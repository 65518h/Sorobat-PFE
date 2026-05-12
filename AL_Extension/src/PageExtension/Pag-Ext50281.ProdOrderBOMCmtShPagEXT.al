PageExtension 50281 "Prod. Order BOM Cmt. Sh_PagEXT" extends "Prod. Order BOM Cmt. Sheet"
{

    trigger OnOpenPage()
    var

        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
        lProdOrderComponent: Record "Prod. Order Component";
    begin

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, lProdOrderComponent.TABLECAPTION) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//
    end;
}

