codeunit 50054 ArchiveManagementEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesLineArchiveInsert', '', true, true)]
    local procedure OnBeforeSalesLineArchiveInsert(var SalesLineArchive: Record "Sales Line Archive"; SalesLine: Record "Sales Line")
    begin
        //#8880
        SalesLineArchive."Job Task No." := SalesLine."Job Task No.";
        //#8880//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforePurchLineArchiveInsert', '', true, true)]
    local procedure OnBeforePurchLineArchiveInsert(var PurchaseLineArchive: Record "Purchase Line Archive"; PurchaseLine: Record "Purchase Line")
    begin
        //#8880
        PurchaseLineArchive."Job Task No." := PurchaseLine."Job Task No.";
        //#8880//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStorePurchLineArchive', '', true, true)]
    local procedure OnAfterStorePurchLineArchive(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var PurchHeaderArchive: Record "Purchase Header Archive"; var PurchLineArchive: Record "Purchase Line Archive")
    begin
        //ACHAT
        IF (PurchLine."Ordered Not Invoiced (LCY)" = 0) OR (PurchHeaderArchive."Version No." = 1) THEN BEGIN
            PurchLine."Original Quantity" := PurchLine.Quantity;
            PurchLine."Original Unit Cost (LCY)" := PurchLine."Unit Cost (LCY)";
            PurchLine."Ordered Not Invoiced (LCY)" :=
              (PurchLine."Original Quantity" - PurchLine."Quantity Invoiced") * PurchLine."Original Unit Cost (LCY)";
            PurchLine.MODIFY;
        END;
        //ACHAT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnRestoreSalesLinesOnAfterValidateQuantity', '', true, true)]
    local procedure OnRestoreSalesLinesOnAfterValidateQuantity(var SalesLine: Record "Sales Line"; var SalesLineArchive: Record "Sales Line Archive")
    begin
        //#8880
        SalesLine."Job Task No." := SalesLineArchive."Job Task No.";
        //#8880//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterRestoreSalesLine', '', true, true)]
    local procedure OnAfterRestoreSalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesHeaderArchive: Record "Sales Header Archive"; var SalesLineArchive: Record "Sales Line Archive")
    var
        lCopyFurther: Codeunit "Copy Document Further";
        lBOQMgt: Codeunit "BOQ Management";
        lFromBOQExist: Boolean;
        lContributorArchive: Record "Sales Contributor Archive";
        lContributor: Record "Sales Contributor";
        lLineExisted: Boolean;
        lSchedulerArchive: Record "Invoice Scheduler Archive";
        lScheduler: Record "Invoice Scheduler";
        lJobCostAssgnt: Record "Job Cost Assignment";
        lJobCostAssgntArchive: Record "Job Cost Assignment Archive";
    begin
        //DEVIS//
        lCopyFurther.wCopyBillOfQtyArchToLine(SalesHeader, SalesLine, SalesHeaderArchive, SalesLineArchive, lFromBOQExist, lBOQMgt);

        IF (NOT lBOQMgt.IsEmpty()) THEN
            lBOQMgt.Save('');

        //DEVIS
        lContributorArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type");
        lContributorArchive.SETRANGE("Document No.", SalesHeaderArchive."No.");
        lContributorArchive.SETRANGE("Doc. No. Occurrence", SalesHeaderArchive."Doc. No. Occurrence");
        lContributorArchive.SETRANGE("Version No.", SalesHeaderArchive."Version No.");
        IF lContributorArchive.FIND('-') THEN BEGIN
            REPEAT
                WITH lContributor DO BEGIN
                    INIT;
                    TRANSFERFIELDS(lContributorArchive);
                    IF NOT INSERT THEN
                        MODIFY;
                END
            UNTIL lContributorArchive.NEXT = 0;
        end;

        //#7089
        wCopyArchDescLine2Doc(SalesHeaderArchive);
        //#7089//
        //+PERF+
        wSalesOverheadMargin.SETRANGE("Document Type", SalesLineArchive."Document Type");
        wSalesOverheadMargin.SETRANGE("Document No.", SalesLineArchive."Document No.");
        IF NOT wSalesOverheadMargin.ISEMPTY THEN
            wSalesOverheadMargin.DELETEALL;

        wTotalNeedParameter.SETRANGE("Document Type", SalesLineArchive."Document Type");
        wTotalNeedParameter.SETRANGE("Document No.", SalesLineArchive."Document No.");
        IF NOT wTotalNeedParameter.ISEMPTY THEN
            wTotalNeedParameter.DELETEALL;

        wSalesOverheadMarginArchive.RESET;
        wSalesOverheadMarginArchive.SETRANGE("Document Type", SalesLineArchive."Document Type");
        wSalesOverheadMarginArchive.SETRANGE("Document No.", SalesLineArchive."Document No.");
        wSalesOverheadMarginArchive.SETRANGE("Doc. No. Occurrence", SalesLineArchive."Doc. No. Occurrence");
        wSalesOverheadMarginArchive.SETRANGE("Version No.", SalesLineArchive."Version No.");
        IF wSalesOverheadMarginArchive.FIND('-') THEN
            REPEAT
                CASE wSalesOverheadMarginArchive.Type OF
                    wSalesOverheadMarginArchive.Type::Overhead, wSalesOverheadMarginArchive.Type::Margin:
                        BEGIN
                            lLineExisted := wSalesOverheadMargin.GET(wSalesOverheadMarginArchive."Document Type",
                                            wSalesOverheadMarginArchive."Document No.", wSalesOverheadMarginArchive."No.");
                            IF NOT lLineExisted THEN BEGIN
                                wSalesOverheadMargin.INIT;
                                wSalesOverheadMargin."Document Type" := wSalesOverheadMarginArchive."Document Type";
                                wSalesOverheadMargin."Document No." := wSalesOverheadMarginArchive."Document No.";
                                wSalesOverheadMargin."Gen. Prod. Post. Code" := wSalesOverheadMarginArchive."No.";
                            END;
                            IF wSalesOverheadMarginArchive.Type = wSalesOverheadMarginArchive.Type::Overhead THEN BEGIN
                                wSalesOverheadMargin.Overhead := wSalesOverheadMarginArchive.Value;
                                wSalesOverheadMargin."Rule Overhead" := wSalesOverheadMarginArchive."Rule Value";
                                wSalesOverheadMargin."Calculation Method Overhead" := wSalesOverheadMarginArchive."Calculation Method";
                            END ELSE BEGIN
                                wSalesOverheadMargin.Margin := wSalesOverheadMarginArchive.Value;
                                wSalesOverheadMargin."Rule Margin" := wSalesOverheadMarginArchive."Rule Value";
                                wSalesOverheadMargin."Calculation Method Margin" := wSalesOverheadMarginArchive."Calculation Method";
                            END;
                            IF NOT lLineExisted THEN
                                wSalesOverheadMargin.INSERT
                            ELSE
                                wSalesOverheadMargin.MODIFY;
                        END;
                    ELSE BEGIN
                        wTotalNeedParameter.INIT;
                        wTotalNeedParameter.TRANSFERFIELDS(wSalesOverheadMarginArchive);
                        wTotalNeedParameter.INSERT;
                    END;
                END;
            UNTIL wSalesOverheadMarginArchive.NEXT = 0;

        //+PERF+//
        //DEVIS//
        //PROJET_FACT
        lSchedulerArchive.SETRANGE("Sales Header Doc. Type", SalesHeaderArchive."Document Type");
        lSchedulerArchive.SETRANGE("Sales Header Doc. No.", SalesHeaderArchive."No.");
        lSchedulerArchive.SETRANGE("Doc. No. Occurrence", SalesHeaderArchive."Doc. No. Occurrence");
        lSchedulerArchive.SETRANGE("Version No.", SalesHeaderArchive."Version No.");
        IF lSchedulerArchive.FIND('-') THEN
            REPEAT
                WITH lScheduler DO BEGIN
                    INIT;
                    TRANSFERFIELDS(lSchedulerArchive);
                    INSERT;
                END;
            UNTIL lSchedulerArchive.NEXT = 0;
        //PROJET_FACT//
        //FRAIS
        lJobCostAssgntArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type");
        lJobCostAssgntArchive.SETRANGE("Document No.", SalesHeaderArchive."No.");
        lJobCostAssgntArchive.SETRANGE("Doc. No. Occurrence", SalesLineArchive."Doc. No. Occurrence");
        lJobCostAssgntArchive.SETRANGE("Version No.", SalesLineArchive."Version No.");
        IF lJobCostAssgntArchive.FIND('-') THEN
            REPEAT
                lJobCostAssgnt.INIT;
                lJobCostAssgnt.TRANSFERFIELDS(lJobCostAssgntArchive);
                lJobCostAssgnt.INSERT;
            UNTIL lJobCostAssgntArchive.NEXT = 0;
        //FRAIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnRestoreDocumentOnBeforeDeleteSalesHeader', '', true, true)]
    local procedure OnRestoreDocumentOnBeforeDeleteSalesHeader(var SalesHeader: Record "Sales Header"; var SkipDeletingLinks: Boolean)
    var
        CduArchivMgment: Codeunit ArchiveManagement;
    begin
        //#7631
        CduArchivMgment.StoreSalesDocument(SalesHeader, FALSE);
        SalesHeader.SetHideValidationDialog(TRUE);
        //#7631//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterTransferFromArchToSalesHeader', '', true, true)]
    local procedure OnAfterTransferFromArchToSalesHeader(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    var
        lCopyFurther: Codeunit "Copy Document Further";
        lBOQMgt: Codeunit "BOQ Management";
        lFromBOQExist: Boolean;
    begin
        // Restauration du BOQ
        lCopyFurther.wCopyBillOfQtyArchToHeader(SalesHeader, SalesHeaderArchive, TRUE, lBOQMgt, lFromBOQExist);
        // Restauration du BOQ //
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStoreSalesDocument', '', true, true)]
    local procedure OnAfterStoreSalesDocument(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    var
        lContributor: Record "Sales Contributor";
        lContributorArchive: Record "Sales Contributor Archive";
        lVATAmountLine: Record "VAT Amount Line" TEMPORARY;
        lScheduler: Record "Invoice Scheduler";
        lSchedulerArchive: Record "Invoice Scheduler Archive";
        lJobCostAssgnt: Record "Job Cost Assignment";
        lJobCostAssgntArchive: Record "Job Cost Assignment Archive";
        lToRef: RecordRef;
        lToOwnerRef: RecordRef;
        lFromRef: RecordRef;
        lFromOwnerRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lFromBOQExist: Boolean;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#6115
        lToOwnerRef.GETTABLE(SalesHeaderArchive);
        lFromOwnerRef.GETTABLE(SalesHeader);
        lBOQCustMgt.gArchiveBOQMgt(lFromOwnerRef, lToOwnerRef);
        //#6115

        //DEVIS

        //+PERF+
        wSalesOverheadMargin.RESET;
        wSalesOverheadMargin.SETRANGE("Document Type", SalesHeader."Document Type");
        wSalesOverheadMargin.SETRANGE("Document No.", SalesHeader."No.");
        IF wSalesOverheadMargin.FIND('-') THEN
            REPEAT
                WITH wSalesOverheadMarginArchive DO BEGIN
                    INIT;
                    "Document Type" := wSalesOverheadMargin."Document Type";
                    "Document No." := wSalesOverheadMargin."Document No.";
                    "Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                    "Version No." := SalesHeaderArchive."Version No.";
                    "No." := wSalesOverheadMargin."Gen. Prod. Post. Code";

                    Type := Type::Overhead;
                    Value := wSalesOverheadMargin.Overhead;
                    "Rule Value" := wSalesOverheadMargin."Rule Overhead";
                    "Calculation Method" := wSalesOverheadMargin."Calculation Method Overhead";
                    INSERT;

                    Type := Type::Margin;
                    Value := wSalesOverheadMargin.Margin;
                    "Rule Value" := wSalesOverheadMargin."Rule Margin";
                    "Calculation Method" := wSalesOverheadMargin."Calculation Method Margin";
                    INSERT;
                END;
            UNTIL wSalesOverheadMargin.NEXT = 0;

        wTotalNeedParameter.RESET;
        wTotalNeedParameter.SETRANGE("Document Type", SalesHeader."Document Type");
        wTotalNeedParameter.SETRANGE("Document No.", SalesHeader."No.");
        IF wTotalNeedParameter.FIND('-') THEN
            REPEAT
                WITH wSalesOverheadMarginArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(wTotalNeedParameter);
                    "Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                    "Version No." := SalesHeaderArchive."Version No.";
                    INSERT;
                END;
            UNTIL wTotalNeedParameter.NEXT = 0;
        //+PERF+//


        lContributor.SETRANGE("Document Type", SalesHeader."Document Type");
        lContributor.SETRANGE("Document No.", SalesHeader."No.");
        IF lContributor.FIND('-') THEN
            REPEAT
                WITH lContributorArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(lContributor);
                    "Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                    "Version No." := SalesHeaderArchive."Version No.";
                    INSERT;
                END;
            UNTIL lContributor.NEXT = 0;

        //DEVIS
        wCopyDescLine2Arch(gSalesHeaderArchive);
        //DEVIS//

        //DEVIS//

        //DEVIS
        SalesHeader."Source Quote Occurence No." := SalesHeaderArchive."Doc. No. Occurrence";
        SalesHeader."Source Quote Version No." := SalesHeaderArchive."Version No.";
        //DEVIS//

        //PROJET_FACT
        lScheduler.SETRANGE("Sales Header Doc. Type", SalesHeader."Document Type");
        lScheduler.SETRANGE("Sales Header Doc. No.", SalesHeader."No.");
        IF lScheduler.FIND('-') THEN
            REPEAT
                WITH lSchedulerArchive DO BEGIN
                    INIT;
                    TRANSFERFIELDS(lScheduler);
                    "Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                    "Version No." := SalesHeaderArchive."Version No.";
                    INSERT;
                END;
            UNTIL lScheduler.NEXT = 0;
        //PROJET_FACT//
        //FRAIS
        lJobCostAssgnt.SETRANGE("Document Type", SalesHeader."Document Type");
        lJobCostAssgnt.SETRANGE("Document No.", SalesHeader."No.");
        IF lJobCostAssgnt.FIND('-') THEN
            REPEAT
                lJobCostAssgntArchive.INIT;
                lJobCostAssgntArchive.TRANSFERFIELDS(lJobCostAssgnt);
                lJobCostAssgntArchive."Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                lJobCostAssgntArchive."Version No." := SalesHeaderArchive."Version No.";
                lJobCostAssgntArchive.INSERT;
            UNTIL lJobCostAssgnt.NEXT = 0;
        //FRAIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterSalesHeaderArchiveInsert', '', true, true)]
    local procedure OnAfterSalesHeaderArchiveInsert(var SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header")
    var
        lInteractLogEntry: Record "Interaction Log Entry";
    begin
        //DEVIS
        gSalesHeaderArchive := SalesHeaderArchive;
        //DEVIS//

        //+REF+MAILING
        lInteractLogEntry.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        lInteractLogEntry.SETRANGE("Sales Document Type", SalesHeader."Document Type");
        lInteractLogEntry.SETRANGE("Sales Document No.", SalesHeader."No.");
        IF lInteractLogEntry.FINDSET THEN
            REPEAT
                IF lInteractLogEntry."Version No." = 0 THEN BEGIN
                    lInteractLogEntry."Version No." := SalesHeaderArchive."Version No.";
                    lInteractLogEntry."Doc. No. Occurrence" := SalesHeaderArchive."Doc. No. Occurrence";
                    lInteractLogEntry.MODIFY;
                    IF NOT SalesHeaderArchive."Interaction Exist" THEN BEGIN
                        SalesHeaderArchive."Interaction Exist" := TRUE;
                        SalesHeaderArchive.MODIFY;
                    END;
                END;
            UNTIL lInteractLogEntry.NEXT = 0;
        //+REF+MAILING//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeArchiveSalesDocument', '', true, true)]
    local procedure OnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    VAR
        wNavibat: Record NavibatSetup;
        CduArchivMgment: Codeunit ArchiveManagement;
        ConfirmManagement: Codeunit "Confirm Management";
        Text007: Label 'Archive %1 no.: %2?';
        Text001: Label 'Document %1 has been archived.';
    begin
        //DEVIS
        //#8211
        //IF Transfert THEN BEGIN
        IF gQuoteToOrder THEN BEGIN
            //#8211//
            wNavibat.GET2;
            IF wNavibat."Archive Quote" THEN
                CduArchivMgment.StoreSalesDocument(SalesHeader, FALSE);
        END ELSE
            IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Quote THEN BEGIN
                if ConfirmManagement.GetResponseOrDefault(
                StrSubstNo(Text007, SalesHeader."Document Type", SalesHeader."No."), true)
           then begin
                    CduArchivMgment.StoreSalesDocument(SalesHeader, false);
                    Message(Text001, SalesHeader."No.");
                end;
            end
            //DEVIS
            ELSE
                CduArchivMgment.StoreSalesDocument(SalesHeader, FALSE);
        //DEVIS//

        //DEVIS//
        IsHandled := true;

    end;

    PROCEDURE gGetArchiveSalesDoc(VAR pArchiveSalesHeader: Record "Sales Header Archive");
    BEGIN
        pArchiveSalesHeader.COPY(gSalesHeaderArchive);
    END;

    PROCEDURE wCopyDescLine2Arch(pSalesHeaderArch: Record "Sales Header Archive");
    VAR
        lDescrLine: Record "Description Line";
        lDescrLineArchive: Record "Description Line Archive";
    BEGIN
        WITH pSalesHeaderArch DO BEGIN
            lDescrLine.RESET;
            lDescrLine.SETRANGE("Table ID", DATABASE::"Sales Header", DATABASE::"Sales Line");
            lDescrLine.SETRANGE("Document Type", pSalesHeaderArch."Document Type");
            lDescrLine.SETRANGE("Document No.", pSalesHeaderArch."No.");
            //  lDescrLine.SETRANGE("Line No.",SalesLine."Line No.");
            IF lDescrLine.FIND('-') THEN
                REPEAT
                    lDescrLineArchive.INIT;
                    lDescrLineArchive.TRANSFERFIELDS(lDescrLine);
                    lDescrLineArchive."Doc. No. Occurrence" := pSalesHeaderArch."Doc. No. Occurrence";
                    lDescrLineArchive."Version No." := pSalesHeaderArch."Version No.";
                    lDescrLineArchive.INSERT;
                UNTIL lDescrLine.NEXT = 0;
        END;
    END;

    PROCEDURE wCopyArchDescLine2Doc(pSalesHeaderArch: Record "Sales Header Archive");
    VAR
        lDescrLine: Record "Description Line";
        lDescrLineArchive: Record "Description Line Archive";
    BEGIN
        WITH pSalesHeaderArch DO BEGIN
            lDescrLine.SETRANGE("Table ID", DATABASE::"Sales Header", DATABASE::"Sales Line");
            lDescrLine.SETRANGE("Document Type", pSalesHeaderArch."Document Type");
            lDescrLine.SETRANGE("Document No.", pSalesHeaderArch."No.");
            IF NOT lDescrLine.ISEMPTY THEN
                lDescrLine.DELETEALL;

            lDescrLineArchive.SETRANGE("Table ID", DATABASE::"Sales Header");
            lDescrLineArchive.SETRANGE("Document Type", pSalesHeaderArch."Document Type");
            lDescrLineArchive.SETRANGE("Document No.", pSalesHeaderArch."No.");
            lDescrLineArchive.SETRANGE("Doc. No. Occurrence", pSalesHeaderArch."Doc. No. Occurrence");
            lDescrLineArchive.SETRANGE("Version No.", pSalesHeaderArch."Version No.");
            IF lDescrLineArchive.FIND('-') THEN
                REPEAT
                    lDescrLine.TRANSFERFIELDS(lDescrLineArchive);
                    lDescrLine.INSERT;
                UNTIL lDescrLineArchive.NEXT = 0;
        END;
    END;

    PROCEDURE fSetQuoteToOrder(pQuoteToOrder: Boolean);
    BEGIN
        gQuoteToOrder := pQuoteToOrder;
    END;

    var
        myInt: Integer;
        wSalesOverheadMargin: Record "Sales Overhead-Margin";
        wSalesOverheadMarginArchive: Record "Sales Overhead-Margin Archive";
        wTotalNeedParameter: Record "Sales Document Cost";
        gSalesHeaderArchive: Record "Sales Header Archive";
        gQuoteToOrder: Boolean;
}