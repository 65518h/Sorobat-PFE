PageExtension 50167 "Rlshp Mgt Comment Sheet_PagEXT" extends "Rlshp. Mgt. Comment Sheet"

{
    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
    BEGIN

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, FORMAT(rec."Table Name")) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//


    end;


}

