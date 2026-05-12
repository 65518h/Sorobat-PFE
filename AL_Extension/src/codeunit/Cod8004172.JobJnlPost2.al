Codeunit 8004172 "Job Jnl.-Post2"
{
    // //PROJET_CESSION GESWAY 24/05/02 Génération des écritures de cession
    //                         10/03/04 Pas de génération pour les répartitions analytiques (FS déjà équilibrée)
    // //POINTAGE GESWAY 05/06/02 Eclatement des lignes machine,qté 1 ...
    // //STOCK GESWAY 03/09/03 Ajout de la fonction wCreateNewPhysInvLine

    TableNo = "Job Journal Line";

    trigger OnRun()
    begin
        JobJnlLine.Copy(Rec);
        Code;
        Rec.Copy(JobJnlLine);
    end;

    var
        Text000: label 'cannot be filtered when posting recurring journals.';
        Text001: label 'Do you want to post the journal lines?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The journal lines were successfully posted.';
        Text004: label 'The journal lines were successfully posted. ';
        Text005: label 'You are now in the %1 journal.';
        JobJnlTemplate: Record "Job Journal Template";
        JobJnlLine: Record "Job Journal Line";
        JobJnlPostbatch: Codeunit "Job Jnl.-Post Batch2";
        TempJnlBatchName: Code[10];
        wCreateBalJobJnlLine: Codeunit "Create Bal. Job Journal Line";
        wCreateJobJnLineWT: Codeunit "Create Job Journal Line WT";

    local procedure "Code"()
    var
        lJobJnlLine: Record "Job Journal Line";
    begin
        with JobJnlLine do begin
            JobJnlTemplate.Get("Journal Template Name");
            JobJnlTemplate.TestField("Force Posting Report", false);
            if JobJnlTemplate.Recurring and (GetFilter("Posting Date") <> '') then
                FieldError("Posting Date", Text000);

            if not Confirm(Text001) then
                exit;

            TempJnlBatchName := "Journal Batch Name";
            //STOCK
            //#4613
            JobJnlLine.SetRange("Journal Template Name", "Journal Template Name");
            //#4613//
            wCreateNewPhysInvLine(JobJnlLine);
            //STOCK//
            //POINTAGE
            FilterGroup(2);
            SetRange("Attached to Line No.");
            FilterGroup(0);
            lJobJnlLine.Copy(JobJnlLine);
            lJobJnlLine.FilterGroup(2);
            lJobJnlLine.SetFilter("Attached to Line No.", '<>0');
            lJobJnlLine.FilterGroup(0);
            if lJobJnlLine.Find('-') then
                lJobJnlLine.DeleteAll;

            wCreateJobJnLineWT.Run(JobJnlLine);
            //POINTAGE//
            //PROJET_CESSION
            //#8877
            if JobJnlLine.Type <> JobJnlLine.Type::Item then
                //#8877
                if not JobJnlLine.wCheckAnalyticalDistribution then
                    wCreateBalJobJnlLine.Run(JobJnlLine);
            //PROJET_CESSION//
            JobJnlPostbatch.Run(JobJnlLine);

            if "Line No." = 0 then
                Message(Text002)
            else
                if TempJnlBatchName = "Journal Batch Name" then
                    Message(Text003)
                else
                    Message(
                      Text004 +
                      Text005,
                      "Journal Batch Name");

            if not Find('=><') or (TempJnlBatchName <> "Journal Batch Name") then begin
                Reset;
                FilterGroup(2);
                SetRange("Journal Template Name", "Journal Template Name");
                SetRange("Journal Batch Name", "Journal Batch Name");
                //POINTAGE
                SetRange("Attached to Line No.", 0);
                //POINTAGE//
                FilterGroup(0);
                "Line No." := 1;
            end;
        end;
    end;


    procedure wCreateNewPhysInvLine(var Rec: Record "Job Journal Line")
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlLine2: Record "Job Journal Line" temporary;
        lLineNo: Integer;
        i: Integer;
        lShortcutDimCode: array[8] of Code[20];
    begin
        //STOCK
        lJobJnlLine.Copy(Rec);
        lJobJnlLine2.DeleteAll;
        if lJobJnlLine.Find('+') then
            lLineNo := lJobJnlLine."Line No.";
        if not lJobJnlLine."Phys. Inventory" then
            exit;
        lJobJnlLine.SetFilter(Quantity, '<>%1', 0);
        if lJobJnlLine.FindSet then begin
            repeat
                if lJobJnlLine.Quantity <> 0 then begin
                    lJobJnlLine.ShowShortcutDimCode(lShortcutDimCode);
                    lLineNo += 10000;
                    lJobJnlLine2 := lJobJnlLine;
                    lJobJnlLine2."Line No." := lLineNo;
                    lJobJnlLine2.Validate("Posting Date", CalcDate('<1D>', lJobJnlLine."Posting Date"));
                    lJobJnlLine2.Validate(Quantity, -lJobJnlLine.Quantity);
                    lJobJnlLine2.Insert;

                    lJobJnlLine2.Validate("Shortcut Dimension 1 Code");
                    lJobJnlLine2.Validate("Shortcut Dimension 2 Code");
                    for i := 3 to 8 do
                        lJobJnlLine2.ValidateShortcutDimCode(i, lShortcutDimCode[i]);

                    Clear(lJobJnlLine2);
                end;
            until lJobJnlLine.Next = 0;

            if lJobJnlLine2.Find('-') then
                repeat
                    lJobJnlLine := lJobJnlLine2;
                    lJobJnlLine.Insert;
                until lJobJnlLine2.Next = 0;
        end;
        Rec.Copy(lJobJnlLine);
        //STOCK//
    end;
}

