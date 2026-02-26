PageExtension 50161 "Han IC Inbox Sales Lin_PagEXT" extends "Handled IC Inbox Sales Lines"
{

    layout
    {

        addafter("Quantity")
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {

    }
}
