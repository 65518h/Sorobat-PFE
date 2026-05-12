PageExtension 50235 "Service Credit Memo_PagEXT" extends "Service Credit Memo"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;

            }

        }
    }
}

