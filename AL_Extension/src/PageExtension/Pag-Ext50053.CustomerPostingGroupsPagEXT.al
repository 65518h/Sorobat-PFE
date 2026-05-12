PageExtension 50053 "Customer Posting Groups_PagEXT" extends "Customer Posting Groups"
{
    layout
    {
        addafter("Receivables Account")
        {

            field("Apply Stamp fiscal"; rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
            }
            field("Stamp fiscal Amout"; rec."Stamp fiscal Amout")
            {
                ApplicationArea = all;
            }
            field("Apply Fodec"; rec."Apply Fodec")
            {
                ApplicationArea = all;
            }
            field("Fodec Account"; rec."Fodec Account")
            {
                ApplicationArea = all;
            }
            field("Fodec %"; rec."Fodec %")
            {
                ApplicationArea = all;
            }
            field("Contract Type"; rec."Contract Type")
            {
                ApplicationArea = all;
            }
        }
    }
}

