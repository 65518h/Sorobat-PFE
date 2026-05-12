PageExtension 50155 "IC Outbox Sales Lines_PagEXT" extends "IC Outbox Sales Lines"
{

    layout
    {
        addafter("Unit Price")
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


