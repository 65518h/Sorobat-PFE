PageExtension 50288 "Prod. Order Comp Cmt Sh_PagEXT" extends "Prod. Order Comp. Cmt. Sheet"
{

    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordref: RecordRef;
        lProdOrderComponent: Record "Prod. Order Component";

    BEGIN

        //+REF+MEMOPAD
        lRecordref.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordref, lProdOrderComponent.TABLECAPTION + ' ' + FORMAT(rec.Status)) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//
    END;
}

