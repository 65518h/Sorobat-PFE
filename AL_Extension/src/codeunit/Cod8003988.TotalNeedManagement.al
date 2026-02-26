Codeunit 8003988 "TotalNeed Management"
{
    // MIG-2009:New version
    // //NEW VERSION
    // //COR-2009 OF 01/06/10 : + fInitStruInfo()


    trigger OnRun()
    begin
    end;

    var
        //GL2024  TextTotal: ;
        TextTotalMachNo: label 'MACHINE TOTAL';
        TextTotalStrucNo: label 'STRUCTURE TOTAL';
        TextTotalDesc: label 'Total %1';
        TextTotalSTNo: label 'SUBCONTRACTING TOTAL';
        TextTotalSTDesc: label 'Subcontracting Total';
        TextTotalItemNo: label 'ITEM TOTAL';
        TextTotalResNo: label 'RES TOTAL';
        SalesLineTemp: Record "Sales Line" temporary;
        TotalNeedParam: Record "Sales Document Cost";
        SalesLine: Record "Sales Line";
        wSaleLine: Record "Sales Line";
        NaviBat: Record NavibatSetup;
        SalesHeader: Record "Sales Header";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        StructureMgt: Codeunit "Structure Management";
        ProdPostGroupFilter: Text[30];
        SubcontFilter: Text[30];
        Empty: Boolean;
        EmptyVendor: Boolean;
        EmptyProc: Boolean;
        EmptyRate: Boolean;
        StatusReleased: Boolean;
        Windows: Dialog;
        NbreTot: Integer;
        Jauge: Integer;
        wEstimateQty: Decimal;
        wCoefRange: Decimal;
        tProgress: label 'Cumul des lignes de type %1';


    procedure fDrillDown(pSalesLine: Record "Sales Line")
    var
        lSalesLines: Record "Sales Line";
        lTempLines: Record "Sales Line" temporary;
        lLineNo: Integer;
    begin
        lTempLines.DeleteAll;

        lSalesLines.SetCurrentkey("Document Type", Type, "No.");
        lSalesLines.SetRange("Document Type", pSalesLine."Document Type");
        lSalesLines.SetRange(Type, pSalesLine.Type);
        lSalesLines.SetRange("No.", pSalesLine."No.");
        lSalesLines.SetRange("Document No.", pSalesLine."Document No.");
        if (pSalesLine."Item Type" <> 0) or (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ") then
            lSalesLines.SetRange("Line No.", pSalesLine."Structure Line No.");
        lSalesLines.SetRange("Purchasing Code", pSalesLine."Item Category Code");
        if lSalesLines.Find('-') then
            repeat
                lTempLines := lSalesLines;
                lLineNo += 1;
                lTempLines.Insert;
            until lSalesLines.Next = 0;
        Page.RunModal(0, lTempLines);
    end;


    procedure fFindUnitCost(var pSalesLine: Record "Sales Line")
    var
        lTotalNeedParam: Record "Sales Document Cost";
        lResCost: Record "Resource Cost";
        lSalesHeader: Record "Sales Header";
        lResFindUnitCost: Codeunit "Resource-Find Cost";
        lItem: Record Item;
        lSKU: Record "Stockkeeping Unit";
    begin
        with pSalesLine do begin
            if Type = Type::Resource then begin
                if lSalesHeader.Get("Document Type", "Document No.") then;
                lResCost.Init;
                lResCost.Code := "No.";
                lResCost."Work Type Code" := "Work Type Code";
                if "Document Type" in ["document type"::Quote, "document type"::Order] then
                    lResCost."Starting Date" := lSalesHeader."Order Date"
                else
                    lResCost."Starting Date" := lSalesHeader."Posting Date";
                //GL2024 lResFindUnitCost.Run(lResCost);
                Validate("Unit Cost (LCY)", lResCost."Unit Cost");
            end;
            if Type = Type::Item then begin
                lItem.Get("No.");
                if lItem."Item Type" <> lItem."item type"::Generic then begin
                    if lItem."Standard Cost" = 0 then
                        lItem."Standard Cost" := lItem."Unit Cost";
                    if lSKU.Get("Location Code", "No.", "Variant Code") then begin
                        Validate("Unit Cost (LCY)", lSKU."Standard Cost" * "Qty. per Unit of Measure");
                    end else begin
                        Validate("Unit Cost (LCY)", lItem."Standard Cost" * "Qty. per Unit of Measure");
                    end;
                end;
            end;
        end;
    end;


    procedure fSalesOverHeadUpdate(var pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line"; pType: Integer; pValue: Decimal; pDelete: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
        lStructureLine: Record "Sales Line";
        lOverhead: Codeunit "Overhead Calculation";
        lxRec: Record "Sales Line";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lNaviBat: Record NavibatSetup;
        lStructureMgt: Codeunit "Structure Management";
    begin
        if lTotalNeedParam.Get(pSalesLine."Document Type",
                               pSalesLine."Document No.",
                               pType,
                               pSalesLine."No.",
                               pSalesLine."Structure Line No.",
                               pSalesLine."Item Category Code") then begin
            lTotalNeedParam.Value := pValue;
            if pDelete and (lTotalNeedParam."Vendor No." = '') and (lTotalNeedParam."Purchasing Code" = '') then
                lTotalNeedParam.Delete
            else
                lTotalNeedParam.Modify;
        end else
            if not pDelete then begin
                //#4419
                lTotalNeedParam.Init;
                //#4419//
                lTotalNeedParam."Document Type" := pSalesLine."Document Type";
                lTotalNeedParam."Document No." := pSalesLine."Document No.";
                lTotalNeedParam.Type := pType;
                lTotalNeedParam."No." := pSalesLine."No.";
                lTotalNeedParam."Line No." := pSalesLine."Structure Line No.";
                lTotalNeedParam."Purchasing Code" := pSalesLine."Item Category Code";
                lTotalNeedParam.Value := pValue;
                lTotalNeedParam.Insert;
            end;

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", pSalesLine."Document No.");
        if (pSalesLine."Item Type" <> 0) or (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pSalesLine."Structure Line No.");
        lSalesLine.SetRange("Line Type", pSalesLine."Line Type");
        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item] then
            lSalesLine.SetRange("Purchasing Code", pSalesLine."Item Category Code");

        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then
            lSalesLine.SetRange("No.", pSalesLine."No.");
        if lSalesLine.Find('-') then
            repeat
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if pType in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
                        if pDelete then
                            fFindUnitCost(lSalesLine)
                        else
                            lSalesLine.Validate("Unit Cost (LCY)", lTotalNeedParam.Value * lSalesLine."Qty. per Unit of Measure");
                        lSalesLine.Modify;
                        if lSalesLine."Structure Line No." <> 0 then
                            if lStructureLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.") then begin
                                //A optimiser
                                lxRec := lStructureLine;
                                lStructureMgt.SumStructureLines(lStructureLine);
                                lStructureLine.Modify;
                                lStructureLine.wUpdateLine(lStructureLine, lxRec, false);
                                //#4829
                                lNaviBat.Get();
                                if (lNaviBat."Number lines before commit" <> 0) then
                                    Commit;
                                //#4829//
                            end;
                    end;
                end;
            until lSalesLine.Next = 0;
        Commit;
        //#4829
        if pSalesLineTemp.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.") then begin
            pSalesLineTemp.Validate("Unit Cost (LCY)", lSalesLine."Unit Cost (LCY)" * pSalesLineTemp."Qty. per Unit of Measure");
            pSalesLineTemp.Modify;
        end;
        pSalesLineTemp.FindLast;
        pSalesLineTemp.Delete;
        fInsertTotalLine(pSalesLine, pSalesLineTemp);
        //#4829//
        if pSalesLineTemp.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.") then;
    end;


    procedure fInsertTotalLine(var pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line")
    var
        i: Integer;
        lLineNo: Integer;
        lTotalQty: Decimal;
        lTotalQtyBase: Decimal;
        lTotalCost: Decimal;
        lLineType: Integer;
    begin
        //MAJ lignes total
        Clear(lTotalQty);
        Clear(lTotalCost);

        lLineType := pSalesLineTemp."Line Type";
        pSalesLineTemp.Reset;
        if pSalesLineTemp.FindLast then begin
            lLineNo := pSalesLineTemp."Line No.";
            lLineNo += 1;
            pSalesLine.Subcontracting := pSalesLineTemp.Subcontracting;
            pSalesLineTemp.Init;
            pSalesLineTemp."Document Type" := pSalesLine."Document Type";
            pSalesLineTemp."Document No." := pSalesLine."Document No.";
            case pSalesLine."Line Type" of
                pSalesLine."line type"::Item:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Item;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Item;
                        if pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" " then begin
                            pSalesLineTemp."No." := TextTotalSTNo;
                            pSalesLineTemp.Subcontracting := 1;
                        end else
                            pSalesLineTemp."No." := TextTotalItemNo;
                    end;
                pSalesLine."line type"::Person:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Person;
                        pSalesLineTemp."No." := TextTotalResNo;
                    end;
                pSalesLine."line type"::Machine:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Machine;
                        pSalesLineTemp."No." := TextTotalMachNo;
                    end;
                pSalesLine."line type"::Structure:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Structure;
                        pSalesLineTemp."No." := TextTotalStrucNo;
                    end;
            end;

            if pSalesLineTemp."No." = TextTotalSTNo then
                pSalesLineTemp.Description := TextTotalSTDesc
            else
                pSalesLineTemp.Description := StrSubstNo(TextTotalDesc, pSalesLineTemp."Line Type");
            pSalesLineTemp."Line No." := lLineNo;
            pSalesLineTemp."Gen. Bus. Posting Group" := ProdPostGroupFilter;
            pSalesLineTemp.Insert;
        end;

        pSalesLineTemp.Reset;
        //MIG-2009:New version
        pSalesLineTemp.SetRange("Line Type", lLineType);
        //MIG-2009:New version//
        if pSalesLineTemp.Find('-') then
            repeat
                if (pSalesLineTemp."No." <> TextTotalItemNo) and (pSalesLineTemp."No." <> TextTotalResNo) and
                   (pSalesLineTemp."No." <> TextTotalMachNo) and (pSalesLineTemp."No." <> TextTotalStrucNo) and
                   (pSalesLineTemp."No." <> TextTotalSTNo) and
                   (pSalesLineTemp.Type in [pSalesLineTemp.Type::Item, pSalesLineTemp.Type::Resource])
                  then begin
                    lTotalQty += pSalesLineTemp.Quantity;
                    lTotalQtyBase += pSalesLineTemp."Quantity (Base)";
                    lTotalCost += pSalesLineTemp."Total Cost (LCY)";
                end else begin
                    if pSalesLineTemp.Type = pSalesLineTemp.Type::Resource then begin
                        pSalesLineTemp.Quantity := lTotalQty;
                        pSalesLineTemp."Quantity (Base)" := lTotalQtyBase;
                    end;
                    pSalesLineTemp."Total Cost (LCY)" := lTotalCost;
                    pSalesLineTemp.Modify;
                    Clear(lTotalQty);
                    Clear(lTotalCost);
                end;
            until pSalesLineTemp.Next = 0;
    end;


    procedure fInitTempTable(pShowDialog: Boolean; pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line" temporary; ProdPostGroupFilter: Text[30]; var pCurrFormWeight: Boolean; pLineTypeFilter: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lArt: Record Item;
        lRes: Record Resource;
        lTotalNeedParam: Record "Sales Document Cost";
        lUnitCode: Record "Unit of Measure";
        lLineNo: Integer;
        lProgress: Codeunit "Progress Dialog2";
    begin
        pSalesLineTemp.Reset;
        pSalesLineTemp.DeleteAll;

        lSalesLine.Reset;
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Line Type");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        if ProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", ProdPostGroupFilter)
        else
            lSalesLine.SetRange("Gen. Prod. Posting Group");
        if pLineTypeFilter then
            lSalesLine.SetRange("Line Type", pSalesLine."Line Type");
        lSalesLine.SetFilter(Type, '%1|%2', lSalesLine.Type::Item, lSalesLine.Type::Resource);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        lSalesLine.SetFilter(Subcontracting, SubcontFilter);

        if lSalesLine.FindSet then begin
            if pShowDialog and pLineTypeFilter then
                lProgress.Open(StrSubstNo(tProgress, pSalesLine."Line Type"), lSalesLine.COUNTAPPROX);
            repeat
                if pShowDialog and pLineTypeFilter then
                    lProgress.Update;
                pSalesLineTemp.Reset;
                pSalesLineTemp.SetCurrentkey("Document Type", "Document No.", "Line Type");
                pSalesLineTemp.SetRange("Document Type", lSalesLine."Document Type");
                pSalesLineTemp.SetRange("Document No.", lSalesLine."Document No.");
                pSalesLineTemp.SetRange("Line Type", lSalesLine."Line Type");
                //DEVIS
                if lSalesLine.Type = lSalesLine.Type::Item then
                    pSalesLineTemp.SetRange("Item Category Code", lSalesLine."Purchasing Code")
                else
                    pSalesLineTemp.SetRange("Item Category Code");
                //DEVIS
                pSalesLineTemp.SetRange("No.", lSalesLine."No.");
                if not pSalesLineTemp.IsEmpty and
                    (lSalesLine."Item Type" = 0) and
                    (lSalesLine.Subcontracting = lSalesLine.Subcontracting::" ") then begin
                    pSalesLineTemp.Find('-');
                    pSalesLineTemp.SuspendStatusCheck(true);
                    pSalesLineTemp."Quantity (Base)" += lSalesLine."Quantity (Base)";
                    if (lSalesLine.Quantity <> 0) then
                        pSalesLineTemp."Total Cost (LCY)" += lSalesLine."Total Cost (LCY)";
                    //4546       pSalesLineTemp."Total Cost (LCY)" +=
                    //4546          (lSalesLine."Total Cost (LCY)" / lSalesLine.Quantity) * lSalesLine."Quantity (Base)";
                    if pSalesLineTemp."Quantity (Base)" <> 0 then
                        pSalesLineTemp."Unit Cost (LCY)" := ROUND(pSalesLineTemp."Total Cost (LCY)" / pSalesLineTemp."Quantity (Base)", 0.01);
                    if (lSalesLine."Vendor No." <> pSalesLineTemp."Bill-to Customer No.") then
                        pSalesLineTemp."Bill-to Customer No." := '****';
                    //DEVIS
                    //      IF (lSalesLine."Purchasing Code" <> pSalesLineTemp."Item Category Code") THEN BEGIN
                    //        pSalesLineTemp."Item Category Code" := '****';
                    //        pSalesLineTemp."Drop Shipment" := FALSE;
                    //        pSalesLineTemp."Special Order" := FALSE;
                    //      END;
                    //DEVIS
                    pSalesLineTemp.Quantity += lSalesLine."Qty. per Unit of Measure" * lSalesLine.Quantity;
                    if lSalesLine."Line Type" = lSalesLine."line type"::Structure then begin
                        pSalesLineTemp.Duration += lSalesLine.Duration;
                        if pSalesLineTemp.Duration <> 0 then
                            pSalesLineTemp.Rate := pSalesLineTemp.Quantity / pSalesLineTemp.Duration
                        else
                            pSalesLineTemp.Rate := 0;
                    end;
                    if pSalesLineTemp."Line Type" = pSalesLineTemp."line type"::Structure then
                        fUpdateStruInfo(lSalesLine, pSalesLineTemp);

                    pSalesLineTemp.Modify;

                end else begin
                    pSalesLineTemp.SuspendStatusCheck(true);
                    pSalesLineTemp."Document Type" := lSalesLine."Document Type";
                    pSalesLineTemp."Document No." := lSalesLine."Document No.";
                    pSalesLineTemp.Type := lSalesLine.Type;
                    pSalesLineTemp."Line Type" := lSalesLine."Line Type";
                    pSalesLineTemp."No." := lSalesLine."No.";
                    pSalesLineTemp."Bill-to Customer No." := lSalesLine."Vendor No.";
                    pSalesLineTemp."Item Category Code" := lSalesLine."Purchasing Code";
                    pSalesLineTemp."Job No." := lSalesLine."Job No.";
                    pSalesLineTemp."Theoretical Profit Amount(LCY)" := 0;
                    lLineNo += 10;
                    pSalesLineTemp."Line No." := lLineNo;
                    pSalesLineTemp."Unit of Measure" := '';
                    case pSalesLineTemp.Type of
                        pSalesLineTemp."line type"::Item:
                            begin
                                pSalesLineTemp.Subcontracting := lSalesLine.Subcontracting;
                                pSalesLineTemp."Purchasing Document Type" := lSalesLine."Purchasing Document Type";
                                pSalesLineTemp."Purchasing Order No." := lSalesLine."Purchasing Order No.";
                                pSalesLineTemp."Purchasing Order Line No." := lSalesLine."Purchasing Order Line No.";
                                if (lSalesLine."Item Type" <> 0) or (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") then begin
                                    pSalesLineTemp.Description := lSalesLine.Description;
                                    pSalesLineTemp."Description 2" := lSalesLine."Description 2";
                                    pSalesLineTemp."Unit of Measure Code" := lSalesLine."Unit of Measure Code";
                                    pSalesLineTemp."Unit of Measure" := lSalesLine."Unit of Measure";
                                    pSalesLineTemp."Gen. Prod. Posting Group" := lSalesLine."Gen. Prod. Posting Group";
                                end else begin
                                    lArt.Get(lSalesLine."No.");
                                    pSalesLineTemp.Description := lArt.Description;
                                    pSalesLineTemp."Description 2" := lArt."Description 2";
                                    pSalesLineTemp."Unit of Measure Code" := lArt."Base Unit of Measure";
                                    if pSalesLineTemp."Unit of Measure Code" <> '' then begin
                                        lUnitCode.Get(pSalesLineTemp."Unit of Measure Code");
                                        pSalesLineTemp."Unit of Measure" := lUnitCode.Description;
                                    end;
                                    pSalesLineTemp."Gen. Prod. Posting Group" := lArt."Gen. Prod. Posting Group";
                                    pSalesLineTemp."Gross Weight" := lArt."Public Price";
                                end;
                            end;
                        pSalesLineTemp.Type::Resource:
                            begin
                                lRes.Get(lSalesLine."No.");
                                pSalesLineTemp.Description := lRes.Name;
                                pSalesLineTemp."Description 2" := lRes."Name 2";
                                pSalesLineTemp."Unit of Measure Code" := lRes."Base Unit of Measure";
                                if pSalesLineTemp."Unit of Measure Code" <> '' then begin
                                    lUnitCode.Get(pSalesLineTemp."Unit of Measure Code");
                                    pSalesLineTemp."Unit of Measure" := lUnitCode.Description;
                                end;
                                pSalesLineTemp."Gen. Prod. Posting Group" := lRes."Gen. Prod. Posting Group";
                                //#4829
                                if lSalesLine."Line Type" = lSalesLine."line type"::Structure then begin
                                    pSalesLineTemp.Duration := lSalesLine.Duration;
                                    pSalesLineTemp.Rate := lSalesLine.Rate;
                                end;
                                //#4829//
                            end else begin
                            pSalesLineTemp.Description := lSalesLine.Description;
                            pSalesLineTemp."Description 2" := lSalesLine."Description 2";
                            pSalesLineTemp."Unit of Measure Code" := lSalesLine."Unit of Measure Code";
                            pSalesLineTemp."Unit of Measure" := lSalesLine."Unit of Measure";
                            pSalesLineTemp."Gen. Prod. Posting Group" := lSalesLine."Gen. Prod. Posting Group";
                        end;
                    end;
                    //#4829
                    //      IF lSalesLine."Line Type" = lSalesLine."Line Type"::Structure THEN BEGIN
                    //        pSalesLineTemp.Duration := lSalesLine.Duration;
                    //        pSalesLineTemp.Rate := lSalesLine.Rate;
                    //      END ELSE BEGIN
                    //        pSalesLineTemp.Duration := 0;
                    //        pSalesLineTemp.Rate := 0;
                    //      END;
                    //#4829//
                    pSalesLineTemp."Quantity (Base)" := lSalesLine."Quantity (Base)";
                    pSalesLineTemp."Qty. per Unit of Measure" := 1;
                    if (pSalesLineTemp."Quantity (Base)" <> 0) then begin
                        pSalesLineTemp."Total Cost (LCY)" := lSalesLine."Total Cost (LCY)";
                        //ML        IF lSalesLine.Quantity <> 0 THEN
                        //ML          pSalesLineTemp."Total Cost (LCY)" :=
                        //ML           (lSalesLine."Total Cost (LCY)" / lSalesLine.Quantity) * lSalesLine."Quantity (Base)";
                        pSalesLineTemp."Unit Cost (LCY)" := ROUND(pSalesLineTemp."Total Cost (LCY)" / pSalesLineTemp."Quantity (Base)", 0.01);
                    end else begin
                        pSalesLineTemp."Unit Cost (LCY)" := 0;
                        pSalesLineTemp."Total Cost (LCY)" := 0;
                    end;
                    Clear(lTotalNeedParam);
                    lTotalNeedParam.SetRange("Document Type", pSalesLineTemp."Document Type");
                    lTotalNeedParam.SetRange("Document No.", pSalesLineTemp."Document No.");
                    lTotalNeedParam.SetRange(Type);
                    //DEVIS      IF pSalesLineTemp.Type = pSalesLineTemp.Type::Item THEN
                    if pSalesLineTemp.Type = pSalesLineTemp.Type::Item then begin
                        lTotalNeedParam.SetRange(Type, lTotalNeedParam.Type::Item);
                        //DEVIS
                        lTotalNeedParam.SetRange("Purchasing Code", lSalesLine."Purchasing Code");
                    end;
                    //DEVIS//
                    if pSalesLineTemp.Type = pSalesLineTemp.Type::Resource then
                        lTotalNeedParam.SetRange(Type, lTotalNeedParam.Type::Resource);
                    lTotalNeedParam.SetRange("No.", pSalesLineTemp."No.");
                    if (lSalesLine."Item Type" <> 0) or (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") then
                        lTotalNeedParam.SetRange("Line No.", lSalesLine."Line No.");
                    if not lTotalNeedParam.IsEmpty then begin
                        lTotalNeedParam.FindFirst;
                        pSalesLineTemp."Unit Cost" := lTotalNeedParam.Value;
                        pSalesLineTemp."Vendor No." := lTotalNeedParam."Vendor No.";
                        pSalesLineTemp."Purchasing Code" := lTotalNeedParam."Purchasing Code";
                        pSalesLineTemp."Purchasing Document Type" := lTotalNeedParam."Purchasing Document Type";
                        pSalesLineTemp."Purchasing Order No." := lTotalNeedParam."Purchasing Order No.";
                        pSalesLineTemp."Purchasing Order Line No." := lTotalNeedParam."Purchasing Order Line No.";
                        pSalesLineTemp.Dummy := lTotalNeedParam."Reference Purchase Quote";
                        pSalesLineTemp."Line Discount Amount" := lTotalNeedParam.Rate;
                    end else begin
                        pSalesLineTemp."Unit Cost" := 0;
                        pSalesLineTemp."Vendor No." := '';
                        pSalesLineTemp."Purchasing Code" := '';
                        pSalesLineTemp."Line Discount Amount" := 0;
                        pSalesLineTemp.Dummy := '';
                    end;
                    pSalesLineTemp.Quantity := lSalesLine.Quantity * lSalesLine."Qty. per Unit of Measure";
                    if (lSalesLine."Item Type" <> 0) or (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") then
                        pSalesLineTemp."Structure Line No." := lSalesLine."Line No."
                    else
                        pSalesLineTemp."Structure Line No." := 0;
                    pSalesLineTemp."Item Type" := lSalesLine."Item Type";
                    pSalesLineTemp."Drop Shipment" := lSalesLine."Drop Shipment";
                    pSalesLineTemp."Special Order" := lSalesLine."Special Order";
                    if pSalesLineTemp."Line Type" = pSalesLineTemp."line type"::Structure then begin
                        //COR-2009
                        fInitStruInfo(pSalesLineTemp);
                        //COR-2009//
                        fUpdateStruInfo(lSalesLine, pSalesLineTemp);
                    end;
                    if (pSalesLineTemp."Gross Weight" <> 0) and (pSalesLineTemp."Unit Cost" <> 0) then
                        pSalesLineTemp."Net Weight" := (1 - (pSalesLineTemp."Unit Cost" / pSalesLineTemp."Gross Weight")) * 100
                    else
                        pSalesLineTemp."Net Weight" := 0;
                    if (pSalesLineTemp."Gross Weight" <> 0) then
                        pCurrFormWeight := true;

                    pSalesLineTemp.Insert;

                end;
            until lSalesLine.Next = 0;
            if pShowDialog then
                lProgress.Close;
        end;

        pSalesLineTemp.Reset;
    end;


    procedure fUpdateStruInfo(pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line" temporary)
    begin
        pSalesLine.CalcFields("Person Quantity");
        pSalesLineTemp."Qty. to Invoice" += pSalesLine."Person Quantity";
        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Item);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Qty. to Ship" += pSalesLine."Total Cost LCY by Line Type"; //Co═t Article
        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Person);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Quantity Shipped" += pSalesLine."Total Cost LCY by Line Type"; //Co═t M.O.
        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Machine);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Quantity Invoiced" += pSalesLine."Total Cost LCY by Line Type"; //Co═t Mat▓riel
        pSalesLine.SetFilter("Line Type Filter", '<>%1&<>%2&<>%3',
            pSalesLine."line type filter"::Machine, pSalesLine."line type filter"::Person, pSalesLine."line type filter"::Item);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Qty. to Invoice (Base)" += pSalesLine."Total Cost LCY by Line Type"; //Co═t autre
    end;


    procedure fInitStruInfo(var pSalesLineTemp: Record "Sales Line" temporary)
    begin
        //COR-2009\\
        pSalesLineTemp."Qty. to Invoice" := 0;
        pSalesLineTemp."Qty. to Ship" := 0;
        pSalesLineTemp."Quantity Shipped" := 0;
        pSalesLineTemp."Quantity Invoiced" := 0;
        pSalesLineTemp."Qty. to Invoice (Base)" := 0;
    end;


    procedure fInsertTotalLineNew(var pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line")
    var
        i: Integer;
        lLineNo: Integer;
        lTotalQty: Decimal;
        lTotalQtyBase: Decimal;
        lTotalCost: Decimal;
        lLineType: Integer;
    begin
        //MAJ lignes total
        Clear(lTotalQty);
        Clear(lTotalCost);

        lLineType := pSalesLineTemp."Line Type";
        pSalesLineTemp.Reset;
        if pSalesLineTemp.FindLast then begin
            lLineNo := pSalesLineTemp."Line No.";
            lLineNo += 1;
            pSalesLine.Subcontracting := pSalesLineTemp.Subcontracting;
            pSalesLineTemp.Init;
            pSalesLineTemp."Document Type" := pSalesLine."Document Type";
            pSalesLineTemp."Document No." := pSalesLine."Document No.";
            case pSalesLine."Line Type" of
                pSalesLine."line type"::Item:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Item;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Item;
                        if pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" " then begin
                            pSalesLineTemp."No." := TextTotalSTNo;
                            pSalesLineTemp.Subcontracting := 1;
                        end else
                            pSalesLineTemp."No." := TextTotalItemNo;
                    end;
                pSalesLine."line type"::Person:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Person;
                        pSalesLineTemp."No." := TextTotalResNo;
                    end;
                pSalesLine."line type"::Machine:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Machine;
                        pSalesLineTemp."No." := TextTotalMachNo;
                    end;
                pSalesLine."line type"::Structure:
                    begin
                        pSalesLineTemp.Type := pSalesLineTemp.Type::Resource;
                        pSalesLineTemp."Line Type" := pSalesLineTemp."line type"::Structure;
                        pSalesLineTemp."No." := TextTotalStrucNo;
                    end;
            end;

            if pSalesLineTemp."No." = TextTotalSTNo then
                pSalesLineTemp.Description := TextTotalSTDesc
            else
                pSalesLineTemp.Description := StrSubstNo(TextTotalDesc, pSalesLineTemp."Line Type");
            pSalesLineTemp."Line No." := lLineNo;
            pSalesLineTemp."Gen. Bus. Posting Group" := ProdPostGroupFilter;
            pSalesLineTemp.Insert;
        end;

        pSalesLineTemp.Reset;
        //MIG-2009:New version
        pSalesLineTemp.SetRange("Line Type", lLineType);
        //MIG-2009:New version//
        if pSalesLineTemp.Find('-') then
            repeat
                if (pSalesLineTemp."No." <> TextTotalItemNo) and (pSalesLineTemp."No." <> TextTotalResNo) and
                   (pSalesLineTemp."No." <> TextTotalMachNo) and (pSalesLineTemp."No." <> TextTotalStrucNo) and
                   (pSalesLineTemp."No." <> TextTotalSTNo) and
                   (pSalesLineTemp.Type in [pSalesLineTemp.Type::Item, pSalesLineTemp.Type::Resource])
                  then begin
                    lTotalQty += pSalesLineTemp.Quantity;
                    lTotalQtyBase += pSalesLineTemp."Quantity (Base)";
                    lTotalCost += pSalesLineTemp."Total Cost (LCY)";
                end else begin
                    if pSalesLineTemp.Type = pSalesLineTemp.Type::Resource then begin
                        pSalesLineTemp.Quantity := lTotalQty;
                        pSalesLineTemp."Quantity (Base)" := lTotalQtyBase;
                    end;
                    pSalesLineTemp."Total Cost (LCY)" := lTotalCost;
                    pSalesLineTemp.Modify;
                    Clear(lTotalQty);
                    Clear(lTotalCost);
                end;
            until pSalesLineTemp.Next = 0;
    end;


    procedure FOnModify(var pRec: Record "Sales Line"; pxRec: Record "Sales Line"): Boolean
    var
        lItem: Record Item;
    begin
        if (pRec.Type = pRec.Type::Item) and (pxRec."Purchasing Code" <> pRec."Purchasing Code") then begin
            if not EmptyProc then begin
                pRec."Item Category Code" := pRec."Purchasing Code";
                SalesLineTemp := pRec;
            end
            else begin
                pRec."Item Category Code" := '';
                if lItem.Get(pRec."No.") then
                    pRec."Item Category Code" := lItem."Purchasing Code";
                SalesLineTemp := pRec;
                SalesLineTemp."Purchasing Code" := '';
            end;
        end;

        if (pRec.Type = pRec.Type::Item) and (pxRec."Vendor No." <> pRec."Vendor No.") then begin
            if not EmptyVendor or (pRec."Vendor No." <> '') then begin
                EmptyVendor := false;
                //SalesOverheadUpdateVendor(TotalNeedParam.Type::Item,pRec."Vendor No.",EmptyVendor);
                pRec."Bill-to Customer No." := pRec."Vendor No.";
                SalesLineTemp := pRec;
            end
            else begin
                pRec."Bill-to Customer No." := '';
                SalesLineTemp := pRec;
                SalesLineTemp."Vendor No." := '';
            end;
        end;

        if pxRec."Unit Cost" <> pRec."Unit Cost" then begin
            if not Empty then begin
                pRec."Unit Cost (LCY)" := pRec."Unit Cost";
                pRec."Total Cost (LCY)" := pRec."Unit Cost (LCY)" * pRec."Quantity (Base)";
                SalesLineTemp := pRec;
            end
            else begin
                //FindUnitCost(pRec);
                pRec."Total Cost (LCY)" := pRec."Unit Cost (LCY)" * pRec."Quantity (Base)";
                SalesLineTemp := pRec;
                SalesLineTemp."Unit Cost" := 0;
            end;
        end;

        if SalesLineTemp.Modify then;
        exit(false);
    end;
}

