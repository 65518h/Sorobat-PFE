PageExtension 50158 "Han IC Outbox Purch Lin_PagEXT" extends "Handled IC Outbox Purch. Lines"
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
