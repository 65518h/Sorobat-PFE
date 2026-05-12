codeunit 50049 CopyDocumentMgtEvent
{
    trigger OnRun()
    begin

    end;



    var
        myInt: Integer;
        wPrevSalesLines: Record "Sales Line";
        TDiff: Label 'The original document has got %1 %2 and the current document %3, %4 will not be recalculed.';
        Text032: Label 'You have selected to create quantity based on the original Quantity and this has';
        ErrorCompletion: Label 'You can''t copy a completion.';
        Text026: Label 'created some lines that will cause a reapplication when you post the return order.';
        wSaleslineTmp: Record "Sales Line" TEMPORARY;
        Text027: Label 'This in turn might change the cost of existing entries.';
        wPresentationMng: Codeunit "Presentation Management";
        Text028: Label 'To cancel this effect you can delete the lines and use the function again.';
        wStructureMgt: Codeunit "Structure Management";
        wProgressDlg: Codeunit "Progress Dialog2";
        HideDialog: Boolean;
        wDocOcc: Integer;
        RecalculateLines: Boolean;
        wDocVersion: Integer;
        ErrorStructure: Label 'You must "Recalculate Line" if your %1 has strucutre.';
        TextOuv: Label 'The structure detail is not copied.';
        wEcart: Integer;
        wNoStruct: Integer;
        wCancelCompletion: Boolean;
        wFirst: Boolean;
        wOkMessage: Boolean;
        tTitreProgress: Label 'Copy %1 No. %2 ...\';
        tTypeProgress: Label 'Update                 #1##############\';
        tCalcProgress: Label 'Work in progress...    @2@@@@@@@@@@@@@@\';
        wMaxProgress: Integer;
        wProgress: Dialog;
        wOKBillOfQty: Boolean;
        tPresentation: Label 'Presentation Code';
        tOption: Label 'Some option line exists in origine document';
        wCopyDocFurther: Codeunit "Copy Document Further";
        wToJobCostAssgntTmp: Record "Job Cost Assignment" TEMPORARY;
        wFromSalesHeaderArchive: Record "Sales Header Archive";
        wFromSalesLineArchive: Record "Sales Line Archive";
        TempSalesLine: Record "Sales Line";
        gAttachedIsText: Boolean;
        gPrevLevPresentation: Text[30];
        FromPurchHeaderArchive: Record "Purchase Header Archive";
        FromPurchLineArchive: Record "Purchase Line Archive";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnGetSalesDocumentTypeCaseElse', '', true, true)]
    local procedure OnGetSalesDocumentTypeCaseElse(FromDocType: Enum "Sales Document Type From"; var ToDocType: Enum "Sales Document Type")
    var
        SalesHeader: Record "Sales Header";
    begin
        //+ABO+
        IF FromDocType = FromDocType::Subscription THEN
            ToDocType := SalesHeader."Document Type"::Subscription;
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeInitAndCheckSalesDocuments', '', true, true)]
    local procedure OnBeforeInitAndCheckSalesDocuments(FromDocType: enum "Sales Document Type From"; FromDocNo: Code[20];
                                                                        FromDocOccurrenceNo: Integer;
                                                                        FromDocVersionNo: Integer; var FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; MoveNegLines: boolean; IncludeHeader: Boolean; RecalculateLines: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        FromSalesLine: Record "Sales Line";
    begin
        // //DEVIS
        // FromSalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code");
        // wDocOcc := wFromDocNoOccurrence;
        // wDocVersion := wFromVersionNo;
        // //DEVIS//

        // //GROUPER
        // wSaleslineTmp.DELETEALL;
        // //DEGROUPER//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnInitAndCheckSalesDocumentsOnBeforeCheckCreditLimit', '', true, true)]
    local procedure OnInitAndCheckSalesDocumentsOnBeforeCheckCreditLimit(var FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    begin
        //#7813
        //#7645
        fTestBOQExist(FromSalesHeader);
        //#7645//
        //#7813//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCheckCopyFromSalesHeaderAvailOnAfterSetFilters', '', true, true)]
    local procedure OnCheckCopyFromSalesHeaderAvailOnAfterSetFilters(var FromSalesLine: Record "Sales Line"; FromSalesHeader: Record "Sales Header"; ToSalesHeader: Record "Sales Header")
    begin
        //OUVRAGE
        FromSalesLine.SETRANGE("Structure Line No.", 0);
        //OUVRAGE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCheckFromSalesHeader', '', true, true)]
    local procedure OnBeforeCheckFromSalesHeader(SalesHeaderFrom: Record "Sales Header"; SalesHeaderTo: Record "Sales Header"; var IsHandled: Boolean)
    var
        lFromJobCostAssgnt: Record "Job Cost Assignment";
        lFromJobCostAssgntArch: Record "Job Cost Assignment Archive";
    begin
        // SalesHeaderFrom.TestField("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
        //SalesHeaderFrom.TestField("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
        SalesHeaderFrom.TestField("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
        SalesHeaderFrom.TestField("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
        SalesHeaderFrom.TestField("Currency Code", SalesHeaderTo."Currency Code");
        SalesHeaderFrom.TestField("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
        //DEVIS
        SalesHeaderTo.TESTFIELD("VAT Bus. Posting Group", SalesHeaderFrom."VAT Bus. Posting Group");
        IF SalesHeaderTo."Customer Price Group" <> SalesHeaderFrom."Customer Price Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Posting Group"), SalesHeaderFrom."Customer Price Group",
            SalesHeaderTo."Customer Price Group", SalesHeaderTo.FIELDCAPTION("Customer Posting Group"));
        IF SalesHeaderTo."Customer Disc. Group" <> SalesHeaderFrom."Customer Disc. Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"), SalesHeaderFrom."Customer Disc. Group",
            SalesHeaderTo."Customer Disc. Group", SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"));
        IF SalesHeaderTo."Responsibility Center" <> SalesHeaderFrom."Responsibility Center" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Responsibility Center"), SalesHeaderFrom."Responsibility Center",
            SalesHeaderTo."Responsibility Center", SalesHeaderTo.FIELDCAPTION("Responsibility Center"));
        //DEVIS//

        //FRAIS
        lFromJobCostAssgnt.SETRANGE("Document Type", SalesHeaderFrom."Document Type");
        lFromJobCostAssgnt.SETRANGE("Document No.", SalesHeaderFrom."No.");
        lFromJobCostAssgnt.SETRANGE(Assigned, TRUE);
        IF NOT lFromJobCostAssgnt.ISEMPTY THEN
            IF lFromJobCostAssgnt.FIND('-') THEN
                REPEAT
                    wToJobCostAssgntTmp := lFromJobCostAssgnt;
                    wToJobCostAssgntTmp."Document Type" := SalesHeaderTo."Document Type";
                    wToJobCostAssgntTmp."Document No." := SalesHeaderTo."No.";
                    wToJobCostAssgntTmp.INSERT;
                UNTIL lFromJobCostAssgnt.NEXT = 0;
        //FRAIS//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCheckFromSalesInvHeader', '', true, true)]
    local procedure OnBeforeCheckFromSalesInvHeader(SalesInvoiceHeaderFrom: Record "Sales Invoice Header"; SalesHeaderTo: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //SalesInvoiceHeaderFrom.TestField("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
        // SalesInvoiceHeaderFrom.TestField("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
        SalesInvoiceHeaderFrom.TestField("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
        SalesInvoiceHeaderFrom.TestField("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
        SalesInvoiceHeaderFrom.TestField("Currency Code", SalesHeaderTo."Currency Code");
        SalesInvoiceHeaderFrom.TestField("Prices Including VAT", SalesHeaderTo."Prices Including VAT");

        //DEVIS
        SalesHeaderTo.TESTFIELD("VAT Bus. Posting Group", SalesInvoiceHeaderFrom."VAT Bus. Posting Group");
        IF SalesHeaderTo."Customer Price Group" <> SalesInvoiceHeaderFrom."Customer Price Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Posting Group"), SalesInvoiceHeaderFrom."Customer Price Group",
            SalesHeaderTo."Customer Price Group", SalesHeaderTo.FIELDCAPTION("Customer Posting Group"));
        IF SalesHeaderTo."Customer Disc. Group" <> SalesInvoiceHeaderFrom."Customer Disc. Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"), SalesInvoiceHeaderFrom."Customer Disc. Group",
            SalesHeaderTo."Customer Disc. Group", SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"));
        IF SalesHeaderTo."Responsibility Center" <> SalesInvoiceHeaderFrom."Responsibility Center" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Responsibility Center"), SalesInvoiceHeaderFrom."Responsibility Center",
            SalesHeaderTo."Responsibility Center", SalesHeaderTo.FIELDCAPTION("Responsibility Center"));
        //DEVIS//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCheckFromSalesCrMemoHeader', '', true, true)]
    local procedure OnAfterCheckFromSalesCrMemoHeader(SalesCrMemoHeaderFrom: Record "Sales Cr.Memo Header"; SalesHeaderTo: Record "Sales Header")
    var
        lFromJobCostAssgntArch: Record "Job Cost Assignment Archive";
    begin
        //SalesCrMemoHeaderFrom.TestField("Sell-to Customer No.", SalesHeaderTo."Sell-to Customer No.");
        //SalesCrMemoHeaderFrom.TestField("Bill-to Customer No.", SalesHeaderTo."Bill-to Customer No.");
        SalesCrMemoHeaderFrom.TestField("Customer Posting Group", SalesHeaderTo."Customer Posting Group");
        SalesCrMemoHeaderFrom.TestField("Gen. Bus. Posting Group", SalesHeaderTo."Gen. Bus. Posting Group");
        SalesCrMemoHeaderFrom.TestField("Currency Code", SalesHeaderTo."Currency Code");
        SalesCrMemoHeaderFrom.TestField("Prices Including VAT", SalesHeaderTo."Prices Including VAT");
        //DEVIS
        SalesHeaderTo.TESTFIELD("VAT Bus. Posting Group", SalesCrMemoHeaderFrom."VAT Bus. Posting Group");
        IF SalesHeaderTo."Customer Price Group" <> SalesCrMemoHeaderFrom."Customer Price Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Posting Group"), SalesCrMemoHeaderFrom."Customer Price Group",
            SalesHeaderTo."Customer Price Group", SalesHeaderTo.FIELDCAPTION("Customer Posting Group"));
        IF SalesHeaderTo."Customer Disc. Group" <> SalesCrMemoHeaderFrom."Customer Disc. Group" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"), SalesCrMemoHeaderFrom."Customer Disc. Group",
            SalesHeaderTo."Customer Disc. Group", SalesHeaderTo.FIELDCAPTION("Customer Disc. Group"));
        IF SalesHeaderTo."Responsibility Center" <> SalesCrMemoHeaderFrom."Responsibility Center" THEN
            MESSAGE(TDiff, SalesHeaderTo.FIELDCAPTION("Responsibility Center"), SalesCrMemoHeaderFrom."Responsibility Center",
            SalesHeaderTo."Responsibility Center", SalesHeaderTo.FIELDCAPTION("Responsibility Center"));
        //DEVIS//
    end;

    local procedure InitShipmentDateInLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        if SalesHeader."Shipment Date" <> 0D then
            SalesLine."Shipment Date" := SalesHeader."Shipment Date"
        else
            SalesLine."Shipment Date" := WorkDate();

    end;

    local procedure SetShipmentDateInLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin

        if SalesLine."Shipment Date" = 0D then begin
            InitShipmentDateInLine(SalesHeader, SalesLine);
            SalesLine.Validate("Shipment Date");
        end;
    end;

    local procedure CheckItemAvailability(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line")
    var
        IsHandled: Boolean;
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin

        if IsHandled then
            exit;



        ToSalesLine."Document Type" := ToSalesHeader."Document Type";
        ToSalesLine."Document No." := ToSalesHeader."No.";
        ToSalesLine.Type := ToSalesLine.Type::Item;
        ToSalesLine."Purchase Order No." := '';
        ToSalesLine."Purch. Order Line No." := 0;
        ToSalesLine."Drop Shipment" :=
          not RecalculateLines and ToSalesLine."Drop Shipment" and
          (ToSalesHeader."Document Type" = ToSalesHeader."Document Type"::Order);

        SetShipmentDateInLine(ToSalesHeader, ToSalesLine);

        IsHandled := false;

        if not IsHandled then
            if ItemCheckAvail.SalesLineCheck(ToSalesLine) then
                ItemCheckAvail.RaiseUpdateInterruptedError();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterInitAndCheckSalesDocuments', '', true, true)]
    local procedure OnAfterInitAndCheckSalesDocuments(FromDocType: Option; FromDocNo: Code[20]; FromDocOccurrenceNo: Integer; FromDocVersionNo: Integer; var FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesShipmentHeader: Record "Sales Shipment Header"; var FromSalesInvoiceHeader: Record "Sales Invoice Header"; var FromReturnReceiptHeader: Record "Return Receipt Header"; var FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var FromSalesHeaderArchive: Record "Sales Header Archive"; IncludeHeader: Boolean; RecalculateLines: Boolean)
    var
        FromDocType2: Enum "Sales Document Type From";
        lFromJobCostAssgntArch: Record "Job Cost Assignment Archive";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        Text001: Label '%1 %2 cannot be copied onto itself.';
    begin
        FromDocType2 := FromDocType;
        //DEVIS
        if FromDocType2 = FromDocType2::"Arch. Quote" THEN
            //   SalesDocType::"Quote Archive":
            BEGIN

            wFromSalesHeaderArchive.GET(wFromSalesHeaderArchive."Document Type"::Quote, FromDocNo, FromDocOccurrenceNo, FromDocVersionNo);
            IF (wFromSalesHeaderArchive."Document Type" = FromSalesHeader."Document Type") AND
               (wFromSalesHeaderArchive."No." = FromSalesHeader."No.")
            THEN
                ERROR(
                  Text001,
                  FromSalesHeader."Document Type", FromSalesHeader."No.");

            //              SalesDocType := SalesDocType::"Quote Archive";

            IF FromSalesHeader."Document Type" <= FromSalesHeader."Document Type"::Invoice THEN BEGIN
                wFromSalesHeaderArchive.CALCFIELDS("Amount Including VAT");
                FromSalesHeader."Amount Including VAT" := wFromSalesHeaderArchive."Amount Including VAT";
                CustCheckCreditLimit.SalesHeaderCheck(ToSalesHeader);
            END;
            wFromSalesLineArchive.SETRANGE("Structure Line No.", 0);
            IF FromSalesHeader."Document Type" IN [FromSalesHeader."Document Type"::Order, FromSalesHeader."Document Type"::Invoice] THEN BEGIN
                wFromSalesLineArchive.SETRANGE("Document Type", wFromSalesHeaderArchive."Document Type");
                wFromSalesLineArchive.SETRANGE("Document No.", wFromSalesHeaderArchive."No.");
                wFromSalesLineArchive.SETRANGE("Doc. No. Occurrence", wFromSalesHeaderArchive."Doc. No. Occurrence");
                wFromSalesLineArchive.SETRANGE("Version No.", wFromSalesHeaderArchive."Version No.");
                wFromSalesLineArchive.SETRANGE(Type, wFromSalesLineArchive.Type::Item);
                wFromSalesLineArchive.SETFILTER("No.", '<>%1', '');
                IF wFromSalesLineArchive.FIND('-') THEN
                    REPEAT
                        IF wFromSalesLineArchive.Quantity > 0 THEN BEGIN
                            ToSalesLine."No." := wFromSalesLineArchive."No.";
                            ToSalesLine."Variant Code" := wFromSalesLineArchive."Variant Code";
                            ToSalesLine."Location Code" := wFromSalesLineArchive."Location Code";
                            ToSalesLine."Bin Code" := wFromSalesLineArchive."Bin Code";
                            ToSalesLine."Unit of Measure Code" := wFromSalesLineArchive."Unit of Measure Code";
                            ToSalesLine."Qty. per Unit of Measure" := wFromSalesLineArchive."Qty. per Unit of Measure";
                            ToSalesLine."Outstanding Quantity" := wFromSalesLineArchive.Quantity;
                            CheckItemAvailability(ToSalesHeader, ToSalesLine);
                        END;
                    UNTIL wFromSalesLineArchive.NEXT = 0;
            END;
            IF NOT IncludeHeader AND NOT RecalculateLines THEN BEGIN
                //DEVIS          wFromSalesHeaderArchive.TESTFIELD("Sell-to Customer No.",ToSalesHeader."Sell-to Customer No.");
                //DEVIS          wFromSalesHeaderArchive.TESTFIELD("Bill-to Customer No.",ToSalesHeader."Bill-to Customer No.");
                ToSalesHeader.TESTFIELD("Customer Posting Group", wFromSalesHeaderArchive."Customer Posting Group");
                ToSalesHeader.TESTFIELD("Gen. Bus. Posting Group", wFromSalesHeaderArchive."Gen. Bus. Posting Group");
                ToSalesHeader.TESTFIELD("Currency Code", wFromSalesHeaderArchive."Currency Code");
                //DEVIS
                ToSalesHeader.TESTFIELD("VAT Bus. Posting Group", wFromSalesHeaderArchive."VAT Bus. Posting Group");
                IF ToSalesHeader."Responsibility Center" <> wFromSalesHeaderArchive."Responsibility Center" THEN
                    MESSAGE(TDiff, ToSalesHeader.FIELDCAPTION("Responsibility Center"), wFromSalesHeaderArchive."Responsibility Center",
                    ToSalesHeader."Responsibility Center", ToSalesHeader.FIELDCAPTION("Responsibility Center"));
                //DEVIS//
            END;
            //FRAIS
            lFromJobCostAssgntArch.SETRANGE("Document Type", wFromSalesHeaderArchive."Document Type");
            lFromJobCostAssgntArch.SETRANGE("Document No.", wFromSalesHeaderArchive."No.");
            lFromJobCostAssgntArch.SETRANGE("Doc. No. Occurrence", wFromSalesHeaderArchive."Doc. No. Occurrence");
            lFromJobCostAssgntArch.SETRANGE("Version No.", wFromSalesHeaderArchive."Version No.");
            lFromJobCostAssgntArch.SETRANGE(Assigned, TRUE);
            IF NOT lFromJobCostAssgntArch.ISEMPTY THEN
                IF lFromJobCostAssgntArch.FIND('-') THEN
                    REPEAT
                        wToJobCostAssgntTmp.TRANSFERFIELDS(lFromJobCostAssgntArch);
                        wToJobCostAssgntTmp."Document Type" := ToSalesHeader."Document Type";
                        wToJobCostAssgntTmp."Document No." := ToSalesHeader."No.";
                        wToJobCostAssgntTmp.INSERT;
                    UNTIL lFromJobCostAssgntArch.NEXT = 0;
            //FRAIS//
        END;
        //DEVIS//


        IF IncludeHeader THEN
            wCopyDocFurther.wCopySalesCommentLine(ToSalesHeader, FromDocType, FromDocNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesHeaderDone', '', true, true)]
    local procedure OnBeforeCopySalesHeaderDone(var ToSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header"; FromDocType: Enum "Sales Document Type From"; OldSalesHeader: Record "Sales Header";
                                                                                                                                                  FromSalesShipmentHeader: Record "Sales Shipment Header";
                                                                                                                                                  FromSalesInvoiceHeader: Record "Sales Invoice Header";
                                                                                                                                                  FromReturnReceiptHeader: Record "Return Receipt Header";
                                                                                                                                                  FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                                                                                                                                                  FromSalesHeaderArchive: Record "Sales Header Archive")
    begin
        // //DEVIS
        // IF ToSalesHeader."Order Type" <> ToSalesHeader."Order Type"::"Supply Order" THEN BEGIN
        //     ToSalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code");
        //     ToSalesLine.SETRANGE("Structure Line No.", 0);
        //     ToSalesLine.SETFILTER("Line Type", '<>%1', ToSalesLine."Line Type"::Other);
        //     IF ToSalesLine.FINDLAST THEN;
        // END;
        // wPrevSalesLines := ToSalesLine;
        // wFirst := TRUE;
        // wEcart := 0;
        // ToSalesLine.SETRANGE("Structure Line No.");
        // ToSalesLine.SETRANGE("Line Type");
        // ToSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        // //DEVIS//

        // //****************
        // //  Copy entˆte
        // //****************
        // //PROGRESS
        // //3728
        // //  lOpenProgressBar(FromDocType,FromDocNo,wFromDocNoOccurrence,wFromVersionNo);
        // lOpenProgressBar(FromSalesHeader."Document Type", FromDocNo, wFromDocNoOccurrence, wFromVersionNo);
        // //3728//
        // //PROGRESS//

        // //COMMIT-LINE
        // IF NOT lRoolBackLog.CopyIntegrityVerify(ToSalesHeader) THEN
        //     NextLineNo := ToSalesLine.wGetLastCurrNo(ToSalesHeader."Document Type", ToSalesHeader."No.", 0);
        // //COMMIT-LINE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesHeaderDone', '', true, true)]
    local procedure OnAfterCopySalesHeaderDone(var ToSalesHeader: Record "Sales Header"; OldSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header"; FromSalesShipmentHeader: Record "Sales Shipment Header"; FromSalesInvoiceHeader: Record "Sales Invoice Header"; FromReturnReceiptHeader: Record "Return Receipt Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; FromSalesHeaderArchive: Record "Sales Header Archive"; FromDocType: Enum "Sales Document Type From")
    var
        CudCopyDoc: Codeunit "Copy Document Mgt.";
        lBoqMgt: Codeunit "BOQ Management";
    begin
        CASE FromDocType of
            "Sales Document Type From"::Quote,
             "Sales Document Type From"::"Blanket Order",
             "Sales Document Type From"::Order,
             "Sales Document Type From"::Invoice,
             "Sales Document Type From"::"Return Order",
             "Sales Document Type From"::"Credit Memo":
                begin
                    //#5813--------------
                    ToSalesHeader."Order Type" := OldSalesHeader."Order Type";
                    //#5813--------------//
                    //DEVIS
                    ToSalesHeader.Status := ToSalesHeader.Status::Open;
                    //DEVIS//

                    //PREPAYMENT //#5597
                    ToSalesHeader."No. Prepayment Invoiced" := 0;
                    ToSalesHeader."No. Prepayment Request Printed" := 0;
                    ToSalesHeader."Prepayment No." := '';
                    ToSalesHeader."Last Prepayment No." := '';
                    ToSalesHeader."Prepmt. Cr. Memo No." := '';
                    ToSalesHeader."Last Prepmt. Cr. Memo No." := '';
                    //#6976
                    ToSalesHeader."On Hold" := '';
                    //#6976//

                    //DEVIS
                    wCopyDocFurther.wCopyContributorToHeader(ToSalesHeader, FromSalesHeader);
                    wCopyDocFurther.wCopyDescriptionToHeader(ToSalesHeader, FromSalesHeader);
                    //DEVIS//
                    //#6115
                    //#7202
                    //          wCopyDocFurther.wCopyBillOfQtyToHeader(ToSalesHeader,FromSalesHeader,TRUE);
                    wCopyDocFurther.wCopyBillOfQtyToHeader(ToSalesHeader, FromSalesHeader, TRUE, lBoqMgt, wOKBillOfQty);
                    //#7202//
                    //#6115//
                    //PROJET_FACT
                    wCopyDocFurther.wCopySheldulerToHeader(ToSalesHeader, FromSalesHeader);
                    //PROJET_FACT//
                end;
            "Sales Document Type From"::"Posted Shipment":
                //#6976
                ToSalesHeader."On Hold" := '';
            //#6976//
            "Sales Document Type From"::"Posted Invoice":
                //#6976
                ToSalesHeader."On Hold" := '';
            //#6976//
            "Sales Document Type From"::"Posted Return Receipt":
                //#6976
                ToSalesHeader."On Hold" := '';
            //#6976//
            "Sales Document Type From"::"Posted Credit Memo":
                //#6976
                ToSalesHeader."On Hold" := '';
            //#6976//
            "Sales Document Type From"::"Arch. Quote":
                begin
                    ToSalesHeader."Posting Date" := WORKDATE;






                    ToSalesHeader.Status := ToSalesHeader.Status::Open;
                    //DEVIS//
                    //#6976
                    ToSalesHeader."On Hold" := '';
                    //#6976//

                    //wCopyDocFurther.wCopyDocDimArchToHeader(ToSalesHeader, wFromSalesHeaderArchive);
                    wCopyDocFurther.wCopyContributorArchToHeader(ToSalesHeader, wFromSalesHeaderArchive);
                    wCopyDocFurther.wCopyDescriptionArchToHeader(ToSalesHeader, wFromSalesHeaderArchive);

                    //#7202

                    wCopyDocFurther.wCopyBillOfQtyArchToHeader(ToSalesHeader, wFromSalesHeaderArchive, TRUE, lBoqMgt, wOKBillOfQty);
                    //#7202//

                    //PROJET_FACT
                    wCopyDocFurther.wCopySheldulerArchToHeader(ToSalesHeader, wFromSalesHeaderArchive);
                    //PROJET_FACT//
                end;
        END;

        //PREPAYMENT// //#5597//
        //+ABO+
        IF FromDocType = FromDocType::Subscription THEN BEGIN
            CopySalesHeaderFromSalesHeaderArchive(FromSalesHeaderArchive, ToSalesHeader, OldSalesHeader);
        END;
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopyFieldsFromOldSalesHeader', '', true, true)]
    local procedure OnBeforeCopyFieldsFromOldSalesHeader(var ToSalesHeader: Record "Sales Header"; var OldSalesHeader: Record "Sales Header")
    begin
        //+REF+OPPORT
        ToSalesHeader."Close Opportunity Code" := '';
        //+REF+OPPORT//
        //USER
        ToSalesHeader."User ID" := USERID;
        ToSalesHeader."Doc. Creation Date" := WORKDATE;
        //USER//
        //+REF+FIN_CREDIT
        ToSalesHeader."Financial Document" := FALSE;
        //+REF+FIN_CREDIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeModifySalesHeader', '', true, true)]
    local procedure OnBeforeModifySalesHeader(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; RecalculateLines: Boolean; FromSalesHeader: Record "Sales Header"; FromSalesInvoiceHeader: Record "Sales Invoice Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; OldSalesHeader: Record "Sales Header")
    begin
        //DEVIS
        //#6367
        ToSalesHeader."Posting Description" := ToSalesHeader.wShowPostingDescription(ToSalesHeader.wPostingDescription);
        //#6367//
        //DEVIS//
        //ACOMPTE
        CLEAR(ToSalesHeader."Part Payment");
        //ACOMPTE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocWithHeader', '', true, true)]
    local procedure OnCopySalesDocWithHeader(FromDocType: Option; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header"; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; var FromSalesHeader: Record "Sales Header")
    var
        CudCopyDoc: Codeunit "Copy Document Mgt.";
        SalesDoc: Enum "Sales Document Type From";
    //lSingleInstance: Codeunit "Import SingleInstance";
    begin
        SalesDoc := FromDocType;
        //OVERHEAD
        IF NOT RecalculateLines THEN BEGIN
            CASE SalesDoc OF
                SalesDoc::"Arch. Quote":
                    IF wFromSalesHeaderArchive.GET(wFromSalesHeaderArchive."Document Type"::Quote,
                          FromDocNo, FromDocOccurenceNo, FromDocVersionNo) THEN
                        wCopyDocFurther.wCopyOverheadArchToHeader(ToSalesHeader, wFromSalesHeaderArchive);
                ELSE
                    wCopyDocFurther.wCopyOverheadToHeader(ToSalesHeader, FromSalesHeader);
            END;
        END;
        //OVERHEAD//
        wOkMessage := FALSE;
        //SINGLE
        ToSalesHeader.MODIFY;
        //DYS codeunit  "Import SingleInstance" manquant

        // lSingleInstance.wSetSalesHeader(ToSalesHeader);
        //SINGLE//


        //****************
        // D‚but copy ligne
        //****************
        //#7202
        //wOKBillOfQty := FALSE;
        //#7202//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnBeforeUpdateSalesInvoiceDiscountValue', '', true, true)]
    local procedure OnCopySalesDocOnBeforeUpdateSalesInvoiceDiscountValue(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20]; FromDocOccurrenceNo: Integer; FromDocVersionNo: Integer; RecalculateLines: Boolean)
    var
        FromSalHdr: Record "Sales Header";
    begin
        IF FromSalHdr.get(ToSalesHeader."Document Type", FromDocNo) THEN;

        // case FromDocType of
        //     "Sales Document Type From"::Subscription:
        //         CopySalesDocSalesLine(FromSalHdr, ToSalesHeader, LinesNotCopied, NextLineNo);
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocSalesLineOnAfterSetFilters', '', true, true)]
    local procedure OnCopySalesDocSalesLineOnAfterSetFilters(FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var ToSalesHeader: Record "Sales Header"; var RecalculateLines: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocSalesLineOnAfterCalcShouldRunIteration', '', true, true)]
    local procedure OnCopySalesDocSalesLineOnAfterCalcShouldRunIteration(FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; FromSalesLine: Record "Sales Line"; var ShouldRunIteration: Boolean)
    begin
        //     //PROGRESS
        //     i += 1;
        //     lUpdateProgressBar(SalesDocType, i);
        //     //PROGRESS//

        //     //#7666
        //     gAttachedIsText := FALSE;
        //     IF (FromSalesLine.Type = FromSalesLine.Type::" ") AND
        //         (FromSalesLine."No." = '') AND
        //         (FromSalesLine.Quantity = 0) AND
        //         (FromSalesLine."Attached to Line No." <> 0) AND
        //         (gPrevLevPresentation = FORMAT(FromSalesLine.Level) + FORMAT(FromSalesLine."Presentation Code"))
        //       THEN
        //         IF lIsStructureParent(FromSalesLine, lStructureNo) THEN BEGIN
        //             IF lIsExtText(lStructureNo, FromSalesLine) THEN
        //                 gAttachedIsText := TRUE
        //         END
        //         ELSE
        //             gAttachedIsText := TRUE;
        //     //#7666//

        //     //DEVIS
        //     wCopyDocFurther.wDeleteDescriptionFromLine(DATABASE::"Sales Line", ToSalesHeader."Document Type",
        //                                                ToSalesHeader."No.", FromSalesLine."Line No.");
        //     //DEVIS//
        //     //FRAIS
        //     wCopyDocFurther.wDeleteJobCostFromLine(ToSalesHeader."Document Type", ToSalesHeader."No.", FromSalesLine."Line No.");
        //     //FRAIS//
        //     //#7202
        //     IF CopySalesLine(ToSalesHeader, ToSalesLine, FromSalesHeader, FromSalesLine, NextLineNo, LinesNotCopied,
        //                      FALSE, FromDocType, lBoqMgt)
        //   //#7202//

        //#7666
        gPrevLevPresentation := FORMAT(FromSalesLine.Level) + FORMAT(FromSalesLine."Presentation Code");
        //#7666//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnAfterCopySalesDocLines', '', true, true)]
    local procedure OnCopySalesDocOnAfterCopySalesDocLines(FromDocType: Option; FromDocNo: Code[20]; FromDocOccurrenceNo: Integer; FromDocVersionNo: Integer; FromSalesHeader: Record "Sales Header"; IncludeHeader: Boolean; var ToSalesHeader: Record "Sales Header"; var HideDialog: Boolean)
    var
        lSalesLineTmp: Record "Sales Line" temporary;
    begin
        // //FRAIS
        // //#4797
        // IF NOT RecalculateLines THEN BEGIN
        //     //#4797//
        //     wCopyDocFurther.wInsertJobCostAssignment(wToJobCostAssgntTmp);
        //     //FRAIS//

        //     //GROUPER
        //     IF NOT wSaleslineTmp.ISEMPTY THEN BEGIN
        //         wSaleslineTmp.FIND('-');
        //         lSalesLineTmp.DELETEALL;
        //         REPEAT
        //             lSalesLineTmp := wSaleslineTmp;
        //             lSalesLineTmp.INSERT;
        //         UNTIL wSaleslineTmp.NEXT = 0;
        //         wSaleslineTmp.FIND('-');
        //         REPEAT
        //             lSalesLineTmp.SETRANGE("Special Order Purch. Line No.", wSaleslineTmp."Cross-Ref. Line No.");
        //             IF lSalesLineTmp.FIND('-') THEN BEGIN
        //                 ToSalesLine.GET(wSaleslineTmp."Document Type", wSaleslineTmp."Document No.", wSaleslineTmp."Line No.");
        //                 ToSalesLine.VALIDATE("Cross-Ref. Line No.", lSalesLineTmp."Line No.");
        //                 ToSalesLine.MODIFY;
        //             END;
        //         UNTIL wSaleslineTmp.NEXT = 0;
        //     END;
        //     //GROUPER//

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeUpdatePurchInvoiceDiscountValue', '', true, true)]
    local procedure OnCopyPurchDocOnBeforeUpdatePurchInvoiceDiscountValue(var ToPurchaseHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]; FromDocOccurrenceNo: Integer; FromDocVersionNo: Integer; RecalculateLines: Boolean; FromPurchHeader: Record "Purchase Header"; LinesNotCopied: Integer; NextLineNo: Integer; MissingExCostRevLink: Boolean)
    begin
        //     //#7859
        //   //#8301
        //      IF  (FromDocType=10) or 
        //   //#8301//
        //       (FromDocType=11) THEN
        //         BEGIN
        //   //#8301
        //   //        FromPurchHeaderArchive.GET(FromPurchHeaderArchive."Document Type"::Order,FromDocNo,pFromDocNoOccurrence,pFromVersionNo););
        //           IF FromDocType = 10 THEN
        //             FromPurchHeaderArchive.GET(FromPurchHeaderArchive."Document Type"::Order,FromDocNo,pFromDocNoOccurrence,pFromVersionNo)
        //           ELSE
        //             FromPurchHeaderArchive.GET(FromPurchHeaderArchive."Document Type"::Quote,FromDocNo,pFromDocNoOccurrence,pFromVersionNo);
        //   //#8301//
        //           IF NOT IncludeHeader AND NOT RecalculateLines THEN BEGIN
        //             FromPurchHeaderArchive.TESTFIELD("Buy-from Vendor No.","Buy-from Vendor No.");
        //             FromPurchHeaderArchive.TESTFIELD("Pay-to Vendor No.","Pay-to Vendor No.");
        //             FromPurchHeaderArchive.TESTFIELD("Vendor Posting Group","Vendor Posting Group");
        //             FromPurchHeaderArchive.TESTFIELD("Gen. Bus. Posting Group","Gen. Bus. Posting Group");
        //             FromPurchHeaderArchive.TESTFIELD("Currency Code","Currency Code");
        //           END;
        //         END;
        //   //#7859//
        //#7859

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnAfterCopyPurchDocLines', '', true, true)]
    local procedure OnCopyPurchDocOnAfterCopyPurchDocLines(FromDocType: Option; FromDocNo: Code[20]; FromPurchaseHeader: Record "Purchase Header"; IncludeHeader: Boolean; var ToPurchHeader: Record "Purchase Header"; MoveNegLines: Boolean)
    begin
        //     //#8301
        //       IF  (FromDocType=10) or 
        //   //#8301//
        //       (FromDocType=11) THEN
        //         BEGIN
        //           FromPurchaseHeader.TRANSFERFIELDS(FromPurchHeaderArchive);
        //           FromPurchLineArchive.RESET;
        //           FromPurchLineArchive.SETRANGE("Document Type",FromPurchHeaderArchive."Document Type");
        //           FromPurchLineArchive.SETRANGE("Document No.",FromPurchHeaderArchive."No.");
        //           FromPurchLineArchive.SETRANGE("Doc. No. Occurrence",FromPurchHeaderArchive."Doc. No. Occurrence");
        //           FromPurchLineArchive.SETRANGE("Version No.",FromPurchHeaderArchive."Version No.");
        //           IF MoveNegLines THEN
        //             FromPurchLineArchive.SETFILTER(Quantity,'<=0');
        //           IF FromPurchLineArchive.FIND('-') THEN
        //             REPEAT
        //               FromPurchLine.TRANSFERFIELDS(FromPurchLineArchive);
        //               IF CopyPurchLine(
        //                 ToPurchHeader,ToPurchLine,FromPurchHeader,FromPurchLine,
        //                 NextLineNo,LinesNotCopied,FALSE) THEN BEGIN
        //                 CopyFromPurchDocDimToLine(ToPurchLine,FromPurchLine);
        //                 IF FromPurchLine.Type = FromPurchLine.Type::"Charge (Item)" THEN
        //                   CopyFromPurchDocAssgntToLine(ToPurchLine,FromPurchLine,ItemChargeAssgntNextLineNo);
        //               END;
        //             UNTIL FromPurchLineArchive.NEXT = 0;
        //         END;
        //   //#7859//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeShowSalesDoc', '', true, true)]
    local procedure OnBeforeShowSalesDoc(var ToSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        case ToSalesHeader."Document Type" of
            ToSalesHeader."Document Type"::Order:
                PAGE.Run(PAGE::"Sales Order", ToSalesHeader);
            ToSalesHeader."Document Type"::Invoice:
                PAGE.Run(PAGE::"Sales Invoice", ToSalesHeader);
            ToSalesHeader."Document Type"::"Return Order":
                PAGE.Run(PAGE::"Sales Return Order", ToSalesHeader);
            ToSalesHeader."Document Type"::"Credit Memo":
                PAGE.Run(PAGE::"Sales Credit Memo", ToSalesHeader);
        //+ABO+
        /*   //GL2024 NAVIBAT    ToSalesHeader."Document Type"::Subscription:
            PAGE.RUN(PAGE::"Sales Contract", ToSalesHeader);*/
        //+ABO+//
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterTransfldsFromSalesToPurchLine', '', true, true)]
    local procedure OnAfterTransfldsFromSalesToPurchLine(var FromSalesLine: Record "Sales Line"; var ToPurchaseLine: Record "Purchase Line")
    begin
        //ACHATS
        ToPurchaseLine.Description := FromSalesLine.Description;
        ToPurchaseLine."Description 2" := FromSalesLine."Description 2";
        //ACHATS//
        //NAVIONE
        ToPurchaseLine."dysJob No." := FromSalesLine."Job No.";
        //#4905
        ToPurchaseLine."Job Task No." := FromSalesLine."Job Task No.";
        //#4905//
        //NAVIONE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesLine', '', true, true)]
    local procedure OnBeforeCopySalesLine(var ToSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header"; FromSalesLine: Record "Sales Line"; RecalculateAmount: Boolean; var CopyThisLine: Boolean; MoveNegLines: Boolean; var Result: Boolean; var IsHandled: Boolean; DocLineNo: Integer)
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
    begin
        IF (FromSalesLine."Line Type" = FromSalesLine."Line Type"::Other) AND (FromSalesLine."Quote No." = '')
         AND (FromSalesLine."Prepayment Line") THEN
            Result := FALSE;
        //#7154//
        //OUVRAGE
        IF (FromSalesLine."Line Type" = FromSalesLine."Line Type"::" ") AND (FromSalesLine.Type <> FromSalesLine.Type::" ") THEN
            CASE FromSalesLine.Type OF
                FromSalesLine.Type::Item:
                    FromSalesLine."Line Type" := FromSalesLine."Line Type"::Item;
                FromSalesLine.Type::"G/L Account":
                    FromSalesLine."Line Type" := FromSalesLine."Line Type"::"G/L Account";
                FromSalesLine.Type::Resource:
                    FromSalesLine."Line Type" := FromSalesLine."Line Type"::Person;
                ELSE
                    ;
            END;
        IF FromSalesLine.Level = 0 THEN BEGIN
            FromSalesLine.Level := 1;
            FromSalesLine."Presentation Code" := '  1';
        END;
        //OUVRAGE//
        //OVERHEAD
        IF ToSalesHeader."No." <> '' THEN BEGIN
            lSalesOverhead.SETRANGE("Document Type", ToSalesHeader."Document Type");
            lSalesOverhead.SETRANGE("Document No.", ToSalesHeader."No.");
            IF lSalesOverhead.ISEMPTY THEN BEGIN
                //DYS ToSalesHeader."Sell-to Customer Template Code" supprimer
                //IF (ToSalesHeader."Sell-to Customer No." <> '') OR (ToSalesHeader."Sell-to Customer Template Code" <> '') THEN
                IF (ToSalesHeader."Sell-to Customer No." <> '') OR (ToSalesHeader."Sell-to Customer Templ. Code" <> '') THEN
                    CODEUNIT.RUN(CODEUNIT::"Overhead Calculation", ToSalesHeader);
            END;
        END;
        //OVERHEAD//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyFieldsFromOldPurchHeaderProcedure', '', true, true)]
    local procedure OnAfterCopyFieldsFromOldPurchHeaderProcedure(var PurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header")
    begin
        //#7373
        PurchaseHeader."Vendor Invoice No." := '';
        //#7373//
    end;

    //GL2024 Erreur avoir ligne [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocLineOnAfterCalcCopyThisLine', '', true, true)]
    // local procedure OnCopySalesDocLineOnAfterCalcCopyThisLine(var ToSalesHeader: Record "Sales Header"; var FromSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; RoundingLineInserted: Boolean; var CopyThisLine: Boolean; RecalculateLines: Boolean)
    // begin
    //     //OUVRAGE
    //     //IF (ToSalesHeader."Language Code" <> FromSalesHeader."Language Code") AND
    //     IF ((ToSalesHeader."Language Code" <> FromSalesHeader."Language Code") OR
    //        RecalculateLines) AND
    //        //#6102
    //        //   (FromSalesLine."Line Type" = FromSalesLine."Line Type"::" ") AND
    //        ((ToSalesLine."Line Type" = ToSalesLine."Line Type"::" ") AND (ToSalesLine."No." = ''))
    //        //#6102//
    //        AND
    //        //OUVRAGE//
    //        //#7666
    //        (NOT gAttachedIsText) and
    //        ToSalesLine.IsExtendedText() or
    //        ToSalesLine."Prepayment Line" or RoundingLineInserted THEN
    //         CopyThisLine := true
    //     else
    //         CopyThisLine := false;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocLineOnBeforeInitToSalesLine', '', true, true)]
    local procedure OnCopySalesDocLineOnBeforeInitToSalesLine(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line"; var ShouldInitToSalesLine: Boolean)
    begin
        //STOCK
        //IF RecalculateLines AND NOT FromSalesLine."System-Created Entry" THEN
        IF RecalculateLines AND NOT FromSalesLine."System-Created Entry" AND
        (FromSalesLine."Item Type" <> FromSalesLine."Item Type"::Generic) THEN
            ShouldInitToSalesLine := true
        else
            ShouldInitToSalesLine := false;
        //STOCK//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesLineOnAfterTransferFieldsToSalesLine', '', true, true)]
    local procedure OnCopySalesLineOnAfterTransferFieldsToSalesLine(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line")
    var
        lStructNo: Integer;
        lInsertLineOK: Boolean;
    begin
        IF FromSalesLine."Structure Line No." <> 0 THEN
            lStructNo := ToSalesLine."Structure Line No.";
        //OUVRAGE//
        //OUVRAGE
        IF FromSalesLine."Structure Line No." <> 0 THEN
            ToSalesLine."Structure Line No." := lStructNo;

        //GROUPER
        IF ToSalesLine."Cross-Ref. Line No." <> 0 THEN BEGIN
            wSaleslineTmp := ToSalesLine;
            wSaleslineTmp."Special Order Purch. Line No." := FromSalesLine."Line No.";
            wSaleslineTmp.INSERT;
            ToSalesLine."Cross-Ref. Line No." := 0;
        END;
        //GROUPER//

        IF wCancelCompletion THEN BEGIN
            ToSalesLine."Job No." := FromSalesLine."Job No.";
            //#4905
            ToSalesLine."Job Task No." := FromSalesLine."Job Task No.";
            //#4905//
            //??  ToSalesLine."Invoice No." := FromSalesLine."Invoice No.";
            //??  ToSalesLine."Invoice Line No." := FromSalesLine."Invoice Line No.";
            ToSalesLine."Gen. Prod. Posting Group" := FromSalesLine."Gen. Prod. Posting Group";
            ToSalesLine."VAT Prod. Posting Group" := FromSalesLine."VAT Prod. Posting Group";
            ToSalesLine."VAT Bus. Posting Group" := FromSalesLine."VAT Bus. Posting Group";
            ToSalesLine."Gen. Bus. Posting Group" := FromSalesLine."Gen. Bus. Posting Group";
            ToSalesLine."Shortcut Dimension 1 Code" := FromSalesLine."Shortcut Dimension 1 Code";
            ToSalesLine."Shortcut Dimension 2 Code" := FromSalesLine."Shortcut Dimension 2 Code";
        END;
        //PROJET_FACT//
        //DEVIS
        ToSalesLine."Line Type" := FromSalesLine."Line Type";
        ToSalesLine.Level := FromSalesLine.Level;
        //DEVIS//

        //OUVRAGE
        IF RecalculateLines AND
           (FromSalesLine."Line Type" = FromSalesLine."Line Type"::Structure)
        THEN BEGIN
            //#4744  IF ToSalesLine.INSERT THEN;
            ToSalesLine.INSERT;
            lInsertLineOK := TRUE;
            //#4744//
            //#7317
            // CASE pFromDocType OF
            //     pFromDocType::Quote .. pFromDocType::"Credit Memo":
            //         wCopyDocFurther.wCopyBillOfQtyToLine(ToSalesHeader, ToSalesLine, FromSalesHeader,
            //                                              FromSalesLine, wOKBillOfQty, pBoqMgt);
            //     pFromDocType::"Quote Archive":
            //         wCopyDocFurther.wCopyBillOfQtyArchToLine(ToSalesHeader, ToSalesLine, wFromSalesHeaderArchive,
            //                                                  wFromSalesLineArchive, TRUE, pBoqMgt);
            // END;
            //#7317//

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocLineOnBeforeValidateLineDiscountPct', '', true, true)]
    local procedure OnCopySalesDocLineOnBeforeValidateLineDiscountPct(var ToSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin

        IF (ToSalesLine."Line Type" = ToSalesLine."Line Type"::" ") AND
           (ToSalesLine.Type <> ToSalesLine.Type::" ")
        THEN
            CASE ToSalesLine.Type OF
                ToSalesLine.Type::"G/L Account":
                    ToSalesLine."Line Type" := ToSalesLine."Line Type"::"G/L Account";
                ToSalesLine.Type::Item:
                    ToSalesLine."Line Type" := ToSalesLine."Line Type"::Item;
                ToSalesLine.Type::Resource:
                    ToSalesLine."Line Type" := ToSalesLine."Line Type"::Person;
            END;

        IF ToSalesLine.Level = 0 THEN
            ToSalesLine.Level := 1;
        ToSalesLine."Structure Line No." := 0;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocLineOnBeforeCheckLocationOnWMS', '', true, true)]
    local procedure OnCopySalesDocLineOnBeforeCheckLocationOnWMS(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line"; var IsHandled: Boolean; IncludeHeader: Boolean; RecalculateLines: Boolean)
    begin
        //OUVRAGE
        IF FromSalesLine."Imported Line" THEN BEGIN
            ToSalesLine.Description := FromSalesLine.Description;
            ToSalesLine."Description 2" := FromSalesLine."Description 2";
        END;
        // IF ToSalesLine."Line Type" = ToSalesLine."Line Type"::Structure THEN BEGIN
        //     ToSalesLine.MODIFY;
        //     //#7202
        //     IF (RecalculateLines) THEN BEGIN
        //         //#7317
        //         CASE pFromDocType OF
        //             pFromDocType::Quote .. pFromDocType::"Credit Memo":
        //                 wCopyDocFurther.wCopyBillOfQtyToLine(ToSalesHeader, ToSalesLine, FromSalesHeader,
        //                                                      FromSalesLine, FALSE, pBoqMgt);
        //             pFromDocType::"Quote Archive":
        //                 wCopyDocFurther.wCopyBillOfQtyArchToLine(ToSalesHeader, ToSalesLine, wFromSalesHeaderArchive,
        //                                                          wFromSalesLineArchive, FALSE, pBoqMgt);
        //         END;
        //         //#7317//
        //     END;
        //     //#7202//
        //     wStructureMgt.fSetBoqManagement(pBoqMgt);
        //     wStructureMgt.ExplodeStructure(ToSalesLine);
        //     lNextLineNo := ToSalesLine.wGetLastCurrNo(ToSalesLine."Document Type", ToSalesLine."Document No.", 0);
        // END;
        // //OUVRAGE//
        // //#7537
        // CLEAR(lPriceCalcMgt);
        // lPriceCalcMgt.FindSalesLineLineDisc(ToSalesHeader, ToSalesLine);
        // lPriceCalcMgt.FindSalesLinePrice(ToSalesHeader, ToSalesLine, ToSalesLine.FIELDNO(Quantity));

        // //#7537//

        //DEVIS
        //ToSalesLine.Status := FromSalesLine.Status;
        IF (FromSalesLine.Type = FromSalesLine.Type::" ") AND (FromSalesLine."No." <> '') THEN
            ToSalesLine.VALIDATE("No.", FromSalesLine."No.");
        //FRAIS
        ToSalesLine."Assignment Basis" := FromSalesLine."Assignment Basis";
        ToSalesLine."Assignment Method" := FromSalesLine."Assignment Method";
        //FRAIS//
        //   IF pFromDocType < SalesDocType::"Posted Shipment" THEN BEGIN
        //     ToSalesLine."Fixed Price" := FALSE;
        //     ToSalesLine.VALIDATE(Quantity);
        //   END ELSE
        //     IF (FromSalesLine."Fixed Price" = TRUE) AND
        //        (FromSalesLine.Type <> FromSalesLine.Type::" ")
        //     THEN BEGIN
        //       ToSalesLine."Fixed Price" := TRUE;
        //       ToSalesLine.VALIDATE("Unit Price",FromSalesLine."Unit Price");
        //       ToSalesLine.VALIDATE("Unit Cost (LCY)",FromSalesLine."Unit Cost (LCY)");
        //     END ELSE
        //       ToSalesLine.VALIDATE(Quantity);
        // END ELSE BEGIN
        //   IF (FromSalesLine."No." <> '') AND
        //      (FromSalesLine."Line Type" = FromSalesLine."Line Type"::Totaling)
        //   THEN
        //     ToSalesLine.VALIDATE("No.",FromSalesLine."No.")
        //   ELSE
        //     ToSalesLine."No." := FromSalesLine."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocLineOnAfterAssignCopiedFromPostedDoc', '', true, true)]
    local procedure OnCopySalesDocLineOnAfterAssignCopiedFromPostedDoc(var ToSalesLine: Record "Sales Line"; ToSalesHeader: Record "Sales Header")
    begin
        //DEVIS
        ToSalesLine."Sell-to Customer No." := ToSalesHeader."Sell-to Customer No.";
        ToSalesLine."Bill-to Customer No." := ToSalesHeader."Bill-to Customer No.";
        ToSalesLine."Order Type" := ToSalesHeader."Order Type";
        ToSalesLine."Currency Code" := ToSalesHeader."Currency Code";
        //#4905
        //ToSalesLine."Job No." := ToSalesHeader."Job No.";
        //#8540

        //#8540//
        ToSalesLine.VALIDATE("Job No.", ToSalesHeader."Job No.");
        //#4905//
        ToSalesLine."Location Code" := ToSalesHeader."Location Code";
        ToSalesLine."Customer Price Group" := ToSalesHeader."Customer Price Group";
        ToSalesLine."Customer Disc. Group" := ToSalesHeader."Customer Disc. Group";
        ToSalesLine."Allow Line Disc." := ToSalesHeader."Allow Line Disc.";
        ToSalesLine."Transaction Type" := ToSalesHeader."Transaction Type";
        ToSalesLine."Transport Method" := ToSalesHeader."Transport Method";
        ToSalesLine."Gen. Bus. Posting Group" := ToSalesHeader."Gen. Bus. Posting Group";
        ToSalesLine."VAT Bus. Posting Group" := ToSalesHeader."VAT Bus. Posting Group";
        ToSalesLine."Exit Point" := ToSalesHeader."Exit Point";
        ToSalesLine.Area := ToSalesHeader.Area;
        ToSalesLine."Transaction Specification" := ToSalesHeader."Transaction Specification";
        ToSalesLine."Tax Area Code" := ToSalesHeader."Tax Area Code";
        ToSalesLine."Tax Liable" := ToSalesHeader."Tax Liable";
        ToSalesLine."Responsibility Center" := ToSalesHeader."Responsibility Center";
        ToSalesLine."Shipping Agent Code" := ToSalesHeader."Shipping Agent Code";
        ToSalesLine."Shipping Agent Service Code" := ToSalesHeader."Shipping Agent Service Code";
        ToSalesLine."Outbound Whse. Handling Time" := ToSalesHeader."Outbound Whse. Handling Time";
        ToSalesLine."Shipping Time" := ToSalesHeader."Shipping Time";
        ToSalesLine."Promised Delivery Date" := ToSalesHeader."Promised Delivery Date";
        ToSalesLine."Requested Delivery Date" := ToSalesHeader."Requested Delivery Date";
        ToSalesLine."Shortcut Dimension 1 Code" := ToSalesHeader."Shortcut Dimension 1 Code";
        ToSalesLine."Shortcut Dimension 2 Code" := ToSalesHeader."Shortcut Dimension 2 Code";
        /*
        //#4449
        //ToSalesLine."Main Order No." := ToSalesHeader."Rider to Order No.";
        IF ToSalesHeader."Rider to Order No." <> '' THEN
          ToSalesLine."Main Order No." := ToSalesHeader."Rider to Order No."
        ELSE
          ToSalesLine."Main Order No." := ToSalesHeader."No.";
        //#4449//
        */
        ToSalesLine."Imported Line" := FALSE;
        ToSalesLine."Completely Shipped" := FALSE;
        //PROJET_FACT
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterInitSalesLineFields', '', true, true)]
    local procedure OnAfterInitSalesLineFields(var SalesLine: Record "Sales Line")
    begin
        //+ABO+
        SalesLine."Subscription Posting Date" := 0D;
        //+ABO+//
        //DEVIS
        IF SalesLine."Document Type" <> SalesLine."Document Type"::Quote THEN
            SalesLine."Fixed Price" := TRUE;
        //DEVIS//
        //#5784
        IF SalesLine."Total Cost (LCY)" = 0 THEN
            SalesLine.VALIDATE("Unit Cost (LCY)");
        //#5784//
        //#5442
        IF SalesLine."Qty. per Unit of Measure" = 0 THEN
            SalesLine."Qty. per Unit of Measure" := 1;
        //#5442//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocPurchLineOnAfterCopyPurchLine', '', true, true)]
    local procedure OnCopyPurchDocPurchLineOnAfterCopyPurchLine(ToPurchHeader: Record "Purchase Header"; var ToPurchLine: Record "Purchase Line"; FromPurchHeader: Record "Purchase Header"; var FromPurchLine: Record "Purchase Line"; IncludeHeader: Boolean; RecalculateLines: Boolean);
    begin
        //ACHATS
        ToPurchLine."Pay-to Vendor No." := FromPurchHeader."Pay-to Vendor No.";
        ToPurchLine."Buy-from Vendor No." := FromPurchHeader."Buy-from Vendor No.";
        //ACHATS//
        //#4765
        ToPurchLine."Completely Received" := FALSE;
        //#4765//

        //PURCHASE
        //#7492
        IF (FromPurchLine.Type = FromPurchLine.Type::" ") AND (FromPurchLine."No." = '') THEN
            ToPurchLine."dysJob No." := ''
        ELSE
            //#7492//
            //#8540
            IF ToPurchHeader."Job No." = '' THEN BEGIN
                ToPurchLine."dysJob No." := FromPurchLine."dysJob No.";
                ToPurchLine."Job Task No." := FromPurchLine."Job Task No.";
            END ELSE
                //#8540//
                ToPurchLine."dysJob No." := ToPurchHeader."Job No.";
        //PURCHASE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesInvLinesToBuffer', '', true, true)]
    local procedure OnBeforeCopySalesInvLinesToBuffer(var FromSalesLine: Record "Sales Line"; var FromSalesInvLine: Record "Sales Invoice Line"; var ToSalesHeader: Record "Sales Header")
    begin
        //#7171
        FromSalesLine."Fixed Price" := TRUE;
        //#7171//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeInsertOldSalesDocNoLine', '', true, true)]
    local procedure OnBeforeInsertOldSalesDocNoLine(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; OldDocType: Option; OldDocNo: Code[20]; var IsHandled: Boolean)
    begin
        //#4836
        IF wCancelCompletion THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchInvLinesToDocOnAfterCalcShouldInsertOldPurchDocNoLine', '', true, true)]
    local procedure OnCopyPurchInvLinesToDocOnAfterCalcShouldInsertOldPurchDocNoLine(var ToPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header"; FromPurchaseHeader: Record "Purchase Header"; var NextLineNo: Integer; var OldInvDocNo: Code[20]; var OldRcptDocNo: Code[20]; var ShouldInsertOldPurchDocNoLine: Boolean)
    begin
        //#7450
        //      IF "Receipt No." <> OldInvDocNo THEN BEGIN
        IF ShouldInsertOldPurchDocNoLine THEN
            IF
                (ToPurchaseHeader."Document Type" <> ToPurchaseHeader."Document Type"::Invoice) THEN
                ShouldInsertOldPurchDocNoLine := true
            else
                ShouldInsertOldPurchDocNoLine := false;
        //#7450//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterInitPurchLineFields', '', true, true)]
    local procedure OnAfterInitPurchLineFields(var PurchaseLine: Record "Purchase Line")
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeModifyPurchHeader', '', true, true)]
    local procedure OnBeforeModifyPurchHeader(var ToPurchHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; RecalculateLines: Boolean; FromPurchaseHeader: Record "Purchase Header"; FromPurchInvHeader: Record "Purch. Inv. Header"; FromPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; OldPurchaseHeader: Record "Purchase Header")
    begin
        //  //#7450
        //   IF ((FromDocType = PurchDocType::"Posted Invoice") OR (FromDocType = 3)) THEN BEGIN
        //     IF (Vend."No." = '') THEN
        //       Vend.GET("Buy-from Vendor No.");
        //     IF ("Payment Terms Code" <> Vend."Payment Terms Code") THEN BEGIN
        //       VALIDATE("Payment Terms Code",Vend."Payment Terms Code");
        //       VALIDATE("Payment Method Code",Vend."Payment Method Code");
        //     END;
        //     "Subscription Starting Date" := 0D;
        //     "Subscription End Date" := 0D;
        //   END;
        //#7450//
        //DEVIS
        /*//#7373
          //#6367
            "Posting Description" := wShowPostingDescription(wPostingDescription);
          //#6367//
        //#7373//*/
        //DEVIS//
    end;


    local procedure CopySalesHeaderFromSalesHeaderArchive(FromSalesHeaderArchive: Record "Sales Header Archive"; var ToSalesHeader: Record "Sales Header"; var OldSalesHeader: Record "Sales Header")
    begin
        FromSalesHeaderArchive.CalcFields("Work Description");
        ToSalesHeader.Validate("Sell-to Customer No.", FromSalesHeaderArchive."Sell-to Customer No.");
        ToSalesHeader.TransferFields(FromSalesHeaderArchive, false);

        UpdateSalesHeaderWhenCopyFromSalesHeaderArchive(ToSalesHeader);
        CopyFromArchSalesDocDimToHdr(ToSalesHeader, FromSalesHeaderArchive);
        SetReceivedFromCountryCode(FromSalesHeaderArchive, ToSalesHeader);

    end;

    local procedure UpdateSalesHeaderWhenCopyFromSalesHeaderArchive(var SalesHeader: Record "Sales Header")
    var
        CudCopyDoc: Codeunit "Copy Document Mgt.";
    begin
        CudCopyDoc.ClearSalesLastNoSFields(SalesHeader);
        SalesHeader.Status := SalesHeader.Status::Open;
    end;

    local procedure CopyFromArchSalesDocDimToHdr(var ToSalesHeader: Record "Sales Header"; FromSalesHeaderArchive: Record "Sales Header Archive")
    begin
        ToSalesHeader."Shortcut Dimension 1 Code" := FromSalesHeaderArchive."Shortcut Dimension 1 Code";
        ToSalesHeader."Shortcut Dimension 2 Code" := FromSalesHeaderArchive."Shortcut Dimension 2 Code";
        ToSalesHeader."Dimension Set ID" := FromSalesHeaderArchive."Dimension Set ID";
    end;

    local procedure SetReceivedFromCountryCode(FromSalesHeaderArchive: Record "Sales Header Archive"; var ToSalesHeader: Record "Sales Header")
    begin
        if not ToSalesHeader.IsCreditDocType() then
            ToSalesHeader."Rcvd.-from Count./Region Code" := '';
        if not (FromSalesHeaderArchive."Document Type" in [FromSalesHeaderArchive."Document Type"::"Return Order"]) then
            ToSalesHeader."Rcvd.-from Count./Region Code" := '';
    end;

    LOCAL PROCEDURE wWarnCompletion(ToSalesHeader: Record "Sales Header");
    VAR
        lText1100280006: Label 'Do you want to cancel Completion %1 of %2 %3 ??';
        lText1100280007: Label 'Do you want to cancel the Scheduler Invoice line(s) ?';
    BEGIN
        //PROJET_FACT
        IF NOT wCancelCompletion AND (ToSalesHeader."No. Prepayment Invoiced" <> 0) THEN
            ERROR(ErrorCompletion);
        IF HideDialog THEN
            EXIT;

        IF (ToSalesHeader."Document Type" <> ToSalesHeader."Document Type"::"Credit Memo") OR
           ((ToSalesHeader."No. Prepayment Invoiced" = 0) AND NOT ToSalesHeader."Scheduler Origin") THEN
            EXIT;

        IF ToSalesHeader."No. Prepayment Invoiced" <> 0 THEN BEGIN
            IF NOT CONFIRM(lText1100280006, FALSE,
                           ToSalesHeader."No. Prepayment Invoiced", ToSalesHeader.FIELDCAPTION("Job No."), ToSalesHeader."Job No.") THEN
                wCancelCompletion := FALSE
            ELSE
                wCancelCompletion := TRUE;
        END ELSE BEGIN
            IF NOT CONFIRM(lText1100280007, FALSE) THEN
                wCancelCompletion := FALSE
            ELSE
                wCancelCompletion := TRUE;
        END;
        //PROJET_FACT//
    END;

    PROCEDURE wCancelClosing();
    BEGIN
        //PROJET_FACT
        wCancelCompletion := TRUE;
        //PROJET_FACT//
    END;

    LOCAL PROCEDURE lOpenProgressBar(FromDocType: Option Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Quote Archive"; FromDocNo: Code[20]; FromDocNoOccurrence: Integer; FromVersionNo: Integer);
    VAR
        lSalesLine: Record "Sales Line";
        lSalesShipLine: Record "Sales Shipment Line";
        lSalesInvLine: Record "Sales Invoice Line";
        lPostedReturnReceipt: Record "Return Receipt Line";
        lSalesCrMemoLine: Record "Sales Cr.Memo Line";
        lSalesLineArchive: Record "Sales Line Archive";
        lRecRef: RecordRef;
        lTitle: Text[50];
    BEGIN
        CASE FromDocType OF
            FromDocType::Quote,
            FromDocType::"Blanket Order",
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Return Order",
            FromDocType::"Credit Memo":
                BEGIN
                    lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                    lSalesLine.SETRANGE("Document Type", FromDocType);
                    lSalesLine.SETRANGE("Document No.", FromDocNo);
                    lSalesLine.SETRANGE("Structure Line No.", 0);
                    IF lSalesLine.FINDFIRST THEN;
                    wMaxProgress := lSalesLine.COUNT;
                    lTitle := STRSUBSTNO(tTitreProgress, lSalesLine."Document Type", FromDocNo);
                END;
            FromDocType::"Posted Shipment":
                BEGIN
                    lSalesShipLine.SETRANGE("Document No.", FromDocNo);
                    IF lSalesShipLine.FINDFIRST THEN;
                    wMaxProgress := lSalesShipLine.COUNT;
                    lRecRef.OPEN(DATABASE::"Sales Shipment Line");
                    lTitle := STRSUBSTNO(tTitreProgress, lRecRef.CAPTION, FromDocNo);
                END;
            FromDocType::"Posted Invoice":
                BEGIN
                    lSalesInvLine.SETRANGE("Document No.", FromDocNo);
                    IF lSalesInvLine.FINDFIRST THEN;
                    wMaxProgress := lSalesInvLine.COUNT;
                    lRecRef.OPEN(DATABASE::"Sales Invoice Line");
                    lTitle := STRSUBSTNO(tTitreProgress, lRecRef.CAPTION, FromDocNo);
                END;
            FromDocType::"Posted Return Receipt":
                BEGIN
                    lPostedReturnReceipt.SETRANGE("Document No.", FromDocNo);
                    IF lPostedReturnReceipt.FINDFIRST THEN;
                    wMaxProgress := lPostedReturnReceipt.COUNT;
                    lRecRef.OPEN(DATABASE::"Return Receipt Line");
                    lTitle := STRSUBSTNO(tTitreProgress, lRecRef.CAPTION, FromDocNo);
                END;
            FromDocType::"Posted Credit Memo":
                BEGIN
                    lSalesCrMemoLine.SETRANGE("Document No.", FromDocNo);
                    IF lSalesCrMemoLine.FINDFIRST THEN;
                    wMaxProgress := lSalesCrMemoLine.COUNT;
                    lRecRef.OPEN(DATABASE::"Sales Cr.Memo Line");
                    lTitle := STRSUBSTNO(tTitreProgress, lRecRef.CAPTION, FromDocNo);
                END;
            FromDocType::"Quote Archive":
                BEGIN
                    lSalesLineArchive.SETCURRENTKEY("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.",
                                                    "Gen. Prod. Posting Group", "Line Type", "Structure Line No.");
                    lSalesLineArchive.SETRANGE("Document Type", lSalesLineArchive."Document Type"::Quote);
                    lSalesLineArchive.SETRANGE("Document No.", FromDocNo);
                    lSalesLineArchive.SETRANGE("Doc. No. Occurrence", FromDocNoOccurrence);
                    lSalesLineArchive.SETRANGE("Version No.", FromVersionNo);
                    lSalesLineArchive.SETRANGE("Structure Line No.", 0);
                    IF lSalesLineArchive.FINDFIRST THEN;
                    wMaxProgress := lSalesLineArchive.COUNT;

                    lRecRef.OPEN(DATABASE::"Sales Line Archive");
                    lTitle := STRSUBSTNO(tTitreProgress, lRecRef.CAPTION, FromDocNo);
                END;
        END;

        //IF wMaxProgress < 20 THEN EXIT;
        wProgress.OPEN(lTitle + tTypeProgress + tCalcProgress);
    END;

    LOCAL PROCEDURE lUpdateProgressBar(FromDocType: Option Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Quote Archive"; pIndex: Integer);
    VAR
        lRecRef: RecordRef;
    BEGIN
        IF wMaxProgress < 20 THEN EXIT;

        CASE FromDocType OF
            FromDocType::Quote,
            FromDocType::"Blanket Order",
            FromDocType::Order,
            FromDocType::Invoice,
            FromDocType::"Return Order",
            FromDocType::"Credit Memo":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Sales Line");
                END;
            FromDocType::"Posted Shipment":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Sales Shipment Line");
                END;
            FromDocType::"Posted Invoice":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Sales Invoice Line");
                END;
            FromDocType::"Posted Return Receipt":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Return Receipt Line");
                END;
            FromDocType::"Posted Credit Memo":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Sales Cr.Memo Line");
                END;
            FromDocType::"Quote Archive":
                BEGIN
                    lRecRef.OPEN(DATABASE::"Sales Line Archive");
                END;
        END;


        wProgress.UPDATE(1, lRecRef.CAPTION);
        wProgress.UPDATE(2, ROUND((pIndex / wMaxProgress) * 10000, 1));
    END;

    LOCAL PROCEDURE lCloseProgressBar();
    BEGIN
        //IF wMaxProgress < 20 THEN EXIT;
        wProgress.CLOSE;
    END;

    PROCEDURE lBOQIsEmpty(pFromSalesHeader: Record "Sales Header"): Boolean;
    VAR
        lBOQMgt: Codeunit "BOQ Management";
        lRecRef: RecordRef;
    BEGIN
        lRecRef.GETTABLE(pFromSalesHeader);
        EXIT(lBOQMgt.Load(lRecRef.RECORDID));
    END;

    PROCEDURE lArchiveBOQIsEmpty(pFromSalesHeader: Record "Sales Header Archive"): Boolean;
    VAR
        lBOQMgt: Codeunit "BOQ Management";
        lRecRef: RecordRef;
    BEGIN
        lRecRef.GETTABLE(pFromSalesHeader);
        EXIT(lBOQMgt.Load(lRecRef.RECORDID));
    END;

    PROCEDURE lIsExtText(pCodeValue: Code[20]; pSalesLine: Record "Sales Line") rValue: Boolean;
    VAR
        lExtTextLine: Record "Extended Text Line";
    BEGIN
        //#7666
        rValue := TRUE;
        lExtTextLine.SETRANGE("No.", pCodeValue);
        IF lExtTextLine.FIND('-') THEN
            REPEAT
                IF pSalesLine.Description = lExtTextLine.Text THEN
                    rValue := FALSE;
            UNTIL lExtTextLine.NEXT = 0;
    END;

    PROCEDURE lIsStructureParent(pSalesLine: Record "Sales Line"; VAR pStructureNo: Code[20]): Boolean;
    VAR
        lSalesLine: Record "Sales Line";
    BEGIN
        //#7666
        IF lSalesLine.GET(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Attached to Line No.") THEN
            IF lSalesLine."Line Type" = lSalesLine."Line Type"::Structure THEN BEGIN
                pStructureNo := lSalesLine."No.";
                EXIT(TRUE);
            END;
    END;

    PROCEDURE fTestBOQExist(pSalesDocHeader: Record "Sales Header");
    VAR
        lBoqCustMgt: Codeunit "BOQ Custom Management";
        lRecRef: RecordRef;
    BEGIN
        //#7645
        //La verification ne doit se faire uniquement sur les doc de ventes devis et commande
        IF (pSalesDocHeader."Document Type" = pSalesDocHeader."Document Type"::Quote) OR
           (pSalesDocHeader."Document Type" = pSalesDocHeader."Document Type"::Order) THEN BEGIN
            lRecRef.GETTABLE(pSalesDocHeader);
            IF (NOT lBoqCustMgt.fBOQExist(lRecRef.RECORDID)) THEN BEGIN
                lBoqCustMgt.gVerifySalesBOQ(pSalesDocHeader);
            END;
        END;
        //#7645//
    END;

    PROCEDURE fCopyFromArchPurchDocDimToHdr(VAR pToPurchHeader: Record "Purchase Header"; VAR pFromPurchHeaderArchive: Record "Purchase Header Archive");
    VAR
        lDocDim: Record "Gen. Jnl. Dim. Filter";
        lFromDocDimArchive: Record "Interaction Merge Data";
    BEGIN
        //DYS table Doc Dim supprimer
        /*
            //#7859
            lDocDim.SETRANGE("Table ID", DATABASE::"Purchase Header");
            lDocDim.SETRANGE("Document Type", pToPurchHeader."Document Type");
            lDocDim.SETRANGE("Document No.", pToPurchHeader."No.");
            lDocDim.SETRANGE("Line No.", 0);
            lDocDim.DELETEALL;

            pToPurchHeader."Shortcut Dimension 1 Code" := pFromPurchHeaderArchive."Shortcut Dimension 1 Code";
            pToPurchHeader."Shortcut Dimension 2 Code" := pFromPurchHeaderArchive."Shortcut Dimension 2 Code";

            lFromDocDimArchive.SETRANGE("Table ID", DATABASE::"Purchase Header Archive");
            //#8301
            //lFromDocDimArchive.SETRANGE("Document Type",lFromDocDimArchive."Document Type"::Order);
            lFromDocDimArchive.SETRANGE("Document Type", pFromPurchHeaderArchive."Document Type");
            //#8301
            lFromDocDimArchive.SETRANGE("Document No.", pFromPurchHeaderArchive."No.");
            lFromDocDimArchive.SETRANGE("Doc. No. Occurrence", pFromPurchHeaderArchive."Doc. No. Occurrence");
            lFromDocDimArchive.SETRANGE("Version No.", pFromPurchHeaderArchive."Version No.");
            IF lFromDocDimArchive.FIND('-') THEN BEGIN
                REPEAT
                    lDocDim.INIT;
                    lDocDim."Table ID" := DATABASE::"Purchase Header";
                    lDocDim."Document Type" := pToPurchHeader."Document Type";
                    lDocDim."Document No." := pToPurchHeader."No.";
                    lDocDim."Line No." := 0;
                    lDocDim."Dimension Code" := lFromDocDimArchive."Dimension Code";
                    lDocDim."Dimension Value Code" := lFromDocDimArchive."Dimension Value Code";
                    lDocDim.INSERT;
                UNTIL lFromDocDimArchive.NEXT = 0;
            END;
            //#7859
            */
    END;


}