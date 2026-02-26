codeunit 50034 SalesPostEvent
{

    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        lPaymentMethod: Record "Payment Method";
        lSalesInvHeader: Record "Sales Invoice Header";
        lSalesSubscrMgt: Codeunit "Sales Subscription Integr.";
        lNavibatSetup: Record "NavibatSetup";
        lSalesOverhead: Record "Sales Overhead-Margin";
        lDescriptionLine: Record "Description Line";
        lDescriptionLine2: Record "Description Line";
        lStructure: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
        lFinishOrder: Codeunit "Finish Sales Order";
        lPos: Integer;
        TextExp: label 'Expédition';
        lFirst: Boolean;
        lJob: Record Job;
        lWorkflowMgt: Codeunit "Workflow Management";
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        lJobTransferLine: Codeunit "Job Transfer Line";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lPostLineNo: Integer;
        lLineNoLink: Record "Sales Line No. Buffer";
        lWkfSetup: Record "Workflow Setup";
        lSalesPostPaymentIntegr: Codeunit "Sales-Post Payment Integr.";
        lSalesPostSubscriptionIntegr: Codeunit "Sales-Post Subscription integr";
        // lInvBufferSubscriptIntegr: Codeunit "Inv. Buffer Subscript integr";
        lSalesJobPostInt: Codeunit "Sales Job-Post Integration";
        lReorderReqMgt: Codeunit "Reordering Requisition mgt";
        wSalesLineEOF: Boolean;
        VATPostingSetup: Record "VAT Posting Setup";
        TotalAmountToInvoice: Decimal;
        DropShipPostBuffer: Record "Drop Shpt. Post. Buffer" temporary;
        wInvScheduler: Record "Invoice Scheduler";
        wJob: Record Job;
        //wAdvJobBudgetEntry : Report 8003906;
        wHideValidationDialog: Boolean;
        wPostProdCompletion: Boolean;
        LineAmountToInvoice: Decimal;
        wProfitCalcMethod: Option;
        wPresentationCodeFilter: Text[80];
        ErrorPaymentDirect: LABEL 'Le montant du paiement direct est supérieur au montant de la facture.';
        wCompletionMgt: Codeunit "Completion Management";

        gTakeOption: Boolean;
        gAddOnLicencePermission: Codeunit IntegrManagement;

        Text054: Label 'Facture Enregistré N° %1';
        ErrorMessageMgt: Codeunit "Error Message Management";
        ForwardLinkMgt: Codeunit "Forward Link Mgt.";
        ApplicationAreaMgmt: Codeunit "Application Area Mgmt.";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        DropShipmentErr: Label 'You cannot ship sales order line %1. The line is marked as a drop shipment and is not yet associated with a purchase order.', Comment = '%1 = Line No.';
    //HS Only ship order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]

    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            if not Confirm('Voulez-vous expédier cette commande ?') then
                IsHandled := true;
        end;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            DefaultOption := 1;
            HideDialog := true;
            SalesHeader.Ship := true;
            SalesHeader.Invoice := false;
        end;
    end;
    //HS Only ship order

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        RecSalesReceivablesSetup: Record "Sales & Receivables Setup";
        RecUserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        // RB SORO 26/08/2015 BETON
        /*  RecSalesReceivablesSetup.GET;
          IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
              IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
              IF (RecUserSetup."Souche Facture Vente" = RecUserSetup."Souche Facture Vente"::Beton) AND (SalesHeader."External Document No." = '') THEN BEGIN
                  // "Posting No. Series" := RecSalesReceivablesSetup."Souche Facture Beton";
                  SalesHeader."External Document No." := NoSeriesMgt.GetNextNo(RecSalesReceivablesSetup."Souche Facture Beton", WORKDATE, TRUE);
                  SalesHeader.MODIFY;
              END;
          END;*/
        //#7439
        wSalesLineEOF := FALSE;
        //#7439//
    end;
    //HS
    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeCheckAndUpdate', '', true, true)]

      local procedure OnRunOnBeforeCheckAndUpdate(var SalesHeader: Record "Sales Header")
      begin
          CalcTimbre(SalesHeader);
          CalcFodec(SalesHeader);
      end;*/
    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckTotalInvoiceAmount', '', true, true)]
    local procedure OnBeforeCheckTotalInvoiceAmount(SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin


        // >> HJ SORO  16-10-2014
        // CalcTimbre(SalesHeader);
        // CalcFodec(SalesHeader);
        // >> HJ SORO  16-10-2014
        /*GL2024    SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETFILTER(Quantity, '<>0');
            IF SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"] THEN
                SalesLine.SETFILTER("Qty. to Invoice", '<>0');

            //+ABO+ - FACT_AVOIR
            IF gAddOnLicencePermission.HasPermissionABO THEN
                TotalAmountToInvoice := lSalesPostSubscriptionIntegr.GetSalesTotaltAmountToInvoice(SalesLine, SalesHeader.Invoice);
            //+ABO+ - FACT_AVOIR//*/

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCheckSalesDocumentOnAfterCalcShouldCheckItemCharge', '', true, true)]
    local procedure OnCheckSalesDocumentOnAfterCalcShouldCheckItemCharge(var SalesHeader: Record "Sales Header"; WhseReceive: Boolean; WhseShip: Boolean; var ShouldCheckItemCharge: Boolean; var ModifyHeader: Boolean)
    begin
        IF (SalesHeader.Invoice) AND (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") THEN
            ShouldCheckItemCharge := true
        else
            ShouldCheckItemCharge := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCheckSalesDocumentOnBeforeCheckDueDate', '', true, true)]
    local procedure OnCheckSalesDocumentOnBeforeCheckDueDate(var SalesHeader: Record "Sales Header"; var ShouldCheckDueDate: Boolean)
    begin
        ShouldCheckDueDate := false;
        IF SalesHeader.Invoice AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN
            ShouldCheckDueDate := true;
    end;

    /*GL2024 Erreur validation commande vente
      [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeUpdatePostingNo', '', true, true)]
      local procedure OnBeforeUpdatePostingNo(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var ModifyHeader: Boolean; var IsHandled: Boolean)
      begin
          IF SalesHeader.Invoice AND (SalesHeader."Posting No." = '') OR (SalesHeader."Order Type" <> SalesHeader."Order Type"::" ") THEN
              IsHandled := true;
      end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnUpdateAssosOrderPostingNosOnAfterSetFilterTempSalesLine', '', true, true)]
    local procedure OnUpdateAssosOrderPostingNosOnAfterSetFilterTempSalesLine(var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //DEVIS
        TempSalesLine.SETRANGE("Structure Line No.", 0);
        //#8591    SalesLine.SETRANGE("Assignment Basis",0);
        //DEVIS//
        //CDE_INTERNE
        IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN
            TempSalesLine.SETFILTER("Qty. to Ship", '<>0');
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertPostedHeaders', '', true, true)]
    local procedure OnBeforeInsertPostedHeaders(var SalesHeader: Record "Sales Header"; var TempWarehouseShipmentHeader: Record "Warehouse Shipment Header" temporary; var TempWarehouseReceiptHeader: Record "Warehouse Receipt Header" temporary)
    begin
        //PROJET_FACT
        wPostProdCompletion := lSalesJobPostInt.GetPostProdCompletion(SalesHeader);
        //PROJET_FACT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader', '', true, true)]
    local procedure OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    var
        GLEntry: Record "G/L Entry";
    begin
        //POSTING_DESC
        //#6367
        //SalesShptHeader."Posting Description" := SalesHeader.wShowPostingDescription("Posting Description");
        SalesShptHeader."Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader.wPostingDescription);
        //#6367//
        GLEntry."Document Type" := GLEntry."Document Type"::Invoice;
        lPos := STRPOS(SalesShptHeader."Posting Description", FORMAT(GLEntry."Document Type"));
        IF lPos <> 0 THEN BEGIN
            SalesShptHeader."Posting Description" :=
            DELSTR(SalesShptHeader."Posting Description", lPos, STRLEN(FORMAT(GLEntry."Document Type")));
            SalesShptHeader."Posting Description" :=
            COPYSTR(INSSTR(SalesShptHeader."Posting Description", TextExp, lPos), 1, MAXSTRLEN(SalesShptHeader."Posting Description"));
        END;
        //POSTING_DESC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesShptHeaderInsert', '', true, true)]
    local procedure OnAfterSalesShptHeaderInsert(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; SuppressCommit: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    begin
        //  //+WKF+CUSTOM
        //           IF NOT SalesHeader.Invoice THEN BEGIN
        //             //#7440
        //             IF (lWkfSetup.READPERMISSION) THEN BEGIN
        //             //#7440//
        //               IF lWorkflowMgt.Exists(FORM::"Sales Order",'') THEN
        //                 IF lWorkflowMgt.WorkflowTypeNo(PAGE::"Sales Order",'',SalesHeader."No.",'','') THEN;
        //             //#7440
        //             END;
        //             //#7440//
        //           END;
        //     //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentHeader', '', true, true)]
    local procedure OnAfterInsertShipmentHeader(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        //PROJET_BUDGET
        lSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        lSalesHeader.SETRANGE("No.", SalesHeader."No.");
        // CLEAR(wAdvJobBudgetEntry);
        // wAdvJobBudgetEntry.InitRequest(SalesHeader."Posting Date");
        // wAdvJobBudgetEntry.InitShipmentNo(SalesShipmentHeader."No.");
        // wAdvJobBudgetEntry.SETTABLEVIEW(lSalesHeader);
        // wAdvJobBudgetEntry.USEREQUESTFORM(FALSE);
        // wAdvJobBudgetEntry.RUNMODAL;
        //PROJET_BUDGET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertPostedHeadersOnAfterCalcShouldInsertInvoiceHeader', '', true, true)]
    local procedure OnInsertPostedHeadersOnAfterCalcShouldInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var ShouldInsertInvoiceHeader: Boolean)
    begin
        ShouldInsertInvoiceHeader := false;
        IF SalesHeader.Invoice AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN
            IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND (TotalAmountToInvoice >= 0) THEN
                ShouldInsertInvoiceHeader := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields', '', true, true)]
    local procedure OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        //POSTING_DESC
        //#6367
        //SalesInvHeader."Posting Description" := SalesHeader.wShowPostingDescription("Posting Description");
        SalesInvoiceHeader."Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader.wPostingDescription);
        //#6367//
        //POSTING_DESC//
        //+ONE+PREPAYMENT
        CLEAR(SalesInvoiceHeader."Prepayment Rank No.");
        //+ONE+PREPAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; WhseShip: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; InvtPickPutaway: Boolean)
    begin
        //#8625
        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND (SalesHeader."Rider to Order No." <> '')) THEN
            SalesInvHeader."Order No." := SalesHeader."Rider to Order No.";
        //#8625//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    begin
        //DESCRIPTION
        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Header");
        lDescriptionLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lDescriptionLine.SETRANGE("Document No.", SalesHeader."No.");
        lDescriptionLine.SETRANGE("Document Line No.", 0);
        IF lDescriptionLine.FINDSET THEN
            REPEAT
                lDescriptionLine2 := lDescriptionLine;
                lDescriptionLine2."Table ID" := 112;
                lDescriptionLine2."Document Type" := SalesHeader."Document Type"::Invoice;
                lDescriptionLine2."Document No." := SalesInvHeader."No.";
                lDescriptionLine2.INSERT;
            UNTIL lDescriptionLine.NEXT = 0;
        //DESCRIPTION//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields', '', true, true)]
    local procedure OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        //POSTING_DESC
        //#6367
        //SalesCrMemoHeader."Posting Description" := SalesHeader.wShowPostingDescription("Posting Description");
        SalesCrMemoHeader."Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader.wPostingDescription);
        //#6367//
        //POSTING_DESC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
    local procedure OnAfterSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    begin
        //DESCRIPTION
        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Header");
        lDescriptionLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lDescriptionLine.SETRANGE("Document No.", SalesHeader."No.");
        lDescriptionLine.SETRANGE("Document Line No.", 0);
        IF lDescriptionLine.FINDSET THEN
            REPEAT
                lDescriptionLine2 := lDescriptionLine;
                lDescriptionLine2."Table ID" := 114;
                lDescriptionLine2."Document Type" := SalesHeader."Document Type"::"Credit Memo";
                lDescriptionLine2."Document No." := SalesCrMemoHeader."No.";
                lDescriptionLine2.INSERT;
            UNTIL lDescriptionLine.NEXT = 0;
        //DESCRIPTION//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertPostedHeadersOnAfterInsertCrMemoHeader', '', true, true)]
    local procedure OnInsertPostedHeadersOnAfterInsertCrMemoHeader(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        //POSTING_DESC
        //#6367
        IF SalesHeader.Invoice THEN
            SalesHeader."Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader.wPostingDescription);
        //"Posting Description" := SalesHeader.wShowPostingDescription("Posting Description");
        //#6367//
        //POSTING_DESC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeCalcVATAmountLines', '', true, true)]
    local procedure OnRunOnBeforeCalcVATAmountLines(var TempSalesLineGlobal: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header"; var TempVATAmountLine: Record "VAT Amount Line" temporary; var IsHandled: Boolean)
    begin
        //#8559
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            //#8559//
            //#7319
            TempSalesLineGlobal.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        //#7319//
        //DEVIS
        TempSalesLineGlobal.SETRANGE("Structure Line No.", 0);
        //#8591  SalesLine.SETRANGE("Assignment Basis",0);
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesLines', '', true, true)]
    local procedure OnBeforePostSalesLines(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var TempVATAmountLine: Record "VAT Amount Line" temporary; var EverythingInvoiced: Boolean)
    var
        ff: record 37;
    begin
        //DEVIS Filtre repos‚ une deuxiŠme fois au retour de la fonction SalesLine.CalcVATAmountLines
        TempSalesLineGlobal.SETRANGE("Structure Line No.", 0);
        //#8591  SalesLine.SETRANGE("Assignment Basis",0);
        //DEVIS//
        //CDE_INTERNE
        IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN
            TempSalesLineGlobal.SETFILTER("Outstanding Quantity", '<>0');
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforePostSalesLineEndLoop', '', true, true)]
    local procedure OnRunOnBeforePostSalesLineEndLoop(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var LastLineRetrieved: Boolean; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; RecSalesHeader: Record "Sales Header"; xSalesLine: Record "Sales Line"; var SalesShipmentHeader: Record "Sales Shipment Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    begin
        //#7319
        fInitRenumberLine(lPostLineNo, lLineNoLink);
        //#7319//
        //#6284
        IF (SalesLine.Type = SalesLine.Type::Item) OR (SalesLine.Type = SalesLine.Type::Resource) THEN
            SalesLine.TESTFIELD("Job No.");
        //#6284//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestUpdatedSalesLine', '', true, true)]
    local procedure OnBeforeTestUpdatedSalesLine(SalesLine: Record "Sales Line"; var IsHandled: Boolean; var ErrorMessageManagement: Codeunit "Error Message Management")
    begin
        if SalesLine."Drop Shipment" then begin
            //DEVIS
            //        IF SalesLine.Type <> SalesLine.Type::Item THEN
            IF (SalesLine.Type <> SalesLine.Type::Item) AND (SalesLine."Line Type" <> SalesLine."Line Type"::Structure) THEN
                //DEVIS//
                    SalesLine.TestField("Drop Shipment", false);
            if (SalesLine."Qty. to Ship" <> 0) and (SalesLine."Purch. Order Line No." = 0) then
                ErrorMessageMgt.LogErrorMessage(SalesLine.FieldNo("Purchasing Code"), StrSubstNo(DropShipmentErr, SalesLine."Line No."),
                    0, 0, ForwardLinkMgt.GetHelpCodeForSalesLineDropShipmentErr());
        end;
        //DEVIS
        IF (SalesLine."Line Type" <> SalesLine."Line Type"::Totaling) THEN
            //DEVIS//
        if SalesLine.Quantity = 0 then
                SalesLine.TestField(Amount, 0)
            else begin
                SalesLine.TestField("No.");
                SalesLine.TestField(Type);
                if not ApplicationAreaMgmt.IsSalesTaxEnabled() then
                    TestGenPostingGroups(SalesLine);
            end;
        IsHandled := true;
    end;
    ////////////////////////////////////////////////////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestSalesLineFixedAsset', '', true, true)]
    local procedure OnBeforeTestSalesLineFixedAsset(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        FixedAsset: Record "Fixed Asset";
        DeprBook: Record "Depreciation Book";
    begin
        //SalesLine.TestField("Job No.", '', ErrorInfo.Create());
        SalesLine.TestField("Depreciation Book Code", ErrorInfo.Create());
        DeprBook.Get(SalesLine."Depreciation Book Code");
        DeprBook.TestField("G/L Integration - Disposal", true, ErrorInfo.Create());
        FixedAsset.Get(SalesLine."No.");
        FixedAsset.TestField("Budgeted Asset", false, ErrorInfo.Create());
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemTrackingLineOnAfterRetrieveInvoiceSpecification', '', true, true)]
    local procedure OnPostItemTrackingLineOnAfterRetrieveInvoiceSpecification(var SalesLine: Record "Sales Line"; var TempInvoicingSpecification: Record "Tracking Specification" temporary; var TrackingSpecificationExists: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        IF SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") THEn;
        //CDE_INTERNE
        if SalesHeader.Invoice AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") then
            //CDE_INTERNE//
            if SalesLine."Qty. to Invoice" = 0 then
                TrackingSpecificationExists := false
            else
                TrackingSpecificationExists :=
                  SalesLineReserve.RetrieveInvoiceSpecification(SalesLine, TempInvoicingSpecification);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckReturnRcptLine', '', true, true)]
    local procedure OnBeforeCheckReturnRcptLine(var ReturnReceiptLine: Record "Return Receipt Line"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        ReturnReceiptLine.TestField("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
        ReturnReceiptLine.TestField(Type, SalesLine.Type);
        ReturnReceiptLine.TestField("No.", SalesLine."No.");
        //PROJET
        //              ReturnReceiptLine.TESTFIELD("Gen. Bus. Posting Group",SalesLine."Gen. Bus. Posting Group");
        //              ReturnReceiptLine.TESTFIELD("Gen. Prod. Posting Group",SalesLine."Gen. Prod. Posting Group");
        //              ReturnReceiptLine.TESTFIELD("Job No.",SalesLine."Job No.");
        ReturnReceiptLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        ReturnReceiptLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        ReturnReceiptLine."Job No." := SalesLine."Job No.";
        ReturnReceiptLine."Work Type Code" := SalesLine."Work Type Code";
        //PROJET//
        ReturnReceiptLine.TestField("Unit of Measure Code", SalesLine."Unit of Measure Code");
        ReturnReceiptLine.TestField("Variant Code", SalesLine."Variant Code");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemTrackingForShipmentOnAfterSetFilters', '', true, true)]
    local procedure OnPostItemTrackingForShipmentOnAfterSetFilters(var SalesShipmentLine: Record "Sales Shipment Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    begin
        //#8877
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin

            IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."Supply Order No." <> '') AND
               (SalesLine."Supply Order Line No." <> 0) THEN BEGIN
                SalesShipmentLine.SETRANGE("Order No.", SalesLine."Supply Order No.");
                SalesShipmentLine.SETRANGE("Order Line No.", SalesLine."Supply Order Line No.");
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemTrackingForShipmentOnBeforeTestLineFields', '', true, true)]
    local procedure OnPostItemTrackingForShipmentOnBeforeTestLineFields(var SalesShipmentLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        SalesShipmentLine.TestField("Sell-to Customer No.", SalesLine."Sell-to Customer No.");
        SalesShipmentLine.TestField(Type, SalesLine.Type);
        SalesShipmentLine.TestField("No.", SalesLine."No.");
        //PROJET
        //              SalesShipmentLine.TESTFIELD("Gen. Bus. Posting Group",SalesLine."Gen. Bus. Posting Group");
        //              SalesShipmentLine.TESTFIELD("Gen. Prod. Posting Group",SalesLine."Gen. Prod. Posting Group");
        //              SalesShipmentLine.TESTFIELD("Job No.",SalesLine."Job No.");
        SalesShipmentLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        SalesShipmentLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        SalesShipmentLine."Job No." := SalesLine."Job No.";
        SalesShipmentLine."Job Task No." := SalesLine."Job Task No.";
        SalesShipmentLine."Work Type Code" := SalesLine."Work Type Code";
        //PROJET//

        SalesShipmentLine.TestField("Unit of Measure Code", SalesLine."Unit of Measure Code");
        SalesShipmentLine.TestField("Variant Code", SalesLine."Variant Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnAfterPostItemTrackingLine', '', true, true)]
    local procedure OnPostSalesLineOnAfterPostItemTrackingLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; WhseShip: Boolean; WhseReceive: Boolean; InvtPickPutaway: Boolean; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary; var TempPostedATOLink: Record "Posted Assemble-to-Order Link" temporary)
    begin
        //PROJET_FACT : V‚rification ligne ‚ch‚ancier existe
        lSalesJobPostInt.GetScheduleInvExist(SalesHeader, SalesLine);
        //PROJET_FACT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostResJnlLine', '', true, true)]
    local procedure OnBeforePostResJnlLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var JobTaskSalesLine: Record "Sales Line"; var IsHandled: Boolean; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; SalesShptHeader: Record "Sales Shipment Header"; ReturnRcptHeader: Record "Return Receipt Header"; var ResJnlPostLine: Codeunit "Res. Jnl.-Post Line")
    begin
        //SUBCONTRACTOR
        BEGIN
            IF (SalesLine."Qty. to Ship" <> 0) AND (SalesLine."Purch. Order Line No." <> 0) THEN BEGIN
                DropShipPostBuffer."Order No." := SalesLine."Purchase Order No.";
                DropShipPostBuffer."Order Line No." := SalesLine."Purch. Order Line No.";
                DropShipPostBuffer.Quantity := -SalesLine."Qty. to Ship";
                DropShipPostBuffer."Quantity (Base)" := -SalesLine."Qty. to Ship (Base)";
                DropShipPostBuffer.INSERT;
            END;
            //SUBCONTRACTOR//
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeTestJobNo', '', true, true)]
    local procedure OnPostSalesLineOnBeforeTestJobNo(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeInsertShipmentLine', '', true, true)]
    local procedure OnPostSalesLineOnBeforeInsertShipmentLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35])
    begin
        //PROJET : Post job entry
        //#8877
        // lSalesJobPostInt.PostJobEntry(SalesHeader, SalesLine, SalesInvHeader, SalesShptHeader, SalesCrMemoHeader,
        //                             ReturnRcptHeader, SalesLineACY, Currency, TempDocDim, SrcCode, DocNo);
        //#8877//
        //PROJET//
    end;

    // [EventSubscriber(ObjectType::Codeunit, 80, 'OnInsertShipmentLineOnAfterInitQuantityFields', '', true, true)]
    // local procedure OnInsertShipmentLineOnAfterInitQuantityFields(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    // begin
    //     //#8877
    //     IF NOT lReorderReqMgt.SetOrderLineFromReq(SalesLine, xSalesLine, SalesShptLine) THEN BEGIN
    //         //#8877//
    //     end;
    // END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeInsertInvoiceLine', '', true, true)]
    local procedure OnPostSalesLineOnBeforeInsertInvoiceLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header"; var ShouldInsertInvoiceLine: Boolean)
    begin
        ShouldInsertInvoiceLine := false;
        //CDE_INTERNE
        //      IF Invoice THEN BEGIN
        // XPE - INSERT VALIDATION FACTURE CREDIT MEMO
        IF SalesHeader.Invoice AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN
            //+ABO+ - FACT_AVOIR***
            //        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
            IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) AND (TotalAmountToInvoice >= 0) THEN
                ShouldInsertInvoiceLine := true;
        //+ABO+ - FACT_AVOIR
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', true, true)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Lineno: Integer;
    begin

        // HS Ligne exist  fSetNumberLine(0, SalesInvLine, SalesCrMemoLine, SalesLine, lPostLineNo, lLineNoLink);
        //#7319//
        //#8655
        IF SalesInvLine."Line Type" = SalesInvLine."Line Type"::Totaling THEN
            SalesInvLine."Line Amount" := 0;
        //#8655//
        //#9351
        IF SalesInvLine."Line Type" = SalesInvLine."Line Type"::Totaling THEN
            SalesInvLine."Inv. Discount Amount" := 0;
        //#9351//
        //#8591
        //HS Bug Fix
        IF SalesLine."Assignment Basis" <> SalesLine."Assignment Basis"::" " THEN
            IsHandled := true;
        //HS Bug Fix
        //#8591//
    end;
    ///////////////////////////////////////////////////////////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    begin
        //#8655
        IF (SalesInvLine."No." <> '') AND (SalesInvLine."Line Amount" <> 0) THEN
            wUpdateTotaling(SalesInvLine, SalesInvLine."Line Amount");
        //#8655//
        //#7439
        //   DimMgt.fMoveOneDocDimToRenbrPostDocDi(
        //     TempDocDim,DATABASE::"Sales Line","Document Type","No.",SalesLine."Line No.",
        //     DATABASE::"Sales Invoice Line",SalesInvHeader."No.", SalesInvLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var PostingSalesLine: Record "Sales Line")
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        //#7319
        // HS Ligne exist     fSetNumberLine(1, SalesInvLine, SalesCrMemoLine, SalesLine, lPostLineNo, lLineNoLink);
        //#7319//
        //#8591
        //HS change to <>
        IF SalesLine."Assignment Basis" <> SalesLine."Assignment Basis"::" " THEN
            IsHandled := true;
        //#8591//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoLineInsert', '', true, true)]
    local procedure OnAfterSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary)
    begin
        //#7439
        // DimMgt.fMoveOneDocDimToRenbrPostDocDi(
        //   TempDocDim, DATABASE::"Sales Line", "Document Type", "No.", SalesLine."Line No.",
        //   DATABASE::"Sales Cr.Memo Line", SalesCrMemoHeader."No.", SalesCrMemoLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', true, true)]
    local procedure OnAfterPostSalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var SalesInvLine: Record "Sales Invoice Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var xSalesLine: Record "Sales Line")
    begin
        //+ABO+
        IF (SalesLine."Blanket Order No." <> '') AND (SalesLine."Subscription Posting Date" <> 0D)
           AND gAddOnLicencePermission.HasPermissionABO THEN
            lSalesSubscrMgt.UpdateSubscrPostingDate(SalesLine);
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostInvoice', '', true, true)]
    local procedure OnBeforePostInvoice(var SalesHeader: Record "Sales Header"; var CustLedgerEntry: Record "Cust. Ledger Entry"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10])
    begin
        //CDE_INTERNE
        //  IF Invoice THEN BEGIN
        IF SalesHeader.Invoice AND (SalesHeader."Order Type" <> SalesHeader."Order Type"::" ") THEN
            IsHandled := true;
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::table, Database::"Invoice Posting Buffer", 'OnAfterCopyToGenJnlLine', '', true, true)]
    local procedure OnAfterCopyToGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostingBuffer: Record "Invoice Posting Buffer");
    begin
        //+ABO+
        // IF gAddOnLicencePermission.HasPermissionABO THEN
        //     lInvBufferSubscriptIntegr.SetGenJnlLineSubscripDate(GenJnlLine, InvoicePostingBuffer);
        //+ABO+//
        //PROJET (#5002)
        GenJnlLine."Job No." := InvoicePostingBuffer."Job No.";
        // GenJnlLine."Job Task No." := InvoicePostingBuffer."Job Task No.";
        //PROJET//
        //#7220
        GenJnlLine."System-Created Entry" := FALSE;
        //#7220

    end;

    [EventSubscriber(ObjectType::table, Database::"Invoice Posting Buffer", 'OnAfterCopyToGenJnlLineFA', '', true, true)]
    local procedure OnAfterCopyToGenJnlLineFA(var GenJnlLine: Record "Gen. Journal Line"; InvoicePostingBuffer: Record "Invoice Posting Buffer");
    begin
        //PROJET_IMMO
        IF (GenJnlLine."Job No." <> InvoicePostingBuffer."Job No.") AND (InvoicePostingBuffer."Job No." <> '') THEN
            GenJnlLine.VALIDATE("Job No.", InvoicePostingBuffer."Job No.");
        //PROJET_IMMO//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", 'OnBeforePostLedgerEntry', '', true, true)]
    local procedure OnBeforePostLedgerEntry(var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; SuppressCommit: Boolean; PreviewMode: Boolean; InvoicePostingParameters: Record "Invoice Posting Parameters"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    begin
        //+ABO+ - FACT_AVOIR ***
        IF gAddOnLicencePermission.HasPermissionABO THEN
            lSalesPostSubscriptionIntegr.SetSalesHeaderbyCreditMemo(SalesHeader, TotalAmountToInvoice);
        //+ABO+ - FACT_AVOIR//
    end;

    [EventSubscriber(ObjectType::table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //PROJET
        GenJournalLine."Job No." := SalesHeader."Job No.";
        //PROJET//
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lSalesPostPaymentIntegr.SetGenJnlLineFromSalesHeader(GenJournalLine, SalesHeader);
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", 'OnPostLedgerEntryOnBeforeGenJnlPostLine', '', true, true)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        //+PMT+MULTI
        //IF gAddOnLicencePermission.HasPermissionPMT() THEN
        //lSalesPostPaymentIntegr.SetAndPostMultiLine(SalesHeader,Currency,GenJnlLine,TempJnlLineDim,GenJnlLineDocNo,GenJnlPostLine)
        //ELSE
        //+PMT+MULTI//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterUpdateLastPostingNos', '', true, true)]
    local procedure OnAfterUpdateLastPostingNos(var SalesHeader: Record "Sales Header")
    VAR

    begin
        // //PROJET_FACT
        // //#6189 
        // IF SalesHeader.Ship then
        //     wCompletionMgt.InsertProductionCompletion(SalesHeader, SalesLine, SalesShptHeader);
        // //#6189//
        // //PROJET_FACT//
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    local procedure OnRunOnBeforeFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; GenJnlLineExtDocNo: Code[35]; var EverythingInvoiced: Boolean; GenJnlLineDocNo: Code[20]; SrcCode: Code[10]; PreviewMode: Boolean)
    var
        RecSalesLine: Record "Sales Line";
    begin
        //PROJET_FACT
        //#6189 
        //HS
        IF SalesHeader.Ship then begin
            RecSalesLine.Reset();
            RecSalesLine.SetRange("Document Type", SalesHeader."Document Type");
            RecSalesLine.SetRange("Document No.", SalesHeader."No.");
            if RecSalesLine.FindSet() then
                wCompletionMgt.InsertProductionCompletion(SalesHeader, RecSalesLine, SalesShipmentHeader);
        end;
        //HS
        //#6189//
        //PROJET_FACT//
        IF SalesHeader.Invoice AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN BEGIN
            //CDE_INTERNE//

            //PROJET_FACT 
            wCompletionMgt.UpdateInvScheduler(SalesHeader, SalesInvoiceHeader, SalesCrMemoHeader);
            //PROJET_FACT//

            //ACOMPTE
            IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Part Payment" <> 0) AND SalesHeader.Invoice
            //#5535
            AND (SalesHeader."Invoicing Method" <> SalesHeader."Invoicing Method"::Completion)
                //#5535//
                THEN BEGIN
                SalesHeader.CALCFIELDS(Amount);
                SalesInvoiceHeader.CALCFIELDS(Amount);
                SalesInvoiceHeader."Part Payment" := ROUND(SalesHeader."Part Payment" * SalesInvoiceHeader.Amount / SalesHeader.Amount, 0.01);
                SalesInvoiceHeader.MODIFY;
            END;
            //ACOMPTE//
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostUpdateOrderLineOnAfterSetFilters', '', true, true)]
    local procedure OnPostUpdateOrderLineOnAfterSetFilters(var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesHeader: Record "Sales Header";
    begin
        //CDE_INTERNE
        IF SalesHeader.get(TempSalesLine."Document Type", TempSalesLine."Document No.") THEN;
        IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN BEGIN
            TempSalesLine.SETFILTER("Outstanding Quantity", '<>0');
            TempSalesLine.SETRANGE("Qty. to Ship");
        END;
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostUpdateOrderLine', '', true, true)]
    local procedure OnAfterPostUpdateOrderLine(var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesHeader: Record "Sales Header";

    begin
        //PROJET_FACT
        IF SalesHeader.get(TempSalesLine."Document Type", TempSalesLine."Document No.") THEN;

        wCompletionMgt.MAJCompletion(SalesHeader, wPostProdCompletion);
        //PROJET_FACT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterResetTempLines', '', true, true)]
    local procedure OnAfterResetTempLines(var TempSalesLineLocal: Record "Sales Line" temporary)
    var
        SalesHeader: Record "Sales Header";
    begin
        //CDE_INTERNE
        IF SalesHeader.get(TempSalesLineLocal."Document Type", TempSalesLineLocal."Document No.") THEN;
        IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN
            TempSalesLineLocal.SETFILTER("Outstanding Quantity", '<>0');
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnDeleteAfterPostingOnBeforeDeleteLinks', '', true, true)]
    local procedure OnDeleteAfterPostingOnBeforeDeleteLinks(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //#6362
        // On n'effectue uniquement le traitement qui suit, pour les documents autre que "demande d'appro"
        IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostInvoiceOnBeforePostBalancingEntry', '', true, true)]
    local procedure OnPostInvoiceOnBeforePostBalancingEntry(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; SuppressCommit: Boolean; PreviewMode: Boolean; InvoicePostingParameters: Record "Invoice Posting Parameters"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        IF SalesInvHeader."No." <> '' THEN MESSAGE(Text054, SalesInvHeader."No.");
    end;

    /*GL2024  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemJnlLine', '', true, true)]
      local procedure OnBeforePostItemJnlLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var QtyToBeShipped: Decimal; var QtyToBeShippedBase: Decimal; var QtyToBeInvoiced: Decimal; var QtyToBeInvoicedBase: Decimal; var ItemLedgShptEntryNo: Integer; var ItemChargeNo: Code[20]; var TrackingSpecification: Record "Tracking Specification"; var IsATO: Boolean; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var Result: Integer; var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempHandlingSpecification: Record "Tracking Specification" temporary; var TempValueEntryRelation: Record "Value Entry Relation" temporary; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
      var
          CduSalesPost: Codeunit "Sales-Post";
      begin
          //#8877
          IF (QtyToBeShipped = QtyToBeInvoiced) AND (ItemLedgShptEntryNo = 0) THEN BEGIN
              IF (SalesLine."Order Type" <> SalesLine."Order Type"::"Supply Order") THEN BEGIN
                  ItemLedgShptEntryNo :=
                    CduSalesPost.PostItemJnlLine(SalesHeader,
                      SalesLine,
                      QtyToBeShipped,
                      QtyToBeShippedBase,
                      0, 0, 0, '', TrackingSpecification, FALSE);
                  QtyToBeShipped := 0;
                  QtyToBeShippedBase := 0;
              END ELSE BEGIN
                  lReorderReqMgt.SetQtyToBeInvoiced(SalesLine, QtyToBeInvoiced, QtyToBeInvoicedBase);
              END;
          END;
          //#8877//
      end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLinePrepareJournalLineOnBeforeCalcItemJnlAmounts', '', true, true)]
    local procedure OnPostItemJnlLinePrepareJournalLineOnBeforeCalcItemJnlAmounts(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; IsATO: Boolean)
    begin
        //+REF+FIN_CREDIT
        ItemJnlLine."Financial Document" := SalesHeader."Financial Document";
        //+REF+FIN_CREDIT//
        //PROJET (#4410)
        ItemJnlLine."Job No." := SalesLine."Job No.";
        //#8331
        ItemJnlLine."Job Task No." := SalesLine."Job Task No.";
        //#8877
        ItemJnlLine."Job Purchase" := SalesLine."Special Order";
        //#8877//

        //#8331//
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', true, true)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var QtyToBeShipped: Decimal; TrackingSpecification: Record "Tracking Specification"; var QtyToBeInvoiced: Decimal; var QtyToBeInvoicedBase: Decimal; var QtyToBeShippedBase: Decimal; var RemAmt: Decimal; var RemDiscAmt: Decimal)
    begin
        //      //#9132
        //       IF  (SalesHeader."Document Type"= SalesHeader."Document Type"::"Credit Memo") THEN BEGIN
        //         IF ItemJournalLine."Document No." = '' THEN BEGIN
        //           IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
        //             ItemJournalLine."Document Type" := ItemJournalLine."Document Type"::"Sales Credit Memo";
        //             ItemJournalLine."Document No." := GenJnlLineDocNo;
        //           END;
        //         END;
        //       END;
        //   //#9132//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemJnlLineItemCharges', '', true, true)]
    local procedure OnBeforePostItemJnlLineItemCharges(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";

    begin
        IF SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") THEN;
        IF (SalesLine.Type = SalesLine.Type::Item) AND SalesHeader.Invoice AND (SalesHeader."Order Type" <> SalesHeader."Order Type"::" ") THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemChargePerOrderOnBeforeTestJobNo', '', true, true)]
    local procedure OnPostItemChargePerOrderOnBeforeTestJobNo(SalesLine: Record "Sales Line"; var SkipTestJobNo: Boolean)
    begin
        SkipTestJobNo := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemChargePerRetRcptOnBeforeTestFieldJobNo', '', true, true)]
    local procedure OnPostItemChargePerRetRcptOnBeforeTestFieldJobNo(ReturnReceiptLine: Record "Return Receipt Line"; var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInitAssocItemJnlLine', '', true, true)]
    local procedure OnAfterInitAssocItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; QtyToBeShipped: Decimal; QtyToBeShippedBase: Decimal)
    var
        lJob: Record Job;
    begin
        //#8877
        IF lJob.GET(PurchaseLine."dysJob No.") THEN
            IF lJob."Job Type" <> lJob."Job Type"::Stock THEN BEGIN
                ItemJournalLine."Job No." := PurchaseLine."dysJob No.";
                ItemJournalLine."Job Task No." := PurchaseLine."dysJob Task No.";

            END;
        IF ItemJournalLine."Job No." <> '' THEN
            ItemJournalLine."Job Purchase" := TRUE;
        //#8877
        //PROJET
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnSumSalesLines2SetFilter', '', true, true)]
    local procedure OnSumSalesLines2SetFilter(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; InsertSalesLine: Boolean; var QtyType: Option)
    begin
        //#4797
        //  OldSalesLine.SETCURRENTKEY("Job No.","Document Type","Document No.","Gen. Prod. Posting Group",Option,Disable,
        //                    "Assignment Basis",Type,"Line Type","Presentation Code","Structure Line No.","No.");
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option)
      ;

        //#4797//
        //#4797
        SalesLine.SETRANGE("Structure Line No.", 0);
        //#4797//

        //#7838
        //#7892
        IF NOT gTakeOption THEN
            //#7892//
            SalesLine.SETRANGE(Option, FALSE);
        SalesLine.SETRANGE(Disable, FALSE);
        //#7838//

        //DEVIS_STAT
        IF wPresentationCodeFilter <> '' THEN
            SalesLine.SETFILTER("Presentation Code", wPresentationCodeFilter);
        //DEVIS_STAT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnSumSalesLines2OnBeforeDivideAmount', '', true, true)]
    local procedure OnSumSalesLines2OnBeforeDivideAmount(var OldSalesLine: Record "Sales Line"; var IsHandled: Boolean; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; QtyType: Option; var SalesLineQty: Decimal; var TempVATAmountLine: Record "VAT Amount Line" temporary; var TempVATAmountLineRemainder: Record "VAT Amount Line" temporary; IncludePrepayments: Boolean; RoundingLineInserted: Boolean)
    begin
        //ANA_MARGE
        IF QtyType > 2 THEN
            SalesLineQty := SalesLine."Quantity (Base)";
        //ANA_MARGE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCopyAndCheckItemChargeOnBeforeLoop', '', true, true)]
    local procedure OnCopyAndCheckItemChargeOnBeforeLoop(var TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header"; var SkipTestJobNo: Boolean)
    begin
        SkipTestJobNo := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCreatePrepaymentLines', '', true, true)]
    local procedure OnBeforeCreatePrepaymentLines(var SalesHeader: Record "Sales Header"; var TempPrepmtSalesLine: Record "Sales Line" temporary; CompleteFunctionality: Boolean; var IsHandled: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        //#7849
        IF SalesHeader."Invoicing Method" <> SalesHeader."Invoicing Method"::Direct THEN
            SalesHeader."Compress Prepayment" := FALSE;
        //#7849//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestSalesLineJob', '', true, true)]

    local procedure OnBeforeTestSalesLineJob(SalesLine: Record "Sales Line"; var SkipTestJobNo: Boolean)
    begin
        SkipTestJobNo := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCreatePrepaymentLinesOnAfterTempPrepmtSalesLineSetFilters', '', true, true)]
    local procedure OnCreatePrepaymentLinesOnAfterTempPrepmtSalesLineSetFilters(var TempPrepmtSalesLine: Record "Sales Line" temporary; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //+ONE+PREPAYMENT_VAT
        TempPrepmtSalesLine.SETRANGE("VAT Bus. Posting Group", TempSalesLine."VAT Bus. Posting Group");
        TempPrepmtSalesLine.SETRANGE("VAT Prod. Posting Group", TempSalesLine."VAT Prod. Posting Group");
        //+ONE+PREPAYMENT_VAT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCreatePrepaymentLinesOnBeforeValidateType', '', true, true)]
    local procedure OnCreatePrepaymentLinesOnBeforeValidateType(var TempPrepmtSalesLine: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //+ONE+
        TempPrepmtSalesLine."Line Type" := TempPrepmtSalesLine."Line Type"::"G/L Account";
        TempPrepmtSalesLine.Level := 1;
        //#5539
        //          TempPrepmtSalesLine."Presentation Code" := lPresMgt.wIncPresentation(lSalesLinePres,1,1);
        //#5539//
        //+ONE+//
        //#7229
        TempPrepmtSalesLine.VALIDATE("VAT Bus. Posting Group", TempSalesLine."VAT Bus. Posting Group");
        TempPrepmtSalesLine.VALIDATE("VAT Prod. Posting Group", TempSalesLine."VAT Prod. Posting Group");
        //#7229//
        //#6621
        TempPrepmtSalesLine.VALIDATE("Job No.", TempSalesLine."Job No.");
        TempPrepmtSalesLine.VALIDATE("Job Task No.", TempSalesLine."Job Task No.");
        //#6621//
    end;

    local procedure TestGenPostingGroups(var SalesLine: Record "Sales Line")
    var
        IsHandled: Boolean;
    begin


        SalesLine.TestField("Gen. Bus. Posting Group");
        SalesLine.TestField("Gen. Prod. Posting Group");
    end;

    PROCEDURE wSetHideValidationDialog(pNewHideValidationDialog: Boolean);
    BEGIN
        //DEVIS
        wHideValidationDialog := pNewHideValidationDialog;
        //DEVIS//
    END;

    PROCEDURE wUpdateTotaling(VAR pRec: Record "Sales Invoice Line"; pAmount: Decimal);
    VAR
        lRec: Record "Sales Invoice Line";
        lok: Boolean;
        lSalesinvLine: Record "Sales Invoice Line";
    BEGIN
        lRec.COPY(pRec);
        IF lSalesinvLine.GET(pRec."Document No.", pRec."Attached to Line No.") THEN
            IF lSalesinvLine."Line Type" = lSalesinvLine."Line Type"::Totaling THEN BEGIN
                lSalesinvLine."Line Amount" += pAmount;
                lSalesinvLine.MODIFY;
                IF (lSalesinvLine."Attached to Line No." <> 0) THEN
                    wUpdateTotaling(lSalesinvLine, lRec."Line Amount");
            END;
        pRec.COPY(lRec);
    END;

    PROCEDURE fInitRenumberLine(VAR pLineNo: Integer; VAR pNoLineLink: Record "Sales Line No. Buffer");
    BEGIN
        //#7319
        pLineNo := 0;
        pNoLineLink.DELETEALL;
        //#7319//
    END;

    PROCEDURE fSetNumberLine(pType: Integer; VAR pInvoiceLine: Record "Sales Invoice Line"; VAR pCrMemoLine: Record "Sales Cr.Memo Line"; pSalesLine: Record "Sales Line"; VAR pLineNo: Integer; VAR pLineNoLink: Record "Sales Line No. Buffer");
    BEGIN
        //#7319
        //Ptype = 0 --> InvoiceLine
        //PType = 1 --> CrMemoLine
        //Affecte un nouveau numero de ligne la ligne facture pour que celle ci respecte l'ordre du document de vente
        // ger‚ par le code presentation
        // Calcul du nouveau numero
        pLineNo += 10000;

        // Ajout de l'association avec la ligne du document de vente
        pLineNoLink.INIT();
        pLineNoLink."Old Line No." := pSalesLine."Line No.";
        pLineNoLink."New Line No." := pLineNo;
        IF (NOT pLineNoLink.INSERT()) THEN;

        IF (pType = 0) THEN BEGIN
            // Affectation du numero de ligne
            pInvoiceLine."Line No." := pLineNo;
            // Maintenant … t'on une ligne attach‚
            IF (pSalesLine."Attached to Line No." <> 0) THEN BEGIN
                // On recherche la ligne attach‚ puis on affecte
                pLineNoLink.RESET;
                pLineNoLink.SETRANGE(pLineNoLink."Old Line No.", pSalesLine."Attached to Line No.");
                IF (NOT pLineNoLink.ISEMPTY) THEN BEGIN
                    pLineNoLink.FINDFIRST;
                    pInvoiceLine."Attached to Line No." := pLineNoLink."New Line No.";
                END;
            END;
        END ELSE BEGIN
            // Affectation du numero de ligne
            pCrMemoLine."Line No." := pLineNo;
            // Maintenant … t'on une ligne attach‚
            IF (pSalesLine."Attached to Line No." <> 0) THEN BEGIN
                // On recherche la ligne attach‚ puis on affecte
                pLineNoLink.RESET;
                pLineNoLink.SETRANGE(pLineNoLink."Old Line No.", pSalesLine."Attached to Line No.");
                IF (NOT pLineNoLink.ISEMPTY) THEN BEGIN
                    pLineNoLink.FINDFIRST;
                    pCrMemoLine."Attached to Line No." := pLineNoLink."New Line No.";
                END;
            END;
        END;
        //#7319//
    END;

    PROCEDURE fTakeOption(pTakeOption: Boolean);
    BEGIN
        //#7892
        gTakeOption := pTakeOption;
    END;




    procedure CalcBIC(Rec: Record 36);
    VAR
        RecLSalesReceivablesSetup: Record 311;
        ReclSalesHeader: Record 36;
        RecLSalesLine: Record 37;
        RecLVendorPostingGroup: Record 92;
        VarILineNo: Integer;
        "RecLG/LAccount": Record 15;
        RecLSalesLine1: Record 37;
        VarDMontantBIC: Decimal;
        RecLRecLSalesLineVat: Record 37;
        VarCAccountBIC: ARRAY[10] OF Code[20];
        VarII: Integer;
        VarIJ: Integer;
        VarBFoundBIC: Boolean;
        VarDialogWindow: Dialog;
        RecLPurchLine2: Record 37;
        VarDMontantFodec1: Decimal;
        RecLDocumentDimension: Record 357;
        RecLTMPDocumentDimension: Record 357;
        RecLInventoryPostingGroup: Record 94;
    begin

        //>>DSFT-TRIUM 01/06/09
        ReclSalesHeader := Rec;
        // Paramétre Taxe Fournisseur
        IF RecLSalesReceivablesSetup.GET THEN;
        IF 1 = 1 THEN BEGIN
            RecLSalesLine.RESET;
            RecLSalesLine.SETRANGE("Document Type", Rec."Document Type");
            RecLSalesLine.SETRANGE("Document No.", Rec."No.");
            RecLSalesLine.SETRANGE("No.", RecLSalesReceivablesSetup."Frais BIC");
            IF RecLSalesLine.FINDFIRST THEN
                REPEAT
                    RecLSalesLine.DELETE;
                UNTIL RecLSalesLine.NEXT = 0;
        END;
        VarDMontantBIC := 0;
        RecLSalesLine.RESET;
        IF 1 = 1 THEN
            WITH ReclSalesHeader DO BEGIN
                RecLSalesLine.RESET;
                RecLSalesLine.SETRANGE("Document Type", "Document Type");
                RecLSalesLine.SETRANGE("Document No.", "No.");
                if ReclSalesHeader."Document Type" = ReclSalesHeader."Document Type"::Invoice then
                    RecLSalesLine.SETFILTER("Qty. to Invoice", '>0');
                RecLSalesLine.SETRANGE("Appliquer BIC", TRUE);
                IF RecLSalesLine.FINDFIRST THEN
                    REPEAT
                        if RecLSalesLine."Document Type" = RecLSalesLine."Document Type"::Quote then
                            VarDMontantBIC += (RecLSalesLine."Amount Including VAT") *
                                                         (RecLSalesReceivablesSetup."Taux BIC" / 100)
                        else
                            VarDMontantBIC += (RecLSalesLine."Amount Including VAT") *
                                 (RecLSalesLine."Qty. to Invoice" / RecLSalesLine.Quantity) * (RecLSalesReceivablesSetup."Taux BIC" / 100)
                    UNTIL RecLSalesLine.NEXT = 0;
                VarDMontantBIC := ROUND(VarDMontantBIC, 1);
                IF VarDMontantBIC <> 0 THEN BEGIN
                    RecLSalesLine1."Document Type" := "Document Type";
                    RecLSalesLine1."Document No." := "No.";
                    RecLSalesLine1."Line No." := RecLSalesLine."Line No." + 50;
                    RecLSalesLine1."Imported Line" := FALSE;
                    //RecLSalesLine1."Structure Line No.":=0;
                    RecLSalesLine1."Sell-to Customer No." := "Sell-to Customer No.";
                    RecLSalesLine1.VALIDATE("Line Type", RecLSalesLine1."Line Type"::Item);
                    RecLSalesLine1.Type := RecLSalesLine1.Type::Item;


                    //  RecLSalesLine1.VALIDATE("Line Type", RecLSalesLine1."Line Type"::"Charge (Item)");
                    // RecLSalesLine1.Type:=RecLSalesLine1.Type::g;
                    RecLSalesLine1.VALIDATE("No.", RecLSalesReceivablesSetup."Frais BIC");
                    RecLSalesLine1."Location Code" := "Location Code";
                    RecLSalesLine1."Shipment Date" := "Shipment Date";
                    //   RecLSalesLine1.Description := 'BIC';
                    RecLSalesLine1.VALIDATE(Quantity, 1);
                    RecLSalesLine1."Allow Invoice Disc." := FALSE;
                    RecLSalesLine1.VALIDATE("Unit Price", VarDMontantBIC);
                    RecLSalesLine1.Amount := VarDMontantBIC;
                    RecLSalesLine1."Amount Including VAT" := VarDMontantBIC;
                    RecLSalesLine1."Outstanding Amount" := VarDMontantBIC;
                    RecLSalesLine1."Bill-to Customer No." := "Bill-to Customer No.";
                    RecLSalesLine1."Outstanding Amount (LCY)" := VarDMontantBIC;
                    RecLSalesLine1.Reserve := Reserve::Never;
                    /*{
                     RecLSalesLine1."VAT Base Amount" := VarDMontantFodec;
                       RecLSalesLine1."VAT Bus. Posting Group" := RecLSalesLine."VAT Bus. Posting Group";
                       RecLSalesLine1."Gen. Bus. Posting Group" := RecLSalesLine."Gen. Bus. Posting Group";
                       RecLSalesLine1."Gen. Prod. Posting Group" := RecLSalesLine."Gen. Prod. Posting Group";
                       RecLSalesLine1.VALIDATE("VAT Prod. Posting Group", RecLSalesLine."VAT Prod. Posting Group");
                    */
                    RecLSalesLine1.INSERT;
                    //     RecLSalesLine1."Type article" := RecLSalesLine1."Type article"::Service;
                    // RecLSalesLine1.Modify();
                END;

            END;
    end;







    /*

        procedure CalcTimbre(Rec: Record "Sales Header")
        VAR
            RecLSalesHeader: Record "Sales Header";
            RecLSalesLine: Record "Sales Line";
            RecLCustomerPostingGroup: Record "Customer Posting Group";
            RecLInventoryPostingGroup: Record "Inventory Posting Group";
            VarBNotExiste: Boolean;
            VarILineNo: Integer;
            RecLSalesLine1: Record "Sales Line";
            //RecLDocumentDimension : Record 357;
            // RecLTMPDocumentDimension : Record 357;
            "RecLG/LEntry": Record "G/L Account";
        begin
            RecLSalesHeader := Rec;
            // Param‚tre Taxe Client
            IF RecLCustomerPostingGroup.GET(RecLSalesHeader."Customer Posting Group") THEN;

            IF Rec."Apply Stamp fiscal" THEN BEGIN
                RecLSalesLine.RESET;
                RecLSalesLine.SETRANGE("Document Type", Rec."Document Type");
                RecLSalesLine.SETRANGE("Document No.", Rec."No.");
                RecLSalesLine.SETRANGE(RecLSalesLine.Type, RecLSalesLine.Type::"G/L Account");
                RecLSalesLine.SETRANGE(RecLSalesLine."No.", RecLCustomerPostingGroup."Stamp Fiscal Law93/53");
                IF RecLSalesLine.FIND('-') THEN BEGIN
                    REPEAT
                    // RecLDocumentDimension.RESET;
                    // RecLDocumentDimension.SETFILTER("Table ID", '37');
                    // RecLDocumentDimension.SETRANGE("Document Type", Rec."Document Type");
                    // RecLDocumentDimension.SETFILTER("Document No.", Rec."No.");
                    // RecLDocumentDimension.SETRANGE("Line No.", RecLSalesLine."Line No.");
                    // RecLDocumentDimension.DELETEALL;
                    // RecLSalesLine.DELETE;
                    UNTIL RecLSalesLine.NEXT = 0;
                END;
                RecLSalesHeader := Rec;
                WITH RecLSalesHeader DO BEGIN

                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE("Document Type", "Document Type");
                    RecLSalesLine.SETRANGE("Document No.", "No.");
                    //* Test si d‚j… existe timbre fiscal
                    VarBNotExiste := FALSE;
                    IF RecLSalesLine.FIND('-') THEN BEGIN
                        REPEAT
                            IF ((RecLSalesLine."Qty. to Invoice" + RecLSalesLine."Quantity Invoiced" -
                              RecLSalesLine."Quantity Shipped" - RecLSalesLine."Qty. to Ship") = 0) OR
                              ((("Document Type" = "Document Type"::"Credit Memo") OR ("Document Type" = "Document Type"::"Return Order"))
                              AND (RecLSalesLine."Qty. to Invoice" > 0)) THEN
                                VarBNotExiste := TRUE;
                        UNTIL RecLSalesLine.NEXT = 0;
                    END;

                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE("Document Type", "Document Type");
                    RecLSalesLine.SETRANGE("Document No.", "No.");


                    IF RecLSalesLine.FIND('-') THEN BEGIN
                        REPEAT
                            IF (((RecLSalesLine.Type = RecLSalesLine.Type::"G/L Account") AND
                             (RecLSalesLine."No." = RecLCustomerPostingGroup."Stamp Fiscal Law93/53") AND
                             (RecLSalesLine."Qty. to Invoice" <> 0))) THEN
                                VarBNotExiste := FALSE;
                        UNTIL RecLSalesLine.NEXT = 0;
                    END;



                    RecLSalesLine.RESET;
                    RecLSalesLine.SETRANGE("Document Type", RecLSalesHeader."Document Type");
                    RecLSalesLine.SETRANGE("Document No.", RecLSalesHeader."No.");
                    IF ("Apply Stamp fiscal" AND RecLSalesLine.FIND('-') AND VarBNotExiste) THEN BEGIN
                        IF RecLSalesLine.FINDLAST THEN
                            //       VarILineNo := RecLSalesLine."Line No." + 50;
                            VarILineNo := 999999;
                        IF 1 = 1 THEN//"Document Type" IN ["Document Type"::Invoice,"Document Type"::Order,"Document Type"::"Credit Memo",
                                     // "Document Type"::"Return Order"] THEN
                        BEGIN
                            RecLSalesLine1."Document Type" := "Document Type";
                            RecLSalesLine1."Document No." := "No.";
                            RecLSalesLine1."Line No." := VarILineNo;
                            RecLSalesLine1."Sell-to Customer No." := "Sell-to Customer No.";
                            RecLSalesLine1.VALIDATE("Line Type", RecLSalesLine1."Line Type"::"G/L Account");
                            RecLSalesLine1."No." := RecLCustomerPostingGroup."Stamp Fiscal Law93/53";
                            // Parametre groupe comptabilisation compte Timbre
                            "RecLG/LEntry".GET(RecLCustomerPostingGroup."Stamp Fiscal Law93/53");
                            RecLSalesLine1."Location Code" := "Location Code";
                            RecLSalesLine1."Shipment Date" := "Shipment Date";
                            RecLSalesLine1.Description := 'Timbre Fiscal Loi 93/53';
                            RecLSalesLine1.VALIDATE(Quantity, 1);
                            RecLSalesLine1."Allow Invoice Disc." := FALSE;
                            RecLSalesLine1.VALIDATE("Unit Price", RecLCustomerPostingGroup."Stamp fiscal Amout");
                            RecLSalesLine1."VAT %" := 0;
                            RecLSalesLine1.Amount := RecLCustomerPostingGroup."Stamp fiscal Amout";
                            RecLSalesLine1."Amount Including VAT" := RecLCustomerPostingGroup."Stamp fiscal Amout";
                            RecLSalesLine1."Outstanding Amount" := RecLCustomerPostingGroup."Stamp fiscal Amout";
                            RecLSalesLine1."Bill-to Customer No." := "Bill-to Customer No.";
                            RecLSalesLine1."Outstanding Amount (LCY)" := RecLCustomerPostingGroup."Stamp fiscal Amout";
                            RecLSalesLine1.Reserve := Reserve::Never;
                            RecLSalesLine1."VAT Base Amount" := RecLCustomerPostingGroup."Stamp fiscal Amout";
                            RecLSalesLine1."VAT Prod. Posting Group" := "RecLG/LEntry"."VAT Prod. Posting Group";
                            RecLSalesLine1."Gen. Prod. Posting Group" := "RecLG/LEntry"."Gen. Prod. Posting Group";
                            RecLSalesLine1."VAT Bus. Posting Group" := "VAT Bus. Posting Group";
                            RecLSalesLine1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                            IF RecLCustomerPostingGroup."Stamp fiscal Amout" <> 0 THEN RecLSalesLine1.INSERT;
                            // RecLDocumentDimension.RESET;
                            // RecLDocumentDimension.SETFILTER("Table ID", '36');
                            // RecLDocumentDimension.SETRANGE("Document Type", "Document Type");
                            // RecLDocumentDimension.SETFILTER("Document No.", "No.");
                            // RecLDocumentDimension.SETRANGE("Line No.", 0);
                            // IF RecLDocumentDimension.FIND('-') THEN
                            //     REPEAT
                            //         RecLTMPDocumentDimension := RecLDocumentDimension;
                            //         RecLTMPDocumentDimension."Table ID" := 37;
                            //         RecLTMPDocumentDimension."Line No." := VarILineNo;
                            //         IF RecLCustomerPostingGroup."Stamp fiscal Amout" <> 0 THEN RecLTMPDocumentDimension.INSERT;
                            //     UNTIL RecLDocumentDimension.NEXT = 0;
                        END;
                    END;
                END;
            END;
        end;


    */



    /* PROCEDURE CalcFodec(Rec: Record "Sales Header");
     VAR
         ReclPurchHeader: Record "Sales Header";
         RecLPurchLine: Record "Sales Line";
         //GL2024    RecLVendorPostingGroup: Record "Vendor Posting Group";
         //GL2024
         RecLVendorPostingGroup: Record "Customer Posting Group";
         //GL2024
         VarILineNo: Integer;
         "RecLG/LAccount": Record "G/L Account";
         RecLPurchLine1: Record "Sales Line";
         VarDMontantFodec: Decimal;
         RecLPurchLineVat: Record "Sales Line";
         VarCAccountFodec: ARRAY[10] OF Code[20];
         VarII: Integer;
         VarIJ: Integer;
         VarBFoundFodec: Boolean;
         VarDialogWindow: Dialog;
         RecLPurchLine2: Record "Sales Line";
         VarDMontantFodec1: Decimal;
         //RecLDocumentDimension : Record 357;
         //RecLTMPDocumentDimension : Record 357;
         RecLInventoryPostingGroup: Record "Inventory Posting Group";
     BEGIN
         //>>DSFT-TRIUM 01/06/09
         ReclPurchHeader := Rec;
         // Param‚tre Taxe Fournisseur
         IF RecLVendorPostingGroup.GET(ReclPurchHeader."Customer Posting Group") THEN;
         //IF ReclPurchHeader."Applies-to Doc. No."='' THEN BEGIN
         //IF RecLVendorPostingGroup."Apply Fodec"  THEN
         // BEGIN
         IF RecLVendorPostingGroup.GET('LOCALSFOD') THEN;
         RecLPurchLine.RESET;
         RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
         RecLPurchLine.SETRANGE("Document No.", Rec."No.");
         RecLPurchLine.SETRANGE(RecLPurchLine.Type, RecLPurchLine.Type::"G/L Account");
         RecLPurchLine.SETRANGE(RecLPurchLine."No.", RecLVendorPostingGroup."Fodec Account");
         IF RecLPurchLine.FINDFIRST THEN
             REPEAT
                 RecLPurchLine.DELETE;
             UNTIL RecLPurchLine.NEXT = 0;
         //END;
         //END;
         RecLPurchLine.RESET;
         IF RecLVendorPostingGroup."Apply Fodec" THEN
             WITH ReclPurchHeader DO BEGIN
                 RecLPurchLine.RESET;
                 RecLPurchLine.SETRANGE("Document Type", "Document Type");
                 RecLPurchLine.SETRANGE("Document No.", "No.");
                 RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');
                 RecLPurchLine.SETRANGE("Apply Fodec", TRUE);
                 IF RecLPurchLine.FINDFIRST THEN
                     REPEAT
                         VarDMontantFodec := 0;
                         IF Ship THEN
                             VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                             (RecLPurchLine."Qty. to Invoice" / RecLPurchLine.Quantity) * (RecLVendorPostingGroup."Fodec %" / 100)
                         ELSE
                             IF RecLPurchLine."Qty. to Invoice" <> 0 THEN BEGIN
                                 IF RecLPurchLine."Qty. to Invoice" > RecLPurchLine."Qty. Shipped Not Invoiced" THEN
                                     VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                                     (RecLPurchLine."Qty. Shipped Not Invoiced" / RecLPurchLine.Quantity)
                                     * (RecLVendorPostingGroup."Fodec %" / 100)
                                 ELSE
                                     VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                                     (RecLPurchLine."Qty. to Invoice" / RecLPurchLine.Quantity) *
                                     (RecLVendorPostingGroup."Fodec %" / 100);
                             END;
                         // END;
                         //insertion des Lignes Fodec
                         VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                         (RecLPurchLine."Qty. to Invoice" / RecLPurchLine.Quantity) * (RecLVendorPostingGroup."Fodec %" / 100);
                         VarDMontantFodec := ROUND(VarDMontantFodec, 0.001);
                         IF VarDMontantFodec <> 0 THEN BEGIN
                             RecLPurchLine1."Document Type" := "Document Type";
                             RecLPurchLine1."Document No." := "No.";
                             RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 50;
                             //New vente
                             RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                             //New vente
                             RecLPurchLine1."Imported Line" := FALSE;
                             //RecLPurchLine1."Structure Line No.":=0;
                             RecLPurchLine1."Sell-to Customer No." := "Sell-to Customer No.";

                             RecLPurchLine1.VALIDATE("Line Type", RecLPurchLine1."Line Type"::"G/L Account");
                             // RecLPurchLine1.Type:=RecLPurchLine1.Type::g;
                             RecLPurchLine1.VALIDATE("No.", RecLVendorPostingGroup."Fodec Account");
                             RecLPurchLine1."Location Code" := "Location Code";
                             RecLPurchLine1."Shipment Date" := "Shipment Date";
                             RecLPurchLine1.Description := 'FODEC';
                             RecLPurchLine1.VALIDATE(Quantity, 1);
                             RecLPurchLine1."Allow Invoice Disc." := FALSE;
                             RecLPurchLine1.VALIDATE("Unit Price", VarDMontantFodec);
                             RecLPurchLine1.Amount := VarDMontantFodec;
                             RecLPurchLine1."Amount Including VAT" := VarDMontantFodec;
                             RecLPurchLine1."Outstanding Amount" := VarDMontantFodec;
                             RecLPurchLine1."Bill-to Customer No." := "Bill-to Customer No.";
                             RecLPurchLine1."Outstanding Amount (LCY)" := VarDMontantFodec;
                             RecLPurchLine1.Reserve := Reserve::Never;
                             RecLPurchLine1."VAT Base Amount" := VarDMontantFodec;
                             RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                             RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                             RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                             RecLPurchLine1.VALIDATE("VAT Prod. Posting Group", RecLPurchLine."VAT Prod. Posting Group");

                             RecLPurchLine1.INSERT;
                         END;
                     UNTIL RecLPurchLine.NEXT = 0;
             END;
     END;



     PROCEDURE MAJLignesBeton(RecSalesHeaderBeton: Record "Sales Header");
     VAR
         RecLCustomer: Record Customer;
         RecSalesLineBeton: Record "Sales Line";
         RecSalesLineBeton1: Record "Sales Line";
         NumLigne: Integer;
         PrixUnitTTC: Decimal;
         RecSalesReceivablesSetupBeton: Record "Sales & Receivables Setup";
         RecItemCharge: Record "Item Charge";
         PrixUnitTransp: Decimal;
         MontantTVATransp: Decimal;
         MontantFournitureTTC: Decimal;
         MontantTVAFourniture: Decimal;
         MontantFournitureFODEC: Decimal;
         MontantUnitaireFodec: Decimal;
         MontantFournitureHT: Decimal;
         RecItemBeton: Record Item;
         "// FODEC": Integer;
         RecCustomerPostingGroup: Record "Customer Posting Group";
     BEGIN
         // Preparation Parametre FODEC
         IF RecItemCharge.GET('P-TR/TRANS') THEN;
         IF RecCustomerPostingGroup.GET(RecSalesHeaderBeton."Customer Posting Group") THEN;
         IF RecLCustomer.GET(RecSalesHeaderBeton."Sell-to Customer No.") THEN;
         IF RecSalesReceivablesSetupBeton.GET THEN;
         PrixUnitTransp := RecSalesReceivablesSetupBeton."Coût Transport BETON HT";
         IF RecSalesHeaderBeton."Forcer % TVA" <> 0 THEN PrixUnitTransp := 20.338;
         IF RecLCustomer."VAT Bus. Posting Group" <> 'SUSPENSION' THEN BEGIN
             IF VATPostingSetup.GET(RecLCustomer."VAT Bus. Posting Group", RecItemCharge."VAT Prod. Posting Group") THEN;
             MontantTVATransp := (PrixUnitTransp * VATPostingSetup."VAT %") / 100;
             IF RecSalesHeaderBeton."Forcer % TVA" <> 0 THEN
                 MontantTVATransp := (PrixUnitTransp * RecSalesHeaderBeton."Forcer % TVA") / 100;
         END;
         MontantTVATransp := ROUND(MontantTVATransp, 0.001);

         //IF RecItemCharge.GET('P-TR/VENTE') THEN;

         RecSalesLineBeton.RESET;
         RecSalesLineBeton.SETRANGE(RecSalesLineBeton."Document Type", RecSalesLineBeton."Document Type"::Invoice);
         RecSalesLineBeton.SETRANGE(RecSalesLineBeton."Document No.", RecSalesHeaderBeton."No.");
         RecSalesLineBeton.SETRANGE(RecSalesLineBeton.Type, RecSalesLineBeton.Type::Item);
         IF RecSalesLineBeton.FINDLAST THEN
             NumLigne := RecSalesLineBeton."Line No.";

         IF RecSalesLineBeton.FINDFIRST THEN
             REPEAT
                 IF RecSalesHeaderBeton."Forcer % TVA" <> 0 THEN
                     RecSalesLineBeton."VAT %" := RecSalesHeaderBeton."Forcer % TVA";
                 PrixUnitTTC := RecSalesLineBeton."Unit Price";
                 IF RecItemBeton.GET(RecSalesLineBeton."No.") THEN;
                 IF RecItemBeton."Calculer Cout Transport" THEN BEGIN
                     MontantFournitureTTC := PrixUnitTTC - PrixUnitTransp - MontantTVATransp;
                 END
                 ELSE BEGIN
                     MontantFournitureTTC := PrixUnitTTC;
                 END;
                 MontantTVAFourniture := MontantFournitureTTC - (MontantFournitureTTC / (100 + RecSalesLineBeton."VAT %")) * 100;
                 // RB SORO 11/08/2015 BETON
                 IF NOT RecCustomerPostingGroup."Apply Fodec" THEN BEGIN
                     MontantTVAFourniture := MontantFournitureTTC - (MontantFournitureTTC / (100 + RecSalesLineBeton."VAT %")) * 100;
                 END;
                 // RB SORO 11/08/2015 BETON
                 MontantTVAFourniture := ROUND(MontantTVAFourniture, 0.001);

                 // 20/08/2015

                 // 20/08/2015

                 MontantFournitureFODEC := MontantFournitureTTC - MontantTVAFourniture;
                 MontantFournitureFODEC := ROUND(MontantFournitureFODEC, 0.001);
                 MontantUnitaireFodec := MontantFournitureFODEC / 101;  // A modifier selon le groupe compta client
                 IF RecCustomerPostingGroup."Apply Fodec" THEN BEGIN
                     MontantFournitureHT := MontantFournitureFODEC - MontantUnitaireFodec;
                 END
                 ELSE BEGIN
                     MontantFournitureHT := MontantFournitureFODEC;
                 END;
                 //RecSalesLineBeton.VALIDATE(RecSalesLineBeton."Unit Price",MontantFournitureHT);
                 //  HS   RecSalesLineBeton.VALIDATE(RecSalesLineBeton."Unit Price", MontantFournitureHT);
                 RecSalesLineBeton.VALIDATE(RecSalesLineBeton."Apply Fodec", TRUE);
                 RecSalesLineBeton.MODIFY;

                 WITH RecSalesHeaderBeton DO BEGIN
                     // Insertion Ligne Transport
                     IF RecItemBeton."Calculer Cout Transport" THEN BEGIN
                         RecSalesLineBeton1."Document Type" := "Document Type";
                         RecSalesLineBeton1."Document No." := "No.";
                         RecSalesLineBeton1."Line No." := RecSalesLineBeton."Line No." + 60;
                         RecSalesLineBeton1."Imported Line" := FALSE;
                         RecSalesLineBeton1."Sell-to Customer No." := "Sell-to Customer No.";
                         RecSalesLineBeton1.VALIDATE("Line Type", RecSalesLineBeton1."Line Type"::"Charge (Item)");
                         RecSalesLineBeton1.VALIDATE("No.", RecItemCharge."No.");
                         RecSalesLineBeton1."Location Code" := "Location Code";
                         RecSalesLineBeton1."Shipment Date" := "Shipment Date";
                         RecSalesLineBeton1.Description := RecItemCharge.Description;
                         RecSalesLineBeton1.VALIDATE(Quantity, RecSalesLineBeton.Quantity);
                         RecSalesLineBeton1."Allow Invoice Disc." := FALSE;
                         RecSalesLineBeton1.VALIDATE("Unit Cost (LCY)", PrixUnitTransp);
                         RecSalesLineBeton1.VALIDATE("Unit Price", PrixUnitTransp);
                         RecSalesLineBeton1.Amount := PrixUnitTransp;
                         RecSalesLineBeton1."Amount Including VAT" := PrixUnitTransp;
                         RecSalesLineBeton1."Outstanding Amount" := PrixUnitTransp + MontantTVATransp;
                         RecSalesLineBeton1."Bill-to Customer No." := "Bill-to Customer No.";
                         RecSalesLineBeton1."Outstanding Amount (LCY)" := PrixUnitTransp + MontantTVATransp;
                         RecSalesLineBeton1.Reserve := Reserve::Never;
                         //RecSalesLineBeton1."VAT Base Amount" := PrixUnitTransp ;
                         // Groupe compta. march‚ TVA ==> A discuter avec M. Hosni
                         RecSalesLineBeton1."VAT Bus. Posting Group" := RecSalesLineBeton."VAT Bus. Posting Group";
                         // Groupe compta. march‚ ==> A discuter avec M. Hosni
                         RecSalesLineBeton1."Gen. Bus. Posting Group" := RecSalesLineBeton."Gen. Bus. Posting Group";
                         RecSalesLineBeton1."Gen. Prod. Posting Group" := RecItemCharge."Gen. Prod. Posting Group";
                         RecSalesLineBeton1.VALIDATE("VAT Prod. Posting Group", RecItemCharge."VAT Prod. Posting Group");
                         IF RecSalesHeaderBeton."Forcer % TVA" <> 0 THEN
                             RecSalesLineBeton1.VALIDATE("VAT %", RecSalesHeaderBeton."Forcer % TVA");

                         RecSalesLineBeton1.INSERT;
                     END;
                     // Insertion Ligne FODEC
                     IF RecCustomerPostingGroup."Apply Fodec" THEN BEGIN
                         RecSalesLineBeton1."Document Type" := "Document Type";
                         RecSalesLineBeton1."Document No." := "No.";
                         RecSalesLineBeton1."Line No." := RecSalesLineBeton."Line No." + 50;
                         RecSalesLineBeton1."Imported Line" := FALSE;
                         RecSalesLineBeton1."Sell-to Customer No." := "Sell-to Customer No.";
                         RecSalesLineBeton1.VALIDATE("Line Type", RecSalesLineBeton1."Line Type"::"G/L Account");
                         RecSalesLineBeton1.VALIDATE("No.", RecCustomerPostingGroup."Fodec Account");
                         RecSalesLineBeton1."Location Code" := "Location Code";
                         RecSalesLineBeton1."Shipment Date" := "Shipment Date";
                         RecSalesLineBeton1.Description := 'FODEC';
                         RecSalesLineBeton1.VALIDATE(Quantity, 1);
                         RecSalesLineBeton1."Allow Invoice Disc." := FALSE;
                         RecSalesLineBeton1.VALIDATE("Unit Cost (LCY)", MontantUnitaireFodec * RecSalesLineBeton.Quantity);
                         RecSalesLineBeton1.VALIDATE("Unit Price", MontantUnitaireFodec * RecSalesLineBeton.Quantity);
                         RecSalesLineBeton1."Bill-to Customer No." := "Bill-to Customer No.";
                         RecSalesLineBeton1."Outstanding Amount (LCY)" := MontantUnitaireFodec;
                         RecSalesLineBeton1.Reserve := Reserve::Never;
                         RecSalesLineBeton1."VAT Base Amount" := MontantUnitaireFodec;
                         RecSalesLineBeton1."VAT Bus. Posting Group" := RecSalesLineBeton."VAT Bus. Posting Group";
                         RecSalesLineBeton1."Gen. Bus. Posting Group" := RecSalesLineBeton."Gen. Bus. Posting Group";
                         RecSalesLineBeton1."Gen. Prod. Posting Group" := RecSalesLineBeton."Gen. Prod. Posting Group";
                         RecSalesLineBeton1.VALIDATE("VAT Prod. Posting Group", RecSalesLineBeton."VAT Prod. Posting Group");

                         RecSalesLineBeton1.INSERT;
                     END;
                 END;

             UNTIL RecSalesLineBeton.NEXT = 0;
     END;

     PROCEDURE UpdateLivraisonRapportChantier(ParaNumEntete: Code[20]; ParaNumLigne: Integer; ParaQuantitéAvoir: Decimal);
     VAR
         LSalesLine: Record "Sales Line";
         LShipmentLine: Record "Sales Shipment Line";
         ProductionCompletionEntry: Record "Production Completion Entry";
         LTaux: Decimal;
         EntryNo: Integer;
         DocumentLivNo: Code[20];
         LigneDocumentLivNo: Integer;
         DateComptabilisation: Date;
     BEGIN
         IF LShipmentLine.GET(ParaNumEntete, ParaNumLigne) THEN BEGIN
             LShipmentLine.Quantity := ParaQuantitéAvoir;
             LShipmentLine."Qty. Shipped Not Invoiced" := LShipmentLine."Qty. Shipped Not Invoiced" + ParaQuantitéAvoir;
             LShipmentLine.Montant := LShipmentLine."Unit Price" * ParaQuantitéAvoir;
             LShipmentLine.MODIFY;
             IF LSalesLine.GET(LSalesLine."Document Type"::Order, LShipmentLine."Order No.", LShipmentLine."Order Line No.") THEN BEGIN
                 ProductionCompletionEntry.SETRANGE("Order No.", LSalesLine."Document No.");
                 ProductionCompletionEntry.SETRANGE("Order Line No.", LSalesLine."Line No.");
                 IF ProductionCompletionEntry.FINDLAST THEN BEGIN
                     EntryNo := ProductionCompletionEntry."Entry No.";
                     DocumentLivNo := ProductionCompletionEntry."Document No.";
                     LigneDocumentLivNo := ProductionCompletionEntry."Line No.";
                     DateComptabilisation := ProductionCompletionEntry."Posting Date";
                 END;
                 CLEAR(ProductionCompletionEntry);
                 ProductionCompletionEntry.SETRANGE("Order No.", LSalesLine."Document No.");
                 ProductionCompletionEntry.SETRANGE("Order Line No.", LSalesLine."Line No.");
                 ProductionCompletionEntry.DELETEALL;

                 LSalesLine."Quantity Shipped" := LSalesLine."Quantity Shipped" + ParaQuantitéAvoir;
                 LSalesLine."Outstanding Quantity" := LSalesLine.Quantity - LSalesLine."Quantity Shipped";
                 LSalesLine."Outstanding Qty. (Base)" := LSalesLine.Quantity - LSalesLine."Quantity Shipped";
                 LSalesLine."Shipped Not Invoiced" := LSalesLine."Quantity Shipped" * LSalesLine."Unit Price";
                 LSalesLine."Qty. to Invoice" := LSalesLine."Quantity Shipped";
                 LSalesLine."Qty. Shipped Not Invoiced" := LSalesLine."Quantity Shipped";
                 LSalesLine."Shipped Not Invoiced (LCY)" := LSalesLine."Shipped Not Invoiced";
                 LSalesLine."Qty. to Invoice (Base)" := LSalesLine."Quantity Shipped";
                 LSalesLine."Qty. Shipped (Base)" := LSalesLine."Quantity Shipped";
                 LSalesLine."Qty. Shipped Not Invd. (Base)" := LSalesLine."Quantity Shipped";

                 // Ecriture Avancement Prod
                 CLEAR(ProductionCompletionEntry);
                 ProductionCompletionEntry."Entry No." := EntryNo;
                 ProductionCompletionEntry."Job No." := LSalesLine."Job No.";
                 ProductionCompletionEntry."Previous Completion %" := 0;
                 ProductionCompletionEntry."New Completion %" := (LSalesLine."Quantity Shipped" / LSalesLine.Quantity) * 100;
                 ProductionCompletionEntry."Completion Difference (%)" := ProductionCompletionEntry."New Completion %";
                 ProductionCompletionEntry."Document No." := DocumentLivNo;
                 ProductionCompletionEntry."Line No." := LigneDocumentLivNo;
                 ProductionCompletionEntry."Order No." := LSalesLine."Document No.";
                 ProductionCompletionEntry."Order Line No." := LSalesLine."Line No.";
                 ProductionCompletionEntry."Posting Date" := DateComptabilisation;
                 ProductionCompletionEntry."Previous Quantity" := 0;
                 ProductionCompletionEntry."New Quantity" := LSalesLine."Quantity Shipped";
                 ProductionCompletionEntry."Quantity Difference" := LSalesLine."Quantity Shipped";
                 ProductionCompletionEntry.INSERT;
                 // Ecriture Avancement Prod

                 LSalesLine.MODIFY;
             END;

         END;
     END;

     PROCEDURE CalcTransport(Rec: Record "Sales Header");
     VAR
         ReclPurchHeader: Record "Sales Header";
         RecLPurchLine: Record "Sales Line";
         RecLVendorPostingGroup: Record "Vendor Posting Group";
         VarILineNo: Integer;
         "RecLG/LAccount": Record "G/L Account";
         RecLPurchLine1: Record "Sales Line";
         VarDMontantFodec: Decimal;
         RecLPurchLineVat: Record "Sales Line";
         VarCAccountFodec: ARRAY[10] OF Code[20];
         VarII: Integer;
         VarIJ: Integer;
         VarBFoundFodec: Boolean;
         VarDialogWindow: Dialog;
         RecLPurchLine2: Record "Sales Line";
         VarDMontantFodec1: Decimal;
         //RecLDocumentDimension : Record 357;
         //RecLTMPDocumentDimension : Record 357;
         RecLInventoryPostingGroup: Record "Inventory Posting Group";
         QteTransport: Decimal;
         QtePompage: Decimal;
     BEGIN

         ReclPurchHeader := Rec;

         RecLPurchLine.RESET;
         RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
         RecLPurchLine.SETRANGE("Document No.", Rec."No.");
         RecLPurchLine.SETRANGE(RecLPurchLine."No.", 'P-TR/TRANS');
         IF RecLPurchLine.FINDFIRST THEN
             REPEAT
                 RecLPurchLine.DELETE;
             UNTIL RecLPurchLine.NEXT = 0;


         RecLPurchLine.RESET;
         RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
         RecLPurchLine.SETRANGE("Document No.", Rec."No.");
         RecLPurchLine.SETRANGE(RecLPurchLine."No.", 'P-TR/POMPAGE');
         IF RecLPurchLine.FINDFIRST THEN
             REPEAT
                 RecLPurchLine.DELETE;
             UNTIL RecLPurchLine.NEXT = 0;

         //END;
         //END;
         //RecLPurchLine.RESET;
         //IF RecLVendorPostingGroup."Apply Fodec"  THEN
         WITH ReclPurchHeader DO BEGIN
             RecLPurchLine.RESET;
             RecLPurchLine.SETRANGE("Document Type", "Document Type");
             RecLPurchLine.SETRANGE("Document No.", "No.");
             RecLPurchLine.SETRANGE(RecLPurchLine.Type, RecLPurchLine.Type::Item);
             RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');

             IF RecLPurchLine.FINDFIRST THEN
                 REPEAT
                     QteTransport += RecLPurchLine.Quantity;

                 UNTIL RecLPurchLine.NEXT = 0;

             RecLPurchLine.RESET;
             RecLPurchLine.SETRANGE("Document Type", "Document Type");
             RecLPurchLine.SETRANGE("Document No.", "No.");
             RecLPurchLine.SETRANGE(RecLPurchLine.Type, RecLPurchLine.Type::Item);
             RecLPurchLine.SETFILTER(RecLPurchLine.Description, '*POMPE* & <>*NON POMPE*');
             //RecLPurchLine.SETFILTER(RecLPurchLine."No.",'%*1*','BET-01-02-0008');
             RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');

             IF RecLPurchLine.FINDFIRST THEN
                 REPEAT
                     QtePompage += RecLPurchLine.Quantity;

                 UNTIL RecLPurchLine.NEXT = 0;

             IF QteTransport > 0 THEN BEGIN
                 RecLPurchLine1."Document Type" := "Document Type";
                 RecLPurchLine1."Document No." := "No.";
                 RecLPurchLine1."Line No." := 999998;
                 RecLPurchLine1."Imported Line" := FALSE;
                 RecLPurchLine1."Sell-to Customer No." := "Sell-to Customer No.";
                 //GL2024  RecLPurchLine1.VALIDATE("Line Type", RecLPurchLine1."Line Type"::"Charge (Item)");
                 //GL2024
                 RecLPurchLine1.VALIDATE("Line Type", RecLPurchLine1."Line Type"::Item);
                 RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                 //GL2024
                 RecLPurchLine1.VALIDATE("No.", 'P-TR/TRANS');
                 RecLPurchLine1.Description := 'TRANSPORT';
                 RecLPurchLine1."Location Code" := "Location Code";
                 RecLPurchLine1."Shipment Date" := "Shipment Date";
                 RecLPurchLine1.VALIDATE(Quantity, QteTransport);
                 RecLPurchLine1."Outstanding Amount" := VarDMontantFodec;
                 RecLPurchLine1."Bill-to Customer No." := "Bill-to Customer No.";
                 RecLPurchLine1.INSERT;
             END;

             IF QtePompage > 0 THEN BEGIN
                 RecLPurchLine2."Document Type" := "Document Type";
                 RecLPurchLine2."Document No." := "No.";
                 RecLPurchLine2."Line No." := 999997;
                 RecLPurchLine2."Imported Line" := FALSE;
                 RecLPurchLine2."Sell-to Customer No." := "Sell-to Customer No.";
                 //GL2024      RecLPurchLine2.VALIDATE("Line Type", RecLPurchLine1."Line Type"::"Charge (Item)");
                 //GL2024
                 RecLPurchLine2.VALIDATE("Line Type", RecLPurchLine1."Line Type"::Item);
                 RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                 //GL2024
                 RecLPurchLine2.VALIDATE("No.", 'P-TR/POMPAGE');
                 RecLPurchLine2."Location Code" := "Location Code";
                 RecLPurchLine2."Shipment Date" := "Shipment Date";
                 RecLPurchLine2.VALIDATE(Quantity, QtePompage);
                 RecLPurchLine2."Outstanding Amount" := VarDMontantFodec;
                 RecLPurchLine2."Bill-to Customer No." := "Bill-to Customer No.";
                 RecLPurchLine2.INSERT;
             END;
         END;
     END;*/
}