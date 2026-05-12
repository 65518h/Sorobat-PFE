
PageExtension 50105 "Bank Account Card_PagEXT" extends "Bank Account Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Source code"; Rec."Source code")
            {
                ApplicationArea = all;
            }
            field("Ancien Code"; Rec."Ancien Code")
            {
                ApplicationArea = all;
            }
            field(RIB; Rec.RIB)
            {
                ApplicationArea = all;
            }
            field(Agence; Rec.Agence)
            {
                ApplicationArea = all;
            }
            field("Souche N° Banque"; Rec."Souche N° Banque")
            {
                ApplicationArea = all;
            }
        }
        addafter("Home Page")
        {
            field("Source code2"; Rec."Source code")
            {
                ApplicationArea = all;
            }
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bank Acc. Posting Group")
        {
            field("Protocol No."; Rec."Protocol No.")
            {
                ApplicationArea = all;
                Visible = "Protocol No.VISIBLE";
            }
            field("Version Code"; Rec."Version Code")
            {
                ApplicationArea = all;
                Visible = "Version CodeVISIBLE";
            }
            field(SubAccount; Rec.SubAccount)
            {
                ApplicationArea = all;
                Visible = SubAccountVISIBLE;
            }
        }
        addafter("National Issuer No.")
        {
            field("Bank Type"; Rec."Bank Type")
            {
                ApplicationArea = all;
            }
            field("LCR Transfer No."; Rec."LCR Transfer No.")
            {
                ApplicationArea = all;
            }
            field("LCR file name"; Rec."LCR file name")
            {
                ApplicationArea = all;
                trigger OnAssistEdit()
                VAR
                    lFileName: Text[250];
                    // lOpenFile: Codeunit "Common Dialog Management";
                    CduFileMgm: Codeunit "File Management";
                BEGIN

                    //+PMT+PAYMENT

                    //  lFileName := lOpenFile.OpenFile(tTitle, rec."LCR file name", 4, tFilter, 2);
                    //GL2024 License  lFileName := CduFileMgm.UploadFileWithFilter(tTitle, rec."LCR file name", tFilter, '');
                    rec.VALIDATE("LCR file name", lFileName);
                    //+PMT+PAYMENT//

                end;
            }



        }
        addbefore("Transit No.2")
        {
            field("Bank Account No2"; Rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("RIB Checked")
        {
            field("Type Compte"; Rec."Type Compte")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        /* GL2024  addafter("Chec&k Ledger Entries")
         {
             group("COD&A")
             {
                 Caption = 'COD&A';

                 action("&Import CODA File")
                 {
                     ApplicationArea = all;
                     Caption = '&Import CODA File';

                     trigger OnAction()
                     var
                         ImportCODA: Integer;
                     begin

                         /*
                         IF (NOT ISSERVICETIER) THEN BEGIN
                           ImportCODA.SetBankAcc(Rec);
                           ImportCODA.RUN;
                           CLEAR(ImportCODA)
                         END;
                             */

        /*     end;
         }
         action("CODA S&tatements")
         {
             ApplicationArea = all;
             Caption = 'CODA S&tatements';
             //DYS page n'existe pas dans NAV
             //  RunObject = Page 2000040;
         }
     }
 }*/
        /* GL2024   addafter("Online Map")
          {
              action("Automatic Payment")
              {
                  ApplicationArea = All;
                  //DYS page addon non migrer
                  // RunObject = Page 8004107;
                  // RunPageLink = "Bank Account No." = FIELD("No.");
              }
          }*/

    }

    trigger OnOpenPage()
    begin
        //LOCALIZATION
        SetVisible;
        //LOCALIZATION//
    end;

    var
        tFilter: label 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        tTitle: label 'Select a file';
        "Protocol No.VISIBLE": Boolean;
        "Version CodeVISIBLE": Boolean;
        SubAccountVISIBLE: Boolean;

    PROCEDURE SetVisible();
    VAR
        GLsetup: Record "General Ledger Setup";
    BEGIN
        //LOCALIZATION
        GLsetup.GET;
        CASE GLsetup.Localization OF
            GLsetup.Localization::BE:
                BEGIN
                    "Protocol No.VISIBLE" := (TRUE);
                    "Version CodeVISIBLE" := (TRUE);
                    SubAccountVISIBLE := (TRUE);
                END;
            ELSE BEGIN
            END;
        END;
    END;

}