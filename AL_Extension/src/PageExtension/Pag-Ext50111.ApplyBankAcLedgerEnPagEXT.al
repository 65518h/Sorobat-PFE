PageExtension 50111 "Apply Bank Ac Ledger En_PagEXT" extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("External Document No.1"; Rec."External Document No.")
            {
                Editable = false;
                ApplicationArea = all;
            }

        }
        addafter("Posting Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }

        }

    }
}
