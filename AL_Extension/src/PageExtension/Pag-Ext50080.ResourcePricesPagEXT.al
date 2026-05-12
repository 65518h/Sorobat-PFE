PageExtension 50080 "Resource Prices_PagEXT" extends "Resource Prices"
{
    layout
    {
        addafter("Code")
        {
            field("Customer No."; rec."Customer No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("Cross-Reference No."; rec."Cross-Reference No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

