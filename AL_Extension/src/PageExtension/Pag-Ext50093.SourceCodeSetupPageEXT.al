PageExtension 50093 "Source Code Setup_PageEXT" extends "Source Code Setup"
{
    layout
    {
        addafter("Cash Flow Worksheet")
        {
            field("Domiciliation Journal"; rec."Domiciliation Journal")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unapplied Purch. Entry Appln.")
        {
            field("Note of Expenses Journal"; rec."Note of Expenses Journal")
            {
                ApplicationArea = all;
            }
        }
        addafter("Job Journal")
        {
            field("Post Recognition"; rec."Post Recognition")
            {
                ApplicationArea = all;
            }
            field("Post Value"; rec."Post Value")
            {
                ApplicationArea = all;
            }
            field("Post Transfer"; rec."Post Transfer")
            {
                ApplicationArea = all;
            }
        }
    }
}

