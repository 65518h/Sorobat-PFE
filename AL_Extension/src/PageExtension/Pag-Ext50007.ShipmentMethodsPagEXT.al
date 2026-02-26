PageExtension 50007 "Shipment Methods_PagEXT" extends "Shipment Methods"
{

    layout
    {
        addafter(code)
        {
            field(Description2; wDescription)
            {
                Caption = 'Description';
                ApplicationArea = all;

                trigger OnValidate()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lRecordRef: RecordRef;
                BEGIN

                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    lTranslationMgt.AfterValidate(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Code, xRec.Description, rec.Description);
                    //+REF+TRANSLATION//

                end;

                trigger OnAssistEdit()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lRecordRef: RecordRef;
                BEGIN

                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    lTranslationMgt.AssistEdit(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Code);
                    //+REF+TRANSLATION//
                END;
            }


        }

        modify(Description)
        {
            Visible = false;
        }
    }

    VAR
        TranslationMgt: Codeunit "Translation Management";
        Translation: Text[250];
        RecRef: RecordRef;
        wDescription: Text[1024];

    PROCEDURE fTranslateDesc(pDesc: Text[1024]) Retour: Text[1024];
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    BEGIN
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.Format(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Code, '', pDesc);
        //+REF+TRANSLATION//
        Retour := pDesc;
    END;

    trigger OnAfterGetRecord()
    BEGIN

        //+REF+TRANSLATION
        wDescription := fTranslateDesc(rec.Description);
        //+REF+TRANSLATION//
    END;

    trigger OnAfterGetCurrRecord()
    BEGIN

        //+REF+TRANSLATION
        wDescription := fTranslateDesc(rec.Description);
        //+REF+TRANSLATION//
    END;
}

