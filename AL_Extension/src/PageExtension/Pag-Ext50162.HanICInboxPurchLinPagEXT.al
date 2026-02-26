PageExtension 50162 "Han IC Inbox Purch. Lin_PagEXT" extends "Handled IC Inbox Purch. Lines"
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
