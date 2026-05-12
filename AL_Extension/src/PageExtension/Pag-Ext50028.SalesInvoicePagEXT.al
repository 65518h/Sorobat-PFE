PageExtension 50028 "Sales Invoice_PagEXT" extends "Sales Invoice"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addafter("Foreign Trade")
        {
            field("Code présentation"; PresentationCode)
            {
                Caption = 'Presentation Code';
                TableRelation = "Sales Line View";

                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //DYS a verifier
                    //CurrPAGE.SalesLines.PAGE.ShowColumns(PresentationCode);
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
            field("Job No."; Rec."Job No.")
            {
                Caption = 'N° Affaire';

                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //#6653
                    CurrPage.UPDATE(TRUE);
                    //#6653//
                end;
            }

        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                rec.VALIDATE("Shipment Date", 0D);

            end;
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
                caption = 'Avenant à la Cde N°';
                //HS 

                //HS
            }
            field("Posting Description1"; Rec."Posting Description")
            {
                ApplicationArea = all;
            }

        }
        modify("Ship-to Name")
        {
            trigger OnAssistEdit()
            begin
                //#7397
                OpenAssisEdit(2);
                //#7397//
            end;
        }
        addafter("Ship-to Name")
        {
            field("Job Description"; Rec."Job Description")
            {
                ApplicationArea = all;
                Caption = 'Désignation affaire';
            }
            field("Project Manager"; Rec."Project Manager")
            {
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
            field(ProjectManagerName; ProjectManagerName)
            {
                ApplicationArea = all;
                Caption = 'Nom du maître d''oeuvre';
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

            field("Job Starting Date"; Rec."Job Starting Date")
            {
                Editable = "Job Starting DateEDITABLE";
                ApplicationArea = all;
            }
            field("Job Ending Date"; Rec."Job Ending Date")
            {
                Editable = "Job Ending DateEDITABLE";
                ApplicationArea = all;
            }

            field("No. Prepayment Invoiced"; Rec."No. Prepayment Invoiced")
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

        addbefore("Bill-to Contact No.")
        {
            field("Contract Type"; Rec."Contract Type")
            {

                ApplicationArea = all;
            }
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {

                ApplicationArea = all;
            }
        }
        addafter("Bill-to Name")
        {
            field(Descr; wDescr)
            {

                Caption = 'Libellé écriture';
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
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
            field("Apply Stamp fiscal"; Rec."Apply Stamp fiscal")
            {
                ApplicationArea = all;
                Caption = 'Appliquer Timbre Fiscal';
            }
            field("N° timbre Fiscal"; Rec."N° timbre Fiscal")
            {
                ApplicationArea = all;
                Caption = 'N° timbre Fiscal';
            }
            field("N° Sticker Fiscal"; Rec."N° Sticker Fiscal")
            {
                ApplicationArea = all;
                Caption = 'N° Sticker Fiscal';
            }
            field("Part Payment"; Rec."Part Payment")
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
        addafter("Responsibility Center")
        {
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
            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("Shipping No."; Rec."Shipping No.")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }

        addafter(Status)
        {
            field("Progress Degree"; Rec."Progress Degree")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = all;
                Visible = false;
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
        //HS
        addfirst(navigation)
        {
            action("AppliquerFodec")
            {
                ApplicationArea = all;
                Caption = 'Appliquer Fodec';
                Visible = false;
                // Promoted = true;
                // PromotedIsBig = true;
                // PromotedCategory = Process; 
                Ellipsis = true;
                Image = Apply;
                trigger OnAction()
                var
                    CduSalesPost: Codeunit SalesPostEvent;
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin

                    // CduSalesPost.CalcTimbre(Rec);
                    //  CduSalesPost.CalcFodec(Rec);
                end;
            }
        }
        //HS
        addafter(Category_Category10)
        {
            /*    actionref("AppliquerFodecAction"; "AppliquerFodec")
                {

                }*/
        }
        addafter(Function_CustomerCard)
        {
            action("C&ontact Card")
            {
                Caption = 'Fiche c&ontact';
                ApplicationArea = all;
                RunObject = Page "Contact Card";
                RunPageLink = "No." = FIELD("Sell-to Contact No.");
            }
        }
        addafter(Statistics_Promoted)
        {
            actionref("C&ontact Card1"; "C&ontact Card")
            {

            }
        }

        addafter(Approvals)
        {
            /* GL2024  action("Statistics Criteria")
               {

                   Caption = 'Statistics Criteria';
                   ApplicationArea = all;
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

                   Caption = 'Additionnals Informations';
                   ApplicationArea = all;
                   trigger OnAction()
                   var
                       lSalesHeader: Record "Sales Header";
                   //DYS page addon non migrer
                   // lFormAddInfo: Page 8005126;
                   begin

                       lSalesHeader := Rec;
                       // lFormAddInfo.SETRECORD(lSalesHeader);
                       // lFormAddInfo.RUNMODAL;
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
            /* GL2024    action("Contacts and addresses")
              {
                  Caption = 'Contacts and addresses';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004022;
                  // RunPageLink = "Document Type" = FIELD("Document Type"),
                  //                   "No." = FIELD("No.");
              }
         action("Job Sales Documents")
              {
                  Caption = 'Job Sales Documents';
                  ApplicationArea = all;
                  //DYS page addon non migrer
                  // RunObject = Page 8004056;
                  // RunPageLink = "Job No." = FIELD("Job No.");
                  // RunPageView = SORTING("Job No.")
                  //                   WHERE("Job No." = FILTER(<> ''),
                  //                         Order Type=CONST(" "));
              }*/
            action(Folder)
            {
                Caption = 'Dossier';
                Visible = false;
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
                Caption = 'E&tats';
                Visible = false;
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
                Caption = 'Métré :Variables du document';
                Visible = false;
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
            /*    GL2024   action("Footer Document")
               {
                   Caption = 'Footer Document';
                   ApplicationArea = all;


                   trigger OnAction()
                   var
                       lSalesLine: Record "Sales Line";
                   begin

                       //#7628
                       //lSalesLine.SETRANGE("Document Type","Document Type");
                       //lSalesLine.SETRANGE("Document No.","No.");
                       //PAGE.RUNMODAL(PAGE::"Quote Footer",lSalesLine);
                       //#7628//
                   end;
               }*/
        }
        modify(Release)
        {
            trigger OnAfterAction()
            var

                //  CduSalesPost: Codeunit "Sales-Post";

                CduSalesPost: Codeunit SalesPostEvent;
            begin
                //DYS a verifier
                //Currpage.SalesLines.page.wSetMarked(wMarked, ShowExtendedText);

                //    CduSalesPost.CalcBIC(Rec);
            end;
        }
        addafter(Approvals_Promoted)
        {
            actionref("&Reports1"; "&Reports")
            {

            }
            actionref("Folder1"; Folder)
            {

            }
            actionref("MDescription1"; Description)
            {

            }
            actionref("Measurement : Document var1"; "Measurement : Document var")
            {

            }
        }

        modify(CopyDocument)
        {
            trigger OnafterAction()
            begin
                //DYS a verifier
                //Currpage.SalesLines.page.wSetMarked(wMarked, ShowExtendedText);
            end;
        }

        addafter("Move Negative Lines")
        {
            action("E&xplode BOM")
            {
                Caption = 'E&xplode BOM';
                Visible = false;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CurrPage.SalesLines.PAGE.ExplodeBOM;
                end;
            }
        }
        addafter("Move Negative Lines_Promoted")
        {
            actionref("E&xplode BOM1"; "E&xplode BOM")
            {

            }
        }

        addafter(RemoveIncomingDoc)
        {
            action(Recap)
            {
                Caption = 'Recap';
                ShortCutKey = 'Ctrl+F7';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                var
                    LSalesLine: Record "Sales Line";
                    // LRegroupementArticle: Record "Regroupent Article";
                    LArticle: Code[20];
                    LQte: Decimal;
                    LNombre: Integer;
                begin

                    // >> HJ SORO 29-06-2015
                    /*  LRegroupementArticle.DELETEALL;
                      LSalesLine.SETCURRENTKEY("No.");
                      LSalesLine.SETRANGE("Document Type", rec."Document Type");
                      LSalesLine.SETRANGE("Document No.", rec."No.");
                      LSalesLine.SETRANGE(Type, LSalesLine.Type::Item);
                      IF LSalesLine.FINDFIRST THEN
                          REPEAT
                              IF LArticle <> LSalesLine."No." THEN BEGIN
                                  LQte := 0;
                                  LNombre := 1;
                                  LArticle := LSalesLine."No.";
                                  LRegroupementArticle."N° Document" := rec."No.";
                                  LRegroupementArticle.Article := LSalesLine."No.";
                                  LRegroupementArticle.Designation := LSalesLine.Description;
                                  LRegroupementArticle.Quantité := LSalesLine.Quantity;
                                  LQte := LSalesLine.Quantity;
                                  LNombre := 1;
                                  LRegroupementArticle.Nombre := LNombre;
                                  LRegroupementArticle.INSERT;
                              END
                              ELSE BEGIN
                                  IF LRegroupementArticle.GET(rec."No.", LSalesLine."No.") THEN BEGIN
                                      LNombre += 1;
                                      LQte += LSalesLine.Quantity;
                                      LRegroupementArticle.Quantité := LQte;
                                      LRegroupementArticle.Nombre := LNombre;
                                      LRegroupementArticle.MODIFY;
                                  END;
                              END;
                          UNTIL LSalesLine.NEXT = 0;
                      COMMIT;
                      PAGE.RUNMODAL(PAGE::"Regroupement Article");
                      // >> HJ SORO 29-06-2015*/
                end;
            }
        }
        addafter(RemoveIncomingDoc_Promoted)
        {
            /*    actionref(Recap1; Recap)
                {

                }*/
        }

        addafter("F&unctions")
        {
            group("&Line")
            {
                Caption = '&Ligne';
                /* GL2024       action(Description2)
                    {
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            //DYS a verifier
                            //CurrPAGE.SalesLines.PAGE.ShowDescription;
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
                    action("Move Up")
                    {
                        Caption = 'Move Up';
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            //DYS a verifier
                            // CurrPAGE.SalesLines.PAGE.Move(MoveOption::Up);
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
                            //CurrPAGE.SalesLines.PAGE.ToggleExpandCollapse(FALSE);
                        end;
                    }
                action("Calculer la quantité")
                    {

                        Caption = 'Calculate the quantity';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //DYS a verifier
                            //CurrPAGE.SalesLines.PAGE.wCalculateQty;
                        end;
                    }*/

                action("M.A.J. Lignes")
                {
                    Caption = 'M.A.J. Lignes';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    begin

                        // RB SORO 27/05/2015
                        //HS replaced by fonctionnalité facture vente beton      CduSalespostevent.MAJLignesBeton(Rec);
                        // RB SORO 27/05/2015
                        //HS
                        // RB SORO 27/05/2015
                        //CduSalesPost.MAJLignesBeton(Rec);
                        // RB SORO 27/05/2015


                        // MH SORO 01/04/2021

                        /*  RecLPurchLine1.RESET;
                          RecLPurchLine1.SETRANGE("Document Type", rec."Document Type");
                          RecLPurchLine1.SETRANGE("Document No.", rec."No.");
                          RecLPurchLine1.SETRANGE(RecLPurchLine1.Type, RecLPurchLine1.Type::Item);
                          RecLPurchLine1.SETFILTER("Qty. to Invoice", '>0');

                          IF RecLPurchLine1.FINDFIRST THEN
                              REPEAT
                                  //      RecLPurchLine1."Apply Fodec" := TRUE;
                                  RecLPurchLine1.MODIFY;
                              UNTIL RecLPurchLine1.NEXT = 0;

                          CduSalesPost2.CalcTimbre(Rec);
                          CduSalesPost2.CalcFodec(Rec);

                          CduSalesPost2.CalcTransport(Rec);
                          // MH SORO 01/04/2021

  */
                        //HS
                    end;
                }
            }
        }
        addafter(Category_Category6)
        {
            group("Line")
            {
                Caption = 'Ligne';
                actionref("M.A.J. Lignes1"; "M.A.J. Lignes")
                {

                }
                actionref(Recap1; Recap) { }
            }
        }

        modify(Post)
        {
            trigger OnafterAction()
            begin
                //PROJET_FACT 
                CurrPage.UPDATE(FALSE);
                rec.TestField("N° timbre Fiscal");
                rec.TestField("N° Sticker Fiscal");
                //PROJET_FACT//             
            end;

            trigger OnBeforeAction()
            begin
                //PROJET_FACT 

                rec.TestField("N° timbre Fiscal");
                rec.TestField("N° Sticker Fiscal");
                //PROJET_FACT//             
            end;
        }


        addafter("Test Report")
        {
            action("Print proforma")
            {
                Caption = 'Imprimer pré-facture';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lSalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    //+REF+INVOICE
                    lSalesInvoiceHeader.SETRANGE("Print Document Type", rec."Document Type");
                    lSalesInvoiceHeader.SETRANGE("No.", rec."No.");
                    lSalesInvoiceHeader.PrintRecords(TRUE);
                    //+REF+INVOICE//
                end;
            }
        }
        addafter(ProformaInvoice_Promoted)
        {
            actionref("Print proforma1"; "Print proforma")
            {

            }
        }

        addafter("P&osting")
        {
            action(Comment2)
            {
                Enabled = SalesCommentBtnENABLED;
                Caption = 'Comment';
                ApplicationArea = all;

                RunObject = Page "Sales Comment Sheet";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No."),
                              "Document Line No." = CONST(0);
            }
            /* GL2024    action("WKF")
                {
                    Enabled = WKFENABLED;
                    Caption = '&Workflow';
                    ApplicationArea = all;
                    //DYS page addon non migrer
                    // RunObject = Page 8004213;
                    // RunPageLink = Type = CONST(42),
                    //               "No." = FIELD("No.");
                }
                action("Move left")
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
            /*GL2024      action("Hide/Show Header")
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
            action(Print)
            {

                ApplicationArea = all;
                Caption = 'Imprimer';
                Image = Print;
                trigger OnAction()
                begin

                    // >> HJ DSFT 10-10-2012
                    IF Rec.Status <> rec.Status::Released THEN ERROR(Text003);
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
        addafter(Category_Report)
        {
            actionref(Comment21; Comment2)
            {

            }
            actionref(Print1; Print)
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
            WKFENABLED := (TRUE);
            HelpENABLED := (TRUE);
            SellToCommentBtnENABLED := (TRUE);
            BillToCommentBtnENABLED := (TRUE);
            SalesCommentBtnENABLED := (TRUE);
        END;
        //SPLASH//



        IF NavibatSetup.GET2 THEN;

        ShowExtendedText := TRUE;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
    end;

    trigger OnAfterGetRecord()
    begin

        rec.SETRANGE("Document Type");
        //NAVIBAT
        //DYS A verifier
        //  Currpage.SalesLines.Page.wPassEnt(Rec);
        IF rec."No." <> xRec."No." THEN BEGIN
            wMarked := FALSE;
            //DYS A verifier
            // Currpage.SalesLines.Page.SetAfterGet(PresentationCode);
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
        //NAVIBAT
        rec."Order Type" := rec."Order Type"::" ";
        rec."Document Type" := rec."Document Type"::Invoice;
        ProjectManagerName := '';
        ContactName := '';
        //NAVIBAT//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //DYS A verifier
        // Currpage.SalesLines.Page.wPassEnt(Rec);
        // Currpage.SalesLines.Page.SetAfterGet(PresentationCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Currpage.UPDATE(TRUE);
    end;

    PROCEDURE OpenAssisEdit(pValue: Integer);
    BEGIN

        //#7397
        Currpage.SAVERECORD;
        COMMIT;
        //#7397//
        //DYS
        // CLEAR(AddressContributors);
        // AddressContributors.InitRequest(pValue);
        // AddressContributors.SETTABLEVIEW(Rec);
        // AddressContributors.SETRECORD(Rec);
        // AddressContributors.RUNMODAL;
        //AddressContributors.GETRECORD(Rec);
        Currpage.UPDATE;
    END;

    PROCEDURE fGetShipmentLine();
    BEGIN

        //RTC - 2009
        Currpage.SalesLines.Page.GetShipment;
        //DEVIS
        //DYS A verifier
        //  Currpage.SalesLines.Page.wSetMarked(wMarked, ShowExtendedText);
        //DEVIS//
        //RTC - 2009//
    END;

    var
        Contact: Record Contact;
        //DYS page addon non migrer
        // AddressContributors: Page 8004022;
        SalesHeaderArchive: Record "Sales Header Archive";
        MoveOption: Option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ProjectManagerName: Text[30];
        ContactName: Text[250];
        SupplyOrderMgt: Codeunit "Reordering Req. Management";
        RecLPurchLine1: Record "Sales Line";
        CduSalesPost2: Codeunit SalesPostEvent;
        wDescr: Text[100];
        NavibatSetup: Record NavibatSetup;
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        "// Ver HJ DSFT": Integer;
        RecSalesHeader: Record "Sales Header";
        // CduSalesPost: Codeunit 80;
        CduSalespostevent: Codeunit SalesPostEvent;
        TextUpdate: Label 'Calcul en cours...';
        tOpenSplash: Label 'Ouverture en cours...';
        Text003: Label 'Veuillez Lancer Avant Impression';
        lMaskMgt: Codeunit "Mask Management";

        //GL2024
        "Job Starting DateEDITABLE": Boolean;
        "Job Ending DateEDITABLE": Boolean;

        WKFENABLED: Boolean;
        HelpENABLED: Boolean;
        SellToCommentBtnENABLED: Boolean;
        BillToCommentBtnENABLED: Boolean;
        SalesCommentBtnENABLED: Boolean;


}

