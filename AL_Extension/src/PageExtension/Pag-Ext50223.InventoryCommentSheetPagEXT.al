PageExtension 50223 "Inventory Comment Sheet_PagEXT" extends "Inventory Comment Sheet"

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
    begin

        //+REF+MEMOPAD
        lRecordref.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordref, FORMAT(rec."Document Type")) THEN
            Currpage.CLOSE;
        //+REF+MEMOPAD//
    end;
}