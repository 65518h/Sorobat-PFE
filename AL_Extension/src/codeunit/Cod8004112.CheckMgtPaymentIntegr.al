Codeunit 8004112 "CheckMgt Payment Integr."
{
    // +PMT+ AC 04/11/10
    //                   *SetPartialCheck* change le type de chèque en paiement partiel
    //                   *SetFilterGJLbyCheckLedgEntry* applique des fitre sur le journal lié à une écriture chèque
    //                   *SetGJLPaymentType* initalisation du compte de contre partie + affectation du champ "Payment Type"
    //                                       (passage d'une ligne sur deux lignes journal)
    //                   *InitGJLCheckLedgEntry* initaliastion du champ "Check Ledger Entry No."
    //                   *SetFilterCheckLedgEntry* recherche de l'écriture check lié à la ligne journal
    //                   *FinancialVoidCheck*  comptabilisation des payement <> de chèque
    //                   *FinancialVoidPayment* traiteent de comptabilisation


    trigger OnRun()
    begin
    end;


    procedure SetPartialCheck(var FromCheckLedgEntry: Record "Check Ledger Entry"; var ToCheckLedgEntry: Record "Check Ledger Entry")
    begin
        ToCheckLedgEntry.SetRange("Check No.", FromCheckLedgEntry."Document No.");
        if ToCheckLedgEntry.Count >= 1 then begin
            FromCheckLedgEntry."Check Type" := FromCheckLedgEntry."check type"::"Partial Check";
            ToCheckLedgEntry.SetRange("Check Type", ToCheckLedgEntry."check type"::"Total Check");
            if not ToCheckLedgEntry.IsEmpty then
                ToCheckLedgEntry.ModifyAll("Check Type", ToCheckLedgEntry."check type"::"Partial Check");
        end;
    end;


    procedure SetFilterGJLbyCheckLedgEntry(var pGenJnlLine: Record "Gen. Journal Line"; pCheckLedgEntry: Integer)
    begin
        if pCheckLedgEntry <> 0 then
            pGenJnlLine.SetRange("Check Ledger Entry No.", pCheckLedgEntry);
    end;


    procedure SetGJLPaymentType(pFromGenJnlLine: Record "Gen. Journal Line"; var pToGenJnlLine: Record "Gen. Journal Line")
    begin
        pToGenJnlLine."Payment Type" := pFromGenJnlLine."Payment Type";
        pToGenJnlLine."Bal. Account No." := '';
    end;


    procedure InitGJLCheckLedgEntry(var pGenJnlLine: Record "Gen. Journal Line")
    begin
        pGenJnlLine."Check Ledger Entry No." := 0;
    end;


    procedure SetFilterCheckLedgEntry(var pCheckLedgEntry: Record "Check Ledger Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        if pGenJnlLine."Check Ledger Entry No." <> 0 then
            pCheckLedgEntry.SetRange("Entry No.", pGenJnlLine."Check Ledger Entry No.");
        if pGenJnlLine."Payment Type" in [pGenJnlLine."payment type"::Transfer, pGenJnlLine."payment type"::"Direct Debit"] then begin
            pCheckLedgEntry.SetCurrentkey("Entry No.");
            pCheckLedgEntry.SetRange("Entry No.", pGenJnlLine."Check Ledger Entry No.");
            pCheckLedgEntry.SetRange("Bank Account No.");
        end;
    end;


    procedure FinancialVoidCheck(var pCheckLedgEntry: Record "Check Ledger Entry"; var pGenJnlLine2: Record "Gen. Journal Line") Return: Boolean
    begin
        if pCheckLedgEntry."Payment Type" <> pCheckLedgEntry."payment type"::Check then begin
            FinancialVoidPayment(pCheckLedgEntry, pGenJnlLine2);
            Return := true;
            //#9012
            //END;
        end else
            //#9012//
            Return := false;
    end;


    procedure FinancialVoidPayment(var CheckLedgEntry: Record "Check Ledger Entry"; var GenJnlLine2: Record "Gen. Journal Line")
    var
        lCheckLedgEntry2: Record "Check Ledger Entry";
        TransactionBalance: Decimal;
        Text001: label 'Voiding check %1.';
        Text002: label 'You cannot Financially Void checks posted in a non-balancing transaction.';
        DimMgt: Codeunit DimensionManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FALedgEntry: Record "FA Ledger Entry";
        BankAccLedgEntry3: Record "Bank Account Ledger Entry";
        //GL2024  LedgEntryDim: Record 355;
        //GL2024 TempJnlLineDim: Record 356 temporary;
        SourceCodeSetup: Record "Source Code Setup";
        GLEntry: Record "G/L Entry";
        BankAccLedgEntry2: Record "Bank Account Ledger Entry";
        BankAcc: Record "Bank Account";
    begin
        //Annulation de l'écriture compte bancaire
        CheckLedgEntry.TestField("Entry Status", CheckLedgEntry."entry status"::Posted);
        CheckLedgEntry.TestField("Statement Status", CheckLedgEntry."statement status"::Open);
        CheckLedgEntry.TestField("Bal. Account No.");
        BankAcc.Get(CheckLedgEntry."Bank Account No.");
        BankAccLedgEntry2.Get(CheckLedgEntry."Bank Account Ledger Entry No.");
        SourceCodeSetup.Get;
        with GLEntry do begin
            SetCurrentkey("Transaction No.");
            SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
            SetRange("Document No.", BankAccLedgEntry2."Document No.");
            if Find('-') then
                repeat
                    TransactionBalance := TransactionBalance + Amount;
                until Next = 0;
        end;
        if TransactionBalance <> 0 then
            Error(Text002);

        GenJnlLine2.Init;
        GenJnlLine2."Document No." := CheckLedgEntry."Document No.";
        GenJnlLine2."Account Type" := GenJnlLine2."account type"::"Bank Account";
        GenJnlLine2."Posting Date" := CheckLedgEntry."Posting Date";
        GenJnlLine2.Validate("Account No.", CheckLedgEntry."Bank Account No.");
        GenJnlLine2.Description := StrSubstNo(Text001, CheckLedgEntry."Check No.");
        //GenJnlLine2.VALIDATE(Amount,CheckLedgEntry.Amount);
        GenJnlLine2.Validate(Amount, -BankAccLedgEntry2.Amount);
        GenJnlLine2."Source Code" := SourceCodeSetup."Financially Voided Check";
        GenJnlLine2."Shortcut Dimension 1 Code" := BankAccLedgEntry2."Global Dimension 1 Code";
        GenJnlLine2."Shortcut Dimension 2 Code" := BankAccLedgEntry2."Global Dimension 2 Code";
        GenJnlLine2."Allow Zero-Amount Posting" := true;
        /* GL2024  LedgEntryDim.SetRange("Table ID", Database::"Bank Account Ledger Entry");
           LedgEntryDim.SetRange("Entry No.", BankAccLedgEntry2."Entry No.");
        TempJnlLineDim.DeleteAll;
        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/

        //Annulation des lignes paiement
        with lCheckLedgEntry2 do begin
            SetCurrentkey("Bank Account No.", "Entry Status", "Check No.");
            SetRange("Bank Account No.", CheckLedgEntry."Bank Account No.");
            SetRange("Entry Status", CheckLedgEntry."Entry Status");
            SetRange("Check No.", CheckLedgEntry."Check No.");
            SetRange("Payment Type", CheckLedgEntry."Payment Type");
            //#7877
            SetRange("Entry No.", CheckLedgEntry."Entry No.");
            //#7877//

            if Find('-') then
                repeat
                    //GenJnlLine2.INIT;
                    GenJnlLine2."Document No." := CheckLedgEntry."Document No.";
                    GenJnlLine2."Account Type" := lCheckLedgEntry2."Bal. Account Type";
                    GenJnlLine2."Posting Date" := CheckLedgEntry."Posting Date";
                    GenJnlLine2.Validate("Account No.", lCheckLedgEntry2."Bal. Account No.");
                    GenJnlLine2.Validate("Currency Code", BankAcc."Currency Code");
                    GenJnlLine2.Description := StrSubstNo(Text001, lCheckLedgEntry2."Check No.");
                    GenJnlLine2."Source Code" := SourceCodeSetup."Financially Voided Check";
                    GenJnlLine2."Allow Zero-Amount Posting" := true;
                    case lCheckLedgEntry2."Bal. Account Type" of
                        lCheckLedgEntry2."bal. account type"::"G/L Account":
                            begin
                                with GLEntry do begin
                                    SetCurrentkey("Transaction No.");
                                    SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SetRange("Document No.", BankAccLedgEntry2."Document No.");
                                    SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                                    SetFilter("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
                                    if Find('-') then begin
                                        repeat
                                            GenJnlLine2.Validate("Account No.", "G/L Account No.");
                                            GenJnlLine2.Validate("Currency Code", BankAcc."Currency Code");
                                            GenJnlLine2.Description := StrSubstNo(Text001, lCheckLedgEntry2."Check No.");
                                            GenJnlLine2.Validate(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        /* GL2024 LedgEntryDim.SetRange("Table ID", Database::"G/L Entry");
                                          LedgEntryDim.SetRange("Entry No.", "Entry No.");
                                        TempJnlLineDim.DeleteAll;
                                        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/
                                        until Next = 0;
                                    end;
                                end;
                            end;
                        CheckLedgEntry."bal. account type"::Customer:
                            begin
                                with CustLedgEntry do begin
                                    SetCurrentkey("Transaction No.");
                                    SetRange("Customer No.", lCheckLedgEntry2."Bal. Account No.");
                                    SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SetRange("Document No.", BankAccLedgEntry2."Document No.");
                                    SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                                    if Find('-') then begin
                                        repeat
                                            CalcFields("Original Amount");
                                            GenJnlLine2.Validate(Amount, -"Original Amount");
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        /* GL2024  LedgEntryDim.SetRange("Table ID", Database::"Cust. Ledger Entry");
                                           LedgEntryDim.SetRange("Entry No.", "Entry No.");
                                        TempJnlLineDim.DeleteAll;
                                        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/
                                        until Next = 0;
                                    end;
                                end;
                            end;
                        CheckLedgEntry."bal. account type"::Vendor:
                            begin
                                with VendorLedgEntry do begin
                                    SetCurrentkey("Transaction No.");
                                    SetRange("Vendor No.", lCheckLedgEntry2."Bal. Account No.");
                                    SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SetRange("Document No.", BankAccLedgEntry2."Document No.");
                                    SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                                    if Find('-') then begin
                                        repeat
                                            CalcFields("Original Amount");
                                            GenJnlLine2.Validate(Amount, -"Original Amount");
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        /*GL2024 LedgEntryDim.SetRange("Table ID", Database::"Vendor Ledger Entry");
                                         LedgEntryDim.SetRange("Entry No.", "Entry No.");
                                        TempJnlLineDim.DeleteAll;
                                        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/
                                        until Next = 0;
                                    end;
                                end;
                            end;
                        CheckLedgEntry."bal. account type"::"Bank Account":
                            begin
                                with BankAccLedgEntry3 do begin
                                    SetCurrentkey("Transaction No.");
                                    SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SetRange("Document No.", BankAccLedgEntry2."Document No.");
                                    SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                                    SetFilter("Entry No.", '<>%1', BankAccLedgEntry2."Entry No.");
                                    if Find('-') then begin
                                        repeat
                                            GenJnlLine2.Validate(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        /*GL2024  LedgEntryDim.SetRange("Table ID", Database::"Bank Account Ledger Entry");
                                          LedgEntryDim.SetRange("Entry No.", "Entry No.");
                                        TempJnlLineDim.DeleteAll;
                                        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/
                                        until Next = 0;
                                    end;
                                end;
                            end;
                        CheckLedgEntry."bal. account type"::"Fixed Asset":
                            begin
                                with FALedgEntry do begin
                                    SetCurrentkey("Transaction No.");
                                    SetRange("Transaction No.", BankAccLedgEntry2."Transaction No.");
                                    SetRange("Document No.", BankAccLedgEntry2."Document No.");
                                    SetRange("Posting Date", BankAccLedgEntry2."Posting Date");
                                    if Find('-') then begin
                                        repeat
                                            GenJnlLine2.Validate(Amount, -Amount);
                                            GenJnlLine2."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                                            GenJnlLine2."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                        /* GL2024  LedgEntryDim.SetRange("Table ID", Database::"FA Ledger Entry");
                                           LedgEntryDim.SetRange("Entry No.", "Entry No.");
                                        TempJnlLineDim.DeleteAll;
                                        DimMgt.CopyLedgEntryDimToJnlLineDim(LedgEntryDim, TempJnlLineDim);
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2, TempJnlLineDim);*/
                                        until Next = 0;
                                    end;
                                end;
                            end;
                        else begin
                            GenJnlLine2."Bal. Account Type" := lCheckLedgEntry2."Bal. Account Type";
                            GenJnlLine2.Validate("Bal. Account No.", lCheckLedgEntry2."Bal. Account No.");
                            GenJnlLine2."Shortcut Dimension 1 Code" := '';
                            GenJnlLine2."Shortcut Dimension 2 Code" := '';
                            /*GL2024 TempJnlLineDim.DeleteAll;
                             GenJnlPostLine.RunWithoutCheck(GenJnlLine2, TempJnlLineDim);*/
                        end;
                    end;
                until Next = 0;

            SetCurrentkey("Bank Account No.", Open);
            if Find('-') then
                repeat
                    "Original Entry Status" := lCheckLedgEntry2."Entry Status";
                    "Entry Status" := lCheckLedgEntry2."entry status"::"Financially Voided";
                    Modify;
                until Next = 0;
        end;
    end;
}

