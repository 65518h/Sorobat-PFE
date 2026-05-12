Codeunit 8004170 "Job Jnl.-Post Batch2"
{
    // //+REP+ GESWAY 01/12/01 Suppression des écritures dans les tables tampon répartition
    // //CESSION GESWAY 16/06/03 Ne pas générer de ligne en fin de validation
    // //DESCRIPTION GESWAY 08/12/04 Gestion des commentaires sur les écr. chantier
    // //PLANNING MB 12/06/06 TEST DOCUMENT No. si pas de souches de validation

    Permissions = TableData "Job Journal Batch" = imd;
    TableNo = "Job Journal Line";

    trigger OnRun()
    begin
        JobJnlLine.Copy(Rec);
        Code;
        Rec := JobJnlLine;
    end;

    var
        Text000: label 'cannot exceed %1 characters.';
        Text001: label 'Journal Batch Name    #1##########\\';
        Text002: label 'Checking lines        #2######\';
        Text003: label 'Posting lines         #3###### @4@@@@@@@@@@@@@\';
        Text004: label 'Updating lines        #5###### @6@@@@@@@@@@@@@';
        Text005: label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text006: label 'A maximum of %1 posting number series can be used in each journal.';
        Text007: label '<Month Text>';
        AccountingPeriod: Record "Accounting Period";
        JobJnlTemplate: Record "Job Journal Template";
        JobJnlBatch: Record "Job Journal Batch";
        JobJnlLine: Record "Job Journal Line";
        JobJnlLine2: Record "Job Journal Line";
        JobJnlLine3: Record "Job Journal Line";
        //GL2024 LedgEntryDim: Record 355;
        JobLedgEntry: Record "Job Ledger Entry";
        JobReg: Record "Job Register";
        //GL2024     NoSeries: Record 308 temporary;
        JobJnlCheckLine: Codeunit "Job Jnl.-Check Line2";
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt2: array[10] of Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        JobRegNo: Integer;
        StartLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        MonthText: Text[30];
        LineCount: Integer;
        NoOfRecords: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;
        gAddOnLicencePermission: Codeunit IntegrManagement;

    local procedure "Code"()
    var
        // GL2024 JnlLineDim: Record 356;
        //GL2024  TempJnlLineDim: Record 356 temporary;
        UpdateAnalysisView: Codeunit "Update Analysis View";
        lDescriptionLine: Record "Description Line";
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        lAnaDistribIntegr: Codeunit "Analytical Distrib.Integr.";
    begin
        with JobJnlLine do begin
            SetRange("Journal Template Name", "Journal Template Name");
            SetRange("Journal Batch Name", "Journal Batch Name");
            if RECORDLEVELLOCKING then
                LockTable;

            JobJnlTemplate.Get("Journal Template Name");
            JobJnlBatch.Get("Journal Template Name", "Journal Batch Name");
            if StrLen(IncStr(JobJnlBatch.Name)) > MaxStrLen(JobJnlBatch.Name) then
                JobJnlBatch.FieldError(
                  Name,
                  StrSubstNo(
                    Text000,
                    MaxStrLen(JobJnlBatch.Name)));

            if JobJnlTemplate.Recurring then begin
                SetRange("Posting Date", 0D, WorkDate);
                SetFilter("Expiration Date", '%1 | %2..', 0D, WorkDate);
            end;

            if not Find('=><') then begin
                "Line No." := 0;
                Commit;
                exit;
            end;

            if JobJnlTemplate.Recurring then
                Window.Open(
                  Text001 +
                  Text002 +
                  Text003 +
                  Text004)
            else
                Window.Open(
                  Text001 +
                  Text002 +
                  Text005);
            Window.Update(1, "Journal Batch Name");

            // Check lines
            LineCount := 0;
            StartLineNo := "Line No.";
            /* GL2024   repeat
                   LineCount := LineCount + 1;
                   Window.Update(2, LineCount);
                   CheckRecurringLine(JobJnlLine);
                   JnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
                   JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
                   JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
                   JnlLineDim.SetRange("Journal Line No.", "Line No.");
                   JnlLineDim.SetRange("Allocation Line No.", 0);
                   TempJnlLineDim.DeleteAll;
                   DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim, TempJnlLineDim);
                   JobJnlCheckLine.RunCheck(JobJnlLine, TempJnlLineDim);
                   if Next = 0 then
                       Find('-');
               until "Line No." = StartLineNo;*/
            NoOfRecords := LineCount;

            // Find next register no.
            //GL2024  LedgEntryDim.LockTable;
            JobLedgEntry.LockTable;
            if RECORDLEVELLOCKING then
                if JobLedgEntry.Find('+') then;
            JobReg.LockTable;
            if JobReg.Find('+') and (JobReg."To Entry No." = 0) then
                JobRegNo := JobReg."No."
            else
                JobRegNo := JobReg."No." + 1;

            // Post lines
            LineCount := 0;
            LastDocNo := '';
            LastDocNo2 := '';
            LastPostedDocNo := '';
            Find('-');
            repeat
                LineCount := LineCount + 1;
                Window.Update(3, LineCount);
                Window.Update(4, ROUND(LineCount / NoOfRecords * 10000, 1));
                if not EmptyLine and
                   (JobJnlBatch."No. Series" <> '') and
                   ("Document No." <> LastDocNo2)
                then
                    TestField("Document No.", NoSeriesMgt.GetNextNo(JobJnlBatch."No. Series", "Posting Date", false));
                LastDocNo2 := "Document No.";
                MakeRecurringTexts(JobJnlLine);
                if "Posting No. Series" = '' then begin
                    "Posting No. Series" := JobJnlBatch."No. Series";
                    //PLANNING
                    if (JobJnlBatch."Posting No. Series" = '') and not EmptyLine then
                        //PLANNING//
                        TestField("Document No.");
                end else
                    if not EmptyLine then
                        if ("Document No." = LastDocNo) and ("Document No." <> '') then
                            "Document No." := LastPostedDocNo
            /* GL2024  else begin
                   if not NoSeries.Get("Posting No. Series") then begin
                       NoOfPostingNoSeries := NoOfPostingNoSeries + 1;
                       if NoOfPostingNoSeries > ArrayLen(NoSeriesMgt2) then
                           Error(
                             Text006,
                             ArrayLen(NoSeriesMgt2));
                       NoSeries.Code := "Posting No. Series";
                       NoSeries.Description := Format(NoOfPostingNoSeries);
                       NoSeries.Insert;
                   end;
                   LastDocNo := "Document No.";
                   //GL2024  Evaluate(PostingNoSeriesNo, NoSeries.Description);
                   "Document No." := NoSeriesMgt2[PostingNoSeriesNo].GetNextNo("Posting No. Series", "Posting Date", false);
                   LastPostedDocNo := "Document No.";
               end;*/
            /* GL2024  JnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
               JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
               JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
               JnlLineDim.SetRange("Journal Line No.", "Line No.");
               JnlLineDim.SetRange("Allocation Line No.", 0);
               TempJnlLineDim.DeleteAll;
               DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim, TempJnlLineDim);
               JobJnlPostLine.RunWithCheck(JobJnlLine, TempJnlLineDim);*/
            until Next = 0;

            // Copy register no. and current journal batch name to the job journal
            if not JobReg.Find('+') or (JobReg."No." <> JobRegNo) then
                JobRegNo := 0;

            Init;
            "Line No." := JobRegNo;

            // Update/delete lines
            if JobRegNo <> 0 then begin
                if not RECORDLEVELLOCKING then begin
                    //GL2024 JnlLineDim.LockTable(true, true);
                    LockTable(true, true);
                end;
                if JobJnlTemplate.Recurring then begin
                    // Recurring journal
                    LineCount := 0;
                    JobJnlLine2.CopyFilters(JobJnlLine);
                    JobJnlLine2.Find('-');
                    repeat
                        LineCount := LineCount + 1;
                        Window.Update(5, LineCount);
                        Window.Update(6, ROUND(LineCount / NoOfRecords * 10000, 1));
                        if JobJnlLine2."Posting Date" <> 0D then
                            JobJnlLine2.Validate("Posting Date", CalcDate(JobJnlLine2."Recurring Frequency", JobJnlLine2."Posting Date"));
                        if (JobJnlLine2."Recurring Method" = JobJnlLine2."recurring method"::Variable) and
                           (JobJnlLine2."No." <> '')
                        then
                            JobJnlLine2.DeleteAmounts;
                        JobJnlLine2.Modify;
                    until JobJnlLine2.Next = 0;
                end else begin
                    // Not a recurring journal
                    JobJnlLine2.CopyFilters(JobJnlLine);
                    JobJnlLine2.SetFilter("No.", '<>%1', '');
                    //+REP+
                    if gAddOnLicencePermission.HasPermissionREP then
                        lAnaDistribIntegr.DeleteAnaDistribLinesFromJob(JobJnlLine2, true)
                    else
                        //+REP+//
                        if JobJnlLine2.Find then; // Remember the last line

                    /* GL2024  JnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
                       JnlLineDim.Copyfilter("Journal Template Name", "Journal Template Name");
                       JnlLineDim.Copyfilter("Journal Batch Name", "Journal Batch Name");
                       JnlLineDim.SetRange("Allocation Line No.", 0);
                       JobJnlLine3.Copy(JobJnlLine);
                       if JobJnlLine3.Find('-') then
                           repeat
                               JnlLineDim.SetRange("Journal Line No.", JobJnlLine3."Line No.");
                               JnlLineDim.DeleteAll;
                               JobJnlLine3.Delete;
                           until JobJnlLine3.Next = 0;*/
                    JobJnlLine3.Reset;
                    JobJnlLine3.SetRange("Journal Template Name", "Journal Template Name");
                    JobJnlLine3.SetRange("Journal Batch Name", "Journal Batch Name");
                    if not JobJnlLine3.Find('+') then
                        if IncStr("Journal Batch Name") <> '' then begin
                            JobJnlBatch.Delete;
                            JobJnlBatch.Name := IncStr("Journal Batch Name");
                            if JobJnlBatch.Insert then;
                            "Journal Batch Name" := JobJnlBatch.Name;
                        end;

                    JobJnlLine3.SetRange("Journal Batch Name", "Journal Batch Name");
                    //CESSION : Pas de génération de ligne en fin de validation
                    /*      IF (JobJnlBatch."No. Series" = '') AND NOT JobJnlLine3.FIND('+') THEN BEGIN
                            JobJnlLine3.INIT;
                            JobJnlLine3."Journal Template Name" := "Journal Template Name";
                            JobJnlLine3."Journal Batch Name" := "Journal Batch Name";
                            JobJnlLine3."Line No." := 10000;
                            JobJnlLine3.INSERT;
                            JobJnlLine3.SetUpNewLine(JobJnlLine2);
                            JobJnlLine3.MODIFY;
                          END;  */
                    //CESSION//
                end;
            end;
            if JobJnlBatch."No. Series" <> '' then
                NoSeriesMgt.SaveNoSeries;
            /* GL2024  if NoSeries.Find('-') then
                   repeat
                       Evaluate(PostingNoSeriesNo, NoSeries.Description);
                       NoSeriesMgt2[PostingNoSeriesNo].SaveNoSeries;
                   until NoSeries.Next = 0;*/

            //DESCRIPTION
            lDescriptionLine.DeleteLines(Database::"Job Journal Line", 0, JobJnlLine."Journal Template Name" + JobJnlLine."Journal Batch Name",
                                        JobJnlLine."Line No.");
            //DESCRIPTION//
            Commit;
        end;
        UpdateAnalysisView.UpdateAll(0, true);
        UpdateItemAnalysisView.UpdateAll(0, true);
        Commit;

    end;

    local procedure CheckRecurringLine(var JobJnlLine2: Record "Job Journal Line")
    var
        TempDateFormula: DateFormula;
    begin
        with JobJnlLine2 do begin
            if "No." <> '' then
                if JobJnlTemplate.Recurring then begin
                    TestField("Recurring Method");
                    TestField("Recurring Frequency");
                    if "Recurring Method" = "recurring method"::Variable then
                        TestField(Quantity);
                end else begin
                    TestField("Recurring Method", 0);
                    TestField("Recurring Frequency", TempDateFormula);
                end;
        end;
    end;

    local procedure MakeRecurringTexts(var JobJnlLine2: Record "Job Journal Line")
    begin
        with JobJnlLine2 do begin
            if ("No." <> '') and ("Recurring Method" <> 0) then begin // Not recurring
                Day := Date2dmy("Posting Date", 1);
                Week := Date2dwy("Posting Date", 2);
                Month := Date2dmy("Posting Date", 2);
                MonthText := Format("Posting Date", 0, Text007);
                AccountingPeriod.SetRange("Starting Date", 0D, "Posting Date");
                if not AccountingPeriod.Find('+') then
                    AccountingPeriod.Name := '';
                "Document No." :=
                  DelChr(
                    PadStr(
                      StrSubstNo("Document No.", Day, Week, Month, MonthText, AccountingPeriod.Name),
                      MaxStrLen("Document No.")),
                    '>');
                Description :=
                  DelChr(
                    PadStr(
                      StrSubstNo(Description, Day, Week, Month, MonthText, AccountingPeriod.Name),
                      MaxStrLen(Description)),
                    '>');
            end;
        end;
    end;
}

