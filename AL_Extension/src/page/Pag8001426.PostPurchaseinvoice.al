page 8001426 "Post Purchase invoice"
{
    // //POSTING_DESC GESWAY 12/06/03 Gestion "Posting Description" paramétrable
    // //+CH+ CW 07/10/05 +"Payment" tab for DTA
    // //FACT_ACHAT_PERSO CLA 10/06/03 Utilisation CompanySetup
    // //+REF+ACHAT_FACT CLA 04/06/03 Nouveau formulaire de validation
    //                          CLA 10/06/03 Prise en compte des personnalisations
    // //+ABO+ GESWAY 13/06/06 Ajout "Subscription Starting Date","Subscription End Date"
    // //+REF+SOLDE_CDE 17/08/06 Ajout "Solder la commande"

    Caption = 'Valider facture achat';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(Invoicing)
            {
                Caption = 'Facturation';
                field("VendorInvoiceNo."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                    Visible = "VendorInvoiceNo.Visible";
                }
                field("Vendor Cr.MemoNo."; rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                    Visible = "Vendor Cr.MemoNo.Visible";
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                }
                field(ReceiveProp; wReceive)
                {
                    ApplicationArea = all;
                    Caption = 'Réceptionner';
                    Visible = ReceivePropVisible;

                    trigger OnValidate()
                    begin
                        wReceiveOnAfterValidate;
                    end;
                }
                field(CompleteProp; wComplete)
                {
                    ApplicationArea = all;
                    Caption = 'Solder commande';
                    Visible = CompletePropVisible;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("TotalPurchLine[1].Line Amount"; TotalPurchLine[1]."Line Amount")
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text8003900, FALSE);
                    Caption = 'Montant commande';
                    Editable = false;
                }
                field(wAmountAlreadyInvoiced; wAmountAlreadyInvoiced)
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text8003902, FALSE);
                    Caption = 'Montant facturé';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Show Invoice", Rec);
                    end;
                }
                field(AmountToInv; wAmountToInvoice)
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text8003901, FALSE);
                    Editable = AmountToInvEditable;
                    Caption = 'AmountToInv';
                    MinValue = 0;

                    trigger OnValidate()
                    begin
                        wAmountToInvoiceOnAfterValidat;
                    end;
                }
                field(DiscAmount; TotalPurchLine[2]."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Montant remise facture';
                    Editable = DiscAmountEditable;

                    trigger OnValidate()
                    begin
                        UpdateInvDiscAmount(2);
                    end;
                }
                field(TotalAmount; TotalAmount1[2])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, FALSE);
                    Caption = 'Total';
                    Editable = TotalAmountEditable;

                    trigger OnValidate()
                    begin
                        UpdateTotalAmount(2);
                    end;
                }
                field("VATAmount[2]"; VATAmount[2])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = FORMAT(VATAmountText[2]);
                    Caption = 'Montant TVA';
                    Editable = false;
                }
                field("TotalAmount2[2]"; TotalAmount2[2])
                {
                    ApplicationArea = all;
                    AutoFormatExpression = rec."Currency Code";
                    AutoFormatType = 1;
                    CaptionClass = GetCaptionClass(Text001, TRUE);
                    Caption = 'Total TTC';
                    Editable = false;
                }
                field("TempVATAmountLine1.COUNT"; TempVATAmountLine1.COUNT)
                {
                    ApplicationArea = all;
                    Caption = 'No. of VAT Lines';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        VATLinesDrillDown(TempVATAmountLine1, FALSE);
                        UpdateHeaderInfo(1, TempVATAmountLine1);
                    end;
                }
            }

            group(Payment)
            {
                Caption = 'Paiement';
                group(frmCH)
                {
                    Caption = 'DTA';
                    Visible = frmCHVisible;
                    field("DTA Coding Line"; rec."DTA Coding Line")
                    {
                        ApplicationArea = all;

                    }
                    field("Reference No."; rec."Reference No.")
                    {
                        ApplicationArea = all;
                    }

                    field("Bank Code"; rec."Bank Code")
                    {
                        ApplicationArea = all;
                    }
                    field("ESR Amount"; rec."ESR Amount")
                    {
                        ApplicationArea = all;
                    }
                }
            }

            group("Posting Description")
            {
                Caption = 'Libellé écriture';
                ShowCaption = false;
                field(wDescr; wDescr)
                {
                    ApplicationArea = all;
                    Caption = 'Libellé écriture';

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
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        PurchLine: Record 39;
        TempPurchLine: Record 39 temporary;
    begin
        //CurrForm.CAPTION(STRSUBSTNO(Text000,"Document Type"));

        IF PrevNo = rec."No." THEN
            EXIT;
        PrevNo := rec."No.";
        rec.FILTERGROUP(2);
        rec.SETRANGE("No.", PrevNo);
        rec.FILTERGROUP(0);

        //+REF+FACTURATION_ACHAT
        wCalcValues;
        wAmountToInvoice := TotalPurchLine[2]."Line Amount";
        wAmountAlreadyInvoiced := wCalcAmountInvoiced;
        //+REF+FACTURATION_ACHAT//
        //FACT_ACHAT_PERSO
        IF wCompanySetup."ID Generate purch. difference" <> 0 THEN
            wComplete := FALSE
        ELSE
            //FACT_ACHAT_PERSO//
            //+REF+SOLDE_CDE
            wComplete := wAmountToInvoice = TotalPurchLine[1]."Line Amount";
        //+REF+SOLDE_CDE//

        TempVATAmountLine1.MODIFYALL(Modified, FALSE);
        TempVATAmountLine2.MODIFYALL(Modified, FALSE);
        TempVATAmountLine3.MODIFYALL(Modified, FALSE);

        PrevTab := -1;
        //SetVATSpecification(ActiveTab);

        SubformIsReady := TRUE;
        wDescr := rec.wShowPostingDescription(rec."Posting Description");
    end;

    trigger OnInit()
    begin
        TotalAmountEditable := TRUE;
        DiscAmountEditable := TRUE;
        AmountToInvEditable := TRUE;
        frmCHVisible := TRUE;
        CompletePropVisible := TRUE;
        "Vendor Cr.MemoNo.Visible" := TRUE;
        "VendorInvoiceNo.Visible" := TRUE;
        ReceivePropVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        lGLsetup: Record 98;
        lVisible: Boolean;
    begin
        PurchSetup.GET;
        AllowInvDisc :=
          NOT (PurchSetup."Calc. Inv. Discount" AND VendInvDiscRecExists(rec."Invoice Disc. Code"));
        AllowVATDifference :=
          PurchSetup."Allow VAT Difference" AND
          NOT (rec."Document Type" IN [rec."Document Type"::Quote, rec."Document Type"::"Blanket Order"]);
        SubformIsEditable := AllowVATDifference OR AllowInvDisc;

        //+REF+FACTURATION_ACHAT
        //CurrForm.EDITABLE := SubformIsEditable;
        DiscAmountEditable := SubformIsEditable;
        TotalAmountEditable := SubformIsEditable;
        //TRS-2009
        lVisible := rec."Document Type" = rec."Document Type"::Order;
        ReceivePropVisible := lVisible;
        lVisible := rec."Document Type" <= rec."Document Type"::Invoice;
        "VendorInvoiceNo.Visible" := lVisible;
        lVisible := rec."Document Type" > rec."Document Type"::Invoice;
        "Vendor Cr.MemoNo.Visible" := lVisible;
        //TRS-2009//
        ActiveTab := ActiveTab::Invoicing;
        //+REF+FACTURATION_ACHAT//
        //+REF+SOLDE_CDE
        //TRS-2009
        lVisible := rec."Document Type" = rec."Document Type"::Order;
        CompletePropVisible := lVisible;
        //TRS-2009//
        //+REF+SOLDE_CDE//
        //FACT_ACHAT_PERSO
        IF NOT wCompanySetup.GET THEN
            wCompanySetup.INSERT;
        AmountToInvEditable :=
                 (wCompanySetup."ID Generate purch. difference" <> 0) AND
                 (rec."Document Type" = rec."Document Type"::Order);
        //FACT_ACHAT_PERSO//

        //SetVATSpecification(ActiveTab);
        //+CH
        lGLsetup.GET;
        lVisible := lGLsetup.Localization = lGLsetup.Localization::CH;
        frmCHVisible := lVisible;
        //+CH//
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        GetVATSpecification(PrevTab);
        IF TempVATAmountLine1.GetAnyLineModified OR TempVATAmountLine2.GetAnyLineModified THEN
            UpdateVATOnPurchLines;
        EXIT(TRUE);
    end;

    var
        Text000: Label 'Purchase %1 Statistics';
        Text001: Label 'Total';
        Text002: Label 'Amount';
        Text003: Label '%1 must not be 0.';
        Text004: Label '%1 must not be greater than %2.';
        Text005: Label 'You cannot change the invoice discount because there is a %1 record for %2 %3.';
        TotalPurchLine: array[3] of Record 39;
        TotalPurchLineLCY: array[3] of Record 39;
        TempVATAmountLine1: Record 290 temporary;
        TempVATAmountLine2: Record 290 temporary;
        TempVATAmountLine3: Record 290 temporary;
        PurchSetup: Record 312;
        PurchPost: Codeunit 90;
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        VATAmountText: array[3] of Text[30];
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping;
        PrevTab: Option General,Invoicing,Shipping;
        SubformIsReady: Boolean;
        SubformIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        wCompanySetup: Record 8003907;
        wReceive: Boolean;
        wInvoice: Boolean;
        wPrint: Boolean;
        Text8003900: Label 'Order Amount';
        Text8003901: Label 'Amount to Invoice';
        wComplete: Boolean;
        wAmountToInvoice: Decimal;
        wAmountAlreadyInvoiced: Decimal;
        Text8003902: Label 'Invoiced Amount';
        wDescr: Text[100];
        VATLinesForm: Page 9401;
        [InDataSet]

        ReceivePropVisible: Boolean;
        [InDataSet]
        "VendorInvoiceNo.Visible": Boolean;
        [InDataSet]
        "Vendor Cr.MemoNo.Visible": Boolean;
        [InDataSet]
        CompletePropVisible: Boolean;
        [InDataSet]
        frmCHVisible: Boolean;
        [InDataSet]
        AmountToInvEditable: Boolean;
        [InDataSet]
        DiscAmountEditable: Boolean;
        [InDataSet]
        TotalAmountEditable: Boolean;


    procedure wInitRequest(pReceive: Boolean; pInvoice: Boolean; pPrintDoc: Boolean)
    begin
        wReceive := pReceive;
        wInvoice := pInvoice;
        wPrint := pPrintDoc;
    end;


    procedure wFinishRequest(var pReceive: Boolean; var pInvoice: Boolean; var pComplete: Boolean; var pPostingDate: Date)
    begin
        pReceive := wReceive;
        pInvoice := wInvoice;
        pPostingDate := rec."Posting Date";
        //+REF+SOLDE_CDE
        pComplete := wComplete;
        //+REF+SOLDE_CDE//
    end;


    procedure wCalcAmountInvoiced(): Decimal
    var
        lPurchLine: Record 39;
        lPurchInvHeader: Record 122;
        lAmountInvoiced: Decimal;
    begin
        CLEAR(lAmountInvoiced);

        CASE rec."Document Type" OF
            rec."Document Type"::Order:
                BEGIN
                    lPurchInvHeader.SETCURRENTKEY("Order No.");
                    lPurchInvHeader.SETRANGE("Order No.", rec."No.");
                    IF NOT lPurchInvHeader.ISEMPTY THEN BEGIN
                        lPurchInvHeader.FIND('-');
                        REPEAT
                            lPurchInvHeader.CALCFIELDS(Amount);
                            lAmountInvoiced += lPurchInvHeader.Amount;
                        UNTIL lPurchInvHeader.NEXT = 0;
                    END;
                END;
        END;
        EXIT(lAmountInvoiced);
    end;


    procedure wCalcValues()
    var
        PurchLine: Record 39;
        TempPurchLine: Record 39 temporary;
    begin
        CLEAR(PurchLine);
        CLEAR(TotalPurchLine);
        CLEAR(TotalPurchLineLCY);

        FOR i := 1 TO 2 DO BEGIN
            TempPurchLine.DELETEALL;
            CLEAR(TempPurchLine);
            CLEAR(PurchPost);
            PurchPost.GetPurchLines(Rec, TempPurchLine, i - 1);
            CLEAR(PurchPost);

            //3455
            IF NOT wReceive THEN BEGIN
                TempPurchLine."Qty. to Receive" := 0;
                TempPurchLine.MODIFY;
                IF TempPurchLine."Qty. to Invoice" >= TempPurchLine."Qty. Rcd. Not Invoiced" THEN BEGIN
                    TempPurchLine.InitQtyToInvoice;
                    TempPurchLine.MODIFY;
                END;
            END;

            //  CASE i OF
            //    1: PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine1);
            //    2: PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine2);
            //    3: PurchLine.CalcVATAmountLines(0,Rec,TempPurchLine,TempVATAmountLine3);
            //  END;
            CASE i OF
                1:
                    PurchLine.CalcVATAmountLines(-1, Rec, TempPurchLine, TempVATAmountLine1);
                2:
                    PurchLine.CalcVATAmountLines(-1, Rec, TempPurchLine, TempVATAmountLine2);
                3:
                    PurchLine.CalcVATAmountLines(-1, Rec, TempPurchLine, TempVATAmountLine3);
            END;
            //3455//

            PurchPost.SumPurchLinesTemp(
              Rec, TempPurchLine, i - 1, TotalPurchLine[i], TotalPurchLineLCY[i],
              VATAmount[i], VATAmountText[i]);
            IF rec."Prices Including VAT" THEN BEGIN
                TotalAmount2[i] := TotalPurchLine[i].Amount;
                TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                TotalPurchLine[i]."Line Amount" := TotalAmount1[i] + TotalPurchLine[i]."Inv. Discount Amount";
            END ELSE BEGIN
                TotalAmount1[i] := TotalPurchLine[i].Amount;
                TotalAmount2[i] := TotalPurchLine[i]."Amount Including VAT";
            END;
        END;
    end;

    local procedure UpdateHeaderInfo(IndexNo: Integer; var VATAmountLine: Record 290)
    var
        CurrExchRate: Record 330;
        UseDate: Date;
    begin
        TotalPurchLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
        TotalAmount1[IndexNo] :=
          TotalPurchLine[IndexNo]."Line Amount" - TotalPurchLine[IndexNo]."Inv. Discount Amount";
        VATAmount[IndexNo] := VATAmountLine.GetTotalVATAmount;
        IF rec."Prices Including VAT" THEN BEGIN
            TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
            TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
            TotalPurchLine[IndexNo]."Line Amount" :=
              TotalAmount1[IndexNo] + TotalPurchLine[IndexNo]."Inv. Discount Amount";
        END ELSE
            TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];

        IF rec."Prices Including VAT" THEN
            TotalPurchLineLCY[IndexNo].Amount := TotalAmount2[IndexNo]
        ELSE
            TotalPurchLineLCY[IndexNo].Amount := TotalAmount1[IndexNo];
        IF rec."Currency Code" <> '' THEN BEGIN
            IF (rec."Document Type" IN [rec."Document Type"::"Blanket Order", rec."Document Type"::Quote]) AND
               (rec."Posting Date" = 0D)
            THEN
                UseDate := WORKDATE
            ELSE
                UseDate := rec."Posting Date";

            TotalPurchLineLCY[IndexNo].Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, rec."Currency Code", TotalPurchLineLCY[IndexNo].Amount, rec."Currency Factor");
        END;
    end;

    local procedure UpdateTotalAmount(IndexNo: Integer)
    var
        SaveTotalAmount: Decimal;
    begin
        CheckAllowInvDisc;
        IF rec."Prices Including VAT" THEN BEGIN
            SaveTotalAmount := TotalAmount1[IndexNo];
            UpdateInvDiscAmount(IndexNo);
            TotalAmount1[IndexNo] := SaveTotalAmount;
        END;
        WITH TotalPurchLine[IndexNo] DO
            "Inv. Discount Amount" := "Line Amount" - TotalAmount1[IndexNo];
        UpdateInvDiscAmount(IndexNo);
    end;

    local procedure UpdateInvDiscAmount(ModifiedIndexNo: Integer)
    var
        PartialInvoicing: Boolean;
        MaxIndexNo: Integer;
        IndexNo: array[2] of Integer;
        i: Integer;
        InvDiscBaseAmount: Decimal;
    begin
        CheckAllowInvDisc;
        IF NOT (ModifiedIndexNo IN [1, 2]) THEN
            EXIT;

        IF ModifiedIndexNo = 1 THEN
            InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(FALSE, rec."Currency Code")
        ELSE
            InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(FALSE, rec."Currency Code");

        IF InvDiscBaseAmount = 0 THEN
            ERROR(Text003, TempVATAmountLine2.FIELDCAPTION("Inv. Disc. Base Amount"));

        IF TotalPurchLine[ModifiedIndexNo]."Inv. Discount Amount" / InvDiscBaseAmount > 1 THEN
            ERROR(
              Text004,
              TotalPurchLine[ModifiedIndexNo].FIELDCAPTION("Inv. Discount Amount"),
              TempVATAmountLine2.FIELDCAPTION("Inv. Disc. Base Amount"));

        PartialInvoicing := (TotalPurchLine[1]."Line Amount" <> TotalPurchLine[2]."Line Amount");

        IndexNo[1] := ModifiedIndexNo;
        IndexNo[2] := 3 - ModifiedIndexNo;
        IF (ModifiedIndexNo = 2) AND PartialInvoicing THEN
            MaxIndexNo := 1
        ELSE
            MaxIndexNo := 2;

        IF NOT PartialInvoicing THEN
            IF ModifiedIndexNo = 1 THEN
                TotalPurchLine[2]."Inv. Discount Amount" := TotalPurchLine[1]."Inv. Discount Amount"
            ELSE
                TotalPurchLine[1]."Inv. Discount Amount" := TotalPurchLine[2]."Inv. Discount Amount";

        FOR i := 1 TO MaxIndexNo DO BEGIN
            WITH TotalPurchLine[IndexNo[i]] DO BEGIN
                IF (i = 1) OR NOT PartialInvoicing THEN
                    IF IndexNo[i] = 1 THEN BEGIN
                        TempVATAmountLine1.SetInvoiceDiscountAmount(
                          "Inv. Discount Amount", "Currency Code", rec."Prices Including VAT", rec."VAT Base Discount %");
                    END ELSE BEGIN
                        TempVATAmountLine2.SetInvoiceDiscountAmount(
                          "Inv. Discount Amount", "Currency Code", rec."Prices Including VAT", rec."VAT Base Discount %");
                    END;

                IF (i = 2) AND PartialInvoicing THEN
                    IF IndexNo[i] = 1 THEN BEGIN
                        InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(FALSE, "Currency Code");
                        IF InvDiscBaseAmount = 0 THEN
                            TempVATAmountLine1.SetInvoiceDiscountPercent(
                              0, "Currency Code", rec."Prices Including VAT", FALSE, rec."VAT Base Discount %")
                        ELSE
                            TempVATAmountLine1.SetInvoiceDiscountPercent(
                              100 * TempVATAmountLine2.GetTotalInvDiscAmount / InvDiscBaseAmount,
                              "Currency Code", rec."Prices Including VAT", FALSE, rec."VAT Base Discount %");
                    END ELSE BEGIN
                        InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(FALSE, "Currency Code");
                        IF InvDiscBaseAmount = 0 THEN
                            TempVATAmountLine2.SetInvoiceDiscountPercent(
                              0, "Currency Code", rec."Prices Including VAT", FALSE, rec."VAT Base Discount %")
                        ELSE
                            TempVATAmountLine2.SetInvoiceDiscountPercent(
                              100 * TempVATAmountLine1.GetTotalInvDiscAmount / InvDiscBaseAmount,
                              "Currency Code", rec."Prices Including VAT", FALSE, rec."VAT Base Discount %");
                    END;
            END;
        END;

        UpdateHeaderInfo(1, TempVATAmountLine1);
        UpdateHeaderInfo(2, TempVATAmountLine2);

        IF ModifiedIndexNo = 1 THEN
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine1)
        ELSE
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine2);

        rec."Invoice Discount Calculation" := rec."Invoice Discount Calculation"::Amount;
        rec."Invoice Discount Value" := TotalPurchLine[1]."Inv. Discount Amount";
        rec.MODIFY;
        UpdateVATOnPurchLines;
    end;

    local procedure GetCaptionClass(FieldCaption: Text[100]; ReverseCaption: Boolean): Text[80]
    begin
        IF rec."Prices Including VAT" XOR ReverseCaption THEN
            EXIT('2,1,' + FieldCaption)
        ELSE
            EXIT('2,0,' + FieldCaption);
    end;

    local procedure UpdateVATOnPurchLines()
    var
        PurchLine: Record 39;
    begin
        GetVATSpecification(ActiveTab);
        IF TempVATAmountLine1.GetAnyLineModified THEN
            PurchLine.UpdateVATOnLines(0, Rec, PurchLine, TempVATAmountLine1);
        IF TempVATAmountLine2.GetAnyLineModified THEN
            PurchLine.UpdateVATOnLines(1, Rec, PurchLine, TempVATAmountLine2);
        PrevNo := '';
    end;

    local procedure VendInvDiscRecExists(InvDiscCode: Code[20]): Boolean
    var
        VendInvDisc: Record 24;
    begin
        VendInvDisc.SETRANGE(Code, InvDiscCode);
        EXIT(VendInvDisc.FIND('-'));
    end;

    local procedure CheckAllowInvDisc()
    var
        VendInvDisc: Record 24;
    begin
        IF NOT AllowInvDisc THEN
            ERROR(
              Text005,
              VendInvDisc.TABLECAPTION, rec.FIELDCAPTION("Invoice Disc. Code"), rec."Invoice Disc. Code");
    end;


    procedure VATLinesDrillDown(var VATLinesToDrillDown: Record 290; ThisTabAllowsVATEditing: Boolean)
    begin
        CLEAR(VATLinesForm);
        VATLinesForm.SetTempVATAmountLine(VATLinesToDrillDown);
        VATLinesForm.InitGlobals(
          rec."Currency Code", AllowVATDifference, AllowVATDifference AND ThisTabAllowsVATEditing,
          rec."Prices Including VAT", AllowInvDisc, rec."VAT Base Discount %");
        VATLinesForm.RUNMODAL;
        VATLinesForm.GetTempVATAmountLine(VATLinesToDrillDown);
    end;

    local procedure GetVATSpecification(QtyType: Option General,Invoicing,Shipping)
    begin
        CASE QtyType OF
            QtyType::General:
                BEGIN
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine1);
                    UpdateHeaderInfo(1, TempVATAmountLine1);
                END;
            QtyType::Invoicing:
                BEGIN
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine2);
                    UpdateHeaderInfo(2, TempVATAmountLine2);
                END;
            QtyType::Shipping:
                VATLinesForm.GetTempVATAmountLine(TempVATAmountLine3);
        END;
    end;

    local procedure wAmountToInvoiceOnAfterValidat()
    var
        lCompanySetup: Record 8003907;
        lPurchHeader: Record 38;
        PurchLine: Record 39;
        TempPurchLine: Record 39 temporary;
    begin
        wComplete := (wAmountToInvoice = TotalPurchLine[1]."Line Amount") AND wInvoice;
        //FACTURATION_ACHAT
        IF wAmountToInvoice <> (TotalPurchLine[1]."Line Amount" - wAmountAlreadyInvoiced) THEN BEGIN
            //FACTURATION_ACHAT_PERSO
            lCompanySetup.GET;
            IF lCompanySetup."ID Generate purch. difference" <> 0 THEN BEGIN
                lPurchHeader.INIT;
                lPurchHeader."Document Type" := rec."Document Type";
                lPurchHeader."No." := rec."No.";
                lPurchHeader.Amount := wAmountToInvoice;
                lPurchHeader."Amount Including VAT" := wAmountAlreadyInvoiced;
                lPurchHeader."Price Offer Amount" := TotalPurchLine[1]."Line Amount";
                CODEUNIT.RUN(lCompanySetup."ID Generate purch. difference", lPurchHeader);
            END;
            //FACTURATION_ACHAT_PERSO//
            wCalcValues;
            UpdateInvDiscAmount(2);
        END;
        //FACTURATION_ACHAT//
    end;

    local procedure wReceiveOnAfterValidate()
    begin
        //+REF+FACTURATION_ACHAT
        TempVATAmountLine1.MODIFYALL(Modified, FALSE);
        TempVATAmountLine2.MODIFYALL(Modified, FALSE);
        TempVATAmountLine3.MODIFYALL(Modified, FALSE);
        wCalcValues;
        wAmountToInvoice := TotalPurchLine[2]."Line Amount";
        PrevTab := -1;
        //SetVATSpecification(ActiveTab);
        CurrPage.UPDATE(FALSE);
        SubformIsReady := TRUE;
        //+REF+FACTURATION_ACHAT//
    end;
}

