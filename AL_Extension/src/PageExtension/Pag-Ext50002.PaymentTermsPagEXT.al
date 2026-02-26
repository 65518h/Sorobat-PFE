PageExtension 50002 "Payment Terms_PagEXT" extends "Payment Terms"
{
    layout
    {
        addafter("Due Date Calculation")
        {
            field("Number of Fractionation"; rec."Number of Fractionation")
            {
                ApplicationArea = all;
                Caption = 'Number of Fractionation';
            }
        }

        modify(Description)
        {
            trigger OnBeforeValidate()
            VAR
                lTranslationMgt: Codeunit "Translation Management";
                lRecordRef: RecordRef;
            BEGIN

                //+REF+TRANSLATION
                lRecordRef.GETTABLE(Rec);
                lTranslationMgt.AfterValidate(lRecordRef.NUMBER, rec.FIELDNO(Description), rec.Code, xRec.Description, rec.Description);
                //+REF+TRANSLATION//
            END;

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
    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}



