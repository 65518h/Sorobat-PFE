PageExtension 50085 "General Journal Batches_PagEXT" extends "General Journal Batches"
{

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}

