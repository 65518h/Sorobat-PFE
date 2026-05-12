codeunit 50036 SalesQuoteOrderEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRun(var SalesHeader: Record "Sales Header")
    begin
        //+REF+USEREXIT
        lRecordRef.GETTABLE(SalesHeader);
        lUserexit.CodeunitOnRun(lRecordRef, CODEUNIT::"Sales-Quote to Order", -1);
        lRecordRef.SETTABLE(SalesHeader);
        //+REF+USEREXIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnCreateSalesHeaderOnBeforeSalesOrderLineLockTable', '', true, true)]
    local procedure OnCreateSalesHeaderOnBeforeSalesOrderLineLockTable(var SalesHeaderOrder: Record "Sales Header"; var SalesHeaderQuote: Record "Sales Header")
    begin
        //DEVIS

        IF lSalesSetup.GET AND (lSalesSetup."Order Nos." <> '') AND (lSalesSetup."Quote Nos." = lSalesSetup."Order Nos.") AND
           (SalesHeaderQuote."Rider to Order No." = '') THEN BEGIN
            SalesHeaderOrder."No." := SalesHeaderQuote."No.";
            SalesHeaderOrder."No. Series" := lSalesSetup."Quote Nos.";
        END ELSE
            //DEVIS//
            //WINPRO
            IF wOrderNo <> '' THEN
                SalesHeaderOrder."No." := wOrderNo
            ELSE
                //WINPRO//
                SalesHeaderOrder."No." := '';

        //PROJET_FACT
        //     {IF wMainOrder <> '' THEN BEGIN
        //     SalesHeaderOrder."Rider to Order No." := wMainOrder;
        //     SalesOrderHeader."Rider Rank" := wRiderRank;
        // END;}

        SalesHeaderOrder."Your Reference" := wYourReference;
        //#7320
        IF (wSubject <> '') THEN
            SalesHeaderOrder.Subject := wSubject;
        //#7320//

        //PROJET_FACT//

        //OPTION-DELETE
        CLEAR(lSalesLine);
        lSalesLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lSalesLine.SETRANGE("Document Type", SalesHeaderQuote."Document Type");
        lSalesLine.SETRANGE("Document No.", SalesHeaderQuote."No.");
        lSalesLine.SETRANGE("Structure Line No.", 0);
        lSalesLine.SETRANGE(Option, TRUE);
        IF NOT lSalesLine.ISEMPTY THEN BEGIN
            lSalesLine.FIND('-');
            lSalesLine.SuspendStatusCheck(TRUE);
            lSalesLine.wDeleteSalesHeader(TRUE);
            REPEAT
                lSalesLine.DELETE(TRUE);
                IF lSalesLine."Line Type" = lSalesLine."Line Type"::Totaling THEN
                    IF lSalesLine.FIND('-') THEN;
            UNTIL (lSalesLine.NEXT = 0);
        END;
        CLEAR(lSalesLine);
        //OPTION-DELETE//

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', true, true)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    begin
        //DEVIS : pour avoir la bonne souche de Nø
        SalesOrderHeader."Posting Date" := WORKDATE;
        //DEVIS//
        //AGENCE
        IF (lUserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') THEN BEGIN
            SalesOrderHeader.SetHideValidationDialog(TRUE);
            //   SalesOrderHeader.INSERT(TRUE);
            //   SalesOrderHeader.SetHideValidationDialog(FALSE);
        END
        //AGENCE//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterInsertSalesOrderHeader', '', true, true)]
    local procedure OnAfterInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        IF (lUserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') THEN
            SalesOrderHeader.SetHideValidationDialog(FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnCheckInProgressOpportunitiesOnBeforeRunCloseOpportunityPage', '', true, true)]
    local procedure OnCheckInProgressOpportunitiesOnBeforeRunCloseOpportunityPage(var TempOpportunityEntry: Record "Opportunity Entry" temporary; Opp: Record Opportunity; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var

        OpportunityEntry: Record "Opportunity Entry";
        SalesOrderHeader: Record "Sales Header";
    begin
        IF wSalesOrderHeaderNo = '' THEN begin


            IF Opp.FINDFIRST THEN BEGIN
                lCloseOpp.SETRANGE(Type, lCloseOpp.Type::Won);
                IF lCloseOpp.FINDFIRST THEN BEGIN
                    IF lCloseOpp.COUNT >= 1 THEN
                        IF PAGE.RUNMODAL(PAGE::"Close Opportunity Codes", lCloseOpp) = ACTION::LookupOK THEN BEGIN
                            SalesHeader."Close Opportunity Code" := lCloseOpp.Code;
                            //NAVIBAT
                            //#5015
                            IF lArchiveSalesDoc."No." <> '' THEN BEGIN
                                lArchiveSalesDoc."Close Opportunity Code" := lCloseOpp.Code;
                                lArchiveSalesDoc.MODIFY;
                            END;
                            //#5015//
                            //NAVIBAT//
                        END ELSE
                            ERROR(Text004);
                    TempOpportunityEntry.DELETEALL;
                    TempOpportunityEntry.INIT;
                    TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                    TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                    TempOpportunityEntry."Contact No." := Opp."Contact No.";
                    TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                    TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                    TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                    TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Won;
                    TempOpportunityEntry."Close Opportunity Code" := lCloseOpp.Code;
                    TempOpportunityEntry."Date Closed" := WORKDATE;
                    OpportunityEntry := TempOpportunityEntry;
                    OpportunityEntry.InsertEntry(OpportunityEntry, FALSE, FALSE);
                    OpportunityEntry.UpdateEstimates;
                    OpportunityEntry.MODIFY;
                    //+REF+OPPORT//
                end;
            end;
        end
        ELSE BEGIN
            SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order, wSalesOrderHeaderNo);
            //#7124
            Opp.RESET;
            Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
            Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
            Opp.SETRANGE("Sales Document No.", SalesHeader."No.");
            Opp.SETRANGE(Status, Opp.Status::"In Progress");
            IF Opp.FINDFIRST THEN BEGIN
                IF lCloseOpp.GET(SalesOrderHeader."Close Opportunity Code") THEN;
                TempOpportunityEntry.DELETEALL;
                TempOpportunityEntry.INIT;
                TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                TempOpportunityEntry."Contact No." := Opp."Contact No.";
                TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Won;
                TempOpportunityEntry."Close Opportunity Code" := lCloseOpp.Code;
                TempOpportunityEntry."Date Closed" := WORKDATE;
                OpportunityEntry := TempOpportunityEntry;
                OpportunityEntry.InsertEntry(OpportunityEntry, FALSE, FALSE);
                OpportunityEntry.UpdateEstimates;
                OpportunityEntry.MODIFY;
            END;
            //#7124//
            //#5723
            SalesOrderHeader.TESTFIELD("Invoicing Method", SalesHeader."Invoicing Method");
            IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN BEGIN
                wToInvScheduler.SETRANGE("Sales Header Doc. Type", wToInvScheduler."Sales Header Doc. Type"::Order);
                wToInvScheduler.SETRANGE("Sales Header Doc. No.", SalesOrderHeader."No.");
                wToInvScheduler.SETFILTER("Amount Emitted", '<>0');
                IF NOT wToInvScheduler.ISEMPTY THEN
                    ERROR(TextErrorScheduler, SalesHeader."No.", SalesOrderHeader."No.");
                wToInvScheduler.RESET;
            END;
            //#5723//
        END;
        //#4006//
        //+REF+CRM
        lInteractLogEntry.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        lInteractLogEntry.SETRANGE("Document Type", lInteractLogEntry.fSearchDocType(SalesHeader."Document Type", 0, 0));
        lInteractLogEntry.SETRANGE("Document No.", SalesHeader."No.");
        IF lInteractLogEntry.FINDSET THEN
            REPEAT
                lInteractLogEntry."Sales Document Type" := SalesOrderHeader."Document Type";
                lInteractLogEntry."Sales Document No." := SalesOrderHeader."No.";
                lInteractLogEntry.MODIFY;
            UNTIL lInteractLogEntry.NEXT = 0;
        //+REF+CRM//
        //DEVIS
        wDescriptionLine.CopyLines(DATABASE::"Sales Header", SalesHeader."Document Type", SalesHeader."No.", 0,
          DATABASE::"Sales Header", SalesOrderHeader."Document Type", SalesOrderHeader."No.", 0);
        //DEVIS//


    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeModifySalesOrderHeader', '', true, true)]
    local procedure OnBeforeModifySalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        //PROJET_FACT
        //#5723
        wToInvScheduler.SETRANGE("Sales Header Doc. Type", SalesOrderHeader."Document Type");
        wToInvScheduler.SETRANGE("Sales Header Doc. No.", SalesOrderHeader."No.");
        IF wToInvScheduler.ISEMPTY THEN BEGIN
            //#5723//
            wFromInvScheduler.SETRANGE("Sales Header Doc. Type", SalesQuoteHeader."Document Type");
            wFromInvScheduler.SETRANGE("Sales Header Doc. No.", SalesQuoteHeader."No.");
            IF wFromInvScheduler.FIND('-') THEN BEGIN
                wFromInvScheduler.UpdateLineAmount(wFromInvScheduler);
                REPEAT
                    wToInvScheduler.INIT;
                    wToInvScheduler.TRANSFERFIELDS(wFromInvScheduler);
                    wToInvScheduler."Sales Header Doc. Type" := SalesOrderHeader."Document Type";
                    wToInvScheduler."Sales Header Doc. No." := SalesOrderHeader."No.";
                    IF wFromInvScheduler."Job No." = SalesQuoteHeader."Job No." THEN
                        wToInvScheduler."Job No." := SalesOrderHeader."Job No.";
                    wToInvScheduler.INSERT;
                UNTIL wFromInvScheduler.NEXT = 0;
                wFromInvScheduler.DELETEALL;
            END;
            //#5723
        END;
        //#5723//
        //PROJET_FACT//
        //#5689 SalesOrderHeader."Order Date" := "Order Date";
        //DEVIS
        //IF "Posting Date" <> 0D THEN
        //  SalesOrderHeader."Posting Date" := "Posting Date";
        //SalesOrderHeader."Document Date" := "Document Date";
        SalesOrderHeader."Posting Date" := WORKDATE;
        //#5589
        //SalesOrderHeader.VALIDATE("Order Date",WORKDATE);
        //#7320
        IF wOrderDate = 0D THEN BEGIN
            IF SalesQuoteHeader."Order Date" <> 0D THEN
                wOrderDate := SalesQuoteHeader."Order Date"
            ELSE
                wOrderDate := WORKDATE;
        END;
        //#7320//
        SalesOrderHeader.VALIDATE("Order Date", wOrderDate);
        //#5589//
        SalesOrderHeader."Document Date" := SalesQuoteHeader."Order Date";
        //DEVIS//

        //DEVIS
        IF SalesOrderHeader."Progress Degree" <> '' THEN BEGIN
            lProgress.SETRANGE("Document Type", SalesOrderHeader."Document Type");
            IF lProgress.FIND('-') THEN
                SalesOrderHeader."Progress Degree" := lProgress.Code
            ELSE
                SalesOrderHeader."Progress Degree" := '';
        END;
        SalesOrderHeader."Invoicing Method" := SalesQuoteHeader."Invoicing Method";
        IF (SalesOrderHeader."Order Type" = SalesOrderHeader."Order Type"::Transfer) AND (SalesOrderHeader."Job No." <> '') AND
           (SalesOrderHeader."Transfer Job No." = '') THEN
            SalesOrderHeader."Transfer Job No." := SalesOrderHeader."Job No.";
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterCreateSalesHeader', '', true, true)]
    local procedure OnAfterCreateSalesHeader(var SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header")
    begin
        //ARCHIVE
        IF lArchiveSalesDoc."No." <> '' THEN BEGIN
            lArchiveSalesDoc."Order No." := SalesOrderHeader."No.";
            lArchiveSalesDoc.MODIFY;
        END;
        //ARCHIVE//

        //PREPAYMENT
        // CLEAR(SalesQuoteLine);
        //PREPAYMENT//

        //METRE
        //#6115
        lQuoteRecRef.GETTABLE(SalesHeader);
        lOrderRecRef.GETTABLE(SalesOrderHeader);
        IF (SalesHeader."Rider to Order No." = '') AND (wMainOrder = '') THEN BEGIN
            IF lBOQCustMgt.gDuplicateBOQXMLDoc(lQuoteRecRef, lOrderRecRef) THEN
                wBOQLoad := lBOQMgt.Load(lOrderRecRef.RECORDID);
            IF wBOQLoad THEN
                lBOQMgt.fSearchReplaceAttValue(FORMAT(lQuoteRecRef.RECORDID), FORMAT(lOrderRecRef.RECORDID), 'Node', 'RecordID');
        END ELSE BEGIN
            //  wBOQLoad := wCopyDocFurther.wCopyBillOfQtyToHeader(SalesOrderHeader,Rec,TRUE);
            wBOQLoad := lBOQMgt.Load(lOrderRecRef.RECORDID);
            IF wBOQLoad THEN BEGIN
                //lBOQCustMgt.gLoadSalesBOQ(SalesOrderHeader);
                //wBOQLoad := lBOQMgt.Load(lOrderRecRef.RECORDID);
                lBOQMgt.AddBOQFrom(lQuoteRecRef.RECORDID, lQuoteRecRef.RECORDID, lOrderRecRef.RECORDID, lOrderRecRef.RECORDID);
                wBOQLoad := TRUE;
            END;
        END;
        //#6115//

        //PLANNING_TASK
        lQuoteRef.GETTABLE(SalesHeader);
        lJobTaskRecordIDMgt.LoadLingSourceBuffer(lQuoteRef, gPlanningLinkSourceIDBuffer);
        //PLANNING_TASK//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnTransferQuoteToOrderLinesOnAfterSetFilters', '', true, true)]
    local procedure OnTransferQuoteToOrderLinesOnAfterSetFilters(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header")
    begin
        //PREPAYMENT
        SalesQuoteLine.SETRANGE("Line Type", SalesQuoteLine."Line Type"::Other);
        IF NOT SalesQuoteLine.ISEMPTY THEN
            SalesQuoteLine.MODIFYALL("Presentation Code", '999');
        //PREPAYMENT//

        //PREPAYMENT
        //SalesQuoteLine.RESET;
        CLEAR(SalesQuoteLine);
        SalesQuoteLine.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code");
        //PREPAYMENT//
        SalesQuoteLine.SETRANGE("Order Type", SalesQuoteHeader."Order Type");
        SalesQuoteLine.SETRANGE("Document Type", SalesQuoteHeader."Document Type");
        SalesQuoteLine.SETRANGE("Document No.", SalesQuoteHeader."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnTransferQuoteToOrderLinesOnBeforeUpdatePrepaymentPct', '', true, true)]
    local procedure OnTransferQuoteToOrderLinesOnBeforeUpdatePrepaymentPct(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header"; var SalesOrderLine: Record "Sales Line"; var SalesOrderHeader: Record "Sales Header"; Customer: Record Customer)
    begin
        //#5034
        SalesOrderLine."Order Date" := wOrderDate;
        //#5034//
        //#5197
        SalesOrderLine."Presentation Code" := PresentationMgt.wIncPresentation(SalesQuoteLine, 1, -1);
        //#5197//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterInsertSalesOrderLine', '', true, true)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
        //#7437
        //IF SalesOrderLine."Line Type" = SalesOrderLine."Line Type"::Other THEN
        //  SalesOrderLine."Presentation Code" := '';
        //#7437//
        //#5034
        SalesOrderLine."Order Date" := wOrderDate;
        //#5034//
        //#4006
        //PREPAYMENT
        wLineNo += 10000;
        TempSalesLineNo."Old Line No." := SalesQuoteLine."Line No.";
        TempSalesLineNo."New Line No." := wLineNo;
        TempSalesLineNo.INSERT;
        SalesOrderLine."Line No." := wLineNo;
        IF SalesQuoteLine."Structure Line No." <> 0 THEN BEGIN
            TempSalesLineNo.GET(SalesQuoteLine."Structure Line No.");
            SalesOrderLine."Structure Line No." := TempSalesLineNo."New Line No.";
        END;
        IF SalesQuoteLine."Attached to Line No." <> 0 THEN BEGIN
            TempSalesLineNo.GET(SalesQuoteLine."Attached to Line No.");
            SalesOrderLine."Attached to Line No." := TempSalesLineNo."New Line No.";
        END;
        //#4006//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterTransferQuoteToOrderLines', '', true, true)]
    local procedure OnAfterTransferQuoteToOrderLines(var SalesQuoteLine: Record "Sales Line"; var SalesQuoteHeader: Record "Sales Header")
    begin
        // //#5840
        //         IF (SalesQuoteHeader."Order Type" = SalesQuoteHeader."Order Type"::" ") AND
        //            (SalesQuoteHeader."Invoicing Method" <> SalesQuoteHeader."Invoicing Method"::Direct) AND
        //            (SalesQuoteLine."Qty. to Ship" <> 0) THEN BEGIN
        //            //#6335
        //             lSalesSetup.GET;
        //             IF lSalesSetup."Default Quantity to Ship" = lSalesSetup."Default Quantity to Ship"::Blank THEN BEGIN
        //               SalesQuoteLine.VALIDATE("Qty. to Ship",0);
        //               SalesQuoteLine.VALIDATE("Qty. to Invoice",0);
        //             END;
        //            //#6365//
        //         END;
        //         //#5840//
        //     //DEVIS
        //         IF (SalesQuoteLine.Subcontracting = SalesQuoteLine.Subcontracting::" ") AND
        //            (SalesQuoteLine."Purchasing Order No." <> '') THEN BEGIN
        //           CLEAR(SalesQuoteLine."Purchase Order No.");
        //           CLEAR(SalesQuoteLine."Purch. Order Line No.");
        //           CLEAR(SalesQuoteLine."Special Order Purchase No.");
        //           CLEAR(SalesQuoteLine."Special Order Purch. Line No.");
        //           CLEAR(SalesQuoteLine."Purchasing Order No.");
        //           CLEAR(SalesQuoteLine."Purchasing Order Line No.");
        //         END;
        //     //DEVIS//
        //     //PIED_DEVIS
        //         IF (SalesQuoteLine."Line Type" = SalesQuoteLine."Line Type"::Other) THEN
        //           SalesQuoteLine."Fixed Price" := TRUE;
        //     //PIED_DEVIS//
        //         SalesQuoteLine.MODIFY;
        //     //DEVIS
        //         wDescriptionLine.CopyLines(DATABASE::"Sales Line","Document Type","No.",SalesQuoteLine."Line No.",
        //           DATABASE::"Sales Line",SalesQuoteHeader."Document Type",SalesQuoteHeader."No.",SalesOrderLine."Line No.");

        //         wTotalNeedQuote.RESET;
        //         wTotalNeedQuote.SETRANGE("Document Type","Document Type");
        //         wTotalNeedQuote.SETRANGE("Document No.","No.");
        //         wTotalNeedQuote.SETRANGE("Line No.",SalesOrderLine."Line No.");
        //         IF NOT wTotalNeedQuote.ISEMPTY THEN BEGIN
        //           wTotalNeedQuote.FIND('-');
        //           REPEAT
        //             wTotalNeedOrder := wTotalNeedQuote;
        //             wTotalNeedOrder."Document Type" := SalesOrderLine."Document Type";
        //             wTotalNeedOrder."Document No." := SalesOrderLine."Document No.";
        //             wTotalNeedOrder.INSERT;
        //             IF (wTotalNeedQuote."Purchasing Order No." <> '') THEN BEGIN
        //               IF lPurchaseLine.GET(wTotalNeedQuote."Purchasing Document Type",wTotalNeedQuote."Purchasing Order No.",
        //                                   wTotalNeedQuote."Purchasing Order Line No.") THEN BEGIN
        //                  lPurchaseLine."Sales Order No." := SalesQuoteLine."Document No.";
        //                  lPurchaseLine."Sales Order Line No." := SalesQuoteLine."Line No.";
        //                  lPurchaseLine."Sales Document Type" := SalesQuoteLine."Document Type" + 1;
        //                  lPurchaseLine."Job No." := SalesQuoteLine."Job No.";
        //                  lPurchaseLine.MODIFY;
        //               END;
        //             END;
        //             wTotalNeedQuote.DELETE;
        //           UNTIL wTotalNeedQuote.NEXT = 0;
        //         END;
        //     //DEVIS//

        //     //Frais #3852
        //     wMAJOverhead("No.",SalesOrderHeader."No.");
        //     //Frais g‚n‚raux//

        //     //SUBCONTRACTOR
        //         IF (SalesQuoteLine."Vendor No." <> '') AND
        //            (SalesQuoteLine."Drop Shipment" OR
        //             SalesQuoteLine."Special Order" OR
        //            (SalesQuoteLine.Subcontracting <> SalesQuoteLine.Subcontracting::" "))
        //         THEN
        //           IF wPurchLine.GET(
        //                SalesQuoteLine."Purchasing Document Type",
        //                SalesQuoteLine."Purchasing Order No.",
        //                SalesQuoteLine."Purchasing Order Line No.")
        //           THEN BEGIN
        //             wPurchLine."Sales Document Type" := SalesQuoteLine."Document Type" + 1;
        //             wPurchLine."Sales Order No." := SalesQuoteLine."Document No.";
        //             wPurchLine."Sales Order Line No." := SalesQuoteLine."Line No.";
        //             wPurchLine."Sales Document Type" := SalesQuoteLine."Document Type" + 1;
        //             wPurchLine."Job No." := SalesQuoteLine."Job No.";
        //             wPurchLine."Job Task No." := SalesQuoteLine."Job Task No.";
        //             wPurchLine.MODIFY;

        //             lPurchLine.RESET;
        //             lPurchLine.SETRANGE("Attached to Doc. Type",wPurchLine."Document Type");
        //             lPurchLine.SETRANGE("Attached to Doc. No.",wPurchLine."Document No.");
        //             IF lPurchLine.FIND('-') THEN
        //               REPEAT
        //                 lPurchLine."Sales Document Type" := SalesQuoteLine."Document Type" + 1;
        //                 lPurchLine."Sales Order No." := SalesQuoteLine."Document No.";
        //                 lPurchLine."Sales Order Line No." := SalesQuoteLine."Line No.";
        //                 lPurchLine."Sales Document Type" := SalesQuoteLine."Document Type" + 1;
        //                 lPurchLine."Job No." := SalesQuoteLine."Job No.";
        //                 lPurchLine."Job Task No." := SalesQuoteLine."Job Task No.";
        //                 lPurchLine.MODIFY;
        //               UNTIL lPurchLine.NEXT = 0;
        //             SalesQuoteLine."Purchasing Document Type" := SalesQuoteLine."Purchasing Document Type";
        //             SalesQuoteLine."Purchasing Order No." := SalesQuoteLine."Purchasing Order No.";
        //             SalesQuoteLine."Purchasing Order Line No." := SalesQuoteLine."Purchasing Order Line No.";
        //             SalesOrderLSalesQuoteLinene.MODIFY;
        //           END;
        //     //SUBCONTRACTOR//

        //     //METRE
        //     //#6115
        //     lQuoteRecRef.GETTABLE(SalesQuoteLine);
        //     lOrderRecRef.GETTABLE(SalesQuoteLine);
        //     IF wBOQLoad THEN BEGIN
        //       IF ("Rider to Order No." = '') THEN BEGIN
        //          lBOQMgt.fSearchReplaceAttValue(FORMAT(lQuoteRecRef.RECORDID),FORMAT(lOrderRecRef.RECORDID),'Node','RecordID');
        //       END ELSE BEGIN
        //         //IF wBOQLoad THEN
        //         //  wCopyDocFurther.wCopyBillOfQtyToLine(SalesOrderHeader,SalesOrderLine,Rec,SalesQuoteLine,wBOQLoad);
        //         lBOQMgt.fSearchReplaceAttValue(FORMAT(lQuoteRecRef.RECORDID),FORMAT(lOrderRecRef.RECORDID),'Node','RecordID');
        //       END;
        //     END;
        //     //#6115//
        //     //METRE
    end;


    var
        myInt: Integer;
        lJobTaskRecordIDMgt: Codeunit "Planning RecordID Mgt";
        lQuoteRef: RecordRef;
        lOrderRef: RecordRef;
        lQuoteRefLine: RecordRef;
        lOrderRefLine: RecordRef;
        lProgress: Record "Document Progress Degree";
        lSalesHeader: Record "Sales Header";
        lPurchaseLine: Record "Purchase Line";
        lRespCenter: Record "Responsibility Center";
        lSalesLine: Record "Sales Line";
        lQuotePlanning: Record "Planning Entry";
        lOrderPlanning: Record "Planning Entry";
        //lCreateJob : Form 8004050;
        // lUpdateBudget : Report 8004052;
        lUserMgt: Codeunit "User Setup Management";
        lNum: Integer;
        lNum2: Integer;
        lInteractLogEntry: Record "Interaction Log Entry";
        lSalesSetup: Record "Sales & Receivables Setup";
        lPurchLine: Record "Purchase Line";
        lCloseOpp: Record "Close Opportunity Code";
        lJobStatus: Record "Job Status";
        lJobBudgetEntry: Record "Job Planning Line";
        lArchiveSalesDoc: Record "Sales Header Archive";
        lJobBudgetEntry2: Record "Job Planning Line";
        lUserexit: Codeunit UserExit;
        lRecordRef: RecordRef;
        lContractType: Record "Contract Type";
        lStandardText: Record "Standard Text";
        lSalesCommentLine: Record "Sales Comment Line";
        TempSalesLineNo: Record "Sales Line No. Buffer" temporary;
        lContributorLineNo: Integer;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lQuoteRecRef: RecordRef;
        lOrderRecRef: RecordRef;
        lSingleInstance: Codeunit "Import SingleInstance2";
        wNaviBatSetup: Record NavibatSetup;
        wContributorQuote: Record "Sales Contributor";
        wContributorOrder: Record "Sales Contributor";
        wArchiveManagement: Codeunit ArchiveManagement;
        wDescriptionLine: Record "Description Line";
        wFromInvScheduler: Record "Invoice Scheduler";
        wToInvScheduler: Record "Invoice Scheduler";
        wTotalNeedQuote: Record "Sales Document Cost";
        wTotalNeedOrder: Record "Sales Document Cost";
        wPurchLine: Record "Purchase Line";
        wSalesDescription: Record "Description Line";
        wOldSalesDescription: Record "Description Line";
        wJobCostQuote: Record "Job Cost Assignment";
        wJobCostOrder: Record "Job Cost Assignment";
        Text005: Label 'Cette commande devrait être l''avenant N°';
        Text006: Label 'Quel est votre numéro d''avenant?';
        tStopProcess: Label 'Le traitement a été interrompu.';
        Text004: Label 'L''opportunité n''est pas terminée. Le programme n''a pas pu créer la commande.';
        wOrderNo: Code[20];
        wJobExist: Boolean;
        FlorianTMP: Record "Sales Overhead-Margin";
        wSalesOrderHeaderNo: Code[20];
        wLineNo: Integer;
        PresentationMgt: Codeunit "Presentation Management";
        wMainOrder: Code[20];
        wRiderRank: Integer;
        wYourReference: Text[50];
        wOrderDate: Date;
        textAddComment: label 'Voulez-vous copier les commentaires du document ?';
        tYourReference: Label 'Votre Référence doit être renseignée';
        gIsNewRank: Boolean;
        wCopyDocFurther: Codeunit "Copy Document Further";
        wSubject: Text[50];
        TextErrorScheduler: Label 'L''échéancier de la commande a déjà été facturé, Vous pourrez donc pas ajouter le devis nø %1 … la commande nø %2';
        wBOQLoad: Boolean;
        gPlanningLinkSourceIDBuffer: Record "Planning Link Source ID Buffer" temporary;

    PROCEDURE wJobPhaseExist(pJobExist: Boolean);
    BEGIN
        //WINPRO
        wJobExist := pJobExist;
    END;

    PROCEDURE wSetOrderNo(pDocNo: Code[20]);
    BEGIN
        //WINPRO
        wOrderNo := pDocNo;
    END;

    PROCEDURE wMAJOverhead(pQuoteNo: Code[20]; pOrderNo: Code[20]);
    VAR
        lQuoteOverheadMargin: Record "Sales Overhead-Margin";
        lOrderOverheadMargin: Record "Sales Overhead-Margin";
    BEGIN
        //#8257
        /*
         lSalesOverheadMargin.SETRANGE("Document Type",lSalesOverheadMargin."Document Type"::Quote);
         lSalesOverheadMargin.SETRANGE("Document No.",pOrderNo);
         IF lSalesOverheadMargin.ISEMPTY THEN BEGIN
           lSalesOverheadMargin.FIND('-');
           REPEAT
              lSalesOverheadMargin2.SETRANGE("Document Type",lSalesOverheadMargin."Document Type"::Order);
              lSalesOverheadMargin2.SETRANGE("Document No.",pQuoteNo);
              lSalesOverheadMargin2.SETRANGE("Gen. Prod. Post. Code",lSalesOverheadMargin."Gen. Prod. Post. Code");
              IF lSalesOverheadMargin2.ISEMPTY THEN BEGIN
                lSalesOverheadMargin2.FINDFIRST;
                lSalesOverheadMargin2.Overhead := lSalesOverheadMargin.Overhead;
                lSalesOverheadMargin2.MODIFY;
              END ELSE BEGIN
                lSalesOverheadMargin2.COPY(lSalesOverheadMargin);
                lSalesOverheadMargin2."Document Type" :=  lSalesOverheadMargin2."Document Type"::Order;
                lSalesOverheadMargin2."Document No." := pQuoteNo;
                lSalesOverheadMargin2.INSERT;
              END;
           UNTIL lSalesOverheadMargin.NEXT = 0;
         END;
         */
        lQuoteOverheadMargin.SETRANGE("Document Type", lQuoteOverheadMargin."Document Type"::Quote);
        lQuoteOverheadMargin.SETRANGE("Document No.", pQuoteNo);
        IF lQuoteOverheadMargin.FINDSET THEN
            REPEAT
                lOrderOverheadMargin.COPY(lQuoteOverheadMargin);
                lOrderOverheadMargin."Document Type" := lOrderOverheadMargin."Document Type"::Order;
                lOrderOverheadMargin."Document No." := pOrderNo;
                IF lOrderOverheadMargin.INSERT THEN; // En cas d'avenant
                lQuoteOverheadMargin.DELETE;
            UNTIL lQuoteOverheadMargin.NEXT = 0;
        //#8257//
    END;

    PROCEDURE wUpdateQuote(VAR Rec: Record "Sales Header"; pIsNewRankNo: Boolean);
    VAR
        lTabCode: ARRAY[20] OF Integer;
        lLastSalesOrderLine: Record "Sales Line";
        lSalesLine: Record "Sales Line";
        lPresLevel: Integer;
        lSalesHeader: Record "Sales Header";
        lReleaseSalesDoc: Codeunit "Release Sales Document";
    BEGIN
        //#4006
        lSalesHeader.GET(lSalesHeader."Document Type"::Order, wSalesOrderHeaderNo);
        lSalesHeader.TESTFIELD("Bill-to Customer No.", Rec."Bill-to Customer No.");

        //#6868
        lReleaseSalesDoc.Reopen(Rec);
        //#6868//
        //#4569
        lReleaseSalesDoc.Reopen(lSalesHeader);
        //#4569//
        lLastSalesOrderLine.SETRANGE("Document Type", lLastSalesOrderLine."Document Type"::Order);
        lLastSalesOrderLine.SETRANGE("Document No.", wSalesOrderHeaderNo);
        //#5197
        IF lLastSalesOrderLine.ISEMPTY THEN
            EXIT;
        //#5197//
        lLastSalesOrderLine.FINDLAST;
        wLineNo := lLastSalesOrderLine."Line No." DIV 10000;
        wLineNo := wLineNo * 10000;

        lLastSalesOrderLine.SETRANGE("Structure Line No.", 0);
        lLastSalesOrderLine.SETFILTER("Line Type", '<>%1', lLastSalesOrderLine."Line Type"::Other);
        IF lLastSalesOrderLine.FINDLAST THEN BEGIN
            PresentationMgt.wMajTab(lLastSalesOrderLine, lTabCode);
            lPresLevel := lTabCode[1] + 1;
        END;
        //#8019
        IF NOT pIsNewRankNo AND (lPresLevel > 0) THEN
            lPresLevel := lPresLevel - 1;
        //#8019//
        lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lSalesLine.SETRANGE("Document Type", Rec."Document Type");
        lSalesLine.SETRANGE("Document No.", Rec."No.");
        lSalesLine.SETRANGE("Structure Line No.", 0);
        IF lSalesLine.FINDSET(TRUE, FALSE) THEN BEGIN
            REPEAT
                //#5494
                //    IF (lSalesLine."No." <> '') OR
                //       (lSalesLine."Line Type" <> lSalesLine."Line Type"::" ") THEN BEGIN
                IF ((lSalesLine."No." <> '') OR (lSalesLine."Line Type" <> lSalesLine."Line Type"::" ") OR
                    (lSalesLine."Attached to Line No." = 0))
                    AND (lSalesLine."Line Type" <> lSalesLine."Line Type"::Other) THEN BEGIN
                    //#5494//
                    lSalesLine.VALIDATE("Presentation Code", PresentationMgt.wIncPresentation(lSalesLine, 1, lPresLevel));
                    lSalesLine.MODIFY;
                END;
            UNTIL lSalesLine.NEXT = 0;
        END;
        //#4006//
    END;

    PROCEDURE fIsNewRank(): Boolean;
    BEGIN
        EXIT(gIsNewRank);
    END;
}