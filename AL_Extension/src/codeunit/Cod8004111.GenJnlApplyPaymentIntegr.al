Codeunit 8004111 "Gen Jnl.-Apply Payment Integr."
{
    // #8487 AC 04/11/10
    // //+PMT+ GESWAY 01/08/02 *CalcAmountApply* Forcer le Montant total des écritures lettrées
    //                                           Interdir OK si paiement imprimé
    //                         *ConfirmApply* Message de confirmation de confirmation si modification lettrage


    trigger OnRun()
    begin
    end;


    procedure CalcAmountApply(pRec: Record "Gen. Journal Line"; pGenJnlLine: Record "Gen. Journal Line"; pAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; pAccNo: Code[20]; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line") return: Decimal
    var
        lCustLedgEntry: Record "Cust. Ledger Entry";
        lVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        return := 0;
        with pGenJnlLine do
            case pAccType of
                Pacctype::Customer:
                    begin
                        lCustLedgEntry.Reset;
                        lCustLedgEntry.SetCurrentkey("Customer No.", Open, Positive);
                        lCustLedgEntry.SetRange("Customer No.", pAccNo);
                        lCustLedgEntry.SetRange(Open, true);
                        lCustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                        if not lCustLedgEntry.IsEmpty then begin
                            lCustLedgEntry.FindSet(false, false);
                            repeat
                                if /* //GL2024 pGenJnlPostLine.CheckCalcPmtDiscGenJnlCust(pRec, lCustLedgEntry, 0, false) and*/
                                  (Abs(lCustLedgEntry."Amount to Apply") >=
                                  Abs(lCustLedgEntry."Remaining Amount" - lCustLedgEntry."Remaining Pmt. Disc. Possible"))
                                then
                                    return := return - (lCustLedgEntry."Amount to Apply" - lCustLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    return := return - lCustLedgEntry."Amount to Apply";
                            until lCustLedgEntry.Next = 0;
                        end;
                    end;
                Pacctype::Vendor:
                    begin
                        lVendLedgEntry.Reset;
                        lVendLedgEntry.SetCurrentkey("Vendor No.", Open, Positive);
                        lVendLedgEntry.SetRange("Vendor No.", pAccNo);
                        lVendLedgEntry.SetRange(Open, true);
                        lVendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                        if not lVendLedgEntry.IsEmpty then begin
                            lVendLedgEntry.FindSet(false, false);
                            repeat
                                if /* //GL2024pGenJnlPostLine.CheckCalcPmtDiscGenJnlVend(pRec, lVendLedgEntry, 0, false) and*/
                                  (Abs(lVendLedgEntry."Amount to Apply") >=
                                  Abs(lVendLedgEntry."Remaining Amount" - lVendLedgEntry."Remaining Pmt. Disc. Possible"))
                                then
                                    return := return - (lVendLedgEntry."Amount to Apply" - lVendLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    return := return - lVendLedgEntry."Amount to Apply";
                            until lVendLedgEntry.Next = 0;
                        end;
                    end;
            end;
    end;


    procedure ConfirmApply(pRec: Record "Gen. Journal Line"; var pGenJnlLine: Record "Gen. Journal Line"; pAccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; pAccNo: Code[20]; pOK: Boolean; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        Text8004100: label 'The Applied Amount is different than the Available Amount.\Do you want update it with the Applied Amount?';
        Text8004101: label 'Becarful, you have modified the apply of ledgers but not the applied amount';
    begin
        if (pGenJnlLine.Amount <> CalcAmountApply(pRec, pGenJnlLine, pAccType, pAccNo, pGenJnlPostLine)) then
            if pOK then begin
                if (pGenJnlLine.Amount <> 0) then
                    if Confirm(Text8004100, false) then
                        pGenJnlLine.Amount := 0;
            end else
                Message(Text8004101);
    end;
}

