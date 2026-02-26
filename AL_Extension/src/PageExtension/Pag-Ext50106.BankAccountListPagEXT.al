PageExtension 50106 "Bank Account List_PagEXT" extends "Bank Account List"
{
    /*GL2024
    SourceTableView=SORTING("No.")
                       WHERE(Blocked=FILTER(No));*/

    layout
    {
        addafter(Name)
        {
            field(RIB; Rec.RIB)
            {
                ApplicationArea = all;
            }
            /* field(Banque; Rec.Banque)
             {
                 ApplicationArea = all;
             }*/
            field("Source code"; Rec."Source code")
            {
                ApplicationArea = all;
            }
            field("Ancien Code"; Rec."Ancien Code")
            {
                ApplicationArea = all;
            }
        }
        modify("Currency Code")
        {
            Visible = true;
        }
    }
    actions
    {
        /* GL2024   addafter(Category_Report)
          {
              group("COD&A1")
              {
                  Caption = 'COD&A';
                  actionref("&Import CODA File1"; "&Import CODA File")
                  {

                  }
              }
          }*/
        addafter("Chec&k Ledger Entries")
        {
            // GL2024    group("COD&A")
            // GL2024  {
            //  GL2024  Caption = 'COD&A';
            /* GL2024  action("&Import CODA File")
              {
                  Caption = 'COD&A';
                  ApplicationArea = all;
                  trigger OnAction()
                  begin

                      //MIG-PAG
                      //ImportCODA.SetBankAcc(Rec);
                      //ImportCODA.RUNMODAL;
                      //CLEAR(ImportCODA)
                      IF ISSERVICETIER THEN
                          fImportServiceTier
                      ELSE
                          fImportClassic;
                      //MIG-PAG

                  end;
              }*/
            /*GL2024   action("CODA S&tatement")
             {
                 Caption = 'CODA S&tatement';
                 ApplicationArea = all;
                 //DYS page n'existe pas dans NAV
                 // RunObject = Page 2000040;
             }*/
            // }

        }
        /*GL2024   addafter("C&ontact")
           {
               action("Automatic Paymen")
               {
                   Caption = 'Automatic Paymen';
                   ApplicationArea = all;
                   //DYS page addon non migrer
                   // RunObject = Page 8004107;
                   // RunPageLink = "Bank Account No." = FIELD("No.");
               }
           }*/
    }

    trigger OnOpenPage()
    VAR

    begin

        /*  Rec.FilterGroup(0);
          rec.SetCurrentKey("No.");
          Rec.SetRange(Blocked, false);
          Rec.FilterGroup(2);*/
    end;

    trigger OnAfterGetRecord()
    begin
        rec.CALCFIELDS("Check Report Name");
    end;

    PROCEDURE fImportClassic();
    BEGIN
    END;

    PROCEDURE fImportServiceTier();
    BEGIN
        //MIG-PAG
        //MIG-PAG//
    END;




}