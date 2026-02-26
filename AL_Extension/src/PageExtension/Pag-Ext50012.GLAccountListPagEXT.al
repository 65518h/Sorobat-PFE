PageExtension 50012 "G/L Account List_PagEXT" extends "G/L Account List"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = all;
                Caption = 'Compte Syscohada';
            }

        }
        addafter(Name)
        {
            field("Search Name"; Rec."Search Name")
            {
                ApplicationArea = all;
            }


            field("Compte ABK"; Rec."Compte ABK")
            {
                ApplicationArea = all;
            }
            /*   field("Gen. Posting Type"; Rec."Gen. Posting Type")
               {
                   ApplicationArea = all;
               }
               field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
               {
                   ApplicationArea = all;
               }*/

        }
        addafter("VAT Prod. Posting Group")
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = all;
            }
            field("Balance"; Rec."Balance")
            {
                ApplicationArea = all;
            }
        }
        addafter("Direct Posting")
        {
            field(Totaling; rec.Totaling)
            {
                ApplicationArea = all;
            }
        }



    }
    var
        gAccountName: Text[1024];

    trigger OnAfterGetRecord()
    begin
        //+REF+TRANSLATION
        gAccountName := fTranslateName(rec.Name);
        //+REF+TRANSLATION//

    end;

    trigger OnAfterGetCurrRecord()
    begin
        //+REF+TRANSLATION
        gAccountName := fTranslateName(rec.Name);
        //+REF+TRANSLATION//
    end;

    PROCEDURE fTranslateName(pName: Text[1024]) Retour: Text[1024];
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    BEGIN
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.Format(lRecordRef.NUMBER, rec.FIELDNO(Name), rec."No.", '', pName);
        Retour := pName;
        //+REF+TRANSLATION//
    END;

    PROCEDURE fSetSelectionFilter(VAR pGLAccount: Record "G/L Account");
    VAR
        lGLAccount: Record "G/L Account";
    BEGIN
        //#7203
        lGLAccount.COPY(Rec);
        pGLAccount.COPY(Rec);

        CurrPage.SETSELECTIONFILTER(lGLAccount);
        lGLAccount.SETCURRENTKEY("No.");
        IF lGLAccount.FIND('-') THEN
            REPEAT
                IF pGLAccount.GET(lGLAccount."No.") THEN
                    pGLAccount.MARK(TRUE);
            UNTIL lGLAccount.NEXT = 0;
        pGLAccount.MARKEDONLY(TRUE);
        //#7203//
    END;
}



