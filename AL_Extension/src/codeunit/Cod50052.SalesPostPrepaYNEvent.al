codeunit 50052 SalesPostPrepaYNEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayment (Yes/No)", 'OnPostPrepmtInvoiceYNOnBeforeConfirm', '', true, true)]
    local procedure OnPostPrepmtInvoiceYNOnBeforeConfirm(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    begin
        //#7330
        IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN
            SalesHeader.FIELDERROR("Invoicing Method");
        //#7330//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayment (Yes/No)", 'OnBeforePostPrepmtDocument', '', true, true)]
    local procedure OnBeforePostPrepmtDocument(var SalesHeader: Record "Sales Header"; PrepmtDocumentType: Option)
    var
        //lPostingForm : PAGE 8001429;
        lPostingDate: Date;
        lInvoice: Boolean;
        lReceive: Boolean;
        lShip: Boolean;
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //#6285

        // lPostingForm.wInitRequest(Receive, Invoice, Ship);
        // lPostingForm.fSetPrepayment(TRUE);
        // lPostingForm.SETRECORD(SalesHeader);
        // IF (lPostingForm.RUNMODAL = ACTION::OK) THEN BEGIN
        //     lPostingForm.wFinishRequest(lPostingDate, lReceive, lInvoice, lShip);
        //     SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
        //     "Posting Date" := lPostingDate;
        //     Invoice := lInvoice;
        //     Receive := lReceive;
        //     Ship := lShip;
        //     MODIFY;
        // END ELSE BEGIN
        //     EXIT;
        // END;

        //#6285//
        //+REF+USEREXIT//
        //+REF+USEREXIT
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then begin
            lRecordRef.GETTABLE(SalesHeader);
            lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Sales-Post Prepayment (Yes/No)", -1);
            lRecordRef.SETTABLE(SalesHeader);
            //+REF+USEREXIT//
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayment (Yes/No)", 'OnAfterPostPrepmtInvoiceYN', '', true, true)]
    local procedure OnAfterPostPrepmtInvoiceYN(var SalesHeader: Record "Sales Header")
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(SalesHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Sales-Post Prepayment (Yes/No)", 0);
        lRecordRef.SETTABLE(SalesHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post Prepayment (Yes/No)", 'OnAfterPostPrepmtCrMemoYN', '', true, true)]
    local procedure OnAfterPostPrepmtCrMemoYN(var SalesHeader: Record "Sales Header")
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(SalesHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Sales-Post Prepayment (Yes/No)", 0);
        lRecordRef.SETTABLE(SalesHeader);
        //+REF+USEREXIT//
    end;

    PROCEDURE fPostPrepmtReversalYN(VAR SalesHeader2: Record "Sales Header"; Print: Boolean);
    VAR
        SalesHeader: Record "Sales Header";
        SalesPostPrepayments: Codeunit SalesPostPrepaymentEvent;
        lSalesInvoiceHeader: Record "Sales Invoice Header";
        lDocNo: Code[20];
        CduSalespostprepyn: Codeunit "Sales-Post Prepayment (Yes/No)";
    BEGIN
        lSalesInvoiceHeader.SETCURRENTKEY("Prepayment Order No.", "Posting Date");

        //#8302
        lDocNo := fCheckPreviousInvoice(1, SalesHeader2);
        //#8302//

        lSalesInvoiceHeader.SETRANGE("Prepayment Order No.", SalesHeader2."No.");
        lSalesInvoiceHeader.SETRANGE("Prepayment Invoice", TRUE);
        lSalesInvoiceHeader.SETRANGE("Reverse Prepmt. Cr. Memo No.", '');
        //#8302
        lSalesInvoiceHeader.SETFILTER("No.", lDocNo);
        //#8302//

        //#6406
        IF lSalesInvoiceHeader.ISEMPTY THEN
            ERROR(tErrorNoInv);
        //#6406//
        lSalesInvoiceHeader.FINDLAST;

        SalesHeader.COPY(SalesHeader2);
        WITH SalesHeader DO BEGIN
            //#6251
            //  IF NOT CONFIRM(tPrepaymentReversal,FALSE,lSalesInvoiceHeader."No.","No.") THEN
            IF "Posting Date" = 0D THEN
                "Posting Date" := lSalesInvoiceHeader."Posting Date";
            IF NOT CONFIRM(tPrepaymentReversal, FALSE, lSalesInvoiceHeader."No.", "No.", "Posting Date") THEN
                //#6251//
                EXIT;

            SalesPostPrepayments.fReversal(SalesHeader, lSalesInvoiceHeader);

            IF Print THEN
                CduSalespostprepyn.GetReport(SalesHeader, 1);

            COMMIT;
            SalesHeader2 := SalesHeader;
        END;
    END;

    PROCEDURE fPostPrepmtCrMemoReversalYN(VAR SalesHeader2: Record "Sales Header"; Print: Boolean);
    VAR
        SalesHeader: Record "Sales Header";
        SalesPostPrepayments: Codeunit SalesPostPrepaymentEvent;
        lSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        lDocNo: Code[20];
        CduSalespostprepyn: Codeunit "Sales-Post Prepayment (Yes/No)";
    BEGIN
        //#8302\\ Annulation du dernier avoir

        lDocNo := fCheckPreviousInvoice(-1, SalesHeader2);

        lSalesCrMemoHeader.SETCURRENTKEY("Prepayment Order No.");
        lSalesCrMemoHeader.SETRANGE("Prepayment Order No.", SalesHeader2."No.");
        lSalesCrMemoHeader.SETRANGE("Prepayment Credit Memo", TRUE);
        lSalesCrMemoHeader.SETFILTER("No.", lDocNo);
        //#6406
        IF lSalesCrMemoHeader.ISEMPTY THEN
            ERROR(tErrorNoInv);
        //#6406//
        lSalesCrMemoHeader.FINDLAST;

        SalesHeader.COPY(SalesHeader2);
        WITH SalesHeader DO BEGIN
            //#6251
            IF "Posting Date" = 0D THEN
                "Posting Date" := lSalesCrMemoHeader."Posting Date";
            IF NOT CONFIRM(tPrepaymentCrMemoReversal, FALSE, lSalesCrMemoHeader."No.", "No.", "Posting Date") THEN
                //#6251//
                EXIT;

            SalesPostPrepayments.fCrMemoReversal(SalesHeader, lSalesCrMemoHeader);

            IF Print THEN
                CduSalespostprepyn.GetReport(SalesHeader, 1);

            COMMIT;
            SalesHeader2 := SalesHeader;
        END;
    END;

    PROCEDURE fCheckPreviousInvoice(pInvoiceType: Integer; pSalesHeader: Record "Sales Header") pReturn: Code[20];
    VAR
        lJobLedgerEntry: Record "Job Ledger Entry";
        TextInvNoFound: Label 'The last document is not an invoice : %1';
        TextCrMemoNoFound: Label 'The last document is not a credit memo : %1';
        lInvoiceHeader: Record "Sales Invoice Header";
        lCrMemoHeader: Record "Sales Cr.Memo Header";
    BEGIN
        //#8302\\ Controle que le dernier document valide peut etre annule
        // remarque : /Table "Job Ledger Entry", qt‚ < 0 sont les facture
        //pInvoiceType = document recherche : 1 = Facture, -1 = Avoir

        //lJobLedgerEntry.SETFILTER("Job No.",pSalesHeader."Job No.");
        //lJobLedgerEntry.SETFILTER("Entry Type",'=%1',lJobLedgerEntry."Entry Type"::Sale);
        //lJobLedgerEntry.SETFILTER(Type,'=%1',lJobLedgerEntry.Type::"G/L Account");
        //IF lJobLedgerEntry.FIND('+') THEN BEGIN
        IF pInvoiceType > 0 THEN BEGIN
            //Si le doc recherche est une Facture
            //IF lJobLedgerEntry.Quantity > 0 THEN
            //ERROR(STRSUBSTNO(TextInvNoFound,lJobLedgerEntry."Document No.",lJobLedgerEntry.Description))
            lInvoiceHeader.SETCURRENTKEY("Prepayment Order No.");
            lInvoiceHeader.SETRANGE("Prepayment Order No.", pSalesHeader."No.");
            lInvoiceHeader.SETFILTER("Prepayment Rank No.", '%1', pSalesHeader."No. Prepayment Invoiced");
            lInvoiceHeader.SETFILTER("Reverse Prepmt. Cr. Memo No.", '=%1', '');
            IF NOT lInvoiceHeader.FIND('+') THEN
                ERROR(STRSUBSTNO(TextInvNoFound, lJobLedgerEntry."Document No.", lJobLedgerEntry.Description))
            ELSE
                pReturn := lInvoiceHeader."No.";
        END
        ELSE BEGIN
            //si le doc recherche est un avoir
            //IF lJobLedgerEntry.Quantity < 0 THEN BEGIN
            //ERROR(STRSUBSTNO(TextCrMemoNoFound,lJobLedgerEntry."Document No.",lJobLedgerEntry.Description));
            lCrMemoHeader.SETCURRENTKEY("Prepayment Order No.");
            lCrMemoHeader.SETRANGE("Prepayment Order No.", pSalesHeader."No.");
            lCrMemoHeader.SETFILTER("Prepayment Rank No.", '%1', pSalesHeader."No. Prepayment Invoiced");
            lCrMemoHeader.SETFILTER("Reverse Prepmt. Inv. No.", '=%1', '');
            IF NOT lCrMemoHeader.FIND('+') THEN
                ERROR(STRSUBSTNO(TextCrMemoNoFound, lJobLedgerEntry."Document No.", lJobLedgerEntry.Description))
            ELSE
                pReturn := lCrMemoHeader."No.";
        END;
    END;

    var
        myInt: Integer;
        tPrepaymentReversal: Label 'Do you want to post a credit memo at posting date %3 to reverse prepayments invoice %1 for order %2?';
        tErrorNoInv: Label 'There is no invoice to cancel';
        tPrepaymentCrMemoReversal: Label 'Voulez-vous valider une facture en date du %3 pour l''avoir d''acompte %1 concernant la commande %2 ?';

}