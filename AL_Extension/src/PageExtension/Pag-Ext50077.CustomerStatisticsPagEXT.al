PageExtension 50077 "Customer Statistics_PagEXT" extends "Customer Statistics"
{
    layout
    {
        addafter("Shipped Not Invoiced (LCY)")
        {
            field("Payments not Due (LCY)"; rec."Payments not Due (LCY)")
            {
                ApplicationArea = all;
            }
            field("Sell-to Cust. Balance (LCY)"; rec."Sell-to Cust. Balance (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }


}

