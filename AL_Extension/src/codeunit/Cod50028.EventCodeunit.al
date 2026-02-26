codeunit 50028 "Event_Codeunit"
{
    var
        ItemJnlLine2: Record "Item Journal Line";
        wWorkingDate: date;
        pItemDiscGroup: code[10];
        VendorNo: code[20];
        pVendDiscGroup: Code[20];

    //*************************************Codeunit 5777************************************************//
    //Table =37 ondelete
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterManualReleaseSalesDoc', '', true, true)]

    // local procedure OnAfterManualReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    // var

    //     //  CduSalesPost: Codeunit "Sales-Post";

    //     CduSalesPost: Codeunit SalesPostEvent;
    // begin
    //     //DYS a verifier
    //     //Currpage.SalesLines.page.wSetMarked(wMarked, ShowExtendedText);
    //     if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
    //         CduSalesPost.CalcBIC(SalesHeader);
    // end;
    //Create Job DIM

    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteJob(RunTrigger: Boolean; var Rec: Record "Job")
    var
    begin
        if RunTrigger then begin

            Rec.CreateJobDimension(2);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertJob(RunTrigger: Boolean; var Rec: Record "Job")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if RunTrigger then begin

            Rec.CreateJobDimension(0);
            rec.CreateLocationAndBin();

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJob(RunTrigger: Boolean; var Rec: Record "Job"; var xRec: Record "Job")
    begin
        if Rec.IsTemporary then
            exit;
        if RunTrigger then begin

            Rec.CreateJobDimension(0);
            rec.CreateLocationAndBin();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job", 'OnAfterRenameEvent', '', false, false)]
    local procedure OnAfterRenameJob(RunTrigger: Boolean; var Rec: Record "Job"; var xRec: Record "Job")
    begin
        if RunTrigger then begin
            // >>> VBS(CDE) Job Dimension
            Rec.CreateJobDimension(1);
        end;
    end;

    //Create Job DIM

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforePerformManualReleaseProcedure', '', true, true)]


    local procedure OnBeforePerformManualReleaseProcedure(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var

        //  CduSalesPost: Codeunit "Sales-Post";

        CduSalesPost: Codeunit SalesPostEvent;
    begin
        //DYS a verifier
        //Currpage.SalesLines.page.wSetMarked(wMarked, ShowExtendedText);
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
            CduSalesPost.CalcBIC(SalesHeader);
    end;

    [EventSubscriber(ObjectType::page, page::"Sales Invoice", 'OnBeforeStatisticsAction', '', true, true)]

    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    var

        //  CduSalesPost: Codeunit "Sales-Post";

        Text004: Label 'Veuillez Lancer La Facture';
        CduSalesPost: Codeunit SalesPostEvent;
    begin

        //    IF SalesHeader.Status = SalesHeader.status::Open THEN ERROR(Text004);
        CduSalesPost.CalcBIC(SalesHeader);
        // CduSalesPost.CalcBIC(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnCopyFromTempPurchLine', '', true, true)]
    local procedure OnValidateNoOnCopyFromTempPurchLine(var PurchLine: Record "Purchase Line"; TempPurchaseLine: Record "Purchase Line" temporary; xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchLine."Type article" := TempPurchaseLine."Type article";
    end;

    [EventSubscriber(ObjectType::Table, Database::"sales Line", 'OnValidateNoOnCopyFromTempSalesLine', '', true, true)]

    local procedure OnValidateNoOnCopyFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine."Type article" := TempSalesLine."Type article";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Validate Source Line", 'OnBeforeWhseLinesExist', '', true, true)]

    local procedure OnBeforeWhseLinesExist(SourceType: Integer; SourceSubType: Option; SourceNo: Code[20]; SourceLineNo: Integer; SourceSublineNo: Integer; SourceQty: Decimal; var TableCaptionValue: Text[100]; var Result: Boolean; var IsHandled: Boolean)
    var
        Salesheader: Record "Sales Header";
    begin
        if Salesheader.get(Salesheader."Document Type"::Quote, SourceNo) then
            IsHandled := true;
    end;
    //*************************************Codeunit 5403************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"AddOnIntegrManagement", 'OnBeforeCheckReceiptOrderStatus', '', true, true)]
    //Table 37
    local procedure OnBeforeCheckReceiptOrderStatus(SalesLine: Record "Sales Line"; var Checked: Boolean)
    begin
        //DEVIS
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            //DEVIS//
            Checked := true;
    end;


    //*************************************Codeunit 99000832************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line-Reserve", 'OnBeforeVerifyQuantity', '', true, true)]
    //Table 37
    local procedure OnBeforeVerifyQuantity(var NewSalesLine: Record "Sales Line"; var IsHandled: Boolean; var OldSalesLine: Record "Sales Line")
    begin

        IF NewSalesLine."Document Type" = NewSalesLine."Document Type"::Quote THEN
            //DEVIS//

            IsHandled := true
        else begin
            IF (NewSalesLine."Order Date" = 0D) AND ((NewSalesLine."Quote No." <> '') OR (NewSalesLine."Line Type" <> NewSalesLine."Line Type"::Other) OR (NOT NewSalesLine."Prepayment Line")) THEN
                NewSalesLine."Order Date" := WORKDATE;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line-Reserve", 'OnBeforeDeleteLine', '', true, true)]
    //Table  37 ondelete
    local procedure OnBeforeDeleteLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            //DEVIS//
            IsHandled := true;
    end;


    //*************************************Codeunit 5057************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendCont-Update", 'OnBeforeOnDelete', '', true, true)]
    local procedure OnBeforeOnDelete(Vendor: Record Vendor; var ContactBusinessRelation: Record "Contact Business Relation"; var IsHandled: Boolean)
    var
        lVendItemCatGroup: Record "Vendor Item Category Group";
        lDescriptionLine: Record "Description Line";
        ezfzf: Record "Véhicule";
    begin
        //+OFF+OFFRE
        lVendItemCatGroup.SETCURRENTKEY("Vendor No.", "Item Category Code", "Product Group Code");
        lVendItemCatGroup.SETRANGE("Vendor No.", Vendor."No.");
        IF NOT lVendItemCatGroup.ISEMPTY THEN
            lVendItemCatGroup.DELETEALL;
        //+OFF+OFFRE//

        //ACHATS
        lDescriptionLine.SETRANGE("Table ID", DATABASE::Vendor);
        lDescriptionLine.SETRANGE("Document No.", Vendor."No.");
        IF NOT lDescriptionLine.ISEMPTY THEN
            lDescriptionLine.DELETEALL;
        //ACHATS//
    end;


    //*************************************Codeunit 392************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reminder-Make", 'OnMakeReminderOnBeforeReminderHeaderModify', '', true, true)]
    local procedure OnMakeReminderOnBeforeReminderHeaderModify(var ReminderHeader: Record "Reminder Header"; var ReminderLine: Record "Reminder Line"; var NextLineNo: Integer; MaxReminderLevel: Integer)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+RELANCE
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            ReminderHeader.InsertLines;
        //+PMT+RELANCE//
    end;

    //*************************************Codeunit 375************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Entry Set Recon.-No.", 'OnBeforeApplyEntries', '', true, true)]
    local procedure OnBeforeApplyEntries(var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var Relation: Option "One-to-One","One-to-Many")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;

    begin
        //+RAP+RAPPRO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            BankAccReconciliationLine.Description := BankAccountLedgerEntry.Description;
        //+RAP+RAPPRO//
    end;

    //*************************************Codeunit 366 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Exchange Acc. G/L Journal Line", 'OnAfterOnRun', '', true, true)]
    local procedure OnAfterOnRun(var GenJournalLine: Record "Gen. Journal Line"; GenJournalLine2: Record "Gen. Journal Line")
    begin
        //+ONE+JOB_GL
        GenJournalLine.VALIDATE("Job Task No.");
        //+ONE+JOB_GL//
        //#7771
    end;

    //*************************************Codeunit 227 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", 'OnVendPostApplyVendLedgEntryOnBeforeCommit', '', true, true)]
    local procedure OnVendPostApplyVendLedgEntryOnBeforeCommit(var VendLedgerEntry: Record "Vendor Ledger Entry"; var SuppressCommit: Boolean);
    var
        GLEntryApplication: Codeunit "G/L Entry Application2";
    begin
        // >> HJ SORO 27-05-2015 LETTRAGE AVEC LETTRE
        GLEntryApplication.GetLettrage;
        // >> HJ SORO 27-05-2015 LETTRAGE AVEC LETTRE
    end;

    //*************************************Codeunit 226 ************************************************//

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", 'OnCustPostApplyCustLedgEntryOnBeforeCommit', '', true, true)]
      local procedure OnCustPostApplyCustLedgEntryOnBeforeCommit(var CustLedgerEntry: Record "Cust. Ledger Entry"; var SuppressCommit: Boolean);
      var
          GLEntryApplication: Codeunit "G/L Entry Application2";

      begin
          // >> HJ SORO 27-05-2015 LETTRAGE AVEC LETTRE
          GLEntryApplication.GetLettrageClt;
          // >> HJ SORO 27-05-2015 LETTRAGE AVEC LETTRE
      end;*/




    //*************************************Codeunit 113 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-Edit", 'OnBeforeVendLedgEntryModify', '', true, true)]
    local procedure OnBeforeVendLedgEntryModify(var VendLedgEntry: Record "Vendor Ledger Entry"; FromVendLedgEntry: Record "Vendor Ledger Entry")
    var
        Res: Record Resource;
        wFindCode, wFindGrp, wFindAll : Boolean;
        gAddOnLicencePermission: Codeunit IntegrManagement;
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            VendLedgEntry."Value Date" := FromVendLedgEntry."Value Date";
        //+RAP+TRESO//
        //+RAP+TRESO
        DtldVendLedgEntry.SetCurrentKey("Vendor Ledger Entry No.");
        DtldVendLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgEntry."Entry No.");
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            DtldVendLedgEntry.MODIFYALL("Value Date", VendLedgEntry."Value Date");
        //+RAP+TRESO//
    end;

    //*************************************Codeunit 103 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', true, true)]
    local procedure OnBeforeCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        //+RAP+TRESO
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            CustLedgEntry."Value Date" := FromCustLedgEntry."Value Date";
        //+RAP+TRESO//
        //+RAP+TRESO
        DtldCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.");
        DtldCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
        IF gAddOnLicencePermission.HasPermissionRAP() THEN
            DtldCustLedgEntry.MODIFYALL("Value Date", CustLedgEntry."Value Date");
        //+RAP+TRESO//
    end;


    //*************************************Codeunit 91 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterConfirmPost', '', true, true)]
    local procedure OnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header")
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Post (Yes/No)", 0);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]

    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        SalesHeader: Record "Sales Header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        RecPurchaseLineSim: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        RecLigneBureauOrdre: Record "Bureau Ordre Diffusion";
        Text002: Label 'You do not have the right to validate invoices';
        UserSetup: Record "User Setup";
        RecPurchaseLine: Record "Purchase Line";
    begin
        //>> MH soro 03-06-2020
        // IF "DTA Coding Line"='' THEN ERROR(Text003);
        //<< MH soro 03-06-2020

        //>> MH SORO 05-06-2020
        RecLigneBureauOrdre.RESET;
        RecLigneBureauOrdre.SETRANGE("Numero Fature Achat Associé", PurchaseHeader."No.");
        IF RecLigneBureauOrdre.FINDFIRST THEN
            REPEAT
                RecLigneBureauOrdre."Date Vérification Facture" := TODAY;
                RecLigneBureauOrdre.MODIFY;
            UNTIL RecLigneBureauOrdre.NEXT = 0;
        //<< MH SORO 05-06-2020


        // >> HJ 06-01-2015
        IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        //GL2024  IF NOT UserSetup."Validation Commande Achat" THEN ERROR(Text002);
        // >> HJ 06-01-2015

        // >> HJ 29-09-2015
        PurchaseHeader."Date Vérification" := TODAY;
        PurchaseHeader.MODIFY;
        // >> HJ 29-09-2015
        RecPurchaseLine.SetFilter("Document Type", '<>%1', PurchaseHeader."Document Type"::"Return Order");
        RecPurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        RecPurchaseLine.SETFILTER("Qty. to Receive", '%1', 0);
        IF RecPurchaseLine.FINDFIRST THEN
            REPEAT
                RecPurchaseLine.VALIDATE("Qty. to Receive", RecPurchaseLine.Quantity);
                RecPurchaseLine.MODIFY;
            UNTIL RecPurchaseLine.NEXT = 0;
        // >> HJ DSFT 03-10-2012



    end;

    //*************************************Codeunit 423 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Change Log Management", 'OnBeforeLogInsertion', '', true, true)]
    local procedure OnBeforeLogInsertion(var RecRef: RecordRef)
    var
        wUserExit: Codeunit "UserExit OnChange";
    begin
        //+REF+USER_EXIT
        wUserExit.OnInsert(RecRef);
        //+REF+USER_EXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Change Log Management", 'OnLogModificationOnBeforeRecRefLoopStart', '', true, true)]
    local procedure OnLogModificationOnBeforeRecRefLoopStart(var RecRef: RecordRef; var xRecRef: RecordRef)
    var
        wUserExit: Codeunit "UserExit OnChange";
    begin
        //+REF+USER_EXIT
        wUserExit.OnModify(RecRef, xRecRef);
        //+REF+USER_EXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Change Log Management", 'OnBeforeLogRename', '', true, true)]
    local procedure OnBeforeLogRename(var RecRef: RecordRef; var xRecRefParam: RecordRef)
    var
        wUserExit: Codeunit "UserExit OnChange";
    begin
        //+REF+USER_EXIT
        wUserExit.OnRename(xRecRefParam, RecRef);
        //+REF+USER_EXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Change Log Management", 'OnBeforeLogDeletion', '', true, true)]
    local procedure OnBeforeLogDeletion(var RecRef: RecordRef)
    var
        wUserExit: Codeunit "UserExit OnChange";
    begin
        //+REF+USER_EXIT
        wUserExit.OnDelete(RecRef);
        //+REF+USER_EXIT//
    end;
    //*************************************Codeunit 242 ************************************************//


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post+Print", 'OnBeforePostJournalBatch', '', true, true)]
    local procedure OnBeforePostJournalBatch(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        DocNo: Code[20];

    begin
        //  RB SORO
        DocNo := ItemJournalLine."Document No.";
        //  RB SORO
    end;

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post+Print", 'OnBeforePrintItemRegister', '', true, true)]
      local procedure OnBeforePrintItemRegister(ItemRegister: Record "Item Register"; ItemJournalTemplate: Record "Item Journal Template"; var IsHandled: Boolean; ItemJournalLine: Record "Item Journal Line")
      begin
          IsHandled := true;
      end;*/

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post+Print", 'OnBeforePrintWhseRegister', '', true, true)]
      local procedure OnBeforePrintWhseRegister(WarehouseRegister: Record "Warehouse Register"; ItemJournalTemplate: Record "Item Journal Template"; var IsHandled: Boolean; ItemJournalLine: Record "Item Journal Line")
      begin
          IsHandled := true;
      end;*/


    //*************************************Codeunit 370 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnBeforeInitPost', '', true, true)]
    local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        lBankAccRecPostPmtIntegr: Codeunit "Bank Acc. Rec. Post Pmt Integr";
        LBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccReconLine2: Record "Bank Acc. Reconciliation Line";
    begin
        // >> HJ SORO 20-09-2016
        BankAccReconLine2.RESET;
        BankAccReconLine2.SETRANGE("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccReconLine2.SETRANGE("Statement No.", BankAccReconciliation."Statement No.");
        BankAccReconLine2.SETRANGE(Lettré, FALSE);
        IF BankAccReconLine2.FINDFIRST THEN
            REPEAT
                IF LBankAccountLedgerEntry.GET(BankAccReconLine2.Sequence) THEN BEGIN
                    LBankAccountLedgerEntry."Statement Status" := LBankAccountLedgerEntry."Statement Status"::Open;
                    LBankAccountLedgerEntry."Statement No." := '';
                    LBankAccountLedgerEntry."Statement Line No." := 0;
                    LBankAccountLedgerEntry.MODIFY;
                END;
                BankAccReconLine2.DELETE;
            UNTIL BankAccReconLine2.NEXT = 0;
        // >> HJ SORO 20-09-2016
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnAfterFinalizePost', '', true, true)]
    local procedure OnAfterFinalizePost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        lBankAccRecPostPmtIntegr: Codeunit "Bank Acc. Rec. Post Pmt Integr";
        BankAcc: Record "Bank Account";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+PAYMENT
        IF BankAcc.get(BankAccReconciliation."Bank Account No.") THEN;
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lBankAccRecPostPmtIntegr.SetEtebac(BankAccReconciliation, BankAcc);
        //+PMT+PAYMENT
    end;

    //*************************************Codeunit 445 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post Prepmt. (Yes/No)", 'OnBeforePostPrepmtDocument', '', true, true)]
    local procedure OnBeforePostPrepmtDocument(var PurchaseHeader: Record "Purchase Header"; PrepmtDocumentType: Option)
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Post Prepmt. (Yes/No)", -1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post Prepmt. (Yes/No)", 'OnAfterPostPrepmtInvoiceYN', '', true, true)]
    local procedure OnAfterPostPrepmtInvoiceYN(var PurchaseHeader: Record "Purchase Header")
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Post Prepmt. (Yes/No)", +1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post Prepmt. (Yes/No)", 'OnAfterPostPrepmtCrMemoYN', '', true, true)]
    local procedure OnAfterPostPrepmtCrMemoYN(var PurchaseHeader: Record "Purchase Header")
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Post Prepmt. (Yes/No)", +1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;
    //*************************************Codeunit 448************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Queue Dispatcher", 'OnBeforeCalcNextRunTimeForRecurringJob', '', true, true)]
    local procedure OnBeforeCalcNextRunTimeForRecurringJob(JobQueueEntry: Record "Job Queue Entry"; StartingDateTime: DateTime; var NewRunDateTime: DateTime; var IsHandled: Boolean)
    begin
        //+REF+JOBQUEUE
        IF FORMAT(JobQueueEntry.Periodicity) <> '' THEN BEGIN
            NewRunDateTime := CREATEDATETIME(CALCDATE(JobQueueEntry.Periodicity, TODAY), JobQueueEntry."Starting Time");
            //EXIT(NewRunDateTime);
            IsHandled := true;
        END;
        //+REF+JOBQUEUE//
    end;
    //*************************************Codeunit 5051************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SegManagement, 'OnBeforeInteractLogEntryInsert', '', true, true)]
    local procedure OnBeforeInteractLogEntryInsert(var InteractionLogEntry: Record "Interaction Log Entry"; SegmentLine: Record "Segment Line")
    begin
        //+REF+MAILING
        InteractionLogEntry."Sales Document Type" := InteractionLogEntry.fSearchDocType(0, SegmentLine."Document Type", 2);
        InteractionLogEntry."Sales Document No." := SegmentLine."Document No.";
        InteractionLogEntry.TableID := SegmentLine.TableID;
        InteractionLogEntry."Document Line No." := SegmentLine."Document Line No.";
        //+REF+MAILING//
    end;
    //*************************************Codeunit 5057************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendCont-Update", 'OnInsertNewContactPersonOnBeforeContactModify', '', true, true)]
    local procedure OnInsertNewContactPersonOnBeforeContactModify(var Contact: Record Contact; Vendor: Record Vendor)
    var
        RMSetup: Record "Marketing Setup";
    begin
        RMSetup.get();
        //+REF+CONTACT
        IF Contact.Type = Contact.Type::Company THEN
            Contact."Salutation Code" := RMSetup."Def. Company Salutation Code"
        ELSE
            Contact."Salutation Code" := RMSetup."Default Person Salutation Code";
        //+REF+CONTACT//
    end;

    //*************************************Codeunit 5510************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertConsumptionJnlLine', '', true, true)]
    local procedure OnBeforeInsertConsumptionJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComp: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Level: Integer)
    var
        ProdOrder: Record "Production Order";
    begin
        // >> HJ SORO 20-08-2015
        IF ProdOrder.GET(ProdOrderLine.Status, ProdOrderComp."Prod. Order No.") THEN;
        // >> HJ SORO 18-04-2016
        ItemJournalLine."External Document No." := ProdOrder."N° BL";
        ItemJournalLine."Sous Affectation Marche" := ProdOrder.Destination;
        // ItemJnlLine.centrale:=ProdOrder.Centrale;
        ItemJournalLine.Chauffeur := ProdOrder.Chauffeur;
        ItemJournalLine."N° Materiel" := ProdOrder.Camion;
        ItemJournalLine."N° Véhicule" := ProdOrder.Camion;
        // ItemJournalLine."Lieu De Livraison / Provenance" := ProdOrder.Destination;
        // >> HJ SORO 18-04-2016

        // >> HJ SORO 20-08-2015


        // >> HJ SORO 19-10-17
        // ItemJournalLine."Job No." := ProdOrder.Client;
        // >> HJ SORO 19-10-17
        ItemJournalLine.VALIDATE("Posting Date", ProdOrder."Due Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertOutputJnlLine', '', true, true)]
    local procedure OnBeforeInsertOutputJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrder: Record "Production Order";

    begin
        // >> HJ SORO 20-08-2015
        IF ProdOrder.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") THEN;
        // >> HJ SORO 18-04-2016
        ItemJournalLine."External Document No." := ProdOrder."N° BL";
        ItemJournalLine."Sous Affectation Marche" := ProdOrder.Destination;
        ItemJournalLine.Benificiaire := ProdOrder.Centrale;
        ItemJournalLine.Chauffeur := ProdOrder.Chauffeur;
        ItemJournalLine."N° Materiel" := ProdOrder.Camion;
        ItemJournalLine."N° Véhicule" := ProdOrder.Camion;
        // ItemJournalLine."Lieu De Livraison / Provenance" := ProdOrder.Destination;
        // >> HJ SORO 18-04-2016
        // >> HJ SORO 19-1017
        //  ItemJournalLine."Job No." := ProdOrder.Client;
        // >> HJ SORO 19-1017

        // >> HJ SORO 20-08-2015
        ItemJournalLine.VALIDATE("Posting Date", ProdOrder."Due Date");
        ItemJournalLine.VALIDATE("Location Code", ProdOrder.Centrale);

        ItemJnlLine2.COPY(ItemJournalLine);
        // >> HJ SORO 19-1017
        //  ItemJournalLine."Job No." := ProdOrder.Client;
        // >> HJ SORO 19-1017
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeRecursiveInsertOutputJnlLine', '', true, true)]
    local procedure OnBeforeRecursiveInsertOutputJnlLine(ProdOrderRoutingLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line"; var DoRecursion: Boolean; var AdditionalProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrder: Record "Production Order";
    begin
        // >> HJ SORO 18-04-2016
        IF NOT ProdOrder.Stockable THEN BEGIN
            ItemJnlLine2."Line No." := ItemJnlLine2."Line No." + 1000;
            ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::Consumption;
            ItemJnlLine2.Description := 'Consommation :' + ItemJnlLine2.Description;
            ItemJnlLine2.VALIDATE("Unit Cost", ProdOrderLine."Unit Cost");
            ItemJnlLine2.VALIDATE("Unit Amount", ProdOrderLine."Unit Cost");
            ItemJnlLine2.VALIDATE(Amount, ProdOrderLine."Unit Cost");
            ItemJnlLine2."Output Quantity" := 0;
            ItemJnlLine2."Output Quantity (Base)" := 0;
            ItemJnlLine2.Type := 0;
            // >> HJ SORO 19-1017
            //   ItemJnlLine2."Job No." := ProdOrder.Client;
            // >> HJ SORO 19-1017

            ItemJnlLine2.INSERT;
        END;
        // >> HJ SORO 18-04-2016
    end;

    //*************************************Codeunit 5601************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert G/L Account", 'OnGetBalAccAfterSaveGenJnlLineFields', '', true, true)]
    local procedure OnGetBalAccAfterSaveGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line"; var SkipInsert: Boolean)
    var
        lFixedAsset: Record "Fixed Asset";
        lJobNo: Code[20];
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert G/L Account", 'OnGetBalAccAfterRestoreGenJnlLineFields', '', true, true)]
    local procedure OnGetBalAccAfterRestoreGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line"; var TempFAGLPostBuf: Record "FA G/L Posting Buffer")
    var
        lFixedAsset: Record "Fixed Asset";
        lJobNo: Code[20];
    begin
        //#5444
        IF NOT lFixedAsset.GET(FromGenJnlLine."Account No.") THEN
            lFixedAsset.INIT;
        //#5444//
        //#5444
        ToGenJnlLine.VALIDATE("Job No.", lFixedAsset."Job No.");
        //#5444//
    end;

    //*************************************Codeunit 5631************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Jnl.-Check Line", 'OnBeforeCheckJobNo', '', true, true)]
    local procedure OnBeforeCheckJobNo(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
        //PROJET_IMMO
        IsHandled := true;
    end;

    //*************************************Codeunit 5700 ************************************************//

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"User Setup Management", 'OnBeforeGetLocation', '', true, true)]
     local procedure OnBeforeGetLocation(DocType: Option Sales,Purchase,Service; AccLocation: Code[10]; RespCenterCode: Code[10]; var LocationCode: Code[10]; var IsHandled: Boolean)
     var
         UserSetup: Record "User Setup";
     begin
         IF UserSetup.GET(UPPERCASE(USERID)) THEN
             IF UserSetup."Filtre Magasin" <> '' THEN AccLocation := UserSetup."Filtre Magasin";
     end;*/

    PROCEDURE GetAutorisationClientUser(User: Code[20]): Boolean;
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN

        IF RecLUserSetup.GET(User) THEN
            IF RecLUserSetup."Modif Client" = TRUE THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE)
    END;

    PROCEDURE GetAutorisationFournUser(User: Code[20]): Boolean;
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
        IF RecLUserSetup.GET(User) THEN
            IF RecLUserSetup."Modif Fournisseur" = TRUE THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE)
    END;

    PROCEDURE GetAutorisationArticleUser(User: Code[20]): Boolean;
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
        IF RecLUserSetup.GET(User) THEN
            IF RecLUserSetup."Modif Article" = TRUE THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE)
    END;

    PROCEDURE GetAutorisationPersonnel(User: Code[20]): Boolean;
    VAR
        RecLUserSetup: Record "User Setup";
    BEGIN
    END;

    //*************************************Codeunit 5702 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dist. Integration", 'OnGetSpecialOrdersOnBeforeSelectSalesHeader', '', true, true)]
    local procedure OnGetSpecialOrdersOnBeforeSelectSalesHeader(var PurchaseHeader: Record "Purchase Header"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", PurchaseHeader."Sell-to Customer No.");
        //CDE_INTERNE
        SalesHeader.SETFILTER("Order Type", '<>%1', SalesHeader."Order Type"::"Supply Order");
        //CDE_INTERNE//
        if (PAGE.RunModal(PAGE::"Sales List", SalesHeader) <> ACTION::LookupOK) or
           (SalesHeader."No." = '')
        then
            IsHandled := true;
        ;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dist. Integration", 'OnGetSpecialOrdersOnAfterSalesLineSetFilters', '', true, true)]
    local procedure OnGetSpecialOrdersOnAfterSalesLineSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; var PurchHeader: Record "Purchase Header")
    begin
        //CDE_INTERNE
        SalesLine.SETRANGE("Supply Order Line No.", 0);
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dist. Integration", 'OnBeforeSalesLineModify', '', true, true)]
    local procedure OnBeforeSalesLineModify1(var SalesLine: Record "Sales Line"; PurchaseLine: Record "Purchase Line")
    begin
        //CDE_INTERNE
        SalesLine."Purchasing Document Type" := SalesLine."Purchasing Document Type"::Order;
        SalesLine."Purchasing Order No." := PurchaseLine."Document No.";
        SalesLine."Purchasing Order Line No." := PurchaseLine."Line No.";
        //CDE_INTERNE//
    end;

    //*************************************Codeunit 5704 ************************************************//
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', true, true)]
     local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
     begin
         // RB SORO 30/05/2015
         TransShptHeader.Observation := TransHeader.Observation;
         TransShptHeader."N° Materiel" := TransHeader."N° Materiel";
         TransShptHeader.Materiel := TransHeader.Materiel;
         TransShptHeader.Receptioneur := TransHeader.Receptioneur;
         TransShptHeader."Id Expediteur" := TransHeader."Id Expediteur";
         TransShptHeader."Id Receptioneur" := TransHeader."Id Receptioneur";
         TransShptHeader."Date Saisie" := TransHeader."Date Saisie";
         // RB SORO 30/05/2015
     end;*/

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', true, true)]
     local procedure OnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header")
     var
         TransHeader: Record "Transfer Header";
     begin
         IF TransHeader.get(TransLine."Document No.") THEN;
         // RB SORO 10/06/2015
         TransShptLine."N° Materiel" := TransLine."N° Materiel";
         // RB SORO 10/06/2015
         // >> HJ SORO 13-06-2015
         TransShptLine.Affaire := TransHeader."Chantier Origine";
         // >> HJ SORO 13-06-2015
     end;*/

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', true, true)]
      local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
      begin
          // RB SORO 18/06/2015
          ItemJournalLine."N° Materiel" := TransferShipmentLine."N° Materiel";
          //// RB SORO 18/06/2015
          // >> HJ SORO 15-06-2015
          ItemJournalLine."Lieu De Livraison / Provenance" := TransferShipmentLine.Affaire;
          ItemJournalLine."Lieu Livraison / Provenance" := TransferShipmentLine.Affaire;
          // >> HJ SORO 15-06-2015
      end;*/

    //*************************************Codeunit 5705 ************************************************//
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransRcptHeaderInsert', '', true, true)]
     local procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
     begin
         // RB SORO 30/05/2015
         TransferReceiptHeader.Observation := TransferHeader.Observation;
         TransferReceiptHeader."N° Materiel" := TransferHeader."N° Materiel";
         TransferReceiptHeader.Materiel := TransferHeader.Materiel;
         TransferReceiptHeader.Receptioneur := TransferHeader.Receptioneur;
         TransferReceiptHeader."Id Expediteur" := TransferHeader."Id Expediteur";
         TransferReceiptHeader."Id Receptioneur" := TransferHeader."Id Receptioneur";
         TransferReceiptHeader."Date Saisie" := TransferHeader."Date Saisie";
         // RB SORO 30/05/2015
     end;*/

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', true, true)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        TransHeader: Record "Transfer Header";
    begin
        IF TransHeader.get(TransLine."Document No.") THEN;
        // RB SORO 10/06/2015
        TransRcptLine."N° Materiel" := TransLine."N° Materiel";
        // RB SORO 10/06/2015
        // >> HJ SORO 15-06-2015
        TransRcptLine.Chantier := TransHeader."Chantier Destination";
        // >> HJ SORO 15-06-2015
    end;*/

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', true, true)]
     local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
     begin
         // RB SORO 11/06/2015
         ItemJournalLine."N° Materiel" := TransferLine."N° Materiel";
         // RB SORO 11/06/2015
         // >> HJ SORO 15-06-2015
         ItemJournalLine."Lieu De Livraison / Provenance" := TransferReceiptLine.Chantier;
         ItemJournalLine."Lieu Livraison / Provenance" := TransferReceiptLine.Chantier;
         // >> HJ SORO 15-06-2015
     end;*/

    //*************************************Codeunit 5706 ************************************************//
    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnBeforePost', '', true, true)]
      local procedure OnBeforePost(var TransHeader: Record "Transfer Header"; var IsHandled: Boolean; var TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment"; var TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt"; var PostBatch: Boolean; var TransferOrderPost: Enum "Transfer Order Post")
      var
          RecUser: Record "User Setup";
          Text001: Label 'Vous n''êtes pas autoriser à receptionner le transfert N° %1';
      begin
          // RB SORO 30/05/2015
          IF TransHeader."Last Shipment No." = '' THEN BEGIN
              TransHeader."Id Expediteur" := USERID;
              TransHeader."Shipment Date" := WORKDATE;
          END;
          IF TransHeader."Last Shipment No." <> '' THEN BEGIN
              IF RecUser.GET(USERID) THEN;
              IF RecUser."Mgasin Origine Transf" <> '' THEN BEGIN
                  IF RecUser."Mgasin Origine Transf" <> TransHeader."Transfer-to Code" THEN
                      ERROR(Text001, TransHeader."No.");
              END;
              TransHeader."Id Receptioneur" := USERID;
              TransHeader."Receipt Date" := WORKDATE;
          END;
          // RB SORO 30/05/2015
      end;*/

    //*************************************Codeunit 5805 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeInsertItemChargeAssgntWithAssignValues', '', true, true)]
    local procedure OnBeforeInsertItemChargeAssgntWithAssignValues(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; FromItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)")
    var
        ItemCharge: Record "Item Charge";
    begin
        // >> HJ DSFT 13 FEV 2009  DOSSIER D'ARRIVAGE
        IF ItemCharge.GET(ItemChargeAssgntPurch."Item Charge No.") THEN
            ItemChargeAssgntPurch."Type Frais" := ItemCharge."Type Frais";
        ItemChargeAssgntPurch."N° Dossier" := ItemChargeAssgntPurch."N° Dossier";
        ItemChargeAssgntPurch."Source Type" := ItemChargeAssgntPurch."Source Type";
        ItemChargeAssgntPurch."Source No." := ItemChargeAssgntPurch."Source No.";
        //manque event
        // IF ApplToDocType=ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt THEN
        //Ins‚rerLigneDossier(ItemChargeAssgntPurch);

        // >> HJ DSFT 13 FEV 2009
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeCheckFromPurchRcptLineWorkCenter', '', true, true)]
    local procedure OnBeforeCheckFromPurchRcptLineWorkCenter(FromPurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeCreateReturnRcptChargeAssgnt', '', true, true)]
    local procedure OnBeforeCreateReturnRcptChargeAssgnt(var FromReturnRcptLine: Record "Return Receipt Line"; ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    PROCEDURE InsérerLigneDossier(ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)");
    VAR
        ligrecept: Record "Purch. Rcpt. Line";
        T1: Record "Ligne Dossiers d'Importation";
        T2: Record "Ligne Dossiers d'Importation";
        T: Record "Dossiers d'Importation";
        i: Integer;
        entrecep: Record "Purch. Rcpt. Header";
        dev: Record Currency;
        LigF: Record "Purch. Inv. Line";
        EntF: Record "Purch. Inv. Header";
    BEGIN
        CLEAR(ligrecept);
        CLEAR(entrecep);

        WITH ItemChargeAssgntPurch DO BEGIN
            IF entrecep.GET("Applies-to Doc. No.") THEN;
            IF ligrecept.GET("Applies-to Doc. No.", "Applies-to Doc. Line No.") THEN;
            CLEAR(T1);
            IF dev.GET(entrecep."Currency Code") THEN;
            T1.RESET;
            T1.SETCURRENTKEY("N° dossier", "N° article", "N° réception", "N° ligne réception");
            T1.SETFILTER("N° dossier", "N° Dossier");
            T1.SETFILTER("N° article", "Item No.");
            T1.SETFILTER("N° réception", "Applies-to Doc. No.");
            T1.SETFILTER("N° ligne réception", '%1', "Applies-to Doc. Line No.");
            IF NOT T1.FIND('-') THEN BEGIN
                CLEAR(T);
                IF T.GET("N° Dossier") THEN;
                CLEAR(T2);
                i := 0;
                T2.RESET;
                T2.SETFILTER("N° dossier", "N° Dossier");
                IF T2.FIND('+') THEN i := T2."N° ligne";
                i := i + 10000;
                CLEAR(LigF);
                LigF.RESET;
                LigF.SETCURRENTKEY("N° Bon Reception", "N° Ligne Bon Reception", Type, "No.");
                LigF.SETFILTER(Type, '%1', LigF.Type::Item);
                LigF.SETFILTER("No.", ligrecept."No.");
                LigF.SETFILTER("N° Bon Reception", ligrecept."Document No.");
                LigF.SETFILTER("N° Ligne Bon Reception", '%1', ligrecept."Line No.");

                T1.RESET;
                T1."N° dossier" := T."N° Dossier";
                T1."N° ligne" := i;
                T1."N° preneur d'ordre" := ligrecept."Buy-from Vendor No.";
                T1."N° réception" := ligrecept."Document No.";
                T1."N° ligne réception" := ligrecept."Line No.";
                T1."N° article" := ligrecept."No.";
                T1."Code magasin" := ligrecept."Location Code";
                T1.Désignation := ligrecept.Description;
                T1."Désignation 2" := ligrecept."Description 2";
                T1.Quantité := ligrecept.Quantity;
                IF LigF.FIND('-') THEN BEGIN
                    T1."Coût unitaire direct" := LigF."Direct Unit Cost";
                    T1."Coût unitaire (dev soc)" := LigF."Unit Cost (LCY)";
                    IF entrecep."Currency Code" <> '' THEN
                        T1.Montant := ROUND((T1."Coût unitaire direct" * ligrecept.Quantity) * (100 - LigF."Line Discount %") / 100,
                           dev."Amount Rounding Precision")
                    ELSE
                        T1.Montant := ROUND((T1."Coût unitaire direct" * ligrecept.Quantity) * (100 - LigF."Line Discount %") / 100, 0.001);

                    T1."Prix unitaire (dev soc)" := LigF."Unit Price (LCY)";
                    T1."Référence fournisseur" := ligrecept."Vendor Item No.";
                    T1."Coût unitaire" := LigF."Unit Cost";
                    T1."Quantité (base)" := ligrecept.Quantity * ligrecept."Qty. per Unit of Measure";
                    T1."N° commande" := ligrecept."Order No.";
                    T1."N° ligne commande" := ligrecept."Order Line No.";
                    EntF.RESET;
                    EntF.GET(LigF."Document No.");
                    IF ligrecept."Qty. per Unit of Measure" = 1 THEN
                        T1."Coût unitaire direct (base)" := LigF."Direct Unit Cost"
                    ELSE
                        T1."Coût unitaire direct (base)" := LigF."Direct Unit Cost" / ligrecept."Qty. per Unit of Measure";
                    T1.VALIDATE("Code devise", EntF."Currency Code");
                    T1.VALIDATE("Facteur devise", EntF."Currency Factor");
                END ELSE BEGIN
                    T1."Coût unitaire direct" := ligrecept."Direct Unit Cost";
                    T1."Coût unitaire (dev soc)" := ligrecept."Unit Cost (LCY)";
                    IF entrecep."Currency Code" <> '' THEN
                        T1.Montant := ROUND((ligrecept."Direct Unit Cost" * ligrecept.Quantity) * (100 - ligrecept."Line Discount %") / 100,
                           dev."Amount Rounding Precision")
                    ELSE
                        T1.Montant := ROUND((ligrecept."Direct Unit Cost" * ligrecept.Quantity) * (100 - ligrecept."Line Discount %") / 100, 0.001);

                    T1."Prix unitaire (dev soc)" := ligrecept."Unit Price (LCY)";
                    T1."Référence fournisseur" := ligrecept."Vendor Item No.";
                    T1."Coût unitaire" := ligrecept."Unit Cost";
                    T1."Quantité (base)" := ligrecept.Quantity * ligrecept."Qty. per Unit of Measure";
                    T1."N° commande" := ligrecept."Order No.";
                    T1."N° ligne commande" := ligrecept."Order Line No.";
                    IF ligrecept."Qty. per Unit of Measure" = 1 THEN
                        T1."Coût unitaire direct (base)" := ligrecept."Direct Unit Cost"
                    ELSE
                        T1."Coût unitaire direct (base)" := ligrecept."Direct Unit Cost" / ligrecept."Qty. per Unit of Measure";
                    T1.VALIDATE("Code devise", entrecep."Currency Code");
                    T1.VALIDATE("Facteur devise", entrecep."Currency Factor");
                END;
                T1.INSERT;
            END;
        END;
    END;

    //*************************************Codeunit 5813 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCheckPurchRcptLine', '', true, true)]
    local procedure OnBeforeCheckPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean; var TempItemLedgerEntry: Record "Item Ledger Entry" temporary)
    var
        AlreadyReversedErr: Label 'This receipt has already been reversed.';
        CduUndoPurchRecpLin: Codeunit "Undo Purchase Receipt Line";
        Text004: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.';
        UndoPostingMgt: Codeunit "Undo Posting Management";
        lOrderSalesLine: Record "Sales Line";
    begin

        if PurchRcptLine.Correction then
            Error(AlreadyReversedErr);
        if PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity then
            if CduUndoPurchRecpLin.HasInvoicedNotReturnedQuantity(PurchRcptLine) then
                Error(Text004);
        if PurchRcptLine.Type = PurchRcptLine.Type::Item then begin
            PurchRcptLine.TestField("Prod. Order No.", '');
            //#5700
            IF NOT (lOrderSalesLine.GET(lOrderSalesLine."Document Type"::Order, PurchRcptLine."Sales Order No.", PurchRcptLine."Sales Order Line No.")
               AND (lOrderSalesLine."Order Type" = lOrderSalesLine."Order Type"::"Supply Order"))
               //#9221
               AND ((PurchRcptLine."Special Order Sales No." = '') AND (PurchRcptLine."Special Order Sales Line No." = 0))
               //#9221L//
               THEN BEGIN
                //#5700//
                PurchRcptLine.TestField("Sales Order No.", '');
                PurchRcptLine.TestField("Sales Order Line No.", 0);
            END;
            UndoPostingMgt.TestPurchRcptLine(PurchRcptLine);



            UndoPostingMgt.CollectItemLedgEntries(TempItemLedgerEntry, DATABASE::"Purch. Rcpt. Line",
              PurchRcptLine."Document No.", PurchRcptLine."Line No.", PurchRcptLine."Quantity (Base)", PurchRcptLine."Item Rcpt. Entry No.");
            //hs
            if PurchRcptLine."Type article" <> PurchRcptLine."Type article"::Service then
                UndoPostingMgt.CheckItemLedgEntries(TempItemLedgerEntry, PurchRcptLine."Line No.", PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity);

        end;
        IsHandled := true;
    end;


    /*GL2024 
      [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeGetCorrectionLineNo', '', true, true)]

       // local procedure OnBeforeGetCorrectionLineNo(PurchRcptLine: Record "Purch. Rcpt. Line"; var Result: Integer; var IsHandled: Boolean)
       // var
       //     PurchRcptLine2: Record "Purch. Rcpt. Line";
       //     LineSpacing: Integer;
       //     lLastLineNo: Integer;
       //     Text002: Label 'There is not enough space to insert correction lines.';

       // begin
       //     PurchRcptLine2.SetRange("Document No.", PurchRcptLine."Document No.");
       //     PurchRcptLine2."Document No." := PurchRcptLine."Document No.";
       //     PurchRcptLine2."Line No." := PurchRcptLine."Line No.";
       //     PurchRcptLine2.Find('=');

       //     if PurchRcptLine2.Find('>') then begin
       //         LineSpacing := (PurchRcptLine2."Line No." - PurchRcptLine."Line No.") div 2;

       //         IF LineSpacing = 0 THEN BEGIN
       //             lLastLineNo := fSendLastLineNo(PurchRcptLine."Document No.");
       //             LineSpacing := lLastLineNo;
       //         END
       //         /*if LineSpacing = 0 then
       //             Error(Text002);*/
    //     end else
    //         LineSpacing := 10000;
    //     //  exit(PurchRcptLine."Line No." + LineSpacing);
    //     //#6910//
    //     Result := PurchRcptLine."Line No." + LineSpacing;

    //     IsHandled := true;
    // end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeNewPurchRcptLineInsert', '', true, true)]
    local procedure OnBeforeNewPurchRcptLineInsert(var NewPurchRcptLine: Record "Purch. Rcpt. Line"; OldPurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        //+REF+COTFRN
        NewPurchRcptLine."Qty. Not In Conformity" := 0;
        NewPurchRcptLine."Not In Conformity Code" := '';
        NewPurchRcptLine."Remainder Quantity" := 0;
        NewPurchRcptLine."Not In Conformity" := FALSE;
        //+REF+COTFRN//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnAfterUpdateOrderLine', '', true, true)]
    local procedure OnAfterUpdateOrderLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line")
    begin
        //+REF+SOLDE_CDE
        PurchLine."Completely Received" := FALSE;
        //+REF+SOLDE_CDE//
    end;

    PROCEDURE wCheckInternalSalesOrder(pDocumentNo: Code[20]; pLineNo: Integer): Boolean;
    VAR
        lInternalOrder: Record "Sales Line";
        wInternalOrder: Record "Sales Line";
    BEGIN
        WITH wInternalOrder DO BEGIN
            IF NOT GET("Document Type"::Order, pDocumentNo, pLineNo) THEN
                EXIT(FALSE);
            EXIT("Order Type" = "Order Type"::"Supply Order");
        END;
    END;

    PROCEDURE wUpdateInternalOrderLine(PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        wInternalOrder: Record "Sales Line";
    BEGIN
        WITH wInternalOrder DO BEGIN
            IF NOT wCheckInternalSalesOrder(PurchRcptLine."Sales Order No.", PurchRcptLine."Sales Order Line No.") THEN
                EXIT;
        END;
    END;

    PROCEDURE fSendLastLineNo(DocumentNo: Code[20]): Integer;
    VAR
        lPurchRcptLine: Record "Purch. Rcpt. Line";
    BEGIN
        lPurchRcptLine.SETRANGE("Document No.", DocumentNo);
        IF lPurchRcptLine.FIND('+') THEN
            EXIT(lPurchRcptLine."Line No.");
    END;

    //*************************************Codeunit 5815 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforeCheckSalesShptLine', '', true, true)]
    local procedure OnBeforeCheckSalesShptLine(var SalesShipmentLine: Record "Sales Shipment Line"; var IsHandled: Boolean; var SkipTestFields: Boolean; var SkipUndoPosting: Boolean; var SkipUndoInitPostATO: Boolean)
    var
        gSupplyOrder: Record "Sales Header";
    begin
        //#6735
        IF (gSupplyOrder."No." <> SalesShipmentLine."Order No.") AND (SalesShipmentLine."Order No." <> '') THEN
            gSupplyOrder.GET(gSupplyOrder."Document Type"::Order, SalesShipmentLine."Order No.");
        //#6735//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnCheckSalesShptLineOnBeforeHasInvoicedNotReturnedQuantity', '', true, true)]
    local procedure OnCheckSalesShptLineOnBeforeHasInvoicedNotReturnedQuantity(SalesShptLine: Record "Sales Shipment Line"; var IsHandled: Boolean)
    var
        gSupplyOrder: Record "Sales Header";
        Text005: Label 'This shipment has already been invoiced. Undo Shipment can be applied only to posted, but not invoiced shipments.';
    begin
        IF (SalesShptLine."Qty. Shipped Not Invoiced" <> SalesShptLine.Quantity) AND
          (gSupplyOrder."Order Type" <> gSupplyOrder."Order Type"::"Supply Order") THEN begin
            IsHandled := true;
            Error(Text005)
        end;

        //#6735//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnUpdateOrderLineOnBeforeUpdateSalesLine', '', true, true)]
    local procedure OnUpdateOrderLineOnBeforeUpdateSalesLine(var SalesShipmentLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    begin
        //+REF+NAVISION
        SalesLine."Completely Shipped" := FALSE;
        //+REF+NAVISION//
    end;

    PROCEDURE fUndoResource(SalesShptLine: Record "Sales Shipment Line");
    VAR
        UndoProductionCompletion: Codeunit "Undo Production Completion";
        lSalesLine: Record "Sales Line";
    BEGIN
        UndoProductionCompletion.SetHideDialog(TRUE);
        WITH SalesShptLine DO BEGIN
            lSalesLine.GET(lSalesLine."Document Type"::Order, "Order No.", "Order Line No.");
            //#7232
            //  UndoProductionCompletion.RUN(lSalesLine);
            UndoProductionCompletion.fUndoFromShipmentLine(lSalesLine, SalesShptLine);
            lSalesLine.GET(lSalesLine."Document Type"::Order, "Order No.", "Order Line No.");
            lSalesLine.VALIDATE("Qty. to Ship", lSalesLine."Outstanding Quantity");
            //  lSalesLine."Qty. to Ship (Base)" := lSalesLine."Outstanding Qty. (Base)";
            lSalesLine.MODIFY;
            //#7232//

        END;
    END;

    //*************************************Codeunit 5720 ************************************************//
    //Table 37
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Reference Management", 'OnBeforeValidateSalesReferenceNo', '', true, true)]
    local procedure OnBeforeValidateSalesReferenceNo(var SalesLine: Record "Sales Line"; ItemReference: Record "Item Reference"; SearchItem: Boolean; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF SalesLine.Type <> SalesLine.Type::Item THEN
            IsHandled := true;
        //DEVIS//
    end;


    //*************************************Codeunit 5991 ************************************************//
    //Table 37
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Warehouse Mgt.", 'OnBeforeSalesLineVerifyChange', '', true, true)]
    local procedure OnBeforeSalesLineVerifyChange(var NewSalesLine: Record "Sales Line"; var OldSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        //DEVIS
        IF NewSalesLine."Document Type" = NewSalesLine."Document Type"::Quote then
            IsHandled := true;
        //DEVIS//
    end;

    //*************************************Codeunit 5912 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnInsertServLedgerEntrySaleOnBeforeCloseEntries', '', true, true)]
    local procedure OnInsertServLedgerEntrySaleOnBeforeCloseEntries(var ServiceLedgerEntry: Record "Service Ledger Entry"; var ApplyToServLedgEntry: Record "Service Ledger Entry"; var ServiceLine: Record "Service Line"; var ServHeader: Record "Service Header");
    begin
        //JOB_SERVICE
        ServiceLedgerEntry."Job No." := ServiceLine."Job No.";
        ServiceLedgerEntry."Job Task No." := ServiceLine."Job Task No.";
        IF ServiceLedgerEntry."Job No." <> '' THEN
            ServiceLine.TESTFIELD("Job Task No.");
        //JOB_SERVICE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsert', '', true, true)]
    local procedure OnInsertServLedgEntryCrMemoOnBeforeServLedgEntryInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceHeader: Record "Service Header"; ServiceLine: Record "Service Line")
    begin
        //JOB_SERVICE
        ServiceLedgerEntry."Job No." := ServiceLine."Job No.";
        ServiceLedgerEntry."Job Task No." := ServiceLine."Job Task No.";
        //JOB_SERVICE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnCreateCreditEntryOnBeforeServDocRegServiceDocument', '', true, true)]
    local procedure OnCreateCreditEntryOnBeforeServDocRegServiceDocument(var ServiceLedgerEntry: Record "Service Ledger Entry"; var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line")
    begin
        //JOB_SERVICE
        ServiceLedgerEntry."Job No." := ServiceLine."Job No.";
        ServiceLedgerEntry."Job Task No." := ServiceLine."Job Task No.";
        IF ServiceLedgerEntry."Job No." <> '' THEN
            ServiceLine.TESTFIELD("Job Task No.");
        //JOB_SERVICE//
    end;

    //*************************************Codeunit 5943 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lock-OpenServContract", 'OnErrorIfServContractLinesHaveZeroAmount', '', true, true)]
    local procedure OnErrorIfServContractLinesHaveZeroAmount(ServiceContractHeader: Record "Service Contract Header"; ServiceContractLine: Record "Service Contract Line"; var RaiseError: Boolean)
    begin
        ServiceContractLine.Reset();
        ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
        ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
        ServiceContractLine.SetRange("Line Amount", 0);
        ServiceContractLine.SetFilter("Line Discount %", '<%1', 100);
        //SERVICE
        ServiceContractLine.SETFILTER(Quantity, '<>0');
        //SERVICE//
        RaiseError := not ServiceContractLine.IsEmpty();
    end;

    //*************************************Codeunit 5944 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnBeforeCheckServContractQuote', '', true, true)]
    local procedure OnBeforeCheckServContractQuote(var ServiceContractHeader: Record "Service Contract Header"; HideDialog: Boolean; var IsHandled: Boolean)
    begin
        //JOB_SERVICE
        ServiceContractHeader.TESTFIELD("Job No.");
        //JOB_SERVICE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'OnAfterCreateDetailedServiceLine', '', true, true)]
    local procedure OnAfterCreateDetailedServiceLine(ServiceHeader: Record "Service Header"; ServiceContractLine: Record "Service Contract Line"; NewContract: Boolean; ServiceContractHeader: Record "Service Contract Header"; var ServLineNo: Integer)
    var
        CduFunction: Codeunit SoroubatFucntion;
    begin
        //SERVICE
        IF ServiceContractLine."Line Value" <> 0 THEN
            CduFunction.fClearNewGlobals;
        //SERVICE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAddendumToContractOnAfterSetStartingDate', '', true, true)]
    local procedure OnAddendumToContractOnAfterSetStartingDate(FromServContractHeader: Record "Service Contract Header"; var StartingDate: Date)

    begin
        //SERVICE
        wWorkingDate := WORKDATE;
        //SERVICE//
        //SERVICE

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAddendumToContractOnBeforeServContractLineLoop', '', true, true)]
    local procedure OnAddendumToContractOnBeforeServContractLineLoop(ServContractLine: Record "Service Contract Line"; var StartingDate: Date)
    begin
        StartingDate := ServContractLine."Starting Date";
        //SERVICE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAddendumToContractOnAfterServContractLineLoop', '', true, true)]
    local procedure OnAddendumToContractOnAfterServContractLineLoop(var ServContractLine: Record "Service Contract Line"; var StartingDate: Date)
    begin
        //SERVICE
        //      ServContractLine."Starting Date" := StartingDate;
        IF StartingDate > ServContractLine."Starting Date" THEN
            StartingDate := ServContractLine."Starting Date";
        //SERVICE//
    end;


    //*************************************Codeunit 5987 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service Post Invoice Events", 'OnPrepareLineOnAfterFillInvoicePostingBuffer', '', true, true)]
    local procedure OnPrepareLineOnAfterFillInvoicePostingBuffer(var InvoicePostingBuffer: Record "Invoice Posting Buffer"; ServiceLine: Record "Service Line"; ServiceLineACY: Record "Service Line"; SuppressCommit: Boolean)
    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        lDocPostSubscriptionIntegr: Codeunit "Sales-Post Subscription integr";
    begin
        //+ABO+
        // IF gAddOnLicencePermission.HasPermissionABO THEN
        //   lDocPostSubscriptionIntegr.SetServInvBufferSubscription(InvoicePostingBuffer[1], ServiceLine);
        //+ABO+//
    end;

    //*************************************Codeunit 5988 ************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnBeforeServCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeServCrMemoLineInsert(var ServiceCrMemoLine: Record "Service Cr.Memo Line"; ServiceLine: Record "Service Line")
    begin
        //JOB_SERVICE
        ServiceCrMemoLine."Job No." := ServiceLine."Job No.";
        ServiceCrMemoLine."Job Task No." := ServiceLine."Job Task No.";
        //JOB_SERVICE//
    end;

    //*************************************Codeunit 7000 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLineItemPrice', '', true, true)]
    local procedure OnAfterFindSalesLineItemPrice(var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; var FoundSalesPrice: Boolean; CalledByFieldNo: Integer)

    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnFindSalesLinePriceOnItemTypeOnAfterSetUnitPrice', '', true, true)]
    local procedure OnFindSalesLinePriceOnItemTypeOnAfterSetUnitPrice(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price" temporary; CalledByFieldNo: Integer; FoundSalesPrice: Boolean)
    var
        lFoundPrice: Decimal;
    begin
        //#7388
        IF CalledByFieldNo IN [SalesLine.FIELDNO(Quantity), SalesLine.FIELDNO("Variant Code"), SalesLine.FIELDNO("Unit of Measure Code")] THEN BEGIN
            lFoundPrice := SalesLine."Found Price";
            SalesLine."Found Price" := 0;
        END;
        //#7388
        //DEVIS
        SalesLine."Found Price" := TempSalesPrice."Unit Price";

        IF (lFoundPrice <> 0) AND (SalesLine."Found Price" = 0) THEN
            SalesLine."Found Price" := lFoundPrice;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLinePrice', '', true, true)]
    local procedure OnAfterFindSalesLinePrice(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var SalesPrice: Record "Sales Price"; var ResourcePrice: Record "Resource Price"; CalledByFieldNo: Integer; FoundSalesPrice: Boolean)
    var
        ResPrice: Record "Resource Price";
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        IF ResPrice.Get(ResPrice.Type::Resource, SalesLine."No.", SalesLine."Work Type Code", SalesHeader."Currency Code") THEN;
        //DEVIS
        //        "Unit Price" := ResPrice."Unit Price" * "Qty. per Unit of Measure";
        //#7582
        IF NOT SalesLine."Fixed Price" AND (ResPrice.Code <> '') THEN BEGIN
            //#7582//
            SalesLine."Unit Price" := ResPrice."Unit Price" * SalesLine."Qty. per Unit of Measure";
            //#4203        ELSE
            //#4203          "Unit Price" := "Unit Price" * SalesLine."Qty. per Unit of Measure";
            //#7582
            SalesLine."Found Price" := SalesLine."Unit Price";
        END ELSE
            SalesLine."Found Price" := 0;
        //#7582//
        //DEVIS//
        //OUVRAGE
        //DYS champs "Cross-Reference No." supprimer 
        // IF (ResPrice."Cross-Reference No." <> '') THEN
        //   SalesLine."Cross-Reference No." := ResPrice."Cross-Reference No.";
        //#6814
        //        IF ("Cross-Reference No." <> '') AND (Type > 0) THEN BEGIN
        //IF (SalesLine."Cross-Reference No." <> '') AND 
        IF (SalesLine.Type > 0) AND (SalesLine."Cross-Ref. Line No." <> SalesLine."Line No.") THEN BEGIN
            //#6814//
            lTotalNeedParam.SETRANGE("Document Type", SalesLine."Document Type");
            lTotalNeedParam.SETRANGE("Document No.", SalesLine."Document No.");
            lTotalNeedParam.SETRANGE(Type, lTotalNeedParam.Type::"Cross-Reference");
            //DYS
            //  lTotalNeedParam.SETRANGE("No.", SalesLine."Cross-Reference No.");
            IF NOT lTotalNeedParam.ISEMPTY THEN BEGIN
                lTotalNeedParam.FIND('-');
                SalesLine.VALIDATE("Unit Price", lTotalNeedParam.Value);
                SalesLine."Fixed Price" := TRUE;
            END;
        END;
        //DISC
        //#6740
        //        IF "Line Discount %" <> 0 THEN
        //#6740//
        SalesLine.VALIDATE("Line Discount %");
        //DISC//
        //OUVRAGE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnFindSalesLineLineDiscOnBeforeCalcLineDisc', '', true, true)]
    local procedure OnFindSalesLineLineDiscOnBeforeCalcLineDisc(var SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var TempSalesLineDiscount: Record "Sales Line Discount" temporary; Qty: Decimal; QtyPerUOM: Decimal; var IsHandled: Boolean)
    var
        CduSalespriceMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        if SalesLine.Type = SalesLine.Type::Item then begin
            CduSalespriceMgt.SalesLineLineDiscExists(SalesHeader, SalesLine, false);
            CduSalespriceMgt.CalcBestLineDisc(TempSalesLineDiscount);
            SalesLine."Line Discount %" := TempSalesLineDiscount."Line Discount %";
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeFindServLineDisc', '', true, true)]
    local procedure OnBeforeFindServLineDisc(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; var IsHandled: Boolean)
    var
        CduSalespriceMgt: Codeunit "Sales Price Calc. Mgt.";
        Item: Record item;
        Currency: Record Currency;
        Resource: Record Resource;
        TempSalesLineDisc: Record "Sales Line Discount";
    begin
        CduSalespriceMgt.SetCurrency(ServiceHeader."Currency Code", 0, 0D);
        CduSalespriceMgt.SetUoM(Abs(ServiceLine.Quantity), ServiceLine."Qty. per Unit of Measure");

        ServiceLine.TestField("Qty. per Unit of Measure");
        CASE ServiceLine.Type OF
            ServiceLine.Type::Item:
                BEGIN
                    Item.GET(ServiceLine."No.");
                    CduSalespriceMgt.FindSalesLineDisc(
                      TempSalesLineDisc, ServiceLine."Bill-to Customer No.", ServiceHeader."Contact No.",
                      ServiceLine."Customer Disc. Group", '', ServiceLine."No.", Item."Item Disc. Group", ServiceLine."Variant Code",
                      ServiceLine."Unit of Measure Code", ServiceHeader."Currency Code", ServiceHeader."Order Date", FALSE);
                    CduSalespriceMgt.CalcBestLineDisc(TempSalesLineDisc);
                    ServiceLine."Line Discount %" := TempSalesLineDisc."Line Discount %";
                    ServiceLine."Line Discount Amount" :=
                      ROUND(
                        ROUND(ServiceLine.CalcChargeableQty * ServiceLine."Unit Price", Currency."Amount Rounding Precision") *
                        ServiceLine."Line Discount %" / 100, Currency."Amount Rounding Precision");
                    ServiceLine."Inv. Discount Amount" := 0;
                    ServiceLine."Inv. Disc. Amount to Invoice" := 0;
                END;
            ServiceLine.Type::Resource:
                BEGIN
                    Resource.GET(ServiceLine."No.");
                    //DYS Fonction FindSalesLineResDisc supprimer
                    //  FindSalesLineResDisc(
                    // TempSalesLineDisc, ServiceLine."Bill-to Customer No.", ServiceHeader."Contact No.",
                    //ServiceLine."Customer Disc. Group", '', ServiceLine."No.", Resource."Resource Disc. Group", ServiceLine."Variant Code",
                    //ServiceLine."Unit of Measure Code", ServiceHeader."Currency Code", ServiceHeader."Order Date", FALSE);
                    CduSalespriceMgt.CalcBestLineDisc(TempSalesLineDisc);
                    ServiceLine."Line Discount %" := TempSalesLineDisc."Line Discount %";
                    ServiceLine."Line Discount Amount" :=
                      ROUND(
                        ROUND(ServiceLine.CalcChargeableQty * ServiceLine."Unit Price", Currency."Amount Rounding Precision") *
                        ServiceLine."Line Discount %" / 100, Currency."Amount Rounding Precision");
                    ServiceLine."Inv. Discount Amount" := 0;
                    ServiceLine."Inv. Disc. Amount to Invoice" := 0;
                END;
            ServiceLine.Type::Cost:
                BEGIN
                    ServiceLine."Line Discount %" := 0;
                    ServiceLine."Line Discount Amount" := 0;
                    ServiceLine."Inv. Discount Amount" := 0;
                    ServiceLine."Inv. Disc. Amount to Invoice" := 0;
                END;
        END;
        //DISC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeCopySalesPriceToSalesPrice', '', true, true)]
    local procedure OnBeforeCopySalesPriceToSalesPrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price"; var IsHandled: Boolean)
    begin
        //#4975 IF FromSalesPrice.FINDSET THEN
        IF NOT FromSalesPrice.ISEMPTY THEN BEGIN
            if FromSalesPrice.FindSet() then
                repeat
                    ToSalesPrice := FromSalesPrice;
                    ToSalesPrice.Insert();
                until FromSalesPrice.Next() = 0;
        END;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeSalesLinePriceExistsProcedure', '', true, true)]
    local procedure OnBeforeSalesLinePriceExistsProcedure(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ShowAll: Boolean; var TempSalesPrice: Record "Sales Price" temporary; var Result: Boolean; var IsHandled: Boolean)
    begin
        //DEVIS
        //EXIT(SalesLine."Found Price" <> 0);
        IF SalesLine."Found Price" <> 0 THEN
            IsHandled := true;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeSalesLinePriceExists', '', true, true)]
    local procedure OnBeforeSalesLinePriceExists(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var TempSalesPrice: Record "Sales Price" temporary; Currency: Record Currency; CurrencyFactor: Decimal; StartingDate: Date; Qty: Decimal; QtyPerUOM: Decimal; ShowAll: Boolean; var InHandled: Boolean)
    var
        CduSalespriceMgt: Codeunit "Sales Price Calc. Mgt.";
        DateCaption: Text[30];
    begin
        CduSalespriceMgt.FindSalesPrice(
                  TempSalesPrice, SalesHeader."Sell-to Customer No.", SalesHeader."Sell-to Contact No.",
                  SalesLine."Customer Price Group", '', SalesLine."No.", SalesLine."Variant Code", SalesLine."Unit of Measure Code",
                  SalesHeader."Currency Code", CduSalespriceMgt.SalesHeaderStartDate(SalesHeader, DateCaption), ShowAll);
        InHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeSalesLineLineDiscExists', '', true, true)]
    local procedure OnBeforeSalesLineLineDiscExists(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var TempSalesLineDisc: Record "Sales Line Discount" temporary; StartingDate: Date; Qty: Decimal; QtyPerUOM: Decimal; ShowAll: Boolean; var IsHandled: Boolean)
    var
        CduSalespriceMgt: Codeunit "Sales Price Calc. Mgt.";
        DateCaption: Text[30];
        Item: Record item;
        Resource: Record Resource;
    begin
        IF Item.GET(SalesLine."No.") THEN;
        CduSalespriceMgt.FindSalesLineDisc(
                  TempSalesLineDisc, SalesHeader."Sell-to Customer No.", SalesHeader."Sell-to Contact No.",
                  SalesLine."Customer Disc. Group", '', SalesLine."No.", Item."Item Disc. Group", SalesLine."Variant Code", SalesLine."Unit of Measure Code",
                  SalesHeader."Currency Code", CduSalespriceMgt.SalesHeaderStartDate(SalesHeader, DateCaption), ShowAll);

        IF (SalesLine.Type = SalesLine.Type::Resource) AND Resource.GET(SalesLine."No.") THEN BEGIN
            Resource.GET(SalesLine."No.");
            //DYS Fonction FindSalesLineResDisc supprimer
            //    FindSalesLineResDisc(
            //    TempSalesLineDisc, SalesLine."Sell-to Customer No.", SalesHeader."Sell-to Contact No.",
            //  SalesLine."Customer Disc. Group", '', SalesLine."No.", Resource."Resource Disc. Group", SalesLine."Variant Code", SalesLine."Unit of Measure Code",
            // SalesHeader."Currency Code", CduSalespriceMgt.SalesHeaderStartDate(SalesHeader, DateCaption), ShowAll);
            //#4975    EXIT(TempSalesLineDisc.FIND('-'));
            IsHandled := NOT TempSalesLineDisc.ISEMPTY;
            //#4975//
        end;
        IF not IsHandled then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeFindJobJnlLinePrice', '', true, true)]
    local procedure OnBeforeFindJobJnlLinePrice(var JobJournalLine: Record "Job Journal Line"; CalledByFieldNo: Integer; var IsHandled: Boolean)
    begin
        //RES_USAGE
        IF JobJournalLine."Job No." = '' THEN
            IsHandled := true;
        //RES_USAGE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeFindJobPlanningLinePrice', '', true, true)]
    local procedure OnBeforeFindJobPlanningLinePrice(var JobPlanningLine: Record "Job Planning Line"; CalledByFieldNo: Integer; var IsHandled: Boolean)
    begin

        //RES_USAGE
        IF JobPlanningLine."Job No." = '' THEN
            IsHandled := true;
        //RES_USAGE//
    end;

    //*************************************Codeunit 7010 ************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnBeforeFindReqLinePrice', '', true, true)]
    local procedure OnBeforeFindReqLinePrice(var TempPurchasePrice: Record "Purchase Price" temporary; var ReqLine: Record "Requisition Line"; var IsHandled: Boolean)
    var
        lSalesLine: Record "Sales Line";
        VendorNo: Code[20];
        lStructureLine: Record "Sales Line";
        wResNo: Code[20];
    begin
        //SUBCONTRACTOR
        IF lSalesLine.GET(ReqLine."Sales Document Type" - 1, ReqLine."Sales Order No.", ReqLine."Sales Order Line No.") THEN BEGIN
            IF lStructureLine.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.") THEN
                wResNo := lStructureLine."No.";
        END;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnAfterFindPurchLineLineDisc', '', true, true)]
    local procedure OnAfterFindPurchLineLineDisc(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; var TempPurchLineDisc: Record "Purchase Line Discount" temporary)
    begin
        //+OFF+REMISE
        PurchaseLine."Discount 1 %" := TempPurchLineDisc."Discount 1 %";
        PurchaseLine."Discount 2 %" := TempPurchLineDisc."Discount 2 %";
        PurchaseLine."Discount 3 %" := TempPurchLineDisc."Discount 3 %";
        //+OFF+REMISE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnCalcBestDirectUnitCostOnBeforeNoPriceFound', '', true, true)]
    local procedure OnCalcBestDirectUnitCostOnBeforeNoPriceFound(var PurchasePrice: Record "Purchase Price"; Item: Record Item; var IsHandled: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnFindPurchLineDiscOnAfterSetFilters', '', true, true)]
    local procedure OnFindPurchLineDiscOnAfterSetFilters(var FromPurchLineDisc: Record "Purchase Line Discount");
    begin
        //+OFF+REMISE
        //REMISE_FOURN
        //DYS champs code "Purchase Code" supprimer
        //FromPurchLineDisc.SETRANGE(Code);
        //FromPurchLineDisc.SETRANGE("Purchase Code");
        //+OFF+REMISE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnAfterFindPurchLineDisc', '', true, true)]
    local procedure OnAfterFindPurchLineDisc(var ToPurchaseLineDiscount: Record "Purchase Line Discount"; var FromPurchaseLineDiscount: Record "Purchase Line Discount"; ItemNo: Code[20]; QuantityPerUoM: Decimal; Quantity: Decimal; ShowAll: Boolean)
    begin
        FOR FromPurchaseLineDiscount."Purchase Type" := FromPurchaseLineDiscount."Purchase Type"::Vendor TO FromPurchaseLineDiscount."Purchase Type"::"All Vendors" DO BEGIN
            IF (FromPurchaseLineDiscount."Purchase Type" = FromPurchaseLineDiscount."Purchase Type"::"All Vendors") OR
               ((FromPurchaseLineDiscount."Purchase Type" = FromPurchaseLineDiscount."Purchase Type"::Vendor) AND (VendorNo <> '')) OR
               ((FromPurchaseLineDiscount."Purchase Type" = FromPurchaseLineDiscount."Purchase Type"::"Vendor Disc. Group") AND (pVendDiscGroup <> ''))
            THEN BEGIN
                ToPurchaseLineDiscount.SETRANGE("Purchase Type", FromPurchaseLineDiscount."Purchase Type");
                CASE FromPurchaseLineDiscount."Purchase Type" OF
                //FromPurchaseLineDiscount."Purchase Type"::"All Vendors":
                //DYS champs "Purchase Code" supprimer
                // ToPurchaseLineDiscount.SETRANGE("Purchase Code");
                //FromPurchaseLineDiscount."Purchase Type"::Vendor:
                //  ToPurchaseLineDiscount.SETRANGE("Purchase Code", VendorNo);
                //FromPurchaseLineDiscount."Purchase Type"::"Vendor Disc. Group":
                //  ToPurchaseLineDiscount.SETRANGE("Purchase Code", pVendDiscGroup);
                END;

                ToPurchaseLineDiscount.SETRANGE(Type, ToPurchaseLineDiscount.Type::Item);
                //DYS champs CODE supprimer
                //ToPurchaseLineDiscount.SETRANGE(Code, pItemNo);
                wCopyPurchDiscToPurchDisc(FromPurchaseLineDiscount, ToPurchaseLineDiscount);

                IF pItemDiscGroup <> '' THEN BEGIN
                    ToPurchaseLineDiscount.SETRANGE(Type, ToPurchaseLineDiscount.Type::"Item Disc. Group");
                    //DYS champs CODE supprimer
                    // ToPurchaseLineDiscount.SETRANGE(Code, pItemDiscGroup);
                    wCopyPurchDiscToPurchDisc(FromPurchaseLineDiscount, ToPurchaseLineDiscount);
                END;
            END;
        END;
        //+OFF+REMISE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Price Calc. Mgt.", 'OnBeforePurchLineLineDiscExists', '', true, true)]
    local procedure OnBeforePurchLineLineDiscExists(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; var TempPurchLineDisc: Record "Purchase Line Discount" temporary; ShowAll: Boolean; var IsHandled: Boolean; var DateCaption: Text[30])
    begin
        // FindPurchLineDisc(
        //           TempPurchLineDisc, PurchLine."Pay-to Vendor No.", PurchLine."No.", PurchLine."Variant Code", PurchLine."Unit of Measure Code",
        //           PurchHeader."Currency Code", PurchHeaderStartDate(PurchHeader, DateCaption), ShowAll,
        //           PurchLine."Qty. per Unit of Measure", PurchLine.Quantity);

        //     exit(TempPurchLineDisc.Find('-'));
    end;

    PROCEDURE wCopyPurchDiscToPurchDisc(VAR FromPurchLineDisc: Record "Purchase Line Discount"; VAR ToPurchLineDisc: Record "Purchase Line Discount");
    BEGIN
        //+OFF+REMISE
        WITH ToPurchLineDisc DO BEGIN
            IF FromPurchLineDisc.FIND('-') THEN
                REPEAT
                    IF FromPurchLineDisc."Line Discount %" <> 0 THEN BEGIN
                        ToPurchLineDisc := FromPurchLineDisc;
                        INSERT;
                    END;
                UNTIL FromPurchLineDisc.NEXT = 0;
        END;
        //+OFF+REMISE//
    END;

    //*************************************Codeunit 10801************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RIB Key", 'OnBeforeCheck', '', true, true)]
    local procedure OnBeforeCheck(Bank: Text; Agency: Text; Account: Text; RIBKey: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        LongAccountNum: Code[30];
        Index: Integer;
        Remaining: Integer;
        Coding: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Uncoding: Label '12345678912345678923456789';
    begin
        //MODIFIE PAR BSK REMPLACE PAR LE RIB TUNISIEN 09/03/11
        IsHandled := true;
        Result := true;
        IF NOT ((STRLEN(Bank) = 2) AND//4
               (STRLEN(Agency) = 3) AND //5
               (STRLEN(Account) = 13) AND  //11
               (RIBKey < 100)) THEN
            Result := false;
        IF Result then begin


            LongAccountNum :=
 CopyStr(Bank + Agency + Account + ConvertStr(Format(RIBKey, 2), ' ', '0'), 1, MaxStrLen(LongAccountNum));
            LongAccountNum := ConvertStr(LongAccountNum, Coding, Uncoding);

            Remaining := 0;
            for Index := 1 to 20 do
                Remaining := (Remaining * 10 + (LongAccountNum[Index] - '0')) mod 97;
            Result := (Remaining = 0);
        end;
    end;

    PROCEDURE CheckRIb(Bank: Text[20]; Agency: Text[20]; Account: Text[30]; RIBKey: Text[30]): Boolean;
    VAR
        LongAccountNum: Code[30];
        Index: Integer;
        Remaining: Integer;
        Coding: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Uncoding: Label '12345678912345678923456789';
    BEGIN

        //MODIFIE PAR BSK REMPLACE PAR LE RIB TUNISIEN 09/03/11
        /*IF NOT ((STRLEN(Bank) = 5) AND
               (STRLEN(Agency) = 5) AND
               (STRLEN(Account) = 11) AND
               (RIBKey < 100)) THEN
              EXIT(FALSE);

          LongAccountNum := Bank + Agency + Account + CONVERTSTR(FORMAT(RIBKey, 2), ' ', '0');
          LongAccountNum := CONVERTSTR(LongAccountNum, Coding, Uncoding);

          Remaining := 0;
          FOR Index := 1 TO 23 DO
              Remaining := (Remaining * 10 + (LongAccountNum[Index] - '0')) MOD 97;

          EXIT(Remaining = 0);  */
        //MODIFIE PAR BSK REMPLACE PAR LE RIB TUNISIEN 09/03/11


        IF NOT ((STRLEN(Bank) = 2) AND//4
               (STRLEN(Agency) = 3) AND //5
               (STRLEN(Account) = 13) AND  //11
               (STRLEN(RIBKey) = 2)) THEN
            EXIT(FALSE);

        LongAccountNum := Bank + Agency + Account + CONVERTSTR(FORMAT(RIBKey, 2), ' ', '0');
        LongAccountNum := CONVERTSTR(LongAccountNum, Coding, Uncoding);

        Remaining := 0;
        FOR Index := 1 TO 20 DO//23
            Remaining := (Remaining * 10 + (LongAccountNum[Index] - '0')) MOD 97;

        EXIT(Remaining = 0);
    END;

    //*************************************Codeunit 99000773************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnBeforeTransferBOM', '', true, true)]
    local procedure OnBeforeTransferBOM(var ProdOrder: Record "Production Order"; var ProdOrderLine: Record "Prod. Order Line"; ProdBOMNo: Code[20]; Level: Integer; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal; Blocked: Boolean; var ErrorOccured: Boolean; var IsHandled: Boolean)
    var
        BOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
        ReqQty: Decimal;
        ProdOrderComp: Record "Prod. Order Component";
        VersionCode: Code[20];
        Text000: Label 'BOM phantom structure for %1 is higher than 50 levels.';
        VersionMgt: Codeunit VersionManagement;
        ProdBOMLine: array[99] of Record "Production BOM Line";
        ProdOrderRoutingLine2: Record "Prod. Order Routing Line";
        SkipTransfer: Boolean;
        CduCalcPordorder: Codeunit "Calculate Prod. Order";
    begin
        // if ProdBOMNo = '' then
        //     exit;

        // ProdOrderComp.LockTable();

        // if Level > 50 then
        //     Error(
        //       Text000,
        //       ProdBOMNo);

        // BOMHeader.Get(ProdBOMNo);

        // if Level > 1 then
        //     VersionCode := VersionMgt.GetBOMVersion(ProdBOMNo, ProdOrderLine."Starting Date", true)
        // else
        //     VersionCode := ProdOrderLine."Production BOM Version Code";

        // if VersionCode <> '' then begin
        //     ProductionBOMVersion.Get(ProdBOMNo, VersionCode);
        //     ProductionBOMVersion.TestField(Status, ProductionBOMVersion.Status::Certified);
        // end else
        //     BOMHeader.TestField(Status, BOMHeader.Status::Certified);

        // ProdBOMLine[Level].SetRange("Production BOM No.", ProdBOMNo);
        // ProdBOMLine[Level].SetRange("Version Code", VersionCode);
        // ProdBOMLine[Level].SetFilter("Starting Date", '%1|..%2', 0D, ProdOrderLine."Starting Date");
        // ProdBOMLine[Level].SetFilter("Ending Date", '%1|%2..', 0D, ProdOrderLine."Starting Date");

        // if ProdBOMLine[Level].Find('-') then
        //     repeat
        //         IsHandled := false;

        //         if not IsHandled then begin
        //             if ProdBOMLine[Level]."Routing Link Code" <> '' then begin
        //                 ProdOrderRoutingLine2.SetRange(Status, ProdOrderLine.Status);
        //                 ProdOrderRoutingLine2.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        //                 ProdOrderRoutingLine2.SetRange("Routing Link Code", ProdBOMLine[Level]."Routing Link Code");
        //                 ProdOrderRoutingLine2.FindFirst();
        //                 ReqQty :=
        //                   ProdBOMLine[Level].Quantity * (1 + ProdBOMLine[Level]."Scrap %" / 100) *
        //                   (1 + ProdOrderRoutingLine2."Scrap Factor % (Accumulated)") * LineQtyPerUOM / ItemQtyPerUOM +
        //                   ProdOrderRoutingLine2."Fixed Scrap Qty. (Accum.)";
        //             end else
        //                 ReqQty :=
        //                   ProdBOMLine[Level].Quantity * (1 + ProdBOMLine[Level]."Scrap %" / 100) * LineQtyPerUOM / ItemQtyPerUOM;



        //             case ProdBOMLine[Level].Type of
        //                 ProdBOMLine[Level].Type::Item:
        //                     begin
        //                         SkipTransfer := false;

        //                         if not SkipTransfer then
        //                             TransferBOMProcessItem(Level, LineQtyPerUOM, ItemQtyPerUOM, ErrorOccured);
        //                     end;
        //                 ProdBOMLine[Level].Type::"Production BOM":
        //                     begin

        //                         TransferBOM(ProdBOMLine[Level]."No.", Level + 1, ReqQty, 1);
        //                         ProdBOMLine[Level].SetRange("Production BOM No.", ProdBOMNo);
        //                         if Level > 1 then
        //                             ProdBOMLine[Level].SetRange("Version Code", VersionMgt.GetBOMVersion(ProdBOMNo, ProdOrderLine."Starting Date", true))
        //                         else
        //                             ProdBOMLine[Level].SetRange("Version Code", ProdOrderLine."Production BOM Version Code");
        //                         ProdBOMLine[Level].SetFilter("Starting Date", '%1|..%2', 0D, ProdOrderLine."Starting Date");
        //                         ProdBOMLine[Level].SetFilter("Ending Date", '%1|%2..', 0D, ProdOrderLine."Starting Date");
        //                     end;
        //             end;
        //         end;
        //     until ProdBOMLine[Level].Next() = 0;



        // exit(not ErrorOccured);
    end;


    //*************************************Codeunit 99000854************************************************//

    [EventSubscriber(ObjectType::TABLE, Database::"Sales Line", 'OnAfterFilterLinesWithItemToPlan', '', true, true)]
    local procedure OnAfterFilterLinesWithItemToPlan(var SalesLine: Record "Sales Line"; var Item: Record Item; DocumentType: Option)
    begin
        //CDE_INT
        SalesLine.SETRANGE("Supply Order No.", '');
        //CDE_INT//
        //#4848
        SalesLine.SETRANGE("Structure Line No.", 0);
        //#4848//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Profile Offsetting", 'OnMaintainPlanningLineOnAfterPopulateReqLineFields', '', true, true)]
    local procedure OnMaintainPlanningLineOnAfterPopulateReqLineFields(var ReqLine: Record "Requisition Line"; var SupplyInvtProfile: Record "Inventory Profile"; DemandInvtProfile: Record "Inventory Profile"; NewPhase: Option " ","Line Created","Routing Created",Exploded,Obsolete; Direction: Option Forward,Backward; var TempSKU: Record "Stockkeeping Unit")
    var
        lLocation: Record Location;
    begin
        //#4849
        IF (ReqLine."Job No." = '') AND lLocation.GET(ReqLine."Location Code") THEN
            ReqLine."Job No." := lLocation."Bal. Job No.";
        //#4849
    end;

    //*************************************Codeunit 8************************************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, 'OnBeforeSetGLAccRowFilters', '', true, true)]
    local procedure OnBeforeSetGLAccRowFilters(var GLAcc: Record "G/L Account"; var AccSchedLine2: Record "Acc. Schedule Line"; var IsHandled: Boolean)
    begin
        case AccSchedLine2."Totaling Type" of
            AccSchedLine2."Totaling Type"::"Posting Accounts":
                begin
                    GLAcc.SetFilter("No.", AccSchedLine2.Totaling);
                    GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
                    //>>MBY 27/04/2009
                    IF AccSchedLine2."Totalisation débiteur" <> '' THEN
                        GLAcc.SETFILTER(GLAcc."Net Change", '>%1', 0);
                    IF AccSchedLine2."Totalisation créditeur" <> '' THEN
                        GLAcc.SETFILTER(GLAcc."Net Change", '<%1', 0);
                    //<<MBY

                end;
            AccSchedLine2."Totaling Type"::"Total Accounts":
                begin
                    GLAcc.SetFilter("No.", AccSchedLine2.Totaling);
                    GLAcc.SetFilter("Account Type", '<>%1', GLAcc."Account Type"::Posting);
                    //>>MBY 27/04/2009
                    IF AccSchedLine2."Totalisation débiteur" <> '' THEN
                        GLAcc.SETFILTER(GLAcc."Net Change", '>%1', 0);
                    IF AccSchedLine2."Totalisation créditeur" <> '' THEN
                        GLAcc.SETFILTER(GLAcc."Net Change", '<%1', 0);
                    //<<MBY

                end;
        end;

        IsHandled := true;
    end;

    //*************************************Codeunit 11************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeCheckJobNoIsEmpty', '', true, true)]
    local procedure OnBeforeCheckJobNoIsEmpty(GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    // //*************************************Codeunit 11************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeCheckElectronicPaymentFields', '', true, true)]
    local procedure OnBeforeCheckElectronicPaymentFields(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            lGenJnlPaymentIntegr.GenCheckBankAccount(GenJnlLine);
        //+PMT+PAYMENT//
    end;
    //*************************************Codeunit 11************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnAfterCheckBalAccountNo', '', true, true)]
    local procedure OnAfterCheckBalAccountNo(var GenJournalLine: Record "Gen. Journal Line")
    var
        lGenJnlPaymentIntegr: Codeunit "Gen. Jnl-Post Payment Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
    begin
        //+PMT+PAYMENT
        IF gAddOnLicencePermission.HasPermissionPMT THEN
            IF GenJournalLine."Payment Type" = GenJournalLine."Payment Type"::Bill THEN
                GenJournalLine.TESTFIELD("Due Date");
        //+PMT+PAYMENT//
    end;



    //*************************************Codeunit 12************************************************//





    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostGLAccOnBeforePostJob', '', true, true)]
    // local procedure OnPostGLAccOnBeforePostJob(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean; Balancing: Boolean)
    // var
    //     CDU_GenjnlPostLine: Codeunit 12;

    // begin
    //     //#8874
    //     //+ABO+
    //     IF GenJournalLine."Subscription Entry No." = 0 THEN
    //         //+ABO+//
    //         //#8874//
    //         CDU_GenjnlPostLine.PostJob(GenJournalLine, GLEntry);
    //     //+ABO+//
    //     //#8874//
    //     IsHandled := true;
    // end;





    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostCustOnAfterCopyCVLedgEntryBuf', '', true, true)]
    // local procedure OnPostCustOnAfterCopyCVLedgEntryBuf(var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; GenJournalLine: Record "Gen. Journal Line"; Customer: Record Customer; CustLedgEntry: Record "Cust. Ledger Entry"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary)
    // var
    //     gAddOnLicencePermission: Codeunit IntegrManagement;
    //     CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
    //     OldCustLedgEntry: Record "Cust. Ledger Entry";
    // begin
    //     if GenJournalLine."Recurring Method" = GenJournalLine."Recurring Method"::" " then begin
    //         IF GenJournalLine."Document Type" IN
    //        [GenJournalLine."Document Type"::Invoice,
    //         GenJournalLine."Document Type"::"Credit Memo",
    //         GenJournalLine."Document Type"::"Finance Charge Memo",
    //         GenJournalLine."Document Type"::Reminder]
    //     THEN BEGIN
    //             OldCustLedgEntry.Reset();
    //             OldCustLedgEntry.SETCURRENTKEY("Document No.");
    //             OldCustLedgEntry.SETRANGE("Document No.", CVLedgEntryBuf."Document No.");
    //             OldCustLedgEntry.SETRANGE("Document Type", CVLedgEntryBuf."Document Type");
    //             if OldCustLedgEntry.FindFirst() then begin
    //                 //+PMT+MULTI
    //                 IF gAddOnLicencePermission.HasPermissionPMT THEN
    //                     OldCustLedgEntry.SETFILTER("Customer No.", '<>%1', CVLedgEntryBuf."CV No.");
    //                 //+PMT+MULTI//
    //             end;
    //         end;
    //     end;
    // end;

















    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInitGLEntry', '', true, true)]
    // local procedure OnBeforeInitGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLAccNo: Code[20]; SystemCreatedEntry: Boolean; Amount: Decimal; AmountAddCurr: Decimal; FADimAlreadyChecked: Boolean; var IsHandled: Boolean; var GLEntry: Record "G/L Entry"; UseAmountAddCurr: Boolean; NextEntryNo: Integer; NextTransactionNo: Integer)
    // var
    //     GLAcc: Record "G/L Account";
    //     CDU12: Codeunit 12;
    //     lBARIntegr: Codeunit 8001608;
    //     gAddOnLicencePermission: Codeunit IntegrManagement;
    //     CDUGenJnlPostLine_CDU12: Codeunit "Gen. Jnl.-Post Line_CDU12";
    //     gGenJnlSubscriptionIntegr: Codeunit "Gen. Jnl. Subscription Integr.";
    //     GFolio: Code[20];
    //     wText020: label 'The %1 used in %2 , %4, %5 has caused an error. Select a %6 for the %7 %8.';
    //     wText021: label 'The %1 used in %2 , %4, %5 has caused an error. Select the %6 %7 for the %7 %8.';
    //     wText022: label 'The %1 used in %2 , %4, %5 has caused an error. %6 %7 must not be mentioned for the %8 %9.';
    // begin



    //     if GLAccNo <> '' then begin 
    //         GLAcc.Get(GLAccNo);

    //         IsHandled := false;
    //         if not IsHandled then
    //             GLAcc.TestField(Blocked, false);
    //         GLAcc.TestField("Account Type", GLAcc."Account Type"::Posting);

    //         //PROJET
    //         CDUGenJnlPostLine_CDU12.wInitGLEntryWithJob(GenJournalLine, GLAccNo);
    //         //PROJET//

    //         // Check the Value Posting field on the G/L Account if it is not checked already in Codeunit 11
    //         if (not
    //             ((GLAccNo = GenJournalLine."Account No.") and
    //             (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"G/L Account")) or
    //             ((GLAccNo = GenJournalLine."Bal. Account No.") and
    //             (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"G/L Account"))) and
    //         not FADimAlreadyChecked
    //         then begin
    //             CDU12.CheckGLAccDimError(GenJournalLine, GLAccNo);
    //         end;
    //     end;
    //     //PROJET
    //     IF CLOSINGDATE(GenJournalLine."Posting Date") <> GenJournalLine."Posting Date" THEN BEGIN
    //         CASE GLAcc."Job Posting" OF
    //             GLAcc."Job Posting"::"Code Mandatory":
    //                 IF GenJournalLine."Job No." = '' THEN
    //                     ERROR(
    //                       wText020,
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GenJournalLine.TABLECAPTION,
    //                       GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name",
    //                       GenJournalLine."Line No.",
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GLAcc.TABLECAPTION, GLAcc."No.");
    //             GLAcc."Job Posting"::"Same Code":
    //                 IF GLAcc."Job No." <> GenJournalLine."Job No." THEN
    //                     ERROR(
    //                       wText021,
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GenJournalLine.TABLECAPTION, GenJournalLine."Journal Template Name",
    //                       GenJournalLine."Journal Batch Name", GenJournalLine."Line No.",
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GLAcc."Job No.",
    //                       GLAcc.TABLECAPTION, GLAcc."No.");
    //             GLAcc."Job Posting"::"No Code":
    //                 IF GenJournalLine."Job No." <> '' THEN
    //                     ERROR(
    //                       wText022,
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GenJournalLine.TABLECAPTION, GenJournalLine."Journal Template Name",
    //                       GenJournalLine."Journal Batch Name", GenJournalLine."Line No.",
    //                       GLAcc.FIELDCAPTION(GLAcc."Job No."),
    //                       GLAcc."Job No.",
    //                       GLAcc.TABLECAPTION, GLAcc."No.");
    //         END;
    //     END;
    //     GLEntry.Init();
    //     GLEntry."Posting Date" := GenJournalLine."Posting Date";
    //     //PROJET//
    //     //+RAP+RAPPRO  : contr“le code motif
    //     //#8882
    //     IF NOT GenJournalLine."System-Created Entry" THEN
    //         //#8882//
    //         IF gAddOnLicencePermission.HasPermissionRAP() THEN
    //             lBARIntegr.CheckReasonCode(GenJournalLine, GLAcc);
    //     //+RAP+RAPPRO//
    //     //+ABO+
    //     IF gAddOnLicencePermission.HasPermissionABO THEN
    //         gGenJnlSubscriptionIntegr.ControlDateSubscription(GenJournalLine, GLAcc);
    //     //+ABO+//
    //     GLEntry.Init();
    //     // >> HJ SORO 09-09-2014
    //     GLEntry."Date Echeance" := GenJournalLine."Date Echeance";
    //     GLEntry.Lettre := GenJournalLine.Lettre;
    //     GLEntry.salarie := GenJournalLine.Salarie;
    //     IF GenJournalLine."N° Bordereau" <> '' THEN
    //         GFolio := GenJournalLine."N° Bordereau"
    //     ELSE
    //         IF GFolio = '' THEN GFolio := GenJournalLine."Document No.";

    //     GLEntry."Folio N°" := GFolio;

    //     GLEntry."Folio N°" := GFolio;

    //     //GLEntry.salarie:=GenJnlLine.Salarie;
    //     // >> HJ SORO 09-09-2014

    //     // RB SORO 27/04/2015
    //     GLEntry."Folio N° RS" := GenJournalLine."Folio N° RS";
    //     // RB SORO 27/04/2015

    //     GLEntry.CopyFromGenJnlLine(GenJournalLine);
    //     //PROJET
    //     GLEntry."Gen. Prod. Posting Group" := GenJournalLine."Gen. Prod. Posting Group";
    //     //PROJET//
    //     GLEntry."Entry No." := NextEntryNo;
    //     GLEntry."Transaction No." := NextTransactionNo; 
    //     GLEntry."G/L Account No." := GLAccNo;
    //     GLEntry."System-Created Entry" := SystemCreatedEntry;
    //     GLEntry.Amount := Amount;
    //     //+ABO+
    //     IF gAddOnLicencePermission.HasPermissionABO THEN
    //         gGenJnlSubscriptionIntegr.SetGLEntrySubscription(GLEntry, GenJournalLine);
    //     //+ABO+//
    //     GLEntry."Additional-Currency Amount" :=
    //          CDU12.GLCalcAddCurrency(Amount, AmountAddCurr, GLEntry."Additional-Currency Amount", UseAmountAddCurr, GenJournalLine);
    //     GLEntry."Source Currency Code" := GenJournalLine."Source Currency Code";
    //     GLEntry."Source Currency Amount" := GenJournalLine."Source Currency Amount";

    //     IsHandled := true;
    // end;



    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry', '', true, true)]
    // local procedure OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    // var
    //     gAddOnLicencePermission: Codeunit IntegrManagement;
    //     lGenJnlPaymentIntegr: Codeunit 8004108;
    //     GLSetup: Record "General Ledger Setup";
    //     TempVATEntry: Record "VAT Entry" temporary;
    //     CDUGenJnlPostLine_CDU12: Codeunit "Gen. Jnl.-Post Line_CDU12";

    // begin
    //     //NAVISION
    //     TempVATEntry.DELETEALL;
    //     IF GLSetup."Unrealized VAT" THEN
    //         CDUGenJnlPostLine_CDU12.PrepareCheckForUnreaVat(NewCVLedgerEntryBuffer."Transaction No.", TempVATEntry);
    //     //NAVISION//

    //     //+PMT+PAYMENT
    //     IF gAddOnLicencePermission.HasPermissionPMT THEN
    //         lGenJnlPaymentIntegr.SetDueDateGenJnlLine(GenJournalLine, NewCVLedgerEntryBuffer);
    //     //+PMT+PAYMENT//
    // end;



    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePrepareTempCustledgEntry', '', true, true)]
    // local procedure OnBeforePrepareTempCustledgEntry(var GenJnlLine: Record "Gen. Journal Line"; var CVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; Customer: Record Customer; var ApplyingDate: Date; var Result: Boolean; var IsHandled: Boolean; var TempOldCustLedgEntry: Record "Cust. Ledger Entry" temporary)
    // var
    //     OldCustLedgEntry: Record "Cust. Ledger Entry";
    //     GenJnlApply: Codeunit "Gen. Jnl.-Apply";
    //     RemainingAmount: Decimal;
    //     SalesSetup: Record "Sales & Receivables Setup";
    //     PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    //     TempVATEntry: Record 254 TEMPORARY;
    //     lGenJnlPaymentIntegr: Codeunit 8004108;
    //     wNavibatSetup: Record NavibatSetup;
    //     Text8003900: label 'You can''t cancel the %1 %2 because it''s always applied';
    //     ErrJob: label 'You can''t apply between differents jobs';

    // begin
    //     IsHandled := false;
    //     if GenJnlLine."Applies-to Doc. No." <> '' then begin
    //         // Find the entry to be applied to
    //         OldCustLedgEntry.Reset();
    //         OldCustLedgEntry.SetLoadFields(Positive, "Posting Date", "Currency Code");
    //         OldCustLedgEntry.SetCurrentKey("Document No.");
    //         OldCustLedgEntry.SetRange("Document No.", GenJnlLine."Applies-to Doc. No.");
    //         OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Applies-to Doc. Type");
    //         OldCustLedgEntry.SetRange("Customer No.", CVLedgerEntryBuffer."CV No.");
    //         OldCustLedgEntry.SetRange(Open, true);
    //         //GL2024    OldCustLedgEntry.FindFirst();
    //         //#7753  OldCustLedgEntry.FINDFIRST;
    //         IF OldCustLedgEntry.ISEMPTY THEN
    //             ERROR(Text8003900, GenJnlLine."Applies-to Doc. Type", GenJnlLine."Applies-to Doc. No.");
    //         //#7753//
    //         //+PMT+PAYMENT
    //         OldCustLedgEntry.FINDSET;
    //         REPEAT
    //             //+PMT+PAYMENT//

    //             if not IsHandled then
    //                 if not ((GenJnlLine.Amount < 0) and
    //                         (GenJnlLine."Document Type" = GenJnlLine."Document Type"::" ") and
    //                         (GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer) and
    //                         (GenJnlLine."Applies-to Doc. Type" = GenJnlLine."Applies-to Doc. Type"::"Finance Charge Memo") and
    //                         (GenJnlLine."Applies-to Doc. No." <> '')) then
    //                     OldCustLedgEntry.TestField(Positive, not CVLedgerEntryBuffer.Positive);

    //             if OldCustLedgEntry."Posting Date" > ApplyingDate then
    //                 ApplyingDate := OldCustLedgEntry."Posting Date";
    //             GenJnlApply.CheckAgainstApplnCurrency(
    //               CVLedgerEntryBuffer."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, true);
    //             TempOldCustLedgEntry := OldCustLedgEntry;
    //             TempOldCustLedgEntry.Insert();
    //             //PROJET
    //             IF (CVLedgerEntryBuffer."Job No." <> OldCustLedgEntry."Job No.") AND
    //                (wNavibatSetup."Appln. between Job" = wNavibatSetup."Appln. between Job"::"Same Job") THEN
    //                 ERROR(ErrJob);
    //         //PROJET//
    //         //+PMT+
    //         UNTIL OldCustLedgEntry.NEXT = 0;

    //         IF NOT TempOldCustLedgEntry.FIND('-') THEN
    //             EXIT;
    //         //+PMT+//
    //     end else begin
    //         // Find the first old entry (Invoice) which the new entry (Payment) should apply to
    //         OldCustLedgEntry.Reset();
    //         OldCustLedgEntry.SetLoadFields("Posting Date", "Currency Code", "Applies-to ID");
    //         OldCustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
    //         TempOldCustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
    //         OldCustLedgEntry.SetRange("Customer No.", CVLedgerEntryBuffer."CV No.");
    //         OldCustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
    //         OldCustLedgEntry.SetRange(Open, true);
    //         OldCustLedgEntry.SetFilter("Entry No.", '<>%1', CVLedgerEntryBuffer."Entry No.");
    //         if not (Customer."Application Method" = Customer."Application Method"::"Apply to Oldest") then
    //             OldCustLedgEntry.SetFilter("Amount to Apply", '<>%1', 0);

    //         if Customer."Application Method" = Customer."Application Method"::"Apply to Oldest" then
    //             OldCustLedgEntry.SetFilter("Posting Date", '..%1', GenJnlLine."Posting Date");

    //         // Check Cust Ledger Entry and add to Temp.
    //         SalesSetup.Get();
    //         if SalesSetup."Appln. between Currencies" = SalesSetup."Appln. between Currencies"::None then
    //             OldCustLedgEntry.SetRange("Currency Code", CVLedgerEntryBuffer."Currency Code");
    //         if OldCustLedgEntry.FindSet(false) then
    //             repeat
    //                 if GenJnlApply.CheckAgainstApplnCurrency(
    //                      CVLedgerEntryBuffer."Currency Code", OldCustLedgEntry."Currency Code", GenJnlLine."Account Type"::Customer, false)
    //                 then begin
    //                     if (OldCustLedgEntry."Posting Date" > ApplyingDate) and (OldCustLedgEntry."Applies-to ID" <> '') then
    //                         ApplyingDate := OldCustLedgEntry."Posting Date";
    //                     TempOldCustLedgEntry := OldCustLedgEntry;
    //                     TempOldCustLedgEntry.Insert();
    //                 end;
    //             until OldCustLedgEntry.Next() = 0;

    //         TempOldCustLedgEntry.SetRange(Positive, CVLedgerEntryBuffer."Remaining Amount" > 0);

    //         if TempOldCustLedgEntry.Find('-') then begin
    //             RemainingAmount := CVLedgerEntryBuffer."Remaining Amount";
    //             TempOldCustLedgEntry.SetRange(Positive);
    //             TempOldCustLedgEntry.Find('-');
    //             repeat
    //                 //PROJET
    //                 IF (CVLedgerEntryBuffer."Job No." <> OldCustLedgEntry."Job No.") AND (wNavibatSetup."Appln. between Job" = wNavibatSetup."Appln. between Job"::"Same Job") THEN
    //                     ERROR(ErrJob);
    //                 //PROJET//
    //                 TempOldCustLedgEntry.CalcFields("Remaining Amount");
    //                 TempOldCustLedgEntry.RecalculateAmounts(
    //                   TempOldCustLedgEntry."Currency Code", CVLedgerEntryBuffer."Currency Code", CVLedgerEntryBuffer."Posting Date");
    //                 if PaymentToleranceMgt.CheckCalcPmtDiscCVCust(CVLedgerEntryBuffer, TempOldCustLedgEntry, 0, false, false) then
    //                     TempOldCustLedgEntry."Remaining Amount" -= TempOldCustLedgEntry.GetRemainingPmtDiscPossible(CVLedgerEntryBuffer."Posting Date");
    //                 RemainingAmount += TempOldCustLedgEntry."Remaining Amount";
    //             until TempOldCustLedgEntry.Next() = 0;
    //             TempOldCustLedgEntry.SetRange(Positive, RemainingAmount < 0);
    //         end else
    //             TempOldCustLedgEntry.SetRange(Positive);

    //         //GL2024 exit(TempOldCustLedgEntry.Find('-'));
    //         Result := TempOldCustLedgEntry.Find('-');
    //     end;
    //     //GL2024 exit(true);
    //     Result := true;

    //     IsHandled := true;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry', '', true, true)]
    // local procedure OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var OldCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var TempOldCustLedgEntry: Record "Cust. Ledger Entry"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    // var
    //     wNavibatSetup: Record NavibatSetup;
    //     ErrJob: label 'You can''t apply between differents jobs';

    // begin
    //     //PROJET
    //     IF (NewCVLedgEntryBuf."Job No." <> OldCVLedgerEntryBuffer."Job No.") AND
    //        (wNavibatSetup."Appln. between Job" = wNavibatSetup."Appln. between Job"::"Same Job") THEN
    //         ERROR(ErrJob);
    //     //PROJET//
    // end;



    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertTempVATEntry', '', true, true)]
    // local procedure OnBeforeInsertTempVATEntry(var TempVATEntry: Record "VAT Entry" temporary; GenJournalLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; VATAmount: Decimal; VATBase: Decimal)
    // var
    //     lGenJnlPaymentIntegr: Codeunit 8004108;
    //     gAddOnLicencePermission: Codeunit IntegrManagement;
    // begin
    //     //+PMT+PAYMENT
    //     IF gAddOnLicencePermission.HasPermissionPMT THEN
    //         lGenJnlPaymentIntegr.SetVATEntry(VATEntry, GenJournalLine, TRUE);
    //     //+PMT+PAYMENT//
    // end;












    /*GL2024 [EventSubscriber(ObjectType::Codeunit, 12, 'OnPostDtldVendLedgEntriesOnBeforePostDtldVendLedgEntry', '', true, true)]
     local procedure OnPostDtldVendLedgEntriesOnBeforePostDtldVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; VendPostingGr: Record "Vendor Posting Group"; AdjAmount: array[4] of Decimal; var IsHandled: Boolean)
     var
         wFromDetail: Boolean;
     begin
         //PROJET
         wFromDetail := TRUE;
         //PROJET//
     end;*/

    // [EventSubscriber(ObjectType::Codeunit, 12, 'OnVendUnrealizedVATOnAfterVATPartCalculation', '', true, true)]
    // local procedure OnVendUnrealizedVATOnAfterVATPartCalculation(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry"; PaidAmount: Decimal; TotalUnrealVATAmountFirst: Decimal; TotalUnrealVATAmountLast: Decimal; SettledAmount: Decimal; VATEntry2: Record "VAT Entry")
    // begin

    //     VATEntry2.Reset();
    //     VATEntry2.SetCurrentKey("Transaction No.");
    //     VATEntry2.SetRange("Transaction No.", VendorLedgerEntry."Transaction No.");
    //     PaidAmount := -VendorLedgerEntry."Amount (LCY)" + VendorLedgerEntry."Remaining Amt. (LCY)";
    // end;





    //*************************************Codeunit 13************************************************//



    //*************************************Codeunit 21************************************************//

    // [EventSubscriber(ObjectType::Codeunit, 21, 'OnBeforeDateNotAllowed', '', true, true)]
    // local procedure OnBeforeDateNotAllowed(ItemJnlLine: Record "Item Journal Line"; var DateCheckDone: Boolean)
    // var
    //     UserSetupManagement: Codeunit "User Setup Management";
    // begin
    //     IF ItemJnlLine."Line No." <> 0 THEN
    //         UserSetupManagement.CheckAllowedPostingDate(ItemJnlLine."Posting Date");
    //     DateCheckDone := true;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, 21, 'OnBeforeCheckEmptyQuantity', '', true, true)]
    // local procedure OnBeforeCheckEmptyQuantity(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    // var
    //     Text007: Label 'You cannot post these lines because you have not entered a quantity on one or more of the lines. ';

    // begin
    //     if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output then begin
    //         if (ItemJnlLine."Output Quantity (Base)" = 0) and (ItemJnlLine."Scrap Quantity (Base)" = 0) and
    //            ItemJnlLine.TimeIsEmpty() and (ItemJnlLine."Invoiced Qty. (Base)" = 0)
    //         then
    //             Error(ErrorInfo.Create(Text007, true))
    //     end else
    //         //GL2024  //#5020   if (ItemJnlLine."Quantity (Base)" = 0) and (ItemJnlLine."Invoiced Qty. (Base)" = 0) then
    //         if (ItemJnlLine."Quantity (Base)" = 0) and (ItemJnlLine."Invoiced Qty. (Base)" = 0) AND (ItemJnlLine."Job No." = '') then
    //             //#5020//
    //             Error(ErrorInfo.Create(Text007, true));

    //     IsHandled := true;
    // end;



    //*************************************Codeunit 22************************************************//
    // [EventSubscriber(ObjectType::Codeunit, 22, 'OnCodeOnBeforeTestOrder', '', true, true)]
    // local procedure OnCodeOnBeforeTestOrder(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    // begin
    //     IsHandled := true;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostItemOnBeforeGetGlobalLedgerEntry', '', true, true)]
    local procedure OnPostItemOnBeforeGetGlobalLedgerEntry(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        GlobalItemLedgEntry: Record "Item Ledger Entry";
        Trouver: Boolean;
        Item: record item;
        RecitemLedgerEntry: Record "Item Ledger Entry";

    begin
        if ItemJnlLine."N° Réception" <> '' then begin
            RecitemLedgerEntry.Reset();
            RecitemLedgerEntry.SetRange("Document No.", ItemJnlLine."N° Réception");
            if not RecitemLedgerEntry.FindFirst() then
                IsHandled := true;
        end;
        if ItemJnlLine."Item Shpt. Entry No." <> 0 then begin
            RecitemLedgerEntry.Reset();
            RecitemLedgerEntry.SetRange("Entry No.", ItemJnlLine."Item Shpt. Entry No.");
            if not RecitemLedgerEntry.FindFirst() then
                IsHandled := true;
        end;
        // if GlobalItemLedgEntry.Get(ItemJnlLine."Item Shpt. Entry No.") THEN
        //  Trouver := FALSE;
        if item.get(ItemJnlLine."Item No.") then begin
            if item.type = item.Type::Service then
                IsHandled := true;
        end;
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt." then
            if ItemJnlLine."Job No." <> '' then
                IsHandled := true;

    end;
    // sequence  //////////////////////////////////////////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Post-Line", 'OnPostJobOnPurchaseLineOnAfterCalcShouldSkipLine', '', true, true)]

    local procedure OnPostJobOnPurchaseLineOnAfterCalcShouldSkipLine(PurchaseLine: Record "Purchase Line"; var ShouldSkipLine: Boolean)
    begin
        //  ShouldSkipLine := true;
    end;


    // sequence
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnBeforeGetInvtPostSetup', '', true, true)]

    local procedure OnBeforeGetInvtPostSetup(var InventoryPostingSetup: Record "Inventory Posting Setup"; var LocationCode: Code[10]; InventoryPostingGroup: Code[20]; var GenPostingSetup: Record "General Posting Setup"; var IsHandled: Boolean; var InvtPostingBuffer: Record "Invt. Posting Buffer")
    begin
        if LocationCode = '' then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnBeforeSetAccNo', '', true, true)]

    local procedure OnBeforeSetAccNo(var InvtPostBuf: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; AccType: Option; BalAccType: Option; CalledFromItemPosting: Boolean; var IsHandled: Boolean)
    begin
        if ValueEntry."Location Code" = '' then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertValueEntryOnBeforeCalcExpectedCost', '', true, true)]

    local procedure OnInsertValueEntryOnBeforeCalcExpectedCost(var ItemJnlLine: Record "Item Journal Line"; var ItemLedgEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry"; TransferItemPBln: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var ShouldCalcExpectedCost: Boolean)
    var
        RecitemLedgerEntry: Record "Item Ledger Entry";

    begin
        if ItemJnlLine."N° Réception" <> '' then begin
            RecitemLedgerEntry.Reset();
            RecitemLedgerEntry.SetRange("Document No.", ItemJnlLine."N° Réception");
            if not RecitemLedgerEntry.FindFirst() then
                ShouldCalcExpectedCost := false;
        end;
        if ItemJnlLine."Item Shpt. Entry No." <> 0 then begin
            RecitemLedgerEntry.Reset();
            RecitemLedgerEntry.SetRange("Entry No.", ItemJnlLine."Item Shpt. Entry No.");
            if not RecitemLedgerEntry.FindFirst() then
                ShouldCalcExpectedCost := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateInvoiceLineOnBeforeCalcQty', '', true, true)]

    local procedure OnPostUpdateInvoiceLineOnBeforeCalcQty(var TempPurchLine: Record "Purchase Line" temporary; var PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        RecPurchaRecepLine: Record "Purch. Rcpt. Line";
        SumQty: Decimal;
    begin
        RecPurchaRecepLine.Reset();
        RecPurchaRecepLine.SetRange("Order No.", PurchOrderLine."Document No.");
        RecPurchaRecepLine.SetRange("Order Line No.", PurchOrderLine."Line No.");
        if RecPurchaRecepLine.FindSet() then begin
            repeat
                SumQty += RecPurchaRecepLine.Quantity;

            until RecPurchaRecepLine.Next() = 0;
        end;
        PurchOrderLine."Quantity Received" := SumQty;
    end;


    // sequence //////////////////////////////////////////////////////////////////////////


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckInvoicedQuantity', '', true, true)]
    local procedure OnBeforeCheckInvoicedQuantity(ItemLedgEntry: Record "Item Ledger Entry"; ValueEntry: Record "Value Entry"; var ModifyEntry: Boolean; var IsHandled: Boolean)
    var
        RecPurchaseReceip: Record "Purch. Rcpt. Header";
        RecPurchaseLine: Record "Purch. Rcpt. Line";
        RecItem: Record Item;
    begin
        if RecPurchaseLine.Get(ValueEntry."N° Réception", ValueEntry."N° Ligne Réception") then begin
            if RecPurchaseLine."Job No." <> '' then
                IsHandled := true;
        end;
        if RecItem.Get(ValueEntry."Item No.") then begin
            if RecItem.Type = RecItem.Type::Service then
                IsHandled := true;
        end;
    end;


    [EventSubscriber(ObjectType::table, database::"Purchase Line", 'OnCreateTempJobJnlLineOnBeforeTempJobJnlLineValidateNo', '', true, true)]
    local procedure OnCreateTempJobJnlLineOnBeforeTempJobJnlLineValidateNo(PurchaseLine: Record "Purchase Line"; var TempJobJnlLine: Record "Job Journal Line" temporary)

    begin
        if PurchaseLine."Job No." <> '' then begin
            TempJobJnlLine.Validate("Job No.", PurchaseLine."Job No.");
            TempJobJnlLine.Validate("Job Task No.", PurchaseLine."Job Task No.");
        end

        else begin
            TempJobJnlLine.Validate("Job No.", PurchaseLine."DYSJob No.");
            TempJobJnlLine.Validate("Job Task No.", PurchaseLine."DYSJob Task No.");
        end;



    end;

    // [EventSubscriber(ObjectType::Codeunit, 22, 'OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify', '', true, true)]
    // local procedure OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify(var ItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    // begin
    //     //#8877
    //     IF ItemLedgerEntry."Job Purchase" = TRUE THEN BEGIN
    //         ItemLedgerEntry."Applies-to Entry" := OldItemLedgerEntry."Entry No.";
    //         //            IF ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Sale THEN
    //         //              ItemLedgEntry."Job Purchase" := FALSE;
    //     END;
    //     //#8877//

    // end;

    // [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeApplyItemLedgEntrySetFilters', '', true, true)]
    // local procedure OnBeforeApplyItemLedgEntrySetFilters(var ToItemLedgEntry: Record "Item Ledger Entry"; FromItemLedgEntry: Record "Item Ledger Entry"; ItemTrackingCode: Record "Item Tracking Code"; var IsHandled: Boolean)
    // var
    //     ItemTrackingSetup2: Record "Item Tracking Setup";
    //     Location: Record Location;

    // begin
    //     if FromItemLedgEntry."Serial No." <> '' then
    //         ToItemLedgEntry.SetCurrentKey("Serial No.", "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
    //     else
    //         ToItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
    //     ToItemLedgEntry.SetRange("Item No.", FromItemLedgEntry."Item No.");
    //     ToItemLedgEntry.SetRange(Open, true);
    //     ToItemLedgEntry.SetRange("Variant Code", FromItemLedgEntry."Variant Code");
    //     ToItemLedgEntry.SetRange(Positive, not FromItemLedgEntry.Positive);
    //     ToItemLedgEntry.SetRange("Location Code", FromItemLedgEntry."Location Code");
    //     if FromItemLedgEntry."Job Purchase" then begin
    //         ToItemLedgEntry.SetRange("Job No.", FromItemLedgEntry."Job No.");
    //         ToItemLedgEntry.SetRange("Job Task No.", FromItemLedgEntry."Job Task No.");
    //         ToItemLedgEntry.SetRange("Document Type", FromItemLedgEntry."Document Type");
    //         ToItemLedgEntry.SetRange("Document No.", FromItemLedgEntry."Document No.");
    //     end;
    //     //#8877
    //     ToItemLedgEntry.SETRANGE("Job Purchase", FromItemLedgEntry."Job Purchase");
    //     //#8877//
    //     ItemTrackingSetup2.CopyTrackingFromItemTrackingCodeSpecificTracking(ItemTrackingCode);
    //     ItemTrackingSetup2.CopyTrackingFromItemLedgerEntry(FromItemLedgEntry);
    //     ToItemLedgEntry.SetTrackingFilterFromItemTrackingSetupIfRequired(ItemTrackingSetup2);
    //     if (Location.Get(FromItemLedgEntry."Location Code") and Location."Use As In-Transit") or
    //        (FromItemLedgEntry."Location Code" = '') and
    //        (FromItemLedgEntry."Document Type" = FromItemLedgEntry."Document Type"::"Transfer Receipt")
    //     then begin
    //         ToItemLedgEntry.SetRange("Order Type", FromItemLedgEntry."Order Type"::Transfer);
    //         ToItemLedgEntry.SetRange("Order No.", FromItemLedgEntry."Order No.");
    //     end;
    //     IsHandled := true;
    // end;



















    /* GL2024  [EventSubscriber(ObjectType::Codeunit, 22, 'OnGetValuationDateOnBeforeFindOldValueEntry', '', true, true)]
       local procedure OnGetValuationDateOnBeforeFindOldValueEntry(var OldValueEntry: Record "Value Entry"; var IsHandled: Boolean)
       begin
           IF OldValueEntry.FINDLAST THEN;
           IsHandled := true;
       end;
   */







    procedure GetTextStringWithLineNo(BasicTextString: Text; ItemNo: Code[20]; LineNo: Integer): Text
    var

        LineNoTxt: Label ' Line No. = ''%1''.', Comment = '%1 - Line No.';
    begin
        if LineNo = 0 then
            exit(StrSubstNo(BasicTextString, ItemNo));
        exit(StrSubstNo(BasicTextString, ItemNo) + StrSubstNo(LineNoTxt, LineNo));
    end;

    //*************************************Codeunit 70************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Calc.Discount", 'OnBeforeCalcPurchaseDiscount', '', true, true)]
    local procedure OnBeforeCalcPurchaseDiscount(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; var PurchaseLine: Record "Purchase Line"; UpdateHeader: Boolean; var GlobalPurchaseLine: Record "Purchase Line")
    var
        lUserExit: Codeunit UserExit;
        lRecordRef: RecordRef;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Calc.Discount", -1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Calc.Discount", 'OnAfterCalcPurchaseDiscount', '', true, true)]
    local procedure OnAfterCalcPurchaseDiscount(var PurchaseHeader: Record "Purchase Header")
    var
        lUserExit: Codeunit UserExit;
        lRecordRef: RecordRef;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(PurchaseHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Purch.-Calc.Discount", -1);
        lRecordRef.SETTABLE(PurchaseHeader);
        //+REF+USEREXIT//
    end;


    //*************************************Codeunit 60************************************************//
    // [EventSubscriber(ObjectType::Codeunit, 60, 'OnRunOnBeforeCalculateInvoiceDiscount', '', true, true)]
    // local procedure OnRunOnBeforeCalculateInvoiceDiscount(var SalesLine: Record "Sales Line"; var TempSalesHeader: Record "Sales Header" temporary; var TempSalesLine: Record "Sales Line" temporary; var UpdateHeader: Boolean; var IsHandled: Boolean)
    // begin
    //     //BAT
    //     SalesLine.SETRANGE("Structure Line No.", 0);
    //     SalesLine.SETFILTER("Line Type", '>%1', SalesLine."Line Type"::" ");
    //     //BAT//
    //     TempSalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
    //     UpdateHeader := true;
    // end;



    //*************************************Codeunit 64************************************************//

    /*GL2024 [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnBeforeCreateInvLines', '', true, true)]
     local procedure OnBeforeCreateInvLines(var SalesShipmentLine2: Record "Sales Shipment Line"; var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; var IsHandled: Boolean)
     var
         Window: Dialog;
         LineCount: Integer;
         TransferLine: Boolean;
         PrepmtAmtToDeductRounding: Decimal;
         CDU64: Codeunit "Sales-Get Shipment";
         OrderNoList: List of [Code[20]];

         Text001: label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
         Text002: label 'Creating Sales Invoice Lines\';
         Text003: label 'Inserted lines';
         lUserExit: Codeunit UserExit;
         lRecRef: RecordRef;

    begin
        SalesShipmentLine2.SetFilter("Qty. Shipped Not Invoiced", '<>0');
        if SalesShipmentLine2.FindSet() then begin
            SalesLine.LockTable();
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            Window.Open(Text002 + Text003);


            repeat
                LineCount := LineCount + 1;
                Window.Update(1, LineCount);
                if SalesShipmentHeader."No." <> SalesShipmentLine2."Document No." then begin
                    SalesShipmentHeader.Get(SalesShipmentLine2."Document No.");
                    TransferLine := true;
                    if SalesShipmentHeader."Currency Code" <> SalesHeader."Currency Code" then begin
                        Message(
                          Text001,
                          SalesHeader.FieldCaption("Currency Code"),
                          SalesHeader.TableCaption(), SalesHeader."No.",
                          SalesShipmentHeader.TableCaption(), SalesShipmentHeader."No.");
                        TransferLine := false;
                    end;
                    //#7313
                    IF lUserExit.CodeunitOnRun(lRecRef, CODEUNIT::"Sales-Get Shipment", 0) = -1 THEN
                        //#7313//
                        if SalesShipmentHeader."Bill-to Customer No." <> SalesHeader."Bill-to Customer No." then begin
                            Message(
                              Text001,
                              SalesHeader.FieldCaption("Bill-to Customer No."),
                              SalesHeader.TableCaption(), SalesHeader."No.",
                              SalesShipmentHeader.TableCaption(), SalesShipmentHeader."No.");
                            TransferLine := false;
                        end;
                end;
                CDU64.InsertInvoiceLineFromShipmentLine(SalesShipmentLine2, TransferLine, PrepmtAmtToDeductRounding);
                if SalesShipmentLine2."Order No." <> '' then
                    if not OrderNoList.Contains(SalesShipmentLine2."Order No.") then
                        OrderNoList.Add(SalesShipmentLine2."Order No.");
            until SalesShipmentLine2.Next() = 0;

            CDU64.UpdateItemChargeLines();

            if SalesLine.Find() then;

            CDU64.CalcInvoiceDiscount(SalesLine);

            if TransferLine then
                CDU64.AdjustPrepmtAmtToDeductRounding(SalesLine, PrepmtAmtToDeductRounding);
            CopyDocumentAttachments(OrderNoList, SalesHeader);
        end;

        IsHandled := true;
    end;

    local procedure CopyDocumentAttachments(OrderNoList: List of [Code[20]]; var SalesHeader2: Record "Sales Header")
    var
        OrderSalesHeader: Record "Sales Header";
        DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt";
        OrderNo: Code[20];
        Handled: Boolean;
    begin
        if Handled then
            exit;
        OrderSalesHeader.ReadIsolation := IsolationLevel::ReadCommitted;
        OrderSalesHeader.SetLoadFields("Document Type", "No.");
        foreach OrderNo in OrderNoList do
            if OrderHasAttachments(OrderNo) then
                if OrderSalesHeader.Get(OrderSalesHeader."Document Type"::Order, OrderNo) then
                    DocumentAttachmentMgmt.CopyAttachments(OrderSalesHeader, SalesHeader2);
    end;

    local procedure OrderHasAttachments(DocNo: Code[20]): boolean
    begin
        exit(EntityHasAttachments(DocNo, Database::"Sales Header"));
    end;

    local procedure EntityHasAttachments(DocNo: Code[20]; TableNo: Integer): boolean
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.ReadIsolation := IsolationLevel::ReadUncommitted;
        DocumentAttachment.SetRange("Table ID", TableNo);
        DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
        DocumentAttachment.SetRange("No.", DocNo);
        exit(not DocumentAttachment.IsEmpty());
    end;
    //*************************************Codeunit 76************************************************/
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnCodeOnBeforeSelectSalesHeader', '', true, true)]
    local procedure OnCodeOnBeforeSelectSalesHeader(var PurchaseHeader: Record "Purchase Header"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        SalesHeader.SetCurrentKey("Document Type", "Sell-to Customer No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", PurchaseHeader."Sell-to Customer No.");
        //CDE_INTERNE
        SalesHeader.SETFILTER("Order Type", '<>%1', SalesHeader."Order Type"::"Supply Order");
        //CDE_INTERNE//
        if (PAGE.RunModal(PAGE::"Sales List", SalesHeader) <> ACTION::LookupOK) or
           (SalesHeader."No." = '')
        then
            exit;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnCodeOnAfterSalesLineSetFilters', '', true, true)]
    local procedure OnCodeOnAfterSalesLineSetFilters(var SalesLine: Record "Sales Line"; var PurchHeader: Record "Purchase Header")
    begin
        //CDE_INTERNE
        SalesLine.SETRANGE("Supply Order Line No.", 0);
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnBeforeSalesLineModify', '', true, true)]
    local procedure OnBeforeSalesLineModify(var SalesLine: Record "Sales Line"; PurchaseLine: Record "Purchase Line"; SalesHeader: Record "Sales Header")
    begin
        //CDE_INTERNE
        SalesLine."Purchasing Document Type" := SalesLine."Purchasing Document Type"::Order;
        SalesLine."Purchasing Order No." := PurchaseLine."Document No.";
        SalesLine."Purchasing Order Line No." := PurchaseLine."Line No.";
        //CDE_INTERNE//
    end;







    //*************************************Codeunit 70************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Calc.Discount", 'OnOnRunOnBeforeUpdateHeader', '', true, true)]
    local procedure OnOnRunOnBeforeUpdateHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    begin
    end;



    //*************************************Codeunit 90************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeTestPurchLineJob', '', true, true)]
    local procedure OnBeforeTestPurchLineJob(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)

    begin
        IsHandled := true;
    end;




    //*************************************Codeunit 23************************************************//
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnAfterUpdateAnalysisViews', '', true, true)]
    local procedure OnAfterUpdateAnalysisViews(var ItemRegister: Record "Item Register")
    var
        UpdateAnalysisView: Codeunit 410;
        UpdateItemAnalysisView: Codeunit 7150;
    begin
        UpdateAnalysisView.UpdateAll(0, TRUE);
        UpdateItemAnalysisView.UpdateAll(0, TRUE);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnBeforeJobLedgEntryInsert', '', true, true)]
    local procedure OnBeforeJobLedgEntryInsert(JobJournalLine: Record "Job Journal Line"; var JobLedgerEntry: Record "Job Ledger Entry")

    begin
        JobLedgerEntry."Executed measurement" := JobJournalLine."Executed measurement";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCopyAndCheckItemChargeTempPurchLine', '', true, true)]
    local procedure OnBeforeCopyAndCheckItemChargeTempPurchLine(PurchaseHeader: Record "Purchase Header"; var AssignError: Boolean; var IsHandled: Boolean; var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; var TempPrepmtPurchaseLine: Record "Purchase Line" temporary)
    begin
        if NOT TempPrepmtPurchaseLine."affectation Frais annexe" then
            ishandled := true;
    end;



    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert', '', true, true)]

    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Purchase Request No." := PurchHeader."Generer A Partir DA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', true, true)]

    local procedure OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
        PurchOrderLine."Purchase Request No." := PurchOrderHeader."Purchase Request No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnAfterInsertAllPurchOrderLines', '', true, true)]

    local procedure OnAfterInsertAllPurchOrderLines(var PurchOrderLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        RecPurchaseRequest: Record "Purchase Request";
        RecPurchaseRequestLine: Record "Purchase request Line";
    begin
        RecPurchaseRequest.Reset();
        RecPurchaseRequest.SetRange("No.", PurchOrderLine."Purchase Request No.");
        if RecPurchaseRequest.FindFirst() then begin
            RecPurchaseRequestLine.Reset();
            RecPurchaseRequestLine.SetRange("Document No.", RecPurchaseRequest."No.");
            if RecPurchaseRequestLine.FindSet() then begin
                repeat
                    RecPurchaseRequestLine."Associated Purchase Order" := PurchOrderLine."Document No.";
                    RecPurchaseRequestLine.Modify();
                until RecPurchaseRequestLine.Next() = 0;
            end;
            RecPurchaseRequest.Statut := RecPurchaseRequest.Statut::"Fully Supported";
            RecPurchaseRequest.Modify();
        end;

    end;

    ///HS




}