PageExtension 50157 "Han IC Outbox Sales Lin_PagEXT" extends "Handled IC Outbox Sales Lines"
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

