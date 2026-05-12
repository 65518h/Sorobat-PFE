PageExtension 50226 "Warehouse Comment Sheet_PagEXT" extends "Warehouse Comment Sheet"

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
        lRecordref: RecordRef;
        v: Page "Code Coverage";
    begin

        //+REF+MEMOPAD
        lRecordref.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordref, FORMAT(rec."Table Name")) THEN
            Currpage.CLOSE;
        //+REF+MEMOPAD//
    end;
}