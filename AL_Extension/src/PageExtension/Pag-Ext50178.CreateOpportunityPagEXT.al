PageExtension 50178 "Create Opportunity_PagEXT" extends "Create Opportunity"

{
    layout
    {
        addafter(Priority)
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = all;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }



}