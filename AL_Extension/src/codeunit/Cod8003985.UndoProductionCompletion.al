Codeunit 8003985 "Undo Production Completion"
{
    // //NAVIONE AC 16/01/07 Codeunit permettant l'annulation de l'avancement en production

    Permissions = TableData "Sales Shipment Line" = imd;
    TableNo = "Sales Line";

    trigger OnRun()
    begin
        if rec.GetFilter("Document No.") <> '' then
            ProdCompletionEntry.SetRange("Order No.", rec."Document No.");

        ProdCompletionEntry.SetRange("Job No.", rec."Job No.");
        ProdCompletionEntry.SetRange(Canceled, false);
        if not ProdCompletionEntry.FindLast then
            Error(Text007);
        ProdCompletionEntry.SetRange("Order No.");
        ProdCompletionEntry.SetRange("Document No.", ProdCompletionEntry."Document No.");

        SalesShptLine.SetRange("Document No.", ProdCompletionEntry."Document No.");
        SalesShptLine.SetRange(Type, SalesShptLine.Type::Resource);
        if SalesShptLine.IsEmpty then
            Error(Text006);

        if not HideDialog then
            if not Confirm(Text000) then
                exit;

        //#9366
        fCtrlPurchaseLine(Rec);
        //#9366//

        Code;
    end;

    var
        HideDialog: Boolean;
        SalesShptLine: Record "Sales Shipment Line";
        Text000: label 'Do you really want to undo the selected Shipment lines?';
        Text001: label 'Undo quantity posting...';
        Text002: label 'There is not enough space to insert correction lines.';
        Text003: label 'Checking lines...';
        Text004: label 'Some shipment lines may have unused service items. Do you want to delete them?';
        Text006: label 'Undo Shipment can be performed only for lines of type Resource. Please select a line of the Item type and repeat the procedure.';
        ProdCompletionEntry: Record "Production Completion Entry";
        Text007: label 'There aren''t compeltion to cancel';
        NewSalesShptLine: Record "Sales Shipment Line";
        AdvJobBudgetEntry: Record "Advanced Job Budget Entry";
        Text008: label 'Undo Shipment can be performed on this completion.';
        Qty: Decimal;
        QtyBase: Decimal;


    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    local procedure "Code"()
    var
        ServItem: Record "Service Item";
        Window: Dialog;
        DeleteServItems: Boolean;
    begin
        with SalesShptLine do begin
            //  CLEAR(ItemJnlPostLine);
            SetRange(Correction, false);

            repeat
                if not HideDialog then
                    Window.Open(Text003);
                TestField("Drop Shipment", false);
            until Next = 0;

            Find('-');
            repeat
                if not HideDialog then
                    Window.Open(Text001);
                InsertNewShipmentLine(SalesShptLine);
                UpdateOrderLine(SalesShptLine);
                "Quantity Invoiced" := Quantity;
                "Qty. Invoiced (Base)" := "Quantity (Base)";
                "Qty. Shipped Not Invoiced" := 0;
                Correction := true;
                ProdCompletionEntry.SetRange("Document No.", "Document No.");
                ProdCompletionEntry.SetRange("Line No.", "Line No.");
                InsertNewCompletion(ProdCompletionEntry, NewSalesShptLine);
                Modify;
            until Next = 0;
            InsertNewAdvJobBudgetEntry(SalesShptLine);
        end;
    end;

    local procedure InsertNewShipmentLine(OldSalesShptLine: Record "Sales Shipment Line")
    var
        LineSpacing: Integer;
    begin
        with OldSalesShptLine do begin
            NewSalesShptLine.SetRange("Document No.", "Document No.");
            NewSalesShptLine."Document No." := "Document No.";
            NewSalesShptLine."Line No." := "Line No.";
            NewSalesShptLine.Find('=');

            if NewSalesShptLine.Find('>') then begin
                LineSpacing := (NewSalesShptLine."Line No." - "Line No.") DIV 2;
                if LineSpacing = 0 then
                    Error(Text002);
            end else
                LineSpacing := 10000;

            NewSalesShptLine.Reset;
            NewSalesShptLine.Init;
            NewSalesShptLine.Copy(OldSalesShptLine);
            NewSalesShptLine."Line No." := "Line No." + LineSpacing;
            NewSalesShptLine."Appl.-from Item Entry" := "Item Shpt. Entry No.";
            NewSalesShptLine.Quantity := -Quantity;
            NewSalesShptLine."Qty. Shipped Not Invoiced" := 0;
            NewSalesShptLine."Quantity (Base)" := -"Quantity (Base)";
            NewSalesShptLine."Quantity Invoiced" := NewSalesShptLine.Quantity;
            NewSalesShptLine."Qty. Invoiced (Base)" := NewSalesShptLine."Quantity (Base)";
            NewSalesShptLine.Correction := true;
            NewSalesShptLine.Insert;

            Qty := Quantity;
            QtyBase := "Quantity (Base)";

            //GL2024   CopyShipmentLineDimensions(OldSalesShptLine, NewSalesShptLine);

        end;
    end;

    local procedure InsertNewCompletion(var OldProdCompletionEntry: Record "Production Completion Entry"; pSalesShipmentLine: Record "Sales Shipment Line")
    var
        NewProdCompletionEntry: Record "Production Completion Entry";
        LineSpacing: Integer;
    begin
        with OldProdCompletionEntry do begin
            if IsEmpty then
                exit;
            FindFirst;

            "Document No." := "Document No.";
            Canceled := true;
            Modify;

            NewProdCompletionEntry.Reset;
            NewProdCompletionEntry.Init;
            NewProdCompletionEntry.Copy(OldProdCompletionEntry);

            NewProdCompletionEntry."Document No." := pSalesShipmentLine."Document No.";
            NewProdCompletionEntry."Line No." := pSalesShipmentLine."Line No.";

            NewProdCompletionEntry."Previous Completion %" := "New Completion %";
            NewProdCompletionEntry."New Completion %" := "Previous Completion %";
            NewProdCompletionEntry."Completion Difference (%)" := "Previous Completion %" - "New Completion %";
            NewProdCompletionEntry."Previous Quantity" := "New Quantity";
            NewProdCompletionEntry."New Quantity" := "Previous Quantity";
            NewProdCompletionEntry."Quantity Difference" := "Previous Quantity" - "New Quantity";
            NewProdCompletionEntry.Canceled := true;
            NewProdCompletionEntry.Insert(true);
        end;
    end;

    local procedure InsertNewAdvJobBudgetEntry(pSalesShipmentLine: Record "Sales Shipment Line")
    var
        NewAdvJobBudgetEntry: Record "Advanced Job Budget Entry";
        LineSpacing: Integer;
        OldAdvJobBudgetEntry: Record "Advanced Job Budget Entry";
    begin
        with OldAdvJobBudgetEntry do begin
            SetCurrentkey("Shipment No.");
            SetRange(OldAdvJobBudgetEntry."Shipment No.", SalesShptLine."Document No.");
            SetRange(Canceled, false);
            //#7237
            //  IF ISEMPTY THEN
            //    ERROR(Text008);
            //  FIND('-');
            if Find('-') then
                //#7237//
                repeat
                    Canceled := true;
                    Modify;
                    NewAdvJobBudgetEntry.Reset;
                    NewAdvJobBudgetEntry.Init;
                    NewAdvJobBudgetEntry.Copy(OldAdvJobBudgetEntry);
                    NewAdvJobBudgetEntry."Entry No." := SearchLastEntry + 1;
                    NewAdvJobBudgetEntry."Progress %" := -"Progress %";
                    NewAdvJobBudgetEntry.Quantity := -Quantity;
                    NewAdvJobBudgetEntry.Cost := -Cost;
                    NewAdvJobBudgetEntry.Price := -Price;
                    NewAdvJobBudgetEntry.Canceled := true;
                    NewAdvJobBudgetEntry.Insert(true);
                until Next = 0;
        end;
    end;

    local procedure UpdateOrderLine(SalesShptLine: Record "Sales Shipment Line")
    var
        SalesLine: Record "Sales Line";
    begin
        with SalesShptLine do begin
            SalesLine.Get(SalesLine."document type"::Order, "Order No.", "Order Line No.");
            //+REF+NAVISION
            SalesLine."Completely Shipped" := false;
            //+REF+NAVISION//
            UpdateSalesLine(SalesLine, Quantity, "Quantity (Base)");
        end;
    end;
    /*GL2024
        local procedure CopyShipmentLineDimensions(FromSalesShptLine: Record 111; ToSalesShptLine: Record 111)
        var
            ToPostedDocDim: Record 359;
            FromPostedDocDim: Record 359;
        begin
            FromPostedDocDim.SetRange("Table ID", Database::"Sales Shipment Line");
            FromPostedDocDim.SetRange("Document No.", FromSalesShptLine."Document No.");
            FromPostedDocDim.SetRange("Line No.", FromSalesShptLine."Line No.");

            if FromPostedDocDim.Find('-') then
                repeat
                    ToPostedDocDim.Copy(FromPostedDocDim);
                    ToPostedDocDim."Document No." := ToSalesShptLine."Document No.";
                    ToPostedDocDim."Line No." := ToSalesShptLine."Line No.";
                    ToPostedDocDim.Insert;
                until FromPostedDocDim.Next = 0;
        end;
    */

    procedure UpdateSalesLine(SalesLine: Record "Sales Line"; UndoQty: Decimal; UndoQtyBase: Decimal)
    var
        xSalesLine: Record "Sales Line";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        with SalesLine do begin
            xSalesLine := SalesLine;
            case "Document Type" of
                "document type"::"Return Order":
                    begin
                        "Return Qty. Received" := "Return Qty. Received" - UndoQty;
                        "Return Qty. Received (Base)" := "Return Qty. Received (Base)" - UndoQtyBase;
                        InitOutstanding;
                        InitQtyToReceive;
                    end;
                "document type"::Order:
                    begin
                        "Quantity Shipped" := "Quantity Shipped" - UndoQty;
                        "Qty. Shipped (Base)" := "Qty. Shipped (Base)" - UndoQtyBase;
                        InitOutstanding;
                        //InitQtyToShip;
                        SalesLine."Qty. to Ship" := UndoQty;
                        SalesLine."Qty. to Ship (Base)" := UndoQtyBase;
                        InitQtyToInvoice;
                    end;
                else
                    FieldError("Document Type");
            end;
            Modify;
            xSalesLine."Quantity (Base)" := 0;
        end;
    end;

    local procedure SearchLastEntry() EntryNo: Integer
    var
        lJobBudgetEntry: Record "Advanced Job Budget Entry";
    begin
        if not lJobBudgetEntry.Find('+') then
            EntryNo := 0
        else
            EntryNo := lJobBudgetEntry."Entry No.";
    end;


    procedure fUndoFromShipmentLine(var Rec: Record "Sales Line"; pSalesShptLine: Record "Sales Shipment Line")
    begin
        //#7232
        if Rec.GetFilter("Document No.") <> '' then
            ProdCompletionEntry.SetRange("Order No.", Rec."Document No.");

        ProdCompletionEntry.SetRange("Job No.", Rec."Job No.");
        ProdCompletionEntry.SetRange(Canceled, false);
        if not ProdCompletionEntry.FindLast then
            Error(Text007);
        ProdCompletionEntry.SetRange("Order No.");
        ProdCompletionEntry.SetRange("Document No.", ProdCompletionEntry."Document No.");

        SalesShptLine.SetRange("Document No.", pSalesShptLine."Document No.");
        SalesShptLine.SetRange("Line No.", pSalesShptLine."Line No.");

        if SalesShptLine.IsEmpty then
            Error(Text006);

        if not HideDialog then
            if not Confirm(Text000) then
                exit;

        Code;
        //#7232//
    end;


    procedure fCtrlPurchaseLine(FromSalesLine: Record "Sales Line")
    var
        lPurchaseLine: Record "Purchase Line";
        lSalesLine: Record "Sales Line";
        lText009: label 'There is  purchase reiception';
    begin
        //#9366
        lSalesLine.SetRange("Document Type", FromSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", FromSalesLine."Document No.");
        lSalesLine.SetRange("Purchasing Document Type", FromSalesLine."purchasing document type"::Order);
        lSalesLine.SetFilter("Purchasing Order No.", '<>%1', '');
        if lSalesLine.Find('-') then
            repeat
                if lPurchaseLine.Get(lSalesLine."Purchasing Document Type", lSalesLine."Purchasing Order No.",
                    lSalesLine."Purchasing Order Line No.") and (lPurchaseLine."Quantity Received" > 0) then
                    Error(StrSubstNo('%1 \%2 %3 %4 %5',
                      Text008, lText009, lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No."));
            until lSalesLine.Next = 0;
        //#9366//
    end;
}

