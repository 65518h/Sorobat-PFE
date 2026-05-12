PageExtension 50134 "Column Layout_PagEXT" extends "Column Layout"
{

    layout
    {
        modify("Column Header")
        {
            trigger OnAfterValidate()
            VAR
                lTranslationMgt: Codeunit "Translation Management";
                lTranslation: Text[250];
                lRecordRef: RecordRef;
            begin

                //+REF+TRANSLATION
                lRecordRef.GETTABLE(Rec);
                lTranslationMgt.AfterValidate2(lRecordRef.NUMBER, rec.FIELDNO("Column Header"), rec."Column Layout Name", rec."Line No.",
                  xRec."Column Header", rec."Column Header");
                //+REF+TRANSLATION//
            end;

            trigger OnAssistEdit()
            VAR
                lTranslationMgt: Codeunit "Translation Management";
                lTranslation: Text[250];
                lRecordRef: RecordRef;
            begin

                //+REF+TRANSLATION
                lRecordRef.GETTABLE(Rec);
                lTranslationMgt.AssistEdit2(lRecordRef.NUMBER, rec.FIELDNO("Column Header"), rec."Column Layout Name", rec."Line No.");
                //+REF+TRANSLATION//
            end;
        }

    }


    actions
    {

    }



}

