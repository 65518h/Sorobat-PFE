PageExtension 50058 "Comment Sheet_PagEXT" extends "Comment Sheet"
{

    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
    BEGIN

        //+BGW+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, FORMAT(rec."Table Name")) THEN
            CurrPage.CLOSE;
        //+BGW+MEMOPAD//

    end;
}

