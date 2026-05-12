PageExtension 50026 "Sales Quote_PagEXT" extends "Sales Quote"
{
    /*GL2024  SourceTableView=SORTING(Order Type,Document Type,No.)
                     WHERE(Document Type=CONST(Quote), 
                           Order Type=CONST(" "));*/
    layout
    {

        modify("Sell-to Contact No.")
        {
            trigger OnAfterValidate()
            var
                SalutationType: Enum "Salutation Formula Salutation Type";
            begin
                ActivateFields;
                IF rec."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                    IF Contact.GET(rec."Sell-to Contact No.") THEN
                        ContactName := Contact.GetSalutation(SalutationType::Informal, rec."Language Code");
                CurrPage.UPDATE;
            end;
        }

        /*  modify("Sell-to Customer No.")
          {
             // Editable = "Sell-to Customer No.EDITABLE";
          }
          modify("Payment Terms Code")
          {
              //Editable = "Payment Terms CodeEDITABLE";
          }

          modify("Payment Method Code")
          {
              Editable = "Payment Method CodeEDITABLE";
          }
          modify("Ship-to Code")
          {
              Editable = "Ship-to CodeEDITABLE";
          }
          modify("Prices Including VAT")
          {
              Editable = "Prices Including VATEDITABLE";
          }
          modify("Currency Code")
          {
              Editable = "Currency CodeEDITABLE";
          }*/
        /*  //GL2024 modify(SalesLines)
          {
             Editable = SalesLinesFORMEDITABLE;
          }*/
        modify("Sell-to Customer Name")
        {
            Editable = "Sell-to Customer NameEDITABLE";
            trigger OnAssistEdit()

            begin

                CurrPage.SAVERECORD;
                COMMIT;
                //DYS
                // CLEAR(AddressContributors);
                // AddressContributors.InitRequest(1);
                // AddressContributors.SETTABLEVIEW(Rec);
                // AddressContributors.SETRECORD(Rec);
                // AddressContributors.RUN;
                //AddressContributors.GETRECORD(Rec);
                CurrPage.UPDATE;
            end;
        }
        // addafter(Status)
        // {
        //     field("Generer A Partir DA";rec."Generer A Partir DA")
        //     {

        //     }
        // }
        modify("Ship-to Name")

        {
            Editable = "Ship-to NameEDITABLE";
            trigger OnAssistEdit()
            begin
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

        addafter("Document Date")
        {
            field(ContactName; ContactName)
            {
                Caption = 'Nom du contact';
                Editable = false;
                ApplicationArea = all;
                trigger OnAssistEdit()
                var
                // AddressesandContributors: Page "Addresses and Contributors";
                begin
                    // CLEAR(AddressContributors);
                    // AddressContributors.InitRequest(1);
                    // AddressContributors.SETTABLEVIEW(Rec);
                    // AddressContributors.SETRECORD(Rec);
                    // AddressContributors.RUNMODAL;
                    //AddressContributors.GETRECORD(Rec);
                    CurrPage.UPDATE;
                end;
            }
            field(Subject; Rec.Subject)
            {
                Caption = 'Sujet';
                ApplicationArea = all;
                trigger OnAssistEdit()
                var
                //  lDescription: Record "Structure Extended Text";
                begin
                    // lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                end;
            }
            /* field("Date Ordre Service"; Rec."Date Ordre Service")
             {
                 ApplicationArea = all;
             }
             field("Date Fin de Travaux"; Rec."Date Fin de Travaux")
             {
                 ApplicationArea = all;
             }*/
            field(Approbateur; Rec.Approbateur)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Date approbation"; Rec."Date approbation")
            {
                ApplicationArea = all;
                Editable = false;
            }
            /*   field("DA Approbé"; Rec."DA Approbé")
               {
                   ApplicationArea = all;
                   Editable = false;
               }*/
            field("Sell-to Customer Template Code"; Rec."Sell-to Customer Templ. Code")
            {
                ApplicationArea = all;


                trigger OnValidate()
                var
                    SalutationType: Enum "Salutation Formula Salutation Type";
                begin
                    ActivateFields;

                    CurrPage.UPDATE;
                end;
            }
            // field("Approbation DG"; Rec."Approbation DG")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }

            // field("Date Approbation DG"; Rec."Date Approbation DG")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
        }

        addafter(General)
        {
            group(Job)
            {
                Caption = 'Affaire';
                field("Job No."; rec."Job No.")
                {
                    Editable = "Job No.EDITABLE";
                    ApplicationArea = all;
                    Caption = 'Désignation affaire';
                }
                field("Job Description"; rec."Job Description")
                {
                    Editable = "Job DescriptionEDITABLE";
                    ApplicationArea = all;
                }
                field("Project Manager"; rec."Project Manager")
                {
                    Editable = "Project ManagerEDITABLE";
                    ApplicationArea = all;
                    Caption = 'Maître d''oeuvre';
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
                field("Nom du maître d'oeuvre"; ProjectManagerName)
                {
                    Caption = 'Nom du Maître d''oeuvre';
                    Editable = false;
                    ApplicationArea = all;

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
                field("<Salesperson Code2>"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("Job Starting Date"; rec."Job Starting Date")
                {
                    Editable = "Job Starting DateEDITABLE";
                    ApplicationArea = all;
                    Caption = 'Date de début Affaire';
                }
                field("Job Ending Date"; rec."Job Ending Date")
                {
                    Editable = "Job Ending DateEDITABLE";
                    ApplicationArea = all;
                    Caption = 'Date de fin Affaire';

                }
                field("<Shipment Date2>"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }

                field("<Assigned User ID2>"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }


            }
        }
        addafter("Currency Code")
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
                trigger OnValidate()
                begin
                    Currpage.SalesLines.page.UpdateForm(FALSE);
                end;
            }


            field("Bill-to Customer Template Code"; Rec."Bill-to Customer Templ. Code")
            {
                Editable = "Bill-to Customer Template CodeEDITABLE";
                ApplicationArea = all;
            }

        }
        modify("VAT Bus. Posting Group")
        {
            Editable = "VAT Bus. Posting GroupEDITABLE";
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Rider to Order No."; Rec."Rider to Order No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin

                    ActivateHeader(rec."Rider to Order No." = '');
                end;

            }
            field(Comment; Rec.Comment)
            {
                Caption = 'Commentaire';
                ApplicationArea = all;
            }
        }

        modify("Bill-to Name")
        {
            Editable = "Bill-to NameEDITABLE";
            trigger OnAssistEdit()
            begin

                Currpage.SAVERECORD;
                COMMIT;
                //DYS
                // CLEAR(AddressContributors);
                // AddressContributors.InitRequest(3);
                // AddressContributors.SETTABLEVIEW(Rec);
                // AddressContributors.SETRECORD(Rec);
                // AddressContributors.RUNMODAL;
                //AddressContributors.GETRECORD(Rec);
                Currpage.UPDATE;
            end;
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
            end;

        }

        addbefore("Shortcut Dimension 1 Code")
        {
            field("Deadline Code"; Rec."Deadline Code")
            {
                ApplicationArea = all;
            }

            field("Deadline Date"; Rec."Deadline Date")
            {
                ApplicationArea = all;
            }
            field("Review Formula Code"; Rec."Review Formula Code")
            {
                Editable = "Review Formula CodeEDITABLE";
                ApplicationArea = all;
            }
            field("Review Base Date"; Rec."Review Base Date")
            {

                Editable = "Review Base DateEDITABLE";
                ApplicationArea = all;
            }
        }
        addafter(WorkflowStatus)
        {
            field("Lines Setup"; PresentationCode)
            {
                Caption = 'Lines Setup';
                ApplicationArea = all;
                TableRelation = "Sales Line View";

                trigger OnValidate()
                begin
                    //DYS a verifier
                    // Currpage.SalesLines.page.ShowColumns(PresentationCode);
                end;
            }
        }

        addafter("No. of Archived Versions")
        {
            field("Progress Degree"; Rec."Progress Degree")
            {
                ApplicationArea = all;
            }
        }







    }


    actions
    {
        addafter(Email)
        {
            action(Print2)
            {

                ApplicationArea = all;
                Caption = 'Imprimer A4';
                Image = Print;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012

                    RecSalesHeader.SETRANGE("Document Type", rec."Document Type");
                    RecSalesHeader.SETRANGE("No.", rec."No.");
                    //REPORT.RUNMODAL(REPORT::"Bon Commande Vente",TRUE,TRUE,RecSalesHeader);
                    //  REPORT.RUNMODAL(REPORT::"Bon Commande Vente Beton", TRUE, TRUE, RecSalesHeader);
                    REPORT.RUNMODAL(REPORT::"Bon Commande Vente", TRUE, TRUE, RecSalesHeader);
                    // >> HJ DSFT 10-10-2012
                    // STD HJ DSFT 10-10-2012 DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
        addafter("C&ontact")
        {
            action("Calculer BIC")
            {
                ApplicationArea = all;
                Caption = 'Calculer BIC';
                Image = Calculate;
                trigger OnAction()
                VAR
                    SalesPostEvent: Codeunit SalesPostEvent;
                BEGIN
                    //+REF+ADDTEXT
                    SalesPostEvent.CalcBIC(Rec);
                    //+REF+ADDTEXT//
                end;
            }
            action("Header Comments")
            {
                ApplicationArea = all;
                Caption = 'Header Comments';
                Visible = false;
                trigger OnAction()
                VAR
                    lSalesTextManagement: Codeunit "Sales Text Management";
                BEGIN

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 1);
                    //+REF+ADDTEXT//

                end;
            }
            action("Footer Comments")
            {
                ApplicationArea = all;
                Visible = false;
                Caption = 'Commentaires &pied';
                trigger OnAction()
                VAR
                    lSalesTextManagement: Codeunit "Sales Text Management";
                BEGIN

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 2);
                    //+REF+ADDTEXT//
                end;
            }
        }
        addafter("MakeOrder_Promoted")
        {
            actionref("calculer_BIC"; "calculer BIC")
            {

            }


        }
        addafter("C&ontact_Promoted")
        {
            actionref("Header Comments1"; "Header Comments")
            {

            }
            actionref("Footer Comments1"; "Footer Comments")
            {

            }
        }


        addafter(Approvals)
        {
            /*  //DYS action("Statistics Criteria")
             {
                 ApplicationArea = all;
                 Caption = 'Statistics Criteria';
                 trigger OnAction()
                 VAR
                     lSalesHeader: Record "Sales Header";
                 //DYS page addon non migrer
                 // lFormStatSales: Page 8005125;
                 BEGIN

                     lSalesHeader := Rec;
                     //DYS
                     // lFormStatSales.SETRECORD(lSalesHeader);
                     // lFormStatSales.fSetSalesDoc(TRUE);
                     // lFormStatSales.RUNMODAL();
                     Rec := lSalesHeader;
                     CurrPage.UPDATE(TRUE);
                 END;

             }
             action("Additionnals Informations")
             {
                 ApplicationArea = all;
                 Caption = 'Additionnals Informations';
                 trigger OnAction()
                 VAR
                     lSalesHeader: Record "Sales Header";
                 //DYS page addon non migrer
                 //lFormAddInfo: Page 8005126;
                 BEGIN

                     lSalesHeader := Rec;
                     // lFormAddInfo.SETRECORD(lSalesHeader);
                     // lFormAddInfo.RUNMODAL;
                     Rec := lSalesHeader;
                     CurrPage.UPDATE(TRUE);

                 end;
             }*/
            action(Description)
            {
                ApplicationArea = all;
                Caption = 'Description';
                trigger OnAction()
                VAR
                    lDescription: Record "Description Line";
                BEGIN
                    lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);

                end;
            }

            /*  //DYS   action("Contacts and Contributors")
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
                Visible = false;
                Caption = 'Ecritures journal d''interaction';
                trigger OnAction()
                begin

                    //CRM
                    rec.wShowDocumentInteraction(Rec);
                    //CRM//
                end;
            }
            /* //DYS  action("Job Sales Documents")
             {
                 ApplicationArea = all;
                 Caption = 'Job Sales Documents';
                 //DYS page addon non migrer
                 // RunObject = Page 8004056;
                 // RunPageView = SORTING("Job No.")
                 //                   WHERE("Job No." = FILTER(<> ''),
                 //                         "Order Type" = CONST(" "));
                 // RunPageLink = "Job No." = FIELD("Job No.");
             }*/
            action(Folder)
            {
                ApplicationArea = all;
                Visible = false;
                Caption = 'Dossier';
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN


                    //FOLDER
                    lFolderManagement.SalesHeader(Rec);
                    //FOLDER//

                end;
            }

            action("E&tats")
            {
                ApplicationArea = all;
                Visible = false;
                Caption = 'E&tats';
                trigger OnAction()
                VAR
                    lReportList: Record ReportList;
                    lId: Integer;
                    lRecRef: RecordRef;
                BEGIN

                    WITH lReportList DO BEGIN
                        EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                        lRecRef.GETTABLE(Rec);
                        lRecRef.SETRECFILTER;
                        SetRecordRef(lRecRef, TRUE);
                        ShowList(lId);
                    END;

                end;
            }
            separator(action1100280091)
            {

            }

            action("Measurement : Document var")
            {
                ApplicationArea = all;
                Caption = 'Measurement : Document var';
                Visible = false;
                trigger OnAction()
                VAR
                    lRecRef: RecordRef;
                    lBOQCustMgt: Codeunit "BOQ Custom Management";
                BEGIN

                    //#6115
                    lRecRef.GETTABLE(Rec);
                    IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
                        EXIT;
                    CurrPage.UPDATE(FALSE);
                    //#6115//

                end;
            }

            separator(action1100280092)
            {

            }
            /*DYS   action("Quote Footer")
               {
                   ApplicationArea = all;
                   Caption = 'Quote Footer';
                   trigger OnAction()
                   VAR
                       lSalesLine: Record "Sales Line";
                   BEGIN

                       lSalesLine.SETRANGE("Document Type", rec."Document Type");
                       lSalesLine.SETRANGE("Document No.", rec."No.");
                       //DYS page addon non migrer
                       //PAGE.RUNMODAL(PAGE::"Quote Footer", lSalesLine);

                   end;
               }*/

            separator(action1100280093)
            {

            }

            action("Invoice Scheduler")
            {
                ApplicationArea = all;
                Caption = 'Invoice Scheduler';
                Visible = false;
                trigger OnAction()
                VAR
                    lInvSch: Record "Invoice Scheduler";
                BEGIN

                    //PROJET_FACT
                    rec.TESTFIELD("Invoicing Method", rec."Invoicing Method"::Scheduler);
                    lInvSch.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                    lInvSch.SETRANGE("Sales Header Doc. No.", rec."No.");
                    PAGE.RUN(0, lInvSch);
                    //PROJET_FACT//

                end;
            }
            /* //DYS  action("Total needs")
             {
                 ApplicationArea = all;
                 Caption = 'Total needs';
                 trigger OnAction()
                 VAR
                 //DYS page addon non migrer
                 //  lFormNeed: Page 8004085;
                 begin

                     //#8255
                     // lFormNeed.fSetDocumentType(Rec."Document Type");
                     // lFormNeed.fSetDocumentNo(Rec."No.");
                     // lFormNeed.RUNMODAL();
                     //#8255//

                 end;
             }*/

            /* //DYS   action("External Reference")
              {
                  ApplicationArea = all;
                  Caption = 'External Reference';
                  //DYS page addon non migrer
                  // RunObject = Page 8003977;
                  // RunPageLink = "Document Type" = FIELD("Document Type"),
                  //                   "Document No." = FIELD("No.");
              }*/

            /*GL2024   action("Planning Task")
               {
                   ApplicationArea = all;
                   Caption = 'Planning Task';
                   trigger OnAction()
                   VAR
                       lRecordRef: RecordRef;
                       lPlanTask: Record "Planning Line";
                   BEGIN

                       //PLANNING\\
                       lRecordRef.GETTABLE(Rec);
                       lPlanTask.SETFILTER("Source Record ID", FORMAT(lRecordRef.RECORDID));
                       //DYS page addon non migrer
                       //   PAGE.RUNMODAL(PAGE::"Planning Task List", lPlanTask);

                   end;
               }*/

            action("Valider Offre de Prix")
            {
                ApplicationArea = all;
                Caption = 'Valider Offre de Prix';

                trigger OnAction()
                begin

                    //IF rec."DA Approbé" = TRUE THEN ERROR(Text004);
                    IF UserSetup.GET(USERID) THEN BEGIN
                        // IF UserSetup."Approbateur Devis vente" = FALSE THEN ERROR(Text002);
                    END;

                    IF NOT CONFIRM('Voulez-vous Validé l Offre de Prix', FALSE) THEN EXIT;
                    //      rec."DA Approbé" := TRUE;
                    rec.Approbateur := USERID;
                    rec."Date approbation" := TODAY;
                    rec.MODIFY;
                end;
            }

        }
        addafter(Approvals_Promoted)
        {
            actionref("IDescription1"; "Description")
            {

            }
            actionref("Interaction Log E&ntries1"; "Interaction Log E&ntries")
            {

            }
            actionref("Folder1"; Folder)
            {

            }
            actionref("E&tats1"; "E&tats")
            {

            }
            actionref("Measurement : Document var1"; "Measurement : Document var")
            {

            }
            /*GL2024 actionref("Quote Footer1"; "Quote Footer")
             {

             }*/
            actionref("Invoice Scheduler1"; "Invoice Scheduler")
            {

            }
            /*GL2024 actionref("Planning Task1"; "Planning Task")
             {

             }*/
            actionref("Valider Offre de Prix1"; "Valider Offre de Prix")
            {

            }
        }


        /*GL2024  addafter(Action59)
          {
              group("&Ligne")
              {
                  Caption = '&Line';
                  action("Fiche ligne")
                  {
                      Caption = 'Line record';
                      ApplicationArea = all;

                      trigger OnAction()
                      begin

                          //#7652
                          //DYS a verifier
                          //Currpage.SalesLines.page.ShowLineCard;
                          //#7652//
                      end;
                  }
                  action("Item Availability by")
                  {
                      ApplicationArea = all;
                      Caption = 'Item Availability by';
                      ShortCutKey = 'Maj+F5';
                  }
                  action("Period")
                  {
                      ApplicationArea = all;
                      Caption = 'Period';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //  CurrPAGE.SalesLines.PAGE.ItemAvailability(0);
                      end;
                  }
                  action(Variant)
                  {
                      ApplicationArea = all;
                      Caption = 'Variant';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.ItemAvailability(1);
                      end;
                  }
                  action(Location)
                  {
                      ApplicationArea = all;
                      Caption = 'Location';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.page.ItemAvailability(2);
                      end;
                  }
                  action("Select Item Substitution")
                  {
                      ApplicationArea = all;
                      Caption = 'Select Item Substitution';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPage.SalesLines.PAGE.ShowItemSub;
                      end;
                  }
                  action("Dimensions1")
                  {
                      ApplicationArea = all;
                      Caption = 'Dimensions';
                      ShortCutKey = 'Maj+Ctrl+D';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.ShowDimensions;
                      end;
                  }
                  action("Co&mments1")
                  {
                      ApplicationArea = all;
                      Caption = 'Co&mments';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPage.SalesLines.PAGE.ShowLineComments;
                      end;
                  }
                  action("Item Charge &Assignment")
                  {
                      ApplicationArea = all;
                      Caption = 'Item Charge &Assignment';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPage.SalesLines.PAGE.ItemChargeAssgnt;
                      end;
                  }
                  action("Item &Tracking Lines")
                  {
                      ApplicationArea = all;
                      Caption = 'Item &Tracking Lines';
                      ShortCutKey = 'Maj+Ctrl+I';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //  CurrPAGE.SalesLines.PAGE.OpenItemTrackingLines;
                      end;
                  }
                  action(Description2)
                  {
                      ApplicationArea = all;
                      Caption = 'Description';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.ShowDescription;
                      end;
                  }
                  separator(separator62522)
                  {
                  }
                  action("Bill Of Qty")
                  {
                      ApplicationArea = all;
                      Caption = 'Bill Of Qty';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.lMetre();
                      end;
                  }
                  action("Calculate the Bill Of Qty")
                  {
                      ApplicationArea = all;
                      Caption = 'Calculate the Bill Of Qty';

                      trigger OnAction()
                      begin

                          //#5771
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.wCalculateCurrentBOQ(gSalesLine.FIELDNO(Quantity));
                          //#5771//
                      end;
                  }
                  action(Structure)
                  {
                      ApplicationArea = all;
                      Caption = 'Structure';
                      ShortCutKey = 'Maj+Ctrl+E';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.wStructure;
                      end;
                  }
                  action("Expand/Collapse")
                  {
                      ApplicationArea = all;
                      Caption = 'Expand/Collapse';
                      ShortCutKey = 'Maj+Ctrl+O';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.ToggleExpandCollapse(FALSE);
                      end;
                  }
                  action("Move Up")
                  {
                      ApplicationArea = all;
                      Caption = 'Move Up';
                      ShortCutKey = 'Maj+Ctrl+Alt+Haut';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.Move(3);
                      end;
                  }
                  action("Mode Down")
                  {
                      ApplicationArea = all;
                      Caption = 'Mode Down';
                      ShortCutKey = 'Maj+Ctrl+Alt+Bas';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //  CurrPAGE.SalesLines.PAGE.Move(4);
                      end;
                  }
                  action("Move Right2")
                  {
                      ApplicationArea = all;
                      Caption = 'Move Right';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.Move(2);
                      end;
                  }
                  action("Move left2")
                  {
                      ApplicationArea = all;
                      Caption = 'Move left';
                      ShortCutKey = 'Maj+Ctrl+Alt+Gauche';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.Move(1);
                      end;
                  }
                  action("Calculate the quantity")
                  {
                      ApplicationArea = all;
                      Caption = 'Calculate the quantity';
                      ShortCutKey = 'Maj+F9';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.wCalculateQty;
                      end;
                  }
                  action("Cross-Reference2")
                  {
                      ApplicationArea = all;
                      Caption = 'Cross-Reference';
                  }
                  action(Group)
                  {
                      ApplicationArea = all;
                      Caption = 'Group';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.wGroupCrossRef;
                      end;
                  }
                  action("Ungroup")
                  {
                      ApplicationArea = all;
                      Caption = 'Ungroup';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          //CurrPAGE.SalesLines.PAGE.wUnGroupCrossRef;
                      end;
                  }

              }
          }*/
        modify(Print)
        {
            trigger OnBeforeAction()
            begin

                //PROJET_FACT
                CustCheckCreditLimit.SalesHeaderCheck(Rec);
                //PROJET_FACT//
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                lArchiveMgt: Codeunit ArchiveManagement;
            begin

                //DEVIS
                IF xRec.Status <> xRec.Status::Open THEN
                    IF rec."Document Type" = rec."Document Type"::Quote THEN
                        IF CONFIRM(tArchiverDoc, TRUE) THEN BEGIN
                            lArchiveMgt.ArchiveSalesDocument(Rec);
                            MESSAGE(tArchDone);
                        END;
                //DEVIS//
            end;
        }
        modify(CopyDocument)
        {
            trigger OnAfterAction()
            var
                lDialog: Dialog;
                lOwnerRef: RecordRef;
            begin

                //#6489
                //DYS a verifier
                //CurrPAGE.SalesLines.PAGE.SetAfterGet(PresentationCode);
                //#6489//
                //CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
            end;
        }

        /*  //DYS addbefore("Archive Document")
         {
             group("Line copy")
             {

                 Caption = 'Line copy';

                 action("From Sales Line Archive")
                 {
                     ApplicationArea = all;
                     Caption = 'From Sales Line Archive';
                     trigger OnAction()
                     begin


                         //DEVIS
                         //#8254
                         //DYS a verifier
                         //  Currpage.SalesLines.page.wCopyLine(TRUE);
                         CurrPage.UPDATE(FALSE);
                         //#8254//
                         //DEVIS//
                     end;
                 }
                 /*    //DYS  action("From Sales Line")
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
                    }
             }
         }*/


        modify("Archive Document")
        {
            trigger OnBeforeAction()
            begin
                //#8211
                ArchiveManagement.fSetQuoteToOrder(FALSE);
                //#82111//
            end;
        }
        addafter("Archive Document")
        {
            action("Get &Price")
            {
                ApplicationArea = all;
                Caption = 'Get &Price';
                trigger OnAction()
                begin
                    //DYS a verifier
                    //CurrPage.SalesLines.PAGE.ShowPrices;
                end;

            }
            group("Subcontracting")
            {

                Caption = 'Subcontracting';

                /* //DYS  action("Generate Subcontracting")
                  {
                      ApplicationArea = all;
                      Caption = 'Generate Subcontracting';

                      trigger OnAction()
                      begin

                          //SUBCONTRACTOR
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.wGenerateSubcontracting;
                          //SUBCONTRACTOR//
                      end;
                  }*/
                action("Update Cost")
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
                        // REPORT.RUNMODAL(REPORT::"Update Subcontracting Cost", TRUE, FALSE, lSalesHeader);
                        CurrPage.UPDATE(FALSE);
                        //SUBCONTRACTOR//
                    end;
                }
                /* //DYS  action("Purchase Qu&ote")
                  {
                      ApplicationArea = all;
                      Caption = 'Purchase Qu&ote';

                      trigger OnAction()
                      begin
                          //DYS a verifier
                          // CurrPAGE.SalesLines.PAGE.OpenPurchOrderForm;
                      end;
                  }
                  action("Rejec&t")
                  {
                      ApplicationArea = all;
                      Caption = 'Rejec&t';
                      //DYS cdu n'existe pas dans NAV
                      //RunObject = Codeunit 6202;
                  }*/
                action("Create Job / P&hase")
                {
                    ApplicationArea = all;
                    Caption = 'Create Job / P&hase';

                    trigger OnAction()
                    var
                        lSaleHeader: Record "Sales Header";
                    //DYS REPORT addon non migrer
                    //lCreateJob: Report 8004055;
                    begin

                        lSaleHeader.COPY(Rec);
                        lSaleHeader.SETRECFILTER;
                        //lCreateJob.SETTABLEVIEW(lSaleHeader);
                        //lCreateJob.RUNMODAL;
                    end;
                }
                action("Create Order")
                {
                    ApplicationArea = all;
                    Caption = 'Create Order';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        IF ApprovalMgt.PrePostApprovalCheckSales(Rec) THEN
                            CODEUNIT.RUN(CODEUNIT::"Sales-Quote to Order (Yes/No)", Rec);
                    end;
                }
                /* //DYS   action("Import/Export Sales Lines")
                   {
                       ApplicationArea = all;
                       Caption = 'Import/Export Sales Lines';

                       trigger OnAction()
                       var
                       //DYS REPORT addon non migrer
                       //  lQuoteFromExcel: Report 8004054;
                       begin

                           // CLEAR(lQuoteFromExcel);
                           // lQuoteFromExcel.InitRequest(rec."Document Type", rec."No.");
                           // lQuoteFromExcel.RUNMODAL;

                           CurrPage.UPDATE(FALSE);
                       end;
                   }*/
                /* //DYS action("Nomad Import/Export")
                 {
                     ApplicationArea = all;
                     Caption = 'Nomad Import/Export';

                     trigger OnAction()
                     var
                         //DYS Xmlport addon non migrer
                         //    lNomad: XmlPort "Import/Export Nomad Sales Doc";
                        //DYS  lLaunchDP: Codeunit "Launch Dataport";
                     //DYS Xmlport addon non migrer
                     //  lXmlNomad: XMLport "Import/Export Nomad Sales Doc";
                     //DYS report addon non migrer
                     // lReportNomad: Report "Import/Export Nomad Sales Doc.";

                     begin

                         /*
                         IF (NOT ISSERVICETIER) THEN BEGIN
                           lNomad.SetDocument(Rec);
                           lNomad.RUNMODAL;
                           IF lNomad.IMPORT THEN
                             lNomad.GetDocument(Rec);
                         //CurrPAGE.SalesLines.FORM.InitTempTable(ShowLevel,ShowExtendedText);
                         END ELSE BEGIN
                           lXmlNomad.SetDocument(Rec);
                           lXmlNomad.RUN;
                           IF lXmlNomad.IMPORT THEN
                             lXmlNomad.GetDocument(Rec);

                         END; */
                //DYS
                // lReportNomad.SetDocument(Rec);
                // lReportNomad.RUNMODAL;
                // IF lReportNomad.Import THEN
                //     lReportNomad.GetDocument(Rec);

                //DYS end;
                //DYS  }
                /* //DYS action("Update Phase")
                 {
                     ApplicationArea = all;
                     Caption = 'Update Phase';

                     trigger OnAction()
                     var
                         lSalesheader: Record "Sales Header";
                     begin

                         lSalesheader.COPY(Rec);
                         lSalesheader.SETRECFILTER;
                         //DYS REPORT addon non migrer
                         //  REPORT.RUNMODAL(REPORT::"Sales to Job Budget Entry", TRUE, FALSE, lSalesheader);
                     end;
                 }*/
            }
        }


        addafter("Archive Document_Promoted")
        {
            actionref("Create Order1"; "Create Order")
            {

            }


            actionref("Get &Price1"; "Get &Price")
            {

            }
            /*GL2024 actionref("Generate Subcontracting1"; "Generate Subcontracting")
             {

             }*/
            actionref("Update Cost1"; "Update Cost")
            {

            }

            /* GL2024  actionref("Purchase Qu&ote1"; "Purchase Qu&ote")
               {

               }
               actionref("Rejec&t1"; "Rejec&t")
               {

               }*/

            actionref("Create Job / P&hase1"; "Create Job / P&hase")
            {

            }
        }

        addafter("F&unctions")
        {
            action("Re&open")
            {
                Caption = 'Re&open';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    IF UserSetup.GET(USERID) THEN BEGIN
                        //  IF UserSetup."Approbateur Devis vente" = FALSE THEN ERROR(Text002);
                    END;

                    IF NOT CONFIRM('Voulez-vous Réouvrir l Offre de Prix', FALSE) THEN EXIT;
                    //  rec."DA Approbé" := FALSE;
                    rec.MODIFY;
                end;
            }
            action("Validate the offer")
            {
                caption = 'Validate the offer';

                ApplicationArea = all;
                trigger OnAction()
                begin

                    //   IF rec."DA Approbé" = TRUE THEN ERROR(Text004);
                    IF UserSetup.GET(USERID) THEN BEGIN
                        //     IF UserSetup."Approbateur Devis vente" = FALSE THEN ERROR(Text002);
                    END;

                    IF NOT CONFIRM('Voulez-vous Validé l Offre de Prix', FALSE) THEN EXIT;
                    //  rec."DA Approbé" := TRUE;
                    rec.Approbateur := USERID;
                    rec."Date approbation" := TODAY;
                    rec.MODIFY;
                end;
            }
            action(Comment1)
            {
                caption = 'Comment';
                Enabled = SalesCommentBtnENABLED;
                ApplicationArea = all;
                RunObject = Page "Sales Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No."),
                              "Document Line No." = CONST(0);
            }
            action(Actualiser)
            {
                Caption = 'Update';
                ApplicationArea = all;
                Visible = true;

                trigger OnAction()
                begin

                    /*SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type","Document Type");
                    SalesLine.SETRANGE("Document No.","No.");
                    SalesLine.SETFILTER(Type,'%1|%2',SalesLine.Type::Item,SalesLine.Type::Resource);
                    IF SalesLine.FINDFIRST THEN
                      REPEAT
                         IF SalesLine.Type=SalesLine.Type::Item THEN
                           BEGIN
                             IF Item.GET(SalesLine."No.") THEN BEGIN
                             IF SalesLine."Unit Cost (LCY)"<>Item."Unit Cost" THEN
                             SalesLine.VALIDATE("Unit Cost (LCY)",Item."Unit Cost");
                             SalesLine.VALIDATE(Quantity,SalesLine.Quantity);
                             SalesLine.MODIFY;
                             END;
                           END;
                         IF SalesLine.Type=SalesLine.Type::Resource THEN
                           BEGIN
                             IF Resource.GET(SalesLine."No.") THEN BEGIN
                             IF SalesLine."Unit Cost (LCY)"<>Resource."Unit Cost" THEN
                             SalesLine.VALIDATE("Unit Cost (LCY)",Resource."Unit Cost");
                             SalesLine.VALIDATE(Quantity,SalesLine.Quantity);
                             SalesLine.MODIFY;
                             END;
                           END;
                    
                      UNTIL SalesLine.NEXT=0;
                    UpdateUMIM;
                    SalesLine2.RESET;
                    SalesLine2.SETRANGE("Document Type","Document Type");
                    SalesLine2.SETRANGE("Document No.","No.");
                    //SalesLine2.SETRANGE("Line Type",SalesLine2."Line Type"::Structure);
                    IF SalesLine2.FINDFIRST THEN
                    REPEAT
                      SalesLine2.VALIDATE("Unit Price","Coeficient Reglement"*SalesLine2."Unit Cost (LCY)");
                    
                      SalesLine2.MODIFY;
                    UNTIL SalesLine2.NEXT=0 ;
                    */

                    //>>     MH SORO 30-05-2022
                    Ligne := 1000;
                    RecItem2.RESET;
                    RecItem2.SETRANGE("Integrer Offre dr Prix", TRUE);
                    IF RecItem2.FINDFIRST THEN
                        REPEAT
                            SalesLine2."Document Type" := rec."Document Type";
                            SalesLine2."Document No." := rec."No.";
                            SalesLine2.Type := 2;
                            SalesLine2."Line No." := Ligne;
                            SalesLine2.VALIDATE("No.", RecItem2."No.");
                            SalesLine2."Unit Price" := 0;
                            SalesLine2.Quantity := 1;
                            SalesLine2.INSERT();
                            Ligne := Ligne + 1000;
                        UNTIL RecItem2.NEXT = 0;

                    SalesLine2."Document Type" := rec."Document Type";
                    SalesLine2."Document No." := rec."No.";
                    SalesLine2.VALIDATE("Line Type", SalesLine2."Line Type"::"Charge (Item)");
                    SalesLine2."Line No." := Ligne;
                    SalesLine2.VALIDATE("No.", 'P-TR/TRANS');
                    SalesLine2.Description := 'TRANSPORT';
                    SalesLine2."Unit Price" := 0;
                    SalesLine2.Quantity := 1;
                    SalesLine2.INSERT();

                    Ligne := Ligne + 1000;

                    SalesLine2."Document Type" := rec."Document Type";
                    SalesLine2."Document No." := rec."No.";
                    SalesLine2.VALIDATE("Line Type", SalesLine2."Line Type"::"Charge (Item)");
                    SalesLine2."Line No." := Ligne;
                    SalesLine2.VALIDATE("No.", 'P-TR/POMPAGE');
                    SalesLine2."Unit Price" := 0;
                    SalesLine2.Quantity := 1;
                    SalesLine2.INSERT();


                    //<<    MH SORO 30-05-2022

                    MESSAGE(Text001);


                    CurrPage.UPDATE;

                end;
            }
            action("Header Comment")
            {
                ApplicationArea = all;
                Caption = 'Header Comment';

                trigger OnAction()
                var
                    lSalesTextManagement: Codeunit "Sales Text Management";
                begin

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 1);
                    //+REF+ADDTEXT//
                end;
            }
            action("Footer Comment")
            {

                ApplicationArea = all;
                Caption = 'Footer Comment';

                trigger OnAction()
                var
                    lSalesTextManagement: Codeunit "Sales Text Management";
                begin

                    //+REF+ADDTEXT
                    lSalesTextManagement.CommentText(Rec, 2);
                    //+REF+ADDTEXT//
                end;
            }
            action("Hde/Show Structure")
            {

                ApplicationArea = all;
                Caption = 'Hde/Show Structure';

                trigger OnAction()
                begin

                    wMarked := NOT wMarked;
                    //DYS a verifier
                    //  CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                end;
            }
            action("Hde/Show Extended Text")
            {


                ApplicationArea = all;
                Caption = 'Hde/Show Extended Text';

                trigger OnAction()
                begin

                    ShowExtendedText := NOT ShowExtendedText;
                    //DYS a verifier
                    //CurrPAGE.SalesLines.PAGE.wSetMarked(wMarked, ShowExtendedText);
                end;
            }
            //GL2024 action("Hide/Show Header")
            // {


            // ApplicationArea = all;
            //  Caption = 'Hide/Show Header';

            // trigger OnAction()
            // begin
            //GL2024
            /*IF CurrPAGE.SalesLines.YPOS = CurrPAGE.TabControl.YPOS THEN BEGIN
              CurrPAGE.SalesLines.YPOS := CurrPAGE.TabControl.YPOS + CurrPAGE.TabControl.HEIGHT + CurrPAGE.SalesLines.YPOS;
              CurrPAGE.SalesLines.HEIGHT := CurrPAGE.SalesLines.HEIGHT - CurrPAGE.SalesLines.YPOS;
            END ELSE BEGIN
              CurrPAGE.SalesLines.HEIGHT := CurrPAGE.SalesLines.HEIGHT + CurrPAGE.SalesLines.YPOS;
              CurrPAGE.SalesLines.YPOS := CurrPAGE.TabControl.YPOS;
            END;     */

            // end;
            //  }
            /*GL2024  action("Move left")
          {


                ApplicationArea = all;
                Caption = 'Move left';
                trigger OnAction()
                begin
                    //DYS a verifier
                    // CurrPAGE.SalesLines.PAGE.Move(MoveOption::Left);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Move Right")
            {

                ApplicationArea = all;
                Caption = 'Move Right';
                trigger OnAction()
                begin
                    //DYS a verifier
                    //CurrPAGE.SalesLines.PAGE.Move(MoveOption::Right);
                    CurrPage.UPDATE(FALSE);
                end;
            }*/
            action("&Workflow")
            {
                Enabled = WorkFlowBtnENABLED;
                Caption = 'Wor&Kflow';
                ApplicationArea = all;
                trigger OnAction()
                var
                    lRecordRef: RecordRef;
                    lWorkflowConnector: Codeunit "Workflow Connector";
                begin

                    lRecordRef.GETTABLE(Rec);
                    lWorkflowConnector.OnPush(PAGE::"Sales Quote", lRecordRef);
                end;
            }

        }
        addafter(Print_Promoted)
        {
            actionref("Print22"; Print2)
            {

            }

        }
        addafter(Category_Category10)
        {



            actionref("Validate the offer1"; "Validate the offer")
            {

            }
            actionref("Re&open1"; "Re&open")
            {

            }
            actionref(Actualiser1; Actualiser)
            {

            }

            actionref(Comment11; Comment1)
            {

            }

        }

    }




















    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin
        /* GL2024 SourceTableView=SORTING(Order Type,Document Type,No.)
                           WHERE(Document Type=CONST(Quote),
                                 Order Type=CONST(" "));*/

        Rec.FilterGroup(0);
        rec.SetCurrentKey("Order Type", "Document Type", "No.");
        Rec.SetRange("Document Type", rec."Document Type"::Quote);
        Rec.SetRange("Order Type", rec."Order Type"::" ");
        Rec.FilterGroup(2);
        //MASK




        wSplashOpened := TRUE;
        wOpenSplash.OPEN(tOpenSplash);
        //wFormEditable := CurrForm.EDITABLE;
        wFormEditable := TRUE;

        //IF "DA Approbé" = TRUE THEN CurrForm.SalesLines.FORM.EDITABLE(FALSE)
        //   ELSE CurrForm.SalesLines.FORM.EDITABLE(TRUE) ;
        //+ONE+
        IF wSplashOpened THEN BEGIN
            wSplashOpened := FALSE;
            wOpenSplash.CLOSE;
            WorkFlowBtnENABLED := TRUE;
            HelpENABLED := TRUE;
            SellToCommentBtnENABLED := TRUE;
            BillToCommentBtnENABLED := TRUE;
            SalesCommentBtnENABLED := TRUE;
        END;
        //+ONE+//
        //Inutile ? et empêche le lien livraison directe : SETRANGE("No."); (Cf. OnFindRecord)

        //+ONE+
        NavibatSetup.GET2;

        ShowExtendedText := TRUE;
        //+ONE+//
        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
    end;

    trigger OnAfterGetRecord()
    begin

        // IF rec."DA Approbé" = TRUE THEN
        //     SalesLinesFORMEDITABLE := FALSE
        // ELSE
        //     SalesLinesFORMEDITABLE := TRUE;

        //DYS a verifier
        //CurrPage.SalesLines.page.wPassEnt(Rec);
        IF rec."No." <> xRec."No." THEN BEGIN
            wMarked := FALSE;
            //  ShowExtendedText := TRUE;
            //DYS a verifier
            // Currpage.SalesLines.page.SetAfterGet(PresentationCode);
        END;

        IF (rec."Sell-to Contact No." <> '') AND Contact.GET(rec."Sell-to Contact No.") THEN BEGIN
            IF Contact."Salutation Code" <> '' THEN
                ContactName := Contact.GetSalutation(1, rec."Language Code")
            ELSE
                ContactName := COPYSTR(Contact.Name + ' ' + Contact."First Name", 1, MAXSTRLEN(ContactName));
        END ELSE
            ContactName := '';
        IF (rec."Project Manager" <> '') AND Contact.GET(rec."Project Manager") THEN
            ProjectManagerName := Contact.Name
        ELSE
            ProjectManagerName := '';

        //PROJET_FACT
        IF rec."Rider to Order No." <> '' THEN
            ActivateHeader(FALSE)
        ELSE BEGIN
            ActivateHeader(TRUE);
            //PROJET_FACT//
            IF rec."Job No." <> '' THEN BEGIN
                "Job Starting DateEDITABLE" := FALSE;
                "Job Ending DateEDITABLE" := FALSE;
            END
            ELSE BEGIN
                "Job Starting DateEDITABLE" := TRUE;
                "Job Ending DateEDITABLE" := TRUE;
            END;
            //PROJET_FACT
        END;
        //PROJET_FACT//
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        rec."Order Type" := rec."Order Type"::" ";
        ContactName := '';
        ProjectManagerName := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //DYS a verifier
        //  CurrPAGE.SalesLines.PAGE.wPassEnt(Rec);
        //CurrPAGE.SalesLines.PAGE.SetAfterGet(PresentationCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
    end;

    PROCEDURE ActivateHeader(Active: Boolean);
    BEGIN
        "Sell-to Customer No.EDITABLE" := Active;
        "Sell-to Customer NameEDITABLE" := Active;
        //CurrForm."Salesperson CodeEDITABLE":=Active;
        //CurrForm."Sell-to Contact No.EDITABLE":=Active;
        //CurrForm.Subject.EDITABLE:=Active;
        "Ship-to CodeEDITABLE" := Active;
        "Job No.EDITABLE" := Active;
        "Ship-to NameEDITABLE" := Active;
        "Job Starting DateEDITABLE" := Active;
        "Job Ending DateEDITABLE" := Active;
        "Job DescriptionEDITABLE" := Active;
        "Project ManagerEDITABLE" := Active;
        "Prices Including VATEDITABLE" := Active;
        "Currency CodeEDITABLE" := Active;
        "Payment Method CodeEDITABLE" := Active;
        "Payment Terms CodeEDITABLE" := Active;
        //CurrForm."Bill-to Contact No.EDITABLE":=Active;
        "Bill-to Customer No.EDITABLE" := Active;
        "Bill-to NameEDITABLE" := Active;
        "Bill-to Customer Template CodeEDITABLE" := Active;
        "VAT Bus. Posting GroupEDITABLE" := Active;
        //#5134"Part PaymentEDITABLE":=Active;
        "Contract TypeEDITABLE" := Active;
        "Review Formula CodeEDITABLE" := Active;
        "Review Base DateEDITABLE" := Active;

        //CurrForm.Application.EDITABLE(Active);
        //CurrForm."Revision % Submitted".EDITABLE(Active);
        /*{
        //CurrForm."Deadline Code".EDITABLE(Active);
        CurrForm."Deadline Date".EDITABLE(Active);
                //CurrForm."Shortcut Dimension 1 Code".EDITABLE(Active);
                //CurrForm."Shortcut Dimension 2 Code".EDITABLE(Active);
                CurrForm."Responsibility Center".EDITABLE(Active);
                //CurrForm."Location Code".EDITABLE(Active);
                CurrForm."Person Responsible".EDITABLE(Active);
                CurrForm."Person Responsible 2".EDITABLE(Active);
                CurrForm."Person Responsible 3".EDITABLE(Active);
                CurrForm."Person Responsible 4".EDITABLE(Active);
                CurrForm."Person Responsible 5".EDITABLE(Active);
                //CurrForm."Progress Degree".EDITABLE(Active);
                //CurrForm."Opportunity No.".EDITABLE(Active);
                //CurrForm."Campaign No.".EDITABLE(Active);
                //CurrForm."Your Reference".EDITABLE(Active);
                CurrForm."Free Field 1".EDITABLE(Active);
                CurrForm."Free Field 2".EDITABLE(Active);
                CurrForm."Free Field 3".EDITABLE(Active);
                CurrForm."Free Field 4".EDITABLE(Active);
                CurrForm."Free Field 5".EDITABLE(Active);
                CurrForm."Free Field 6".EDITABLE(Active);
                CurrForm."Free Field 7".EDITABLE(Active);
                CurrForm."Free Field 8".EDITABLE(Active);
                CurrForm."Free Field 9".EDITABLE(Active);
                CurrForm."Free Field 10".EDITABLE(Active);
                CurrForm."Free Date 1".EDITABLE(Active);
                CurrForm."Free Date 2".EDITABLE(Active);
                CurrForm."Free Date 3".EDITABLE(Active);
                CurrForm."Free Date 4".EDITABLE(Active);
                CurrForm."Free Date 5".EDITABLE(Active);
                CurrForm."Free Date 6".EDITABLE(Active);
                CurrForm."Free Date 7".EDITABLE(Active);
                CurrForm."Free Date 8".EDITABLE(Active);
                CurrForm."Free Date 9".EDITABLE(Active);
                CurrForm."Free Date 10".EDITABLE(Active);
                CurrForm."Free Value 2".EDITABLE(Active);
                CurrForm."Free Value 1".EDITABLE(Active);
                CurrForm."Free Value 3".EDITABLE(Active);
                CurrForm."Free Value 4".EDITABLE(Active);
                CurrForm."Free Value 5".EDITABLE(Active);
                CurrForm."Free Boolean 2".EDITABLE(Active);
                CurrForm."Free Boolean 1".EDITABLE(Active);
                CurrForm."Free Boolean 3".EDITABLE(Active);
                CurrForm."Free Boolean 4".EDITABLE(Active);
                CurrForm."Free Boolean 5".EDITABLE(Active);
                CurrForm."Criteria 1".EDITABLE(Active);
                CurrForm."Criteria 2".EDITABLE(Active);
                CurrForm."Criteria 3".EDITABLE(Active);
                CurrForm."Criteria 4".EDITABLE(Active);
                CurrForm."Criteria 5".EDITABLE(Active);
                CurrForm."Criteria 6".EDITABLE(Active);
                CurrForm."Criteria 7".EDITABLE(Active);
                CurrForm."Criteria 8".EDITABLE(Active);
                CurrForm."Criteria 9".EDITABLE(Active);
                CurrForm."Criteria 10".EDITABLE(Active);
        }*/
    END;

    PROCEDURE ActivateFields();
    BEGIN
        // CurrForm."Bill-to Customer Template Code".ENABLED("Bill-to Customer No." = '');
        // CurrForm."Sell-to Customer Template Code".ENABLED("Sell-to Customer No." = '');
        // CurrForm."Sell-to Customer No.".ENABLED("Sell-to Customer Template Code" = '');
        // CurrForm."Bill-to Customer No.".ENABLED("Bill-to Customer Template Code" = '');
    END;

    PROCEDURE UpdateUMIM();
    begin

        // >> HJ SORO 12-08-2014

        SalesLine4.SETRANGE("Document Type", rec."Document Type");
        SalesLine4.SETRANGE("Document No.", rec."No.");
        SalesLine4.SETFILTER("Line Type", '%1', SalesLine3."Line Type"::Structure);
        SalesLine4.SETRANGE("Structure Line No.", 0);
        IF SalesLine4.FINDFIRST THEN
            REPEAT
                VMO := 0;
                VFournitures := 0;
                VFournituresEtDivers := 0;
                VMOConducteur := 0;
                VMateriel := 0;
                VLubrifiant := 0;
                VConsommation := 0;
                VLubrifiantPetitEntret := 0;
                VUM := 0;
                VIM := 0;
                VDivers := 0;
                VSoustraitance := 0;
                SalesLine3.SETRANGE("Document Type", rec."Document Type");
                SalesLine3.SETRANGE("Document No.", rec."No.");
                SalesLine3.SETFILTER(Type, '%1|%2', SalesLine3.Type::Resource, SalesLine3.Type::Item);
                SalesLine3.SETRANGE("Structure Line No.", SalesLine4."Line No.");
                IF SalesLine3.FINDFIRST THEN
                    REPEAT

                        IF SalesLine3."Line Type" = SalesLine3."Line Type"::Item THEN BEGIN
                            IF RecItem.GET(SalesLine3."No.") THEN BEGIN
                                IF RecItem."Type Lié Ouvrage" = 0 THEN BEGIN
                                    // Item
                                    IF SalesLine3.Rate <> 0 THEN BEGIN
                                        SalesLine3."Fourniture Detail" := SalesLine3."Unit Cost" * SalesLine3."Rate Quantity" * SalesLine3.Rate;
                                        //SalesLine3.VALIDATE("Quantity per","Rate Quantity"*SalesLine3.Rate);
                                    END;
                                    VFournitures += SalesLine3."Fourniture Detail";
                                END;
                                IF RecItem."Type Lié Ouvrage" = 1 THEN BEGIN
                                    // DIVERS
                                    SalesLine3."Divers Detail" := SalesLine3."Unit Cost";       // Divers
                                    VDivers += SalesLine3."Divers Detail";
                                END;
                                IF RecItem."Type Lié Ouvrage" = 2 THEN BEGIN
                                    //Transport
                                    SalesLine3."Transport Detail" := SalesLine3."Unit Cost";
                                    VTransport += SalesLine3."Transport Detail";
                                END;
                                IF RecItem."Type Lié Ouvrage" = 3 THEN BEGIN
                                    // Sous Traitance
                                    SalesLine3."Sous Traitance Detail" := SalesLine3."Unit Cost";
                                    VSoustraitance += SalesLine3."Sous Traitance Detail";
                                END;
                            END;
                        END;
                        IF SalesLine3."Line Type" = SalesLine3."Line Type"::Person THEN BEGIN
                            //VMO+=SalesLine3."Total Cost (LCY)";
                            IF SalesLine3.Rate <> 0 THEN
                                SalesLine3."Main Oeuvre Detail" := SalesLine3."Unit Cost" * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                            VMO += SalesLine3."Main Oeuvre Detail";
                        END;

                        IF SalesLine3."Line Type" = SalesLine3."Line Type"::Machine THEN BEGIN
                            IF Resource.GET(SalesLine3."No.") THEN BEGIN
                                IF SalesLine3.Rate <> 0 THEN BEGIN
                                    SalesLine3."Materiel Detail" := (Resource."UM Cout Direct" + Resource."IM Cout Direct" +
                                    Resource."Lubrifiant Pt Entre Cout Direc") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    VUM += (Resource."UM Cout Direct") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    VIM += (Resource."IM Cout Direct") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    SalesLine3."Lubrifiants Petit Entre Detail" := Resource."Lubrifiant Pt Entre Cout Direc"
                                                                                * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    ;
                                END;
                                VMateriel += SalesLine3."Materiel Detail";
                                VLubrifiant += SalesLine3."Lubrifiants Petit Entre Detail";
                                IF SalesLine3.Rate <> 0 THEN
                                    SalesLine3."Main Oeuvre Materiel Detail" := (Resource."Cout MO Materielle Direct" *
                                    SalesLine3."Rate Quantity") / SalesLine3.Rate;

                                VMO += SalesLine3."Main Oeuvre Materiel Detail";
                                IF SalesLine3.Rate <> 0 THEN
                                    SalesLine3."Consommation Detail" := Resource."Cout Consommation Direct" * SalesLine3."Rate Quantity" / SalesLine3.Rate;

                                VConsommation += SalesLine3."Consommation Detail";
                            END;
                        END;
                        SalesLine3."Fourniture Et Divers Detail" := SalesLine3."Consommation Detail" + SalesLine3."Fourniture Detail" +
                        SalesLine4."Transport Detail" + SalesLine3."Sous Traitance Detail" + SalesLine3."Divers Detail";
                        SalesLine3.MODIFY;
                    UNTIL SalesLine3.NEXT = 0;

                SalesLine4.Materiel := VMateriel;
                VFournituresEtDivers := VConsommation + VTransport + VSoustraitance + VDivers;
                SalesLine4."Main Oeuvre" := VMO;
                SalesLine4.UM := VUM;
                SalesLine4.IM := VIM;
                SalesLine4."Lubrifiants Petit Entretient" := VLubrifiant;
                SalesLine4.Consommation := VConsommation;
                SalesLine4.Transport := VTransport;
                SalesLine4."Sous Traitance" := VSoustraitance;
                SalesLine4.Divers := VDivers;
                SalesLine4.Fournitures := VFournitures;
                SalesLine4."Fourniture Et Divers" := VFournituresEtDivers;
                SalesLine4.MODIFY;

            UNTIL SalesLine4.NEXT = 0;
        // >> HJ SORO 12-08-2014
    end;

    var
        //DYS page addon non migrer
        //AddressContributors: Page 8004022;
        MoveOption: Option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ContactName: Text[250];
        ProjectManagerName: Text[50];
        NavibatSetup: Record NavibatSetup;
        Fenetre: Dialog;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        wFormEditable: Boolean;
        wEditable: Boolean;
        gSalesLine: Record "Sales Line";
        "// HJ": Integer;
        StructureMgt: Codeunit "Structure Management";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        NaviBat: Record NavibatSetup;
        Coef: Decimal;
        Compteur: Integer;
        Item: Record Item;
        Resource: Record Resource;
        "// Var HJ DSFT": Integer;
        RecItem: Record Item;
        Ressource: Record Resource;
        SalesLine4: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        UM: Decimal;
        IM: Decimal;
        VConsommation: Decimal;
        VTransport: Decimal;
        VDivers: Decimal;
        VSoustraitance: Decimal;
        VFournitures: Decimal;
        VFournituresEtDivers: Decimal;
        VMO: Decimal;
        VMOConducteur: Decimal;
        VLubrifiantPetitEntret: Decimal;
        VMateriel: Decimal;
        V1: Decimal;
        V2: Decimal;
        V3: Decimal;
        V4: Decimal;
        V5: Decimal;
        VUM: Decimal;
        VIM: Decimal;
        SalesLineRate: Record "Sales Line";
        VLubrifiant: Decimal;
        RecItem2: Record Item;
        Ligne: Integer;
        UserSetup: Record "User Setup";
        RecSalesHeader: Record "Sales Header";
        Line: Record "Sales Line";
        Contact: Record Contact;
        ArchiveManagement: Codeunit ArchiveManagementEvent;
        tArchiverDoc: Label 'Do you vant to archive the quote?';
        tOpenSplash: Label 'Open In Progress...';
        tArchDone: Label 'The quote archived is done.';
        tSellToCust: Label 'Sell-to Customer';
        tBillToCust: Label 'Bill-to Customer';
        Text001: Label 'Processing completed';
        Text002: Label 'You are no longer an approver!!';
        Text003: Label 'Price offer approved successfully!!';
        Text004: Label 'Offer already approved!!';

        "Review Base DateEDITABLE": Boolean;
        "Sell-to Customer NameEDITABLE": Boolean;
        "Job No.EDITABLE": Boolean;
        "Job Starting DateEDITABLE": Boolean;
        "Job Ending DateEDITABLE": Boolean;
        "Job DescriptionEDITABLE": Boolean;
        "Project ManagerEDITABLE": Boolean;
        "Bill-to Customer No.EDITABLE": Boolean;
        "Bill-to NameEDITABLE": Boolean;
        "Bill-to Customer Template CodeEDITABLE": Boolean;
        "Contract TypeEDITABLE": Boolean;
        "Review Formula CodeEDITABLE": Boolean;
        "Sell-to Customer No.EDITABLE": Boolean;

        "VAT Bus. Posting GroupEDITABLE": Boolean;

        "Payment Terms CodeEDITABLE": Boolean;

        "Payment Method CodeEDITABLE": Boolean;
        "Ship-to CodeEDITABLE": Boolean;

        "Ship-to NameEDITABLE": Boolean;

        "Prices Including VATEDITABLE": Boolean;
        "Currency CodeEDITABLE": Boolean;

        WorkFlowBtnENABLED: Boolean;
        SalesCommentBtnENABLED: Boolean;
        ///
        SalesLinesFORMEDITABLE: boolean;
        HelpENABLED: Boolean;

        SellToCommentBtnENABLED: Boolean;
        BillToCommentBtnENABLED: Boolean;





}



