Codeunit 8001537 "Workflow VendLedgEnt. OnHold"
{
    //GL2024  ID dans Nav 2009 : "8004204"
    // #7694 CW 25/11/09
    // //WORKFLOW CW 25/11/09


    trigger OnRun()
    var
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        lVendorLedgerEntry.SetFilter("On Hold", '<>%1', '');
        PAGE.Run(page::"Vendor Ledger Entries", lVendorLedgerEntry);
    end;
}

