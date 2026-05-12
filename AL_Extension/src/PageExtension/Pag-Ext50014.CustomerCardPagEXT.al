PageExtension 50014 "Customer Card_PagEXT" extends "Customer Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Customer Posting Group")
        {
            /*   field("Customer Price Group"; Rec."Customer Price Group")
               {
                   ApplicationArea = all;
               }*/
        }
        modify("Search Name")
        {
            Visible = true;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        addafter(Priority)
        {
            /* field("Type identifiant"; Rec."Type identifiant")
             {
                 ApplicationArea = all;
             }
             field("Matricule fiscal"; Rec."Matricule fiscal")
             {
                 ApplicationArea = all;
             }

             field("Type client"; Rec."Type client")
             {
                 ApplicationArea = all;
             }*/
            field(IFU; Rec.IFU)
            {
                ApplicationArea = all;
            }
            field(RCCM; Rec.RCCM)
            {
                ApplicationArea = all;
            }
            field("Forme juridique"; Rec."Forme juridique")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Ancien Code"; Rec."Ancien Code")
            {
                Editable = FALSE;
                ApplicationArea = all;
                Visible = false;
            }
            field("Invoice Amounts"; Rec."Invoice Amounts")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Outstanding Invoices (LCY)"; Rec."Outstanding Invoices (LCY)")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Outstanding Invoices"; Rec."Outstanding Invoices")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("No. of Orders"; Rec."No. of Orders")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("No. of Invoices"; Rec."No. of Invoices")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("No. of Return Orders"; Rec."No. of Return Orders")
            {
                ApplicationArea = all;
                Visible = false;

            }
            field("No. of Credit Memos"; Rec."No. of Credit Memos")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Montant Impayés"; Rec."Montant Impayés")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }

        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Fin. Charge Terms Code")
        {
            field("Domiciliation No."; Rec."Domiciliation No.")
            {
                ApplicationArea = all;
            }
        }


    }
    actions
    {
        addafter("Co&mments")
        {
            /*GL2024  action("Statistics Criteria")
              {
                  Caption = 'Statistics Criteria';
                  ApplicationArea = all;

                  trigger OnAction()
                  VAR
                      lCust: Record Customer;
                  //DYS page addon non migrer
                  //lFormStatCust: Page 8001326;
                  BEGIN

                      lCust := Rec;
                      //DYS
                      //lFormStatCust.SETRECORD(lCust);
                      //lFormStatCust.RUNMODAL();
                      Rec := lCust;
                      CurrPage.UPDATE(TRUE);

                  end;
              }*/

        }
        //DYS addafter("Service &Items")
        //DYS {
        //DYS action("&Jobs2")
        //DYS {
        //DYS ApplicationArea = all;
        //DYSCaption = '&Jobs';
        //DYS page addon non migrer
        //RunObject = page 8003901;
        //DYS }
        //DYS}
        //DYS addbefore("F&unctions")
        //DYS {
        //DYSaction("&Workflow")
        //DYS{
        //DYSApplicationArea = all;
        //DYSCaption = '&Workflow';
        //DYS page addon non migrer
        // RunObject = Page 8004213;
        // RunPageLink = Type = CONST(21),
        //                   "No." = FIELD("No.");
        //DYS }
        //DYS }

        addafter(Contact)
        {
            action("Con&tacts liés")
            {
                ApplicationArea = all;
                Caption = 'Relate&d Contacts';
                Visible = false;
                trigger OnAction()
                begin

                    //+REF+CONTACT

                    rec.wShowContactList;
                    //+REF+CONTACT//
                end;
            }
            action("Folder")
            {
                ApplicationArea = all;
                Caption = 'Folder';
                Visible = false;
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN

                    //+REF+FOLDER
                    lFolderManagement.Customer(Rec);
                    //+REF+FOLDER//
                end;
            }

            //DYS action("Form Characteristics")
            //DYS{
            //DYSApplicationArea = all;
            //DYSCaption = 'Form Characteristics';
            //DYS page addon non migrer
            // RunObject = page 8001403;
            // RunPageView = SORTING("Table Name, No.", "Characteristic Code");
            // RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
            //DYS}
        }
        //DYS addafter("Service Orders")
        //DYS {
        //DYS action("Subscription Contracts")
        //DYS {
        //DYS ApplicationArea = all;
        //DYS Caption = 'Subscription Contracts';
        //DYS page addon non migrer
        // RunObject = Page 8001905;
        // RunPageView = SORTING("Document Type", "Sell-to Contact No.");
        // RunPageLink = "Sell-to Customer No." = FIELD("No.");
        //DYS }
        //DYS }

        addafter(Contact_Promoted)
        {
            actionref("Con&tacts liés1"; "Con&tacts liés")
            {
            }
            actionref("Folder1"; "Folder")
            {
            }
        }
        addafter("Co&mments_Promoted")
        {
            /*GL2024  actionref("Statistics Criteria1"; "Statistics Criteria")
              {
              }*/
        }
    }


    trigger OnOpenPage()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(USERID) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Client");
        // >> HJ DSFT 03-06-2012 
    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(USERID) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Client");
        // >> HJ DSFT 03-06-2012
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        CduFunction: Codeunit SoroubatFucntion;
    BEGIN

        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Rec);
        //GL2024
        IF NOT CduFunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//

    end;

    trigger OnAfterGetCurrRecord()
    begin
        // >> HJ DSFT 03-06-2012
        IF RecUserSetup.GET(USERID) THEN;
        CurrPage.EDITABLE(RecUserSetup."Modif Client");
        // >> HJ DSFT 03-06-2012
    end;

    var

        RecUserSetup: Record "User Setup";
        Text003: label 'The customer %1 does not exist.';
}


