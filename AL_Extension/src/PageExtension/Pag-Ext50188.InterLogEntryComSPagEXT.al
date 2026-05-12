PageExtension 50188 "Inter Log Entry Com. S_PagEXT" extends "Inter. Log Entry Comment Sheet"

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
    BEGIN

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, '') THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//

    end;
}