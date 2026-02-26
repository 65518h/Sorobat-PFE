Codeunit 8004108 "Gen. Jnl-Post Payment Integr."
{

    trigger OnRun()
    begin
    end;

    var
        gCustLedgEntryTmp: Record "Cust. Ledger Entry" temporary;


    procedure GenCheckBankAccount(pGenJnlLine: Record "Gen. Journal Line")
    var
        lBankAcc: Record "Bank Account";
    begin
        if lBankAcc.Get(pGenJnlLine."Bal. Account No.") and
           (lBankAcc."Bank Type" in
             [lBankAcc."bank type"::Receivable, lBankAcc."bank type"::Payable]) then begin
            pGenJnlLine.TestField("Due Date");
            if lBankAcc."Bank Type" = lBankAcc."bank type"::Receivable then begin
                pGenJnlLine.TestField("Bill Type");
                pGenJnlLine.TestField("Payment Bank Account");
            end;
        end;
    end;


    procedure SetVATEntry(var pGLEntry: Record "VAT Entry"; pGenJnlLine: Record "Gen. Journal Line"; pVATtest: Boolean)
    var
        lTestVAT: Boolean;
    begin
        if (pGenJnlLine."Due Date" > pGenJnlLine."Posting Date") and
           (pGenJnlLine."Document Type" = pGenJnlLine."document type"::Payment) or
           (not pVATtest and (pGenJnlLine."Journal Template Name" = '')) then
            pGLEntry."Posting Date" := pGenJnlLine."Due Date";
    end;


    procedure SetGLEntryVAT(var pGLEntryVAT: Record "G/L Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        if (pGenJnlLine."Due Date" > pGenJnlLine."Posting Date") and
           (pGenJnlLine."Document Type" = pGenJnlLine."document type"::Payment) then
            pGLEntryVAT."Posting Date" := pGenJnlLine."Due Date";
    end;


    procedure SetBankAccLedgEntry(var pBankAccLedgEntry: Record "Bank Account Ledger Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        pBankAccLedgEntry."Due Date" := pGenJnlLine."Due Date";
        pBankAccLedgEntry."Bal. Bank Account No." := pGenJnlLine."Payment Bank Account";
        pBankAccLedgEntry."Bill Type" := pGenJnlLine."Bill Type";
    end;


    procedure GetCountCheck(var pCheckLedgEntry: Record "Check Ledger Entry"; pGenJnlLine: Record "Gen. Journal Line") Return: Integer
    begin
        if pGenJnlLine."Check Ledger Entry No." <> 0 then begin
            pCheckLedgEntry.SetCurrentkey("Entry No.");
            pCheckLedgEntry.SetRange("Bank Account No.");
            pCheckLedgEntry.SetRange("Entry No.", pGenJnlLine."Check Ledger Entry No.");
        end;
        Return := pCheckLedgEntry.Count;
    end;


    procedure SetCheckType(var pCheckLedgEntry: Record "Check Ledger Entry"; pCountCheck: Integer)
    begin
        if pCountCheck > 1 then
            pCheckLedgEntry."Check Type" := pCheckLedgEntry."check type"::"Partial Check"
        else
            pCheckLedgEntry."Check Type" := pCheckLedgEntry."check type"::"Total Check";
    end;


    procedure SetManualCheck(var pCheckLedgEntry: Record "Check Ledger Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        pCheckLedgEntry."Payment Type" := pGenJnlLine."Payment Type";
    end;


    procedure SetGLEntry(var pGLEntry: Record "G/L Entry"; pGLEntryVAT: Record "G/L Entry")
    begin
        if (pGLEntry."G/L Account No." = pGLEntryVAT."G/L Account No.") then
            pGLEntry."Posting Date" := pGLEntryVAT."Posting Date";
    end;


    procedure SetDueDateGenJnlLine(var pGenJnlLine: Record "Gen. Journal Line"; pNewCVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
        if pGenJnlLine."Due Date" = 0D then
            pGenJnlLine."Due Date" := pNewCVLedgEntryBuf."Due Date";
    end;


    procedure GetAmtLCY(var pCustLedgEntry2: Record "Cust. Ledger Entry"; var pOriginalAmtLCY: Decimal; var pAmountLCY: Decimal; var pRemainingAmtLCY: Decimal)
    var
        lCustLedgEntry: Record "Cust. Ledger Entry";
        lOriginalAmtLCY: Decimal;
        lAmountLCY: Decimal;
        lRemainingAmtLCY: Decimal;
    begin
        //lCustLedgEntry := pCustLedgEntry2;
        lCustLedgEntry.SetCurrentkey("Transaction No.");
        lCustLedgEntry.SetRange("Transaction No.", pCustLedgEntry2."Transaction No.");
        lCustLedgEntry.SetRange("Document No.", pCustLedgEntry2."Document No.");
        lCustLedgEntry.CalcFields("Remaining Amt. (LCY)");
        lCustLedgEntry.SetFilter("Remaining Amt. (LCY)", '<>0');
        //lCustLedgEntry.SETRANGE(Open,TRUE);
        if lCustLedgEntry.Count > 1 then begin
            lCustLedgEntry.Find('-');
            repeat
                if not gCustLedgEntryTmp.Get(lCustLedgEntry."Entry No.") then begin
                    lCustLedgEntry.CalcFields("Original Amt. (LCY)", "Amount (LCY)", "Remaining Amt. (LCY)");
                    if lCustLedgEntry."Entry No." = pCustLedgEntry2."Entry No." then begin
                        lOriginalAmtLCY += pCustLedgEntry2."Original Amt. (LCY)";
                        lAmountLCY += pCustLedgEntry2."Amount (LCY)";
                        lRemainingAmtLCY += pCustLedgEntry2."Remaining Amt. (LCY)";
                    end else
                        if lCustLedgEntry."Remaining Amt. (LCY)" <> 0 then begin
                            lOriginalAmtLCY += lCustLedgEntry."Original Amt. (LCY)";
                            lAmountLCY += lCustLedgEntry."Amount (LCY)";
                            lRemainingAmtLCY += lCustLedgEntry."Remaining Amt. (LCY)";
                        end;
                end;
            until lCustLedgEntry.Next = 0;
            //  pCustLedgEntry2 := lCustLedgEntry;
            pOriginalAmtLCY := lOriginalAmtLCY;
            pAmountLCY := lAmountLCY;
            pRemainingAmtLCY := lRemainingAmtLCY;
        end;

        gCustLedgEntryTmp := pCustLedgEntry2;
        if gCustLedgEntryTmp.Insert then;

        //pCustLedgEntry2.SETRANGE("Transaction No.");
        //pCustLedgEntry2.SETRANGE("Document No.");
    end;


    procedure SetDtldCustLedgEntry(var pDtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; pGenJnlLine: Record "Gen. Journal Line")
    begin
        pDtldCustLedgEntry."Sell-to Customer No." := pGenJnlLine."Sell-to/Buy-from No.";
    end;
}

