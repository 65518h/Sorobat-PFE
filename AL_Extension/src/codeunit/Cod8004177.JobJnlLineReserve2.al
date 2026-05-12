Codeunit 8004177 "Job Jnl. Line-Reserve2"
{
    Permissions = TableData "Reservation Entry" = rimd;

    trigger OnRun()
    begin
    end;

    var
        Text002: label 'must be filled in when a quantity is reserved.';
        Text004: label 'must not be changed when a quantity is reserved.';
        ReservMgt: Codeunit "Reservation Management";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        Blocked: Boolean;
        DeleteItemTracking: Boolean;


    procedure FilterReservFor(var FilterReservEntry: Record "Reservation Entry"; JobJnlLine: Record "Job Journal Line")
    begin
        FilterReservEntry.SetRange("Source Type", Database::"Job Journal Line");
        FilterReservEntry.SetRange("Source Subtype", JobJnlLine."Entry Type");
        FilterReservEntry.SetRange("Source ID", JobJnlLine."Journal Template Name");
        FilterReservEntry.SetRange("Source Batch Name", JobJnlLine."Journal Batch Name");
        FilterReservEntry.SetRange("Source Prod. Order Line", 0);
        FilterReservEntry.SetRange("Source Ref. No.", JobJnlLine."Line No.");
    end;


    procedure FindReservEntry(JobJnlLine: Record "Job Journal Line"; var ReservEntry: Record "Reservation Entry"): Boolean
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, false);
        FilterReservFor(ReservEntry, JobJnlLine);
        exit(ReservEntry.Find('+'));
    end;


    procedure ReservEntryExist2(JobJnlLine: Record "Job Journal Line"): Boolean
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, false);
        FilterReservFor(ReservEntry, JobJnlLine);
        ReservEntry.SetRange("Serial No."); // Ignore Serial No
        ReservEntry.SetRange("Lot No."); // Ignore Lot No

        exit(not ReservEntry.IsEmpty);
    end;


    procedure VerifyChange(var NewJobJnlLine: Record "Job Journal Line"; var OldJobJnlLine: Record "Job Journal Line")
    var
        JobJnlLine: Record "Job Journal Line";
        TempReservEntry: Record "Reservation Entry";
        ItemTrackManagement: Codeunit "Item Tracking Management";
        ShowError: Boolean;
        HasError: Boolean;
        SNRequired: Boolean;
        LNRequired: Boolean;
        PointerChanged: Boolean;
    begin
        if Blocked then
            exit;
        if NewJobJnlLine."Line No." = 0 then
            if not JobJnlLine.Get(
                 NewJobJnlLine."Journal Template Name",
                 NewJobJnlLine."Journal Batch Name",
                 NewJobJnlLine."Line No.")
            then
                exit;

        NewJobJnlLine.CalcFields("Reserved Qty. (Base)");
        ShowError := NewJobJnlLine."Reserved Qty. (Base)" <> 0;
        SNRequired := false;
        LNRequired := false;

        if NewJobJnlLine."Posting Date" = 0D then
            if not ShowError then
                HasError := true
            else
                NewJobJnlLine.FieldError("Posting Date", Text002);

        if NewJobJnlLine."Job No." <> OldJobJnlLine."Job No." then
            if not ShowError then
                HasError := true
            else
                NewJobJnlLine.FieldError("Job No.", Text004);

        if NewJobJnlLine."Entry Type" <> OldJobJnlLine."Entry Type" then
            if not ShowError then
                HasError := true
            else
                NewJobJnlLine.FieldError("Entry Type", Text004);

        if NewJobJnlLine."Location Code" <> OldJobJnlLine."Location Code" then
            if not ShowError then
                HasError := true
            else
                NewJobJnlLine.FieldError("Location Code", Text004);

        if NewJobJnlLine."Bin Code" <> OldJobJnlLine."Bin Code" then begin
            //GL2024    ItemTrackManagement.CheckWhseItemTrkgSetup(NewJobJnlLine."Job No.", SNRequired, LNRequired, false);
            if SNRequired or LNRequired then
                if not ShowError then
                    HasError := true
                else
                    NewJobJnlLine.FieldError("Bin Code", Text004);
        end;

        if NewJobJnlLine."Variant Code" <> OldJobJnlLine."Variant Code" then
            if not ShowError then
                HasError := true
            else
                NewJobJnlLine.FieldError("Variant Code", Text004);

        if NewJobJnlLine."Line No." <> OldJobJnlLine."Line No." then
            HasError := true;

        if NewJobJnlLine."No." <> OldJobJnlLine."No." then
            HasError := true;

        if HasError then begin
            FindReservEntry(NewJobJnlLine, TempReservEntry);
            TempReservEntry.SetRange("Serial No.");
            TempReservEntry.SetRange("Lot No.");

            PointerChanged := (NewJobJnlLine."Job No." <> OldJobJnlLine."Job No.") or
              (NewJobJnlLine."Entry Type" <> OldJobJnlLine."Entry Type") or
              (NewJobJnlLine."No." <> OldJobJnlLine."No.");

            if PointerChanged or
               (not TempReservEntry.IsEmpty)
            then begin
                if PointerChanged then begin
                    //GL2024ReservMgt.SetJobJnlLine(OldJobJnlLine);
                    ReservMgt.DeleteReservEntries(true, 0);
                    //GL2024   ReservMgt.SetJobJnlLine(NewJobJnlLine);
                end else begin
                    //GL2024  ReservMgt.SetJobJnlLine(NewJobJnlLine);
                    ReservMgt.DeleteReservEntries(true, 0);
                end;
                ReservMgt.AutoTrack(NewJobJnlLine."Quantity (Base)");
            end;
        end;
    end;


    procedure VerifyQuantity(var NewJobJnlLine: Record "Job Journal Line"; var OldJobJnlLine: Record "Job Journal Line")
    var
        JobJnlLine: Record "Job Journal Line";
    begin
        if Blocked then
            exit;

        with NewJobJnlLine do begin
            if "Line No." = OldJobJnlLine."Line No." then
                if "Quantity (Base)" = OldJobJnlLine."Quantity (Base)" then
                    exit;
            if "Line No." = 0 then
                if not JobJnlLine.Get("Journal Template Name", "Journal Batch Name", "Line No.") then
                    exit;
            //GL2024  ReservMgt.SetJobJnlLine(NewJobJnlLine);
            if "Qty. per Unit of Measure" <> OldJobJnlLine."Qty. per Unit of Measure" then
                ReservMgt.ModifyUnitOfMeasure;
            if "Quantity (Base)" * OldJobJnlLine."Quantity (Base)" < 0 then
                ReservMgt.DeleteReservEntries(true, 0)
            else
                ReservMgt.DeleteReservEntries(false, "Quantity (Base)");
        end;
    end;


    procedure RenameLine(var NewJobJnlLine: Record "Job Journal Line"; var OldJobJnlLine: Record "Job Journal Line")
    begin
        ReservEngineMgt.RenamePointer(Database::"Job Journal Line",
          OldJobJnlLine."Entry Type",
          OldJobJnlLine."Journal Template Name",
          OldJobJnlLine."Journal Batch Name",
          0,
          OldJobJnlLine."Line No.",
          NewJobJnlLine."Entry Type",
          NewJobJnlLine."Journal Template Name",
          NewJobJnlLine."Journal Batch Name",
          0,
          NewJobJnlLine."Line No.");
    end;


    procedure DeleteLineConfirm(var JobJnlLine: Record "Job Journal Line"): Boolean
    begin
        with JobJnlLine do begin
            if not ReservEntryExist2(JobJnlLine) then
                exit(true);

            //GL2024   ReservMgt.SetJobJnlLine(JobJnlLine);
            if ReservMgt.DeleteItemTrackingConfirm then
                DeleteItemTracking := true;
        end;

        exit(DeleteItemTracking);
    end;


    procedure DeleteLine(var JobJnlLine: Record "Job Journal Line")
    begin
        if Blocked then
            exit;

        with JobJnlLine do
            if Type = Type::Item then begin
                //GL2024  ReservMgt.SetJobJnlLine(JobJnlLine);
                if DeleteItemTracking then
                    ReservMgt.SetItemTrackingHandling(1); // Allow Deletion
                ReservMgt.DeleteReservEntries(true, 0);
            end;
    end;


    procedure AssignForPlanning(var JobJnlLine: Record "Job Journal Line")
    var
        PlanningAssignment: Record "Planning Assignment";
    begin
        if JobJnlLine."No." <> '' then
            with JobJnlLine do
                PlanningAssignment.ChkAssignOne("No.", "Variant Code", "Location Code", "Posting Date");
    end;


    procedure Block(SetBlocked: Boolean)
    begin
        Blocked := SetBlocked;
    end;


    procedure CallItemTracking(var JobJnlLine: Record "Job Journal Line"; IsReclass: Boolean)
    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: Page "Item Tracking Lines";
    begin
        InitTrackingSpecification(JobJnlLine, TrackingSpecification);
        //GL2024  if IsReclass then
        //GL2024  ItemTrackingForm.SetFormRunMode(1);
        //GL2024 ItemTrackingForm.SetSource(TrackingSpecification, JobJnlLine."Posting Date");
        ItemTrackingFORM.RunModal;
    end;


    procedure InitTrackingSpecification(var JobJnlLine: Record "Job Journal Line"; var TrackingSpecification: Record "Tracking Specification")
    begin
        TrackingSpecification.Init;
        TrackingSpecification."Source Type" := Database::"Job Journal Line";
        with JobJnlLine do begin
            TrackingSpecification."Item No." := "No.";
            TrackingSpecification."Location Code" := "Location Code";
            TrackingSpecification.Description := Description;
            TrackingSpecification."Variant Code" := "Variant Code";
            TrackingSpecification."Source Subtype" := "Entry Type";
            TrackingSpecification."Source ID" := "Journal Template Name";
            TrackingSpecification."Source Batch Name" := "Journal Batch Name";
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := "Line No.";
            TrackingSpecification."Quantity (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Handle" := Quantity;
            TrackingSpecification."Qty. to Handle (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Invoice" := Quantity;
            TrackingSpecification."Qty. to Invoice (Base)" := "Quantity (Base)";
            TrackingSpecification."Quantity Handled (Base)" := 0;
            TrackingSpecification."Quantity Invoiced (Base)" := 0;
            TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            TrackingSpecification."Bin Code" := "Bin Code";
        end;
    end;


    procedure TransJobJnlLineToItemJnlLine(var JobJnlLine: Record "Job Journal Line"; var ItemJnlLine: Record "Item Journal Line"; TransferQty: Decimal): Decimal
    var
        OldReservEntry: Record "Reservation Entry";
    begin
        if not FindReservEntry(JobJnlLine, OldReservEntry) then
            exit(TransferQty);
        OldReservEntry.Lock;
        // Handle Item Tracking on drop shipment:
        Clear(CreateReservEntry);

        ItemJnlLine.TestField("Item No.", JobJnlLine."No.");
        ItemJnlLine.TestField("Variant Code", JobJnlLine."Variant Code");
        ItemJnlLine.TestField("Location Code", JobJnlLine."Location Code");

        if TransferQty = 0 then
            exit;

        if ReservEngineMgt.InitRecordSet(OldReservEntry) then
            repeat
                OldReservEntry.TestField("Item No.", JobJnlLine."No.");
                OldReservEntry.TestField("Variant Code", JobJnlLine."Variant Code");
                OldReservEntry.TestField("Location Code", JobJnlLine."Location Code");


                TransferQty := CreateReservEntry.TransferReservEntry(Database::"Item Journal Line",
                    ItemJnlLine."Entry Type", ItemJnlLine."Journal Template Name",
                    ItemJnlLine."Journal Batch Name", 0, ItemJnlLine."Line No.",
                    ItemJnlLine."Qty. per Unit of Measure", OldReservEntry, TransferQty);

            until (ReservEngineMgt.NEXTRecord(OldReservEntry) = 0) or (TransferQty = 0);

        exit(TransferQty);
    end;
}

