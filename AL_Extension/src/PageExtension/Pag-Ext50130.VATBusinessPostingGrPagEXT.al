PageExtension 50130 "VAT Business Posting Gr_PagEXT" extends "VAT Business Posting Groups"
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

