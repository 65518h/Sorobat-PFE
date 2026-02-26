Codeunit 8003951 "Overhead Calculation"
{
    // //#6306 Ajout
    // //PROJET_FG GESWAY 25/07/02 Recherche %FG et %Marge
    //             CW     10/02/04 "Job No." remplacé par "Responsibility center"
    //             CW     10/02/04 Copie des lois sur le devis en OnActivate du sous-form : Codeunit.RUN
    //             CW     13/04/04 Application des FG / réalisé (fonction JobLedgerEntry)
    //             CLA    16/06/04 Gestion des lignes 'Ignoré'
    //             CLA    12/11/04 (1884) Permettre marge < 0 sur le document
    // //FRAIS     CLA    17/02/05 Lancement Codeunit pour calcul spécifique
    //                    15/10/05 Prise en compte de "Job Costs (LCY)" dans le calcul de la marge théo
    //                              (sinon marge calculée sur les frais des lignes <> ouvrage du devis)
    // //PERF AC 03/04/06

    TableNo = "Sales Header";

    trigger OnRun()
    var
        lNaviBatSingleInst: Codeunit "NaviBat SingleInstance";
    begin
        lNaviBatSingleInst.SetSalesOverhead(rec."Document Type", rec."No.");
        CopyToSalesDoc(Rec);
    end;

    var
        NavibatSetup: Record NavibatSetup;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        TextCodeNature: label 'You must give the Gen. Prod. Posting Group in %1 %2 Line No. .';
        OldSalesLine: Record "Sales Line";
        SalesOverhead: Record "Sales Overhead-Margin";
        wSalesHeader: Record "Sales Header";


    procedure FetchRule(pRuleType: Integer; var pRule: Record "Overhead-Margin Rule")
    var
        lRule: Record "Overhead-Margin Rule";
    begin
        with pRule do begin
            Reset;
            SetCurrentkey(Type, "Application Order");
            SetRange(Type, pRuleType);
            SetFilter("Gen. Prod. Posting Group", '%1|''''', pRule."Gen. Prod. Posting Group");
            SetFilter("Global Dimension 1 Code", '%1|''''', pRule."Global Dimension 1 Code");
            SetFilter("Global Dimension 2 Code", '%1|''''', pRule."Global Dimension 2 Code");
            SetFilter("Customer Posting Group", '%1|''''', pRule."Customer Posting Group");
            SetFilter("Responsibility Center", '%1|''''', pRule."Responsibility Center");
            if IsEmpty then
                pRule.Init
            else
                FindLast;
        end;
    end;


    procedure SalesLine(var pSalesLine: Record "Sales Line"; pOverhead: Boolean; pMargin: Boolean)
    var
        lJob: Record Job;
        RuleValue: Record "Overhead-Margin Rule";
        lSalesLines: Record "Sales Line";
        lJobCostSpecific: Codeunit "Job Cost Specific Calculation";
        lProfitPerc: Decimal;
        lAmount: Decimal;
        lSingleInstance: Codeunit "Import SingleInstance2";
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        lQuantity: Decimal;
    begin
        NavibatSetup.GET2;

        with pSalesLine do begin
            if (Type = 0) or ("No." = '') or ("Document Type" = "document type"::"Blanket Order") then
                exit;
            lSingleInstance.wGetSalesHeader(wSalesHeader, "Document Type", "Document No.");
            lSingleInstance.wInitCurrency;
            lSingleInstance.wSetCurrency(Currency, wSalesHeader);

            //Gestion du prix si référence externe
            if fSetUnitPriceCrossRef(pSalesLine) then
                exit;

            //Gestion des lignes désactivées
            if fSetDisableLine(pSalesLine) then
                exit;

            //Gestion des exceptions
            if ("Gen. Prod. Posting Group" = '') then begin
                IF ("Line No." <> OldSalesLine."Line No.") AND (Quantity <> 0) THEN
                    Message(TextCodeNature, Type, "No.", "Line No.");
                OldSalesLine := pSalesLine;
                exit;
            end;

            //Calcul du Cout total
            if not fSetSalesTotalCost(pSalesLine, lQuantity) then
                exit;

            //Calcul Frais Generaux
            fSetSalesOverHead(pSalesLine, lQuantity);

            //FRAIS : Calcul spécifique
            lJobCostSpecific.CalcSpecificValue(pSalesLine);

            //Calcul Marge
            fSetSalesMargin(pSalesLine);

            if ("Quantity (Base)" = 0) and ("Optionnal Quantity" = 0) then
                "Total Cost (LCY)" := 0;
            if "Line No." = "Cross-Ref. Line No." then
                lSalesCrossRefMgt.wUpdateField(pSalesLine, pSalesLine."Unit Price", pSalesLine.FieldNo("Unit Price"));

            if (pSalesLine."Line Type" <> pSalesLine."line type"::Structure) and
               (pSalesLine.Quantity = 0) and (pSalesLine."Structure Line No." = 0) then begin
                "Total Cost (LCY)" := 0;
                "Overhead Amount (LCY)" := 0;
                "Theoretical Profit Amount(LCY)" := 0;
                exit;
            end;

        end;
    end;


    procedure Default(var pSalesHeader: Record "Sales Header"; pType: Integer; pGenProdPostGroup: Code[10]; var Return: Record "Sales Overhead-Margin")
    var
        lJob: Record Job;
        lRule: Record "Overhead-Margin Rule";
    begin
        lRule."Responsibility Center" := pSalesHeader."Responsibility Center";

        lRule."Gen. Prod. Posting Group" := pGenProdPostGroup;
        lRule."Global Dimension 1 Code" := pSalesHeader."Shortcut Dimension 1 Code";
        lRule."Global Dimension 2 Code" := pSalesHeader."Shortcut Dimension 2 Code";
        lRule."Customer Posting Group" := pSalesHeader."Customer Posting Group";

        FetchRule(pType, lRule);
        Return."Document Type" := pSalesHeader."Document Type";
        Return."Document No." := pSalesHeader."No.";
        Return."Gen. Prod. Post. Code" := pGenProdPostGroup;
        if pType = 0 then begin
            Return.Overhead := lRule.Value;
            Return."Rule Overhead" := Return.Overhead;
            Return."Calculation Method Overhead" := lRule."Calculation Method";
        end else begin
            Return.Margin := lRule.Value;
            Return."Rule Margin" := Return.Margin;
            Return."Calculation Method Margin" := lRule."Calculation Method";
        end;
    end;


    procedure CalcPrice(var pSalesLine: Record "Sales Line"; pQuantity: Decimal)
    var
        lUnitPrice: Decimal;
        lProfit: Decimal;
    begin
        with pSalesLine do begin
            GET2(SalesOverhead, "Document Type", "Document No.", "Gen. Prod. Posting Group");
            //#8423
            lProfit := SalesOverhead.Margin;
            //#8423
            if "Profit %" <> 0 then
                SalesOverhead.Margin := "Profit %";
            lUnitPrice := "Total Cost (LCY)" + "Overhead Amount (LCY)";
            if SalesOverhead."Calculation Method Margin" = SalesOverhead."calculation method margin"::Quantity then begin
                if Type = Type::Resource then
                    lUnitPrice += pQuantity * SalesOverhead.Margin;
            end else begin
                if SalesOverhead.Margin < 100 then
                    lUnitPrice := lUnitPrice / (1 - SalesOverhead.Margin / 100);

            end;
            lUnitPrice += "Job Costs (LCY)";
            if pQuantity <> 0 then
                lUnitPrice := lUnitPrice / pQuantity;
            //#6749
            //  IF "Qty. per Unit of Measure" <> 0 THEN
            //    lUnitPrice := lUnitPrice / "Qty. per Unit of Measure";
            //#6749//
            if wSalesHeader."Prices Including VAT" and ("VAT %" <> 0) then
                lUnitPrice := (lUnitPrice * (1 + ("VAT %" / 100)));
            "Unit Price" := lUnitPrice;
            //#8423
            SalesOverhead.Margin := lProfit;
            //#8423
        end;
    end;

    local procedure CalcAmountExclVAT(var pAmountExclVAT: Decimal; pSalesLine: Record "Sales Line"; pQuantity: Decimal; pPricesInclVAT: Boolean; pCurrencyFactor: Decimal)
    begin
        with pSalesLine do begin
            //  wGetSalesHeader;
            pAmountExclVAT := ("Unit Price" * pQuantity) - "Line Discount Amount" - "Inv. Discount Amount";
            if pPricesInclVAT and ("VAT %" <> 0) then
                pAmountExclVAT := (("Unit Price" * pQuantity) - "Line Discount Amount" - "Inv. Discount Amount") / (1 + ("VAT %" / 100));
            if Currency.Code <> '' then
                pAmountExclVAT :=
                    //      ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                        pSalesLine.GetDate, Currency.Code,
                        pAmountExclVAT, pCurrencyFactor);//,
                                                         //        Currency."Amount Rounding Precision")
                                                         //  ELSE
                                                         //    pAmountExclVAT := ROUND(pAmountExclVAT,Currency2."Amount Rounding Precision");
        end;
    end;


    procedure CopyToSalesDoc(var pSalesHeader: Record "Sales Header")
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
        lPostingGroup: Record "Gen. Product Posting Group";
    begin
        pSalesHeader.TestField("Customer Posting Group");
        pSalesHeader.TestField("Gen. Bus. Posting Group");

        lSalesOverhead."Document Type" := pSalesHeader."Document Type";
        lSalesOverhead."Document No." := pSalesHeader."No.";

        if lPostingGroup.Find('-') then
            repeat
                lSalesOverhead."Gen. Prod. Post. Code" := lPostingGroup.Code;
                InsertPostingGroup(pSalesHeader, lSalesOverhead, lPostingGroup);
            until lPostingGroup.Next = 0;
    end;


    procedure InsertPostingGroup(pSalesHeader: Record "Sales Header"; var pSalesOverhead: Record "Sales Overhead-Margin"; pPostingGroup: Record "Gen. Product Posting Group")
    begin
        //3493 pSalesOverhead.SETRANGE("Document Type",pSalesHeader."Document Type");
        //3493 pSalesOverhead.SETRANGE("Document No.",pSalesHeader."No.");

        pSalesOverhead."Document Type" := pSalesHeader."Document Type";
        pSalesOverhead."Document No." := pSalesHeader."No.";
        pSalesOverhead."Gen. Prod. Post. Code" := pPostingGroup.Code;

        if pSalesOverhead.Insert then begin
            Default(pSalesHeader, 0, pPostingGroup.Code, pSalesOverhead);
            Default(pSalesHeader, 1, pPostingGroup.Code, pSalesOverhead);
            pSalesOverhead.Modify;
        end;
    end;


    procedure JobLedgerEntry(var pJobLedgerEntry: Record "Job Ledger Entry")
    var
        lRule: Record "Overhead-Margin Rule";
    begin
        with pJobLedgerEntry do begin
            lRule."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            //#6306
            lRule."Global Dimension 1 Code" := pJobLedgerEntry."Global Dimension 1 Code";
            lRule."Global Dimension 2 Code" := pJobLedgerEntry."Global Dimension 2 Code";
            //#6309//
            FetchRule(lRule.Type::Overhead, lRule);
            if lRule."Calculation Method" <> lRule."calculation method"::"Person Quantity" then
                "Overhead Amount" := "Total Cost (LCY)" * lRule.Value / 100
            else
                if (Type = Type::Resource) and ("Work Time Type" = "work time type"::"Producted Hours") then
                    "Overhead Amount" := Quantity * lRule.Value;
        end;
    end;


    procedure GET2(var pSalesOverhead: Record "Sales Overhead-Margin"; pDocType: Option; pDocNo: Code[20]; pGenProdPostGrp: Code[20]): Boolean
    var
        lNaviBatSingleInstance: Codeunit "NaviBat SingleInstance";
    begin
        if (pSalesOverhead."Document Type" = pDocType) and
           (pSalesOverhead."Document No." = pDocNo) and
           (pSalesOverhead."Gen. Prod. Post. Code" = pGenProdPostGrp) then
            exit(true);


        //#4975 EXIT(pSalesOverhead.GET(pDocType,pDocNo,pGenProdPostGrp));
        exit(lNaviBatSingleInstance.GetSalesOverhead(pSalesOverhead, pDocType, pDocNo, pGenProdPostGrp));
    end;


    procedure JobBudgetEntry(var pJobBudgetEntry: Record "Job Planning Line")
    var
        lRule: Record "Overhead-Margin Rule";
        lRess: Record Resource;
    begin
        with pJobBudgetEntry do begin
            lRule."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            FetchRule(lRule.Type::Overhead, lRule);
            if lRule."Calculation Method" <> lRule."calculation method"::"Person Quantity" then
                "Gross Total Cost" := ("Total Cost" * lRule.Value / 100) + "Total Cost"
            else
                if (Type = Type::Resource) and ("Resource Type" = "resource type"::Person) then
                    "Gross Total Cost" := (Quantity * lRule.Value) + "Total Cost";
        end;
    end;


    procedure fSetSalesTotalCost(var pSalesLine: Record "Sales Line"; var pQuantity: Decimal) SortieException: Boolean
    var
        lNumberOfRes: Decimal;
        lStructQty: Decimal;
        lAttachedLine: Record "Sales Line";
    begin
        //Calcul du Cout total

        with pSalesLine do begin
            if ("Line Type" = "line type"::Structure) then
                pQuantity := "Quantity (Base)"
            else begin
                if Option and ("Optionnal Quantity" <> 0) then
                    pQuantity := "Optionnal Quantity"
                else begin
                    pQuantity := Quantity;
                    if (Quantity * "Qty. per Unit of Measure" <> "Quantity (Base)") and
                       ("Qty. per Unit of Measure" <> 0) then
                        pQuantity := "Quantity (Base)" / "Qty. per Unit of Measure";
                end;
            end;

            if pQuantity = 0 then begin
                if pSalesLine."Structure Line No." <> 0 then begin
                    //INITIALISATION DU NOMBRE DE RESOURCES
                    lNumberOfRes := 1;
                    lStructQty := 1;
                    if "Line Type" in ["line type"::Person, "line type"::Machine] then
                        lNumberOfRes := pSalesLine."Number of Resources";

                    //INITIALISATION DE LA QUANTITE DANS LE CAS D'UN SOUS-OUVRAGE
                    if "Attached to Line No." <> 0 then
                        if lAttachedLine.Get("Document Type", "Document No.", "Attached to Line No.") then
                            lStructQty := lAttachedLine."Quantity per" + lAttachedLine."Quantity Fixed";
                    if lStructQty <> 0 then
                        lStructQty := 1;

                    pQuantity := ("Quantity per" + "Quantity Fixed") * lNumberOfRes * lStructQty;
                    if (pQuantity = 0) then begin
                        "Total Cost (LCY)" := 0;
                        "Overhead Amount (LCY)" := 0;
                        "Theoretical Profit Amount(LCY)" := 0;
                        SortieException := false;
                        exit(SortieException);
                    end;
                end else
                    pQuantity := 1;
            end;
            "Total Cost (LCY)" := "Unit Cost (LCY)" * pQuantity;
            SortieException := true;
        end;
    end;


    procedure fSetSalesMargin(var pSalesLine: Record "Sales Line")
    var
        lAmount: Decimal;
        lSingleInstance: Codeunit "Import SingleInstance2";
        lPriceQty: Decimal;
        lFixedUnitPrice: Decimal;
    begin
        //Calcul Marge

        with pSalesLine do begin
            //définition de la quantité pour le calcul du prix unitaire
            if Quantity <> 0 then
                lPriceQty := Quantity
            else
                if "Optionnal Quantity" = 0 then
                    lPriceQty := 1
                else
                    lPriceQty := "Optionnal Quantity";

            if (("Structure Line No." = 0) and
               (NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::Structure) or
                  not ("Line Type" in ["line type"::Structure, "line type"::Totaling])) or
               (("Structure Line No." <> 0) and
                  (NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::"Structure line")) then begin

                //Dans le cas d'affectation de frais
                if "Assignment Basis" <> "assignment basis"::" " then begin
                    "Fixed Price" := false;
                    CalcPrice(pSalesLine, lPriceQty);
                    CalcAmountExclVAT(
                        lAmount, pSalesLine, lPriceQty, wSalesHeader."Prices Including VAT", wSalesHeader."Currency Factor");

                    "Theoretical Profit Amount(LCY)" := (lAmount - ("Total Cost (LCY)" + "Overhead Amount (LCY)" + "Job Costs (LCY)"));
                    "Job Costs Margin Included" := -"Theoretical Profit Amount(LCY)";
                    "Unit Price" := 0;
                    if (Quantity = 0) then begin
                        "Inv. Discount Amount" := 0;
                        "Inv. Disc. Amount to Invoice" := 0;
                        "Line Discount Amount" := 0;
                        "Line Discount %" := 0;
                    end else
                        Validate("Line Discount Amount");
                end else
                    //Dans le cas des prix fixes et trouvés//
                    //#8423
                    //#9181
                    if "Fixed Price" then
                        //      IF "Fixed Price" THEN BEGIN
                        //#9181//
                        lFixedUnitPrice := "Unit Price";
                /*DELETE
                      IF "Fixed Price" OR ("Found Price" <> 0) THEN BEGIN
                        IF ("Found Price" <> 0) AND NOT "Fixed Price" THEN
                          VALIDATE("Unit Price","Found Price");
                        IF ("Unit Price" <> 0) AND (Quantity <> 0) THEN BEGIN
                          IF ("Amount Excl. VAT (LCY)" = 0) THEN
                            CalcAmountExclVAT(
                                "Amount Excl. VAT (LCY)",pSalesLine,lPriceQty,wSalesHeader."Prices Including VAT",wSalesHeader."Currency Factor");
                          "Theoretical Profit Amount(LCY)" :=
                              ("Amount Excl. VAT (LCY)" - ("Total Cost (LCY)" + "Overhead Amount (LCY)" + "Job Costs (LCY)"));
                        END;
                      END ELSE BEGIN
                DELETE*/
                //#8423//
                //Dans le cas des prix à calculer normalement//
                CalcPrice(pSalesLine, lPriceQty);
                lSingleInstance.wGetSalesHeader(wSalesHeader, "Document Type", "Document No.");
                lSingleInstance.wSetCurrency(Currency, wSalesHeader);

                if wSalesHeader."Currency Code" <> '' then begin
                    "Unit Price" :=
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          GetDate, wSalesHeader."Currency Code",
                          "Unit Price", wSalesHeader."Currency Factor");
                end;
                if "Unit Price" <> 0 then
                    CalcAmountExclVAT(
                        "Amount Excl. VAT (LCY)", pSalesLine, lPriceQty, wSalesHeader."Prices Including VAT", wSalesHeader."Currency Factor");
                //#8863
                //        IF (SalesOverhead.Margin = 0) THEN
                if (SalesOverhead.Margin = 0) and ("Profit %" = 0) then
                    //#8863//
                    "Theoretical Profit Amount(LCY)" := 0
                else
                    "Theoretical Profit Amount(LCY)" := "Amount Excl. VAT (LCY)" -
                                                        ("Total Cost (LCY)" + "Overhead Amount (LCY)" + "Job Costs (LCY)")
                                                       + "Line Discount Amount" + "Inv. Discount Amount";
                //traitement du prix fixe
                if "Fixed Price" or ("Found Price" <> 0) then begin
                    if not "Fixed Price" then
                        Validate("Unit Price", "Found Price")
                    else
                        Validate("Unit Price", lFixedUnitPrice);
                end;
                //traitement du prix fixe

                //Calcul du prix unitaire
                fSetUnitPrice(pSalesLine);
                //Calcul du prix unitaire//
                //DELETE      END;
                //#9181
                //    END;
                //#9181//
            end;
        end;

    end;


    procedure fSetSalesOverHead(var pSalesLine: Record "Sales Line"; pQuantity: Decimal)
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
        lPostingGroup: Record "Gen. Product Posting Group";
    begin
        //Calcul Frais Generaux
        with pSalesLine do begin
            if ("Line Type" in ["line type"::Item,
                                "line type"::Person,
                                "line type"::Machine,
                                "line type"::"G/L Account"]) and (Type <> Type::" ") then begin
                if not GET2(lSalesOverhead, "Document Type", "Document No.", "Gen. Prod. Posting Group") then begin
                    lSalesOverhead.Init;
                    lPostingGroup.Get(pSalesLine."Gen. Prod. Posting Group");
                    InsertPostingGroup(wSalesHeader, lSalesOverhead, lPostingGroup);
                end;
                if lSalesOverhead."Calculation Method Overhead" = lSalesOverhead."calculation method overhead"::Quantity then begin
                    //#6421      IF Type = Type::Resource THEN BEGIN
                    if "Line Type" = "line type"::Person then begin
                        if "Quantity (Base)" <> 0 then
                            "Overhead Amount (LCY)" := lSalesOverhead.Overhead * "Quantity (Base)"
                        else
                            "Overhead Amount (LCY)" := lSalesOverhead.Overhead * pQuantity
                        //#6421//
                    end else
                        "Overhead Amount (LCY)" := 0;
                end else
                    "Overhead Amount (LCY)" := "Total Cost (LCY)" * lSalesOverhead.Overhead / 100;
            end;
        end;
    end;


    procedure fSetUnitPrice(var pSalesLine: Record "Sales Line")
    begin
        //calcul du prix unitaire

        with pSalesLine do begin
            if "Structure Line No." = 0 then begin
                if "Unit-Amount Rounding Precision" <> 0 then
                    "Unit Price" := ROUND("Unit Price", "Unit-Amount Rounding Precision")
                else
                    "Unit Price" := ROUND("Unit Price", Currency."Sales Unit-Amt Round. Prec.");

                SuspendStatusCheck(true);

                if (Quantity <> 0) then
                    //Mise à jour de la remise
                    if "Line Discount Amount" <> 0 then
                        Validate("Line Discount Amount")
                    else
                        Validate("Line Discount %");

                //Mise à jour de la remise//
                InitOutstandingAmount;
            end;
        end;
    end;


    procedure fSetUnitPriceCrossRef(var pSalesLine: Record "Sales Line") return: Boolean
    var
        lSalesLines: Record "Sales Line";
    begin
        //calcul du prix unitaire : gestion de la référence externe (groupé/dégroupé)

        with pSalesLine do begin
            if ("Line No." <> "Cross-Ref. Line No.") and ("Cross-Ref. Line No." <> 0) then begin
                if lSalesLines.Get("Document Type", "Document No.", "Cross-Ref. Line No.") then
                    "Unit Price" := lSalesLines."Unit Price";
                if (Quantity <> 0) then
                    Validate("Line Discount Amount");
                InitOutstandingAmount;
                return := true;
            end;
            return := false;
        end;
    end;


    procedure fSetDisableLine(var pSalesLine: Record "Sales Line") return: Boolean
    var
        lSalesLines: Record "Sales Line";
    begin
        //gestion des lignes désactivés

        with pSalesLine do begin
            if Disable then begin
                "Overhead Amount (LCY)" := 0;
                "Theoretical Profit Amount(LCY)" := 0;
                //PREPAYMENT
                if not "Fixed Price" and ("Found Price" = 0) and not ("Line Type" = "line type"::Other) then
                    //PREPAYMENT//
                    Validate("Unit Price", 0);
                return := true;
            end else
                return := false;
        end;
    end;
}

