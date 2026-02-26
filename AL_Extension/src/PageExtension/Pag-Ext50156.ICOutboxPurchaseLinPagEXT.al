PageExtension 50156 "IC Outbox Purchase Lin_PagEXT" extends "IC Outbox Purchase Lines"
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

