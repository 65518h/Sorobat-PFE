Codeunit 70831 LsvMgt
{
    //GL2024  ID dans Nav 2009 : "3010831"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="LS"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Payment Add-On (LSV)</add>
    //   <change id="CH2810" dev="SRYSER" date="2006-04-15" area="LS"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="PS9380">
    //     LSV Plus redesign</change>
    //   <change id="CH2811" dev="SRYSER" date="2006-04-15" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH4.00.03" feature="PS18377">
    //     Check if Gen. Journal Line is Empty</change>
    //   <change id="CH2820" dev="SRYSER" date="2006-07-27" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH4.00.03" feature="PS18597">
    //     Closed by ESR, additional Checks</change>
    //   <change id="CH2821" dev="sryser" date="2006-08-07" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH5.00" feature="PSCORS1045">
    //     Changed CustLedgEntry.SetCurrentkey because of W1 change</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="LS"
    //     baseversion="CH5.00" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>

    Permissions = TableData "Cust. Ledger Entry" = rm;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'The payment for customer %1 with amount %2 ist planned for LSV collection %3.\';
        Text002: label 'There are already entries in the G/L journal %1. Please post or delete them before you proceed.';
        Text004: label 'Delete line?';
        Text015: label 'Modify posting date\';
        Text016: label 'New date: #1########';
        Text017: label 'Do you want to modify the field %1 on all lines from %2 to %3?';
        Text035: label 'Collection is Closed, no change possible.';
        Text036: label '%1 entry not found.';
        Text037: label 'Invoice %1 could not be found. Please check the file.';
        Text038: label 'Reopen Collection, are you sure?';
        Text039: label 'Invoice %1 duplicate. Please check.';
        Text040: label 'Invoice %1 was finished. Please check.';
        LsvJour: Record "LSV Journal";
        LsvJournalLine: Record "LSV Journal Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GlLine: Record "Gen. Journal Line";
        d: Dialog;


    procedure ReleaseCustLedgEntries(_GenJnlLine: Record "Gen. Journal Line")
    begin
        if _GenJnlLine."Account Type" = _GenJnlLine."account type"::Customer then begin
            CustLedgEntry.Reset;
            // CH2821.BEGIN
            CustLedgEntry.SetCurrentkey("Document No.");
            // CH2821.END
            CustLedgEntry.SetRange("Document Type", _GenJnlLine."Applies-to Doc. Type");
            CustLedgEntry.SetRange("Document No.", _GenJnlLine."Applies-to Doc. No.");
            CustLedgEntry.SetFilter("LSV No.", '<>%1', 0);
            if CustLedgEntry.Find('-') then begin
                if not Confirm(
                     Text000 +
                     Text004,
                     true, _GenJnlLine."Account No.", -_GenJnlLine.Amount, CustLedgEntry."LSV No.")
                then
                    Error('');

                LsvJournalLine.SetCurrentkey("Applies-to Doc. No.");
                LsvJournalLine.SetRange("Applies-to Doc. No.", _GenJnlLine."Applies-to Doc. No.");
                if not LsvJournalLine.Find('-') then
                    Error(Text036, LsvJournalLine.TableCaption);

                LsvJournalLine."LSV Status" := LsvJournalLine."lsv status"::Open;
                LsvJournalLine.Modify;

                LsvJour.Get(LsvJournalLine."LSV Journal No.");
                LsvJour.Validate("LSV Status");
                LsvJour.Modify;

                // Adjust balance posting in G/L Line if matching Total Amount
                GlLine.Reset;
                GlLine.SetRange("Journal Template Name", _GenJnlLine."Journal Template Name");
                GlLine.SetRange("Journal Batch Name", _GenJnlLine."Journal Batch Name");
                if GlLine.Find('+') then begin
                    if GlLine.Amount = LsvJour.Amount then begin  // Amount before Corr.
                        GlLine.Validate(Amount, LsvJour.Amount);
                        GlLine.Modify;
                    end;
                end;
            end;
        end;
    end;


    procedure ModifyPostingDate(var ActLSVJourLine: Record "LSV Journal Line")
    var
        NewDate: Date;
    begin
        LsvJour.Get(ActLSVJourLine."LSV Journal No.");
        if LsvJour."LSV Status" >= LsvJour."lsv status"::Released then
            Error(Text035);
        NewDate := LsvJour."Credit Date";

        d.Open(
          Text015 +
          Text016);
        d.Update(1, NewDate);
        /* GL2024 if d.INPUT(1, NewDate) = 0 then
              exit;*/

        d.Close;

        if not Confirm(Text017, true, LsvJour.FieldCaption("Credit Date"), LsvJour."Credit Date", NewDate) then
            exit;

        LsvJour."Credit Date" := NewDate;
        LsvJour.Modify;
    end;


    procedure LSVJournalToGLJournal(GenJournalLine: Record "Gen. Journal Line"; LsvJournal: Record "LSV Journal")
    var
        LsvLine: Record "LSV Journal Line";
        GLSetup: Record "General Ledger Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LastEntryNo: Integer;
    begin
        LsvLine.SetRange("LSV Journal No.", LsvJournal."No.");
        LsvLine.SetRange("LSV Status", LsvLine."lsv status"::Open);

        GenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        // CH2811.BEGIN
        if GenJournalLine.Find('-') then
            Error(Text002, GenJournalLine."Journal Batch Name");
        // CH2811.END
        if GenJournalLine.Find('+') then
            LastEntryNo := GenJournalLine."Line No.";

        GenJournalBatch.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalBatch.SetRange(Name, GenJournalLine."Journal Batch Name");
        GenJournalBatch.Find('-');
        GenJournalBatch.TestField("No. Series");

        if LsvLine.Find('-') then
            repeat
                LastEntryNo := LastEntryNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := GenJournalLine."Journal Template Name";
                GenJournalLine."Journal Batch Name" := GenJournalLine."Journal Batch Name";
                GenJournalLine."Line No." := LastEntryNo;
                GenJournalLine.Validate("Account Type", GenJournalLine."account type"::Customer);
                GenJournalLine.Validate("Document No.",
                  NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", LsvJournal."Credit Date", false));
                GenJournalLine.Validate("Posting Date", LsvJournal."Credit Date");
                GenJournalLine."Applies-to Doc. Type" := GenJournalLine."applies-to doc. type"::Invoice;
                GenJournalLine.Validate("Applies-to Doc. No.", LsvLine."Applies-to Doc. No.");
                GLSetup.Get;
                if GLSetup."LCY Code" <> LsvLine."Currency Code" then
                    GenJournalLine.Validate("Currency Code", LsvLine."Currency Code");
                GenJournalLine.Insert;

                LsvLine."LSV Status" := LsvLine."lsv status"::"Transferred to Pmt. Journal";
                LsvLine.Modify;
            until LsvLine.Next = 0;
        LsvJournal.Validate("LSV Status");
        LsvJournal.Modify;
    end;


    procedure ClosedByESR(InvoiceNo: Code[20])
    begin
        LsvJournalLine.Reset;
        LsvJournalLine.SetCurrentkey("Applies-to Doc. No.");
        LsvJournalLine.SetRange("Applies-to Doc. No.", InvoiceNo);
        // CH2820.BEGIN
        LsvJournalLine.SetRange("LSV Status", LsvJournalLine."lsv status"::"Closed by ESR",
          LsvJournalLine."lsv status"::"Transferred to Pmt. Journal");
        if LsvJournalLine.Find('-') then
            Error(Text040, InvoiceNo);
        LsvJournalLine.SetRange("LSV Status");
        // CH2820.END
        if not LsvJournalLine.Find('-') then
            Error(Text037, InvoiceNo);

        // CH2820.BEGIN
        if LsvJournalLine.Count > 1 then begin
            // Rejected entry switch to Closed by ESR
            LsvJournalLine.SetRange("LSV Status", LsvJournalLine."lsv status"::Rejected);
            if not LsvJournalLine.Find('-') then
                Error(Text039, InvoiceNo);

            CustLedgEntry.Get(LsvJournalLine."Cust. Ledg. Entry No.");
            CustLedgEntry."On Hold" := 'LSV';
            CustLedgEntry."LSV No." := LsvJournalLine."LSV Journal No.";
            CustLedgEntry.Modify;
            LsvJournalLine."LSV Status" := LsvJournalLine."lsv status"::"Closed by ESR";
            LsvJournalLine.Modify;

            // Switch the open to rejected
            LsvJournalLine.SetRange("LSV Status", LsvJournalLine."lsv status"::Open);
            if not LsvJournalLine.Find('-') then
                Error(Text039, InvoiceNo);
            LsvJournalLine."LSV Status" := LsvJournalLine."lsv status"::Rejected;
            LsvJournalLine.Modify;
        end else begin
            LsvJournalLine."LSV Status" := LsvJournalLine."lsv status"::"Closed by ESR";
            LsvJournalLine.Modify;
        end;
        // CH2820.END

        LsvJour.Get(LsvJournalLine."LSV Journal No.");
        LsvJour.Validate("LSV Status");
        LsvJour.Modify;
    end;


    procedure ReopenJournal(var ActLSVJour: Record "LSV Journal")
    begin
        if ActLSVJour."LSV Status" >= ActLSVJour."lsv status"::Finished then
            Error(Text035);

        LsvJournalLine.SetRange("LSV Journal No.", ActLSVJour."No.");
        LsvJournalLine.SetFilter("LSV Status", '<>%1', LsvJournalLine."lsv status"::Open);
        if LsvJournalLine.Find('-') then
            Error(Text035);

        if not Confirm(Text038, false) then
            exit;

        ActLSVJour."LSV Status" := ActLSVJour."lsv status"::Edit;
        ActLSVJour.Modify;
    end;
}

