codeunit 50055 "Event_PageEXT"
{
    //*************************************page 20************************************************//
    [EventSubscriber(ObjectType::Page, Page::"General Ledger Entries", 'OnBeforeCheckEntryPostedFromJournal', '', true, true)]
    local procedure OnBeforeCheckEntryPostedFromJournal(var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    begin
        //+ABO+
        GLEntry.TESTFIELD("Subscription Entry No.", 0);
        //+ABO+//
    end;


    //*************************************page 41************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeStatisticsAction', '', true, true)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    VAR
        lInvScheduler: Record "Invoice Scheduler";
        lGR: Record "Gen. Product Posting Group";
        //GL2024  lStat: Page 8004045;
        lSingleInstance: Codeunit "Import SingleInstance2";
        lJobCostAssignment: Codeunit "Job Cost Assignment";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";

    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin


            //GL2024  SalesHeader.OpenDocumentStatistics();
            SalesHeader.CalcInvDiscForHeader;
            COMMIT;
            //+ONE+
            //FORM.RUNMODAL(FORM::"Sales Statistics",Rec);
            //+ONE+//

            //PROJET_FACT
            CustCheckCreditLimit.SalesHeaderCheck(SalesHeader);
            IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN BEGIN
                CLEAR(lInvScheduler);
                lInvScheduler.SETRANGE("Sales Header Doc. Type", SalesHeader."Document Type");
                lInvScheduler.SETRANGE("Sales Header Doc. No.", SalesHeader."No.");
                lInvScheduler.SETFILTER("Document Percentage", '<>0');
                IF NOT lInvScheduler.ISEMPTY THEN BEGIN
                    lInvScheduler.FINDFIRST;
                    lInvScheduler.UpdateLineAmount(lInvScheduler);
                    COMMIT;
                END;
            END;
            //PROJET_FACT//
            //GL2024    lStat.GetSalesHeader(SalesHeader."Document Type", SalesHeader."No.");
            lGR.SETRANGE("Document Type Filter", SalesHeader."Document Type");
            lGR.SETRANGE("Document No. Filter", SalesHeader."No.");
            //lGR.SETRANGE("Job Filter","Job No.");
            //#9092
            lGR.SETFILTER("Job Totaling", '%1', SalesHeader."Job No.");
            //#9092//
            //GL2024   lStat.SETTABLEVIEW(lGR);
            //EVENT
            //lStat.setEventLog(wEventLog);
            //EVENT//
            //GL2024   lStat.RUNMODAL;

            //   Handled := true;
        end;
    end;

    //*************************************page 42************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeStatisticsAction', '', true, true)]

    local procedure OnBeforeStatisticsAction42(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    VAR
        lGR: Record "Gen. Product Posting Group";
        lInvScheduler: Record "Invoice Scheduler";
        //GL2024 NAVIBAT    lStat: Page 8004045;
        CduSalesPost: Codeunit "Sales-Post";
        CduSalesPost2: Codeunit SalesPostEvent;
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin


            // >> HJ SORO 16-10-2014
            CduSalesPost2.CalcBIC(SalesHeader);
            // >> HJ SORO 16-10-2014

            SalesHeader.CalcInvDiscForHeader;
            COMMIT;
            //+ONE+
            //FORM.RUNMODAL(FORM::"Sales Order Statistics",Rec);
            //+ONE+//
            //CurrForm.SalesLines.FORM.wCalcJobCostRepartition;       Fait dans lStat
            //COMMIT;
            //PROJET_FACT
            IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN BEGIN
                CLEAR(lInvScheduler);
                lInvScheduler.SETRANGE("Sales Header Doc. Type", SalesHeader."Document Type");
                lInvScheduler.SETRANGE("Sales Header Doc. No.", SalesHeader."No.");
                lInvScheduler.SETFILTER("Document Percentage", '<>0');
                IF NOT lInvScheduler.ISEMPTY THEN BEGIN
                    lInvScheduler.FINDFIRST;
                    lInvScheduler.UpdateLineAmount(lInvScheduler);
                    COMMIT;
                END;
            END;
            //PROJET_FACT//
            //GL2024 NAVIBAT   lStat.GetSalesHeader(SalesHeader."Document Type", SalesHeader."No.");
            lGR.SETRANGE("Document Type Filter", SalesHeader."Document Type");
            lGR.SETRANGE("Document No. Filter", SalesHeader."No.");
            //lGR.SETRANGE("Job Filter","Job No.");
            //#9092
            lGR.SETFILTER("Job Totaling", '%1', SalesHeader."Job No.");
            //#9092//
            //GL2024 NAVIBAT    lStat.SETTABLEVIEW(lGR);
            //Fenetre.CLOSE;
            //GL2024 NAVIBAT    lStat.RUNMODAL;
            // Handled := true;
        end;

    end;

    //*************************************page 43************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice", 'OnBeforeStatisticsAction', '', true, true)]
    local procedure OnBeforeStatisticsAction43(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    VAR
        //GL2024 NAVIBAT     lStat: Page 8004045;
        lGR: Record "Gen. Product Posting Group";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        CduSalesPost: Codeunit SalesPostEvent;
    BEGIN

        // >> HJ SORO 16-10-2014
        /*//HS     ReleaseSalesDoc.PerformManualRelease(SalesHeader);
             CduSalesPost.CalcTimbre(SalesHeader);
             CduSalesPost.CalcFodec(SalesHeader); //HS*/
        // >> HJ SORO 16-10-2014
        //Fenetre.OPEN(TextUpdate);7
        SalesHeader.CalcInvDiscForHeader;
        COMMIT;
        //+ONE+
        //PAGE.RUNMODAL(PAGE::"Sales Statistics",Rec);

        //+ONE+//
        //CurrPAGE.SalesLines.FORM.wCalcJobCostRepartition;      Fait dans lStat
        //COMMIT;
        //GL2024 NAVIBAT     lStat.GetSalesHeader(SalesHeader."Document Type", SalesHeader."No.");
        lGR.SETRANGE("Document Type Filter", SalesHeader."Document Type");
        lGR.SETRANGE("Document No. Filter", SalesHeader."No.");
        lGR.SETRANGE("Job Filter", SalesHeader."Job No.");
        //GL2024 NAVIBAT     lStat.SETTABLEVIEW(lGR);
        //Fenetre.CLOSE;
        //GL2024 NAVIBAT    lStat.RUNMODAL;
        //  Handled := true;
    end;



    //*************************************page 44************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Sales Credit Memo", 'OnBeforeStatisticsAction', '', true, true)]
    local procedure OnBeforeStatisticsAction44(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    VAR
        //GL2024 NAVIBAT   lStat: Page 8004045;
        lGR: Record "Gen. Product Posting Group";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        RecSalesHeader: Record "Sales Header";
        CduSalesPost: Codeunit "Sales-Post";
        CduSalesPost2: Codeunit SalesPostEvent;

    begin

        // RB SORO 23/03/2015
        // >> HJ SORO 16-10-2014 
        ReleaseSalesDoc.PerformManualRelease(SalesHeader);
        // CduSalesPost2.CalcTimbre(SalesHeader);
        // CduSalesPost2.CalcFodec(SalesHeader);
        // >> HJ SORO 16-10-2014
        // RB SORO 23/03/2015

        //Fenetre.OPEN(TextUpdate);
        SalesHeader.CalcInvDiscForHeader;
        COMMIT;
        //+ONE+
        //FORM.RUNMODAL(FORM::"Sales Statistics",Rec);
        //+ONE+//
        //CurrForm.SalesLines.FORM.wCalcJobCostRepartition;    Fait dans lStat
        //COMMIT;
        //GL2024 NAVIBAT    lStat.GetSalesHeader(SalesHeader."Document Type", SalesHeader."No.");
        lGR.SETRANGE("Document Type Filter", SalesHeader."Document Type");
        lGR.SETRANGE("Document No. Filter", SalesHeader."No.");
        lGR.SETRANGE("Job Filter", SalesHeader."Job No.");
        //GL2024 NAVIBAT    lStat.SETTABLEVIEW(lGR);
        //Fenetre.CLOSE;
        //GL2024 NAVIBAT     lStat.RUNMODAL;

        //   Handled := true;
    end;

    //*************************************page 54************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeOnDeleteRecord', '', true, true)]
    local procedure OnBeforeOnDeleteRecord(var PurchaseLine: Record "Purchase Line"; var Result: Boolean; var IsHandled: Boolean)
    var
        PurchHeader: Record "Purchase Header";
        Text003: Label 'Suppression Impossible, Statut Non Ouvert';
    begin

        IF PurchHeader.GET(PurchaseLine."Document Type"::Order, PurchaseLine."Document No.") THEN
            IF PurchHeader.Status <> PurchHeader.Status::Open THEN ERROR(Text003);
    end;

    //*************************************page 54************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeOpenSalesOrderForm', '', true, true)]
    local procedure OnBeforeOpenSalesOrderForm(var PurchaseLine: Record "Purchase Line"; var SalesHeader: Record "Sales Header"; var SalesOrder: Page "Sales Order"; var IsHandled: Boolean)
    var
        //GL2024 SalesOrder: Page 8003966;
        lSalesOrder2: Record "Sales Header";
        lNavibatOrder: Page "Sales Order";
    begin

        PurchaseLine.TestField("Sales Order No.");
        SalesHeader.SetRange("No.", PurchaseLine."Sales Order No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order, PurchaseLine."Sales Order No.") AND
           (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
            lNavibatOrder.SETTABLEVIEW(SalesHeader);
            lNavibatOrder.EDITABLE := FALSE;
            lNavibatOrder.RUN;
        END ELSE BEGIN
            //DEVIS//
            SalesOrder.SetTableView(SalesHeader);
            SalesOrder.Editable := false;
            SalesOrder.Run();
            //DEVIS
        END;
        //DEVIS//
        IsHandled := true;
    end;

    //*************************************page 54************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnBeforeOpenSpecOrderSalesOrderForm', '', true, true)]
    local procedure OnBeforeOpenSpecOrderSalesOrderForm(var PurchaseLine: Record "Purchase Line"; var SalesHeader: Record "Sales Header"; var SalesOrder: Page "Sales Order"; var IsHandled: Boolean)
    var
        //GL2024  SalesOrder : Page 8003966;
        lSalesOrder2: Record "Sales Header";
        lNavibatOrder: Page "Sales Order";
    begin


        PurchaseLine.TestField("Special Order Sales No.");
        SalesHeader.SetRange("No.", PurchaseLine."Special Order Sales No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order, PurchaseLine."Special Order Sales No.") AND
            (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
            lNavibatOrder.SETTABLEVIEW(SalesHeader);
            lNavibatOrder.EDITABLE := FALSE;
            lNavibatOrder.RUN;
        END ELSE BEGIN
            //DEVIS//
            SalesOrder.SetTableView(SalesHeader);
            SalesOrder.Editable := false;
            SalesOrder.Run();
            //DEVIS
        END;
        //DEVIS//
        IsHandled := true;
    end;


    //*************************************page 151************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Customer Statistics", 'OnAfterSetDateFilter', '', true, true)]
    local procedure OnAfterSetDateFilter(var Customer: Record Customer)
    var
        lPaymentFormIntegration: Codeunit "Payment Form Integration";
        TotalAmountLCY: Decimal;
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        TotalAmountLCY := Customer.GetTotalAmountLCY;
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lPaymentFormIntegration.CUSTUpdTotalAmountLCY(Customer, TotalAmountLCY);
        //+PMT+PAYMENT//
    end;

    //*************************************page 232************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnAfterSetApplyingCustLedgEntrySalesHeader', '', true, true)]
    local procedure OnAfterSetApplyingCustLedgEntrySalesHeader(var TempApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary; var SalesHeader: Record "Sales Header")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            TempApplyingCustLedgEntry."Due Date" := SalesHeader."Due Date";
        //+PMT+//

    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnAfterSetApplyingCustLedgEntryGenJnlLine', '', true, true)]
    local procedure OnAfterSetApplyingCustLedgEntryGenJnlLine(var TempApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary; var GenJnlLine: Record "Gen. Journal Line")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            TempApplyingCustLedgEntry."Due Date" := GenJnlLine."Due Date";
        //+PMP+//
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnSetApplyingCustLedgEntryOnBeforeCalcTypeDirectCalcApplnAmount', '', true, true)]

    local procedure OnSetApplyingCustLedgEntryOnBeforeCalcTypeDirectCalcApplnAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingAmount: Decimal; var TempApplyingCustLedgEntry: Record "Cust. Ledger Entry")
    var

        "Page_Apply_Customer_Entries": page "Apply Customer Entries";

    begin

        if not (CustLedgerEntry."Applying Entry") then begin
            //ONE+
            CustLedgerEntry := TempApplyingCustLedgEntry;
            CustLedgerEntry."Applying Entry" := FALSE;
            TempApplyingCustLedgEntry.INIT;
            TempApplyingCustLedgEntry."Entry No." := 0;
            "Page_Apply_Customer_Entries".SetCustApplId(true);
            ApplyingAmount := 0;
            /*GL2024  ApplnDate := 0D;
              ApplnCurrencyCode := '';*/
            CustLedgerEntry.SETRANGE("Entry No.");
            //ONE+//
        end;
    end;
    //*************************************page 256************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnBeforeSuggestVendorPaymentsAction', '', true, true)]
    local procedure OnBeforeSuggestVendorPaymentsAction(var GenJournalLine: Record "Gen. Journal Line"; var IsHanlded: Boolean)
    var
        CreateVendorPmtSuggestion: Report "Suggest Vendor Payments";
    begin
        //+PMT+PAYMENT
        CreateVendorPmtSuggestion.wSetAutomaticPayment;
        //+PMT+PAYMENT//
    end;

    //*************************************page 343************************************************//
    [EventSubscriber(ObjectType::Page, Page::"Check Credit Limit", 'OnShowWarningOnBeforeExitValue', '', true, true)]
    local procedure OnShowWarningOnBeforeExitValue(var Customer: Record Customer; ExitValue: Integer; var Result: Boolean; var IsHandled: Boolean; var Heading: Text[250]; var SecondHeading: Text[250]; var NotificationID: Guid)
    var
        CustCheckCrLimit: Codeunit "Cust-Check Cr. Limit";
    begin
        if ExitValue > 0 then begin
            case ExitValue of
                1:
                    begin
                        Heading := CopyStr(CustCheckCrLimit.GetCreditLimitNotificationMsg(), 1, 250);
                        NotificationId := CustCheckCrLimit.GetCreditLimitNotificationId();
                    end;
                2:
                    begin
                        Heading := CopyStr(CustCheckCrLimit.GetOverdueBalanceNotificationMsg(), 1, 250);
                        NotificationId := CustCheckCrLimit.GetOverdueBalanceNotificationId();
                    end;
                3:
                    begin
                        Heading := CopyStr(CustCheckCrLimit.GetCreditLimitNotificationMsg(), 1, 250);
                        SecondHeading := CopyStr(CustCheckCrLimit.GetOverdueBalanceNotificationMsg(), 1, 250);
                        NotificationId := CustCheckCrLimit.GetBothNotificationsId();
                    end;
            end;
            //#6658
            IF (NOT wBalanceDueCalc) THEN BEGIN
                Result := (TRUE);
            END ELSE BEGIN
                Result := (Customer."Balance Due (LCY)" > 0);
            END;
            //EXIT(TRUE);
            //#6658//
        end;
        IsHandled := true;
    end;

    PROCEDURE fSetCalcBalanceDue(pCalcBalanceDue: Boolean);
    BEGIN
        //#6658
        wBalanceDueCalc := pCalcBalanceDue;
        //#6658//
    END;

    PROCEDURE fSetDayNumber(pDayNumber: Integer);
    BEGIN
        //#6658
        wDayNumber := pDayNumber;
        //#6658//
    END;

    var
        wBalanceDueCalc: Boolean;
        wDayNumber: Integer;

    [EventSubscriber(ObjectType::Page, Page::"Check Credit Limit", 'OnBeforeCalcCreditLimitLCY', '', true, true)]
    local procedure OnBeforeCalcCreditLimitLCY(var Customer: Record Customer; var OutstandingRetOrdersLCY: Decimal; var RcdNotInvdRetOrdersLCY: Decimal; var NewOrderAmountLCY: Decimal; var OrderAmountTotalLCY: Decimal; var OrderAmountThisOrderLCY: Decimal; var ShippedRetRcdNotIndLCY: Decimal; var CustCreditAmountLCY: Decimal; var CustNo: Code[20]; var ExtensionAmountsDic: Dictionary of [Guid, Decimal]; var IsHandled: Boolean; DeltaAmount: Decimal)
    begin
        //#6658
        //IF GETFILTER("Date Filter") = '' THEN
        //SETFILTER("Date Filter",'..%1',WORKDATE);
        IF Customer.GETFILTER("Date Filter") = '' THEN BEGIN
            IF (wDayNumber > 0) THEN BEGIN
                Customer.SETFILTER("Date Filter", '..%1', CALCDATE('<-' + FORMAT(wDayNumber) + 'D>', WORKDATE));
            END ELSE BEGIN
                Customer.SETFILTER("Date Filter", '..%1', WORKDATE);
            END;

        END;
        //#6658//


    end;


    [EventSubscriber(ObjectType::Page, Page::"Check Credit Limit", 'OnAfterCalcCreditLimitLCYProcedure', '', true, true)]
    local procedure OnAfterCalcCreditLimitLCYProcedure(var Customer: Record Customer; var CustCreditAmountLCY: Decimal; var ExtensionAmountsDic: Dictionary of [Guid, Decimal])
    var

        gAddOnLicencePermission: Codeunit IntegrManagement;
        lPaymentFormIntegration: Codeunit "Payment Form Integration";
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lPaymentFormIntegration.CUSTUpdTotalAmountLCY(Customer, CustCreditAmountLCY);
        //wInitDueDateFilter;
        //CALCFIELDS("Payments not Due (LCY)");
        //CustCreditAmountLCY := CustCreditAmountLCY + "Payments not Due (LCY)";
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure OnAfterNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])
    var
        Navigate: page Navigate;
        PaymentHeader: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        PaymentHeaderArchive: Record "Payment Header Archive";
        PaymentLineArchive: Record "Payment Line Archive";
        wProdCompletionEntry: Record "Production Completion Entry";
        wAdvancedJobBudgetEntry: Record "Advanced Job Budget Entry";

    begin

        if not (ItemTrackingSearch) then
            case TempDocumentEntry."Table ID" of



                //BSK 03/07/2012

                DATABASE::"Payment Header":
                    PAGE.RUN(0, PaymentHeader);
                DATABASE::"Payment Line":
                    PAGE.RUN(0, PaymentLine);
                DATABASE::"Payment Header Archive":
                    PAGE.RUN(0, PaymentHeaderArchive);
                DATABASE::"Payment Line Archive":
                    PAGE.RUN(0, PaymentLineArchive);

                //BSK 03/07/2012


                //NAVIONE

                DATABASE::"Production Completion Entry":
                    PAGE.RUN(0, wProdCompletionEntry);
                /*  {
                      DATABASE::Table8003980:
                        PAGE.RUN(0,wInvCompletionEntry);
                      DATABASE::Table8003986:
                        PAGE.RUN(0,wCompletion);
                  }*/
                DATABASE::"Advanced Job Budget Entry":
                    PAGE.RUN(0, wAdvancedJobBudgetEntry);
            //NAVIONE

            end;

    end;


    //*************************************page 475************************************************//
    [EventSubscriber(ObjectType::Page, Page::"VAT Statement Preview Line", 'OnColumnValueDrillDownOnBeforeRunGeneralLedgerEntries', '', true, true)]
    local procedure OnColumnValueDrillDownOnBeforeRunGeneralLedgerEntries(var VATEntry: Record "VAT Entry"; var GLEntry: Record "G/L Entry"; var VATStatementLine: Record "VAT Statement Line")
    begin


        //BE_TVA
        // CASE VATStatementLine."Document Type" OF
        //     VATStatementLine."Document Type"::"All except Credit Memo":
        //         GLEntry.SETFILTER("Document Type", '<>%1', VATStatementLine."Document Type"::"Credit Memo");
        //     VATStatementLine."Document Type"::None:
        //         GLEntry.SETRANGE("Document Type", VATStatementLine."Document Type"::" ");
        //     VATStatementLine."Document Type"::" ":
        //         BEGIN
        //         END;   //Tous les documents
        //     ELSE
        //         GLEntry.SETRANGE("Document Type", VATStatementLine."Document Type");
    END;
    //BE_TVA//
    //end;

    [EventSubscriber(ObjectType::Page, Page::"VAT Statement Preview Line", 'OnBeforeOpenPageVATEntryTotaling', '', true, true)]
    local procedure OnBeforeOpenPageVATEntryTotaling(var VATEntry: Record "VAT Entry"; var VATStatementLine: Record "VAT Statement Line"; var GLEntry: Record "G/L Entry")
    begin

        //BE_TVA
        // CASE VATStatementLine."Document Type" OF
        //     VATStatementLine."Document Type"::"All except Credit Memo":
        //         VATEntry.SETFILTER("Document Type", '<>%1', VATStatementLine."Document Type"::"Credit Memo");
        //     VATStatementLine."Document Type"::None:
        //         VATEntry.SETRANGE("Document Type", VATStatementLine."Document Type"::" ");
        //     VATStatementLine."Document Type"::" ":
        //         BEGIN
        //         END;   //Tous les documents
        //     ELSE
        //         VATEntry.SETRANGE("Document Type", VATStatementLine."Document Type");
        // END;
        //BE_TVA//
    end;


    //*************************************page 5709************************************************//

    /*GL2024  [EventSubscriber(ObjectType::Page, Page::"Get Receipt Lines", 'OnBeforeIsFirstDocLine', '', true, true)]
      local procedure OnBeforeIsFirstDocLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var TempPurchRcptLine: Record "Purch. Rcpt. Line" temporary)
      var
          PurchRcptHeader: Record "Purch. Rcpt. Header";
          gVendorShipNo: Code[20];
      begin
          PurchRcptLine.Init();
          TempPurchRcptLine.Reset();
          // TempPurchRcptLine.CopyFilters(PurchRcptLine);
          TempPurchRcptLine.SetRange("Document No.", PurchRcptLine."Document No.");
          if not TempPurchRcptLine.FindFirst() then begin
              //+REF+MISC_PURCH
              IF PurchRcptLine."Line No." = TempPurchRcptLine."Line No." THEN BEGIN
                  PurchRcptHeader.GET(PurchRcptLine."Document No.");
                  gVendorShipNo := PurchRcptHeader."Vendor Shipment No.";
                  PurchRcptLine."Vendor Ship No." := gVendorShipNo;
                  PurchRcptLine.Insert();

              end;


          end;
      end;*/

    //*************************************page 6510************************************************//

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssistEditLotNoOnBeforeCurrPageUdate', '', true, true)]

    local procedure OnAssistEditLotNoOnBeforeCurrPageUdate(var TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification")
    begin
        //+REF+LOT
        TrackingSpecification."New Lot No." := TrackingSpecification."Lot No.";
        //+REF+LOT//
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeSetWarehouseControls', '', true, true)]
    local procedure OnBeforeSetWarehouseControls(TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean; var NewTrackingSpecification: Record "Tracking Specification")

    begin
        //+REF+LOT
        TrackingSpecification.LotNo := TrackingSpecification."Lot No.";
        TrackingSpecification.Serial := TrackingSpecification."Serial No.";
        TrackingSpecification.ExpDate := TrackingSpecification."Expiration Date";
        //+REF+LOT
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeLotNoOnAfterValidate', '', true, true)]
    local procedure OnBeforeLotNoOnAfterValidate(var TempTrackingSpecification: Record "Tracking Specification" temporary; SecondSourceQuantityArray: array[3] of Decimal)
    begin
        //+REF+LOT
        TempTrackingSpecification."New Lot No." := TempTrackingSpecification."Lot No.";
        //+REF+LOT//
    end;



    //*************************************page 9300************************************************//

    [EventSubscriber(ObjectType::Page, Page::"Sales Quotes", 'OnBeforeStatisticsAction', '', true, true)]

    local procedure OnBeforeStatisticsAction9300(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)

    VAR
        //GL2024 NAVIBAT    lStat: Page 8004045;
        lGR: Record "Gen. Product Posting Group";
    begin

        //#8601
        //CalcInvDiscForHeader;
        //COMMIT;
        //FORM.RUNMODAL(FORM::"Sales Statistics",Rec);
        //GL2024 NAVIBAT    CLEAR(lStat);
        CLEAR(lGR);
        //GL2024 NAVIBAT     lStat.GetSalesHeader(SalesHeader."Document Type", SalesHeader."No.");
        lGR.SETRANGE("Document Type Filter", SalesHeader."Document Type");
        lGR.SETRANGE("Document No. Filter", SalesHeader."No.");
        //lStat.SETRECORD(lGR);
        //GL2024 NAVIBAT    lStat.SETTABLEVIEW(lGR);
        //GL2024 NAVIBAT   lStat.RUNMODAL;
        //#8601//

        //   IsHandled := true;
    end;



}