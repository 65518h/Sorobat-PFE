codeunit 50037 PurchPostEvent
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        lWorkflowSetup: Record "Workflow Setup";
        lCompanySetup: Record "Company Setup";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lLineAmountToInvoice: Decimal;
        lPurchSubscrMgt: Codeunit "Purch. Subscription Integr.";
        lNaviBatSetup: Record NavibatSetup;
        lProdCompl: Record "Production Completion Entry";
        lArchiveMgt: Codeunit ArchiveManagement;
        lPostJobEntry: Boolean;
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lComplete: Boolean;
        lConformDateRef: Date;
        lPurchline: Record "Purchase Line";
        lPurchRcptLine: Record "Purch. Rcpt. Line";
        lReturnRcptInv: Record "Return Receipt Invoiced";
        lPurchRcptInv: Record "Purchase Rcpt. Invoiced";
        lValidateInvoice: Boolean;
        lValidateShip: Boolean;
        lExcessReceip: Boolean;
        lPurchPostPaymentIntegr: Codeunit "Purch.-Post Payment Integr.";
        lPurchPostSubscriptionIntegr: Codeunit "Purch-Post Subscription integr";
        //lInvBufferSubscriptIntegr : Codeunit 8001906;
        lHoldJobNo: Code[20];
        lPurchOrderPost: Codeunit "Purch. Order - Post";
        lOrderLine: Record "Sales Line";
        wPurchRcptInv: Record "Purchase Rcpt. Invoiced";
        wReturnRcptInv: Record "Return Receipt Invoiced";
        wJob: Record Job;
        wHideValidationDialog: Boolean;
        DtaSetup: Record "DTA Setup";
        DtaMgt: Codeunit DtaMgt;
        wOldPurchLine: Record "Purchase Line";
        gTotalAmountToInvoice: Decimal;
        tNoEPostingDesc: Label 'NdF %1 %2';
        gCompletionMgt: Codeunit "Completion Management";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        T8003900: Label 'Vous ne pouvez pas receptionner un article générique sur une affaire de stock';
        Text010: label '%1 %2 -> Facture %3';
        Text011: label '%1 %2 -> Avoir %3';
        RecLigneDossier: Record "Ligne Dossiers d'Importation";
        RecItemCharge: Record "Item Charge";
        VarDMontantFS: Decimal;
        Text061: Label 'Magasin non Autorisé !!!';
        Text062: label 'Modification Reussite, Validation de la Facture Nø %1';
        Text063: Label '';
        text023: Label 'in the associated blanket order must not be greater than %1';
        Text064: Label 'Supprition reuissite, vérifier les factures en cours : Facture Nø %1';
        ItemChargeZeroAmountErr: Label 'The amount for item charge %1 cannot be 0.', Comment = '%1 = Item Charge No.';
    //HS

    //HS Only recieve order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]

    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if not Confirm('Voulez-vous réceptionner  cette commande ?') then
                IsHandled := true;
        end;
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            DefaultOption := 1;
            HideDialog := true;
            PurchaseHeader.Receive := true;
            PurchaseHeader.Invoice := false;
        end;
    end;
    //HS Only recieve order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSetPostingFlags', '', true, true)]
    local procedure OnAfterSetPostingFlags(var PurchHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        //+NDF+
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::"Note of Expenses" THEN BEGIN
            PurchHeader.Receive := TRUE;
            PurchHeader.Invoice := TRUE;
            PurchHeader.Ship := FALSE;
            PurchHeader."Applies-to Doc. Type" := PurchInvHeader."Applies-to Doc. Type"::"Note of Expenses";
            PurchHeader."Posting Description" :=
              COPYSTR(STRSUBSTNO(tNoEPostingDesc, PurchHeader."Pay-to Name", PurchHeader."Your Reference"),
                1, MAXSTRLEN(PurchHeader."Posting Description"));
            IF PurchSetup."Ext. Doc. No. Mandatory" THEN BEGIN
                IF PurchHeader."Vendor Invoice No." = '' THEN
                    PurchHeader."Vendor Invoice No." := PurchHeader."No.";
                IF PurchHeader."Vendor Cr. Memo No." = '' THEN
                    PurchHeader."Vendor Cr. Memo No." := PurchHeader."No.";
            END;
        END;
        //+NDF+//
    end;

    /*GL2024 [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforePostInvoice', '', true, true)]
     local procedure OnRunOnBeforePostInvoice(PurchaseHeader: Record "Purchase Header"; var EverythingInvoiced: Boolean)
     begin
         IF PurchaseHeader.Invoice then begin
             CalcTimbre(PurchaseHeader);
             CalcFodec(PurchaseHeader); 
         end;

     end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCalcInvoiceOnAfterResetTempLines', '', true, true)]
    local procedure OnCalcInvoiceOnAfterResetTempLines(var PurchHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary; var NewInvoice: Boolean; var IsHandled: Boolean)
    begin
        //#8939
        //++ABO++ - FACT_AVOIR
        IF gAddOnLicencePermission.HasPermissionABO THEN
            gTotalAmountToInvoice := lPurchPostSubscriptionIntegr.GetPurchTotalAmountToInvoice(PurchHeader, TempPurchLine, PurchHeader.Invoice);
        //++ABO++ - FACT_AVOIR//
        gTotalAmountToInvoice := lPurchOrderPost.GetPurchTotalAmountToInvoice(PurchHeader, TempPurchLine, PurchHeader.Invoice);
        //#8939//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckDropShipmentReceiveInvoice', '', true, true)]
    local procedure OnBeforeCheckDropShipmentReceiveInvoice(PurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //SUBCONTRACTOR : suppression pour facturer achat ind‚pendamment vente
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckAssocOrderLinesOnBeforeCheckOrderLine', '', true, true)]
    local procedure OnCheckAssocOrderLinesOnBeforeCheckOrderLine(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; SalesOrderLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //SUBCONTRACTOR : suppression pour facturer achat ind‚pendamment vente
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnUpdatePostingNosOnAfterCalcShouldUpdateReceivingNo', '', true, true)]
    local procedure OnUpdatePostingNosOnAfterCalcShouldUpdateReceivingNo(PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var ModifyHeader: Boolean; var ShouldUpdateReceivingNo: Boolean)
    var
        NoSeriesMgt: Codeunit SoroubatFucntion;
    begin
        //#7795
        NoSeriesMgt.fSetRespCenter(PurchaseHeader."Responsibility Center");
        //#7795//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckAndUpdateOnAfterSetSourceCode', '', true, true)]
    local procedure OnCheckAndUpdateOnAfterSetSourceCode(var PurchHeader: Record "Purchase Header"; SourceCodeSetup: Record "Source Code Setup"; var SrcCode: Code[10]);
    begin
        //+NDF+
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::"Note of Expenses" THEN BEGIN
            SourceCodeSetup.TESTFIELD("Note of Expenses Journal");
            SrcCode := SourceCodeSetup."Note of Expenses Journal";
        END;
        //+NDF+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', true, true)]
    local procedure OnAfterPurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; PreviewMode: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        //ACHATS
        PurchSetup.Get();
        IF (PurchaseHeader.Receive AND NOT PurchaseHeader.Invoice) AND
           PurchSetup."Vendor Shipment No. Mandatory"
        THEN
            PurchaseHeader.TESTFIELD("Vendor Shipment No.");
        //ACHATS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInsertInvoiceHeader', '', true, true)]
    local procedure OnBeforeInsertInvoiceHeader(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean; var Window: Dialog; var HideProgressWindow: Boolean; var SrcCode: Code[10]; var PurchCommentLine: Record "Purch. Comment Line"; var RecordLinkManagement: Codeunit "Record Link Management")
    begin
        //+NDF+
        //    IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
        IF (PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice, PurchHeader."Document Type"::"Note of Expenses"])
           //++ABO++ - FACT_AVOIR
           AND (gTotalAmountToInvoice >= 0)
          //++ABO++ - FACT_AVOIR//
          THEN
            IsHandled := false
        else
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', true, true)]
    local procedure OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //POSTING_DESC
        PurchInvHeader."Posting Description" := PurchHeader.wShowPostingDescription(PurchInvHeader."Posting Description");
        //POSTING_DESC//
        //ACHATS
        PurchInvHeader."Vendor Shipment No." := PurchHeader."Vendor Shipment No.";
        //ACHATS//
        //Dossier d'importation
        PurchInvHeader."N° Dossier" := PurchHeader."N° Dossier";
        //Dossier d'importation
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertInvoiceHeader', '', true, true)]

    local procedure OnAfterInsertInvoiceHeader(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        //#7675//
        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.PurchInvoicePostOnHold(PurchaseHeader, PurchInvHeader)
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', true, true)]
    local procedure OnBeforePurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //POSTING_DESC
        PurchCrMemoHdr."Posting Description" := PurchHeader.wShowPostingDescription(PurchCrMemoHdr."Posting Description");
        //POSTING_DESC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertPostedHeaders', '', true, true)]
    local procedure OnAfterInsertPostedHeaders(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var PurchSetup: Record "Purchases & Payables Setup"; var Window: Dialog)
    begin
        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            lProcessusWKFIntegr.PurchCreditPostOnHold(PurchaseHeader, PurchCrMemoHdr);
        //+WKF+CUSTOM//

        //POSTING_DESC
        PurchaseHeader."Posting Description" := PurchaseHeader.wShowPostingDescription(PurchaseHeader."Posting Description");
        //POSTING_DESC//
    end;

    /*GL2024  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeUpdatePurchLineBeforePost', '', true, true)]
      local procedure OnBeforeUpdatePurchLineBeforePost(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; WhseShip: Boolean; WhseReceive: Boolean; RoundingLineInserted: Boolean; CommitIsSupressed: Boolean)
      begin
          //#6565
          IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
              PurchaseLine.TESTFIELD("Job No.");
              //#9109
              PurchaseLine.TESTFIELD("Job Task No.");
              //#9109//
          END;
          //#6565//
      end;*/
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTestPurchLine', '', true, true)]

    local procedure OnBeforeTestPurchLine(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; var IsHandled: Boolean)
    begin
        if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
            PurchaseLine."Job No." := '';
            PurchaseLine."Job Task No." := '';
            //PurchaseLine.Modify(); 
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTestPurchLineFixedAsset', '', true, true)]
    local procedure OnBeforeTestPurchLineFixedAsset(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        ReclPurchhdr: Record "Purchase Header";
        RecPurchaseLine: Record "Purchase Line";
    begin
        IF ReclPurchhdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN;
        //#5635
        IF ReclPurchhdr.Receive AND ReclPurchhdr.Invoice AND (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order) THEN
            PurchaseLine.TESTFIELD("Qty. to Receive",
              PurchaseLine."Qty. to Invoice" + PurchaseLine."Quantity Invoiced" - PurchaseLine."Quantity Received");
        //#5635//
        // RecPurchaseLine.Reset();
        // RecPurchaseLine.SetRange("Document Type", PurchaseLine."Document Type");
        // RecPurchaseLine.SetRange("Document No.", PurchaseLine."Document No.");
        // RecPurchaseLine.SetRange(Type, RecPurchaseLine.Type::"Fixed Asset");
        // RecPurchaseLine.SetFilter("Job No.", '<>%1', '');
        // if RecPurchaseLine.FindSet() then begin
        //     repeat
        //         RecPurchaseLine."Job No." := '';
        //         RecPurchaseLine."Job Task No." := '';
        //         RecPurchaseLine.Modify();
        //     until RecPurchaseLine.Next() = 0;
        // end;


        // PurchaseLine."Job No." := '';
        // PurchaseLine."Job Task No." := '';
        // PurchaseLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckFieldsOnReturnShipmentLine', '', true, true)]
    local procedure OnBeforeCheckFieldsOnReturnShipmentLine(var ReturnShipmentLine: Record "Return Shipment Line"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        ReturnShipmentLine.TestField("Buy-from Vendor No.", PurchaseLine."Buy-from Vendor No.");
        ReturnShipmentLine.TestField(Type, PurchaseLine.Type);
        ReturnShipmentLine.TestField("No.", PurchaseLine."No.");
        //PROJET
        // ReturnShipmentLine.TestField("Gen. Bus. Posting Group", PurchaseLine."Gen. Bus. Posting Group");
        // ReturnShipmentLine.TestField("Gen. Prod. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
        // ReturnShipmentLine.TestField("Job No.", PurchaseLine."Job No.");
        ReturnShipmentLine."Gen. Bus. Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
        ReturnShipmentLine."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
        //#6565
        //              ReturnShptLine."Job No." := PurchLine."Job No.";
        lCheckJob(PurchaseLine, ReturnShipmentLine."Job No.");
        //#6565//
        //              ReturnShptLine."Job Task No." := PurchLine."Job Task No.";
        ReturnShipmentLine."Work Type Code" := PurchaseLine."Work Type Code";
        //PROJET//
        ReturnShipmentLine.TestField("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
        ReturnShipmentLine.TestField("Variant Code", PurchaseLine."Variant Code");
        ReturnShipmentLine.TestField("Prod. Order No.", PurchaseLine."Prod. Order No.");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdateInvoicedQtyOnReturnShptLine', '', true, true)]
    local procedure OnAfterUpdateInvoicedQtyOnReturnShptLine(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentLine: Record "Return Shipment Line"; PurchaseLine: Record "Purchase Line"; TempTrackingSpecification: Record "Tracking Specification" temporary; TrackingSpecificationExists: Boolean; QtyToBeInvoiced: Decimal; QtyToBeInvoicedBase: Decimal)
    var

        ReturnShptHeader: Record "Return Shipment Header";
        RecPurchHdr: Record "Purchase Header";
    begin
        IF RecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN;
        //CUT_OFF
        ReturnShptHeader.GET(ReturnShipmentLine."Document No.");
        wReturnRcptInv.INIT;
        wReturnRcptInv."Credit Memo No." := PurchCrMemoHdr."No.";
        wReturnRcptInv."Cr. Memo Line No." := PurchaseLine."Line No.";
        wReturnRcptInv."Return Receipt. No." := ReturnShipmentLine."Document No.";
        wReturnRcptInv."Return Receipt Line No." := ReturnShipmentLine."Line No.";
        wReturnRcptInv."Return  Order No." := ReturnShipmentLine."Return Order No.";
        wReturnRcptInv."Return Order Line No." := ReturnShipmentLine."Return Order Line No.";
        wReturnRcptInv."Qty. to Invoice" := QtyToBeInvoiced;
        wReturnRcptInv."Qty. to Receive" := ReturnShipmentLine.Quantity;
        wReturnRcptInv."Cr. Memo Posting Date" := PurchCrMemoHdr."Posting Date";
        wReturnRcptInv."Return Rcpt. Posting Date" := ReturnShptHeader."Posting Date";
        wReturnRcptInv."User ID" := USERID;
        IF NOT wReturnRcptInv.INSERT THEN
            IF lReturnRcptInv.GET(PurchCrMemoHdr."No.", PurchaseLine."Line No.", ReturnShipmentLine."Document No.",
            ReturnShipmentLine."Line No.") THEN BEGIN
                wReturnRcptInv."Qty. to Invoice" += lReturnRcptInv."Qty. to Invoice";
                wReturnRcptInv.MODIFY;
            END;
        //#6141
        IF RecPurchHdr."Return Shipment No." <> '' THEN
            ReturnShptHeader.GET(RecPurchHdr."Return Shipment No.")
        ELSE BEGIN
            ReturnShptHeader.INIT;
            ReturnShptHeader."No." := '';
        END;
        //#6141//
        //CUT_OFF//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterReturnShptLineInsert', '', true, true)]
    local procedure OnAfterReturnShptLineInsert(var ReturnShptLine: Record "Return Shipment Line"; ReturnShptHeader: Record "Return Shipment Header"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; xPurchLine: Record "Purchase Line")
    var
        ReclPurchHdr: Record "Purchase Header";
    begin
        //CUT_OFF
        IF ReclPurchHdr.GET(PurchLine."Document Type", PurchLine."Document No.") THEN;
        IF ReclPurchHdr.Invoice AND (ReturnShptLine."Quantity Invoiced" <> 0) THEN
            //#6141
                      IF NOT wReturnRcptInv.GET(PurchCrMemoHdr."No.", PurchLine."Line No.",
                                 ReturnShptLine."Document No.", ReturnShptLine."Line No.") THEN BEGIN
                //#6141
                wReturnRcptInv.INIT;
                wReturnRcptInv."Credit Memo No." := PurchCrMemoHdr."No.";
                wReturnRcptInv."Cr. Memo Line No." := PurchLine."Line No.";
                wReturnRcptInv."Return Receipt. No." := ReturnShptLine."Document No.";
                wReturnRcptInv."Return Receipt Line No." := ReturnShptLine."Line No.";
                wReturnRcptInv."Return  Order No." := ReturnShptLine."Return Order No.";
                wReturnRcptInv."Return Order Line No." := ReturnShptLine."Return Order Line No.";
                wReturnRcptInv."Qty. to Invoice" := ReturnShptLine."Quantity Invoiced";
                wReturnRcptInv."Qty. to Receive" := ReturnShptLine.Quantity;
                wReturnRcptInv."Cr. Memo Posting Date" := PurchCrMemoHdr."Posting Date";
                wReturnRcptInv."Return Rcpt. Posting Date" := ReturnShptHeader."Posting Date";
                wReturnRcptInv."User ID" := USERID;
                wReturnRcptInv.INSERT;
            END;
        //CUT_OFF//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnBeforeInsertInvoiceLine', '', true, true)]
    local procedure OnPostPurchLineOnBeforeInsertInvoiceLine(PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; var PurchInvLine: Record "Purch. Inv. Line");
    begin
        //++ABO++ - FACT_AVOIR***
        //#8056
        //        IF gTotalAmountToInvoice >= 0 THEN
        //BAT//        IF ("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]) AND (gTotalAmountToInvoice >= 0) THEN BEGIN
        //#8056//
        //++ABO++ - FACT_AVOIR
        //+NDF+
        //        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN BEGIN
        //BAT//        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::"Note of Expenses"] THEN
        //             BEGIN
        //+NDF+//
        // +ABO+ +NDF+ conditions cumulées
        //#8885
        //IF (("Document Type" IN ["Document Type"::Order,"Document Type"::Invoice]) AND (gTotalAmountToInvoice >= 0))OR
        //  ("Document Type" IN ["Document Type"::"Note of Expenses"]) THEN BEGIN
        IF ((PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice, PurchaseHeader."Document Type"::"Note of Expenses"])
            AND (gTotalAmountToInvoice >= 0)) THEN
            IsHandled := false
        else
            IsHandled := true;
        //#8885//
        //+ABO+ +NDF+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', true, true)]
    local procedure OnBeforePurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        //Dossier d'importation
        PurchInvLine."N° Bon Reception" := xPurchaseLine."Receipt No.";
        PurchInvLine."N° Ligne Bon Reception" := xPurchaseLine."Receipt Line No.";
        PurchInvLine."N° dossier" := xPurchaseLine."N° Dossier";

        //Dossier D'arrivage

        //ACHATS
        IF (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Invoice) AND (xPurchaseLine."Original Unit Cost (LCY)" = 0) THEN BEGIN
            xPurchaseLine."Original Quantity" := PurchaseLine.Quantity;
            xPurchaseLine."Original Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
        END;
        PurchInvLine."Amount Ordered (LCY)" :=
          ROUND(PurchInvLine.Quantity * xPurchaseLine."Original Unit Cost (LCY)", GLSetup."Amount Rounding Precision");
        //ACHATS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvLineInsert', '', true, true)]
    local procedure OnAfterPurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; PurchHeader: Record "Purchase Header"; PurchRcptHeader: Record "Purch. Rcpt. Header"; TempWhseRcptHeader: Record "Warehouse Receipt Header"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    begin
        //Dossier d'importation
        IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
            RecLigneDossier.RESET;
            RecLigneDossier.SETCURRENTKEY("N° réception", "N° ligne réception", "N° article", "N° dossier");
            RecLigneDossier.SETFILTER("N° réception", PurchLine."Receipt No.");
            RecLigneDossier.SETFILTER("N° ligne réception", '%1', PurchLine."Receipt Line No.");
            RecLigneDossier.SETFILTER("N° article", PurchLine."No.");
            IF RecLigneDossier.FIND('-') THEN
                REPEAT
                    RecLigneDossier."Coût unitaire direct" := PurchLine."Direct Unit Cost";
                    RecLigneDossier.Montant := (PurchLine."Direct Unit Cost" * RecLigneDossier.Quantité);
                    RecLigneDossier."Coût unitaire" := PurchLine."Direct Unit Cost";
                    RecLigneDossier.MODIFY;
                UNTIL RecLigneDossier.NEXT = 0;
        END;

        //Dossier d'importation
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoLineInsert', '', true, true)]
    local procedure OnAfterPurchCrMemoLineInsert(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var PurchaseHeader: Record "Purchase Header"; GenJnlLineDocNo: Code[20]; RoundingLineInserted: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    begin
        //++ABO++
        IF (PurchLine."Blanket Order No." <> '') AND (PurchLine."Subscription Posting Date" <> 0D)
           AND gAddOnLicencePermission.HasPermissionABO THEN
            lPurchSubscrMgt.UpdateSubscrPostingDate(PurchLine);
        //++ABO++//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeSalesShptLineInsert', '', true, true)]
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSupressed: Boolean; DropShptPostBuffer: Record "Drop Shpt. Post. Buffer")
    begin
        //CDE_INTERNE
        IF SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order" THEN BEGIN
            //#8877
            lOrderLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
            lOrderLine.SETRANGE("Supply Order No.", SalesLine."Document No.");
            lOrderLine.SETRANGE("Supply Order Line No.", SalesLine."Line No.");
            lOrderLine.SETRANGE("Structure Line No.", 0);
            IF lOrderLine.FINDFIRST THEN BEGIN
                SalesShptLine."Qty. Shipped Not Invoiced" := SalesShptLine.Quantity;
                SalesShptLine."Quantity Invoiced" := 0;
                SalesShptLine."Qty. Invoiced (Base)" := 0;
                lOrderLine."Quantity Shipped" += SalesShptLine.Quantity;
                lOrderLine."Qty. Shipped (Base)" += SalesShptLine."Quantity (Base)";
                lOrderLine."Qty. Shipped Not Invoiced" := lOrderLine."Quantity Shipped" - lOrderLine."Quantity Invoiced";
                lOrderLine."Qty. Shipped Not Invd. (Base)" := lOrderLine."Qty. Shipped (Base)" - lOrderLine."Qty. Invoiced (Base)";
                lOrderLine.MODIFY;
            END ELSE BEGIN
                //#8877//
                SalesShptLine."Quantity Invoiced" := SalesShptLine.Quantity;
                SalesShptLine."Qty. Invoiced (Base)" := SalesShptLine."Quantity (Base)";
            END;
        END;
        //CDE_INTERNE//
        //SUBCONTRACTOR
        IF SalesShptLine.Type <> SalesShptLine.Type::Item THEN begin
            SalesShptLine."Item Shpt. Entry No." := 0;
            SalesShptLine."Item Charge Base Amount" := 0;
        end;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSalesShptLineInsert', '', true, true)]
    local procedure OnAfterSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesOrderLine: Record "Sales Line"; CommitIsSuppressed: Boolean; DropShptPostBuffer: Record "Drop Shpt. Post. Buffer"; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        SalesOrderHeader: Record "Sales Header";
    begin
        //SUBCONTRATOR
        IF SalesOrderHeader.get(SalesOrderLine."Document Type", SalesOrderLine."Document No.") THEN;
        IF (SalesOrderHeader."Order Type" <> SalesOrderHeader."Order Type"::"Supply Order") AND
           NOT SalesOrderHeader."Scheduler Origin" AND
           (SalesOrderHeader."Document Type" = SalesOrderHeader."Document Type"::Order) THEN BEGIN
            SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,
                               DropShptPostBuffer."Order No.", DropShptPostBuffer."Order Line No.");
            lProdCompl.INIT;
            lProdCompl."Job No." := SalesOrderLine."Job No.";
            lProdCompl."Job Task No." := SalesOrderLine."Job Task No.";
            lProdCompl."Closing No." := SalesOrderHeader."No. Prepayment Invoiced";
            lProdCompl."Posting Date" := SalesShptHeader."Posting Date";
            lProdCompl."Line No." := SalesOrderLine."Line No.";
            lProdCompl."Order No." := SalesOrderLine."Document No.";
            lProdCompl."Order Line No." := SalesOrderLine."Line No.";
            lProdCompl."Document No." := SalesShptHeader."No.";
            lProdCompl."Work Type Code" := SalesOrderLine."Work Type Code";
            lProdCompl.INSERT(TRUE);
            lProdCompl.VALIDATE(lProdCompl."New Quantity", DropShptPostBuffer.Quantity + SalesOrderLine."Quantity Shipped");
            lProdCompl.MODIFY;
        END;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //Dossier d'importation
        GenJournalLine."N° Dossier" := PurchaseHeader."N° Dossier";
        //Dossier d'importation
        // RB SORO 22/03/2016 FACTURE SIMULATION
        // GenJournalLine.Simulation := PurchaseHeader.Simulation;
        // RB SORO 22/03/2016 FACTURE SIMULATION
        // CH2300.end
        //PROJET
        GenJournalLine."Job No." := PurchaseHeader."Job No.";
        //PROJET//
        //PMT_DIRECT
        IF (GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice) THEN
            GenJournalLine."Apply-to Sales Order No." := PurchaseHeader."Apply-to Sales Order No.";
        //PMT_DIRECT//

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnPostBalancingEntryOnAfterGenJnlPostLine', '', true, true)]
    local procedure OnPostBalancingEntryOnAfterGenJnlPostLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")

    begin
        // //+PMT+MULTI
        //           IF gAddOnLicencePermission.HasPermissionPMT() THEN
        //             lPurchPostPaymentIntegr.PostFractionGenJnlLine(GenJnlLine,TempJnlLineDim,PurchHeader."Payment Terms Code",GenJnlPostLine)
        //           ELSE
        //       //+PMT+MULTI//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnAfterSetEverythingInvoiced', '', true, true)]

    local procedure OnPostPurchLineOnAfterSetEverythingInvoiced(PurchaseLine: Record "Purchase Line"; var EverythingInvoiced: Boolean; PurchaseHeader: Record "Purchase Header")
    begin
        //FACT_ACHAT_PERSO
        PurchaseHeader."Vendor Invoice No." := '';
        PurchaseHeader."Vendor Cr. Memo No." := '';
        IF lCompanySetup.GET AND lCompanySetup."Keep Invoiced Order" AND (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) THEN
            EverythingInvoiced := FALSE;
        //FACT_ACHAT_PERSO//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostPurchLineOnBeforeTestGeneralPostingGroups', '', true, true)]
    local procedure OnPostPurchLineOnBeforeTestGeneralPostingGroups(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        RecPurchHdr: Record "Purchase Header";
    begin
        IF RecPurchHdr.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then;
        //#8067
        lExcessReceip := FALSE;
        //#8067//
        IF RecPurchHdr.Receive THEN
            //#8067
            lExcessReceip := PurchaseLine."Qty. to Receive" + PurchaseLine."Quantity Received" > PurchaseLine.Quantity;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateOrderLineOnBeforeInitOutstanding', '', true, true)]
    local procedure OnPostUpdateOrderLineOnBeforeInitOutstanding(var PurchaseHeader: Record "Purchase Header"; var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        //#8067
        IF lExcessReceip THEN
            TempPurchaseLine."Completely Received" := TRUE;
        //#8067//
    end;

    [EventSubscriber(ObjectType::table, Database::"Purchase Line", 'OnAfterInitOutstandingQty', '', true, true)]
    local procedure OnAfterInitOutstandingQty(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    begin
        //+REF+COTFRN
        PurchaseLine."Qty. Not In Conformity" := 0;
        PurchaseLine."Not In Conformity Code" := '';
        PurchaseLine."Remainder Quantity" := 0;
        //+REF+COTFRN//
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateInvoiceLineOnBeforeCalcQty', '', true, true)]
    local procedure OnPostUpdateInvoiceLineOnBeforeCalcQty(var TempPurchLine: Record "Purchase Line" temporary; var PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchOrderLine."Quantity Invoiced" += TempPurchLine."Qty. to Invoice";
        PurchOrderLine."Qty. Invoiced (Base)" += TempPurchLine."Qty. to Invoice (Base)";
        IsHandled := true;
    end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateInvoiceLineOnBeforeInitQtyToInvoice', '', true, true)]
    local procedure OnPostUpdateInvoiceLineOnBeforeInitQtyToInvoice(var PurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary)
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get();
        //ACHATS
        IF TempPurchaseLine."Ordered Not Invoiced (LCY)" <> 0 THEN
            TempPurchaseLine."Ordered Not Invoiced (LCY)" -=
              ROUND(
                PurchaseLine."Qty. to Invoice" * PurchaseLine."Original Unit Cost (LCY)",
                GLSetup."Amount Rounding Precision");
        //ACHATS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFinalizePostingOnAfterUpdateItemChargeAssgnt', '', true, true)]
    local procedure OnFinalizePostingOnAfterUpdateItemChargeAssgnt(var PurchHeader: Record "Purchase Header"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary; var EverythingInvoiced: Boolean; var TempPurchLine: Record "Purchase Line" temporary; var TempPurchLineGlobal: Record "Purchase Line" temporary; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SalesOrderLine: Record "Sales Line";
        PurchSetup: Record "Purchases & Payables Setup";
        cdupurchpost: Codeunit "Purch.-Post";

    begin
        //SUBCONTRACTOR
        IF PurchHeader.Receive AND PurchHeader.Invoice THEN BEGIN
            TempPurchLineGlobal.SETFILTER("Sales Order Line No.", '<>0');
            IF TempPurchLineGlobal.FIND('-') THEN
                cdupurchpost.UpdateAssocOrder(TempDropShptPostBuffer);
            TempPurchLineGlobal.SETRANGE("Sales Order Line No.");
        END;
        //SUBCONTRACTOR//
        //CDE_INTERNE
        IF PurchHeader.Receive AND PurchHeader.Invoice THEN BEGIN
            TempPurchLineGlobal.SETFILTER("Special Order Sales Line No.", '<>0');
            IF TempPurchLineGlobal.FIND('-') THEN
                IF (TempPurchLineGlobal.Quantity - TempPurchLineGlobal."Qty. to Invoice" - TempPurchLineGlobal."Quantity Invoiced" = 0) THEN
                    IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,
                    TempPurchLineGlobal."Special Order Sales No.", TempPurchLineGlobal."Special Order Sales Line No.") THEN BEGIN
                        SalesOrderLine."Purchase Order No." := '';
                        SalesOrderLine."Purch. Order Line No." := 0;
                        SalesOrderLine."Purchasing Order No." := '';
                        SalesOrderLine."Purchasing Order Line No." := 0;
                        SalesOrderLine.MODIFY;
                    END;
            TempPurchLineGlobal.SETRANGE("Special Order Sales Line No.");
        END;
        //CDE_INTERNE//
        //ACHATS : Achiver commande
        PurchSetup.GET;
        //#8609
        //IF PurchSetup."Archive Orders" AND (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN
        IF ((PurchSetup."Archive Quotes" = PurchSetup."Archive Quotes"::Always) AND (PurchSetup."Archive Orders") AND
             ((PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Both) OR
              (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::"At the invoicing")))
            AND (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN
            //#8609//
            lArchiveMgt.StorePurchDocument(PurchHeader, FALSE);
        //ACHATS//
    end;

    [EventSubscriber(ObjectType::table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var
        Job: Record Job;
        lItem: Record item;
    begin
        //Dossier d'importation
        IF Job.Get(PurchLine."dysJob No.") THEN;
        ItemJnlLine."N° Dossier" := PurchLine."N° Dossier";
        ItemJnlLine."N° Réception" := PurchLine."Receipt No.";
        ItemJnlLine."N° Ligne Réception" := PurchLine."Receipt Line No.";
        // ItemJnlLine."Lieu De Livraison / Provenance" := PurchLine."dysJob No.";
        //Dossier d'importation
        //#8877
        IF Job."Job Type" <> Job."Job Type"::Stock THEN BEGIN
            //#8877//
            ItemJnlLine."Job No." := PurchLine."dysJob No.";
            ItemJnlLine."Job Task No." := PurchLine."dysJob Task No.";
            //#8877
        END ELSE BEGIN
            IF lItem.GET(ItemJnlLine."Item No.") AND (lItem."Item Type" = lItem."Item Type"::Generic) THEN
                ERROR(T8003900);
        END;
        //#8877//





        // //Dossier d'importation
        //         IF PurchLine."dysJob No." <> '' then
        //             IF Job.Get(PurchLine."dysJob No.") THEN;
        //         IF PurchLine."Job No." <> '' then
        //             IF Job.Get(PurchLine."Job No.") THEN;
        //         ItemJnlLine."N° Dossier" := PurchLine."N° Dossier";
        //         ItemJnlLine."N° Réception" := PurchLine."Receipt No.";
        //         ItemJnlLine."N° Ligne Réception" := PurchLine."Receipt Line No.";
        //         ItemJnlLine."Lieu De Livraison / Provenance" := PurchLine."dysJob No.";
        //         //Dossier d'importation
        //         //#8877
        //         IF Job."Job Type" <> Job."Job Type"::Stock THEN BEGIN
        //             //#8877//
        //             IF PurchLine."dysJob No." <> '' then begin
        //                 ItemJnlLine."Job No." := PurchLine."dysJob No.";
        //                 ItemJnlLine."Job Task No." := PurchLine."dysJob Task No.";
        //             end
        //             else begin
        //                 ItemJnlLine."Job No." := PurchLine."dysJob No.";
        //                 ItemJnlLine."Job Task No." := PurchLine."dysJob Task No.";
        //             end;

        //             //#8877
        //         END ELSE BEGIN
        //             IF lItem.GET(ItemJnlLine."Item No.") AND (lItem."Item Type" = lItem."Item Type"::Generic) THEN
        //                 ERROR(T8003900);
        //         END;
        //         //#8877//








    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTestPurchLineItemCharge', '', true, true)]
    local procedure OnBeforeTestPurchLineItemCharge(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)

    begin
        if (PurchaseLine.Amount = 0) and (PurchaseLine.Quantity <> 0) then
            Error(ErrorInfo.Create(StrSubstNo(ItemChargeZeroAmountErr, PurchaseLine."No."), true, PurchaseLine));
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemChargePerOrderOnAfterCopyToItemJnlLine', '', true, true)]
    local procedure OnPostItemChargePerOrderOnAfterCopyToItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var PurchaseLine: Record "Purchase Line"; GeneralLedgerSetup: Record "General Ledger Setup"; QtyToInvoice: Decimal; var TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary; PurchLine: Record "Purchase Line")
    begin
        //Dossier d'importation
        ItemJournalLine."N° Dossier" := TempItemChargeAssignmentPurch."N° Dossier";
        ItemJournalLine."N° Réception" := TempItemChargeAssignmentPurch."Applies-to Doc. No.";
        ItemJournalLine."N° Ligne Réception" := TempItemChargeAssignmentPurch."Applies-to Doc. Line No.";
        //Dossier d'importation
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemChargePerSalesRetRcptOnBeforeTestJobNo', '', true, true)]
    local procedure OnPostItemChargePerSalesRetRcptOnBeforeTestJobNo(ReturnReceiptLine: Record "Return Receipt Line"; var IsHandled: Boolean; var PurchaseLine: Record "Purchase Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostAssocItemJnlLine', '', true, true)]
    local procedure OnBeforePostAssocItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var SalesLine: Record "Sales Line"; CommitIsSupressed: Boolean; var PurchaseLine: Record "Purchase Line")
    var
        SalesOrderHeader: Record "Sales Header";
        Job: Record Job;
    begin
        if SalesOrderHeader.get(SalesLine."Document Type", SalesLine."Document No.") THEN;
        //CDE_INTERNE
        IF SalesOrderHeader."Order Type" = SalesOrderHeader."Order Type"::"Supply Order" THEN BEGIN
            //#8877
            lOrderLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
            lOrderLine.SETRANGE("Supply Order No.", SalesLine."Document No.");
            lOrderLine.SETRANGE("Supply Order Line No.", SalesLine."Line No.");
            lOrderLine.SETRANGE("Structure Line No.", 0);
            IF lOrderLine.FINDFIRST THEN BEGIN
                ItemJournalLine."Invoiced Quantity" := 0;
                ItemJournalLine."Invoiced Qty. (Base)" := 0;
            END ELSE BEGIN
                //#8877//
                ItemJournalLine."Invoiced Quantity" := ItemJournalLine.Quantity;
                ItemJournalLine."Invoiced Qty. (Base)" := ItemJournalLine."Quantity (Base)";
            END;
        END;
        //CDE_INTERNE//
        //#8877
        IF Job.Get(SalesLine."Job No.") THEN;
        IF Job."Job Type" <> Job."Job Type"::Stock THEN BEGIN
            ItemJournalLine."Job No." := SalesLine."Job No.";
            ItemJournalLine."Job Task No." := SalesLine."Job Task No.";
        END;
        //#8877//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterReverseAmount', '', true, true)]

    local procedure OnAfterReverseAmount(var PurchLine: Record "Purchase Line")
    begin
        //#5766
        PurchLine."Job Total Price" := -PurchLine."Job Total Price";
        PurchLine."Job Line Amount" := -PurchLine."Job Line Amount";
        PurchLine."Job Line Discount Amount" := -PurchLine."Job Line Discount Amount";
        PurchLine."Job Total Price (LCY)" := -PurchLine."Job Total Price (LCY)";
        PurchLine."Job Line Amount (LCY)" := -PurchLine."Job Line Amount (LCY)";
        PurchLine."Job Line Disc. Amount (LCY)" := -PurchLine."Job Line Disc. Amount (LCY)";
        //#5766//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnUpdateBlanketOrderLineOnBeforeCheck', '', true, true)]
    local procedure OnUpdateBlanketOrderLineOnBeforeCheck(var BlanketOrderPurchLine: Record "Purchase Line"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; Ship: Boolean; Receive: Boolean; Invoice: Boolean)
    begin
        IF (BlanketOrderPurchLine.Quantity *
                BlanketOrderPurchLine."Quantity Received" < 0)
             THEN
            BlanketOrderPurchLine.FIELDERROR(
              "Quantity Received",
              STRSUBSTNO(
                Text023,
                BlanketOrderPurchLine.FIELDCAPTION(Quantity)));

        IF (BlanketOrderPurchLine."Quantity (Base)" *
           BlanketOrderPurchLine."Qty. Received (Base)" < 0)
        THEN
            BlanketOrderPurchLine.FIELDERROR(
              "Qty. Received (Base)",
              STRSUBSTNO(
                Text023,
                BlanketOrderPurchLine.FIELDCAPTION("Quantity Received")));
        //#5832//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeBlanketOrderPurchLineModify', '', true, true)]
    local procedure OnBeforeBlanketOrderPurchLineModify(var BlanketOrderPurchLine: Record "Purchase Line"; PurchLine: Record "Purchase Line"; Ship: Boolean; Receive: Boolean; Invoice: Boolean)
    begin
        //+REF+EXCEED_RECEIPT
        //#5832
        //      BlanketOrderPurchLine."Qty. to Invoice" :=
        //        BlanketOrderPurchLine.Quantity - BlanketOrderPurchLine."Quantity Invoiced";
        IF BlanketOrderPurchLine.Quantity - BlanketOrderPurchLine."Quantity Received" > 0 THEN BEGIN
            BlanketOrderPurchLine.InitQtyToReceive;
            BlanketOrderPurchLine."Qty. to Invoice" :=
              BlanketOrderPurchLine.Quantity - BlanketOrderPurchLine."Quantity Invoiced";
            BlanketOrderPurchLine."Qty. to Invoice (Base)" :=
              BlanketOrderPurchLine."Quantity (Base)" - BlanketOrderPurchLine."Qty. Invoiced (Base)";
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemChargePerSalesShptOnBeforeTestJobNo', '', true, true)]
    local procedure OnPostItemChargePerSalesShptOnBeforeTestJobNo(SalesShipmentLine: Record "Sales Shipment Line"; var IsHandled: Boolean; var PurchaseLine: Record "Purchase Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCreatePrepmtLinesOnAfterTempPurchLineSetFilters', '', true, true)]
    local procedure OnCreatePrepmtLinesOnAfterTempPurchLineSetFilters(var TempPurchaseLine: Record "Purchase Line" temporary)
    begin
        //#8858

        TempPurchaseLine.SETFILTER(Quantity, '<>0');
        TempPurchaseLine.SETFILTER("Qty. to Invoice", '<>0');
        //#8858//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeArchiveUnpostedOrder', '', true, true)]
    local procedure OnBeforeArchiveUnpostedOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; var OrderArchived: Boolean; PreviewMode: Boolean)
    var
        PurchSetup: record "Purchases & Payables Setup";
    begin
        PurchSetup.Get();
        IF ((NOT PurchSetup."Archive Orders") OR
          (PurchSetup."Archive Orders" AND (PurchSetup."Archiving Method" = PurchSetup."Archiving Method"::Standard))) THEN
            IsHandled := true;
        //#8609//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', true, true)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; EverythingInvoiced: Boolean)

    begin
        //+REF+MISC_PURCH
        IF PurchCrMemoHdr."No." <> '' THEN
            MESSAGE(STRSUBSTNO(Text011, PurchHeader."Document Type", PurchHeader."No.", PurchCrMemoHdr."No."));
        IF PurchInvHeader."No." <> '' THEN
            MESSAGE(STRSUBSTNO(Text010, PurchHeader."Document Type", PurchHeader."No.", PurchInvHeader."No."));
        //+REF+MISC_PURCH//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckPurchRcptLine', '', true, true)]
    local procedure OnBeforeCheckPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //PROJET
        PurchRcptLine.TestField("Buy-from Vendor No.", PurchaseLine."Buy-from Vendor No.");
        PurchRcptLine.TestField(Type, PurchaseLine.Type);
        PurchRcptLine.TestField("No.", PurchaseLine."No.");
        //PurchRcptLine.TestField("Gen. Bus. Posting Group", PurchaseLine."Gen. Bus. Posting Group");
        //PurchRcptLine.TestField("Gen. Prod. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
        //PurchRcptLine.TestField("Job No.", PurchaseLine."Job No.");
        PurchRcptLine.TestField("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
        PurchRcptLine.TestField("Variant Code", PurchaseLine."Variant Code");
        PurchRcptLine.TestField("Prod. Order No.", PurchaseLine."Prod. Order No.");
        IsHandled := true;
        PurchRcptLine."Gen. Bus. Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
        PurchRcptLine."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
        //#6565
        if PurchaseLine."dysJob No." <> '' then
            PurchRcptLine."dysJob No." := PurchaseLine."dysJob No."
        else
            PurchRcptLine."Job No." := PurchaseLine."Job No.";
        lCheckJob(PurchaseLine, PurchRcptLine."Job No.");
        //#6565//
        PurchRcptLine."Job Task No." := PurchaseLine."Job Task No.";
        PurchRcptLine."Work Type Code" := PurchaseLine."Work Type Code";
        //PROJET//
        PurchRcptLine."Observation" := PurchaseLine.Observation_Ligne;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostGLAccICLineOnBeforeCreateJobPurchLine', '', true, true)]
    local procedure OnPostGLAccICLineOnBeforeCreateJobPurchLine(var PurchHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //#6935
        // Ici on valide si c'est ok pour la facturation et la livraison
        //#9420
        lValidateInvoice := PurchHeader.Invoice AND (ABS(PurchaseLine."Qty. to Invoice") > 0);
        lValidateShip := PurchHeader.Ship AND (ABS(PurchaseLine."Qty. to Receive") > 0);
        //#9420//
        //IF (PurchLine."Job No." <> '') AND (PurchLine."Qty. to Invoice" <> 0) THEN BEGIN
        IF ((PurchaseLine."Job No." <> '') AND (PurchaseLine."Qty. to Invoice" <> 0)
            AND (lValidateInvoice OR lValidateShip)) THEN
            IsHandled := false
        else
            IsHandled := true;
        //#6935//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnProcessAssocItemJnlLineOnAfterInitTempDropShptPostBuffer', '', true, true)]
    local procedure OnProcessAssocItemJnlLineOnAfterInitTempDropShptPostBuffer(var PurchLine: Record "Purchase Line"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary)
    var
        SalesOrderLine: Record "Sales Line";
    begin
        //SUBCONTRACTOR
        TempDropShptPostBuffer."Purch. Order Line No." := PurchLine."Line No.";
        SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, PurchLine."Sales Order No.", PurchLine."Sales Order Line No.");
        IF (SalesOrderLine."Structure Line No." <> 0) AND (SalesOrderLine.Subcontracting <> 0) THEN
            TempDropShptPostBuffer."Order Line No." := SalesOrderLine."Structure Line No."

        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTempDropShptPostBufferInsert', '', true, true)]
    local procedure OnBeforeTempDropShptPostBufferInsert(var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary; PurchaseLine: Record "Purchase Line")
    var
        SalesOrderLine: Record "Sales Line";
    begin
        //SUBCONTRACTOR
        SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, PurchaseLine."Sales Order No.", PurchaseLine."Sales Order Line No.");
        IF SalesOrderLine.Type <> SalesOrderLine.Type::Item THEN
            TempDropShptPostBuffer."Item Shpt. Entry No." := 0;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessAssocItemJnlLine', '', true, true)]
    local procedure OnAfterProcessAssocItemJnlLine(var PurchLine: Record "Purchase Line"; var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer" temporary)
    var
        JobPostLine: codeunit "Job Post-Line";
    begin
        // //PROJET_IMMO
        // PurchLine.Type::"Fixed Asset": BEGIN
        //     IF PurchLine."Job No." <> '' THEN
        //         JobPostLine.InsertPurchLine(PurchHeader, PurchInvHeader, PurchCrMemoHeader,
        //         JobPurchLine, SrcCode, TempJnlLineDim);
        // END;
        // //PROJET_IMMO//
        // //+NDF+
        // PurchLine.Type::"Note of Expenses": BEGIN
        //     PurchHeader.TESTFIELD("Document Type", PurchHeader."Document Type"::"Note of Expenses");
        //     IF PurchLine."Job No." <> '' THEN
        //         JobPostLine.InsertPurchLine(PurchHeader, PurchInvHeader, PurchCrMemoHeader,
        //         JobPurchLine, SrcCode, TempJnlLineDim);
        // END;
        // //+NDF+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', true, true)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean)
    var
        Currency: Record Currency;
    begin
        //Dossier d'importation
        PurchRcptLine."N° dossier" := PurchRcptHeader."N° Dossier";
        //Dossier d'importation
        IF Currency.get(PurchRcptHeader."Currency Code") then;

        //+REF+COTFRN
        PurchRcptLine."Posting Date" := PurchRcptHeader."Posting Date";
        PurchRcptLine."Remainder Quantity" :=
          PurchLine."Outstanding Quantity" - PurchLine."Qty. to Receive";

        //        lSingleInstance.GetCompletePurchOrder(lComplete);
        //        IF lComplete OR (PurchRcptLine.Quantity = 0) THEN BEGIN
        IF PurchLine."Completely Received" OR (PurchRcptLine.Quantity = 0) THEN BEGIN
            PurchRcptLine."Not In Conformity" := FALSE;
            PurchRcptLine."Remainder Quantity" := 0;
            PurchRcptLine."Qty. Not In Conformity" := 0;
            PurchRcptLine."Not In Conformity Code" := '';
        END ELSE BEGIN
            IF PurchRcptLine."Qty. Not In Conformity" <> 0 THEN
                PurchRcptLine.TESTFIELD("Not In Conformity Code");
            IF PurchRcptLine."Promised Receipt Date" > PurchRcptLine."Requested Receipt Date" THEN
                lConformDateRef := PurchRcptLine."Promised Receipt Date"
            ELSE
                lConformDateRef := PurchRcptLine."Requested Receipt Date";
            IF (PurchRcptLine."Promised Receipt Date" = 0D) AND
               (PurchRcptLine."Requested Receipt Date" = 0D) THEN
                lConformDateRef := PurchRcptLine."Posting Date";

            PurchRcptLine."Not In Conformity" :=
              (PurchRcptLine."Posting Date" > lConformDateRef) OR
              (PurchRcptLine."Remainder Quantity" <> 0) OR
              (PurchRcptLine."Qty. Not In Conformity" <> 0);
            //#5719
            PurchRcptLine."Order Line Amount" :=
              ROUND(PurchLine.Quantity * PurchLine."Direct Unit Cost", Currency."Amount Rounding Precision") -
              PurchLine."Line Discount Amount";
            //#5719//
        END;
        //+REF+COTFRN//
    end;

    PROCEDURE wSetHideValidationDialog(pNewHideValidationDialog: Boolean);
    BEGIN
        //DEVIS
        wHideValidationDialog := pNewHideValidationDialog;
        //DEVIS//
    END;

    LOCAL PROCEDURE lCheckJob(VAR pPurchLine: Record "Purchase Line"; VAR pJobNo: Code[20]);
    VAR
        lJob1: Record Job;
        lJob2: Record Job;
        ltFrom: label 'ne peut être modifié depuis une affaire de type Stock.';
        ltTo: label 'ne peut être modifié pour une affaire de type Stock.';
        ltCancel: Label 'Vous devez annuler la réception (ou le retour)';
    BEGIN
        EXIT;//>> HJ SORO 20-09-2018
        IF (pPurchLine."dysJob No." = pJobNo) OR (pJobNo = '') THEN
            EXIT;
        IF lJob1.GET(pJobNo) AND lJob2.GET(pPurchLine."dysJob No.") AND (lJob1."Job Type" = lJob2."Job Type") THEN
            pJobNo := pPurchLine."dysJob No."
        ELSE IF lJob1."Job Type" = lJob1."Job Type"::Stock THEN
            pJobNo := pPurchLine."dysJob No."// pPurchLine.FIELDERROR("Job No.",ltFrom + ' ' + ltCancel)
        ELSE
            pPurchLine.FIELDERROR("dysJob No.", ltTo + ' ' + ltCancel);
    END;



    PROCEDURE VerifIntegrationConsomCpt(VAR RecItemJournalLine: Record "Item Journal Line");
    VAR
        RecLItemApplicationEntry: Record "Item Application Entry";
        RecLGeneralPostingSetup: Record "General Posting Setup";
        RecLItemLedgerEntry: Record "Item Ledger Entry";
        RecLValueEntry: Record "Value Entry";
        RecLGenJournalLine: Record "Gen. Journal Line";
        RecInventorySetup: Record "Inventory Setup";
        RecLJob: Record Job;
        RecResource: Record Resource;
        RecDefaultDimension: Record "Default Dimension";
        RecLItemJournalTemplate: Record "Item Journal Template";
        CdeCompteChargeAffecte: Code[20];
        CdeCompteStock: Code[20];
        CdeAxeChantire: Code[20];
        CdeAxeMateriel: Code[20];
        DecMontantDebit: Decimal;
        DecMontantCredit: Decimal;
        TextL001: Label 'Vous dever parametrer compte affectation ou compte Achat pout le code nature %1';
        DecQteInitial: Decimal;
        DecCoutUnitaire: Decimal;
        IntCompteur: Integer;
        TextL002: Label 'Parametrage Model De Feuille Manquant Dans Parametre Stock Onglet Specifique';
        TextL003: Label 'Axe Ou Section Analytique Manquante Pour L''AffaireNø  %1';
        TextL004: Label 'Axe Ou Section Analytique Manquante Pour Le Materiel Nø  %1';
        TextL005: Label 'Veuiller Saisir Le Nø Affaire';
        TextL006: Label 'Veuiller Saisir Le Materiel';
    BEGIN
        // >> HJ DSFT 27-03-2012
        IF RecInventorySetup.GET THEN;
        IF (RecInventorySetup."Model Journal" = '') OR (RecInventorySetup."Nom Model De Feuille" = '') THEN
            ERROR(TextL002);
        WITH RecItemJournalLine DO BEGIN
            REPEAT
                RecLGeneralPostingSetup.RESET;
                RecLGeneralPostingSetup.SETRANGE("Gen. Prod. Posting Group", RecItemJournalLine."Gen. Prod. Posting Group");
                RecLGeneralPostingSetup.SETFILTER("Comptes De Charges Affectées", '<>%1', '');
                IF RecLGeneralPostingSetup.FINDFIRST THEN BEGIN
                    CdeCompteChargeAffecte := RecLGeneralPostingSetup."Comptes De Charges Affectées";
                    CdeCompteStock := RecLGeneralPostingSetup."Purch. Account";
                END;
                IF (CdeCompteChargeAffecte = '') OR (CdeCompteStock = '') THEN ERROR(TextL001, RecItemJournalLine."Gen. Prod. Posting Group");
                RecLGenJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Journal");
                IF Marche <> '' THEN BEGIN
                    RecDefaultDimension.RESET;
                    RecDefaultDimension.SETRANGE("Table ID", 167);
                    RecDefaultDimension.SETRANGE("No.", Marche);
                    IF RecDefaultDimension.FINDFIRST THEN
                        REPEAT
                            IF (RecDefaultDimension."Dimension Code" = '') OR (RecDefaultDimension."Dimension Value Code" = '') THEN
                                ERROR(TextL003, Marche);
                        UNTIL RecDefaultDimension.NEXT = 0
                    ELSE
                        ERROR(TextL003, Marche);
                END;
                IF Materiel <> '' THEN BEGIN
                    RecDefaultDimension.RESET;
                    RecDefaultDimension.SETRANGE("Table ID", 156);
                    RecDefaultDimension.SETRANGE("No.", Materiel);
                    IF RecDefaultDimension.FINDFIRST THEN
                        REPEAT
                            IF (RecDefaultDimension."Dimension Code" = '') OR (RecDefaultDimension."Dimension Value Code" = '') THEN
                                ERROR(TextL004, Marche);
                        UNTIL RecDefaultDimension.NEXT = 0
                    ELSE
                        ERROR(TextL004, Materiel);
                END;
                IF RecLItemJournalTemplate.GET("Journal Template Name") THEN;
                IF RecLItemJournalTemplate."Affaire Obligatoire" THEN IF Marche = '' THEN ERROR(TextL005);
                IF RecLItemJournalTemplate."Materiel Obligatoire" THEN IF Materiel = '' THEN ERROR(TextL006);

            UNTIL RecItemJournalLine.NEXT = 0
        END;

        // >> HJ DSFT 27-03-2012
    END;

    PROCEDURE IntegrationConsommationCpt(VAR RecItemJournalLine: Record "Item Journal Line");
    VAR
        RecLItemApplicationEntry: Record "Item Application Entry";
        RecLGeneralPostingSetup: Record "General Posting Setup";
        RecLItemLedgerEntry: Record "Item Ledger Entry";
        RecLValueEntry: Record "Value Entry";
        RecLGenJournalLine: Record "Gen. Journal Line";
        RecInventorySetup: Record "Inventory Setup";
        RecDefaultDimension: Record "Default Dimension";
        RecLJob: Record Job;
        RecResource: Record Resource;
        RecJournalLineDimension: Record "Dim. Value per Account";
        RecGenJnlBatch: Record "Gen. Journal Batch";
        RecNoSeriesMgt: Codeunit NoSeriesManagement;
        RecLItemJournalTemplate: Record "Item Journal Template";
        CdeCompteChargeAffecte: Code[20];
        CdeCompteStock: Code[20];
        CdeAxeChantire: Code[20];
        CdeAxeMateriel: Code[20];
        DecMontantDebit: Decimal;
        DecMontantCredit: Decimal;
        TextL001: Label 'Vous dever parametrer compte affectation ou compte Achat pout le code nature %1';
        DecQteInitial: Decimal;
        DecCoutUnitaire: Decimal;
        IntCompteur: Integer;
        CdeNumeroDocument: Code[20];
    BEGIN
        // >> HJ DSFT 27-03-2012
        WITH RecItemJournalLine DO BEGIN
            IF RecLItemJournalTemplate.GET("Journal Template Name") THEN;
            IF NOT RecLItemJournalTemplate."Feuille Affectaion Charge" THEN EXIT;
            REPEAT
                CdeCompteChargeAffecte := '';
                CdeCompteStock := '';
                CdeAxeChantire := '';
                CdeAxeMateriel := '';
                DecMontantDebit := 0;
                DecMontantCredit := 0;
                DecQteInitial := 0;
                DecCoutUnitaire := 0;
                IF RecInventorySetup.GET THEN;
                RecGenJnlBatch.GET(RecInventorySetup."Model Journal", RecInventorySetup."Nom Model De Feuille");
                //DYS 
                // CdeNumeroDocument := RecNoSeriesMgt.GetNextNoDocument(RecGenJnlBatch."No. Series", TODAY);
                CdeNumeroDocument := RecNoSeriesMgt.GetNextNo(RecGenJnlBatch."No. Series", TODAY, true);
                RecLGeneralPostingSetup.SETRANGE("Gen. Prod. Posting Group", RecItemJournalLine."Gen. Prod. Posting Group");
                RecLGeneralPostingSetup.SETFILTER("Comptes De Charges Affectées", '<>%1', '');
                IF RecLGeneralPostingSetup.FINDFIRST THEN BEGIN
                    CdeCompteChargeAffecte := RecLGeneralPostingSetup."Comptes De Charges Affectées";
                    CdeCompteStock := RecLGeneralPostingSetup."Purch. Account";
                END;
                IF (CdeCompteChargeAffecte = '') OR (CdeCompteStock = '') THEN ERROR(TextL001, RecItemJournalLine."Gen. Prod. Posting Group");
                RecLItemLedgerEntry.SETCURRENTKEY("Document No.", "Item No.");
                RecLItemLedgerEntry.SETRANGE("Document No.", RecItemJournalLine."Document No.");
                RecLItemLedgerEntry.SETRANGE("Item No.", RecItemJournalLine."Item No.");
                IF RecLItemLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IntCompteur += 10000;
                        DecQteInitial := RecLItemLedgerEntry.Quantity;
                        RecLItemApplicationEntry.SETRANGE("Outbound Item Entry No.", RecLItemLedgerEntry."Entry No.");
                        IF RecLItemApplicationEntry.FINDFIRST THEN
                            REPEAT
                                RecLItemApplicationEntry.CALCFIELDS("Cout Total Document Entree", "Quantité Achat Valorisé",
                                "Cout Total Document Entre Prev", "Quantité Achat Valorisé Prev");
                                IF RecLItemApplicationEntry."Quantité Achat Valorisé" <> 0 THEN
                                    DecCoutUnitaire := ABS(RecLItemApplicationEntry."Cout Total Document Entree" /
                                                       RecLItemApplicationEntry."Quantité Achat Valorisé")
                                ELSE
                                    IF RecLItemApplicationEntry."Quantité Achat Valorisé Prev" <> 0 THEN
                                        DecCoutUnitaire := ABS(RecLItemApplicationEntry."Cout Total Document Entre Prev" /
                                                           RecLItemApplicationEntry."Quantité Achat Valorisé Prev")
                                                            ;
                                DecMontantDebit += ABS(RecLItemApplicationEntry.Quantity) * DecCoutUnitaire;
                            UNTIL RecLItemApplicationEntry.NEXT = 0;
                        RecLGenJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Journal");
                        RecLGenJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model De Feuille");
                        RecLGenJournalLine.DELETEALL;
                        RecLGenJournalLine.INIT;
                        RecLGenJournalLine."Journal Template Name" := RecInventorySetup."Model Journal";
                        RecLGenJournalLine."Journal Batch Name" := RecInventorySetup."Nom Model De Feuille";
                        RecLGenJournalLine."Document No." := CdeNumeroDocument;
                        RecLGenJournalLine."Line No." := IntCompteur;
                        RecLGenJournalLine."Posting Date" := RecItemJournalLine."Posting Date";
                        RecLGenJournalLine.VALIDATE("Account Type", RecLGenJournalLine."Account Type"::"G/L Account");
                        RecLGenJournalLine.VALIDATE("Account No.", CdeCompteChargeAffecte);
                        RecLGenJournalLine.VALIDATE("Debit Amount", DecMontantDebit);
                        RecLGenJournalLine.VALIDATE("Bal. Account Type", RecLGenJournalLine."Bal. Account Type"::"G/L Account");
                        RecLGenJournalLine.VALIDATE("Bal. Account No.", CdeCompteStock);
                        IF DecMontantDebit <> 0 THEN RecLGenJournalLine.INSERT;
                        RecDefaultDimension.RESET;
                        RecDefaultDimension.SETRANGE("Table ID", 167);
                        RecDefaultDimension.SETRANGE("No.", Marche);
                        IF RecDefaultDimension.FINDFIRST THEN
                            REPEAT
                                RecJournalLineDimension.INIT;
                                RecJournalLineDimension."Table ID" := 81;
                                //    RecJournalLineDimension."Journal Template Name":=RecInventorySetup."Model Journal";
                                //    RecJournalLineDimension."Journal Batch Name":=RecInventorySetup."Nom Model De Feuille";
                                //    RecJournalLineDimension."Journal Line No.":=IntCompteur;
                                RecJournalLineDimension.VALIDATE("Dimension Code", RecDefaultDimension."Dimension Code");
                                RecJournalLineDimension.VALIDATE("Dimension Value Code", RecDefaultDimension."Dimension Value Code");
                                IF DecMontantDebit <> 0 THEN RecJournalLineDimension.INSERT(TRUE);
                            UNTIL RecDefaultDimension.NEXT = 0;
                        RecDefaultDimension.RESET;
                        RecDefaultDimension.SETRANGE("Table ID", 156);
                        RecDefaultDimension.SETRANGE("No.", Materiel);
                        IF RecDefaultDimension.FINDFIRST THEN
                            REPEAT
                                RecJournalLineDimension.INIT;
                                RecJournalLineDimension."Table ID" := 81;
                                //    RecJournalLineDimension."Journal Template Name":=RecInventorySetup."Model Journal";
                                //    RecJournalLineDimension."Journal Batch Name":=RecInventorySetup."Nom Model De Feuille";
                                //    RecJournalLineDimension."Journal Line No.":=IntCompteur;
                                RecJournalLineDimension.VALIDATE("Dimension Code", RecDefaultDimension."Dimension Code");
                                RecJournalLineDimension.VALIDATE("Dimension Value Code", RecDefaultDimension."Dimension Value Code");
                                IF DecMontantDebit <> 0 THEN RecJournalLineDimension.INSERT(TRUE);
                            UNTIL RecDefaultDimension.NEXT = 0;


                    UNTIL RecLItemLedgerEntry.NEXT = 0;

            UNTIL RecItemJournalLine.NEXT = 0;
            RecLGenJournalLine.INIT;
            RecLGenJournalLine."Journal Template Name" := RecInventorySetup."Model Journal";
            RecLGenJournalLine."Journal Batch Name" := RecInventorySetup."Nom Model De Feuille";
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Consumation", RecLGenJournalLine);
        END;

        // >> HJ DSFT 27-03-2012
    END;

    PROCEDURE IntegrationConsommationCpt2(VAR RecItemLedgerEntry: Record "Item Ledger Entry"; BlnValidationComptable: Boolean);
    VAR
        RecLItemApplicationEntry: Record "Item Application Entry";
        RecLGeneralPostingSetup: Record "General Posting Setup";
        RecLItemLedgerEntry: Record "Item Ledger Entry";
        RecLValueEntry: Record "Value Entry";
        RecLGenJournalLine: Record "Gen. Journal Line";
        RecInventorySetup: Record "Inventory Setup";
        RecDefaultDimension: Record "Default Dimension";
        RecLJob: Record JOB;
        RecResource: Record Resource;
        RecJournalLineDimension: Record "Dim. Value per Account";
        RecGenJnlBatch: Record "Gen. Journal Batch";
        RecNoSeriesMgt: Codeunit NoSeriesManagement;
        RecLItemJournalTemplate: Record "Item Journal Template";
        CdeCompteChargeAffecte: Code[20];
        CdeCompteStock: Code[20];
        CdeAxeChantire: Code[20];
        CdeAxeMateriel: Code[20];
        DecMontantDebit: Decimal;
        DecMontantCredit: Decimal;
        TextL001: Label 'Vous dever parametrer compte affectation ou compte Achat pout le code nature %1';
        DecQteInitial: Decimal;
        DecCoutUnitaire: Decimal;
        IntCompteur: Integer;
        CdeNumeroDocument: Code[20];
    BEGIN
        // >> HJ DSFT 27-03-2012
        IF RecInventorySetup.GET THEN;
        RecLGenJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Journal");
        RecLGenJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model De Feuille");
        RecLGenJournalLine.DELETEALL;
        WITH RecItemLedgerEntry DO BEGIN
            REPEAT
                CdeCompteChargeAffecte := '';
                CdeCompteStock := '';
                CdeAxeChantire := '';
                CdeAxeMateriel := '';
                DecMontantDebit := 0;
                DecMontantCredit := 0;
                DecQteInitial := 0;
                DecCoutUnitaire := 0;
                MESSAGE(RecItemLedgerEntry."Document No.");
                MESSAGE(RecItemLedgerEntry."Code Nature");
                RecGenJnlBatch.GET(RecInventorySetup."Model Journal", RecInventorySetup."Nom Model De Feuille");
                //DYS
                //CdeNumeroDocument := RecNoSeriesMgt.GetNextNoDocument(RecGenJnlBatch."No. Series", TODAY);
                CdeNumeroDocument := RecNoSeriesMgt.GetNextNo(RecGenJnlBatch."No. Series", TODAY, true);
                RecLGeneralPostingSetup.SETRANGE("Gen. Prod. Posting Group", RecItemLedgerEntry."Code Nature");
                RecLGeneralPostingSetup.SETFILTER("Comptes De Charges Affectées", '<>%1', '');
                IF RecLGeneralPostingSetup.FINDFIRST THEN BEGIN
                    CdeCompteChargeAffecte := RecLGeneralPostingSetup."Comptes De Charges Affectées";
                    CdeCompteStock := RecLGeneralPostingSetup."Purch. Account";
                END;
                IF (CdeCompteChargeAffecte = '') OR (CdeCompteStock = '') THEN ERROR(TextL001, RecItemLedgerEntry."Code Nature");
                RecLGenJournalLine.INIT;
                RecItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                RecLGenJournalLine."Journal Template Name" := RecInventorySetup."Model Journal";
                RecLGenJournalLine."Journal Batch Name" := RecInventorySetup."Nom Model De Feuille";
                RecLGenJournalLine."Document No." := CdeNumeroDocument;
                RecLGenJournalLine."Line No." := IntCompteur;
                RecLGenJournalLine."Posting Date" := RecItemLedgerEntry."Posting Date";
                RecLGenJournalLine.VALIDATE("Account Type", RecLGenJournalLine."Account Type"::"G/L Account");
                RecLGenJournalLine.VALIDATE("Account No.", CdeCompteChargeAffecte);
                RecLGenJournalLine.VALIDATE("Debit Amount", RecItemLedgerEntry."Cost Amount (Actual)");
                RecLGenJournalLine.VALIDATE("Bal. Account Type", RecLGenJournalLine."Bal. Account Type"::"G/L Account");
                RecLGenJournalLine.VALIDATE("Bal. Account No.", CdeCompteStock);
                RecLGenJournalLine.INSERT;
            UNTIL RecItemLedgerEntry.NEXT = 0;
            IF BlnValidationComptable THEN CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", RecLGenJournalLine)
        END;
        RecItemLedgerEntry.MODIFYALL("Consommation Intégré", TRUE);
        // >> HJ DSFT 27-03-2012
    END;

    PROCEDURE InsertPVReception(ParaDocNum: Code[20]; ParaNumBon: Code[20]);
    VAR
        RecLPurchaseHeader: Record "Purchase Header";
        RecLPurchaseLine: Record "Purchase Line";
        RecPvReception: Record "PV Reception";
    BEGIN
        //>> HJ DSFT 25-04-2012
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order, ParaDocNum) THEN BEGIN
            RecLPurchaseLine.SETRANGE("Document Type", RecLPurchaseLine."Document Type"::Order);
            RecLPurchaseLine.SETRANGE("Document No.", ParaDocNum);
            IF RecLPurchaseLine.FINDFIRST THEN
                REPEAT
                    IF NOT RecPvReception.GET(RecLPurchaseLine."Document No.", RecLPurchaseLine."No.", RecLPurchaseLine."Line No.") THEN BEGIN
                        RecPvReception.INIT;
                        RecPvReception."N° Commande" := RecLPurchaseLine."Document No.";
                        RecPvReception."N° Article" := RecLPurchaseLine."No.";
                        RecPvReception."Date Commande" := RecLPurchaseHeader."Order Date";
                        RecPvReception."Lieu De Chargement" := RecLPurchaseHeader."Pay-to Name";
                        RecPvReception."N° BL Fournisseur" := ParaNumBon;
                        RecPvReception.INSERT;
                    END;
                UNTIL RecLPurchaseLine.NEXT = 0;
        END;
        //>> HJ DSFT 25-04-2012
    END;

    PROCEDURE ListePvReception(ParaNumDoc: Code[20]; ParaOrderNo: Code[20]; ParaArticle: Code[20]; ParaBlFournisseur: Code[20]);
    VAR
        RecLPvReception: Record "PV Reception";
        RecLPvReception2: Record "PV Reception";
        RecLPurchRcptHeader: Record "Purch. Rcpt. Header";
    BEGIN
        // >> HJ DSFT 25-04-2012
        RecLPvReception.SETRANGE("N° Commande", ParaOrderNo);
        RecLPvReception.SETRANGE("N° Article", ParaArticle);
        RecLPvReception.SETRANGE("N° BL Fournisseur", ParaBlFournisseur);
        RecLPvReception.SETRANGE("N° Reception Enregistré", '');
        IF RecLPvReception.FINDFIRST THEN BEGIN
            RecLPvReception."N° Reception Enregistré" := ParaNumDoc;
            RecLPvReception.MODIFY;
        END;

        // >> HJ DSFT 25-04-2012
    END;

    /* PROCEDURE CalcTimbre(Rec: Record "Purchase Header");
     VAR
         RecLPurchHeader: Record "Purchase Header";
         RecLPurchLine: Record "Purchase Line";
         RecLVendorPostingGroup: Record "Vendor Posting Group";
         RecLInventoryPostingGroup: Record "Inventory Posting Group";
         VarBNotExiste: Boolean;
         VarILineNo: Integer;
         RecLPurchLine1: Record "Purchase Line";
         RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
         RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
         "RecLG/LEntry": Record "G/L Account";
     BEGIN
         RecLPurchHeader := Rec;
         // Param‚tre Taxe Client
         IF RecLVendorPostingGroup.GET(RecLPurchHeader."Vendor Posting Group") THEN;

         IF Rec."Apply Stamp fiscal" THEN BEGIN
             //    RecLPurchLine.RESET;
             //    RecLPurchLine.SETRANGE("Document Type",Rec."Document Type");
             //    RecLPurchLine.SETRANGE("Document No.",Rec."No.");
             //    RecLPurchLine.SETRANGE(RecLPurchLine.Type,RecLPurchLine.Type::"G/L Account");
             //    RecLPurchLine.SETRANGE(RecLPurchLine."No.",RecLVendorPostingGroup."Stamp Fiscal Law93/53");
             //    IF  RecLPurchLine.FIND('-') THEN
             //    BEGIN
             //      REPEAT
             //       RecLDocumentDimension.RESET;
             //       RecLDocumentDimension.SETFILTER("Table ID",'39');
             //       RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
             //       RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
             //       RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
             //       RecLDocumentDimension.DELETEALL;
             //       //RecLPurchLine.DELETE;
             //      UNTIL RecLPurchLine.NEXT=0;
         END;
         RecLPurchHeader := Rec;
         WITH RecLPurchHeader DO BEGIN

             RecLPurchLine.RESET;
             RecLPurchLine.SETRANGE("Document Type", "Document Type");
             RecLPurchLine.SETRANGE("Document No.", "No.");
             //* Test si d‚j… existe timbre fiscal
             VarBNotExiste := TRUE;
             IF RecLPurchLine.FIND('-') THEN BEGIN
                 REPEAT
                     IF (((RecLPurchLine.Type = RecLPurchLine.Type::"G/L Account") AND
                      (RecLPurchLine."No." = RecLVendorPostingGroup."Stamp Fiscal Law93/53") AND
                      (RecLPurchLine."Qty. to Invoice" <> 0))) THEN
                         VarBNotExiste := FALSE;
                 UNTIL RecLPurchLine.NEXT = 0;
             END;



             RecLPurchLine.RESET;
             RecLPurchLine.SETRANGE("Document Type", RecLPurchHeader."Document Type");
             RecLPurchLine.SETRANGE("Document No.", RecLPurchHeader."No.");
             IF ("Apply Stamp fiscal" AND RecLPurchLine.FIND('-') AND VarBNotExiste) THEN BEGIN
                 IF RecLPurchLine.FINDLAST THEN
                     VarILineNo := 999999;
                 IF 1 = 1 THEN BEGIN
                     RecLPurchLine1."Document Type" := "Document Type";
                     RecLPurchLine1."Document No." := "No.";
                     RecLPurchLine1."Line No." := VarILineNo;
                     RecLPurchLine1."Buy-from Vendor No." := "Buy-from Vendor No.";
                     RecLPurchLine1.Type := RecLPurchLine1.Type::"G/L Account";
                     RecLPurchLine1."No." := RecLVendorPostingGroup."Stamp Fiscal Law93/53";
                     // Parametre groupe comptabilisation compte Timbre
                     "RecLG/LEntry".GET(RecLVendorPostingGroup."Stamp Fiscal Law93/53");
                     RecLPurchLine1."Location Code" := "Location Code";
                     RecLPurchLine1."Expected Receipt Date" := "Expected Receipt Date";
                     RecLPurchLine1.Description := 'Timbre Fiscal';
                     RecLPurchLine1.VALIDATE("dysJob No.", 'STOCK');
                     RecLPurchLine1.VALIDATE(Quantity, 1);
                     RecLPurchLine1."Qty. to Receive" := 1;
                     RecLPurchLine1."N° Dossier" := "N° Dossier";
                     RecLPurchLine1."Request No." := RecLPurchLine."Request No.";
                     RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";

                     RecLPurchLine1."Allow Invoice Disc." := FALSE;
                     RecLPurchLine1.VALIDATE("Direct Unit Cost", RecLVendorPostingGroup."Stamp fiscal Amout");
                     RecLPurchLine1."VAT %" := 0;
                     RecLPurchLine1.Amount := RecLVendorPostingGroup."Stamp fiscal Amout";
                     RecLPurchLine1."Amount Including VAT" := RecLVendorPostingGroup."Stamp fiscal Amout";
                     RecLPurchLine1."Outstanding Amount" := RecLVendorPostingGroup."Stamp fiscal Amout";
                     RecLPurchLine1."Buy-from Vendor No." := "Buy-from Vendor No.";
                     RecLPurchLine1."Outstanding Amount (LCY)" := RecLVendorPostingGroup."Stamp fiscal Amout";
                     RecLPurchLine1."VAT Base Amount" := RecLVendorPostingGroup."Stamp fiscal Amout";
                     RecLPurchLine1."VAT Prod. Posting Group" := "RecLG/LEntry"."VAT Prod. Posting Group";
                     RecLPurchLine1."Gen. Prod. Posting Group" := "RecLG/LEntry"."Gen. Prod. Posting Group";
                     RecLPurchLine1."VAT Bus. Posting Group" := "VAT Bus. Posting Group";
                     RecLPurchLine1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                     IF RecLVendorPostingGroup."Stamp fiscal Amout" <> 0 THEN RecLPurchLine1.INSERT;
                     RecLDocumentDimension.RESET;
                     // RecLDocumentDimension.SETFILTER("Table ID",'38');
                     // RecLDocumentDimension.SETRANGE("Document Type","Document Type");
                     // RecLDocumentDimension.SETFILTER("Document No.","No.");
                     // RecLDocumentDimension.SETRANGE("Line No.",0);
                     // IF  RecLDocumentDimension.FIND('-') THEN
                     //   REPEAT
                     //     RecLTMPDocumentDimension:=RecLDocumentDimension;
                     //     RecLTMPDocumentDimension."Table ID":=39;
                     //     RecLTMPDocumentDimension."Line No.":=VarILineNo;
                     //     IF RecLVendorPostingGroup."Stamp fiscal Amout" <> 0 THEN RecLTMPDocumentDimension.INSERT;
                     //     UNTIL RecLDocumentDimension.NEXT=0;
                 END;
             END;
         END;
     END;
     //END;

     PROCEDURE ChangerStatutFacture(ParaNumFact: Code[20]; ParaStatut: Integer);
     VAR
         PurchInvHeader: Record "Purch. Inv. Header";
         TextL001: Label 'Confirmer Cette Action ??';
     BEGIN
         //IF NOT CONFIRM(TextL001) THEN EXIT;
         IF PurchInvHeader.GET(ParaNumFact) THEN BEGIN
             PurchInvHeader."Statut Facture" := ParaStatut;
             IF ParaStatut = 1 THEN
                 IF PurchInvHeader."Date Préparation Payement" = 0D
                   THEN
                     PurchInvHeader."Date Préparation Payement" := TODAY;
             IF ParaStatut = 2 THEN
                 IF PurchInvHeader."Date En Cours Signature" = 0D THEN
                     PurchInvHeader."Date En Cours Signature" := TODAY;

             IF ParaStatut = 3 THEN
                 IF PurchInvHeader."Date Signature" = 0D THEN
                     PurchInvHeader."Date Signature" := TODAY;
             IF ParaStatut = 4 THEN
                 IF PurchInvHeader."Date Paiement" = 0D THEN
                     PurchInvHeader."Date Paiement" := TODAY;
             PurchInvHeader.MODIFY;
         END;
     END;*/

    PROCEDURE Lettrage(ParaIdLettrage: Code[20]; ParaMontantLettrage: Decimal);
    VAR
        LocalVendorLedgerEntry: Record "Vendor Ledger Entry";
        MontantRestant: Decimal;
        LocalListeFacturesLettrage: Record "Liste Factures Lettrage";
    BEGIN
        MontantRestant := ParaMontantLettrage;
        LocalListeFacturesLettrage.SETRANGE("ID Lettrage", ParaIdLettrage);
        IF LocalListeFacturesLettrage.FINDFIRST THEN
            REPEAT
                IF LocalVendorLedgerEntry.GET(LocalListeFacturesLettrage.Sequence) THEN BEGIN
                    LocalVendorLedgerEntry.CALCFIELDS("Remaining Amount");
                    IF (ABS(LocalVendorLedgerEntry."Remaining Amount") > 0) AND (MontantRestant > 0) THEN BEGIN
                        LocalVendorLedgerEntry."Applies-to ID" := ParaIdLettrage;
                        IF ABS(LocalVendorLedgerEntry."Remaining Amount") >= MontantRestant THEN BEGIN
                            IF LocalVendorLedgerEntry."Remaining Amount" < 0 THEN
                                LocalVendorLedgerEntry."Amount to Apply" := -MontantRestant;
                            IF LocalVendorLedgerEntry."Remaining Amount" > 0 THEN
                                LocalVendorLedgerEntry."Amount to Apply" := MontantRestant;

                            MontantRestant := 0;
                        END
                        ELSE BEGIN
                            LocalVendorLedgerEntry."Amount to Apply" := LocalVendorLedgerEntry."Remaining Amount";
                            MontantRestant := MontantRestant - ABS(LocalVendorLedgerEntry."Remaining Amount");

                        END;
                        LocalVendorLedgerEntry.MODIFY;
                    END;
                END;
            UNTIL LocalListeFacturesLettrage.NEXT = 0;
    END;


    PROCEDURE MajEcritureArticleProd();
    VAR
        LItemLedgerEntry: Record 32;
    BEGIN
        LItemLedgerEntry.SETRANGE(Production, TRUE);
        LItemLedgerEntry.MODIFYALL("Entry Type", LItemLedgerEntry."Entry Type"::Output);
    END;


    PROCEDURE MajEcritureArticle(VAR GNumSequence: Integer);
    VAR
        LItemLedgerEntry: Record "Item Ledger Entry";
    BEGIN
        LItemLedgerEntry.SETRANGE(Synchronise, FALSE);
        // RB SORO 05/03/2015
        LItemLedgerEntry.MODIFYALL("Num Sequence Synchro", GNumSequence);
        // RB SORO 05/03/2015
        LItemLedgerEntry.MODIFYALL(Synchronise, TRUE);
    END;

    PROCEDURE MajEnteteReception(VAR GNumSequence: Integer);
    VAR
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    BEGIN
        PurchRcptHeader.SETRANGE(Synchronise, FALSE);
        // RB SORO 05/03/2015
        PurchRcptHeader.MODIFYALL("Num Sequence Syncro", GNumSequence);
        // RB SORO 05/03/2015
        PurchRcptHeader.MODIFYALL(Synchronise, TRUE);
    END;

    PROCEDURE MajLigneReception(VAR GNumSequence: Integer);
    VAR
        PurchRcptLine: Record "Purch. Rcpt. Line";
    BEGIN
        PurchRcptLine.SETRANGE(Synchronise, FALSE);
        // RB SORO 05/03/2015
        PurchRcptLine.MODIFYALL(PurchRcptLine."Num Sequence Syncro", GNumSequence);
        // RB SORO 05/03/2015
        PurchRcptLine.MODIFYALL(Synchronise, TRUE);
    END;

    PROCEDURE InsertEnteteReception(VAR ParaEnteteReception: Record "Purch. Rcpt. Header");
    BEGIN
        IF NOT ParaEnteteReception.INSERT THEN;
    END;

    PROCEDURE InsertLigneReception(VAR ParaLigneReception: Record "Purch. Rcpt. Line");
    BEGIN
        IF NOT ParaLigneReception.INSERT THEN;
    END;

    /*  PROCEDURE CalcFodec(Rec: Record "Purchase Header");
      VAR
          ReclPurchHeader: Record "Purchase Header";
          RecLPurchLine: Record "Purchase Line";
          RecLVendorPostingGroup: Record "Vendor Posting Group";
          VarILineNo: Integer;
          "RecLG/LAccount": Record "G/L Account";
          RecLPurchLine1: Record "Purchase Line";
          VarDMontantFodec: Decimal;
          RecLPurchLineVat: Record "Purchase Line";
          VarCAccountFodec: ARRAY[10] OF Code[20];
          VarII: Integer;
          VarI: Integer;
          VarBFoundFodec: Boolean;
          VarDialogWindow: Dialog;
          RecLPurchLine2: Record "Purchase Line";
          VarDMontantFodec1: Decimal;
          RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
          RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
          RecLInventoryPostingGroup: Record "Inventory Posting Group";
      BEGIN
          //>>DSFT-TRIUM 01/06/09
          ReclPurchHeader := Rec;
          // MAJ Ligne
          RecLPurchLine.RESET;
          RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
          RecLPurchLine.SETRANGE("Document No.", Rec."No.");
          RecLPurchLine.SETRANGE("No.", 'FODEC');
          RecLPurchLine.DELETEALL;
          //

          // Param‚tre Taxe Fournisseur
          IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;

          // RB SORO 07/04/2014
          IF ReclPurchHeader."Appliquer Fodec" THEN
          //IF RecLVendorPostingGroup."Apply Fodec"  THEN
          BEGIN
              IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
              RecLPurchLine.RESET;
              RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
              RecLPurchLine.SETRANGE("Document No.", Rec."No.");
              // HS REPLACED BY THE ABOVE    RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
              RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
              RecLPurchLine.SETRANGE("No.", 'FODEC');
              IF RecLPurchLine.FINDFIRST THEN
                  REPEAT
                      // RecLDocumentDimension.RESET;
                      // RecLDocumentDimension.SETFILTER("Table ID",'39');
                      // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                      // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                      // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                      // RecLDocumentDimension.DELETEALL;
                      RecLPurchLine.DELETE;
                  UNTIL RecLPurchLine.NEXT = 0;
          END;

          RecLPurchLine.RESET;
          // RB SORO 07/04/2014
          IF ReclPurchHeader."Appliquer Fodec" THEN
              //IF RecLVendorPostingGroup."Apply Fodec"  THEN
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
                                  IF RecLPurchLine."Qty. to Invoice" > RecLPurchLine."Qty. Rcd. Not Invoiced" THEN
                                      VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                                      (RecLPurchLine."Qty. Rcd. Not Invoiced" / RecLPurchLine.Quantity)
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
                              RecLPurchLine1.INIT;
                              RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                              RecLPurchLine1.VALIDATE("Document No.", "No.");
                              RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 50;
                              RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                              RecLPurchLine1.Type := RecLPurchLine.Type::Item;
                              RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                              RecLPurchLine1.VALIDATE("No.", 'FODEC');// RecLVendorPostingGroup."Fodec Account");
                              RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                              RecLPurchLine1."VAT Prod. Posting Group" := RecLPurchLine."VAT Prod. Posting Group";
                              RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                              RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                              IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                  RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                  RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                              END;
                              RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                              RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                              RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                              RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                              RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                              RecLPurchLine1."Allow Invoice Disc." := FALSE;
                              RecLPurchLine1.Description := 'FODEC';
                              RecLPurchLine1.VALIDATE("dysJob No.", 'STOCK');
                              RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFodec);
                              RecLPurchLine1.VALIDATE("Line Discount %", 0);
                              RecLPurchLine1."Allow Invoice Disc." := FALSE;
                              RecLPurchLine1."N° Dossier" := "N° Dossier";
                              RecLPurchLine1."Request No." := RecLPurchLine."Request No.";

                              RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                              RecLPurchLine1.VALIDATE(Quantity, 1);
                              RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFodec);
                              RecLPurchLine1.VALIDATE("Line Discount %", 0);
                              RecLPurchLine1."Qty. to Receive" := 1;
                              //GL2024     RecLPurchLine1."Unit of Measure Code" := '';
                              RecLPurchLine1."Ligne Fodec" := TRUE;
                              IF VarDMontantFodec <> 0 THEN RecLPurchLine1.INSERT;
                              // RecLDocumentDimension.RESET;
                              // RecLDocumentDimension.SETFILTER("Table ID",'38');
                              // RecLDocumentDimension.SETRANGE("Document Type","Document Type");
                              // RecLDocumentDimension.SETFILTER("Document No.","No.");
                              // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                              //    IF  RecLDocumentDimension.FINDFIRST THEN
                              //       REPEAT
                              //         RecLTMPDocumentDimension:=RecLDocumentDimension;
                              //         RecLTMPDocumentDimension."Table ID":=39;
                              //         RecLTMPDocumentDimension."Line No.":=RecLPurchLine."Line No."+50;
                              //         IF VarDMontantFodec <> 0 THEN RecLTMPDocumentDimension.INSERT;
                              //      UNTIL RecLDocumentDimension.NEXT=0;
                          END;
                      UNTIL RecLPurchLine.NEXT = 0;
              END;
      END;*/

    /*   PROCEDURE CalcRedevance(Rec: Record "Purchase Header");
       VAR
           ReclPurchHeader: Record "Purchase Header";
           RecLPurchLine: Record "Purchase Line";
           RecLVendorPostingGroup: Record "Vendor Posting Group";
           RecLItem: Record item;
           VarILineNo: Integer;
           "RecLG/LAccount": Record "G/L Account";
           RecLPurchLine1: Record "Purchase Line";
           VarDMontantRedevance: Decimal;
           RecLPurchLineVat: Record "Purchase Line";
           VarCAccountFodec: ARRAY[10] OF Code[20];
           VarII: Integer;
           VarIJ: Integer;
           VarBFoundFodec: Boolean;
           VarDialogWindow: Dialog;
           RecLPurchLine2: Record "Purchase Line";
           VarDMontantFodec1: Decimal;
           RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLInventoryPostingGroup: Record "Inventory Posting Group";
       BEGIN
           //>>DSFT-TRIUM 01/06/09
           VarDMontantRedevance := 0;
           ReclPurchHeader := Rec;
           // Param‚tre Taxe Fournisseur

           IF 1 = 1 THEN BEGIN
               IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
               RecLPurchLine.RESET;
               RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
               RecLPurchLine.SETRANGE("Document No.", Rec."No.");
               // HS REPLACED BY THE ABOVE    RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
               RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
               RecLPurchLine.SETRANGE("No.", 'REDEVANCE');
               IF RecLPurchLine.FINDFIRST THEN
                   REPEAT
                       // RecLDocumentDimension.RESET;
                       // RecLDocumentDimension.SETFILTER("Table ID",'39');
                       // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                       // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                       // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                       // RecLDocumentDimension.DELETEALL;
                       RecLPurchLine.DELETE;
                   UNTIL RecLPurchLine.NEXT = 0;
           END;

           RecLPurchLine.RESET;
           IF 1 = 1 THEN
               WITH ReclPurchHeader DO BEGIN
                   RecLPurchLine.RESET;
                   RecLPurchLine.SETRANGE("Document Type", "Document Type");
                   RecLPurchLine.SETRANGE("Document No.", "No.");
                   RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                   RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');
                   IF RecLPurchLine.FINDFIRST THEN
                       REPEAT
                           IF RecLItem.GET(RecLPurchLine."No.") THEN
                               IF RecLItem."Appliquer Redevance" THEN BEGIN
                                   VarDMontantRedevance := RecLPurchLine."Qty. to Invoice" * RecLItem."Montant Redevance";


                                   IF VarDMontantRedevance <> 0 THEN BEGIN
                                       RecLPurchLine1.INIT;
                                       RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                                       RecLPurchLine1.VALIDATE("Document No.", "No.");
                                       RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 60;
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                                       //  RecLPurchLine1.Type := RecLPurchLine.Type::"Charge (Item)";
                                       RecLPurchLine1.Type := RecLPurchLine.Type::Item;
                                       RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                                       RecLPurchLine1.VALIDATE("No.", 'REDEVANCE');
                                       RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                                       RecLPurchLine1."VAT Prod. Posting Group" := 'STVA';
                                       RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                                       RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                                       IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                           RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                           RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                                       END;
                                       RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                                       RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                                       RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                                       RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;

                                       RecLPurchLine1.Description := 'REDEVANCE';
                                       RecLPurchLine1.VALIDATE("dysJob No.", 'STOCK');
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantRedevance);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                       RecLPurchLine1."N° Dossier" := "N° Dossier";
                                       RecLPurchLine1."Request No." := RecLPurchLine."Request No.";
                                       RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                                       RecLPurchLine1.VALIDATE(Quantity, 1);
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantRedevance);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Qty. to Receive" := 1;
                                       //GL2024    RecLPurchLine1."Unit of Measure Code" := '';
                                       RecLPurchLine1."Ligne Fodec" := TRUE;
                                       IF VarDMontantRedevance <> 0 THEN RecLPurchLine1.INSERT;
                                   END;
                               END;
                       UNTIL RecLPurchLine.NEXT = 0;
               END;
       END;
   */
    /*  PROCEDURE CalcFondSoutient(Rec: Record "Purchase Header");
      VAR
          ReclPurchHeader: Record "Purchase Header";
          RecLPurchLine: Record "Purchase Line";
          RecLVendorPostingGroup: Record "Vendor Posting Group";
          RecLItem: Record item;
          VarILineNo: Integer;
          "RecLG/LAccount": Record "G/L Account";
          RecLPurchLine1: Record "Purchase Line";
          VarDMontantRedevance: Decimal;
          RecLPurchLineVat: Record "Purchase Line";
          VarCAccountFodec: ARRAY[10] OF Code[20];
          VarII: Integer;
          VarIJ: Integer;
          VarBFoundFodec: Boolean;
          VarDialogWindow: Dialog;
          RecLPurchLine2: Record "Purchase Line";
          VarDMontantFodec1: Decimal;
          RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
          RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
          RecLInventoryPostingGroup: Record "Inventory Posting Group";
      BEGIN
          //>>DSFT-TRIUM 01/06/09
          ReclPurchHeader := Rec;
          VarDMontantFS := 0;
          // Param‚tre Taxe Fournisseur

          IF 1 = 1 THEN BEGIN
              IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
              RecLPurchLine.RESET;
              RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
              RecLPurchLine.SETRANGE("Document No.", Rec."No.");
              // HS REPLACED BY THE ABOVE    RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
              RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
              RecLPurchLine.SETRANGE("No.", 'FS');
              IF RecLPurchLine.FINDFIRST THEN
                  REPEAT
                      // RecLDocumentDimension.RESET;
                      // RecLDocumentDimension.SETFILTER("Table ID",'39');
                      // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                      // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                      // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                      // RecLDocumentDimension.DELETEALL;
                      RecLPurchLine.DELETE;
                  UNTIL RecLPurchLine.NEXT = 0;
          END;

          RecLPurchLine.RESET;
          IF 1 = 1 THEN
              WITH ReclPurchHeader DO BEGIN
                  RecLPurchLine.RESET;
                  RecLPurchLine.SETRANGE("Document Type", "Document Type");
                  RecLPurchLine.SETRANGE("Document No.", "No.");
                  RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                  RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');
                  IF RecLPurchLine.FINDFIRST THEN
                      REPEAT
                          IF RecLItem.GET(RecLPurchLine."No.") THEN
                              IF RecLItem."Appliquer FS" THEN BEGIN
                                  VarDMontantFS := RecLPurchLine."Qty. to Invoice" * RecLItem."Montant FS";


                                  IF VarDMontantFS <> 0 THEN BEGIN
                                      RecLPurchLine1.INIT;
                                      RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                                      RecLPurchLine1.VALIDATE("Document No.", "No.");
                                      RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 70;
                                      RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                                      //   RecLPurchLine1.Type := RecLPurchLine.Type::"Charge (Item)";
                                      RecLPurchLine1.Type := RecLPurchLine.Type::Item;
                                      RecLPurchLine1."Type article" := RecLPurchLine1."Type article"::Service;
                                      RecLPurchLine1.VALIDATE("No.", 'FS');
                                      RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                                      RecLPurchLine1."VAT Prod. Posting Group" := 'STVA';
                                      RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                                      RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                                      IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                          RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                          RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                                      END;
                                      RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                                      RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                                      RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                                      RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                                      RecLPurchLine1."Allow Invoice Disc." := FALSE;

                                      RecLPurchLine1.Description := 'FOND SOUTIENT';
                                      RecLPurchLine1.VALIDATE("dysJob No.", 'STOCK');
                                      RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFS);
                                      RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                      RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                      RecLPurchLine1."N° Dossier" := "N° Dossier";
                                      RecLPurchLine1."Request No." := RecLPurchLine."Request No.";

                                      RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                                      RecLPurchLine1.VALIDATE(Quantity, 1);
                                      RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFS);
                                      RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                      RecLPurchLine1."Qty. to Receive" := 1;
                                      //GL2024   RecLPurchLine1."Unit of Measure Code" := '';
                                      RecLPurchLine1."Ligne Fodec" := TRUE;
                                      IF VarDMontantFS <> 0 THEN RecLPurchLine1.INSERT;
                                  END;
                              END;
                      UNTIL RecLPurchLine.NEXT = 0;
              END;
      END;
  */
    /*GL2024   PROCEDURE CalcFodec(Rec: Record "Purchase Header");
       VAR
           ReclPurchHeader: Record "Purchase Header";
           RecLPurchLine: Record "Purchase Line";
           RecLVendorPostingGroup: Record "Vendor Posting Group";
           VarILineNo: Integer;
           "RecLG/LAccount": Record "G/L Account";
           RecLPurchLine1: Record "Purchase Line";
           VarDMontantFodec: Decimal;
           RecLPurchLineVat: Record "Purchase Line";
           VarCAccountFodec: ARRAY[10] OF Code[20];
           VarII: Integer;
           VarI: Integer;
           VarBFoundFodec: Boolean;
           VarDialogWindow: Dialog;
           RecLPurchLine2: Record "Purchase Line";
           VarDMontantFodec1: Decimal;
           RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLInventoryPostingGroup: Record "Inventory Posting Group";
       BEGIN
           //>>DSFT-TRIUM 01/06/09
           ReclPurchHeader := Rec;
           // MAJ Ligne
           RecLPurchLine.RESET;
           RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
           RecLPurchLine.SETRANGE("Document No.", Rec."No.");
           RecLPurchLine.SETRANGE("No.", 'FODEC');
           RecLPurchLine.DELETEALL;
           //

           // Param‚tre Taxe Fournisseur
           IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;

           // RB SORO 07/04/2014
           IF ReclPurchHeader."Appliquer Fodec" THEN
           //IF RecLVendorPostingGroup."Apply Fodec"  THEN
           BEGIN
               IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
               RecLPurchLine.RESET;
               RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
               RecLPurchLine.SETRANGE("Document No.", Rec."No.");
               RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
               RecLPurchLine.SETRANGE("No.", 'FODEC');
               IF RecLPurchLine.FINDFIRST THEN
                   REPEAT
                       // RecLDocumentDimension.RESET;
                       // RecLDocumentDimension.SETFILTER("Table ID",'39');
                       // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                       // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                       // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                       // RecLDocumentDimension.DELETEALL;
                       RecLPurchLine.DELETE;
                   UNTIL RecLPurchLine.NEXT = 0;
           END;

           RecLPurchLine.RESET;
           // RB SORO 07/04/2014
           IF ReclPurchHeader."Appliquer Fodec" THEN
               //IF RecLVendorPostingGroup."Apply Fodec"  THEN
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
                                   IF RecLPurchLine."Qty. to Invoice" > RecLPurchLine."Qty. Rcd. Not Invoiced" THEN
                                       VarDMontantFodec := (RecLPurchLine."Line Amount" - RecLPurchLine."Inv. Discount Amount") *
                                       (RecLPurchLine."Qty. Rcd. Not Invoiced" / RecLPurchLine.Quantity)
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
                               RecLPurchLine1.INIT;
                               RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                               RecLPurchLine1.VALIDATE("Document No.", "No.");
                               RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 50;
                               RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                               RecLPurchLine1.Type := RecLPurchLine.Type::"Charge (Item)";
                               RecLPurchLine1.VALIDATE("No.", 'FODEC');// RecLVendorPostingGroup."Fodec Account");
                               RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                               RecLPurchLine1."VAT Prod. Posting Group" := RecLPurchLine."VAT Prod. Posting Group";
                               RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                               RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                               IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                   RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                   RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                               END;
                               RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                               RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                               RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                               RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                               RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                               RecLPurchLine1."Allow Invoice Disc." := FALSE;
                               RecLPurchLine1.Description := 'FODEC';
                               RecLPurchLine1.VALIDATE("Job No.", 'STOCK');
                               RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFodec);
                               RecLPurchLine1.VALIDATE("Line Discount %", 0);
                               RecLPurchLine1."Allow Invoice Disc." := FALSE;
                               RecLPurchLine1."N° Dossier" := "N° Dossier";
                               RecLPurchLine1."Request No." := RecLPurchLine."Request No.";

                               RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                               RecLPurchLine1.VALIDATE(Quantity, 1);
                               RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFodec);
                               RecLPurchLine1.VALIDATE("Line Discount %", 0);
                               RecLPurchLine1."Qty. to Receive" := 1;
                               RecLPurchLine1."Unit of Measure Code" := '';
                               RecLPurchLine1."Ligne Fodec" := TRUE;
                               IF VarDMontantFodec <> 0 THEN RecLPurchLine1.INSERT;
                               // RecLDocumentDimension.RESET;
                               // RecLDocumentDimension.SETFILTER("Table ID",'38');
                               // RecLDocumentDimension.SETRANGE("Document Type","Document Type");
                               // RecLDocumentDimension.SETFILTER("Document No.","No.");
                               // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                               //    IF  RecLDocumentDimension.FINDFIRST THEN
                               //       REPEAT
                               //         RecLTMPDocumentDimension:=RecLDocumentDimension;
                               //         RecLTMPDocumentDimension."Table ID":=39;
                               //         RecLTMPDocumentDimension."Line No.":=RecLPurchLine."Line No."+50;
                               //         IF VarDMontantFodec <> 0 THEN RecLTMPDocumentDimension.INSERT;
                               //      UNTIL RecLDocumentDimension.NEXT=0;
                           END;
                       UNTIL RecLPurchLine.NEXT = 0;
               END;
       END;

       PROCEDURE CalcRedevance(Rec: Record "Purchase Header");
       VAR
           ReclPurchHeader: Record "Purchase Header";
           RecLPurchLine: Record "Purchase Line";
           RecLVendorPostingGroup: Record "Vendor Posting Group";
           RecLItem: Record item;
           VarILineNo: Integer;
           "RecLG/LAccount": Record "G/L Account";
           RecLPurchLine1: Record "Purchase Line";
           VarDMontantRedevance: Decimal;
           RecLPurchLineVat: Record "Purchase Line";
           VarCAccountFodec: ARRAY[10] OF Code[20];
           VarII: Integer;
           VarIJ: Integer;
           VarBFoundFodec: Boolean;
           VarDialogWindow: Dialog;
           RecLPurchLine2: Record "Purchase Line";
           VarDMontantFodec1: Decimal;
           RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLInventoryPostingGroup: Record "Inventory Posting Group";
       BEGIN
           //>>DSFT-TRIUM 01/06/09
           VarDMontantRedevance := 0;
           ReclPurchHeader := Rec;
           // Param‚tre Taxe Fournisseur

           IF 1 = 1 THEN BEGIN
               IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
               RecLPurchLine.RESET;
               RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
               RecLPurchLine.SETRANGE("Document No.", Rec."No.");
               RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
               RecLPurchLine.SETRANGE("No.", 'REDEVANCE');
               IF RecLPurchLine.FINDFIRST THEN
                   REPEAT
                       // RecLDocumentDimension.RESET;
                       // RecLDocumentDimension.SETFILTER("Table ID",'39');
                       // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                       // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                       // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                       // RecLDocumentDimension.DELETEALL;
                       RecLPurchLine.DELETE;
                   UNTIL RecLPurchLine.NEXT = 0;
           END;

           RecLPurchLine.RESET;
           IF 1 = 1 THEN
               WITH ReclPurchHeader DO BEGIN
                   RecLPurchLine.RESET;
                   RecLPurchLine.SETRANGE("Document Type", "Document Type");
                   RecLPurchLine.SETRANGE("Document No.", "No.");
                   RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                   RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');
                   IF RecLPurchLine.FINDFIRST THEN
                       REPEAT
                           IF RecLItem.GET(RecLPurchLine."No.") THEN
                               IF RecLItem."Appliquer Redevance" THEN BEGIN
                                   VarDMontantRedevance := RecLPurchLine."Qty. to Invoice" * RecLItem."Montant Redevance";


                                   IF VarDMontantRedevance <> 0 THEN BEGIN
                                       RecLPurchLine1.INIT;
                                       RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                                       RecLPurchLine1.VALIDATE("Document No.", "No.");
                                       RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 50;
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                                       RecLPurchLine1.Type := RecLPurchLine.Type::"Charge (Item)";
                                       RecLPurchLine1.VALIDATE("No.", 'REDEVANCE');
                                       RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                                       RecLPurchLine1."VAT Prod. Posting Group" := 'STVA';
                                       RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                                       RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                                       IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                           RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                           RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                                       END;
                                       RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                                       RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                                       RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                                       RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                       RecLPurchLine1.Description := 'REDEVANCE';
                                       RecLPurchLine1.VALIDATE("Job No.", 'STOCK');
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantRedevance);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                       RecLPurchLine1."N° Dossier" := "N° Dossier";
                                       RecLPurchLine1."Request No." := RecLPurchLine."Request No.";
                                       RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                                       RecLPurchLine1.VALIDATE(Quantity, 1);
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantRedevance);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Qty. to Receive" := 1;
                                       RecLPurchLine1."Unit of Measure Code" := '';
                                       RecLPurchLine1."Ligne Fodec" := TRUE;
                                       IF VarDMontantRedevance <> 0 THEN RecLPurchLine1.INSERT;
                                   END;
                               END;
                       UNTIL RecLPurchLine.NEXT = 0;
               END;
       END;

       PROCEDURE CalcFondSoutient(Rec: Record "Purchase Header");
       VAR
           ReclPurchHeader: Record "Purchase Header";
           RecLPurchLine: Record "Purchase Line";
           RecLVendorPostingGroup: Record "Vendor Posting Group";
           RecLItem: Record item;
           VarILineNo: Integer;
           "RecLG/LAccount": Record "G/L Account";
           RecLPurchLine1: Record "Purchase Line";
           VarDMontantRedevance: Decimal;
           RecLPurchLineVat: Record "Purchase Line";
           VarCAccountFodec: ARRAY[10] OF Code[20];
           VarII: Integer;
           VarIJ: Integer;
           VarBFoundFodec: Boolean;
           VarDialogWindow: Dialog;
           RecLPurchLine2: Record "Purchase Line";
           VarDMontantFodec1: Decimal;
           RecLDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLTMPDocumentDimension: Record "Gen. Jnl. Dim. Filter";
           RecLInventoryPostingGroup: Record "Inventory Posting Group";
       BEGIN
           //>>DSFT-TRIUM 01/06/09
           ReclPurchHeader := Rec;
           VarDMontantFS := 0;
           // Param‚tre Taxe Fournisseur

           IF 1 = 1 THEN BEGIN
               IF RecLVendorPostingGroup.GET(ReclPurchHeader."Vendor Posting Group") THEN;
               RecLPurchLine.RESET;
               RecLPurchLine.SETRANGE("Document Type", Rec."Document Type");
               RecLPurchLine.SETRANGE("Document No.", Rec."No.");
               RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::"Charge (Item)");
               RecLPurchLine.SETRANGE("No.", 'FS');
               IF RecLPurchLine.FINDFIRST THEN
                   REPEAT
                       // RecLDocumentDimension.RESET;
                       // RecLDocumentDimension.SETFILTER("Table ID",'39');
                       // RecLDocumentDimension.SETRANGE("Document Type",Rec."Document Type");
                       // RecLDocumentDimension.SETFILTER("Document No.",Rec."No.");
                       // RecLDocumentDimension.SETRANGE("Line No.",RecLPurchLine."Line No.");
                       // RecLDocumentDimension.DELETEALL;
                       RecLPurchLine.DELETE;
                   UNTIL RecLPurchLine.NEXT = 0;
           END;

           RecLPurchLine.RESET;
           IF 1 = 1 THEN
               WITH ReclPurchHeader DO BEGIN
                   RecLPurchLine.RESET;
                   RecLPurchLine.SETRANGE("Document Type", "Document Type");
                   RecLPurchLine.SETRANGE("Document No.", "No.");
                   RecLPurchLine.SETRANGE(Type, RecLPurchLine.Type::Item);
                   RecLPurchLine.SETFILTER("Qty. to Invoice", '>0');
                   IF RecLPurchLine.FINDFIRST THEN
                       REPEAT
                           IF RecLItem.GET(RecLPurchLine."No.") THEN
                               IF RecLItem."Appliquer FS" THEN BEGIN
                                   VarDMontantFS := RecLPurchLine."Qty. to Invoice" * RecLItem."Montant FS";


                                   IF VarDMontantFS <> 0 THEN BEGIN
                                       RecLPurchLine1.INIT;
                                       RecLPurchLine1.VALIDATE("Document Type", "Document Type");
                                       RecLPurchLine1.VALIDATE("Document No.", "No.");
                                       RecLPurchLine1."Line No." := RecLPurchLine."Line No." + 60;
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Buy-from Vendor No.", "Buy-from Vendor No.");
                                       RecLPurchLine1.Type := RecLPurchLine.Type::"Charge (Item)";
                                       RecLPurchLine1.VALIDATE("No.", 'FS');
                                       RecLPurchLine1."Gen. Prod. Posting Group" := RecLPurchLine."Gen. Prod. Posting Group";
                                       RecLPurchLine1."VAT Prod. Posting Group" := 'STVA';
                                       RecLPurchLine1."VAT Bus. Posting Group" := RecLPurchLine."VAT Bus. Posting Group";
                                       RecLPurchLine1."Gen. Bus. Posting Group" := RecLPurchLine."Gen. Bus. Posting Group";
                                       IF RecLPurchLine1.Type = RecLPurchLine1.Type::Item THEN BEGIN
                                           RecLPurchLine1.VALIDATE("Gen. Prod. Posting Group");
                                           RecLPurchLine1.VALIDATE("VAT Prod. Posting Group");
                                       END;
                                       RecLPurchLine1.VALIDATE("VAT Bus. Posting Group");
                                       RecLPurchLine1."Location Code" := RecLPurchLine."Location Code";
                                       RecLPurchLine1."Requested Receipt Date" := RecLPurchLine."Requested Receipt Date";
                                       RecLPurchLine1."FA Posting Date" := RecLPurchLine."FA Posting Date";
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                       RecLPurchLine1.Description := 'FOND SOUTIENT';
                                       RecLPurchLine1.VALIDATE("Job No.", 'STOCK');
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFS);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Allow Invoice Disc." := FALSE;
                                       RecLPurchLine1."N° Dossier" := "N° Dossier";
                                       RecLPurchLine1."Request No." := RecLPurchLine."Request No.";

                                       RecLPurchLine1."Request Line No." := RecLPurchLine."Request Line No.";
                                       RecLPurchLine1.VALIDATE(Quantity, 1);
                                       RecLPurchLine1.VALIDATE(RecLPurchLine1."Direct Unit Cost", VarDMontantFS);
                                       RecLPurchLine1.VALIDATE("Line Discount %", 0);
                                       RecLPurchLine1."Qty. to Receive" := 1;
                                       RecLPurchLine1."Unit of Measure Code" := '';
                                       RecLPurchLine1."Ligne Fodec" := TRUE;
                                       IF VarDMontantFS <> 0 THEN RecLPurchLine1.INSERT;
                                   END;
                               END;
                       UNTIL RecLPurchLine.NEXT = 0;
               END;
       END;

   */

    PROCEDURE ResetSyncroEcritureArticle(VAR GNumSequence: Integer);
    VAR
        LItemLedgerEntry: Record "Item Ledger Entry";
    BEGIN
        LItemLedgerEntry.SETRANGE("Num Sequence Synchro", GNumSequence);
        LItemLedgerEntry.MODIFYALL(Synchronise, FALSE);
        LItemLedgerEntry.MODIFYALL("Num Sequence Synchro", 0);
    END;

    PROCEDURE ResetSyncroEnteteReception(VAR GNumSequence: Integer);
    VAR
        LPurchRcptHeader: Record "Purch. Rcpt. Header";
    BEGIN
        LPurchRcptHeader.SETRANGE("Num Sequence Syncro", GNumSequence);
        LPurchRcptHeader.MODIFYALL(Synchronise, FALSE);
        LPurchRcptHeader.MODIFYALL("Num Sequence Syncro", 0);
    END;

    PROCEDURE ResetSyncroLigneReception(VAR GNumSequence: Integer);
    VAR
        LPurchRcptLine: Record "Purch. Rcpt. Line";
    BEGIN
        LPurchRcptLine.SETRANGE("Num Sequence Syncro", GNumSequence);
        LPurchRcptLine.MODIFYALL(Synchronise, FALSE);
        LPurchRcptLine.MODIFYALL("Num Sequence Syncro", 0);
    END;

    /*  PROCEDURE AutorisationMagasin(ParamCodeLocation: Code[10]);
      VAR
          RecAutorisationMagasin: Record "Autorisation Magasin";
          RecAutorisationMagasin2: Record "Autorisation Magasin";
      BEGIN
          RecAutorisationMagasin.RESET;
          RecAutorisationMagasin2.RESET;

          RecAutorisationMagasin.SETRANGE("Code Utilisateur", UPPERCASE(USERID));
          IF RecAutorisationMagasin.FINDFIRST THEN BEGIN
              IF RecAutorisationMagasin2.GET(UPPERCASE(USERID), ParamCodeLocation) THEN;
              IF NOT RecAutorisationMagasin2.FIND THEN
                  ERROR(Text061);

          END;
      END;*/

    PROCEDURE ChangerStatutFacture(ParaNumFact: Code[20]; ParaStatut: Integer);
    VAR
        PurchInvHeader: Record 122;
        TextL001: label 'Confirmer Cette Action ??';
    BEGIN
        //IF NOT CONFIRM(TextL001) THEN EXIT;
        IF PurchInvHeader.GET(ParaNumFact) THEN BEGIN
            PurchInvHeader."Statut Facture" := ParaStatut;
            PurchInvHeader.MODIFY;

        END;
    END;

    /*   PROCEDURE MiseAJourDecharge(ParaNumFacture: Code[20]; ParaSens: Boolean; ParaImprimer: Boolean; ParaNumDecharge: Code[20]);
       VAR
           LPurchInvHeader: Record "Purch. Inv. Header";
       BEGIN
           IF NOT ParaImprimer THEN BEGIN
               IF LPurchInvHeader.GET(ParaNumFacture) THEN BEGIN
                   LPurchInvHeader.Decharge := ParaSens;
                   LPurchInvHeader.MODIFY;
               END;
           END
           ELSE BEGIN
               IF LPurchInvHeader.GET(ParaNumFacture) THEN;
               LPurchInvHeader.Imprimer := ParaSens;
               IF ParaSens = FALSE THEN
                   LPurchInvHeader."N° Decharge" := ''
               ELSE BEGIN
                   LPurchInvHeader."N° Decharge" := ParaNumDecharge;
                   LPurchInvHeader."Date Decharge" := TODAY;
               END;

               LPurchInvHeader.MODIFY;
           END;
       END;*/

    /*  PROCEDURE MiseAJourAvoir(ParaNumFacture: Code[20]; ParaSens: Boolean; ParaImprimer: Boolean; ParaNumDecharge: Code[20]);
      VAR
          LPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
      BEGIN

          IF NOT ParaImprimer THEN BEGIN
              IF LPurchCrMemoHdr.GET(ParaNumFacture) THEN BEGIN
                  LPurchCrMemoHdr.Decharge := ParaSens;
                  LPurchCrMemoHdr.MODIFY;
              END;
          END
          ELSE BEGIN
              IF LPurchCrMemoHdr.GET(ParaNumFacture) THEN;
              LPurchCrMemoHdr.Imprimer := ParaSens;
              IF ParaSens = FALSE THEN
                  LPurchCrMemoHdr."N° Decharge" := ''
              ELSE BEGIN
                  LPurchCrMemoHdr."N° Decharge" := ParaNumDecharge;
                  LPurchCrMemoHdr."Date Decharge" := TODAY;
              END;

              LPurchCrMemoHdr.MODIFY;
          END;
      END;*/

    /*  PROCEDURE ValiderFactSimulee(VAR NumFact: Code[20]);
      VAR
          RecVendorLedgerEntry: Record "Vendor Ledger Entry";
          RecPurchInvHeader: Record "Purch. Inv. Header";
      BEGIN
          RecVendorLedgerEntry.RESET;
          RecVendorLedgerEntry.SETRANGE("Document No.", NumFact);
          IF RecVendorLedgerEntry.FINDFIRST THEN BEGIN
              RecVendorLedgerEntry.Simulation := FALSE;
              RecVendorLedgerEntry.MODIFY;
          END;

          RecPurchInvHeader.RESET;
          RecPurchInvHeader.GET(NumFact);
          RecPurchInvHeader.Simulation := FALSE;
          RecPurchInvHeader.MODIFY;
          MESSAGE(Text062, NumFact);
      END;*/

    PROCEDURE CreateFactAchat(ParamNumFact: Code[20]);
    VAR
        RecPurchInvHeaderDFS: Record "Purch. Inv. Header";
        RecPurchInvLineDFS: Record "Purch. Inv. Line";
        RecPurchaseHeaderCFS: Record "Purchase Header";
        RecPurchaseLineCFS: Record "Purchase Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecPurchasesSetup: Record "Purchases & Payables Setup";
        RecPurchaseHeaderStatus: Record "Purchase Header";
        TextL001: Label 'Facture Créer N° %1';
        TextL002: Label 'Confirmer La Restauration de la Facture ?';
        RecPurchRcptLine: Record "Purch. Rcpt. Line";
        RecPurchaseLine2: Record "Purchase Line";
        LPurchaseLine: Record "Purchase Line";
    BEGIN
        IF NOT CONFIRM(TextL002) THEN EXIT;
        RecPurchasesSetup.GET;
        IF RecPurchInvHeaderDFS.GET(ParamNumFact) THEN;
        RecPurchaseHeaderCFS.LOCKTABLE;
        //Supprimer Ligne Achat
        IF RecPurchInvHeaderDFS."Pre-Assigned No." <> '' THEN BEGIN
            LPurchaseLine.SETRANGE("Document Type", LPurchaseLine."Document Type"::Invoice);
            LPurchaseLine.SETRANGE("No.", RecPurchInvHeaderDFS."Pre-Assigned No.");
            // LPurchaseLine.DELETEALL;
        END;


        //Supprimer Ligne Achat
        // Entete
        RecPurchaseHeaderCFS.INIT;
        RecPurchaseHeaderCFS.TRANSFERFIELDS(RecPurchInvHeaderDFS);
        RecPurchaseHeaderCFS."Document Type" := RecPurchaseLineCFS."Document Type"::Invoice;
        RecPurchaseHeaderCFS."No." := RecPurchInvHeaderDFS."Pre-Assigned No.";
        RecPurchaseHeaderCFS."Posting No." := RecPurchInvHeaderDFS."No.";
        RecPurchaseHeaderCFS."Posting No. Series" := 'A-FACT+';
        RecPurchaseHeaderCFS."Receiving No. Series" := 'A-RCPT';
        RecPurchaseHeaderCFS.Simulation := FALSE;
        RecPurchaseHeaderCFS.INSERT;
        MESSAGE(TextL001, RecPurchaseHeaderCFS."No.");
        // Entete

        RecPurchInvLineDFS.SETRANGE("Document No.", ParamNumFact);
        RecPurchaseLineCFS.LOCKTABLE;
        RecPurchaseLineCFS.INIT;

        // Ligne
        IF RecPurchInvLineDFS.FINDFIRST THEN
            REPEAT
                RecPurchaseLineCFS.TRANSFERFIELDS(RecPurchInvLineDFS);
                RecPurchaseLineCFS."Document Type" := RecPurchaseLineCFS."Document Type"::Invoice;
                RecPurchaseLineCFS."Receipt No." := RecPurchInvLineDFS."N° Bon Reception";
                RecPurchaseLineCFS."Qty. to Invoice" := RecPurchInvLineDFS.Quantity;
                RecPurchaseLineCFS."Qty. to Invoice (Base)" := RecPurchInvLineDFS.Quantity;
                RecPurchaseLineCFS."Qty. to Receive" := RecPurchInvLineDFS.Quantity;
                RecPurchaseLineCFS."Qty. to Receive (Base)" := RecPurchInvLineDFS.Quantity;
                RecPurchaseLineCFS."Receipt Line No." := RecPurchInvLineDFS."N° Ligne Bon Reception";
                IF RecPurchRcptLine.GET(RecPurchInvLineDFS."N° Bon Reception", RecPurchInvLineDFS."N° Ligne Bon Reception") THEN BEGIN
                    RecPurchRcptLine."Qty. Rcd. Not Invoiced" := RecPurchRcptLine."Qty. Rcd. Not Invoiced" + RecPurchInvLineDFS.Quantity;
                    RecPurchRcptLine."Quantity Invoiced" := RecPurchRcptLine."Quantity Invoiced" - RecPurchInvLineDFS.Quantity;
                    RecPurchRcptLine."Qty. Invoiced (Base)" := RecPurchRcptLine."Qty. Invoiced (Base)" - RecPurchInvLineDFS.Quantity;
                    RecPurchRcptLine.MODIFY;
                    IF RecPurchaseLine2.GET(RecPurchaseLine2."Document Type"::Order, RecPurchRcptLine."Order No.",
                                            RecPurchRcptLine."Order Line No.") THEN BEGIN
                        RecPurchaseLine2."Qty. Rcd. Not Invoiced" := RecPurchaseLine2."Qty. Rcd. Not Invoiced" + RecPurchInvLineDFS.Quantity;
                        RecPurchaseLine2."Qty. Rcd. Not Invoiced (Base)" := RecPurchaseLine2."Qty. Rcd. Not Invoiced (Base)" +
                                                                          +RecPurchInvLineDFS.Quantity;
                        RecPurchaseLine2."Quantity Invoiced" := RecPurchaseLine2."Quantity Invoiced" - RecPurchInvLineDFS.Quantity;
                        RecPurchaseLine2."Qty. Invoiced (Base)" := RecPurchaseLine2."Qty. Invoiced (Base)" - RecPurchInvLineDFS.Quantity;

                        RecPurchaseLine2.MODIFY;
                    END;
                END;
                IF RecPurchaseLineCFS.INSERT THEN;
            UNTIL RecPurchInvLineDFS.NEXT = 0;

        // Ligne
        IF RecPurchaseHeaderStatus.GET(RecPurchaseHeaderCFS."Document Type", RecPurchaseHeaderCFS."No.") THEN;
        RecPurchaseHeaderStatus.Status := RecPurchaseHeaderStatus.Status::"Simulation Annuler";
        RecPurchaseHeaderStatus.MODIFY;
    END;

    PROCEDURE DeleteFactAchat(VAR ParamNumFAct: Code[20]);
    VAR
        DeletePurchInvHeader: Record "Purch. Inv. Header";
        DeletePurchInvLine: Record "Purch. Inv. Line";
        DeleteGLEntry: Record "G/L Entry";
        DeleteVATEntry: Record "VAT Entry";
        DeleteVendorLedgerEntry: Record "Vendor Ledger Entry";
        DeleteDettVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        DeleteJobLedgerEntry: Record "Job Ledger Entry";
    BEGIN
        // Entet Facture Achat
        DeletePurchInvHeader.RESET;
        DeletePurchInvHeader.SETCURRENTKEY("No.");
        DeletePurchInvHeader.SETFILTER("No.", ParamNumFAct);
        DeletePurchInvHeader.DELETEALL;
        // Ligne Facture Achat
        DeletePurchInvLine.RESET;
        DeletePurchInvLine.SETFILTER("Document No.", ParamNumFAct);
        DeletePurchInvLine.DELETEALL;
        // Ecriture Comptable  Facture AcHAT
        DeleteGLEntry.RESET;
        DeleteGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        DeleteGLEntry.SETFILTER("Document No.", ParamNumFAct);
        DeleteGLEntry.DELETEALL;
        // Ecriture TVA Facture Achat
        DeleteVATEntry.RESET;
        DeleteVATEntry.SETCURRENTKEY("Document No.", "Posting Date");
        DeleteVATEntry.SETFILTER("Document No.", ParamNumFAct);
        DeleteVATEntry.DELETEALL;
        // Ecriture Fournisseur  Facture Achat
        DeleteVendorLedgerEntry.RESET;
        DeleteVendorLedgerEntry.SETCURRENTKEY("Document No.");
        DeleteVendorLedgerEntry.SETFILTER("Document No.", ParamNumFAct);
        DeleteVendorLedgerEntry.DELETEALL;
        // Ecriture Fournisseur Dettaill‚e  Facture Achat
        DeleteDettVendorLedgerEntry.RESET;
        DeleteDettVendorLedgerEntry.SETCURRENTKEY("Document No.");
        DeleteDettVendorLedgerEntry.SETFILTER("Document No.", ParamNumFAct);
        DeleteDettVendorLedgerEntry.DELETEALL;
        // Ecriture Affaire  Facture Achat
        DeleteJobLedgerEntry.RESET;
        DeleteJobLedgerEntry.SETFILTER("Document No.", ParamNumFAct);
        DeleteJobLedgerEntry.DELETEALL;
    END;

    /* PROCEDURE MiseAJourEcritureComptable(ParaNumFacture: Integer; ParaSens: Boolean; ParaImprimer: Boolean; ParaNumDecharge: Code[20]);
     VAR
         VendorLedgerEntry: Record "Vendor Ledger Entry";
     BEGIN

         IF NOT ParaImprimer THEN BEGIN
             IF VendorLedgerEntry.GET(ParaNumFacture) THEN BEGIN
                 VendorLedgerEntry.Boolean := ParaSens;
                 VendorLedgerEntry.MODIFY;
             END;
         END
         ELSE BEGIN
             IF VendorLedgerEntry.GET(ParaNumFacture) THEN;
             VendorLedgerEntry.Boolean := ParaSens;
             //IF ParaSens=FALSE THEN LPurchInvHeader."Nø Decharge":=''
             //ELSE
             ////  BEGIN
             //    LPurchInvHeader."Nø Decharge":=ParaNumDecharge;
             //    LPurchInvHeader."Date Decharge":=TODAY;
             // END;

             VendorLedgerEntry.MODIFY;
         END;
     END;*/

    /* PROCEDURE AnnulerSimulation(ParaNumFacture: Code[20]; ParaSimler: Boolean);
     VAR
         LPurchInvHeader: Record "Purch. Inv. Header";
         LVendorLedgerEntry: Record "Vendor Ledger Entry";
     BEGIN
         IF LPurchInvHeader.GET(ParaNumFacture) THEN BEGIN
             LPurchInvHeader.Simulation := ParaSimler;
             LPurchInvHeader.MODIFY;
         END;
         LVendorLedgerEntry.SETRANGE("Document No.", ParaNumFacture);
         LVendorLedgerEntry.MODIFYALL(Simulation, ParaSimler);
     END;*/

    PROCEDURE MiseAJourEtatFacture(ParaNumFacture: Code[20]; ParaSens: Boolean);
    VAR
        LPurchInvHeader: Record "Purch. Inv. Header";
    BEGIN

        IF LPurchInvHeader.GET(ParaNumFacture) THEN;
        IF ParaSens = FALSE THEN
            LPurchInvHeader."En instance Controle Facture" := 0
        ELSE IF ParaSens = TRUE THEN LPurchInvHeader."En instance Controle Facture" := 1;
        LPurchInvHeader.MODIFY;
    END;
}