PageExtension 50027 "Sales Order_PagEXT" extends "Sales Order"
{
    /* SourceTableView=SORTING("Order Type","Document Type","No.","Invoicing Method",Finished)
                     WHERE("Document Type"=CONST(Order),
                           "Order Type"=FILTER(' '),
                           "Commande Interne"=FILTER(false));*/
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = true;
        }
        modify("Sell-to Customer No.")
        {
            Editable = "Sell-to Customer No.EDITABLE";
            Caption = 'N° donneur d''ordre';
        }
        modify("Ship-to Code")
        {
            Editable = "Ship-to CodeEDITABLE";
        }
        modify("Currency Code")
        {
            Editable = "Currency CodeEDITABLE";
        }
        modify("Payment Method Code")
        {
            Editable = "Payment Method CodeEDITABLE";
        }
        modify("Payment Terms Code")
        {
            Editable = "Payment Terms CodeEDITABLE";
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = "VAT Bus. Posting GroupEDITABLE";
        }
        modify("Responsibility Center")
        {
            Editable = "Responsibility CenterEDITABLE";
        }


        addafter(Control1900201301)
        {
            field("Code présentation"; PresentationCode)
            {
                Caption = 'Presentation Code';
                TableRelation = "Sales Line View";
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //DYS a verifier
                    //  CurrPAGE.SalesLines.PAGE.ShowColumns(PresentationCode);
                end;
            }
        }
        modify("Sell-to Customer Name")
        {
            Editable = "Sell-to Customer NameEDITABLE";
            Caption = 'Nom du donneur d''ordre';
            trigger OnAfterValidate()
            begin
                CurrPage.SAVERECORD;
                COMMIT;
                //DYS
                // CLEAR(AddressContributors);
                // AddressContributors.InitRequest(1);
                // AddressContributors.SETTABLEVIEW(Rec);
                // AddressContributors.SETRECORD(Rec);
                // AddressContributors.RUNMODAL;
                //AddressContributors.GETRECORD(Rec);
                CurrPage.UPDATE;
            end;
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                rec.VALIDATE("Shipment Date", 0D);
            end;
        }
        modify("Order Date")
        {
            Editable = false;
        }

        addafter("Sell-to Customer Name")
        {
            field("Job No."; Rec."Job No.")
            {
                Editable = "Job No.EDITABLE";
                Caption = 'N° Affaire';
                ApplicationArea = all;
            }

        }
        modify(Control114)
        {
            Visible = true;
        }
        addafter("Quote No.")
        {
            /*  field("Commande Interne"; Rec."Commande Interne")
              {
                  ApplicationArea = all;
                  Editable = false;
              }*/
            field("Last Shipping No."; Rec."Last Shipping No.")
            {
                ApplicationArea = all;
                Caption = 'N° Expédition';
            }
        }
        modify("External Document No.")
        {
            Caption = 'N° doc. externe';
        }
        addafter("External Document No.")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Caption = 'Code utilisateur';
            }
        }
        modify("Ship-to Name")
        {
            Editable = "Ship-to NameEDITABLE";
            trigger OnAssistEdit()
            begin
                CurrPage.SAVERECORD;
                COMMIT;
                //DYS
                // CLEAR(AddressContributors);
                // AddressContributors.InitRequest(2);
                // AddressContributors.SETTABLEVIEW(Rec);
                // AddressContributors.SETRECORD(Rec);
                // AddressContributors.RUNMODAL;
                //AddressContributors.GETRECORD(Rec);
                CurrPage.UPDATE;
            end;
        }

        addafter("Ship-to Name")
        {
            field("Job Description"; Rec."Job Description")
            {
                Editable = "Job DescriptionEDITABLE";
                ApplicationArea = all;
            }
            field("Project Manager"; Rec."Project Manager")
            {
                Editable = "Project ManagerEDITABLE";
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
            field(ProjectManagerName; ProjectManagerName)
            {
                ApplicationArea = all;
                Caption = 'Nom du chef de projet';
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


            field("Job Starting Date"; rec."Job Starting Date")
            {
                Editable = "Job Starting DateEDITABLE";
                ApplicationArea = all;
            }
            field("Job Ending Date"; rec."Job Ending Date")
            {
                Editable = "Job Ending DateEDITABLE";
                ApplicationArea = all;
            }
            field("Shipment Date2"; rec."Shipment Date")
            {
                ApplicationArea = all;
            }
            field("No. Prepayment Invoiced"; rec."No. Prepayment Invoiced")
            {
                ApplicationArea = all;
            }

            field("<Salesperson Code2>"; rec."Salesperson Code")
            {
                ApplicationArea = all;
            }
            field("Nom du contact"; ContactName)
            {
                ApplicationArea = all;
                Caption = 'Nom du contact';
            }
            field(Subject; rec.Subject)
            {
                ApplicationArea = all;
                trigger OnAssistEdit()
                var
                    lDescription: Record "Description Line";
                begin
                    lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                end;
            }
            field("Posting Description2"; rec."Posting Description")
            {
                ApplicationArea = all;
                Caption = 'Libellé écriture';
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
                Editable = "Bill-to Customer No.EDITABLE";
                ApplicationArea = all;
            }



        }
        modify("Bill-to Name")
        {
            Editable = "Bill-to NameEDITABLE";
            trigger OnAfterValidate()
            begin
                CurrPage.SAVERECORD;
                COMMIT;
                //DYS
                // CLEAR(AddressContributors);
                // AddressContributors.InitRequest(3);
                // AddressContributors.SETTABLEVIEW(Rec);
                // AddressContributors.SETRECORD(Rec);
                // AddressContributors.RUNMODAL;
                //AddressContributors.GETRECORD(Rec);
                CurrPage.UPDATE;
            end;
        }
        modify("Prices Including VAT")
        {
            Editable = "Prices Including VATEDITABLE";
            trigger OnAfterValidate()
            begin
                CurrPage.UPDATE;
            end;
        }
        addafter("Bill-to Name")
        {
            field(Descr; wDescr)
            {
                Editable = DescrEDITABLE;
                Caption = 'Description de publication';
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
        }

        addafter("Currency Code")
        {
            field("Part Payment"; Rec."Part Payment")
            {
                ApplicationArea = all;
            }
        }

        addafter("Shortcut Dimension 1 Code")
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
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
            end;
        }
        addafter("Location Code")
        {
            field("Review Base Date"; Rec."Review Base Date")
            {
                Editable = "Review Base DateEDITABLE";
                ApplicationArea = all;
            }
            field("Review Formula CodeEDITABLE"; "Review Formula CodeEDITABLE")
            {
                Editable = "Review Formula CodeEDITABLE";
                ApplicationArea = all;
            }

        }
        modify("No. of Archived Versions")
        {
            trigger OnDrillDown()
            VAR
                lSalesHeaderArchive: Record "Sales Header Archive";
            BEGIN

                CurrPage.SAVERECORD;
                COMMIT;
                lSalesHeaderArchive.SETRANGE("Document Type", rec."Document Type"::Order);
                lSalesHeaderArchive.SETRANGE("No.", rec."No.");
                lSalesHeaderArchive.SETRANGE("Doc. No. Occurrence", rec."Doc. No. Occurrence");
                IF lSalesHeaderArchive.GET(rec."Document Type"::Quote, rec."No.", rec."Doc. No. Occurrence", rec."No. of Archived Versions") THEN;
                PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive);
                CurrPage.UPDATE(FALSE);

            end;
        }
        addafter(Status)
        {
            field(Finished; Rec.Finished)
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Progress Degree"; Rec."Progress Degree")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

    }
    actions
    {
        modify(Statistics)
        {
            Visible = false;

        }
        addafter(Customer)
        {
            action("Fiche Card")
            {
                ApplicationArea = all;
                Caption = 'Fiche Contact';
                RunObject = Page "Contact Card";
                RunPageLink = "No." = FIELD("Sell-to Contact No.");

            }
        }
        addafter(Statistics_Promoted)
        {
            actionref("Fiche Card1"; "Fiche Card")
            {

            }
        }

        addafter("Co&mments")
        {
            action("Standard Co&mments")
            {
                ApplicationArea = all;
                Caption = 'Commentaires standard';
                RunObject = Page "Sales Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
            }
            action("Header Comments")
            {

                ApplicationArea = all;
                Caption = 'Commentaires d’en-tête';

                trigger OnAction()
                var
                    lSalesTextManagement: Codeunit "Sales Text Management";
                begin

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 1);
                    //+REF+ADDTEXT//
                end;
            }
            action("Footer Comments")
            {


                ApplicationArea = all;
                Caption = 'Commentaires de pied';
                trigger OnAction()
                var
                    lSalesTextManagement: Codeunit "Sales Text Management";
                begin

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 2);
                    //+REF+ADDTEXT//
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("Standard Co&mments1"; "Standard Co&mments")
            {

            }
            actionref("Header Comments1"; "Header Comments")
            {

            }
            actionref("Footer Comments1"; "Footer Comments")
            {

            }
        }



        addafter(Approvals)
        {
            action(Folder)
            {

                ApplicationArea = all;
                Caption = 'Dossier';
                Visible = false;

                trigger OnAction()
                var
                    lFolderManagement: Codeunit "Folder management";
                begin

                    //+REF+FOLDER
                    lFolderManagement.SalesHeader(Rec);
                    //+REF+FOLDER//
                end;
            }
            action("E&tats")
            {

                ApplicationArea = all;
                Caption = 'E&tats';
                Visible = false;
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
            /*GL2024      action("Statistics Criteria")
                  {


                      ApplicationArea = all;
                      Caption = 'Statistics Criteria';
                      trigger OnAction()
                      var
                          lSalesHeader: Record "Sales Header";
                      //DYS page addon non migrer
                      //lFormStatSales: Page 8005125;
                      begin

                          lSalesHeader := Rec;
                          // lFormStatSales.SETRECORD(lSalesHeader);
                          // lFormStatSales.fSetSalesDoc(TRUE);
                          // lFormStatSales.RUNMODAL();
                          Rec := lSalesHeader;
                          CurrPage.UPDATE(TRUE);
                      end;
                  }
                  action("Additionnals Informations")
                  {

                      ApplicationArea = all;
                      Caption = 'Additionnals Informations';
                      trigger OnAction()
                      var
                          lSalesHeader: Record "Sales Header";
                      //DYS page addon non migrer
                      //  LfORMaDDiNFO: Page 8005126;
                      begin

                          lSalesHeader := Rec;
                          // LfORMaDDiNFO.SETRECORD(lSalesHeader);
                          // LfORMaDDiNFO.RUNMODAL;
                          Rec := lSalesHeader;
                          CurrPage.UPDATE(TRUE);
                      end;
                  }*/
            action(Description)
            {
                Caption = 'Description';
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                var
                    lDesc: Record "Description Line";
                begin
                    lDesc.ShowDescription(36, rec."Document Type", rec."No.", 0);
                end;
            }
            /*GL2024  action("Contacts and Contributors")
              {

                  ApplicationArea = all;
                  Caption = 'Contacts and Contributors';
                  //DYS page addon non migrer
                  // RunObject = Page 8004022;
                  // RunPageLink = "Document Type" = FIELD("Document Type"),
                  //                   "No." = FIELD("No.");
              }*/
            action("Interaction Log E&ntries")
            {
                ApplicationArea = all;
                Caption = 'Interaction Log E&ntries';
                Visible = false;


                trigger OnAction()
                begin

                    //CRM
                    rec.wShowDocumentInteraction(Rec);
                    //CRM//
                end;
            }
            /* GL2024 action("Job Sales Documents")
              {

                  ApplicationArea = all;
                  Caption = 'Job Sales Documentss';
                  //DYS page addon non migrer
                  // RunObject = Page 8004056;
                  // RunPageLink = "Job No." = FIELD("Job No.");
                  // RunPageView = SORTING("Job No.")
                  //                   WHERE("Job No." = FILTER(<> ''),
                  //                         "Order Type" = CONST(" "));
              }*/
            action("Price Study Archive")
            {

                ApplicationArea = all;
                Caption = 'Archive d''Études de Prix';
                trigger OnAction()
                var
                    lSalesHeaderArchive: Record "Sales Header Archive";
                begin

                    lSalesHeaderArchive.SETCURRENTKEY("Document Type", "Order No.");
                    lSalesHeaderArchive.SETRANGE("Document Type", lSalesHeaderArchive."Document Type"::Quote);
                    lSalesHeaderArchive.SETRANGE("Order No.", rec."No.");
                    IF NOT lSalesHeaderArchive.ISEMPTY THEN BEGIN
                        IF lSalesHeaderArchive.COUNT > 1 THEN
                            PAGE.RUNMODAL(PAGE::"Sales List Archive", lSalesHeaderArchive)
                        //DYS page addon non migrer
                        //ELSE
                        //  PAGE.RUNMODAL(PAGE::"NaviBat Sales Archive", lSalesHeaderArchive);
                    END;
                end;
            }
            separator(separator1000)
            {
            }
            action("Measurement : Document var")
            {

                ApplicationArea = all;
                Caption = 'Measurement : Document var';
                Visible = false;
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
            /* GL2024  action("Quote Footer")
               {

                   ApplicationArea = all;
                   Caption = 'Quote Footer';
                   trigger OnAction()
                   var
                       lSalesLine: Record "Sales Line";
                   begin

                       lSalesLine.SETRANGE("Document Type", rec."Document Type");
                       lSalesLine.SETRANGE("Document No.", rec."No.");
                       //DYS page addon non migrer
                       //PAGE.RUNMODAL(PAGE::"Quote Footer", lSalesLine);
                   end;
               }*/


        }
        addafter(Approvals_Promoted)
        {
            actionref(Folder1; Folder)
            {

            }
            actionref("E&tats1"; "E&tats")
            {

            }
            actionref(Description1; Description)
            {

            }
            actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries")
            {

            }
            actionref("Price Study Archive1"; "Price Study Archive")
            {

            }
            actionref("Measurement : Document var1"; "Measurement : Document var")
            {

            }
        }
        modify("PagePostedSalesPrepaymentCrMemos")
        {
            Visible = false;
        }
        modify(Reopen)
        {
            trigger OnafterAction()
            var

            begin
                //DEVIS
                CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
                //DEVIS//
            end;
        }
        modify(CopyDocument)

        {
            trigger OnafterAction()
            var

            begin
                //DYS a verifier
                //    CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
            end;
        }
        addafter(CopyDocument)
        {
            /* GL2024 action("Line copy")
              {
                  ApplicationArea = all;
                  Caption = 'Line copy';

              }*/
            /*GL2024   action("From Sales Line Archive")
              {

                  ApplicationArea = all;
                  Caption = 'From Sales Line Archive';
                  trigger OnAction()
                  begin

                      //DEVIS
                      //#8254
                      //DYS a verifier
                      // Currpage.SalesLines.page.wCopyLine(TRUE);
                      CurrPage.UPDATE(FALSE);
                      //#8254//
                      //DEVIS//
                  end;
              }*/
            /*GL2024  action("From Sales Line")
              {

                  ApplicationArea = all;
                  Caption = 'From Sales Line';
                  trigger OnAction()
                  begin

                      //DEVIS
                      //#8254
                      //DYS a verifier
                      //  CurrPAGE.SalesLines.PAGE.wCopyLine(FALSE);
                      CurrPage.UPDATE(FALSE);
                      //#8254//
                      //DEVIS//
                  end;
              }*/
            action("Archi&ve Document")
            {

                ApplicationArea = all;
                Caption = 'Archi&ve Document';
                trigger OnAction()
                var

                    ArchiveManagement: Codeunit ArchiveManagement;
                    Archivemgm: Codeunit ArchiveManagementEvent;
                begin

                    //#8211
                    Archivemgm.fSetQuoteToOrder(FALSE);
                    ArchiveManagement.ArchiveSalesDocument(Rec);
                    //#8211//
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        addafter(CopyDocument_Promoted)
        {
            actionref("Archi&ve Document1"; "Archi&ve Document")
            {

            }
        }
        addafter(MoveNegativeLines)
        {
            /*GL2024  group("Re&quisition Order")
              {

                  Caption = 'Re&quisition Order';

                  action("Générer demande d'appro.")
                  {

                      ApplicationArea = all;
                      Caption = 'Generate Supply Order';
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //  CurrPAGE.SalesLines.PAGE.wSupplyOrder;
                      end;
                  }
                  action("Supply Order")
                  {

                      ApplicationArea = all;
                      Caption = 'Supply Order';
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.wFindSupplyOrder;
                      end;
                  }
              }*/
            /*GL2024   group("Transfer Order")
               {
                   Caption = 'Transfer Order';
                   action("Generate Transfer Order")
                   {
                       ApplicationArea = all;
                       Caption = 'Generate Transfer Order';
                       trigger OnAction()
                       begin
                           //DYS a verifier
                           //CurrPAGE.SalesLines.PAGE.wTransfer;
                       end;
                   }
                   action("Transfer Order2")
                   {

                       ApplicationArea = all;
                       Caption = 'Transfer Order';
                       trigger OnAction()
                       begin
                           //DYS a verifier
                           // CurrPAGE.SalesLines.PAGE.wFindTransfer;
                       end;
                   }
               }*/
            group("Subcontracting")
            {

                Caption = 'Sous-traitance';

                /* GL2024  action("Generate Subcontracting")
                   {
                       ApplicationArea = all;
                       Caption = 'Generate Subcontracting';
                       trigger OnAction()
                       begin

                           //SUBCONTRACTOR
                           //DYS a verifier
                           //  CurrPAGE.SalesLines.PAGE.wGenerateSubcontracting;
                           //SUBCONTRACTOR//
                       end;
                   }*/
                /*GL2024    action("Update Cost")
                    {

                        ApplicationArea = all;
                        Caption = 'Update Cost';
                        trigger OnAction()
                        var
                            lSalesHeader: Record "Sales Header";
                        begin

                            //SUBCONTRACTOR
                            lSalesHeader.COPY(Rec);
                            lSalesHeader.SETRECFILTER;
                            //DYS REPORT addon non migrer
                            //REPORT.RUNMODAL(REPORT::"Update Subcontracting Cost", TRUE, FALSE, lSalesHeader);
                            //DYS a verifier
                            // CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                            //SUBCONTRACTOR//
                        end;
                    }*/

                action("Purchase D&ocument")
                {

                    ApplicationArea = all;
                    Caption = 'Document d''achat';
                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.OpenPurchOrderForm;
                    end;
                }
            }
            /*GL2024  action("Update Budget")
              {

                  ApplicationArea = all;
                  Caption = 'Update Budget';
                  trigger OnAction()
                  var
                      lSaleHeader: Record "Sales Header";
                  begin

                      lSaleHeader.COPY(Rec);
                      lSaleHeader.SETRECFILTER;
                      //DYS REPORT addon non migrer
                      //  REPORT.RUNMODAL(REPORT::"Sales to Job Budget Entry", TRUE, FALSE, lSaleHeader);
                  end;
              }*/
            /* GL2024  action("Import/Export lignes ventes")
               {

                   ApplicationArea = all;
                   Caption = 'Import/Export lignes ventes';
                   trigger OnAction()
                   var
                   //DYS REPORT addon non migrer
                   //lQuoteFromExcel: Report 8004054;
                   begin
                       //DYS
                       // CLEAR(lQuoteFromExcel);
                       // lQuoteFromExcel.InitRequest(rec."Document Type", rec."No.");
                       // lQuoteFromExcel.RUNMODAL;
                       //DYS a verifier
                       //    Currpage.SalesLines.page.wSetMarked(wMarked, ShowExtendedText);
                   end;
               }*/

        }
        addafter(MoveNegativeLines_Promoted)
        {
            actionref("Invoicing Scheduler1"; "Invoicing Scheduler")
            {

            }
            actionref("Production Completion1"; "Production Completion")
            {

            }
            /*GL2024   actionref("Planning Task1"; "Planning Task")
               {

               }*/
            group("Subcontracting1")
            {
                caption = 'Sous-traitance';
                actionref("Purchase D&ocument1"; "Purchase D&ocument")
                {

                }
            }

        }
        addafter("Pla&nning")
        {
            /*GL2024 action("Total needs")
             {
                 ApplicationArea = all;
                 Caption = 'Total needs';
                 //DYS page addon non migrer
                 // RunObject = Page 8004085;
                 // RunPageLink = "Document Type" = FIELD("Document Type"),
                 //                   "Document No." = FIELD("No.");
                 Visible = false;
             }
             action("Total needs 2")
             {

                 ApplicationArea = all;
                 Caption = 'Total needs 2';
                 ShortCutKey = 'Ctrl+F9';

                 trigger OnAction()
                 var
                 //DYS page addon non migrer
                 //   lFormNeed: Page 8004085;
                 begin

                     //#8255
                     // lFormNeed.fSetDocumentType(Rec."Document Type");
                     // lFormNeed.fSetDocumentNo(Rec."No.");
                     // lFormNeed.RUNMODAL();
                     //#8255//
                 end;
             }*/
            /* GL2024  action(Guarantees)
               {


                   ApplicationArea = all;
                   Caption = 'Guarantees';
                   //DYS page addon non migrer
                   // RunObject = Page 8003994;
                   // RunPageLink = "Document Type" = FIELD("Document Type"),
                   //                   "No." = FIELD("No.");
               }*/
            action("Invoicing Scheduler")
            {

                ApplicationArea = all;
                Caption = 'Planificateur de Facturation';
                trigger OnAction()
                var
                    lInvSch: Record "Invoice Scheduler";
                begin

                    //PROJET_FACT
                    rec.TESTFIELD("Invoicing Method", rec."Invoicing Method"::Scheduler);
                    lInvSch.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                    lInvSch.SETRANGE("Sales Header Doc. No.", rec."No.");
                    PAGE.RUN(0, lInvSch);
                    //PROJET_FACT//
                end;
            }
            action("Production Completion")
            {

                ApplicationArea = all;
                Caption = 'Production Completion';
                trigger OnAction()
                var
                    lCompletionMgt: Codeunit "Completion Management";
                begin

                    //PROJET_FACT
                    //#4523  TESTFIELD(Status,Status::Released);
                    //TESTFIELD("Invoicing Method");
                    lCompletionMgt.fShowCompletion(Rec);
                    //PROJET_FACT//
                end;
            }
            /*GL2024 action(Prepayments)
             {

                 ApplicationArea = all;
                 Caption = 'Prepayments';
                 //DYS page addon non migrer
                 // RunObject = Page 8003978;
                 // RunPageLink = "Document Type" = FIELD("Document Type"),
                 //                   "No." = FIELD("No.");
             }*/
            /*GL2024 action("Planning Task")
             {

                 ApplicationArea = all;
                 Caption = 'Planning Task';
                 trigger OnAction()
                 var
                     lRecordRef: RecordRef;
                     lPlanTask: Record "Planning Line";
                 begin

                     //PLANNING\\
                     lRecordRef.GETTABLE(Rec);
                     lPlanTask.SETFILTER("Source Record ID", FORMAT(lRecordRef.RECORDID));
                     //DYS page addon non migrer
                     // PAGE.RUNMODAL(PAGE::"Planning Task List", lPlanTask);
                 end;
             }*/
        }
        /*GL2024  addafter("F&unctions")
          {
              group("Ligne")
              {
                  Caption = '&Line';

                  action("Line Card")
                  {
                      Caption = 'Line Card';
                      ApplicationArea = all;

                      trigger OnAction()
                      begin

                          //#7652
                          //DYS a verifier
                          //Currpage.SalesLines.page.ShowLineCard;
                          //#7652//
                      end;
                  }
                  action("Comment Lines")
                  {

                      Caption = 'Comment Lines';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.ShowDescription;
                      end;
                  }
                  action("Bill Of Qty")
                  {

                      Caption = 'Bill Of Qty';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.lMetre();
                      end;
                  }
                  action(BOM)
                  {

                      Caption = 'BOM';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.wStructure;
                      end;
                  }
                  action("Move Up")
                  {
                      Caption = 'Move Up';
                      ApplicationArea = all;

                      ShortCutKey = 'Maj+Ctrl+Haut';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.Move(MoveOption::Up);
                          CurrPage.UPDATE(FALSE);
                      end;
                  }
                  action("Mode Down")
                  {

                      Caption = 'Mode Down';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //  CurrPAGE.SalesLines.PAGE.Move(MoveOption::Down);
                          CurrPage.UPDATE(FALSE);
                      end;
                  }
                  action("Open/Close the Folder")
                  {

                      Caption = 'Open/Close the Folder';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.ToggleExpandCollapse(FALSE);
                      end;
                  }
                  action("Calculate the quantity")
                  {

                      Caption = 'Calculate the quantity';
                      ApplicationArea = all;
                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.wCalculateQty;
                      end;
                  }
              }
          }*/
        modify(Post)
        {
            trigger OnbeforeAction()
            begin
                //#8742
                rec.TESTFIELD("Invoicing Method", rec."Invoicing Method"::Direct);
                //#8742//
                //PROJET_FACT    

            end;

            trigger OnafterAction()
            begin
                //PROJET_FACT//
                CurrPage.UPDATE(FALSE);
            end;
        }
        addafter("&Order Confirmation")
        {
            action(Commande)
            {
                Caption = 'Commande';
                ApplicationArea = all;
                Image = print;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012
                    IF rec.Status <> rec.Status::Released THEN ERROR(Text003);
                    RecSalesHeader.SETRANGE("Document Type", rec."Document Type");
                    RecSalesHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(REPORT::"Bon Déchargement", TRUE, TRUE, RecSalesHeader);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(Proforma)
            {
                Caption = 'Proforma';
                Visible = false;

                ApplicationArea = all;
                trigger OnAction()
                var
                    lSalesInvoiceHeader: Record "Sales Invoice Header";
                begin

                    //+REF+INVOICE
                    lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::Order);
                    lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    lSalesInvoiceHeader.PrintRecords(TRUE);
                    //+REF+INVOICE//
                end;
            }
            action("Pre-Invoice")
            {
                Visible = false;

                Caption = 'Pre-Invoice';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lSalesInvoiceHeader: Record "Sales Invoice Header";
                begin

                    //+REF+INVOICE
                    lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Invoice Request");
                    lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    lSalesInvoiceHeader.PrintRecords(TRUE);
                    //+REF+INVOICE//
                end;
            }
        }
        addafter("Work Order_Promoted")
        {
            actionref(Commande1; Commande)
            {

            }

            actionref(Proforma1; Proforma)
            {

            }
            actionref("Pre-Invoice1"; "Pre-Invoice")
            {

            }

        }
        /*//DYS    addafter(MoveNegativeLines)
           {
               action("Generate Purchase Order'")
               {
                   Caption = 'Generate Purchase Order';
                   ApplicationArea = all;
                   trigger OnAction()
                   begin
                       //DYS a verifier
                       //CurrPAGE.SalesLines.PAGE.gGenerateDropShipment;
                   end;
               }
           }*/
        addafter("&Order Confirmation")
        {
            action(Comment2)
            {
                Enabled = SalesCommentBtnENABLED;
                Caption = 'Commentaire';
                ApplicationArea = all;
                RunObject = Page "Sales Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                             "No." = FIELD("No."),
                              "Document Line No." = CONST(0);
            }
            /*//DYS   action("Move left")
              {
                  Caption = 'Move left';
                  ApplicationArea = all;


                  trigger OnAction()
                  begin
                      //DYS a verifier
                      //Currpage.SalesLines.page.Move(MoveOption::Left);
                      Currpage.UPDATE(FALSE);

                  end;
              }*/
            /*//DYS    action("Move Right")
               {

                   Caption = 'Move Right';
                   ApplicationArea = all;

                   trigger OnAction()
                   begin
                       //DYS a verifier
                       //  CurrPAGE.SalesLines.PAGE.Move(MoveOption::Right);
                   end;
               }*/
            /* GL2024  action("Hide/Show Header")
               {

                   Caption= 'Hide/Show Header', FRA = 'Masquer/Afficher en-tête';
                   ApplicationArea = all;

                   trigger OnAction()
                   begin

                       IF Currpage.SalesLines.YPOS = Currpage.TabControl.YPOS THEN BEGIN
                           Currpage.SalesLines.YPOS := Currpage.TabControl.YPOS + Currpage.TabControl.HEIGHT + Currpage.SalesLines.YPOS;
                           Currpage.SalesLines.HEIGHT := Currpage.SalesLines.HEIGHT - Currpage.SalesLines.YPOS;
                       END ELSE BEGIN
                           Currpage.SalesLines.HEIGHT := Currpage.SalesLines.HEIGHT + Currpage.SalesLines.YPOS;
                           Currpage.SalesLines.YPOS := Currpage.TabControl.YPOS;
                       END;

                   end;
               }*/
            /*//DYS      action("Hide/Show Extended Text")
                 {


                     Caption = 'Hide/Show Extended Text';
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
            action("&Workflow")
            {
                Enabled = WorkFlowBtnENABLED;
                Caption = 'Flux de travail';
                Visible = false;

                ApplicationArea = all;
                trigger OnAction()
                var
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                begin

                    lRecordRef.GETTABLE(Rec);
                    lWorkflowConnector.OnPush(PAGE::"Sales Order", lRecordRef);
                end;
            }
        }
        addafter(Category_Synchronize)
        {
            actionref(Comment22; Comment2)
            {

            }
            actionref("&Workflow1"; "&Workflow")
            {

            }
        }
    }








    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
        lSalesHeader: Record "Sales Header";

        UserMgt: Codeunit "User Setup Management";
    begin

        /* GL2024 SourceTableView=SORTING("Order Type","Document Type","No.","Invoicing Method",Finished)
                         WHERE("Document Type"=CONST(Order),
                               "Order Type"=FILTER(' '),
        //                        "Commande Interne"=FILTER(false));*/
        // Rec.FilterGroup(0);
        // rec.SetCurrentKey("Order Type", "Document Type", "No.", "Invoicing Method", Finished);
        // //  rec.SetAscending(Finished, true);
        // Rec.SetRange("Document Type", rec."Document Type"::Order);
        // Rec.SetRange("Order Type", rec."Order Type"::" ");
        // //  rec.SetRange("Commande Interne", false);
        // Rec.FilterGroup(2);
        IF rec."Rider to Order No." <> '' THEN
            ActivateHeader(false)
        ELSE BEGIN
            ActivateHeader(TRUE);
            //PROJET_FACT//
            IF rec."Job No." <> '' THEN BEGIN
                "Job Starting DateEDITABLE" := (FALSE);
                "Job Ending DateEDITABLE" := (FALSE);
            END
            ELSE BEGIN
                "Job Starting DateEDITABLE" := (TRUE);
                "Job Ending DateEDITABLE" := (TRUE);
            END;

        END;
        wSplashOpened := TRUE;
        wOpenSplash.OPEN(tOpenSplash);
        //wFormEditable := Currpage.EDITABLE;
        wFormEditable := TRUE;

        IF wSplashOpened THEN BEGIN
            wSplashOpened := FALSE;
            wOpenSplash.CLOSE;
            //+WKF+ CW 04/08/02 +Workflow Button
            WorkFlowBtnENABLED := (TRUE);
            HelpENABLED := (TRUE);
            SellToCommentBtnENABLED := (TRUE);
            BillToCommentBtnENABLED := (TRUE);
            SalesCommentBtnENABLED := (TRUE);
        END;


        //Inutile ? et empêche le lien livraison directe SETRANGE("No.");
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;




        //#8686
        IF NOT lSalesHeader.GET(rec."Document Type", rec."No.") THEN
            IF rec.FIND('-') THEN;
        //#8686//
        //CurrForm.SalesLines.FORM.SetUpdateAllowed(wFormEditable);
        NavibatSetup.GET2;

        ShowExtendedText := TRUE;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
    end;

    trigger OnAfterGetRecord()
    begin
        //DYS a verifier
        // Currpage.SalesLines.page.wPassEnt(Rec);
        IF rec."No." <> xRec."No." THEN BEGIN
            wMarked := FALSE;
            //DYS a verifier
            // Currpage.SalesLines.page.SetAfterGet(PresentationCode);
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

        //PROJET_FACT
        IF rec."Rider to Order No." <> '' THEN
            ActivateHeader(false)
        ELSE BEGIN
            ActivateHeader(TRUE);
            //PROJET_FACT//
            IF rec."Job No." <> '' THEN BEGIN
                "Job Starting DateEDITABLE" := (FALSE);
                "Job Ending DateEDITABLE" := (FALSE);
            END
            ELSE BEGIN
                "Job Starting DateEDITABLE" := (TRUE);
                "Job Ending DateEDITABLE" := (TRUE);
            END;
            //PROJET_FACT
        END;
        //PROJET_FACT//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Order Type" := rec."Order Type"::" ";
        rec."Document Type" := rec."Document Type"::Order;
        ProjectManagerName := '';
        ContactName := '';
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //DYS a verifier
        // Currpage.SalesLines.page.wPassEnt(Rec);
        // Currpage.SalesLines.page.SetAfterGet(PresentationCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
    end;


    trigger OnAfterGetCurrRecord()
    begin
        rec.SETRANGE("Document Type");
    end;

    PROCEDURE ActivateHeader(Active: Boolean);
    BEGIN

        "Sell-to Customer No.EDITABLE" := (Active);
        "Sell-to Customer NameEDITABLE" := (Active);
        "Ship-to CodeEDITABLE" := (Active);
        "Job No.EDITABLE" := (Active);
        "Ship-to NameEDITABLE" := (Active);
        "Job Starting DateEDITABLE" := (Active);
        "Job Ending DateEDITABLE" := (Active);
        "Job DescriptionEDITABLE" := (Active);
        "Project ManagerEDITABLE" := (Active);
        "Prices Including VATEDITABLE" := (Active);
        "Currency CodeEDITABLE" := (Active);
        "Payment Method CodeEDITABLE" := (Active);
        "Payment Terms CodeEDITABLE" := (Active);
        "Bill-to Customer No.EDITABLE" := (Active);
        "Bill-to NameEDITABLE" := (Active);
        "VAT Bus. Posting GroupEDITABLE" := (Active);
        "Contract TypeEDITABLE" := (Active);
        "Review Formula CodeEDITABLE" := (Active);
        "Review Base DateEDITABLE" := (Active);
        "Responsibility CenterEDITABLE" := (Active);
        DescrEDITABLE := (Active);
    END;

    var
        Contact: Record Contact;
        //DYS page addon non migrer
        // AddressContributors: Page 8004022;
        MoveOption: option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ProjectManagerName: Text[30];
        ContactName: Text[250];
        SupplyOrderMgt: Codeunit "Reordering Req. Management";
        wDescr: Text[100];
        NavibatSetup: Record NavibatSetup;
        Fenetre: Dialog;
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        wFormEditable: Boolean;
        "// VAr HJ DSFT": Integer;
        RecSalesHeader: Record "Sales Header";
        // CduSalesPost: Codeunit 80;
        TextUpdate: Label 'Processing...';
        tOpenSplash: Label 'Open In Progress...';
        Text003: Label 'Veuillez Lancer La Commande Avant Impression';

        //GL2024

        "Sell-to Customer No.EDITABLE": Boolean;
        "Sell-to Customer NameEDITABLE": Boolean;
        "Ship-to CodeEDITABLE": Boolean;
        "Job No.EDITABLE": Boolean;
        "Ship-to NameEDITABLE": Boolean;
        "Job Starting DateEDITABLE": Boolean;
        "Job Ending DateEDITABLE": Boolean;
        "Job DescriptionEDITABLE": Boolean;
        "Project ManagerEDITABLE": Boolean;
        "Prices Including VATEDITABLE": Boolean;
        "Currency CodeEDITABLE": Boolean;
        "Payment Method CodeEDITABLE": Boolean;
        "Payment Terms CodeEDITABLE": Boolean;
        "Bill-to Customer No.EDITABLE": Boolean;
        "Bill-to NameEDITABLE": Boolean;
        "VAT Bus. Posting GroupEDITABLE": Boolean;
        "Contract TypeEDITABLE": Boolean;
        "Review Formula CodeEDITABLE": Boolean;
        "Review Base DateEDITABLE": Boolean;
        "Responsibility CenterEDITABLE": Boolean;
        DescrEDITABLE: Boolean;
        WorkFlowBtnENABLED: Boolean;
        HelpENABLED: Boolean;
        SellToCommentBtnENABLED: Boolean;
        BillToCommentBtnENABLED: Boolean;
        SalesCommentBtnENABLED: Boolean;
}
