page 50170 "Alerte DA"
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

    Caption = 'Alerte DA';
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    SaveValues = true;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Order Type", "Document Type", "No.") WHERE("Document Type" = FILTER(Order), "Order Type" = CONST("Supply Order"), "Jours Retard" = FILTER(> 4));

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
                    //    OptionCaption = ' ,Quote,Order';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lCustomer: Record Customer;
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
                    ApplicationArea = all;
                    Caption = 'Type document';
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
                    ApplicationArea = all;
                    Caption = 'Code vendeur';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lSalesperson: Record "Salesperson/Purchaser";
                    begin
                        lSalesperson.FIND('-');
                        IF PAGE.RUNMODAL(page::"Salespersons/Purchasers", lSalesperson) = ACTION::LookupOK THEN
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
                    ApplicationArea = all;
                    Caption = 'N° affaire';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lJob: Record Job;
                    begin
                        lJob.FIND('-');
                        IF PAGE.RUNMODAL(page::"Job List", lJob) = ACTION::LookupOK THEN
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
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Jours Retard"; rec."Jours Retard")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                // field("Posting Date"; rec."Posting Date")
                // {
                //     ApplicationArea = all;
                // }
                field("No."; rec."No.")
                {
                }
                field("Requester ID"; rec."Requester ID")
                {
                    ApplicationArea = all;
                }
                field(Service; rec.Service)
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
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
                        lDescription: Record "Description Line";
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                field("Sell-to Contact No."; rec."Sell-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Commande Achat Associé"; rec."Commande Achat Associé")
                {
                    ApplicationArea = all;
                }
                field("Num Sequence Syncro"; Rec."Num Sequence Syncro")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                // field(Observation; rec.Observation)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Engin';
                // }
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
                field("Criteria 1"; rec."Criteria 1")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 1Visible";
                }
                field("Criteria 2"; rec."Criteria 2")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 2Visible";
                }
                field("Criteria 3"; rec."Criteria 3")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 3Visible";
                }
                field("Criteria 4"; rec."Criteria 4")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 4Visible";
                }
                field("Criteria 5"; rec."Criteria 5")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 5Visible";
                }
                field("Criteria 6"; rec."Criteria 6")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 6Visible";
                }
                field("Criteria 7"; rec."Criteria 7")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 7Visible";
                }
                field("Criteria 8"; rec."Criteria 8")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 8Visible";
                }
                field("Criteria 9"; rec."Criteria 9")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 9Visible";
                }
                field("Criteria 10"; rec."Criteria 10")
                {
                    ApplicationArea = all;
                    Visible = "Criteria 10Visible";
                }
            }
            /*  part(; 8003969)
              { ApplicationArea = all;
                  SubPageLink = "Document No."=FIELD("No.");
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
                actionref(Card11; Card) { }
                actionref("Customer Card1"; "Customer Card") { }
                actionref("C&ontact Card1"; "C&ontact Card") { }
                actionref("Co&mments1"; "Co&mments") { }

                actionref(Description1; Description) { }
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
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Maj+F5';

                    trigger OnAction()
                    var
                        lSingleInstance: Codeunit "Import SingleInstance2";
                    begin
                        //DEVIS
                        lSingleInstance.wSetSalesHeader(Rec);
                        CASE rec."Order Type" OF
                            /*GL2024 rec."Order Type"::"Supply Order":
                                 PAGE.RUNMODAL(page::"Reordering Requisition", Rec);*/
                            rec."Order Type"::Transfer:
                                //#8136
                                /*GL2024  CASE rec."Document Type" OF
                                     rec."Document Type"::Quote:
                                         PAGE.RUNMODAL(page::"Internal Quote", Rec);
                                     rec."Document Type"::Order:
                                         PAGE.RUNMODAL(page::"Internal Order", Rec);
                                 END
                             //#8136//    PAGE.RUNMODAL(page::"Internal Order",Rec);
                             ELSE*/
                                CASE rec."Document Type" OF
                                    rec."Document Type"::Quote:
                                        PAGE.RUNMODAL(page::"Sales Quote", Rec);
                                    rec."Document Type"::Order:
                                        PAGE.RUNMODAL(page::"Sales Order", Rec);
                                    rec."Document Type"::Invoice:
                                        PAGE.RUNMODAL(page::"Sales Invoice", Rec);
                                    rec."Document Type"::"Credit Memo":
                                        PAGE.RUNMODAL(page::"Sales Credit Memo", Rec);
                                    rec."Document Type"::"Blanket Order":
                                        PAGE.RUNMODAL(page::"Blanket Sales Order", Rec);
                                END;
                        END;
                        CLEARALL;
                        //DEVIS//
                    end;
                }
                /* //GL2024   action(Statistics)
                   { ApplicationArea = all;
                       Caption = 'Statistics';
                       Image = Statistics;
                       Promoted = true;
                       PromotedCategory = Process;
                       ShortCutKey = 'F7';

                       trigger OnAction()
                       var
                        //GL2024   lStat: Page 8004045;
                           lGR: Record 251;
                       begin
                           //PAGE.RUNMODAL(page::"NaviBat Quote Statistics",Rec);
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
                    ApplicationArea = all;
                    Caption = 'Customer Card';
                    RunObject = Page "Customer List";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                }
                action("C&ontact Card")
                {
                    ApplicationArea = all;
                    Caption = 'C&ontact Card';
                    RunObject = Page "Contact List";
                    RunPageLink = "No." = FIELD("Sell-to Contact No.");
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                }
                /* GL2024 action(Dimensions)
                  { ApplicationArea = all;
                      Caption = 'Dimensions';
                      Image = Dimensions;
                      RunObject = Page 546;
                                      RunPageLink = "Table ID"=CONST(36), "Document Type"=FIELD("Document Type"), "Document No."=FIELD("No."), "Line No."=CONST(0);
                  }*/
                action(Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';

                    trigger OnAction()
                    var
                        lDescription: Record "Description Line";
                    begin
                        lDescription.ShowDescription(36, rec."Document Type", rec."No.", 0);
                    end;
                }
                /*GL2024  action(Contacts)
                  { ApplicationArea = all;
                      Caption = 'Contacts';
                      RunObject = Page 8004022;
                                      RunPageLink = Document Type=FIELD(Document Type), No.=FIELD(No.);
                  }*/
                action("Job Sales Documents")
                {
                    ApplicationArea = all;
                    Caption = 'Job Sales Documents';

                    trigger OnAction()
                    var
                        lRec: Record "Sales Header";
                    begin
                        rec.TESTFIELD("Job No.");
                        rec.SETRANGE("Job No.", rec."Job No.");
                        GetFormFilters;
                    end;
                }
                action(Folder)
                {
                    ApplicationArea = all;
                    Caption = 'Folder';

                    trigger OnAction()
                    var
                        lFolderManagement: Codeunit "Folder management";
                    begin
                        //FOLDER
                        lFolderManagement.SalesHeader(Rec);
                        //FOLDER//
                    end;
                }
                action(Reports)
                {
                    ApplicationArea = all;
                    Caption = 'Reports';

                    trigger OnAction()
                    var
                        lReportList: Record ReportList;
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
                separator(separator2)
                {
                }
                /*GL2024 action("Total needs")
                 { ApplicationArea = all;
                     Caption = 'Total needs';
                     RunObject = Page 8004085;
                                     RunPageLink = Document Type=FIELD(Document Type), Document No.=FIELD(No.);
                     ShortCutKey = 'Ctrl+F11';
                 }*/
                action("Invoice Scheduler")
                {
                    ApplicationArea = all;
                    Caption = 'Invoice Scheduler';

                    trigger OnAction()
                    var
                        lInvSch: Record "Invoice Scheduler";
                    begin
                        //PROJET_FACT
                        IF REC."Invoicing Method" = REC."Invoicing Method"::Scheduler THEN BEGIN
                            lInvSch.SETRANGE("Sales Header Doc. Type", REC."Document Type");
                            lInvSch.SETRANGE("Sales Header Doc. No.", REC."No.");
                            Page.RUN(0, lInvSch);
                        END;
                        //PROJET_FACT//
                    end;
                }
                /*  GL2024 action("Job Card")
                   { ApplicationArea = all;
                       Caption = 'Job Card';
                       Image = "Report";
                       RunObject = Page 8003901;
                                       RunPageLink = No.=FIELD(Job No.);

                       trigger OnAction()
                       begin
                           TESTFIELD("Job No.");
                       end;
                   }
                   action("Job Statistics")
                   { ApplicationArea = all;
                       Caption = 'Job Statistics';
                       RunObject = Page 8003961;
                                       RunPageLink = Code=FIELD(Job No.);

                       trigger OnAction()
                       begin
                           TESTFIELD("Job No.");
                       end;
                   }*/
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        REC.CALCFIELDS(Amount, "Amount Including VAT");
        // >> HJ SORO 05-01-2014
        //RESET;
        IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        // >> HJ SORO 05-01-2014

        // >> HJ SORO 18-05-2016
        IF REC."Posting Date" <> 0D THEN Jours := WORKDATE - REC."Posting Date";
        // >> HJ SORO 18-05-2016
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Criteria 10Visible" := TRUE;
        "Criteria 9Visible" := TRUE;
        "Criteria 8Visible" := TRUE;
        "Criteria 7Visible" := TRUE;
        "Criteria 6Visible" := TRUE;
        "Criteria 5Visible" := TRUE;
        "Criteria 4Visible" := TRUE;
        "Criteria 3Visible" := TRUE;
        "Criteria 2Visible" := TRUE;
        "Criteria 1Visible" := TRUE;
        DocumentTypeVisible := TRUE;
        Navibat.GET2;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        UserMgt: Codeunit "User Setup Management";
        lMaskMgt: Codeunit "Mask Management";
        lOrderTypeFilter: Text[250];
    begin
        //#5384
        lOrderTypeFilter := REC.GETFILTER("Order Type");
        /*//#5384//
        FILTERGROUP(2);
        IF UserMgt.GetSalesFilter() <> '' THEN
          SETFILTER("Responsibility Center",UserMgt.GetSalesFilter());
        //#5384
        //IF (GETFILTER("Order Type") = '') THEN
        IF (GETFILTER("Order Type") = '') AND (lOrderTypeFilter = '')  THEN
        //#5384//
          SETRANGE("Order Type",0)
        
        ELSE IF "Order Type" = "Order Type"::"Supply Order" THEN
          CurrForm.CAPTION(Text8003900)
        ELSE IF "Order Type" = "Order Type"::Transfer THEN
          CurrForm.CAPTION(Text8003901);
        FILTERGROUP(0);
        
        GetFormFilters;
        
        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
        //MESSAGE(GETFILTERS);
         */
        // >> HJ SORO 05-01-2014
        //RESET;
        IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        // >> HJ SORO 05-01-2014
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
        Navibat: Record NavibatSetup;
        Text8003900: Label 'Reodering Requisitions List';
        Text8003901: Label 'Sales Transfer Orders List';
        UserSetup: Record "User Setup";

        Jours: Integer;
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
        [InDataSet]
        "Criteria 1Visible": Boolean;
        [InDataSet]
        "Criteria 2Visible": Boolean;
        [InDataSet]
        "Criteria 3Visible": Boolean;
        [InDataSet]
        "Criteria 4Visible": Boolean;
        [InDataSet]
        "Criteria 5Visible": Boolean;
        [InDataSet]
        "Criteria 6Visible": Boolean;
        [InDataSet]
        "Criteria 7Visible": Boolean;
        [InDataSet]
        "Criteria 8Visible": Boolean;
        [InDataSet]
        "Criteria 9Visible": Boolean;
        [InDataSet]
        "Criteria 10Visible": Boolean;


    procedure Filters()
    var
        JobTot: Record Job;
        lJob: Record Job;
    begin
        IF ProgressFilter = '' THEN
            REC.SETRANGE("Progress Degree")

        ELSE
            REC.SETFILTER("Progress Degree", ProgressFilter);

        IF DocumentTypeFilter = 0 THEN
            REC.SETRANGE("Document Type")
        ELSE BEGIN
            REC.SETRANGE("Document Type", DocumentTypeFilter - 1);
        END;

        IF SellToFilter = '' THEN
            REC.SETRANGE("Sell-to Customer No.")
        ELSE
            REC.SETFILTER("Sell-to Customer No.", SellToFilter);

        IF SalesPersonFilter = '' THEN
            REC.SETRANGE("Salesperson Code")
        ELSE
            REC.SETFILTER("Salesperson Code", SalesPersonFilter);

        IF JobFilter = '' THEN
            REC.SETRANGE("Job No.")
        ELSE
            REC.SETFILTER("Job No.", JobFilter);
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
        ProgressFilter := REC.GETFILTER("Progress Degree");
        REC.FILTERGROUP(2);
        IF REC.GETFILTER("Document Type") <> '' THEN
            DocumentTypeVisible := FALSE;
        REC.FILTERGROUP(0);
        CASE REC.GETFILTER("Document Type") OF
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
        SalesPersonFilter := REC.GETFILTER("Salesperson Code");
        JobFilter := REC.GETFILTER("Job No.");
        //POINTAGE
        IF JobFilter = '''''' THEN BEGIN
            CLEAR(JobFilter);
            REC.SETRANGE("Job No.");
        END;
        //POINTAGE//
        SellToFilter := REC.GETFILTER("Sell-to Customer No.");
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
        lCaptionClassTrans: Record "CaptionClass Translation";
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

        //#7108
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99090, GLOBALLANGUAGE);
        "Criteria 1Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99091, GLOBALLANGUAGE);
        "Criteria 2Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99092, GLOBALLANGUAGE);
        "Criteria 3Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99093, GLOBALLANGUAGE);
        "Criteria 4Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99094, GLOBALLANGUAGE);
        "Criteria 5Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99095, GLOBALLANGUAGE);
        "Criteria 6Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99096, GLOBALLANGUAGE);
        "Criteria 7Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99097, GLOBALLANGUAGE);
        "Criteria 8Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99098, GLOBALLANGUAGE);
        "Criteria 9Visible" := lClassicVisible;
        lClassicVisible := lCaptionClassTrans.Exists(8001302, 99099, GLOBALLANGUAGE);
        "Criteria 10Visible" := lClassicVisible;
        //#7108//
    end;

    local procedure DocumentTypeFilterOnAfterValid()
    begin
        IF DocumentTypeFilter IN [DocumentTypeFilter::All, DocumentTypeFilter::Order] THEN BEGIN
        END //  CurrForm.FinishedOrder.VISIBLE(TRUE)
        ELSE BEGIN
            //  CurrForm.FinishedOrder.VISIBLE(FALSE);
            REC.SETRANGE(Finished, FALSE);
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

