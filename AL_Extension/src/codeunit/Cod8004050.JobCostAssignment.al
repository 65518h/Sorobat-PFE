Codeunit 8004050 "Job Cost Assignment"
{
    // //DEVIS GESWAY 17/07/03 Répartition des frais directs
    // //PIED_DEVIS MB 04/01/07 Ajout de la fonction CalcMarketCharge

    TableNo = "Sales Line";

    trigger OnRun()
    begin
        Salesline2.Copy(Rec);
        if Salesline2."Order Type" <> Salesline2."order type"::" " then
            exit;

        if SalesHeader.Status <> SalesHeader.Status::Open then
            exit;
        wSingleInstance.wInitCurrency();
        wSingleInstance.wSetCurrency(Currency, SalesHeader);
        wUnitRoundPrec := Currency."Sales Unit-Amt Round. Prec.";
        if rec."Unit-Amount Rounding Precision" <> 0 then
            wUnitRoundPrec := rec."Unit-Amount Rounding Precision";

        wProgress.Open(tTitreProgress + tTypeProgress + tCalcProgress);
        wNavibatSetup.GET;
        InitTempTable;
        Code;
        TransferTempTable;
        wProgress.Close;
        Rec := Salesline2;
        Commit;
    end;

    var
        SalesLine: Record "Sales Line";
        Salesline2: Record "Sales Line";
        SalesLineTmp: Record "Sales Line" temporary;
        SalesLineTmp2: Record "Sales Line" temporary;
        SalesLineTmp3: Record "Sales Line" temporary;
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        JobCostAssgnt: Record "Job Cost Assignment";
        CurrExchRate: Record "Currency Exchange Rate";
        StructureMgt: Codeunit "Structure Management";
        OverheadCalculation: Codeunit "Overhead Calculation";
        JobCostSpecific: Codeunit "Job Cost Specific Calculation";
        wSingleInstance: Codeunit "Import SingleInstance2";
        TotalJobCost: Decimal;
        TotalMarginJobCost: Decimal;
        TotalBasis: Decimal;
        TotalAssigned: Decimal;
        TotalMarginAssigned: Decimal;
        TotalBase: Decimal;
        ErrorRep: label 'The assignment of the line %1 %2 cannot be done.';
        LineNumber: Integer;
        tErrorTotalRate: label 'Sum of rate on the result must be lower than 100 ';
        tTitreProgress: label 'Documents Updating\';
        tTypeProgress: label 'Update                 #1##############\';
        tCalcProgress: label 'Work in progress...    @2@@@@@@@@@@@@@@\';
        tDocInfo: label '%1 No. %2';
        TotalDocInit: Decimal;
        TotalDocEnd: Decimal;
        TotalDocDiscount: Decimal;
        wRecalculAmount: Boolean;
        wProgress: Dialog;
        tDownload: label 'Download...';
        tUpdate: label 'Update...';
        tInitPrice: label 'Price Initialization';
        tCalcVentilation: label 'Job Cost Calculation';
        tTypeRepartition: label 'Type of Assignment : %1';
        wNavibatSetup: Record NavibatSetup;
        wUnitRoundPrec: Decimal;


    procedure "Code"()
    var
        lSalesLine: Record "Sales Line";
        lTextBasisNul: label 'There is no assignment basis for line no. %1 : %2 .';
        lTextNoMethod: label 'There is no assignment method for line no. %1 : %2 .';
        lSalesLineMgt: Codeunit "SalesLine Management";
        lLineQtyOne: Integer;
        lCurrMinQty: Decimal;
        lBrutAmount: Decimal;
        lTextJobCostNul: label 'There is nothing to assign.';
        lDiff: Decimal;
        OldJobCost: Decimal;
        NewDelta: Decimal;
        lJobCostFixedPrice: Decimal;
        lMax: Integer;
        i: Integer;
        lGlobalDisc: Decimal;
        lSalesLineTmp: Record "Sales Line" temporary;
    begin
        //#4367
        if wSingleInstance.wGetSalesOverheadIsCalculated then
            exit;
        //#4367//

        with SalesLineTmp do begin
            SuspendStatusCheck(true);
            SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            SetRange("Document Type", Salesline2."Document Type");
            SetRange("Document No.", Salesline2."Document No.");
            SetRange("Structure Line No.", 0);
            SetFilter(Type, '<>0');
            SetFilter(Quantity, '<>0');
            SetRange(Option, false);
            SetFilter("Assignment Basis", '<>0');
            wRecalculAmount := true;
            if not IsEmpty then begin
                wRecalculAmount := false;
                SetRange("Assignment Method", 0);
                if FindFirst then
                    Error(lTextNoMethod, "Line No.", "No.", Description);
                SetRange("Assignment Basis");
                SetRange("Assignment Method");
            end;

            SetRange(Quantity);
            SetRange("Assignment Method");
            SetRange("Assignment Basis");
            SetRange("Job Costs (LCY)");
            SetRange(Type);
            ClearJobCost;
            SetRange(Option, false);
            //PIED_DEVIS
            //#5162  IF "Document Type" = "Document Type"::Quote THEN
            if CalcMarketCharge(SalesHeader) then
                Commit;
            //PIED_DEVIS
            SetRange("Line Type");
            SetRange("Value Option");

            SetFilter(Type, '<>0');

            //Totaliser frais
            SetFilter(Quantity, '<>0');
            SetRange(Option, false);
            SetFilter("Assignment Method", '<>%1', "assignment method"::" ");
            if IsEmpty then
                exit;

            //#5279
            lSalesLineTmp.DeleteAll;
            if FindSet(true, false) then
                repeat
                    AppendJobCost(lSalesLineTmp);
                until Next = 0;
            //#5279//

            if lSalesLineTmp.FindSet(true, false) then
                repeat
                    wProgress.Update(1, StrSubstNo(tTypeRepartition, "Assignment Method"));
                    i := 0;
                    Clear(TotalAssigned);
                    Clear(TotalMarginAssigned);
                    TotalBasis := CalcBasis(lSalesLineTmp);
                    if (TotalBasis = 0) and (LineNumber <> 1) then
                        Error(lTextBasisNul, "Line No.", "No.", lSalesLineTmp.Description);
                    TotalJobCost := CalcJobCost(lSalesLineTmp);
                    if SalesLineTmp."Line Type" = SalesLineTmp."line type"::Other then
                        TotalMarginJobCost := TotalJobCost
                    else
                        TotalMarginJobCost := lSalesLineTmp."Theoretical Profit Amount(LCY)";
                    if TotalJobCost = 0 then
                        Error(lTextJobCostNul);
                    CalcAssignment(lSalesLineTmp);
                until lSalesLineTmp.Next = 0;

            SetRange("Assignment Method", "assignment method"::" ");

            if Find('-') then begin
                lMax := COUNTAPPROX;
                wProgress.Update(1, tCalcVentilation);
                i := 0;
                //#5923
                StructureMgt.wInitInstance(SalesLineTmp);
                //#5923//
                repeat
                    i += 1;
                    //#5142
                    if SalesLineTmp."Line Discount %" = 0 then
                        lGlobalDisc := SalesLineTmp."Line Discount Amount";
                    //#5142//
                    wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                    //#5124
                    if ("Assignment Method" <> "assignment method"::" ") or ("Line Type" <> "line type"::Other) then
                        //#5124//
                        if SalesLineTmp2.Get("Document Type", "Document No.", "Line No.") then
                            SalesLineTmp := SalesLineTmp2;
                    if ("Found Price" <> 0) or "Fixed Price" then
                        lJobCostFixedPrice += "Job Costs (LCY)";
                    if ("Line Type" = "line type"::Structure) and
                       ("Found Price" = 0) and not "Fixed Price" then begin
                        StructureMgt.UpdateSumStructPrice(SalesLineTmp);
                        if ((lCurrMinQty = 0) or ((Quantity < lCurrMinQty) and (Quantity > 0)))
                           and ("Job Costs (LCY)" <> 0) then begin
                            lCurrMinQty := SalesLineTmp.Quantity;
                            lLineQtyOne := SalesLineTmp."Line No.";
                        end;
                    end else
                        //#7326
                        if ("Line Type" <> "line type"::Other) then
                            //#7326//
                            OverheadCalculation.SalesLine(SalesLineTmp, false, true);

                    //#4683
                    //      TotalDocEnd += SalesLine."Line Amount";
                    TotalDocEnd += ROUND(Quantity * "Unit Price", Currency."Amount Rounding Precision", '=');
                    //#4683//
                    //#5142
                    if (SalesLineTmp."Line Discount %" = 0) and (lGlobalDisc <> 0) then begin
                        SalesLineTmp.Validate("Line Discount Amount", lGlobalDisc);
                        SalesLineTmp."Line Discount %" := 0;
                    end;
                    //#5142//
                    Modify;
                until Next = 0;
            end;

            //#7433
            /*
              SETRANGE("Assignment Method",0);
              SETFILTER("Assignment Method",'<>%1',"Assignment Method"::" ");
              IF FIND('-') THEN BEGIN
                REPEAT
                  IF (SalesLineTmp."Line Type" <> SalesLineTmp."Line Type"::Other) AND
                     (SalesLineTmp.Quantity <> 0) THEN BEGIN
                    StructureMgt.UpdateSumStructPrice(SalesLineTmp);
                    MODIFY;
                  END;
                UNTIL NEXT = 0;
              END;
            */
            //#7433//

            //Gestion arrondi
            wNavibatSetup.GET;
            if (TotalDocInit - TotalDocEnd <> 0) and (lLineQtyOne <> 0) and not wNavibatSetup."Ignore Job Cost Around" then begin
                //      SalesLine.GET("Document Type","Document No.",lLineQtyOne);
                Get("Document Type", "Document No.", lLineQtyOne);
                //#4683
                OldJobCost := "Line Amount" + "Line Discount Amount";
                //#4683//
                "Job Costs (LCY)" += (TotalDocInit - TotalDocEnd - lJobCostFixedPrice);
                //#5142
                if "Line Discount %" = 0 then
                    lGlobalDisc := "Line Discount Amount";
                //#5142//
                OverheadCalculation.SalesLine(SalesLineTmp, false, true);
                if "Line Type" = "line type"::Structure then
                    StructureMgt.SumStructureLines(SalesLineTmp);
                //#4683
                NewDelta := (TotalDocInit - TotalDocEnd - lJobCostFixedPrice) - ("Line Amount" - OldJobCost);
                "Job Costs (LCY)" += NewDelta;
                OverheadCalculation.SalesLine(SalesLineTmp, false, true);
                if "Line Type" = "line type"::Structure then
                    StructureMgt.SumStructureLines(SalesLineTmp);
                //#4683//
                //#5142
                if ("Line Discount %" = 0) and (lGlobalDisc <> 0) then begin
                    Validate("Line Discount Amount", lGlobalDisc);
                    "Line Discount %" := 0;
                end;
                //#5142//
                Modify;
            end;
        end;
        Commit;

    end;


    procedure ClearJobCost()
    var
        lSalesLine: Record "Sales Line";
        lMax: Integer;
        i: Integer;
        lGlobalDisc: Decimal;
    begin
        wProgress.Update(1, tInitPrice);
        with SalesLineTmp do begin
            if not IsEmpty then begin
                Find('-');
                lMax := COUNTAPPROX;
                repeat
                    i += 1;
                    wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                    if (Type <> Type::" ") then begin
                        if "Job Costs (LCY)" <> 0 then begin
                            "Job Costs (LCY)" := 0;
                            if "Assignment Basis" = "assignment basis"::" " then
                                "Job Costs Margin Included" := 0;
                            Modify;
                            //#5142
                            if lSalesLine."Line Discount %" = 0 then
                                lGlobalDisc := lSalesLine."Line Discount Amount";
                            //#5142

                            if ("Line Type" = "line type"::Structure) and
                               ("Assignment Basis" = "assignment basis"::" ") then begin
                                //#4797          StructureMgt.SumStructureLines(SalesLineTmp)
                                if ("Found Price" = 0) and not ("Fixed Price") then begin
                                    //#5415
                                    StructureMgt.UpdateSumStructPrice(SalesLineTmp);
                                    //            "Unit Price" := ("Total Cost (LCY)" + "Overhead Amount (LCY)" +
                                    //                        "Theoretical Profit Amount(LCY)") / "Quantity (Base)";
                                    //#5415//
                                    //#5124
                                    //#7393
                                    if not wNavibatSetup."Specific Struct. Price Calcul" and ("Quantity (Base)" * Quantity <> 0) and
                                       //            IF wNavibatSetup."Specific Struct. Price Calcul" AND ("Quantity (Base)" * Quantity <> 0) AND
                                       //#7393//
                                       ("Quantity (Base)" <> Quantity) then
                                        "Unit Price" := "Unit Price" / Quantity * "Quantity (Base)";

                                    //#5124//
                                    if (SalesHeader."Currency Code" <> '') and ("Unit Price" <> 0) then
                                        "Unit Price" := ROUND(
                                            CurrExchRate.ExchangeAmtLCYToFCY(
                                                GetDate,
                                                SalesHeader."Currency Code",
                                                "Unit Price",
                                                SalesHeader."Currency Factor"),
                                                wUnitRoundPrec)
                                    else
                                        "Unit Price" := ROUND("Unit Price", wUnitRoundPrec);
                                    //#5142
                                    if wRecalculAmount then begin
                                        if (lGlobalDisc = 0) then
                                            Validate("Unit Price")
                                        else begin
                                            Validate("Line Discount Amount", lGlobalDisc);
                                            lSalesLine."Line Discount %" := 0;
                                        end;
                                    end;
                                    //#5142//
                                    //#4797//
                                end;
                            end else
                                OverheadCalculation.SalesLine(SalesLineTmp, false, true);
                            if wRecalculAmount then
                                Modify;
                        end;
                        //PREPAYMENT
                        if ("Line Type" <> "line type"::Other) or ("Quote No." <> '') then begin
                            if "Assignment Basis" = "assignment basis"::" " then
                                TotalDocInit += ROUND((Quantity * "Unit Price"), Currency."Amount Rounding Precision", '=')
                            else
                                if "Quantity (Base)" <> 0 then
                                    TotalDocInit += ROUND(("Total Cost (LCY)" + "Overhead Amount (LCY)" +
                                                           "Theoretical Profit Amount(LCY)") / "Quantity (Base)",
                                                           wUnitRoundPrec, '=') * Quantity;
                        end;
                        TotalDocDiscount += SalesLineTmp."Line Discount Amount" + SalesLineTmp."Inv. Discount Amount";
                    end;
                    SalesLineTmp2 := SalesLineTmp;
                    SalesLineTmp2.Insert;
                until Next = 0;
            end;
        end;
    end;


    procedure UpdateJobCostAssgntForm(pJobCostLine: Record "Sales Line"; pSalesLine: Record "Sales Line"; pLineAssigned: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        UpdateLine(pJobCostLine, pSalesLine, pLineAssigned);
        if pSalesLine."Line Type" = pSalesLine."line type"::Totaling then begin
            lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
            lSalesLine.SetRange("Document Type", pSalesLine."Document Type");
            lSalesLine.SetRange("Document No.", pSalesLine."Document No.");
            lSalesLine.SetFilter("Presentation Code", '%1', pSalesLine."Presentation Code" + '*');
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange(Option, false);
            lSalesLine.SetRange("Assignment Basis", 0);
            lSalesLine.SetFilter("Line Type", '<>0');
            if lSalesLine.Find('-') then
                repeat
                    UpdateLine(pJobCostLine, lSalesLine, pLineAssigned);
                until lSalesLine.Next = 0;
        end;
    end;


    procedure UpdateLine(pJobCostLine: Record "Sales Line"; pSalesLine: Record "Sales Line"; pLineAssigned: Boolean)
    begin
        if pLineAssigned then begin
            if not JobCostAssgntExist(
                     pJobCostLine."Document Type",
                     pJobCostLine."Document No.",
                     pJobCostLine."Line No.",
                     pSalesLine."Line No.") then
                if pSalesLine."Line Type" = pSalesLine."line type"::Totaling then
                    InsertJobCostAssgnt(pJobCostLine, pSalesLine, false)
                else
                    InsertJobCostAssgnt(pJobCostLine, pSalesLine, pLineAssigned);
        end else
            pSalesLine.wDeleteJobCostAssgnt(
               pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.", pJobCostLine."Line No.");
    end;


    procedure JobCostAssgntExist(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; pDocNo: Code[20]; pJobCostLineNo: Integer; pLineNo: Integer): Boolean
    begin
        exit(JobCostAssgnt.Get(pDocType, pDocNo, pJobCostLineNo, pLineNo));
    end;


    procedure InsertJobCostAssgnt(pJobCostAssgnt: Record "Sales Line"; pSalesLine: Record "Sales Line"; pAssigned: Boolean)
    var
        lJobCostAssgnt2: Record "Job Cost Assignment";
    begin
        with lJobCostAssgnt2 do begin
            Init;
            "Document Type" := pJobCostAssgnt."Document Type";
            "Document No." := pJobCostAssgnt."Document No.";
            "Document Line No." := pJobCostAssgnt."Line No.";
            "Applies-to Doc. Line No." := pSalesLine."Line No.";
            "Job Cost No." := pJobCostAssgnt."No.";
            "No." := pSalesLine."No.";
            Description := pSalesLine.Description;
            Assigned := pAssigned;
            Insert;
        end;
    end;

    local procedure CalcJobCost(var pJobCostLine: Record "Sales Line"): Decimal
    var
        lAmount: Decimal;
    begin
        if pJobCostLine."Line Type" = pJobCostLine."line type"::Other then begin
            lAmount := pJobCostLine."Line Amount";
            SalesLineTmp.Get(pJobCostLine."Document Type", pJobCostLine."Document No.", pJobCostLine."Line No.");
            //#7326
            //   SalesLineTmp."Unit Price" := 0;
            //#7326//
            SalesLineTmp.UpdateAmounts;
            //#7693
            SalesLineTmp."Unit Price" := pJobCostLine."Unit Price";
            //#9181
            SalesLineTmp."Line Amount" := 0;
            SalesLineTmp."Amount Excl. VAT (LCY)" := 0;
            SalesLineTmp."Outstanding Amount" := 0;
            //#9181//
            //#7693//
            SalesLineTmp.Modify;
        end else
            if pJobCostLine."Quantity (Base)" <> 0 then
                lAmount := ROUND(
                    (pJobCostLine."Total Cost (LCY)" +
                     pJobCostLine."Overhead Amount (LCY)" +
                     pJobCostLine."Theoretical Profit Amount(LCY)") /
                     pJobCostLine."Quantity (Base)", wUnitRoundPrec) * pJobCostLine.Quantity
            else
                lAmount := 0;
        exit(lAmount);
    end;

    local procedure CalcBasis(pJobCostLine: Record "Sales Line"): Decimal
    var
        lTotaling: Record "Sales Line";
        lJobCostAssgnt: Record "Job Cost Assignment";
        lAmount: Decimal;
    begin
        with SalesLineTmp3 do begin
            CopyFilters(SalesLineTmp);
            SetRange("Assignment Basis", 0);
            SetRange("Assignment Method", 0);
            case pJobCostLine."Assignment Method" of
                pJobCostLine."assignment method"::All:
                    begin
                        LineNumber := Count;
                        if FindSet then
                            repeat
                                lAmount := lAmount +
                                           Basis(SalesLineTmp3, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata");
                            until Next = 0;
                    end;
                pJobCostLine."assignment method"::Totaling:
                    begin
                        if not lTotaling.Get(pJobCostLine."Document Type", pJobCostLine."Document No.", pJobCostLine."Attached to Line No.") then
                            exit(0);
                        SetFilter("Presentation Code", '%1', lTotaling."Presentation Code" + '*');
                        LineNumber := Count;
                        if FindSet then
                            repeat
                                lAmount := lAmount +
                                           Basis(SalesLineTmp3, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata");
                            until Next = 0;
                    end;
                pJobCostLine."assignment method"::Selection:
                    begin
                        Reset;
                        lJobCostAssgnt.SetRange("Document Type", pJobCostLine."Document Type");
                        lJobCostAssgnt.SetRange("Document No.", pJobCostLine."Document No.");
                        lJobCostAssgnt.SetRange("Document Line No.", pJobCostLine."Line No.");
                        lJobCostAssgnt.SetRange(Assigned, true);
                        LineNumber := lJobCostAssgnt.Count;
                        if lJobCostAssgnt.Find('-') then
                            repeat
                                Get(
                                  lJobCostAssgnt."Document Type",
                                  lJobCostAssgnt."Document No.",
                                  lJobCostAssgnt."Applies-to Doc. Line No.");
                                lAmount := lAmount +
                                           Basis(SalesLineTmp3, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata");
                            until lJobCostAssgnt.Next = 0;
                    end;
                pJobCostLine."assignment method"::"No Subcontracting":
                    begin
                        SetRange(Subcontracting, Subcontracting::" ");
                        LineNumber := Count;
                        if FindSet then
                            repeat
                                lAmount := lAmount + Basis(SalesLineTmp3, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")
                 ;
                            until Next = 0;
                    end;
                pJobCostLine."assignment method"::Subcontracting:
                    begin
                        SetFilter(Subcontracting, '<>%1', Subcontracting::" ");
                        LineNumber := Count;
                        if FindSet then
                            repeat
                                lAmount := lAmount +
                                           Basis(SalesLineTmp3, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata");
                            until Next = 0;
                    end;
            end;
        end;
        exit(lAmount);
    end;


    procedure CalcAssignment(pJobCostLine: Record "Sales Line")
    var
        lSalesLine2: Record "Sales Line";
        lTotaling: Record "Sales Line";
        lJobCostAssgnt: Record "Job Cost Assignment";
        lJobCostAssgnt2: Record "Job Cost Assignment";
        lDiff: Decimal;
        i: Integer;
        lMax: Integer;
        lNaviBatSetup: Record NavibatSetup;
    begin
        with SalesLineTmp2 do begin
            CopyFilters(SalesLineTmp);
            //#7303
            lNaviBatSetup.Get;
            //#7303//
            SetRange("Assignment Basis", 0);
            SetRange("Assignment Method", 0);
            SetRange("Structure Line No.", 0);
            Clear(lDiff);
            SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option);
            case pJobCostLine."Assignment Method" of
                pJobCostLine."assignment method"::All:
                    if Find('-') then begin
                        lMax := COUNTAPPROX;
                        repeat
                            i += 1;
                            wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                            if ("Cross-Ref. Line No." = 0) or
                               ("Line No." = "Cross-Ref. Line No.") then begin
                                Validate("Job Costs (LCY)", "Job Costs (LCY)" +
                                  CalcRepartition(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")));
                                //#5239
                                "Job Costs Margin Included" +=
                                  CalcRepMargin(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata"));
                                //#5239//
                                lSalesLine2.Copy(SalesLineTmp2);
                                //#7303
                                //IF lSalesLine2.NEXT = 0 THEN BEGIN
                                if (lSalesLine2.Next = 0) and (not lNaviBatSetup."Ignore Job Cost Around") then begin
                                    //#7303//
                                    lDiff := TotalJobCost - TotalAssigned;
                                    if lDiff <> 0 then
                                        Validate("Job Costs (LCY)", "Job Costs (LCY)" + lDiff);
                                    //#5239
                                    lDiff := TotalMarginJobCost - TotalMarginAssigned;
                                    if lDiff <> 0 then
                                        "Job Costs Margin Included" := "Job Costs Margin Included" + lDiff;
                                    //#5239//
                                end;
                                Modify;
                            end;
                        until Next = 0;
                    end;
                pJobCostLine."assignment method"::Totaling:
                    begin
                        if not lTotaling.Get(pJobCostLine."Document Type", pJobCostLine."Document No.", pJobCostLine."Attached to Line No.") then
                            exit;
                        SetFilter("Presentation Code", '%1', lTotaling."Presentation Code" + '*');
                        if Find('-') then begin
                            lMax := COUNTAPPROX;
                            repeat
                                i += 1;
                                wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                                if ("Cross-Ref. Line No." = 0) or ("Line No." = "Cross-Ref. Line No.") then begin
                                    Validate("Job Costs (LCY)", "Job Costs (LCY)" +
                                     CalcRepartition(Basis(
                                              SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")));
                                    //#5239
                                    "Job Costs Margin Included" +=
                                      CalcRepMargin(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata"));
                                    //#5239//
                                    lSalesLine2.Copy(SalesLineTmp2);
                                    //#7303
                                    //IF lSalesLine2.NEXT = 0 THEN BEGIN
                                    if (lSalesLine2.Next = 0) and (not lNaviBatSetup."Ignore Job Cost Around") then begin
                                        //#7303//
                                        lDiff := TotalJobCost - TotalAssigned;
                                        if lDiff <> 0 then
                                            Validate("Job Costs (LCY)", "Job Costs (LCY)" + lDiff);
                                        //#5239
                                        lDiff := TotalMarginJobCost - TotalMarginAssigned;
                                        if lDiff <> 0 then
                                            "Job Costs Margin Included" := "Job Costs Margin Included" + lDiff;
                                        //#5239//
                                    end;
                                    Modify;
                                end;
                            until Next = 0;
                        end;
                    end;
                pJobCostLine."assignment method"::Selection:
                    begin
                        Reset;
                        lJobCostAssgnt.SetRange("Document Type", pJobCostLine."Document Type");
                        lJobCostAssgnt.SetRange("Document No.", pJobCostLine."Document No.");
                        lJobCostAssgnt.SetRange("Document Line No.", pJobCostLine."Line No.");
                        lJobCostAssgnt.SetRange(Assigned, true);
                        if lJobCostAssgnt.Find('-') then begin
                            lMax := COUNTAPPROX;
                            repeat
                                i += 1;
                                wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                                Get(pJobCostLine."Document Type", pJobCostLine."Document No.", lJobCostAssgnt."Applies-to Doc. Line No.");
                                if ("Cross-Ref. Line No." = 0) or ("Line No." = "Cross-Ref. Line No.") then begin
                                    Validate("Job Costs (LCY)", "Job Costs (LCY)" +
                                      CalcRepartition(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")));
                                    //#5239
                                    "Job Costs Margin Included" +=
                                      CalcRepMargin(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata"));
                                    //#5239//
                                    lJobCostAssgnt2.Copy(lJobCostAssgnt);
                                    //#7303
                                    //IF lJobCostAssgnt2.NEXT = 0 THEN BEGIN
                                    if (lJobCostAssgnt2.Next = 0) and (not lNaviBatSetup."Ignore Job Cost Around") then begin
                                        //#7303//
                                        lDiff := TotalJobCost - TotalAssigned;
                                        if lDiff <> 0 then
                                            Validate("Job Costs (LCY)", "Job Costs (LCY)" + lDiff);
                                        //#5239
                                        lDiff := TotalMarginJobCost - TotalMarginAssigned;
                                        if lDiff <> 0 then
                                            "Job Costs Margin Included" := "Job Costs Margin Included" + lDiff;
                                        //#5239//
                                    end;
                                    Modify;
                                end;
                            until lJobCostAssgnt.Next = 0;
                        end;
                    end;
                pJobCostLine."assignment method"::"No Subcontracting":
                    begin
                        SetRange(Subcontracting, Subcontracting::" ");
                        if Find('-') then begin
                            lMax := COUNTAPPROX;
                            repeat
                                i += 1;
                                wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                                if ("Cross-Ref. Line No." = 0) or ("Line No." = "Cross-Ref. Line No.") then begin
                                    Validate("Job Costs (LCY)", "Job Costs (LCY)" +
                                      CalcRepartition(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")));
                                    //#5239
                                    "Job Costs Margin Included" +=
                                      CalcRepMargin(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata"));
                                    //#5239//
                                    lSalesLine2.Copy(SalesLineTmp2);
                                    //#7303
                                    //IF lSalesLine2.NEXT = 0 THEN BEGIN
                                    if (lSalesLine2.Next = 0) and (not lNaviBatSetup."Ignore Job Cost Around") then begin
                                        //#7303//
                                        lDiff := TotalJobCost - TotalAssigned;
                                        if lDiff <> 0 then
                                            Validate("Job Costs (LCY)", "Job Costs (LCY)" + lDiff);
                                        //#5239
                                        lDiff := TotalMarginJobCost - TotalMarginAssigned;
                                        if lDiff <> 0 then
                                            "Job Costs Margin Included" := "Job Costs Margin Included" + lDiff;
                                        //#5239//
                                    end;
                                    Modify;
                                end;
                            until Next = 0;
                        end;
                    end;
                pJobCostLine."assignment method"::Subcontracting:
                    begin
                        SetFilter(Subcontracting, '<>%1', Subcontracting::" ");
                        if Find('-') then begin
                            lMax := COUNTAPPROX;
                            repeat
                                i += 1;
                                wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                                if ("Cross-Ref. Line No." = 0) or ("Line No." = "Cross-Ref. Line No.") then begin
                                    Validate("Job Costs (LCY)", "Job Costs (LCY)" +
                                     CalcRepartition(Basis(
                                          SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata")));
                                    //#5239
                                    "Job Costs Margin Included" +=
                                      CalcRepMargin(Basis(SalesLineTmp2, pJobCostLine."Assignment Basis", pJobCostLine."Gen. Prod. Posting Prorata"));
                                    //#5239//
                                    lSalesLine2.Copy(SalesLineTmp2);
                                    //#7303
                                    //IF lSalesLine2.NEXT = 0 THEN BEGIN
                                    if (lSalesLine2.Next = 0) and (not lNaviBatSetup."Ignore Job Cost Around") then begin
                                        //#7303//
                                        lDiff := TotalJobCost - TotalAssigned;
                                        if lDiff <> 0 then
                                            Validate("Job Costs (LCY)", "Job Costs (LCY)" + lDiff);
                                        //#5239
                                        lDiff := TotalMarginJobCost - TotalMarginAssigned;
                                        if lDiff <> 0 then
                                            "Job Costs Margin Included" := "Job Costs Margin Included" + lDiff;
                                        //#5239//
                                    end;
                                    Modify;
                                end;
                            until Next = 0;
                        end;
                    end;
            end;
            if TotalAssigned = 0 then
                Error(ErrorRep, pJobCostLine."Line No.", pJobCostLine.Description);
        end;
    end;


    procedure Basis(pSalesLine: Record "Sales Line"; pBasis: Option " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific; pFilter: Text[250]): Decimal
    var
        lAmount: Decimal;
    begin
        if pFilter <> '' then
            exit(Basis2(pSalesLine, pBasis, pFilter));

        case pBasis of
            Pbasis::" ":
                lAmount := 0;
            Pbasis::"Person Quantity":
                begin
                    pSalesLine.CalcFields("Person Quantity");
                    lAmount := pSalesLine."Person Quantity";
                end;
            Pbasis::"Direct Cost":
                lAmount := pSalesLine."Total Cost (LCY)";
            Pbasis::"Cost Price":
                lAmount := pSalesLine."Total Cost (LCY)" + pSalesLine."Overhead Amount (LCY)";
            Pbasis::"Estimated Price":
                lAmount := pSalesLine."Total Cost (LCY)" + pSalesLine."Overhead Amount (LCY)" +
                           pSalesLine."Theoretical Profit Amount(LCY)";
            Pbasis::Specific:
                lAmount := JobCostSpecific.SpecificBasis(pSalesLine);
        end;
        exit(lAmount);
    end;


    procedure Basis2(pSalesLine: Record "Sales Line"; pBasis: Option " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific; pFilter: Text[250]): Decimal
    var
        lSalesLine: Record "Sales Line";
        lSalesLineTemp: Record "Sales Line" temporary;
        lGenProdPostingGp: Record "Gen. Product Posting Group";
        lStructureMgt: Codeunit "Structure Management";
        lAmount: Decimal;
    begin
        if pSalesLine."Line Type" = pSalesLine."line type"::Structure then begin
            lSalesLineTemp := pSalesLine;
            lSalesLineTemp."Gen. Prod Posting Group Filter" := pFilter;
            lSalesLineTemp.Insert;
            if pBasis <> Pbasis::"Person Quantity" then
                lStructureMgt.SumStructureLines(lSalesLineTemp)
        end else begin
            lSalesLine.SetRange("Document Type", pSalesLine."Document Type");
            lSalesLine.SetRange("Document No.", pSalesLine."Document No.");
            lSalesLine.SetRange("Line No.", pSalesLine."Line No.");
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pFilter);
            if lSalesLine.FindFirst then begin
                lSalesLineTemp := pSalesLine;
                lSalesLineTemp.Insert;
            end else
                exit(0);
        end;

        lAmount := 0;

        case pBasis of
            Pbasis::"Person Quantity":
                begin
                    if lSalesLineTemp."Line Type" = lSalesLineTemp."line type"::Person then
                        lAmount := lSalesLineTemp."Quantity (Base)"
                    else
                        if lSalesLineTemp."Line Type" = lSalesLineTemp."line type"::Structure then begin
                            lGenProdPostingGp.SetRange(Code, pFilter);
                            if not lGenProdPostingGp.IsEmpty then begin
                                pSalesLine.SetRange("Gen. Prod Posting Group Filter", pFilter);
                                pSalesLine.CalcFields("Person Quantity");
                                lAmount := pSalesLine."Person Quantity";
                            end else begin
                                lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                                lSalesLine.SetRange("Document Type", lSalesLineTemp."Document Type");
                                lSalesLine.SetRange("Document No.", lSalesLineTemp."Document No.");
                                lSalesLine.SetRange("Structure Line No.", lSalesLineTemp."Line No.");
                                lSalesLine.SetRange("Line Type", lSalesLine."line type"::Person);
                                lSalesLine.SetFilter("Gen. Prod. Posting Group", pFilter);
                                if lSalesLine.FindSet then
                                    repeat
                                        lAmount += lSalesLine."Quantity (Base)";
                                    until lSalesLine.Next = 0;
                            end;
                        end;
                end;
            Pbasis::"Direct Cost":
                lAmount := lSalesLineTemp."Total Cost (LCY)";
            Pbasis::"Cost Price":
                lAmount := lSalesLineTemp."Total Cost (LCY)" + pSalesLine."Overhead Amount (LCY)";
            Pbasis::"Estimated Price":
                lAmount := lSalesLineTemp."Total Cost (LCY)" + lSalesLineTemp."Overhead Amount (LCY)" +
                           lSalesLineTemp."Theoretical Profit Amount(LCY)";
            Pbasis::Specific:
                lAmount := JobCostSpecific.SpecificBasis(pSalesLine);
        end;

        exit(lAmount);
    end;

    local procedure CalcRepartition(pCost: Decimal) Return: Decimal
    begin
        if (pCost = 0) or (TotalBasis = 0) and (LineNumber <> 1) then
            exit(0);
        if LineNumber = 1 then begin
            TotalAssigned := TotalJobCost;
            exit(ROUND(TotalJobCost, Currency."Amount Rounding Precision"));
        end;

        Return := ROUND(pCost * TotalJobCost / TotalBasis, Currency."Amount Rounding Precision");
        TotalAssigned += ROUND(Return, Currency."Amount Rounding Precision");

        exit(ROUND(Return, Currency."Amount Rounding Precision"));
    end;

    local procedure CalcRepMargin(pCost: Decimal) Return: Decimal
    begin
        //#5239
        if (pCost = 0) or (TotalBasis = 0) and (LineNumber <> 1) then
            exit(0);
        if LineNumber = 1 then begin
            TotalMarginAssigned := TotalMarginJobCost;
            exit(ROUND(TotalMarginJobCost, Currency."Amount Rounding Precision"));
        end;

        Return := ROUND(pCost * TotalMarginJobCost / TotalBasis, Currency."Amount Rounding Precision");
        TotalMarginAssigned += ROUND(Return, Currency."Amount Rounding Precision");

        exit(ROUND(Return, Currency."Amount Rounding Precision"));
        //#5239//
    end;


    procedure Assignment(var pSalesLine: Record "Sales Line") Return: Text[1024]
    var
        lJobCostAssgnt: Record "Job Cost Assignment";
        lSalesLine2: Record "Sales Line";
        lFirst: Boolean;
        lMax: Integer;
    begin
        lMax := MaxStrLen(Return);
        lJobCostAssgnt.SetRange("Document Type", pSalesLine."Document Type");
        lJobCostAssgnt.SetRange("Document No.", pSalesLine."Document No.");
        lJobCostAssgnt.SetRange("Applies-to Doc. Line No.", pSalesLine."Line No.");
        lJobCostAssgnt.SetRange(Assigned, true);
        if lJobCostAssgnt.Find('-') then begin
            lFirst := true;
            repeat
                if lFirst then
                    lFirst := false
                else
                    Return := CopyStr(Return + ';', 1, lMax);
                lSalesLine2.Get(lJobCostAssgnt."Document Type", lJobCostAssgnt."Document No.", lJobCostAssgnt."Document Line No.");
                if lSalesLine2."Job Cost Assignment" <> '' then
                    lSalesLine2.Description := lSalesLine2."Job Cost Assignment";
                Return := CopyStr(Return + lSalesLine2.Description, 1, lMax);
            until lJobCostAssgnt.Next = 0;
        end;
    end;


    procedure AssignmentArchive(var pSalesLine: Record "Sales Line Archive") Return: Text[1024]
    var
        lJobCostAssgnt: Record "Job Cost Assignment Archive";
        lSalesLine2: Record "Sales Line Archive";
        lFirst: Boolean;
        lMax: Integer;
    begin
        lMax := MaxStrLen(Return);
        lJobCostAssgnt.SetRange("Document Type", pSalesLine."Document Type");
        lJobCostAssgnt.SetRange("Document No.", pSalesLine."Document No.");
        lJobCostAssgnt.SetRange("Doc. No. Occurrence", pSalesLine."Doc. No. Occurrence");
        lJobCostAssgnt.SetRange("Version No.", pSalesLine."Version No.");
        lJobCostAssgnt.SetRange("Applies-to Doc. Line No.", pSalesLine."Line No.");
        lJobCostAssgnt.SetRange(Assigned, true);
        if not lJobCostAssgnt.IsEmpty then
            if lJobCostAssgnt.Find('-') then begin
                lFirst := true;
                repeat
                    if lFirst then
                        lFirst := false
                    else
                        Return := CopyStr(Return + ';', 1, lMax);
                    lSalesLine2.Get(
                      lJobCostAssgnt."Document Type",
                      lJobCostAssgnt."Document No.",
                      lJobCostAssgnt."Doc. No. Occurrence",
                      lJobCostAssgnt."Version No.",
                      lJobCostAssgnt."Document Line No.");
                    if lSalesLine2."Job Cost Assignment" <> '' then
                        lSalesLine2.Description := lSalesLine2."Job Cost Assignment";
                    Return := CopyStr(Return + lSalesLine2.Description, 1, lMax);
                until lJobCostAssgnt.Next = 0;
            end;
    end;


    procedure CalcBasisJobCost(pRec: Record "Sales Line"; pAssignmentBasis: Integer): Decimal
    var
        lJobCostSpecifCalcul: Codeunit "Job Cost Specific Calculation";
    begin
        case pAssignmentBasis of
            0:
                exit(0);
            1:
                begin
                    exit(CalcMOQuantity(pRec));
                end;
            2:
                begin
                    exit(pRec."Total Cost (LCY)");
                end;
            3:
                begin
                    exit(pRec."Total Cost (LCY)" + pRec."Overhead Amount (LCY)");
                end;
            4:
                begin
                    exit(pRec."Total Cost (LCY)" + pRec."Overhead Amount (LCY)" + pRec."Theoretical Profit Amount(LCY)");
                end;
            5:
                exit(lJobCostSpecifCalcul.SpecificBasis(pRec));
        end;
    end;


    procedure CalcMOQuantity(pRec: Record "Sales Line"): Decimal
    var
        lSalesLine: Record "Sales Line";
        Return: Decimal;
    begin
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Structure Line No.", pRec."Line No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Person);
        if lSalesLine.FindSet then
            repeat
                Return += lSalesLine."Quantity (Base)";
            until lSalesLine.Next = 0;
        exit(Return);
    end;


    procedure CalcTotalBasisJobCost(pRec: Record "Sales Line"): Decimal
    var
        lJobCostAssignment: Record "Job Cost Assignment";
        lSalesLine: Record "Sales Line";
    begin
        case pRec."Assignment Method" of
            pRec."assignment method"::All:
                begin
                    lSalesLine.SetRange("Document Type", pRec."Document Type");
                    lSalesLine.SetRange("Document No.", pRec."Document No.");
                    lSalesLine.SetRange("Assignment Basis", lSalesLine."assignment basis"::" ");
                    if lSalesLine.FindSet then
                        repeat
                            TotalBase += CalcBasisJobCost(lSalesLine, pRec."Assignment Basis");
                        until lJobCostAssignment.Next = 0;
                end;
            pRec."assignment method"::Totaling:
                begin
                    lSalesLine.SetRange("Document Type", pRec."Document Type");
                    lSalesLine.SetRange("Document No.", pRec."Document No.");
                    lSalesLine.SetRange(Level, pRec.Level - 1);
                    lSalesLine.SetFilter("Presentation Code", CopyStr(DelChr('%1'), 1, StrLen(DelChr('%1')) - 1) + '*', pRec."Presentation Code");
                    lSalesLine.SetRange("Assignment Basis", lSalesLine."assignment basis"::" ");
                    if lSalesLine.FindSet then
                        repeat
                            TotalBase += CalcBasisJobCost(lSalesLine, pRec."Assignment Basis");
                        until lJobCostAssignment.Next = 0;
                end;
            pRec."assignment method"::Selection:
                begin
                    lJobCostAssignment.SetRange("Document Type", pRec."Document Type");
                    lJobCostAssignment.SetRange("Document No.", pRec."Document No.");
                    lJobCostAssignment.SetRange("Document Line No.", pRec."Line No.");
                    if lJobCostAssignment.FindSet then
                        repeat
                            lSalesLine.SetRange("Document Type", lJobCostAssignment."Document Type");
                            lSalesLine.SetRange("Document No.", lJobCostAssignment."Document No.");
                            lSalesLine.SetRange("Line No.", lJobCostAssignment."Applies-to Doc. Line No.");
                            lSalesLine.SetFilter("Line Type", '%1..', lSalesLine."line type"::Item);
                            if lSalesLine.FindSet then
                                repeat
                                    TotalBase += CalcBasisJobCost(lSalesLine, pRec."Assignment Basis");
                                until lSalesLine.Next = 0;
                        until lJobCostAssignment.Next = 0;
                end;
            pRec."assignment method"::"No Subcontracting":
                begin
                    lSalesLine.SetRange("Document Type", pRec."Document Type");
                    lSalesLine.SetRange("Document No.", pRec."Document No.");
                    lSalesLine.SetRange("Assignment Basis", lSalesLine."assignment basis"::" ");
                    lSalesLine.SetRange(Subcontracting, lSalesLine.Subcontracting::" ");
                    if lSalesLine.FindSet then
                        repeat
                            TotalBase += CalcBasisJobCost(lSalesLine, pRec."Assignment Basis");
                        until lSalesLine.Next = 0;
                end;
            pRec."assignment method"::Subcontracting:
                begin
                    lSalesLine.SetRange("Document Type", pRec."Document Type");
                    lSalesLine.SetRange("Document No.", pRec."Document No.");
                    lSalesLine.SetRange("Assignment Basis", lSalesLine."assignment basis"::" ");
                    lSalesLine.SetFilter(Subcontracting, '<>%1', lSalesLine.Subcontracting::" ");
                    if lSalesLine.FindSet then
                        repeat
                            TotalBase += CalcBasisJobCost(lSalesLine, pRec."Assignment Basis");
                        until lSalesLine.Next = 0;
                end;
            else
                exit(1);
        end;
        exit(TotalBase);
    end;

    local procedure CalcMarketCharge(pSalesHeader: Record "Sales Header"): Boolean
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lTotalAmount: Decimal;
        lTotalRate: Decimal;
        lModif: Boolean;
    begin
        SalesLineTmp.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        SalesLineTmp.SetRange("Document Type", pSalesHeader."Document Type");
        SalesLineTmp.SetRange("Document No.", pSalesHeader."No.");
        SalesLineTmp.SetRange("Line Type", lSalesLine."line type"::Other);
        //+ONE+PREPAYMENT
        SalesLineTmp.SetRange("Quote No.", '');
        //+ONE+PREPAYMENT//
        //lSalesLine.SETRANGE("Fixed Price",FALSE);
        if SalesLineTmp.IsEmpty then
            exit;

        //Calcul des frais montant
        lModif := CalcMarketChargeAmount(SalesLineTmp, pSalesHeader);

        //Calcul des frais par rapport à la base
        lModif := (lModif or CalcMarketChargeBase(SalesLineTmp, pSalesHeader));

        //Calcul des frais par rapport au résultat
        lModif := (lModif or CalcMarketChargeResultat(SalesLineTmp, pSalesHeader));

        exit(lModif);
    end;

    local procedure CalcMarketChargeAmount(var psalesLine: Record "Sales Line"; pSalesHeader: Record "Sales Header"): Boolean
    begin
        //Calcul des frais montant
        psalesLine.SetRange("Value Option", psalesLine."value option"::Amount);
        if not psalesLine.IsEmpty then begin
            psalesLine.FindSet(true);
            repeat
                psalesLine.Quantity := 1;
                psalesLine."Quantity (Base)" := 1;
                //#5721
                if (psalesLine."Rate Amount" = 0) and (psalesLine."Unit Price" <> 0) then
                    psalesLine."Rate Amount" := psalesLine."Unit Price";
                //#5721/
                psalesLine."Unit Price" := psalesLine."Rate Amount";
                if psalesLine."Assignment Basis" <> 0 then begin
                    psalesLine."Outstanding Quantity" := psalesLine.Quantity;
                    psalesLine.Validate("Qty. to Ship", psalesLine.Quantity);
                    psalesLine."Outstanding Qty. (Base)" := psalesLine.Quantity;
                    psalesLine."Qty. to Invoice (Base)" := psalesLine.Quantity;
                    psalesLine."Qty. to Ship (Base)" := psalesLine.Quantity;
                end;
                psalesLine.UpdateAmounts;
                psalesLine.Modify;
                TotalDocInit += psalesLine."Rate Amount";
            until psalesLine.Next = 0;
            exit(true);
        end;
        exit(false);
    end;

    local procedure CalcMarketChargeBase(var pSalesLine: Record "Sales Line"; pSalesHeader: Record "Sales Header"): Boolean
    var
        lSalesLine2: Record "Sales Line";
        lTotalAmount: Decimal;
        lTotalRate: Decimal;
        lModif: Boolean;
    begin
        pSalesLine.SetRange("Value Option", pSalesLine."value option"::"% on Base");
        if pSalesLine.IsEmpty then
            exit(false);

        //Calcul du montant de la commande

        //Calcul des frais de marché par rapport à la base
        lTotalAmount := TotalDocInit - TotalDocDiscount;
        pSalesLine.FindSet(true);
        repeat
            pSalesLine.Quantity := 1;
            pSalesLine."Quantity (Base)" := 1;
            pSalesLine."Unit Price" := lTotalAmount * pSalesLine."Rate Amount" / 100;
            if pSalesLine."Assignment Basis" <> 0 then begin
                pSalesLine."Outstanding Quantity" := pSalesLine.Quantity;
                pSalesLine.Validate("Qty. to Ship", pSalesLine.Quantity);
                pSalesLine."Outstanding Qty. (Base)" := pSalesLine.Quantity;
                pSalesLine."Qty. to Invoice (Base)" := pSalesLine.Quantity;
                pSalesLine."Qty. to Ship (Base)" := pSalesLine.Quantity;
            end;
            pSalesLine.UpdateAmounts;
            pSalesLine.Modify;
            TotalDocInit += pSalesLine."Unit Price";
        until pSalesLine.Next = 0;
        exit(true);
    end;

    local procedure CalcMarketChargeResultat(var pSalesLine: Record "Sales Line"; pSalesHeader: Record "Sales Header"): Boolean
    var
        lSalesLine2: Record "Sales Line";
        lTotalAmount: Decimal;
        lTotalRate: Decimal;
    begin
        //Calcul des frais par rapport au résultat
        pSalesLine.SetRange("Value Option", pSalesLine."value option"::"% on Result");
        if pSalesLine.IsEmpty then
            exit(false);

        //Calcul du nouveau montant de la commande
        lTotalAmount := TotalDocInit - TotalDocDiscount;

        pSalesLine.FindSet;
        repeat
            lTotalRate += pSalesLine."Rate Amount";
        until pSalesLine.Next = 0;

        if lTotalRate >= 100 then
            Error(tErrorTotalRate);

        pSalesLine.FindSet(true);
        repeat
            pSalesLine.Quantity := 1;
            pSalesLine."Quantity (Base)" := 1;
            pSalesLine."Unit Price" := lTotalAmount * pSalesLine."Rate Amount" / (100 - lTotalRate);
            if pSalesLine."Assignment Basis" <> 0 then begin
                pSalesLine."Outstanding Quantity" := pSalesLine.Quantity;
                pSalesLine.Validate("Qty. to Ship", pSalesLine.Quantity);
                pSalesLine."Outstanding Qty. (Base)" := pSalesLine.Quantity;
                pSalesLine."Qty. to Invoice (Base)" := pSalesLine.Quantity;
                pSalesLine."Qty. to Ship (Base)" := pSalesLine.Quantity;
            end;
            pSalesLine.UpdateAmounts;
            pSalesLine.Modify;
            TotalDocInit += pSalesLine."Unit Price";
        until pSalesLine.Next = 0;

        exit(true);
    end;


    procedure CalcSalesLineAmount(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line"; pCurrency: Record Currency): Decimal
    var
        lQtyBase: Decimal;
        lUnitPrice: Decimal;
    begin
        with pSalesLine do begin
            lQtyBase := 1;
            if "Quantity (Base)" <> 0 then
                lQtyBase := "Quantity (Base)";
            if "Line Type" = "line type"::Other then
                lUnitPrice := ("Line Amount") * (Quantity / lQtyBase)
            else
                lUnitPrice := ("Total Cost (LCY)" + "Overhead Amount (LCY)" +
                           "Theoretical Profit Amount(LCY)" + "Job Costs (LCY)") * (Quantity / lQtyBase);
            if pSalesHeader."Currency Code" <> '' then
                CurrExchRate.ExchangeAmtLCYToFCY(
                             GetDate, pSalesHeader."Currency Code",
                             lUnitPrice, pSalesHeader."Currency Factor");
            if Quantity = 0 then
                exit(0);
            exit(ROUND(lUnitPrice / Quantity, wUnitRoundPrec, '='));
        end;
    end;


    procedure AssignArroundError(var pSalesLine: Record "Sales Line"; pLastJobCostLineNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lDiff: Decimal;
    begin
        lDiff := TotalJobCost - TotalAssigned;
        if pLastJobCostLineNo = lSalesLine."Line No." then begin
            pSalesLine.Validate("Job Costs (LCY)", lSalesLine."Job Costs (LCY)" + lDiff);
            pSalesLine.Modify;
        end else begin
            lSalesLine.Get(pSalesLine."Document Type", pSalesLine."Document No.", pLastJobCostLineNo);
            lSalesLine.Validate("Job Costs (LCY)", lSalesLine."Job Costs (LCY)" + lDiff);
            lSalesLine.Modify;
        end;
    end;


    procedure InitTempTable()
    var
        lMax: Integer;
        i: Integer;
    begin
        wProgress.Update(1, tDownload);
        SalesLineTmp.DeleteAll;
        SalesLineTmp2.DeleteAll;
        SalesLineTmp3.DeleteAll;
        with SalesLine do begin
            SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            SetRange("Document Type", Salesline2."Document Type");
            SetRange("Document No.", Salesline2."Document No.");
            SetRange("Structure Line No.", 0);
            SetFilter("Line Type", '%1..', "line type"::Item);
            SetRange(Option, false);
            if not IsEmpty then begin
                FindSet;
                lMax := COUNTAPPROX;
                repeat
                    i += 1;
                    wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                    SalesLineTmp := SalesLine;
                    SalesLineTmp3 := SalesLine;
                    SalesLineTmp.Insert;
                    SalesLineTmp3.Insert;
                until SalesLine.Next = 0;
            end;
        end;
    end;


    procedure TransferTempTable()
    var
        lSalesLineMgt: Codeunit "SalesLine Management";
        lNavibatSetup: Record NavibatSetup;
        i: Integer;
        lMax: Integer;
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        wProgress.Update(1, tUpdate);
        SalesLineTmp.Reset;
        with SalesLineTmp do begin
            if not IsEmpty then begin
                FindSet;
                lMax := COUNTAPPROX;
                repeat
                    i += 1;
                    wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                    SalesLine.Get(SalesLineTmp."Document Type", SalesLineTmp."Document No.", SalesLineTmp."Line No.");
                    SalesLine := SalesLineTmp;
                    SalesLine.Modify;
                    if lSingleInstance.wGetFrequencyCommit = 0 then
                        Commit;
                until Next = 0;
            end;
        end;
        lSalesLineMgt.ReFreshTotalLine(SalesHeader, wProgress);
    end;


    procedure AppendJobCost(var pSalesLine: Record "Sales Line")
    var
        lTabCode: array[20] of Integer;
        lPresentation: Codeunit "Presentation Management";
    begin
        with pSalesLine do begin
            if (SalesLineTmp."Line Type" = SalesLineTmp."line type"::Other) then begin
                Init;
                pSalesLine := SalesLineTmp;
                Insert;
                exit;
            end;
            SetRange("Assignment Method");
            SetRange("Assignment Basis", "Assignment Basis");
            case SalesLineTmp."Assignment Method" of
                SalesLineTmp."assignment method"::All,
                //#6302    SalesLineTmp."Assignment Method"::Selection,
                SalesLineTmp."assignment method"::Subcontracting,
                ////#6302//
                SalesLineTmp."assignment method"::"No Subcontracting":
                    begin
                        SetRange("Assignment Method", SalesLineTmp."Assignment Method");
                        if IsEmpty then begin
                            Init;
                            pSalesLine := SalesLineTmp;
                            Insert;
                        end else begin
                            FindFirst;
                            "Overhead Amount (LCY)" += SalesLineTmp."Overhead Amount (LCY)";
                            "Theoretical Profit Amount(LCY)" += SalesLineTmp."Theoretical Profit Amount(LCY)";
                            "Total Cost (LCY)" += SalesLineTmp."Total Cost (LCY)";
                            Modify;
                        end;
                    end;
                "assignment method"::Totaling:
                    begin
                        lPresentation.wMajTab(SalesLineTmp, lTabCode);
                        if Level > 1 then
                            SetFilter("Presentation Code", '%1*', lPresentation.wCreatePresentationCode(lTabCode, Level - 1));
                        if IsEmpty or (Level = 1) then begin
                            Init;
                            pSalesLine := SalesLineTmp;
                            Insert;
                        end else begin
                            FindFirst;
                            "Overhead Amount (LCY)" += SalesLineTmp."Overhead Amount (LCY)";
                            "Theoretical Profit Amount(LCY)" += SalesLineTmp."Theoretical Profit Amount(LCY)";
                            "Total Cost (LCY)" += SalesLineTmp."Total Cost (LCY)";
                            Modify;
                        end;
                    end;
                "assignment method"::Selection:
                    begin
                        Init;
                        pSalesLine := SalesLineTmp;
                        Insert;
                    end;
            end;
            Reset;
        end;
    end;
}

