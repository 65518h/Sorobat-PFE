PageExtension 50123 "Fin. Charge Comment Sh_PagEXT" extends "Fin. Charge Comment Sheet"
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

