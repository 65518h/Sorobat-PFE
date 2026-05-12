PageExtension 50280 "Routing Comment Sheet_PagEXT" extends "Routing Comment Sheet"
{

    trigger OnOpenPage()
    var

        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
        lRoutingLine: Record "Routing Line";
    begin

        //+REF+MEMOPAD
        rec."Routing No." := rec.GETFILTER("Routing No.");
        rec."Version Code" := rec.GETFILTER("Version Code");
        IF rec."Version Code" = '''''' THEN rec."Version Code" := '';
        rec."Operation No." := rec.GETFILTER("Operation No.");
        lRecordRef.GETTABLE(Rec);
        IF lMemoPad.Edit(lRecordRef, lRoutingLine.TABLECAPTION) THEN
            Currpage.CLOSE;
        //+REF+MEMOPAD//
    end;


}

