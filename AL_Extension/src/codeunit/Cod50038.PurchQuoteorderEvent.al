codeunit 50038 PurchQuoteorderEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforeInitRecord', '', true, true)]
    local procedure OnCreatePurchHeaderOnBeforeInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
        //+OFF+OFFRE
        lPurchQuoteHeader := PurchHeader;
        wSourceDocNo := PurchOrderHeader."Attached to Doc. No.";
        PurchOrderHeader."Attached to Doc. No." := '';
        PurchOrderHeader."Quote No." := PurchHeader."No.";
        //+OFF+OFFRE//

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderModify', '', true, true)]
    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderModify(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
        //   //ACHAT
        //     IF PurchOrderHeader."Posting Date" = 0D THEN
        //       PurchOrderHeader."Posting Date" := WORKDATE;
        //     //ACHAT//
        //NAVIBAT
        IF wSourceDocNo <> '' THEN BEGIN
            lPurchQuoteHeader.GET(PurchHeader."Document Type", wSourceDocNo);
            PurchOrderHeader."Job No." := lPurchQuoteHeader."Job No.";
        END;
        //NAVIBAT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeTransferQuoteLineToOrderLineLoop', '', true, true)]
    local procedure OnBeforeTransferQuoteLineToOrderLineLoop(var PurchQuoteLine: Record "Purchase Line"; var PurchQuoteHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        //+OFF+OFFRE
        IF wSourceDocNo <> '' THEN BEGIN
            wInitialPurchLine.GET(PurchQuoteLine."Document Type", wSourceDocNo, PurchQuoteLine."Line No.");
            wCreateOrderLine :=
              ((wInitialPurchLine."Selected Doc. No." = PurchQuoteLine."Document No.") AND
              (wInitialPurchLine."Selected Doc. Line No." = PurchQuoteLine."Line No.") AND
              NOT wInitialPurchLine."Ordered Line") OR
              ((PurchQuoteLine.Type = PurchQuoteLine.Type::" ") AND (PurchQuoteLine."Attached to Line No." = 0));
        END ELSE
            wCreateOrderLine := TRUE;
        IF wCreateOrderLine THEN
            IsHandled := false
        else
            IsHandled := true;
        //+OFF+OFFRE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeArchivePurchaseQuote', '', true, true)]
    local procedure OnBeforeArchivePurchaseQuote(var PurchaseHeader: Record "Purchase Header"; PurchaseOrderHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        PurchSetup.Get();
        //#8609
        //IF PurchSetup."Archive Quotes and Orders" THEN
        IF (PurchSetup."Archive Orders") AND
           ((PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard) OR
            (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Both)) THEN
            IsHandled := false
        else
            IsHandled := true;
        //#8609//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', true, true)]

    local procedure OnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        //+REF+CRM
        lInteractLogEntry.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        lInteractLogEntry.SETRANGE("Document Type", lInteractLogEntry.fSearchDocType(QuotePurchHeader."Document Type", 0, 0));
        lInteractLogEntry.SETRANGE("Document No.", QuotePurchHeader."No.");
        IF lInteractLogEntry.FIND('-') THEN
            REPEAT
                lInteractLogEntry."Sales Document Type" := OrderPurchHeader."Document Type";
                lInteractLogEntry."Sales Document No." := OrderPurchHeader."No.";
                lInteractLogEntry.MODIFY;
            UNTIL lInteractLogEntry.NEXT = 0;
        //+REF+CRM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', true, true)]
    local procedure OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        CudFunction: Codeunit SoroubatFucntion;
    begin
        //+OFF+OFFRE
        IF PurchQuoteLine."Attached to Doc. No." = '' THEN
            CudFunction.wTransferQuotePurchToOrdePurch(
              PurchQuoteLine, PurchOrderLine, PurchQuoteLine."Quantity (Base)", FALSE)
        ELSE BEGIN
            lPurchQuoteLine.SETRANGE("Document Type", PurchQuoteLine."Attached to Doc. Type");
            lPurchQuoteLine.SETRANGE("Document No.", PurchQuoteLine."Attached to Doc. No.");
            IF lPurchQuoteLine.GET(
                 PurchQuoteLine."Attached to Doc. Type",
                 PurchQuoteLine."Attached to Doc. No.", PurchQuoteLine."Line No.")
            THEN
                CudFunction.wTransferQuotePurchToOrdePurch(
                  lPurchQuoteLine, PurchOrderLine, PurchQuoteLine."Quantity (Base)", FALSE);
        END;
        //+OFF+OFFRE//

        //SUBCONTRACTOR
        IF (PurchOrderLine."Sales Order No." <> '') OR
           (PurchOrderLine."Special Order Sales Line No." <> 0) THEN BEGIN
            PurchOrderLine."Sales Document Type" := PurchOrderLine."Sales Document Type"::Order;
            //#5020      IF wSourceDocNo = '' THEN
            wUpdateSalesLine(PurchOrderLine, PurchQuoteLine);
            //(2425)      lSubcontractingMgt.UpdateFromPurchases(PurchOrderLine,TRUE);
            IF PurchQuoteLine."Attached to Doc. No." <> '' THEN BEGIN
                lPrincQuoteLine.SETRANGE("Selected Doc. No.", PurchQuoteLine."Document No.");
                lPrincQuoteLine.SETRANGE("Selected Doc. Line No.", PurchQuoteLine."Line No.");
                lPrincQuoteLine.SETRANGE("Document Type", PurchQuoteLine."Attached to Doc. Type");
                lPrincQuoteLine.SETRANGE("Document No.", PurchQuoteLine."Attached to Doc. No.");
                IF lPrincQuoteLine.FIND('-') THEN BEGIN
                    lPrincQuoteLine."Sales Document Type" := lPrincQuoteLine."Sales Document Type"::" ";
                    lPrincQuoteLine."Sales Order No." := '';
                    lPrincQuoteLine."Sales Order Line No." := 0;
                    lPrincQuoteLine."Drop Shipment" := FALSE;
                    lPrincQuoteLine.MODIFY;
                END;
            END;
        END;
        //SUBCONTRACTOR//
        //PROJET
        PurchOrderLine.InitOutstandingAmount;
        //PROJET//
    end;

    procedure wUpdateSalesLine(PurchOrdLine: Record "Purchase Line"; PurchQtLine: Record "Purchase Line")
    var
        lSalesLine: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
    begin

        //SUBCONTRACTOR
        IF (PurchOrdLine."Sales Order Line No." <> 0) OR (PurchOrdLine."Special Order Sales Line No." <> 0) THEN
            IF (PurchOrdLine."Sales Document Type" <> PurchOrdLine."Sales Document Type"::Order) AND
               (PurchOrdLine."Sales Document Type" <> PurchOrdLine."Sales Document Type"::" ") THEN
                ERROR(TextSubcontractor, PurchOrdLine."Document No.", PurchOrdLine."Line No.", PurchOrdLine."Sales Order No.");
        //SUBCONTRACTOR//

        //+OFF+OFFRE
        IF PurchOrdLine."Drop Shipment" THEN BEGIN
            //CONSULT
            //PERF  lSalesLine.SETCURRENTKEY("Document Type","Document No.","Structure Line No.","Line No.","Line Type","Fixed Price",Type);
            IF PurchOrdLine."Sales Order Line No." = 0 THEN BEGIN
                lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SETRANGE("Document Type", lSalesLine."Document Type"::Order);
                lSalesLine.SETRANGE("Document No.", PurchOrdLine."Sales Order No.");
                lSalesLine.SETRANGE(Type, lSalesLine.Type::Item);
                lSalesLine.SETRANGE("No.", PurchOrdLine."No.");
                lSalesLine.SETRANGE("Item Type", lSalesLine."Item Type"::" ");
                lSalesLine.SETRANGE(Subcontracting, lSalesLine.Subcontracting::" ");
                lSalesLine.SETFILTER("Purchasing Order Line No.", '<>%1', 0);
                lSalesLine.MODIFYALL("Purchasing Document Type", PurchOrdLine."Document Type");
                lSalesLine.MODIFYALL("Purchasing Order No.", PurchOrdLine."Document No.");
                lSalesLine.MODIFYALL("Purchasing Order Line No.", PurchOrdLine."Line No.");
                lSalesLine.MODIFYALL("Purchase Order No.", PurchOrdLine."Document No.");
                lSalesLine.MODIFYALL("Purch. Order Line No.", PurchOrdLine."Line No.");
            END;
            //CONSULT//
            //#5133
            IF NOT lSalesLine.GET(PurchOrdLine."Sales Document Type" - 1, PurchOrdLine."Sales Order No.",
              PurchOrdLine."Sales Order Line No.") THEN
                ERROR(TextSubcontractor, PurchOrdLine."Document No.", PurchOrdLine."Line No.", PurchOrdLine."Sales Order No.");
            //#5133//

            lSalesLine."Purchase Order No." := PurchOrdLine."Document No.";
            lSalesLine."Purch. Order Line No." := PurchOrdLine."Line No.";

            //PROJET_FG
            lTotalNeedParam.SETRANGE("Document Type", lSalesLine."Document Type");
            lTotalNeedParam.SETRANGE("Document No.", lSalesLine."Document No.");
            lTotalNeedParam.SETRANGE(Type, lTotalNeedParam.Type::Item);
            lTotalNeedParam.SETRANGE("No.", lSalesLine."No.");
            lTotalNeedParam.MODIFYALL("Vendor No.", PurchOrdLine."Buy-from Vendor No.");
            lTotalNeedParam.MODIFYALL("Purchasing Document Type", PurchOrdLine."Document Type");
            lTotalNeedParam.MODIFYALL("Purchasing Order No.", PurchOrdLine."Document No.");
            //PROJET_FG//

            //SUBCONTRACTOR
            lSalesLine."Purchasing Document Type" := lSalesLine."Purchasing Document Type"::Order;
            lSalesLine."Purchasing Order No." := PurchOrdLine."Document No.";
            lSalesLine."Purchasing Order Line No." := PurchOrdLine."Line No.";
            lSalesLine."Vendor No." := PurchOrdLine."Buy-from Vendor No.";
            IF lSalesLine."Order Type" = lSalesLine."Order Type"::"Supply Order" THEN BEGIN
                lSalesLine."Unit Cost (LCY)" := PurchOrdLine."Unit Cost (LCY)";
                lSalesLine."Total Cost (LCY)" := lSalesLine."Unit Cost (LCY)" * lSalesLine.Quantity;
            END;

            //SUBCONTRACTOR//

            lSalesLine.MODIFY;
        END;

        IF PurchOrdLine."Special Order" THEN BEGIN
            lSalesLine.GET(
              lSalesLine."Document Type"::Order,
              //#4431
              //    PurchQuoteLine."Sales Order No.",
              //    PurchQuoteLine."Sales Order Line No.");
              PurchQtLine."Special Order Sales No.",
              PurchQtLine."Special Order Sales Line No.");
            //#4431//
            lSalesLine."Special Order Purchase No." := PurchOrdLine."Document No.";
            lSalesLine."Special Order Purch. Line No." := PurchOrdLine."Line No.";
            //SUBCONTRACTOR
            lSalesLine."Purchasing Document Type" := lSalesLine."Purchasing Document Type"::Order;
            lSalesLine."Purchasing Order No." := PurchOrdLine."Document No.";
            lSalesLine."Purchasing Order Line No." := PurchOrdLine."Line No.";
            lSalesLine."Vendor No." := PurchOrdLine."Buy-from Vendor No.";
            IF lSalesLine."Order Type" = lSalesLine."Order Type"::"Supply Order" THEN BEGIN
                lSalesLine."Unit Cost (LCY)" := PurchOrdLine."Unit Cost (LCY)";
                lSalesLine."Total Cost (LCY)" := lSalesLine."Unit Cost (LCY)" * lSalesLine.Quantity;
            END;
            //SUBCONTRACTOR//
            lSalesLine.MODIFY;
        END;
        //+OFF+OFFRE//
        //SUBCONTRACTOR
        wUpdateStructureLine(lSalesLine, PurchOrdLine);
        //SUBCONTRACTOR//

    end;

    procedure wTransferTextLine(PurchOrderHdr: Record "Purchase Header")
    var
        lPurchOrderLine: Record "Purchase Line";
        PurchOrderLine: Record "Purchase Line";
        PurchQuoteLine: Record "Purchase Line";
    begin

        //+OFF+OFFRE
        PurchOrderLine.RESET;
        PurchOrderLine.SETRANGE("Document Type", PurchOrderLine."Document Type"::Order);
        PurchOrderLine.SETRANGE("Document No.", PurchOrderHdr."No.");
        IF PurchOrderLine.FIND('-') THEN
            REPEAT
                PurchQuoteLine.SETRANGE("Document Type", PurchQuoteLine."Document Type"::Quote);
                PurchQuoteLine.SETRANGE("Document No.", wSourceDocNo);
                PurchQuoteLine.SETRANGE("Attached to Line No.", PurchOrderLine."Line No.");
                IF PurchQuoteLine.FIND('-') THEN BEGIN
                    REPEAT
                        lPurchOrderLine := PurchQuoteLine;
                        lPurchOrderLine."Document Type" := PurchOrderHdr."Document Type";
                        lPurchOrderLine."Document No." := PurchOrderHdr."No.";
                        lPurchOrderLine."Attached to Doc. No." := '';
                        lPurchOrderLine."Selected Doc. No." := '';
                        lPurchOrderLine."Ordered Line" := FALSE;
                        lPurchOrderLine."Price Offer No." := wSourceDocNo;
                        lPurchOrderLine.INSERT;
                    UNTIL PurchQuoteLine.NEXT = 0;
                END;
            UNTIL PurchOrderLine.NEXT = 0;
        //+OFF+OFFRE//

    end;

    procedure wUpdateStructureLine(pSalesLine: Record "Sales Line"; PurchOrdLine2: Record "Purchase Line")
    var
        lSalesLine: Record "Sales Line";
    begin

        //SUBCONTRACTOR
        IF pSalesLine.Subcontracting = pSalesLine.Subcontracting::" " THEN
            EXIT;
        lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.");
        IF lSalesLine.GET(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Structure Line No.") THEN BEGIN
            lSalesLine."Purchasing Document Type" := lSalesLine."Purchasing Document Type"::Order;
            lSalesLine."Purchasing Order No." := PurchOrdLine2."Document No.";
            lSalesLine."Purchasing Order Line No." := PurchOrdLine2."Line No.";
            lSalesLine."Purchase Order No." := PurchOrdLine2."Document No.";
            lSalesLine."Purch. Order Line No." := PurchOrdLine2."Line No.";
            lSalesLine."Vendor No." := PurchOrdLine2."Buy-from Vendor No.";
            lSalesLine.MODIFY;
        END;
        //SUBCONTRACTOR//

    end;

    var
        myInt: Integer;
        lPurchQuoteHeader: Record "Purchase Header";
        lPurchQuoteLine: Record "Purchase Line";
        lPrincQuoteLine: Record "Purchase Line";
        lSalesLine: Record "Sales Line";
        lRespCenter: Record "Responsibility Center";
        lUserMgt: Codeunit "User Setup Management";
        lSubcontractingMgt: Codeunit "Subcontracting Management";
        lInteractLogEntry: Record "Interaction Log Entry";
        wCreateOrderLine: Boolean;
        wSourceDocNo: Code[20];
        wInitialPurchLine: Record "Purchase Line";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        TextSubcontractor: label 'Vous ne pouvez pas transformer le devis %1 en commande\car la ligne %2 est encore liée au Devis de vente %3.\Vous devez transformer ce devis en commande avant de poursuivre.';
}