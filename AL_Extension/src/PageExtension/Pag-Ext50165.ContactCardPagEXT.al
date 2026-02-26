PageExtension 50165 "Contact Card_PagEXT" extends "Contact Card"
{

    layout
    {

        addafter("Salutation Code")
        {
            field("Job Title2"; Rec."Job Title")
            {
                ApplicationArea = all;
            }
            field("Territory Code2"; Rec."Territory Code")
            {
                ApplicationArea = all;
            }
        }

        addafter("Stock Capital")
        {
            field("Sell-to Customer Template Code"; Rec."Sell-to Customer Template Code")
            {
                ApplicationArea = all;
            }

        }

    }
    actions
    {

        /* GL2024   addbefore("Online Map")
            {
                action("Sales Contributors")
                {
                    Caption = 'Sales Contributors';
                    ApplicationArea = all;
                    //DYS page addon non migrer
                    // RunObject = Page 8003939;
                    // RunPageLink = "Contact No." = FIELD("No.");
                }
            }*/

        addafter("Online Map")
        {
            action("Outlook Card")
            {
                Caption = 'Outlook Card';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lOutlookContactManagement: Codeunit "OutlookLink ContactManagement";
                BEGIN
                    //+REF+OUTLOOK
                    lOutlookContactManagement.DisplayContact(Rec);
                    //+REF+OUTLOOK//

                end;
            }
        }
        addafter("Oppo&rtunities")
        {
            action("Opportunity Card")
            {
                Caption = 'Opportunity Card';
                ApplicationArea = all;
                RunObject = Page "Opportunity Card";
                RunPageView = SORTING("Contact Company No.", "Contact No.", Closed);
                RunPageLink = "Contact Company No." = FIELD("Company No.");
            }
        }
        addafter(SalesQuotes_Promoted)
        {
            actionref("Outlook Card1"; "Outlook Card") { }
            actionref("Opportunity Card1"; "Opportunity Card") { }
        }
        /*GL2024   addafter(SalesQuotes)
          {
              action("Sales Documents List")
              {
                  Caption = 'Sales Documents List';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004056;
                  // RunPageView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished);
                  // RunPageLink = "Sell-to Contact No." = FIELD("No.");
              }
          }*/
        addafter(Statistics_Promoted)
        {
            actionref("Folder1"; "Folder")
            {

            }

            actionref("&Reports1"; "&Reports")
            {

            }
        }

        addafter("Interaction Log E&ntries")
        {
            action("Folder")
            {
                Caption = 'Folder';
                ApplicationArea = all;
                trigger OnAction()

                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN
                    //FOLDER
                    lFolderManagement.Contact(Rec);
                    //FOLDER//
                end;
            }
            /*GL2024   action("Form Characteristics")
              {
                  Caption = 'Form Characteristics';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8001403;
                  // RunPageLink = "Table Name" = FILTER(Contact),
                  //                   "No." = FIELD("No.");
              }*/
            action("&Reports")
            {
                Caption = '&Etats';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                begin

                    WITH lReportList DO BEGIN
                        EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                        lRecRef.GETTABLE(Rec);
                        SetRecordRef(lRecRef, TRUE);
                        ShowList(lId);
                    END;
                end;
            }
        }

    }

    trigger OnNewRecord(BelowxRec: Boolean)
    VAR
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
        Cdufunction: Codeunit SoroubatFucntion;
    begin

        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Rec);
        IF NOT Cdufunction.GetTemplate(lRecordRef) THEN
            Currpage.CLOSE;
        lRecordRef.SETTABLE(Rec);
        //+REF+TEMPLATE//


    end;

}
