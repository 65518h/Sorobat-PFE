TableExtension 50004 "Standard TextEXT" extends "Standard Text"
{
    fields
    {
        field(50000; "Insertion Automatique"; Boolean)
        {
            Description = 'HJ DSFT 20-06-2012';
        }
    }

    trigger OnafterDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.NUMBER, 0, Code);
        //+REF+TRANSLATION//
    end;

    trigger OnafterRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
        xRecordRef: RecordRef;
    begin
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        xRecordRef.GETTABLE(xRec);
        lTranslationMgt.RenameTranslations(lRecordRef.NUMBER, 0, xRec.Code, Code);
        //+REF+TRANSLATION
    end;

}

