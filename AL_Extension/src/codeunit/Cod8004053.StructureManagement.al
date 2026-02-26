Codeunit 8004053 "Structure Management"
{
    // //#5923 Ajout
    // //#5423 Utilisation de "Gen. Prod Posting Group Filter"
    // //DEVIS GESWAY 27/03/03 Gestion des lignes ouvrage

    TableNo = "Sales Line";

    trigger OnRun()
    var
        Text000: label 'The synchronization has been enabled %1 at %2.';
        Text001: label 'The synchronization has been disabled %1 at %2.';
        Text003: label 'The starting date cannot be in the future.';
        Text004: label 'The ending date cannot be in the past.';
        Text005: label 'You must provide an e-mail address for the current salesperson before enabling the synchronization with Outlook.';
        Text006: label 'You cannot delete the %1 for this salesperson while Outlook Synchronization is enabled.';
    begin
        //#5048
        gUpdateStructure(Rec);
        //#5048//
    end;

    var
        IStream: InStream;
        BLOBPortion: Text[250];
        SalesHeader: Record "Sales Header";
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        NavibatSetup: Record NavibatSetup;
        tErrorProfit: label 'It''s not possible to apply a profit purcent on a Salesline Type equal %1';
        wSalesLineTmp2: Record "Sales Line" temporary;
        StructureMgt: Codeunit "Structure Management";
        Overhead: Codeunit "Overhead Calculation";
        wFromOwnerRef: RecordRef;
        wToOwnerRef: RecordRef;
        wFromRef: RecordRef;
        wBOQExist: Boolean;
        wBoqMgt: Codeunit "BOQ Management";


    procedure ExplodeStructure(var pRec: Record "Sales Line")
    var
        SegmentLine: Record "Segment Line" temporary;
        lRec: Record "Sales Line";
        lStructureComponent: Record "Structure Component";
        lxRec: Record "Sales Line";
        lExplodeStc: Codeunit "Explode Structure";
    begin
        NavibatSetup.GET2;
        with pRec do begin
            TestField("Line Type", "line type"::Structure);
            lRec.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetRange("Structure Line No.", "Line No.");
            if not lRec.IsEmpty then
                lRec.DeleteAll(true);
            //#7202
            //CODEUNIT.RUN(CODEUNIT::"Explode Structure",pRec);
            lExplodeStc.fSetBoqManagement(wBoqMgt);
            lExplodeStc.Run(pRec);
            //#7202//
            if not Modify then
                Insert;  //ML
            if ("Found Price" <> 0) and not "Fixed Price" then begin
                Validate("Unit Price", "Found Price");
                if "Quantity (Base)" = 0 then begin
                    "Total Cost (LCY)" := 0;
                    "Overhead Amount (LCY)" := 0;
                    "Theoretical Profit Amount(LCY)" := 0;
                end;
            end;
            Modify;
        end;
    end;


    procedure DeleteStructure(pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
    begin
        with pRec do begin
            TestField("Line Type", "line type"::Structure);
            lRec.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetRange("Structure Line No.", "Line No.");
            if not lRec.IsEmpty then
                lRec.DeleteAll(true);
        end;
    end;


    procedure SumStructureLines(var pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        xRec: Record "Sales Line";
        lUnitPrice: Decimal;
        lNumberOfRes: Decimal;
        lSubStrucQty: Decimal;
        lSubStruct: Record "Sales Line";
        lStructureTmp: Record "Sales Line" temporary;
    begin
        if (pRec."Line No." <> pRec."Cross-Ref. Line No.") and (pRec."Cross-Ref. Line No." <> 0) then
            exit;

        lStructureTmp := pRec;

        InitSumStructure(lStructureTmp);
        with pRec do begin
            lRec.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetRange("Structure Line No.", "Line No.");
            lRec.SetFilter(Type, '=0');
            lRec.SetRange("Line Type", "line type"::Structure);
            if not lRec.IsEmpty then begin
                lRec.ModifyAll("Unit Price", 0);
                lRec.ModifyAll("Total Cost (LCY)", 0);
                lRec.ModifyAll("Unit Cost (LCY)", 0);
                lRec.ModifyAll("Overhead Amount (LCY)", 0);
                lRec.ModifyAll("Theoretical Profit Amount(LCY)", 0);
            end;
            lRec.SetRange(Type);
            lRec.SetFilter("Line Type", '<>0');
            lRec.SetRange(Disable, false);
            //#5423
            lRec.SetFilter("Gen. Prod. Posting Group", "Gen. Prod Posting Group Filter");    //Pour répartition frais direct
                                                                                             //#5423//
            lRec.Ascending(false);
            if not lRec.IsEmpty then begin
                lRec.FindFirst;
                repeat
                    if (lRec.Type <> lRec.Type::" ") then
                        UpdateSumStructCost(lStructureTmp, lRec)
                    else
                        UpdateSubDetailStruct(lRec, lStructureTmp, false);
                until lRec.Next = 0;
            end;
            UpdateSumStructPrice(lStructureTmp);
        end;
        pRec := lStructureTmp;
    end;


    procedure UpdateStructureLine(pRec: Record "Sales Line"; pFieldNo: Integer; pValidate: Boolean)
    var
        lStructureLine: Record "Sales Line";
        lRecRef: RecordRef;
        lNewRecRef: RecordRef;
        lFieldRef: FieldRef;
        lNewFieldValue: FieldRef;
        lFieldRec: Record "Field";
        lDec: Decimal;
        lInt: Integer;
        lCode: Code[20];
        lBool: Boolean;
    begin
        with pRec do begin
            if "Line Type" <> "line type"::Structure then
                exit;

            lNewRecRef.GetTable(pRec);
            lNewFieldValue := lNewRecRef.Field(pFieldNo);

            lStructureLine.Reset;
            lStructureLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lStructureLine.SetRange("Document Type", "Document Type");
            lStructureLine.SetRange("Document No.", "Document No.");
            if "Structure Line No." = 0 then
                lStructureLine.SetRange("Structure Line No.", "Line No.")
            else begin
                lStructureLine.SetRange("Structure Line No.", "Structure Line No.");
                lStructureLine.SetRange("Attached to Line No.", "Line No.");
            end;
            lStructureLine.SetFilter("Line Type", '<>%1', lStructureLine."line type"::" ");

            if pFieldNo = 8004094 then begin
                lStructureLine.SetFilter("Line Type", '%1|%2', "line type"::Person, "line type"::Machine);
                if "Structure Line No." = 0 then
                    lStructureLine.SetRange("Attached to Line No.", 0);
            end;
            //#5423
            lStructureLine.SetFilter("Gen. Prod. Posting Group", "Gen. Prod Posting Group Filter");
            //#5423//

            lStructureLine.Ascending(false);
            lRecRef.GetTable(lStructureLine);
            if not lRecRef.IsEmpty then begin
                lRecRef.Find('-');
                repeat
                    lFieldRef := lRecRef.Field(pFieldNo);
                    Evaluate(lFieldRec.Type, Format(lFieldRef.Type));
                    case lFieldRec.Type of
                        lFieldRec.Type::Decimal:
                            if Evaluate(lDec, Format(lNewFieldValue)) then
                                if pValidate then
                                    lFieldRef.Validate(lDec)
                                else
                                    lFieldRef.Value(lDec);
                        lFieldRec.Type::Integer:
                            if Evaluate(lInt, Format(lNewFieldValue)) then
                                if pValidate then
                                    lFieldRef.Validate(lInt)
                                else
                                    lFieldRef.Value(lInt);
                        lFieldRec.Type::Code:
                            if Evaluate(lCode, Format(lNewFieldValue)) then
                                if pValidate then
                                    lFieldRef.Validate(lCode)
                                else
                                    lFieldRef.Value(lCode);
                        lFieldRec.Type::Boolean:
                            if Evaluate(lBool, Format(lNewFieldValue)) then
                                if pValidate then
                                    lFieldRef.Validate(lBool)
                                else
                                    lFieldRef.Value(lBool);
                        lFieldRec.Type::Option:
                            if pValidate then
                                lFieldRef.Validate(lNewFieldValue.Value)
                            else
                                lFieldRef.Value(lNewFieldValue.Value);
                    end;
                    lRecRef.Modify;
                until lRecRef.Next = 0;
            end;
        end;
    end;


    procedure wInitInstance(pRec: Record "Sales Line")
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        NavibatSetup.GET2;
        lSingleInstance.wGetSalesHeader(SalesHeader, pRec."Document Type", pRec."Document No.");
        lSingleInstance.wSetCurrency(Currency, SalesHeader);
    end;


    procedure InitSumStructure(var pRec: Record "Sales Line")
    var
        lQtySetup: Record "Quantity Setup";
        lRecordRef: RecordRef;
    begin
        with pRec do begin
            wInitInstance(pRec);
            TestField("Line Type", "line type"::Structure);
            "Total Cost (LCY)" := 0;
            "Unit Cost (LCY)" := 0;
            "Theoretical Profit Amount(LCY)" := 0;
            "Overhead Amount (LCY)" := 0;
            "Gross Weight" := 0;
            "Net Weight" := 0;
            "Unit Volume" := 0;
            if lQtySetup.Get then
                if lQtySetup."Formula desactivated / Sales" then begin
                    //#7768
                    lRecordRef.GetTable(pRec);
                    //#8281
                    /*
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 1"))) THEN
                            "Value 1" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 2"))) THEN
                            "Value 2" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 3"))) THEN
                            "Value 3" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 4"))) THEN
                            "Value 4" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 5"))) THEN
                            "Value 5" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 6"))) THEN
                            "Value 6" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 7"))) THEN
                            "Value 7" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 8"))) THEN
                            "Value 8" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 9"))) THEN
                            "Value 9" := 0;
                    //#7918  IF (NOT wBoqMgt.HasReferenceVariable(lRecordRef.RECORDID, pRec.FIELDNO("Value 10"))) THEN
                            "Value 10" := 0;
                    */
                    if (fResetFreeValue(pRec, lQtySetup, 1)) then
                        "Value 1" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 2)) then
                        "Value 2" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 3)) then
                        "Value 3" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 4)) then
                        "Value 4" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 5)) then
                        "Value 5" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 6)) then
                        "Value 6" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 7)) then
                        "Value 7" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 8)) then
                        "Value 8" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 9)) then
                        "Value 9" := 0;
                    if (fResetFreeValue(pRec, lQtySetup, 10)) then
                        "Value 10" := 0;
                    //#8281//
                    //#7768//
                end;
            if (Quantity = 0) and ("Optionnal Quantity" = 0) then
                "Job Costs (LCY)" := 0;
            if not "Fixed Price" then begin
                if "Assignment Basis" = "assignment basis"::" " then
                    if "Found Price" <> 0 then
                        "Unit Price" := "Found Price";
                "Theoretical Profit Amount(LCY)" := 0;
            end;
        end;

    end;


    procedure UpdateSumStructCost(var pStructRec: Record "Sales Line"; pSalesLine: Record "Sales Line")
    var
        lSubStruct: Record "Sales Line";
        lSubStrucQty: Decimal;
        lNumberOfRes: Decimal;
        lQtySetup: Record "Quantity Setup";
    begin
        with pStructRec do begin
            if (pStructRec."Quantity (Base)" = 0) then
                Overhead.SalesLine(pSalesLine, true, true);
            lSubStrucQty := 1;
            if (pSalesLine."Attached to Line No." <> 0) and
               lSubStruct.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Attached to Line No.") then begin
                lSubStrucQty := (lSubStruct."Quantity per" + lSubStruct."Quantity Fixed");
                if lSubStrucQty <> 0 then
                    lSubStrucQty := 1;
            end;

            lNumberOfRes := 1;
            if pSalesLine."Line Type" in [pSalesLine."line type"::Person, pSalesLine."line type"::Machine] then
                lNumberOfRes := pSalesLine."Number of Resources";

            if ("Quantity (Base)" <> 0) and ((pSalesLine."Quantity per" + pSalesLine."Quantity Fixed") * lNumberOfRes <> 0) then begin
                "Total Cost (LCY)" += pSalesLine."Total Cost (LCY)";
                "Overhead Amount (LCY)" += pSalesLine."Overhead Amount (LCY)";
            end else begin
                if (pSalesLine."Quantity per" + pSalesLine."Quantity Fixed") * lNumberOfRes <> 0 then begin
                    "Total Cost (LCY)" += pSalesLine."Unit Cost (LCY)" *
                                         ((pSalesLine."Quantity per" + pSalesLine."Quantity Fixed") * lNumberOfRes) * lSubStrucQty;
                    "Overhead Amount (LCY)" += pSalesLine."Overhead Amount (LCY)";
                end;
            end;

            if //NOT "Fixed Price" AND
               (NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::"Structure line") then begin
                "Theoretical Profit Amount(LCY)" += pSalesLine."Theoretical Profit Amount(LCY)";
            end;
            //#4946
            "Gross Weight" += pSalesLine."Gross Weight" * pSalesLine."Quantity per";
            "Net Weight" += pSalesLine."Net Weight" * pSalesLine."Quantity per";
            "Unit Volume" += pSalesLine."Unit Volume" * pSalesLine."Quantity per";
            if lQtySetup.Get then
                if lQtySetup."Formula desactivated / Sales" then begin
                    "Value 1" += pSalesLine."Value 1" * pSalesLine."Quantity per";
                    "Value 2" += pSalesLine."Value 2" * pSalesLine."Quantity per";
                    "Value 3" += pSalesLine."Value 3" * pSalesLine."Quantity per";
                    "Value 4" += pSalesLine."Value 4" * pSalesLine."Quantity per";
                    "Value 5" += pSalesLine."Value 5" * pSalesLine."Quantity per";
                    "Value 6" += pSalesLine."Value 6" * pSalesLine."Quantity per";
                    "Value 7" += pSalesLine."Value 7" * pSalesLine."Quantity per";
                    "Value 8" += pSalesLine."Value 8" * pSalesLine."Quantity per";
                    "Value 9" += pSalesLine."Value 9" * pSalesLine."Quantity per";
                    "Value 10" += pSalesLine."Value 10" * pSalesLine."Quantity per";
                end;
            //#4946//
            UpdateSubDetailStruct(pSalesLine, lSubStruct, false);

            //#5264
            if pSalesLine."Quantity (Base)" = 0 then begin
                pSalesLine."Total Cost (LCY)" := 0;
                pSalesLine."Overhead Amount (LCY)" := 0;
                pSalesLine."Theoretical Profit Amount(LCY)" := 0;
                if pSalesLine.Modify then;
            end;
            //#5264//
        end;
    end;


    procedure UpdateSubDetailStruct(var pRec: Record "Sales Line"; pStructRec: Record "Sales Line"; pInit: Boolean)
    var
        lStructAttached: Record "Sales Line";
        lSubstructureQty: Decimal;
        lNbRes: Decimal;
        lQtySetup: Record "Quantity Setup";
    begin
        with pRec do begin
            //#7075
            /*
              IF pInit THEN BEGIN
                "Unit Price" := 0;
                "Total Cost (LCY)" := 0;
                "Unit Cost (LCY)" := 0;
                "Overhead Amount (LCY)" := 0;
                "Theoretical Profit Amount(LCY)" := 0;
                MODIFY;
              END ELSE
            */
            //#7075//
            begin
                //gestion des options
                if pRec."Attached to Line No." = 0 then
                    exit;
                if pRec."Attached to Line No." = pStructRec."Line No." then
                    lStructAttached := pStructRec
                else
                    if not lStructAttached.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.") then
                        exit;
                lNbRes := 1;
                if "Line Type" in ["line type"::Person, "line type"::Machine] then
                    lNbRes := "Number of Resources";
                lSubstructureQty := lStructAttached."Quantity per" + lStructAttached."Quantity Fixed";

                if (lSubstructureQty = 0) then
                    lSubstructureQty := 1;
                //Calcul des cumuls
                lStructAttached."Gross Weight" += "Gross Weight" * "Quantity per";
                lStructAttached."Net Weight" += "Net Weight" * "Quantity per";
                lStructAttached."Unit Volume" += "Unit Volume" * "Quantity per";
                if lQtySetup.Get then
                    if lQtySetup."Formula desactivated / Sales" then begin
                        lStructAttached."Value 1" += "Value 1" * "Quantity per";
                        lStructAttached."Value 2" += "Value 2" * "Quantity per";
                        lStructAttached."Value 3" += "Value 3" * "Quantity per";
                        lStructAttached."Value 4" += "Value 4" * "Quantity per";
                        lStructAttached."Value 5" += "Value 5" * "Quantity per";
                        lStructAttached."Value 6" += "Value 6" * "Quantity per";
                        lStructAttached."Value 7" += "Value 7" * "Quantity per";
                        lStructAttached."Value 8" += "Value 8" * "Quantity per";
                        lStructAttached."Value 9" += "Value 9" * "Quantity per";
                        lStructAttached."Value 10" += "Value 10" * "Quantity per";
                    end;
                //CALCUL DU COUT DE LA LIGNE
                lStructAttached."Total Cost (LCY)" += "Total Cost (LCY)";
                lStructAttached."Unit Cost (LCY)" += "Unit Cost (LCY)" * ("Quantity per" + "Quantity Fixed") * lNbRes / lSubstructureQty;
                //CALCUL DES FRAIS GENERAUX
                lStructAttached."Overhead Amount (LCY)" += "Overhead Amount (LCY)";
                //CALCUL DE LA MARGE ETUDE
                lStructAttached."Theoretical Profit Amount(LCY)" += "Theoretical Profit Amount(LCY)";
                //CALCUL DU PRIX DE LA LIGNE
                if (Type = 0) and ("Line Type" = "line type"::Structure) then begin
                    if "Quantity per" <> 0 then
                        lStructAttached."Unit Price" += "Unit Price" * ("Quantity per" + "Quantity Fixed") / lSubstructureQty
                end else begin
                    if Quantity <> 0 then
                        lStructAttached."Unit Price" += "Unit Price" * Quantity / lSubstructureQty
                    else
                        lStructAttached."Unit Price" += "Unit Price" / lSubstructureQty
                end;
                lStructAttached.Modify;
            end;
        end;

    end;


    procedure UpdateSumStructPrice(var pRec: Record "Sales Line")
    var
        lUnitPrice: Decimal;
        xRec: Record "Sales Line";
        lQtyBase: Decimal;
        lQtyPrice: Decimal;
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        lUnitPrecision: Decimal;
    begin
        NavibatSetup.GET2;
        with pRec do begin
            lQtyBase := 1;
            if ("Quantity (Base)" <> 0) then
                lQtyBase := "Quantity (Base)";

            lQtyPrice := 1;
            if ((Quantity + "Optionnal Quantity") <> 0) then
                lQtyPrice := (Quantity + "Optionnal Quantity");
            if NavibatSetup."Specific Struct. Price Calcul" then
                lQtyPrice := lQtyBase / "Qty. per Unit of Measure";
            //#7433
            if not "Fixed Price" and ("Assignment Basis" = "assignment basis"::" ") and ("Found Price" = 0) and
                  //    IF NOT "Fixed Price" AND ("Found Price" = 0) AND
                  //        (("Assignment Basis" = "Assignment Basis"::" ") OR
                  //        (("Assignment Basis" <> "Assignment Basis"::" ") AND ("Line Type" = "Line Type"::Other))) AND
                  //#7433//
                  (NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::"Structure line") then begin
                if "Profit %" = 0 then
                    "Unit Price" :=
                     ("Total Cost (LCY)" + "Overhead Amount (LCY)" + "Job Costs (LCY)" + "Theoretical Profit Amount(LCY)") / lQtyPrice
                else
                    "Unit Price" :=
                     ((("Total Cost (LCY)" + "Overhead Amount (LCY)") / (1 - "Profit %" / 100))
                     + "Job Costs (LCY)") / lQtyPrice;
                //#4956
                if "Unit-Amount Rounding Precision" <> 0 then
                    lUnitPrecision := "Unit-Amount Rounding Precision"
                else
                    //#5923      lUnitPrecision := Currency."Unit-Amount Rounding Precision";
                    //#8666
                    Currency.InitRoundingPrecision;
                //#8666//
                lUnitPrecision := Currency."Sales Unit-Amt Round. Prec.";
                //#5923//
                //#4956

                if (SalesHeader."Currency Code" <> '') and ("Unit Price" <> 0) then
                    "Unit Price" := ROUND(
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        pRec.GetDate,
                        SalesHeader."Currency Code",
                        "Unit Price",
                        SalesHeader."Currency Factor"),
                        lUnitPrecision)
                else
                    "Unit Price" := ROUND("Unit Price", lUnitPrecision);
            end;
            //#4812
            //#7433
            if ("Assignment Basis" <> "assignment basis"::" ") then
                "Unit Price" := 0;
            //#7433//
            //#4812//
            lUnitPrice := "Unit Price";
            //#7583
            //  "Total Cost (LCY)" := "Total Cost (LCY)" / "Qty. per Unit of Measure";
            "Unit Cost (LCY)" := "Total Cost (LCY)" / lQtyBase;
            //  "Unit Cost (LCY)" := "Total Cost (LCY)" / lQtyPrice;
            //#7583//
            if NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::Structure then begin
                Overhead.SalesLine(pRec, false, true);
                //#8190
                pRec.UpdateAmounts();
                //#8190//
            end else begin
                if SalesHeader."Prices Including VAT" and ("VAT %" <> 0) then
                    "Unit Price" := "Unit Price" * (1 + ("VAT %" / 100));
                Validate("Line Discount %");
                if pRec."Unit Price" <> lUnitPrice then begin
                    xRec := pRec;
                    xRec."Unit Price" := lUnitPrice;
                end;
            end;
            if "Quantity (Base)" = 0 then begin
                "Total Cost (LCY)" := 0;
                "Overhead Amount (LCY)" := 0;
                "Theoretical Profit Amount(LCY)" := 0;
            end;
            //#5239
            if "Assignment Basis" <> "assignment basis"::" " then
                "Job Costs Margin Included" := -"Theoretical Profit Amount(LCY)";
            //#5239//

            if "Line No." = "Cross-Ref. Line No." then
                lSalesCrossRefMgt.wUpdateField(pRec, "Unit Price", FieldNo("Unit Price"));
            //#6394
            //#4971
            //  IF NOT NavibatSetup."Specific Struct. Price Calcul" AND ((Quantity + "Optionnal Quantity") * "Quantity (Base)" <> 0) AND
            //     ((Quantity + "Optionnal Quantity") * "Qty. per Unit of Measure" <> "Quantity (Base)") AND  NOT "Fixed Price" THEN  //#5379
            //    VALIDATE("Unit Price","Unit Price" / (Quantity + "Optionnal Quantity") * ("Quantity (Base)" / "Qty. per Unit of Measure"));
            //#4971//
            //#6394//
        end;
    end;


    procedure wInsertStructure(pFromRec: Record "Sales Line"; var pNew: Record "Sales Line"; pDocOcc: Integer; pDocVersion: Integer; pJobNo: Code[20]) return: Integer
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        lOverhead: Codeunit "Overhead Calculation";
        lSalesHeader: Record "Sales Header";
        lSalesHeader2: Record "Sales Header";
        lSalesHeaderArchive: Record "Sales Header Archive";
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lSalesLine3: Record "Sales Line";
        lSalesLineArch: Record "Sales Line Archive";
        lSalesLineTmp: Record "Sales Line" temporary;
        lNavibatSetup: Record NavibatSetup;
        lSubcontOpt: Option;
        lLineNo: Integer;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        lSalesLine := pNew;
        lSalesLine.TestField("Line Type", lSalesLine."line type"::Structure);
        lNavibatSetup.GET2;

        //#6420
        lLineNo := lSalesLine."Line No.";
        //#6420#

        lSalesLineTmp.DeleteAll;
        lSalesLineTmp.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");

        wSalesLineTmp2.DeleteAll;
        if (pDocOcc = 0) and (pDocVersion = 0) then begin
            lSalesLine3.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lSalesLine3.SetRange("Document Type", pFromRec."Document Type");
            lSalesLine3.SetRange("Document No.", pFromRec."Document No.");
            lSalesLine3.SetRange("Structure Line No.", pFromRec."Line No.");
            //#4744
            if not lSalesLine3.IsEmpty then begin
                lSalesLine3.FindSet(true, true);
                //#6115
                lSalesHeader.Get(pFromRec."Document Type", pFromRec."Document No.");
                wFromOwnerRef.GetTable(lSalesHeader);
                lSalesHeader2.Get(lSalesLine."Document Type", lSalesLine."Document No.");
                wToOwnerRef.GetTable(lSalesHeader2);
                if (wBoqMgt.IsEmpty()) then begin
                    wBOQExist := wBoqMgt.Load(wFromOwnerRef.RecordId);
                    if wBOQExist then begin
                        if not wBoqMgt.Load(wToOwnerRef.RecordId) then begin
                            wBoqMgt.Finalize();
                            wBoqMgt.Initialize;
                            wBoqMgt.AddHeader(wToOwnerRef.RecordId);
                            wBoqMgt.Save('');
                        end;
                    end;
                end else begin
                    wBOQExist := true;
                end;
                //#6115//
                StructureMgt.InitSumStructure(lSalesLine);
                repeat
                    //#6240
                    lSalesLine2.Init; // PrimanyKey kept
                    lSalesLine2."Document Type" := lSalesLine."Document Type";
                    lSalesLine2."Document No." := lSalesLine."Document No.";
                    lSalesLine2."Structure Line No." := lSalesLine."Line No.";
                    lSalesLine2."Sell-to Customer No." := lSalesLine."Sell-to Customer No.";
                    lSalesLine2."Line No." := lLineNo;
                    //#6240//
                    //#6115
                    wFromRef.GetTable(lSalesLine3);
                    //6115//
                    lSalesLineTmp.TransferFields(lSalesLine3);
                    wInsertStructureLine(lSalesLine, lSalesLine2, lSalesLine3, pDocOcc, pDocVersion, pJobNo);
                    //#6240
                    lLineNo := lSalesLine2."Line No.";
                //#6240//
                until lSalesLine3.Next = 0;

                if lSalesLine.Option then begin
                    lSalesLine.Option := false;
                    lSalesLine.Quantity := lSalesLine."Optionnal Quantity";
                    lSalesLine.Validate(Option, true);
                end;
                UpdateSumStructPrice(lSalesLine);   //ML
                lSalesLine.Modify;
                pNew := lSalesLine;
                //#4744//
                //#9346
            end else begin
                // Ouvrage sans sous détail
                lSalesLine2."Line No." := lLineNo;
                //#9346//
            end;
        end else begin
            lSalesLineArch.SetCurrentkey("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Presentation Code");
            lSalesLineArch.SetRange("Document Type", lSalesLineArch."document type"::Quote);
            lSalesLineArch.SetRange("Document No.", pFromRec."Document No.");
            lSalesLineArch.SetRange("Doc. No. Occurrence", pDocOcc);
            lSalesLineArch.SetRange("Version No.", pDocVersion);
            lSalesLineArch.SetRange("Structure Line No.", pFromRec."Line No.");
            //#4744
            if not lSalesLineArch.IsEmpty then begin
                //#6115
                lSalesHeaderArchive.Get(pFromRec."Document Type", pFromRec."Document No.", pDocOcc, pDocVersion);
                wFromOwnerRef.GetTable(lSalesHeaderArchive);
                lSalesHeader2.Get(lSalesLine."Document Type", lSalesLine."Document No.");
                wToOwnerRef.GetTable(lSalesHeader2);
                if (wBoqMgt.IsEmpty()) then begin
                    wBOQExist := lBOQMgt.Load(wFromOwnerRef.RecordId);
                    if wBOQExist then begin
                        if not wBoqMgt.Load(wToOwnerRef.RecordId) then begin
                            wBoqMgt.Finalize();
                            wBoqMgt.Initialize;
                            wBoqMgt.AddHeader(wToOwnerRef.RecordId);
                            wBoqMgt.Save('');
                        end;
                    end;
                end else begin
                    wBOQExist := true;
                end;
                //#6115//
                lSalesLineArch.FindSet(true, false);
                StructureMgt.InitSumStructure(lSalesLine);
                repeat
                    //#6115
                    wFromRef.GetTable(lSalesLineArch);
                    //6115//
                    lSalesLineTmp.TransferFields(lSalesLineArch);
                    //#6408
                    lSalesLine2.Init; // PrimanyKey kept
                    lSalesLine2."Document Type" := lSalesLine."Document Type";
                    lSalesLine2."Document No." := lSalesLine."Document No.";
                    lSalesLine2."Structure Line No." := lSalesLine."Line No.";
                    lSalesLine2."Sell-to Customer No." := lSalesLine."Sell-to Customer No.";
                    lSalesLine2."Line No." := lLineNo;
                    //#6408//
                    wInsertStructureLine(lSalesLine, lSalesLine2, lSalesLineTmp, pDocOcc, pDocVersion, pJobNo);
                    //#6408
                    lLineNo := lSalesLine2."Line No.";
                //#6408//

                until lSalesLineArch.Next = 0;
                if lSalesLine.Option then begin
                    lSalesLine.Option := false;
                    lSalesLine.Quantity := lSalesLine."Optionnal Quantity";
                    lSalesLine.Validate(Option, true);
                end;
                UpdateSumStructPrice(lSalesLine);   //ML
                lSalesLine.Modify;
                pNew := lSalesLine;
            end else
                //#7973
                lSalesLine2."Line No." := lLineNo;
            //#7973//
            //#4744//
        end;
        //3143
        return := lSalesLine2."Line No.";
        //3143 MB//
    end;


    procedure wGetProfit(var pProfit: Decimal; pRec: Record "Sales Line"; pActif: Boolean)
    var
        lQuantity: Decimal;
        lDenominator: Decimal;
    begin
        with pRec do begin
            pProfit := 0;
            if not pActif and ("Profit %" = 0) then
                exit;
            //#5064
            lQuantity := Quantity + "Optionnal Quantity";
            //#5064//
            if SalesHeader."No." <> "Document No." then
                SalesHeader.Get("Document Type", "Document No.");
            if "Profit %" <> 0 then
                pProfit := "Profit %"
            else begin
                case "Structure Line No." of
                    //#4675
                    0:
                        begin
                            //#5824
                            lDenominator := CurrExchRate.ExchangeAmtFCYToLCY(SalesHeader."Document Date", SalesHeader."Currency Code", "Line Amount",
                                            SalesHeader."Currency Factor")
                            //#5824//
                        end;
                    //#4675//
                    else //IF ("Unit Price" * Quantity) <> 0 THEN
                        lDenominator := (CurrExchRate.ExchangeAmtFCYToLCY(SalesHeader."Document Date", SalesHeader."Currency Code", "Unit Price",
                                           SalesHeader."Currency Factor") * lQuantity);
                end;
            end;
            if lDenominator <> 0 then
                //#5824
                pProfit := ((lDenominator - "Total Cost (LCY)" - "Overhead Amount (LCY)") / lDenominator) * 100;
            //#5824//
        end;
    end;


    procedure wSetProfit(var pRec: Record "Sales Line"; pProfit: Decimal; pActif: Boolean)
    var
        lSalesOverHead: Record "Sales Overhead-Margin";
        lSalesLine: Record "Sales Line";
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        with pRec do begin
            if not pActif and ("Profit %" = 0) then
                exit;
            "Profit %" := pProfit;
            if ("Profit %" <> 0) then
                Validate("Line Discount %", 0);
            if not (("Line Type" = "line type"::Structure) and ("Structure Line No." = 0)) then begin
                lSalesOverHead.SetRange("Document Type", "Document Type");
                lSalesOverHead.SetRange("Document No.", "Document No.");
                lSalesOverHead.SetRange("Gen. Prod. Post. Code", "Gen. Prod. Posting Group");
                if lSalesOverHead.FindFirst then
                    if pProfit = lSalesOverHead.Margin then
                        "Profit %" := 0;
            end;
            if "Structure Line No." <> 0 then begin
                //#5383
                Validate("Profit %");
                //#5383//
                case "Line Type" of
                    "line type"::Structure:
                        begin
                            NavibatSetup.GET2;
                            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                            lSalesLine.SetRange("Document Type", "Document Type");
                            lSalesLine.SetRange("Document No.", "Document No.");
                            lSalesLine.SetRange("Attached to Line No.", "Line No.");
                            lSalesLine.SetRange("Structure Line No.", "Structure Line No.");
                            lSalesLine.SetFilter("Line Type", '<>%1', "line type"::" ");
                            if not lSalesLine.IsEmpty then begin
                                lSalesLine.Find('-');
                                repeat
                                    wSetProfit(lSalesLine, pProfit, true);
                                    lSalesLine.Modify;
                                until lSalesLine.Next = 0;
                            end;
                        end;
                    else
                        Validate("Quantity per");
                end
            end else begin
                //#4676
                if not Option then
                    Validate(Quantity)
                else begin
                    //#5670
                    Option := false;
                    Validate(Quantity, "Optionnal Quantity");
                    "Optionnal Quantity" := 0;
                    Validate(Option, true);
                    //#5670//
                    Modify;
                end;
                //#4676//
            end;
            //#5232
            if (pRec."Item Reference No." <> '') and not pRec."Fixed Price" then
                lSalesCrossRefMgt.wUpdateField(pRec, "Unit Price", FieldNo("Unit Price"));

            //#5232//
        end;
    end;


    procedure wInsertStructureLine(var pStructure: Record "Sales Line"; var pNew: Record "Sales Line"; pTmpSalesLine: Record "Sales Line"; pDocOcc: Integer; pDocVersion: Integer; pJobNo: Code[20]) Return: Integer
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        lOverhead: Codeunit "Overhead Calculation";
        lNavibatSetup: Record NavibatSetup;
        lSubcontOpt: Option;
        lRollBackLog: Record "RollBack Log";
        lToRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lFatherRef: RecordRef;
        lReplaceRecordID: Boolean;
    begin

        pNew."Line No." += 10000;
        while not pNew.Insert do
            pNew."Line No." += 10;
        pNew."Line Type" := pTmpSalesLine."Line Type";
        //#4724
        pNew."Presentation Code" := pStructure."Presentation Code";
        //#4724//
        pNew.Validate("Line Type");
        pNew.Validate("No.", pTmpSalesLine."No.");
        Clear(pNew."Attached to Line No.");

        if pTmpSalesLine."Attached to Line No." <> 0 then begin
            if wSalesLineTmp2.Get(pTmpSalesLine."Document Type", pTmpSalesLine."Document No.", pTmpSalesLine."Attached to Line No.") then
                pNew."Attached to Line No." := wSalesLineTmp2."Supply Order Line No.";
        end;
        pNew."Job No." := pJobNo;
        pNew.Subcontracting := pTmpSalesLine.Subcontracting;
        //#3905
        if pTmpSalesLine."Supply Order No." <> '' then begin
            pTmpSalesLine."Supply Order No." := '';
            pTmpSalesLine."Supply Order Line No." := 0;
            //#4619
            if pTmpSalesLine.Disable then
                //#4619
                pTmpSalesLine.Validate(Disable, false);
        end;
        //#3905//
        pNew.Disable := pTmpSalesLine.Disable;
        //#5432
        //    pNew.Option := pTmpSalesLine.Option;
        pNew.Option := pStructure.Option;
        //#5432//

        //#5257
        pNew."Shortcut Dimension 1 Code" := pStructure."Shortcut Dimension 1 Code";
        pNew."Shortcut Dimension 2 Code" := pStructure."Shortcut Dimension 2 Code";
        //#5257

        if pTmpSalesLine.Type <> pTmpSalesLine.Type::" " then begin
            if pTmpSalesLine."Variant Code" <> pNew."Variant Code" then
                pNew.Validate("Variant Code", pTmpSalesLine."Variant Code");
            if pTmpSalesLine."Unit of Measure Code" <> pNew."Unit of Measure Code" then
                pNew.Validate("Unit of Measure Code", pTmpSalesLine."Unit of Measure Code");

            pNew."Gen. Prod. Posting Group" := pTmpSalesLine."Gen. Prod. Posting Group";
            pNew."Location Code" := pStructure."Location Code";
            pNew.Validate("Unit Cost (LCY)", pTmpSalesLine."Unit Cost (LCY)");
            pNew.Rate := pTmpSalesLine.Rate;

            if (lNavibatSetup."Profit Calculation Method" = lNavibatSetup."profit calculation method"::"Structure line") then
                pNew.Validate("Unit Price", 0)
            else
                pNew."Unit Price" := pTmpSalesLine."Unit Price";

            pNew."Number of Resources" := pTmpSalesLine."Number of Resources";
            pNew."Quantity Fixed" := pTmpSalesLine."Quantity Fixed";
            pNew."Optionnal Quantity" := pTmpSalesLine."Optionnal Quantity";
            //#5435      pNew."Quantity (Base)" := pTmpSalesLine."Quantity (Base)";
            if pNew.Disable then begin
                pNew.Validate("Disable Quantity", pTmpSalesLine."Disable Quantity");
                pNew."Quantity per" := 0;
                pNew."Quantity per" := pTmpSalesLine."Quantity per";
            end else
                pNew."Quantity per" := pTmpSalesLine."Quantity per";
            pNew."Rate Quantity" := pTmpSalesLine."Rate Quantity";
            pNew.wCalcQuantity(pNew, pStructure.Quantity);
            //#5435
            pNew."Quantity (Base)" := pNew.Quantity * pNew."Qty. per Unit of Measure";
            //#5435//
            pNew."Value 1" := pTmpSalesLine."Value 1";
            pNew."Value 2" := pTmpSalesLine."Value 2";
            pNew."Value 3" := pTmpSalesLine."Value 3";
            pNew."Value 4" := pTmpSalesLine."Value 4";
            pNew."Value 5" := pTmpSalesLine."Value 5";
            pNew."Value 6" := pTmpSalesLine."Value 6";
            pNew."Value 7" := pTmpSalesLine."Value 7";
            pNew."Value 8" := pTmpSalesLine."Value 8";
            pNew."Value 9" := pTmpSalesLine."Value 9";
            pNew."Value 10" := pTmpSalesLine."Value 10";
            pNew."Gross Weight" := pTmpSalesLine."Gross Weight";
            pNew."Net Weight" := pTmpSalesLine."Net Weight";
            pNew."Unit Volume" := pTmpSalesLine."Unit Volume";
            //#6750
            pNew."Profit %" := pTmpSalesLine."Profit %";
            //#6750//

        end else begin
            //#5432
            //    pNew.Option := pTmpSalesLine.Option;
            pNew.Option := pStructure.Option;
            //#5432//
            pNew."Optionnal Quantity" := pTmpSalesLine."Optionnal Quantity";
            pNew."Quantity Fixed" := pTmpSalesLine."Quantity Fixed";
            pNew."Quantity (Base)" := pTmpSalesLine."Quantity (Base)";
            pNew.Disable := pTmpSalesLine.Disable;
            if pNew.Disable then begin
                pNew.Validate("Disable Quantity", pTmpSalesLine."Disable Quantity");
                pNew."Quantity per" := 0;
                pNew."Quantity per" := pTmpSalesLine."Quantity per";
            end else
                pNew."Quantity per" := pTmpSalesLine."Quantity per";
            pNew."Unit of Measure" := '';
            pNew."Unit of Measure Code" := '';
            pNew."Unit Price" := pTmpSalesLine."Unit Price";
            pNew."Unit Cost (LCY)" := pTmpSalesLine."Unit Cost (LCY)";
            pNew."Unit Cost" := pTmpSalesLine."Unit Cost";
            pNew."Total Cost (LCY)" := pTmpSalesLine."Total Cost (LCY)";
            //AC//
        end;
        pNew."Print Structure Line" := pTmpSalesLine."Print Structure Line";
        pNew.Description := pTmpSalesLine.Description;
        pNew.Level := pTmpSalesLine.Level;
        if pNew.Level = 0 then
            pNew.Level := 1;

        if pNew."Line Type" = pNew."line type"::Structure then begin
            pNew.Type := pNew.Type::" ";
            pTmpSalesLine."Supply Order Line No." := pNew."Line No.";
            wSalesLineTmp2 := pTmpSalesLine;
            wSalesLineTmp2.Insert;
        end;
        //#6115
        if wBOQExist then begin
            lToRef.GetTable(pNew);
            lBOQCustMgt.gGetFatherNode(lToRef, lFatherRef);
            if ((pTmpSalesLine."Document Type" = pNew."Document Type") and (pTmpSalesLine."Document No." = pNew."Document No.")) then begin
                lReplaceRecordID := wBoqMgt.fSearchReplaceAttValueFrom(Format(lFatherRef.RecordId), Format(wFromRef.RecordId),
                                                                       Format(lToRef.RecordId), 'Node', 'RecordID');
            end else begin
                lReplaceRecordID := wBoqMgt.fSearchReplaceAttValue(Format(wFromRef.RecordId), Format(lToRef.RecordId), 'Node', 'RecordID');
            end;
            if (not lReplaceRecordID) then begin
                //lBOQCustMgt.gOnInsert(lToRef);
                wBoqMgt.AppendNodeAt(lFatherRef.RecordId, lToRef.RecordId);
                wBoqMgt.CopyBOQFrom(wFromOwnerRef.RecordId, wFromRef.RecordId, wToOwnerRef.RecordId, lToRef.RecordId, false);
            end;
        end;
        //#6115//

        lOverhead.SalesLine(pNew, true, true);
        pNew.Modify;
        //#5153
        if pNew.Type <> pNew.Type::" " then
            //#5153//
            StructureMgt.UpdateSumStructCost(pStructure, pNew)
        //#5153
        else
            StructureMgt.UpdateSubDetailStruct(pNew, pStructure, true);
        //#5153//
        Return := pNew."Line No.";
    end;


    procedure gUpdateStructure(var pxRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        lTotaling: Record "Sales Line";
        lSalesMgt: Codeunit "SalesLine Management";
    begin
        //#5048
        if (not ISSERVICETIER) then
            Commit;
        if pxRec."Structure Line No." <> 0 then begin
            //#5235
            gUpdateAtt(pxRec);
            exit;
            //#5235//
        end else
            lSalesLine := pxRec;
        if (lSalesLine."Line Type" = lSalesLine."line type"::Structure) then begin
            lSalesLine.SuspendStatusCheck(true);
            SumStructureLines(lSalesLine);
            if (lSalesLine."item Reference No." <> '') and
               ((lSalesLine."Cross-Ref. Line No." = 0) or (lSalesLine."Line No." = lSalesLine."Cross-Ref. Line No.")) then
                lSalesCrossRefMgt.wUpdateCrossRefStructure(lSalesLine);
            if lSalesLine."Imported Line" and (lSalesLine."Purchasing Order No." = '') then
                lSalesLine.Validate(Quantity);
            if lSalesLine.Modify then;

            if lSalesLine."Attached to Line No." = 0 then
                exit;
            while lTotaling.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Attached to Line No.") and
                  (lTotaling."Line Type" <> lTotaling."line type"::Totaling) do
                //#7535
                lSalesLine := lTotaling;
            //#7535//
            lSalesMgt.wUpdateTotalLine(lTotaling);
        end;
        //#5048//
    end;


    procedure gUpdateAtt(var pRec: Record "Sales Line")
    var
        lSalesline: Record "Sales Line";
    begin
        with pRec do
            if ("Structure Line No." <> 0) then
                if ("Attached to Line No." <> 0) then
                    if lSalesline.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                        lSalesline.Validate("Quantity per");
                        lSalesline.Modify;
                        if lSalesline."Line Type" = lSalesline."line type"::Structure then
                            gUpdateAtt(lSalesline);
                    end;
    end;


    procedure wSumDiffStructureLine(pRec: Record "Sales Line"; pxRec: Record "Sales Line"; var pOwner: Record "Sales Line")
    var
        lDiffTmp: Record "Sales Line" temporary;
        lNavibatSetup: Record NavibatSetup temporary;
        lQtySetup: Record "Quantity Setup";
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        if ((pRec."Quantity (Base)" - pxRec."Quantity (Base)") = 0)
          and not ((pRec."Line Type" = pRec."line type"::Structure) and (pRec.Type = pRec.Type::" "))
          then
            exit;

        lDiffTmp.Init;
        lDiffTmp."Document Type" := pRec."Document Type";
        lDiffTmp."Document No." := pRec."Document No.";
        lDiffTmp."Line No." := pRec."Line No.";
        lDiffTmp."Structure Line No." := pRec."Structure Line No.";
        lDiffTmp."Attached to Line No." := pRec."Attached to Line No.";

        lDiffTmp."Total Cost (LCY)" += pRec."Total Cost (LCY)" - pxRec."Total Cost (LCY)";
        lDiffTmp."Overhead Amount (LCY)" += pRec."Overhead Amount (LCY)" - pxRec."Overhead Amount (LCY)";
        lDiffTmp."Theoretical Profit Amount(LCY)" += pRec."Theoretical Profit Amount(LCY)" - pxRec."Theoretical Profit Amount(LCY)";
        lDiffTmp."Value 1" += pRec."Value 1" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 2" += pRec."Value 2" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 3" += pRec."Value 3" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 4" += pRec."Value 4" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 5" += pRec."Value 5" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 6" += pRec."Value 6" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 7" += pRec."Value 7" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 8" += pRec."Value 8" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 9" += pRec."Value 9" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Value 10" += pRec."Value 10" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Gross Weight" += pRec."Gross Weight" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Net Weight" += pRec."Net Weight" * (pRec."Quantity per" - pxRec."Quantity per");
        lDiffTmp."Unit Volume" += pRec."Unit Volume" * (pRec."Quantity per" - pxRec."Quantity per");

        if pOwner."Structure Line No." = 0 then begin
            pOwner."Total Cost (LCY)" += lDiffTmp."Total Cost (LCY)";
            pOwner."Overhead Amount (LCY)" += lDiffTmp."Overhead Amount (LCY)";

            lSingleInstance.wGetNaviBatSetup(lNavibatSetup);
            if (lNavibatSetup."Profit Calculation Method" = lNavibatSetup."profit calculation method"::"Structure line") then
                pOwner."Theoretical Profit Amount(LCY)" += lDiffTmp."Theoretical Profit Amount(LCY)";

            if lQtySetup.Get and lQtySetup."Formula desactivated / Sales" then begin
                pOwner."Value 1" += lDiffTmp."Value 1";
                pOwner."Value 2" += lDiffTmp."Value 2";
                pOwner."Value 3" += lDiffTmp."Value 3";
                pOwner."Value 4" += lDiffTmp."Value 4";
                pOwner."Value 5" += lDiffTmp."Value 5";
                pOwner."Value 6" += lDiffTmp."Value 6";
                pOwner."Value 7" += lDiffTmp."Value 7";
                pOwner."Value 8" += lDiffTmp."Value 8";
                pOwner."Value 9" += lDiffTmp."Value 9";
                pOwner."Value 10" += lDiffTmp."Value 10";
            end;

            pOwner."Gross Weight" += lDiffTmp."Gross Weight";
            pOwner."Net Weight" += lDiffTmp."Net Weight";
            pOwner."Unit Volume" += lDiffTmp."Unit Volume";

            UpdateSumStructPrice(pOwner);
            pOwner.Modify;
        end else
            UpdateSubDetailStruct(lDiffTmp, pOwner, false);
    end;


    procedure wSumDiffStructure(pRec: Record "Sales Line"; pxRec: Record "Sales Line")
    var
        lOwner: Record "Sales Line";
        lAttachLine: Integer;
        lOwnerExist: Boolean;
    begin
        if pRec."Structure Line No." = 0 then
            exit;

        if pRec."Attached to Line No." <> 0 then
            lOwnerExist := lOwner.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.");
        while lOwnerExist do begin
            wSumDiffStructureLine(pRec, pxRec, lOwner);
            lAttachLine := lOwner."Attached to Line No.";
            lOwnerExist := lOwner.Get(pRec."Document Type", pRec."Document No.", lAttachLine);
        end;

        lOwnerExist := lOwner.Get(pRec."Document Type", pRec."Document No.", pRec."Structure Line No.");
        if lOwnerExist then
            wSumDiffStructureLine(pRec, pxRec, lOwner)
    end;


    procedure fSetBoqManagement(var pBoqMgt: Codeunit "BOQ Management")
    begin
        //#7202
        wBoqMgt := pBoqMgt;
        //#7202//
    end;


    procedure fResetFreeValue(pRec: Record "Sales Line"; pQtySetup: Record "Quantity Setup"; pValueNumber: Integer) Retour: Boolean
    var
        lRecordRef: RecordRef;
        lTotalise: Boolean;
        lInBOQ: Boolean;
    begin
        //#8280
        Retour := false;
        lRecordRef.GetTable(pRec);
        case (pValueNumber) of
            1:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 1"));
                    lTotalise := pQtySetup."Value 1 Total" and
                                 ((pQtySetup."Used in 1" = pQtySetup."used in 1"::Sales) or
                                 (pQtySetup."Used in 1" = pQtySetup."used in 1"::Both));
                end;
            2:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 2"));
                    lTotalise := pQtySetup."Value 2 Total" and
                                 ((pQtySetup."Used in 2" = pQtySetup."used in 2"::Sales) or
                                 (pQtySetup."Used in 2" = pQtySetup."used in 2"::Both));

                end;
            3:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 3"));
                    lTotalise := pQtySetup."Value 3 Total" and
                                 ((pQtySetup."Used in 3" = pQtySetup."used in 3"::Sales) or
                                 (pQtySetup."Used in 3" = pQtySetup."used in 3"::Both));

                end;
            4:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 4"));
                    lTotalise := pQtySetup."Value 4 Total" and
                                 ((pQtySetup."Used in 4" = pQtySetup."used in 4"::Sales) or
                                 (pQtySetup."Used in 4" = pQtySetup."used in 4"::Both));

                end;
            5:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 5"));
                    lTotalise := pQtySetup."Value 5 Total" and
                                 ((pQtySetup."Used in 5" = pQtySetup."used in 5"::Sales) or
                                 (pQtySetup."Used in 5" = pQtySetup."used in 5"::Both));

                end;
            6:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 6"));
                    lTotalise := pQtySetup."Value 6 Total" and
                                 ((pQtySetup."Used in 6" = pQtySetup."used in 6"::Sales) or
                                 (pQtySetup."Used in 6" = pQtySetup."used in 6"::Both));

                end;
            7:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 7"));
                    lTotalise := pQtySetup."Value 7 Total" and
                                 ((pQtySetup."Used in 7" = pQtySetup."used in 7"::Sales) or
                                 (pQtySetup."Used in 7" = pQtySetup."used in 7"::Both));

                end;
            8:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 8"));
                    lTotalise := pQtySetup."Value 8 Total" and
                                 ((pQtySetup."Used in 8" = pQtySetup."used in 8"::Sales) or
                                 (pQtySetup."Used in 8" = pQtySetup."used in 8"::Both));

                end;
            9:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 9"));
                    lTotalise := pQtySetup."Value 9 Total" and
                                 ((pQtySetup."Used in 9" = pQtySetup."used in 9"::Sales) or
                                 (pQtySetup."Used in 9" = pQtySetup."used in 9"::Both));

                end;
            10:
                begin
                    lInBOQ := wBoqMgt.HasReferenceVariable(lRecordRef.RecordId, pRec.FieldNo("Value 10"));
                    lTotalise := pQtySetup."Value 10 Total" and
                                 ((pQtySetup."Used in 10" = pQtySetup."used in 10"::Sales) or
                                 (pQtySetup."Used in 10" = pQtySetup."used in 10"::Both));

                end;
        end;
        Retour := lTotalise or (not lInBOQ);
        //#8280//
    end;
}

