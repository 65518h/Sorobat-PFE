page 50421 "Liste Facture vente Beton"
{
    // //TRS-2009 XPE 05/10/09
    // //DELETE-RTC2009
    //                         Suppr. des champs sur formulaire
    // //DEVIS GESWAY 20/06/03 Ajout filtres en en-tête et colonnes pour Suivi commercial
    //                12/12/03 Ajout fonction GetListPosition
    //                20/10/06 Ajout lien vers demande d'appro et commande de cession par bouton commande fiche
    // //FOLDER CW 18/03/04 Ajout Document, Dossier
    // //MASK IMA 03/01/06 MaskFilter
    // //POINTAGE MB 19/05/06 Correction fitre sur Job No.

    Caption = 'Liste Facture vente Beton';
    PageType = List;
    SaveValues = true;
    SourceTable = "Sales Header";
    //   CardPageId = "Sales Invoice Beton";
    CardPageId = "Sales Invoice";
    //GL2024
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));
    //GL2024
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            group(Filters1)
            {
                Caption = 'Filters';
                field(SellToFilter; SellToFilter)
                {
                    Caption = 'N° donneur d''ordre';
                    //    OptionCaption = ' ,Quote,Order';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lCustomer: Record 18;
                    begin
                        lCustomer.FIND('-');
                        IF Page.RUNMODAL(Page::"Customer List", lCustomer) = ACTION::LookupOK THEN
                            IF SellToFilter = '' THEN
                                SellToFilter := STRSUBSTNO('%1', lCustomer."No.")
                            ELSE
                                SellToFilter += STRSUBSTNO('|%1', lCustomer."No.");
                        Filters;
                        //#8937
                        CurrPage.UPDATE(FALSE);
                        //#8937//
                    end;

                    trigger OnValidate()
                    begin
                        SellToFilterOnAfterValidate;
                    end;
                }
                field(DocumentType; DocumentTypeFilter)
                {
                    Caption = 'Type Document';
                    OptionCaption = ' ,Devis,Commande,Facture,Avoir';
                    Visible = DocumentTypeVisible;

                    trigger OnValidate()
                    begin
                        Filters;
                        DocumentTypeFilterOnAfterValid;
                    end;
                }
                field(SalesPersonFilter; SalesPersonFilter)
                {
                    Caption = 'Code vendeur';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lSalesperson: Record 13;


                    begin
                        lSalesperson.FIND('-');
                        IF Page.RUNMODAL(Page::"Salespersons/Purchasers", lSalesperson) = ACTION::LookupOK THEN
                            IF SalesPersonFilter = '' THEN
                                SalesPersonFilter := STRSUBSTNO('%1', lSalesperson.Code)
                            ELSE
                                SalesPersonFilter += STRSUBSTNO('|%1', lSalesperson.Code);
                        Filters;
                    end;

                    trigger OnValidate()
                    begin
                        Filters;
                        SalesPersonFilterOnAfterValida;
                    end;
                }
                field(JobFilter; JobFilter)
                {
                    Caption = 'N° affaire';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lJob: Record job;
                    begin
                        lJob.FIND('-');
                        /*GL2024  IF Page.RUNMODAL(Page::"Job List2", lJob) = ACTION::LookupOK THEN
                              IF JobFilter = '' THEN
                                  JobFilter := STRSUBSTNO('%1', lJob."No.")
                              ELSE
                                  JobFilter += STRSUBSTNO('|%1', lJob."No.");
                          Filters;*/
                    end;

                    trigger OnValidate()
                    begin
                        Filters;
                        JobFilterOnAfterValidate;
                    end;
                }
            }
            repeater(repeater1)
            {
                Editable = false;
                ShowCaption = false;
                field("Document Type"; Rec."Document Type")
                {
                    OptionCaption = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour,,,,,,Abonnement';

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Order Date"; Rec."Order Date")
                {

                }
                field("No."; rec."No.")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'N° BL';
                }

                field("Job No."; rec."Job No.")
                {
                }
                // field("Formule Beton"; Rec."Formule Beton")
                // {

                // }
                field("Last Shipping No."; Rec."Last Shipping No.")
                {

                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    Caption = 'N° Client';
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    Caption = 'Nom du Client';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Code utilisateur';
                }
                field("Requester ID"; Rec."Requester ID")
                {

                }
                field(Service; Rec.Service)
                {

                }
                field(Subject; rec.Subject)
                {
                    Style = Attention;
                    StyleExpr = true;


                    trigger OnAssistEdit()
                    var
                        lDescription: Record 8004075;
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                field(Status; Rec.Status)
                {
                    StyleExpr = true;
                    Style = Attention;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {

                }
                field("Description Engin"; Rec."Description Engin")
                {
                    Caption = 'Engin';
                }
                field("Job Description"; Rec."Job Description")
                {

                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Caption = 'Ville affaire';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {

                }
                field("Amount Excl. VAT (LCY)"; rec."Amount Excl. VAT (LCY)")
                {
                    AutoFormatType = 1;
                }
                field("Deadline Date"; Rec."Deadline Date")
                {
                    Caption = 'Date de validité';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {

                }

                field("Rider to Order No."; rec."Rider to Order No.")
                {
                    Visible = false;
                }
                field(Finished; rec.Finished)
                {
                    Visible = false;
                }
                field("Quote No."; rec."Quote No.")
                {
                    Visible = false;
                }



                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; rec."Sell-to Contact")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; rec."Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to City"; rec."Bill-to City")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; rec."Bill-to Contact")
                {
                    Visible = false;
                }
                field("Project Manager"; rec."Project Manager")
                {
                    Visible = false;
                }


                field("Ship-to Code"; rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    Visible = false;
                }

                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    Visible = false;
                }

                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    Visible = false;
                }


                field("Person Responsible"; rec."Person Responsible")
                {
                    Visible = false;
                }
                field("Person Responsible 2"; rec."Person Responsible 2")
                {
                    Visible = false;
                }
                field("Person Responsible 3"; rec."Person Responsible 3")
                {
                    Visible = false;
                }
                field("Person Responsible 4"; rec."Person Responsible 4")
                {
                    Visible = false;
                }
                field("Person Responsible 5"; rec."Person Responsible 5")
                {
                    Visible = false;
                }
                field("Free Date 1"; rec."Free Date 1")
                {
                    Visible = false;
                }
                field("Free Date 2"; rec."Free Date 2")
                {
                    Visible = false;
                }
                field("Free Date 3"; rec."Free Date 3")
                {
                    Visible = false;
                }
                field("Free Date 4"; rec."Free Date 4")
                {
                    Visible = false;
                }
                field("Free Date 5"; rec."Free Date 5")
                {
                    Visible = false;
                }
                field("Free Date 6"; rec."Free Date 6")
                {
                    Visible = false;
                }
                field("Free Date 7"; rec."Free Date 7")
                {
                    Visible = false;
                }
                field("Free Date 8"; rec."Free Date 8")
                {
                    Visible = false;
                }
                field("Free Value 1"; rec."Free Value 1")
                {
                    Visible = false;
                }
                field("Free Value 2"; rec."Free Value 2")
                {
                    Visible = false;
                }
                field("Free Value 3"; rec."Free Value 3")
                {
                    Visible = false;
                }
                field("Free Value 4"; rec."Free Value 4")
                {
                    Visible = false;
                }
                field("Free Value 5"; rec."Free Value 5")
                {
                    Visible = false;
                }
                field("Free Boolean 1"; rec."Free Boolean 1")
                {
                    Visible = false;
                }
                field("Free Boolean 2"; rec."Free Boolean 2")
                {
                    Visible = false;
                }
                field("Free Boolean 3"; rec."Free Boolean 3")
                {
                    Visible = false;
                }
                field("Free Boolean 4"; rec."Free Boolean 4")
                {
                    Visible = false;
                }
                field("Free Boolean 5"; rec."Free Boolean 5")
                {
                    Visible = false;
                }
                field("Criteria 1"; rec."Criteria 1")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 1';
                }
                field("Criteria 2"; rec."Criteria 2")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 2';
                }
                field("Criteria 3"; rec."Criteria 3")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 3';
                }
                field("Criteria 4"; rec."Criteria 4")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 4';
                }
                field("Criteria 5"; rec."Criteria 5")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 5';
                }
                field("Criteria 6"; rec."Criteria 6")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 6';
                }
                field("Criteria 7"; rec."Criteria 7")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 7';
                }
                field("Criteria 8"; rec."Criteria 8")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 8';
                }
                field("Criteria 9"; rec."Criteria 9")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 9';
                }
                field("Criteria 10"; rec."Criteria 10")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Critère 10';
                }

            }
            /*gl2024   part("Reordering Requisition Subform"; "Reordering Requisition Subform")
               {
                   SubPageLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type");

               }*/
        }

    }

    actions
    {
        area(Promoted)
        {
            group("&Document1")
            {
                Caption = '&Document';
                actionref("Customer Card1"; "Customer Card") { }
                actionref("C&ontact Card1"; "C&ontact Card") { }
                actionref("Co&mments1"; "Co&mments") { }

                //  actionref(Description1; Description) { }
                actionref("Job Sales Documents1"; "Job Sales Documents") { }
                actionref(Folder1; Folder) { }
                actionref(Reports1; Reports) { }
                actionref("Invoice Scheduler1"; "Invoice Scheduler") { }
            }
        }
        area(navigation)
        {
            group("&Document")
            {
                Caption = '&Document';
                /*GL2024    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        ShortCutKey = 'Maj+F7';

                        trigger OnAction()
                        var
                            lSingleInstance: Codeunit 8001405;
                        begin
                            //DEVIS
                            lSingleInstance.wSetSalesHeader(Rec);
                            CASE rec."Order Type" OF
                                rec."Order Type"::"Supply Order":
                                    Page.RUNMODAL(Page::"Reordering Requisition", Rec);
                                rec."Order Type"::Transfer:
                                    //#8136
                                    CASE rec."Document Type" OF
                                        rec."Document Type"::Quote:
                                            Page.RUNMODAL(Page::"Internal Quote", Rec);
                                        rec."Document Type"::Order:
                                            Page.RUNMODAL(Page::"Internal Order", Rec);
                                    END
                                //#8136//    Page.RUNMODAL(Page::"Internal Order",Rec);
                                ELSE
                                    CASE rec."Document Type" OF
                                        rec."Document Type"::Quote:
                                            Page.RUNMODAL(Page::"Sales Quote", Rec);
                                        rec."Document Type"::Order:
                                            Page.RUNMODAL(Page::"Sales Order", Rec);
                                        rec."Document Type"::Invoice:
                                            Page.RUNMODAL(Page::"Sales Invoice", Rec);
                                        rec."Document Type"::"Credit Memo":
                                            Page.RUNMODAL(Page::"Sales Credit Memo", Rec);
                                        rec."Document Type"::"Blanket Order":
                                            Page.RUNMODAL(Page::"Blanket Sales Order", Rec);
                                    END;
                            END;
                            CLEARALL;
                            //DEVIS//
                        end;
                    }*/
                /*GL2024   action(Statistics)
                   {
                       Caption = 'Statistics';
                       Image = Statistics;
                       Promoted = true;
                       PromotedCategory = Process;
                       ShortCutKey = 'F7';

                       trigger OnAction()
                       var
                           lStat: Page 64045;
                           lGR: Record 251;
                       begin
                           //Page.RUNMODAL(Page::"NaviBat Quote Statistics",Rec);
                           CLEAR(lStat);
                           CLEAR(lGR);
                           lStat.GetSalesHeader("Document Type", "No.");
                           lGR.SETRANGE("Document Type Filter", "Document Type");
                           lGR.SETRANGE("Document No. Filter", "No.");
                           //lStat.SETRECORD(lGR);
                           lStat.SETTABLEVIEW(lGR);
                           lStat.RUNMODAL;
                       end;
                   }*/
                action("Customer Card")
                {
                    Caption = 'Fiche client';
                    RunObject = Page 21;
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    Image = card;
                }
                action("C&ontact Card")
                {
                    Caption = 'Fiche c&ontact';
                    RunObject = Page 5050;
                    RunPageLink = "No." = FIELD("Sell-to Contact No.");
                    Image = card;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page 67;

                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                }
                /*GL2024 action(Dimensions)
                 {
                     Caption = 'Dimensions';
                     Image = Dimensions;
                     RunObject = Page 546;
                     RunPageLink = "Table ID" = CONST(36), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Line No." = CONST(0);
                 }
                action(Description)
                {
                    Caption = 'Description';

                    trigger OnAction()
                    var
                        lDescription: Record 8004075;
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                /*GL2024   action(Contacts)
                {
                    Caption = 'Contacts';
                    RunObject = Page 64022;
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }*/
                action("Job Sales Documents")
                {
                    Caption = 'Documents ventes de l''affaire';
                    ApplicationArea = all;
                    Image = Document;
                    trigger OnAction()
                    var
                        lRec: Record 36;
                    begin
                        rec.TESTFIELD("Job No.");
                        rec.SETRANGE("Job No.", rec."Job No.");
                        GetFormFilters;
                    end;
                }
                action(Folder)
                {
                    Caption = 'Dossier';

                    trigger OnAction()
                    var
                        lFolderManagement: Codeunit 8001414;
                    begin
                        //FOLDER
                        lFolderManagement.SalesHeader(Rec);
                        //FOLDER//
                    end;
                }
                action(Reports)
                {
                    Caption = 'Etats';
                    Image = Report;

                    trigger OnAction()
                    var
                        lReportList: Record 8001428;
                        lId: Integer;
                        lRecRef: RecordRef;
                    begin
                        WITH lReportList DO BEGIN
                            EVALUATE(lId, COPYSTR(CurrPage.OBJECTID(FALSE), 6));
                            lRecRef.GETTABLE(Rec);
                            SetRecordRef(lRecRef, FALSE);
                            ShowList(lId);
                        END;
                    end;
                }

                /*GL2024    action("Total needs")
                 {
                     Caption = 'Total needs';
                     RunObject = Page 64085;
                     RunPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                     ShortCutKey = 'Ctrl+F11';
                 }*/
                action("Invoice Scheduler")
                {
                    Caption = 'Echéancier de facturation';
                    image = Invoice;

                    trigger OnAction()
                    var
                        lInvSch: Record 8003981;
                    begin
                        //PROJET_FACT
                        IF rec."Invoicing Method" = rec."Invoicing Method"::Scheduler THEN BEGIN
                            lInvSch.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                            lInvSch.SETRANGE("Sales Header Doc. No.", rec."No.");
                            Page.RUN(0, lInvSch);
                        END;
                        //PROJET_FACT//
                    end;
                }
                /*GL2024    action("Job Card2")
                 {
                     Caption = 'Job Card2';
                     Image = "Report";
                     RunObject = Page 63901;
                                     RunPageLink = "No."=FIELD("Job No.");

                     trigger OnAction()
                     begin
                         rec.TESTFIELD("Job No.");
                     end;
                 }
              action("Job Statistics")
                 {
                     Caption = 'Job Statistics';
                     RunObject = Page 63961;
                                     RunPageLink = Code=FIELD("Job No.");

                     trigger OnAction()
                     begin
                         rec.TESTFIELD("Job No.");
                     end;
                 }*/
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.CALCFIELDS(Amount, "Amount Including VAT");
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        DocumentTypeVisible := TRUE;
        Navibat.GET2;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        UserMgt: Codeunit 5700;
        lMaskMgt: Codeunit 8003901;
        lOrderTypeFilter: Text[250];
    begin
        //#5384
        lOrderTypeFilter := rec.GETFILTER("Order Type");
        //#5384//
        rec.FILTERGROUP(2);
        IF UserMgt.GetSalesFilter() <> '' THEN
            rec.SETFILTER("Responsibility Center", UserMgt.GetSalesFilter());
        //#5384
        //IF (GETFILTER("Order Type") = '') THEN
        IF (rec.GETFILTER("Order Type") = '') AND (lOrderTypeFilter = '') THEN
            //#5384//
            rec.SETRANGE("Order Type", 0)

        ELSE IF rec."Order Type" = rec."Order Type"::"Supply Order" THEN
            CurrPage.CAPTION(Text8003900)
        ELSE IF rec."Order Type" = rec."Order Type"::Transfer THEN
            CurrPage.CAPTION(Text8003901);
        rec.FILTERGROUP(0);

        GetFormFilters;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
        //MESSAGE(GETFILTERS);
        OnActivateForm;
    end;

    var
        DimMgt: Codeunit 408;
        DocumentTypeFilter: Option All,Quote,"Order",Invoice,"Credit Memo";
        SellToFilter: Text[250];
        SalesPersonFilter: Text[250];
        GroupFilter: Text[250];
        ProgressFilter: Text[250];
        Text8003902: Label ' ,Devis,Commande,Facture,Avoir';
        JobFilter: Text[250];
        Navibat: Record 8003900;
        Text8003900: Label 'Liste des demandes d''approvisionnement';
        Text8003901: Label 'Liste des documents internes';
        [InDataSet]
        DocumentTypeVisible: Boolean;


    procedure Filters()
    var
        JobTot: Record job;
        lJob: Record job;
    begin
        IF ProgressFilter = '' THEN
            rec.SETRANGE("Progress Degree")

        ELSE
            rec.SETFILTER("Progress Degree", ProgressFilter);

        IF DocumentTypeFilter = 0 THEN
            rec.SETRANGE("Document Type")
        ELSE BEGIN
            rec.SETRANGE("Document Type", DocumentTypeFilter - 1);
        END;

        IF SellToFilter = '' THEN
            rec.SETRANGE("Sell-to Customer No.")
        ELSE
            rec.SETFILTER("Sell-to Customer No.", SellToFilter);

        IF SalesPersonFilter = '' THEN
            rec.SETRANGE("Salesperson Code")
        ELSE
            rec.SETFILTER("Salesperson Code", SalesPersonFilter);

        IF JobFilter = '' THEN
            rec.SETRANGE("Job No.")
        ELSE
            rec.SETFILTER("Job No.", JobFilter);
        /*
        IF HideRiders THEN
          SETRANGE("Rider to Order No.",'')
        ELSE
          SETRANGE("Rider to Order No.");
        
        SETRANGE(Finished,ShowFinishOrder)
        */

    end;


    procedure GetFormFilters()
    var
        lStatus: Option All,Planning,Quote,"Order",Completed;
    begin
        ProgressFilter := rec.GETFILTER("Progress Degree");
        rec.FILTERGROUP(2);
        IF rec.GETFILTER("Document Type") <> '' THEN
            DocumentTypeVisible := FALSE;
        rec.FILTERGROUP(0);
        CASE rec.GETFILTER("Document Type") OF
            '':
                BEGIN
                    DocumentTypeFilter := DocumentTypeFilter::All;
                    //      CurrForm.FinishedOrder.VISIBLE(TRUE);
                END;
            SELECTSTR(2, Text8003902):
                BEGIN
                    DocumentTypeFilter := DocumentTypeFilter::Quote;
                    //      CurrForm.FinishedOrder.VISIBLE(FALSE);
                END;
            SELECTSTR(3, Text8003902):
                BEGIN
                    DocumentTypeFilter := DocumentTypeFilter::Order;
                    //      CurrForm.FinishedOrder.VISIBLE(TRUE);
                END;
            SELECTSTR(4, Text8003902):
                BEGIN
                    DocumentTypeFilter := DocumentTypeFilter::Invoice;
                    //      CurrForm.FinishedOrder.VISIBLE(FALSE);
                END;
            SELECTSTR(5, Text8003902):
                BEGIN
                    DocumentTypeFilter := DocumentTypeFilter::"Credit Memo";
                    //      CurrForm.FinishedOrder.VISIBLE(FALSE);
                END;
        END;
        /*//#4927
        FILTERGROUP(2);
        IF GETFILTER("Order Type") = '' THEN
          SETFILTER("Order Type",'<>1',"Order Type"::"Supply Order");
        FILTERGROUP(0);
        //#4927//*/
        SalesPersonFilter := rec.GETFILTER("Salesperson Code");
        JobFilter := rec.GETFILTER("Job No.");
        //POINTAGE
        IF JobFilter = '''''' THEN BEGIN
            CLEAR(JobFilter);
            rec.SETRANGE("Job No.");
        END;
        //POINTAGE//
        SellToFilter := rec.GETFILTER("Sell-to Customer No.");
        //ShowRiders := GETFILTER("Rider to Order No.") = '';
        /*
        IF HideRiders THEN
          SETRANGE("Rider to Order No.",'')
        ELSE
          SETRANGE("Rider to Order No.");
        ShowFinishOrder := GETFILTER(Finished) = '';
        IF DocumentTypeFilter IN [DocumentTypeFilter::Quote,DocumentTypeFilter::Invoice,DocumentTypeFilter::"Credit Memo"] THEN
          ShowFinishOrder := FALSE;
        SETRANGE(Finished,ShowFinishOrder);
        */
        CurrPage.UPDATE(FALSE);

    end;


    procedure UpdateColonne()
    var
        lCaptionClassTrans: Record 8001404;
        lClassicVisible: Boolean;
    begin
        lClassicVisible := FALSE;
        IF (Navibat."Free Date 1 Option" = 2) OR (Navibat."Free Date Name 1" = '') THEN;
        IF (Navibat."Free Date 2 Option" = 2) OR (Navibat."Free Date Name 2" = '') THEN;
        IF (Navibat."Free Date 3 Option" = 2) OR (Navibat."Free Date Name 3" = '') THEN;
        IF (Navibat."Free Date 4 Option" = 2) OR (Navibat."Free Date Name 4" = '') THEN;
        IF (Navibat."Free Date 5 Option" = 2) OR (Navibat."Free Date Name 5" = '') THEN;
        IF (Navibat."Free Date 6 Option" = 2) OR (Navibat."Free Date Name 6" = '') THEN;
        IF (Navibat."Free Date 7 Option" = 2) OR (Navibat."Free Date Name 7" = '') THEN;
        IF (Navibat."Free Date 8 Option" = 2) OR (Navibat."Free Date Name 8" = '') THEN;
        //#5946
        //IF (Navibat."Free Date 9 Option" = 2) OR (Navibat."Free Date Name 9" = '') THEN
        //  CurrForm."Free Date 9".VISIBLE(FALSE);
        //IF (Navibat."Free Date 10 Option" = 2) OR (Navibat."Free Date Name 10" = '') THEN
        //  CurrForm."Free Date 10".VISIBLE(FALSE);
        //#5946//
        IF (Navibat."Person Resp. 1 Option" = 2) OR (Navibat."Person Responsible Name 1" = '') THEN;
        IF (Navibat."Person Resp. 2 Option" = 2) OR (Navibat."Person Responsible Name 2" = '') THEN;
        IF (Navibat."Person Resp. 3 Option" = 2) OR (Navibat."Person Responsible Name 3" = '') THEN;
        IF (Navibat."Person Resp. 4 Option" = 2) OR (Navibat."Person Responsible Name 4" = '') THEN;
        IF (Navibat."Person Resp. 5 Option" = 2) OR (Navibat."Person Responsible Name 5" = '') THEN;
        IF (Navibat."Free Boolean 1 Option" = 2) OR (Navibat."Free Boolean Name 1" = '') THEN;
        IF (Navibat."Free Boolean 2 Option" = 2) OR (Navibat."Free Boolean Name 2" = '') THEN;
        IF (Navibat."Free Boolean 3 Option" = 2) OR (Navibat."Free Boolean Name 3" = '') THEN;
        IF (Navibat."Free Boolean 4 Option" = 2) OR (Navibat."Free Boolean Name 4" = '') THEN;
        IF (Navibat."Free Boolean 5 Option" = 2) OR (Navibat."Free Boolean Name 5" = '') THEN;
        IF (Navibat."Free Value 1 Option" = 2) OR (Navibat."Free Value Name 1" = '') THEN;
        IF (Navibat."Free Value 2 Option" = 2) OR (Navibat."Free Value Name 2" = '') THEN;
        IF (Navibat."Free Value 3 Option" = 2) OR (Navibat."Free Value Name 3" = '') THEN;
        IF (Navibat."Free Value 4 Option" = 2) OR (Navibat."Free Value Name 4" = '') THEN;
        IF (Navibat."Free Value 5 Option" = 2) OR (Navibat."Free Value Name 5" = '') THEN;

        //#7108
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99090, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99091, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99092, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99093, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99094, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99095, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99096, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99097, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99098, GLOBALLANGUAGE);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99099, GLOBALLANGUAGE);
        //#7108//
    end;

    local procedure DocumentTypeFilterOnAfterValid()
    begin
        IF DocumentTypeFilter IN [DocumentTypeFilter::All, DocumentTypeFilter::Order] THEN BEGIN
        END //  CurrForm.FinishedOrder.VISIBLE(TRUE)
        ELSE BEGIN
            //  CurrForm.FinishedOrder.VISIBLE(FALSE);
            rec.SETRANGE(Finished, FALSE);
        END;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SalesPersonFilterOnAfterValida()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    local procedure JobFilterOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SellToFilterOnAfterValidate()
    begin
        Filters;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateColonne;
    end;

    local procedure OnActivateForm()
    begin
        GetFormFilters;
    end;
}

