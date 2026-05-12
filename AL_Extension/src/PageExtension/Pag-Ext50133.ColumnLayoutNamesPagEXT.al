PageExtension 50133 "Column Layout Names_PagEXT" extends "Column Layout Names"
{

    layout
    {
        addafter(Name)
        {
            field(wDescription; wDescription)
            {
                Caption = 'Description';
                ApplicationArea = all;

                trigger OnValidate()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lTranslation: Text[250];
                    lRecordRef: RecordRef;
                BEGIN

                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    lTranslationMgt.AfterValidate(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Name, xRec.Description, rec.Description);
                    //+REF+TRANSLATION//

                end;

                trigger OnAssistEdit()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lTranslation: Text[250];
                    lRecordRef: RecordRef;
                BEGIN

                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    lTranslationMgt.AssistEdit(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Name);
                    //+REF+TRANSLATION//

                end;
            }
        }

    }


    actions
    {

    }

    PROCEDURE fTranslateDescription(pDesc: Text[1024]) Return: Text[1024];
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lTranslation: Text[250];
        lRecordRef: RecordRef;
    BEGIN
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.Format(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Name, '', pDesc);
        //+REF+TRANSLATION//
        Return := pDesc;
    END;


    trigger OnAfterGetRecord()
    begin
        wDescription := fTranslateDescription(rec.Description);
    end;

    VAR
        wDescription: Text[1024];

}

