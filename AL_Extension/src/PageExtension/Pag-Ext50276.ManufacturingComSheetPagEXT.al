PageExtension 50276 "Manufacturing Com Sheet_PagEXT" extends "Manufacturing Comment Sheet"
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

