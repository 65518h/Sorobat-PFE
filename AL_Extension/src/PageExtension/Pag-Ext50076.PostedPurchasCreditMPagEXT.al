PageExtension 50076 "Posted Purchas Credit M_PagEXT" extends "Posted Purchase Credit Memos"
{
    layout
    {

        addbefore("No.")
        {
            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
        }

        addafter("Buy-from Vendor Name")
        {

            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }

            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }

        }

    }

}

