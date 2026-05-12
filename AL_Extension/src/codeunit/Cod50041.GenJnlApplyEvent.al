codeunit 50041 GenJnlApplyEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnAfterSelectCustLedgEntry', '', true, true)]
    local procedure OnAfterSelectCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var AccNo: Code[20]; var Selected: Boolean)
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlApplyPaymentIntegr.ConfirmApply(GenJournalLine, GenJournalLine, AccType::Customer, AccNo, Selected, GenJnlPostLine);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnApplyCustomerLedgerEntryOnBeforeCheckAgainstApplnCurrency', '', true, true)]
    local procedure OnApplyCustomerLedgerEntryOnBeforeCheckAgainstApplnCurrency(var GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        //PROJET
        IF GenJournalLine."Job No." = '' THEN
            //#                "Job No." := CustLedgEntry."Job No.";
                           GenJournalLine.VALIDATE("Job No.", CustLedgerEntry."Job No.");
        //PROJET
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnApplyCustomerLedgerEntryOnBeforeCheckAgainstApplnCurrencyCustomerAmountNotZero', '', true, true)]
    local procedure OnApplyCustomerLedgerEntryOnBeforeCheckAgainstApplnCurrencyCustomerAmountNotZero(GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        //PROJET
        IF GenJournalLine."Job No." = '' THEN
            //#                "Job No." := CustLedgEntry."Job No.";
                           GenJournalLine.VALIDATE("Job No.", CustLedgerEntry."Job No.");
        //PROJET
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnAfterSelectVendLedgEntry', '', true, true)]
    local procedure OnAfterSelectVendLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var AccNo: Code[20]; var Selected: Boolean)
    begin
        // //+PMT+PAYMENT
        // IF gAddOnLicencePermission.HasPermissionPMT THEN
        //     ApplyVendEntries.LOOKUPMODE(NOT "Check Printed");
        //+PMT+PAYMENT//
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlApplyPaymentIntegr.ConfirmApply(GenJournalLine, GenJournalLine, AccType::Vendor, AccNo, Selected, GenJnlPostLine);
        //+PMT+PAYMENT//
    end;

    var
        myInt: Integer;
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        lGenJnlApplyPaymentIntegr: Codeunit "Gen Jnl.-Apply Payment Integr.";
}