PageExtension 50137 "Resource Price Changes_PagEXT" extends "Resource Price Changes"
{

    layout
    {
        addbefore(Type)
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("New Unit Price")
        {
            field("Cross-Reference No."; Rec."Cross-Reference No.")
            {
                ApplicationArea = all;
            }
        }
    }
}