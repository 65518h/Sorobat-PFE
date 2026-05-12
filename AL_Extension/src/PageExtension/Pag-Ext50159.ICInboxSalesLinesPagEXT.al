PageExtension 50159 "IC Inbox Sales Lines_PagEXT" extends "IC Inbox Sales Lines"
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
