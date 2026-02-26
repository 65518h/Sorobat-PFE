Codeunit 8003982 "Subcontracting Management"
{
    // //SUBCONTRACTOR GESWAY 28/07/03 Nouveau Codeunit
    // //PERF AC 03/04/06


    trigger OnRun()
    begin
    end;

    var
        PurchLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
        StructureLine: Record "Sales Line";
        StructureMgt: Codeunit "Structure Management";
        SubSingleInstance: Codeunit "NaviBat SingleInstance";
        Update: Boolean;
        TextSubItem: label 'Check Item %1 from structure No. %2, line No. .';
        ErrorSubItem: label 'Check Item %1.';


    procedure UpdateFromPurchases(pRec: Record "Purchase Line"; pUpdate: Boolean)
    begin
        Update := pUpdate;

        PurchLine := pRec;
        if PurchLine."Sales Document Type" = PurchLine."sales document type"::" " then
            PurchLine."Sales Document Type" := PurchLine."sales document type"::Order;
        if PurchLine."Sales Order Line No." <> 0 then begin
            if not SalesLine.Get(PurchLine."Sales Document Type" - 1,
                                 PurchLine."Sales Order No.", PurchLine."Sales Order Line No.") then
                exit;
        end else
            if PurchLine."Special Order Sales Line No." <> 0 then
                if not SalesLine.Get(PurchLine."Sales Document Type" - 1,
                                     PurchLine."Special Order Sales No.", PurchLine."Special Order Sales Line No.") then
                    exit;

        UpdatePurchCost;
    end;


    procedure UpdateFromSales(pRec: Record "Sales Line"; pUpdate: Boolean)
    begin
        Update := pUpdate;

        SalesLine := pRec;
        if SalesLine."Purch. Order Line No." <> 0 then begin
            if not PurchLine.Get(SalesLine."Purchasing Document Type",
                                 SalesLine."Purchase Order No.", SalesLine."Purch. Order Line No.") then
                exit;
        end else
            if SalesLine."Special Order Purch. Line No." <> 0 then
                if not PurchLine.Get(SalesLine."Purchasing Document Type",
                                     SalesLine."Special Order Purchase No.", SalesLine."Special Order Purch. Line No.") then
                    exit;

        UpdatePurchCost;
    end;


    procedure UpdatePurchCost()
    var
        lxRec: Record "Sales Line";
    begin
        if SalesLine."Purchasing Order No." <> PurchLine."Document No." then      //Offre de prix
            exit;

        if (PurchLine."Unit Cost (LCY)" = SalesLine."Unit Cost (LCY)") then
            exit;

        with SalesLine do begin
            StructureLine.Get("Document Type", "Document No.", "Structure Line No.");
            if ("Line Type" = "line type"::Item) and ("Vendor No." <> '') and
               (Subcontracting <> Subcontracting::" ") then begin
                //(2425)    IF ((PurchLine."Document Type" <> PurchLine."Document Type"::Quote) OR Update) THEN BEGIN
                if Update then begin
                    "Unit Cost (LCY)" := PurchLine."Unit Cost (LCY)";
                    "Unit Cost" := PurchLine."Unit Cost";
                    Validate("Unit Cost (LCY)", PurchLine."Unit Cost (LCY)");
                    Modify;
                end;
                lxRec := StructureLine;
                StructureMgt.SumStructureLines(StructureLine);
                StructureLine.Modify;
                StructureLine.wUpdateLine(StructureLine, lxRec, false);
            end;
        end;
    end;


    procedure InsertSubExtendedText(var pPurchOrderLine: Record "Purchase Line"; pStructureLine: Record "Sales Line") LastLine: Integer
    var
        lSalesLine: Record "Sales Line";
        lPurchOrderLine: Record "Purchase Line";
        lPurchOrderLine2: Record "Purchase Line";
        lItem: Record Item;
        lTransferExtendedText: Codeunit "Transfer Extended Text";
        lInsertText: Boolean;
        lPurchDesc: Option Structure,Item,Both;
    begin
        lPurchDesc := SubSingleInstance.Get;

        Clear(lInsertText);

        with pPurchOrderLine do begin
            lPurchOrderLine := pPurchOrderLine;

            lSalesLine.Get(pStructureLine."Document Type", pStructureLine."Document No.", pStructureLine."Structure Line No.");
            if "Drop Shipment" then
                lPurchOrderLine."Sales Order Line No." := lSalesLine."Line No."
            else
                if "Special Order" then
                    lPurchOrderLine."Special Order Sales Line No." := lSalesLine."Line No.";
            lSalesLine."Purchasing Document Type" := pPurchOrderLine."Document Type";
            lSalesLine."Purchasing Order No." := pPurchOrderLine."Document No.";
            lSalesLine."Purchasing Order Line No." := pPurchOrderLine."Line No.";
            lSalesLine."Purchase Order No." := pPurchOrderLine."Document No.";
            lSalesLine."Purch. Order Line No." := pPurchOrderLine."Line No.";
            lSalesLine.Modify;
            if not lItem.Get("No.") then
                lItem.Init;

            case lPurchDesc of
                Lpurchdesc::Item:
                    begin
                        if lItem."Item Type" <> 0 then begin
                            pPurchOrderLine.Description := pStructureLine.Description;
                            pPurchOrderLine."Description 2" := pStructureLine."Description 2";
                            pPurchOrderLine.Modify;
                        end;
                        if "Purchasing Code" <> '' then
                            /*  //GL2024 lInsertText := lTransferExtendedText.wPurchasingCheckIfAnyAttText(lPurchOrderLine, pStructureLine."Line No.")
                             else*/
                            lInsertText := lTransferExtendedText.PurchCheckIfAnyExtText(lPurchOrderLine, false);
                    end;
                Lpurchdesc::Structure:
                    begin
                        pPurchOrderLine.Description := lSalesLine.Description;
                        pPurchOrderLine."Description 2" := lSalesLine."Description 2";
                        pPurchOrderLine.Modify;
                        //GL2024  lInsertText := lTransferExtendedText.wPurchasingCheckIfAnyAttText(lPurchOrderLine, lSalesLine."Line No.")
                    end;
                Lpurchdesc::Both:
                    begin
                        if lItem."Item Type" <> 0 then begin
                            pPurchOrderLine.Description := pStructureLine.Description;
                            pPurchOrderLine."Description 2" := pStructureLine."Description 2";
                            pPurchOrderLine.Modify;
                        end;
                        if "Purchasing Code" <> '' then
                            /*  //GL2024 lInsertText := lTransferExtendedText.wPurchasingCheckIfAnyAttText(lPurchOrderLine, pStructureLine."Line No.")
                         else*/
                            lInsertText := lTransferExtendedText.PurchCheckIfAnyExtText(lPurchOrderLine, false);
                        if lInsertText then
                            lTransferExtendedText.InsertPurchExtText(lPurchOrderLine);
                        //Insérer désignation + texte étendu ouvrage
                        Clear(lInsertText);
                        lPurchOrderLine2.SetRange("Document Type", lPurchOrderLine."Document Type");
                        lPurchOrderLine2.SetRange("Document No.", lPurchOrderLine."Document No.");
                        if lPurchOrderLine2.Find('+') then
                            LastLine := lPurchOrderLine2."Line No.";
                        lPurchOrderLine2.Init;
                        lPurchOrderLine2."Document Type" := lPurchOrderLine."Document Type";
                        lPurchOrderLine2."Document No." := lPurchOrderLine."Document No.";
                        lPurchOrderLine2."Line No." := LastLine + 10000;
                        lPurchOrderLine2.Validate(Type, 0);
                        lPurchOrderLine2.Description := lSalesLine.Description;
                        lPurchOrderLine2."Description 2" := lSalesLine."Description 2";
                        lPurchOrderLine2."Attached to Line No." := lPurchOrderLine."Line No.";
                        lPurchOrderLine2."Sales Order No." := lPurchOrderLine."Sales Order No.";
                        lPurchOrderLine2."Sales Order Line No." := lPurchOrderLine."Sales Order Line No.";
                        lPurchOrderLine2."Sales Document Type" := lPurchOrderLine."Sales Document Type";
                        if lPurchOrderLine2.Insert then begin
                            lPurchOrderLine := lPurchOrderLine2;
                            /*  //GL2024 if "Purchasing Code" <> '' then
                                  lInsertText := lTransferExtendedText.wPurchasingCheckIfAnyAttText(lPurchOrderLine, lSalesLine."Line No.");*/
                        end;
                        //#6787
                        lPurchOrderLine2."Sales Order No." := '';
                        lPurchOrderLine2."Sales Order Line No." := 0;
                        lPurchOrderLine2.Modify;
                        //#6787//
                    end;
            end;

            if lInsertText then
                lTransferExtendedText.InsertPurchExtText(lPurchOrderLine);
            lPurchOrderLine2.SetRange("Document Type", lPurchOrderLine."Document Type");
            lPurchOrderLine2.SetRange("Document No.", lPurchOrderLine."Document No.");
            if lPurchOrderLine2.Find('+') then
                LastLine := lPurchOrderLine2."Line No.";
        end;
        exit(LastLine);
    end;


    procedure CheckSubcontractingItem(var pSalesLine: Record "Sales Line"; pSubcontracting: Option " ","Furniture and Fixing",Fixing; pStructureLineNo: Code[20])
    var
        TextSubcontracting: label ' ,Furniture and Fixing,Fixing';
    begin
        if pSubcontracting = Psubcontracting::" " then
            exit;
        with pSalesLine do begin
            SetRange(Subcontracting, pSubcontracting);
            if IsEmpty then
                Error(TextSubItem,
                      SelectStr(pSubcontracting + 1, TextSubcontracting), pStructureLineNo,
                                pSalesLine.GetFilter(pSalesLine."Structure Line No."))
            else begin
                if Subcontracting = pSubcontracting then begin
                    if Disable then
                        pSalesLine."Disable Quantity" := 1
                    else
                        pSalesLine."Quantity per" := 1;
                end;
            end;
            SetRange(Subcontracting);
        end;
    end;


    procedure CheckStructure(pStructure: Record Resource)
    var
        lComponent: Record "Structure Component";
    begin
        with lComponent do
            if pStructure.Subcontracting <> pStructure.Subcontracting::" " then begin
                SetCurrentkey("Parent Structure No.");
                SetRange("Parent Structure No.", pStructure."No.");
                SetCurrentkey(Type);
                SetRange(Type, Type::Item);
                SetRange(Subcontracting, pStructure.Subcontracting);
                if IsEmpty then
                    Error(ErrorSubItem, pStructure.Subcontracting);
            end;
    end;


    procedure UpdateSubcontractor(var pRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lItem: Record Item;
        lVendor: Record Vendor;
    begin
        //MAJ fns sur ligne ouvrage
        if pRec.Subcontracting = 0 then
            exit;

        with lSalesLine do begin
            SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            SetRange("Document Type", pRec."Document Type");
            SetRange("Document No.", pRec."Document No.");
            SetRange("Structure Line No.", pRec."Line No.");
            SetRange("Line Type", "line type"::Item);
            SetRange(Disable, false);
            SetRange(Subcontracting, pRec.Subcontracting);
            if Find('-') then begin
                lItem.Get("No.");
                if lItem."Vendor No." <> '' then begin
                    lVendor.Get(lItem."Vendor No.");
                    if not lVendor.Subcontractor then
                        exit;
                    pRec.Validate("Vendor No.", lItem."Vendor No.");
                    pRec.Modify;
                end;
            end;
        end;
    end;


    procedure ItemUnitOfMeasure(pResNo: Code[20]; pItemNo: Code[20]; pUnitCode: Code[10])
    var
        lRes: Record Resource;
        lUnitOfMeasure: Record "Unit of Measure";
        lStructureComponent: Record "Structure Component";
        lItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        if pResNo <> '' then
            lRes.Get(pResNo);
        if (pUnitCode = '') and (lRes."Base Unit of Measure" = '') then
            exit;
        if pUnitCode = '' then
            pUnitCode := lRes."Base Unit of Measure";
        lUnitOfMeasure.Get(pUnitCode);
        if pItemNo = '' then begin
            lStructureComponent.SetRange("Parent Structure No.", lRes."No.");
            lStructureComponent.SetRange(Type, lStructureComponent.Type::Item);
            lStructureComponent.SetFilter(Subcontracting, '<>0');
            if not lStructureComponent.IsEmpty then begin
                lStructureComponent.Find('-');
                repeat
                    with lItemUnitOfMeasure do begin
                        SetRange("Item No.", lStructureComponent."No.");
                        SetRange(Code, pUnitCode);
                        if IsEmpty then begin
                            "Item No." := lStructureComponent."No.";
                            Code := pUnitCode;
                            "Qty. per Unit of Measure" := 1;
                            Insert;
                        end;
                    end;
                until lStructureComponent.Next = 0;
            end;
        end else begin
            with lItemUnitOfMeasure do begin
                SetRange("Item No.", pItemNo);
                SetRange(Code, pUnitCode);
                if IsEmpty then begin
                    "Item No." := pItemNo;
                    Code := pUnitCode;
                    "Qty. per Unit of Measure" := 1;
                    Insert;
                end;
            end;
        end;
    end;
}

