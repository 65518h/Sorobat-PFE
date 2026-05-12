PageExtension 50287 "Prod. Order Comm Sheet_PagEXT" extends "Prod. Order Comment Sheet"
{

    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
        lProductionOrder: Record "Production Order";
    BEGIN

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, lProductionOrder.TABLECAPTION + ' ' + FORMAT(rec.Status)) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//
    END;



}

