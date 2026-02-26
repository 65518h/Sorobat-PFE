PageExtension 50147 "Posted Purchase Rec Lin_PagEXT" extends "Posted Purchase Receipt Lines"
{

    layout
    {
        addafter("Expected Receipt Date")
        {
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }

}