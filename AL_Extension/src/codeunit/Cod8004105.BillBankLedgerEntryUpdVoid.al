Codeunit 8004105 "Bill Bank Ledger Entry UpdVoid"
{
    // #5491 ML 04/02/08
    // #5390 ML 24/12/07
    // //+PMT+PAYMENT GESWAY 01/08/02 Annulation (extourne d'un effet)
    //                            Ajout Permissions en Modify sur tables 21,25,270,379,380
    //                            Ajout setrange sur N° transaction dans UpdateCustLedgEntry et UpdateVendLedgEntry
    //                   04/09/03 Modification UpdateCustLedgEntry et UpdateVendLedgEntry

    Permissions = TableData "Cust. Ledger Entry" = m,
                  TableData "Vendor Ledger Entry" = m,
                  TableData "Bank Account" = m,
                  TableData "Bank Account Ledger Entry" = m,
                  TableData "Detailed Cust. Ledg. Entry" = m,
                  TableData "Detailed Vendor Ledg. Entry" = m;
    TableNo = "Bank Account Ledger Entry";

    trigger OnRun()
    var
        GenJnlLine: Record "Gen. Journal Line";
        Text1000000001: label 'Void';
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        //GL2024  TempLedgDim: Record 355;
        //GL2024    TempJnlLineDim: Record 356 temporary;
        DimMgt: Codeunit DimensionManagement;
    begin
        BankAccount.Get(rec."Bank Account No.");
        BankAccount.TestField("Bank Type");
        case rec."Bal. Account Type" of
            rec."bal. account type"::Customer:
                UpdateCustLedgEntry(Rec);
            rec."bal. account type"::Vendor:
                UpdateVendLedgEntry(Rec);
            else
                Error(Text1000000004, rec.FieldCaption("Bal. Account Type"), rec."bal. account type"::Customer, rec."bal. account type"::Vendor);
        end;

        SourceCodeSetup.Get;
        GenJnlLine.Init;
        //#5390 GenJnlLine."Source Code" := SourceCodeSetup."Payment Journal";
        GenJnlLine."Source Code" := rec."Source Code";
        //#5390//
        GenJnlLine."Line No." := 10000;
        GenJnlLine."Posting Date" := WorkDate;
        GenJnlLine."Document No." := rec."Document No.";
        GenJnlLine."Account Type" := rec."Bal. Account Type";
        GenJnlLine.Validate("Account No.", rec."Bal. Account No.");
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
        GenJnlLine.Validate("Bal. Account No.", rec."Bank Account No.");
        //GenJnlLine."Bank Account Code" := "Bank Account No.";
        GenJnlLine."Currency Code" := rec."Currency Code";
        //#5390
        GenJnlLine."Payment Bank Account" := rec."Bal. Bank Account No.";
        //#5390//
        GenJnlLine.Description := CopyStr(Text1000000001 + ' ' + rec.Description, 1, MaxStrLen(GenJnlLine.Description));
        GenJnlLine.Validate(Amount, rec.Amount);
        GenJnlLine."Bill Type" := rec."Bill Type";
        GenJnlLine."Due Date" := rec."Due Date";
        GenJnlLine."Reason Code" := rec."Reason Code";
        //#5140
        GenJnlLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := rec."Global Dimension 2 Code";
        //#5140//
        //GL2024   TempJnlLineDim.DeleteAll;
        //GL2024TempLedgDim.Reset;
        //GL2024  TempLedgDim.SetRange("Table ID", Database::"Bank Account Ledger Entry");
        //GL2024 TempLedgDim.SetRange("Entry No.", "Entry No.");
        //GL2024  DimMgt.CopyLedgEntryDimToJnlLineDim(TempLedgDim, TempJnlLineDim);
        //GL2024 GenJnlPostLine.RunWithCheck(GenJnlLine, TempJnlLineDim);
        Clear(GenJnlPostLine);
        Commit;
        rec.Open := false;
        //#5491
        rec."Remaining Amount" := 0;
        //#5491
        rec.Modify;

        rec.Reset;
        rec.SetCurrentkey("Entry No.");
        rec.SetRange("Bank Account No.", rec."Bank Account No.");
        rec.SetRange("Posting Date", WorkDate);
        rec.SetRange("Due Date", rec."Due Date");
        rec.SetRange(Amount, -rec.Amount);
        if rec.Find('+') then begin
            rec.Open := false;
            rec."Remaining Amount" := 0;
            rec.Modify;
        end;
    end;

    var
        Text1000000000: label 'Do you want to reverse this bank account to origin.';
        Text1000000001: label 'Due date can not earlier than workdate.';
        Text1000000002: label 'It must be one and only one Bal. account ledger entry.';
        SourceCodeSetup: Record "Source Code Setup";
        Text1000000004: label '%& must be %2 or %3';
        BankAccount: Record "Bank Account";


    procedure UpdateCustLedgEntry(var rec: Record "Bank Account Ledger Entry")
    var
        lCustLedgEntry: Record "Cust. Ledger Entry";
        lDetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        if rec."Bal. Account Type" <> rec."bal. account type"::Customer then
            exit;

        lCustLedgEntry.SetCurrentkey("Transaction No.");
        lCustLedgEntry.SetRange("Transaction No.", rec."Transaction No.");
        lCustLedgEntry.SetRange("Customer No.", rec."Bal. Account No.");
        lCustLedgEntry.SetRange("Posting Date", rec."Posting Date");
        lCustLedgEntry.SetRange("Document No.", rec."Document No.");
        lCustLedgEntry.Find('+');
        if lCustLedgEntry.Count <> 1 then
            Error(Text1000000002)
        else begin
            lDetCustLedgEntry.SetCurrentkey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
            lDetCustLedgEntry.SetRange("Cust. Ledger Entry No.", lCustLedgEntry."Entry No.");
            lDetCustLedgEntry.SetRange("Entry Type", lDetCustLedgEntry."entry type"::"Initial Entry");
            lDetCustLedgEntry.SetRange("Posting Date", rec."Posting Date");
            lDetCustLedgEntry.ModifyAll("Initial Document Type", 0);
        end;
    end;


    procedure UpdateVendLedgEntry(var rec: Record "Bank Account Ledger Entry")
    var
        lVendLedgEntry: Record "Vendor Ledger Entry";
        lDetVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        if rec."Bal. Account Type" <> rec."bal. account type"::Vendor then
            exit;

        lVendLedgEntry.SetCurrentkey("Transaction No.");
        lVendLedgEntry.SetRange("Transaction No.", rec."Transaction No.");
        lVendLedgEntry.SetRange("Vendor No.", rec."Bal. Account No.");
        lVendLedgEntry.SetRange("Posting Date", rec."Posting Date");
        lVendLedgEntry.SetRange("Document No.", rec."Document No.");
        lVendLedgEntry.Find('+');
        if lVendLedgEntry.Count <> 1 then
            Error(Text1000000002)
        else begin
            lDetVendLedgEntry.SetCurrentkey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
            lDetVendLedgEntry.SetRange("Vendor Ledger Entry No.", lVendLedgEntry."Entry No.");
            lDetVendLedgEntry.SetRange("Entry Type", lDetVendLedgEntry."entry type"::"Initial Entry");
            lDetVendLedgEntry.SetRange("Posting Date", rec."Posting Date");
            lDetVendLedgEntry.ModifyAll("Initial Document Type", 0);
        end;
    end;
}

