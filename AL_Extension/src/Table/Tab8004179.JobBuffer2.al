Table 8004179 "Job Buffer2"
{
    Caption = 'Job Buffer';

    fields
    {
        field(1; "Account No. 1"; Code[20])
        {
            Caption = 'Account No. 1';
        }
        field(2; "Account No. 2"; Code[20])
        {
            Caption = 'Account No. 2';
        }
        field(3; "Amount 1"; Decimal)
        {
            Caption = 'Amount 1';
        }
        field(4; "Amount 2"; Decimal)
        {
            Caption = 'Amount 2';
        }
        field(5; "Amount 3"; Decimal)
        {
            Caption = 'Amount 3';
        }
        field(6; "Amount 4"; Decimal)
        {
            Caption = 'Amount 4';
        }
        field(7; "Amount 5"; Decimal)
        {
            Caption = 'Amount 5';
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "New Total"; Boolean)
        {
            Caption = 'New Total';
        }
    }

    keys
    {
        key(STG_Key1; "Account No. 1", "Account No. 2")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        JobBuffer: array[2] of Record "Job Buffer2" temporary;


    procedure InsertWorkInProgress(var Job: Record Job2)
    var
        JobWIPGLEntry: Record "Job WIP G/L Entry2";
    begin
        Clear(JobBuffer);
        JobWIPGLEntry.SetCurrentkey("Job No.");
        JobWIPGLEntry.SetRange("Job No.", Job."No.");
        JobWIPGLEntry.SetRange(Reversed, false);
        JobWIPGLEntry.SetRange("Job Complete", false);

        JobWIPGLEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
        if JobWIPGLEntry.Find('-') then
            repeat
                Clear(JobBuffer);
                if JobWIPGLEntry."G/L Account No." <> '' then begin
                    JobBuffer[1]."Account No. 1" := JobWIPGLEntry."G/L Account No.";
                    JobBuffer[1]."Account No. 2" := JobWIPGLEntry."Job Posting Group";
                    if (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"WIP Costs") or
                       (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"Recognized Costs") then
                        JobBuffer[1]."Amount 1" := JobWIPGLEntry."WIP Entry Amount"
                    else
                        if (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"Accrued Costs") then
                            JobBuffer[1]."Amount 2" := JobWIPGLEntry."WIP Entry Amount";
                    if (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"WIP Sales") or
                       (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"Recognized Sales") then
                        JobBuffer[1]."Amount 4" := JobWIPGLEntry."WIP Entry Amount"
                    else
                        if (JobWIPGLEntry.Type = JobWIPGLEntry.Type::"Accrued Sales") then
                            JobBuffer[1]."Amount 5" := JobWIPGLEntry."WIP Entry Amount";
                    JobBuffer[2] := JobBuffer[1];
                    if JobBuffer[2].Find then begin
                        JobBuffer[2]."Amount 1" :=
                          JobBuffer[2]."Amount 1" + JobBuffer[1]."Amount 1";
                        JobBuffer[2]."Amount 2" :=
                          JobBuffer[2]."Amount 2" + JobBuffer[1]."Amount 2";
                        JobBuffer[2]."Amount 4" :=
                          JobBuffer[2]."Amount 4" + JobBuffer[1]."Amount 4";
                        JobBuffer[2]."Amount 5" :=
                          JobBuffer[2]."Amount 5" + JobBuffer[1]."Amount 5";
                        JobBuffer[2].Modify;
                    end else
                        JobBuffer[1].Insert;
                end;
            until JobWIPGLEntry.Next = 0;
    end;


    procedure InitJobBuffer()
    begin
        Clear(JobBuffer);
        JobBuffer[1].DeleteAll;
    end;


    procedure GetJobBuffer(var Job: Record Job2; var JobBuffer2: Record "Job Buffer2")
    var
        GLEntry: Record "G/L Entry";
        OldAcc: Code[20];
    begin
        JobBuffer2.DeleteAll;
        GLEntry.SetCurrentkey("G/L Account No.", "Job No.", "Posting Date");
        GLEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
        OldAcc := '';

        if JobBuffer[1].Find('+') then
            repeat
                if JobBuffer[1]."Account No. 1" <> OldAcc then begin
                    GLEntry.SetRange("G/L Account No.", JobBuffer[1]."Account No. 1");
                    GLEntry.SetFilter("Job No.", Job.GetFilter("No."));
                    GLEntry.CalcSums(Amount);
                    JobBuffer[1]."Amount 3" := GLEntry.Amount;
                    if JobBuffer[1]."Amount 3" <> 0 then
                        JobBuffer[1]."New Total" := true;
                    OldAcc := JobBuffer[1]."Account No. 1";
                end;
                JobBuffer2 := JobBuffer[1];
                JobBuffer2.Insert;
            until JobBuffer[1].Next(-1) = 0;
        JobBuffer[1].DeleteAll;
    end;


    procedure ReportJobItem(var Job: Record Job2; var item2: Record Item; var JobBuffer2: Record "Job Buffer2")
    var
        Item: Record Item;
        Item3: Record Item;
        JobLedgEntry: Record "Job Ledger Entry2";
        InFilter: Boolean;
        Itemfilter: Boolean;
    begin
        Clear(JobBuffer2);
        Clear(JobBuffer);
        JobBuffer2.DeleteAll;
        JobBuffer[1].DeleteAll;
        if Job."No." = '' then
            exit;
        Item.Copy(item2);
        Itemfilter := Item.GetFilters <> '';
        Item.SetCurrentkey("No.");

        JobLedgEntry.SetCurrentkey("Job No.", "Posting Date");
        JobLedgEntry.SetRange("Job No.", Job."No.");
        JobLedgEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
        if JobLedgEntry.Find('-') then
            repeat
                if (JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Usage) and
                   (JobLedgEntry.Type = JobLedgEntry.Type::Item) and
                   (JobLedgEntry."No." <> '')
                then begin
                    InFilter := true;
                    if Itemfilter then begin
                        Item.Init;
                        Item."No." := JobLedgEntry."No.";
                        InFilter := Item.Find;
                    end;
                    if InFilter then begin
                        Item3.Init;
                        if Item3.Get(JobLedgEntry."No.") then;
                        Clear(JobBuffer[1]);
                        JobBuffer[1]."Account No. 1" := JobLedgEntry."No.";
                        JobBuffer[1]."Account No. 2" := JobLedgEntry."Unit of Measure Code";
                        JobBuffer[1].Description := Item3.Description;
                        JobBuffer[1]."Amount 1" := JobLedgEntry.Quantity;
                        JobBuffer[1]."Amount 2" := JobLedgEntry."Total Cost (LCY)";
                        JobBuffer[1]."Amount 3" := JobLedgEntry."Line Amount (LCY)";
                        JobBuffer[2] := JobBuffer[1];
                        if JobBuffer[2].Find then begin
                            JobBuffer[2]."Amount 1" :=
                              JobBuffer[2]."Amount 1" + JobBuffer[1]."Amount 1";
                            JobBuffer[2]."Amount 2" :=
                              JobBuffer[2]."Amount 2" + JobBuffer[1]."Amount 2";
                            JobBuffer[2]."Amount 3" :=
                              JobBuffer[2]."Amount 3" + JobBuffer[1]."Amount 3";
                            JobBuffer[2].Modify;
                        end else
                            JobBuffer[1].Insert;
                    end;
                end;
            until JobLedgEntry.Next = 0;

        if JobBuffer[1].Find('-') then
            repeat
                JobBuffer2 := JobBuffer[1];
                JobBuffer2.Insert;
            until JobBuffer[1].Next = 0;
        JobBuffer[1].DeleteAll;
    end;


    procedure ReportItemJob(var Item: Record Item; var Job2: Record Job2; var JobBuffer2: Record "Job Buffer2")
    var
        JobLedgEntry: Record "Job Ledger Entry2";
        Job: Record Job2;
        Job3: Record Job2;
        InFilter: Boolean;
        JobFilter: Boolean;
    begin
        Clear(JobBuffer2);
        Clear(JobBuffer);
        JobBuffer2.DeleteAll;
        JobBuffer[1].DeleteAll;
        if Item."No." = '' then
            exit;
        Job.Copy(Job2);
        JobFilter := Job.GetFilters <> '';
        Job.SetCurrentkey("No.");

        JobLedgEntry.SetCurrentkey("Entry Type", Type, "No.", "Posting Date");
        JobLedgEntry.SetRange("Entry Type", JobLedgEntry."entry type"::Usage);
        JobLedgEntry.SetRange(Type, JobLedgEntry.Type::Item);
        JobLedgEntry.SetRange("No.", Item."No.");
        JobLedgEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
        if JobLedgEntry.Find('-') then
            repeat
                InFilter := true;
                if JobFilter then begin
                    Job.Init;
                    Job."No." := JobLedgEntry."Job No.";
                    InFilter := Job.Find;
                end;
                if InFilter then begin
                    Job3.Init;
                    if Job3.Get(JobLedgEntry."Job No.") then;
                    Clear(JobBuffer[1]);
                    JobBuffer[1]."Account No. 1" := JobLedgEntry."Job No.";
                    JobBuffer[1]."Account No. 2" := JobLedgEntry."Unit of Measure Code";
                    JobBuffer[1].Description := Job3.Description;
                    JobBuffer[1]."Amount 1" := JobLedgEntry.Quantity;
                    JobBuffer[1]."Amount 2" := JobLedgEntry."Total Cost (LCY)";
                    JobBuffer[1]."Amount 3" := JobLedgEntry."Line Amount (LCY)";
                    JobBuffer[2] := JobBuffer[1];
                    if JobBuffer[2].Find then begin
                        JobBuffer[2]."Amount 1" :=
                          JobBuffer[2]."Amount 1" + JobBuffer[1]."Amount 1";
                        JobBuffer[2]."Amount 2" :=
                          JobBuffer[2]."Amount 2" + JobBuffer[1]."Amount 2";
                        JobBuffer[2]."Amount 3" :=
                          JobBuffer[2]."Amount 3" + JobBuffer[1]."Amount 3";
                        JobBuffer[2].Modify;
                    end else
                        JobBuffer[1].Insert;
                end;
            until JobLedgEntry.Next = 0;

        if JobBuffer[1].Find('-') then
            repeat
                JobBuffer2 := JobBuffer[1];
                JobBuffer2.Insert;
            until JobBuffer[1].Next = 0;
        JobBuffer[1].DeleteAll;
    end;
}

