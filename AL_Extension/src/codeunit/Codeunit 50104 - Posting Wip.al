codeunit 52048899 "Posting Wip"
{
    TableNo = "WIP Report Header";
    trigger OnRun()
    begin
        PostWipReport(Rec);
    end;

    procedure PostWipReport(WipReportHeader: Record "WIP Report Header")
    var
        Text001: Label 'Do you want to post the project report?';
        Text002: Label 'You must enter the quantity for the line %1';
        Text003: Label 'You must enter the Number of days for the equipment %1';
        Text004: Label 'You must enter the Quantity Consumed for the item %1';
        CduTypeHelper: Codeunit "Type Helper";
        CduJobJnlPost: Codeunit "Job Jnl.-Post";
    begin
        //  CduTypeHelper.TransferFieldsWithValidate(WipReportHeader, JobJournalLine);

        WipReportHeader.TestField(Status, WipReportHeader.Status::Open);
        if Confirm(Text001) then begin
            if JobSetup.Get() then begin
                WipReportLine.Reset();
                WipReportLine.SetRange("WIP Report No.", WipReportHeader."No.");
                if WipReportLine.FindSet() then begin
                    repeat
                        JobJournalLine.Init();
                        JobJournalLine.TransferFields(WipReportLine);
                        //  JobJournalLine.Validate("No.", WipReportLine."No.");
                        JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
                        JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
                        JobJournalLine."Document No." := WipReportHeader."No.";
                        JobJournalLine."Posting Date" := WipReportHeader."Ending date";
                        JobJournalLine."Document Date" := Today();
                        JobJournalLine."From WIP" := true;
                        if WipReportLine.Quantity = 0 then
                            Error(Text002, WipReportLine."Line No.")
                        else
                            JobJournalLine.Insert(true);
                    until WipReportLine.Next() = 0;
                end;
                WipReportLine.Reset();
                WipReportLine.SetRange("WIP Report No.", WipReportHeader."No.");
                if WipReportLine.FindLast() then
                    IntLineNo := WipReportLine."Line No." + 10000
                else
                    IntLineNo := 10000;
                //New

                // JobRepLine.Reset();
                // JobRepLine.SetAutoCalcFields("Resource No.");
                // JobRepLine.SetRange("WIP Report No.", WipReportHeader."No.");
                // JobRepLine.SetRange(Resource, JobRepLine.Resource::Supply);
                // if JobRepLine.FindSet() then begin
                //     repeat
                //         JobJournalLine.Init();
                //         JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
                //         JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
                //         JobJournalLine."Document No." := WipReportHeader."No.";
                //         JobJournalLine."Posting Date" := WipReportHeader."Ending date";
                //         JobJournalLine."Document Date" := Today();
                //         JobJournalLine."Line No." := IntLineNo;
                //         JobJournalLine.Validate("Job No.", WipReportHeader."Job No.");
                //         JobJournalLine.Validate("Job Task No.", WipReportHeader."Job Task No.");
                //         JobJournalLine.Type := JobJournalLine.Type::Item;
                //         JobJournalLine."From WIP" := true;
                //         JobJournalLine.Validate("No.", JobRepLine.Product);
                //         //
                //         //JobJournalLine.Validate("Job Planning Line No.", JobRepLine."Job Planning Line No.");
                //         JobJournalLine."Job Planning Line No." := JobRepLine."Job Planning Line No.";
                //         if JobJournalLine."Job Planning Line No." <> 0 then begin
                //             ValidateJobPlanningLineLink(WipReportHeader."Job No.", WipReportHeader."Job Task No.",
                //            JobRepLine."Job Planning Line No.", JobSetup."Journal Template Name", JobSetup."Job Journal Batch", IntLineNo);
                //             JobPlanningLine.Get(WipReportHeader."Job No.", WipReportHeader."Job Task No.", JobRepLine."Job Planning Line No.");
                //             JobPlanningLine.TestField("Job No.", JobJournalLine."Job No.");
                //             JobPlanningLine.TestField("Job Task No.", JobJournalLine."Job Task No.");
                //             JobPlanningLine.TestField(Type, JobJournalLine.Type);
                //             // JobPlanningLine.TestField("No.", "No.");
                //             JobPlanningLine.TestField("Usage Link", true);
                //             JobPlanningLine.TestField("System-Created Entry", false);
                //             JobPlanningLine."Line Type" := JobPlanningLine.ConvertToJobLineType();

                //             if (JobPlanningLine."Location Code" <> '') then
                //                 JobJournalLine."Location Code" := JobPlanningLine."Location Code";
                //             if (JobPlanningLine."Bin Code" <> '') then
                //                 JobJournalLine."Bin Code" := JobPlanningLine."Bin Code";
                //             JobJournalLine.Validate("Remaining Qty.", CalcQtyFromBaseQty(JobPlanningLine."Remaining Qty. (Base)" - JobJournalLine."Quantity (Base)", JobJournalLine));
                //             JobJournalLine."Assemble to Order" := JobPlanningLine."Assemble to Order";
                //             if JobJournalLine.Quantity > 0 then
                //                 JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                //         end else
                //             JobJournalLine.Validate("Remaining Qty.", 0);
                //         // end;
                //         //JobJournalLine.Validate(Quantity, JobRepLine."Total Hours");
                //         JobJournalLine.Quantity := JobRepLine."Quantity Consumed";
                //         JobJournalLine.Quantity := UOMMgt.RoundAndValidateQty(JobJournalLine.Quantity, JobJournalLine."Qty. Rounding Precision", JobJournalLine.FieldCaption(Quantity));
                //         JobJournalLine."Quantity (Base)" := CalcBaseQty(JobJournalLine.Quantity, JobJournalLine.FieldCaption(Quantity), JobJournalLine.FieldCaption("Quantity (Base)"), JobJournalLine);
                //         JobJournalLine.UpdateAllAmounts();
                //         JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                //         if JobJournalLine."Job Planning Line No." <> 0 then begin
                //             if JobJournalLine."Job Planning Line No." <> 0 then begin
                //                 ValidateJobPlanningLineLink(WipReportHeader."Job No.", WipReportHeader."Job Task No.",
                //                JobRepLine."Job Planning Line No.", JobSetup."Journal Template Name", JobSetup."Job Journal Batch", IntLineNo);
                //                 JobPlanningLine.Get(WipReportHeader."Job No.", WipReportHeader."Job Task No.", JobRepLine."Job Planning Line No.");
                //                 JobPlanningLine.TestField("Job No.", JobJournalLine."Job No.");
                //                 JobPlanningLine.TestField("Job Task No.", JobJournalLine."Job Task No.");
                //                 JobPlanningLine.TestField(Type, JobJournalLine.Type);
                //                 // JobPlanningLine.TestField("No.", "No.");
                //                 JobPlanningLine.TestField("Usage Link", true);
                //                 JobPlanningLine.TestField("System-Created Entry", false);
                //                 JobPlanningLine."Line Type" := JobPlanningLine.ConvertToJobLineType();

                //                 if (JobPlanningLine."Location Code" <> '') then
                //                     JobJournalLine."Location Code" := JobPlanningLine."Location Code";
                //                 if (JobPlanningLine."Bin Code" <> '') then
                //                     JobJournalLine."Bin Code" := JobPlanningLine."Bin Code";
                //                 JobJournalLine.Validate("Remaining Qty.", CalcQtyFromBaseQty(JobPlanningLine."Remaining Qty. (Base)" - JobJournalLine."Quantity (Base)", JobJournalLine));
                //                 JobJournalLine."Assemble to Order" := JobPlanningLine."Assemble to Order";
                //                 if JobJournalLine.Quantity > 0 then
                //                     JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                //             end else
                //                 JobJournalLine.Validate("Remaining Qty.", 0);

                //         end;
                //         JobJournalLine.CheckItemAvailable();
                //         /*  if JobJournalLine.Type = JobJournalLine.Type::Item then
                //               if Item."Item Tracking Code" <> '' then
                //                   ReserveJobJnlLine.VerifyQuantity(Rec, xRec);*/
                //         ////////////////////////////////////////////////////////////////////////
                //         if JobRepLine."Quantity Consumed" = 0 then
                //             Error(Text004, JobRepLine.Product)
                //         else
                //             JobJournalLine.Insert(true);
                //         IntLineNo := IntLineNo + 10000;
                //     until JobRepLine.Next() = 0;
                // end;*/


                //new
                JobRepLine.Reset();
                JobRepLine.SetAutoCalcFields("Resource No.");
                JobRepLine.SetRange("WIP Report No.", WipReportHeader."No.");
                JobRepLine.SetRange(Resource, JobRepLine.Resource::Equipment);
                if JobRepLine.FindSet() then begin
                    repeat
                        JobJournalLine.Init();
                        JobJournalLine."Journal Template Name" := JobSetup."Journal Template Name";
                        JobJournalLine."Journal Batch Name" := JobSetup."Job Journal Batch";
                        JobJournalLine."Document No." := WipReportHeader."No.";
                        JobJournalLine."Posting Date" := WipReportHeader."Ending date";
                        JobJournalLine."Document Date" := Today();
                        JobJournalLine."Line No." := IntLineNo;
                        JobJournalLine.Validate("Job No.", WipReportHeader."Job No.");
                        JobJournalLine.Validate("Job Task No.", WipReportHeader."Job Task No.");
                        JobJournalLine.Type := JobJournalLine.Type::Resource;
                        JobJournalLine."From WIP" := true;
                        JobJournalLine.Validate("No.", JobRepLine."Resource No.");
                        //
                        //JobJournalLine.Validate("Job Planning Line No.", JobRepLine."Job Planning Line No.");
                        JobJournalLine."Job Planning Line No." := JobRepLine."Job Planning Line No.";
                        if JobJournalLine."Job Planning Line No." <> 0 then begin
                            ValidateJobPlanningLineLink(WipReportHeader."Job No.", WipReportHeader."Job Task No.",
                           JobRepLine."Job Planning Line No.", JobSetup."Journal Template Name", JobSetup."Job Journal Batch", IntLineNo);
                            JobPlanningLine.Get(WipReportHeader."Job No.", WipReportHeader."Job Task No.", JobRepLine."Job Planning Line No.");
                            JobPlanningLine.TestField("Job No.", JobJournalLine."Job No.");
                            JobPlanningLine.TestField("Job Task No.", JobJournalLine."Job Task No.");
                            JobPlanningLine.TestField(Type, JobJournalLine.Type);
                            // JobPlanningLine.TestField("No.", "No.");
                            JobPlanningLine.TestField("Usage Link", true);
                            JobPlanningLine.TestField("System-Created Entry", false);
                            JobPlanningLine."Line Type" := JobPlanningLine.ConvertToJobLineType();

                            if (JobPlanningLine."Location Code" <> '') then
                                JobJournalLine."Location Code" := JobPlanningLine."Location Code";
                            if (JobPlanningLine."Bin Code" <> '') then
                                JobJournalLine."Bin Code" := JobPlanningLine."Bin Code";
                            JobJournalLine.Validate("Remaining Qty.", CalcQtyFromBaseQty(JobPlanningLine."Remaining Qty. (Base)" - JobJournalLine."Quantity (Base)", JobJournalLine));
                            JobJournalLine."Assemble to Order" := JobPlanningLine."Assemble to Order";
                            if JobJournalLine.Quantity > 0 then
                                JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                        end else
                            JobJournalLine.Validate("Remaining Qty.", 0);
                        // end;
                        //JobJournalLine.Validate(Quantity, JobRepLine."Total Hours");
                        JobJournalLine.Quantity := JobRepLine."Total Hours";
                        JobJournalLine.Quantity := UOMMgt.RoundAndValidateQty(JobJournalLine.Quantity, JobJournalLine."Qty. Rounding Precision", JobJournalLine.FieldCaption(Quantity));
                        JobJournalLine."Quantity (Base)" := CalcBaseQty(JobJournalLine.Quantity, JobJournalLine.FieldCaption(Quantity), JobJournalLine.FieldCaption("Quantity (Base)"), JobJournalLine);
                        JobJournalLine.UpdateAllAmounts();
                        JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                        if JobJournalLine."Job Planning Line No." <> 0 then begin
                            if JobJournalLine."Job Planning Line No." <> 0 then begin
                                ValidateJobPlanningLineLink(WipReportHeader."Job No.", WipReportHeader."Job Task No.",
                               JobRepLine."Job Planning Line No.", JobSetup."Journal Template Name", JobSetup."Job Journal Batch", IntLineNo);
                                JobPlanningLine.Get(WipReportHeader."Job No.", WipReportHeader."Job Task No.", JobRepLine."Job Planning Line No.");
                                JobPlanningLine.TestField("Job No.", JobJournalLine."Job No.");
                                JobPlanningLine.TestField("Job Task No.", JobJournalLine."Job Task No.");
                                JobPlanningLine.TestField(Type, JobJournalLine.Type);
                                // JobPlanningLine.TestField("No.", "No.");
                                JobPlanningLine.TestField("Usage Link", true);
                                JobPlanningLine.TestField("System-Created Entry", false);
                                JobPlanningLine."Line Type" := JobPlanningLine.ConvertToJobLineType();

                                if (JobPlanningLine."Location Code" <> '') then
                                    JobJournalLine."Location Code" := JobPlanningLine."Location Code";
                                if (JobPlanningLine."Bin Code" <> '') then
                                    JobJournalLine."Bin Code" := JobPlanningLine."Bin Code";
                                JobJournalLine.Validate("Remaining Qty.", CalcQtyFromBaseQty(JobPlanningLine."Remaining Qty. (Base)" - JobJournalLine."Quantity (Base)", JobJournalLine));
                                JobJournalLine."Assemble to Order" := JobPlanningLine."Assemble to Order";
                                if JobJournalLine.Quantity > 0 then
                                    JobJnlLineVerifyChangeForWhsePick(JobJournalLine);
                            end else
                                JobJournalLine.Validate("Remaining Qty.", 0);

                        end;
                        JobJournalLine.CheckItemAvailable();
                        /*  if JobJournalLine.Type = JobJournalLine.Type::Item then
                              if Item."Item Tracking Code" <> '' then
                                  ReserveJobJnlLine.VerifyQuantity(Rec, xRec);*/
                        ////////////////////////////////////////////////////////////////////////
                        if JobRepLine."Total Hours" = 0 then
                            Error(Text003, JobRepLine.Equipment)
                        else
                            JobJournalLine.Insert(true);
                        IntLineNo := IntLineNo + 10000;
                    until JobRepLine.Next() = 0;
                end;
            end;
            CODEUNIT.Run(CODEUNIT::"Job Jnl.-Post From wip", JobJournalLine);
            WipReportHeader.Status := WipReportHeader.Status::Released;
            WipReportHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Job Jnl.-Post", OnCodeOnBeforeConfirm, '', false, false)]

    local procedure OnCodeOnBeforeConfirm(JobJnlLine: Record "Job Journal Line"; var IsHandled: Boolean)
    begin
        if JobJnlLine."From WIP" then
            IsHandled := true;
    end;

    local procedure CalcBaseQty(Qty: Decimal; FromFieldName: Text; ToFieldName: Text; JobJnlIne: Record "Job Journal Line"): Decimal
    begin
        exit(UOMMgt.CalcBaseQty(
            JobJnlIne."No.", JobJnlIne."Variant Code", JobJnlIne."Unit of Measure Code", Qty, JobJnlIne."Qty. per Unit of Measure", JobJnlIne."Qty. Rounding Precision (Base)", JobJnlIne.FieldCaption("Qty. Rounding Precision"), FromFieldName, ToFieldName));
    end;

    internal procedure JobJnlLineVerifyChangeForWhsePick(var NewJobJnlLine: Record "Job Journal Line")
    var
        JobPlanningLine: Record "Job Planning Line";
        QtyRemainingToBePicked: Decimal;
    begin
        if IsWhsePickRequiredForJobJnlLine(NewJobJnlLine) and (NewJobJnlLine.Quantity > 0) then
            if JobPlanningLine.Get(NewJobJnlLine."Job No.", NewJobJnlLine."Job Task No.", NewJobJnlLine."Job Planning Line No.") and (NewJobJnlLine.Quantity >= 0) then begin
                QtyRemainingToBePicked := NewJobJnlLine.Quantity + JobPlanningLine."Qty. Posted" - JobPlanningLine."Qty. Picked" - JobPlanningLine."Qty. to Assemble";
                CheckQtyRemainingToBePickedForJob(NewJobJnlLine, QtyRemainingToBePicked);
            end;
    end;

    local procedure CheckQtyRemainingToBePickedForJob(NewJobJnlLine: Record "Job Journal Line"; QtyRemainingToBePicked: Decimal)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCheckQtyRemainingToBePickedForJob(NewJobJnlLine, QtyRemainingToBePicked, IsHandled);
        if IsHandled then
            exit;

        if QtyRemainingToBePicked > 0 then
            Error(JobPostQtyPickRemainErr, NewJobJnlLine."Job No.", QtyRemainingToBePicked);
    end;

    internal procedure IsWhsePickRequiredForJobJnlLine(var JobJournalLine: Record "Job Journal Line"): Boolean
    var
        Item: Record Item;
    begin
        if (JobJournalLine."Line Type" in [JobJournalLine."Line Type"::Budget, JobJournalLine."Line Type"::"Both Budget and Billable"]) and (JobJournalLine.Type = JobJournalLine.Type::Item) then
            if RequireWarehousePicking(JobJournalLine) then
                if Item.Get(JobJournalLine."No.") then
                    if Item.IsInventoriableType() then
                        exit(true);
    end;

    local procedure RequireWarehousePicking(var JobJournalLine: Record "Job Journal Line"): Boolean
    var
        Location: Record Location;
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if Location.Get(JobJournalLine."Location Code") then
            exit(Location."Job Consump. Whse. Handling" = Enum::"Job Consump. Whse. Handling"::"Warehouse Pick (mandatory)");
        WarehouseSetup.Get();
        exit(WarehouseSetup."Require Pick" and WarehouseSetup."Require Shipment");
    end;

    local procedure CalcQtyFromBaseQty(BaseQty: Decimal; JobJournalLine: Record "Job Journal Line"): Decimal
    begin
        JobJournalLine.TestField("Qty. per Unit of Measure");
        exit(Round(BaseQty / JobJournalLine."Qty. per Unit of Measure", UOMMgt.QtyRndPrecision()));
    end;

    local procedure ValidateJobPlanningLineLink("Job No.": Code[20]; "Job Task No.": Code[20]; "Job Planning Line No.": Integer; "Journal Template Name": Code[10]; "Journal Batch Name": Code[10]; "Line No.": Integer)
    var
        JobPlanningLine: Record "Job Planning Line";
        JobJournalLine: Record "Job Journal Line";
        Text007: Label '%1 %2 is already linked to %3 %4. Hence %5 cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?', Comment = 'Project Journal Line project DEFAULT 30000 is already linked to Project Planning Line  DEERFIELD, 8 WP 1120 10000. Hence Remaining Qty. cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?';

    begin
        JobJournalLine.SetRange("Job No.", "Job No.");
        JobJournalLine.SetRange("Job Task No.", "Job Task No.");
        JobJournalLine.SetRange("Job Planning Line No.", "Job Planning Line No.");

        if JobJournalLine.FindFirst() then
            if ("Journal Template Name" <> JobJournalLine."Journal Template Name") or
               ("Journal Batch Name" <> JobJournalLine."Journal Batch Name") or
               ("Line No." <> JobJournalLine."Line No.")
            then begin
                JobPlanningLine.Get("Job No.", "Job Task No.", "Job Planning Line No.");
                if not Confirm(Text007, false,

                     StrSubstNo('%1, %2, %3', "Journal Template Name", "Journal Batch Name", "Line No."),
                     JobPlanningLine.TableCaption(),
                     StrSubstNo('%1, %2, %3', JobPlanningLine."Job No.", JobPlanningLine."Job Task No.", JobPlanningLine."Line No.")
                     )
                then
                    Error('');
            end;
    end;


    var
        JobSetup: Record "Jobs Setup";
        JobJournalLine: Record "Job Journal Line";
        WipReportLine: Record "WIP Report Line";
        JobRepLine: Record "Job Report Line";
        IntLineNo: Integer;
        JobPlanningLine: Record "Job Planning Line";
        UOMMgt: Codeunit "Unit of Measure Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        JobPostQtyPickRemainErr: Label 'You cannot post usage for project number %1 because a quantity of %2 remains to be picked.', Comment = '%1 = Project number, %2 = remaining quantity to pick';

}