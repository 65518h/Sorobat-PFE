PageExtension 50149 "Chart of Accounts (G/L)_PagEXT" extends "Chart of Accounts (G/L)"
{

    layout
    {
        modify(Name)
        {
            Visible = false;
        }
        addafter(Name)
        {
            field(gNameAccount; gNameAccount)
            {
                ApplicationArea = all;
                Caption = 'Name';
            }
        }
    }
    actions
    {

    }
    PROCEDURE fTranslationName(pName: Text[1024]) Return: Text[1024];
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    BEGIN
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.Format(lRecordRef.NUMBER, rec.FIELDNO(Name), rec."No.", '', pName);
        //+REF+TRANSLATION//
        Return := pName;
    END;

    trigger OnAfterGetRecord()
    begin
        gNameAccount := fTranslationName(rec.Name);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        gNameAccount := fTranslationName(rec.Name);
    end;

    var
        gNameAccount: Text[1024];
}