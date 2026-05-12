codeunit 50043 ReqWkshMakeOrderEvent
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        wSalesLine: Record "Sales Line";
        wPriceOfferSetup: Record "Price Offer Setup";
        wTotalNeedParam: Record "Sales Document Cost";
        wSubcontractingMgt: Codeunit "Subcontracting Management";
        wSubcontractor: Boolean;
        wConsult: Boolean;
        TextReference: Label 'Selon votre offre %1';
        wPurchType: Option " ",Direct,Special;
        lPurchType: Option " ",Direct,Special;
        wPrevLineType: Option " ","G/L Account",Item;
        wQuoteCount: Integer;
        wOrderCount: Integer;
        wOrderKO: Boolean;
        NextLineNo: integer;
        PurchOrderLine: Record "Purchase Line";
        PurchOrderHeader: Record "Purchase Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRun(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    begin
        //+OFF+OFFRE
        IF wPriceOfferSetup.READPERMISSION THEN
            IF NOT wPriceOfferSetup.GET THEN
                wPriceOfferSetup.INIT;
        //+OFF+OFFRE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnCheckRequisitionLineOnNonCancelActionMessageOnBeforeCheckUOM', '', true, true)]
    local procedure OnCheckRequisitionLineOnNonCancelActionMessageOnBeforeCheckUOM(var ReqLine2: Record "Requisition Line"; var PurchasingCode: Record Purchasing; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        if SalesLine.Get(SalesLine."Document Type"::Order, ReqLine2."Sales Order No.", ReqLine2."Sales Order Line No.") and
              (SalesLine."Unit of Measure Code" <> ReqLine2."Unit of Measure Code")
           then
            //CONSULT
        IF SalesLine."Document Type" <> SalesLine."Document Type"::Order THEN
                IsHandled := true;
        //CONSULT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforeCheckInsertFinalizePurchaseOrderHeader', '', true, true)]
    local procedure OnBeforeCheckInsertFinalizePurchaseOrderHeader(RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var CheckInsert: Boolean; var OrderCounter: Integer; var PrevPurchCode: Code[10]; PrevLocationCode: Code[10]; var PrevShipToCode: Code[10]; var UpdateAddressDetails: Boolean; var CheckAddressDetailsResult: Boolean; ReceiveDateReq: Date)
    begin
        //PROJET
        IF (PurchaseHeader."Job No." <> RequisitionLine."Job No.") then
            CheckAddressDetailsResult := true
        else
            CheckAddressDetailsResult := false;
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforeInsertPurchOrderLine', '', true, true)]
    local procedure OnBeforeInsertPurchOrderLine(var RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var NextLineNo: Integer; var IsHandled: Boolean; var PrevPurchCode: code[10]; var PrevShipToCode: code[10]; var PlanningResiliency: boolean; TempDocumentEntry: Record "Document Entry" temporary; var SuppressCommit: Boolean; var PostingDateReq: date; var ReferenceReq: text[35]; var OrderDateReq: date; var ReceiveDateReq: date; var OrderCounter: integer; var HideProgressWindow: Boolean; var PrevLocationCode: code[10]; var LineCount: Integer; var PurchOrderHeader: Record "Purchase Header"; PurchasingCode: record Purchasing; var PurchOrderLine: Record "Purchase Line")
    var
        lInsertText: Boolean;
        lPurchCode: Record Purchasing;
        lStructureLine: Record "Sales Line";

    begin
        IF (RequisitionLine."No." = '') OR (RequisitionLine."Vendor No." = '') OR (RequisitionLine.Quantity = 0) THEN
            EXIT;
        //CDE_INTERNE
        IF PrevPurchCode <> RequisitionLine."Purchasing Code" THEN BEGIN
            IF NOT lPurchCode.GET(RequisitionLine."Purchasing Code") THEN BEGIN
                lPurchCode.INIT;
                lPurchType := lPurchType::" ";
            END ELSE BEGIN
                IF lPurchCode."Drop Shipment" THEN
                    lPurchType := lPurchType::Direct
                ELSE
                    IF lPurchCode."Special Order" THEN
                        lPurchType := lPurchType::Special
                    ELSE
                        lPurchType := lPurchType::" ";
            END;
        END ELSE
            lPurchType := wPurchType;
        //CDE_INTERNE//
        //SUBCONTRACTOR
        IF wPrevLineType = wPrevLineType::" " THEN
            lPurchType := wPurchType;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnBeforeInsertHeader', '', true, true)]
    local procedure OnInsertPurchOrderLineOnBeforeInsertHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var LineCount: Integer; var NextLineNo: Integer; var IsHandled: Boolean)
    begin
        //PROJET
        IF (PurchaseHeader."Job No." <> RequisitionLine."Job No.") OR
         (lPurchType <> wPurchType) then begin
            IsHandled := false;
            //SUBCONTRACTOR
            wPurchType := lPurchType;
            wPrevLineType := RequisitionLine.Type;
            //SUBCONTRACTOR//
        end

        else
            IsHandled := true;

        //     (PrevPurchCode <> "Purchasing Code")
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnAfterCheckInsertFinalizePurchaseOrderHeader', '', true, true)]
    local procedure OnInsertPurchOrderLineOnAfterCheckInsertFinalizePurchaseOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var NextLineNo: Integer)
    begin
        //SUBCONTRACTOR
        IF (RequisitionLine."Sales Order No." <> wSalesLine."Document No.") OR
           (RequisitionLine."Sales Order Line No." <> wSalesLine."Line No.") OR
           (RequisitionLine."Sales Document Type" <> wSalesLine."Document Type")
        THEN
            IF NOT wSalesLine.GET(RequisitionLine."Sales Document Type" - 1, RequisitionLine."Sales Order No.", RequisitionLine."Sales Order Line No.") THEN
                wSalesLine.INIT
            ELSE
                wSubcontractor := (wSalesLine."Vendor No." <> '') AND
                                  NOT wSalesLine.Disable AND
                                  (wSalesLine.Subcontracting <> wSalesLine.Subcontracting::" ");
        IF wSubcontractor AND (RequisitionLine.Type = RequisitionLine.Type::" ") THEN BEGIN
            wInsertTextLine(RequisitionLine);
            EXIT;
        END;
        //SUBCONTRACTOR//
        //CONSULT
        wInsertRefLine(RequisitionLine);
        //CONSULT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInitPurchOrderLineOnAfterValidateLineDiscount', '', true, true)]
    local procedure OnInitPurchOrderLineOnAfterValidateLineDiscount(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    begin
        //OFFRE_DE_PRIX
        //  PurchOrderLine."Document Type" := PurchOrderLine."Document Type"::Order;
        PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
        //OFFRE_DE_PRIX//
        //QUANTITE
        PurchOrderLine."Value 1" := RequisitionLine."Value 1";
        PurchOrderLine."Value 2" := RequisitionLine."Value 2";
        PurchOrderLine."Value 3" := RequisitionLine."Value 3";
        PurchOrderLine."Value 4" := RequisitionLine."Value 4";
        PurchOrderLine."Value 5" := RequisitionLine."Value 5";
        PurchOrderLine."Value 6" := RequisitionLine."Value 6";
        PurchOrderLine."Value 7" := RequisitionLine."Value 7";
        PurchOrderLine."Value 8" := RequisitionLine."Value 8";
        PurchOrderLine."Value 9" := RequisitionLine."Value 9";
        PurchOrderLine."Value 10" := RequisitionLine."Value 10";
        //QUANTITE//
        //SUBCONTRACTOR
        PurchOrderLine."Sales Document Type" := RequisitionLine."Sales Document Type";
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', true, true)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    begin
        //PROJET
        PurchOrderLine."dysJob No." := RequisitionLine."Job No.";
        PurchOrderLine."Job Task No." := RequisitionLine."Job Task No.";
        IF PurchOrderLine."Job Task No." = '' THEN
            PurchOrderLine.VALIDATE("dysJob No.");
        PurchOrderLine."Work Type Code" := RequisitionLine."Work Type Code";
        //PROJET//
        //REMISE_FOURN
        PurchOrderLine.VALIDATE("Discount 1 %", RequisitionLine."Discount 1 %");
        PurchOrderLine.VALIDATE("Discount 2 %", RequisitionLine."Discount 2 %");
        PurchOrderLine.VALIDATE("Discount 3 %", RequisitionLine."Discount 3 %");
        //REMISE_FOURN//
        //CONSULT
        //PurchOrderLine."Drop Shipment" := "Sales Order Line No." <> 0;
        PurchOrderLine."Drop Shipment" := RequisitionLine."Sales Order No." <> '';
        //CONSULT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnBeforeSalesOrderLineValidateUnitCostLCY', '', true, true)]
    local procedure OnInsertPurchOrderLineOnBeforeSalesOrderLineValidateUnitCostLCY(var PurchOrderLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line")
    var
        SalesOrderHeader: Record "Sales Header";
    begin
        IF SalesOrderHeader.get(SalesOrderLine."Document Type", SalesOrderLine."Document No.") THEN;
        //INTERNAL_ORDER
        IF SalesOrderHeader."Order Type" = SalesOrderHeader."Order Type"::"Supply Order" THEN BEGIN
            PurchOrderLine."Requested Receipt Date" := SalesOrderLine."Requested Delivery Date";
            PurchOrderLine."Promised Receipt Date" := SalesOrderLine."Promised Delivery Date";
        END;
        //INTERNAL_ORDER//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnBeforeSalesOrderLineModify', '', true, true)]
    local procedure OnInsertPurchOrderLineOnBeforeSalesOrderLineModify(var SalesOrderLine: Record "Sales Line"; var RequisitionLine: Record "Requisition Line"; var PurchOrderLine: Record "Purchase Line")
    begin
        //ACHAT_DIRECT
        SalesOrderLine."Purchasing Order No." := PurchOrderLine."Document No.";
        SalesOrderLine."Purchasing Order Line No." := PurchOrderLine."Line No.";
        SalesOrderLine."Purchasing Document Type" := PurchOrderLine."Document Type";
        //ACHAT_DIRECT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderHeaderInsert', '', true, true)]
    local procedure OnBeforePurchOrderHeaderInsert(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line"; var ReceiveDateReq: Date)
    var
        SalesOrderLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
    begin
        //DEVIS
        IF RequisitionLine."Sales Order Line No." <> 0 THEN BEGIN
            IF SalesOrderLine.GET(RequisitionLine."Sales Document Type" - 1, RequisitionLine."Sales Order No.", RequisitionLine."Sales Order Line No.") THEN
                IF SalesOrderLine."Vendor No." = '' THEN
                    PurchOrderHeader."Document Type" := RequisitionLine."Sales Document Type" - 1;
        END ELSE BEGIN
            IF SalesOrderHeader.GET(RequisitionLine."Sales Document Type" - 1, RequisitionLine."Sales Order No.") THEN
                PurchOrderHeader."Document Type" := RequisitionLine."Sales Document Type" - 1;
        END;
        //DEVIS//

        //OFFRE_DE_PRIX
        IF wPriceOfferSetup.READPERMISSION THEN
            IF (RequisitionLine."Vendor No." = wPriceOfferSetup."Default Quote Vendor") THEN
                PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Quote;
        //OFFRE_DE_PRIX//
        //CONSULT
        IF wOrderKO THEN
            PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Quote;

        //CONSULT//

        //SUBCONTRACTOR
        IF SalesOrderLine.GET(RequisitionLine."Sales Document Type" - 1, RequisitionLine."Sales Order No.", RequisitionLine."Sales Order Line No.") THEN
            IF SalesOrderLine."Vendor No." <> '' THEN
                IF (SalesOrderLine."Document Type" = SalesOrderLine."Document Type"::Quote) OR
                   (SalesOrderLine."Vendor No." = wPriceOfferSetup."Default Quote Vendor")
                THEN
                    PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Quote;
        IF PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Quote THEN
            wQuoteCount += 1
        ELSE
            wOrderCount += 1;
        //SUBCONTRACTOR//
        // >> HJ DSFT 25-01-2013
        PurchOrderHeader."N° Demande d'achat" := RequisitionLine."Sales Order No.";

        // >> HJ DSFT 25-01-2013
        //#5228
        IF SalesOrderHeader.GET(RequisitionLine."Sales Document Type" - 1, RequisitionLine."Sales Order No.") THEN
            //#7800    IF SalesOrderHeader."Order Type" = SalesOrderHeader."Order Type"::"Supply Order" THEN
            //#6630
            //      PurchOrderHeader."Responsibility Center" := SalesOrderHeader."Responsibility Center";
            IF SalesOrderHeader."Responsibility Center" <> '' THEN
                PurchOrderHeader."Responsibility Center" := SalesOrderHeader."Responsibility Center"
            ELSE
                PurchOrderHeader."Responsibility Center" := fRespCenterVendor(PurchOrderHeader);
        //#6630//
        //#5228 //
        //AGENCE
        // >> HJ DSFT 25-01-2013

        PurchOrderHeader."Date DA" := SalesOrderHeader."Order Date";
        // >> HJ DSFT 25-01-2013

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertHeaderOnBeforeValidateSellToCustNoFromReqLine', '', true, true)]
    local procedure OnInsertHeaderOnBeforeValidateSellToCustNoFromReqLine(PurchOrderHeader: Record "Purchase Header"; ReqLine2: Record "Requisition Line"; var ShouldValidateSellToCustNo: Boolean)
    begin
        //      //#5228   IF SalesOrderHeader.GET("Sales Document Type" - 1,"Sales Order No.") THEN
        //     IF SalesOrderHeader."Order Type" = SalesOrderHeader."Order Type"::"Supply Order" THEN BEGIN
        //       PurchOrderHeader."Requested Receipt Date" := SalesOrderHeader."Requested Delivery Date";
        //       PurchOrderHeader."Promised Receipt Date" := SalesOrderHeader."Promised Delivery Date";
        //   //#7754
        //       PurchOrderHeader."Expected Receipt Date" := SalesOrderHeader."Shipment Date";
        //   //#7754//
        //     END;
        //     PurchOrderHeader.SetHideValidationDialog(FALSE);
        //   //INTERNAL_ORDER//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertHeaderOnBeforeSetShipToForSpecOrder', '', true, true)]
    local procedure OnInsertHeaderOnBeforeSetShipToForSpecOrder(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line"; var ShouldSetShipToForSpecOrder: Boolean)
    begin
        //PROJET
        PurchOrderHeader."Job No." := RequisitionLine."Job No.";
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderHeader', '', true, true)]
    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnFinalizeOrderHeaderOnAfterSetFiltersForRecurringReqLine', '', true, true)]
    local procedure OnFinalizeOrderHeaderOnAfterSetFiltersForRecurringReqLine(var RequisitionLine: Record "Requisition Line"; PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        //PROJET (#5179)
        RequisitionLine.SETRANGE("Job No.", PurchaseHeader."Job No.");
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnFinalizeOrderHeaderOnAfterSetFiltersForNonRecurringReqLine', '', true, true)]
    local procedure OnFinalizeOrderHeaderOnAfterSetFiltersForNonRecurringReqLine(var RequisitionLine: Record "Requisition Line"; PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; var TempFailedRequisitionLine: Record "Requisition Line" temporary)
    begin
        //PROJET (#5179)
        RequisitionLine.SETRANGE("Job No.", PurchaseHeader."Job No.");
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterFinalizeOrderHeaderProcedure', '', true, true)]
    local procedure OnAfterFinalizeOrderHeaderProcedure(var PurchHeader: Record "Purchase Header"; var ReqLine: Record "Requisition Line")
    var
        lWorkflowSetup: Record "Workflow Setup";
        lWorkflowMgt: Codeunit "Workflow Management2";
    begin
        //+WKF+CUSTOM
        IF (PurchOrderHeader."Document Type" = PurchOrderHeader."Document Type"::Order) THEN
            IF lWorkflowSetup.GET AND lWorkflowSetup."Generate Purchase Order" THEN
                IF lWorkflowMgt.WorkflowTypeNo(PAGE::"Purchase Order", '', PurchOrderHeader."No.", '', '') THEN
                    EXIT;
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforeInitPurchOrderLine', '', true, true)]
    local procedure OnBeforeInitPurchOrderLine(var ReqLine: record "Requisition Line"; var PurchasingCode: Record Purchasing; var PurchOrderHeader: Record "Purchase Header"; var LineCount: Integer; var NextLineNo: Integer; var PrevPurchCode: code[10]; var PrevShipToCode: code[10]; var PlanningResiliency: boolean; TempDocumentEntry: Record "Document Entry" temporary; var SuppressCommit: Boolean; var PostingDateReq: date; var ReferenceReq: text[35]; var OrderDateReq: date; var ReceiveDateReq: date; var OrderCounter: integer; var HideProgressWindow: Boolean; var IsHandled: Boolean; var PurchaseLineOrder: Record "Purchase Line")
    begin
        //SUBCONTRACTOR
        IF (ReqLine."Sales Order No." <> wSalesLine."Document No.") OR
           (ReqLine."Sales Order Line No." <> wSalesLine."Line No.") OR
           (ReqLine."Sales Document Type" <> wSalesLine."Document Type")
        THEN
            IF NOT wSalesLine.GET(ReqLine."Sales Document Type" - 1, ReqLine."Sales Order No.", ReqLine."Sales Order Line No.") THEN
                wSalesLine.INIT
            ELSE
                wSubcontractor := (wSalesLine."Vendor No." <> '') AND
                                  NOT wSalesLine.Disable AND
                                  (wSalesLine.Subcontracting <> wSalesLine.Subcontracting::" ");
        IF wSubcontractor AND (ReqLine.Type = ReqLine.Type::" ") THEN BEGIN
            wInsertTextLine(ReqLine);
            EXIT;
        END;
        //SUBCONTRACTOR//
        //CONSULT
        wInsertRefLine(ReqLine);
        //CONSULT//
    end;

    LOCAL PROCEDURE wInsertLotLine(pReqLine2: Record "Requisition Line"; pPresCode: Text[30]);
    VAR
        lSalesLine: Record "Sales Line";
        lPurchOrderLine2: Record "Purchase Line";
        lInsertText: Boolean;
        CduFunction: Codeunit SoroubatFucntion;

    BEGIN
        WITH pReqLine2 DO BEGIN
            lSalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code", "Line No.", "Line Type");
            lSalesLine.SETRANGE("Document Type", "Sales Document Type" - 1);
            lSalesLine.SETRANGE("Document No.", "Sales Order No.");
            lSalesLine.SETFILTER("Presentation Code", '%1..%2', pPresCode, wSalesLine."Presentation Code");
            //                       COPYSTR(wSalesLine."Presentation Code",1,STRPOS(wSalesLine."Presentation Code",'.') - 1),
            //                       wSalesLine."Presentation Code");
            lSalesLine.SETRANGE("Line Type", lSalesLine."Line Type"::Totaling);
            lSalesLine.SETRANGE("Vendor No.", "Vendor No.");
            IF lSalesLine.FIND('-') THEN BEGIN
                PurchOrderLine.INIT;
                PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                PurchOrderLine."Buy-from Vendor No." := PurchOrderHeader."Buy-from Vendor No.";
                PurchOrderLine."Document No." := PurchOrderHeader."No.";
                PurchOrderLine.VALIDATE(Type, Type::" ");
                REPEAT
                    PurchOrderLine."Line No." := NextLineNo + 10000;
                    PurchOrderLine."No." := lSalesLine."No.";
                    PurchOrderLine.Description := lSalesLine.Description;
                    PurchOrderLine."Description 2" := lSalesLine."Description 2";
                    IF PurchOrderLine.INSERT THEN
                        NextLineNo := NextLineNo + 10000;

                    //Texte ‚tendu de la ligne de lot
                    PurchOrderLine."Sales Document Type" := lSalesLine."Document Type" + 1;
                    PurchOrderLine."Sales Order No." := lSalesLine."Document No.";
                    PurchOrderLine."Sales Order Line No." := lSalesLine."Line No.";
                    CLEAR(lInsertText);
                    lInsertText := CduFunction.wPurchasingCheckIfAnyAttText(PurchOrderLine, 0);
                    IF lInsertText THEN BEGIN
                        TransferExtendedText.InsertPurchExtText(PurchOrderLine);
                        lPurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
                        lPurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
                        IF lPurchOrderLine2.FIND('+') THEN
                            NextLineNo := lPurchOrderLine2."Line No.";
                    END;

                UNTIL lSalesLine.NEXT = 0;
            END;
        END;
    END;

    LOCAL PROCEDURE wInsertTextLine(pReqLine2: Record "Requisition Line");
    VAR
        lSalesLine: Record "Sales Line";
        lPurchOrderLine2: Record "Purchase Line";
        lInsertText: Boolean;
        CduFunction: Codeunit SoroubatFucntion;
    BEGIN
        WITH pReqLine2 DO BEGIN
            IF "Sales Order No." = '' THEN
                EXIT;
            lSalesLine.GET("Sales Document Type" - 1, "Sales Order No.", "Sales Order Line No.");
            PurchOrderLine.INIT;
            PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
            PurchOrderLine."Buy-from Vendor No." := PurchOrderHeader."Buy-from Vendor No.";
            PurchOrderLine."Document No." := PurchOrderHeader."No.";
            PurchOrderLine.VALIDATE(Type, Type::" ");
            PurchOrderLine."Line No." := NextLineNo + 10000;
            PurchOrderLine."No." := "No.";
            PurchOrderLine.Description := Description;
            PurchOrderLine."Description 2" := "Description 2";
            IF PurchOrderLine.INSERT THEN
                NextLineNo := NextLineNo + 10000;
            //Texte ‚tendu de la ligne de lot
            PurchOrderLine."Sales Document Type" := lSalesLine."Document Type" + 1;
            PurchOrderLine."Sales Order No." := lSalesLine."Document No.";
            PurchOrderLine."Sales Order Line No." := lSalesLine."Line No.";
            CLEAR(lInsertText);
            lInsertText := CduFunction.wPurchasingCheckIfAnyAttText(PurchOrderLine, 0);
            IF lInsertText THEN BEGIN
                TransferExtendedText.InsertPurchExtText(PurchOrderLine);
                lPurchOrderLine2.SETRANGE("Document Type", PurchOrderHeader."Document Type");
                lPurchOrderLine2.SETRANGE("Document No.", PurchOrderHeader."No.");
                IF lPurchOrderLine2.FIND('+') THEN
                    NextLineNo := lPurchOrderLine2."Line No.";
            END;
        END;
    END;

    LOCAL PROCEDURE wInsertRefLine(pReqLine2: Record "Requisition Line");
    VAR
        lTotalNeedParam: Record "Sales Document Cost";
        lSalesLine: Record "Sales Line";
    BEGIN
        IF (pReqLine2."Sales Order No." = '') OR (wSalesLine."Document Type" <> wSalesLine."Document Type"::Order) THEN
            EXIT;
        WITH pReqLine2 DO BEGIN
            lSalesLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
            lSalesLine.SETRANGE("Document Type", lSalesLine."Document Type"::Order);
            lSalesLine.SETRANGE("Supply Order No.", "Sales Order No.");
            lSalesLine.SETRANGE("Supply Order Line No.", "Sales Order Line No.");
            IF lSalesLine.ISEMPTY THEN
                EXIT;
            IF lSalesLine.FIND('-') AND (pReqLine2.Type = pReqLine2.Type::Item) THEN
                IF lTotalNeedParam.GET("Sales Document Type" - 1, lSalesLine."Document No.",
                                          lTotalNeedParam.Type::Item, "No.", 0) THEN BEGIN
                    IF lTotalNeedParam."Reference Purchase Quote" = '' THEN
                        EXIT;
                    PurchOrderLine.INIT;
                    PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                    PurchOrderLine."Buy-from Vendor No." := PurchOrderHeader."Buy-from Vendor No.";
                    PurchOrderLine."Document No." := PurchOrderHeader."No.";
                    PurchOrderLine.VALIDATE(Type, Type::" ");
                    NextLineNo := NextLineNo + 10000;
                    PurchOrderLine."Line No." := NextLineNo;
                    PurchOrderLine.Description := STRSUBSTNO(TextReference, lTotalNeedParam."Reference Purchase Quote");
                    PurchOrderLine.INSERT;
                END;
        END;
    END;

    PROCEDURE wGetDocumentType(VAR pPurchaseHeader: Record "Purchase Header"; VAR pQuoteCount: Integer; VAR pOrderCount: Integer);
    BEGIN
        //CONSULT
        pPurchaseHeader := PurchOrderHeader;
        pQuoteCount := wQuoteCount;
        pOrderCount := wOrderCount;
        //CONSULT//
    END;

    PROCEDURE wSetOrderKO(pOrderKO: Boolean);
    BEGIN
        wOrderKO := pOrderKO;
    END;

    PROCEDURE fRespCenterVendor(pPurchHeader: Record "Purchase Header"): Code[20];
    VAR
        lVendor: Record Vendor;
    BEGIN
        IF lVendor.GET(pPurchHeader."Buy-from Vendor No.") THEN
            EXIT(lVendor."Responsibility Center");
    END;


}