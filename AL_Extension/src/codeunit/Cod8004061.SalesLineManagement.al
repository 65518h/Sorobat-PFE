Codeunit 8004061 "SalesLine Management"
{
    // //DEVIS GESWAY 01/01/06 Gestion ligne vente
    //             AC 17/11/06 ReFreshTotalLine : mise à jour des lignes de type Lot


    trigger OnRun()
    begin
    end;

    var
        Text8003924: label 'This line is attached to requisition order %1';
        wQtySetup: Record "Quantity Setup";
        tError: label 'Not Implemented';
        wNotRefreshFather: Boolean;


    procedure SupplyOrderMessage(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lText: Text[1024];
    begin
        with Rec do begin
            if (("Supply Order No." = '') and not ("Line Type" in ["line type"::" ", "line type"::Structure]))
              or (Quantity = xRec.Quantity) then
                exit;

            if (CurrFieldNo in [FieldNo(Quantity), FieldNo("Quantity per"), FieldNo("Quantity (Base)")]) then begin
                if "Supply Order No." <> '' then
                    //#7117
                    //MESSAGE(Text8003924,"Supply Order No.")
                    Error(Text8003924, "Supply Order No.")
                //#7117
                else begin
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                    lSalesLine.SetRange("Document Type", "Document Type");
                    lSalesLine.SetRange("Document No.", "Document No.");
                    lSalesLine.SetRange("Structure Line No.", "Line No.");
                    lSalesLine.SetRange(Type, Type::Item);
                    lSalesLine.SetFilter("Supply Order No.", '<>%1', '');
                    if lSalesLine.IsEmpty then
                        exit;
                    lSalesLine.Find('-');
                    repeat
                        if StrPos(lText, lSalesLine."Supply Order No.") = 0 then begin
                            if lText <> '' then
                                lText := lText + '|';
                            lText := lText + lSalesLine."Supply Order No.";
                        end;
                    until lSalesLine.Next = 0;
                    if StrPos(lText, '|') = 0 then
                        Message(Text8003924, lText);
                end;
            end;
        end;
    end;


    procedure wValidateQtyPer(var pRec: Record "Sales Line"; pxRec: Record "Sales Line"; pStructureLine: Record "Sales Line"; pAttachStruct: Record "Sales Line"; pAttachActived: Boolean)
    var
        lStrQty: Decimal;
        lOverheadCalc: Codeunit "Overhead Calculation";
    begin
        with pRec do begin
            lStrQty := 1;
            if pAttachActived then
                lStrQty := (pAttachStruct."Quantity per" + pAttachStruct."Quantity Fixed");
            if lStrQty <> 0 then
                lStrQty := 1;
            wCalcQuantity(pRec, pStructureLine."Quantity (Base)" * lStrQty);
            if ("Rate Quantity" <> 0) and (pxRec."Rate Quantity" <> 0) and (not Disable) then
                if (Rate <> 0) and ("Rate Quantity" <> ROUND(Rate * "Quantity per", 0.00001)) then begin
                    "Rate Quantity" := Rate * ("Quantity per");
                end;
            //#4975
            /*DELETE
                IF (pStructureLine.Quantity)<> 0 THEN
                  VALIDATE(Quantity);
            DELETE*/
            //#4975//
            if (pRec.Quantity <> pxRec.Quantity) then
                InitOutstanding;
            if Option then
                "Quantity (Base)" := ROUND("Optionnal Quantity" * "Qty. per Unit of Measure", 0.00001)
            else
                "Quantity (Base)" := ROUND(Quantity * "Qty. per Unit of Measure", 0.00001);
            //#4975
            lOverheadCalc.SalesLine(pRec, true, true);
            //    VALIDATE("Unit Cost (LCY)");
            //#4975//
        end;

    end;


    procedure wValidateStructQtyPer(var Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        lStructureLine: Record "Sales Line";
        lOwner: Record "Sales Line";
        lxRec: Record "Sales Line";
        lOwnerQty: Decimal;
        lRecQty: Decimal;
        lxRecQty: Decimal;
        lNbRes: Decimal;
        lValidateQty: Boolean;
        lStructureMgt: Codeunit "Structure Management";
        lOverheadCalc: Codeunit "Overhead Calculation";
        lCostTot: Decimal;
        lUnitCost: Decimal;
        lPriceTot: Decimal;
        lOverhead: Decimal;
        lProfit: Decimal;
    begin
        with Rec do begin
            Clear(lStructureLine);
            lStructureLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lStructureLine.SetRange("Document Type", "Document Type");
            lStructureLine.SetRange("Document No.", "Document No.");
            lStructureLine.SetRange("Structure Line No.", "Structure Line No.");
            lStructureLine.SetRange("Attached to Line No.", "Line No.");
            lStructureLine.SetFilter("Line Type", '<>0');
            lStructureLine.Ascending(false);
            if not lStructureLine.IsEmpty then begin
                if Modify then;
                //Gestion de quantité principale
                lOwner.Get("Document Type", "Document No.", "Structure Line No.");
                lOwnerQty := lOwner.Quantity + lOwner."Optionnal Quantity";
                if lOwnerQty = 0 then
                    lOwnerQty := 1;

                lStructureLine.Find('-');
                //Gestion de la quantité en cours de modification
                lRecQty := "Quantity per" + "Quantity Fixed";
                lxRecQty := xRec."Quantity per" + xRec."Quantity Fixed";
                if lxRecQty = 0 then
                    lxRecQty := 1;
                lStructureMgt.UpdateSubDetailStruct(lStructureLine, Rec, true);
                repeat
                    lValidateQty := false;
                    lxRec := lStructureLine;
                    if lRecQty = 0 then begin
                        if (lStructureLine."Optionnal Quantity" = 0) and (lxRecQty <> 0) then begin
                            lStructureLine."Optionnal Quantity" := lStructureLine."Quantity per" / lxRecQty;
                            lStructureLine."Quantity per" := 0; //#7012
                            lValidateQty := true;
                        end;
                    end else begin
                        if (lStructureLine."Optionnal Quantity" <> 0) and (lStructureLine."Quantity per" = 0) then begin
                            lStructureLine."Quantity per" := lStructureLine."Optionnal Quantity";
                            lStructureLine."Optionnal Quantity" := 0;
                            lValidateQty := true;
                        end;
                        if (lxRecQty <> lRecQty) then begin
                            lStructureLine."Quantity per" := (lStructureLine."Quantity per" * lRecQty) / lxRecQty;
                            lValidateQty := true;
                        end;
                    end;
                    if lValidateQty then begin
                        if (lStructureLine."Line Type" = lStructureLine."line type"::Structure) then begin
                            wValidateStructQtyPer(lStructureLine, lxRec);
                            /*
                                      IF (lRecQty <> 0) THEN
                                        lStructureLine.wSetUpdateQty((lStructureLine."Quantity per"* lxRecQty) / lRecQty,
                                                                   lStructureLine."Quantity Fixed")
                                      ELSE
                                        lStructureLine.wSetUpdateQty((lStructureLine."Quantity per"* lxRecQty),
                                                                   lStructureLine."Quantity Fixed");
                                      lStructureLine.VALIDATE("Quantity per");
                            */
                        end else
                            wValidateQtyPer(lStructureLine, lStructureLine, lOwner, Rec, true);
                        lOverheadCalc.SalesLine(lStructureLine, true, true);
                        lStructureLine.Modify;
                    end;
                    lNbRes := 1;
                    if lStructureLine."Line Type" in [lStructureLine."line type"::Person, lStructureLine."line type"::Machine] then
                        lNbRes := lStructureLine."Number of Resources";

                    //CALCUL DU COUT DE LA LIGNE
                    lCostTot += lStructureLine."Total Cost (LCY)";
                    if (lStructureLine."Optionnal Quantity" = 0) then begin
                        if (lStructureLine.Type = lStructureLine.Type::" ") and   //SS-Ouvrage
                           (lStructureLine."Line Type" = lStructureLine."line type"::Structure) then begin
                            lUnitCost += lStructureLine."Unit Cost (LCY)" * (lStructureLine."Quantity per" + lStructureLine."Quantity Fixed");
                        end else                                                  //LE RESTE
                            lUnitCost += lStructureLine."Unit Cost (LCY)" *
                                             (lStructureLine."Quantity per" + lStructureLine."Quantity Fixed") * lNbRes;
                    end else
                        lUnitCost += lStructureLine."Unit Cost (LCY)" *
                           (lStructureLine."Quantity per" + lStructureLine."Quantity Fixed") * lNbRes;
                    //(lStructureLine."Optionnal Quantity" + lStructureLine."Quantity Fixed") * lNbRes;

                    //CALCUL DU PRIX DE LA LIGNE
                    if (lStructureLine.Type = 0) and (lStructureLine."Line Type" = lStructureLine."line type"::Structure) then begin
                        if lStructureLine."Quantity per" <> 0 then
                            lPriceTot += lStructureLine."Unit Price"
                    end else begin
                        if not lStructureLine.Option then
                            lPriceTot += lStructureLine."Unit Price" * lStructureLine.Quantity / lOwnerQty
                        else
                            lPriceTot += lStructureLine."Unit Price" *
                              (lStructureLine."Quantity per" + lStructureLine."Quantity Fixed") * lNbRes;
                    end;
                    //CALCUL DES FRAIS GENERAUX ET MARGE
                    lOverhead += lStructureLine."Overhead Amount (LCY)";
                    lProfit += lStructureLine."Theoretical Profit Amount(LCY)";
                until lStructureLine.Next = 0;
            end;

            //MISE A JOUR DE LA LIGNE DE SS OUVRAGE
            "Total Cost (LCY)" := lCostTot;
            "Overhead Amount (LCY)" := lOverhead;
            "Theoretical Profit Amount(LCY)" := lProfit;

            if ("Quantity per" + "Quantity Fixed") <> 0 then begin
                "Unit Cost (LCY)" := lUnitCost / ("Quantity per" + "Quantity Fixed");
                "Unit Price" := lPriceTot / ("Quantity per" + "Quantity Fixed");
            end else begin
                "Unit Cost (LCY)" := lUnitCost;
                "Unit Price" := lPriceTot;
            end;
            Modify;
        end;

    end;


    procedure UpdateQtyPer(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        lStructureLine: Record "Sales Line";
    begin
        with Rec do begin
            if (CurrFieldNo in [FieldNo(Quantity), FieldNo("Quantity (Base)")]) and ("Structure Line No." <> 0) then begin
                if Quantity = 0 then begin
                    "Quantity per" := 0;
                    "Quantity Fixed" := 0;
                    "Number of Resources" := 0;
                end else
                    if Quantity <= "Quantity Fixed" then begin
                        "Quantity per" := 0;
                        if "Line Type" in ["line type"::Person, "line type"::Machine] then begin
                            if ("Number of Resources" = 0) then
                                "Number of Resources" := 1;
                            "Quantity Fixed" := Quantity / "Number of Resources";
                        end else
                            "Quantity Fixed" := Quantity;
                    end else begin
                        if lStructureLine.Get("Document Type", "Document No.", "Structure Line No.") then
                            if (lStructureLine."Quantity (Base)" <> 0) then begin
                                if not ("Line Type" in ["line type"::Person, "line type"::Machine]) then
                                    "Quantity per" := (Quantity - "Quantity Fixed") / lStructureLine."Quantity (Base)"
                                else begin
                                    if "Number of Resources" = 0 then
                                        "Number of Resources" := 1;
                                    "Quantity per" := (Quantity - "Quantity Fixed" * "Number of Resources")
                                             / (lStructureLine."Quantity (Base)" * "Number of Resources");
                                    if Rate <> 0 then
                                        "Rate Quantity" := "Quantity per" * Rate;
                                end;
                            end;
                    end;
                wInitCalcValue(Rec);
            end;
            if not "Imported Line" and ("Line Type" <> "line type"::" ") then
                TestField("No.");
            if Option and (CurrFieldNo = FieldNo(Quantity)) then begin
                Validate("Optionnal Quantity", Quantity);
                Quantity := 0;
            end;
        end;
    end;


    procedure UpdateStructLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; wStatusCheckSuspended: Boolean)
    var
        lSalesline: Record "Sales Line";
        lPuchLine: Record "Purchase Line";
        lOverhead: Codeunit "Overhead Calculation";
        lStructMgt: Codeunit "Structure Management";
    begin
        with Rec do begin
            lStructMgt.InitSumStructure(Rec);
            lSalesline.Reset;
            lSalesline.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lSalesline.SetRange("Document Type", "Document Type");
            lSalesline.SetRange("Document No.", "Document No.");
            lSalesline.SetRange("Structure Line No.", "Line No.");
            lSalesline.SetRange(Type, Type::" ");
            lSalesline.SetRange("Line Type", "line type"::Structure);
            if not lSalesline.IsEmpty then begin
                lSalesline.ModifyAll("Unit Price", 0);
                lSalesline.ModifyAll("Total Cost (LCY)", 0);
                lSalesline.ModifyAll("Unit Cost (LCY)", 0);
                lSalesline.ModifyAll("Overhead Amount (LCY)", 0);
                lSalesline.ModifyAll("Theoretical Profit Amount(LCY)", 0);
            end;
            lSalesline.SetFilter("Line Type", '<>0');
            lSalesline.SetRange(Type);
            lSalesline.Ascending(false);
            if not lSalesline.IsEmpty then begin
                lSalesline.Find('-');
                repeat
                    if (lSalesline.Type <> lSalesline.Type::" ") then begin
                        lSalesline.SuspendStatusCheck(wStatusCheckSuspended and
                           (not "Fixed Price" or ("Found Price" = 0)) and ("Structure Line No." = 0));
                        wCalcQuantity(lSalesline, "Quantity (Base)");
                        if Option then
                            lSalesline."Quantity (Base)" :=
                              ROUND(lSalesline."Optionnal Quantity" * lSalesline."Qty. per Unit of Measure", 0.00001)
                        else
                            lSalesline."Quantity (Base)" :=
                              ROUND(lSalesline.Quantity * lSalesline."Qty. per Unit of Measure", 0.00001);

                        //#4975        lSalesline.VALIDATE(Quantity);
                        lSalesline.InitOutstanding;
                        //#4975        lSalesline.VALIDATE("Unit Cost (LCY)");
                        lOverhead.SalesLine(lSalesline, true, true);
                        lSalesline.Modify;
                        lStructMgt.UpdateSumStructCost(Rec, lSalesline);
                    end else
                        lStructMgt.UpdateSubDetailStruct(lSalesline, Rec, false);
                until lSalesline.Next = 0;
            end;
            lStructMgt.UpdateSumStructPrice(Rec);
        end;
    end;


    procedure wInitCalcValue(var pRec: Record "Sales Line")
    begin
        with pRec do begin
            if ("Value 1" <> 0) or ("Value 2" <> 0) or ("Value 3" <> 0) or ("Value 4" <> 0) or ("Value 5" <> 0) or
               ("Value 6" <> 0) or ("Value 7" <> 0) or ("Value 8" <> 0) or ("Value 9" <> 0) or ("Value 10" <> 0) then begin
                //(fiche 3759)    ERROR(Text8003918);
                if not wQtySetup.Get then
                    wQtySetup.Init;
                if (wQtySetup."Value Formula" <> '') and not wQtySetup."Formula desactivated / Sales" then begin
                    "Value 1" := 0;
                    "Value 2" := 0;
                    "Value 3" := 0;
                    "Value 4" := 0;
                    "Value 5" := 0;
                    "Value 6" := 0;
                    "Value 7" := 0;
                    "Value 8" := 0;
                    "Value 9" := 0;
                    "Value 10" := 0;
                end;
            end;
        end;
    end;


    procedure wSetCustTax(var Rec: Record "Sales Line")
    var
        lCust: Record Customer;
    begin
        with Rec do begin
            if lCust."No." <> "Bill-to Customer No." then
                lCust.Get("Bill-to Customer No.");
        end;
    end;


    procedure wUpdateTotalLine(var SalesLineTot: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesLineBis: Record "Sales Line";
        lAmount: Decimal;
        lAmountIncludVAT: Decimal;
        lUnitPrice: Decimal;
        lUnitCost: Decimal;
        lLineAmount: Decimal;
        lTotalCost: Decimal;
        lOverheadAmount: Decimal;
        lAmountExclVAT: Decimal;
        lTheoProfitAmount: Decimal;
        lTheoJobCostProfit: Decimal;
        lJobCosts: Decimal;
        lTerminer: Boolean;
        lNaviBatSetup: Record NavibatSetup;
        lSingleinstance: Codeunit "Import SingleInstance2";
        lSalesHeader: Record "Sales Header";
        lVar: array[13] of Decimal;
        lLineDiscountAmount: Decimal;
        lInvDiscountAmount: Decimal;
    begin
        //RQ : Surtout ne pas alimenter Amount et "Amount Including VAT" sinon 'CONSISTENT' lors de la validation comptable
        //#4797
        //IF SalesLineTot."Order Type" = SalesLineTot."Order Type"::"Supply Order" THEN
        lSingleinstance.wGetNaviBatSetup(lNaviBatSetup);
        lSingleinstance.wGetSalesHeader(lSalesHeader, SalesLineTot."Document Type", SalesLineTot."Document No.");
        if (SalesLineTot."Order Type" = SalesLineTot."order type"::"Supply Order") or
           ((SalesLineTot."Document Type" = SalesLineTot."document type"::Quote) and
           (lNaviBatSetup."Disable update totaling") and
           (lSalesHeader.Status = lSalesHeader.Status::Released)) then
            //#4797//
            exit;

        //Initialisation des valeurs de départ xRec
        lAmount := SalesLineTot.Amount;
        lAmountIncludVAT := SalesLineTot."Amount Including VAT";
        lLineAmount := SalesLineTot."Line Amount";
        lTotalCost := SalesLineTot."Total Cost (LCY)";
        lOverheadAmount := SalesLineTot."Overhead Amount (LCY)";
        lAmountExclVAT := SalesLineTot."Amount Excl. VAT (LCY)";
        lTheoProfitAmount := SalesLineTot."Theoretical Profit Amount(LCY)";
        //#5239
        lTheoJobCostProfit := SalesLineTot."Job Costs Margin Included";
        //#5239//
        lJobCosts := SalesLineTot."Job Costs (LCY)";
        //#5922
        lLineDiscountAmount := SalesLineTot."Line Discount Amount";
        //#5922//
        //+ONE+
        lInvDiscountAmount := SalesLineTot."Inv. Discount Amount";
        //+ONE+//
        //#4946
        lVar[1] := SalesLineTot."Gross Weight";
        lVar[2] := SalesLineTot."Net Weight";
        lVar[3] := SalesLineTot."Unit Volume";
        lVar[4] := SalesLineTot."Value 1";
        lVar[5] := SalesLineTot."Value 2";
        lVar[6] := SalesLineTot."Value 3";
        lVar[7] := SalesLineTot."Value 4";
        lVar[8] := SalesLineTot."Value 5";
        lVar[9] := SalesLineTot."Value 6";
        lVar[10] := SalesLineTot."Value 7";
        lVar[11] := SalesLineTot."Value 8";
        lVar[12] := SalesLineTot."Value 9";
        lVar[13] := SalesLineTot."Value 10";
        //#4946//

        //Initialisation des totaux
        if SalesLineTot."Line Type" = SalesLineTot."line type"::Totaling then begin
            SalesLineTot.Amount := 0;
            SalesLineTot."Amount Including VAT" := 0;
            SalesLineTot."Line Amount" := 0;
            SalesLineTot."Total Cost (LCY)" := 0;
            SalesLineTot."Overhead Amount (LCY)" := 0;
            SalesLineTot."Amount Excl. VAT (LCY)" := 0;
            SalesLineTot."Theoretical Profit Amount(LCY)" := 0;
            //#5239
            SalesLineTot."Job Costs Margin Included" := 0;
            //#5239
            SalesLineTot."Job Costs (LCY)" := 0;
            //#5922
            SalesLineTot."Line Discount Amount" := 0;
            SalesLineTot."Inv. Discount Amount" := 0;
            //#5922//
            //#4946
            SalesLineTot."Gross Weight" := 0;
            SalesLineTot."Net Weight" := 0;
            SalesLineTot."Unit Volume" := 0;
            SalesLineTot."Value 1" := 0;
            SalesLineTot."Value 2" := 0;
            SalesLineTot."Value 3" := 0;
            SalesLineTot."Value 4" := 0;
            SalesLineTot."Value 5" := 0;
            SalesLineTot."Value 6" := 0;
            SalesLineTot."Value 7" := 0;
            SalesLineTot."Value 8" := 0;
            SalesLineTot."Value 9" := 0;
            SalesLineTot."Value 10" := 0;
            //#4946//

            lSalesLine.Reset;
            //+PERF+  lSalesLine.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code");
            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
            //+PERF+//
            lSalesLine.SetRange("Document Type", SalesLineTot."Document Type");
            lSalesLine.SetRange("Document No.", SalesLineTot."Document No.");
            lSalesLine.SetRange("Attached to Line No.", SalesLineTot."Line No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Order Type", SalesLineTot."Order Type");
            //  lSalesLine.SETFILTER("Presentation Code",'%1',SalesLineTot."Presentation Code" + '*');
            lSalesLine.SetRange(Option, false);
            if not lSalesLine.IsEmpty then
                lSalesLine.Find('-');
            repeat
                if ((lSalesLine.Quantity <> 0) or (lSalesLine."Line Type" = lSalesLine."line type"::Totaling)) and
                   not SalesLineTot.Option then begin
                    SalesLineTot."Line Amount" += lSalesLine."Line Amount";
                    SalesLineTot."Total Cost (LCY)" += lSalesLine."Total Cost (LCY)";
                    SalesLineTot."Overhead Amount (LCY)" += lSalesLine."Overhead Amount (LCY)";
                    SalesLineTot."Theoretical Profit Amount(LCY)" += lSalesLine."Theoretical Profit Amount(LCY)";
                    //#5239
                    SalesLineTot."Job Costs Margin Included" += lSalesLine."Job Costs Margin Included";
                    //#5239
                    SalesLineTot."Amount Excl. VAT (LCY)" += lSalesLine."Amount Excl. VAT (LCY)";
                    SalesLineTot."Job Costs (LCY)" += lSalesLine."Job Costs (LCY)";
                    //#5922
                    SalesLineTot."Line Discount Amount" += lSalesLine."Line Discount Amount";
                    //#5922//
                    //+ONE+
                    SalesLineTot."Inv. Discount Amount" += lSalesLine."Inv. Discount Amount";
                    //+ONE+//
                    //#4946
                    if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then
                        lSalesLine."Quantity (Base)" := 1;
                    SalesLineTot."Gross Weight" += lSalesLine."Gross Weight" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Net Weight" += lSalesLine."Net Weight" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Unit Volume" += lSalesLine."Unit Volume" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 1" += lSalesLine."Value 1" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 2" += lSalesLine."Value 2" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 3" += lSalesLine."Value 3" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 4" += lSalesLine."Value 4" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 5" += lSalesLine."Value 5" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 6" += lSalesLine."Value 6" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 7" += lSalesLine."Value 7" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 8" += lSalesLine."Value 8" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 9" += lSalesLine."Value 9" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Value 10" += lSalesLine."Value 10" * lSalesLine."Quantity (Base)";
                    //#4946//
                end;
            until lSalesLine.Next = 0;

            SalesLineTot.Modify;
            //#4946
            if lSalesLine."Gross Weight" <> 0 then
                SalesLineTot.Validate("Gross Weight");
            if lSalesLine."Net Weight" <> 0 then
                SalesLineTot.Validate("Net Weight");
            if lSalesLine."Unit Volume" <> 0 then
                SalesLineTot.Validate("Unit Volume");
            if not wQtySetup.Get then
                wQtySetup.Init;
            if (lSalesLine."Value 1" <> 0) and (wQtySetup."Value 1 Total") then
                SalesLineTot.Validate("Value 1");
            if (lSalesLine."Value 2" <> 0) and (wQtySetup."Value 2 Total") then
                SalesLineTot.Validate("Value 2");
            if (lSalesLine."Value 3" <> 0) and (wQtySetup."Value 3 Total") then
                SalesLineTot.Validate("Value 3");
            if (lSalesLine."Value 4" <> 0) and (wQtySetup."Value 4 Total") then
                SalesLineTot.Validate("Value 4");
            if (lSalesLine."Value 5" <> 0) and (wQtySetup."Value 5 Total") then
                SalesLineTot.Validate("Value 5");
            if (lSalesLine."Value 6" <> 0) and (wQtySetup."Value 6 Total") then
                SalesLineTot.Validate("Value 6");
            if (lSalesLine."Value 7" <> 0) and (wQtySetup."Value 7 Total") then
                SalesLineTot.Validate("Value 7");
            if (lSalesLine."Value 8" <> 0) and (wQtySetup."Value 8 Total") then
                SalesLineTot.Validate("Value 8");
            if (lSalesLine."Value 9" <> 0) and (wQtySetup."Value 9 Total") then
                SalesLineTot.Validate("Value 9");
            if (lSalesLine."Value 10" <> 0) and (wQtySetup."Value 10 Total") then
                SalesLineTot.Validate("Value 10");
            //#4946//

            lAmount := SalesLineTot.Amount - lAmount;
            lAmountIncludVAT := SalesLineTot."Amount Including VAT" - lAmountIncludVAT;
            lLineAmount := SalesLineTot."Line Amount" - lLineAmount;
            lTotalCost := SalesLineTot."Total Cost (LCY)" - lTotalCost;
            lOverheadAmount := SalesLineTot."Overhead Amount (LCY)" - lOverheadAmount;
            lAmountExclVAT := SalesLineTot."Amount Excl. VAT (LCY)" - lAmountExclVAT;
            lTheoProfitAmount := SalesLineTot."Theoretical Profit Amount(LCY)" - lTheoProfitAmount;
            //#5239
            lTheoJobCostProfit := SalesLineTot."Job Costs Margin Included" - lTheoJobCostProfit;
            //#5239
            lJobCosts := SalesLineTot."Job Costs (LCY)" - lJobCosts;
            //#5922
            lLineDiscountAmount := SalesLineTot."Line Discount Amount" - lLineDiscountAmount;
            //#5922//
            //#4946
            lVar[1] := SalesLineTot."Gross Weight" - lVar[1];
            lVar[2] := SalesLineTot."Net Weight" - lVar[2];
            lVar[3] := SalesLineTot."Unit Volume" - lVar[3];
            lVar[4] := SalesLineTot."Value 1" - lVar[4];
            lVar[5] := SalesLineTot."Value 2" - lVar[5];
            lVar[6] := SalesLineTot."Value 3" - lVar[6];
            lVar[7] := SalesLineTot."Value 4" - lVar[7];
            lVar[8] := SalesLineTot."Value 5" - lVar[8];
            lVar[9] := SalesLineTot."Value 6" - lVar[9];
            lVar[10] := SalesLineTot."Value 7" - lVar[10];
            lVar[11] := SalesLineTot."Value 8" - lVar[11];
            lVar[12] := SalesLineTot."Value 9" - lVar[12];
            lVar[13] := SalesLineTot."Value 10" - lVar[13];
            //#4946//

            if SalesLineTot.Level > 1 then begin
                lSalesLineBis.Reset;
                lTerminer := not lSalesLineBis.Get(SalesLineTot."Document Type", SalesLineTot."Document No.",
                                                   SalesLineTot."Attached to Line No.");
                while not lTerminer do begin
                    if lSalesLineBis."Line Type" = lSalesLineBis."line type"::Totaling then begin
                        if (lSalesLineBis."Line Amount" = 0) and (lSalesLineBis."Total Cost (LCY)" = 0) then begin
                            lSalesLineBis.Amount := SalesLineTot.Amount;
                            lSalesLineBis."Amount Including VAT" := SalesLineTot."Amount Including VAT";
                            lSalesLineBis."Line Amount" := SalesLineTot."Line Amount";
                            lSalesLineBis."Total Cost (LCY)" := SalesLineTot."Total Cost (LCY)";
                            lSalesLineBis."Overhead Amount (LCY)" := SalesLineTot."Overhead Amount (LCY)";
                            lSalesLineBis."Amount Excl. VAT (LCY)" := SalesLineTot."Amount Excl. VAT (LCY)";
                            lSalesLineBis."Theoretical Profit Amount(LCY)" := SalesLineTot."Theoretical Profit Amount(LCY)";
                            //#5239
                            lSalesLineBis."Job Costs Margin Included" := SalesLineTot."Job Costs Margin Included";
                            //#5239
                            lSalesLineBis."Job Costs (LCY)" := SalesLineTot."Job Costs (LCY)";
                            //#5922
                            lSalesLineBis."Line Discount Amount" := SalesLineTot."Line Discount Amount";
                            //#5922//
                            //+ONE+
                            lSalesLineBis."Inv. Discount Amount" := SalesLineTot."Inv. Discount Amount";
                            //+ONE+//
                            //#4946
                            lSalesLineBis."Gross Weight" := SalesLineTot."Gross Weight" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Net Weight" := SalesLineTot."Net Weight" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Unit Volume" := SalesLineTot."Unit Volume" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 1" := SalesLineTot."Value 1" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 2" := SalesLineTot."Value 2" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 3" := SalesLineTot."Value 3" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 4" := SalesLineTot."Value 4" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 5" := SalesLineTot."Value 5" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 6" := SalesLineTot."Value 6" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 7" := SalesLineTot."Value 7" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 8" := SalesLineTot."Value 8" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 9" := SalesLineTot."Value 9" * SalesLineTot."Quantity (Base)";
                            lSalesLineBis."Value 10" := SalesLineTot."Value 10" * SalesLineTot."Quantity (Base)";
                            //#4946//
                        end else begin
                            lSalesLineBis.Amount += lAmount;
                            lSalesLineBis."Amount Including VAT" += lAmountIncludVAT;
                            lSalesLineBis."Line Amount" += lLineAmount;
                            lSalesLineBis."Total Cost (LCY)" += lTotalCost;
                            lSalesLineBis."Overhead Amount (LCY)" += lOverheadAmount;
                            lSalesLineBis."Amount Excl. VAT (LCY)" += lAmountExclVAT;
                            lSalesLineBis."Theoretical Profit Amount(LCY)" += lTheoProfitAmount;
                            //#5239
                            lSalesLineBis."Job Costs Margin Included" += lTheoJobCostProfit;
                            //#5239
                            lSalesLineBis."Job Costs (LCY)" += lJobCosts;
                            //#5922
                            lSalesLineBis."Line Discount Amount" += lLineDiscountAmount;
                            //#5922//
                            //+ONE+
                            lSalesLineBis."Inv. Discount Amount" += lInvDiscountAmount;
                            //+ONE+//

                            //#4946
                            lSalesLineBis."Gross Weight" += lVar[1];
                            lSalesLineBis."Net Weight" += lVar[2];
                            lSalesLineBis."Unit Volume" += lVar[3];
                            lSalesLineBis."Value 1" += lVar[4];
                            lSalesLineBis."Value 2" += lVar[5];
                            lSalesLineBis."Value 3" += lVar[6];
                            lSalesLineBis."Value 4" += lVar[7];
                            lSalesLineBis."Value 5" += lVar[8];
                            lSalesLineBis."Value 6" += lVar[9];
                            lSalesLineBis."Value 7" += lVar[10];
                            lSalesLineBis."Value 8" += lVar[11];
                            lSalesLineBis."Value 9" += lVar[12];
                            lSalesLineBis."Value 10" += lVar[13];
                            //#4946//
                        end;
                        lSalesLineBis.Modify;
                        //#4946
                        if lVar[1] <> 0 then
                            lSalesLineBis.Validate("Gross Weight");
                        if lVar[2] <> 0 then
                            lSalesLineBis.Validate("Net Weight");
                        if lVar[3] <> 0 then
                            lSalesLineBis.Validate("Unit Volume");
                        if lVar[4] <> 0 then
                            lSalesLineBis.Validate("Value 1");
                        if lVar[5] <> 0 then
                            lSalesLineBis.Validate("Value 2");
                        if lVar[6] <> 0 then
                            lSalesLineBis.Validate("Value 3");
                        if lVar[7] <> 0 then
                            lSalesLineBis.Validate("Value 4");
                        if lVar[8] <> 0 then
                            lSalesLineBis.Validate("Value 5");
                        if lVar[9] <> 0 then
                            lSalesLineBis.Validate("Value 6");
                        if lVar[10] <> 0 then
                            lSalesLineBis.Validate("Value 7");
                        if lVar[11] <> 0 then
                            lSalesLineBis.Validate("Value 8");
                        if lVar[12] <> 0 then
                            lSalesLineBis.Validate("Value 9");
                        if lVar[13] <> 0 then
                            lSalesLineBis.Validate("Value 10");
                        //#4946//
                    end;
                    lTerminer := (lSalesLineBis."Attached to Line No." = 0);
                    lTerminer := not lSalesLineBis.Get(lSalesLineBis."Document Type", lSalesLineBis."Document No.",
                                                  lSalesLineBis."Attached to Line No.") and lTerminer;
                end;
            end;
        end;
    end;


    procedure wUpdateTotalLine2(var SalesLineTot: Record "Sales Line"; Rec: Record "Sales Line"; xRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesLineBis: Record "Sales Line";
        lAmount: Decimal;
        lAmountIncludVAT: Decimal;
        lUnitPrice: Decimal;
        lUnitCost: Decimal;
        lLineAmount: Decimal;
        lTotalCost: Decimal;
        lOverheadAmount: Decimal;
        lAmountExclVAT: Decimal;
        lTheoProfitAmount: Decimal;
        lTheoJobCostProfit: Decimal;
        lJobCosts: Decimal;
        lTerminer: Boolean;
        lNaviBatSetup: Record NavibatSetup;
        lSingleinstance: Codeunit "Import SingleInstance2";
        lSalesHeader: Record "Sales Header";
        lVar: array[13] of Decimal;
        lOK: Boolean;
        i: Integer;
        lLineDiscountAmount: Decimal;
        lInvDiscountAmount: Decimal;
    begin
        //RQ : Surtout ne pas alimenter Amount et "Amount Including VAT" sinon 'CONSISTENT' lors de la validation comptable
        //#4797
        //IF SalesLineTot."Order Type" = SalesLineTot."Order Type"::"Supply Order" THEN
        lSingleinstance.wGetNaviBatSetup(lNaviBatSetup);
        lSingleinstance.wGetSalesHeader(lSalesHeader, SalesLineTot."Document Type", SalesLineTot."Document No.");
        if (SalesLineTot."Order Type" = SalesLineTot."order type"::"Supply Order") or
           ((SalesLineTot."Document Type" = SalesLineTot."document type"::Quote) and
           (lNaviBatSetup."Disable update totaling") and
           (lSalesHeader.Status = lSalesHeader.Status::Released)) then
            //#4797//
            exit;

        lAmount := Rec.Amount - xRec.Amount;
        lAmountIncludVAT := Rec."Amount Including VAT" - xRec."Amount Including VAT";
        lLineAmount := Rec."Line Amount" - xRec."Line Amount";
        lTotalCost := Rec."Total Cost (LCY)" - xRec."Total Cost (LCY)";
        lOverheadAmount := Rec."Overhead Amount (LCY)" - xRec."Overhead Amount (LCY)";
        lAmountExclVAT := Rec."Amount Excl. VAT (LCY)" - xRec."Amount Excl. VAT (LCY)";
        lTheoProfitAmount := Rec."Theoretical Profit Amount(LCY)" - xRec."Theoretical Profit Amount(LCY)";
        //#5239
        lTheoJobCostProfit := Rec."Job Costs Margin Included" - xRec."Job Costs Margin Included";
        //#5239
        lJobCosts := Rec."Job Costs (LCY)" - xRec."Job Costs (LCY)";
        //#5922
        lLineDiscountAmount := Rec."Line Discount Amount" - xRec."Line Discount Amount";
        //#5922//
        //+ONE+
        lInvDiscountAmount := Rec."Inv. Discount Amount" - xRec."Inv. Discount Amount";
        //+ONE+//

        //#4946

        lVar[1] := (Rec."Gross Weight" * Rec."Quantity (Base)") - (xRec."Gross Weight" * xRec."Quantity (Base)");
        lVar[2] := (Rec."Net Weight" * Rec."Quantity (Base)") - (xRec."Net Weight" * xRec."Quantity (Base)");
        lVar[3] := (Rec."Unit Volume" * Rec."Quantity (Base)") - (xRec."Unit Volume" * xRec."Quantity (Base)");
        lVar[4] := (Rec."Value 1" * Rec."Quantity (Base)") - (xRec."Value 1" * xRec."Quantity (Base)");
        lVar[5] := (Rec."Value 2" * Rec."Quantity (Base)") - (xRec."Value 2" * xRec."Quantity (Base)");
        lVar[6] := (Rec."Value 3" * Rec."Quantity (Base)") - (xRec."Value 3" * xRec."Quantity (Base)");
        lVar[7] := (Rec."Value 4" * Rec."Quantity (Base)") - (xRec."Value 4" * xRec."Quantity (Base)");
        lVar[8] := (Rec."Value 5" * Rec."Quantity (Base)") - (xRec."Value 5" * xRec."Quantity (Base)");
        lVar[9] := (Rec."Value 6" * Rec."Quantity (Base)") - (xRec."Value 6" * xRec."Quantity (Base)");
        lVar[10] := (Rec."Value 7" * Rec."Quantity (Base)") - (xRec."Value 7" * xRec."Quantity (Base)");
        lVar[11] := (Rec."Value 8" * Rec."Quantity (Base)") - (xRec."Value 8" * xRec."Quantity (Base)");
        lVar[12] := (Rec."Value 9" * Rec."Quantity (Base)") - (xRec."Value 9" * xRec."Quantity (Base)");
        lVar[13] := (Rec."Value 10" * Rec."Quantity (Base)") - (xRec."Value 10" * xRec."Quantity (Base)");

        //#4946//
        i := 0;
        lOK := false;
        while (not lOK) and (i < 13) do begin
            i += 1;
            lOK := lVar[i] <> 0;
        end;

        if (lLineAmount = 0) and (lTotalCost = 0) and (lTheoProfitAmount = 0) and not lOK then
            exit;

        //Initialisation des totaux
        if SalesLineTot."Line Type" = SalesLineTot."line type"::Totaling then begin
            SalesLineTot.Amount += (Rec.Amount - xRec.Amount);
            SalesLineTot."Line Amount" += (Rec."Line Amount" - xRec."Line Amount");
            SalesLineTot."Total Cost (LCY)" += (Rec."Total Cost (LCY)" - xRec."Total Cost (LCY)");
            SalesLineTot."Overhead Amount (LCY)" += (Rec."Overhead Amount (LCY)" - xRec."Overhead Amount (LCY)");
            SalesLineTot."Theoretical Profit Amount(LCY)" +=
                                                    (Rec."Theoretical Profit Amount(LCY)" - xRec."Theoretical Profit Amount(LCY)");
            //#5239
            SalesLineTot."Job Costs Margin Included" +=
                                           (Rec."Job Costs Margin Included" - xRec."Job Costs Margin Included");
            //#5239
            SalesLineTot."Amount Excl. VAT (LCY)" += (Rec."Amount Excl. VAT (LCY)" - xRec."Amount Excl. VAT (LCY)");
            SalesLineTot."Job Costs (LCY)" += (Rec."Job Costs (LCY)" - xRec."Job Costs (LCY)");
            //#5922
            SalesLineTot."Line Discount Amount" += (Rec."Line Discount Amount" - xRec."Line Discount Amount");
            //#5922//
            //+ONE+
            SalesLineTot."Inv. Discount Amount" += Rec."Inv. Discount Amount" - xRec."Inv. Discount Amount";
            //+ONE+//

            //#4946
            SalesLineTot."Gross Weight" += (Rec."Gross Weight" * Rec."Quantity (Base)")
                                          - (xRec."Gross Weight" * xRec."Quantity (Base)");
            SalesLineTot."Net Weight" += (Rec."Net Weight" * Rec."Quantity (Base)") - (xRec."Net Weight" * xRec."Quantity (Base)");
            SalesLineTot."Unit Volume" += (Rec."Unit Volume" * Rec."Quantity (Base)") - (xRec."Unit Volume" * xRec."Quantity (Base)");
            SalesLineTot."Value 1" += (Rec."Value 1" * Rec."Quantity (Base)") - (xRec."Value 1" * xRec."Quantity (Base)");
            SalesLineTot."Value 2" += (Rec."Value 2" * Rec."Quantity (Base)") - (xRec."Value 2" * xRec."Quantity (Base)");
            SalesLineTot."Value 3" += (Rec."Value 3" * Rec."Quantity (Base)") - (xRec."Value 3" * xRec."Quantity (Base)");
            SalesLineTot."Value 4" += (Rec."Value 4" * Rec."Quantity (Base)") - (xRec."Value 4" * xRec."Quantity (Base)");
            SalesLineTot."Value 5" += (Rec."Value 5" * Rec."Quantity (Base)") - (xRec."Value 5" * xRec."Quantity (Base)");
            SalesLineTot."Value 6" += (Rec."Value 6" * Rec."Quantity (Base)") - (xRec."Value 6" * xRec."Quantity (Base)");
            SalesLineTot."Value 7" += (Rec."Value 7" * Rec."Quantity (Base)") - (xRec."Value 7" * xRec."Quantity (Base)");
            SalesLineTot."Value 8" += (Rec."Value 8" * Rec."Quantity (Base)") - (xRec."Value 8" * xRec."Quantity (Base)");
            SalesLineTot."Value 9" += (Rec."Value 9" * Rec."Quantity (Base)") - (xRec."Value 9" * xRec."Quantity (Base)");
            SalesLineTot."Value 10" += (Rec."Value 10" * Rec."Quantity (Base)") - (xRec."Value 10" * xRec."Quantity (Base)");
            //#4946//
        end;

        SalesLineTot.Modify;
        //#4946
        if Rec."Gross Weight" <> xRec."Gross Weight" then
            SalesLineTot.Validate("Gross Weight");
        if Rec."Net Weight" <> xRec."Net Weight" then
            SalesLineTot.Validate("Net Weight");
        if Rec."Unit Volume" <> xRec."Unit Volume" then
            SalesLineTot.Validate("Unit Volume");
        if Rec."Value 1" <> xRec."Value 1" then
            SalesLineTot.Validate("Value 1");
        if Rec."Value 2" <> xRec."Value 2" then
            SalesLineTot.Validate("Value 2");
        if Rec."Value 3" <> xRec."Value 3" then
            SalesLineTot.Validate("Value 3");
        if Rec."Value 4" <> xRec."Value 4" then
            SalesLineTot.Validate("Value 4");
        if Rec."Value 5" <> xRec."Value 5" then
            SalesLineTot.Validate("Value 5");
        if Rec."Value 6" <> xRec."Value 6" then
            SalesLineTot.Validate("Value 6");
        if Rec."Value 7" <> xRec."Value 7" then
            SalesLineTot.Validate("Value 7");
        if Rec."Value 8" <> xRec."Value 8" then
            SalesLineTot.Validate("Value 8");
        if Rec."Value 9" <> xRec."Value 9" then
            SalesLineTot.Validate("Value 9");
        if Rec."Value 10" <> xRec."Value 10" then
            SalesLineTot.Validate("Value 10");
        //#4946//

        if (SalesLineTot.Level > 1) and not wNotRefreshFather then begin
            lSalesLineBis.Reset;
            lTerminer := not lSalesLineBis.Get(SalesLineTot."Document Type", SalesLineTot."Document No.",
                                               SalesLineTot."Attached to Line No.");
            while not lTerminer do begin

                if lSalesLineBis."Line Type" = lSalesLineBis."line type"::Totaling then begin
                    if (lSalesLineBis."Line Amount" = 0) and (lSalesLineBis."Total Cost (LCY)" = 0) then begin
                        lSalesLineBis.Amount := SalesLineTot.Amount;
                        lSalesLineBis."Amount Including VAT" := SalesLineTot."Amount Including VAT";
                        lSalesLineBis."Line Amount" := SalesLineTot."Line Amount";
                        lSalesLineBis."Total Cost (LCY)" := SalesLineTot."Total Cost (LCY)";
                        lSalesLineBis."Overhead Amount (LCY)" := SalesLineTot."Overhead Amount (LCY)";
                        lSalesLineBis."Amount Excl. VAT (LCY)" := SalesLineTot."Amount Excl. VAT (LCY)";
                        lSalesLineBis."Theoretical Profit Amount(LCY)" := SalesLineTot."Theoretical Profit Amount(LCY)";
                        //#5239
                        lSalesLineBis."Job Costs Margin Included" := SalesLineTot."Job Costs Margin Included";
                        //#5239
                        lSalesLineBis."Job Costs (LCY)" := SalesLineTot."Job Costs (LCY)";
                        //#5922
                        lSalesLineBis."Line Discount Amount" := SalesLineTot."Line Discount Amount";
                        //#5922//
                        //#4946
                        lSalesLineBis."Gross Weight" := SalesLineTot."Gross Weight";
                        lSalesLineBis."Net Weight" := SalesLineTot."Net Weight";
                        lSalesLineBis."Unit Volume" := SalesLineTot."Unit Volume";
                        lSalesLineBis."Value 1" := SalesLineTot."Value 1";
                        lSalesLineBis."Value 2" := SalesLineTot."Value 2";
                        lSalesLineBis."Value 3" := SalesLineTot."Value 3";
                        lSalesLineBis."Value 4" := SalesLineTot."Value 4";
                        lSalesLineBis."Value 5" := SalesLineTot."Value 5";
                        lSalesLineBis."Value 6" := SalesLineTot."Value 6";
                        lSalesLineBis."Value 7" := SalesLineTot."Value 7";
                        lSalesLineBis."Value 8" := SalesLineTot."Value 8";
                        lSalesLineBis."Value 9" := SalesLineTot."Value 9";
                        lSalesLineBis."Value 10" := SalesLineTot."Value 10";
                        //#4946//
                    end else begin
                        lSalesLineBis.Amount += lAmount;
                        lSalesLineBis."Amount Including VAT" += lAmountIncludVAT;
                        lSalesLineBis."Line Amount" += lLineAmount;
                        lSalesLineBis."Total Cost (LCY)" += lTotalCost;
                        lSalesLineBis."Overhead Amount (LCY)" += lOverheadAmount;
                        lSalesLineBis."Amount Excl. VAT (LCY)" += lAmountExclVAT;
                        lSalesLineBis."Theoretical Profit Amount(LCY)" += lTheoProfitAmount;
                        //#5239
                        lSalesLineBis."Job Costs Margin Included" += lTheoJobCostProfit;
                        //#5239//
                        lSalesLineBis."Job Costs (LCY)" += lJobCosts;
                        //#5922
                        lSalesLineBis."Line Discount Amount" += lLineDiscountAmount;
                        //#5922//
                        //+ONE+
                        lSalesLineBis."Inv. Discount Amount" += lInvDiscountAmount;
                        //+ONE+//

                        //#4946
                        lSalesLineBis."Gross Weight" += lVar[1];
                        lSalesLineBis."Net Weight" += lVar[2];
                        lSalesLineBis."Unit Volume" += lVar[3];
                        lSalesLineBis."Value 1" += lVar[4];
                        lSalesLineBis."Value 2" += lVar[5];
                        lSalesLineBis."Value 3" += lVar[6];
                        lSalesLineBis."Value 4" += lVar[7];
                        lSalesLineBis."Value 5" += lVar[8];
                        lSalesLineBis."Value 6" += lVar[9];
                        lSalesLineBis."Value 7" += lVar[10];
                        lSalesLineBis."Value 8" += lVar[11];
                        lSalesLineBis."Value 9" += lVar[12];
                        lSalesLineBis."Value 10" += lVar[13];
                        //#4946//
                    end;
                    lSalesLineBis.Modify;
                    //#4946
                    if lVar[1] <> 0 then
                        lSalesLineBis.Validate("Gross Weight");
                    if lVar[2] <> 0 then
                        lSalesLineBis.Validate("Net Weight");
                    if lVar[3] <> 0 then
                        lSalesLineBis.Validate("Unit Volume");
                    if lVar[4] <> 0 then
                        lSalesLineBis.Validate("Value 1");
                    if lVar[5] <> 0 then
                        lSalesLineBis.Validate("Value 2");
                    if lVar[6] <> 0 then
                        lSalesLineBis.Validate("Value 3");
                    if lVar[7] <> 0 then
                        lSalesLineBis.Validate("Value 4");
                    if lVar[8] <> 0 then
                        lSalesLineBis.Validate("Value 5");
                    if lVar[9] <> 0 then
                        lSalesLineBis.Validate("Value 6");
                    if lVar[10] <> 0 then
                        lSalesLineBis.Validate("Value 7");
                    if lVar[11] <> 0 then
                        lSalesLineBis.Validate("Value 8");
                    if lVar[12] <> 0 then
                        lSalesLineBis.Validate("Value 9");
                    if lVar[13] <> 0 then
                        lSalesLineBis.Validate("Value 10");
                    //#4946//
                end;
                lTerminer := (lSalesLineBis."Attached to Line No." = 0);
                lTerminer := not lSalesLineBis.Get(lSalesLineBis."Document Type", lSalesLineBis."Document No.",
                                              lSalesLineBis."Attached to Line No.") and lTerminer;
            end;
        end;
    end;


    procedure ReFreshTotalLine(pSalesHeader: Record "Sales Header"; var pProgress: Dialog)
    var
        lSalesLine: Record "Sales Line";
        lSalesLineTmp: Record "Sales Line" temporary;
        index: Integer;
        lmax: Integer;
    begin
        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lSalesLine.Ascending(false);
        lSalesLine.SetRange("Order Type", pSalesHeader."Order Type");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetRange("Line Type", lSalesLine."line type"::Totaling);
        if lSalesLine.IsEmpty then begin
            pProgress.Update(2, 100);
            exit;
        end;
        //#4829
        lmax := lSalesLine.COUNTAPPROX;
        //#4829//
        index := 1;
        if not lSalesLine.IsEmpty then begin
            lSalesLine.Find('-');
            repeat
                index += 1;
                wUpdateTotalLine(lSalesLine);
                pProgress.Update(2, ROUND((index / lmax) * 10000, 1));
            until lSalesLine.Next = 0;
        end;
    end;


    procedure wRefreshSalesTotaling(var pTotalingRef: RecordRef; pRef: RecordRef; pxRef: RecordRef; pFieldList: array[255, 2] of Integer)
    var
        lFieldList: array[255, 2] of Integer;
        lTmpRef: RecordRef;
    begin
        lTmpRef.Open(pTotalingRef.Number);
        lTmpRef.Init;
        wInitTempVar(pRef, pxRef, lTmpRef, pFieldList);
        if (pRef.RecordId = pTotalingRef.RecordId) then begin

        end;

        lTmpRef.Close;
    end;


    procedure wGetFatherNode(pRef: RecordRef; var pFatherRef: RecordRef) Return: Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        case pRef.Number of
            Database::"Sales Line":
                begin
                    pRef.SetTable(lSalesLine);
                    if (lSalesLine."Attached to Line No." <> 0) then
                        Return := lSalesLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Attached to Line No.")
                    else
                        if (lSalesLine."Structure Line No." <> 0) then
                            Return := lSalesLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.")
                        else
                            Return := false;
                    if Return then
                        pFatherRef.GetTable(lSalesLine);
                end;
            else
                Error(tError);
        end;
    end;


    procedure wInitTempVar(pRef: RecordRef; pxRef: RecordRef; var pVarRef: RecordRef; pFieldList: array[255, 2] of Integer)
    var
        i: Integer;
        pFref: FieldRef;
        pxFref: FieldRef;
        pVarFref: FieldRef;
    begin
        i := 1;
        while ((i <= ArrayLen(pFieldList, 1)) and (pFieldList[i] [1] <> 0)) do begin
            pFref := pRef.Field(pFieldList[i] [1]);
            pxFref := pxRef.Field(pFieldList[i] [1]);
            pVarFref := pVarRef.Field(pFieldList[i] [1]);

            pVarFref.Value := lConvert2Dec(pFref) - lConvert2Dec(pxFref);
            i += 1;
        end;
    end;


    procedure wCumulateToRec(var pToRef: RecordRef; pFromRef: RecordRef; pFieldList: array[255, 2] of Integer)
    var
        i: Integer;
        pToFref: FieldRef;
        pFromFref: FieldRef;
    begin
        i := 1;
        while ((i <= ArrayLen(pFieldList)) and (pFieldList[i] [1] <> 0)) do begin
            pToFref := pToRef.Field(pFieldList[i] [1]);
            pFromFref := pFromRef.Field(pFieldList[i] [1]);

            if pFieldList[i] [2] = 0 then
                pToFref.Value := lConvert2Dec(pToFref) + lConvert2Dec(pFromFref)
            else
                pToFref.Validate(lConvert2Dec(pToFref) + lConvert2Dec(pFromFref));
            i += 1;
        end;
    end;


    procedure wCumulateToListRec(var pToRef: RecordRef; pFromRef: RecordRef; pFieldList: array[255, 2] of Integer)
    var
        i: Integer;
        pToFref: FieldRef;
        pFromFref: FieldRef;
    begin
        if pFromRef.IsEmpty then
            exit;
        pFromRef.FindSet(true, false);
        repeat
            wCumulateToRec(pToRef, pFromRef, pFieldList);
        until pFromRef.Next = 0;
    end;

    local procedure lConvert2Dec(pFieldRef: FieldRef) return: Decimal
    begin
        Evaluate(return, Format(pFieldRef.Value));
    end;

    local procedure lConvert2int(pFieldRef: FieldRef) return: Integer
    begin
        Evaluate(return, Format(pFieldRef.Value));
    end;


    procedure wUpdateTotalingLine(var SalesLineTot: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesLineBis: Record "Sales Line";
        lAmount: Decimal;
        lAmountIncludVAT: Decimal;
        lUnitPrice: Decimal;
        lUnitCost: Decimal;
        lLineAmount: Decimal;
        lTotalCost: Decimal;
        lOverheadAmount: Decimal;
        lAmountExclVAT: Decimal;
        lTheoProfitAmount: Decimal;
        lTheoJobCostProfit: Decimal;
        lJobCosts: Decimal;
        lTerminer: Boolean;
        lNaviBatSetup: Record NavibatSetup;
        lSingleinstance: Codeunit "Import SingleInstance2";
        lSalesHeader: Record "Sales Header";
        lVar: array[10] of Decimal;
        lLineDiscountAmount: Decimal;
        lFatherSalesLineTot: Record "Sales Line";
        lQtySetup: Record "Quantity Setup";
    begin
        //#6768
        //RQ : Surtout ne pas alimenter Amount et "Amount Including VAT" sinon 'CONSISTENT' lors de la validation comptable
        //#4797
        //IF SalesLineTot."Order Type" = SalesLineTot."Order Type"::"Supply Order" THEN
        lSingleinstance.wGetNaviBatSetup(lNaviBatSetup);
        lSingleinstance.wGetSalesHeader(lSalesHeader, SalesLineTot."Document Type", SalesLineTot."Document No.");
        if (SalesLineTot."Order Type" = SalesLineTot."order type"::"Supply Order") or
           ((SalesLineTot."Document Type" = SalesLineTot."document type"::Quote) and
           (lNaviBatSetup."Disable update totaling") and
           (lSalesHeader.Status = lSalesHeader.Status::Released)) then
            //#4797//
            exit;

        //#7420
        if (not lQtySetup.Get()) then
            exit;
        //#7420//

        //Initialisation des totaux
        if SalesLineTot."Line Type" = SalesLineTot."line type"::Totaling then begin
            SalesLineTot.Amount := 0;
            SalesLineTot."Amount Including VAT" := 0;
            SalesLineTot."Line Amount" := 0;
            SalesLineTot."Total Cost (LCY)" := 0;
            SalesLineTot."Overhead Amount (LCY)" := 0;
            SalesLineTot."Amount Excl. VAT (LCY)" := 0;
            SalesLineTot."Theoretical Profit Amount(LCY)" := 0;
            //#5239
            SalesLineTot."Job Costs Margin Included" := 0;
            //#5239
            SalesLineTot."Job Costs (LCY)" := 0;
            //#5922
            SalesLineTot."Line Discount Amount" := 0;
            //#5922//
            //#4946
            SalesLineTot."Gross Weight" := 0;
            SalesLineTot."Net Weight" := 0;
            SalesLineTot."Unit Volume" := 0;
            SalesLineTot."Value 1" := 0;
            SalesLineTot."Value 2" := 0;
            SalesLineTot."Value 3" := 0;
            SalesLineTot."Value 4" := 0;
            SalesLineTot."Value 5" := 0;
            SalesLineTot."Value 6" := 0;
            SalesLineTot."Value 7" := 0;
            SalesLineTot."Value 8" := 0;
            SalesLineTot."Value 9" := 0;
            SalesLineTot."Value 10" := 0;
            //#4946//
            //#7420
            lVar[1] := 0;
            lVar[2] := 0;
            lVar[3] := 0;
            lVar[4] := 0;
            lVar[5] := 0;
            lVar[6] := 0;
            lVar[7] := 0;
            lVar[8] := 0;
            lVar[9] := 0;
            lVar[10] := 0;
            //#7420//

            lSalesLine.Reset;
            //+PERF+  lSalesLine.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code");
            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
            //+PERF+//
            lSalesLine.SetRange("Document Type", SalesLineTot."Document Type");
            lSalesLine.SetRange("Document No.", SalesLineTot."Document No.");
            lSalesLine.SetRange("Attached to Line No.", SalesLineTot."Line No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Order Type", SalesLineTot."Order Type");
            //  lSalesLine.SETFILTER("Presentation Code",'%1',SalesLineTot."Presentation Code" + '*');
            lSalesLine.SetRange(Option, false);
            if not lSalesLine.IsEmpty then
                lSalesLine.Find('-');
            repeat
                if ((lSalesLine.Quantity <> 0) or (lSalesLine."Line Type" = lSalesLine."line type"::Totaling)) and
                   not SalesLineTot.Option then begin
                    SalesLineTot."Line Amount" += lSalesLine."Line Amount";
                    SalesLineTot."Total Cost (LCY)" += lSalesLine."Total Cost (LCY)";
                    SalesLineTot."Overhead Amount (LCY)" += lSalesLine."Overhead Amount (LCY)";
                    SalesLineTot."Theoretical Profit Amount(LCY)" += lSalesLine."Theoretical Profit Amount(LCY)";
                    //#5239
                    SalesLineTot."Job Costs Margin Included" += lSalesLine."Job Costs Margin Included";
                    //#5239
                    SalesLineTot."Amount Excl. VAT (LCY)" += lSalesLine."Amount Excl. VAT (LCY)";
                    SalesLineTot."Job Costs (LCY)" += lSalesLine."Job Costs (LCY)";
                    //#5922
                    SalesLineTot."Line Discount Amount" += lSalesLine."Line Discount Amount";
                    //#5922//
                    //#4946
                    if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then
                        lSalesLine."Quantity (Base)" := 1;
                    SalesLineTot."Gross Weight" += lSalesLine."Gross Weight" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Net Weight" += lSalesLine."Net Weight" * lSalesLine."Quantity (Base)";
                    SalesLineTot."Unit Volume" += lSalesLine."Unit Volume" * lSalesLine."Quantity (Base)";
                    //#7420
                    if (SalesLineTot."Line Type" = SalesLineTot."line type"::Totaling) then begin
                        lVar[1] += lSalesLine."Value 1" * lSalesLine."Quantity (Base)";
                        lVar[2] += lSalesLine."Value 2" * lSalesLine."Quantity (Base)";
                        lVar[3] += lSalesLine."Value 3" * lSalesLine."Quantity (Base)";
                        lVar[4] += lSalesLine."Value 4" * lSalesLine."Quantity (Base)";
                        lVar[5] += lSalesLine."Value 5" * lSalesLine."Quantity (Base)";
                        lVar[6] += lSalesLine."Value 6" * lSalesLine."Quantity (Base)";
                        lVar[7] += lSalesLine."Value 7" * lSalesLine."Quantity (Base)";
                        lVar[8] += lSalesLine."Value 8" * lSalesLine."Quantity (Base)";
                        lVar[9] += lSalesLine."Value 9" * lSalesLine."Quantity (Base)";
                        lVar[10] += lSalesLine."Value 10" * lSalesLine."Quantity (Base)";
                    end else begin
                        //#7420//
                        lVar[1] += lSalesLine."Value 1";
                        lVar[2] += lSalesLine."Value 2";
                        lVar[3] += lSalesLine."Value 3";
                        lVar[4] += lSalesLine."Value 4";
                        lVar[5] += lSalesLine."Value 5";
                        lVar[6] += lSalesLine."Value 6";
                        lVar[7] += lSalesLine."Value 7";
                        lVar[8] += lSalesLine."Value 8";
                        lVar[9] += lSalesLine."Value 9";
                        lVar[10] += lSalesLine."Value 10";
                        //#7720
                    end;
                    //#7420//
                    //#4946//
                end;
            until lSalesLine.Next = 0;
            //#7420
            if (lQtySetup."Value 1 Total") then
                SalesLineTot."Value 1" := lVar[1];
            if (lQtySetup."Value 2 Total") then
                SalesLineTot."Value 2" := lVar[2];
            if (lQtySetup."Value 3 Total") then
                SalesLineTot."Value 3" := lVar[3];
            if (lQtySetup."Value 4 Total") then
                SalesLineTot."Value 4" := lVar[4];
            if (lQtySetup."Value 5 Total") then
                SalesLineTot."Value 5" := lVar[5];
            if (lQtySetup."Value 6 Total") then
                SalesLineTot."Value 6" := lVar[6];
            if (lQtySetup."Value 7 Total") then
                SalesLineTot."Value 7" := lVar[7];
            if (lQtySetup."Value 8 Total") then
                SalesLineTot."Value 8" := lVar[8];
            if (lQtySetup."Value 9 Total") then
                SalesLineTot."Value 9" := lVar[9];
            if (lQtySetup."Value 10 Total") then
                SalesLineTot."Value 10" := lVar[10];
            //#7420//
            SalesLineTot.Modify;
        end;
        //#6768//
        //#7420
        if (SalesLineTot."Attached to Line No." <> 0) then begin
            lFatherSalesLineTot.SetRange("Document Type", SalesLineTot."Document Type");
            lFatherSalesLineTot.SetRange("Document No.", SalesLineTot."Document No.");
            lFatherSalesLineTot.SetRange("Line No.", SalesLineTot."Attached to Line No.");
            if (not lFatherSalesLineTot.IsEmpty()) then begin
                lFatherSalesLineTot.FindFirst;
                wUpdateTotalingLine(lFatherSalesLineTot);
            end;
        end;
        //#7420//
    end;


    procedure ReFreshStructureLine(pSalesHeader: Record "Sales Header"; var pProgress: Dialog)
    var
        lSalesLine: Record "Sales Line";
        lSalesLineTmp: Record "Sales Line" temporary;
        index: Integer;
        lmax: Integer;
    begin
        //#6834
        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lSalesLine.Ascending(false);
        lSalesLine.SetRange("Order Type", pSalesHeader."Order Type");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetRange("Line Type", lSalesLine."line type"::Structure);
        if lSalesLine.IsEmpty then begin
            pProgress.Update(2, 100);
            exit;
        end;
        //#4829
        lmax := lSalesLine.Count;
        //#4829//
        index := 1;
        if not lSalesLine.IsEmpty then begin
            lSalesLine.Find('-');
            repeat
                index += 1;
                Codeunit.Run(Codeunit::"Structure Management", lSalesLine);
                pProgress.Update(2, ROUND((index / lmax) * 10000, 1));
            until lSalesLine.Next = 0;
        end;
        //#6834//
    end;


    procedure wRefreshFather(pValue: Boolean)
    begin
        wNotRefreshFather := pValue
    end;


    procedure InvDiscountIsAllowed(pSalesLine: Record "Sales Line"; DefaultValue: Boolean): Boolean
    var
        lNaviBatSetUp: Record NavibatSetup;
        lItem: Record Item;
        lResource: Record Resource;
    begin
        //#8334
        //Controle si remise facture par defaut
        with pSalesLine do begin
            lNaviBatSetUp.Get();
            // Pase de remise sur pied de doc. et frais
            if ("Line Type" = "line type"::Other) or ("Line Type" = "line type"::"Charge (Item)") then
                exit(false);
            // Pase de remise sur option
            if pSalesLine.Option then
                exit(false);
            // Pas de remise dans le sous détail
            if "Structure Line No." <> 0 then
                exit(false);

            case lNaviBatSetUp."Discount Method Calculation" of
                lNaviBatSetUp."discount method calculation"::"Line Discount":
                    begin
                        // Pas de remise sur Prix fixe si remise ligne
                        if pSalesLine."Fixed Price" then
                            exit(false);
                    end;
                lNaviBatSetUp."discount method calculation"::"Invoice Discount":
                    begin

                    end;
            end;

            case Type of
                Type::Item:
                    begin
                        if DefaultValue then begin
                            if lItem.Get("No.") then
                                exit(lItem."Allow Invoice Disc.");
                        end else
                            exit(true);
                    end;
                Type::Resource:
                    begin
                        if DefaultValue then begin
                            if lResource.Get("No.") then
                                exit(lResource."Allow Invoice Disc.");
                        end else
                            exit(true);
                    end;
                Type::"G/L Account":
                    begin
                        exit(true);
                    end
                else begin
                    exit(false);
                end;
            end;
            exit(false);
        end;
        //#8334//
    end;
}

