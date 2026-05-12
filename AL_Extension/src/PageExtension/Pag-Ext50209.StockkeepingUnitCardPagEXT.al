PageExtension 50209 "Stockkeeping Unit Card_PagEXT" extends "Stockkeeping Unit Card"

{


    layout
    {
        addafter("Qty. on Service Order")
        {
            field("Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }

}
