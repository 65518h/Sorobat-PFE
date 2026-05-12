PageExtension 50004 "Standard Text Codes_PagEXT" extends "Standard Text Codes"
{
    layout
    {
        addafter(Code)
        {
            field("Description2"; gDescription)
            {
                ApplicationArea = all;
                Caption = 'Description';
                Enabled = false;
                trigger OnValidate()
                var
                    lTranslationMgt: Codeunit "Translation Management";
                    lRecordRef: RecordRef;


                begin
                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    //#8421
                    //lTranslationMgt.AfterValidate(lRecordRef.NUMBER,FIELDNO(Description),Code,xRec.Description,Description);
                    lTranslationMgt.AfterValidate(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Code, xRec.Description, gDescription);
                    //#8421
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

                end;
            }
            field("Insertion Automatique"; Rec."Insertion Automatique")
            {
                ApplicationArea = all;
            }


        }
        modify(Description)
        {
            Visible = false;

        }

        addafter(Control1)
        {
            part("Liste Ouvrages"; "Liste Ouvrages")
            {
                Caption = 'Liste Ouvrages';

                ApplicationArea = all;
                SubPageLink = Section = FIELD(Code);

            }
        }


    }

    VAR
        gDescription: Text[1024];

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
        gDescription := fTranslateDesc(rec.Description);
    END;

    trigger OnAfterGetCurrRecord()
    BEGIN
        gDescription := fTranslateDesc(rec.Description);
    END;
}



