//HS
page 50351 "Liste Commande Affaire"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Liste Commande Affaire';
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Order Type", "Document Type", "No.", "Invoicing Method", Finished) WHERE("Document Type" = CONST(Order), "Order Type" = FILTER(' '), "Commande Affaire" = FILTER(true));
    CardPageId = "Commande Affaire";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    // trigger OnAssistEdit()
                    // begin
                    //     IF REC.AssistEdit(xRec) THEN
                    //         CurrPage.UPDATE;
                    // end;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Client';
                    Editable = "Sell-to Customer No.Editable";

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Editable = "Sell-to Customer NameEditable";

                    /* GL2024  trigger OnAssistEdit()
                      begin
                          CurrPage.SAVERECORD;
                          COMMIT;
                          CLEAR(AddressContributors);
                          AddressContributors.InitRequest(1);
                          AddressContributors.SETTABLEVIEW(Rec);
                          AddressContributors.SETRECORD(Rec);
                          AddressContributors.RUNMODAL;
                          //AddressContributors.GETRECORD(Rec);
                          CurrPage.UPDATE;
                      end;*/
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Caption = 'Centrale';
                    Editable = "Job No.Editable";
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° BL';
                }
                // field("Date Ordre Service"; rec."Date Ordre Service")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Nbre Mois Marché"; rec."Nbre Mois Marché")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Date Fin de Travaux"; rec."Date Fin de Travaux")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                // field("Delai Suspension"; rec."Delai Suspension")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field(Presentation; PresentationCode)
                {
                    ApplicationArea = all;
                    Caption = 'Presentation Code';
                    TableRelation = "Sales Line View";
                    ToolTip = 'Lines Setup';

                    trigger OnValidate()
                    begin
                        PresentationCodeOnAfterValidat;
                    end;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        rec.VALIDATE("Shipment Date", 0D);
                    end;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date Fin Prevue';
                    Editable = true;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Quote No."; rec."Quote No.")
                {
                    ApplicationArea = all;
                }
                // field("Commande Interne"; rec."Commande Interne")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Last Shipping No."; rec."Last Shipping No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Expédition';
                }
                // field("Date Debut Decompte"; rec."Date Debut Decompte")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }
                // field("Date Fin Decompte"; rec."Date Fin Decompte")
                // {
                //     ApplicationArea = all;
                //     Style = Unfavorable;
                //     StyleExpr = TRUE;
                // }

            }

            /* GL2024   group(CustInfoPanel)
                {
                    Caption = 'Customer Information';
                    label()
                    {
                        CaptionClass = Text19070588;
                    }
                    field(STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec));STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfContacts(Rec)))
                    {
                        Editable = false;
                    }
                    label()
                    {
                        CaptionClass = Text19069283;
                    }
                    field(SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No.");SalesInfoPaneMgt.CalcAvailableCredit("Bill-to Customer No."))
                    {
                        DecimalPlaces = 0:0;
                        Editable = false;
                    }
                }*/

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // CurrPage.SalesLines.PAGE.wPassEnt(Rec);
        // IF REC."No." <> xRec."No." THEN BEGIN
        //     wMarked := FALSE;
        //     CurrPage.SalesLines.PAGE.SetAfterGet(PresentationCode);
        // END;

        IF (REC."Project Manager" <> '') AND Contact.GET(REC."Project Manager") THEN
            ProjectManagerName := Contact.Name
        ELSE
            ProjectManagerName := '';
        //POSTING_DESC
        wDescr := REC.wShowPostingDescription(REC."Posting Description");
        //POSTING_DESC//
        IF (REC."Sell-to Contact No." <> '') AND Contact.GET(REC."Sell-to Contact No.") THEN
            ContactName := Contact.GetSalutation(1, REC."Language Code")
        ELSE
            ContactName := '';

        //PROJET_FACT
        IF REC."Rider to Order No." <> '' THEN
            ActivateHeader(FALSE)
        ELSE BEGIN
            ActivateHeader(TRUE);
            //PROJET_FACT//
            IF REC."Job No." <> '' THEN BEGIN
                "Job Starting DateEditable" := FALSE;
                "Job Ending DateEditable" := FALSE;
            END
            ELSE BEGIN
                "Job Starting DateEditable" := TRUE;
                "Job Ending DateEditable" := TRUE;
            END;
            //PROJET_FACT
        END;
        //PROJET_FACT//
        // >> HJ SORO 05-01-2014
        // IF UserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
        //     IF UserSetup."Affaire Par Defaut" <> '' THEN REC.SETFILTER("Job No.", UserSetup."Affaire Par Defaut" + '*');
        // END;
        // >> HJ SORO 05-01-2014
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE(TRUE);
        EXIT(REC.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnEnable := TRUE;
        BillToCommentPictEnable := TRUE;
        SalesHistoryBtnEnable := TRUE;
        DescrEditable := TRUE;
        "Responsibility CenterEditable" := TRUE;
        "Review Base DateEditable" := TRUE;
        "Review Formula CodeEditable" := TRUE;
        "Contract TypeEditable" := TRUE;
        "VAT Bus. Posting GroupEditable" := TRUE;
        "Bill-to NameEditable" := TRUE;
        "Bill-to Customer No.Editable" := TRUE;
        "Payment Terms CodeEditable" := TRUE;
        "Payment Method CodeEditable" := TRUE;
        "Currency CodeEditable" := TRUE;
        "Prices Including VATEditable" := TRUE;
        "Project ManagerEditable" := TRUE;
        "Job DescriptionEditable" := TRUE;
        "Ship-to NameEditable" := TRUE;
        "Job No.Editable" := TRUE;
        "Ship-to CodeEditable" := TRUE;
        "Sell-to Customer NameEditable" := TRUE;
        "Sell-to Customer No.Editable" := TRUE;
        SalesCommentBtnEnable := TRUE;
        BillToCommentBtnEnable := TRUE;
        SellToCommentBtnEnable := TRUE;
        HelpEnable := TRUE;
        WorkFlowBtnEnable := TRUE;
        "Job Ending DateEditable" := TRUE;
        "Job Starting DateEditable" := TRUE;
        wSplashOpened := TRUE;
        wOpenSplash.OPEN(tOpenSplash);
        //wFormEditable := Currpage.EDITABLE;
        wFormEditable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        REC.CheckCreditMaxBeforeInsert;
        // CurrPage.SalesLines.PAGE.wPassEnt(Rec);
        // CurrPage.SalesLines.PAGE.SetAfterGet(PresentationCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        REC."Responsibility Center" := UserMgt.GetSalesFilter();
        REC."Order Type" := REC."Order Type"::" ";
        REC."Document Type" := REC."Document Type"::Order;
        ProjectManagerName := '';
        ContactName := '';
        REC."Commande Affaire" := TRUE;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lMaskMgt: Codeunit "Mask Management";
        lSalesHeader: Record "Sales Header";
        "//HJ": Integer;
        SousAffectation: Record "Affectation Marche";
        LSalesLine: Record "Sales Line";
    begin
        IF wSplashOpened THEN BEGIN
            wSplashOpened := FALSE;
            wOpenSplash.CLOSE;
            //+WKF+ CW 04/08/02 +Workflow Button
            WorkFlowBtnEnable := TRUE;
            HelpEnable := TRUE;
            SellToCommentBtnEnable := TRUE;
            BillToCommentBtnEnable := TRUE;
            SalesCommentBtnEnable := TRUE;
        END;

        //Inutile ? et empêche le lien livraison directe SETRANGE("No.");
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            REC.FILTERGROUP(2);
            REC.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            REC.FILTERGROUP(0);
        END;

        //+ONE+
        //SETRANGE("Date Filter",0D,WORKDATE - 1);
        //+ONE+//

        //#8686
        IF NOT lSalesHeader.GET(REC."Document Type", REC."No.") THEN
            IF REC.FIND('-') THEN;
        //#8686//
        //Currpage.SalesLines.PAGE.SetUpdateAllowed(wFormEditable);
        NavibatSetup.GET2;

        ShowExtendedText := TRUE;

        //MASK
        lMaskMgt.SalesHeader(Rec);
        //MASK//
        // Remplir Sous Affectation HJ Soro 11-06-2016
        LSalesLine.SETRANGE("Document Type", REC."Document Type");
        LSalesLine.SETRANGE("Document No.", REC."No.");
        LSalesLine.SETRANGE(Type, LSalesLine.Type::Resource);
        IF LSalesLine.FINDFIRST THEN
            REPEAT
                SousAffectation.Code := LSalesLine."No.";
                SousAffectation.Description := LSalesLine.Description;
                SousAffectation.Marche := REC."Job No.";
                IF NOT SousAffectation.INSERT THEN SousAffectation.MODIFY;
            UNTIL LSalesLine.NEXT = 0;
        // REC."Date Debut Decompte" := 0D;
        // REC."Date Fin Decompte" := 0D;
        REC.MODIFY;
        // Remplir Sous Affectation HJ Soro 11-06-2016
        // >> HJ SORO 05-01-2014
        // IF UserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
        //     IF UserSetup."Affaire Par Defaut" <> '' THEN REC.SETFILTER("Job No.", UserSetup."Affaire Par Defaut" + '*');
        // END;
        // >> HJ SORO 05-01-2014
    end;

    var
        Text000: Label 'Impossible d''exécuter cette fonction en mode consultation uniquement';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order";
        //  Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        //  Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        Contact: Record Contact;
        //GL2024  AddressContributors: Page 8004022;
        MoveOption: Option Same,Left,Right,Up,Down;
        OldRec: Record "Sales Header";
        PresentationCode: Code[10];
        ProjectManagerName: Text[30];
        ContactName: Text[250];
        SupplyOrderMgt: Codeunit "Reordering Req. Management";
        wDescr: Text[100];
        NavibatSetup: Record NavibatSetup;
        TextUpdate: Label 'Traitement en cours...';
        Fenetre: Dialog;
        ShowLevel: Integer;
        ShowExtendedText: Boolean;
        wMarked: Boolean;
        wSplashOpened: Boolean;
        wOpenSplash: Dialog;
        tOpenSplash: Label 'Ouverture en cours...';
        wFormEditable: Boolean;
        "// VAr HJ DSFT": Integer;
        RecSalesHeader: Record "Sales Header";

        Text003: Label 'Veuillez Lancer La Commande Avant Impression';
        CduSalesPost: Codeunit "Sales-Post";
        CduSalesPost2: Codeunit SalesPostEvent;
        UserSetup: Record "User Setup";
        Text004: Label 'Voulez vous remettre a zero les avancements de productions avant la nouvelle saisie ?';
        RecSalesLine: Record "Sales Line";

        "Job Starting DateEditable": Boolean;

        "Job Ending DateEditable": Boolean;

        WorkFlowBtnEnable: Boolean;

        HelpEnable: Boolean;

        SellToCommentBtnEnable: Boolean;

        BillToCommentBtnEnable: Boolean;

        SalesCommentBtnEnable: Boolean;
        SalesLinesYPos: Integer;
        TabControlYPos: Integer;
        TabControlHeight: Integer;
        SalesLinesHeight: Integer;

        "Sell-to Customer No.Editable": Boolean;

        "Sell-to Customer NameEditable": Boolean;

        "Ship-to CodeEditable": Boolean;

        "Job No.Editable": Boolean;

        "Ship-to NameEditable": Boolean;

        "Job DescriptionEditable": Boolean;

        "Project ManagerEditable": Boolean;

        "Prices Including VATEditable": Boolean;

        "Currency CodeEditable": Boolean;

        "Payment Method CodeEditable": Boolean;

        "Payment Terms CodeEditable": Boolean;

        "Bill-to Customer No.Editable": Boolean;

        "Bill-to NameEditable": Boolean;

        "VAT Bus. Posting GroupEditable": Boolean;

        "Contract TypeEditable": Boolean;

        "Review Formula CodeEditable": Boolean;

        "Review Base DateEditable": Boolean;

        "Responsibility CenterEditable": Boolean;

        DescrEditable: Boolean;

        SalesHistoryBtnEnable: Boolean;

        BillToCommentPictEnable: Boolean;

        SalesHistoryStnEnable: Boolean;
    //  Text19070588: Label 'Sell-to Customer';
    //  Text19069283: Label 'Bill-to Customer';


    procedure UpdateAllowed(): Boolean
    begin
        IF wFormEditable = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := REC."Sell-to Customer No." <> REC."Bill-to Customer No.";
        SalesHistoryBtnEnable := DifferSellToBillTo;
        BillToCommentPictEnable := DifferSellToBillTo;
        BillToCommentBtnEnable := DifferSellToBillTo;
        //DYS FONCTION obsolet
        // SalesHistoryStnEnable := SalesInfoPaneMgt.DocExist(Rec, REC."Sell-to Customer No.");
        // IF DifferSellToBillTo THEN
        //   SalesHistoryBtnEnable := SalesInfoPaneMgt.DocExist(Rec, REC."Bill-to Customer No.")
    end;

    local procedure ApproveCalcInvDisc()
    begin
        //  CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;


    procedure ActivateHeader(Active: Boolean)
    begin
        "Sell-to Customer No.Editable" := Active;
        "Sell-to Customer NameEditable" := Active;
        "Ship-to CodeEditable" := Active;
        "Job No.Editable" := Active;
        "Ship-to NameEditable" := Active;
        "Job Starting DateEditable" := Active;
        "Job Ending DateEditable" := Active;
        "Job DescriptionEditable" := Active;
        "Project ManagerEditable" := Active;
        "Prices Including VATEditable" := Active;
        "Currency CodeEditable" := Active;
        "Payment Method CodeEditable" := Active;
        "Payment Terms CodeEditable" := Active;
        "Bill-to Customer No.Editable" := Active;
        "Bill-to NameEditable" := Active;
        "VAT Bus. Posting GroupEditable" := Active;
        "Contract TypeEditable" := Active;
        "Review Formula CodeEditable" := Active;
        "Review Base DateEditable" := Active;
        "Responsibility CenterEditable" := Active;
        DescrEditable := Active;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ProjectManagerOnAfterValidate()
    begin
        IF (REC."Project Manager" <> xRec."Project Manager") AND (REC."Project Manager" <> '') THEN
            IF Contact.GET(REC."Project Manager") THEN
                ProjectManagerName := Contact.Name
            ELSE
                ProjectManagerName := '';
        IF REC."Project Manager" = '' THEN
            ProjectManagerName := '';
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        // CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        //   CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PresentationCodeOnAfterValidat()
    begin
        //  CurrPage.SalesLines.PAGE.ShowColumns(PresentationCode);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        REC.SETRANGE("Document Type");
    end;

    local procedure SelltoContactNoOnDeactivate()
    begin
        IF REC."Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
            IF Contact.GET(REC."Sell-to Contact No.") THEN
                ContactName := Contact.GetSalutation(1, REC."Language Code");
        //#4250
        CurrPage.UPDATE;
        //#4250//
    end;
}