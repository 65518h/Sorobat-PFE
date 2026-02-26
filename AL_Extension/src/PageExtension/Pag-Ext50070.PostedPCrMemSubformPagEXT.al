PageExtension 50070 "Posted P.Cr Mem Subform_PagEXT" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Value 1"; rec."Value 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 2"; rec."Value 2")
            {
                ApplicationArea = all;
            }
            field("Value 3"; rec."Value 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 4"; rec."Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; rec."Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; rec."Value 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; rec."Value 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; rec."Value 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; rec."Value 9")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; rec."Value 10")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Depr. until FA Posting Date")
        {
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
}

