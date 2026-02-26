PageExtension 50029 "Sales Credit Memo_PagEXT" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Foreign Trade")
        {
            field("Code présentation"; PresentationCode)
            {
                Caption = 'Presentation Code';
                TableRelation = "Sales Line View";

                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //DYS  a verifier 

                    // CurrPAGE.SalesLines.PAGE.ShowColumns(PresentationCode);
                end;
            }
        }
        modify("Sell-to Customer Name")
        {
            trigger OnAssistEdit()
            begin
                //#7397
                OpenAssisEdit(1);
                //#7397//
            end;
        }

        addafter("Sell-to Contact No.")
        {
            field(ContactName; ContactName)
            {
                ApplicationArea = all;
                Caption = 'Nom du contact';
            }
            field(Subject; Rec.Subject)
            {
                ApplicationArea = all;
                trigger OnAssistEdit()
                VAR
                    lDescription: Record "Description Line";
                BEGIN
                    lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);

                end;
            }
        }
        addafter("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("Rider to Order No."; Rec."Rider to Order No.")
            {
                ApplicationArea = all;
            }
            /*  field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
              {
                  ApplicationArea = all;
              }*/
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                rec.VALIDATE("Shipment Date", 0D);
            end;
        }

        addafter(General)
        {
            group(Job)
            {
                Caption = 'Affaire';
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        OpenAssisEdit(2);
                    end;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field(ProjectManagerName; ProjectManagerName)
                {
                    ApplicationArea = all;
                    Caption = 'Nom du Chef de Projet';

                    trigger OnAssistEdit()
                    begin
                        //DYS
                        // CLEAR(AddressContributors);
                        // AddressContributors.InitRequest(4);
                        // AddressContributors.SETTABLEVIEW(Rec);
                        // AddressContributors.SETRECORD(Rec);
                        // AddressContributors.RUNMODAL;
                        //AddressContributors.GETRECORD(Rec);
                        CurrPage.UPDATE;
                    end;
                }
                field("Project Manager"; rec."Project Manager")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        IF (rec."Project Manager" <> xRec."Project Manager") AND (rec."Project Manager" <> '') THEN
                            IF Contact.GET(rec."Project Manager") THEN
                                ProjectManagerName := Contact.Name
                            ELSE
                                ProjectManagerName := '';
                        IF rec."Project Manager" = '' THEN
                            ProjectManagerName := '';
                    end;
                }
                field("Job Starting Date"; REC."Job Starting Date")
                {
                    Editable = "Job Starting DateEDITABLE";
                    ApplicationArea = all;
                }
                field("Job Ending Date"; rec."Job Ending Date")
                {
                    Editable = "Job Ending DateEDITABLE";
                    ApplicationArea = all;
                }
                field("Job Description"; rec."Job Description")
                {
                    ApplicationArea = all;
                }

                field("Payment Method Code2"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                /*GL2024    field("Credit Card No."; rec."Credit Card No.")
                    {  ApplicationArea = all;
                        Visible = false;
                    }*/
                //DYS fonction obsolet
                /*
            field(GetCreditcardNumber; GetCreditcardNumber)
            {
                Caption = 'GetCreditcardNumber';
                ApplicationArea = all;
                Visible = false;
            }*/
                /*   field("Status2"; rec.Status)
                   {  ApplicationArea = all;
                   }*/
            }
        }
        addbefore("Bill-to Contact No.")
        {
            field("Contract Type"; Rec."Contract Type")
            {
                Editable = "Contract TypeEDITABLE";

                ApplicationArea = all;
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {

                ApplicationArea = all;
            }
        }
        modify("Bill-to Name")
        {
            trigger OnAssistEdit()
            begin

                //#7397
                OpenAssisEdit(3);
                //#7397//
            end;
        }
        modify("Bill-to Contact No.")
        {
            trigger OnAfterValidate()
            begin
                // ActivateFields;
            end;
        }
        addafter("Bill-to Name")
        {
            field(Descr; wDescr)
            {

                Caption = 'Posting Description';
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    //POSTING_DESC
                    IF wDescr = '' THEN BEGIN
                        rec."Posting Description" := rec.wPostingDescription;
                        wDescr := rec.wShowPostingDescription(rec."Posting Description");
                    END ELSE
                        rec."Posting Description" := wDescr;
                    //POSTING_DESC//
                end;
            }
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Shortcut Dimension 1 Code")
        {
            field("Subscription Starting Date"; Rec."Subscription Starting Date")
            {
                ApplicationArea = all;
            }
            field("Subscription End Date"; Rec."Subscription End Date")
            {
                ApplicationArea = all;
            }
        }

        addafter(Status)
        {
            field("Progress Degree"; Rec."Progress Degree")
            {
                ApplicationArea = all;
            }
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = all;
                trigger OnControlAddIn(Index: Integer; Data: Text)
                begin

                    Currpage.SAVERECORD;
                    COMMIT;
                    SalesHeaderArchive.SETRANGE("Document Type", rec."Document Type"::Quote);
                    SalesHeaderArchive.SETRANGE("No.", rec."No.");
                    SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", rec."Doc. No. Occurrence");
                    IF SalesHeaderArchive.GET(rec."Document Type"::Quote, rec."No.", rec."Doc. No. Occurrence", rec."No. of Archived Versions") THEN;
                    page.RUNMODAL(page::"Sales List Archive", SalesHeaderArchive);
                    Currpage.UPDATE(FALSE);

                end;
            }
        }

    }
    actions
    {
        addafter("CreditMemo_CustomerCard")
        {
            action("C&ontact Card")
            {
                Caption = 'Fiche Contact';
                ApplicationArea = all;
                RunObject = Page "Contact Card";
                RunPageLink = "No." = FIELD("Sell-to Contact No.");
            }
        }
        addafter(CreditMemo_CustomerCard_Promoted)
        {
            actionref("C&ontact Card1"; "C&ontact Card")
            {

            }
        }
        addafter("Co&mments")
        {
            /* GL2024      action("Statistics Criteria")
                  {

                      Caption = 'Statistics Criteria';
                      ApplicationArea = all;
                      trigger OnAction()
                      var
                          lSalesHeader: Record "Sales Header";
                      //DYS page addon non migrer
                      //  lFormStatSales: Page 8005125;
                      begin

                          lSalesHeader := Rec;
                          // lFormStatSales.SETRECORD(lSalesHeader);
                          // lFormStatSales.fSetSalesDoc(TRUE);
                          //  lFormStatSales.RUNMODAL();
                          Rec := lSalesHeader;
                          CurrPage.UPDATE(TRUE);
                      end;
                  }
                  action("Additionnals Informations")
                  {

                      Caption = 'Additionnals Informations';
                      ApplicationArea = all;
                      trigger OnAction()
                      var
                          lSalesHeader: Record "Sales Header";
                      //DYS REPORT addon non migrer
                      // lFormAddInfo: Page 8005126;
                      begin

                          lSalesHeader := Rec;
                          //  lFormAddInfo.SETRECORD(lSalesHeader);
                          // lFormAddInfo.RUNMODAL;
                          Rec := lSalesHeader;
                          CurrPage.UPDATE(TRUE);
                      end;
                  }*/
            action(Description)
            {
                Caption = 'Description';

                ApplicationArea = all;
                trigger OnAction()
                var
                    lDesc: Record "Description Line";
                begin
                    lDesc.ShowDescription(36, rec."Document Type", rec."No.", 0);
                end;
            }
            /*GL2024   action("Contacts and addresses")
               {
                   Caption = 'Contacts and addresses';
                   ApplicationArea = all;
                   //DYS REPORT addon non migrer
                   // RunObject = Page 8004022;
                   // RunPageLink = "Document Type" = FIELD("Document Type"),
                   //                   "No." = FIELD("No.");
               }
               action("Job Sales Documents")
               {
                   Caption = 'Job Sales Documents';
                   ApplicationArea = all;
                   //DYS REPORT addon non migrer
                   // RunObject = Page 8004056;
                   // RunPageLink = "Job No." = FIELD("Job No.");
                   // RunPageView = SORTING("Job No.")
                   //                   WHERE("Job No." = FILTER(<> ''),
                   //                         "Order Type" = CONST(" "));
               }*/
            action(Folder)
            {

                Caption = 'Dossier';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lFolderManagement: Codeunit "Folder management";
                begin

                    //FOLDER
                    lFolderManagement.SalesHeader(Rec);
                    //FOLDER//
                end;
            }
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
                        lRecRef.SETRECFILTER;
                        SetRecordRef(lRecRef, TRUE);
                        ShowList(lId);
                    END;
                end;
            }
            separator(separator100)
            {
            }
            action("Measurement : Document var")
            {

                Caption = 'Measurement : Document var';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lRecRef: RecordRef;
                    lBOQCustMgt: Codeunit "BOQ Custom Management";
                begin

                    //#6115
                    lRecRef.GETTABLE(Rec);
                    IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
                        EXIT;
                    CurrPage.UPDATE(FALSE);
                    //#6115//
                end;
            }
        }
        addafter("Co&mments_Promoted")
        {
            actionref(Description1; Description)
            {

            }
            actionref(Folder1; Folder)
            {

            }
            actionref("&Reports1"; "&Reports")
            {

            }
            actionref("Measurement : Document var1"; "Measurement : Document var")
            {

            }
        }
        modify("CopyDocument")
        {
            trigger OnafterAction()
            begin
                //DYS a verifier
                //CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
            end;
        }
        /*GL2024       addafter(CopyDocument)
               {
                   action("Extraire &prix")
                   {

                       Caption = 'Get &Price';
                       ApplicationArea = all;
                       trigger OnAction()
                       begin
                           //DYS a verifier
                           // CurrPAGE.SalesLines.PAGE.ShowPrices
                       end;
                   }
                   action("Get Li&ne Discount")
                   {

                       Caption = 'Get Li&ne Discount';
                       ApplicationArea = all;
                       trigger OnAction()
                       begin
                           //DYS a verifier
                           //CurrPAGE.SalesLines.PAGE.ShowLineDisc
                       end;
                   }
               }*/



        /*GL2024 addafter("F&unctions")
         {
             group("&Line")
             {
                 Caption = '&Line';
                 action(Description2)
                 {
                     ApplicationArea = All;

                     trigger OnAction()
                     begin
                         //DYS a verifier
                         // CurrPAGE.SalesLines.PAGE.ShowDescription;
                     end;
                 }
                 separator(separator101)
                 {
                 }
                 action(BOM)
                 {

                     Caption = 'BOM';
                     ApplicationArea = All;

                     trigger OnAction()
                     begin
                         //DYS a verifier
                         //CurrPAGE.SalesLines.PAGE.wStructure;
                     end;
                 }
                 action(Monter)
                 {
                     Caption = 'Monter';
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         //DYS a verifier
                         //CurrPAGE.SalesLines.PAGE.Move(MoveOption::Up);
                         CurrPage.UPDATE(FALSE);
                     end;
                 }
                 action(Descendre)
                 {

                     Caption = 'Mode Down';
                     ApplicationArea = all;
                     trigger OnAction()
                     begin
                         //DYS a verifier
                         // CurrPAGE.SalesLines.PAGE.Move(MoveOption::Down);
                         CurrPage.UPDATE(FALSE);
                     end;
                 }
                 action("O&uvrir/Fermer le dossier")
                 {

                     Caption = 'Open/Close the Folder';
                     ApplicationArea = all;
                     trigger OnAction()
                     begin
                         //DYS a verifier
                         // CurrPAGE.SalesLines.PAGE.ToggleExpandCollapse(FALSE);
                     end;
                 }
                 action("Calculer la quantité")
                 {

                     Caption = 'Calculate the quantity';
                     ApplicationArea = all;
                     trigger OnAction()
                     begin
                         //DYS a verifier
                         //  CurrPAGE.SalesLines.PAGE.wCalculateQty;
                     end;
                 }

             }

         }*/
        modify(Post)
        {
            trigger OnafterAction()
            begin
                //PROJET_FACT
                CurrPage.UPDATE(FALSE);
                //PROJET_FACT//
            end;
        }

        addafter(TestReport)
        {
            action("Print unposted credit memo")
            {

                Caption = 'Print unposted credit memo';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                begin

                    //+REF+INVOICE
                    //lSalesCrMemoHeader.SETRANGE("Print Document Type","Document Type");
                    lSalesCrMemoHeader.SETRANGE("No.", rec."No.");
                    lSalesCrMemoHeader.PrintRecords(TRUE);
                    //+REF+INVOICE//
                end;
            }
        }


        addafter("P&osting")
        {
            action(Comment2)
            {

                Caption = 'Comment';
                ApplicationArea = all;
                Enabled = SalesCommentBtnENABLED;

                RunObject = Page "Sales Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No."),
                              "Document Line No." = CONST(0);
            }

            /*GL2024  action("Move left")
              {
                  Caption = 'Move left';
                  ApplicationArea = all;


                  trigger OnAction()
                  begin
                      //DYS a verifier
                      //Currpage.SalesLines.page.Move(MoveOption::Left);
                      CurrPage.UPDATE(FALSE);
                  end;
              }
              action("Move Right")
              {
                  Caption = 'Move Right';
                  ApplicationArea = all;


                  trigger OnAction()
                  begin
                      //DYS a verifier
                      //CurrPAGE.SalesLines.PAGE.Move(MoveOption::Right);
                  end;
              }
              action("Expand All")
              {
                  Caption = 'Expand All';
                  ApplicationArea = all;
                  trigger OnAction()
                  begin
                      //DYS a verifier
                      // CurrPAGE.SalesLines.PAGE.ToggleExpandCollapse(TRUE);
                  end;

              }*/
            /* GL2024  action("Hide/Show Header")
               {
                   Caption= 'Hide/Show Header';
                   ApplicationArea = all;


                   trigger OnAction()
                   begin

                       IF CurrPAGE.SalesLines.YPOS = CurrPAGE.TabControl.YPOS THEN BEGIN
                         CurrPAGE.SalesLines.YPOS := CurrPAGE.TabControl.YPOS + CurrPAGE.TabControl.HEIGHT + CurrPAGE.SalesLines.YPOS;
                         CurrPAGE.SalesLines.HEIGHT := CurrPAGE.SalesLines.HEIGHT - CurrPAGE.SalesLines.YPOS;
                       END ELSE BEGIN
                         CurrPAGE.SalesLines.HEIGHT := CurrPAGE.SalesLines.HEIGHT + CurrPAGE.SalesLines.YPOS;
                         CurrPAGE.SalesLines.YPOS := CurrPAGE.TabControl.YPOS;
                       END;   

                   end;
               }*/
            /*GL2024  action("Hide/Show Header")
              {
                  Caption = 'Hide/Show Header';
                  ApplicationArea = all;


                  trigger OnAction()
                  begin

                      ShowExtendedText := NOT ShowExtendedText;
                      //DYS a verifier
                      //CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                  end;
              }
              action("Hde/Show Structure")
              {
                  Caption = 'Hde/Show Structure';
                  ApplicationArea = all;


                  trigger OnAction()
                  begin

                      wMarked := NOT wMarked;
                      //DYS a verifier
                      //CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                  end;
              }*/

        }
        addafter("Preview Posting_Promoted")
        {
            actionref("Print unposted credit memo1"; "Print unposted credit memo")
            {

            }
            actionref(Comment21; Comment2)
            {

            }
        }

    }
    trigger OnOpenPage()
    begin

        //SPLASH
        wSplashOpened := TRUE;
        wOpenSplash.OPEN(tOpenSplash);
        //SPLASH//

        //SPLASH
        IF wSplashOpened THEN BEGIN
            wSplashOpened := FALSE;
            wOpenSplash.CLOSE;
            //  CurrPage.WKF.ENABLED(TRUE);
            HelpENABLED := (TRUE);
            SellToCommentBtnENABLED := (TRUE);
            BillToCommentBtnENABLED := (TRUE);
            SalesCommentBtnENABLED := (TRUE);
        END;
        //SPLASH//



        ActivateFields;
        NavibatSetup.GET2;

        ShowExtendedText := TRUE;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
    end;

    trigger OnAfterGetRecord()
    begin

        rec.SETRANGE("Document Type");
        //NAVIBAT
        //DYS a verifier
        //  CurrPage.SalesLines.Page.wPassEnt(Rec);
        IF rec."No." <> xRec."No." THEN BEGIN
            wMarked := FALSE;
            //DYS a verifier
            //CurrPage.SalesLines.Page.SetAfterGet(PresentationCode);
        END;

        IF (rec."Project Manager" <> '') AND Contact.GET(rec."Project Manager") THEN
            ProjectManagerName := Contact.Name
        ELSE
            ProjectManagerName := '';
        //POSTING_DESC
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
        IF (rec."Sell-to Contact No." <> '') AND Contact.GET(rec."Sell-to Contact No.") THEN
            ContactName := Contact.GetSalutation(1, rec."Language Code")
        ELSE
            ContactName := '';
        IF rec."Job No." <> '' THEN BEGIN
            "Job Starting DateEDITABLE" := (FALSE);
            "Job Ending DateEDITABLE" := (FALSE);
        END
        ELSE BEGIN
            "Job Starting DateEDITABLE" := (TRUE);
            "Job Ending DateEDITABLE" := (TRUE);
        END;
        //NAVIBAT//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        rec."Order Type" := rec."Order Type"::" ";
        rec."Document Type" := rec."Document Type"::"Credit Memo";
        ProjectManagerName := '';
        ContactName := '';
        //+REF+FIN_CREDIT
        IF rec.GETFILTER("Financial Document") <> '' THEN
            IF rec.GETRANGEMAX("Financial Document") = TRUE THEN
                rec."Financial Document" := TRUE;
        //+REF+FIN_CREDIT//

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //DYS a verifier
        // CurrPage.SalesLines.Page.wPassEnt(Rec);
        // CurrPage.SalesLines.Page.SetAfterGet(PresentationCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
    end;

    PROCEDURE ActivateFields();
    BEGIN
        //CurrPAGE."Bill-to Customer Template Code".ENABLED("Bill-to Customer No." = '');
        //CurrPAGE."Sell-to Customer Template Code".ENABLED("Sell-to Customer No." = '');
        //CurrPAGE."Sell-to Customer No.".ENABLED("Sell-to Customer Template Code" = '');
        //CurrPAGE."Bill-to Customer No.".ENABLED("Bill-to Customer Template Code" = '');
        "Contract TypeEDITABLE" := (Rec."No. Prepayment Invoiced" = 0);
    END;

    PROCEDURE OpenAssisEdit(pValue: Integer);
    BEGIN
        //#7397
        CurrPage.UPDATE(TRUE);
        COMMIT;
        //#7397//
        //DYS
        // CLEAR(AddressContributors);
        // AddressContributors.InitRequest(pValue);
        // AddressContributors.SETTABLEVIEW(Rec);
        // AddressContributors.SETRECORD(Rec);
        // AddressContributors.RUNMODAL;
        //AddressContributors.GETRECORD(Rec);
        CurrPage.UPDATE;
    END;

    var
        Contact: Record Contact;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        //DYS page non migrer
        // AddressContributors: Page 8004022;
        SalesHeaderArchive: Record "Sales Header Archive";
        "?OkInsert": Boolean;
        MoveOption: Option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ProjectManagerName: Text[30];
        ContactName: Text[250];
        SupplyOrderMgt: Codeunit "Reordering Req. Management";
        wDescr: Text[100];
        NavibatSetup: Record NavibatSetup;
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        lMaskMgt: Codeunit "Mask Management";
        TextUpdate: Label 'Calcul en cours...';
        tOpenSplash: Label 'Ouverture en cours...';
        //GL2024
        "Contract TypeEDITABLE": Boolean;
        "Job Starting DateEDITABLE": Boolean;
        "Job Ending DateEDITABLE": Boolean;
        HelpENABLED: Boolean;
        SellToCommentBtnENABLED: Boolean;
        BillToCommentBtnENABLED: Boolean;
        SalesCommentBtnENABLED: Boolean;
}

