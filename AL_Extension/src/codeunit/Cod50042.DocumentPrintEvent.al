codeunit 50042 DocumentPrintEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnAfterDoPrintSalesHeader', '', true, true)]
    local procedure OnAfterDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; SendAsEmail: Boolean)

    begin
        //#4367
        IF lSingleIns.wGetSalesOverheadCalcfrom = 0 THEN
            lSingleIns.wSetSalesOverheadIsCalculated(FALSE, 4);
        //#4367//
        //+REF+
        CR := 13;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        //+REF+//

        //DEVIS

        SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
        IF SalesHeader.Status = SalesHeader.Status::Open THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            SalesLine.FINDFIRST;
            CODEUNIT.RUN(CODEUNIT::"Job Cost Assignment", SalesLine);
        END;

        COMMIT;
        //DEVIS//

        //PROJET_FACT
        IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN BEGIN
            CLEAR(lInvScheduler);
            lInvScheduler.SETRANGE("Sales Header Doc. Type", SalesHeader."Document Type");
            lInvScheduler.SETRANGE("Sales Header Doc. No.", SalesHeader."No.");
            lInvScheduler.SETFILTER("Document Percentage", '<>0');
            IF NOT lInvScheduler.ISEMPTY THEN BEGIN
                lInvScheduler.FIND('-');
                lInvScheduler.UpdateLineAmount(lInvScheduler);
                COMMIT;
            END;
        END;
        //PROJET_FACT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnGetSalesDocTypeUsageElseCase', '', true, true)]
    local procedure OnGetSalesDocTypeUsageElseCase(SalesHeader: Record "Sales Header"; var TypeUsage: Integer; var IsHandled: Boolean)
    begin
        //+ABO+
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Subscription then
            TypeUsage := 8001905;
        IsHandled := true;
        //+ABO+//
        // //DEVIS
        // SalesHeader."Document Type"::Invoice:
        //     ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"S.Invoice");
        // //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnDoPrintPurchaseHeaderToDocumentAttachmentOnBeforeRunSaveAsDocumentAttachment', '', true, true)]
    local procedure OnDoPrintPurchaseHeaderToDocumentAttachmentOnBeforeRunSaveAsDocumentAttachment(var PurchaseHeader: Record "Purchase Header"; ReportUsage: Integer; ShowNotificationAction: Boolean; var IsHandled: Boolean)
    var
        PurchLine: Record "Purchase Line";
        CduReleasePurchaseDocumentEvent: Codeunit ReleasePurchaseDocumentEvent;
    begin
        //4577
        IF lSingleIns.wGetSalesOverheadCalcfrom = 0 THEN
            lSingleIns.wSetSalesOverheadIsCalculated(FALSE, 4);
        //4577//
        //+REF+
        CR := 13;
        //+REF+//

        //PROJET
        PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchLine.FIND('-') THEN
            REPEAT
                CduReleasePurchaseDocumentEvent.wCheckLine(PurchLine);
            UNTIL PurchLine.NEXT = 0;
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnGetPurchDocTypeUsageElseCase', '', true, true)]
    local procedure OnGetPurchDocTypeUsageElseCase(PurchaseHeader: Record "Purchase Header"; var TypeUsage: Integer; var IsHandled: Boolean)
    begin
        //+ABO+
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Subscription THEN
            TypeUsage := 8001915;
        //+ABO+//
        //+NDF
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Note of Expenses" THEN
            TypeUsage := 8002000;

        //+NDF//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintServiceHeader', '', true, true)]
    local procedure OnBeforePrintServiceHeader(var ServiceHeader: Record "Service Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    begin
        //+REF+
        ServiceHeader.SETRANGE("Document Type", ServiceHeader."Document Type");
        //+REF+//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintSalesOrder', '', true, true)]
    local procedure OnBeforePrintSalesOrder(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; var IsPrinted: Boolean)
    begin
        //+REF+
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
        //+REF+//
    end;

    var
        myInt: Integer;
        SalesLine: Record "Sales Line";
        tSubject: Label 'Société %1, %2 N° %3';
        tMailNotSent: Label '%1 %2 (Etat %3) n''a pu être envoyée à %4';
        tNotUnique: Label 'Vous ne pouvez pas envoyer plusieurs documents simultanément par email.';
        gMail: Codeunit Mail;
        lCorps: Text[250];
        lMsg: Record "Extended Text Line";
        CR: Char;
        lEntMsg: Record "Extended Text Header";
        lFileName: Text[250];
        lContact: Record Contact;
        lSubject: Text[250];
        lInvScheduler: Record "Invoice Scheduler";
        lSingleIns: Codeunit "Import SingleInstance2";
        //GL2024 License  lObject: Record Object;
        //GL2024 License
        lObject: Record AllObj;
        //GL2024 License
        lRelease: Codeunit "Release Purchase Document";
}