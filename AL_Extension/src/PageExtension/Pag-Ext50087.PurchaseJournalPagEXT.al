PageExtension 50087 "Purchase Journal_PagEXT" extends "Purchase Journal"
{
    layout
    {
        addafter("Document Date")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field("Apply-to Sales Order No."; Rec."Apply-to Sales Order No.")
            {
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;

            }
            field("Job Task No."; Rec."Job Task No.")
            {
                Visible = false;
                ApplicationArea = all;

            }
        }
    }

}

