PageExtension 50054 "Vendor Posting Groups_PagEXT" extends "Vendor Posting Groups"
{
    layout
    {
        addafter("Code")
        {

            field("Apply Stamp fiscal"; rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Stamp fiscal Amout"; rec."Stamp fiscal Amout")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Apply Fodec"; rec."Apply Fodec")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Fodec %"; rec."Fodec %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Fodec Account"; rec."Fodec Account")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }


    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

