PageExtension 50011 "G/L Account Card_PagEXT" extends "G/L Account Card"
{
    layout
    {


        addafter(Name)
        {
            field(Name2; gNameAccount)
            {
                Caption = 'Nom';
                ApplicationArea = all;
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
                END;


            }
            field("Compte Syscohada"; Rec."No. 2") { ApplicationArea = all; }
            field("Designation Syscohada"; Rec."Designation Syscohada") { ApplicationArea = all; }
            field("Compte ABK"; Rec."Compte ABK") { ApplicationArea = all; }

        }
        addafter("Default IC Partner G/L Acc. No")
        {
            field("Reason Value Posting"; Rec."Reason Value Posting")
            {
                Caption = 'Reason Value Posting';
                ApplicationArea = all;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                Caption = 'Reason Code';
                ApplicationArea = all;
            }
            field("Subscription Period Control"; Rec."Subscription Period Control")
            {
                Caption = 'Subscription Period Control';
                ApplicationArea = all;
            }
            field("Post Job Entry"; Rec."Post Job Entry")
            {
                Caption = 'Post Job Entry';
                ApplicationArea = all;
            }
            field("Job Posting"; Rec."Job Posting")
            {
                Caption = 'Job Posting';
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                Caption = 'Job No.';
                ApplicationArea = all;
            }

            field("Sugg. for Purch. Doc."; Rec."Sugg. for Purch. Doc.")
            {
                Caption = 'Sugg. for Purch. Doc.';
                ApplicationArea = all;
            }

            field("Sugg. for Sales Doc."; Rec."Sugg. for Sales Doc.")
            {
                Caption = 'Sugg. for Sales Doc.';
                ApplicationArea = all;
            }
            /*field("Compte SORO"; Rec."Compte SORO")
            {
                Caption = 'Compte SORO';
                ApplicationArea = all;
            }*/
        }
        modify(Name)
        {
            Visible = false;
        }
    }

    actions
    {
        addafter("Where-Used List")
        {

            action(Folder)
            {
                ApplicationArea = all;

                Caption = 'Folder';

                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                begin

                    //+REF+FOLDER
                    lFolderManagement.GLAccount(Rec);
                    //+REF+FOLDER//
                end;

            }

            // action("Characteristics")
            // {
            // ApplicationArea = all;

            // Caption = 'Characteristics';
            //DYS page addon non migrer
            // RunObject = page 8001403;
            // RunPageLink = "Table Name" = CONST("Account (G/L)"),
            //                   "No." = FIELD("No.");
            // }
        }

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
        addlast(Category_Category4)
        {
            actionref(Folder1; Folder)
            { }
        }

    }


    VAR
        gNameAccount: Text[30];

    PROCEDURE fTranslateName(pName: Text[1024]) Return: Text[1024];
    VAR
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    BEGIN
        //#8451
        //+REF+TRANSLATION
        lRecordRef.GETTABLE(Rec);
        lTranslationMgt.Format(lRecordRef.NUMBER, rec.FIELDNO(Name), rec."No.", '', pName);
        //+REF+TRANSLATION//
        Return := pName;
        //#8451//
    END;


    trigger OnOpenPage()

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
    end;

    trigger OnAfterGetRecord()
    begin
        //#8451
        gNameAccount := fTranslateName(rec.Name);
        //#8451//
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //#8451
        gNameAccount := fTranslateName(rec.Name);
        //#8451//
    end;

}



