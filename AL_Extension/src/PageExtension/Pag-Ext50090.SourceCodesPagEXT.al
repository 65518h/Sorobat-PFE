PageExtension 50090 "Source Codes_PagEXT" extends "Source Codes"
{

    layout
    {

    }
    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}



