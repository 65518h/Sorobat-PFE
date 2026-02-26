Codeunit 8004062 "Sales Cross-Ref Management"
{
    // //NAVIONE AC 22/01/07 Urbanisation du code relatif à la gestion du champ "Cross-Reference No."
    //                       reprise des fonctions:
    //                       -> wGroup
    //                            Fonction permettant de regrouper toutes les lignes de même référence externe sur une seule.
    //                       -> wUnGroup
    //                            Fonction permettant de dégrouper une ligne sur n lignes de même référence externe
    //                       ->wDeleteCrossRef
    //                            Fonction gérant la suppression d'une ligne qui reprend une référence externe
    //                       ->wUpdateCrossRefStructure
    //                            Fonction permettant la mise à jour du sous-détail de toutes les lignes d'un doc de même référence externe
    //                       ->wUpdateSalesDocCost
    //                            Fonction permettant la mise à jour du coût enregistré dans la table "Sales document Cost"
    //                       ->wValidateCrossRefStructure
    //                            Fonction executée lors de la validation du champ "Cross-Reference No."
    //                             1 - Elle rapatrie le N° d'ouvrage correspondant à la référence à partir du catalogue des prix
    //                             2 - Elle corrige le sous-détail avec l'ouvrage existant portant la même référence (unicité de cout)
    //                             3 - Elle reprend le prix enregistré dans la table "Sales document Cost" (unicité de prix)


    trigger OnRun()
    begin
    end;

    var
        wStructureMgt: Codeunit "Structure Management";
        Text8003900: label 'You must ungroup the cross-Réf. before to delete this line.';


    procedure wDeleteCrossRef(var Rec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesDocCost: Record "Sales Document Cost";
    begin
        with Rec do begin

            //#6428
            wUpdateAttachedLine(Rec, 1);
            //#6428//

            if ("Item Reference No." = '') then
                exit;

            if "Cross-Ref. Line No." <> 0 then begin
                if ("Line No." = "Cross-Ref. Line No.") and (Dummy <> '@@') then   //Supp à partir de l'en-tête
                    Error(Text8003900);
                //#6814
                if "Cross-Ref. Line No." = "Line No." then begin
                    "Quantity (Base)" -= Quantity;
                    Modify;
                end else
                    //#6814//
                    if lSalesLine.Get("Document Type", "Document No.", "Cross-Ref. Line No.") then begin
                        lSalesLine."Quantity (Base)" -= Quantity;
                        lSalesLine.Modify;
                    end;

            end;

            lSetFilterCrossRefLine(lSalesLine, Rec);
            if lSalesLine.IsEmpty then
                if lSalesDocCost.Get("Document Type", "Document No.", lSalesDocCost.Type::"Cross-Reference",
                                      "Item Reference No.", 0, "Purchasing Code") then
                    lSalesDocCost.Delete;
        end;
    end;


    procedure wUpdateCrossRefStructure(var Rec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lToSalesLineComp: Record "Sales Line";
        lFromSalesLineComp: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
    //GL2024 NAVIBAT   lInsertStructLine: Report 8004070;
    begin
        with Rec do begin
            //#5982
            if ("Item Reference No." = '') then
                exit;
            //#5982
            lSetFilterCrossRefLine(lSalesLine, Rec);
            if not lSalesLine.IsEmpty then begin
                lSalesLine.Find('-');
                repeat
                    if lSalesLine."Cross-Ref. Line No." = 0 then begin
                        lSalesLine."Item Reference No." := "Item Reference No.";
                        lSalesLine."Fixed Price" := "Fixed Price";
                        lSalesLine.Description := Description;
                        lSalesLine."Description 2" := "Description 2";
                        lSalesLine.Modify;

                        //Texte attaché
                        wDuplicateExtendedText(lSalesLine, Rec);
                        //métré
                        //GL2024 NAVIBAT   lInsertStructLine.wCopyBOQ(Rec, lSalesLine);

                        //#6299
                        lStructureMgt.wInitInstance(lSalesLine);
                        //#6299//
                        lStructureMgt.DeleteStructure(lSalesLine);
                        lStructureMgt.wInsertStructure(Rec, lSalesLine, 0, 0, lSalesLine."Job No.");

                    end;
                until lSalesLine.Next = 0;
            end;
        end;
    end;


    procedure wUpdateSalesDocCost(Rec: Record "Sales Line")
    var
        lSalesDocCost: Record "Sales Document Cost";
    begin
        with Rec do begin
            lSalesDocCost."Document Type" := "Document Type";
            lSalesDocCost."Document No." := "Document No.";
            lSalesDocCost.Type := lSalesDocCost.Type::"Cross-Reference";
            lSalesDocCost."No." := "Item Reference No.";
            lSalesDocCost.Value := "Unit Price";
            lSalesDocCost.Rate := Rate;
            if not lSalesDocCost.Insert then
                lSalesDocCost.Modify;
        end;
    end;


    procedure wValidateCrossRefStructure(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        lSalesDocCost: Record "Sales Document Cost";
        lResPrice: Record "Resource Price";
        lSalesLine: Record "Sales Line";
        lFromSalesLineTmp: Record "Sales Line" temporary;
        lToSalesLineComp: Record "Sales Line";
        lxRec: Record "Sales Line";
        lNavibatSetup: Record NavibatSetup;
        lSalesHeader: Record "Sales Header";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lStructureMgt: Codeunit "Structure Management";
        lSubcontractingMgt: Codeunit "Subcontracting Management";
        lOverheadCalc: Codeunit "Overhead Calculation";
        lSalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        lCrossRef: Code[20];
    //GL2024 NAVIBAT   lInsertStructLine: Report 8004070;
    begin
        with Rec do begin
            if ("Item Reference No." = '') or (Type = 0) then
                exit;
            if "Cross-Ref. Line No." <> 0 then
                Error(Text8003900);

            //Recherche N° à partir Ref. externe
            if ("Line Type" <> "line type"::Structure) then
                exit;

            lxRec := Rec;
            //Recherche dans le document
            lSetFilterCrossRefLine(lSalesLine, Rec);
            if not lSalesLine.IsEmpty then begin
                lSalesLine.FindFirst;
                if ("No." = '') then begin
                    Validate("No.", lSalesLine."No.");
                    Validate(Rate, lSalesLine.Rate);
                end;
                //#6428----------
                Validate("Line Discount %", lSalesLine."Line Discount %");
                //#6428----------//
                "Item Reference No." := lxRec."Item Reference No.";
                "Fixed Price" := lSalesLine."Fixed Price";
                Description := lSalesLine.Description;
                "Description 2" := lSalesLine."Description 2";
                //#6300----------
                Validate("Unit of Measure Code", lSalesLine."Unit of Measure Code");
                Validate(Subcontracting, lSalesLine.Subcontracting);
                //#6300----------//
                //#6068
                if not Modify then
                    Insert(true);
                //#6068//

                //métré
                //GL2024 NAVIBAT    lInsertStructLine.wCopyBOQ(Rec, lSalesLine);
                //Sous détail
                lStructureMgt.DeleteStructure(Rec);
                lFromSalesLineTmp := lSalesLine;
                lStructureMgt.wInitInstance(Rec);
                lStructureMgt.wInsertStructure(lFromSalesLineTmp, Rec, 0, 0, lSalesHeader."Job No.");
                //Texte attaché
                //#6300----------
                //inversion paramètres
                wDuplicateExtendedText(Rec, lSalesLine);
                //#6300----------
            end else
                if ("No." = '') then begin
                    lSingleInstance.wGetSalesHeader(lSalesHeader, "Document Type", "Document No.");

                    lResPrice.SetCurrentkey("Customer No.", "Cross-Reference No.");
                    lResPrice.SetFilter("Customer No.", '%1|%2', lSalesHeader."Sell-to Customer No.", '');
                    lResPrice.SetRange("Cross-Reference No.", "Item Reference No.");
                    //GL2024  lResPrice.SetFilter("Job No.", '%1|%2', lSalesHeader."Job No.", '');
                    lResPrice.SetRange(Type, lResPrice.Type::Resource);
                    if not lResPrice.IsEmpty then begin
                        lResPrice.FindLast;
                        "Sell-to Customer No." := lSalesHeader."Sell-to Customer No.";
                        Validate("No.", lResPrice.Code);
                        "Item Reference No." := lxRec."Item Reference No.";
                        Modify;
                        lStructureMgt.ExplodeStructure(Rec);
                        "Fixed Price" := false;
                    end;
                end;

            if ("No." = '') then
                exit;

            //SUBCONTRACTING
            lSubcontractingMgt.UpdateSubcontractor(Rec);
            //SUBCONTRACTING//
            wUpdateLine(Rec, lxRec, false);
            lSingleInstance.wGetNaviBatSetup(lNavibatSetup);
            if ("Structure Line No." = 0) and
               (lNavibatSetup."Profit Calculation Method" = lNavibatSetup."profit calculation method"::Structure) then begin
                xRec."Unit Price" := "Unit Price";
                lSalesPriceCalcMgt.FindSalesLineLineDisc(lSalesHeader, Rec);
                lSalesPriceCalcMgt.FindSalesLinePrice(lSalesHeader, Rec, FieldNo("Item Reference No."));
            end;

            lSalesDocCost.SetRange("Document Type", "Document Type");
            lSalesDocCost.SetRange("Document No.", "Document No.");
            lSalesDocCost.SetRange(Type, lSalesDocCost.Type::"Cross-Reference");
            lSalesDocCost.SetRange("No.", "Item Reference No.");
            if lSalesDocCost.FindFirst then begin
                Validate("Unit Price", lSalesDocCost.Value);
                Validate(Rate, lSalesDocCost.Rate);
                lStructureMgt.wSetProfit(Rec, lSalesLine."Profit %", true);
            end;

            lOverheadCalc.SalesLine(Rec, false, true);
        end;
    end;

    local procedure wDuplicateExtendedText(pToSalesLine: Record "Sales Line"; pFromSalesLine: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lFromExtText: Record "Sales Line";
        lEcart: Integer;
        lNbExtText: Integer;
    begin
        lFromExtText.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lFromExtText.SetRange("Document Type", pFromSalesLine."Document Type");
        lFromExtText.SetRange("Document No.", pFromSalesLine."Document No.");
        lFromExtText.SetRange("Structure Line No.", 0);
        lFromExtText.SetRange("Attached to Line No.", pFromSalesLine."Line No.");
        lFromExtText.SetRange("Line Type", pFromSalesLine."line type"::" ");
        if lFromExtText.IsEmpty then
            exit;

        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lSalesLine.SetRange("Document Type", pToSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", pToSalesLine."Document No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        //#6813
        //lSalesLine.SETFILTER("Line Type",'<>%1',pToSalesLine."Line Type"::" ");
        //#6813//

        if not lSalesLine.Get(pToSalesLine."Document Type", pToSalesLine."Document No.", pToSalesLine."Line No.") then
            exit;

        //#6813
        //IF NOT lSalesLine.FIND('>') THEN
        if (not lSalesLine.Find('>')) or (lSalesLine."Line No." < pToSalesLine."Line No.") then
            //#6813
            lEcart := 10000
        else
            lEcart := (lSalesLine."Line No." - pToSalesLine."Line No.") DIV (lFromExtText.Count + 1);

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lSalesLine.SetRange("Document Type", pToSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", pToSalesLine."Document No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetRange("Attached to Line No.", pToSalesLine."Line No.");
        lSalesLine.SetRange("Line Type", pToSalesLine."line type"::" ");
        if not lSalesLine.IsEmpty then
            lSalesLine.DeleteAll;
        lSalesLine.Reset;

        lFromExtText.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lFromExtText.FindSet;
        repeat
            lSalesLine.TransferFields(lFromExtText);
            lSalesLine."Document Type" := pToSalesLine."Document Type";
            lSalesLine."Document No." := pToSalesLine."Document No.";
            lSalesLine."Line No." := pToSalesLine."Line No." + lEcart;
            lSalesLine."Presentation Code" := pToSalesLine."Presentation Code";
            lSalesLine."Attached to Line No." := pToSalesLine."Line No.";
            lSalesLine.Level := pToSalesLine.Level;
            while not lSalesLine.Insert do
                lSalesLine."Line No." += 10;
        until lFromExtText.Next = 0;
    end;


    procedure wUpdateAttachedLine(rec: Record "Sales Line"; pOption: Option Modification,Delete)
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lFromExtText: Record "Sales Line";
        lSalesLineAttached: Record "Sales Line";
        lEcart: Integer;
        lNbExtText: Integer;
    begin
        //#6428
        if not lSalesLineAttached.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.") then
            exit;
        if (rec."Structure Line No." <> 0) or (lSalesLineAttached."Item Reference No." = '') or
           (lSalesLineAttached.Type = lSalesLineAttached.Type::" ") or (lSalesLine."Structure Line No." <> 0) then
            exit;
        //#6428//

        lSetFilterCrossRefLine(lSalesLine, lSalesLineAttached);
        if not lSalesLine.IsEmpty then begin
            lSalesLine.Find('-');
            repeat
                lFromExtText.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                lFromExtText.SetRange("Document Type", lSalesLineAttached."Document Type");
                lFromExtText.SetRange("Document No.", lSalesLineAttached."Document No.");
                lFromExtText.SetRange("Structure Line No.", 0);
                lFromExtText.SetRange("Attached to Line No.", lSalesLineAttached."Line No.");
                lFromExtText.SetRange("Line Type", lSalesLineAttached."line type"::" ");
                if lFromExtText.IsEmpty then
                    exit;

                lSalesLine2.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                lSalesLine2.SetRange("Document Type", lSalesLine."Document Type");
                lSalesLine2.SetRange("Document No.", lSalesLine."Document No.");
                lSalesLine2.SetRange("Structure Line No.", 0);
                if not lSalesLine2.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.") then
                    exit;

                if (not lSalesLine2.Find('>')) or (lSalesLine2."Line No." < lSalesLine."Line No.") then
                    lEcart := 10000
                else
                    lEcart := (lSalesLine2."Line No." - lSalesLine."Line No.") DIV (lFromExtText.Count + 1);

                lSalesLine2.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                lSalesLine2.SetRange("Document Type", lSalesLine."Document Type");
                lSalesLine2.SetRange("Document No.", lSalesLine."Document No.");
                lSalesLine2.SetRange("Structure Line No.", 0);
                lSalesLine2.SetRange("Attached to Line No.", lSalesLine."Line No.");
                lSalesLine2.SetRange("Line Type", lSalesLine."line type"::" ");
                if not lSalesLine2.IsEmpty then
                    lSalesLine2.DeleteAll;
                lSalesLine2.Reset;

                lFromExtText.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                lFromExtText.FindSet(true, true);
                repeat
                    //#6428
                    if (pOption = Poption::Modification) or
                      ((pOption = Poption::Delete) and (lFromExtText."Line No." <> rec."Line No.")) then begin
                        //#6428//
                        lSalesLine2.TransferFields(lFromExtText);
                        lSalesLine2."Document Type" := lSalesLine."Document Type";
                        lSalesLine2."Document No." := lSalesLine."Document No.";
                        lSalesLine2."Line No." := lSalesLine."Line No." + lEcart;
                        lSalesLine2."Presentation Code" := lSalesLine."Presentation Code";
                        lSalesLine2."Attached to Line No." := lSalesLine."Line No.";
                        lSalesLine2.Level := lSalesLine.Level;

                        //-Récupère designation ligne en cours
                        if lFromExtText."Line No." = rec."Line No." then
                            lSalesLine2.Description := rec.Description;
                        //---//

                        while not lSalesLine2.Insert do
                            lSalesLine2."Line No." += 10;
                    end;
                until lFromExtText.Next = 0;

            until lSalesLine.Next = 0;
        end;
    end;


    procedure lHeaderUpdField(var pRec: Record "Sales Line"; var pFieldNo: Integer) return: Boolean
    var
        lSalesDocCost: Record "Sales Document Cost";
    begin
        return := false;
        with pRec do
            case pFieldNo of
                FieldNo(Description), FieldNo("Description 2"):
                    begin
                        pFieldNo := FieldNo(Description);
                        if ("Attached to Line No." <> 0) and (Type = Type::" ") then begin
                            wUpdateAttachedLine(pRec, 0);
                            return := true;
                        end;
                    end;
                FieldNo("Fixed Price"):
                    begin
                        if not "Fixed Price" then
                            if lSalesDocCost.Get("Document Type", "Document No.", lSalesDocCost.Type::"Cross-Reference", "Item Reference No.") then
                                lSalesDocCost.Delete(true);
                    end;
            end;
    end;

    local procedure lBeforeUpdField(var pRecRef: RecordRef; pFieldNo: Integer; pCrossRefRec: Record "Sales Line") rValidate: Boolean
    var
        lSalesLine: Record "Sales Line";
        lFieldRef: FieldRef;
        lRecRef: RecordRef;
    begin
        rValidate := true;
        pRecRef.SetTable(lSalesLine);
        with lSalesLine do
            case pFieldNo of
                FieldNo("Unit Price"), FieldNo("Line Amount"):
                    begin
                        if "Profit %" <> lSalesLine."Profit %" then
                            wStructureMgt.wSetProfit(lSalesLine, pCrossRefRec."Profit %", true);
                        lSalesLine.Validate("Fixed Price", pCrossRefRec."Fixed Price");
                    end;
                FieldNo("Fixed Price"):
                    begin
                        if not "Fixed Price" then
                            rValidate := false;
                    end;
            end;
        pRecRef.GetTable(lSalesLine);
    end;


    procedure wUpdateField(pRec: Record "Sales Line"; pValue: Variant; pFieldNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lFieldRef: FieldRef;
        lRecRef: RecordRef;
    begin
        //#6428
        with pRec do begin
            //Début de traitement sur enreg. en cours
            if lHeaderUpdField(pRec, pFieldNo) then
                exit;

            if ("Item Reference No." = '') or ("Structure Line No." <> 0) or (pFieldNo = 0) then
                exit;

            lSetFilterCrossRefLine(lSalesLine, pRec);
            if not lSalesLine.IsEmpty then begin
                lSalesLine.Find('-');
                repeat
                    lRecRef.GetTable(lSalesLine);
                    //Traitement post-validation
                    if lBeforeUpdField(lRecRef, pFieldNo, pRec) then begin
                        lFieldRef := lRecRef.Field(pFieldNo);
                        lFieldRef.Validate(pValue);
                    end else begin
                        lFieldRef := lRecRef.Field(pFieldNo);
                        lFieldRef.Value := pValue;
                    end;
                    //Traitement pré-validation
                    lAfterUpdField(lRecRef, pFieldNo, pRec);
                    lRecRef.Modify;
                    //      lRecRef.SETTABLE(lSalesLine);
                    //Traitement pré-modify
                    lAfterModifyUpdField(lRecRef, pFieldNo, pRec);
                until lSalesLine.Next = 0;
            end;
            //Fin de traitement sur enreg. en cours
            lFooterUpdField(pRec, pFieldNo);
        end;
    end;

    local procedure lAfterUpdField(var pRecRef: RecordRef; pFieldNo: Integer; pCrossRefRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lFieldRef: FieldRef;
        lRecRef: RecordRef;
    begin
        pRecRef.SetTable(lSalesLine);
        with lSalesLine do
            case pFieldNo of
                FieldNo("Unit Price"), FieldNo("Line Amount"):
                    begin
                        lSalesLine."Total Cost (LCY)" := lSalesLine."Unit Cost (LCY)" * lSalesLine."Quantity (Base)";
                    end;
                FieldNo(Description), FieldNo("Description 2"):
                    begin
                        lSalesLine."Description 2" := pCrossRefRec."Description 2";
                    end;
                FieldNo("Fixed Price"):
                    begin
                        if not "Fixed Price" then begin
                            lSalesLine.Validate("Unit Price", pCrossRefRec."Unit Price");
                            lSalesLine."Total Cost (LCY)" := lSalesLine."Unit Cost (LCY)" * lSalesLine."Quantity (Base)";
                        end;
                    end;
            end;
        pRecRef.GetTable(lSalesLine);
    end;

    local procedure lAfterModifyUpdField(var pRecRef: RecordRef; pFieldNo: Integer; pCrossRefRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lFieldRef: FieldRef;
        lRecRef: RecordRef;
    begin
        pRecRef.SetTable(lSalesLine);
        with lSalesLine do
            case pFieldNo of
                FieldNo(Description), FieldNo("Description 2"):
                    begin
                        wDuplicateExtendedText(lSalesLine, pCrossRefRec);
                    end;
            end;
        pRecRef.GetTable(lSalesLine);
    end;


    procedure lFooterUpdField(var pRec: Record "Sales Line"; pFieldNo: Integer)
    begin
        with pRec do
            case pFieldNo of
                FieldNo("Unit Price"), FieldNo("Line Amount"), FieldNo(Description), FieldNo("Description 2"):
                    begin
                        wUpdateSalesDocCost(pRec);
                    end;
            end;
    end;


    procedure lSetFilterCrossRefLine(var pRec: Record "Sales Line"; pCrossRefRec: Record "Sales Line")
    begin
        with pCrossRefRec do begin
            pRec.Reset;
            pRec.SetCurrentkey("Document Type", "Document No.", "Line Type", "Item Reference No.");
            pRec.SetRange("Document Type", "Document Type");
            pRec.SetRange("Document No.", "Document No.");
            pRec.SetRange("Line Type", "Line Type");
            pRec.SetRange("Item Reference No.", "Item Reference No.");
            pRec.SetRange("Structure Line No.", 0);
            pRec.SetFilter("Line No.", '<>%1', "Line No.");
        end;
    end;
}

