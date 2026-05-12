PageExtension 50211 "Stock. Unit Comment Sh_PagEXT" extends "Stock. Unit Comment Sheet"

{


    layout
    {


    }
    actions
    {

    }
    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
        lSKU: Record "Stockkeeping Unit";
    BEGIN

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, lSKU.TABLECAPTION) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//

    end;

}
