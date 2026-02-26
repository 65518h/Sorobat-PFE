PageExtension 50160 "IC Inbox Purchase Lines_PagEXT" extends "IC Inbox Purchase Lines"
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
