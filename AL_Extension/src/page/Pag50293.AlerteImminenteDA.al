page 50293 "Alerte Imminente DA"
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

    Caption = 'Alerte Imminente DA';
    PageType = List;
    SaveValues = true;
    SourceTable = 36;
    SourceTableView = WHERE("Alerte Imminente" = CONST(true),
                            "Alerte Imminente Declanché" = CONST(true),
                            "Alerte Imminente Desactivé" = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Filters2)
            {
                Caption = 'Filters';
                field(SellToFilter; SellToFilter)
                {
                    ApplicationArea = all;
                    Caption = 'N° donneur d''ordre';
                    //GL2024 OptionCaption = ' ,Quote,Order';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lCustomer: Record 18;
                    begin
                        lCustomer.FIND('-');
                        IF page.RUNMODAL(page::"Customer List", lCustomer) = ACTION::LookupOK THEN
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
                    Caption = 'Type document';
                    ApplicationArea = all;
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
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lSalesperson: Record 13;

                    begin
                        lSalesperson.FIND('-');
                        IF page.RUNMODAL(page::"Salespersons/Purchasers", lSalesperson) = ACTION::LookupOK THEN
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
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lJob: Record Job;
                    begin
                        lJob.FIND('-');
                        IF page.RUNMODAL(page::"Job List", lJob) = ACTION::LookupOK THEN
                            IF JobFilter = '' THEN
                                JobFilter := STRSUBSTNO('%1', lJob."No.")
                            ELSE
                                JobFilter += STRSUBSTNO('|%1', lJob."No.");
                        Filters;
                    end;

                    trigger OnValidate()
                    begin
                        Filters;
                        JobFilterOnAfterValidate;
                    end;
                }
            }
            repeater(" ")
            {
                ShowCaption = false;
                Editable = false;
                field("Alerte Imminente"; rec."Alerte Imminente")
                {
                    Style = Unfavorable;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Alerte Imminente Declanché"; rec."Alerte Imminente Declanché")
                {
                    Style = Unfavorable;
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Rider to Order No."; rec."Rider to Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Finished; rec.Finished)
                {
                    Visible = false;
                }
                field("Quote No."; rec."Quote No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Subject; rec.Subject)
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    var
                        lDescription: Record 8004075;
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                field("Sell-to Contact No."; rec."Sell-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Contact"; rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Post Code"; rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to City"; rec."Bill-to City")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Contact"; rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Project Manager"; rec."Project Manager")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Description"; rec."Job Description")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("Amount Excl. VAT (LCY)"; rec."Amount Excl. VAT (LCY)")
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                }
                field("Deadline Date"; rec."Deadline Date")
                {
                    ApplicationArea = all;
                }
                field("Person Responsible"; rec."Person Responsible")
                {
                    ApplicationArea = all;
                    Visible = "Person ResponsibleVisible";
                }
                field("Person Responsible 2"; rec."Person Responsible 2")
                {
                    ApplicationArea = all;
                    Visible = "Person Responsible 2Visible";
                }
                field("Person Responsible 3"; rec."Person Responsible 3")
                {
                    ApplicationArea = all;
                    Visible = "Person Responsible 3Visible";
                }
                field("Person Responsible 4"; rec."Person Responsible 4")
                {
                    ApplicationArea = all;
                    Visible = "Person Responsible 4Visible";
                }
                field("Person Responsible 5"; rec."Person Responsible 5")
                {
                    ApplicationArea = all;
                    Visible = "Person Responsible 5Visible";
                }
                field("Free Date 1"; rec."Free Date 1")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 1Visible";
                }
                field("Free Date 2"; rec."Free Date 2")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 2Visible";
                }
                field("Free Date 3"; rec."Free Date 3")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 3Visible";
                }
                field("Free Date 4"; rec."Free Date 4")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 4Visible";
                }
                field("Free Date 5"; rec."Free Date 5")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 5Visible";
                }
                field("Free Date 6"; rec."Free Date 6")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 6Visible";
                }
                field("Free Date 7"; rec."Free Date 7")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 7Visible";
                }
                field("Free Date 8"; rec."Free Date 8")
                {
                    ApplicationArea = all;
                    Visible = "Free Date 8Visible";
                }
                field("Free Value 1"; rec."Free Value 1")
                {
                    ApplicationArea = all;
                    Visible = "Free Value 1Visible";
                }
                field("Free Value 2"; rec."Free Value 2")
                {
                    ApplicationArea = all;
                    Visible = "Free Value 2Visible";
                }
                field("Free Value 3"; rec."Free Value 3")
                {
                    ApplicationArea = all;
                    Visible = "Free Value 3Visible";
                }
                field("Free Value 4"; rec."Free Value 4")
                {
                    ApplicationArea = all;
                    Visible = "Free Value 4Visible";
                }
                field("Free Value 5"; rec."Free Value 5")
                {
                    ApplicationArea = all;
                    Visible = "Free Value 5Visible";
                }
                field("Free Boolean 1"; rec."Free Boolean 1")
                {
                    ApplicationArea = all;
                    Visible = "Free Boolean 1Visible";
                }
                field("Free Boolean 2"; rec."Free Boolean 2")
                {
                    ApplicationArea = all;
                    Visible = "Free Boolean 2Visible";
                }
                field("Free Boolean 3"; rec."Free Boolean 3")
                {
                    ApplicationArea = all;
                    Visible = "Free Boolean 3Visible";
                }
                field("Free Boolean 4"; rec."Free Boolean 4")
                {
                    ApplicationArea = all;
                    Visible = "Free Boolean 4Visible";
                }
                field("Free Boolean 5"; rec."Free Boolean 5")
                {
                    ApplicationArea = all;
                    Visible = "Free Boolean 5Visible";
                }
            }
            part("Reordering Requisition Subform"; "Reordering Requisition Subform")
            {
                ApplicationArea = all;
                SubpageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Document1")
            {
                Caption = '&Document';
                actionref(Card1; Card)
                { }
                // actionref(Statistics1; Statistics)
                // { }
                actionref("Customer Card1"; "Customer Card")
                { }
                actionref("C&ontact Card1"; "C&ontact Card")
                { }
                actionref("Co&mments1"; "Co&mments")
                { }
                // actionref("Dimensions1"; "Dimensions")
                // { }
                actionref(Description1; Description)
                { }
                //  actionref(Contacts1; Contacts)
                // { }
                actionref("Job Sales Documents1"; "Job Sales Documents")
                { }
                actionref(Folder1; Folder)
                { }
                actionref(Reports1; Reports)
                { }
                //  actionref("Total needs1"; "Total needs")
                // { }
                actionref("Invoice Scheduler1"; "Invoice Scheduler")
                { }
                actionref("Job Card1"; "Job Card")
                { }
                actionref("Job Statistics1"; "Job Statistics")
                { }
                actionref("Desactivé Alerte Imminente1"; "Desactivé Alerte Imminente")
                { }


            }
        }
        area(navigation)
        {
            group("&Document")
            {
                Caption = '&Document';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    Image = EditLines;
                    ShortCutKey = 'Maj+F5';
                    Visible = false;

                    trigger OnAction()
                    var
                        lSingleInstance: Codeunit 8001405;
                    begin
                        //DEVIS
                        // lSingleInstance.wSetSalesHeader(Rec);
                        // CASE rec."Order Type" OF
                        //     rec."Order Type"::"Supply Order":
                        //         page.RUNMODAL(page::"Reordering Requisition", Rec);
                        //     rec."Order Type"::Transfer:
                        //         //#8136
                        //         CASE rec."Document Type" OF
                        //             rec."Document Type"::Quote:
                        //                 page.RUNMODAL(page::"Internal Quote", Rec);
                        //             rec."Document Type"::Order:
                        //                 page.RUNMODAL(page::"Internal Order", Rec);
                        //         END
                        //     //#8136//    page.RUNMODAL(page::"Internal Order",Rec);
                        //     ELSE
                        //         CASE rec."Document Type" OF
                        //             rec."Document Type"::Quote:
                        //                 page.RUNMODAL(page::"Sales Quote", Rec);
                        //             rec."Document Type"::Order:
                        //                 page.RUNMODAL(page::"Sales Order", Rec);
                        //             rec."Document Type"::Invoice:
                        //                 page.RUNMODAL(page::"Sales Invoice", Rec);
                        //             rec."Document Type"::"Credit Memo":
                        //                 page.RUNMODAL(page::"Sales Credit Memo", Rec);
                        //             rec."Document Type"::"Blanket Order":
                        //                 page.RUNMODAL(page::"Blanket Sales Order", Rec);
                        //         END;
                        // END;
                        // CLEARALL;
                        // //DEVIS//
                    end;
                }
                /*  action(Statistics)
                  {ApplicationArea=all;
                      Caption = 'Statistics';
                      Image = Statistics;
                      Promoted = true;
                      PromotedCategory = Process;
                      ShortCutKey = 'F7';

                      trigger OnAction()
                      var
                          lStat: page 8004045;
                          lGR: Record 251;
                      begin
                          //page.RUNMODAL(page::"NaviBat Quote Statistics",Rec);
                          CLEAR(lStat);
                          CLEAR(lGR);
                          lStat.GetSalesHeader("Document Type", rec."No.");
                          lGR.SETRANGE("Document Type Filter", rec."Document Type");
                          lGR.SETRANGE("Document No. Filter", rec."No.");
                          //lStat.SETRECORD(lGR);
                          lStat.SETTABLEVIEW(lGR);
                          lStat.RUNMODAL;
                      end;
                  }*/
                action("Customer Card")
                {
                    Caption = 'Fiche client';
                    ApplicationArea = all;
                    RunpageLink = "No." = FIELD("Sell-to Customer No.");
                    RunObject = Page 22;
                }
                action("C&ontact Card")
                {
                    Caption = 'Fiche c&ontact';
                    ApplicationArea = all;
                    RunpageLink = "No." = FIELD("Sell-to Contact No.");
                    RunObject = Page 5052;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mmentaires';
                    ApplicationArea = all;
                    Image = ViewComments;
                    RunpageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    RunObject = Page 67;
                }
                /* action(Dimensions)
                 {ApplicationArea=all;
                     Caption = 'A&xe analytique';
                     Image = Dimensions;
                     RunpageLink = "Table ID" = CONST(36),
                                   "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No."),
                                   "Line No." = CONST(0);
                     RunObject = Page 546;
                 }*/
                action(Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';

                    trigger OnAction()
                    var
                        lDescription: Record 8004075;
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                /*  action(Contacts)
                  {ApplicationArea=all;
                      Caption = 'Contacts';
                      RunpageLink = "Document Type" = FIELD("Document Type"),
                                    "No." = FIELD("No.");
                      RunObject = Page 8004022;
                  }*/
                action("Job Sales Documents")
                {
                    ApplicationArea = all;
                    Caption = 'Documents ventes de l''affaire';

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
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    Caption = 'Etats';

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

                /*  action("Total needs")
                  {ApplicationArea=all;
                      Caption = 'Besoins cumulés';
                      RunpageLink = "Document Type" = FIELD("Document Type"),
                                    "Document No." = FIELD("No.");
                      RunObject = Page "8004085";
                      ShortCutKey = 'Ctrl+F11';
                  }*/
                action("Invoice Scheduler")
                {
                    ApplicationArea = all;
                    Caption = 'Echéancier de facturation';

                    trigger OnAction()
                    var
                        lInvSch: Record "Invoice Scheduler";
                    begin
                        //PROJET_FACT
                        IF rec."Invoicing Method" = rec."Invoicing Method"::Scheduler THEN BEGIN
                            lInvSch.SETRANGE("Sales Header Doc. Type", rec."Document Type");
                            lInvSch.SETRANGE("Sales Header Doc. No.", rec."No.");
                            page.RUN(0, lInvSch);
                        END;
                        //PROJET_FACT//
                    end;
                }
                action("Job Card")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche affaire';
                    Image = "Report";
                    RunpageLink = "No." = FIELD("Job No.");
                    RunObject = Page "Job Card";

                    trigger OnAction()
                    begin
                        rec.TESTFIELD("Job No.");
                    end;
                }
                action("Job Statistics")
                {
                    ApplicationArea = all;
                    Caption = 'Synthèse affaire';
                    RunpageLink = "No." = FIELD("Job No.");
                    RunObject = Page "Job Statistics";

                    trigger OnAction()
                    begin
                        rec.TESTFIELD("Job No.");
                    end;
                }
                action("Desactivé Alerte Imminente")
                {
                    ApplicationArea = all;
                    Caption = 'Desactivé Alerte Imminente';

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        rec."Alerte Imminente Desactivé" := TRUE;
                        rec.MODIFY;
                    end;
                }
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
        "//HJ": Integer;
        LSalesHeader: Record 36;
        LPurchaseLine: Record 39;
    begin
        // >> HJ SORO 08-11-2016
        Trouver := FALSE;
        LSalesHeader.SETRANGE("Document Type", LSalesHeader."Document Type"::Order);
        LSalesHeader.SETRANGE("Order Type", LSalesHeader."Order Type"::"Supply Order");
        LSalesHeader.SETRANGE("Alerte Imminente", TRUE);
        LSalesHeader.SETRANGE("Alerte Imminente Desactivé", FALSE);
        IF LSalesHeader.FINDFIRST THEN
            REPEAT
                LSalesHeader.CALCFIELDS("Commande Achat Associé");
                IF LSalesHeader."Commande Achat Associé" <> '' THEN BEGIN
                    LPurchaseLine.SETRANGE("Document Type", LPurchaseLine."Document Type"::Order);
                    LPurchaseLine.SETRANGE("Document No.", LSalesHeader."Commande Achat Associé");
                    LPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
                    IF LPurchaseLine.FINDFIRST THEN BEGIN
                        Trouver := TRUE;
                        LSalesHeader."Alerte Imminente Declanché" := TRUE;
                        LSalesHeader.MODIFY;
                    END;
                END;
            UNTIL LSalesHeader.NEXT = 0;
        IF NOT Trouver THEN CurrPage.CLOSE;
        // >> HJ SORO 08-11-2016
        OnActivateForm;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        DocumentTypeFilter: Option All,Quote,"Order",Invoice,"Credit Memo";
        SellToFilter: Text[250];
        SalesPersonFilter: Text[250];
        GroupFilter: Text[250];
        ProgressFilter: Text[250];
        Text8003902: Label 'All,Quote,Order,Invoice,Credit Memo';
        JobFilter: Text[250];
        Navibat: Record 8003900;
        Text8003900: Label 'Reodering Requisitions List';
        Text8003901: Label 'Sales Transfer Orders List';

        Text001: Label 'Desactivé Alerte Imminente ?';
        Trouver: Boolean;
        [InDataSet]
        DocumentTypeVisible: Boolean;
        [InDataSet]
        "Free Date 1Visible": Boolean;
        [InDataSet]
        "Free Date 2Visible": Boolean;
        [InDataSet]
        "Free Date 3Visible": Boolean;
        [InDataSet]
        "Free Date 4Visible": Boolean;
        [InDataSet]
        "Free Date 5Visible": Boolean;
        [InDataSet]
        "Free Date 6Visible": Boolean;
        [InDataSet]
        "Free Date 7Visible": Boolean;
        [InDataSet]
        "Free Date 8Visible": Boolean;
        [InDataSet]
        "Person ResponsibleVisible": Boolean;
        [InDataSet]
        "Person Responsible 2Visible": Boolean;
        [InDataSet]
        "Person Responsible 3Visible": Boolean;
        [InDataSet]
        "Person Responsible 4Visible": Boolean;
        [InDataSet]
        "Person Responsible 5Visible": Boolean;
        [InDataSet]
        "Free Boolean 1Visible": Boolean;
        [InDataSet]
        "Free Boolean 2Visible": Boolean;
        [InDataSet]
        "Free Boolean 3Visible": Boolean;
        [InDataSet]
        "Free Boolean 4Visible": Boolean;
        [InDataSet]
        "Free Boolean 5Visible": Boolean;
        [InDataSet]
        "Free Value 1Visible": Boolean;
        [InDataSet]
        "Free Value 2Visible": Boolean;
        [InDataSet]
        "Free Value 3Visible": Boolean;
        [InDataSet]
        "Free Value 4Visible": Boolean;
        [InDataSet]
        "Free Value 5Visible": Boolean;


    procedure Filters()
    var
        JobTot: Record Job;
        lJob: Record Job;
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
        IF (Navibat."Free Date 1 Option" = 2) OR (Navibat."Free Date Name 1" = '') THEN BEGIN
            "Free Date 1Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 2 Option" = 2) OR (Navibat."Free Date Name 2" = '') THEN BEGIN
            "Free Date 2Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 3 Option" = 2) OR (Navibat."Free Date Name 3" = '') THEN BEGIN
            "Free Date 3Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 4 Option" = 2) OR (Navibat."Free Date Name 4" = '') THEN BEGIN
            "Free Date 4Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 5 Option" = 2) OR (Navibat."Free Date Name 5" = '') THEN BEGIN
            "Free Date 5Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 6 Option" = 2) OR (Navibat."Free Date Name 6" = '') THEN BEGIN
            "Free Date 6Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 7 Option" = 2) OR (Navibat."Free Date Name 7" = '') THEN BEGIN
            "Free Date 7Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Date 8 Option" = 2) OR (Navibat."Free Date Name 8" = '') THEN BEGIN
            "Free Date 8Visible" := lClassicVisible;
        END;
        //#5946
        //IF (Navibat."Free Date 9 Option" = 2) OR (Navibat."Free Date Name 9" = '') THEN
        //  CurrForm."Free Date 9".VISIBLE(FALSE);
        //IF (Navibat."Free Date 10 Option" = 2) OR (Navibat."Free Date Name 10" = '') THEN
        //  CurrForm."Free Date 10".VISIBLE(FALSE);
        //#5946//
        IF (Navibat."Person Resp. 1 Option" = 2) OR (Navibat."Person Responsible Name 1" = '') THEN BEGIN
            "Person ResponsibleVisible" := lClassicVisible;
        END;
        IF (Navibat."Person Resp. 2 Option" = 2) OR (Navibat."Person Responsible Name 2" = '') THEN BEGIN
            "Person Responsible 2Visible" := lClassicVisible;
        END;
        IF (Navibat."Person Resp. 3 Option" = 2) OR (Navibat."Person Responsible Name 3" = '') THEN BEGIN
            "Person Responsible 3Visible" := lClassicVisible;
        END;
        IF (Navibat."Person Resp. 4 Option" = 2) OR (Navibat."Person Responsible Name 4" = '') THEN BEGIN
            "Person Responsible 4Visible" := lClassicVisible;
        END;
        IF (Navibat."Person Resp. 5 Option" = 2) OR (Navibat."Person Responsible Name 5" = '') THEN BEGIN
            "Person Responsible 5Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Boolean 1 Option" = 2) OR (Navibat."Free Boolean Name 1" = '') THEN BEGIN
            "Free Boolean 1Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Boolean 2 Option" = 2) OR (Navibat."Free Boolean Name 2" = '') THEN BEGIN
            "Free Boolean 2Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Boolean 3 Option" = 2) OR (Navibat."Free Boolean Name 3" = '') THEN BEGIN
            "Free Boolean 3Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Boolean 4 Option" = 2) OR (Navibat."Free Boolean Name 4" = '') THEN BEGIN
            "Free Boolean 4Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Boolean 5 Option" = 2) OR (Navibat."Free Boolean Name 5" = '') THEN BEGIN
            "Free Boolean 5Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Value 1 Option" = 2) OR (Navibat."Free Value Name 1" = '') THEN BEGIN
            "Free Value 1Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Value 2 Option" = 2) OR (Navibat."Free Value Name 2" = '') THEN BEGIN
            "Free Value 2Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Value 3 Option" = 2) OR (Navibat."Free Value Name 3" = '') THEN BEGIN
            "Free Value 3Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Value 4 Option" = 2) OR (Navibat."Free Value Name 4" = '') THEN BEGIN
            "Free Value 4Visible" := lClassicVisible;
        END;
        IF (Navibat."Free Value 5 Option" = 2) OR (Navibat."Free Value Name 5" = '') THEN BEGIN
            "Free Value 5Visible" := lClassicVisible;
        END;

        //#7108  RB SORO 26/12/2015
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99090, GLOBALLANGUAGE);
        //CurrForm."Criteria 1".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99091, GLOBALLANGUAGE);
        //CurrForm."Criteria 2".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99092, GLOBALLANGUAGE);
        //CurrForm."Criteria 3".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99093, GLOBALLANGUAGE);
        //CurrForm."Criteria 4".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99094, GLOBALLANGUAGE);
        //CurrForm."Criteria 5".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99095, GLOBALLANGUAGE);
        //CurrForm."Criteria 6".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99096, GLOBALLANGUAGE);
        //CurrForm."Criteria 7".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99097, GLOBALLANGUAGE);
        //CurrForm."Criteria 8".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99098, GLOBALLANGUAGE);
        //CurrForm."Criteria 9".VISIBLE(lClassicVisible);
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99099, GLOBALLANGUAGE);
        //CurrForm."Criteria 10".VISIBLE(lClassicVisible);
        //#7108//   RB SORO 26/12/2015
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

