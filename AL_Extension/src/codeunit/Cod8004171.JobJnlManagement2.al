Codeunit 8004171 JobJnlManagement2
{
    Permissions = TableData "Job Journal Template" = imd,
                  TableData "Job Journal Batch" = imd;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'JOB';
        Text001: label 'Job Journal';
        Text002: label 'RECURRING';
        Text003: label 'Recurring Job Journal';
        Text004: label 'DEFAULT';
        Text005: label 'Default Journal';
        LastJobJnlLine: Record "Job Journal Line";
        OpenFromBatch: Boolean;


    procedure TemplateSelection(FormID: Integer; RecurringJnl: Boolean; var JobJnlLine: Record "Job Journal Line"; var JnlSelected: Boolean)
    var
        JobJnlTemplate: Record "Job Journal Template";
    begin
        JnlSelected := true;

        JobJnlTemplate.Reset;
        JobJnlTemplate.SetRange("Page ID", FormID);
        JobJnlTemplate.SetRange(Recurring, RecurringJnl);

        case JobJnlTemplate.Count of
            0:
                begin
                    JobJnlTemplate.Init;
                    JobJnlTemplate.Recurring := RecurringJnl;
                    if not RecurringJnl then begin
                        JobJnlTemplate.Name := Text000;
                        JobJnlTemplate.Description := Text001;
                    end else begin
                        JobJnlTemplate.Name := Text002;
                        JobJnlTemplate.Description := Text003;
                    end;
                    //#6138
                    //      JobJnlTemplate.VALIDATE("Form ID");
                    JobJnlTemplate.Validate(Recurring, RecurringJnl);
                    JobJnlTemplate.Validate("Page ID", FormID);
                    //#6138//
                    JobJnlTemplate.Insert;
                    Commit;
                end;
            1:
                JobJnlTemplate.Find('-');
            else
                JnlSelected := Page.RunModal(0, JobJnlTemplate) = Action::LookupOK;
        end;
        if JnlSelected then begin
            JobJnlLine.FilterGroup := 2;
            JobJnlLine.SetRange("Journal Template Name", JobJnlTemplate.Name);
            JobJnlLine.FilterGroup := 0;
            if OpenFromBatch then begin
                JobJnlLine."Journal Template Name" := '';
                PAGE.Run(JobJnlTemplate."Page ID", JobJnlLine);
            end;
        end;
    end;


    procedure TemplateSelectionFromBatch(var JobJnlBatch: Record "Job Journal Batch")
    var
        JobJnlLine: Record "Job Journal Line";
        JobJnlTemplate: Record "Job Journal Template";
        JnlSelected: Boolean;
    begin
        OpenFromBatch := true;
        JobJnlTemplate.Get(JobJnlBatch."Journal Template Name");
        JobJnlTemplate.TestField("Page ID");
        JobJnlBatch.TestField(Name);

        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Template Name", JobJnlTemplate.Name);
        JobJnlLine.FilterGroup := 0;

        JobJnlLine."Journal Template Name" := '';
        JobJnlLine."Journal Batch Name" := JobJnlBatch.Name;
        PAGE.Run(JobJnlTemplate."Page ID", JobJnlLine);
    end;


    procedure OpenJnl(var CurrentJnlBatchName: Code[10]; var JobJnlLine: Record "Job Journal Line")
    begin
        CheckTemplateName(JobJnlLine.GetRangemax("Journal Template Name"), CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Batch Name", CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 0;
    end;


    procedure OpenJnlBatch(var JobJnlBatch: Record "Job Journal Batch")
    var
        JobJnlTemplate: Record "Job Journal Template";
        JobJnlLine: Record "Job Journal Line";
        JobJnlBatch2: Record "Job Journal Batch";
        JnlSelected: Boolean;
    begin
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then
            exit;
        JobJnlBatch.FilterGroup(2);
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then begin
            JobJnlBatch.FilterGroup(0);
            exit;
        end;
        JobJnlBatch.FilterGroup(0);

        if not JobJnlBatch.Find('-') then begin
            if not JobJnlTemplate.Find('-') then
                TemplateSelection(0, false, JobJnlLine, JnlSelected);
            if JobJnlTemplate.Find('-') then
                CheckTemplateName(JobJnlTemplate.Name, JobJnlBatch.Name);
            JobJnlTemplate.SetRange(Recurring, true);
            if not JobJnlTemplate.Find('-') then
                TemplateSelection(0, true, JobJnlLine, JnlSelected);
            if JobJnlTemplate.Find('-') then
                CheckTemplateName(JobJnlTemplate.Name, JobJnlBatch.Name);
            JobJnlTemplate.SetRange(Recurring);
        end;
        JobJnlBatch.Find('-');
        JnlSelected := true;
        JobJnlBatch.CalcFields(Recurring);
        JobJnlTemplate.SetRange(Recurring, JobJnlBatch.Recurring);
        if JobJnlBatch.GetFilter("Journal Template Name") <> '' then
            JobJnlTemplate.SetRange(Name, JobJnlBatch.GetFilter("Journal Template Name"));
        case JobJnlTemplate.Count of
            1:
                JobJnlTemplate.Find('-');
            else
                JnlSelected := Page.RunModal(0, JobJnlTemplate) = Action::LookupOK;
        end;
        if not JnlSelected then
            Error('');

        JobJnlBatch.FilterGroup(2);
        JobJnlBatch.SetRange("Journal Template Name", JobJnlTemplate.Name);
        JobJnlBatch.FilterGroup(0);
    end;


    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10]; var CurrentJnlBatchName: Code[10])
    var
        JobJnlBatch: Record "Job Journal Batch";
    begin
        JobJnlBatch.SetRange("Journal Template Name", CurrentJnlTemplateName);
        if not JobJnlBatch.Get(CurrentJnlTemplateName, CurrentJnlBatchName) then begin
            if not JobJnlBatch.Find('-') then begin
                JobJnlBatch.Init;
                JobJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
                JobJnlBatch.SetupNewBatch;
                JobJnlBatch.Name := Text004;
                JobJnlBatch.Description := Text005;
                JobJnlBatch.Insert(true);
                Commit;
            end;
            CurrentJnlBatchName := JobJnlBatch.Name;
        end;
    end;


    procedure CheckName(CurrentJnlBatchName: Code[10]; var JobJnlLine: Record "Job Journal Line")
    var
        JobJnlBatch: Record "Job Journal Batch";
    begin
        JobJnlBatch.Get(JobJnlLine.GetRangemax("Journal Template Name"), CurrentJnlBatchName);
    end;


    procedure SetName(CurrentJnlBatchName: Code[10]; var JobJnlLine: Record "Job Journal Line")
    begin
        JobJnlLine.FilterGroup := 2;
        JobJnlLine.SetRange("Journal Batch Name", CurrentJnlBatchName);
        JobJnlLine.FilterGroup := 0;
        if JobJnlLine.Find('-') then;
    end;


    procedure LookupName(var CurrentJnlBatchName: Code[10]; var JobJnlLine: Record "Job Journal Line"): Boolean
    var
        JobJnlBatch: Record "Job Journal Batch";
    begin
        Commit;
        JobJnlBatch."Journal Template Name" := JobJnlLine.GetRangemax("Journal Template Name");
        JobJnlBatch.Name := JobJnlLine.GetRangemax("Journal Batch Name");
        JobJnlBatch.FilterGroup(2);
        JobJnlBatch.SetRange("Journal Template Name", JobJnlBatch."Journal Template Name");
        JobJnlBatch.FilterGroup(0);
        //#7480
        /*
        IF JobJnlBatch.COUNT = 1 THEN
           EXIT(TRUE);
        */
        //#7480//
        if Page.RunModal(0, JobJnlBatch) = Action::LookupOK then begin
            CurrentJnlBatchName := JobJnlBatch.Name;
            SetName(CurrentJnlBatchName, JobJnlLine);
            //#6696
            exit(true);
            //#6696//
        end;

    end;


    procedure GetNames(var JobJnlLine: Record "Job Journal Line"; var JobDescription: Text[100]; var AccName: Text[100])
    var
        Job: Record Job;
        Res: Record Resource;
        Item: Record Item;
        GLAcc: Record "G/L Account";
    begin
        if (JobJnlLine."Job No." = '') or
           (JobJnlLine."Job No." <> LastJobJnlLine."Job No.")
        then begin
            JobDescription := '';
            if Job.Get(JobJnlLine."Job No.") then
                JobDescription := Job.Description;
        end;

        if (JobJnlLine.Type <> LastJobJnlLine.Type) or
           (JobJnlLine."No." <> LastJobJnlLine."No.")
        then begin
            AccName := '';
            if JobJnlLine."No." <> '' then
                case JobJnlLine.Type of
                    JobJnlLine.Type::Resource:
                        if Res.Get(JobJnlLine."No.") then
                            AccName := Res.Name;
                    JobJnlLine.Type::Item:
                        if Item.Get(JobJnlLine."No.") then
                            AccName := Item.Description;
                    JobJnlLine.Type::"G/L Account":
                        if GLAcc.Get(JobJnlLine."No.") then
                            AccName := GLAcc.Name;
                end;
        end;

        LastJobJnlLine := JobJnlLine;
    end;
}

