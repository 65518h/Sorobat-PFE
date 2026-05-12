codeunit 50047 ReleaseSalesDocumentEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        CduReleasalesdoc: Codeunit "Prepayment Mgt.";
    begin
        //DEVIS
        IF SalesHeader.Finished THEN
            ERROR(tReleaseFinishErr);
        //DEVIS//
        //#8425
        fCheckSalesLinePrice(SalesHeader);
        //#8425//
        //#4367
        IF lSingleInstance.wGetSalesOverheadCalcfrom = 0 THEN
            lSingleInstance.wSetSalesOverheadIsCalculated(FALSE, 2);
        //#4367//

        //PERF
        wSalesHeader.SETPOSITION(SalesHeader.GETPOSITION);
        lSingleInstance.wSetSalesHeader(wSalesHeader);
        //PERF//

        //MB//
        IF CduReleasalesdoc.TestSalesPrepayment(SalesHeader) AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
            SalesHeader.Status := SalesHeader.Status::"Pending Prepayment";
            SalesHeader.MODIFY(TRUE);
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeCheckCustomerCreated', '', true, true)]
    local procedure OnBeforeCheckCustomerCreated(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeTestSellToCustomerNo', '', true, true)]
    local procedure OnBeforeTestSellToCustomerNo(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterCheckCustomerCreated', '', true, true)]
    local procedure OnCodeOnAfterCheckCustomerCreated(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var LinesWereModified: Boolean)
    var
        lProcessusWKFIntegr: Codeunit "Processus workflow Integr.";
    begin

        //+WKF+CUSTOM
        IF gAddOnLicencePermission.HasPermissionWKF() THEN
            IF lProcessusWKFIntegr.ReleaseSalesDoc(SalesHeader) THEN
                EXIT;
        //+WKF+CUSTOM//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeSalesLineFind', '', true, true)]
    local procedure OnBeforeSalesLineFind(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var LinesWereModified: Boolean; var IsHandled: Boolean)
    begin
        SalesLine.SETRANGE("Drop Shipment");

        //GL2024 CDU Navibat IF SalesLine.FINDFIRST THEN;
        //DEVIS//
        //DEVIS
        //GL2024 CDU Navibat CODEUNIT.RUN(CODEUNIT::"Job Cost Assignment", SalesLine);
        //   SalesLine.GET(SalesLine."Document Type", SalesLine."No.");
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterSalesLineCheck', '', true, true)]
    local procedure OnCodeOnAfterSalesLineCheck(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    begin
        //DEVIS
        SalesLine.TESTFIELD("Gen. Prod. Posting Group");
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN BEGIN
            SalesLine.VALIDATE("Fixed Price", TRUE);
            SalesLine.MODIFY;
        END;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeCalcInvDiscount', '', true, true)]
    local procedure OnBeforeCalcInvDiscount(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        //DEVIS  Sinon plantage dans "Sales-Calc. Discount"
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Drop Shipment");
        IF SalesLine.FINDFIRST THEN;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeModifySalesDoc', '', true, true)]
    local procedure OnBeforeModifySalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        lRecordRef: RecordRef;
        lTemplateMgt: Codeunit "Config. Template Management";
    begin
        //+REF+TEMPLATE
        lRecordRef.GETTABLE(SalesHeader);
        //DYS fonction Check supprimer 
        // lTemplateMgt.Check(lRecordRef, '');
        //+REF+TEMPLATE//
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnAfterCalcShouldSetStatusPrepayment', '', true, true)]
    // local procedure OnCodeOnAfterCalcShouldSetStatusPrepayment(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var ShouldSetStatusPrepayment: Boolean)
    // var
    //     lScheduler: Record "Invoice Scheduler";
    //     lSchedulerAmount: Decimal;
    //     lOpp: Record Opportunity;
    // begin
    //     //PROJET_FACT
    //     IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN BEGIN
    //         CLEAR(lScheduler);
    //         //#4328
    //         lScheduler.SETCURRENTKEY("Sales Header Doc. Type", "Sales Header Doc. No.", Invoice, "Line No.");
    //         lScheduler.SETRANGE("Sales Header Doc. Type", SalesHeader."Document Type");
    //         lScheduler.SETRANGE("Sales Header Doc. No.", SalesHeader."No.");
    //         //#5114
    //         lScheduler.SETFILTER("Amount Emitted", '<>0');
    //         IF lScheduler.ISEMPTY THEN BEGIN                   //Aucun montant ‚mis
    //             lScheduler.SETRANGE("Amount Emitted");
    //             lScheduler.SETFILTER("Amount to Emit", '<>0');
    //             IF lScheduler.ISEMPTY THEN BEGIN                   //Aucun montant … ‚mettre
    //                 lScheduler.SETRANGE("Amount to Emit");
    //                 lScheduler.SETRANGE(Invoice);
    //                 lScheduler.SETFILTER("Document Percentage", '<>0');
    //                 IF NOT lScheduler.ISEMPTY THEN BEGIN
    //                     lScheduler.FINDFIRST;
    //                     lScheduler.UpdateLineAmount(lScheduler);
    //                     lScheduler.SETRANGE("Document Percentage");
    //                 END;
    //             END ELSE
    //                 lScheduler.SETRANGE("Amount to Emit");
    //         END ELSE
    //             lScheduler.SETRANGE("Amount Emitted");
    //         //#5114//
    //         IF NOT lScheduler.ISEMPTY THEN BEGIN
    //             IF lScheduler.FINDSET THEN//
    //                 REPEAT
    //                     lSchedulerAmount += lScheduler."Amount to Emit";
    //                 UNTIL lScheduler.NEXT = 0;
    //             CrMemo := lScheduler."Amount to Emit" < 0;
    //             lScheduler.SETRANGE(Invoice);
    //             lScheduler.SETRANGE("Amount Emitted");
    //             lScheduler.CALCSUMS("Amount to Emit");
    //             wSalesHeader.CALCFIELDS(Amount);
    //             IF lScheduler."Amount to Emit" <> wSalesHeader.Amount THEN
    //                 ERROR(tInvSchedulerAmount, lScheduler."Amount to Emit", wSalesHeader.Amount);
    //         END;
    //         //#4328//
    //     END;
    //     //PROJET_FACT//

    //     //+REF+OPPORT
    //     IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) AND (lOpp.READPERMISSION) THEN
    //         lOpp.wUpdateOpportunity(SalesHeader, FALSE);
    //     //+REF+OPPORT//
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        lSalesHeader: Record "Sales Header";
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //#4367
        IF lSingleInstance.wGetSalesOverheadCalcfrom = 2 THEN
            lSingleInstance.wSetSalesOverheadIsCalculated(FALSE, 0);
        //#4367//

        //#4797
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) AND (wNaviBatSetup."Disable update totaling") THEN BEGIN
            lSingleInstance.wSetSalesHeader(SalesHeader);
            lSalesHeader.SETRANGE("Document Type", SalesHeader."Document Type");
            lSalesHeader.SETRANGE("No.", SalesHeader."No.");
            //GL2024 NAVIBAT   REPORT.RUNMODAL(REPORT::"Restore doc. Totaling", FALSE, FALSE, lSalesHeader);
        END;
        //#4797//
        //+REF+USEREXIT
        lRecordRef.GETTABLE(SalesHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Release Sales Document", +1);
        lRecordRef.SETTABLE(SalesHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReopenSalesDoc', '', true, true)]
    local procedure OnBeforeReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //PERF
        //  wSalesHeader.SETPOSITION(SalesHeader.GETPOSITION);
        lSingleInstance.wSetSalesHeader(SalesHeader);
        //PERF//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnReopenOnBeforeSalesHeaderModify', '', true, true)]
    local procedure OnReopenOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header")
    begin
        //DEVIS
        IF SalesHeader.Finished THEN
            ERROR(tReleaseFinishErr);
        //DEVIS//

        //#5087 (Pour avenants, sinon erreur)
        //GET("Document Type", "No.");
        //#5087//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReopenSalesDoc', '', true, true)]
    local procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; SkipWhseRequestOperations: Boolean)
    var
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(SalesHeader);
        lUserExit.CodeunitOnRun(lRecordRef, CODEUNIT::"Release Sales Document", -1);
        lRecordRef.SETTABLE(SalesHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnCheckTracking', '', true, true)]
    local procedure OnCodeOnCheckTracking(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin

    end;

    var
        myInt: Integer;
        wNaviBatSetup: Record NavibatSetup;
        wSalesHeader: Record "Sales Header";
        wArchiveManagement: Codeunit ArchiveManagement;
        ErrorFact: Label 'Vous ne pouvez pas rouvrir une commande facturée.';
        TextInvExist: Label 'Vous ne pouvez pas rouvrir une commande en cours de facturation : Facture %1.';
        tReleaseFinishErr: Label 'Vous ne pouvez pas modifier le statut d''un document soldé.';
        tInvSchedulerAmount: Label 'Le montant de l''échéancier %1 est différent du montant de la commande %2.';
        CrMemo: Boolean;
        gAddOnLicencePermission: Codeunit IntegrManagement;
        tErrSalesLineDirectCost: Label 'Le cout direct est supérieur ou egale au prix de vente pour la ligne N° : %1 - %2 - %3 du document de vente : %4 - %5';

    PROCEDURE fCheckSalesLinePrice(pSalesHeader: Record "Sales Header");
    VAR
        lSalesLine: Record "Sales Line";
        lNavibatSetup: Record NavibatSetup;
        lUnitPriceRounded: Decimal;
        lGeneralLedgerSetup: Record "General Ledger Setup";
    BEGIN
        //#8425
        /***********************************************************
        *                   fCheckSalesLinePrice                  *
        ***********************************************************
        * Input : Sales Header                                    *
        * Output : Void                                           *
        ***********************************************************
        * Verifie pour chaque ligne de vente du document de vente *
        * dont l'entete est pass‚ en parametre, si le cout direct *
        * est superieur ou egale au prix de vente.Dans ce cas un *
        * message d'erreur en avertira l'utilisateur              *
        ***********************************************************/
        //Le test de cette regle ne se fait que sous les contraintes suivantes :
        // * Uniquement sur les lignes de premier niveau
        // * Le type de ligne est necessairement diff‚rent de " "
        // * La ligne de vente n'est pas soumise … un prix fixe
        // * Aucun "prix trouv‚" ne doit ˆtre li‚ … cette ligne de vente
        // * Sans base de repartition
        // * Enfin, elle ne doit pas avoir de remise (ligne et/ou facture)
        // * Bien sur, cette regle s'applique ssi le parametre de la table navibat setup est selectionn‚
        lNavibatSetup.GET();
        lGeneralLedgerSetup.GET();
        IF (lNavibatSetup."Check Sales Document Price") THEN BEGIN
            lSalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            lSalesLine.SETRANGE("Document No.", pSalesHeader."No.");
            lSalesLine.SETRANGE("Document Type", pSalesHeader."Document Type");
            lSalesLine.SETRANGE("Structure Line No.", 0);
            lSalesLine.SETRANGE("Line Type", lSalesLine."Line Type"::Item, lSalesLine."Line Type"::"G/L Account");
            lSalesLine.SETFILTER(Quantity, '<>0');
            //  lSalesLine.SETFILTER("Line Type" , '<>%1', lSalesLine."Line Type"::Other);
            IF (NOT lSalesLine.ISEMPTY()) THEN BEGIN
                lSalesLine.FINDSET(FALSE, FALSE);
                REPEAT
                    IF NOT (lSalesLine."Fixed Price") AND (lSalesLine."Found Price" = 0) AND
                       (lSalesLine."Line Discount Amount" = 0) AND
                       //#8631
                       (lSalesLine."Assignment Basis" = lSalesLine."Assignment Basis"::" ") THEN BEGIN
                        //#8631//
                        lUnitPriceRounded := ROUND(lSalesLine."Unit Cost (LCY)", lGeneralLedgerSetup."Amount Rounding Precision");
                        IF (lUnitPriceRounded >= lSalesLine."Unit Price") THEN
                            ERROR(STRSUBSTNO(tErrSalesLineDirectCost,
                                             lSalesLine."Line No.",
                                             lSalesLine.Type,
                                             lSalesLine."No.",
                                             pSalesHeader."Document Type",
                                             pSalesHeader."No."));
                    END;
                UNTIL (lSalesLine.NEXT() = 0);
            END;
        END;
        //#8425//
    END;
}