PageExtension 50121 "Reminder Comment Sheet_PagEXT" extends "Reminder Comment Sheet"
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
        IF lMemoPad.Edit(lRecordRef, FORMAT(rec.Type)) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//

    end;


}

