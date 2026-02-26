PageExtension 50131 "VAT Product Posting Gr_PagEXT" extends "VAT Product Posting Groups"
{

    layout
    {


    }


    actions
    {

    }

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

