PageExtension 50099 "Gen. Business Posting G_PagEXT" extends "Gen. Business Posting Groups"
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