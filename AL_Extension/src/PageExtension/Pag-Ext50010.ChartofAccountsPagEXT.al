PageExtension 50010 "Chart of Accounts_PagEXT" extends "Chart of Accounts"
{
    Editable = false;
    layout
    {

        addafter(Name)
        {
            field(Name2; gNameAccount)
            {
                ApplicationArea = all;
                Caption = 'Nom';

                trigger OnValidate()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lRecordRef: RecordRef;
                BEGIN
                    //#8451
                    Rec.VALIDATE(Name, gNameAccount);
                    Rec.MODIFY();
                    //#8451//


                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    //#8451
                    //lTranslationMgt.AfterValidate(lRecordRef.NUMBER,FIELDNO(Name),"No.",xRec.Name,Name);
                    lTranslationMgt.AfterValidate(lRecordRef.NUMBER, rec.FIELDNO(Name), rec."No.", xRec.Name, gNameAccount);
                    CurrPage.UPDATE(FALSE);
                    //#8451//
                    //+REF+TRANSLATION//

                end;

                trigger OnAssistEdit()
                VAR
                    lTranslationMgt: Codeunit "Translation Management";
                    lRecordRef: RecordRef;
                BEGIN

                    //+REF+TRANSLATION
                    lRecordRef.GETTABLE(Rec);
                    lTranslationMgt.AssistEdit(lRecordRef.NUMBER, rec.FIELDNO(Name), rec."No.");
                    //+REF+TRANSLATION//

                end;

            }
            field("Compte Syscohada"; Rec."No. 2") { ApplicationArea = all; Caption = 'Compte Syscohada'; }
            field("Designation Syscohada"; Rec."Designation Syscohada") { ApplicationArea = all; }
            field("Compte ABK"; Rec."Compte ABK") { ApplicationArea = all; }


        }
        modify(Name)
        {
            Visible = true;
        }


        addafter(Totaling)
        {
            /*   field("Compte SORO"; rec."Compte SORO")
               {
                   ApplicationArea = all;
                   Caption = 'Compte SORO';
                   Visible = "Compte ABKVISIBLE";
               }*/
            field("Sugg. for Purch. Doc."; rec."Sugg. for Purch. Doc.")
            {
                ApplicationArea = all;
                Caption = 'Sugg. for Purch. Doc.';
            }
            field("Sugg. for Sales Doc."; rec."Sugg. for Sales Doc.")
            {
                ApplicationArea = all;
                Caption = 'Sugg. for Sales Doc.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
            }
            field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 3 Code field.', Comment = '%';
            }
            field("Global Dimension 4 Code"; Rec."Global Dimension 4 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 4 Code field.', Comment = '%';
            }

        }




    }
    actions
    {
        modify("Apply Entries")
        {
            Visible = false;
        }
        addafter("Where-Used List")
        {
            //GL2024 Lettrage
            action("Apply Entries1")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Lettrer écritures';
                ObsoleteState = Pending;

                Image = ApplyEntries;
                RunObject = Page "Lettrage écritures comptables";
                RunPageLink = "G/L Account No." = field("No.");
                ShortCutKey = 'Shift+F11';

            }

        }
    }
    var
        gNameAccount: Text[30];
        "Compte ABKVISIBLE": boolean;

    PROCEDURE fTranslateName(pName: Text[1024]) Return: Text[1024];
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


    PROCEDURE CompteABK();
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN



        // >> HJ DSFT 29-09-2012
        //GL2024
        IF RecLUserSetup.GET(USERID) THEN;
        IF RecLUserSetup."Compte EX" THEN BEGIN
            "Compte ABKVISIBLE" := TRUE;
            rec.RESET;
        END
        ELSE BEGIN
            "Compte ABKVISIBLE" := FALSE;
            // rec.SETRANGE("Compte SORO", FALSE);
        END;

        // >> HJ DSFT 29-09-2012
    END;

    trigger OnOpenPage()
    begin

        // >> HJ DSFT 29-09-2012
        CompteABK();
        // >> HJ DSFT 29-09-2012
    end;

    trigger OnAfterGetRecord()
    begin

        //#8451
        gNameAccount := fTranslateName(rec.Name);

        // >> HJ DSFT 29-09-2012
        CompteABK();
        // >> HJ DSFT 29-09-2012


        //#8451//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)

    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    BEGIN

        //+REF+TEMPLATE

        lRecordRef.GETTABLE(Rec);
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //#8451
        gNameAccount := fTranslateName(rec.Name);
        //#8451//
    end;


}