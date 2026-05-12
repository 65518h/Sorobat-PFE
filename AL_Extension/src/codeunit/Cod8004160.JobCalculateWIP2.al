Codeunit 8004160 "Job Calculate WIP2"
{
    Permissions = TableData "Job Ledger Entry" = r,
                  TableData "Job Task" = rimd,
                  TableData "Job Planning Line" = r,
                  TableData "Job WIP Entry" = rimd,
                  TableData "Job WIP G/L Entry" = rimd;

    trigger OnRun()
    begin
    end;

    var
        WIPBuffer: array[2] of Record "Job WIP Buffer" temporary;
        GenJnPostLine: Codeunit "Gen. Jnl.-Post Line";
        DimMgt: Codeunit DimensionManagement;
        DimensionBufferManagement: Codeunit "Dimension Buffer Management";
        WIPPostingDate: Date;
        DocNo: Code[20];
        Text000: label '%1,%2 %3,%4';
        Text001: label 'WIP';
        Text002: label 'Recognition';
        Text003: label 'Completion';
        JobComplete: Boolean;
        Text004: label 'WIP G/L entries posted for Job %1 cannot be reversed at an earlier date than %2.';
        Text005: label '..%1';
        GLSetup: Record "General Ledger Setup";
        HasGotGLSetup: Boolean;


    procedure JobCalcWIP(JobNo: Code[20]; WIPPostingDate2: Date; DocNo2: Code[20]; var Job2: Record Job)
    var
        Job: Record Job;
        JT: Record "Job Task";
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        JobWIPEntry: Record "Job WIP Entry";
        JobWIPGLEntry: Record "Job WIP G/L Entry";
        FromJT: Code[20];
        First: Boolean;
    begin
        ClearAll;
        WIPBuffer[1].DeleteAll;
        WIPPostingDate := WIPPostingDate2;
        DocNo := DocNo2;
        if WIPPostingDate = 0D then
            WIPPostingDate := WorkDate;
        JobPlanningLine.LockTable;
        JobLedgEntry.LockTable;
        JobWIPEntry.LockTable;
        JT.LockTable;
        Job.LockTable;

        JobWIPGLEntry.SetCurrentkey("Job No.", Reversed, "Job Complete");
        JobWIPGLEntry.SetRange("Job No.", JobNo);
        JobWIPGLEntry.SetRange("Job Complete", true);
        if JobWIPGLEntry.Find('-') then begin
            JobWIPEntry.SetCurrentkey("Job No.");
            JobWIPEntry.SetRange("Job No.", JobNo);
            JobWIPEntry.DeleteAll(true);
            exit;
        end;

        Job.Get(JobNo);
        Job.TestBlocked;
        Job."WIP Entries Exist" := false;
        Job."WIP Posting Date" := WIPPostingDate;
        //GL2024     Job."Calc. WIP Method Used" := Job."WIP Method" + 1;
        JobComplete := Job.Complete;
        Job.Modify;
        JT.SetRange("Job No.", JobNo);
        if JT.Find('+') then
            if JT."WIP-Total" = JT."wip-total"::" " then begin
                JT."WIP-Total" := JT."wip-total"::Total;
                JT.Modify;
            end;
        InitWIP(JobNo);
        First := true;
        if JT.Find('-') then
            repeat
                if First then
                    FromJT := JT."Job Task No.";
                First := false;
                if JT."WIP-Total" <> JT."wip-total"::" " then begin
                    JobTaskCalcWIP(JobNo, FromJT, JT."Job Task No.", Job2);
                    First := true;
                end;
            until JT.Next = 0;
        CreateWIPEntries(JobNo);
    end;

    local procedure JobTaskCalcWIP(JobNo: Code[20]; FromJT: Code[20]; ToJT: Code[20]; var Job2: Record Job)
    var
        Job: Record Job;
        JT: Record "Job Task";
        TotalJT: Record "Job Task";
        WIPPercent: Decimal;
        WIPSpecialAmount: Decimal;
    begin
        Job.Get(JobNo);
        JT.SetRange("Job No.", JobNo);
        JT.SetRange("Job Task No.", FromJT, ToJT);
        if Job2.GetFilter("Posting Date Filter") <> '' then
            JT.SetFilter("Posting Date Filter", Job2.GetFilter("Posting Date Filter"))
        else
            JT.SetFilter("Posting Date Filter", StrSubstNo(Text005, WIPPostingDate));

        JT.SetFilter("Planning Date Filter", Job2.GetFilter("Planning Date Filter"));

        if JT.Find('+') then
            if JT."WIP-Total" = JT."wip-total"::Excluded then
                exit;
        Clear(TotalJT);

        if JT.Find('-') then
            repeat
                if JT."Job Task Type" = JT."job task type"::Posting then begin
                    JT.CalcFields(
                      "Schedule (Total Cost)",
                      "Schedule (Total Price)",
                      "Usage (Total Cost)",
                      "Usage (Total Price)",
                      "Contract (Total Cost)",
                      "Contract (Total Price)",
                      "Contract (Invoiced Price)",
                      "Contract (Invoiced Cost)");
                    TotalJT."Schedule (Total Cost)" :=
                      TotalJT."Schedule (Total Cost)" + JT."Schedule (Total Cost)";
                    TotalJT."Schedule (Total Price)" :=
                      TotalJT."Schedule (Total Price)" + JT."Schedule (Total Price)";
                    TotalJT."Usage (Total Cost)" :=
                      TotalJT."Usage (Total Cost)" + JT."Usage (Total Cost)";
                    TotalJT."Usage (Total Price)" :=
                      TotalJT."Usage (Total Price)" + JT."Usage (Total Price)";
                    TotalJT."Contract (Total Cost)" :=
                      TotalJT."Contract (Total Cost)" + JT."Contract (Total Cost)";
                    TotalJT."Contract (Total Price)" :=
                      TotalJT."Contract (Total Price)" + JT."Contract (Total Price)";
                    TotalJT."Contract (Invoiced Price)" :=
                      TotalJT."Contract (Invoiced Price)" + JT."Contract (Invoiced Price)";
                    TotalJT."Contract (Invoiced Cost)" :=
                      TotalJT."Contract (Invoiced Cost)" + JT."Contract (Invoiced Cost)";
                end;
            until JT.Next = 0;

        CalcWIPPercent(Job."WIP Method", WIPPercent, WIPSpecialAmount, TotalJT);

        /*GL2024 if JT.Find('-') then
             repeat
                 SetWIPAmounts(JT, WIPPercent, JT."Job Posting Group",
                   Job."WIP Method", WIPSpecialAmount);
             until JT.Next = 0;*/
    end;
    /*GL2024
        local procedure SetWIPAmounts(var JT: Record "Job Task"; WIPPercent: Decimal; PostingGr: Code[10]; WIPCalcMethod: Integer; var WIPSpecialAmount: Decimal)
        var
            Job: Record Job;
            JobPostingGr: Record "Job Posting Group";
        begin
            if JT."Job Task Type" <> JT."job task type"::Posting then
                exit;
            JT.CalcFields(
              "Schedule (Total Cost)",
              "Schedule (Total Price)",
              "Usage (Total Cost)",
              "Usage (Total Price)",
              "Contract (Total Cost)",
              "Contract (Total Price)",
              "Contract (Invoiced Price)",
              "Contract (Invoiced Cost)");

            JT."WIP Schedule (Total Cost)" := JT."Schedule (Total Cost)";
            JT."WIP Schedule (Total Price)" := JT."Schedule (Total Price)";
            JT."WIP Usage (Total Cost)" := JT."Usage (Total Cost)";
            JT."WIP Usage (Total Price)" := JT."Usage (Total Price)";
            JT."WIP Contract (Total Cost)" := JT."Contract (Total Cost)";
            JT."WIP Contract (Total Price)" := JT."Contract (Total Price)";
            JT."WIP (Invoiced Price)" := JT."Contract (Invoiced Price)";
            JT."WIP (Invoiced Cost)" := JT."Contract (Invoiced Cost)";
            JT."WIP Posting Date" := WIPPostingDate;
            JT."WIP Posting Date Filter" := JT.GetFilter("Posting Date Filter");
            JT."WIP Planning Date Filter" := JT.GetFilter("Planning Date Filter");

            JT."WIP Method Used" := WIPCalcMethod + 1;

            JT."WIP Amount" := ROUND(WIPSpecialAmount);
            WIPSpecialAmount := 0;

            CalcWIPAmount(WIPCalcMethod, JT, WIPPercent);

            if PostingGr = '' then begin
                Job.Get(JT."Job No.");
                Job.TestField("Job Posting Group");
                PostingGr := Job."Job Posting Group";
            end;

            JobPostingGr.Get(PostingGr);
            JT."Job Posting Group" := PostingGr;

            if WIPCalcMethod <= 3 then
                if JT."WIP Amount" <> 0 then
                    JT."WIP %" := ROUND(WIPPercent * 100, 0.00001);

            if ((WIPCalcMethod = 0) or (WIPCalcMethod = 2)) and not JobComplete then begin
                JobPostingGr.TestField("WIP Costs Account");
                JobPostingGr.TestField("Job Costs Applied Account");
                JobPostingGr.TestField("WIP Invoiced Sales Account");
                JobPostingGr.TestField("Job Sales Applied Account");
                JobPostingGr.TestField("Recognized Costs Account");
                JobPostingGr.TestField("Recognized Sales Account");
                JT."WIP Costs Account" := JobPostingGr."WIP Costs Account";
                JT."WIP Costs Balance Account" := JobPostingGr."Job Costs Applied Account";
                JT."WIP Sales Account" := JobPostingGr."WIP Invoiced Sales Account";
                JT."WIP Sales Balance Account" := JobPostingGr."Job Sales Applied Account";
                JT."Recognized Costs Account" := JobPostingGr."Recognized Costs Account";
                JT."Recognized Costs Bal. Account" := JobPostingGr."WIP Costs Account";
                JT."Recognized Sales Account" := JobPostingGr."Recognized Sales Account";
                JT."Recognized Sales Bal. Account" := JobPostingGr."WIP Invoiced Sales Account";
                if JT."WIP Amount" >= 0 then begin
                    JT."WIP Account" := JobPostingGr."WIP Costs Account";
                    JT."WIP Balance Account" := JobPostingGr."Job Costs Applied Account";
                end else begin
                    JobPostingGr.TestField("WIP Accrued Costs Account");
                    JobPostingGr.TestField("Job Costs Adjustment Account");
                    JT."WIP Account" := JobPostingGr."WIP Accrued Costs Account";
                    JT."WIP Balance Account" := JobPostingGr."Job Costs Adjustment Account";
                    CreateWIPBuffer(JT, 4, WIPCalcMethod);
                end;
                CreateWIPBuffer(JT, 0, WIPCalcMethod);
                CreateWIPBuffer(JT, 1, WIPCalcMethod);
                CreateWIPBuffer(JT, 2, WIPCalcMethod);
                CreateWIPBuffer(JT, 3, WIPCalcMethod);
            end;

            if (WIPCalcMethod = 1) and not JobComplete then begin
                JobPostingGr.TestField("Job Sales Applied Account");
                JobPostingGr.TestField("Job Costs Applied Account");
                JobPostingGr.TestField("WIP Costs Account");
                JobPostingGr.TestField("Recognized Costs Account");
                JobPostingGr.TestField("Recognized Sales Account");
                JobPostingGr.TestField("WIP Invoiced Sales Account");
                JT."WIP Sales Account" := JobPostingGr."WIP Invoiced Sales Account";
                JT."WIP Sales Balance Account" := JobPostingGr."Job Sales Applied Account";
                JT."WIP Costs Balance Account" := JobPostingGr."Job Costs Applied Account";
                JT."WIP Costs Account" := JobPostingGr."WIP Costs Account";
                JT."Recognized Costs Account" := JobPostingGr."Recognized Costs Account";
                JT."Recognized Sales Account" := JobPostingGr."Recognized Sales Account";
                JT."Recognized Costs Bal. Account" := JobPostingGr."WIP Costs Account";
                JT."Recognized Sales Bal. Account" := JobPostingGr."WIP Invoiced Sales Account";
                if JT."WIP Amount" > 0 then begin
                    JobPostingGr.TestField("WIP Accrued Sales Account");
                    JobPostingGr.TestField("Job Sales Adjustment Account");
                    JT."WIP Account" := JobPostingGr."WIP Accrued Sales Account";
                    JT."WIP Balance Account" := JobPostingGr."Job Costs Adjustment Account";
                    CreateWIPBuffer(JT, 5, WIPCalcMethod);
                end else begin
                    JobPostingGr.TestField("WIP Invoiced Sales Account");
                    JT."WIP Account" := JobPostingGr."WIP Invoiced Sales Account";
                    JT."WIP Balance Account" := JobPostingGr."Job Sales Applied Account";
                end;
                CreateWIPBuffer(JT, 0, WIPCalcMethod);
                CreateWIPBuffer(JT, 1, WIPCalcMethod);
                CreateWIPBuffer(JT, 2, WIPCalcMethod);
                CreateWIPBuffer(JT, 3, WIPCalcMethod);
            end;

            if (WIPCalcMethod >= 3) and not JobComplete then begin
                JobPostingGr.TestField("WIP Costs Account");
                JobPostingGr.TestField("Job Costs Applied Account");
                JobPostingGr.TestField("WIP Invoiced Sales Account");
                JobPostingGr.TestField("Job Sales Applied Account");
                JobPostingGr.TestField("Recognized Costs Account");
                JobPostingGr.TestField("Recognized Sales Account");
                JobPostingGr.TestField("WIP Accrued Sales Account");
                JT."WIP Costs Account" := JobPostingGr."WIP Costs Account";
                JT."WIP Costs Balance Account" := JobPostingGr."Job Costs Applied Account";
                JT."WIP Sales Account" := JobPostingGr."WIP Invoiced Sales Account";
                JT."WIP Sales Balance Account" := JobPostingGr."Job Sales Applied Account";
                JT."Recognized Costs Account" := JobPostingGr."Recognized Costs Account";
                JT."Recognized Costs Bal. Account" := JobPostingGr."WIP Costs Account";
                JT."Recognized Sales Account" := JobPostingGr."Recognized Sales Account";
                JT."Recognized Sales Bal. Account" := JobPostingGr."WIP Accrued Sales Account";
                CreateWIPBuffer(JT, 0, WIPCalcMethod);
                CreateWIPBuffer(JT, 1, WIPCalcMethod);
                if WIPCalcMethod = 3 then begin
                    CreateWIPBuffer(JT, 2, WIPCalcMethod);
                    CreateWIPBuffer(JT, 3, WIPCalcMethod);
                end;
            end;

            if JobComplete then begin
                JobPostingGr.TestField("Job Costs Applied Account");
                JobPostingGr.TestField("Job Sales Applied Account");
                JobPostingGr.TestField("Recognized Costs Account");
                JobPostingGr.TestField("Recognized Sales Account");
                JT."Recognized Costs Account" := JobPostingGr."Recognized Costs Account";
                JT."Recognized Costs Bal. Account" := JobPostingGr."Job Costs Applied Account";
                JT."Recognized Sales Account" := JobPostingGr."Recognized Sales Account";
                JT."Recognized Sales Bal. Account" := JobPostingGr."Job Sales Applied Account";
                CreateWIPBuffer(JT, 2, WIPCalcMethod);
                CreateWIPBuffer(JT, 3, WIPCalcMethod);
            end;

            JT.Modify;
        end;
    */
    //GL2024 local procedure CreateWIPBuffer(JT: Record "Job Task"; BufferType: Integer; WIPCalcMethod: Integer)
    // var
    //     JobTaskDimension: Record "Job Task Dimension";
    //     DimensionBuffer: Record "Dimension Buffer" temporary;
    // begin
    //     Clear(WIPBuffer);

    //     DimensionBuffer.Reset;
    //     DimensionBuffer.DeleteAll;
    //     JobTaskDimension.SetRange("Job No.", JT."Job No.");
    //     JobTaskDimension.SetRange("Job Task No.", JT."Job Task No.");
    //     if JobTaskDimension.FindSet then
    //         repeat
    //             DimensionBuffer."Dimension Code" := JobTaskDimension."Dimension Code";
    //             DimensionBuffer."Dimension Value Code" := JobTaskDimension."Dimension Value Code";
    //             DimensionBuffer.Insert;
    //         until JobTaskDimension.Next = 0;
    //     if not DimMgt.CheckDimBuffer(DimensionBuffer) then
    //         Error(DimMgt.GetDimCombErr);
    //     WIPBuffer[1]."Dim Combination ID" := DimensionBufferManagement.GetDimensionId(DimensionBuffer);

    //     if BufferType = WIPBuffer[1].Type::"WIP Sales" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"WIP Sales";
    //         /*GL2024    WIPBuffer[1]."G/L Account No." := JT."WIP Sales Account";
    //             WIPBuffer[1]."Bal. G/L Account No." := JT."WIP Sales Balance Account";
    //             WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //             WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //             WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";*/
    //         if WIPCalcMethod <> 1 then
    //             WIPBuffer[1]."WIP Entry Amount" := -JT."Contract (Invoiced Price)";
    //         if WIPCalcMethod = 1 then
    //             /*GL2024     if JT."WIP Amount" < 0 then
    //                      WIPBuffer[1]."WIP Entry Amount" := -JT."Contract (Invoiced Price)"
    //                  else
    //                      WIPBuffer[1]."WIP Entry Amount" := -JT."Contract (Invoiced Price)" - JT."WIP Amount";
    //              WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //              WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //              WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //              WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //              WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //              WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //              WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //              WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;

    //     if BufferType = WIPBuffer[1].Type::"WIP Costs" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"WIP Costs";
    //         /*GL2024     WIPBuffer[1]."G/L Account No." := JT."WIP Costs Account";
    //              WIPBuffer[1]."Bal. G/L Account No." := JT."WIP Costs Balance Account";
    //              WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //              WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //              WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";
    //              if (WIPCalcMethod = 1) or (WIPCalcMethod >= 3) then
    //                  WIPBuffer[1]."WIP Entry Amount" := JT."WIP Usage (Total Cost)";
    //              if (WIPCalcMethod = 0) or (WIPCalcMethod = 2) then
    //                  if JT."WIP Amount" > 0 then
    //                      WIPBuffer[1]."WIP Entry Amount" := JT."WIP Usage (Total Cost)"
    //                  else
    //                      WIPBuffer[1]."WIP Entry Amount" := JT."WIP Usage (Total Cost)" - JT."WIP Amount";
    //              WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //              WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //              WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //              WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //              WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //              WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //              WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //              WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;

    //     if BufferType = WIPBuffer[1].Type::"Recognized Costs" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"Recognized Costs";
    //         /*GL2024     WIPBuffer[1]."G/L Account No." := JT."Recognized Costs Bal. Account";
    //              WIPBuffer[1]."Bal. G/L Account No." := JT."Recognized Costs Account";
    //              WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //              WIPBuffer[1]."Job Complete" := JobComplete;
    //              WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //              WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";
    //              WIPBuffer[1]."WIP Entry Amount" := -JT."Recognized Costs Amount";
    //              WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //              WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //              WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //              WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //              WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //              WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //              WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //              WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;

    //     if BufferType = WIPBuffer[1].Type::"Recognized Sales" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"Recognized Sales";
    //         /*GL2024    WIPBuffer[1]."G/L Account No." := JT."Recognized Sales Bal. Account";
    //             WIPBuffer[1]."Bal. G/L Account No." := JT."Recognized Sales Account";
    //             WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //             WIPBuffer[1]."Job Complete" := JobComplete;
    //             WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //             WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";
    //             WIPBuffer[1]."WIP Entry Amount" := JT."Recognized Sales Amount";
    //             WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //             WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //             WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //             WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //             WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //             WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //             WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //             WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;

    //     if BufferType = WIPBuffer[1].Type::"Accrued Costs" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"Accrued Costs";
    //         /*GL2024        WIPBuffer[1]."G/L Account No." := JT."WIP Account";
    //                 WIPBuffer[1]."Bal. G/L Account No." := JT."WIP Balance Account";
    //                 WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //                 WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //                 WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";
    //                 WIPBuffer[1]."WIP Entry Amount" := JT."WIP Amount";
    //                 WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //                 WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //                 WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //                 WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //                 WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //                 WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //                 WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //                 WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;

    //     if BufferType = WIPBuffer[1].Type::"Accrued Sales" then begin
    //         WIPBuffer[1]."Job No." := JT."Job No.";
    //         WIPBuffer[1]."Posting Group" := JT."Job Posting Group";
    //         WIPBuffer[1].Type := WIPBuffer[1].Type::"Accrued Sales";
    //         /*GL2024       WIPBuffer[1]."G/L Account No." := JT."WIP Account";
    //                WIPBuffer[1]."Bal. G/L Account No." := JT."WIP Balance Account";
    //                WIPBuffer[1]."WIP Method" := JT."WIP Method Used";
    //                WIPBuffer[1]."WIP Posting Date Filter" := JT."WIP Posting Date Filter";
    //                WIPBuffer[1]."WIP Planning Date Filter" := JT."WIP Planning Date Filter";
    //                WIPBuffer[1]."WIP Entry Amount" := JT."WIP Amount";
    //                WIPBuffer[1]."WIP Schedule (Total Cost)" := JT."WIP Schedule (Total Cost)";
    //                WIPBuffer[1]."WIP Schedule (Total Price)" := JT."WIP Schedule (Total Price)";
    //                WIPBuffer[1]."WIP Usage (Total Cost)" := JT."WIP Usage (Total Cost)";
    //                WIPBuffer[1]."WIP Usage (Total Price)" := JT."WIP Usage (Total Price)";
    //                WIPBuffer[1]."WIP Contract (Total Cost)" := JT."WIP Contract (Total Cost)";
    //                WIPBuffer[1]."WIP Contract (Total Price)" := JT."WIP Contract (Total Price)";
    //                WIPBuffer[1]."WIP (Invoiced Price)" := JT."WIP (Invoiced Price)";
    //                WIPBuffer[1]."WIP (Invoiced Cost)" := JT."WIP (Invoiced Cost)";*/

    //         WIPBuffer[2] := WIPBuffer[1];
    //         if WIPBuffer[2].Find then begin
    //             WIPBuffer[2]."WIP Entry Amount" :=
    //               WIPBuffer[2]."WIP Entry Amount" + WIPBuffer[1]."WIP Entry Amount";
    //             WIPBuffer[2]."WIP Schedule (Total Cost)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Cost)" + WIPBuffer[1]."WIP Schedule (Total Cost)";
    //             WIPBuffer[2]."WIP Schedule (Total Price)" :=
    //               WIPBuffer[2]."WIP Schedule (Total Price)" + WIPBuffer[1]."WIP Schedule (Total Price)";
    //             WIPBuffer[2]."WIP Usage (Total Cost)" :=
    //               WIPBuffer[2]."WIP Usage (Total Cost)" + WIPBuffer[1]."WIP Usage (Total Cost)";
    //             WIPBuffer[2]."WIP Usage (Total Price)" :=
    //               WIPBuffer[2]."WIP Usage (Total Price)" + WIPBuffer[1]."WIP Usage (Total Price)";
    //             WIPBuffer[2]."WIP Contract (Total Cost)" :=
    //               WIPBuffer[2]."WIP Contract (Total Cost)" + WIPBuffer[1]."WIP Contract (Total Cost)";
    //             WIPBuffer[2]."WIP Contract (Total Price)" :=
    //               WIPBuffer[2]."WIP Contract (Total Price)" + WIPBuffer[1]."WIP Contract (Total Price)";
    //             WIPBuffer[2]."WIP (Invoiced Price)" :=
    //               WIPBuffer[2]."WIP (Invoiced Price)" + WIPBuffer[1]."WIP (Invoiced Price)";
    //             WIPBuffer[2]."WIP (Invoiced Cost)" :=
    //               WIPBuffer[2]."WIP (Invoiced Cost)" + WIPBuffer[1]."WIP (Invoiced Cost)";
    //             WIPBuffer[2].Modify;
    //         end else
    //             WIPBuffer[1].Insert;
    //     end;
    // end;

    local procedure CalcWIPPercent(WIPCalcMethod: code[20]; var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; var TotalJT: Record "Job Task")
    begin
        if WIPCalcMethod = '0' then
            CalcWIPPercent1(WIPPercent, WIPSpecialAmount, TotalJT);
        if WIPCalcMethod = '1' then
            CalcWIPPercent2(WIPPercent, WIPSpecialAmount, TotalJT);
        if WIPCalcMethod = '2' then
            CalcWIPPercent3(WIPPercent, WIPSpecialAmount, TotalJT);
        if WIPCalcMethod = '3' then
            CalcWIPPercent4(WIPPercent, WIPSpecialAmount, TotalJT);
        if WIPCalcMethod = '4' then
            CalcWIPPercent5(WIPPercent, WIPSpecialAmount, TotalJT);
    end;

    /*GL2024 local procedure CalcWIPAmount(WIPCalcMethod: Integer; var JT: Record "Job Task"; WIPPercent: Decimal)
    begin
        if WIPCalcMethod = 0 then
            CalcWIPAmount1(JT, WIPPercent);
        if WIPCalcMethod = 1 then
            CalcWIPAmount2(JT, WIPPercent);
        if WIPCalcMethod = 2 then
            CalcWIPAmount3(JT, WIPPercent);
        if WIPCalcMethod = 3 then
            CalcWIPAmount4(JT, WIPPercent);
        if WIPCalcMethod = 4 then
            CalcWIPAmount5(JT);
    end;*/

    local procedure CalcWIPPercent1(var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; TotalJT: Record "Job Task")
    var
        WIPAmount: Decimal;
    begin
        WIPPercent := 0;
        WIPSpecialAmount := 0;
        if JobComplete or (TotalJT."Schedule (Total Price)" = 0) then
            exit;
        WIPAmount :=
          (TotalJT."Usage (Total Cost)" *
           TotalJT."Contract (Total Price)" /
           TotalJT."Schedule (Total Price)") -
          TotalJT."Schedule (Total Cost)" *
          TotalJT."Contract (Invoiced Price)" /
          TotalJT."Schedule (Total Price)";
        if TotalJT."Usage (Total Cost)" <> 0 then
            WIPPercent := WIPAmount / TotalJT."Usage (Total Cost)"
        else
            WIPSpecialAmount := WIPAmount;
    end;

    local procedure CalcWIPPercent2(var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; TotalJT: Record "Job Task")
    var
        WIPAmount: Decimal;
    begin
        WIPPercent := 0;
        WIPSpecialAmount := 0;
        if JobComplete or (TotalJT."Schedule (Total Price)" = 0) then
            exit;
        WIPAmount :=
          (TotalJT."Usage (Total Price)" *
           TotalJT."Contract (Total Price)" /
           TotalJT."Schedule (Total Price)") -
          TotalJT."Schedule (Total Price)" *
          TotalJT."Contract (Invoiced Price)" /
          TotalJT."Schedule (Total Price)";
        if TotalJT."Usage (Total Price)" <> 0 then
            WIPPercent := WIPAmount / TotalJT."Usage (Total Price)"
        else
            WIPSpecialAmount := WIPAmount;
    end;

    local procedure CalcWIPPercent3(var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; TotalJT: Record "Job Task")
    var
        WIPAmount: Decimal;
    begin
        WIPPercent := 0;
        WIPSpecialAmount := 0;
        if JobComplete or (TotalJT."Contract (Total Price)" = 0) then
            exit;
        WIPAmount :=
          TotalJT."Usage (Total Cost)" - ((TotalJT."Contract (Invoiced Price)" / TotalJT."Contract (Total Price)") *
                                          TotalJT."Schedule (Total Cost)");
        if TotalJT."Usage (Total Cost)" <> 0 then
            WIPPercent := WIPAmount / TotalJT."Usage (Total Cost)"
        else
            WIPSpecialAmount := WIPAmount;
    end;

    local procedure CalcWIPPercent4(var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; TotalJT: Record "Job Task")
    var
        WIPAmount: Decimal;
    begin
        WIPPercent := 0;
        WIPSpecialAmount := 0;
        if JobComplete or (TotalJT."Schedule (Total Cost)" = 0) then
            exit;
        if TotalJT."Usage (Total Cost)" <= TotalJT."Schedule (Total Cost)" then
            WIPAmount :=
              (TotalJT."Usage (Total Cost)" / TotalJT."Schedule (Total Cost)") *
              TotalJT."Contract (Total Price)"
        else
            WIPAmount := TotalJT."Contract (Total Price)";
        if TotalJT."Contract (Total Price)" <> 0 then
            WIPPercent := WIPAmount / TotalJT."Contract (Total Price)"
        else
            WIPSpecialAmount := WIPAmount;
    end;

    local procedure CalcWIPPercent5(var WIPPercent: Decimal; var WIPSpecialAmount: Decimal; TotalJT: Record "Job Task")
    var
        WIPAmount: Decimal;
    begin
        WIPPercent := 0;
        WIPSpecialAmount := 0;
        if JobComplete or (TotalJT."Schedule (Total Cost)" = 0) then
            exit;
        WIPAmount := TotalJT."Usage (Total Cost)";
        if TotalJT."Usage (Total Cost)" <> 0 then
            WIPPercent := WIPAmount / TotalJT."Usage (Total Cost)"
        else
            WIPSpecialAmount := WIPAmount;
    end;

    /*GL2024  local procedure CalcWIPAmount1(var JT: Record "Job Task"; WIPPercent: Decimal)
     begin
           if WIPPercent <> 0 then
                JT."WIP Amount" := ROUND(JT."Usage (Total Cost)" * WIPPercent);
            if JT."Schedule (Total Cost)" <> 0 then
                JT."Cost Completion %" := ROUND(100 * JT."Usage (Total Cost)" / JT."Schedule (Total Cost)", 0.00001)
            else
                JT."Cost Completion %" := 0;
            if JT."Contract (Total Price)" <> 0 then
                JT."Invoiced %" := ROUND(100 * JT."Contract (Invoiced Price)" / JT."Contract (Total Price)", 0.00001)
            else
                JT."Invoiced %" := 0;
         JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
         //GL2024   JT."Recognized Costs Amount" := (JT."Usage (Total Cost)" - JT."WIP Amount");
         if JobComplete then begin
             JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
             JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
         end;
     end;*/

    /*GL2024  local procedure CalcWIPAmount2(var JT: Record "Job Task"; WIPPercent: Decimal)
      begin
           if WIPPercent <> 0 then
               JT."WIP Amount" := ROUND(JT."Usage (Total Price)" * WIPPercent);
           if JT."Schedule (Total Cost)" <> 0 then
               JT."Cost Completion %" := ROUND(100 * JT."Usage (Total Cost)" / JT."Schedule (Total Cost)", 0.00001)
           else
               JT."Cost Completion %" := 0;
           if JT."Contract (Total Price)" <> 0 then
               JT."Invoiced %" := ROUND(100 * JT."Contract (Invoiced Price)" / JT."Contract (Total Price)", 0.00001)
           else
               JT."Invoiced %" := 0;
           JT."Recognized Sales Amount" := (JT."Contract (Invoiced Price)" + JT."WIP Amount");
          JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
          if JobComplete then begin
              JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
              JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
          end;
      end;*/

    /*GL2024  local procedure CalcWIPAmount3(var JT: Record "Job Task"; WIPPercent: Decimal)
   begin
      if WIPPercent <> 0 then
             JT."WIP Amount" := ROUND(JT."Usage (Total Cost)" * WIPPercent);
         if JT."Schedule (Total Cost)" <> 0 then
             JT."Cost Completion %" := ROUND(100 * JT."Usage (Total Cost)" / JT."Schedule (Total Cost)", 0.00001)
         else
             JT."Cost Completion %" := 0;
         if JT."Contract (Total Price)" <> 0 then
             JT."Invoiced %" := ROUND(100 * JT."Contract (Invoiced Price)" / JT."Contract (Total Price)", 0.00001)
         else
             JT."Invoiced %" := 0
       JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
       //GL2024   JT."Recognized Costs Amount" := (JT."Usage (Total Cost)" - JT."WIP Amount");
       if JobComplete then begin
           JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
           JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
       end;
   end;;*/

    /*GL2024   local procedure CalcWIPAmount4(var JT: Record "Job Task"; WIPPercent: Decimal)
    begin
         if WIPPercent <> 0 then
                JT."WIP Amount" := ROUND(JT."Contract (Total Price)" * WIPPercent);
            JT."Invoiced Sales Amount" := -JT."Contract (Invoiced Price)";
            if JT."Schedule (Total Cost)" <> 0 then
                JT."Cost Completion %" := ROUND(100 * JT."Usage (Total Cost)" / JT."Schedule (Total Cost)", 0.00001)
            else
                JT."Cost Completion %" := 0;
            if JT."Contract (Total Price)" <> 0 then
                JT."Invoiced %" := ROUND(100 * JT."Contract (Invoiced Price)" / JT."Contract (Total Price)", 0.00001)
            else
                JT."Invoiced %" := 0;
         JT."Recognized Sales Amount" := JT."WIP Amount";
        JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
        if JobComplete then begin
            //GL2024   JT."Invoiced Sales Amount" := 0;
            JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
            JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
        end;
    end;*/

    /*GL2024  local procedure CalcWIPAmount5(var JT: Record "Job Task")
      begin
          JT."WIP Amount" := JT."Usage (Total Cost)";
          JT."Invoiced Sales Amount" := -JT."Contract (Invoiced Price)";
          if JT."Schedule (Total Cost)" <> 0 then
              JT."Cost Completion %" := ROUND(100 * JT."Usage (Total Cost)" / JT."Schedule (Total Cost)", 0.00001)
          else
              JT."Cost Completion %" := 0;
          if JT."Contract (Total Price)" <> 0 then
              JT."Invoiced %" := ROUND(100 * JT."Contract (Invoiced Price)" / JT."Contract (Total Price)", 0.00001)
          else
              JT."Invoiced %" := 0;
          if JobComplete then begin
              JT."Invoiced Sales Amount" := 0;
              JT."Recognized Sales Amount" := JT."Contract (Invoiced Price)";
              JT."Recognized Costs Amount" := JT."Usage (Total Cost)";
          end;
      end;*/


    procedure InitWIP(JobNo: Code[20])
    var
        JT: Record "Job Task";
        JobWIPEntry: Record "Job WIP Entry";
    begin
        JT.SetRange("Job No.", JobNo);
        if JT.Find('-') then
            repeat
                JT.InitWIPFields;
                JT.Modify;
            until JT.Next = 0;
        JobWIPEntry.SetCurrentkey("Job No.");
        JobWIPEntry.SetRange("Job No.", JobNo);
        JobWIPEntry.DeleteAll(true);
    end;

    local procedure CreateWIPEntries(JobNo: Code[20])
    var
        JobWIPEntry: Record "Job WIP Entry";
        DimensionBuffer: Record "Dimension Buffer" temporary;
        //GL2024   LedgerEntryDimension: Record 355;
        NextEntryNo: Integer;
    begin
        if JobWIPEntry.Find('+') then
            NextEntryNo := JobWIPEntry."Entry No." + 1
        else
            NextEntryNo := 1;
        Clear(JobWIPEntry);

        GetGLSetup;
        if WIPBuffer[1].Find('-') then
            repeat
                if WIPBuffer[1]."WIP Entry Amount" <> 0 then begin
                    DimensionBuffer.Reset;
                    DimensionBuffer.DeleteAll;
                    DimensionBufferManagement.RetrieveDimensions(WIPBuffer[1]."Dim Combination ID", DimensionBuffer);
                    JobWIPEntry."Job No." := JobNo;
                    JobWIPEntry."WIP Posting Date" := WIPPostingDate;
                    JobWIPEntry."Document No." := DocNo;
                    JobWIPEntry.Type := WIPBuffer[1].Type;
                    JobWIPEntry."Job Posting Group" := WIPBuffer[1]."Posting Group";
                    JobWIPEntry."G/L Account No." := WIPBuffer[1]."G/L Account No.";
                    JobWIPEntry."G/L Bal. Account No." := WIPBuffer[1]."Bal. G/L Account No.";
                    /*GL2024 JobWIPEntry."WIP Method Used" := WIPBuffer[1]."WIP Method";
                     JobWIPEntry."Job Complete" := WIPBuffer[1]."Job Complete";
                     JobWIPEntry."WIP Posting Date Filter" := WIPBuffer[1]."WIP Posting Date Filter";
                     JobWIPEntry."WIP Planning Date Filter" := WIPBuffer[1]."WIP Planning Date Filter";
                     JobWIPEntry."WIP Entry Amount" := WIPBuffer[1]."WIP Entry Amount";
                     JobWIPEntry."WIP Schedule (Total Cost)" := WIPBuffer[1]."WIP Schedule (Total Cost)";
                     JobWIPEntry."WIP Schedule (Total Price)" := WIPBuffer[1]."WIP Schedule (Total Price)";
                     JobWIPEntry."WIP Usage (Total Cost)" := WIPBuffer[1]."WIP Usage (Total Cost)";
                     JobWIPEntry."WIP Usage (Total Price)" := WIPBuffer[1]."WIP Usage (Total Price)";
                     JobWIPEntry."WIP Contract (Total Cost)" := WIPBuffer[1]."WIP Contract (Total Cost)";
                     JobWIPEntry."WIP Contract (Total Price)" := WIPBuffer[1]."WIP Contract (Total Price)";
                     JobWIPEntry."WIP (Invoiced Price)" := WIPBuffer[1]."WIP (Invoiced Price)";
                     JobWIPEntry."WIP (Invoiced Cost)" := WIPBuffer[1]."WIP (Invoiced Cost)";*/
                    JobWIPEntry."Entry No." := NextEntryNo;
                    /* GL2024 if DimensionBuffer.FindSet then
                          repeat
                              LedgerEntryDimension."Table ID" := Database::"Job WIP Entry";
                              LedgerEntryDimension."Entry No." := JobWIPEntry."Entry No.";
                              LedgerEntryDimension."Dimension Code" := DimensionBuffer."Dimension Code";
                              LedgerEntryDimension."Dimension Value Code" := DimensionBuffer."Dimension Value Code";
                              if LedgerEntryDimension."Dimension Code" = GLSetup."Global Dimension 1 Code" then
                                  JobWIPEntry."Global Dimension 1 Code" := DimensionBuffer."Dimension Value Code";
                              if LedgerEntryDimension."Dimension Code" = GLSetup."Global Dimension 2 Code" then
                                  JobWIPEntry."Global Dimension 2 Code" := DimensionBuffer."Dimension Value Code";
                              LedgerEntryDimension.Insert;
                          until DimensionBuffer.Next = 0;*/
                    JobWIPEntry.Insert;
                    NextEntryNo := NextEntryNo + 1;
                end;
            until WIPBuffer[1].Next = 0;
    end;


    procedure CalcGLWIP(JobNo: Code[20]; JustReverse: Boolean; DocNo: Code[20]; PostingDate: Date; NewPostDate: Boolean)
    var
        SourceCodeSetup: Record "Source Code Setup";
        GLEntry: Record "G/L Entry";
        Job: Record Job;
        JobWIPEntry: Record "Job WIP Entry";
        JobWIPGLEntry: Record "Job WIP G/L Entry";
        //GL2024   LedgerEntryDimension: Record 355;
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
        WIPCalcMethodFound: Boolean;
    begin
        JobWIPGLEntry.LockTable;
        JobWIPEntry.LockTable;
        Job.LockTable;
        Job.Get(JobNo);

        JobWIPGLEntry.SetCurrentkey("Job No.", Reversed, "Job Complete");
        JobWIPGLEntry.SetRange("Job No.", JobNo);
        JobWIPGLEntry.SetRange("Job Complete", true);
        if JobWIPGLEntry.Find('-') then
            exit;
        JobWIPGLEntry.Reset;

        Job.TestBlocked;
        Job."WIP Entries Exist" := not JustReverse;
        if NewPostDate then
            Job."WIP G/L Posting Date" := PostingDate;
        if JustReverse then begin
            Job."WIP G/L Posting Date" := 0D;
            //GL2024  Job."Posted WIP Method Used" := 0;
        end;
        Job.Modify;
        if JobWIPGLEntry.Find('+') then
            NextEntryNo := JobWIPGLEntry."Entry No." + 1
        else
            NextEntryNo := 1;
        SourceCodeSetup.Get;
        JobWIPGLEntry.SetCurrentkey("WIP Transaction No.");
        if JobWIPGLEntry.Find('+') then
            NextTransactionNo := JobWIPGLEntry."WIP Transaction No." + 1
        else
            NextTransactionNo := 1;
        JobWIPGLEntry.SetCurrentkey("Job No.", Reversed);
        JobWIPGLEntry.SetRange("Job No.", JobNo);
        JobWIPGLEntry.SetRange(Reversed, false);
        // reversed
        if JobWIPGLEntry.Find('-') then
            repeat
                if JobWIPGLEntry."Posting Date" > PostingDate then
                    Error(Text004, JobWIPGLEntry."Job No.", JobWIPGLEntry."Posting Date");
            until JobWIPGLEntry.Next = 0;
        JobWIPGLEntry.SetRange("Job No.", JobNo);
        JobWIPGLEntry.SetRange(Reversed, false);
        /* GL2024  if JobWIPGLEntry.Find('-') then
              repeat
                  LedgerEntryDimension.SetRange("Table ID", Database::"Job WIP G/L Entry");
                  LedgerEntryDimension.SetRange("Entry No.", JobWIPGLEntry."Entry No.");
                  PostWIPGL(JobWIPGLEntry, true, DocNo, SourceCodeSetup."Job G/L WIP", PostingDate, LedgerEntryDimension);
              until JobWIPGLEntry.Next = 0;*/
        JobWIPGLEntry.ModifyAll("Reverse Date", PostingDate);
        JobWIPGLEntry.ModifyAll(Reversed, true);
        if JustReverse then
            exit;
        JobWIPEntry.SetRange("Job No.", JobNo);
        if JobWIPEntry.Find('-') then begin
            WIPCalcMethodFound := false;
            repeat
                Clear(JobWIPGLEntry);
                JobWIPGLEntry."Job No." := JobWIPEntry."Job No.";
                JobWIPGLEntry."Document No." := JobWIPEntry."Document No.";
                JobWIPGLEntry."G/L Account No." := JobWIPEntry."G/L Account No.";
                JobWIPGLEntry."G/L Bal. Account No." := JobWIPEntry."G/L Bal. Account No.";
                JobWIPGLEntry.Type := JobWIPEntry.Type;
                JobWIPGLEntry."WIP Posting Date" := JobWIPEntry."WIP Posting Date";
                if NewPostDate then
                    JobWIPGLEntry."Posting Date" := PostingDate
                else
                    JobWIPGLEntry."Posting Date" := JobWIPEntry."WIP Posting Date";
                JobWIPGLEntry."Job Posting Group" := JobWIPEntry."Job Posting Group";
                /*GL2024   JobWIPGLEntry."WIP Method Used" := JobWIPEntry."WIP Method Used";*/
                if not WIPCalcMethodFound then begin
                    //GL2024       Job."Posted WIP Method Used" := JobWIPEntry."WIP Method Used";
                    if not NewPostDate then
                        Job."WIP G/L Posting Date" := JobWIPEntry."WIP Posting Date";
                    Job.Modify;
                    WIPCalcMethodFound := true;
                end;
                /*GL2024      JobWIPGLEntry."WIP Posting Date Filter" := JobWIPEntry."WIP Posting Date Filter";
                      JobWIPGLEntry."WIP Planning Date Filter" := JobWIPEntry."WIP Planning Date Filter";*/
                JobWIPGLEntry.Reversed := false;
                JobWIPGLEntry."Job Complete" := JobWIPEntry."Job Complete";
                JobWIPGLEntry."WIP Transaction No." := NextTransactionNo;
                if JobWIPGLEntry.Type in [JobWIPGLEntry.Type::"Recognized Costs", JobWIPGLEntry.Type::"Recognized Sales"] then begin
                    if JobWIPGLEntry."Job Complete" then
                        JobWIPGLEntry.Description := StrSubstNo(Text000, Text003, JobWIPGLEntry.FieldCaption("Job No."), JobNo,
                            JobWIPGLEntry."Posting Date")
                    else
                        JobWIPGLEntry.Description := StrSubstNo(Text000, Text002, JobWIPGLEntry.FieldCaption("Job No."), JobNo,
                            JobWIPGLEntry."Posting Date");
                end else
                    JobWIPGLEntry.Description := StrSubstNo(Text000, Text001, JobWIPGLEntry.FieldCaption("Job No."), JobNo,
                        JobWIPGLEntry."Posting Date");
                JobWIPGLEntry."WIP Entry Amount" := JobWIPEntry."WIP Entry Amount";
                /*GL2024     JobWIPGLEntry."WIP Schedule (Total Cost)" := JobWIPEntry."WIP Schedule (Total Cost)";
                     JobWIPGLEntry."WIP Schedule (Total Price)" := JobWIPEntry."WIP Schedule (Total Price)";
                     JobWIPGLEntry."WIP Usage (Total Cost)" := JobWIPEntry."WIP Usage (Total Cost)";
                     JobWIPGLEntry."WIP Usage (Total Price)" := JobWIPEntry."WIP Usage (Total Price)";
                     JobWIPGLEntry."WIP Contract (Total Cost)" := JobWIPEntry."WIP Contract (Total Cost)";
                     JobWIPGLEntry."WIP Contract (Total Price)" := JobWIPEntry."WIP Contract (Total Price)";
                     JobWIPGLEntry."WIP (Invoiced Price)" := JobWIPEntry."WIP (Invoiced Price)";
                     JobWIPGLEntry."WIP (Invoiced Cost)" := JobWIPEntry."WIP (Invoiced Cost)";*/
                JobWIPGLEntry."Global Dimension 1 Code" := JobWIPEntry."Global Dimension 1 Code";
                JobWIPGLEntry."Global Dimension 2 Code" := JobWIPEntry."Global Dimension 2 Code";
                JobWIPGLEntry."Entry No." := NextEntryNo;
                NextEntryNo := NextEntryNo + 1;
                /* GL2024  LedgerEntryDimension.Reset;
                   LedgerEntryDimension.SetRange("Table ID", Database::"Job WIP Entry");
                   LedgerEntryDimension.SetRange("Entry No.", JobWIPEntry."Entry No.");
                   PostWIPGL(JobWIPGLEntry,
                             false,
                             JobWIPGLEntry."Document No.",
                             SourceCodeSetup."Job G/L WIP",
                             JobWIPGLEntry."Posting Date",
                             LedgerEntryDimension);*/
                GLEntry.Find('+');
                JobWIPGLEntry."G/L Entry No." := GLEntry."Entry No.";
                /*  //GL2024 DimMgt.CopyLedgEntryDimToLedgEntryDim(Database::"Job WIP Entry",
                                                        JobWIPEntry."Entry No.",
                                                        Database::"Job WIP G/L Entry",
                                                        JobWIPGLEntry."Entry No.");*/
                JobWIPGLEntry.Insert;
            until JobWIPEntry.Next = 0;
        end;
    end;

    local procedure PostWIPGL(JobWIPGLEntry: Record "Job WIP G/L Entry"; Reversed: Boolean; JnlDocNo: Code[20]; SourceCode: Code[10]; JnlPostingDate: Date; var LedgerEntryDimension: Record "Dimension Set ID Filter Line")
    var
        GLAmount: Decimal;
    begin
        CheckJobGLAcc(JobWIPGLEntry."G/L Account No.");
        CheckJobGLAcc(JobWIPGLEntry."G/L Bal. Account No.");
        GLAmount := JobWIPGLEntry."WIP Entry Amount";
        if Reversed then
            GLAmount := -GLAmount;

        InsertWIPGL(JobWIPGLEntry."G/L Bal. Account No.", JnlPostingDate, JnlDocNo, SourceCode, -GLAmount, JobWIPGLEntry.Description,
          JobWIPGLEntry."Job No.", LedgerEntryDimension);
        InsertWIPGL(JobWIPGLEntry."G/L Account No.", JnlPostingDate, JnlDocNo, SourceCode, GLAmount, JobWIPGLEntry.Description,
          JobWIPGLEntry."Job No.", LedgerEntryDimension);
    end;

    local procedure InsertWIPGL(AccNo: Code[20]; JnlPostingDate: Date; JnlDocNo: Code[20]; SourceCode: Code[10]; GLAmount: Decimal; JnlDescription: Text[50]; JobNo: Code[20]; var LedgerEntryDimension: Record "Dimension Set ID Filter Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLAcc: Record "G/L Account";
    //GL2024   TempJnlLineDim: Record 356 temporary;
    begin
        GLAcc.Get(AccNo);
        with GenJnlLine do begin
            Init;
            "Posting Date" := JnlPostingDate;
            "Account No." := AccNo;
            "Tax Area Code" := GLAcc."Tax Area Code";
            "Tax Liable" := GLAcc."Tax Liable";
            "Tax Group Code" := GLAcc."Tax Group Code";
            Amount := GLAmount;
            "Document No." := JnlDocNo;
            "Source Code" := SourceCode;
            Description := JnlDescription;
            "Job No." := JobNo;
            "System-Created Entry" := true;
        end;
        /* GL2024  Clear(TempJnlLineDim);
           TempJnlLineDim.DeleteAll;
           Clear(DimMgt);
           DimMgt.MoveLedgEntryDimToJnlLineDim(LedgerEntryDimension, TempJnlLineDim, Database::"Gen. Journal Line", '', '', 0, 0);
           GetGLSetup;
           TempJnlLineDim.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
           if TempJnlLineDim.FindFirst then
               GenJnlLine."Shortcut Dimension 1 Code" := TempJnlLineDim."Dimension Value Code"
           else
               GenJnlLine."Shortcut Dimension 1 Code" := '';
           TempJnlLineDim.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
           if TempJnlLineDim.FindFirst then
               GenJnlLine."Shortcut Dimension 2 Code" := TempJnlLineDim."Dimension Value Code"
           else
               GenJnlLine."Shortcut Dimension 2 Code" := '';
           TempJnlLineDim.Reset;
           GenJnPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);*/
    end;

    local procedure CheckJobGLAcc(AccNo: Code[20])
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get(AccNo);
        GLAcc.CheckGLAcc;
        GLAcc.TestField("Gen. Posting Type", GLAcc."gen. posting type"::" ");
        GLAcc.TestField("Gen. Bus. Posting Group", '');
        GLAcc.TestField("Gen. Prod. Posting Group", '');
        GLAcc.TestField("VAT Bus. Posting Group", '');
        GLAcc.TestField("VAT Prod. Posting Group", '');
    end;


    procedure GetGLSetup()
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get;
            HasGotGLSetup := true;
        end;
    end;


    procedure ReOpenJob(JobNo: Code[20])
    var
        JobWIPGLEntry: Record "Job WIP G/L Entry";
    begin
        InitWIP(JobNo);
        JobWIPGLEntry.SetCurrentkey("Job No.", Reversed, "Job Complete");
        JobWIPGLEntry.SetRange("Job No.", JobNo);
        JobWIPGLEntry.ModifyAll("Job Complete", false);
    end;
}

