codeunit 50045 CheckManagementEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnBeforeVoidCheckGenJnlLine2Modify', '', true, true)]
    local procedure OnBeforeVoidCheckGenJnlLine2Modify(var GenJournalLine2: Record "Gen. Journal Line"; GenJournalLine: Record "Gen. Journal Line")
    var
        lCheckMgtPaymentIntegr: Codeunit "CheckMgt Payment Integr.";
    begin
        //+PMT+PAYMENT
        // IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Bank Account") OR
        //   NOT gAddOnLicencePermission.HasPermissionPMT THEN
        //+PMT+PAYMENT//
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lCheckMgtPaymentIntegr.SetFilterGJLbyCheckLedgEntry(GenJournalLine2, GenJournalLine."Check Ledger Entry No.");

        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lCheckMgtPaymentIntegr.SetGJLPaymentType(GenJournalLine, GenJournalLine2);

        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lCheckMgtPaymentIntegr.InitGJLCheckLedgEntry(GenJournalLine2);
        //GenJnlLine2."Check Ledger Entry No." := 0;
        //+PMT+PAYMENT//


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnVoidCheckOnAfterCheckLedgEntry2SetFilters', '', true, true)]
    local procedure OnVoidCheckOnAfterCheckLedgEntry2SetFilters(var CheckLedgerEntry: Record "Check Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        lCheckMgtPaymentIntegr: Codeunit "CheckMgt Payment Integr.";
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lCheckMgtPaymentIntegr.SetFilterCheckLedgEntry(CheckLedgerEntry, GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnBeforeFinancialVoidCheck', '', true, true)]
    local procedure OnBeforeFinancialVoidCheck(var CheckLedgerEntry: Record "Check Ledger Entry"; var IsHandled: Boolean)
    var
        lCheckMgtPaymentIntegr: Codeunit "CheckMgt Payment Integr.";
    begin
        // //+PMT+PAYMENT
        // IF gAddOnLicencePermission.HasPermissionPMT AND
        //    lCheckMgtPaymentIntegr.FinancialVoidCheck(CheckLedgEntry, GenJnlLine2) THEN
        //     EXIT;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnFinancialVoidCheckOnBeforePostVoidCheckLine', '', true, true)]
    local procedure OnFinancialVoidCheckOnBeforePostVoidCheckLine(var GenJournalLine: Record "Gen. Journal Line"; var CheckLedgEntry: Record "Check Ledger Entry"; var BankAccLedgEntry2: Record "Bank Account Ledger Entry")
    begin
        //#6153
        GenJournalLine."Reason Code" := BankAccLedgEntry2."Reason Code";
        //#7275
        //GenJnlLine2."Payment Type" := CheckLedgEntry."Payment Type" + 1;
        //#7275//
        //#6153//
        //#7334
        GenJournalLine."Due Date" := GenJournalLine."Posting Date";
        //#7334//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnFinancialVoidCheckOnBeforePostBalAccLine', '', true, true)]
    local procedure OnFinancialVoidCheckOnBeforePostBalAccLine(var GenJournalLine: Record "Gen. Journal Line"; CheckLedgerEntry: Record "Check Ledger Entry")
    begin
        //#6153
        //GenJournalLine."Reason Code" := "Reason Code";
        GenJournalLine."Payment Type" := CheckLedgerEntry."Payment Type" + 1;
        //#6153//
    end;

    PROCEDURE wFinancialVoidPayment(VAR CheckLedgEntry: Record "Check Ledger Entry");
    VAR
        lCheckLedgEntry2: Record "Check Ledger Entry";
        TransactionBalance: Decimal;
        BankAcc: Record "Bank Account";
        BankAccLedgEntry2, BankAccLedgEntry3 : Record "Bank Account Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        GLEntry: Record "G/L Entry";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FALedgEntry: Record "FA Ledger Entry";
        Text001: LABEL 'Annulation du chéque %1.';
        Text002: Label 'Vous ne pouvez pas financiŠrement annuler les chéques validés dans une transaction déséquilibrée.';
    BEGIN
        //Annulation de l'‚criture compte bancaire
        CheckLedgEntry.TESTFIELD("Entry Status", CheckLedgEntry."Entry Status"::Posted);
        CheckLedgEntry.TESTFIELD("Statement Status", CheckLedgEntry."Statement Status"::Open);
        CheckLedgEntry.TESTFIELD("Bal. Account No.");
        BankAcc.GET(CheckLedgEntry."Bank Account No.");
        BankAccLedgEntry2.GET(CheckLedgEntry."Bank Account Ledger Entry No.");
        SourceCodeSetup.GET;
        WITH GLEntry DO BEGIN
            SETCURRENTKEY("Transaction No.");
            SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
            SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
            IF FIND('-') THEN
                REPEAT
                    TransactionBalance := TransactionBalance + Amount;
                UNTIL NEXT = 0;
        END;
        IF TransactionBalance <> 0 THEN
            ERROR(Text002);

        GenJnlLine2.INIT;
        GenJnlLine2."Document No." := CheckLedgEntry."Document No.";
        GenJnlLine2."Account Type" := GenJnlLine2."Account Type"::"Bank Account";
        GenJnlLine2."Posting Date" := CheckLedgEntry."Posting Date";
        GenJnlLine2.VALIDATE("Account No.", CheckLedgEntry."Bank Account No.");
        GenJnlLine2.Description := STRSUBSTNO(Text001, CheckLedgEntry."Check No.");
        //GenJnlLine2.VALIDATE(Amount,CheckLedgEntry.Amount);
        GenJnlLine2.VALIDATE(Amount, -BankAccLedgEntry2.Amount);
        GenJnlLine2."Source Code" := SourceCodeSetup."Financially Voided Check";
        GenJnlLine2."Shortcut Dimension 1 Code" := BankAccLedgEntry2."Global Dimension 1 Code";
        GenJnlLine2."Shortcut Dimension 2 Code" := BankAccLedgEntry2."Global Dimension 2 Code";
        GenJnlLine2."Allow Zero-Amount Posting" := TRUE;
        // LedgEntryDim.SETRANGE("Table ID", DATABASE::"Bank Account Ledger Entry");
        // LedgEntryDim.SETRANGE("Entry No.", BankAccLedgEntry2."Entry No.");
        // TempJnlLineDim.DELETEALL;
        // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
        GenJnlPostLine.RunWithCheck(GenJnlLine2);

        //Annulation des lignes paiement
        WITH lCheckLedgEntry2 DO BEGIN
            SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
            SETRANGE("Bank Account No.", CheckLedgEntry."Bank Account No.");
            SETRANGE("Entry Status", CheckLedgEntry."Entry Status");
            SETRANGE("Check No.", CheckLedgEntry."Check No.");
            SETRANGE("Payment Type", CheckLedgEntry."Payment Type");
            //#7877
            SETRANGE("Entry No.", CheckLedgEntry."Entry No.");
            //#7877//

            IF FIND('-') THEN
                REPEAT
                    //GenJnlLine2.INIT;
                    GenJnlLine2."Document No." := CheckLedgEntry."Document No.";
                    GenJnlLine2."Account Type" := lCheckLedgEntry2."Bal. Account Type";
                    GenJnlLine2."Posting Date" := CheckLedgEntry."Posting Date";
                    GenJnlLine2.VALIDATE("Account No.", lCheckLedgEntry2."Bal. Account No.");
                    GenJnlLine2.VALIDATE("Currency Code", BankAcc."Currency Code");
                    GenJnlLine2.Description := STRSUBSTNO(Text001, lCheckLedgEntry2."Check No.");
                    GenJnlLine2."Source Code" := SourceCodeSetup."Financially Voided Check";
                    GenJnlLine2."Allow Zero-Amount Posting" := TRUE;
                    CASE lCheckLedgEntry2."Bal. Account Type" OF
                        lCheckLedgEntry2."Bal. Account Type"::"G/L Account":
                            BEGIN
                                WITH GLEntry DO BEGIN
                                    SETCURRENTKEY("Transaction No.");
                                    SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
                                    SETRANGE("Posting Date", BankAccLedgEntry2."Posting Date");
                                    SETFILTER("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
                                    IF FIND('-') THEN BEGIN
                                        REPEAT
                                            GenJnlLine2.VALIDATE("Account No.", "G/L Account No.");
                                            GenJnlLine2.VALIDATE("Currency Code", BankAcc."Currency Code");
                                            GenJnlLine2.Description := STRSUBSTNO(Text001, lCheckLedgEntry2."Check No.");
                                            GenJnlLine2.VALIDATE(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                            // LedgEntryDim.SETRANGE("Table ID", DATABASE::"G/L Entry");
                                            // LedgEntryDim.SETRANGE("Entry No.", "Entry No.");
                                            // TempJnlLineDim.DELETEALL;
                                            // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                        UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        CheckLedgEntry."Bal. Account Type"::Customer:
                            BEGIN
                                WITH CustLedgEntry DO BEGIN
                                    SETCURRENTKEY("Transaction No.");
                                    SETRANGE("Customer No.", lCheckLedgEntry2."Bal. Account No.");
                                    SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
                                    SETRANGE("Posting Date", BankAccLedgEntry2."Posting Date");
                                    IF FIND('-') THEN BEGIN
                                        REPEAT
                                            CALCFIELDS("Original Amount");
                                            GenJnlLine2.VALIDATE(Amount, -"Original Amount");
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                            // LedgEntryDim.SETRANGE("Table ID", DATABASE::"Cust. Ledger Entry");
                                            // LedgEntryDim.SETRANGE("Entry No.", "Entry No.");
                                            // TempJnlLineDim.DELETEALL;
                                            // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                        UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        CheckLedgEntry."Bal. Account Type"::Vendor:
                            BEGIN
                                WITH VendorLedgEntry DO BEGIN
                                    SETCURRENTKEY("Transaction No.");
                                    SETRANGE("Vendor No.", lCheckLedgEntry2."Bal. Account No.");
                                    SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
                                    SETRANGE("Posting Date", BankAccLedgEntry2."Posting Date");
                                    IF FIND('-') THEN BEGIN
                                        REPEAT
                                            CALCFIELDS("Original Amount");
                                            GenJnlLine2.VALIDATE(Amount, -"Original Amount");
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                            // LedgEntryDim.SETRANGE("Table ID", DATABASE::"Vendor Ledger Entry");
                                            // LedgEntryDim.SETRANGE("Entry No.", "Entry No.");
                                            // TempJnlLineDim.DELETEALL;
                                            // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                        UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        CheckLedgEntry."Bal. Account Type"::"Bank Account":
                            BEGIN
                                WITH BankAccLedgEntry3 DO BEGIN
                                    SETCURRENTKEY("Transaction No.");
                                    SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
                                    SETRANGE("Posting Date", BankAccLedgEntry2."Posting Date");
                                    SETFILTER("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
                                    IF FIND('-') THEN BEGIN
                                        REPEAT
                                            GenJnlLine2.VALIDATE(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                            // LedgEntryDim.SETRANGE("Table ID", DATABASE::"Bank Account Ledger Entry");
                                            // LedgEntryDim.SETRANGE("Entry No.", "Entry No.");
                                            // TempJnlLineDim.DELETEALL;
                                            // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                        UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        CheckLedgEntry."Bal. Account Type"::"Fixed Asset":
                            BEGIN
                                WITH FALedgEntry DO BEGIN
                                    SETCURRENTKEY("Transaction No.");
                                    SETRANGE("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SETRANGE("Document No.", BankAccLedgEntry2."Document No.");
                                    SETRANGE("Posting Date", BankAccLedgEntry2."Posting Date");
                                    IF FIND('-') THEN BEGIN
                                        REPEAT
                                            GenJnlLine2.VALIDATE(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                            // LedgEntryDim.SETRANGE("Table ID", DATABASE::"FA Ledger Entry");
                                            // LedgEntryDim.SETRANGE("Entry No.", "Entry No.");
                                            // TempJnlLineDim.DELETEALL;
                                            // DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                            GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                        UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        ELSE BEGIN
                            GenJnlLine2."Bal. Account Type" := lCheckLedgEntry2."Bal. Account Type";
                            GenJnlLine2.VALIDATE("Bal. Account No.", lCheckLedgEntry2."Bal. Account No.");
                            GenJnlLine2."Shortcut Dimension 1 Code" := '';
                            GenJnlLine2."Shortcut Dimension 2 Code" := '';
                            //TempJnlLineDim.DELETEALL;
                            GenJnlPostLine.RunWithoutCheck(GenJnlLine2);
                        END;
                    END;
                UNTIL NEXT = 0;

            SETCURRENTKEY("Bank Account No.", Open);
            IF FIND('-') THEN
                REPEAT
                    "Original Entry Status" := lCheckLedgEntry2."Entry Status";
                    "Entry Status" := lCheckLedgEntry2."Entry Status"::"Financially Voided";
                    MODIFY;
                UNTIL NEXT = 0;
        END;
    END;

    var
        myInt: Integer;
        gAddOnLicencePermission: Codeunit IntegrManagement;
}