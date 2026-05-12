PageExtension 50005 "Languages_PagEXT" extends Languages
{


    trigger OnOpenPage()
    begin

        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

