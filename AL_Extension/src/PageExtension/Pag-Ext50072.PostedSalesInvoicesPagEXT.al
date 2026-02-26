PageExtension 50072 "Posted Sales Invoices_PagEXT" extends "Posted Sales Invoices"
{

    layout
    {
        addafter("No.")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }
        }



        addafter("Sell-to Customer Name")
        {
            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;

            }
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
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Shipment Date")
        {
            field("Reverse Prepmt. Cr. Memo No."; Rec."Reverse Prepmt. Cr. Memo No.")
            {
                ApplicationArea = all;
            }
        }

    }

}



