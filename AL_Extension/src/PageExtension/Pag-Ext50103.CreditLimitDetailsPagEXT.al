
PageExtension 50103 "Credit Limit Details_PagEXT" extends "Credit Limit Details"
{

    layout
    {
        addafter("Credit Limit (LCY)")
        {
            field("Payments not Due (LCY)"; Rec."Payments not Due (LCY)")
            {

                ApplicationArea = all;
            }
        }
    }
}