PageExtension 50154 "Unapply Vendor Entries_PagEXT" extends "Unapply Vendor Entries"
{

    layout
    {



    }
    actions
    {
        modify(Unapply)
        {
            Visible = false;

        }
        addafter(Unapply_Promoted)
        {
            actionref(Unapply212; Unapply2)
            {

            }
        }
        addafter(Unapply)
        {
            action(Unapply2)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Unapply';
                Image = UnApply;
                ToolTip = 'Unselect one or more ledger entries that you want to unapply this record.';

                trigger OnAction()
                var
                    ApplyUnapplyParameters: Record "Apply Unapply Parameters";
                    VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
                    ConfirmManagement: Codeunit "Confirm Management";

                    MALettre: Text[5];
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    Soroubatcdu: Codeunit "Soroubat cdu";
                begin
                    if Rec.IsEmpty() then
                        Error(Text010);
                    if not ConfirmManagement.GetResponseOrDefault(Text011, true) then
                        exit;
                    // >> HJ SORO 05-04-2018
                    MALettre := rec.Lettre;
                    // >> HJ SORO 05-04-2018
                    ApplyUnapplyParameters."Document No." := DocNo;
                    ApplyUnapplyParameters."Posting Date" := PostingDate;
                    VendEntryApplyPostedEntries.PostUnApplyVendor(DtldVendLedgEntry2, ApplyUnapplyParameters);
                    PostingDate := 0D;
                    DocNo := '';
                    Rec.DeleteAll();
                    Message(Text009);
                    // >> HJ SORO 05-04-2018
                    //    Soroubatcdu.MajLettreVendorLedgerEntry(MALettre);
                    // >> HJ SORO 05-04-2018
                    CurrPage.Close();
                end;
            }
        }
    }

    var

        Text009: Label 'The entries were successfully unapplied.';
        Text010: Label 'There is nothing to unapply.';
        Text011: Label 'To unapply these entries, correcting entries will be posted.\Do you want to unapply the entries?';

}