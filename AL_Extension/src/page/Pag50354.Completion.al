page 50354 Completion
{
    // //PROJET_FACT GESWAY 04/03/03 Nouveau formulaire de saisie de l'avancement en facturation
    //               ML 11/07/06 #3406 SaveValue à NO car garde le filtre d'une autre affaire.

    Caption = 'Completion';
    DataCaptionExpression = STRSUBSTNO('%1 %2', Job."No.", Job.Description);
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = 37;
    // SourceTableView = SORTING("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.") WHERE("Order Type" = CONST(" "), "Document Type" = CONST(Order), Option = CONST(false));
    //HS
    // SourceTableView = sorting("Document No.", "Line No.", "Document Type") WHERE("Order Type" = CONST(" "), "Document Type" = CONST(Order), Option = CONST(false));
    SourceTableView = SORTING("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.")
                    WHERE("Order Type" = CONST(" "),
                          "Document Type" = CONST(Order),
                          Option = CONST(false));
    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                ShowCaption = false;
                field(DocNoFilter; DocNoFilter)
                {
                    Caption = 'N° document';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lSalesHeader: Record 36;
                    begin
                        lSalesHeader.SETCURRENTKEY("Job No.");
                        lSalesHeader.SETRANGE("Job No.", Rec."Job No.");
                        lSalesHeader.SETRANGE("Document Type", lSalesHeader."Document Type"::Order);
                        lSalesHeader.SETRANGE(Status, lSalesHeader.Status::Released);
                        lSalesHeader.SETRANGE("Order Type", lSalesHeader."Order Type"::" ");
                        IF Page.RUNMODAL(Page::"Sales List", lSalesHeader) = ACTION::LookupOK THEN BEGIN
                            DocNoFilter := lSalesHeader."No.";
                            SetFilters;
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        DocNoFilterOnAfterValidate;
                    end;
                }
                field(SellToNoFilter; SellToNoFilter)
                {
                    Caption = 'N° donneur d''ordre';
                    TableRelation = Customer;

                    trigger OnValidate()
                    begin
                        SellToNoFilterOnAfterValidate;
                    end;
                }
            }
            repeater("Lines")
            {
                IndentationColumn = "Internal DescriptionIndent";
                IndentationControls = wDescription;
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(PresentationCodeText; PresentationCodeText)
                {
                    CaptionClass = Rec.FIELDCAPTION("Presentation Code");
                    Editable = false;
                    Visible = false;
                }
                field(Level; Rec.Level)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = LevelEmphasize;
                    Visible = false;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Marker; Rec.Marker)
                {
                    Editable = false;
                    caption = 'Repère';
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line Type"; Rec."Line Type")
                {
                    Editable = false;
                    caption = 'Type de ligne';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = "No.Emphasize";

                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(wDescription; wDescription)
                {
                    Caption = 'Désignation';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = wDescriptionEmphasize;
                }
                field("Internal Description"; Rec."Internal Description")
                {
                    Editable = "Internal DescriptionEditable";
                    Style = Strong;
                    StyleExpr = "Internal DescriptionEmphasize";
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Caption = 'Quantité prévue';
                    Editable = false;

                }
                field("Previous Prod. Completion %"; Rec."Previous Prod. Completion %")
                {
                    Editable = false;
                    caption = '% déjà réalisé';
                }
                field(NewShipPerc; NewShipPerc)
                {
                    BlankZero = true;
                    Caption = '% réalisé cumulé';
                    DecimalPlaces = 2 : 5;
                    Editable = NewShipPercEditable;
                    MaxValue = 100;
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Line Type");
                        IF Rec."Line Type" = Rec."Line Type"::Other THEN
                            ERROR(tProdForbidden);
                        CalcNewCompletion(6);
                        NewShipPercOnAfterValidate;
                    end;
                }
                field(OldQty; OldQty)
                {
                    BlankZero = true;
                    Caption = 'Quantité déjà réalisée';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        ShowOldQty(TRUE);
                    end;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    BlankZero = true;
                    Caption = 'Nouvelle quantité réalisée';
                    Editable = "Qty. to ShipEditable";

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Line Type");
                        //CalcNewCompletion(5);
                        QtytoShipOnAfterValidate;
                    end;
                }
                field(NewShipQuanitity; NewShipQty)
                {
                    BlankZero = true;
                    Caption = 'Quantité réalisée cumulée';
                    DecimalPlaces = 0 : 5;
                    Editable = NewShipQuanitityEditable;

                    trigger OnValidate()
                    begin
                        Rec.TESTFIELD("Line Type");
                        CalcNewCompletion(5);
                        NewShipQtyOnAfterValidate;
                    end;
                }
                field(CancelProd; wProdCancel)
                {
                    Caption = 'Annuler avancement en production';
                    Editable = CancelProdEditable;

                    trigger OnValidate()
                    begin
                        wProdCancelOnPush;
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Visible = false;
                }
            }
            field(ShowDetailFilter; ShowDetailFilter)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("F&unctions1")
            {
                Caption = 'Fonction&s';
                actionref("New Completion1"; "New Completion")
                {

                }
                actionref("Batch Post Product Sales1"; "Batch Post Product Sales")
                {

                }
                actionref("Void Prod. Completion1"; "Void Prod. Completion")
                {

                }
            }
        }
        area(processing)
        {
            action("Hide/Show Extended Text")
            {
                Caption = 'Masquer/Afficher texte étendu';

                Visible = false;

                trigger OnAction()
                begin
                    ShowDetailFilter := NOT ShowDetailFilter;
                    SetFilters;
                end;
            }
            group("F&unctions")
            {
                Caption = 'Fonction&s';
                action("New Completion")
                {
                    Caption = 'Nouvel avancement';

                    trigger OnAction()
                    begin
                        SalesLine.COPY(Rec);
                        CurrPage.SETSELECTIONFILTER(SalesLine);
                        CLEAR(SetNew);
                        SetNew.SETTABLEVIEW(SalesLine);
                        SetNew.RUNMODAL;
                        CurrPage.UPDATE;
                    end;
                }
                action("Batch Post Product Sales")
                {
                    Caption = 'Valider avancement en production';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        lBatchPost: Report "Batch Post Product Sales";
                    begin
                        SalesLine.COPYFILTERS(Rec);
                        SalesLine.SETRANGE("Job No.", Rec."Job No.");
                        SalesLine.SETFILTER("Qty. to Ship", '<>0');
                        CLEAR(SalesHeader);
                        IF SalesLine.FIND('-') THEN
                            REPEAT
                                IF SalesHeader."No." <> SalesLine."Document No." THEN BEGIN
                                    SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                                    SalesHeader.MARK(TRUE);
                                END;
                            UNTIL SalesLine.NEXT = 0;
                        SalesHeader.MARKEDONLY(TRUE);
                        CLEAR(lBatchPost);
                        lBatchPost.wInitializeRequest(TRUE, FALSE);
                        lBatchPost.SETTABLEVIEW(SalesHeader);
                        lBatchPost.UseRequestPage(TRUE);
                        lBatchPost.RUNMODAL;
                        CurrPage.UPDATE;
                    end;
                }
                action("Void Prod. Completion")
                {
                    Caption = 'Annuler avancement prod.';
                    RunObject = Codeunit 8003985;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        wDescriptionIndent := 0;
        /*CW 21/09/07 +one+prepayment
        IF SalesHeader."No." <> "Document No." THEN BEGIN
          SalesHeader.GET("Document Type","Document No.");
          SalesHeader.TESTFIELD(Status,SalesHeader.Status::Released);
        END;
        */

        ShowOldQty(FALSE);
        ShowInvQty(FALSE);
        CalcNewCompletion(10);

        IF Rec."Internal Description" <> '' THEN
            wDescription := Rec."Internal Description"
        ELSE
            wDescription := Rec.Description;
        //#4682
        wProdCancel := (Rec."Line Type" = Rec."Line Type"::Structure) AND
                       (Rec."Qty. to Ship" = -Rec."Quantity Shipped") AND
                       (Rec.Quantity <> Rec."Outstanding Quantity");
        //#4682//
        PresentationCodeText := FORMAT(Rec."Presentation Code");
        PresentationCodeTextOnFormat(PresentationCodeText);
        LevelOnFormat;
        NoOnFormat;
        wDescriptionOnFormat;
        InternalDescriptionOnFormat;
        QuantityOnFormat;
        PreviousProdCompletion37OnForm;
        NewShipPercOnFormat;
        QtytoShipOnFormat;
        NewShipQtyOnFormat;

    end;

    trigger OnInit()
    begin
        NewShipPercEditable := TRUE;
        NewShipQuanitityEditable := TRUE;
        CancelProdEditable := TRUE;
        "Qty. to ShipEditable" := TRUE;
        "Internal DescriptionEditable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.GETFILTER("Document No.") <> '' THEN
            DocNoFilter := Rec.GETFILTER("Document No.");
        SetFilters;
    end;

    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        SetNew: Report 8003989;
        TextInvExist: Label 'Vous ne pouvez pas modifer l''avancement de la ligne %1 car il existe une facture %2.';
        NewShipQty: Decimal;
        NewShipPerc: Decimal;
        OldQty: Decimal;
        "--": Integer;
        Job: Record 8004160;
        SellToNoFilter: Code[20];
        DocNoFilter: Text[30];
        ShowDetailFilter: Boolean;
        wDescription: Text[100];
        wProdCancel: Boolean;
        tNoInvoice: Label 'Il n''y a pas de situation en cours pour cette ligne';
        tProdForbidden: Label 'Vous ne pouvez pas avancer en production des lignes de type Autre';
        [InDataSet]
        PresentationCodeText: Text[1024];
        [InDataSet]
        LevelEmphasize: Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        wDescriptionEmphasize: Boolean;
        [InDataSet]
        wDescriptionIndent: Integer;
        [InDataSet]
        "Internal DescriptionEmphasize": Boolean;
        [InDataSet]
        "Internal DescriptionIndent": Integer;
        [InDataSet]
        "Internal DescriptionEditable": Boolean;
        [InDataSet]
        "Qty. to ShipEditable": Boolean;
        [InDataSet]
        CancelProdEditable: Boolean;
        [InDataSet]
        NewShipQuanitityEditable: Boolean;
        [InDataSet]
        NewShipPercEditable: Boolean;


    procedure CalcNewCompletion(pValueType: Option Tantieme,Quantity,Amount,Percentage,ProdTantieme,ProdQuantity,ProdPercentage)
    var
        lLastCompletion: Boolean;
    begin
        CLEAR(lLastCompletion);
        IF pValueType < 4 THEN BEGIN
            IF SalesHeader."No." <> Rec."Document No." THEN
                SalesHeader.GET(Rec."Document Type", Rec."Document No.");
            SalesHeader.TESTFIELD("Invoicing Method", SalesHeader."Invoicing Method"::Completion);
            /*
              SalesLine.RESET;
              SalesLine.SETRANGE("Document Type","Document Type"::Order);
              SalesLine.SETRANGE("Document No.","Document No.");
              SalesLine.SETFILTER("Invoice No.",'<>%1','');
            //  SalesLine.SETRANGE("Invoice Line No.","Line No.");
              IF NOT SalesLine.ISEMPTY THEN
                ERROR(TextInvExist,"Line No.","Invoice No.");
            */
        END;

        CASE pValueType OF
            /*
              pValueType::Quantity :
                IF NewQty = Quantity THEN
                  lLastCompletion := TRUE
                ELSE IF Quantity <> 0 THEN
                  NewPerc := NewQty * 100 / Quantity
                ELSE
                  NewPerc := 0;
              pValueType::Amount :
                IF NewAmount = "Line Amount" THEN
                  lLastCompletion := TRUE
                ELSE IF "Line Amount" <> 0 THEN
                  NewPerc := NewAmount * 100 / "Line Amount"
                ELSE
                  NewPerc := 0;
              pValueType::Percentage :
                IF NewPerc = 100 THEN
                  lLastCompletion := TRUE;
            */
            pValueType::ProdQuantity:
                IF NewShipQty = Rec.Quantity THEN
                    lLastCompletion := TRUE
                ELSE
                    IF Rec.Quantity <> 0 THEN
                        NewShipPerc := NewShipQty * 100 / Rec.Quantity
                    ELSE
                        NewShipPerc := 0;
            pValueType::ProdPercentage:
                BEGIN
                    IF NewShipPerc = 100 THEN
                        lLastCompletion := TRUE;
                END;
            ELSE BEGIN
                IF Rec."Qty. to Ship" <> 0 THEN BEGIN
                    NewShipQty := Rec."Qty. to Ship" + Rec."Quantity Shipped";
                    IF Rec.Quantity <> 0 THEN
                        NewShipPerc := (Rec."Qty. to Ship" + Rec."Quantity Shipped") * 100 / Rec.Quantity
                    ELSE
                        NewShipPerc := 0;
                END ELSE BEGIN
                    NewShipQty := 0;
                    NewShipPerc := 0;
                END;
                EXIT;
            END;
        END;

        UpdateLine(Rec, lLastCompletion, pValueType, 0, 0);
        IF Rec."Line Type" = Rec."Line Type"::Totaling THEN BEGIN                         //MAJ détail du lot
            TotalingLine(0, NewShipPerc, Rec."Document No.", Rec."Line No.", Rec."Presentation Code");
            rec.MODIFY;
        END;

    end;


    procedure UpdateLine(var pSalesLine: Record 37; pLastCompletion: Boolean; pValueType: Option Tantieme,Quantity,Amount,Percentage,ProdTantieme,ProdQuantity,ProdPercentage; pNewPerc: Decimal; pNewShipPerc: Decimal)
    begin
        IF ((pSalesLine.Quantity = 0) AND (pSalesLine."Line Type" <> pSalesLine."Line Type"::Totaling)) OR
           (pSalesLine."Line Type" = pSalesLine."Line Type"::Totaling) THEN
            EXIT;
        //IF pNewPerc <> 0 THEN
        //  NewPerc := pNewPerc;
        IF pNewShipPerc <> 0 THEN
            NewShipPerc := pNewShipPerc;
        IF pValueType < 4 THEN BEGIN          //Avancement en facturation
                                              /*
                                                IF pLastCompletion THEN BEGIN
                                                  pSalesLine.CALCFIELDS("Previous Completion %");
                                                  IF pSalesLine."Previous Completion %" <> 100 THEN BEGIN
                                                    NewQty := pSalesLine.Quantity;
                                                    NewAmount := pSalesLine."Line Amount";
                                                    NewPerc := 100;
                                                  END ELSE
                                                    NewPerc := 0;
                                                END ELSE BEGIN
                                                  NewTantieme := pSalesLine.Tantieme * NewPerc / 100;
                                                  NewQty := pSalesLine.Quantity * NewPerc / 100;
                                                  NewAmount := pSalesLine."Line Amount" * NewPerc / 100;
                                                END;
                                                IF NewPerc <> 0 THEN
                                                  pSalesLine.VALIDATE("New Completion %",NewPerc)
                                                ELSE BEGIN
                                                  pSalesLine."New Completion %" := 0;
                                                  pSalesLine."Completion Amount" := 0;
                                                END;
                                              */
        END ELSE BEGIN                 //Avancement en production
            IF pLastCompletion THEN BEGIN
                NewShipQty := pSalesLine.Quantity;
                NewShipPerc := 100;
            END ELSE BEGIN
                NewShipQty := pSalesLine.Quantity * NewShipPerc / 100;
            END;
            IF pSalesLine.Type <> pSalesLine.Type::" " THEN BEGIN
                IF NewShipQty = 0 THEN
                    pSalesLine.VALIDATE("Qty. to Ship", 0)
                //    ELSE IF NewShipQty - pSalesLine."Quantity Shipped" > 0 THEN
                ELSE
                    IF NewShipQty - pSalesLine."Quantity Shipped" <> 0 THEN
                        pSalesLine.VALIDATE("Qty. to Ship", NewShipQty - pSalesLine."Quantity Shipped");
                pSalesLine.VALIDATE("Qty. to Invoice", 0);
                //#6698
                pSalesLine."Completely Shipped" := (pSalesLine.Quantity <> 0) AND (pSalesLine."Outstanding Quantity" = 0) AND
                  (pSalesLine."Qty. to Ship" >= 0);
                //#6698//
            END;
        END;
        pSalesLine.MODIFY;

    end;


    procedure TotalingLine(pLotPerc: Decimal; pLotShipPerc: Decimal; pDocNo: Code[20]; pAttLineNo: Integer; pPresCode: Code[10])
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", pDocNo);
        SalesLine.SETFILTER("Line Type", '<>0');
        SalesLine.SETFILTER("Presentation Code", '%1', '  ' + pPresCode + '*');
        SalesLine.SETRANGE("Structure Line No.", 0);
        IF SalesLine.FIND('-') THEN
            REPEAT
                //IF (pLotPerc <> 0) AND (SalesLine."New Completion %" = 0) AND
                IF (pLotPerc <> 0) AND NOT Rec.Option AND (SalesLine."Assignment Basis" = 0) THEN
                    UpdateLine(SalesLine, pLotPerc = 100, 3, pLotPerc, 0);
                IF (pLotShipPerc <> 0) AND (SalesLine."Qty. to Ship" = 0) THEN
                    UpdateLine(SalesLine, pLotShipPerc = 100, 6, 0, pLotShipPerc);
            UNTIL SalesLine.NEXT = 0;

        CLEAR(pLotPerc);
        CLEAR(pLotShipPerc);
        CLEAR(pAttLineNo);
    end;


    procedure SetFilters()
    var
        lSalesHeader: Record 36;
    begin
        IF ShowDetailFilter THEN
            Rec.SETFILTER("Line Type", '<>%1', Rec."Line Type"::Other)
        ELSE
            Rec.SETFILTER("Line Type", '<>%1&<>%2', Rec."Line Type"::" ", Rec."Line Type"::Other);

        IF DocNoFilter = '' THEN
            Rec.SETRANGE("Document No.")
        ELSE BEGIN
            Rec.SETRANGE("Document Type", Rec."Document Type"::Order);
            Rec.SETFILTER("Document No.", DocNoFilter);
        END;
        IF SellToNoFilter = '' THEN
            Rec.SETRANGE("Sell-to Customer No.")
        ELSE
            Rec.SETFILTER("Sell-to Customer No.", SellToNoFilter);

        //#5134
        IF lSalesHeader.GET(Rec."Document Type"::Order, DocNoFilter) THEN BEGIN
            IF Job.GET(lSalesHeader."Job No.") THEN;
        END ELSE
            IF Rec.GETFILTER("Job No.") <> '' THEN BEGIN
                IF Job.GET(Rec.GETFILTER("Job No.")) THEN;
            END ELSE
                Job.INIT;
        //#5134//
    end;


    procedure ShowOldQty(pDrillDown: Boolean)
    var
        lComplEntry: Record 8003987;
    begin
        lComplEntry.SETCURRENTKEY("Order No.");
        lComplEntry.SETRANGE("Order No.");
        lComplEntry.SETRANGE("Order No.", Rec."Document No.");
        lComplEntry.SETRANGE("Order Line No.", Rec."Line No.");
        IF NOT pDrillDown THEN BEGIN
            IF lComplEntry.FIND('-') THEN BEGIN
                lComplEntry.CALCSUMS("Quantity Difference");
                OldQty := lComplEntry."Quantity Difference";
            END ELSE
                OldQty := 0;
        END ELSE
            Page.RUNMODAL(0, lComplEntry, lComplEntry."Quantity Difference");
    end;


    procedure ShowInvQty(pDrillDown: Boolean)
    begin
        /*
        lComplEntry.SETCURRENTKEY("Order No.");
        lComplEntry.SETRANGE("Order No.");
        lComplEntry.SETRANGE("Order No.","Document No.");
        lComplEntry.SETRANGE("Order Line No.","Line No.");
        IF NOT pDrillDown THEN BEGIN
          IF lComplEntry.FIND('-') THEN BEGIN
            lComplEntry.CALCSUMS("Quantity Difference");
            InvQty := lComplEntry."Quantity Difference";
          END ELSE
            InvQty := 0;
        END ELSE
          Page.RUNMODAL(0,lComplEntry,lComplEntry."Quantity Difference");
        */

    end;


    procedure DisableField(pRec: Record 37)
    begin
        "Internal DescriptionEditable" := pRec."Supply Order No." = '';
        "Qty. to ShipEditable" := pRec."Supply Order No." = '';
        CancelProdEditable := pRec."Supply Order No." = '';
        NewShipQuanitityEditable := pRec."Supply Order No." = '';
        NewShipPercEditable := pRec."Supply Order No." = '';
    end;

    local procedure NewShipPercOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure QtytoShipOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure NewShipQtyOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure DocNoFilterOnAfterValidate()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SellToNoFilterOnAfterValidate()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure wProdCancelOnActivate()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;

    local procedure wProdCancelOnPush()
    begin
        Rec.TESTFIELD("Line Type");
        IF wProdCancel THEN BEGIN
            Rec.VALIDATE("Qty. to Ship", -Rec."Quantity Shipped");
            //#6698
            Rec."Completely Shipped" := FALSE;
            //#6698//
            Rec.MODIFY;
            NewShipQty := 0;
            NewShipPerc := 0;
        END ELSE BEGIN
            NewShipQty := 0;
            NewShipPerc := 0;
            CalcNewCompletion(6);
        END;
    end;

    local procedure PresentationCodeTextOnFormat(var Text: Text[1024])
    begin
        Text := DELCHR(Text);
    end;

    local procedure LevelOnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := Rec."Line Type" = Rec."Line Type"::Totaling;
        LevelEmphasize := lFontBold;
    end;

    local procedure NoOnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := Rec."Line Type" = Rec."Line Type"::Totaling;
        "No.Emphasize" := lFontBold;
    end;

    local procedure wDescriptionOnFormat()
    var
        lIndent: Integer;
        lFontBold: Boolean;
    begin
        lFontBold := Rec."Line Type" = Rec."Line Type"::Totaling;
        wDescriptionEmphasize := lFontBold;
        lIndent := 0;
        IF rec.Level > 0 THEN BEGIN
            IF (NOT ISSERVICETIER) THEN
                lIndent := (Rec.Level - 1) * 220
            ELSE
                lIndent := (Rec.Level - 1);
        END;
        wDescriptionIndent := lIndent;
    end;

    local procedure InternalDescriptionOnFormat()
    var
        lFontBold: Boolean;
        lIndent: Integer;
    begin
        lFontBold := Rec."Line Type" = Rec."Line Type"::Totaling;
        "Internal DescriptionEmphasize" := lFontBold;
        lIndent := 0;
        IF rec.Level > 0 THEN BEGIN
            IF (NOT ISSERVICETIER) THEN
                lIndent := (Rec.Level - 1) * 220
            ELSE
                lIndent := (Rec.Level - 1);
        END;
        "Internal DescriptionIndent" := lIndent;
    end;

    local procedure QuantityOnFormat()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;

    local procedure PreviousProdCompletion37OnForm()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;

    local procedure NewShipPercOnFormat()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;

    local procedure QtytoShipOnFormat()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;

    local procedure NewShipQtyOnFormat()
    begin
        //#6419
        DisableField(Rec);
        //#6419//
    end;
}

