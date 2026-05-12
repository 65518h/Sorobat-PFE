PageExtension 50233 "Service Comment Sheet_PagEXT" extends "Service Comment Sheet"
{


    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordref: RecordRef;
    BEGIN

        //+REF+MEMOPAD
        lRecordref.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordref, FORMAT(rec."Table Name")) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//


    end;

}

