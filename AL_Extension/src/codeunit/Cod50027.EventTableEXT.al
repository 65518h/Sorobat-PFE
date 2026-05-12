codeunit 50027 "Event_TableEXT"
{
    //*************************************Table 4************************************************//
    [EventSubscriber(ObjectType::Table, Database::Currency, 'OnAfterInitRoundingPrecision', '', true, true)]
    local procedure OnAfterInitRoundingPrecision(var Currency: Record Currency; var xCurrency: Record Currency; var GeneralLedgerSetup: Record "General Ledger Setup")
    var
    begin
        //#5923 
        IF GeneralLedgerSetup."Sales Unit-Amt Round. Prec." <> 0 THEN
            Currency."Sales Unit-Amt Round. Prec." := GeneralLedgerSetup."Sales Unit-Amt Round. Prec."
        ELSE
            Currency."Sales Unit-Amt Round. Prec." := 0.00001;//
        //#5923//
    end;


    //*************************************Table 18************************************************//



    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsert', '', true, true)]
    local procedure OnBeforeInsert(var Customer: Record Customer; var IsHandled: Boolean)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //+REF+TEMPLATE
        IF (Customer."No." = '') AND (Customer."No. Series" <> '') THEN
            NoSeriesMgt.InitSeries(Customer."No. Series", Customer."No. Series", 0D, Customer."No.", Customer."No. Series");
        //+REF+TEMPLATE//



        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeCheckIfOrderSalesLinesExist', '', true, true)]
    local procedure OnBeforeCheckIfOrderSalesLinesExist(var Customer: Record Customer; var IsHandled: Boolean)
    var
        lResPrice: Record "Resource Price";
    begin
        //OUVRAGE
        lResPrice.SETRANGE(lResPrice."Customer No.", Customer."No.");
        lResPrice.DELETEALL;
        //OUVRAGE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Detailed CV Ledg. Entry Buffer", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(var DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJnlLine: Record "Gen. Journal Line")
    begin

    end;


    //*************************************Table 23************************************************//
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeOnInsert', '', true, true)]
    local procedure OnBeforeOnInsert(var Vendor: Record Vendor; var IsHandled: Boolean)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //+REF+TEMPLATE

        IF (Vendor."No." = '') AND (Vendor."No. Series" <> '') THEN
            NoSeriesMgt.InitSeries(Vendor."No. Series", Vendor."No. Series", 0D, Vendor."No.", Vendor."No. Series");
        //+REF+TEMPLATE// 

        IsHandled := true;
    end;


    //*************************************Table 27************************************************//
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeOnInsert', '', true, true)]
    local procedure OnBeforeOnInsert27(var Item: Record Item; var IsHandled: Boolean; xRecItem: Record Item)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        //+REF+TEMPLATE
        IF (Item."No." = '') AND (Item."No. Series" <> '') THEN
            NoSeriesMgt.InitSeries(Item."No. Series", Item."No. Series", 0D, Item."No.", Item."No. Series");
        //+REF+TEMPLATE//
    end;



    [EventSubscriber(ObjectType::Table, Database::Item, 'OnModifyOnBeforePlanningAssignmentItemChange', '', true, true)]
    local procedure OnModifyOnBeforePlanningAssignmentItemChange(var Item: Record Item; xItem: Record Item; PlanningAssignment: Record "Planning Assignment"; var IsHandled: Boolean)
    begin
        Item.Synchronise := FALSE;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterDeleteRelatedData', '', true, true)]
    local procedure OnAfterDeleteRelatedData(Item: Record Item)
    var

        lStructureComponent: Record "Structure Component";
        PurchLineDisc: Record "Purchase Line Discount";
        tStructureUsed: label 'You cannot delete %1 %2 because there is at least one structure component that includes this item.';
    begin

        //+OFF+REMISE
        PurchLineDisc.SETRANGE(Type, PurchLineDisc.Type::Item);
        PurchLineDisc.SETRANGE("Item No.", Item."No.");
        PurchLineDisc.DELETEALL;


        //PurchLineDisc.SETRANGE("Item No.","No.");
        //PurchLineDisc.DELETEALL;
        //+OFF+REMISE//

        //OUVRAGE
        lStructureComponent.SETCURRENTKEY(Type, "No.");
        lStructureComponent.SETRANGE(Type, lStructureComponent.Type::Item);
        lStructureComponent.SETRANGE("No.", Item."No.");
        IF NOT lStructureComponent.ISEMPTY THEN
            ERROR(tStructureUsed, Item.TABLECAPTION, Item."No.");
        //OUVRAGE//
    end;



    [EventSubscriber(ObjectType::Table, Database::Item, 'OnValidateBaseUnitOfMeasure', '', true, true)]
    local procedure OnValidateBaseUnitOfMeasure(var ValidateBaseUnitOfMeasure: Boolean)
    begin
        ValidateBaseUnitOfMeasure := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeUpdateQtyRoundingPrecisionForBaseUoM', '', true, true)]
    local procedure OnBeforeUpdateQtyRoundingPrecisionForBaseUoM(var Item: Record Item; xItem: Record Item; var IsHandled: Boolean)
    var
        lUnitOfMeasure: Record "Unit of Measure";

        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //+REF+UNIT
        lUnitOfMeasure.GET(Item."Base Unit of Measure");
        WITH ItemUnitOfMeasure DO BEGIN
            SETRANGE("Item No.", Item."No.");
            IF ISEMPTY THEN BEGIN
                "Item No." := Item."No.";
                Code := Item."Base Unit of Measure";
                "Qty. per Unit of Measure" := 1;
                INSERT;
            END;
        END;
        //+REF+UNIT//
    end;


    //*************************************Table 36************************************************//

    //Pour page 507
    [EventSubscriber(ObjectType::table, Database::"Sales Header", 'OnBeforeOpenDocumentStatistics', '', true, true)]
    local procedure OnBeforeOpenDocumentStatistics(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var

        SalesSetup: Record "Sales & Receivables Setup";
    begin

        SalesSetup.GET;
        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
            SalesHeader.PrepareOpeningDocumentStatistics();
        end;
        SalesHeader.ShowDocumentStatisticsPage();
        IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', true, true)]

    local procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    var

        wNaviBatSetup: Record NavibatSetup;
    begin
        //CESSION
        IF SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer THEN
            wNaviBatSetup.GET;
        //CESSION//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeGetNextArchiveDocOccurrenceNo', '', true, true)]
    local procedure OnInitRecordOnBeforeGetNextArchiveDocOccurrenceNo(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        wJob: Record Job;
    begin

        //JOB_TO_QUOTE

        IF SalesHeader.GETFILTER("Job No.") <> '' THEN BEGIN
            SalesHeader.VALIDATE("Job No.", SalesHeader.GETFILTER("Job No."));
            SalesHeader.wUpdateDocFromJob;




            //#7804
            //IF ("Order Type" = 0) AND ("Sell-to Customer No." = '') THEN
            IF (SalesHeader."Order Type" IN [0, 2]) AND (SalesHeader."Sell-to Customer No." = '') THEN
                //#7804//
                 IF wJob.GET(SalesHeader."Job No.") AND (wJob."Bill-to Customer No." <> '') THEN
                    SalesHeader.VALIDATE("Sell-to Customer No.", wJob."Bill-to Customer No.");
        END;
        //JOB_TO_QUOTE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure OnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        //+REF+USERID
        SalesHeader."Doc. Creation Date" := TODAY;
        SalesHeader."User ID" := USERID;
        //+REF+USERID//
    end;


    [EventSubscriber(ObjectType::table, Database::"Sales Header", 'OnBeforeDeleteSalesLines', '', true, true)]

    local procedure OnBeforeDeleteSalesLines(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; var SalesHeader: Record "Sales Header");
    begin
        IsHandled := true;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateOpportunity', '', true, true)]
    local procedure OnBeforeUpdateOpportunity(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")

    var
        SalesLine: record "Sales Line";
        Text8001400: label 'Do you want to archive the quote?';
        Text8001401: label 'You must choose the loss reason.';
        Text044: Label 'The status of the opportunity has not been changed. The program has aborted deleting the order.';
        tArchiveOK: label 'Document %1 has been archived.';
        Opp: Record Opportunity;
        TempOpportunityEntry: Record "Opportunity Entry" TEMPORARY;
        lOppEntry: Record "Opportunity Entry";
        lRMCommentLine: Record "Rlshp. Mgt. Comment Line";
        wArchiveManagement: Codeunit ArchiveManagement;
        lCloseOppCode: Record "Close Opportunity Code";
        fOpportunityActive: Boolean;
        HideValidationDialog: Boolean;
    begin
        IsHandled := true;
        /*   //+REF+OPPORTUNITE
           SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
           SalesLine.SETRANGE("Document No.", SalesHeader."No.");
           IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) AND
              (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") AND
             ((SalesHeader."Bill-to Customer No." <> '') OR (SalesHeader."Bill-to Contact No." <> '')) AND
              //DEVIS   NOT HideValidationDialog AND ("Opportunity No." <> '')
              NOT HideValidationDialog
           THEN
               IF CONFIRM(Text8001400, TRUE) THEN BEGIN
                   //#6968
                   IF (fOpportunityActive) THEN BEGIN
                       //#6968//
                       //GL2024   CLEAR(page);
                       IF ACTION::LookupOK = page.RUNMODAL(page::"Close Opportunity Codes", lCloseOppCode) THEN
                           SalesHeader."Close Opportunity Code" := lCloseOppCode.Code
                       ELSE
                           ERROR(Text8001401);

                       IF SalesHeader."Opportunity No." <> '' THEN BEGIN
                           Opp.RESET;
                           Opp.SETRANGE("No.", SalesHeader."Opportunity No.");
                           IF Opp.FIND('-') THEN BEGIN
                               TempOpportunityEntry.INIT;
                               TempOpportunityEntry.DELETEALL;
                               TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                               TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                               TempOpportunityEntry."Contact No." := Opp."Contact No.";
                               TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                               TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                               TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                               TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Lost;
                               TempOpportunityEntry."Close Opportunity Code" := lCloseOppCode.Code;
                               TempOpportunityEntry."Date Closed" := SalesHeader."Order Date";
                               lOppEntry := TempOpportunityEntry;
                               lOppEntry.InsertEntry(lOppEntry, FALSE, FALSE);
                               lOppEntry.UpdateEstimates;
                               lOppEntry.MODIFY;
                               //#7631
                               /*  {DELETE
                                            Opp.Closed := TRUE;
                                              Opp.MODIFY;
                                              DELETE}*/
        //#7631//
        /*   END ELSE
               ERROR(Text044);
       END;
       //#6968
   END;
   //#6968//
   wArchiveManagement.StoreSalesDocument(SalesHeader, FALSE);
   MESSAGE(tArchiveOK, SalesHeader."No.");
END ELSE BEGIN
   IF SalesHeader."Opportunity No." <> '' THEN
       IF Opp.GET(SalesHeader."Opportunity No.") THEN BEGIN
           lRMCommentLine.SETRANGE("Table Name", lRMCommentLine."Table Name"::Opportunity);
           lRMCommentLine.SETRANGE("No.", SalesHeader."No.");
           lRMCommentLine.DELETEALL;

           lOppEntry.SETCURRENTKEY("Opportunity No.");
           lOppEntry.SETRANGE("Opportunity No.", SalesHeader."No.");
           lOppEntry.DELETEALL;

           Opp.DELETE;
       END;
END;*/

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteOnBeforeArchiveSalesDocument', '', true, true)]
    local procedure OnDeleteOnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Opp: Record Opportunity;
        TempOpportunityEntry: Record "Opportunity Entry" TEMPORARY;
        lOppEntry: Record "Opportunity Entry";
        lRMCommentLine: Record "Rlshp. Mgt. Comment Line";
        wArchiveManagement: Codeunit ArchiveManagement;
        HideValidationDialog: Boolean;
        lCloseOppCode: Record "Close Opportunity Code";
        lDescriptionLine: Record "Description Line";
        tArchiveOK: label 'Document %1 has been archived.';
        Text8001400: label 'Do you want to archive the quote?';
        Text8001401: label 'You must choose the loss reason.';
        Text044: label 'The status of the opportunity has not been changed. The program has aborted deleting the order.';

    begin
        //+REF+OPPORTUNITE
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) AND
           (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") AND
          ((SalesHeader."Bill-to Customer No." <> '') OR (SalesHeader."Bill-to Contact No." <> '')) AND
           //DEVIS   NOT HideValidationDialog AND ("Opportunity No." <> '')
           NOT HideValidationDialog
        THEN
            IF CONFIRM(Text8001400, TRUE) THEN BEGIN
                //#6968
                IF (SalesHeader.fOpportunityActive) THEN BEGIN
                    //#6968//
                    //GL2024    CLEAR(page);
                    IF ACTION::LookupOK = page.RUNMODAL(page::"Close Opportunity Codes", lCloseOppCode) THEN
                        SalesHeader."Close Opportunity Code" := lCloseOppCode.Code
                    ELSE
                        ERROR(Text8001401);

                    IF SalesHeader."Opportunity No." <> '' THEN BEGIN
                        Opp.RESET;
                        Opp.SETRANGE("No.", SalesHeader."Opportunity No.");
                        IF Opp.FIND('-') THEN BEGIN
                            TempOpportunityEntry.INIT;
                            TempOpportunityEntry.DELETEALL;
                            TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                            TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                            TempOpportunityEntry."Contact No." := Opp."Contact No.";
                            TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                            TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                            TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                            TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Lost;
                            TempOpportunityEntry."Close Opportunity Code" := lCloseOppCode.Code;
                            TempOpportunityEntry."Date Closed" := SalesHeader."Order Date";
                            lOppEntry := TempOpportunityEntry;
                            lOppEntry.InsertEntry(lOppEntry, FALSE, FALSE);
                            lOppEntry.UpdateEstimates;
                            lOppEntry.MODIFY;
                            //#7631
                            /*DELETE
                                       Opp.Closed := TRUE;
                                         Opp.MODIFY;
                                         DELETE*/
                            //#7631//
                        END ELSE
                            ERROR(Text044);
                    END;
                    //#6968
                END;
                //#6968//
                wArchiveManagement.StoreSalesDocument(SalesHeader, FALSE);
                MESSAGE(tArchiveOK, SalesHeader."No.");
            END ELSE BEGIN
                IF SalesHeader."Opportunity No." <> '' THEN
                    IF Opp.GET(SalesHeader."Opportunity No.") THEN BEGIN
                        lRMCommentLine.SETRANGE("Table Name", lRMCommentLine."Table Name"::Opportunity);
                        lRMCommentLine.SETRANGE("No.", SalesHeader."No.");
                        lRMCommentLine.DELETEALL;

                        lOppEntry.SETCURRENTKEY("Opportunity No.");
                        lOppEntry.SETRANGE("Opportunity No.", SalesHeader."No.");
                        lOppEntry.DELETEALL;

                        Opp.DELETE;
                    END;
            END;
        //#3853





        //#3853//
        //+REF+OPPORTUNITY//

        //DEVIS
        //PERF  lDescriptionLine.SETRANGE("Table ID",DATABASE::"Sales Header");
        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Header", DATABASE::"Sales Line");
        lDescriptionLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lDescriptionLine.SETRANGE("Document No.", SalesHeader."No.");
        //PERF  lDescriptionLine.SETRANGE("Document Line No.",0);
        lDescriptionLine.DELETEALL;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteSalesLines', '', true, true)]

    local procedure OnAfterDeleteSalesLines(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    begin
        //PERF
        SalesLine.SETRANGE("Structure Line No.", 0);
        SalesLine.SETRANGE("Line Type", SalesLine."Line Type"::Totaling);
        //GL2024 Procedure local SalesHeader.DeleteSalesLines;
        SalesLine.SETRANGE("Line Type");
        //PERF//


    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCopySellToCustomerAddressFieldsFromCustomerOnAfterAssignSellToCustomerAddress', '', true, true)]
    procedure OnCopySellToCustomerAddressFieldsFromCustomerOnAfterAssignSellToCustomerAddress(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    var
        lRecordref: RecordRef;
        lJob: Record Job;
        "//HJ SORO": Integer;
        RecLCustomerPostingGroup1: Record "Customer Posting Group";
        Cust: Record Customer;
        reccu: Record Currency;

    begin
        //NAVISION
        SalesHeader."Salesperson Code" := Cust."Salesperson Code";
        IF (SalesHeader."Job No." <> '') THEN BEGIN
            IF lJob.GET(SalesHeader."Job No.") THEN
                IF lJob."Salesperson Code" <> '' THEN
                    SalesHeader."Salesperson Code" := lJob."Salesperson Code";
        END;
        //NAVISION//

        //#4337
        IF Cust."Primary Contact No." <> '' THEN
            SalesHeader.VALIDATE("Ship-to Contact No.", Cust."Primary Contact No.");
        //#4337//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter', '', true, true)]
    local procedure OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter(var SalesHeader: Record "Sales Header"; var SellToCustomer: Record Customer; var IsHandled: Boolean)
    begin
        //GL2024 champs Urgence id 5750 nav2009 remplace par "Responsibility Center" bc24 
        //SalesHeader.Urgence := SellToCustomer."Shipping Advice";
        //   SalesHeader."Shipping Advice" := SellToCustomer."Shipping Advice";

        //AGENCE
        IF SalesHeader."Responsibility Center" <> '' THEN
            IsHandled := true;
        //AGENCE//


    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckCreditLimitCondition', '', true, true)]
    local procedure OnAfterCheckCreditLimitCondition(var SalesHeader: Record "Sales Header"; var RunCheck: Boolean)
    begin
        RunCheck := ((SalesHeader."Document Type".AsInteger() <= SalesHeader."Document Type"::Invoice.AsInteger()) or (SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order")) and (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order");

    end;





    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', true, true)]
    local procedure OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer; xSalesHeader: Record "Sales Header"; SkipBillToContact: Boolean; CUrrentFieldNo: Integer)
    var

        lSalesLine: Record "Sales Line";

        Cust: Record Customer;

        RecUserSetup: Record "User Setup";
    begin
        //#4324
        //"Currency Code" := Cust."Currency Code";
        SalesHeader.VALIDATE("Currency Code", Cust."Currency Code");
        //#4324//
        //MH SORO 28-08-2020

        // IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
        // IF (RecUserSetup."Prix CMDV TTC" = FALSE) AND (SalesHeader."Document Type" = 1) THEN
        //  SalesHeader."Prices Including VAT" := Cust."Prices Including VAT";
        SalesHeader."Prices Including VAT" := Cust."Prices Including VAT";

        //MH SORO 28-08-2020
        //DEVIS
        lSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF lSalesLine.FIND('-') THEN
            REPEAT
                lSalesLine."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                lSalesLine."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                //#6561
                IF (lSalesLine.Type <> lSalesLine.Type::" ") THEN
                    lSalesLine.VALIDATE("VAT Bus. Posting Group");
                //#6561//
                lSalesLine.MODIFY;
            UNTIL lSalesLine.NEXT = 0;
        lSalesLine.INIT;
        //DEVIS//
    end;









    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitDefaultDimensionSources', '', true, true)]
    local procedure OnAfterInitDefaultDimensionSources(var SalesHeader: Record "Sales Header"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    var
        DimMgt: Codeunit DimensionManagement;
    begin


        DimMgt.AddDimSource(DefaultDimSource, Database::Job, SalesHeader."Job No.", FieldNo = SalesHeader.FieldNo("Bill-to Customer No."));

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateBillToCustomerNoOnBeforeRecallModifyAddressNotification', '', true, true)]
    local procedure OnValidateBillToCustomerNoOnBeforeRecallModifyAddressNotification(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header")
    var


        lSalesLine: Record "Sales Line";
    begin
        //DEVIS
        lSalesLine.INIT;
        lSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        //PERF
        IF NOT lSalesLine.ISEMPTY THEN
            //PERF//
            IF lSalesLine.FIND('-') THEN
                REPEAT
                    lSalesLine."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                    lSalesLine.MODIFY;
                UNTIL lSalesLine.NEXT = 0;
    END;
    //DEVIS//



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateDirectDebitPmtTermsCode', '', true, true)]

    local procedure OnBeforeUpdateDirectDebitPmtTermsCode(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var PaymentMethod: Record "Payment Method")
    begin
        IF SalesHeader."Payment Method Code" <> '' THEN BEGIN
            PaymentMethod.GET(SalesHeader."Payment Method Code");
            //#8771
            SalesHeader."Reason Code" := PaymentMethod."Reason Code"
            //#8771//
        END;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitPostingNoSeries', '', true, true)]

    local procedure OnAfterInitPostingNoSeries36(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        NoSeriesMgt2: Codeunit NoSeriesManagement;
        PostingNoSeries: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";

    begin

        SalesSetup.Get();
        PostingNoSeries := SalesSetup."Posted Invoice Nos.";
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Subscription:
                begin
                    NoSeriesMgt2.SetDefaultSeries(SalesHeader."Posting No. Series", PostingNoSeries);
                    NoSeriesMgt2.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeTestNoSeries', '', true, true)]

    local procedure OnBeforeTestNoSeries(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        GlobalNoSeries: Record "No. Series";
        wNavibatSetup: Record 8003900;
        lSubscrSetup: Record 8001900;
    begin
        SalesSetup.Get();

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote:
                SalesSetup.TestField("Quote Nos.");
            SalesHeader."Document Type"::Order:
                //COMMANDE_INT
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN BEGIN
                    wNaviBatSetup.GET;
                    wNaviBatSetup.TESTFIELD("Supply Order Nos.");
                END ELSE
                    //COMMANDE_INT//
                    //CESSION
                    IF SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer THEN BEGIN
                        wNaviBatSetup.GET;
                        wNaviBatSetup.TESTFIELD("Transfer Order Nos.");
                    END ELSE
                        //CESSION//
                        SalesSetup.TestField("Order Nos.");
            SalesHeader."Document Type"::Invoice:
                SalesSetup.TestField("Invoice Nos.");
            SalesHeader."Document Type"::"Return Order":
                SalesSetup.TestField("Return Order Nos.");
            SalesHeader."Document Type"::"Credit Memo":
                SalesSetup.TestField("Credit Memo Nos.");
            SalesHeader."Document Type"::"Blanket Order":
                SalesSetup.TestField("Blanket Order Nos.");
            //+ABO+
            SalesHeader."Document Type"::Subscription:
                BEGIN
                    lSubscrSetup.GET;
                    lSubscrSetup.TESTFIELD("Sales Contract Nos.");
                END;
        //+ABO+//
        end;
        GLSetup.GetRecordOnce();
        if not GLSetup."Journal Templ. Name Mandatory" then
            case SalesHeader."Document Type" of
                SalesHeader."Document Type"::Invoice:
                    SalesSetup.TestField("Posted Invoice Nos.");
                SalesHeader."Document Type"::"Credit Memo":
                    SalesSetup.TestField("Posted Credit Memo Nos.");
            end
        else begin
            SalesSetup.GetRecordOnce();
            if not SalesHeader.IsCreditDocType() then begin
                SalesSetup.TestField("S. Invoice Template Name");
                if SalesHeader."Journal Templ. Name" = '' then
                    GenJournalTemplate.Get(SalesSetup."S. Invoice Template Name")
                else
                    GenJournalTemplate.Get(SalesHeader."Journal Templ. Name");
            end else begin
                SalesSetup.TestField("S. Cr. Memo Template Name");
                if SalesHeader."Journal Templ. Name" = '' then
                    GenJournalTemplate.Get(SalesSetup."S. Cr. Memo Template Name")
                else
                    GenJournalTemplate.Get(SalesHeader."Journal Templ. Name");
            end;
            GenJournalTemplate.TestField("Posting No. Series");
            GlobalNoSeries.Get(GenJournalTemplate."Posting No. Series");
            GlobalNoSeries.TestField("Default Nos.", true);
        end;

        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeGetNoSeriesCode', '', true, true)]

    local procedure OnBeforeGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20]; var IsHandled: Boolean)
    var
        NoSeries: Codeunit "No. Series";
        wNavibatSetup: Record 8003900;
        lSubscrSetup: Record 8001900;
        SelectNoSeriesAllowed: Boolean;
    begin

        case SalesHeader."Document Type" of


            //Code NAVIBAT Supprimer
            //+ABO+
            SalesHeader."Document Type"::Subscription:
                BEGIN
                    lSubscrSetup.GET;
                    NoSeriesCode := lSubscrSetup."Sales Contract Nos.";
                END;
        //+ABO+//
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnRecreateSalesLinesHandleSupplementTypesOnAfterCalcShouldCreateSalsesLine', '', true, true)]

    local procedure OnRecreateSalesLinesHandleSupplementTypesOnAfterCalcShouldCreateSalsesLine(var TempSalesLine: Record "Sales Line"; var ShouldCreateSalsesLine: Boolean; var SalesLine: Record "Sales Line")
    begin
        ShouldCreateSalsesLine := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateShipToCodeOnBeforeCopyShipToAddress', '', true, true)]

    local procedure OnValidateShipToCodeOnBeforeCopyShipToAddress(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; var CopyShipToAddress: Boolean)
    var
        Customer, Cust : record customer;
        ShipToAddr: Record "Ship-to Address";
        CurrFieldNo: integer;
        CopyShipToAddressSpec: Boolean;
    begin
        CopyShipToAddressSpec := not ((SalesHeader."Document Type" in [SalesHeader."Document Type"::"Return Order", SalesHeader."Document Type"::"Credit Memo"]) and (SalesHeader."Order Type" = SalesHeader."Order Type"::" "));
        CopyShipToAddress := false;
        if CopyShipToAddressSpec then begin


            if SalesHeader."Ship-to Code" <> '' then begin
                //code spec Added
                //+REF+ALT_ADDRESS
                //#8229
                CurrFieldNo := SalesHeader.FieldNo("Sell-to Contact No.");

                IF CurrFieldNo <> SalesHeader.FIELDNO("Ship-to Code") THEN BEGIN
                    //#8229//
                    ShipToAddr.RESET;
                    ShipToAddr.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
                    IF NOT ShipToAddr.ISEMPTY THEN BEGIN
                        COMMIT;  //OBLIGATOIRE POUR EVITER UN GROS MESSAGE D'ERREUR
                        IF Page.RUNMODAL(0, ShipToAddr) = ACTION::LookupOK THEN
                            SalesHeader."Ship-to Code" := ShipToAddr.Code;
                    END;
                    //#8253
                END;
                //#8253//
                //+REF+ALT_ADDRESS//

                //code spec Added
                if xSalesHeader."Ship-to Code" <> '' then begin
                    customer := SalesHeader.GetCust(SalesHeader."Sell-to Customer No.");
                    if customer."Location Code" <> '' then
                        SalesHeader.Validate("Location Code", customer."Location Code");
                    // SetCustomerLocationCode(Customer);
                    SalesHeader."Tax Area Code" := Customer."Tax Area Code";
                end;
                ShipToAddr.Get(SalesHeader."Sell-to Customer No.", SalesHeader."Ship-to Code");
                SalesHeader.SetShipToCustomerAddressFieldsFromShipToAddr(ShipToAddr);
            end else
                if SalesHeader."Sell-to Customer No." <> '' then begin
                    customer := SalesHeader.GetCust(SalesHeader."Sell-to Customer No.");
                    SalesHeader.CopyShipToCustomerAddressFieldsFromCust(Customer);
                end;
        end else begin

            IF (SalesHeader."Sell-to Customer No." <> '') AND (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") THEN BEGIN
                Cust := SalesHeader.GetCust(SalesHeader."Sell-to Customer No.");
                //#6560
                // IF ("Job No." = '') THEN
                // "Ship-to Name" := Cust.Name;
                //#6560//
                SalesHeader."Ship-to Name 2" := Cust."Name 2";
                SalesHeader."Ship-to Address" := Cust.Address;
                SalesHeader."Ship-to Address 2" := Cust."Address 2";
                SalesHeader."Ship-to City" := Cust.City;
                SalesHeader."Ship-to Post Code" := Cust."Post Code";
                SalesHeader."Ship-to County" := Cust.County;
                SalesHeader."Ship-to Country/Region Code" := Cust."Country/Region Code";
                SalesHeader."Ship-to Contact" := Cust.Contact;
                SalesHeader."Shipment Method Code" := Cust."Shipment Method Code";
                IF Cust."Location Code" <> '' THEN
                    SalesHeader.VALIDATE("Location Code", Cust."Location Code");
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidatePostingDateOnBeforeResetInvoiceDiscountValue', '', true, true)]
    local procedure OnValidatePostingDateOnBeforeResetInvoiceDiscountValue(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        lPrepaymentManagement: Codeunit "Prepayment Management";
    begin
        //#7974
        lPrepaymentManagement.SalesPostingDate(SalesHeader, 2);
        //#7974//
    end;

    /*GL2024    [EventSubscriber(ObjectType::Table, 36, 'OnAfterTestStatusOpen', '', true, true)]
      local procedure OnAfterTestStatusOpen(var SalesHeader: Record "Sales Header")
        var

            wSingleInstance: Codeunit 8001405;
        begin
            wSingleInstance.wSetSalesHeader(SalesHeader);
        end;*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidatePricesIncludingVATOnBeforeSalesLineModify', '', true, true)]
    local procedure OnValidatePricesIncludingVATOnBeforeSalesLineModify(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; Currency: Record Currency; RecalculatePrice: Boolean)
    begin
        //+NAV+TVA
        //      IF SalesLine."Line Type" = SalesLine."Line Type"::Structure THEN
        SalesLine.VALIDATE("Unit Price");
        //+NAV+TVA//
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitFromBillToCustTemplate', '', true, true)]
    local procedure OnAfterInitFromBillToCustTemplate(var SalesHeader: Record "Sales Header"; BillToCustTemplate: Record "Customer Templ.")
    var
        lCustPostingGp: Record "Customer Posting Group";
    begin
        //PROJET_FACT
        IF SalesHeader."Order Type" = SalesHeader."Order Type"::" " THEN BEGIN
            lCustPostingGp.GET(SalesHeader."Customer Posting Group");
            SalesHeader.VALIDATE("Contract Type", lCustPostingGp."Contract Type");
        END;
        //PROJET_FACT//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignShipmentDate', '', true, true)]
    local procedure OnInitRecordOnBeforeAssignShipmentDate(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Quote] then begin
            //DEVIS
            IF SalesHeader."Order Type" <> SalesHeader."Order Type"::" " THEN
                SalesHeader."Shipment Date" := WorkDate();
            //DEVIS//
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitPostingDescription', '', true, true)]
    local procedure OnBeforeInitPostingDescription(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //POSTING_DESC "Posting Description" := FORMAT("Document Type") + ' ' + "No.";
        //#6367
        //GL2024 SalesHeader."Posting Description" := SalesHeader.wShowPostingDescription(SalesHeader.wPostingDescription);
        //GL2024 
        SalesHeader."Posting Description" := Format(SalesHeader."Document Type") + ' ' + Format(SalesHeader."Bill-to Name");
        //GL2024 

        //#6367//
        //POSTING_DESC//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignOrderDate', '', true, true)]
    local procedure OnInitRecordOnBeforeAssignOrderDate(var SalesHeader: Record "Sales Header"; var NewOrderDate: Date)
    begin
        //+ABO+
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Subscription THEN
            SalesHeader."Posting Date" := 0D;
        //+ABO+//
        //#6627
        //GL2024   SalesSetup.GET;
        //#6627//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignResponsibilityCenter', '', true, true)]
    local procedure OnInitRecordOnBeforeAssignResponsibilityCenter(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        UserMgt: Codeunit "User Setup Management";

    begin
        //DEVIS
        IF SalesHeader."Responsibility Center" = '' THEN
            SalesHeader."Responsibility Center" := UserMgt.GetRespCenter(0, SalesHeader."Responsibility Center");
        //DEVIS//
        IsHandled := true;
    end;

    /*GL2024 [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterTestNoSeries', '', true, true)]
     local procedure OnAfterTestNoSeries(var SalesHeader: Record "Sales Header"; var SalesReceivablesSetup: Record "Sales & Receivables Setup")
     var
         //DYS table missing
         //lSubscrSetup: Record 8001900;
         wNaviBatSetup: Record NavibatSetup;
     begin
         case SalesHeader."Document Type" of
             SalesHeader."Document Type"::Quote:
                 SalesReceivablesSetup.TestField("Quote Nos.");
             SalesHeader."Document Type"::Order:

                 //COMMANDE_INT
                 IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN BEGIN
                     wNaviBatSetup.GET;
                     wNaviBatSetup.TESTFIELD("Supply Order Nos.");
                 END ELSE
                     //COMMANDE_INT//
                     //CESSION
                     IF SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer THEN BEGIN
                         wNaviBatSetup.GET;
                         wNaviBatSetup.TESTFIELD("Transfer Order Nos.");
                     END ELSE
                         //CESSION//
                        SalesReceivablesSetup.TestField("Order Nos.");
             //+ABO+


             SalesHeader."Document Type"::Invoice:
                 BEGIN
                     SalesReceivablesSetup.TESTFIELD("Invoice Nos.");
                     SalesReceivablesSetup.TESTFIELD("Posted Invoice Nos.");
                 END;
             SalesHeader."Document Type"::"Return Order":
                 SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
             SalesHeader."Document Type"::"Credit Memo":
                 BEGIN
                     SalesReceivablesSetup.TESTFIELD("Credit Memo Nos.");
                     SalesReceivablesSetup.TESTFIELD("Posted Credit Memo Nos.");
                 END;
             SalesHeader."Document Type"::"Blanket Order":
                 SalesReceivablesSetup.TESTFIELD("Blanket Order Nos.");
             SalesHeader."Document Type"::Subscription:
                 BEGIN
                     //DYS table 8001900 missing
                     //lSubscrSetup.GET;
                     //lSubscrSetup.TESTFIELD("Sales Contract Nos.");
                 END;
         //+ABO+//
         end;

     end;*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', true, true)]
    local procedure OnAfterGetNoSeriesCode36(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    var
        //DYS table missing
        //lSubscrSetup: Record 8001900;
        wNaviBatSetup: Record NavibatSetup;
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote:
                //CESSION
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer THEN
                    // EXIT(wNaviBatSetup."Transfer Quote Nos.")
                    NoSeriesCode := wNaviBatSetup."Transfer Quote Nos."
                ELSE
                    NoSeriesCode := SalesReceivablesSetup."Quote Nos.";

            SalesHeader."Document Type"::Order:
                //COMMANDE_INT
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
                    //  EXIT(wNaviBatSetup."Supply Order Nos.")
                    NoSeriesCode := wNaviBatSetup."Supply Order Nos."
                ELSE
                    //COMMANDE_INT//
                    //CESSION
                    IF SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer THEN
                        //  EXIT(wNaviBatSetup."Transfer Order Nos.")
                        NoSeriesCode := wNaviBatSetup."Transfer Order Nos."
                    ELSE
                        //CESSION//
                        NoSeriesCode := SalesReceivablesSetup."Order Nos.";
            //+ABO+
            SalesHeader."Document Type"::Invoice:
                NoSeriesCode := SalesReceivablesSetup."Invoice Nos.";
            SalesHeader."Document Type"::"Return Order":
                NoSeriesCode := SalesReceivablesSetup."Return Order Nos.";
            SalesHeader."Document Type"::"Credit Memo":
                NoSeriesCode := SalesReceivablesSetup."Credit Memo Nos.";
            SalesHeader."Document Type"::"Blanket Order":
                NoSeriesCode := SalesReceivablesSetup."Blanket Order Nos.";
            SalesHeader."Document Type"::Subscription:
                BEGIN
                    //DYS table 8001900 missing
                    //lSubscrSetup.GET;
                    //EXIT(lSubscrSetup."Sales Contract Nos.");
                    //NoSeriesCode := lSubscrSetup."Sales Contract Nos.";
                END;
        //+ABO+//

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeConfirmDeletion', '', true, true)]
    local procedure OnBeforeConfirmDeletion(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        // SalesHeader."Shipping No." := '';
        //  SalesHeader."Posting No." := '';
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSalesLinesExist', '', true, true)]

    local procedure OnBeforeSalesLinesExist(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var Result: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.ISEMPTY THEN
            EXIT;
        IsHandled := true;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        //#4907
        SalesLine.SETRANGE("Order Type", SalesHeader."Order Type");
        //#4907//
        Result := SalesLine.FINDFIRST;
        // EXIT(SalesLine.FINDFIRST);
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeRecreateSalesLines', '', true, true)]
    local procedure OnBeforeRecreateSalesLines(var SalesHeader: Record "Sales Header")
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        lRecRef: RecordRef;
        lBOQLoadOK: Boolean;
        lBOQMgt: Codeunit "BOQ Management";
    //DYS Automation non compatible dans cloud
    //lBOQXmlDoc: Automation "{F5078F18-C551-11D3-89B9-0000F81FE221} 6.0:{88D96A05-F192-11D4-A65F-0040963251E5}:'Microsoft XML, v6.0'.DOMDocument60";

    begin
        //PERF
        lSingleInstance.wSetSalesHeader(SalesHeader);
        //PERF//
        //#6115
        lRecRef.GETTABLE(SalesHeader);
        lBOQLoadOK := lBOQMgt.Load(lRecRef.RECORDID);
        //DYS
        // IF lBOQLoadOK THEN
        //   lSingleInstance.GetXmlDoc(lBOQXmlDoc);
        //#6115//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeTestQuantityShippedField', '', true, true)]
    local procedure OnBeforeTestQuantityShippedField(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnRecreateSalesLinesOnBeforeSalesLineDeleteAll', '', true, true)]
    local procedure OnRecreateSalesLinesOnBeforeSalesLineDeleteAll(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)

    var

        lJobCostAssign: Record "Job Cost Assignment";
        lDescription: Record "Description Line";
        lTempJobCostAssign: Record "Job Cost Assignment";
        lTempDescription: Record "Description Line";
        lOverheadCalculation: Codeunit "Overhead Calculation";
        lOverhead: Record "Sales Overhead-Margin";
        lSalesOverheadDefault: Record "Sales Overhead-Margin";
    begin
        //JOB-COST
        lJobCostAssign.SETRANGE("Document Type", SalesHeader."Document Type");
        lJobCostAssign.SETRANGE("Document No.", SalesHeader."No.");
        IF NOT lJobCostAssign.ISEMPTY THEN BEGIN
            lJobCostAssign.FIND('-');
            REPEAT
                lTempJobCostAssign.INIT;
                lTempJobCostAssign := lJobCostAssign;
                lTempJobCostAssign.INSERT;
            UNTIL lJobCostAssign.NEXT = 0;
            lJobCostAssign.DELETEALL;
        END;
        //JOB-COST//

        //BILLOFQTY//

        //DESCRIPTION
        lDescription.SETRANGE("Table ID", DATABASE::"Sales Header", DATABASE::"Sales Line");
        lDescription.SETRANGE("Document Type", SalesHeader."Document Type");
        lDescription.SETRANGE("Document No.", SalesHeader."No.");
        IF NOT lDescription.ISEMPTY THEN BEGIN
            lDescription.FIND('-');
            REPEAT
                lTempDescription.INIT;
                lTempDescription := lDescription;
                lTempDescription.INSERT;
            UNTIL lDescription.NEXT = 0;
            lDescription.DELETEALL;
        END;
        //DESCRIPTION//

        //DEVIS
        //      SalesLine.DELETEALL(TRUE);
        SalesLine.wDeleteAllSalesLine(SalesHeader."Document Type", SalesHeader."No.");
        //DEVIS
        //OVERHEAD
        lOverhead.SETRANGE("Document Type", SalesHeader."Document Type");
        lOverhead.SETRANGE("Document No.", SalesHeader."No.");
        IF lOverhead.FIND('-') THEN
            REPEAT
                lSalesOverheadDefault := lOverhead;
                lOverheadCalculation.Default(SalesHeader, 0, lOverhead."Gen. Prod. Post. Code", lSalesOverheadDefault);
                lOverheadCalculation.Default(SalesHeader, 1, lOverhead."Gen. Prod. Post. Code", lSalesOverheadDefault);
                lSalesOverheadDefault.MODIFY;
            UNTIL lOverhead.NEXT = 0;
        //OVERHEAD//

        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnAfterAssignType', '', true, true)]
    local procedure OnCreateSalesLineOnAfterAssignType(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //DEVIS
        //IF SalesLineTmp."Attached to Line No." = 0 THEN BEGIN
        SalesLine.INIT;
        //SalesLine."Line No." := SalesLine."Line No." + 10000;
        //SalesLine.VALIDATE(Type,SalesLineTmp.Type);
        SalesLine."Line No." := TempSalesLine."Line No.";
        SalesLine."Attached to Line No." := TempSalesLine."Attached to Line No.";
        SalesLine.Level := TempSalesLine.Level;
        SalesLine."Presentation Code" := TempSalesLine."Presentation Code";
        //#5237        SalesLine.VALIDATE("Line Type",SalesLineTmp."Line Type");
        SalesLine."Line Type" := TempSalesLine."Line Type";
        SalesLine.Type := TempSalesLine.Type;
        //#5237//
        SalesLine."Structure Line No." := TempSalesLine."Structure Line No.";
        SalesLine."Job Task No." := TempSalesLine."Job Task No.";
        SalesLine."Quote No." := TempSalesLine."Quote No.";
        //DEVIS//
        if TempSalesLine."No." = '' then begin
            //JOB-COST//
            //DEVIS
            SalesLine."Sell-to Customer No." := TempSalesLine."Sell-to Customer No.";
            SalesLine."Bill-to Customer No." := TempSalesLine."Bill-to Customer No.";
            //DEVIS//
            //#6443
            SalesLine."Job No." := TempSalesLine."Job No.";
            //#6443//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeAssignType', '', true, true)]
    local procedure OnCreateSalesLineOnBeforeAssignType(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header")
    begin
        if TempSalesLine."No." = '' then begin
            //JOB-COST
            SalesLine."Assignment Basis" := TempSalesLine."Assignment Basis";
            //JOB-COST//
            //DEVIS
            SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            SalesLine."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
            //DEVIS//
            //#6443
            SalesLine."Job No." := TempSalesLine."Job No.";
            //#6443//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnAfterValidateNo', '', true, true)]
    local procedure OnCreateSalesLineOnAfterValidateNo(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary)
    begin
        //#7538
        SalesLine."Found Price" := 0;
        //#7538//
        //#5607
        SalesLine.Description := TempSalesLine.Description;
        SalesLine."Description 2" := TempSalesLine."Description 2";
        //#5607//
        //JOB-COST
        SalesLine."Quote No." := TempSalesLine."Quote No.";
        SalesLine."Assignment Basis" := TempSalesLine."Assignment Basis";
        SalesLine."Assignment Method" := TempSalesLine."Assignment Method";
        SalesLine."Job Cost Assignment" := TempSalesLine."Job Cost Assignment";
        //JOB-COST//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeTransferFieldsFromTempSalesLine', '', true, true)]
    local procedure OnCreateSalesLineOnBeforeTransferFieldsFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header")
    var

        lPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        SalesLine.Option := TempSalesLine.Option;
        SalesLine.Quantity := TempSalesLine.Quantity;
        SalesLine."Quantity (Base)" := TempSalesLine."Quantity (Base)";
        SalesLine."Value 1" := TempSalesLine."Value 1";
        SalesLine."Value 2" := TempSalesLine."Value 2";
        SalesLine."Value 3" := TempSalesLine."Value 3";
        SalesLine."Value 4" := TempSalesLine."Value 4";
        SalesLine."Value 5" := TempSalesLine."Value 5";
        SalesLine."Value 6" := TempSalesLine."Value 6";
        SalesLine."Value 7" := TempSalesLine."Value 7";
        SalesLine."Value 8" := TempSalesLine."Value 8";
        SalesLine."Value 9" := TempSalesLine."Value 9";
        SalesLine."Value 10" := TempSalesLine."Value 10";
        //#7831
        //              SalesLine."Unit Cost (LCY)" := TempSalesLine."Unit Cost (LCY)";
        //#7831//
        //#7538
        IF TempSalesLine."Fixed Price" THEN BEGIN
            //#7538//
            SalesLine."Unit Price" := TempSalesLine."Unit Price";
            SalesLine."Fixed Price" := TempSalesLine."Fixed Price";
            //#7538
        END ELSE BEGIN
            CASE SalesLine.Type OF
                SalesLine.Type::Item, SalesLine.Type::Resource:
                    BEGIN
                        CLEAR(lPriceCalcMgt);
                        lPriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
                        lPriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, 0);
                    END;
            END;
        END;
        //#7538//
        //#7831
        //              SalesLine.VALIDATE("Unit of Measure Code",TempSalesLine."Unit of Measure Code");
        //#7831

        IF TempSalesLine."Variant Code" <> '' THEN
            SalesLine.VALIDATE("Variant Code", TempSalesLine."Variant Code");
        //IF TempSalesLine.Quantity <> 0 THEN
        //  SalesLine.VALIDATE(Quantity,TempSalesLine.Quantity);
        IF SalesLine."Line Type" IN [SalesLine."Line Type"::Machine, SalesLine."Line Type"::Person] THEN BEGIN
            SalesLine."Number of Resources" := TempSalesLine."Number of Resources";
            SalesLine."Rate Quantity" := TempSalesLine."Rate Quantity";
        END;
        SalesLine."Quantity Fixed" := TempSalesLine."Quantity Fixed";
        SalesLine."Quantity per" := TempSalesLine."Quantity per";
        SalesLine."Optionnal Quantity" := TempSalesLine."Optionnal Quantity";
        SalesLine.Disable := TempSalesLine.Disable;
        SalesLine."Disable Quantity" := TempSalesLine."Disable Quantity";

        SalesLine.Subcontracting := TempSalesLine.Subcontracting;
        SalesLine."Vendor No." := TempSalesLine."Vendor No.";

        //#7831
        //#7831
        IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
            //#7831
            SalesLine.VALIDATE("Unit of Measure Code", TempSalesLine."Unit of Measure Code");
        IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
            SalesLine.VALIDATE("Unit Cost (LCY)", TempSalesLine."Unit Cost (LCY)");
        SalesLine."Unit Cost (LCY)" := TempSalesLine."Unit Cost (LCY)";
        //#7831//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeValidateQuantity', '', true, true)]
    local procedure OnCreateSalesLineOnBeforeValidateQuantity(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; var ShouldValidateQuantity: Boolean)
    begin
        IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
            //#7831
            SalesLine.VALIDATE("Unit of Measure Code", TempSalesLine."Unit of Measure Code");
        IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
            SalesLine.VALIDATE("Unit Cost (LCY)", TempSalesLine."Unit Cost (LCY)");
        //#7831//
        SalesLine."Unit Cost (LCY)" := TempSalesLine."Unit Cost (LCY)";
        //#7831//


    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCreateSalesLineOnBeforeValidateShipmentDate', '', true, true)]
    local procedure OnCreateSalesLineOnBeforeValidateShipmentDate(var SalesLine: Record "Sales Line"; TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IF (SalesLine."Structure Line No." = 0) AND (SalesLine."Line Type" <> SalesLine."Line Type"::Structure) THEN BEGIN
            IF NOT SalesLine.Option THEN
                SalesLine.VALIDATE(Quantity)
            ELSE BEGIN
                SalesLine.VALIDATE(Quantity, SalesLine."Optionnal Quantity");
                SalesLine.VALIDATE(Option, TRUE);
            END;
        END;
    end;



    local procedure OnBeforeSetBillToCustomerNo(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean; xSalesHeader: Record "Sales Header"; var CurrentFieldNo: Integer)
    begin
        IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
            SalesHeader.VALIDATE("Ship-to Code")
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnRecreateSalesLinesOnAfterProcessTempSalesLines', '', true, true)]
    local procedure OnRecreateSalesLinesOnAfterProcessTempSalesLines(var TempSalesLine: Record "Sales Line" temporary; var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldName: Text[100])
    var

        lBOQLoadOK: Boolean;

        lSingleInstance: Codeunit "Import SingleInstance2";

        lBOQMgt: Codeunit "BOQ Management";

        lTempJobCostAssign: Record "Job Cost Assignment";

        lJobCostAssign: Record "Job Cost Assignment";
        //DYS Automation non compatible dans cloud

        //lBOQXmlDoc: Automation  'Microsoft XML, v6.0'.DOMDocument60;

        lDescription: Record "Description Line";

        lTempDescription: Record "description Line";

        lRecRef: RecordRef;


    begin
        lBOQLoadOK := lBOQMgt.Load(lRecRef.RECORDID);
        //#6115l

        IF lBOQLoadOK THEN BEGIN
            //DYS
            // lSingleInstance.SetXmlDoc(lBOQXmlDoc);
            lBOQMgt.Save('');
        END;
        //#6115//


        //JOB-COST
        IF NOT lTempJobCostAssign.ISEMPTY THEN BEGIN
            lTempJobCostAssign.FIND('-');
            REPEAT
                lJobCostAssign.INIT;
                lJobCostAssign := lTempJobCostAssign;
                lJobCostAssign.INSERT;
            UNTIL lTempJobCostAssign.NEXT = 0;
            lTempJobCostAssign.DELETEALL;
        END;
        //JOB-COST//


        //DESCRIPTION
        IF NOT lTempDescription.ISEMPTY THEN BEGIN
            lTempDescription.FIND('-');
            REPEAT
                lDescription.INIT;
                lDescription := lTempDescription;
                lDescription.INSERT;
            UNTIL lTempDescription.NEXT = 0;
            lTempDescription.DELETEALL;
        END;
        //DESCRIPTION//

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRecreateSalesLines', '', true, true)]
    local procedure OnAfterRecreateSalesLines(var SalesHeader: Record "Sales Header"; ChangedFieldName: Text[100])

    var
        SalesLine: Record "Sales Line";

        lSalesLineMgt: Codeunit "SalesLine Management";

        lStructureMgt: Codeunit "Structure Management";


        DialogBox: Dialog;

        lSingleInstance: Codeunit "Import SingleInstance2";

        tRiderToOrder: label 'You can''t link an order to a rider';

        tTitreProgress: label 'Documents Updating\';
        tTypeProgress: label 'Update                 #1##############\';
        tCalcProgress: label 'Work in progress...    @2@@@@@@@@@@@@@@\';
        tDocInfo: label '%1 No. %2';





    begin
        //DEVIS
        /* GL2024 
       // Field 'Cross-Reference No.' is removed.
         SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line Type",
                                   "Cross-Reference No.", "Cross-Ref. Line No.", "Structure Line No.", Option);*/
        //GL2024
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line Type",
                                          "Cross-Ref. Line No.", "Structure Line No.", Option);
        //GL2024 FIN
        SalesLine.SETRANGE("Attached to Line No.");
        SalesLine.SETRANGE("Structure Line No.", 0);
        SalesLine.SETRANGE("Line Type", SalesLine."Line Type"::Structure);
        IF SalesLine.FIND('-') THEN
            REPEAT
                IF NOT SalesLine.Option THEN BEGIN
                    IF (SalesLine.Subcontracting = SalesLine.Subcontracting::" ") THEN
                        lStructureMgt.SumStructureLines(SalesLine)
                    ELSE
                        SalesLine.VALIDATE(Quantity);
                END ELSE BEGIN
                    SalesLine.VALIDATE(Quantity, SalesLine."Optionnal Quantity");
                    SalesLine.VALIDATE(Option, TRUE);
                END;
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        //DEVIS//

        //DEVIS
        lSingleInstance.wGetSalesHeader(SalesHeader, SalesHeader."Document Type", SalesHeader."No.");
        /*
        lSalesHeader.SETRANGE("Document Type", Rec."Document Type");
          lSalesHeader.SETRANGE("No.", Rec."No.");
          REPORT.RUNMODAL(REPORT::"Restore doc. Totaling", FALSE, FALSE, lSalesHeader);
        */
        DialogBox.OPEN(tTitreProgress + tTypeProgress + tCalcProgress);
        DialogBox.UPDATE(1, STRSUBSTNO(tDocInfo, SalesHeader."Document Type", SalesHeader."No."));
        lSalesLineMgt.ReFreshTotalLine(SalesHeader, DialogBox);
        DialogBox.CLOSE;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeUpdateSalesLinesByFieldNo', '', true, true)]
    local procedure OnBeforeUpdateSalesLinesByFieldNo(var SalesHeader: Record "Sales Header"; ChangedFieldNo: Integer; var AskQuestion: Boolean; var IsHandled: Boolean; xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer)
    begin
        //PROJET_FACT
        AskQuestion := (AskQuestion OR ((SalesHeader."No. Prepayment Invoiced" <> 0) AND (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo"))) AND SalesHeader.wNotOnlyOtherLine;
        //PROJET_FACT//
        IF NOT SalesHeader.wNotOnlyOtherLine THEN
            AskQuestion := FALSE;
        //#4331//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSalesLinesByFieldNoOnAfterSalesLineSetFilters', '', true, true)]
    local procedure OnUpdateSalesLinesByFieldNoOnAfterSalesLineSetFilters(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldNo: Integer)
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
        lCurrency: Record Currency;
    begin
        lSingleInstance.wSetSalesHeader(SalesHeader);
        lSingleInstance.wSetCurrency(lCurrency, SalesHeader);
        //#5753//
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSalesLineByChangedFieldNo', '', true, true)]
    local procedure OnBeforeSalesLineByChangedFieldNo(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldNo: Integer; var IsHandled: Boolean; xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer)
    var
        lPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        lStructureMgt: Codeunit "Structure Management";
        lOverHeadCalc: Codeunit "Overhead Calculation";
        JobTransferLine: Codeunit "Job Transfer Line2";
        JobPostLine: Codeunit "Job Post-Line2";
    begin
        case ChangedFieldNo of
            SalesHeader.FieldNo(SalesHeader."Shipment Date"):
                if SalesLine."No." <> '' then
                    //#9171
                    IF (SalesLine."Line Type" = SalesLine."Line Type"::Item) OR
                  (SalesLine."Line Type" = SalesLine."Line Type"::Structure) THEN
                        //#9171//
                        SalesLine.Validate("Shipment Date", SalesHeader."Shipment Date");
            SalesHeader.FieldNo("Currency Factor"):
                if SalesLine.Type <> SalesLine.Type::" " then begin
                    //#5753
                    IF (SalesLine."Structure Line No." = 0) AND (SalesLine."Line Type" = SalesLine."Line Type"::Structure) THEN BEGIN
                        lPriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
                        lPriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, SalesLine.FIELDNO(Quantity));
                        lStructureMgt.SumStructureLines(SalesLine);
                    END ELSE
                        lOverHeadCalc.SalesLine(SalesLine, TRUE, TRUE);
                    //#5753//
                    SalesLine.Validate("Unit Price");
                    SalesLine.Validate("Unit Cost (LCY)");
                    if SalesLine."Job No." <> '' then
                        //GL2024    JobTransferLine.FromSalesHeaderToPlanningLine(SalesLine,SalesHeader."Currency Factor");
                        JobTransferLine.FromSalesHeaderToPlanningLine(SalesLine, SalesHeader."Currency Code", SalesHeader."Currency Factor");
                end;
            SalesHeader.FieldNo("Transaction Type"):
                SalesLine.Validate("Transaction Type", SalesHeader."Transaction Type");
            SalesHeader.FieldNo("Transport Method"):
                SalesLine.Validate("Transport Method", SalesHeader."Transport Method");
            SalesHeader.FieldNo("Exit Point"):
                SalesLine.Validate("Exit Point", SalesHeader."Exit Point");
            SalesHeader.FieldNo(Area):
                SalesLine.Validate(Area, SalesHeader.Area);
            SalesHeader.FieldNo("Transaction Specification"):
                SalesLine.Validate("Transaction Specification", SalesHeader."Transaction Specification");
            SalesHeader.FieldNo("Shipping Agent Code"):
                SalesLine.Validate("Shipping Agent Code", SalesHeader."Shipping Agent Code");
            SalesHeader.FieldNo("Shipping Agent Service Code"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Shipping Agent Service Code", SalesHeader."Shipping Agent Service Code");
            SalesHeader.FieldNo("Shipping Time"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Shipping Time", SalesHeader."Shipping Time");
            SalesHeader.FieldNo("Prepayment %"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Prepayment %", SalesHeader."Prepayment %");
            SalesHeader.FieldNo("Requested Delivery Date"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Requested Delivery Date", SalesHeader."Requested Delivery Date");
            SalesHeader.FieldNo("Promised Delivery Date"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Promised Delivery Date", SalesHeader."Promised Delivery Date");
            SalesHeader.FieldNo("Outbound Whse. Handling Time"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Outbound Whse. Handling Time", SalesHeader."Outbound Whse. Handling Time");
            SalesLine.FieldNo("Deferral Code"):
                if SalesLine."No." <> '' then
                    SalesLine.Validate("Deferral Code");
            SalesHeader.FieldNo("Campaign No."):
                if SalesLine."No." <> '' then begin
                    if SalesLine."Job No." <> '' then
                        JobPostLine.TestSalesLine(SalesLine);
                    SalesLine.UpdateUnitPrice(0);
                end;

            //PROJET
            SalesHeader.FieldNo("Job No."):
                BEGIN
                    SalesLine.VALIDATE("Job No.", SalesHeader."Job No.");
                    //PROJET_FACT
                    SalesHeader.wUpdateSchedulerLines(SalesHeader.FIELDCAPTION("Job No."), FALSE);
                END;
        //PROJET_FACT//
        //PROJET//

        end;

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCreateDim', '', true, true)]
    local procedure OnBeforeCreateDim(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        //NAVISION
        //DYS Table Document Dimension supprimer

        // DimMgt.GetPreviousDocDefaultDim(
        //   DATABASE::"Sales Header", SalesHeader."Document Type", SalesHeader."No.", 0,
        //   DATABASE::Customer, SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code");
        //NAVISION//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnDeleteSalesLinesOnBeforeDeleteLine', '', true, true)]
    local procedure OnDeleteSalesLinesOnBeforeDeleteLine(var SalesLine: Record "Sales Line")
    begin
        //DEVIS
        SalesLine.wDeleteSalesHeader(TRUE);
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnUpdateSellToCustOnAfterSetShipToAddress', '', true, true)]
    local procedure OnUpdateSellToCustOnAfterSetShipToAddress(var SalesHeader: Record "Sales Header"; var SearchContact: Record Contact)

    var
        Cont: Record Contact;
    // Cont : Record 5050;
    begin
        //DEVIS    ContComp.GET(Cont."Company No.");
        Cont.GET(SearchContact."No.");
        SalesHeader."Ship-to Contact" := SearchContact.Name;
        SalesHeader."Ship-to Contact No." := SearchContact."No.";
        //DEVIS//


        IF (SalesHeader."Job No." = '') THEN
            SalesHeader."Ship-to Name" := SearchContact."Company Name";
        //#6560////
    end;





    //*************************************Table 37************************************************//


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnInsertOnAfterCheckInventoryConflict', '', true, true)]
    local procedure OnInsertOnAfterCheckInventoryConflict(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var SalesLine2: Record "Sales Line")
    var
        DocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        //DEVIS//
        //PERF-LOCK
        /*GL2024 DocDim.SETRANGE("Table ID", 37);
         DocDim.SETRANGE("Document Type", SalesLine."Document Type");
         DocDim.SETRANGE("Document No.", SalesLine."Document No.");*/
        //PERF-LOCK//.
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeVerifyChangeForSalesLineReserve', '', true, true)]
    local procedure OnBeforeVerifyChangeForSalesLineReserve(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF (CallingFieldNo = SalesLine.FIELDNO("Location Code")) or (CallingFieldNo = SalesLine.FIELDNO("Drop Shipment")) then
            //DEVIS
            IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
                //DEVIS//
                IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckReservedQtyBase', '', true, true)]

    local procedure OnBeforeCheckReservedQtyBase(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            //DEVIS//
            IsHandled := true;
        //#5029
        SalesLine.wUndoTrackingTransfer(SalesLine);
        //#5029//

    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckNotInvoicedQty', '', true, true)]
    local procedure OnBeforeCheckNotInvoicedQty(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesWarehouseMgt: Codeunit "Sales Warehouse Mgt.";

        Text000: label 'You cannot delete the order line because it is associated with purchase order %1 line %2.';

        Text8003927: label 'You cannot delete the line %1 because it is associated with purchase %2 .';


    begin

        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            //DEVIS//
            IsHandled := true;


        //#6630 R20 Appro
        IF (SalesLine."Document Type" = SalesLine."Document Type"::Order) AND
            (SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order") AND
            (SalesLine."Quantity Shipped" <> 0) THEN
            ERROR(Text8003927, SalesLine."Line No.", SalesLine."Purchasing Document Type", SalesLine."Purchasing Order No.");
        //#6630 R20 Appro//
        //SUBCONTRACTOR
        IF (SalesLine."Purchasing Order Line No." <> 0) THEN
            ERROR(Text8003927, SalesLine."Line No.", SalesLine."Purchasing Document Type", SalesLine."Purchasing Order No.")
        ELSE
            //SUBCONTRACTOR//
            IF (SalesLine."Purch. Order Line No." <> 0) OR (SalesLine."Special Order Purch. Line No." <> 0) THEN
                ERROR(
                  Text000,
                  //DEVIS
                  //    "Purchase Order No.");
                  SalesLine."Purchase Order No.", SalesLine."Line No.");
        IF SalesLine."Document Type" <> SalesLine."Document Type"::Quote THEN
            //DEVIS//
            SalesWarehouseMgt.SalesLineDelete(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckLinkedBlanketOrderLineOnDelete', '', true, true)]
    local procedure OnBeforeCheckLinkedBlanketOrderLineOnDelete(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        CapableToPromise: Codeunit "Capable to Promise";
        lFatherRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        SalesHeader: Record "Sales Header";
    begin

        //#6115 - AC
        /*    {
            IF "Line Type" <> "Line Type"::" " THEN BEGIN
         lRecRef.GETTABLE(Rec);
         lBOQCustMgt.gOndelete(lRecRef, lOkDelete);
     END;
            }*/
        //#7287
        // We must load the boq Management OBject
        //GL2024
        SalesHeader.Reset();
        SalesHeader.SetRange(SalesHeader."Document Type", SalesLine."Document Type");
        SalesHeader.SetRange(SalesHeader."No.", SalesLine."Document No.");
        IF SalesHeader.FindFirst() THEN begin
            //GL2024 FIN
            lFatherRef.GETTABLE(SalesHeader);
            IF (NOT lBOQMgt.Load(lFatherRef.RECORDID)) THEN BEGIN
                // Here, we must recreate all xml structure of the document
                lBOQCustMgt.gLoadSalesBOQ(SalesHeader);
                lBOQMgt.Load(lFatherRef.RECORDID);
            END;
            //#7287//
            //#6115 - AC//
        end;

    end;

    // GL2024 Modification impossible 
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnDeleteOnAfterSalesLine2DeleteAll', '', true, true)]
    // local procedure OnDeleteOnAfterSalesLine2DeleteAll(var SalesLine: Record "Sales Line"; var SalesLine2: Record "Sales Line")
    // var
    //     lBOQMgt: Codeunit "BOQ Management";
    //     lRecRef: RecordRef;
    //     lFatherRef: RecordRef;
    //     SalesCommentLine: Record "Sales Comment Line";
    //     lT37: Record "Sales Line";
    //     lSalesLine: Record "Sales Line";
    //     DimMgt: Codeunit DimensionManagement;
    //     wPresentationMgt: Codeunit "Presentation Management";
    //     Text8003922: label 'Do you want to delete the detail of the totaling %1 ?';
    //     lOkDelete: Boolean;
    //     wDeleteHeader: Boolean;
    //     StatusCheckSuspended: Boolean;


    //     wConfirmDeleteTot: Boolean;


    // begin
    //     //#4797
    //     SalesLine2.SETCURRENTKEY("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
    //     //#4797//

    //     //DEVIS
    //     //SalesLine2.DELETEALL(TRUE);  //Original code
    //     //PERF  SalesLine2.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code");
    //     lOkDelete := TRUE;
    //     //GL2024
    //     wConfirmDeleteTot := false;
    //     //GL2024 Fin
    //     IF SalesLine.Dummy = '@@' THEN      //pour ne pas poser la question pour les sous-lots appel‚s
    //         wDeleteHeader := TRUE;
    //     IF NOT SalesLine2.ISEMPTY THEN BEGIN
    //         IF (SalesLine."Line Type" = SalesLine."Line Type"::Totaling) AND (NOT wDeleteHeader) THEN BEGIN
    //             lOkDelete := wConfirmDeleteTot;
    //             IF NOT lOkDelete THEN
    //                 lOkDelete := CONFIRM(Text8003922, FALSE, SalesLine."No.", SalesLine.Description);
    //         END;
    //         IF NOT lOkDelete THEN BEGIN
    //             SalesLine2.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code");
    //             IF SalesLine2.FIND('+') THEN
    //                 REPEAT
    //                     IF (SalesLine2."Line Type" = SalesLine2."Line Type"::" ") AND (SalesLine2."No." = '') THEN BEGIN
    //                         SalesLine2.DELETE;
    //                         //#5145
    //                         //DYS Table Document Dimension supprimer
    //                         // DimMgt.DeleteDocDim(DATABASE::"Sales Line", SalesLine."Document Type", SalesLine."Document No.", SalesLine2."Line No.");
    //                         //#5145//
    //                     END ELSE
    //                         IF NOT wDeleteHeader THEN BEGIN
    //                             lSalesLine.COPY(SalesLine2);
    //                             wPresentationMgt.SetRefreshPres(TRUE);
    //                             wPresentationMgt.wLeft(lSalesLine, FALSE);
    //                             lSalesLine.VALIDATE("Presentation Code");
    //                             lSalesLine.MODIFY;

    //                             //#6115
    //                             //#7287
    //                             //lFatherRef.GETTABLE(SalesHeader);
    //                             //lBOQMgt.SetUseSingleInstance(TRUE);
    //                             //IF lBOQMgt.Load(lFatherRef.RECORDID) THEN BEGIN
    //                             //#7287//
    //                             IF lSalesLine."Attached to Line No." <> 0 THEN BEGIN
    //                                 lT37.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Attached to Line No.");
    //                                 lFatherRef.GETTABLE(lT37);
    //                             END;
    //                             lRecRef.GETTABLE(lSalesLine);
    //                             lBOQMgt.AssignFatherNode(lFatherRef.RECORDID, lRecRef.RECORDID);
    //                             //#7287
    //                             //END;
    //                             //#7287//
    //                             //#6115//
    //                             wPresentationMgt.SetRefreshPres(FALSE);
    //                         END;
    //                 UNTIL SalesLine2.NEXT(-1) = 0;
    //             //#6115
    //             //#7287
    //             // Delete the node on the xml document
    //             lRecRef.GETTABLE(SalesLine);
    //             lBOQMgt.DeleteNode(lRecRef.RECORDID, FALSE);
    //             lBOQMgt.Save('');
    //             //#7287//
    //             //#6115//
    //         END ELSE BEGIN
    //             //#7287
    //             // We delete the node on the xml document after to continue the process
    //             lRecRef.GETTABLE(SalesLine);
    //             lBOQMgt.DeleteNode(lRecRef.RECORDID, FALSE);
    //             lBOQMgt.Save('');
    //             //#7287//
    //             //GL2024
    //             StatusCheckSuspended := false;
    //             IF SalesLine."Quote No." = '' THEN
    //                 StatusCheckSuspended := true;
    //             //GL2024 fin
    //             SalesLine2.SuspendStatusCheck(StatusCheckSuspended);
    //             SalesLine2.MODIFYALL(Dummy, '@@');
    //             IF SalesLine2.FIND('-') THEN
    //                 REPEAT
    //                     //#4838
    //                     SalesLine2.wDeleteSalesHeader(TRUE);
    //                     //#4838//
    //                     SalesLine2.DELETE(TRUE);
    //                 UNTIL SalesLine2.NEXT = 0;
    //         END;
    //     END ELSE BEGIN
    //         //#7287
    //         //Now, we can remove the node on the xml document for the other line type
    //         lRecRef.GETTABLE(SalesLine);
    //         IF (lBOQMgt.gNodeExist(lRecRef.RECORDID)) THEN BEGIN
    //             lBOQMgt.DeleteNode(lRecRef.RECORDID, FALSE);
    //             lBOQMgt.Save('');
    //         END;
    //         //#7287//
    //     END;
    //     //DEVIS//
    // end;

    //HS
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateUnitPrice', '', true, true)]

    local procedure OnBeforeValidateUnitPrice(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        Text043: label 'cannot be %1';
        Currency: Record Currency;
    begin
        //facture
        //IF ("Document Type" = "Document Type"::Invoice) AND ("Main Order No."<> '') AND  (xRec."Unit Price" <> Rec."Unit Price") THEN
        //  ERROR(tLineNotModificable);
        //facture//

        //#5397

        IF (CurrentFieldNo = SalesLine.FIELDNO("Unit Price")) AND (SalesLine."Unit Price" = SalesLine.XRec_Unit_Price) THEN
            IsHandled := true;
        //#5397//
        //#4365
        //#5923
        SalesLine.GetSalesHeader;
        //#5923//

        //#4956
        IF SalesLine."Unit-Amount Rounding Precision" <> 0 THEN
            SalesLine."Unit Price" := ROUND(SalesLine."Unit Price", SalesLine."Unit-Amount Rounding Precision")
        ELSE BEGIN
            //#4956
            //IF "Currency Code" <> '' THEN
            //#5923  "Unit Price" := ROUND("Unit Price",Currency."Amount Rounding Precision")
            //#5989
            IF Currency."Sales Unit-Amt Round. Prec." = 0 THEN
                Currency.FIELDERROR("Sales Unit-Amt Round. Prec.",
                  STRSUBSTNO(
                    Text043, Currency."Sales Unit-Amt Round. Prec."));
            //#5989//
            SalesLine."Unit Price" := ROUND(SalesLine."Unit Price", Currency."Sales Unit-Amt Round. Prec.");
        END;
        //#5923//
        //#4365//

        //DEVIS
        IF SalesLine."Unit Price" <> 0 THEN
            //  IF xRec."Assignment Basis" <> xRec."Assignment Basis"::" " THEN
            //    TESTFIELD(SalesLine."Assignment Basis", SalesLine."Assignment Basis"::" ");
            IF (SalesLine."Unit Price" <> SalesLine.XRec_Unit_Price) THEN BEGIN
                //DEVIS//
                // TestStatusOpen;
                //+ABO+
                IF SalesLine."Document Type" = SalesLine."Document Type"::Subscription THEN
                    SalesLine.fSubscrIntegration(SalesLine.FIELDNO("Unit Price"));
                //+ABO+//
                //AVANCEMENT
                SalesLine.wTestInvoicedQty(SalesLine.FIELDNO("Unit Price"));
                //AVANCEMENT//
                //DEVIS
            END;
        IF (SalesLine."Unit Price" <> SalesLine.XRec_Unit_Price) AND (CurrentFieldNo = SalesLine.FIELDNO("Unit Price")) THEN BEGIN
            SalesLine."Fixed Price" := TRUE;
            IF SalesLine."Profit %" <> 0 THEN
                SalesLine.VALIDATE("Profit %", 0);
        END;
        //DEVIS//

        //OUVRAGE
        IF (SalesLine.Type > 0) AND
           //GL2024 ("Cross-Reference No." <> '') AND
           (SalesLine."Structure Line No." = 0) AND
           //#6428
           //   (CurrFieldNo = FIELDNO("Unit Price"))
           ((CurrentFieldNo = SalesLine.FIELDNO("Unit Price")) OR (CurrentFieldNo = SalesLine.FIELDNO("Line Amount")))
        //#6428//
        THEN
            lSalesCrossRefMgt.wUpdateField(SalesLine, SalesLine."Unit Price", SalesLine.FIELDNO("Unit Price"));
        //  lSalesCrossRefMgt.wUpdateCrossRefPrice(Rec);
        //OUVRAGE//

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceByFieldOnBeforeValidateUnitPrice', '', true, true)]
    local procedure OnUpdateUnitPriceByFieldOnBeforeValidateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer; var Handled: Boolean)
    begin
        //PROJET
        IF SalesLine.Type = SalesLine.Type::" " THEN
            Handled := true;
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceOnBeforeFindPrice', '', true, true)]
    local procedure OnUpdateUnitPriceOnBeforeFindPrice(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    var
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";

    begin
        //#
        // IsHandled := true;
        CLEAR(PriceCalcMgt);
        //#
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateUnitPrice', '', true, true)]
    local procedure OnBeforeUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer; var Handled: Boolean)
    var
        Text8003921: label 'Le prix est fixe, souhaitez-vous recalculer le prix ?';
        wSalesLineMgt: Codeunit "SalesLine Management";
        wOverhead: Codeunit "Overhead Calculation";
        StatusCheckSuspended: Boolean;
        lSalesline: Record "Sales Line";
        lInit: Boolean;
        RecPrixBeton: Record "Temp beton Prix";
    begin


        //HS
        IF (CalledByFieldNo = SalesLine.FieldNo(Quantity)) then begin
            IF (xSalesLine.Quantity <> SalesLine.Quantity) THEN BEGIN

                lInit := TRUE;
            END;
            //CADENCE
            SalesLine.wUpdateDuration(SalesLine.FIELDNO("Quantity (Base)"));
            //CADENCE//

            //OUVRAGE
            //MARGE
            IF (SalesLine."Line Type" = SalesLine."Line Type"::Structure) THEN
                wSalesLineMgt.UpdateStructLine(SalesLine, xSalesLine, StatusCheckSuspended)

            ELSE
                IF (SalesLine."Structure Line No." = 0) THEN
                    wOverhead.SalesLine(SalesLine, TRUE, TRUE);

            //MARGE//
            IF (SalesLine."Structure Line No." <> 0) AND (SalesLine.Type <> SalesLine.Type::" ") AND
               ((CurrFieldNo = SalesLine.FIELDNO(Quantity)) OR (CurrFieldNo = SalesLine.FIELDNO("Quantity (Base)"))) THEN
                SalesLine.VALIDATE("Unit Cost (LCY)");
            //OUVRAGE//

            //CDE_INTERNE
            IF SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order" THEN BEGIN
                //  "Unit Cost (LCY)" := wGetDirectCost;
                //  VALIDATE("Unit Cost (LCY)");         //17/03/05
                SalesLine.GetUnitCost();
                EXIT;
            END;
            //CDE_INTERNE//

            //DEVIS
            IF (SalesLine."Cross-Ref. Line No." <> 0) AND (SalesLine."Line No." <> SalesLine."Cross-Ref. Line No.") THEN
                IF lSalesline.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Cross-Ref. Line No.") THEN BEGIN
                    lSalesline."Quantity (Base)" += SalesLine.Quantity - xSalesLine.Quantity;
                    lSalesline.MODIFY;
                END;

            //#7121
            //#6926
            //IF ("Order Type" <> "Order Type"::"Supply Order") AND ("Structure Line No." = 0) THEN BEGIN
            //IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND
            //   ("Order Type" <> "Order Type"::"Supply Order") AND ("Structure Line No." = 0) THEN BEGIN
            //#6926//
            IF (SalesLine."Order Type" <> SalesLine."Order Type"::"Supply Order") AND (SalesLine."Structure Line No." = 0) THEN BEGIN
                //#7121//
                //#8243
                //#8437 IF lSalesline."Blanket Order No." <> '' THEN
                //#8243
                IF SalesLine.MODIFY THEN;
                SalesLine.wUpdateLine(SalesLine, xSalesLine, lInit);
            END;

            //DEVIS//
            // >> HJ SORO 13-08-2014
            SalesLine.UpdateUMIM;
            // >> HJ SORO 13-08-2014
            // >> HJ SORO 17-02-2017

            // >> HJ SORO 17-02-2017
            // >> HJ SORO 17-02-2017
            SalesLine."Shipped Not Invoiced" := SalesLine."Quantity Shipped" * SalesLine."Unit Price";
            // >> HJ SORO 17-02-2017

            // MH SORO 28-08-2020

            RecPrixBeton.RESET;
            RecPrixBeton.SETRANGE(CodeBeton, SalesLine."No.");
            IF RecPrixBeton.FINDFIRST THEN SalesLine.VALIDATE("Unit Price", RecPrixBeton."Prix Reelle");

            // MH SORO 28-08-2020

        end;
        //HS
        //DEVIS
        //IF (CalledByFieldNo <> CurrFieldNo) THEN AND (CurrFieldNo <> 0) THEN
        //  EXIT;
        //#9084
        //IF ((CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 6)) OR ("Structure Line No." <> 0) THEN
        //GL2024    IF ((CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 6) AND (gCurrFieldNoRTC = 0)) OR (SalesLine."Structure Line No." <> 0) THEN
        //#9084//
        //DEVIS//
        //GL2024        EXIT;
        //DEVIS

        IF SalesLine."Structure Line No." = 0 THEN BEGIN
            IF CurrFieldNo = SalesLine.FIELDNO("Work Type Code") THEN
                IF SalesLine."Fixed Price" THEN
                    IF NOT CONFIRM(Text8003921, FALSE) THEN
                        EXIT;
            IF SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order" THEN
                EXIT;
            //DEVIS//
        end
        else
            Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateTypeOnCopyFromTempSalesLine', '', true, true)]
    local procedure OnValidateTypeOnCopyFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesHeader: Record "Sales Header";
    begin
        //DEVIS
        SalesLine."Line Type" := TempSalesLine."Line Type";
        IF SalesLine.Type = SalesLine.Type::Item THEN
            SalesLine."Line Type" := SalesLine."Line Type"::Item;
        SalesLine."Presentation Code" := TempSalesLine."Presentation Code";
        SalesLine."Imported Line" := TempSalesLine."Imported Line";
        /* GL2024 IF SalesLine."Imported Line" THEN
            SalesLine."Cross-Reference No." := TempSalesLine."Cross-Reference No.";*/
        SalesLine.Level := TempSalesLine.Level;
        SalesLine."Job No." := TempSalesLine."Job No.";
        SalesLine."Attached to Line No." := TempSalesLine."Attached to Line No.";
        SalesLine."Structure Line No." := TempSalesLine."Structure Line No.";

        //GL2024  IF ((xRec."No." = '') AND (xRec.Description <> '')) OR (SalesLine."Line Type" = SalesLine."Line Type"::" ") OR SalesLine."Imported Line" THEN
        SalesLine.Description := TempSalesLine.Description;
        SalesLine."Location Code" := TempSalesLine."Location Code";
        IF SalesLine."Job No." = '' THEN begin
            SalesHeader.Reset();
            SalesHeader.SetRange("Document Type", SalesLine."Document Type");
            SalesHeader.SetRange("No.", SalesLine."Document No.");
            if SalesHeader.FindFirst() then begin
                SalesLine."Job No." := SalesHeader."Job No.";
            end;
        end;
        SalesLine.Option := TempSalesLine.Option;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateTypeOnBeforeInitRec', '', true, true)]
    local procedure OnValidateTypeOnBeforeInitRec(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var

        wStructureMgt: Codeunit "Structure Management";
    begin

        IF xSalesLine."Line Type" = SalesLine."Line Type"::Structure THEN
            wStructureMgt.DeleteStructure(xSalesLine);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeInitRec', '', true, true)]
    local procedure OnValidateNoOnBeforeInitRec(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer)
    var

        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";


        SalesLine2: Record "Sales Line";
        Text045: label 'Article Deja Existant Dans Cette Commande, Vous n''avez Le droit D''untilser Un Article Qu''une Seule Fois';

    begin


        //+ONE+//

        //DEVIS
        IF SalesLine."Document Type" <> SalesLine."Document Type"::Quote THEN
            //DEVIS//
            WhseValidateSourceLine.SalesLineVerifyChange(SalesLine, xSalesLine);
        /*GL2024 protected procedure 
        
          IF (SalesLine."No." <> xSalesLine."No.") THEN BEGIN
            IF SalesLine.Type = SalesLine.Type::Item THEN
             
                SalesLine.DeleteItemChargeAssgnt("Document Type", "Document No.", "Line No.");
            IF SalesLine.Type = SalesLine.Type::"Charge (Item)" THEN
                SalesLine.DeleteChargeChargeAssgnt("Document Type", "Document No.", "Line No.");
        END;
        
        */
        //new vente
        // >> HJ SORO 15-01-2015
        IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN BEGIN
            IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                IF (SalesLine."No." <> 'IMM') AND (SalesLine."No." <> '3000010000001') AND (COPYSTR(SalesLine.Description, 1, 4) <> 'DALOT') and (SalesLine."Type article" <> SalesLine."Type article"::Service) THEN BEGIN
                    SalesLine2.SETRANGE("No.", SalesLine."No.");
                    SalesLine2.SETRANGE("Document Type", SalesLine."Document Type");
                    SalesLine2.SETRANGE("Document No.", SalesLine."Document No.");
                    IF SalesLine2.FINDFIRST THEN ERROR(Text045);
                END;
            END;
        END;
        // >> HJ SORO 15-01-2015
    END;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnCopyFromTempSalesLine', '', true, true)]
    local procedure OnValidateNoOnCopyFromTempSalesLine(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lStructureOk: Boolean;
        wPresentationMgt: Codeunit "Presentation Management";
        SalesHeader: Record "Sales Header";
        lDescr: Text[50];
        lQty: Decimal;
        lQtyBase: Decimal;
        lUnit: Code[10];
        lPrice: Decimal;
    begin
        //DEVIS
        // IF SalesLine."Line Type" = SalesLine."Line Type"::Totaling THEN
        //     SalesLine.Description := TempSalesLine.Description
        // ELSE
        //     //DEVIS//
        //     //DEVIS//
        //     SalesLine.INIT;

        SalesLine.Type := TempSalesLine.Type;
        //DEVIS
        //"No." := TempSalesLine."No.";
        lDescr := TempSalesLine.Description;
        SalesLine.Description := TempSalesLine.Description;
        SalesLine."Description 2" := TempSalesLine."Description 2";
        lQty := TempSalesLine.Quantity;
        lQtyBase := TempSalesLine."Quantity (Base)";
        lUnit := TempSalesLine."Unit of Measure Code";
        lPrice := TempSalesLine."Unit Price";

        SalesLine."Line Type" := TempSalesLine."Line Type";
        IF SalesLine.Type = SalesLine.Type::Item THEN
            SalesLine."Line Type" := SalesLine."Line Type"::Item;
        SalesLine."Presentation Code" := TempSalesLine."Presentation Code";
        SalesLine."Imported Line" := TempSalesLine."Imported Line";
        IF SalesLine."Imported Line" THEN BEGIN
            //GL2024   SalesLine."Cross-Reference No." := TempSalesLine."Cross-Reference No.";
            SalesLine.Marker := TempSalesLine.Marker;
            SalesLine."Fixed Price" := TempSalesLine."Fixed Price";
            SalesLine."Unit of Measure Code" := TempSalesLine."Unit of Measure Code";
            SalesLine."Excel Line No." := TempSalesLine."Excel Line No.";
        END;
        SalesLine.Level := TempSalesLine.Level;
        SalesLine."Job No." := TempSalesLine."Job No.";
        //"Invoice No." := TempSalesLine."Invoice No.";
        //"Invoice Line No." := TempSalesLine."Invoice Line No.";
        SalesLine.Option := TempSalesLine.Option;

        //  SalesLine."No." := TempSalesLine."No.";
        IF SalesLine."Structure Line No." = 0 THEN
            TempSalesLine.VALIDATE(Type);
        //GL2024
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesLine."Document Type");
        SalesHeader.SetRange("No.", SalesLine."Document No.");
        if SalesHeader.FindFirst() then begin
            IF (TempSalesLine."No." <> '') AND
               (TempSalesLine."Line Type" = TempSalesLine."Line Type"::" ") AND
               (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order")
            THEN BEGIN
                wPresentationMgt.wNextRecordTextWithNo(TempSalesLine);
                SalesLine."Presentation Code" := TempSalesLine."Presentation Code";
            END;
        end;
        //GL2024 FIN



        SalesLine."Attached to Line No." := TempSalesLine."Attached to Line No.";
        SalesLine."Structure Line No." := TempSalesLine."Structure Line No.";
        IF (SalesLine."Structure Line No." <> 0) THEN BEGIN
            //#4744
            lStructureOK := lSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.");
            IF NOT lStructureOK THEN
                //#4744//
                lSalesLine.INIT;
            //#5257
            SalesLine."Shortcut Dimension 1 Code" := lSalesLine."Shortcut Dimension 1 Code";
            SalesLine."Shortcut Dimension 2 Code" := lSalesLine."Shortcut Dimension 2 Code";
            //#5257//
            SalesLine."Vendor No." := lSalesLine."Vendor No.";
            SalesLine."Purchasing Code" := lSalesLine."Purchasing Code";
            SalesLine.Subcontracting := lSalesLine.Subcontracting;
            SalesLine."Assignment Basis" := lSalesLine."Assignment Basis";
            SalesLine."Profit %" := lSalesLine."Profit %";
        END;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCalcVATAmountLinesOnAfterCalcLineTotals', '', true, true)]

    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals37(var VATAmountLine: Record "VAT Amount Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal; QtyToHandle: Decimal)
    begin
        if not ((QtyType = QtyType::General) and (QtyType = QtyType::Invoicing) and (QtyType = QtyType::Shipping)) then begin
            VATAmountLine.Quantity := VATAmountLine.Quantity + SalesLine."Quantity (Base)";
            VATAmountLine."Line Amount" := VATAmountLine."Line Amount" + SalesLine."Line Amount";
            IF SalesLine."Allow Invoice Disc." THEN
                VATAmountLine."Inv. Disc. Base Amount" :=
                  VATAmountLine."Inv. Disc. Base Amount" + SalesLine."Line Amount";
            VATAmountLine."Invoice Discount Amount" :=
              VATAmountLine."Invoice Discount Amount" + SalesLine."Inv. Discount Amount";
            VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + SalesLine."VAT Difference";
            VATAmountLine.MODIFY;
        END;
        IF SalesLine."Prepayment Line" THEN
            VATAmountLine."Includes Prepayment" := TRUE;
        //#4495//

    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnInitHeaderDefaultsOnBeforeTestSellToCustomerNo', '', true, true)]

    local procedure OnInitHeaderDefaultsOnBeforeTestSellToCustomerNo(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //CDE_INTERNE
        SalesLine."Order Type" := SalesHeader."Order Type";
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitHeaderLocactionCode', '', true, true)]
    local procedure OnBeforeInitHeaderLocactionCode(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesLine."Document Type");
        SalesHeader.SetRange("No.", SalesLine."Document No.");
        if SalesHeader.FindFirst() then begin

            SalesLine."Job No." := SalesHeader."Job No.";
            IF SalesLine."Job No." <> '' THEN
                SalesLine.VALIDATE("Job No.");
            //DEVIS "Location Code" := SalesHeader."Location Code";


            SalesLine.wInitLocationCode;
            //DEVIS//
        end;
        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeCalcShipmentDateForLocation', '', true, true)]
    local procedure OnValidateNoOnBeforeCalcShipmentDateForLocation(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    begin
        IF SalesLine.Type = SalesLine.Type::Item THEN
            IsHandled := false
        else
            IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeUpdateDates', '', true, true)]
    local procedure OnValidateNoOnBeforeUpdateDates(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CallingFieldNo: Integer; var IsHandled: Boolean; var TempSalesLine: Record "Sales Line" temporary)
    begin
        IF SalesLine.Type = SalesLine.Type::Item THEN
            IsHandled := false
        else
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFieldsForNo', '', true, true)]
    local procedure OnAfterAssignFieldsForNo(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        StdTxt: Record "Standard Text";
        Res: Record "Resource";

        Text8003925: Label 'The length of Structure No. cannot be superior to 10 characters.';
    begin
        case SalesLine.Type of
            SalesLine.Type::" ":
                begin


                    //DEVIS
                    //   StdTxt.GET(SalesLine."No.");
                    //GL2024 car   Description := StandardText.Description; commente en Standard
                    SalesLine.Description := xSalesLine.Description;
                    //GL2024
                    //  SalesLine."Allow Item Charge Assignment" := FALSE;

                    //#5251
                    IF (SalesLine."Line Type" = SalesLine."Line Type"::" ") AND
                       (xSalesLine."No." = '') AND (SalesLine."No." <> '') AND (SalesLine."Attached to Line No." <> 0) AND
                       NOT SalesLine."Imported Line" THEN BEGIN
                        SalesLine.TESTFIELD(Description, '');
                        SalesLine.TESTFIELD("Description 2", '');
                    END;
                    //#5251//

                    IF SalesLine."Line Type" = SalesLine."Line Type"::Totaling THEN BEGIN
                        IF STRLEN(SalesLine."No.") > 10 THEN
                            ERROR(Text8003925);
                        SalesLine."Allow Item Charge Assignment" := FALSE;
                        IF (SalesLine.Marker = '') OR (xSalesLine.Marker = xSalesLine."No.") THEN
                            SalesLine.Marker := SalesLine."No.";
                    END;
                    //#7590
                    IF SalesLine."Line Type" = SalesLine."Line Type"::Structure THEN BEGIN
                        Res.GET(SalesLine."No.");
                        Res.TESTFIELD(Blocked, FALSE);
                        SalesLine.Rate := Res.Rate;
                    END;
                    //#7590//
                    //TRAD
                    IF StdTxt.GET(SalesLine."No.") THEN
                        SalesLine.wGetStandardText
                    ELSE
                        IF SalesHeader."Language Code" <> '' THEN
                            SalesLine."Internal Description" := SalesLine.Description;

                    //TRAD//
                    //DEVIS//
                    SalesLine."Allow Item Charge Assignment" := FALSE;
                END;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignGLAccountValues', '', true, true)]
    local procedure OnAfterAssignGLAccountValues(var SalesLine: Record "Sales Line"; GLAccount: Record "G/L Account"; SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    begin
        //DEVIS      "Allow Invoice Disc." := FALSE;
        SalesLine."Allow Invoice Disc." := TRUE;
        //DEVIS//
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheck', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheck(var SalesLine: Record "Sales Line"; Item: Record Item)
    var

        lSalesLine: Record "Sales Line";

        lStructureOK: Boolean;
    begin
        // >> HJ SORO 20-01-2015
        //   IF Item."Appliquer Fodec" THEN SalesLine."Apply Fodec" := TRUE;
        // >> HJ SORO 20-01-2015

        //DEVIS  Avant GetUnitCost
        SalesLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        IF (SalesLine."Structure Line No." <> 0) THEN BEGIN
            //#4744
            IF NOT lStructureOK THEN
                lStructureOK := lSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.");
            //#9171
            //         IF lSalesLine."Structure Line No." = "Line No." THEN
            //9171//
            //#4744//
            SalesLine."Shipment Date" := lSalesLine."Shipment Date";
        END;
        //DEVIS//
        //CDE_INTERNE
        //#7640       IF ("Vendor No." = '') THEN
        IF (SalesLine."Vendor No." = '') AND (SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order") THEN
            //#7640//
            SalesLine."Vendor No." := Item."Vendor No.";
        SalesLine."Purchasing Code" := Item."Purchasing Code";
        SalesLine.Subcontracting := Item.Subcontracting;
        //SUBCONTRACTOR
        //      END;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheckInvtPostingSetupInventoryAccount', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheckInvtPostingSetupInventoryAccount(var SalesLine: Record "Sales Line"; Item: Record Item)
    var

        lTotalNeedParameter: Record "Sales Document Cost";


    begin
        //+ONE+



        //DEVIS      "Profit %" := Item."Profit %";
        //CDE_INTERNE//
        SalesLine."Item Type" := Item."Item Type";
        IF lTotalNeedParameter.GET(SalesLine."Document Type", SalesLine."Document No.", lTotalNeedParameter.Type::Item, SalesLine."No.", 0, SalesLine."Purchasing Code") THEN
            IF lTotalNeedParameter."Vendor No." <> '' THEN
                SalesLine."Vendor No." := lTotalNeedParameter."Vendor No.";
        IF lTotalNeedParameter.GET(SalesLine."Document Type", SalesLine."Document No.", lTotalNeedParameter.Type::Item, SalesLine."No.", 0, SalesLine."Purchasing Code") THEN
            IF lTotalNeedParameter."Purchasing Code" <> '' THEN
                SalesLine."Purchasing Code" := lTotalNeedParameter."Purchasing Code";
        IF SalesLine."Purchasing Code" <> '' THEN
            SalesLine.VALIDATE("Purchasing Code");
        //CDE_INTERNE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeGetItemTranslation', '', true, true)]
    local procedure OnBeforeGetItemTranslation(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        if SalesLine.Type = SalesLine.Type::Item then begin
            if Item.get(SalesLine."No.") then
                //TRAD
                SalesLine."Internal Description" := Item.Description;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemValues', '', true, true)]
    local procedure OnAfterAssignItemValues(var SalesLine: Record "Sales Line"; Item: Record Item; SalesHeader: Record "Sales Header"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin


        //QUANTITE
        SalesLine."Value 1" := Item."Default Qty Value 1";
        SalesLine."Value 2" := Item."Default Qty Value 2";
        SalesLine."Value 3" := Item."Default Qty Value 3";
        SalesLine."Value 4" := Item."Default Qty Value 4";
        SalesLine."Value 5" := Item."Default Qty Value 5";
        SalesLine."Value 6" := Item."Default Qty Value 6";
        SalesLine."Value 7" := Item."Default Qty Value 7";
        SalesLine."Value 8" := Item."Default Qty Value 8";
        SalesLine."Value 9" := Item."Default Qty Value 9";
        SalesLine."Value 10" := Item."Default Qty Value 10";
        //QUANTITE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromResourceOnBeforeApplyResUnitCost', '', true, true)]
    local procedure OnCopyFromResourceOnBeforeApplyResUnitCost(var SalesLine: Record "Sales Line"; Resource: Record Resource; SalesHeader: Record "Sales Header")
    var

        Text8003926: label '%1 is not the same in imported line.';
        ResUnitOfMeasure: Record "Resource Unit of Measure";
        TempSalesLine: Record "Sales Line";


    begin
        //DEVIS
        //      Res.TESTFIELD("Gen. Prod. Posting Group");
        //      IF (xRec."No." = '') AND (xRec.Description <> '') AND (TempSalesLine.Description <> '') THEN
        if TempSalesLine.get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.") then begin


            IF TempSalesLine."Imported Line" THEN BEGIN
                SalesLine.Description := TempSalesLine.Description;
                SalesLine."Description 2" := TempSalesLine."Description 2";
                IF NOT ResUnitOfMeasure.GET(SalesLine."No.", SalesLine."Unit of Measure Code") THEN
                    ResUnitOfMeasure.INIT;
                IF (ResUnitOfMeasure."Qty. per Unit of Measure" <> 1) AND (SalesLine."Unit of Measure Code" <> Resource."Base Unit of Measure") THEN
                    MESSAGE(Text8003926, SalesLine.FIELDCAPTION("Unit of Measure Code"));
            END ELSE BEGIN
                //DEVIS//
                SalesLine.Description := Resource.Name;
                SalesLine."Description 2" := Resource."Name 2";
                //DEVIS
            END;
            //DEVIS//
        end;

        //TRAD
        IF SalesHeader."Language Code" <> '' THEN
            SalesLine.wGetStructureTranslation;
        //TRAD//
        //DEVIS

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignResourceValues', '', true, true)]
    local procedure OnAfterAssignResourceValues(var SalesLine: Record "Sales Line"; Resource: Record Resource; SalesHeader: Record "Sales Header")
    var

        lSalesLine: Record "Sales Line";

        lStructureOK: Boolean;
        wPresentationMgt: Codeunit "Presentation Management";

        ICPartner: Record "IC Partner";

        lQty: Decimal;
        lQtyBase: Decimal;

    begin
        //CADENCE
        SalesLine.Rate := Resource.Rate;
        //#4744
        IF (SalesLine."Line Type" IN [SalesLine."Line Type"::Person, SalesLine."Line Type"::Machine]) AND (SalesLine."Structure Line No." <> 0)
          //#7590
          AND (SalesLine."Attached to Line No." = 0) THEN BEGIN
            //#7590//
            IF NOT lStructureOK THEN
                lStructureOK := lSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.");
            IF lStructureOK AND (lSalesLine.Rate <> 0) THEN
                SalesLine.Rate := lSalesLine.Rate;
        END;
        //#4744//
        IF (SalesLine."Structure Line No." = 0) AND (SalesLine.Rate <> 0) THEN
            SalesLine.Duration := 1 / SalesLine.Rate;
        //#5080
        IF (SalesLine."Line Type" <> SalesLine."Line Type"::Structure) AND (SalesLine."Structure Line No." <> 0) THEN BEGIN
            SalesLine."Number of Resources" := Resource."Default Number of Resources";
            //#6301
            IF lStructureOK AND (lSalesLine.Rate <> 0) THEN
                SalesLine.VALIDATE("Rate Quantity", Resource."Default Rate Quantity")
            ELSE
                SalesLine."Rate Quantity" := Resource."Default Rate Quantity";
            //#6301//
        END;
        //CADENCE//
        //POINTAGE
        SalesLine."Work Type Code" := Resource."Work Type Code";
        //POINTAGE//
        //PLANNING
        IF SalesLine."Line Type" IN [SalesLine."Line Type"::Person, SalesLine."Line Type"::Machine] THEN BEGIN
            Resource.TESTFIELD("Resource Group No.");
            SalesLine."Resource Group No." := Resource."Resource Group No.";
        END;
        //PLANNING//

        //SUBCONTRACTOR
        SalesLine.Subcontracting := Resource.Subcontracting;
        //SUBCONTRACTOR//
        //FRAIS
        IF SalesLine."Structure Line No." = 0 THEN BEGIN
            //#5110
            IF Resource."Assignment Basis" <> Resource."Assignment Basis"::" " THEN
                SalesLine.TESTFIELD(Option, FALSE);
            //#5110//
            SalesLine."Assignment Basis" := Resource."Assignment Basis";
        END;
        //FRAIS//
        //    FindResUnitCost;
        //PIED_DEVIS
        IF (SalesLine."Line Type" = SalesLine."Line Type"::Other) THEN BEGIN
            SalesLine."Value Option" := Resource."Value Option";
            SalesLine."Rate Amount" := Resource."Rate Amount";
            SalesLine."Assignment Method" := Resource."Assignment Method";
            //#7438
            //Quantity := 1;
            SalesLine.VALIDATE(Quantity, 1);
            lQty := SalesLine.Quantity;
            lQtyBase := SalesLine."Quantity (Base)";
            //#7438//
            wPresentationMgt.wMoveAfterOther(SalesLine);
        END;
        //PIED_DEVIS//
        IF SalesHeader."Bill-to IC Partner Code" <> '' THEN
            IF SalesHeader."Sell-to IC Partner Code" <> '' THEN
                ICPartner.GET(SalesHeader."Sell-to IC Partner Code")
            ELSE
                ICPartner.GET(SalesHeader."Bill-to IC Partner Code");
    end;





    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFixedAssetValues', '', true, true)]
    local procedure OnAfterAssignFixedAssetValues(var SalesLine: Record "Sales Line"; FixedAsset: Record "Fixed Asset"; SalesHeader: Record "Sales Header")
    begin
        //PROJET_IMMO
        SalesLine.VALIDATE("Job No.", FixedAsset."Job No.");
        //PROJET_IMMO// 
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeCheckPostingSetups', '', true, true)]
    local procedure OnValidateNoOnBeforeCheckPostingSetups(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        wSalesLineMgt: Codeunit "SalesLine Management";
    begin
        //#8334
        SalesLine."Allow Invoice Disc." := wSalesLineMgt.InvDiscountIsAllowed(SalesLine, TRUE);
        //#8334//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterCreateDimFromDefaultDim', '', true, true)]
    local procedure OnValidateNoOnAfterCreateDimFromDefaultDim(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CallingFieldNo: Integer)
    var

        lStructureOK: Boolean;

        lSalesLine: Record "Sales Line";

        lGenProductPostGr: Record "Gen. Product Posting Group";
        TempSalesLine: Record "Sales Line" temporary;
        lPrice: Decimal;
        lUnit: Code[10];
        lQty: Decimal;
        lQtyBase: Decimal;



    begin

        //PROJET_FG

        SalesLine.VALIDATE("Unit Cost (LCY)");
        //PROJET_FG//

        //#6926
        IF SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order] THEN BEGIN
            //#6926//
            //DEVIS
            //  VALIDATE(Quantity,xRec.Quantity);
            IF SalesLine."Structure Line No." = 0 THEN BEGIN
                //GL2024
                TempSalesLine := SalesLine;
                //GL2024
                //GL2024   TempSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                //GL2024
                lPrice := TempSalesLine."Unit Price";
                lUnit := TempSalesLine."Unit of Measure Code";
                lQty := TempSalesLine.Quantity;
                lQtyBase := TempSalesLine."Quantity (Base)";
                //GL2024

                IF TempSalesLine."Imported Line" THEN BEGIN
                    SalesLine.VALIDATE("Unit of Measure Code", lUnit);
                    //#5347
                    SalesLine."Quantity (Base)" := lQtyBase;
                    //#5347//
                    SalesLine.VALIDATE(Quantity, lQty);
                    IF (lPrice <> 0) AND
                       (SalesLine."Fixed Price" OR xSalesLine."Fixed Price" OR TempSalesLine."Fixed Price")
                    THEN BEGIN
                        SalesLine.VALIDATE("Unit Price", lPrice);
                        SalesLine.VALIDATE("Fixed Price", TRUE);
                    END;
                END ELSE
                    IF SalesLine."Document Type" <> SalesLine."Document Type"::"Blanket Order" THEN BEGIN
                        SalesLine."Quantity (Base)" := lQtyBase;
                        SalesLine.VALIDATE(Quantity, lQty);
                    END;
            END ELSE BEGIN
                //SUBCONTRACTOR
                IF SalesLine."Structure Line No." <> 0 THEN BEGIN    //D‚tail
                                                                     //#4744
                    lSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.");

                    IF NOT lStructureOK THEN
                        lStructureOK := lSalesLine.GET(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.");
                    IF lStructureOK THEN
                        //#4744//
                        CASE lSalesLine.Subcontracting OF
                            lSalesLine.Subcontracting::" ", lSalesLine.Subcontracting::"Furniture and Fixing":
                                SalesLine.Disable := SalesLine.Subcontracting <> lSalesLine.Subcontracting;
                            lSalesLine.Subcontracting::Fixing:
                                SalesLine.Disable :=
                                  (SalesLine."Line Type" IN [SalesLine."Line Type"::Person, SalesLine."Line Type"::Machine]) OR
                                  ((SalesLine.Type = SalesLine.Type::Item) AND (SalesLine.Subcontracting = SalesLine.Subcontracting::"Furniture and Fixing"));
                        END;
                END;
                //SUBCONTRACTOR//
                //PROJET_CESSION
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
                    lGenProductPostGr.wCheckBalJob(SalesLine."Gen. Prod. Posting Group");
                //PROJET_CESSION//
            END;
            //#6926
        END;
        //#6926//

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', true, true)]
    local procedure OnValidateNoOnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        wPresentationMgt: Codeunit "Presentation Management";
        lDescr: Text[50];
        RecSalesHeaderBeton: Record "Sales Header";
        SalesHeader: Record "Sales Header";
        //  CduSoro: Codeunit "Soroubat cdu";
        RecPrixBeton: Record "Temp beton Prix";

    begin
        //DEVIS
        // hs
        SalesLine.VALIDATE("Unit Cost (LCY)");
        // hs
        lDescr := TempSalesLine.Description;
        IF SalesLine."Imported Line" THEN
            SalesLine.Description := lDescr;
        wPresentationMgt.wInsertBetweenExtendedText(SalesLine, xSalesLine);
        //DEVIS//
        //#7190
        SalesLine.fInitUnitAmountRounding;
        //#7190//
        //##8419
        IF SalesLine.Quantity <> 0 THEN
            SalesLine.wUpdateLine(SalesLine, xSalesLine, TRUE);
        //##8419//
        // >> HJ DSFT 20-06-2012
        SalesLine.InsertionLigneChapitre;
        // >> HJ DSFT 20-06-2012
        // RB SORO 21/08/2015 BETON
        // IF RecSalesHeaderBeton.GET(SalesLine."Document Type", SalesLine."Document No.") THEN;
        // SalesLine."Date Comptabilisation" := RecSalesHeaderBeton."Posting Date";
        // SalesLine."User ID" := RecSalesHeaderBeton."User ID";
        // RB SORO 21/08/2015 BETON
        // >> HJ SORO 06-03-2018
        //  IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN begin


        //  IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
        //   IF SalesHeader."Type Demande" = SalesHeader."Type Demande"::Materiaux THEN CduSoro.VerifMateriauxChantier(SalesLine."Job No.", SalesLine."No.");
        // >> HJ SORO 06-03-2018
        //  end;
        // MH SORO 28-08-2020

        //  RecPrixBeton.RESET;
        // RecPrixBeton.SETRANGE(CodeBeton, SalesLine."No.");
        //  IF RecPrixBeton.FINDFIRST THEN SalesLine.VALIDATE("Unit Price", RecPrixBeton."Prix Reelle");

        // MH SORO 28-08-2020
        // >> HJ DSFT 07-12-2016
        SalesLine."Type DA" := SalesHeader."Type DA";
        // >> HJ DSFT 07-12-2016




    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateICPartner', '', true, true)]

    local procedure OnBeforeUpdateICPartner37(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var ShouldUpdateICPartner: Boolean)
    var
        ICPartner: Record 413;
    begin
        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        IF ((SalesHeader.ISEMPTY) OR ((SalesHeader."Document Type" <> SalesLine."Document Type") AND (SalesHeader."No." <> SalesLine."Document No."))) THEN
            ShouldUpdateICPartner := SalesHeader."Send IC Document" and (SalesHeader."IC Direction" = SalesHeader."IC Direction"::Outgoing) and
                  (SalesHeader."Send IC Document")
        else
            ShouldUpdateICPartner := false;





    end;







    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateICPartner', '', true, true)]
    local procedure OnAfterUpdateICPartner(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        ShouldUpdateICPartner: Boolean;
        GLAcc: Record "G/L Account";

        ICPartner: Record "IC Partner";

    begin

        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        IF ((SalesHeader.ISEMPTY) OR ((SalesHeader."Document Type" <> SalesLine."Document Type") AND (SalesHeader."No." <> SalesLine."Document No."))) THEN
            ShouldUpdateICPartner := SalesHeader."Send IC Document" and (SalesHeader."IC Direction" = SalesHeader."IC Direction"::Outgoing) and
                  (SalesHeader."Send IC Document")
        else
            ShouldUpdateICPartner := false;


        if ShouldUpdateICPartner then
            case SalesLine.Type of
                SalesLine.Type::"G/L Account":
                    begin
                        SalesLine."IC Partner Ref. Type" := SalesLine.Type;
                        //+REF+IC
                        IF GLAcc."Default IC Partner G/L Acc. No" <> '' THEN
                            //+REF+IC//
                            SalesLine."IC Partner Reference" := GLAcc."Default IC Partner G/L Acc. No"
                        //+REF+IC
                        ELSE
                            SalesLine."IC Partner Reference" := SalesLine."No.";
                        //+REF+IC//
                    end;

            end;

        IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
            //+ABO+
            //#8661
            //IF "Document Type" = "Document Type"::Subscription THEN
            //#8661
            SalesLine.fSubscrIntegration(SalesLine.FIELDNO("No."));
            //+ABO+//
            //QUANTITE
            IF (SalesLine."Value 1" <> 0) OR (SalesLine."Value 2" <> 0) OR (SalesLine."Value 3" <> 0) OR (SalesLine."Value 4" <> 0) OR (SalesLine."Value 5" <> 0) OR
                 (SalesLine."Value 6" <> 0) OR (SalesLine."Value 7" <> 0) OR (SalesLine."Value 8" <> 0) OR (SalesLine."Value 9" <> 0) OR (SalesLine."Value 10" <> 0) THEN
                SalesLine.VALIDATE("Value 1");
            //QUANTITE//
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateShipmentDate', '', true, true)]
    local procedure OnBeforeValidateShipmentDate(var IsHandled: Boolean; var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
    begin
        //DEVIS
        IF (SalesLine."Line Type" = SalesLine."Line Type"::Structure) AND
           (SalesLine."Structure Line No." = 0) AND
           (xSalesLine."Shipment Date" <> SalesLine."Shipment Date")
        THEN BEGIN
            lSalesLine.SETRANGE("Document Type", SalesLine."Document Type");
            lSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
            lSalesLine.SETRANGE("Structure Line No.", SalesLine."Line No.");
            lSalesLine.SETRANGE("Line Type", SalesLine."Line Type"::Item);
            IF NOT lSalesLine.ISEMPTY THEN BEGIN
                lSalesLine.FIND('-');
                REPEAT
                    lSalesLine."Shipment Date" := SalesLine."Shipment Date";
                    lSalesLine.MODIFY;
                UNTIL lSalesLine.NEXT = 0;
            END;
        END;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckShipmentDateBeforeWorkDate', '', true, true)]
    local procedure OnBeforeCheckShipmentDateBeforeWorkDate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var HasBeenShown: Boolean; var IsHandled: Boolean)
    var
        Text014: Label '%1 %2 is before work date %3';
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin


            //IF ("Shipment Date" < WORKDATE) AND (Type <> Type::" ") THEN
            IF (SalesLine."Shipment Date" < WORKDATE) AND (SalesLine.Type <> SalesLine.Type::" ") AND
               (SalesHeader."Order Type" = SalesHeader."Order Type"::" ") THEN
                //DEVIS//
                if not (SalesLine.GetHideValidationDialog() or HasBeenShown) then begin
                    Message(
                      Text014,
                      SalesLine.FieldCaption("Shipment Date"), SalesLine."Shipment Date", WorkDate());
                    HasBeenShown := true;
                end;


        end;
        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, 37, 'OnValidateQuantityOnAfterCalcBaseQty', '', true, true)]
    local procedure OnValidateQuantityOnAfterCalcBaseQty(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        lInit: Boolean;
        wCalcQty: Codeunit 8004051;
        wSalesLineMgt: Codeunit "SalesLine Management";

    begin

        //  SalesLine."Quantity (Base)" := xSalesLine."Quantity (Base)";

    end;
    //HS
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateQuantity', '', true, true)]

    local procedure OnBeforeValidateQuantity(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        lInit: Boolean;
        lxRec: Record "Sales Line";
        lQtySetup: Record "Quantity Setup";
        lCalculateQty: Decimal;
        lCalcQty: Codeunit "Calculate Quantity";
        wSalesLineMgt: Codeunit "SalesLine Management";
        wCalcQty: Codeunit "Calculate Quantity";
    begin
        //+ONE+
        lxRec := SalesLine;
        //+ONE+//
        // >> HJ SORO 17-02-2017
        SalesLine."Quantity (Base)" := SalesLine.Quantity;
        SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
        SalesLine."Outstanding Qty. (Base)" := SalesLine.Quantity - SalesLine."Quantity Shipped";
        SalesLine."Qty. Shipped (Base)" := SalesLine."Quantity Shipped";
        // >> HJ SORO 17-02-2017
        //#6767
        IF (lQtySetup.GET()) THEN BEGIN
            IF (lQtySetup.fSalesUsed()) THEN BEGIN
                // obtenons le valeur de la quantit‚ li‚ au calcul de la formule
                // puis comparons la avec la quantite courante
                // si different, alors on effectue un RAZ des champs "ValueX"
                lCalculateQty := lCalcQty.fGetSalesCalcQty(SalesLine);
                IF (lCalculateQty <> SalesLine.Quantity) THEN BEGIN
                    lCalcQty.fSalesReset(SalesLine);
                END;
            END;
        END;
        //#6767//

        //AVANCEMENT
        IF (SalesLine.Quantity <> xSalesLine.Quantity) THEN BEGIN
            SalesLine.wTestInvoicedQty(SalesLine.FIELDNO(SalesLine.Quantity));
            //#5020
            SalesLine.TESTFIELD("Purchase Order No.", '');
            //#5020//
        END;
        //AVANCEMENT//

        //CDE_INTERNE
        wSalesLineMgt.SupplyOrderMessage(SalesLine, xSalesLine, CallingFieldNo);
        //CDE_INTERNE//

        //SUBCONTRACTOR
        IF (CallingFieldNo IN [SalesLine.FIELDNO(SalesLine.Quantity), SalesLine.FIELDNO(SalesLine."Quantity per"), SalesLine.FIELDNO(SalesLine."Quantity (Base)"),
           SalesLine.FIELDNO(SalesLine."Number of Resources"), SalesLine.FIELDNO(SalesLine."Rate Quantity")]) THEN
            SalesLine.TESTFIELD(Disable, FALSE);
        //SUBCONTRACTOR//
        IF (xSalesLine.Quantity <> SalesLine.Quantity) AND (CallingFieldNo = SalesLine.FIELDNO(SalesLine.Quantity)) THEN BEGIN
            wCalcQty.wCalcQty(SalesLine, SalesLine.FIELDNO(Quantity));
            lInit := TRUE;
        END;

    end;
    //HS

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnAfterInitQty', '', true, true)]
    local procedure OnValidateQuantityOnAfterInitQty(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        lInit: Boolean;
        wCalcQty: Codeunit 8004051;
        wSalesLineMgt: Codeunit "SalesLine Management";

    begin



        //"Quantity (Base)" := CalcBaseQty(Quantity);
        IF SalesLine."Optionnal Quantity" <> 0 THEN BEGIN
            IF (CurrentFieldNo = SalesLine.FIELDNO("Quantity (Base)")) THEN BEGIN
                IF (SalesLine."Qty. per Unit of Measure" * SalesLine.Quantity = xSalesLine."Quantity (Base)") AND
                   (SalesLine."Line Type" <> SalesLine."Line Type"::Structure) THEN
                    SalesLine.Quantity := SalesLine."Qty. per Unit of Measure" * SalesLine."Quantity (Base)";
            END;
            xSalesLine.Quantity := SalesLine."Optionnal Quantity";
            xSalesLine."Quantity (Base)" := SalesLine."Quantity (Base)";
            IF (CurrentFieldNo = SalesLine.FIELDNO(Quantity)) OR (SalesLine."Structure Line No." = 0) THEN
                SalesLine."Optionnal Quantity" := 0;
        END;
        IF SalesLine.Option THEN
            SalesLine."Quantity (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity + SalesLine."Optionnal Quantity", Format(SalesLine."Quantity (Base)"), ''/*GL2024 TRUE*/)
        ELSE
            SalesLine."Quantity (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity, Format(SalesLine."Quantity (Base)"), ''/*GL2024 TRUE*/);
        IF (xSalesLine."Quantity (Base)" <> SalesLine."Quantity (Base)") AND (CurrentFieldNo = SalesLine.FIELDNO(Quantity)) THEN BEGIN
            wCalcQty.wCalcQty(SalesLine, SalesLine.FIELDNO("Quantity (Base)"));
            lInit := TRUE;
        END;
        IF (xSalesLine."Quantity (Base)" <> SalesLine."Quantity (Base)") AND (CurrentFieldNo = SalesLine.FIELDNO("Quantity (Base)")) THEN
            lInit := TRUE;
        //QTYBASE//

        //DEVIS
        wSalesLineMgt.UpdateQtyPer(SalesLine, xSalesLine, CurrentFieldNo);
        //DEVIS//



    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitQty', '', true, true)]

    local procedure OnBeforeInitQty(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; IsAsmToOrderAlwd: Boolean; IsAsmToOrderRqd: Boolean; var IsHandled: Boolean; var ShouldInitQty: Boolean)
    begin
        //#3844
        //IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
        //#3844//
        ShouldInitQty := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnAfterCalcShouldVerifyQtyForItem', '', true, true)]
    local procedure OnValidateQuantityOnAfterCalcShouldVerifyQtyForItem(var SalesLine: Record "Sales Line"; var ShouldVerifyQtyForItem: Boolean; xSalesLine: Record "Sales Line")
    begin

        //+ONE+
        IF SalesLine."Structure Line No." = 0 THEN
            ShouldVerifyQtyForItem := (xSalesLine.Quantity <> SalesLine.Quantity) or (xSalesLine."Quantity (Base)" <> SalesLine."Quantity (Base)") // <-- NEW VARIABLE
        else
            ShouldVerifyQtyForItem := false;
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeResetAmounts', '', true, true)]
    local procedure OnValidateQuantityOnBeforeResetAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if SalesLine.Type <> SalesLine.Type::Item then begin
            //DISC
            IF (SalesLine.Type = SalesLine.Type::Resource) AND (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) THEN
                SalesLine.UpdateUnitPrice(SalesLine.FIELDNO(Quantity))
            ELSE
                //DISC//
                SalesLine.VALIDATE("Line Discount %");
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQtyToShipOnAfterCheck', '', true, true)]
    local procedure OnValidateQtyToShipOnAfterCheck(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        //PROJET_FACT

        IF (CurrentFieldNo <> 0) AND
           (SalesLine."Qty. to Ship" <> 0) THEN BEGIN
            SalesLine.GetSalesHeader;
            SalesHeader.Reset();
            SalesHeader.SetRange(SalesHeader."Document Type", SalesLine."Document Type");
            SalesHeader.SetRange(SalesHeader."No.", SalesLine."Document No.");
            IF SalesHeader.FindFirst() THEN begin
                IF SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Scheduler THEN // CW 14/09/07
                    SalesHeader.TESTFIELD("Invoicing Method", SalesHeader."Invoicing Method"::Direct);
            END;
            //PROJET_FACT//
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQtyToShipAfterInitQty', '', true, true)]
    local procedure OnValidateQtyToShipAfterInitQty(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        Text8003907: Label 'The shpiment management of this item is transfering in the supply Order %1 on the Line %2';
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange(SalesHeader."Document Type", SalesLine."Document Type");
        SalesHeader.SetRange(SalesHeader."No.", SalesLine."Document No.");
        IF SalesHeader.FindFirst() THEN begin
            //#4682
            IF (SalesHeader."Invoicing Method" <> SalesHeader."Invoicing Method"::Direct) AND
               (ABS(SalesLine."Qty. to Ship") <= ABS(SalesLine."Quantity Shipped")) AND (SalesLine."Quantity Shipped" <> 0) THEN
                EXIT;
            //#4682//
            //#8877
            IF ((SalesLine."Supply Order No." <> '')) AND
               ((SalesLine."Qty. to Ship" * SalesLine.Quantity < 0) OR
               (ABS(SalesLine."Qty. to Ship") > ABS(SalesLine."Outstanding Quantity")) OR
               (SalesLine.Quantity * SalesLine."Outstanding Quantity" < 0)) THEN
                ERROR(
                  Text8003907, SalesLine."Supply Order No.", SalesLine."Supply Order Line No.");
            //#8877//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckItemAvailable', '', true, true)]
    local procedure OnBeforeCheckItemAvailable(var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; var IsHandled: Boolean; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        CPt: Integer;

    begin

        //Hs  genere une erreur de recursivité

        /*    if CalledByFieldNo = SalesLine.FieldNo(Quantity) then begin
                IF SalesLine."Document Type" <> SalesLine."Document Type"::Quote THEN
                    //DEVIS//
                    //#9364
                    //IF Reserve <> Reserve::Always THEN
                    IF SalesLine.Reserve <> SalesLine.Reserve::Always THEN BEGIN
                        IF ((SalesLine."Document Type" = SalesLine."Document Type"::Order) AND (SalesLine."Order Type" = SalesLine."Order Type"::Transfer)) THEN
                            COMMIT;
                        //#9364//

                        SalesLine.CheckItemAvailable(SalesLine.FIELDNO(Quantity));

                        //#9364
                    END else begin
                        IsHandled := true;
                    end;
            end;
    */


        //hS

        if CalledByFieldNo = SalesLine.FieldNo("No.") then
            IF SalesLine."Line Type" = SalesLine."Line Type"::Totaling THEN BEGIN
                IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN BEGIN
                    //DEVIS//
                    IsHandled := true
                end;
            end;
        //+ONE+
        IF SalesLine."Structure Line No." <> 0 THEN
            EXIT;
        //+ONE+//


        if (CalledByFieldNo = SalesLine.FieldNo("Location Code"))
        or (CalledByFieldNo = SalesLine.FieldNo("Drop Shipment"))
         or (CalledByFieldNo = SalesLine.FieldNo("Variant Code"))
          or (CalledByFieldNo = SalesLine.FieldNo("Unit of Measure Code"))
         then
            //DEVIS
            IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
                IsHandled := true
        //DEVIS//




    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateUnitCostLCY', '', true, true)]
    local procedure OnBeforeValidateUnitCostLCY(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        lSubLine: Record "Sales Line";
        wStructureMgt: Codeunit "Structure Management";
        Text8003911: label 'You mustn''t specify %1 when the line type is %2.';
        lxRec: Record "Sales Line";
    begin

        //+ONE+
        lxRec := xSalesLine;
        //+ONE+//
        //DEVIS
        IF (SalesLine."Line Type" IN [SalesLine."Line Type"::Totaling, SalesLine."Line Type"::Structure]) AND (SalesLine.FIELDNO("Unit Cost (LCY)") = CurrentFieldNo) AND
           (SalesLine.Subcontracting = SalesLine.Subcontracting::" ") THEN
            ERROR(Text8003911, SalesLine.FIELDCAPTION("Unit Cost (LCY)"), SalesLine."Line Type");
        //DEVIS//

        //SUBCONTRACTOR : saisie du co–t sur la ligne ouvrage
        IF (SalesLine."Line Type" = SalesLine."Line Type"::Structure) AND (SalesLine.Subcontracting <> SalesLine.Subcontracting::" ") THEN BEGIN
            wStructureMgt.InitSumStructure(SalesLine);
            lSubLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.");
            lSubLine.SETRANGE("Document Type", SalesLine."Document Type");
            lSubLine.SETRANGE("Document No.", SalesLine."Document No.");
            lSubLine.SETRANGE("Structure Line No.", SalesLine."Line No.");
            lSubLine.SETRANGE(Subcontracting, SalesLine.Subcontracting);
            lSubLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
            IF lSubLine.FINDFIRST THEN BEGIN
                lSubLine.VALIDATE("Unit Cost (LCY)", SalesLine."Unit Cost (LCY)");
                SalesLine."Unit Cost (LCY)" := xSalesLine."Unit Cost (LCY)";
                lSubLine.MODIFY;
                wStructureMgt.UpdateSumStructCost(SalesLine, lSubLine);
            END;
            wStructureMgt.UpdateSumStructPrice(SalesLine);
        END;
        //SUBCONTRACTOR//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateLineDiscountPercentOnAfterTestStatusOpen', '', true, true)]
    local procedure OnValidateLineDiscountPercentOnAfterTestStatusOpen(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        wStructureMgt: Codeunit "Structure Management";
    begin
        //MARGE
        IF (SalesLine."Profit %" <> 0) AND (SalesLine."Line Discount %" <> 0) AND (CurrentFieldNo = SalesLine.FIELDNO("Line Discount %")) THEN
            wStructureMgt.wSetProfit(SalesLine, 0, TRUE);
        IF SalesLine."Line Discount %" <> xSalesLine."Line Discount %" THEN BEGIN
            //MARGE//
            //   SalesLine.TestStatusOpen;

            //AVANCEMENT
            SalesLine.wTestInvoicedQty(SalesLine.FIELDNO("Line Discount %"));
        END;
        //AVANCEMENT//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateLineDiscPct', '', true, true)]
    local procedure OnAfterUpdateLineDiscPct(var SalesLine: Record "Sales Line")
    begin
        //DEVIS
        //#4590
        IF SalesLine."Line Discount %" = 0 THEN
            SalesLine."Global Disc. Amount" := 0;

        //DEVIS//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateDropShipment', '', true, true)]
    local procedure OnBeforeValidateDropShipment(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        //SUBCONTRACTOR
        IF (SalesLine."Vendor No." = '') AND (xSalesLine."Vendor No." = '') AND (SalesLine.Subcontracting <> 0) THEN BEGIN
            //SUBCONTRACTOR//
            SalesLine.TESTFIELD("Document Type", SalesLine."Document Type"::Order);
            SalesLine.TESTFIELD(Type, SalesLine.Type::Item);
            //SUBCONTRACTOR
        END ELSE
            SalesLine.TESTFIELD("Line Type", SalesLine."Line Type"::Structure);
        //SUBCONTRACTOR//













    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnGenProdPostingGroupOnBeforeValidate', '', true, true)]
    local procedure OnGenProdPostingGroupOnBeforeValidate(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var GenProdPostingGroup: Record "Gen. Product Posting Group"; var IsHandled: Boolean)

    var
        GenProdPostingGrp: Record "Gen. Product Posting Group";
    begin
        SalesLine.TestJobPlanningLine();
        SalesLine.TestStatusOpen();
        if xSalesLine."Gen. Prod. Posting Group" <> SalesLine."Gen. Prod. Posting Group" then
                                                                  //DEVIS
                                                                  BEGIN
            IF (SalesLine."Structure Line No." <> 0) AND (SalesLine."Quantity per" <> 0) THEN
                SalesLine.VALIDATE("Quantity per");
            IF (SalesLine."Structure Line No." = 0) AND (SalesLine.Quantity <> 0) THEN
                SalesLine.VALIDATE(Quantity);
            //DEVIS//
            if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, SalesLine."Gen. Prod. Posting Group") then
                SalesLine.Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            //DEVIS
        END;
        //DEVIS//

        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateVATProdPostingGroupOnBeforeUpdateAmounts', '', true, true)]
    local procedure OnValidateVATProdPostingGroupOnBeforeUpdateAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; Currency: Record Currency)
    begin

        if SalesHeader."Prices Including VAT" and (SalesLine.Type in [SalesLine.Type::Item, SalesLine.Type::Resource]) then
            SalesLine.Validate("Unit Price",
                Round(
                    SalesLine."Unit Price" * (100 + SalesLine."VAT %") / (100 + xSalesLine."VAT %"),
              //#5923     Currency."Unit-Amount Rounding Precision"));
              Currency."Sales Unit-Amt Round. Prec."));
        //#5923//



        //#6332
        SalesLine."Prepayment VAT %" := SalesLine."VAT %";
        SalesLine."Prepmt. VAT Calc. Type" := SalesLine."VAT Calculation Type";
        SalesLine."Prepayment VAT Identifier" := SalesLine."VAT Identifier";
        //#6332//
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateLineAmount', '', true, true)]
    local procedure OnBeforeValidateLineAmount(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean; Currency: Record Currency)
    var
        wOverhead: Codeunit "Overhead Calculation";
        SalesHeader: Record "Sales Header";
        MaxLineAmount: Decimal;

    begin


        SalesLine.TestField(Type);
        SalesLine.TestField(Quantity);



        //  TestField("Unit Price");

        SalesLine.GetSalesHeader();
        //AVANCEMENT
        IF (SalesLine."Line Amount" <> xSalesLine."Line Amount") THEN
            SalesLine.wTestInvoicedQty(SalesLine.FIELDNO("Line Amount"));
        //AVANCEMENT//
        SalesLine."Line Amount" := Round(SalesLine."Line Amount", Currency."Amount Rounding Precision");
        MaxLineAmount := Round(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision");
        SalesLine.CheckLineAmount2(MaxLineAmount);// GL 2024 Procédure spécifique car la procédure standard est locale

        //DEVIS 
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
            IF (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") AND (CurrentFieldNo = SalesLine.FIELDNO("Line Amount")) THEN BEGIN
                SalesLine."Fixed Price" := TRUE;
                IF SalesLine."Profit %" <> 0 THEN
                    SalesLine.VALIDATE("Profit %", 0);
                IF SalesLine.Quantity <> 0 THEN
                    SalesLine.VALIDATE("Unit Price", SalesLine."Line Amount" / SalesLine.Quantity);
                SalesLine.VALIDATE("Line Discount Amount", 0);
                SalesLine."Inv. Discount Amount" := 0;
                SalesLine."Global Disc. Amount" := 0;
                //#5133
                IF CurrentFieldNo = SalesLine.FIELDNO("Line Amount") THEN BEGIN
                    wOverhead.SalesLine(SalesLine, FALSE, TRUE);
                END;
                //#5133//
            END ELSE BEGIN
                //DEVIS//
                SalesLine.Validate("Line Discount Amount", MaxLineAmount - SalesLine."Line Amount");
                //DEVIS
            END;
        end;
        SalesLine.wUpdateLine(SalesLine, xSalesLine, FALSE);
        //DEVIS//



        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidatePrepaymentPercentageOnBeforeUpdatePrepmtSetupFields', '', true, true)]
    local procedure OnValidatePrepaymentPercentageOnBeforeUpdatePrepmtSetupFields(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidatePrepmtLineAmount', '', true, true)]
    local procedure OnBeforeValidatePrepmtLineAmount(var SalesLine: Record "Sales Line"; PrePaymentLineAmountEntered: Boolean; var IsHandled: Boolean; FieldNo: Integer)
    begin

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemUOM', '', true, true)]
    local procedure OnAfterAssignItemUOM(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    var
        lCurrFieldNo: Integer;
    begin
        lCurrFieldNo := CurrentFieldNo;



        //+ONE+
        CurrentFieldNo := lCurrFieldNo;
        //+ONE+//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignResourceUOM', '', true, true)]
    local procedure OnAfterAssignResourceUOM(var SalesLine: Record "Sales Line"; Resource: Record Resource; ResourceUOM: Record "Resource Unit of Measure")
    begin

        //#4203
        IF SalesLine."Fixed Price" AND (SalesLine."Qty. per Unit of Measure" <> ResourceUOM."Qty. per Unit of Measure") THEN
            SalesLine.TESTFIELD("Fixed Price", FALSE);
        //#4203//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateQuantityFromUOMCode', '', true, true)]
    local procedure OnBeforeUpdateQuantityFromUOMCode(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterSetReserveWithoutPurchasingCode', '', true, true)]

    local procedure OnAfterSetReserveWithoutPurchasingCode(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; Item: Record Item)
    begin
        IF SalesLine."Structure Line No." <> 0 THEN
            SalesLine.Reserve := SalesLine.Reserve::Never;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateQuantityBase', '', true, true)]
    local procedure OnBeforeValidateQuantityBase(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //HS new Event
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitOutstandingAmount', '', true, true)]

    local procedure OnBeforeInitOutstandingAmountV2(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        if SalesLine.IsCreditDocType() then begin
            SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Return Qty. Received";
            //QTYBASE
            //   SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Return Qty. Received (Base)";
            SalesLine."Outstanding Qty. (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity, '', '') - SalesLine."Return Qty. Received (Base)";
            //QTYBASE//
            SalesLine."Return Qty. Rcd. Not Invd." := SalesLine."Return Qty. Received" - SalesLine."Quantity Invoiced";
            SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := SalesLine."Return Qty. Received (Base)" - SalesLine."Qty. Invoiced (Base)";
        end else begin
            //DEVIS
            IF NOT SalesLine."Completely Shipped" THEN BEGIN
                //DEVIS//
                SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
                //QTYBASE
                // SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
                SalesLine."Outstanding Qty. (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity, '', '') - SalesLine."Qty. Shipped (Base)";
                //QTYBASE
                //DEVIS
            END
            ELSE BEGIN
                SalesLine."Outstanding Quantity" := 0;
                SalesLine."Outstanding Qty. (Base)" := 0;
            END;
            //DEVIS//
            SalesLine."Qty. Shipped Not Invoiced" := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
            SalesLine."Qty. Shipped Not Invd. (Base)" := SalesLine."Qty. Shipped (Base)" - SalesLine."Qty. Invoiced (Base)";
        end;


        //SOLDE_CDE (#5357)
        SalesLine."Completely Invoiced" := (SalesLine.Quantity <> 0) AND (SalesLine."Quantity Invoiced" = SalesLine.Quantity);
        //SOLDE_CDE//
    end;
    //HS new Event
    //HS 
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInitOutstandingQty', '', true, true)]
    // local procedure OnAfterInitOutstandingQty(var SalesLine: Record "Sales Line")
    // begin
    //     if SalesLine.IsCreditDocType() then begin
    //         SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Return Qty. Received";
    //         //QTYBASE
    //         //   SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Return Qty. Received (Base)";
    //         SalesLine."Outstanding Qty. (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity, '', '') - SalesLine."Return Qty. Received (Base)";
    //         //QTYBASE//
    //         SalesLine."Return Qty. Rcd. Not Invd." := SalesLine."Return Qty. Received" - SalesLine."Quantity Invoiced";
    //         SalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := SalesLine."Return Qty. Received (Base)" - SalesLine."Qty. Invoiced (Base)";
    //     end else begin
    //         //DEVIS
    //         IF NOT SalesLine."Completely Shipped" THEN BEGIN
    //             //DEVIS//
    //             SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
    //             //QTYBASE
    //             // SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
    //             SalesLine."Outstanding Qty. (Base)" := SalesLine.CalcBaseQty(SalesLine.Quantity, '', '') - SalesLine."Qty. Shipped (Base)";
    //             //QTYBASE
    //             //DEVIS
    //         END
    //         ELSE BEGIN
    //             SalesLine."Outstanding Quantity" := 0;
    //             SalesLine."Outstanding Qty. (Base)" := 0;
    //         END;
    //         //DEVIS//
    //         SalesLine."Qty. Shipped Not Invoiced" := SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced";
    //         SalesLine."Qty. Shipped Not Invd. (Base)" := SalesLine."Qty. Shipped (Base)" - SalesLine."Qty. Invoiced (Base)";
    //     end;


    //     //SOLDE_CDE (#5357)
    //     SalesLine."Completely Invoiced" := (SalesLine.Quantity <> 0) AND (SalesLine."Quantity Invoiced" = SalesLine.Quantity);
    //     //SOLDE_CDE//
    // end;
    //HS 
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdatePlanned', '', true, true)]
    local procedure OnBeforeUpdatePlanned(var SalesLine: Record "Sales Line"; var Result: Boolean; var IsHandled: Boolean)
    begin
        //PERF
        IF (SalesLine.Quantity <> 0) AND (SalesLine.Reserve <> SalesLine.Reserve::Never) AND (SalesLine."Structure Line No." = 0) THEN
            //PERF//
            SalesLine.CalcFields("Reserved Quantity");

        SalesLine.TestField("Qty. per Unit of Measure");

        if SalesLine.Planned = (SalesLine."Reserved Quantity" = SalesLine."Outstanding Quantity") then
            Result := false;
        SalesLine.Planned := not SalesLine.Planned;
        Result := true;

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitOutstandingAmount', '', true, true)]
    local procedure OnBeforeInitOutstandingAmount(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        AmountInclVAT: Decimal;
        Currency: Record Currency;
        SalesHeader: Record "Sales Header";

    begin
        //DEVIS-TTC
        if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then;
        IF SalesHeader."Prices Including VAT" THEN
            IsHandled := true;

        //PERF


        if IsHandled = false then begin



            IF (SalesLine."Structure Line No." <> 0) AND (SalesLine.Subcontracting = 0) THEN
                EXIT;
            //PERF//
            if SalesLine.Quantity = 0 then begin
                SalesLine."Outstanding Amount" := 0;
                SalesLine."Outstanding Amount (LCY)" := 0;
                SalesLine."Shipped Not Invoiced" := 0;
                SalesLine."Shipped Not Invoiced (LCY)" := 0;
                SalesLine."Return Rcd. Not Invd." := 0;
                SalesLine."Return Rcd. Not Invd. (LCY)" := 0;
                //CDE_INTERNE
                SalesLine."Outstanding Amt Excl VAT(LCY)" := 0;
                SalesLine."Amount Excl. VAT (LCY)" := 0;
                //CDE_INTERNE//
            end else begin
                SalesLine.GetSalesHeader();
                AmountInclVAT := SalesLine."Amount Including VAT";
                SalesLine.Validate(
                  "Outstanding Amount",
                  Round(
                    AmountInclVAT * SalesLine."Outstanding Quantity" / SalesLine.Quantity,
                    Currency."Amount Rounding Precision"));
                //CDE_INTERNE
                SalesLine.VALIDATE(
                  "Outstanding Amt Excl VAT(LCY)",
                  ROUND(
                    SalesLine."Unit Cost (LCY)" * SalesLine."Outstanding Quantity",
                    Currency."Amount Rounding Precision"));
                //CDE_INTERNE//
                //DEVIS
                SalesLine.VALIDATE("Amount Excl. VAT (LCY)");
                //DEVIS//
                if SalesLine.IsCreditDocType() then
                    SalesLine.Validate(
                      "Return Rcd. Not Invd.",
                      Round(
                        AmountInclVAT * SalesLine."Return Qty. Rcd. Not Invd." / SalesLine.Quantity,
                              Currency."Amount Rounding Precision"))
                else
                    SalesLine.Validate(
                      "Shipped Not Invoiced",
                      Round(
                        AmountInclVAT * SalesLine."Qty. Shipped Not Invoiced" / SalesLine.Quantity,
                        Currency."Amount Rounding Precision"));
            end;

            IsHandled := true;
        end;
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitQtyToShip', '', true, true)]
    local procedure OnBeforeInitQtyToShip(var SalesLine: Record "Sales Line"; FieldNo: Integer; var IsHandled: Boolean)
    begin



        //DEVIS
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            IsHandled := true;
        //DEVIS//


        /////////////////////////////////////////////

        //PERF
        IF (SalesLine."Structure Line No." <> 0) AND (SalesLine.Subcontracting = 0) THEN
            IsHandled := true;
        //PERF//
        //CDE_INTERNE
        IF (SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order") And (FieldNo <> SalesLine.FIELDNO("Qty. to Ship")) THEN BEGIN
            //CDE_INTERNE//
            //CDE_INTERNE

            SalesLine."Qty. to Ship" := 0;
            SalesLine."Qty. to Ship (Base)" := 0;
            SalesLine."Qty. to Invoice" := 0;
            SalesLine."Qty. to Invoice (Base)" := 0;

            IsHandled := true;
        END;
        //CDE_INTERNE//

    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInitQtyToReceive', '', true, true)]
    local procedure OnBeforeInitQtyToReceive(var SalesLine: Record "Sales Line"; FieldNo: Integer; var IsHandled: Boolean)
    begin
        //PERF
        IF (SalesLine."Structure Line No." <> 0) AND (SalesLine.Subcontracting = 0) THEN
            IsHandled := true;
        //PERF//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCalcInvDiscToInvoice', '', true, true)]
    local procedure OnBeforeCalcInvDiscToInvoice(var SalesLine: Record "Sales Line"; CallingFieldNo: Integer)
    begin
        //PERF
        IF (SalesLine."Structure Line No." <> 0) AND (SalesLine.Subcontracting = 0) THEN
            EXIT;
        //PERF//
    end;






    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeSetSalesHeader', '', true, true)]
    local procedure OnBeforeSetSalesHeader(SalesHeader: record "Sales Header");
    var

        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //+ONE+
        lSingleInstance.wSetSalesHeader(SalesHeader);
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnFindResUnitCostOnAfterInitResCost', '', true, true)]
    local procedure OnFindResUnitCostOnAfterInitResCost(var SalesLine: Record "Sales Line"; var ResourceCost: Record "Resource Cost")
    var
        lTotalNeedParameter: Record "Sales Document Cost";
        SalesHeader: Record "Sales Header";

    begin

        //PROJET_FG
        IF lTotalNeedParameter.GET(SalesLine."Document Type", SalesLine."Document No.", lTotalNeedParameter.Type::Resource, SalesLine."No.", 0, SalesLine."Purchasing Code") AND
           ((lTotalNeedParameter.Value <> 0) OR (lTotalNeedParameter."Vendor No." = '') OR
            (lTotalNeedParameter."Purchasing Code" = '')) THEN BEGIN
            SalesLine.VALIDATE("Unit Cost (LCY)", lTotalNeedParameter.Value);
            EXIT;
        END;
        //PROJET_FG//



        //INTERIM
        SalesLine.GetSalesHeader;
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
            //DYS A VERIFIER
            // IF SalesLine."Document Type" IN [SalesLine."Document Type"::Invoice, SalesLine."Document Type"::"Credit Memo"] THEN
            //     ResourceCost."Starting Date" := SalesHeader."Posting Date"
            // ELSE
            //     ResourceCost."Starting Date" := SalesHeader."Order Date";
        END;
        //INTERIM//
    end;






    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterFindResUnitCost', '', true, true)]
    local procedure OnAfterFindResUnitCost(var SalesLine: Record "Sales Line"; var ResourceCost: Record "Resource Cost")
    begin
        //DEVIS
        IF (ResourceCost."Unit Cost" <> 0) AND (ResourceCost.Code = SalesLine."No.") AND
           (SalesLine."Unit Cost (LCY)" <> ResourceCost."Unit Cost" * SalesLine."Qty. per Unit of Measure") THEN
            //DEVIS//
            SalesLine.VALIDATE("Unit Cost (LCY)", ResourceCost."Unit Cost" * SalesLine."Qty. per Unit of Measure");
    end;




    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateAmounts', '', true, true)]
    local procedure OnBeforeUpdateAmounts(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF SalesLine."Structure Line No." <> 0 THEN
            //  EXIT;
            //hs
            IsHandled := true;

    end;
    //HS
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmounts', '', true, true)]

    local procedure OnAfterUpdateAmounts(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        lQty: Decimal;
        lxRec: Record "Sales Line";
        lSalesLineProcess: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin

            //DEVIS
            IF (SalesLine."Line Type" <> SalesLine."Line Type"::Totaling) AND
               (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") THEN BEGIN
                //#4957
                //#7583
                IF (SalesLine."Line Type" = SalesLine."Line Type"::Structure) OR (SalesLine."Structure Line No." <> 0) THEN
                    //  IF ("Structure Line No." <> 0) THEN
                    //#7583//
                    //  IF ("Line Type" = "Line Type"::Structure)  THEN
                    //#4957//
                    lQty := SalesLine."Quantity (Base)"
                ELSE
                    lQty := SalesLine.Quantity;
                IF lQty <> 0 THEN
                    SalesLine."Total Cost (LCY)" := SalesLine."Unit Cost (LCY)" * lQty
                ELSE
                    //#7144
                    //    "Total Cost (LCY)" := "Unit Cost (LCY)";
                    SalesLine."Total Cost (LCY)" := 0;
                //#7144//
                IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
                    SalesLine.wCalcAmount(SalesLine);

            END;
        end;

        SalesLine."Amount Excl. VAT (LCY)" := 0;
        SalesLine.VALIDATE("Amount Excl. VAT (LCY)");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateAmountsOnAfterCalcLineAmount', '', true, true)]
    local procedure OnUpdateAmountsOnAfterCalcLineAmount(var SalesLine: Record "Sales Line"; var LineAmount: Decimal)
    VAR
        lQty: Decimal;
        lxRec: Record "Sales Line";
        lSalesLineProcess: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        //HS
        /* if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin

             //DEVIS
             IF (SalesLine."Line Type" <> SalesLine."Line Type"::Totaling) AND
                (SalesHeader."Order Type" <> SalesHeader."Order Type"::"Supply Order") THEN BEGIN
                 //#4957
                 //#7583
                 IF (SalesLine."Line Type" = SalesLine."Line Type"::Structure) OR (SalesLine."Structure Line No." <> 0) THEN
                     //  IF ("Structure Line No." <> 0) THEN
                     //#7583//
                     //  IF ("Line Type" = "Line Type"::Structure)  THEN
                     //#4957//
                     lQty := SalesLine."Quantity (Base)"
                 ELSE
                     lQty := SalesLine.Quantity;
                 IF lQty <> 0 THEN
                     SalesLine."Total Cost (LCY)" := SalesLine."Unit Cost (LCY)" * lQty
                 ELSE
                     //#7144
                     //    "Total Cost (LCY)" := "Unit Cost (LCY)";
                     SalesLine."Total Cost (LCY)" := 0;
                 //#7144//
                 IF SalesLine."Line Type" <> SalesLine."Line Type"::Structure THEN
                     SalesLine.wCalcAmount(SalesLine);

             END;
         end;

         SalesLine."Amount Excl. VAT (LCY)" := 0;
         SalesLine.VALIDATE("Amount Excl. VAT (LCY)");

         //DEVIS//*/
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckPrepmtAmounts', '', true, true)]

    local procedure OnBeforeCheckPrepmtAmounts37(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CurrFieldNo: Integer; SalesHeader: Record "Sales Header")
    var
        Text047: Label 'must be positive when %1 is not 0.';
        Currency: Record Currency;
    begin
        //DEVIS//

        //+ONE+PREPAYMENT
        //#7811 IF Type <> Type::Resource THEN

        IF NOT (SalesLine.Type IN [SalesLine.Type::"G/L Account", SalesLine.Type::Item, SalesLine.Type::Resource]) THEN
            //#7811//
            //+ONE+PREPAYMENT//
            IF SalesLine."Prepayment %" <> 0 THEN BEGIN
                IF SalesLine.Quantity < 0 THEN
                    SalesLine.FIELDERROR(Quantity, STRSUBSTNO(Text047, SalesLine.FIELDCAPTION("Prepayment %")));
                IF SalesLine."Unit Price" < 0 THEN
                    SalesLine.FIELDERROR("Unit Price", STRSUBSTNO(Text047, SalesLine.FIELDCAPTION("Prepayment %")));
            END;
        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice THEN BEGIN
            SalesLine."Prepayment VAT Difference" := 0;
            if Currency.get(SalesHeader."Currency Code") then;
            IF SalesLine."Quantity Invoiced" = 0 THEN BEGIN
                SalesLine."Prepmt. Line Amount" := ROUND(SalesLine."Line Amount" * SalesLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
                //#5773
                /* {DELETE
                         IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
                               FIELDERROR("Prepmt. Line Amount", STRSUBSTNO(Text049, "Prepmt. Amt. Inv."));
                           DELETE}*/
                //#5773//
            END ELSE BEGIN
                //#8015
                //Delete
                //    IF "Prepayment %" <> 0 THEN
                //      "Prepmt. Line Amount" := "Prepmt. Amt. Inv." +
                //        ROUND("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity * "Prepayment %" / 100,
                //          Currency."Amount Rounding Precision")
                //    ELSE
                //#8015//
                SalesLine."Prepmt. Line Amount" := ROUND(SalesLine."Line Amount" * SalesLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
                //#8336
                /* {DELETE
                 IF "Prepmt. Line Amount" > "Line Amount" THEN
                   FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text049,"Prepmt. Line Amount"));
                 DELETE}*/
                //#8336//
            END;
        END;


        IsHandled := true;




    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateAmountOnBeforeCheckCreditLimit', '', true, true)]
    local procedure OnUpdateAmountOnBeforeCheckCreditLimit(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CurrentFieldNo: Integer)
    var
        gCreditAlreadyCheck: Boolean;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";


    begin

        IF NOT gCreditAlreadyCheck THEN
            CustCheckCreditLimit.SalesLineCheck(SalesLine);
        gCreditAlreadyCheck := TRUE;



        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmountsDone', '', true, true)]
    local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        lSalesLineProcess: Record "Sales Line";
        wOverhead: Codeunit "Overhead Calculation";

    begin

        //#6103
        IF CurrentFieldNo = SalesLine.FIELDNO("Unit Price") THEN BEGIN
            //#8428
            lSalesLineProcess := SalesLine;
            //wOverhead.SalesLine(Rec,FALSE,TRUE);
            wOverhead.SalesLine(lSalesLineProcess, FALSE, TRUE);
            SalesLine := lSalesLineProcess;
            //#8428//
        END;
        //#6103//
    end;





    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateVariantCodeOnAfterChecks', '', true, true)]

    local procedure OnValidateVariantCodeOnAfterChecks(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer)
    begin
        //DISC
        IF SalesLine.Type = SalesLine.Type::Resource THEN
            SalesLine.PlanPriceCalcByField((SalesLine.FIELDNO("Variant Code")));
        //DISC//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCheckItemAvailableOnBeforeSalesLineCheck', '', true, true)]
    local procedure OnCheckItemAvailableOnBeforeSalesLineCheck(var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        ItemCheckAvail: Codeunit "Item-Check Avail.";

    begin
        ItemCheckAvail.SalesLineCheck(SalesLine);

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeAutoReserve', '', true, true)]
    local procedure OnBeforeAutoReserve(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; FullAutoReservation: Boolean; var ReserveSalesLine: Codeunit "Sales Line-Reserve")
    begin
        //+ONE+
        IF SalesLine."Structure Line No." <> 0 THEN
            EXIT;
        //+ONE+//
    end;


    /*GL2024  //GL2024 Paramètre event ne pas dans sales line
      [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeGetDate', '', true, true)]
      local procedure OnBeforeGetDate(var ResultDate: Date; var IsHandled: Boolean)
      var
          SalesHeader: Record "Sales Header";
          SalesLine: Record "Sales Line";
          wSingleInstance: Codeunit "Import SingleInstance2";


      begin
          if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
              //+ONE+
              IF SalesHeader."No." = '' THEN
                  wSingleInstance.wGetSalesHeader(SalesHeader, SalesLine."Document Type", SalesLine."Document No.");
              //+ONE+//
              //+ABO+
              IF SalesLine."Document Type" = SalesLine."Document Type"::Subscription THEN
                  ResultDate := WORKDATE;
              //+ABO+//
          end;
      end;*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCreateDim', '', true, true)]
    local procedure OnBeforeCreateDim37(var IsHandled: Boolean; var SalesLine: Record "Sales Line"; FieldNo: Integer; DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    begin
        //+ONE+
        IF (SalesLine.Type = SalesLine.Type::" ") OR (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //+ONE+
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterGetFAPostingGroup', '', true, true)]
    local procedure OnAfterGetFAPostingGroup(var SalesLine: Record "Sales Line"; GLAccount: Record "G/L Account")
    var
        FASetup: Record "FA Setup";
    begin
        FASetup.Get();
        //+REF+IMMOS
        SalesLine."Use Duplication List" := FASetup."Activate Duplication List";
        //+REF+IMMOS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterGetSKU', '', true, true)]
    local procedure OnAfterGetSKU(SalesLine: Record "Sales Line"; var Result: Boolean; var StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        //PERF
        IF (SalesLine."Structure Line No." <> 0) THEN
            Result := false;

        //PERF//
    end;
    //hs todo
    /*  [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeGetUnitCost', '', true, true)]
      local procedure OnBeforeGetUnitCost(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CurrFieldNo: Integer)
      begin
          if CurrFieldNo = SalesLine.FieldNo("No.") then begin
              case SalesLine.Type of
                  SalesLine.Type::Item:
                      IF SalesLine.Subcontracting = 0 THEN
                          //+ONE+//
                          IsHandled := true;
              end;
          end;

          // >> HJ SORO 06-06-2014
          IF SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order" THEN IsHandled := true;
          // >> HJ SORO 06-06-2014
      end;*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateUnitCostLCYOnGetUnitCost', '', true, true)]
    local procedure OnBeforeValidateUnitCostLCYOnGetUnitCost(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    VAR
        lTotalNeedParameter: Record "Sales Document Cost";
        lSubCost: Decimal;
        lCostExist: Boolean;
        SKU: Record "Stockkeeping Unit";
        Item: record item;


    begin

        //PROJET_FG
        lCostExist := lTotalNeedParameter.GET(SalesLine."Document Type", SalesLine."Document No.", lTotalNeedParameter.Type::Item, SalesLine."No.", 0, SalesLine."Purchasing Code") AND
           ((lTotalNeedParameter.Value <> 0) OR (lTotalNeedParameter."Vendor No." = '') OR
           (lTotalNeedParameter."Purchasing Code" = ''));
        IF lCostExist THEN BEGIN
            SalesLine.VALIDATE("Unit Cost (LCY)", lTotalNeedParameter.Value * SalesLine."Qty. per Unit of Measure");
            IF (lTotalNeedParameter."Purchasing Code" <> '') AND (SalesLine."Purchasing Code" = '') THEN
                SalesLine.VALIDATE("Purchasing Code", lTotalNeedParameter."Purchasing Code");
            EXIT;
        END;
        //PROJET_FG//


        IF SalesLine.GetSKU THEN
          //DEVIS
          BEGIN
            //GL2024 Filtre
            if SKU.get(SalesLine."Location Code", SalesLine."No.", SalesLine."Variant Code") then begin
                IF SKU."Standard Cost" <> 0 THEN
                    SKU."Unit Cost" := SKU."Standard Cost";
                //DEVIS//
                SalesLine.VALIDATE("Unit Cost (LCY)", SKU."Unit Cost" * SalesLine."Qty. per Unit of Measure");
                //CDE_INTERNE
                IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
                    IF (SKU."Purchasing Code" <> '') AND (SalesLine."Purchasing Code" = '') THEN
                        SalesLine.VALIDATE("Purchasing Code", SKU."Purchasing Code");
            end;
            //CDE_INTERNE//
        END ELSE BEGIN
            //GL2024 
            if Item.get(SalesLine."No.") then begin
                //DEVIS
                IF Item."Standard Cost" <> 0 THEN
                    Item."Unit Cost" := Item."Standard Cost";
                //DEVIS//

                //#7434
                IF (Item."Unit Cost" = 0) AND (Item."Public Price" <> 0) THEN
                    Item."Unit Cost" := Item."Public Price";
                //#7434//

                //SUBCONTRACTOR
                IF SalesLine.Subcontracting <> SalesLine.Subcontracting::" " THEN BEGIN
                    lSubCost := SalesLine.wFindSubCost(SalesLine, '');
                    IF lSubCost <> Item."Unit Cost" THEN
                        Item."Unit Cost" := lSubCost;
                END;
                //SUBCONTRACTOR//
                SalesLine.VALIDATE("Unit Cost (LCY)", Item."Unit Cost" * SalesLine."Qty. per Unit of Measure");
            END;
        end;
        //GL2024 
        if Item.get(SalesLine."No.") then begin
            //CDE_INTERNE
            IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
                IF (Item."Purchasing Code" <> '') AND (SalesLine."Purchasing Code" = '') THEN
                    SalesLine.VALIDATE("Purchasing Code", Item."Purchasing Code");
            IF SalesLine."Order Type" = SalesLine."Order Type"::"Supply Order" THEN
                SalesLine."Unit Cost (LCY)" := SalesLine.wGetDirectCost;
            //CDE_INTERNE//
        end;

        //PROJET_FG
        IF lTotalNeedParameter.GET(SalesLine."Document Type", SalesLine."Document No.", lTotalNeedParameter.Type::Item, SalesLine."No.", 0, SalesLine."Purchasing Code") AND
           ((lTotalNeedParameter.Value <> 0) OR (lTotalNeedParameter."Vendor No." = '') OR
           (lTotalNeedParameter."Purchasing Code" = '')) THEN
            SalesLine.VALIDATE("Unit Cost (LCY)", lTotalNeedParameter.Value * SalesLine."Qty. per Unit of Measure");
        //PROJET_FG//


        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnShowItemChargeAssgntOnAfterCurrencyInitialize', '', true, true)]
    local procedure OnShowItemChargeAssgntOnAfterCurrencyInitialize(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var Currency: Record Currency)
    begin
        //+ONE+
        IF (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateItemChargeAssgnt', '', true, true)]
    local procedure OnBeforeUpdateItemChargeAssgnt(var SalesLine: Record "Sales Line"; var InHandled: Boolean);
    begin
        //+ONE+
        IF (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteItemChargeAssignment', '', true, true)]
    local procedure OnAfterDeleteItemChargeAssignment(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; DocType: Enum "Sales Document Type"; DocNo: Code[20];
                                                                                                                                                                 DocLineNo: Integer)
    begin
        //+ONE+
        IF (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeDeleteChargeChargeAssgnt', '', true, true)]
    local procedure OnBeforeDeleteChargeChargeAssgnt(SalesDocumentType: Enum "Sales Document Type"; DocNo: Code[20];
                                                                            DocLineNo: Integer; var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        //+ONE+
        IF (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //+ONE+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterHasTypeToFillMandatoryFields', '', true, true)]
    local procedure OnAfterHasTypeToFillMandatoryFields(var SalesLine: Record "Sales Line"; var ReturnValue: Boolean)
    begin
        ReturnValue := (SalesLine.Type <> SalesLine.Type::" ") OR (SalesLine."Document Type" = SalesLine."Document Type"::Subscription)
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterTestStatusOpen', '', true, true)]
    local procedure OnAfterTestStatusOpen(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    begin
        //+ABO+//
        //CDE_INTERNE

        IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
            EXIT;
        //CDE_INTERNE//
        //DEVIS
        //IF Type IN [Type::Item,Type::"Fixed Asset"] THEN
        /*GL2024     IF (SalesLine.Type IN [SalesLine.Type::" ", SalesLine.Type::Item, SalesLine.Type::"Fixed Asset", SalesLine.Type::Resource, SalesLine.Type::"Charge (Item)"])
               AND (SalesLine."Structure Line No." = 0)
                //PREPAYMENT
                AND (SalesLine."Line Type" <> SalesLine."Line Type"::Other) THEN*/
        //PREPAYMENT//
        //DEVIS//
        //MH //SalesHeader.TESTFIELD(Status,SalesHeader.Status::Open);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateVATOnLinesOnAfterSalesLineSetFilter', '', true, true)]
    local procedure OnUpdateVATOnLinesOnAfterSalesLineSetFilter(var SalesLine: Record "Sales Line")
    begin
        //GL2024 WITH SalesLine DO BEGIN
        //PERF
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.");
        //PERF//

        //DEVIS
        SalesLine.SETRANGE("Structure Line No.", 0);
        //DEVIS//
        //+ONE+
        SalesLine.SETRANGE("Line Type", SalesLine."Line Type"::Item, SalesLine."Line Type"::"Charge (Item)");
        SalesLine.SETRANGE(Option, FALSE);
        //+ONE+//
        // END;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateVATOnLinesOnBeforeCalculateAmounts', '', true, true)]
    local procedure OnUpdateVATOnLinesOnBeforeCalculateAmounts(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    VAR
        lxSalesLine: Record "Sales Line";
    begin
        //REMISE
        lxSalesLine := SalesLine;
        //REMISE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateVATOnLinesOnBeforeModifySalesLine', '', true, true)]
    local procedure OnUpdateVATOnLinesOnBeforeModifySalesLine(var SalesLine: Record "Sales Line"; VATAmount: Decimal)
    VAR
        lxSalesLine: Record "Sales Line";
    begin
        //REMISE
        lxSalesLine := SalesLine;
        //REMISE//
        //REMISE
        SalesLine.wUpdateLine(SalesLine, lxSalesLine, FALSE);
        //REMISE//
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateVATOnLines', '', true, true)]
    local procedure OnAfterUpdateVATOnLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var VATAmountLine: Record "VAT Amount Line"; QtyType: Option General,Invoicing,Shipping)
    begin
        //#7971
        //+ONE+
        SalesLine.SETRANGE("Line Type");
        SalesLine.SETRANGE(Option);
        //+ONE+//
        //#7971//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCalcVATAmountLinesOnAfterSetFilters', '', true, true)]
    local procedure OnCalcVATAmountLinesOnAfterSetFilters(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        //+ONE+
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.");
        //+ONE+//

        SalesLine.SETRANGE("Structure Line No.", 0);
        SalesLine.SETRANGE(Option, FALSE);
        SalesLine.SETRANGE(Disable, FALSE);
        //DEVIS//
        //#7693
        SalesLine.SETRANGE("Assignment Basis", SalesLine."Assignment Basis"::" ");
        //#7693//



    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCalcVATAmountLinesOnAfterCalcShouldProcessRounding', '', true, true)]
    local procedure OnCalcVATAmountLinesOnAfterCalcShouldProcessRounding(var VATAmountLine: Record "VAT Amount Line"; Currency: Record Currency; var IsHandled: Boolean; var SalesLine: Record "Sales Line"; var TotalVATAmount: Decimal)
    begin
        //DEVIS
        SalesLine.SETRANGE("Structure Line No.");
        SalesLine.SETRANGE("Line Type");
        SalesLine.SETRANGE(Option);
        //#7693
        SalesLine.SETRANGE("Assignment Basis");
        //#7693//
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeAutoAsmToOrder', '', true, true)]
    local procedure OnBeforeAutoAsmToOrder(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CurrentFieldNo: Integer; var ATOLink: Record "Assemble-to-Order Link")
    begin
        //DEVIS
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            IsHandled := true;
        //DEVIS//

    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateWithWarehouseShip', '', true, true)]
    local procedure OnBeforeUpdateWithWarehouseShip(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var

        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
    begin

        //DEVIS
        IF SalesLine."Document Type" = SalesLine."Document Type"::Quote THEN
            IsHandled := true;
        //DEVIS//

        //PERF
        IF SalesLine."Structure Line No." <> 0 THEN
            EXIT;
        //PERF//
        //PROJET_FACT
        SalesLine.GetSalesHeader;
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
            IF (SalesLine."Order Type" <> SalesLine."Order Type"::"Supply Order") AND
               (SalesHeader."Invoicing Method" <> SalesHeader."Invoicing Method"::Direct) THEN
                EXIT;
        end;
        //PROJET_FACT//

        //#6335
        IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
            //IF Type = Type::Item THEN
            SalesSetup.GET;
            IF SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Blank THEN BEGIN
                //#6335//
                CASE TRUE OF
                    (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity >= 0):
                        IF Location.RequireShipment(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Qty. to Ship", 0)
                        ELSE
                            SalesLine.VALIDATE("Qty. to Ship", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity < 0):
                        IF Location.RequireReceive(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Qty. to Ship", 0)
                        ELSE
                            SalesLine.VALIDATE("Qty. to Ship", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity >= 0):
                        IF Location.RequireReceive(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Return Qty. to Receive", 0)
                        ELSE
                            SalesLine.VALIDATE("Return Qty. to Receive", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity < 0):
                        IF Location.RequireShipment(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Return Qty. to Receive", 0)
                        ELSE
                            SalesLine.VALIDATE("Return Qty. to Receive", SalesLine."Outstanding Quantity");
                END;
                //#6335
            END ELSE BEGIN
                CASE TRUE OF
                    (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity >= 0):
                        IF NOT Location.RequireShipment(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Qty. to Ship", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity < 0):
                        IF NOT Location.RequireReceive(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Qty. to Ship", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity >= 0):
                        IF NOT Location.RequireReceive(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Return Qty. to Receive", SalesLine."Outstanding Quantity");
                    (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity < 0):
                        IF NOT Location.RequireShipment(SalesLine."Location Code") THEN
                            SalesLine.VALIDATE("Return Qty. to Receive", SalesLine."Outstanding Quantity");
                END;
            END;
            //#6335//
        END;
        SalesLine.SetDefaultQuantity();
        IsHandled := true;
    end;










    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdateDates', '', true, true)]
    local procedure OnBeforeUpdateDates(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; var PlannedShipmentDateCalculated: Boolean; var PlannedDeliveryDateCalculated: Boolean)
    begin
        //PERF
        IF (SalesLine."Structure Line No." <> 0) THEN
            EXIT;
        //PERF//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterGetItemTranslation', '', true, true)]
    local procedure OnAfterGetItemTranslation(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; ItemTranslation: Record "Item Translation")
    var
        Item: Record Item;
    begin
        //TRAD
        //GL2024
        if item.get(SalesLine."No.") then
            //GL2024
            SalesLine."Internal Description" := Item.Description;
        //TRAD//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', true, true)]

    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    begin
        //OUVRAGE
        IF SalesLine."Structure Line No." <> 0 THEN
            //OUVRAGE//

            SalesLine.Reserve := SalesLine.Reserve::Never;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeGetDefaultBin', '', true, true)]
    local procedure OnBeforeGetDefaultBin(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        //PERF IF Type <> Type::Item THEN
        IF (SalesLine.Type <> SalesLine.Type::Item) OR (SalesLine."Structure Line No." <> 0) THEN
            //PERF//
            IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckAssocPurchOrder', '', true, true)]
    local procedure OnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line"; TheFieldCaption: Text[250]; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    VAR
        lPurchLine: Record "Purchase Line";
    begin

        if TheFieldCaption = SalesLine.FieldCaption(Quantity) then
            //SUBCONTRACTOR
            IF (xSalesLine.Quantity = SalesLine.Quantity) AND (xSalesLine."Quantity (Base)" = SalesLine."Quantity (Base)") THEN BEGIN
                //SUBCONTRACTOR//
                IsHandled := true;
            end
            else
                SalesLine.CheckAssocPurchOrder(SalesLine.FIELDCAPTION("Quantity (Base)"));
        //SUBCONTRACTOR
        //#8877
        //IF ("Purchasing Order Line No." = 0) AND ("Special Order Purch. Line No." = 0) THEN
        IF (SalesLine."Purch. Order Line No." = 0) AND (SalesLine."Special Order Purch. Line No." = 0) THEN
            EXIT;
        //#8877//
        //#8877
        //IF ("Purchasing Order Line No." <> 0) THEN //PERF
        IF (SalesLine."Purchasing Order Line No." <> 0) AND SalesLine."Drop Shipment" THEN //PERF
                                                                                           //#8877//
            IF lPurchLine.GET(SalesLine."Purchasing Document Type", SalesLine."Purchasing Order No.", SalesLine."Purchasing Order Line No.") AND
         (SalesLine."Line No." <> lPurchLine."Sales Order Line No.") THEN
                EXIT;
        //SUBCONTRACTOR//




    end;



    //*************************************Table 38************************************************//
    //Pour page 509
    //ERREUR action Statistique facture achat
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOpenDocumentStatistics', '', true, true)]
    // local procedure OnBeforeOpenDocumentStatistics38(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    // var

    //     PurchSetup: Record "Purchases & Payables Setup";
    // begin
    //     PurchSetup.GET;
    //     IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
    //         PurchaseHeader.PrepareOpeningDocumentStatistics();
    //     end;
    //     PurchaseHeader.ShowDocumentStatisticsPage();
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnInitInsertOnBeforeInitRecord', '', true, true)]
    local procedure OnInitInsertOnBeforeInitRecord(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header")
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CduFunction: Codeunit SoroubatFucntion;
    begin


        IF PurchaseHeader."No." = '' THEN BEGIN
            CduFunction.fSetRespCenter(PurchaseHeader."Responsibility Center");
        END;
        //AGENCE//
        //+REF+USERID
        PurchaseHeader."User ID" := USERID;
        PurchaseHeader.Utilisateur := UPPERCASE(USERID);
        //+REF+USERID//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', true, true)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    var
        UserSetupMgt: Codeunit "User Setup Management";
    begin
        PurchaseHeader."Responsibility Center" := xPurchaseHeader."Responsibility Center";
        //AGENCE
        IF PurchaseHeader."Responsibility Center" = '' THEN
            //AGENCE//
            PurchaseHeader."Responsibility Center" := UserSetupMgt.GetRespCenter(1, Vendor."Responsibility Center");

    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterSetBuyFromVendorFromFilter', '', true, true)]
    local procedure OnAfterSetBuyFromVendorFromFilter(var PurchaseHeader: Record "Purchase Header")
    begin
        //#6695
        IF PurchaseHeader.GETFILTER("Job No.") <> '' THEN
            PurchaseHeader.VALIDATE("Job No.", PurchaseHeader.GETFILTER("Job No."));
        //#6695//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorAddressFieldsFromVendor', '', true, true)]
    local procedure OnAfterCopyBuyFromVendorAddressFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; BuyFromVendor: Record Vendor)
    begin
        PurchaseHeader."Buy-from Address" := COPYSTR(BuyFromVendor.Address, 1, 50);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEmptySellToCustomerAndLocation', '', true, true)]
    local procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        //+OFF+REMISE
        PurchaseHeader."Vendor Disc. Group" := Vendor."Vendor Disc. Group";
        IF PurchaseHeader."Attached to Doc. No." = '' THEN
            //+OFF+REMISE//
            PurchaseHeader.Validate("Sell-to Customer No.", '');

        if PurchaseHeader."Buy-from Vendor No." <> '' then
            PurchaseHeader.GetVend(PurchaseHeader."Buy-from Vendor No.");

        //VALIDATE("Location Code",UserMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        //REMISE_FOURN
        PurchaseHeader."Vendor Disc. Group" := Vendor."Vendor Disc. Group";
        //REMISE_FOURN//

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoBeforeRecreateLines', '', true, true)]
    local procedure OnValidateBuyFromVendorNoBeforeRecreateLines(var PurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var Vendor: Record Vendor)
    var
        OrderAddr: Record "Order Address";

    begin
        //+REF+ALT_ADDRESS
        //VALIDATE("Order Address Code");
        IF CallingFieldNo <> 0 THEN BEGIN
            OrderAddr.RESET;
            OrderAddr.SETRANGE("Vendor No.", PurchaseHeader."Buy-from Vendor No.");
            IF NOT OrderAddr.ISEMPTY THEN BEGIN
                COMMIT;  //OBLIGATOIRE POUR EVITER UN GROS MESSAGE D'ERREUR
                IF page.RUNMODAL(0, OrderAddr) = ACTION::LookupOK THEN
                    PurchaseHeader.VALIDATE("Order Address Code", OrderAddr.Code);
            END;
        END;
        //+REF+ALT_ADDRESS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterRecreateLines', '', true, true)]
    local procedure OnValidateBuyFromVendorNoOnAfterRecreateLines(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer)
    var
        lDescriptionLine: Record "Description Line";

    begin
        //ACHATS
        lDescriptionLine.DeleteLines(DATABASE::"Purchase Header", PurchaseHeader."Document Type", PurchaseHeader."No.", 0);
        lDescriptionLine.CopyLines(
          DATABASE::Vendor, 0, PurchaseHeader."Buy-from Vendor No.", 0,
          DATABASE::"Purchase Header", PurchaseHeader."Document Type", PurchaseHeader."No.", 0);
        PurchaseHeader."Buy-from Contact No." := '';
        //ACHATS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', true, true)]
    local procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    var
        RecLVendorPostingGroup: Record "Vendor Posting Group";
    begin
        //>>HJ SORO 16-10-2014
        IF RecLVendorPostingGroup.GET(PurchaseHeader."Vendor Posting Group") THEN BEGIN
            IF PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order THEN
                PurchaseHeader."Apply Stamp fiscal" := RecLVendorPostingGroup."Apply Stamp fiscal";
            PurchaseHeader."Appliquer Fodec" := RecLVendorPostingGroup."Apply Fodec";
        END;
        //>>HJ SORO 16-10-2014
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyPayToVendorFieldsFromVendor', '', true, true)]
    local procedure OnAfterCopyPayToVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."Payment Terms Code" := xPurchaseHeader."Payment Terms Code";

        IF PurchaseHeader."Payment Terms Code" = '' THEN
            PurchaseHeader."Payment Terms Code" := Vendor."Payment Terms Code";

        //SHIP_TO_ADDRESS
        PurchaseHeader."Shipment Method to" := Vendor."Shipment Method to";
        //SHIP_TO_ADDRESS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePurchaseHeaderPayToVendorNo', '', true, true)]
    procedure OnValidatePurchaseHeaderPayToVendorNo(Vendor: Record Vendor; var PurchaseHeader: Record "Purchase Header")
    begin
        IF PurchaseHeader."Purchaser Code" = '' THEN
            PurchaseHeader."Purchaser Code" := Vendor."Purchaser Code";
    end;



    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitDefaultDimensionSources', '', true, true)]
    local procedure OnAfterInitDefaultDimensionSources38(var PurchaseHeader: Record "Purchase Header"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    var
        DimMgt: Codeunit DimensionManagement;
    begin

        DimMgt.AddDimSource(DefaultDimSource, Database::Job, PurchaseHeader."Job No.", FieldNo = PurchaseHeader.FieldNo("Job No."));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePayToVendorNoOnBeforeRecallModifyAddressNotification', '', true, true)]
    local procedure OnValidatePayToVendorNoOnBeforeRecallModifyAddressNotification(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)

    var
        lPaymentMgt: Codeunit "Payment Management1";
        GLSetup: Record "General Ledger Setup";

    begin
        //+CH+2300
        GLSetup.GET;
        IF GLSetup.Localization = GLSetup.Localization::CH THEN
            PurchaseHeader."Bank Code" := lPaymentMgt.GetVendDefBankCode(Vendor."No."); // CH2300
                                                                                        //+CH+2300//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeSetShipToCodeEmpty', '', true, true)]
    local procedure OnBeforeSetShipToCodeEmpty(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin


        //CRM
        //ELSE
        PurchaseHeader.VALIDATE("Ship-to Code", '');
        PurchaseHeader."Ship-to Contact" := PurchaseHeader.wGetSalutation(PurchaseHeader.FIELDNO("Sell-to Customer No."), PurchaseHeader."Sell-to Customer No.");
        //CRM
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitPostingNoSeries', '', true, true)]
    local procedure OnAfterInitPostingNoSeries(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header")
    var
#if not CLEAN24
        NoSeriesMgt: Codeunit NoSeriesManagement;
#endif
        PostingNoSeries: Code[20];
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";


    begin

        /*     if GLSetup."Journal Templ. Name Mandatory" then begin
                 if PurchaseHeader."Journal Templ. Name" = '' then begin
                     if not PurchaseHeader.IsCreditDocType() then
                         GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                     else
                         GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name");
                     PurchaseHeader."Journal Templ. Name" := GenJournalTemplate.Name;
                 end else
                     if GenJournalTemplate.Name = '' then
                         GenJournalTemplate.Get(PurchaseHeader."Journal Templ. Name");
                 PostingNoSeries := GenJournalTemplate."Posting No. Series";

             end else
                 if PurchaseHeader.IsCreditDocType() then
                     PostingNoSeries := PurchSetup."Posted Credit Memo Nos."
                 else
                     PostingNoSeries := PurchSetup."Posted Invoice Nos.";*/

        /////////////////////////////////////////

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Subscription:
                begin
#if CLEAN24
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        "Posting No. Series" := PostingNoSeries;
                    if NoSeries.IsAutomatic(PurchSetup."Posted Receipt Nos.") then
                        "Receiving No. Series" := PurchSetup."Posted Receipt Nos.";
                    if "Document Type" = "Document Type"::Order then begin
                        if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Inv. Nos.") then
                            "Prepayment No. Series" := PurchSetup."Posted Prepmt. Inv. Nos.";
                        if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Cr. Memo Nos.") then
                            "Prepmt. Cr. Memo No. Series" := PurchSetup."Posted Prepmt. Cr. Memo Nos.";
                    end;
#else
#pragma warning disable AL0432
                    NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Posting No. Series", PostingNoSeries);
                    NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Receiving No. Series", PurchSetup."Posted Receipt Nos.");
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
                        NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Prepayment No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
                        NoSeriesMgt.SetDefaultSeries(PurchaseHeader."Prepmt. Cr. Memo No. Series", PurchSetup."Posted Prepmt. Cr. Memo Nos.");
                    end;
#pragma warning restore AL0432
#endif
                end;



            //+NDF+
            PurchaseHeader."Document Type"::"Note of Expenses":
                BEGIN
                    lNoteOfExpensesIntegr.SetNoSeries(PurchaseHeader, PurchSetup, NoSeriesMgt);
                END;
        //+NDF+//  
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnInitRecordOnAfterAssignDates', '', true, true)]
    local procedure OnInitRecordOnAfterAssignDates(var PurchaseHeader: Record "Purchase Header")
    begin
        //+ABO+
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Subscription THEN
            PurchaseHeader."Posting Date" := 0D;
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeInitPostingDescription', '', true, true)]
    local procedure OnBeforeInitPostingDescription38(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        lNaviBatSetup: Record NavibatSetup;
    begin

        //POSTING_DESC "Posting Description" := FORMAT("Document Type") + ' ' + "No.";
        //GL   PurchaseHeader."Posting Description" := PurchaseHeader.wPostingDescription; 
        lNaviBatSetup.GET();
        PurchaseHeader."Posting Description" := StrSubstNo(lNaviBatSetup."Purchase Document Description", PurchaseHeader."Document Type", PurchaseHeader."Pay-to Name", PurchaseHeader."Job No.");

        //POSTING_DESC//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTestNoSeries', '', true, true)]
    local procedure OnAfterTestNoSeries38(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup")
    var
    //DYS table is missing
    //lSubscrSetup: Record 8001900;
    begin
        PurchSetup.Get();
        case PurchHeader."Document Type" of
            //+ABO+
            PurchHeader."Document Type"::Subscription:
                BEGIN
                    //DYS
                    //  lSubscrSetup.GET;
                    //lSubscrSetup.TESTFIELD("Purch. Contract Nos.");
                END;
            //+ABO+//
            //+NDF+
            PurchHeader."Document Type"::"Note of Expenses":
                PurchSetup.TESTFIELD("Note of Expenses Nos.");
        //+NDF+//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', true, true)]
    local procedure OnAfterGetNoSeriesCode38(var PurchHeader: Record "Purchase Header"; PurchSetup: Record "Purchases & Payables Setup"; var NoSeriesCode: Code[20])
    var
    //DYS table is missing
    //lSubscrSetup: Record 8001900;
    begin
        PurchSetup.Get();
        case PurchHeader."Document Type" of

            //+ABO+
            PurchHeader."Document Type"::Subscription:
                BEGIN
                    //DYS
                    // lSubscrSetup.GET;
                    //NoSeriesCode := lSubscrSetup."Purch. Contract Nos.";
                END;
            //+ABO+//
            //+NDF+
            PurchHeader."Document Type"::"Note of Expenses":
                NoSeriesCode := PurchSetup."Note of Expenses Nos.";
        //+NDF+//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTestPurchLineFieldsBeforeRecreate', '', true, true)]
    local procedure OnBeforeTestPurchLineFieldsBeforeRecreate(var PurchaseHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
    begin

        PurchLine.TestField("Quantity Received", 0);
        PurchLine.TestField("Quantity Invoiced", 0);
        PurchLine.TestField("Return Qty. Shipped", 0);
        PurchLine.CalcFields("Reserved Qty. (Base)");
        PurchLine.TestField("Reserved Qty. (Base)", 0);
        PurchLine.TestField("Receipt No.", '');
        PurchLine.TestField("Return Shipment No.", '');
        PurchLine.TestField("Blanket Order No.", '');
        IsHandled := false;

        if not IsHandled then
            if PurchLine."Drop Shipment" or PurchLine."Special Order" then begin
                case true of
                    PurchLine."Drop Shipment":
                        SalesHeader.Get(SalesHeader."Document Type"::Order, PurchLine."Sales Order No.");
                    PurchLine."Special Order":
                        SalesHeader.Get(SalesHeader."Document Type"::Order, PurchLine."Special Order Sales No.");
                end;
                //   PurchaseHeader.TestField("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                PurchaseHeader.TESTFIELD("Ship-to Code", SalesHeader."Ship-to Code");
            end;

        PurchLine.TestField("Prepmt. Amt. Inv.", 0);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTransferSavedFieldsDropShipment', '', true, true)]
    local procedure OnBeforeTransferSavedFieldsDropShipment(var DestinationPurchaseLine: Record "Purchase Line"; var SourcePurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)

    begin


        DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
        DestinationPurchaseLine."Description 2" := SourcePurchaseLine."Description 2";
        //DESC//
        //QUANTITE
        DestinationPurchaseLine."Value 1" := SourcePurchaseLine."Value 1";
        DestinationPurchaseLine."Value 2" := SourcePurchaseLine."Value 2";
        DestinationPurchaseLine."Value 3" := SourcePurchaseLine."Value 3";
        DestinationPurchaseLine."Value 4" := SourcePurchaseLine."Value 4";
        DestinationPurchaseLine."Value 5" := SourcePurchaseLine."Value 5";
        DestinationPurchaseLine."Value 6" := SourcePurchaseLine."Value 6";
        DestinationPurchaseLine."Value 7" := SourcePurchaseLine."Value 7";
        DestinationPurchaseLine."Value 8" := SourcePurchaseLine."Value 8";
        DestinationPurchaseLine."Value 9" := SourcePurchaseLine."Value 9";
        DestinationPurchaseLine."Value 10" := SourcePurchaseLine."Value 10";
        //QUANTITE//
        //CDE_INTERNE
        DestinationPurchaseLine."Sales Document Type" := SourcePurchaseLine."Sales Document Type";
        //CDE_INTERNE//
        //#9150
        DestinationPurchaseLine.VALIDATE("Direct Unit Cost", SourcePurchaseLine."Direct Unit Cost");

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnTransferSavedFieldsSpecialOrderOnBeforeSalesLineModify', '', true, true)]
    local procedure OnTransferSavedFieldsSpecialOrderOnBeforeSalesLineModify(var DestinationPurchaseLine: Record "Purchase Line"; var SourcePurchaseLine: Record "Purchase Line"; var SalesLine: Record "Sales Line")
    begin
        //DESC
        DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
        DestinationPurchaseLine."Description 2" := SourcePurchaseLine."Description 2";
        //DESC//
        //QUANTITE
        DestinationPurchaseLine."Value 1" := SourcePurchaseLine."Value 1";
        DestinationPurchaseLine."Value 2" := SourcePurchaseLine."Value 2";
        DestinationPurchaseLine."Value 3" := SourcePurchaseLine."Value 3";
        DestinationPurchaseLine."Value 4" := SourcePurchaseLine."Value 4";
        DestinationPurchaseLine."Value 5" := SourcePurchaseLine."Value 5";
        DestinationPurchaseLine."Value 6" := SourcePurchaseLine."Value 6";
        DestinationPurchaseLine."Value 7" := SourcePurchaseLine."Value 7";
        DestinationPurchaseLine."Value 8" := SourcePurchaseLine."Value 8";
        DestinationPurchaseLine."Value 9" := SourcePurchaseLine."Value 9";
        DestinationPurchaseLine."Value 10" := SourcePurchaseLine."Value 10";
        //QUANTITE//
        //CDE_INTERNE
        DestinationPurchaseLine."Sales Document Type" := SourcePurchaseLine."Sales Document Type";
        //CDE_INTERNE//
        //#9150
        DestinationPurchaseLine.VALIDATE("Direct Unit Cost", SourcePurchaseLine."Direct Unit Cost");
        //#9150//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdateCurrencyFactorOnAfterCurrencyDateSet', '', true, true)]

    local procedure OnUpdateCurrencyFactorOnAfterCurrencyDateSet(var PurchaseHeader: Record "Purchase Header"; var CurrencyDate: Date; CurrentFieldNo: Integer)
    begin
        //+ABO+
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Subscription THEN
            CurrencyDate := WORKDATE

        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdatePurchLinesByChangedFieldName', '', true, true)]

    local procedure OnUpdatePurchLinesByChangedFieldName(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer; xPurchaseHeader: Record "Purchase Header")
    var

        Text032: label 'Vous avez modifié le champ %1.';
        Text033: label 'Souhaitez-vous mettre les lignes à jour ?';
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdatePurchLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict', '', true, true)]

    local procedure OnUpdatePurchLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict(var PurchaseHeader: Record "Purchase Header"; ChangedFieldNo: Integer; var ShouldConfirmReservationDateConflict: Boolean)
    var

        Text032: label 'Vous avez modifié le champ %1.';
        Text033: label 'Souhaitez-vous mettre les lignes à jour ?';
    begin
        //PROJET
        CASE ChangedFieldNo OF

            PurchaseHeader.FieldNo("Job No."):
                //SUBCONTRACTOR
                //   IF HideValidationDialog THEN
                ShouldConfirmReservationDateConflict := TRUE
            ELSE
                //SUBCONTRACTOR//
                ShouldConfirmReservationDateConflict :=
                  CONFIRM(
                    STRSUBSTNO(
                      Text032 +
                      Text033, ChangedFieldNo));
        //PROJET//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTransferSavedFields', '', true, true)]
    local procedure OnAfterTransferSavedFields(var DestinationPurchaseLine: Record "Purchase Line"; SourcePurchaseLine: Record "Purchase Line")
    begin
        //DESC
        DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
        DestinationPurchaseLine."Description 2" := SourcePurchaseLine."Description 2";
        //DESC//
        //QUANTITE
        DestinationPurchaseLine."Value 1" := SourcePurchaseLine."Value 1";
        DestinationPurchaseLine."Value 2" := SourcePurchaseLine."Value 2";
        DestinationPurchaseLine."Value 3" := SourcePurchaseLine."Value 3";
        DestinationPurchaseLine."Value 4" := SourcePurchaseLine."Value 4";
        DestinationPurchaseLine."Value 5" := SourcePurchaseLine."Value 5";
        DestinationPurchaseLine."Value 6" := SourcePurchaseLine."Value 6";
        DestinationPurchaseLine."Value 7" := SourcePurchaseLine."Value 7";
        DestinationPurchaseLine."Value 8" := SourcePurchaseLine."Value 8";
        DestinationPurchaseLine."Value 9" := SourcePurchaseLine."Value 9";
        DestinationPurchaseLine."Value 10" := SourcePurchaseLine."Value 10";
        //QUANTITE//
        //#9150
        DestinationPurchaseLine.VALIDATE("Direct Unit Cost", SourcePurchaseLine."Direct Unit Cost");
        //#9150//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdatePurchLinesByFieldNoOnBeforeValidateFields', '', true, true)]
    local procedure OnUpdatePurchLinesByFieldNoOnBeforeValidateFields(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; var ChangedFieldNo: Integer; var PurchaseHeader: record "Purchase Header"; var IsHandled: boolean)
    var
        UpdateConfirmed: Boolean;
        Text032: label 'You have modified %1.';
        Text033: label 'Do you want to update the lines?';
    begin



        case ChangedFieldNo of
            PurchaseHeader.FieldNo("Expected Receipt Date"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Expected Receipt Date", PurchaseHeader."Expected Receipt Date");
            PurchaseHeader.FieldNo("Currency Factor"):
                if PurchaseLine.Type <> PurchaseLine.Type::" " then
                    PurchaseLine.Validate("Direct Unit Cost");
            PurchaseHeader.FieldNo("Transaction Type"):
                PurchaseLine.Validate("Transaction Type", PurchaseHeader."Transaction Type");
            PurchaseHeader.FieldNo("Transport Method"):
                PurchaseLine.Validate("Transport Method", PurchaseHeader."Transport Method");
            PurchaseHeader.FieldNo("Entry Point"):
                PurchaseLine.Validate("Entry Point", PurchaseHeader."Entry Point");
            PurchaseHeader.FieldNo(Area):
                PurchaseLine.Validate(Area, PurchaseHeader.Area);
            PurchaseHeader.FieldNo("Transaction Specification"):
                PurchaseLine.Validate("Transaction Specification", PurchaseHeader."Transaction Specification");
            PurchaseHeader.FieldNo("Requested Receipt Date"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Requested Receipt Date", PurchaseHeader."Requested Receipt Date");
            PurchaseHeader.FieldNo("Prepayment %"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Prepayment %", PurchaseHeader."Prepayment %");
            PurchaseHeader.FieldNo("Promised Receipt Date"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Promised Receipt Date", PurchaseHeader."Promised Receipt Date");
            PurchaseHeader.FieldNo("Lead Time Calculation"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Lead Time Calculation", PurchaseHeader."Lead Time Calculation");
            PurchaseHeader.FieldNo("Inbound Whse. Handling Time"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Inbound Whse. Handling Time", PurchaseHeader."Inbound Whse. Handling Time");
            PurchaseLine.FieldNo("Deferral Code"):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.Validate("Deferral Code");
            PurchaseHeader.FieldNo("Order Date"):
                if PurchaseLine."No." <> '' then begin
                    PurchaseLine.Validate("Order Date", PurchaseHeader."Order Date");
                    PurchaseLine.UpdateDirectUnitCost(0);
                end;
            PurchaseHeader.FieldNo("Campaign No."):
                if PurchaseLine."No." <> '' then
                    PurchaseLine.UpdateDirectUnitCost(0);

            //PROJET
            PurchaseHeader.FieldNo("Job No."):
                IF UpdateConfirmed THEN BEGIN
                    //#5103
                    PurchaseLine.SETFILTER(Type, '%1|%2|%3', PurchaseLine.Type::Item, PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Note of Expenses");
                    //#5103//
                    PurchaseLine.VALIDATE("dysJob No.", PurchaseHeader."Job No.");
                END;
            //PROJET//
            PurchaseHeader.FieldNo("N° Dossier"):
                //GL2024
                IF UpdateConfirmed AND (PurchaseLine."No." <> '') THEN
                    PurchaseLine.VALIDATE("N° Dossier", PurchaseHeader."N° Dossier");


        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdateShipToAddress', '', true, true)]
    local procedure OnBeforeUpdateShipToAddress(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; CurrentFieldNo: Integer)
    VAR
        lContact: Record Contact;
        lJob: Record Job;
    begin
        //#8747
        //IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
        //  EXIT;
        //#8747//

        //SHIP_TO_ADDRESS
        IF (PurchaseHeader."Ship-to Contact No." <> '') AND lContact.GET(PurchaseHeader."Ship-to Contact No.") THEN BEGIN
            PurchaseHeader."Ship-to Name" := lContact."Company Name";
            PurchaseHeader."Ship-to Name 2" := lContact."Name 2";
            PurchaseHeader."Ship-to Address" := lContact.Address;
            PurchaseHeader."Ship-to Address 2" := lContact."Address 2";
            PurchaseHeader."Ship-to City" := lContact.City;
            PurchaseHeader."Ship-to Post Code" := lContact."Post Code";
            PurchaseHeader."Ship-to County" := lContact.County;
            PurchaseHeader."Ship-to Country/Region Code" := lContact."Country/Region Code";
            IF lContact.Type = lContact.Type::Person THEN
                PurchaseHeader."Ship-to Contact" := lContact.Name
            ELSE
                PurchaseHeader."Ship-to Contact" := '';
            EXIT;
        END;

        IF (PurchaseHeader."Ship-to Job No." <> '') AND lJob.GET(PurchaseHeader."Ship-to Job No.") THEN BEGIN
            PurchaseHeader."Ship-to Name" := COPYSTR(lJob."Description 2", 1, MAXSTRLEN(PurchaseHeader."Ship-to Name"));
            //  "Ship-to Name 2" := lJob."Job Name 2";
            PurchaseHeader."Ship-to Address" := lJob."Job Address";
            PurchaseHeader."Ship-to Address 2" := lJob."Job Address 2";
            PurchaseHeader."Ship-to City" := lJob."Job City";
            PurchaseHeader."Ship-to Post Code" := lJob."Job Post Code";
            PurchaseHeader."Ship-to County" := lJob."Job County";
            PurchaseHeader."Ship-to Country/Region Code" := lJob."Job Country Code";
            PurchaseHeader."Ship-to Contact" := lJob."Ship-to Contact";
            EXIT;
        END;
        //SHIP_TO_ADDRESS//

        //#8747
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdateBuyFromVendOnAfterGetContact', '', true, true)]
    local procedure OnUpdateBuyFromVendOnAfterGetContact(var PurchaseHeader: Record "Purchase Header"; var Cont: Record Contact; var ShouldUpdateFromContact: Boolean)
    var
        Vend: Record Vendor;
    begin


        if ShouldUpdateFromContact then begin
            PurchaseHeader."Buy-from Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
            //ACHAT_ADR
            BEGIN
                PurchaseHeader."Buy-from Address" := Cont.Address;
                PurchaseHeader."Buy-from Address 2" := Cont."Address 2";
                PurchaseHeader."Buy-from City" := Cont.City;
                PurchaseHeader."Buy-from Post Code" := Cont."Post Code";
                PurchaseHeader."Buy-from County" := Cont.County;
                PurchaseHeader."Buy-from Country/Region Code" := Cont."Country/Region Code";
                //ACHAT_ADR//
                PurchaseHeader."Buy-from Contact" := Cont.Name
                //ACHAT_ADR
            END
            //ACHAT_ADR//
            else
                if Vend.Get(PurchaseHeader."Buy-from Vendor No.") then
               //ACHAT_ADR
               BEGIN
                    PurchaseHeader."Buy-from Vendor Name" := Vend.Name;
                    PurchaseHeader."Buy-from Vendor Name 2" := Vend."Name 2";
                    PurchaseHeader."Buy-from Address" := Vend.Address;
                    PurchaseHeader."Buy-from Address 2" := Vend."Address 2";
                    PurchaseHeader."Buy-from City" := Vend.City;
                    PurchaseHeader."Buy-from Post Code" := Vend."Post Code";
                    PurchaseHeader."Buy-from County" := Vend.County;
                    PurchaseHeader."Buy-from Country/Region Code" := Vend."Country/Region Code";
                    //ACHAT_ADR//
                    PurchaseHeader."Buy-from Contact" := Vend.Contact
                    //ACHAT_ADR
                END
                //ACHAT_ADR//
                else
                    PurchaseHeader."Buy-from Contact" := ''
        end else begin
            PurchaseHeader."Buy-from Contact" := '';
            exit;
        end;

        ShouldUpdateFromContact := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeJobUpdatePurchaseLine', '', true, true)]
    local procedure OnBeforeJobUpdatePurchaseLine(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    VAR
        lCurrPrev: Decimal;
    begin

        //#5020
        lCurrPrev := PurchaseLine."Job Currency Factor";
        //#5020//
        PurchaseLine.CreateTempJobJnlLine(FALSE);
        PurchaseLine.UpdateJobPrices();
        //#5020
        IF lCurrPrev <> PurchaseLine."Job Currency Factor" THEN
            //#5020//
            PurchaseLine.MODIFY;

        IsHandled := true;

    end;





    //*************************************Table 39************************************************//

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnDeleteOnBeforeTestStatusOpen', '', true, true)]
    local procedure OnDeleteOnBeforeTestStatusOpen(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;




    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', true, true)]
    local procedure OnBeforeUpdateSpecialSalesOrderLineFromOnDelete(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        lInitialOfferLine: Record "Purchase Line";
        lOfferLine: Record "Purchase Line";
        lSalesDocNo: Code[20];
        lSalesDocLineNo: Integer;
        lSalesDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        lSourceDocNo: Code[20];

    begin
        lSourceDocNo := '';
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Quote THEN
            lSourceDocNo := PurchaseLine."Attached to Doc. No.";


        IF PurchaseLine."Sales Order Line No." <> 0 THEN BEGIN

            PurchaseLine.LOCKTABLE;
            SalesOrderLine.LOCKTABLE;
            //SUBCONTRACTOR
            IF (PurchaseLine."Sales Document Type" <> 0) THEN BEGIN
                SalesOrderLine.GET(PurchaseLine."Sales Document Type" - 1, PurchaseLine."Sales Order No.", PurchaseLine."Sales Order Line No.")
            END
            ELSE
                //SUBCONTRACTOR//
                SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, PurchaseLine."Sales Order No.", PurchaseLine."Sales Order Line No.");
            SalesOrderLine."Purchase Order No." := '';
            SalesOrderLine."Purch. Order Line No." := 0;
            //ACHAT_DIRECT
            SalesOrderLine."Purchasing Order No." := '';
            SalesOrderLine."Purchasing Order Line No." := 0;
            //ACHAT_DIRECT//
            //#6630 R37
            SalesOrderLine."Purchasing Document Type" := SalesOrderLine."Purchasing Document Type"::Quote;
            //#6630 R37//
            SalesOrderLine.MODIFY;
            //SUBCONTRACTOR : ligne d'ouvrage  //PERF
            IF SalesOrderLine.Subcontracting <> 0 THEN
                IF SalesOrderLine.GET(SalesOrderLine."Document Type", SalesOrderLine."Document No.", SalesOrderLine."Structure Line No.") THEN BEGIN
                    SalesOrderLine."Purchasing Document Type" := SalesOrderLine."Purchasing Document Type"::Quote;
                    SalesOrderLine."Purchase Order No." := '';
                    SalesOrderLine."Purch. Order Line No." := 0;
                    SalesOrderLine."Purchasing Order No." := '';
                    SalesOrderLine."Purchasing Order Line No." := 0;
                    SalesOrderLine.MODIFY;
                END;
            //SUBCONTRACTOR//
        END;



        IF (PurchaseLine."Special Order Sales Line No." <> 0) THEN BEGIN
            PurchaseLine.LOCKTABLE;
            SalesOrderLine.LOCKTABLE;
            IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order THEN BEGIN
                SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, PurchaseLine."Special Order Sales No.", PurchaseLine."Special Order Sales Line No.");
                SalesOrderLine."Special Order Purchase No." := '';
                SalesOrderLine."Special Order Purch. Line No." := 0;
                //ACHAT_DIRECT
                SalesOrderLine."Purchasing Document Type" := SalesOrderLine."Purchasing Document Type"::Quote;
                SalesOrderLine."Purchasing Order No." := '';
                SalesOrderLine."Purchasing Order Line No." := 0;
                //ACHAT_DIRECT//                                            -
                SalesOrderLine.MODIFY;
                //#8250
            END;
            //#8250
            //SUBCONTRACTOR : ligne d'ouvrage  //PERF
            IF SalesOrderLine.Subcontracting <> 0 THEN
                IF SalesOrderLine.GET(SalesOrderLine."Document Type", SalesOrderLine."Document No.", SalesOrderLine."Structure Line No.") THEN BEGIN
                    SalesOrderLine."Purchasing Document Type" := SalesOrderLine."Purchasing Document Type"::Quote;
                    SalesOrderLine."Special Order Purchase No." := '';
                    SalesOrderLine."Special Order Purch. Line No." := 0;
                    SalesOrderLine."Purchasing Order No." := '';
                    SalesOrderLine."Purchasing Order Line No." := 0;
                    SalesOrderLine.MODIFY;
                END;
            //SUBCONTRACTOR//
        END ELSE BEGIN
            IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order, PurchaseLine."Special Order Sales No.", PurchaseLine."Special Order Sales Line No.") THEN BEGIN
                SalesOrderLine."Special Order Purchase No." := '';
                SalesOrderLine."Special Order Purch. Line No." := 0;
                SalesOrderLine.MODIFY;
            END;
        END;

        //CONSULT
        IF (lSourceDocNo <> '') AND (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order) THEN BEGIN


            lSalesDocLineNo := PurchaseLine."Sales Order Line No." + PurchaseLine."Special Order Sales Line No.";
            lSalesDocNo := PurchaseLine."Sales Order No." + PurchaseLine."Special Order Sales No.";
            IF PurchaseLine."Sales Document Type" > PurchaseLine."Sales Document Type"::" " THEN
                lSalesDocType := PurchaseLine."Sales Document Type" - 1;

            IF PurchaseLine."Sales Document Type" > PurchaseLine."Sales Document Type"::" " THEN BEGIN
                lInitialOfferLine.GET(lInitialOfferLine."Document Type"::Quote, lSourceDocNo, PurchaseLine."Line No.");
                lInitialOfferLine."Sales Order No." := lSalesDocNo;
                lInitialOfferLine."Sales Order Line No." := lSalesDocLineNo;
                lInitialOfferLine."Sales Document Type" := lSalesDocType + 1;
                lInitialOfferLine.MODIFY;
                SalesOrderLine.GET(lSalesDocType, lSalesDocNo, lSalesDocLineNo);
                SalesOrderLine."Purchasing Document Type" := lInitialOfferLine."Document Type";
                SalesOrderLine."Purchasing Order No." := lInitialOfferLine."Document No.";
                SalesOrderLine."Purchasing Order Line No." := lInitialOfferLine."Line No.";
                //SUBCONTRACTOR
                IF SalesOrderLine.Subcontracting <> SalesOrderLine.Subcontracting::" " THEN BEGIN
                    IF (PurchaseLine."Sales Order Line No." <> 0) THEN BEGIN
                        SalesOrderLine."Purchase Order No." := lInitialOfferLine."Document No.";
                        SalesOrderLine."Purch. Order Line No." := lInitialOfferLine."Line No.";
                    END;
                    IF (PurchaseLine."Special Order Sales Line No." <> 0) THEN BEGIN
                        SalesOrderLine."Special Order Purchase No." := lInitialOfferLine."Document No.";
                        SalesOrderLine."Special Order Purch. Line No." := lInitialOfferLine."Line No.";
                    END;
                    if lOfferLine.get(PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.") then
                        SalesOrderLine."Vendor No." := lOfferLine."Buy-from Vendor No.";
                END;
                //SUBCONTRACTOR//
                SalesOrderLine.MODIFY;
            END;
            //SUBCONTRACTOR : Structure Line
            SalesOrderLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            SalesOrderLine.SETRANGE("Document Type", lSalesDocType);
            SalesOrderLine.SETRANGE("Document No.", lSalesDocNo);
            SalesOrderLine.SETRANGE("Line Type", SalesOrderLine."Line Type"::Item);
            SalesOrderLine.SETRANGE("No.", PurchaseLine."No.");
            SalesOrderLine.SETRANGE("Item Type", SalesOrderLine."Item Type"::" ");
            SalesOrderLine.MODIFYALL("Purchasing Document Type", lInitialOfferLine."Document Type");
            SalesOrderLine.MODIFYALL("Purchasing Order No.", lInitialOfferLine."Document No.");
            if lOfferLine.get(PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.") then
                SalesOrderLine.MODIFYALL("Vendor No.", lOfferLine."Buy-from Vendor No.");
            SalesOrderLine.MODIFYALL("Purchasing Order Line No.", lInitialOfferLine."Line No.");
            IF (PurchaseLine."Sales Order Line No." <> 0) THEN BEGIN
                SalesOrderLine.MODIFYALL("Purchase Order No.", lInitialOfferLine."Document No.");
                SalesOrderLine.MODIFYALL("Purch. Order Line No.", lInitialOfferLine."Line No.");
            END;
            IF (PurchaseLine."Special Order Sales Line No." <> 0) THEN BEGIN
                SalesOrderLine.MODIFYALL("Special Order Purchase No.", lInitialOfferLine."Document No.");
                SalesOrderLine.MODIFYALL("Special Order Purch. Line No.", lInitialOfferLine."Line No.");
            END;

            IF SalesOrderLine.Subcontracting <> SalesOrderLine.Subcontracting::" " THEN BEGIN
                IF SalesOrderLine.GET(lSalesDocType, lSalesDocNo, SalesOrderLine."Structure Line No.") THEN BEGIN
                    SalesOrderLine."Purchasing Document Type" := lInitialOfferLine."Document Type";
                    SalesOrderLine."Purchasing Order No." := lInitialOfferLine."Document No.";
                    SalesOrderLine."Purchasing Order Line No." := lInitialOfferLine."Line No.";
                    if lOfferLine.get(PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.") then
                        SalesOrderLine."Vendor No." := lOfferLine."Buy-from Vendor No.";
                    IF (PurchaseLine."Sales Order Line No." <> 0) THEN BEGIN
                        SalesOrderLine."Purchase Order No." := lInitialOfferLine."Document No.";
                        SalesOrderLine."Purch. Order Line No." := lInitialOfferLine."Line No.";
                    END;
                    IF (PurchaseLine."Special Order Sales Line No." <> 0) THEN BEGIN
                        SalesOrderLine."Special Order Purchase No." := lInitialOfferLine."Document No.";
                        SalesOrderLine."Special Order Purch. Line No." := lInitialOfferLine."Line No.";
                    END;
                    SalesOrderLine.MODIFY;
                END;
            END;
            //SUBCONTRACTOR//
        END;
        //CONSULT//





        IsHandled := true;




    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnDeleteOnBeforePurchLineDeleteAll', '', true, true)]
    local procedure OnDeleteOnBeforePurchLineDeleteAll(var PurchaseLine: Record "Purchase Line")
    begin
        PurchaseLine.DELETEALL();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckAssosiatedSalesOrder', '', true, true)]
    local procedure OnBeforeCheckAssosiatedSalesOrder(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        Text001: label 'You cannot change %1 because the order line is associated with sales order %2.';
    begin
        if PurchaseLine."Drop Shipment" then
            Error(Text001, PurchaseLine.FieldCaption("No."), PurchaseLine."Sales Order No.");
        //  if PurchaseLine."Special Order" then
        //  Error(Text001, PurchaseLine.FieldCaption("No."), PurchaseLine."Special Order Sales No.");
        IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateNoOnBeforeCheckReceiptNo', '', true, true)]
    local procedure OnValidateNoOnBeforeCheckReceiptNo(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        PurchLine2: Record "Purchase Line";
        Text045: label 'Article Deja Existant Dans Cette Commande, Vous n''avez Le droit D''untilser Un Article Qu''une Seule Fois';

    begin
        // >> HJ SORO 15-01-2015
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order THEN BEGIN
            IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                IF (PurchaseLine."No." <> 'IMM') AND (PurchaseLine."No." <> '3000010000001') AND (COPYSTR(PurchaseLine.Description, 1, 4) <> 'DALOT') and (PurchaseLine."Type article" <> PurchaseLine."Type article"::Service) THEN BEGIN
                    PurchLine2.SETRANGE("No.", PurchaseLine."No.");
                    PurchLine2.SETRANGE("Document Type", PurchaseLine."Document Type");
                    PurchLine2.SETRANGE("Document No.", PurchaseLine."Document No.");
                    IF PurchLine2.FINDFIRST THEN ERROR(Text045);
                END;
            END;
        END;
        // >> HJ SORO 15-01-2015

    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeAssignHeaderValues', '', true, true)]
    local procedure OnBeforeAssignHeaderValues(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header")
    begin
        //ACHAT
        PurchaseHeader."No." := '';
        //ACHAT//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckBuyFromVendorNo', '', true, true)]
    local procedure OnBeforeCheckBuyFromVendorNo(PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    begin
        // >> HJ SORO 16-01-2015
        PurchaseHeader.TESTFIELD("Job No.");
        // >> HJ SORO 16-01-2015
    end;


    /*GL2024 [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInitHeaderDefaults', '', true, true)]
     local procedure OnAfterInitHeaderDefaults(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; var TempPurchLine: record "Purchase Line" temporary)
     begin
         //+ONE+
         //#5452
         IF (PurchLine.Type <> PurchLine.Type::" ") THEN
             //#5452
             PurchLine.VALIDATE("Job No.", PurchHeader."Job No.")
         //#5452
         ELSE
             PurchLine."Job No." := PurchHeader."Job No.";
         //#5452
         //+ONE+
     end;*/

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignStdTxtValues', '', true, true)]
    local procedure OnAfterAssignStdTxtValues(var PurchLine: Record "Purchase Line"; StandardText: Record "Standard Text")
    begin
        //BASIC_GESWAY
        //      Description := StdTxt.Description;
        PurchLine.wGetStandardText;
        //BASIC_GESWAY//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheck39(var PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin
        //    IF Item."Appliquer Fodec" THEN
        //  PurchaseLine."Apply Fodec" := TRUE;


        // MH SORO 08-02-2021
        PurchaseLine.Cocher_Ligne := Item.Cocher_Appro;
        PurchaseLine.Observation_Ligne := Item.Observation_Appro;
        // MH SORO 08-02-2021

        //ACHATS
        PurchaseLine."Invoicing Unit" := Item."Invoicing Unit";
        PurchaseLine.InitQtyPerInvoicingUnit;
        //ACHATS//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', true, true)]
    local procedure OnAfterAssignItemValues39(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    var
        //GL2024  ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference";


    begin
        //QUANTITE
        PurchLine."Value 1" := Item."Default Qty Value 1";
        PurchLine."Value 2" := Item."Default Qty Value 2";
        PurchLine."Value 3" := Item."Default Qty Value 3";
        PurchLine."Value 4" := Item."Default Qty Value 4";
        PurchLine."Value 5" := Item."Default Qty Value 5";
        PurchLine."Value 6" := Item."Default Qty Value 6";
        PurchLine."Value 7" := Item."Default Qty Value 7";
        PurchLine."Value 8" := Item."Default Qty Value 8";
        PurchLine."Value 9" := Item."Default Qty Value 9";
        PurchLine."Value 10" := Item."Default Qty Value 10";
        //QUANTITE//
        //+REF+CROSSREF
        PurchLine.GetPurchHeader;
        //#7728
        //GL2024 IF CurrentFieldNo <> PurchLine.FIELDNO("Cross-Reference No.") THEN BEGIN
        IF CurrentFieldNo <> PurchLine.FIELDNO("Item Reference No.") THEN BEGIN
            //#7728//
            ItemCrossReference.RESET;
            ItemCrossReference.SETCURRENTKEY("Item No.");
            ItemCrossReference.SETRANGE("Item No.", Item."No.");
            ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Vendor);
            ItemCrossReference.SETRANGE("Reference Type No.", PurchHeader."Buy-from Vendor No.");
            IF ItemCrossReference.COUNT = 1 THEN BEGIN
                PurchLine."Item Reference Type" := PurchLine."Item Reference Type"::Vendor;
            END ELSE
                IF ItemCrossReference.COUNT > 1 THEN BEGIN
                    COMMIT;
                    //GL2024  IF page.RUNMODAL(page::"Cross Reference List", ItemCrossReference) = ACTION::LookupOK THEN BEGIN
                    IF page.RUNMODAL(page::"Item Reference List", ItemCrossReference) = ACTION::LookupOK THEN BEGIN
                        PurchLine."Item Reference Type" := PurchLine."Item Reference Type"::Vendor;
                        PurchLine."Item Reference No." := ItemCrossReference."Reference No.";
                    END;
                END;
            //#7728
        END;
        //#7728//
        //+REF+CROSSREF//
    END;
    //+ABO+
    //  Type::"3":
    //    ERROR(Text003);



    /*
    GL2024 Déjà existe dans BC2024 mais n'existe pas dans NAV 2009
     [EventSubscriber(ObjectType::Table, 39, 'OnAfterAssignFieldsForNo', '', true, true)]
     local procedure OnAfterAssignFieldsForNo39(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
     var
         lRes: Record Resource;
     begin
         case PurchLine.Type of
             PurchLine.Type::Resource:
                 BEGIN
                     lRes.GET(PurchLine."No.");
                     lRes.TESTFIELD(Blocked, FALSE);
                     lRes.TESTFIELD("Gen. Prod. Posting Group");
                     PurchLine.Description := lRes.Name;
                     PurchLine."Description 2" := lRes."Name 2";
                     PurchLine."Unit of Measure Code" := lRes."Base Unit of Measure";
                     PurchLine."Unit Cost (LCY)" := lRes."Unit Cost";
                     PurchLine."Gen. Prod. Posting Group" := lRes."Gen. Prod. Posting Group";
                     PurchLine."VAT Prod. Posting Group" := lRes."VAT Prod. Posting Group";
                     PurchLine."Tax Group Code" := lRes."Tax Group Code";
                     PurchLine."Allow Item Charge Assignment" := FALSE;
                     //      FindResUnitCost;
                 end;
         end;
     end;*/




    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckLineNotShippedOrReceived', '', true, true)]

    local procedure OnBeforeCheckLineNotShippedOrReceived(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeTestStatusOpen', '', true, true)]

    local procedure OnBeforeTestStatusOpen(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        if (CallingFieldNo = PurchaseLine.FieldNo("Unit Cost (LCY)")) or (CallingFieldNo = PurchaseLine.FieldNo("location code")) or (CallingFieldNo = PurchaseLine.FieldNo("Prepayment %")) or (CallingFieldNo = PurchaseLine.FieldNo("Prepmt. Line Amount")) then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::codeunit, codeunit::"Item Reference Management", 'OnAfterValidatePurchaseReferenceNo', '', true, true)]

    local procedure OnAfterValidatePurchaseReferenceNo(var PurchaseLine: Record "Purchase Line"; ItemReference: Record "Item Reference"; ReturnedItemReference: Record "Item Reference")
    begin
        //ACHATS
        IF ReturnedItemReference."Reference Type No." <> '' THEN
            PurchaseLine."Vendor Item No." := PurchaseLine."Item Reference No.";
        //ACHATS//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeGetPurchHeader', '', true, true)]
    local procedure OnBeforeGetPurchHeader(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; var Currency: Record Currency)
    var
        RecCurrency: Record Currency;
        PurchHeader: Record "Purchase Header";
    begin
        PurchaseLine.TestField("Document No.");
        if (PurchaseLine."Document Type" <> PurchHeader."Document Type") or (PurchaseLine."Document No." <> PurchHeader."No.") or (PurchHeader."Buy-from Vendor No." = '') then
            if PurchHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
                if PurchHeader."Currency Code" = '' then
                    RecCurrency.InitRoundingPrecision()
                else begin
                    PurchHeader.TestField("Currency Factor");
                    RecCurrency.Get(PurchHeader."Currency Code");
                    RecCurrency.TestField("Amount Rounding Precision");
                end
            else
                Clear(PurchHeader);

        // OnAfterGetPurchHeader(Rec, PurchHeader, Currency);
        PurchaseHeader := PurchHeader;
        Currency := RecCurrency;

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckPrepmtAmounts', '', true, true)]

    local procedure OnBeforeCheckPrepmtAmounts(var PurchaseLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; CurrentFieldNo: Integer; var IsHandled: Boolean; xPurchaseLine: Record "Purchase Line")
    var

        RemLineAmountToInvoice: Decimal;
        CannotChangePrepaidServiceChargeErr: Label 'You cannot change the line because it will affect service charges that are already invoiced as part of a prepayment.';
        InvDiscForPrepmtExceededErr: Label 'You cannot enter an invoice discount for purchase document %1.\\You must cancel the prepayment invoice first and then you will be able to update the invoice discount.', Comment = '%1 - document number';
        Text039: Label 'cannot be more than %1.';
        Text038: Label 'cannot be less than %1.';
        Text037: Label 'cannot be %1.';
        Currency: Record Currency;
    begin
        //  Currency.Get(PurchHeader."Currency Code");
        if PurchHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else begin
            PurchHeader.TestField("Currency Factor");
            Currency.Get(PurchHeader."Currency Code");
            Currency.TestField("Amount Rounding Precision");
        end;
        if PurchaseLine."Prepayment %" <> 0 then begin
            if PurchaseLine."System-Created Entry" then
                if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                    if not PurchaseLine.IsServiceCharge() then
                        exit;
            /*  if Quantity < 0 then
                  FieldError(Quantity, StrSubstNo(Text043, FieldCaption("Prepayment %")));
              if "Direct Unit Cost" < 0 then
                  FieldError("Direct Unit Cost", StrSubstNo(Text043, FieldCaption("Prepayment %")));*/
        end;
        //  IF ("Prepmt. Line Amount" < "Prepmt. Amt. Inv.") THEN
        //#7814//
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice then begin
            //     if ((PurchaseLine."Prepmt. Line Amount" + Currency."Amount Rounding Precision") < PurchaseLine."Prepmt. Amt. Inv.") and (PurchHeader.Status <> PurchHeader.Status::Released) then begin
            IF (((PurchaseLine."Prepmt. Line Amount" > 0) AND (PurchaseLine."Prepmt. Line Amount" < PurchaseLine."Prepmt. Amt. Inv.")) OR
         ((PurchaseLine."Prepmt. Line Amount" < 0) AND (PurchaseLine."Prepmt. Line Amount" > PurchaseLine."Prepmt. Amt. Inv."))) and (PurchHeader.Status <> PurchHeader.Status::Released) THEN begin
                if PurchaseLine.IsServiceCharge() then
                    Error(CannotChangePrepaidServiceChargeErr);
                if PurchaseLine."Inv. Discount Amount" <> 0 then
                    Error(InvDiscForPrepmtExceededErr, PurchaseLine."Document No.");
                PurchaseLine.FieldError("Prepmt. Line Amount", StrSubstNo(Text037, PurchaseLine."Prepmt. Amt. Inv."));
            end;
            if PurchaseLine."Prepmt. Line Amount" <> 0 then begin
                RemLineAmountToInvoice :=
                  Round(PurchaseLine."Line Amount" * (PurchaseLine.Quantity - PurchaseLine."Quantity Invoiced") / PurchaseLine.Quantity, Currency."Amount Rounding Precision");
                if RemLineAmountToInvoice < (PurchaseLine."Prepmt Amt to Deduct" - PurchaseLine."Prepmt Amt Deducted") then
                    PurchaseLine.FieldError("Prepmt Amt to Deduct", StrSubstNo(Text039, RemLineAmountToInvoice + PurchaseLine."Prepmt Amt Deducted"));
            end;
        end else
            if (CurrentFieldNo <> 0) and (PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount") and
               (PurchaseLine."Prepmt. Amt. Inv." <> 0) and (PurchaseLine."Prepayment %" = 100)
            then begin
                if PurchaseLine."Line Amount" < xPurchaseLine."Line Amount" then
                    PurchaseLine.FieldError("Line Amount", StrSubstNo(Text038, xPurchaseLine."Line Amount"));
                PurchaseLine.FieldError("Line Amount", StrSubstNo(Text039, xPurchaseLine."Line Amount"));
            end;

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignFixedAssetValues', '', true, true)]
    local procedure OnAfterAssignFixedAssetValues39(var PurchLine: Record "Purchase Line"; FixedAsset: Record "Fixed Asset"; PurchHeader: Record "Purchase Header")
    begin
        //PROJET_IMMO
        PurchLine.VALIDATE("dysJob No.", FixedAsset."Job No.");
        //PROJET_IMMO//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignFieldsForNo', '', true, true)]
    local procedure OnAfterAssignFieldsForNo39(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")

    var
        lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";
        TempPurchLine: Record "Purchase Line";

    begin
        //+NDF+
        lNoteOfExpensesIntegr.SetPurchLineRes(PurchLine);
        lNoteOfExpensesIntegr.SetPurchLineExpectReceiptDate(PurchLine, TempPurchLine);
        //+NDF+//

        //+OFF+OFFRE
        //GL2024 TempPurchLine.get(PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.")
        IF TempPurchLine."Attached to Doc. No." <> '' THEN BEGIN
            PurchLine."Attached to Doc. Type" := TempPurchLine."Attached to Doc. Type";
            PurchLine."Attached to Doc. No." := TempPurchLine."Attached to Doc. No.";
            PurchLine."Selected Doc. No." := TempPurchLine."Selected Doc. No.";
            PurchLine."Selected Doc. Line No." := TempPurchLine."Selected Doc. Line No.";
            PurchLine."Ordered Line" := TempPurchLine."Ordered Line";
            PurchLine."Price Offer No." := TempPurchLine."Price Offer No.";
            PurchLine."Offer Comments" := TempPurchLine."Offer Comments";
            PurchLine."Discount 1 %" := TempPurchLine."Discount 1 %";
            PurchLine."Discount 2 %" := TempPurchLine."Discount 2 %";
            PurchLine."Discount 3 %" := TempPurchLine."Discount 3 %";
        END;
        //+OFF+OFFRE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateJobFields', '', true, true)]
    local procedure OnBeforeUpdateJobFields(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateICPartner', '', true, true)]
    local procedure OnAfterUpdateICPartner39(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header")
    begin
        //QUANTITE
        IF (PurchaseLine."Value 1" <> 0) OR (PurchaseLine."Value 2" <> 0) OR (PurchaseLine."Value 3" <> 0) OR (PurchaseLine."Value 4" <> 0) OR (PurchaseLine."Value 5" <> 0) OR
           (PurchaseLine."Value 6" <> 0) OR (PurchaseLine."Value 7" <> 0) OR (PurchaseLine."Value 8" <> 0) OR (PurchaseLine."Value 9" <> 0) OR (PurchaseLine."Value 10" <> 0) THEN
            PurchaseLine.VALIDATE("Value 1");
        //QUANTITE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateICPartner', '', true, true)]
    local procedure OnBeforeUpdateICPartner(var PurchLine: Record "Purchase Line"; GLAcc: Record "G/L Account"; var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        lRes: Record Resource;
    begin

        if PurchHeader."Send IC Document" and (PurchHeader."IC Direction" = PurchHeader."IC Direction"::Outgoing)
        then
            case PurchLine.Type of

                PurchLine.Type::"G/L Account":
                    begin
                        //+REF+IC
                        IF GLAcc."Default IC Partner G/L Acc. No" <> '' THEN
                            //+REF+IC//
                            PurchLine."IC Partner Reference" := GLAcc."Default IC Partner G/L Acc. No"
                        //+REF+IC
                        ELSE
                            PurchLine."IC Partner Reference" := PurchLine."No.";
                        //+REF+IC//
                    end;

                //+ABO+
                PurchLine.Type::Resource:
                    BEGIN
                        lRes.GET(PurchLine."No.");
                        PurchLine."IC Partner Ref. Type" := PurchLine."IC Partner Ref. Type"::"G/L Account";
                        PurchLine."IC Partner Reference" := lRes."IC Partner Purch. G/L Acc. No.";
                    END;
            //+ABO+//


            end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateNoPurchaseLine', '', true, true)]
    local procedure OnAfterValidateNoPurchaseLine(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseHeader: Record "Purchase Header")
    begin
        //+ABO+
        //#8661
        //IF "Document Type" = "Document Type"::Subscription THEN
        //#8661
        PurchaseLine.fSubscrIntegration(PurchaseLine.FIELDNO("No."));
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateLocationCodeOnAfterTestStatusOpen', '', true, true)]
    local procedure OnValidateLocationCodeOnAfterTestStatusOpen(var PurchaseLine: Record "Purchase Line")
    var
        "CUPurch.-Post": Codeunit "Purch.-Post";
        CduPurchpostev: Codeunit PurchPostEvent;

    begin
        //
        // RB SORO 09/06/2015

        // CduPurchpostev.AutorisationMagasin(PurchaseLine."Location Code");

        // RB SORO 09/06/2015
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateLocationCodeOnBeforeSpecialOrderError', '', true, true)]
    local procedure OnValidateLocationCodeOnBeforeSpecialOrderError(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; CurrFieldNo: Integer; xPurchaseLine: Record "Purchase Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateLocationCodeOnBeforeDropShipmentError', '', true, true)]
    local procedure OnValidateLocationCodeOnBeforeDropShipmentError(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; xPurchaseLine: Record "Purchase Line")
    var
        RecUserLocation: Record "User Setup";
        // RecAutorisationMagasin: Record "Autorisation Magasin";
        Text0001: label 'Magasin non Autorisé !!!';
        Text001: label 'Vous ne pouvez pas modifier %1 car la commande est associée à la commande vente %2.';
    BEGIN
        /* IF RecUserLocation.GET(USERID) THEN;
         IF NOT RecUserLocation."Modifier Magasin Reception" THEN BEGIN

             if PurchaseLine."Drop Shipment" then
                 Error(Text001, PurchaseLine.FieldCaption("Location Code"), PurchaseLine."Sales Order No.");
         end;*/
        IF PurchaseLine."Drop Shipment" THEN
            ERROR(
              Text001,
              PurchaseLine.FIELDCAPTION("Location Code"), PurchaseLine."Sales Order No.");
        IF PurchaseLine."Special Order" THEN
            ERROR(
              Text001,
              PurchaseLine.FIELDCAPTION("Location Code"), PurchaseLine."Special Order Sales No.");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQtyToReceiveOnAfterInitQty', '', true, true)]
    local procedure OnValidateQtyToReceiveOnAfterInitQty(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        lInventPostGroup: Record "Inventory Posting Group";
        Text008: label 'You cannot receive more than %1 units.';

        Text009: label 'You cannot receive more than %1 base units.';
        Item: Record Item;

    begin
        if not PurchaseLine.OverReceiptProcessing2() then
            if not IsHandled then begin
                if (((PurchaseLine."Qty. to Receive" < 0) xor (PurchaseLine.Quantity < 0)) and (PurchaseLine.Quantity <> 0) and (PurchaseLine."Qty. to Receive" <> 0)) or
                   (Abs(PurchaseLine."Qty. to Receive") > Abs(PurchaseLine."Outstanding Quantity")) or
                   (((PurchaseLine.Quantity < 0) xor (PurchaseLine."Outstanding Quantity" < 0)) and (PurchaseLine.Quantity <> 0) and (PurchaseLine."Outstanding Quantity" <> 0))
                  THEN
                  //+REF+EXCEED_RECEIP
                  BEGIN
                    ITEM := PurchaseLine.GetItem;
                    IF NOT lInventPostGroup.GET(Item."Inventory Posting Group") THEN
                        Item.INIT;
                    IF PurchaseLine."Drop Shipment" OR PurchaseLine."Special Order" OR NOT lInventPostGroup."Excess Receip Allow" OR
                       (((lInventPostGroup."Excess Receip (%)" / 100 + 1) * PurchaseLine.Quantity < PurchaseLine."Qty. to Receive" + PurchaseLine."Quantity Received") AND
                        (lInventPostGroup."Excess Receip (%)" <> 0)) THEN BEGIN
                        IF PurchaseLine."Drop Shipment" OR PurchaseLine."Special Order" OR NOT lInventPostGroup."Excess Receip Allow" THEN
                            ERROR(
                              Text008,
                              PurchaseLine."Outstanding Quantity");
                        ERROR(
                          Text008,
                          PurchaseLine."Outstanding Quantity" + (lInventPostGroup."Excess Receip (%)" / 100 * PurchaseLine.Quantity));
                    END;
                END;




                if (((PurchaseLine."Qty. to Receive (Base)" < 0) xor (PurchaseLine."Quantity (Base)" < 0)) and (PurchaseLine."Quantity (Base)" <> 0) and (PurchaseLine."Qty. to Receive (Base)" <> 0)) or
                   (Abs(PurchaseLine."Qty. to Receive (Base)") > Abs(PurchaseLine."Outstanding Qty. (Base)")) or
                   (((PurchaseLine."Quantity (Base)" < 0) xor (PurchaseLine."Outstanding Qty. (Base)" < 0)) and (PurchaseLine."Quantity (Base)" <> 0) and (PurchaseLine."Outstanding Qty. (Base)" <> 0))
                then
                  //+REF+EXCEED_RECEIP
                  BEGIN
                    PurchaseLine.GetItem;
                    IF NOT lInventPostGroup.GET(Item."Inventory Posting Group") THEN
                        Item.INIT;
                    IF PurchaseLine."Drop Shipment" OR PurchaseLine."Special Order" OR NOT lInventPostGroup."Excess Receip Allow" OR
                       (((lInventPostGroup."Excess Receip (%)" / 100 + 1) * PurchaseLine."Quantity (Base)" < PurchaseLine."Qty. to Receive (Base)") AND
                        (lInventPostGroup."Excess Receip (%)" <> 0)) THEN BEGIN
                        IF PurchaseLine."Drop Shipment" OR PurchaseLine."Special Order" OR NOT lInventPostGroup."Excess Receip Allow" THEN
                            ERROR(
                              Text009,
                                    PurchaseLine."Outstanding Quantity");
                        ERROR(
                          Text009,
                          PurchaseLine."Outstanding Qty. (Base)" + (lInventPostGroup."Excess Receip (%)" / 100 * PurchaseLine."Quantity (Base)"));
                    END;
                END;

            end;

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateDirectUnitCostOnBeforeValidateLineDiscPct', '', true, true)]
    local procedure OnValidateDirectUnitCostOnBeforeValidateLineDiscPct(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateLineDiscountPercentOnAfterTestStatusOpen', '', true, true)]
    local procedure OnValidateLineDiscountPercentOnAfterTestStatusOpen39(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        Currency: Record Currency;

    begin

        //REMISE_FOURN
        IF CallingFieldNo = PurchaseLine.FIELDNO("Line Discount %") THEN BEGIN
            PurchaseLine."Discount 1 %" := PurchaseLine."Line Discount %";
            PurchaseLine."Discount 2 %" := 0;
            PurchaseLine."Discount 3 %" := 0;
        END;
        //REMISE_FOURN//
        //  end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnLineDiscountAmountOnValidateOnBeforeUpdateAmounts', '', true, true)]
    local procedure OnLineDiscountAmountOnValidateOnBeforeUpdateAmounts(var PurchaseLine: Record "Purchase Line")
    begin
        //REMISE_FOURN
        IF PurchaseLine."Discount 1 %" = 0 THEN BEGIN
            PurchaseLine."Discount 1 %" := PurchaseLine."Line Discount %";
            PurchaseLine."Discount 2 %" := 0;
            PurchaseLine."Discount 3 %" := 0;
        END;
        //REMISE_FOURN//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateJobNoOnBeforeGetJob', '', true, true)]
    local procedure OnValidateJobNoOnBeforeGetJob(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        Job: Record Job;


    begin
        if PurchLine."dysJob No." <> '' then
            Job.Get(PurchLine."dysJob No.")
        else
            Job.Get(PurchLine."Job No.");
        //+JOB+
        //ABZPurchLine.VALIDATE("Job Task No.", Job.gGetDefaultJobTask);
        PurchLine.VALIDATE("DysJob Task No.", Job.gGetDefaultJobTask);
        //+JOB+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeVerifyLineTypeForJob', '', true, true)]
    local procedure OnBeforeVerifyLineTypeForJob(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        Job: Record Job;
        lJobStatus: Record "Job Status";
        Text012: label 'must not be specified when %1 = %2';
    begin
        //+ABO+
        //#9002
        IF PurchaseLine.Type <> PurchaseLine.Type::Resource THEN BEGIN
            //#8300//
            IF NOT (PurchaseLine.Type IN [PurchaseLine.Type::Item, PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Note of Expenses", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"Charge (Item)"]) THEN
                //+NDF+,PROJET_IMMO//
                PurchaseLine.FIELDERROR("dysJob No.", STRSUBSTNO(Text012, PurchaseLine.FIELDCAPTION(Type), PurchaseLine.Type));
        END ELSE BEGIN
            //+ABO+//
            //#8300
            /*    {
                IF NOT (Type IN [Type::Item, Type::"G/L Account"]) THEN
//+NDF+
IF NOT (Type IN [Type::"Note of Expenses"]) THEN
//+NDF+//
//PROJET_IMMO
IF NOT (Type IN [Type::"Fixed Asset"]) THEN
                  //PROJET_IMMO//
                    //IF NOT (Type IN [Type::"Charge (Item)"]) THEN
                }*/
            IF (PurchaseLine.Type = PurchaseLine.Type::"Charge (Item)") THEN;
            //#8300
            //  IF Job.GET("Job No.") AND NOT (Job."Job Type" = Job."Job Type"::Stock) AND NOT lPurchOrderPost.fCheckAllItemStockJob(Rec) THEN
            /*      {
                     IF "Job No." <> '' THEN
IF Job.GET("Job No.") AND NOT (Job."Job Type" = Job."Job Type"::Stock) THEN
FIELDERROR("Job No.", STRSUBSTNO(Text037, FIELDCAPTION(Type) + ' ' + FORMAT(Job."Job Type")))
ELSE
lPurchOrderPost.fCheckAllItemStockJob(Rec);
                   }*/
            //#8300//
        END;
        //#9002//
        //PROJET
        //IF "Job No." <> '' THEN BEGIN
        Job.wCheckBlockedJob(PurchaseLine."dysJob No.");
        //JOB_STATUS
        /*GL2024 WITH lJobStatus DO
             Check(PurchaseLine."Job No.", PurchaseLine.FIELDNO(PurchaseLine."Purchase Order"));*/
        //JOB_STATUS//
        //END;
        //PROJET//

        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckDirectUnitCost', '', true, true)]
    local procedure OnBeforeCheckDirectUnitCost(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //#4967
        IF (PurchaseLine.Quantity = 1) AND (PurchaseLine."Direct Unit Cost" = 0) AND (PurchaseLine."Line Discount %" = 0) THEN
            PurchaseLine."Direct Unit Cost" := PurchaseLine."Line Amount";
        //#4967//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeInitOutstanding', '', true, true)]
    local procedure OnBeforeInitOutstanding(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        if PurchaseLine.IsCreditDocType() then begin
            PurchaseLine."Outstanding Quantity" := PurchaseLine.Quantity - PurchaseLine."Return Qty. Shipped";
            PurchaseLine."Outstanding Qty. (Base)" := PurchaseLine."Quantity (Base)" - PurchaseLine."Return Qty. Shipped (Base)";
            PurchaseLine."Return Qty. Shipped Not Invd." := PurchaseLine."Return Qty. Shipped" - PurchaseLine."Quantity Invoiced";
            PurchaseLine."Ret. Qty. Shpd Not Invd.(Base)" := PurchaseLine."Return Qty. Shipped (Base)" - PurchaseLine."Qty. Invoiced (Base)";
        end else begin
            PurchaseLine."Outstanding Quantity" := PurchaseLine.Quantity - PurchaseLine."Quantity Received";
            PurchaseLine."Outstanding Qty. (Base)" := PurchaseLine."Quantity (Base)" - PurchaseLine."Qty. Received (Base)";
            PurchaseLine."Qty. Rcd. Not Invoiced" := PurchaseLine."Quantity Received" - PurchaseLine."Quantity Invoiced";
            PurchaseLine."Qty. Rcd. Not Invoiced (Base)" := PurchaseLine."Qty. Received (Base)" - PurchaseLine."Qty. Invoiced (Base)";
        end;

        //+REF+SOLDE_CDE
        IF PurchaseLine."Completely Received" THEN BEGIN
            PurchaseLine."Outstanding Quantity" := 0;
            PurchaseLine."Outstanding Qty. (Base)" := 0;
        END ELSE
            //+REF+SOLDE_CDE//
            PurchaseLine."Completely Received" := (PurchaseLine.Quantity <> 0) and (PurchaseLine."Outstanding Quantity" = 0);

        PurchaseLine.InitOutstandingAmount();


        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInitOutstandingAmount', '', true, true)]
    local procedure OnAfterInitOutstandingAmount(var PurchLine: Record "Purchase Line"; xPurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; Currency: Record Currency)
    begin

        if PurchLine.Quantity = 0 then begin


            //PROJET_NATURE
            PurchLine."Outst. Amount Excl. VAT (LCY)" := 0;
            PurchLine."Amt.Rcd. Not Inv.Excl. VAT LCY" := 0;
            //PROJET_NATURE//
            //#5466
            PurchLine.VALIDATE("Engaged Cost (LCY)");
            //#5466//

        end else begin
            //PROJET_NATURE
            IF PurchLine."Document Type" = PurchLine."Document Type"::Order THEN BEGIN
                PurchLine.VALIDATE(
                  PurchLine."Outst. Amount Excl. VAT (LCY)",
                  ROUND(
                    PurchLine."Outstanding Amount" / (1 + PurchLine."VAT %" / 100),
                    Currency."Amount Rounding Precision"));
                PurchLine.VALIDATE(
                  "Amt.Rcd. Not Inv.Excl. VAT LCY",
                  ROUND(
                    PurchLine."Amt. Rcd. Not Invoiced" / (1 + PurchLine."VAT %" / 100),
                    Currency."Amount Rounding Precision"));
            END;
            //PROJET_NATURE//
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInitQtyToReceive', '', true, true)]
    local procedure OnAfterInitQtyToReceive(var PurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin


        IF (PurchLine."Qty. to Receive" < 0) AND (PurchLine.Quantity > 0) THEN
            PurchLine.VALIDATE("Completely Received", TRUE);

    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSalesCost', '', true, true)]
    local procedure OnBeforeUpdateSalesCost(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        lOrderLine: Record "Sales Line";
        lStructureLine: Record "Sales Line";
        lxRec: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        lItem: Record Item;
        lTotalNeedParameter: Record "Sales Document Cost";
        lInitialOfferLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        lSourceDocNo: Code[20];






    begin
        //#8877
        IF (PurchaseLine."Sales Document Type" <> "Sales Document Type"::Quote) THEN BEGIN
            //#8877  IF ("Sales Order Line No." <> 0) AND
            //#8877   ("Sales Document Type" <> "Sales Document Type"::Quote) AND
            //#8877   ("Sales Document Type" = 0) THEN BEGIN   // Subcontracting (2425 : mise … jour … la demande)
            CASE TRUE OF
                PurchaseLine."Sales Order Line No." <> 0:
                    // Drop Shipment
                    SalesOrderLine.GET(
                      SalesOrderLine."Document Type"::Order,
                     PurchaseLine."Sales Order No.",
                      PurchaseLine."Sales Order Line No.");
                PurchaseLine."Special Order Sales Line No." <> 0:
                    // Special Order
                    BEGIN
                        IF NOT
                          SalesOrderLine.GET(
                            SalesOrderLine."Document Type"::Order,
                            PurchaseLine."Special Order Sales No.",
                            PurchaseLine."Special Order Sales Line No.")
                        THEN
                            EXIT;
                    END;
                ELSE
                    EXIT;
            END;
            //#8877
            IF SalesOrderLine.Subcontracting = SalesOrderLine.Subcontracting::" " THEN BEGIN
                //#8877
                SalesOrderLine."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)" * SalesOrderLine."Qty. per Unit of Measure" / PurchaseLine."Qty. per Unit of Measure";
                SalesOrderLine."Unit Cost" := PurchaseLine."Unit Cost" * SalesOrderLine."Qty. per Unit of Measure" / PurchaseLine."Qty. per Unit of Measure";
                SalesOrderLine.VALIDATE("Unit Cost (LCY)");
                IF NOT PurchaseLine.RECORDLEVELLOCKING THEN
                    PurchaseLine.LOCKTABLE(TRUE, TRUE);
                SalesOrderLine.MODIFY();
                //#8877
                IF (SalesOrderLine."Order Type" = SalesOrderLine."Order Type"::"Supply Order") THEN BEGIN
                    lOrderLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
                    lOrderLine.SETRANGE("Supply Order No.", SalesOrderLine."Document No.");
                    lOrderLine.SETRANGE("Supply Order Line No.", SalesOrderLine."Line No.");
                    lOrderLine.SETRANGE("Structure Line No.", 0);
                    lOrderLine.SETRANGE("Drop Shipment", TRUE);
                    IF lOrderLine.FINDFIRST THEN BEGIN
                        lOrderLine."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)" * lOrderLine."Qty. per Unit of Measure" / PurchaseLine."Qty. per Unit of Measure";
                        lOrderLine."Unit Cost" := PurchaseLine."Unit Cost" * lOrderLine."Qty. per Unit of Measure" / PurchaseLine."Qty. per Unit of Measure";
                        lOrderLine.VALIDATE("Unit Cost (LCY)");
                        lOrderLine.MODIFY;
                    END;
                END ELSE
                    //#8877//
                    //DEVIS
                    IF lStructureLine.GET(SalesOrderLine."Document Type", SalesOrderLine."Document No.", SalesOrderLine."Structure Line No.") THEN BEGIN
                        lxRec := lStructureLine;
                        lStructureMgt.SumStructureLines(lStructureLine);
                        lStructureLine.MODIFY;
                        lStructureLine.wUpdateLine(lStructureLine, lxRec, FALSE);
                    END;
                //DEVIS//
                //#8877
            END;
            //#8877//
        END ELSE
            //CONSULT
            IF (PurchaseLine."Document Type" = PurchaseLine."Document Type"::Quote) AND
               ((PurchaseLine."Sales Order No." <> '') OR (PurchaseLine."Special Order Sales No." <> '')) AND
               (PurchaseLine.Type = PurchaseLine.Type::Item) THEN BEGIN
                PurchaseLine.GetPurchHeader;
                IF NOT lItem.GET(PurchaseLine."No.") THEN
                    lItem.INIT;
                IF PurchaseLine."Sales Order No." <> '' THEN
                    IF (lItem."Item Type" <> 0) OR (lItem.Subcontracting <> lItem.Subcontracting::" ") THEN BEGIN
                        IF NOT lTotalNeedParameter.GET(PurchaseLine."Sales Document Type" - 1, PurchaseLine."Sales Order No.", lTotalNeedParameter.Type::Item,
                                                        PurchaseLine."No.", PurchaseLine."Sales Order Line No.", PurchaseLine."Purchasing Code") THEN BEGIN
                            lTotalNeedParameter.INIT;
                            lTotalNeedParameter."Document Type" := PurchaseLine."Sales Document Type" - 1;
                            lTotalNeedParameter."Document No." := PurchaseLine."Sales Order No.";
                            lTotalNeedParameter.Type := lTotalNeedParameter.Type::Item;
                            lTotalNeedParameter."No." := PurchaseLine."No.";
                            lTotalNeedParameter."Line No." := PurchaseLine."Sales Order Line No.";
                            lTotalNeedParameter."Purchasing Code" := PurchaseLine."Purchasing Code";
                            lTotalNeedParameter.INSERT;
                        END;
                    END ELSE BEGIN
                        IF NOT lTotalNeedParameter.GET(PurchaseLine."Sales Document Type" - 1, PurchaseLine."Sales Order No.",
                                                        lTotalNeedParameter.Type::Item, PurchaseLine."No.", 0, PurchaseLine."Purchasing Code") THEN BEGIN
                            lTotalNeedParameter.INIT;
                            lTotalNeedParameter."Document Type" := PurchaseLine."Sales Document Type" - 1;
                            lTotalNeedParameter."Document No." := PurchaseLine."Sales Order No.";
                            lTotalNeedParameter.Type := lTotalNeedParameter.Type::Item;
                            lTotalNeedParameter."No." := PurchaseLine."No.";
                            lTotalNeedParameter."Purchasing Code" := PurchaseLine."Purchasing Code";
                            lTotalNeedParameter.INSERT;
                        END;
                    END;
                IF PurchaseLine."Special Order Sales No." <> '' THEN BEGIN
                    IF (lItem."Item Type" <> 0) OR (lItem.Subcontracting <> lItem.Subcontracting::" ") THEN BEGIN
                        IF NOT lTotalNeedParameter.GET(PurchaseLine."Sales Document Type" - 1, PurchaseLine."Special Order Sales No.", lTotalNeedParameter.Type::Item, PurchaseLine."No.",
                                                        PurchaseLine."Special Order Sales Line No.", PurchaseLine."Purchasing Code") THEN BEGIN
                            lTotalNeedParameter.INIT;
                            lTotalNeedParameter."Document Type" := PurchaseLine."Sales Document Type" - 1;
                            lTotalNeedParameter."Document No." := PurchaseLine."Special Order Sales No.";
                            lTotalNeedParameter.Type := lTotalNeedParameter.Type::Item;
                            lTotalNeedParameter."No." := PurchaseLine."No.";
                            lTotalNeedParameter."Line No." := PurchaseLine."Special Order Sales Line No.";
                            lTotalNeedParameter."Purchasing Code" := PurchaseLine."Purchasing Code";
                            lTotalNeedParameter.INSERT;
                        END;
                    END ELSE BEGIN
                        IF NOT lTotalNeedParameter.GET(PurchaseLine."Sales Document Type" - 1, PurchaseLine."Special Order Sales No.",
                                                       lTotalNeedParameter.Type::Item, PurchaseLine."No.", 0, PurchaseLine."Purchasing Code") THEN BEGIN
                            lTotalNeedParameter.INIT;
                            lTotalNeedParameter."Document Type" := PurchaseLine."Sales Document Type" - 1;
                            lTotalNeedParameter."Document No." := PurchaseLine."Sales Order No.";
                            lTotalNeedParameter.Type := lTotalNeedParameter.Type::Item;
                            lTotalNeedParameter."No." := PurchaseLine."No.";
                            lTotalNeedParameter."Purchasing Code" := PurchaseLine."Purchasing Code";
                            lTotalNeedParameter.INSERT;
                        END;
                    END;
                END;

                lSourceDocNo := PurchaseLine."Attached to Doc. No.";
                IF lSourceDocNo <> '' THEN
                    lInitialOfferLine.GET(lInitialOfferLine."Document Type"::Quote, lSourceDocNo, PurchaseLine."Line No.")
                ELSE
                    lInitialOfferLine.INIT;

                lTotalNeedParameter."Vendor No." := PurchaseLine."Buy-from Vendor No.";
                lTotalNeedParameter."Purchasing Document Type" := PurchaseLine."Document Type";
                IF lSourceDocNo <> '' THEN BEGIN
                    lTotalNeedParameter."Purchasing Order No." := lSourceDocNo;
                    lTotalNeedParameter."Vendor No." := lInitialOfferLine."Buy-from Vendor No.";
                END ELSE BEGIN
                    lTotalNeedParameter."Purchasing Order No." := PurchaseLine."Document No.";
                    lTotalNeedParameter."Vendor No." := PurchaseLine."Buy-from Vendor No.";
                END;
                lTotalNeedParameter."Purchasing Order Line No." := PurchaseLine."Line No.";
                if PurchHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
                    lTotalNeedParameter."Reference Purchase Quote" := PurchHeader."Your Reference";
                //Mise … jour … la demande    lTotalNeedParameter.VALIDATE(Value,"Unit Cost (LCY)");
                lTotalNeedParameter.MODIFY;
            END;
        //CONSULT//

        IsHandled := True;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterGetFAPostingGroup', '', true, true)]
    local procedure OnAfterGetFAPostingGroup39(var PurchaseLine: Record "Purchase Line"; GLAccount: Record "G/L Account")
    var
        FASetup: Record "FA Setup";

    begin
        //+REF+IMMOS
        IF FASetup."Default Depr. Book" = '' THEN   // pour ne pas refaire un GET
            FASetup.GET;
        PurchaseLine."Use Duplication List" := FASetup."Activate Duplication List";
        //+REF+IMMOS//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterTestStatusOpen', '', true, true)]
    local procedure OnAfterTestStatusOpen39(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header")
    begin
        //ACHAT
        PurchaseHeader.INIT;
        //ACHAT//
        //+ABO+
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Subscription THEN
            PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);
        //+ABO+//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCalcVATAmountLinesOnAfterCalcLineTotals', '', true, true)]
    local procedure OnCalcVATAmountLinesOnAfterCalcLineTotals(var VATAmountLine: Record "VAT Amount Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; Currency: Record Currency; QtyType: Option General,Invoicing,Shipping; var TotalVATAmount: Decimal)
    var
        PurchLine2: Record "Purchase Line";
        QtyToHandle: Decimal;
    begin
        case QtyType of
            //+REF+FACTURATION_ACHAT : (3455) Pour F11 commande achat
            -1:
                BEGIN
                    PurchLine2 := PurchaseLine;
                    CASE TRUE OF
                        (PurchaseLine."Document Type" IN [PurchaseLine."Document Type"::Order, PurchaseLine."Document Type"::Invoice]) AND
                        (NOT PurchaseHeader.Receive) AND PurchaseHeader.Invoice:
                            BEGIN
                                PurchLine2."Qty. to Receive" := 0;
                                PurchLine2.MODIFY;
                                PurchLine2.InitQtyToInvoice;
                                PurchaseLine."Qty. to Invoice" := PurchLine2."Qty. to Invoice";
                                QtyToHandle := PurchaseLine.GetAbsMin(PurchaseLine."Qty. to Invoice", PurchaseLine."Qty. Rcd. Not Invoiced") / PurchaseLine.Quantity;
                                VATAmountLine.Quantity :=
                                  VATAmountLine.Quantity + PurchaseLine.GetAbsMin(PurchaseLine."Qty. to Invoice (Base)", PurchaseLine."Qty. Rcd. Not Invoiced (Base)");
                            END;
                        (PurchaseLine."Document Type" IN [PurchaseLine."Document Type"::"Return Order", PurchaseLine."Document Type"::"Credit Memo"]) AND
                        (NOT PurchaseHeader.Ship) AND PurchaseHeader.Invoice:
                            BEGIN
                                QtyToHandle := PurchaseLine.GetAbsMin(PurchaseLine."Qty. to Invoice", PurchaseLine."Return Shpd. Not Invd.") / PurchaseLine.Quantity;
                                VATAmountLine.Quantity :=
                                  VATAmountLine.Quantity + PurchaseLine.GetAbsMin(PurchaseLine."Qty. to Invoice (Base)", PurchaseLine."Ret. Qty. Shpd Not Invd.(Base)");
                            END;
                        ELSE BEGIN
                            QtyToHandle := PurchaseLine."Qty. to Invoice" / PurchaseLine.Quantity;
                            VATAmountLine.Quantity := VATAmountLine.Quantity + PurchaseLine."Qty. to Invoice (Base)";
                        END;
                    END;
                    VATAmountLine."Line Amount" :=
                      VATAmountLine."Line Amount" +
                      ROUND(PurchaseLine."Line Amount" * QtyToHandle, Currency."Amount Rounding Precision");
                    IF PurchaseLine."Allow Invoice Disc." THEN
                        VATAmountLine."Inv. Disc. Base Amount" :=
                          VATAmountLine."Inv. Disc. Base Amount" +
                          ROUND(PurchaseLine."Line Amount" * QtyToHandle, Currency."Amount Rounding Precision");
                    VATAmountLine."Invoice Discount Amount" :=
                      VATAmountLine."Invoice Discount Amount" + PurchaseLine."Inv. Disc. Amount to Invoice";
                    VATAmountLine."VAT Difference" := VATAmountLine."VAT Difference" + PurchaseLine."VAT Difference";
                    VATAmountLine.MODIFY;
                END;
        //+REF+FACTURATION_ACHAT//
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCheckWarehouseOnBeforeShowDialog', '', true, true)]
    local procedure OnCheckWarehouseOnBeforeShowDialog(var PurchLine: Record "Purchase Line"; Location2: Record Location; var ShowDialog: Option " ",Message,Error; var DialogText: Text[50])
    var
        WhseSetup: Record "Warehouse Setup";
        WhseRequirementMsg: Label '%1 is required for this line. The entered information may be disregarded by warehouse activities.', Comment = '%1=Document';
        Text016: Label '%1 is required for %2 = %3.';
    begin
        case ShowDialog of
            ShowDialog::Message:
                //#8724
                IF NOT WhseSetup.GET OR WhseSetup."Require Receive" THEN
                    //#8724//
                    Message(WhseRequirementMsg, DialogText);
            ShowDialog::Error:
                Error(Text016, DialogText, PurchLine.FieldCaption("Line No."), PurchLine."Line No.")

        end;
        ShowDialog := ShowDialog::" ";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCreateTempJobJnlLine', '', true, true)]
    local procedure OnBeforeCreateTempJobJnlLine(var TempJobJournalLine: Record "Job Journal Line" temporary; PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; GetPrices: Boolean; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        PurchHeader: Record "Purchase Header";
        lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";


    begin

        PurchaseLine.GetPurchHeader();
        Clear(TempJobJournalLine);
        TempJobJournalLine.DontCheckStdCost();
        if PurchaseLine."DYSJob No." <> '' then
            TempJobJournalLine.Validate("Job No.", PurchaseLine."DYSJob No.")
        else
            TempJobJournalLine.Validate("Job No.", PurchaseLine."Job No.");
        //    TempJobJournalLine.Validate("Job No.", PurchaseLine."dysJob No.");
        // TempJobJournalLine.Validate("Job Task No.", PurchaseLine."Job Task No.");
        if PurchHeader.get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
            TempJobJournalLine.Validate("Posting Date", PurchHeader."Posting Date");
        TempJobJournalLine.SetCurrencyFactor(PurchaseLine."Job Currency Factor");
        if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
            TempJobJournalLine.Validate(Type, TempJobJournalLine.Type::"G/L Account")
        //+NDF+
        ELSE
            //DYS A VERIFIER
            // IF PurchaseLine.Type = PurchaseLine.Type::"Note of Expenses" THEN
            //     lNoteOfExpensesIntegr.SetPurchLineTmpJobJnlLine(PurchaseLine, TempJobJournalLine)

            // //+NDF+
            // else
            TempJobJournalLine.Validate(Type, TempJobJournalLine.Type::Item);

        IF PurchaseLine.Type = PurchaseLine.Type::Item THEN TempJobJournalLine.Validate("No.", PurchaseLine."No.");
        TempJobJournalLine.Validate(Quantity, PurchaseLine.Quantity);
        TempJobJournalLine.Validate("Variant Code", PurchaseLine."Variant Code");
        IF PurchaseLine.Type = PurchaseLine.Type::Item THEN TempJobJournalLine.Validate("Unit of Measure Code", PurchaseLine."Unit of Measure Code");

        if not GetPrices then begin
            if xPurchaseLine."Line No." <> 0 then begin
                TempJobJournalLine."Unit Cost" := xPurchaseLine."Unit Cost";
                TempJobJournalLine."Unit Cost (LCY)" := xPurchaseLine."Unit Cost (LCY)";
                TempJobJournalLine."Unit Price" := xPurchaseLine."Job Unit Price";
                TempJobJournalLine."Line Amount" := xPurchaseLine."Job Line Amount";
                TempJobJournalLine."Line Discount %" := xPurchaseLine."Job Line Discount %";
                TempJobJournalLine."Line Discount Amount" := xPurchaseLine."Job Line Discount Amount";
            end else begin
                TempJobJournalLine."Unit Cost" := PurchaseLine."Unit Cost";
                TempJobJournalLine."Unit Cost (LCY)" := PurchaseLine."Unit Cost (LCY)";
                TempJobJournalLine."Unit Price" := PurchaseLine."Job Unit Price";
                TempJobJournalLine."Line Amount" := PurchaseLine."Job Line Amount";
                TempJobJournalLine."Line Discount %" := PurchaseLine."Job Line Discount %";
                TempJobJournalLine."Line Discount Amount" := PurchaseLine."Job Line Discount Amount";
            end;
            TempJobJournalLine.Validate("Unit Price");
        end else
            TempJobJournalLine.Validate("Unit Cost (LCY)", PurchaseLine."Unit Cost (LCY)");

        IsHandled := true;
    end;





    //*************************************Table 49 ************************************************//

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPrepareSales', '', true, true)]
    local procedure OnAfterInvPostBufferPrepareSales(var SalesLine: Record "Sales Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    begin
        //PROJET
        InvoicePostBuffer."Job Task No." := InvoicePostBuffer."Job Task No.";
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPreparePurchase', '', true, true)]
    local procedure OnAfterInvPostBufferPreparePurchase(var PurchaseLine: Record "Purchase Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    begin
        //PROJET "VAT %" := PurchLine."VAT %";
        InvoicePostBuffer."Job Task No." := InvoicePostBuffer."Job Task No.";
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Invoice Post. Buffer", 'OnAfterInvPostBufferPrepareService', '', true, true)]
    local procedure OnAfterInvPostBufferPrepareService(var ServiceLine: Record "Service Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    begin
        //JOB_SERVICE
        InvoicePostBuffer."Job Task No." := ServiceLine."Job Task No.";
        InvoicePostBuffer.Quantity := ServiceLine."Qty. to Invoice (Base)";
        InvoicePostBuffer."Line Discount %" := ServiceLine."Line Discount %";
        //JOB_SERVICE//
    end;

    //*************************************Table 77 ************************************************//
    /*GL2024   [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnBeforePrint', '', true, true)]
       local procedure OnBeforePrint(ReportUsage: Integer; RecordVariant: Variant; CustomerNoFieldNo: Integer; var Handled: Boolean)
       var
           lSalesInvoiceHeader: Record 112;
           ReportSelection: Record 77;
           FinChrgMemoHeader: Record 302;
           test: Boolean;
           RecRefToPrint: RecordRef;
       begin


           if (FinChrgMemoHeader = RecordVariant) and (CustomerNoFieldNo = FinChrgMemoHeader.FieldNo("Customer No.")) then
               ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"F.C.Test");
           ReportSelection.SETFILTER("Report ID", '<>0');
           ReportSelection.ASCENDING := FALSE;
           //+REF+INVOICE
           //  ReportSelection.FIND('-');
           IF NOT ReportSelection.FIND('-') THEN BEGIN
               lSalesInvoiceHeader.SETVIEW(ReportSelection.GETVIEW);
               lSalesInvoiceHeader.SETRANGE("Print Document Type", DATABASE::"Finance Charge Memo Header");
               lSalesInvoiceHeader.PrintRecords(TRUE);
           END

       end;*/
    //*************************************Table 81 ************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLBalAccount', '', true, true)]


    //GL2024 local procedure OnAfterSetDescriptionFromGLAcc(var GenJournalLine: Record "Gen. Journal Line"; GLAccount: Record "G/L Account")
    local procedure OnAfterAccountNoOnValidateGetGLBalAccount(var GenJournalLine: Record "Gen. Journal Line"; GLAccount: Record "G/L Account")


    var

        VATPostingSetup: Record "VAT Posting Setup";

    begin

        //PROJET
        GenJournalLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
        GenJournalLine."Gen. Posting Type" := GLAccount."Gen. Posting Type";
        GenJournalLine."Gen. Bus. Posting Group" := GLAccount."Gen. Bus. Posting Group";
        GenJournalLine.VALIDATE("Job No.", GLAccount."Job No.");
        //PROJET//

        if not GenJournalLine.CopyVATSetupToJnlLines() then begin
            IF VATPostingSetup.GET(GLAccount."VAT Bus. Posting Group", GLAccount."VAT Prod. Posting Group") AND
                  (VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Full VAT") THEN BEGIN
                GenJournalLine."Gen. Posting Type" := GLAccount."Gen. Posting Type";
                GenJournalLine."VAT Bus. Posting Group" := GLAccount."VAT Bus. Posting Group";
                GenJournalLine."VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetCustomerAccountOnBeforeValidatePaymentTermsCode', '', true, true)]
    local procedure OnGetCustomerAccountOnBeforeValidatePaymentTermsCode(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; HideValidationDialog: Boolean)
    var
        lPaymentIntegration: Codeunit "Payment Integration";
        gAddOnLicencePermission: Codeunit IntegrManagement;


    begin
        //+PMT+PAYMENT
        //VALIDATE("Payment Bank Account",lPaymentMgt.GetCustDefBankCode(Cust."No."));
        //IF lPaymentMethod.GET(Cust."Payment Method Code") THEN
        //"Bill Type" := lPaymentMethod."Bill Type";
        IF gAddOnLicencePermission.HasPermissionPMT() THEN BEGIN
            lPaymentIntegration.GJLSetPmtBankAcc(GenJournalLine, Customer."No.", 0);
            lPaymentIntegration.GJLSetBillType(GenJournalLine, Customer."Payment Method Code");
        END;
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeCheckConfirmDifferentVendorAndPayToVendor', '', true, true)]
    local procedure OnBeforeCheckConfirmDifferentVendorAndPayToVendor(var GenJorunalLine: Record "Gen. Journal Line"; Vendor: Record Vendor; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        lPaymentIntegration: Codeunit "Payment Integration";
        gAddOnLicencePermission: Codeunit IntegrManagement;

    begin
        //+PMT+PAYMENT
        //VALIDATE("Payment Bank Account",lPaymentMgt.GetVendDefBankCode(Vend."No."));
        //IF lPaymentMethod.GET(Vend."Payment Method Code") THEN
        //"Bill Type" := lPaymentMethod."Bill Type";
        IF gAddOnLicencePermission.HasPermissionPMT() THEN BEGIN
            lPaymentIntegration.GJLSetPmtBankAcc(GenJorunalLine, Vendor."No.", 1);
            lPaymentIntegration.GJLSetBillType(GenJorunalLine, Vendor."Payment Method Code");
        END;
        //+PMT+PAYMENT//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetVendorAccount(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record Vendor; CallingFieldNo: Integer)
    var
        DtaMgt: Codeunit DtaMgt;
        DtaSetup: Record "DTA Setup";


    begin
        // CH2300.begin
        IF DtaSetup.READPERMISSION THEN
            DtaMgt.TransferVendorGlLine(GenJournalLine);
        // CH2300.end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetFAAccount', '', true, true)]
    local procedure OnAfterAccountNoOnValidateGetFAAccount(var GenJournalLine: Record "Gen. Journal Line"; var FixedAsset: Record "Fixed Asset"; CurrFieldNo: Integer)
    var
        FASetup: Record "FA Setup";
    begin
        //PROJET_IMMO
        GenJournalLine.VALIDATE("Job No.", FixedAsset."Job No.");
        //PROJET_IMMO//
        //+REF+IMMOS
        IF CurrFieldNo <> 0 THEN BEGIN
            IF FASetup."Default Depr. Book" = '' THEN   //Pour ‚viter un 'GET'
                FASetup.GET;
            GenJournalLine."Use Duplication List" := FASetup."Activate Duplication List";
        END;
        //+REF+IMMOS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetFAVATSetupOnBeforeCheckGLAcc', '', true, true)]

    local procedure OnGetFAVATSetupOnBeforeCheckGLAcc(var GenJournalLine: Record "Gen. Journal Line"; var GLAccount: Record "G/L Account")
    begin

        case GenJournalLine."FA Posting Type" of
            GenJournalLine."FA Posting Type"::"Acquisition Cost":
                //+REF+IMMOS
                GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::Purchase;
            //+REF+IMMOS//
            GenJournalLine."FA Posting Type"::Disposal:
                //+REF+IMMOS
                GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::Sale;
        //+REF+IMMOS//
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeBlankJobNo', '', true, true)]
    local procedure OnBeforeBlankJobNo(var GenJournalLine: Record "Gen. Journal Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        if CurrentFieldNo = GenJournalLine.FIELDNO("Bal. Account No.") then
            IsHandled := true;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateBalAccountNoOnBeforeAssignValue', '', true, true)]
    local procedure OnValidateBalAccountNoOnBeforeAssignValue(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";


    begin
        //BE_FINJNL
        if GenJnlTemplate.get(GenJournalLine."Journal Template Name") then begin
            IF GenJnlTemplate.Type = GenJnlTemplate.Type::Financial THEN
                GenJournalLine.TESTFIELD("Bal. Account No.", GenJnlTemplate."Bal. Account No.");
            //BE_FINJNL//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnGetGLBalAccountOnAfterSetDescription', '', true, true)]
    local procedure OnGetGLBalAccountOnAfterSetDescription(var GenJournalLine: Record "Gen. Journal Line"; GLAcc: Record "G/L Account")
    begin


        //PROJET
        GenJournalLine."Bal. Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
        GenJournalLine."Bal. Gen. Posting Type" := GLAcc."Gen. Posting Type";
        GenJournalLine."Bal. Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
        //PROJET//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateAmount', '', true, true)]
    local procedure OnAfterValidateAmount(var GenJnlLine: Record "Gen. Journal Line")
    var
        DtaSetup: Record "DTA Setup";
        DtaMgt: Codeunit DtaMgt;

    begin
        // CH2300.begin
        IF DtaSetup.READPERMISSION THEN
            IF GenJnlLine."Bank Code" <> '' THEN
                DtaMgt.ProcessGlRefNo(GenJnlLine);
        // CH2300.end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeCheckAccountTypeOnJobValidation', '', true, true)]
    local procedure OnBeforeCheckAccountTypeOnJobValidation(var IsHandled: Boolean; var GenJournalLine: Record "Gen. Journal Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeCheckBalAccountNoOnJobNoValidation', '', true, true)]
    local procedure OnBeforeCheckBalAccountNoOnJobNoValidation(var IsHandled: Boolean; var GenJournalLine: Record "Gen. Journal Line")
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateBalAccountTypeOnBeforeSetBalAccountNo', '', true, true)]
    local procedure OnValidateBalAccountTypeOnBeforeSetBalAccountNo(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        if GenJnlTemplate.get(GenJournalLine."Journal Template Name") then begin
            //BE_FINJNL
            IF GenJnlTemplate.Type = GenJnlTemplate.Type::Financial THEN
                GenJournalLine.TESTFIELD("Bal. Account Type", GenJnlTemplate."Bal. Account Type");
            //BE_FINJNL//
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnValidateJobTaskNoOnBeforeJobTaskIsSet', '', true, true)]
    local procedure OnValidateJobTaskNoOnBeforeJobTaskIsSet(var GenJournalLine: Record "Gen. Journal Line")
    begin
        //+ONE_JOB
        IF (GenJournalLine."Job Quantity" = 0) OR (ABS(GenJournalLine."Job Quantity") = 1) THEN
            //#7869 "Job Quantity" := 1;
            GenJournalLine."Job Quantity" := GenJournalLine.fSignJobQuantity(GenJournalLine."Amount (LCY)" - GenJournalLine."VAT Amount (LCY)" > 0);
        //#7869//
        //+ONE_JOB//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnUpdateLineBalanceOnAfterAssignBalanceLCY', '', true, true)]
    local procedure OnUpdateLineBalanceOnAfterAssignBalanceLCY(var BalanceLCY: Decimal; var GenJournalLine: Record "Gen. Journal Line")
    var
        BankAcc: Record "Bank Account";
        GenJnlTemplate: Record "Gen. Journal Template";
        wTestReportBE: Boolean;



    begin

        //BE_FINJNL//
        //BE_FINJNL
        IF GenJournalLine."Journal Template Name" <> GenJnlTemplate.Name THEN
            GenJnlTemplate.GET(GenJournalLine."Journal Template Name");
        IF (GenJnlTemplate.Type = GenJnlTemplate.Type::Financial) AND
           NOT wTestReportBE THEN
            //GL2024 wTestReportBE existe dans la table EXT dans la procédure UpdateLineBalanceTestReport(). Il faut vérifier qu'elle a une valeur dans le test.
            IF (GenJournalLine."Currency Code" <> '') AND
               (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"Bank Account")
            THEN BEGIN
                BankAcc.GET(GenJournalLine."Bal. Account No.");
                IF BankAcc."Currency Code" <> '' THEN
                    GenJournalLine."Balance (LCY)" := GenJournalLine.Amount
                ELSE
                    GenJournalLine."Balance (LCY)" := GenJournalLine."Amount (LCY)";
            END ELSE
                GenJournalLine."Balance (LCY)" := GenJournalLine."Amount (LCY)";
        //BE_FINJNL//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnSetUpNewLineOnBeforeIncrDocNo', '', true, true)]
    local procedure OnSetUpNewLineOnBeforeIncrDocNo(var GenJournalLine: Record "Gen. Journal Line"; LastGenJournalLine: Record "Gen. Journal Line"; var Balance: Decimal; var BottomLine: Boolean; var IsHandled: Boolean; var Rec: Record "Gen. Journal Line"; GenJnlBatch: Record "Gen. Journal Batch")
    var
        NoSeriesBatch: Codeunit "No. Series - Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
    begin
        //BE_FINJNL
        //     (Balance - LastGenJnlLine."Balance (LCY)" = 0) AND
        if GenJnlTemplate.GET(GenJournalLine."Journal Template Name") then begin
            IF BottomLine AND ((Balance - LastGenJournalLine."Balance (LCY)" = 0) OR (GenJnlTemplate.Type = GenJnlTemplate.Type::Financial)) AND NOT LastGenJournalLine.EmptyLine THEN
                GenJournalLine."Document No." := NoSeriesBatch.SimulateGetNextNo(GenJnlBatch."No. Series", Rec."Posting Date", GenJournalLine."Document No.");
            //GL2024  GenJournalLine."Document No." := INCSTR(GenJournalLine."Document No.");
        end;
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnSetApplyToAmountOnBeforeCustEntryEdit', '', true, true)]
    local procedure OnSetApplyToAmountOnBeforeCustEntryEdit(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        //#7817
        GenJournalLine.VALIDATE("Job No.", CustLedgerEntry."Job No.");
        //#7817//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCreateTempJobJnlLine', '', true, true)]
    local procedure OnAfterCreateTempJobJnlLine(var JobJournalLine: Record "Job Journal Line"; GenJournalLine: Record "Gen. Journal Line"; xGenJournalLine: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        //#7869
        IF GenJournalLine."Gen. Posting Type" = GenJournalLine."Gen. Posting Type"::Sale THEN
            JobJournalLine."Cost Factor" := 1;
        //#7869//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromGenJnlAllocation', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromGenJnlAllocation(GenJnlAllocation: Record "Gen. Jnl. Allocation"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //PROJET
        GenJournalLine."Job No." := GenJnlAllocation."Job No.";
        GenJournalLine."Job Task No." := GenJnlAllocation."Job Task No.";
        GenJournalLine."Job Quantity" := 1;
        GenJournalLine.VALIDATE("Job Total Cost (LCY)", GenJournalLine."Amount (LCY)");
        //PROJET//
    end;


    //*************************************Table 83************************************************//

    /* [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnValidateItemNoOnAfterGetItem', '', true, true)]
     local procedure OnValidateItemNoOnAfterGetItem(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
     begin
         // >> HJ SORO 04-06-2014
         ItemJournalLine."Shelf No." := Item."Emplacement DEPOT Z4";
         IF ItemJournalLine."Location Code" = 'DEPOT Z4' THEN ItemJournalLine."Shelf No." := Item."Emplacement DEPOT Z4";
         IF ItemJournalLine."Location Code" = 'MGHLOT13' THEN ItemJournalLine."Shelf No." := Item."Emplacement Bati Depot z4";
         IF ItemJournalLine."Location Code" = 'MGHLOT51' THEN ItemJournalLine."Shelf No." := Item."Emplacement MGH 51";
         IF ItemJournalLine."Location Code" = 'MGHLOT113' THEN ItemJournalLine."Shelf No." := Item."Emplacement MGH 113";
         // >> HJ SORO 04-06-2014
     end;*/

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyFromProdOrderLine', '', true, true)]
    local procedure OnAfterCopyFromProdOrderLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";

    begin
        //+REF+OF_MONO
        ProdOrderRtngLine.SETCURRENTKEY(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
        ProdOrderRtngLine.SETRANGE(Status, ProdOrderLine.Status::Released);
        /*GL2024      Le champ "Prod. Order No." n'est plus présent dans la table Item Journal Line
          ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Prod. Order No.");*/
        IF ProdOrderRtngLine.FIND('-') AND (ProdOrderRtngLine.COUNT = 1) THEN
            ItemJournalLine.VALIDATE("Operation No.", ProdOrderRtngLine."Operation No.");
        //+REF+OF_MONO//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnSetUpNewLineOnAfterFindItemJnlLine', '', true, true)]
    local procedure OnSetUpNewLineOnAfterFindItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var FirstItemJournalLine: Record "Item Journal Line"; var LastItemJnlLine: Record "Item Journal Line")
    var
        RecUserSetup: Record "User Setup";

    begin
        // >> HJ DSFT 23-03-2012
        IF RecUserSetup.GET(USERID) THEN
            ItemJournalLine."Work Center No." := RecUserSetup."Inventory Resp. Ctr. Filter";
        // >> HJ DSFT 23-03-2012
    end;

    //HS
    [EventSubscriber(ObjectType::Codeunit, codeunit::"User Setup Management", 'OnBeforeGetLocation', '', true, true)]

    local procedure OnBeforeGetLocation(DocType: Option Sales,Purchase,Service; AccLocation: Code[10]; RespCenterCode: Code[10]; var LocationCode: Code[10]; var IsHandled: Boolean)
    var
        UserRespCenter: Code[10];
        RespCenter: Record "Responsibility Center";
        CduUserSetupManagement: Codeunit "User Setup Management";
        UserSetup: Record "User Setup";
    begin
        IsHandled := true;

        case DocType of
            DocType::Sales:
                UserRespCenter := CduUserSetupManagement.GetSalesFilter();
            DocType::Purchase:
                UserRespCenter := CduUserSetupManagement.GetPurchasesFilter();
            DocType::Service:
                UserRespCenter := CduUserSetupManagement.GetServiceFilter();
        end;
        if UserRespCenter <> '' then
            RespCenterCode := UserRespCenter;
        if RespCenter.Get(RespCenterCode) then
            if RespCenter."Location Code" <> '' then
                LocationCode := RespCenter."Location Code";

        //  IF UserSetup.GET(UPPERCASE(USERID)) THEN
        //     IF UserSetup."Filtre Magasin" <> '' THEN
        //   LocationCode := UserSetup."Filtre Magasin";
        if AccLocation <> '' then
            LocationCode := AccLocation;

    end;

    //Hs

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnSetUpNewLineOnBeforeSetDefaultPriceCalculationMethod', '', true, true)]
    local procedure OnSetUpNewLineOnBeforeSetDefaultPriceCalculationMethod(var ItemJournalLine: Record "Item Journal Line"; ItemJnlBatch: Record "Item Journal Batch"; var DimMgt: Codeunit DimensionManagement)
    var
        ItemJnlTemplate: Record "Item Journal Template";

        RecUserSetup: Record "User Setup";

        CduNoSeriesRespCentManagement: Codeunit "NoSeriesRespCenterManagement";

    begin

        // >> HJ DSFT 23-03-2012
        IF RecUserSetup.GET(USERID) THEN ItemJournalLine."Work Center No." := RecUserSetup."Inventory Resp. Ctr. Filter";
        // >> HJ DSFT 23-03-2012

        if ItemJnlTemplate.get(ItemJournalLine."Journal Template Name") then begin
            // >> HJ DSFT 27-03-2012
            IF ItemJnlTemplate."Entry Type" <> 0 THEN ItemJournalLine."Entry Type" := ItemJnlTemplate."Entry Type";
            IF ItemJnlTemplate.Magasin <> '' THEN ItemJournalLine."Location Code" := ItemJnlTemplate.Magasin;
            IF ItemJnlTemplate."Feuille Affectaion Charge" THEN ItemJournalLine.Consommation := TRUE;
            // >> HJ DSFT 27-03-2012



        end;



        /*GL2024 NaviBat
                // >> HJ DSFT 23-03-2012
                IF ItemJournalLine."Work Center No." <> '' THEN
                    ItemJournalLine."Document No." := CduNoSeriesRespCentManagement.GetNextNo(ItemJnlBatch."No. Series",
                                                             ItemJournalLine."Posting Date", FALSE, ItemJournalLine."Work Center No.")
                ELSE
                    // >> HJ DSFT 23-03-2012
                    ItemJournalLine."Document No." := NoSeriesMgt.TryGetNextNo(ItemJnlBatch."No. Series", ItemJournalLine."Posting Date");
        */

    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnBeforeRetrieveCosts', '', true, true)]
    local procedure OnBeforeRetrieveCosts(var ItemJournalLine: Record "Item Journal Line"; var UnitCost: Decimal; var IsHandled: Boolean)
    begin

        IsHandled := true;
    end;



    //*************************************Table 111************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean; TempSalesLine: Record "Sales Line" temporary; SalesInvHeader: Record "Sales Header")
    var
        lSalesShipHeader: Record "Sales Shipment Header";
        lPresentationMgt: Codeunit "Presentation Management";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        Text000: label 'Shipment No. %1:';
        TextRef: label 'Ship. No. %1 - %3 / Your Ref %2 :';

    begin
        //DEVIS
        //  SalesLine.Description := STRSUBSTNO(Text000,"Document No.");
        IF NOT lSalesShipHeader.GET(SalesShptLine."Document No.") THEN
            lSalesShipHeader.INIT;
        SalesLine.Description := COPYSTR(STRSUBSTNO(Text000, SalesShptLine."Document No.", lSalesShipHeader."Posting Date"),
                                         1, MAXSTRLEN(SalesLine.Description));
        IF SalesOrderHeader."No." <> SalesShptLine."Order No." THEN
            SalesOrderHeader.GET(SalesOrderLine."Document Type"::Order, SalesShptLine."Order No.");
        IF SalesOrderHeader."External Document No." <> '' THEN
            SalesLine.Description := COPYSTR(STRSUBSTNO(TextRef, SalesShptLine."Document No.", SalesOrderHeader."External Document No.",
                                                lSalesShipHeader."Posting Date"), 1, MAXSTRLEN(SalesLine.Description));
        SalesLine."No." := '*';
        lPresentationMgt.CreateInvoicePresLevel(SalesLine);
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnInsertInvLineFromShptLineOnBeforeAssigneSalesLine', '', true, true)]
    local procedure OnInsertInvLineFromShptLineOnBeforeAssigneSalesLine(var SalesShipmentLine: Record "Sales Shipment Line"; SalesHeaderInv: Record "Sales Header"; SalesHeaderOrder: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesOrderLine: Record "Sales Line"; Currency: Record Currency)
    var
        lPresentationMgt: Codeunit "Presentation Management";
    begin
        //DEVIS
        IF SalesLine.Type <> SalesLine.Type::" " THEN
            SalesLine."Attached to Line No." := 0;
        lPresentationMgt.CreateInvoicePresLevel(SalesLine);
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnInsertInvLineFromShptLineOnAfterUpdatePrepaymentsAmounts', '', true, true)]
    local procedure OnInsertInvLineFromShptLineOnAfterCalcQuantities(var SalesLine: Record "Sales Line"; var SalesOrderLine: Record "Sales Line")
    var
        PrePaymentFraction: Decimal;

        Currency: Record Currency;
        lAttach: Integer;
    begin
        //DEVIS
        lAttach := SalesLine."Line No.";
        //DEVIS//
        //NAVISION
        SalesLine."Completely Shipped" := FALSE;
        //NAVISION//
        if Currency.get(SalesOrderLine."Currency Code") then begin
            PrePaymentFraction := SalesLine.Quantity / (SalesOrderLine.Quantity - SalesOrderLine."Quantity Invoiced");
            SalesLine."Prepmt. Line Amount" := ROUND(SalesOrderLine."Prepmt. Line Amount" * PrePaymentFraction,
                  Currency."Amount Rounding Precision");
            SalesLine."Prepmt. Amt. Inv." := ROUND(SalesOrderLine."Prepmt. Amt. Inv." * PrePaymentFraction,
            Currency."Amount Rounding Precision");
            SalesLine."Prepmt. Amt. Incl. VAT" := ROUND(SalesOrderLine."Prepmt. Amt. Incl. VAT" * PrePaymentFraction,
            Currency."Amount Rounding Precision");
            SalesLine."Prepayment Amount" := ROUND(SalesOrderLine."Prepayment Amount" * PrePaymentFraction,
            Currency."Amount Rounding Precision");
            SalesLine."Prepmt. VAT Base Amt." := ROUND(SalesOrderLine."Prepmt. VAT Base Amt." * PrePaymentFraction,
            Currency."Amount Rounding Precision");
            SalesLine."Prepmt. Amount Inv. Incl. VAT" := ROUND(SalesOrderLine."Prepmt. Amount Inv. Incl. VAT" * PrePaymentFraction,
            Currency."Amount Rounding Precision");

            SalesLine."Prepmt Amt to Deduct" :=
              ROUND(
                (SalesOrderLine."Prepmt. Amt. Inv." - SalesOrderLine."Prepmt Amt Deducted") * PrePaymentFraction,
                Currency."Amount Rounding Precision");
            //DEVIS//
        end


    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromShptLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean; var TransferOldExtTextLines: Codeunit "Transfer Old Ext. Text Lines")
    var
        lPresentationMgt: Codeunit "Presentation Management";
        lAttach: Integer;
    begin

        lAttach := SalesLine."Line No.";
        //DEVIS
        IF SalesLine."Line Type" = SalesLine."Line Type"::" " THEN BEGIN
            //DEVIS//
            IF SalesLine."Attached to Line No." = 0 THEN
                SalesLine."Attached to Line No." := lAttach;
        END;
        //DEVIS//



        //PRESENTATION-MGT
        lPresentationMgt.CreateInvoicePresLevel(SalesLine);
        //PRESENTATION-MGT
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterInsertInvLineFromShptLine', '', true, true)]
    local procedure OnAfterInsertInvLineFromShptLine(var SalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; var NextLineNo: Integer; SalesShipmentLine: Record "Sales Shipment Line")
    begin

        if (SalesShipmentLine.Type <> 0) then begin
            SalesShipmentLine."Attached to Line No." := 0
        end;
    end;


    //*************************************Table 112************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords(var ReportSelections: Record "Report Selections"; var SalesInvoiceHeader: Record "Sales Invoice Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    begin
        //+REF+DOCUMENT
        //  FIND('-');
        IF SalesInvoiceHeader.FINDFIRST THEN;
        //+REF+DOCUMENT//
    end;

    //*************************************Table 114************************************************//
    // GL2024 La procédure a changé entre NAV 2009 et BC 2024, la structure a changé

    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords114(var ReportSelections: Record "Report Selections"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    var
        lSalesInvoiceHeader: Record "Sales Invoice Header";
        lPostedDoc: Boolean;
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin

        lPostedDoc := SalesCrMemoHeader.FIND('-');

        IF ReportSelections.FIND('-') THEN BEGIN
            DocumentSendingProfile.TrySendToPrinter(
           DummyReportSelections.Usage::"S.Cr.Memo".AsInteger(), SalesCrMemoHeader, SalesCrMemoHeader.FieldNo("Bill-to Customer No."), ShowRequestPage);
            //#3182
        END
        ELSE BEGIN
            //#5618
            //#5868
            IF lPostedDoc THEN
                lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Posted Credit Memo")
            ELSE
                lSalesInvoiceHeader.SETRANGE("Print Document Type", lSalesInvoiceHeader."Print Document Type"::"Credit Memo");
            //#5868//
            lSalesInvoiceHeader.SETRANGE("No.", SalesCrMemoHeader.GETRANGEMIN("No."));
            //    lSalesInvoiceHeader.SETRANGE("No.",'');
            //    lSalesInvoiceHeader.SETRANGE("Rider to Order No.","No.");
            //#5618//
            lSalesInvoiceHeader.PrintRecords(TRUE);
        END;
        //#3182//
        IsHandled := true;
    end;


    //*************************************Table 121************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromRcptLineBeforeInsertTextLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; var NextLineNo: Integer; var Handled: Boolean)
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        Text8004101: label 'Order No. %1 - Receipt No. %2 - Shipment No. %3';
    begin

        //#7268
        //  PurchLine.Description := STRSUBSTNO(Text000,"Document No.");
        IF PurchRcptHeader.GET(PurchRcptLine."Document No.") THEN;
        PurchLine.Description := COPYSTR(
          //STRSUBSTNO(Text8004101, PurchRcptLine."Order No.", PurchRcptLine."Document No.", PurchRcptHeader."Vendor Shipment No."), 1, 100);
          STRSUBSTNO(Text8004101, PurchRcptLine."Order No.", PurchRcptLine."Document No.", PurchRcptHeader."Vendor Shipment No."), 1, 50);
        //#7268//
    end;


    // HS CREATE dIM Extraire Ligne Receipt
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromRcptLine1(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchLine.CreateDimFromDefaultDim(PurchLine.FieldNo("No."));
    end;
    // HS CREATE dIM Extraire Ligne Receipt
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnAfterCopyFromPurchRcptLine', '', true, true)]
    local procedure OnAfterCopyFromPurchRcptLine(var PurchaseLine: Record "Purchase Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; var TempPurchLine: Record "Purchase Line")
    begin
        //ACHAT
        PurchaseLine."Order No." := PurchRcptLine."Order No.";
        PurchaseLine."Job No." := PurchRcptLine."DYSJob No.";
        PurchaseLine."Job Task No." := PurchRcptLine."DYSJob Task No.";
        PurchaseLine."Job Planning Line No." := PurchaseLine."dysJob Planning Line No.";
        //ACHAT//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnInsertInvLineFromRcptLineOnBeforeValidateQuantity', '', true, true)]
    local procedure OnInsertInvLineFromRcptLineOnBeforeValidateQuantity(PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; var PurchInvHeader: Record "Purchase Header")
    begin
        //NAVISION
        PurchaseLine."Completely Received" := FALSE;
        //NAVISION//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', true, true)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean)

    begin
        //  PurchRcptLine."Job No." := PurchLine."dysJob No.";

    end;



    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        RecJobTask: Record "Job Task";

    begin
        // >> HJ SORO 03-03-2015
        IF PurchRcptLine.GET(PurchLine."Receipt No.", PurchLine."Receipt Line No.") THEN begin
            if PurchRcptLine."DYSJob No." <> '' then begin
                PurchLine."dysJob No." := PurchRcptLine."DysJob No.";
                PurchLine."DysJob Task No." := PurchRcptLine."DysJob Task No.";
                PurchLine."Job No." := PurchRcptLine."DysJob No.";
                PurchLine."Job Task No." := PurchRcptLine."dysJob Task No.";
                PurchLine."Job Planning Line No." := PurchRcptLine."DYSJob Planning Line No.";
                PurchLine."dysJob Planning Line No." := PurchRcptLine."DYSJob Planning Line No.";
            end else begin
                PurchLine."dysJob No." := PurchRcptLine."Job No.";
                PurchLine."DysJob Task No." := PurchRcptLine."Job Task No.";
                PurchLine."Job No." := PurchRcptLine."Job No.";
                RecJobTask.Reset();
                RecJobTask.SetRange("Job No.", PurchRcptLine."Job No.");
                if RecJobTask.FindFirst() then
                    PurchLine."Job Task No." := RecJobTask."Job Task No.";
                PurchLine."Job Planning Line No." := PurchRcptLine."DYSJob Planning Line No.";
                PurchLine."dysJob Planning Line No." := PurchRcptLine."DYSJob Planning Line No.";
            end;
            /*  else begin
                  // PurchLine."Job No." := PurchRcptLine."Job No.";
                  // if (PurchRcptLine."Job Task No." <> '') and (PurchRcptLine."Job Task No." <> '0') then begin
                  //     PurchLine."Job Task No." := PurchRcptLine."Job Task No.";
                  // end else begin
                  RecJobTask.Reset();
                  RecJobTask.SetRange("Job No.", PurchRcptLine."Job No.");
                  if RecJobTask.FindFirst() then
                      PurchLine."Job Task No." := RecJobTask."Job Task No.";

                  PurchLine."dysJob No." := PurchRcptLine."Job No.";
              end;*/

        end;
        PurchLine."Affectation Marche" := PurchRcptLine."Affectation Marche";
        PurchLine."Sous Affectation Marche" := PurchRcptLine."Sous Affectation Marche";
        // >> HJ SORO 03-03-2015
    end;


    //*************************************Table 122************************************************//
    // GL2024 La procédure a changé entre NAV 2009 et BC 2024, la structure a changé
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords122(var PurchInvHeader: Record "Purch. Inv. Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        Text8004101: label 'Order No. %1 - Receipt No. %2 - Shipment No. %3';
        ReportSelection: Record "Report Selections";
    begin
        //+NDF+
        PurchInvHeader.COPY(PurchInvHeader);
        //DYS REPORT ADDON NON MIGRER
        // IF PurchInvHeader.GET(PurchInvHeader.GETRANGEMIN("No.")) AND (PurchInvHeader."Applies-to Doc. Type" = PurchInvHeader."Applies-to Doc. Type"::"Note of Expenses") THEN BEGIN
        //     REPORT.RUNMODAL(REPORT::"Note of Expenses - Posted", ShowRequestpage, FALSE, PurchInvHeader)
        // END ELSE
        begin
            //+NDF+//
            PurchInvHeader.Copy(PurchInvHeader);
            ReportSelection.PrintWithDialogForVend(
              ReportSelection.Usage::"P.Invoice", PurchInvHeader, ShowRequestPage, PurchInvHeader.FieldNo("Buy-from Vendor No."));
        end;
        IsHandled := true;
    end;


    //*************************************Table 156************************************************//

    [EventSubscriber(ObjectType::Table, Database::Resource, 'OnBeforeOnInsert', '', true, true)]
    local procedure OnBeforeOnInsert156(var Resource: Record Resource; var IsHandled: Boolean; var xResource: Record Resource)
    var
        ResSetup: Record "Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        lResUnitOfMeasure: Record "Resource Unit of Measure";
        lCodeTranslation: Record Translation2;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        wReplicationRef: RecordRef;
        wReplicationTrigger: Codeunit "Replication Trigger";
    begin
        //+REF+TEMPLATE
        IF (Resource."No." = '') AND (Resource."No. Series" <> '') THEN
            NoSeriesMgt.InitSeries(Resource."No. Series", Resource."No. Series", 0D, Resource."No.", Resource."No. Series");
        //+REF+TEMPLATE//
        if Resource."No." = '' then begin
            //RESSOURCE
            ResSetup.Get();
            //  ResSetup.TestField("Resource Nos.");

            //  NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(ResSetup."Resource Nos.", xResource."No. Series", 0D, Resource."No.", Resource."No. Series", IsHandled);


            Resource."No. Series" := ResSetup."Resource Nos.";
            if NoSeries.AreRelated(Resource."No. Series", xResource."No. Series") then
                Resource."No. Series" := xResource."No. Series";
            Resource."No." := NoSeries.GetNextNo(Resource."No. Series");
            Resource.ReadIsolation(IsolationLevel::ReadUncommitted);
            Resource.SetLoadFields("No.");
            while Resource.Get(Resource."No.") do
                Resource."No." := NoSeries.GetNextNo(Resource."No. Series");
#if not CLEAN24
            CASE TRUE OF
                Resource.Type = Resource.Type::Person:
                    BEGIN
                        ResSetup.TESTFIELD("Person Nos.");
                        NoSeriesMgt.InitSeries(ResSetup."Person Nos.", xResource."No. Series", 0D, Resource."No.", Resource."No. Series");
                    END;
                Resource.Type = Resource.Type::Machine:
                    BEGIN
                        ResSetup.TESTFIELD("Machine Nos.");
                        NoSeriesMgt.InitSeries(ResSetup."Machine Nos.", xResource."No. Series", 0D, Resource."No.", Resource."No. Series");
                    END;
                Resource.Type = Resource.Type::Structure:
                    BEGIN
                        ResSetup.TESTFIELD("Structure Nos.");
                        NoSeriesMgt.InitSeries(ResSetup."Structure Nos.", xResource."No. Series", 0D, Resource."No.", Resource."No. Series");
                    END;
                //#6792
                ELSE BEGIN
                    ResSetup.TestField("Resource Nos.");
                    NoSeriesMgt.RaiseObsoleteOnAfterInitSeries(Resource."No. Series", ResSetup."Resource Nos.", 0D, Resource."No.");
                end;
#endif
            end;
        end;

        if Resource.GetFilter("Resource Group No.") <> '' then
            if Resource.GetRangeMin("Resource Group No.") = Resource.GetRangeMax("Resource Group No.") then
                Resource.Validate("Resource Group No.", Resource.GetRangeMin("Resource Group No."));
        //RESSOURCE
        IF Resource.Type = Resource.Type::Structure THEN
            Resource."Automatic Ext. Texts" := TRUE;

        lCodeTranslation.SETRANGE(TableID, 156);
        lCodeTranslation.SETRANGE(FieldID, 1);
        lCodeTranslation.SETRANGE(Code, Resource."No.");
        IF NOT lCodeTranslation.ISEMPTY THEN
            lCodeTranslation.DELETEALL;
        //RESSOURCE//
        DimMgt.UpdateDefaultDim(
          DATABASE::Resource, Resource."No.",
          Resource."Global Dimension 1 Code", Resource."Global Dimension 2 Code");
        //GL2024
        UpdateResourceUnitGroup();

        //+REF+UNIT
        IF Resource."Base Unit of Measure" <> '' THEN BEGIN
            lResUnitOfMeasure.INIT;
            lResUnitOfMeasure."Resource No." := Resource."No.";
            lResUnitOfMeasure.Code := Resource."Base Unit of Measure";
            lResUnitOfMeasure."Qty. per Unit of Measure" := 1;
            IF lResUnitOfMeasure.INSERT THEN
                Resource.VALIDATE("Base Unit of Measure");
        END;
        //+REF+UNIT//
        //REPLIC
        wReplicationRef.GETTABLE(Resource);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //REPLIC//

        IsHandled := true;
    end;






    //GL2024/////////////////////////////////////
    local procedure UpdateResourceUnitGroup()
    var
        UnitGroup: Record "Unit Group";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        Resource: Record Resource;
    begin
        if IsIntegrationEnabled() then begin
            UnitGroup.SetRange("Source Id", Resource.SystemId);
            UnitGroup.SetRange("Source Type", UnitGroup."Source Type"::Resource);
            if UnitGroup.IsEmpty() then begin
                UnitGroup.Init();
                UnitGroup."Source Id" := Resource.SystemId;
                UnitGroup."Source No." := Resource."No.";
                UnitGroup."Source Type" := UnitGroup."Source Type"::Resource;
                UnitGroup.Insert();
            end;
        end
    end;

    procedure IsIntegrationEnabled(): Boolean
    var
        CRMConnectionSentup: Record "CRM Connection Setup";
    begin
        if not CRMConnectionSentup.ReadPermission() then
            exit(false);

        if not CRMConnectionSentup.Get() then
            exit(false);

        if not CRMConnectionSentup."Is Enabled" then
            exit(false);

        exit(true);
    end;


    //GL2024////////////////////


    [EventSubscriber(ObjectType::Table, Database::Resource, 'OnBeforeAssistEdit', '', true, true)]
    local procedure OnBeforeAssistEdit(var Resource: Record Resource; xOldRes: Record Resource; var IsHandled: Boolean; var Result: Boolean)
    var

        Res: Record Resource;
        ResSetup: Record "Resources Setup";
        lResNos: Code[20];
        NoSeries: Codeunit "No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Res := Resource;
        ResSetup.Get();
        //+ONE+
        CASE Res.Type OF
            Res.Type::Person:
                BEGIN
                    ResSetup.TESTFIELD("Person Nos.");
                    lResNos := ResSetup."Person Nos.";
                END;
            Res.Type::Machine:
                BEGIN
                    ResSetup.TESTFIELD("Machine Nos.");
                    lResNos := ResSetup."Machine Nos.";
                END;
            Res.Type::Structure:
                BEGIN
                    ResSetup.TESTFIELD("Structure Nos.");
                    lResNos := ResSetup."Structure Nos.";
                END;
            ELSE BEGIN
                ResSetup.TestField("Resource Nos.");
                lResNos := ResSetup."Structure Nos.";
            END;
        END;
        //+ONE+//
        //  ResSetup.TESTFIELD("Resource Nos.");
        //+ONE+
        if NoSeries.LookupRelatedNoSeries(ResSetup."Resource Nos.", xOldRes."No. Series", Res."No. Series") then begin


            Res."No." := NoSeries.GetNextNo(Res."No. Series");
            Resource := Res;
            IsHandled := true;
        end;
        IsHandled := true;
    end;

    //*************************************Table 207************************************************//
    /*GL2024   [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterFindResUnitCost', '', true, true)]
       local procedure OnAfterFindResUnitCost207(var ResJournalLine: Record "Res. Journal Line"; var ResourceCost: Record "Resource Cost")
       var
           ResCost: Record 8004162;
       begin
           //POINTAGE
           ResCost."Starting Date" := ResJournalLine."Posting Date";
           //POINTAGE//
       end;*/

    //*************************************Table 246************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnValidateNoOnAfterAssignFieldsForNo', '', true, true)]
    local procedure OnValidateNoOnAfterAssignFieldsForNo(var RequisitionLine: Record "Requisition Line"; xRequisitionLine: Record "Requisition Line")
    var
        ItemCharge: Record "Item Charge";
        FixedAsset: Record "Fixed Asset";

    begin
        case RequisitionLine.Type of
            RequisitionLine.Type::"Charge (Item)":
                BEGIN
                    ItemCharge.GET(RequisitionLine."No.");
                    RequisitionLine.Description := ItemCharge.Description;
                END;
            RequisitionLine.Type::"Fixed Asset":
                BEGIN
                    FixedAsset.GET(RequisitionLine."No.");
                    RequisitionLine.Description := FixedAsset.Description;
                END;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterUpdateDescription', '', true, true)]
    local procedure OnAfterUpdateDescription(var RequisitionLine: Record "Requisition Line"; Item: Record Item; ItemVariant: Record "Item Variant"; FieldNo: Integer)
    begin
        if RequisitionLine."Variant Code" = '' then begin
            Item.Get(RequisitionLine."No.");
            //#5185
            //#7199
            IF FieldNo = RequisitionLine.FIELDNO("Vendor No.") THEN
                //#7199//
                IF (Item."Item Type" <> Item."Item Type"::" ") OR (RequisitionLine.Description = '') THEN
                    EXIT;
            //#5185//
        end;
    end;
    //*************************************Table 304************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Issued Fin. Charge Memo Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords304(var IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header"; ShowRequestForm: Boolean; SendAsEmail: Boolean; HideDialog: Boolean; var IsHandled: Boolean)
    var
        lSalesInvoiceHeader: Record 112;
        ReportSelection: Record 77;
    begin
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Fin.Charge");
        ReportSelection.SETFILTER("Report ID", '<>0');
        //+REF+INVOICE
        //  ReportSelection.FIND('-');
        IF NOT ReportSelection.FIND('-') THEN BEGIN
            lSalesInvoiceHeader.SETVIEW(IssuedFinChargeMemoHeader.GETVIEW);
            lSalesInvoiceHeader.SETRANGE("Print Document Type", DATABASE::"Issued Fin. Charge Memo Header");
            lSalesInvoiceHeader.PrintRecords(TRUE);
            IsHandled := true;
        END;
    end;

    //*************************************Table 5050************************************************//
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeUpdateCompanyNo', '', true, true)]
    local procedure OnBeforeUpdateCompanyNo(var Contact: Record Contact; xContact: Record Contact)
    begin
        //+REF+CRM
        IF Contact."Company No." = xContact."Company No." THEN
            EXIT;
        //+REF+CRM
    end;




    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeVendorInsert', '', true, true)]
    local procedure OnBeforeVendorInsert(var Vend: Record Vendor; var Contact: Record Contact; VendorTemplateCode: Code[20])
    var
        lRecordRef: RecordRef;
        lInitValueMgt: Codeunit "Config. Template Management";
    begin
        //+REF+TEMPLATE
        lRecordRef.GETTABLE(Vend);
        //lInitValueMgt.UpdateFromTemplateSelection(lRecordRef);
        //DYS fonction standard supprimer
        //    lInitValueMgt.GetTemplate(lRecordRef);
        lRecordRef.SETTABLE(Vend);
        //+REF+TEMPLATE//
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeUpdateSearchName', '', true, true)]
    local procedure OnBeforeUpdateSearchName(var Contact: Record Contact; xContact: Record Contact; var IsHandled: Boolean)
    begin
        //+REF+SEARCH_NAME
        IF (Contact.Type = Contact.Type::Person) AND
           ((Contact."Search Name" = UPPERCASE(xContact.Name)) OR (Contact."Search Name" = '') OR
            (Contact."Search Name" = UPPERCASE(xContact.Surname) + ' ' + UPPERCASE(xContact."First Name"))) THEN
            Contact."Search Name" := Contact.Surname + ' ' + Contact."First Name"
        ELSE
            if (Contact."Search Name" = UpperCase(xContact.Name)) or (Contact."Search Name" = '') then
                Contact."Search Name" := Contact.Name;
        //+REF+SEARCH_NAME//

        IsHandled := true;
    end;



    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeChooseNewCustomerTemplate', '', true, true)]
    local procedure OnBeforeChooseNewCustomerTemplate(var Contact: Record Contact; var CustTemplateCode: Code[20]; var IsHandled: Boolean)
    var
        ContBusRel: Record "Contact Business Relation";
        Text019: Label 'The %2 record of the %1 already has the %3 with %4 %5.';
        CreateCustomerFromContactQst: Label 'Do you want to create a contact as a customer using a customer template?';
        CustTemplate: Record "Customer Templ.";
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        Text022: Label 'The creation of the customer has been aborted.';
        HideValidationDialog: Boolean;
    begin
        HideValidationDialog := contact.GetHideValidationDialog();
        Contact.CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
        ContBusRel.Reset();
        ContBusRel.SetRange("Contact No.", Contact."No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::Customer);
        if ContBusRel.FindFirst() then
            Error(
              Text019,
               Contact.TableCaption, Contact."No.", ContBusRel.TableCaption(), ContBusRel."Link to Table", ContBusRel."No.");

        IsHandled := false;
        //+REF+CRM
        IF Contact."Sell-to Customer Template Code" <> '' THEN
            CustTemplateCode := Contact."Sell-to Customer Template Code"
        ELSE
            //+REF+CRM//
            if not IsHandled then
                if not HideValidationDialog then
                    if Confirm(CreateCustomerFromContactQst, true) then begin
                        CustTemplate.SetRange("Contact Type", Contact.Type);
                        if CustomerTemplMgt.SelectCustomerTemplate(CustTemplate) then
                            CustTemplateCode := CustTemplate.Code;

                        Error(Text022);
                    end;


        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterTypeChange', '', true, true)]
    local procedure OnAfterTypeChange(var Contact: Record Contact)
    begin
        case Contact.Type of
            Contact.Type::Company:
                begin
                    //#7807
                    Contact."Lookup Contact No." := '';
                    //#7807//
                end;
            Contact.Type::Person:
                begin
                    //#7807
                    Contact."Lookup Contact No." := Contact."No.";
                    //#7807//
                end;

        end;
    end;
    //*************************************Table 5065************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Interaction Log Entry", 'OnOpenAttachmentOnBeforeShowAttachment', '', true, true)]
    local procedure OnOpenAttachmentOnBeforeShowAttachment(var InteractionLogEntry: Record "Interaction Log Entry"; var SegmentLine: Record "Segment Line"; var Attachment: Record Attachment)
    begin
        //+REF+MAILING
        SegmentLine."Document Type" := InteractionLogEntry."Document Type";
        SegmentLine."Document No." := InteractionLogEntry."Document No.";
        SegmentLine."Version No." := InteractionLogEntry."Version No.";
        SegmentLine."Doc. No. Occurrence" := InteractionLogEntry."Doc. No. Occurrence";
        SegmentLine.TableID := InteractionLogEntry.TableID;
        SegmentLine."Document Line No." := InteractionLogEntry."Document Line No.";
        //+REF+MAILING//
    end;

    //*************************************Table 5077************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Segment Line", 'OnCreateInteractionFromInteractLogEntryOnBeforeStartWizard', '', true, true)]
    local procedure OnCreateInteractionFromInteractLogEntryOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var InteractionLogEntry: Record "Interaction Log Entry")
    begin
        //#8915
        IF (InteractionLogEntry.GETFILTER("Interaction Template Code") <> '') THEN BEGIN
            SegmentLine."Interaction Template Code" := InteractionLogEntry.GETFILTER("Interaction Template Code");
            SegmentLine.SETRANGE("Interaction Template Code", SegmentLine."Interaction Template Code");
        END;
        //#8915//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Segment Line", 'OnBeforeRunCreateInteraction', '', true, true)]
    local procedure OnBeforeRunCreateInteraction(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
        //CAUTION
        IF SegmentLine."Interaction Template Code" <> '' THEN
            SegmentLine.VALIDATE("Interaction Template Code");
        //CAUTION//
    end;

    //*************************************Table 5092************************************************//
    [EventSubscriber(ObjectType::Table, Database::Opportunity, 'OnCreateOppFromOppOnBeforeSetFilterSalesPersonCode', '', true, true)]
    local procedure OnCreateOppFromOppOnBeforeSetFilterSalesPersonCode(var Opportunity: Record Opportunity; var IsHandled: Boolean)
    var
        lOpport: Record Opportunity;
        lInterLogEntry: Record "Interaction Log Entry";
        lSalesCycleStage: Record "Sales Cycle Stage";
        lToDo: Record "To-do";
        lOppNo: Code[20];
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //+REF+OPPORT
        lSingleInstance.GetOpportunityNo(lOppNo);
        IF NOT lOpport.GET(lOppNo) THEN
            EXIT;
        lOpport.CALCFIELDS("Current Sales Cycle Stage");
        IF lSalesCycleStage.GET(lOpport."Sales Cycle Code", lOpport."Current Sales Cycle Stage") THEN
            CASE lSalesCycleStage.Create OF
                lSalesCycleStage.Create::Quote:
                    IF lOpport."Sales Document No." = '' THEN
                        //GL2024  lOpport.AssignQuote;
                        //GL2024
                        lOpport.CreateQuote;
                //GL2024
                lSalesCycleStage.Create::Interaction:
                    BEGIN
                        lInterLogEntry.SETRANGE("Contact Company No.", lOpport."Contact Company No.");
                        lInterLogEntry.SETRANGE("Contact No.", lOpport."Contact No.");
                        lInterLogEntry.SETRANGE("Campaign No.", lOpport."Campaign No.");
                        lInterLogEntry.SETRANGE("Opportunity No.", lOpport."No.");
                        lInterLogEntry.SETRANGE("Interaction Template Code", lSalesCycleStage."Interaction Template");
                        lInterLogEntry.SETRANGE("Segment No.", lOpport."Segment No.");
                        lInterLogEntry.CreateInteraction;
                    END;
                lSalesCycleStage.Create::"To-Do":
                    BEGIN
                        lToDo.SETRANGE("Opportunity No.", lOpport."No.");
                        //GL2024 lToDo.CreateToDoFromToDo(lToDo);
                        lToDo.CreateTaskFromTask(lToDo);
                    END;
            END;
        //+REF+OPPORT//
    end;

    [EventSubscriber(ObjectType::Table, Database::Opportunity, 'OnAfterInsertOpportunity', '', true, true)]
    local procedure OnAfterInsertOpportunity(var Opportunity: Record Opportunity)
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //+REF+OPPORT
        lSingleInstance.SetOpportunityNo(Opportunity."No.");
        //+REF+OPPORT// 
    end;

    [EventSubscriber(ObjectType::Table, Database::Opportunity, 'OnCreateQuoteOnBeforeSalesHeaderInsert', '', true, true)]
    local procedure OnCreateQuoteOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header"; Opportunity: Record Opportunity)
    var
        Cont: Record Contact;
    begin
        Cont.Get(Opportunity."Contact No.");

        //+REF+OPPORT
        //  SalesHeader.INSERT(TRUE);
        SalesHeader."Posting Description" := Opportunity.Description;
        SalesHeader."Responsibility Center" := Opportunity."Responsibility Center";
        SalesHeader."Sell-to Customer Templ. Code" := Cont."Sell-to Customer Template Code";
        SalesHeader."Shortcut Dimension 1 Code" := Opportunity."Shortcut Dimension 1 Code";
        SalesHeader."Shortcut Dimension 2 Code" := Opportunity."Shortcut Dimension 2 Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::Opportunity, 'OnCreateQuoteOnAfterSalesHeaderInsert', '', true, true)]
    local procedure OnCreateQuoteOnAfterSalesHeaderInsert(var SalesHeader: Record "Sales Header"; Opportunity: Record Opportunity)
    begin
        SalesHeader.VALIDATE("Responsibility Center");
        IF SalesHeader."Sell-to Customer Templ. Code" <> '' THEN
            SalesHeader.VALIDATE("Sell-to Customer Templ. Code");
        SalesHeader.VALIDATE("Shortcut Dimension 1 Code");
        SalesHeader.VALIDATE("Shortcut Dimension 2 Code");
        //+REF+OPPORT//

        //+REF+OPPORT
        SalesHeader."Posting Description" := Opportunity.Description;
        //+REF+OPPORT//
        //DEVIS
        SalesHeader.Subject := Opportunity.Description;
        //DEVIS//
    end;

    [EventSubscriber(ObjectType::Table, Database::Opportunity, 'OnBeforeCheckStatus', '', true, true)]

    local procedure OnBeforeCheckStatus(var Opportunity: Record Opportunity; var OppEntry: Record "Opportunity Entry"; var IsHandled: Boolean)
    var
        SegmentHeader: Record "Segment Header";
        Text023: Label 'You must fill in the contact that is involved in the opportunity.';
        Text024: Label '%1 must be greater than 0.';
        Text025: Label 'The Estimated closing date has to be later than this change';
        lSalesCycle: Record 5091;
    begin
        if Opportunity."Creation Date" = 0D then
            ErrorMessage(Opportunity.FieldCaption("Creation Date"));
        if Opportunity.Description = '' then
            ErrorMessage(Opportunity.FieldCaption(Description));

        if not SegmentHeader.Get(Opportunity.GetFilter("Segment No.")) then
            if Opportunity."Contact No." = '' then
                Error(Text023);
        if Opportunity."Salesperson Code" = '' then
            ErrorMessage(Opportunity.FieldCaption("Salesperson Code"));
        if Opportunity."Sales Cycle Code" = '' then
            ErrorMessage(Opportunity.FieldCaption("Sales Cycle Code"));

        if Opportunity."Activate First Stage" then begin
            //+REF+OPPORT
            lSalesCycle.SETRANGE("Sales Cycle Code", Opportunity."Sales Cycle Code");
            IF lSalesCycle.FINDFIRST THEN;
            IF NOT lSalesCycle."Estimate optional" THEN BEGIN
                //+REF+OPPORT//
                if Opportunity."Wizard Estimated Value (LCY)" <= 0 then
                    Error(Text024, Opportunity.FieldCaption("Wizard Estimated Value (LCY)"));
                if Opportunity."Wizard Chances of Success %" <= 0 then
                    Error(Text024, Opportunity.FieldCaption("Wizard Chances of Success %"));
                if Opportunity."Wizard Estimated Closing Date" = 0D then
                    ErrorMessage(Opportunity.FieldCaption("Wizard Estimated Closing Date"));
                if Opportunity."Wizard Estimated Closing Date" < OppEntry."Date of Change" then
                    Error(Text025);
                //+REF+OPPORT
            END;
            //+REF+OPPORT//
        end;
        IsHandled := true;
    end;

    procedure ErrorMessage(FieldName: Text[1024])
    var

        Text022: Label 'You must fill in the %1 field.';
    begin
        Error(Text022, FieldName);
    end;

    //*************************************Table 5093************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Opportunity Entry", 'OnUpdateEstimatesOnBeforeModifyOpportunityEntry', '', true, true)]
    local procedure OnUpdateEstimatesOnBeforeModifyOpportunityEntry(var OpportunityEntry: Record "Opportunity Entry"; SalesHeader: Record "Sales Header")
    var
        Opp: Record Opportunity;
    begin
        //#5453
        Opp.GET(OpportunityEntry."Opportunity No.");
        IF SalesHeader.GET(SalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN
            OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesHeader)
        ELSE
            OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry."Estimated Value (LCY)";
        //#5453//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Opportunity Entry", 'OnBeforeUpdateEstimates', '', true, true)]
    local procedure OnBeforeUpdateEstimates(var OpportunityEntry: Record "Opportunity Entry"; var IsHandled: Boolean)
    var
        SalesCycleStage: Record "Sales Cycle Stage";
        SalesCycle: Record "Sales Cycle";
        Opp: Record Opportunity;
        SalesHeader: Record "Sales Header";
    begin
        if SalesCycleStage.Get(OpportunityEntry."Sales Cycle Code", OpportunityEntry."Sales Cycle Stage") then begin
            SalesCycle.Get(OpportunityEntry."Sales Cycle Code");
            if (OpportunityEntry."Chances of Success %" = 0) and (SalesCycleStage."Chances of Success %" <> 0) then
                OpportunityEntry."Chances of Success %" := SalesCycleStage."Chances of Success %";
            OpportunityEntry."Completed %" := SalesCycleStage."Completed %";
            case SalesCycle."Probability Calculation" of
                SalesCycle."Probability Calculation"::Multiply:
                    OpportunityEntry."Probability %" := OpportunityEntry."Chances of Success %" * OpportunityEntry."Completed %" / 100;
                SalesCycle."Probability Calculation"::Add:
                    OpportunityEntry."Probability %" := (OpportunityEntry."Chances of Success %" + OpportunityEntry."Completed %") / 2;
                SalesCycle."Probability Calculation"::"Chances of Success %":
                    OpportunityEntry."Probability %" := OpportunityEntry."Chances of Success %";
                SalesCycle."Probability Calculation"::"Completed %":
                    OpportunityEntry."Probability %" := OpportunityEntry."Completed %";
            end;
            OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry."Estimated Value (LCY)" * OpportunityEntry."Probability %" / 100;
            if (OpportunityEntry."Estimated Close Date" = OpportunityEntry."Date of Change") or (OpportunityEntry."Estimated Close Date" = 0D) then
                OpportunityEntry."Estimated Close Date" := CalcDate(SalesCycleStage."Date Formula", OpportunityEntry."Date of Change");
        end;
        //#5453
        Opp.GET(OpportunityEntry."Opportunity No.");
        IF SalesHeader.GET(SalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN
            OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesHeader)
        ELSE
            OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry."Estimated Value (LCY)";
        //#5453//
        case OpportunityEntry."Action Taken" of
            OpportunityEntry."Action Taken"::Won:
                begin
                    /*  Opp.Get(OpportunityEntry."Opportunity No.");
                      if SalesHeader.Get(SalesHeader."Document Type"::Quote, Opp."Sales Document No.") then
                          OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesHeader);
                      */
                    OpportunityEntry."Completed %" := 100;
                    OpportunityEntry."Chances of Success %" := 100;
                    OpportunityEntry."Probability %" := 100;
                end;
            OpportunityEntry."Action Taken"::Lost:
                begin
                    //    OpportunityEntry."Calcd. Current Value (LCY)" := 0;
                    OpportunityEntry."Completed %" := 100;
                    OpportunityEntry."Chances of Success %" := 0;
                    OpportunityEntry."Probability %" := 0;
                end;
        end;

        OpportunityEntry.Modify();

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Opportunity Entry", 'OnBeforeGetSalesDocValue', '', true, true)]
    local procedure OnBeforeGetSalesDocValue(SalesHeader: Record "Sales Header"; var Result: Decimal; var IsHandled: Boolean)

    var
        lUpdateF9: Codeunit "Update F9";
        lSalesLine: Record "Sales Line";
        wMargin: Decimal;
    begin
        //DEVIS
        lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option,
                   Disable, "Gen. Prod. Posting Group", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        lSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        lSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        lSalesLine.SETRANGE("Structure Line No.", 0);
        lSalesLine.SETFILTER("Line Type", '%1..', lSalesLine."Line Type"::Item);
        lSalesLine.SETRANGE(Option, FALSE);
        lSalesLine.CALCSUMS("Overhead Amount (LCY)", "Total Cost (LCY)", "Job Costs (LCY)", "Amount Excl. VAT (LCY)");
        //wMargin := lUpdateF9.getMaginPriceCostValue;
        //#6228
        wMargin := lSalesLine."Amount Excl. VAT (LCY)" -
                   (lSalesLine."Overhead Amount (LCY)" + lSalesLine."Total Cost (LCY)");
        //#6228//
        Result := lSalesLine."Amount Excl. VAT (LCY)";
        /*{
        SalesPost.SumSalesLines(
          SalesHeader,0,TotalSalesLine,TotalSalesLineLCY,
          VATAmount,VATAmountText,ProfitLCY,ProfitPct,TotalAdjCostLCY);
        EXIT(TotalSalesLineLCY.Amount);
        }*/
        //DEVIS//

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Opportunity Entry", 'OnBeforeTestCust', '', true, true)]
    local procedure OnBeforeTestCust(OpportunityEntry: Record "Opportunity Entry"; var IsHandled: Boolean)
    var

        Opp: Record Opportunity;
    begin
        //#6399
        Opp.GET(OpportunityEntry."Opportunity No.");
        IF Opp."Sales Document No." = '' THEN
            EXIT;
        //#6399//
    end;

    [EventSubscriber(ObjectType::Table, 5093, 'OnAfterInsertEntry', '', true, true)]
    local procedure OnAfterInsertEntry(var OpportunityEntry: Record "Opportunity Entry")
    var
        OppEntry2: Record "Opportunity Entry";
    begin
        OppEntry2.SetCurrentKey(Active, "Opportunity No.");
        OppEntry2.SetRange(Active, true);
        OppEntry2.SetRange("Opportunity No.", OpportunityEntry."Opportunity No.");
        if OppEntry2.FindFirst() then begin

            //+REF+OPPORT
            OpportunityEntry.Variation := OpportunityEntry."Estimated Value (LCY)" - OppEntry2."Estimated Value (LCY)";
        END ELSE BEGIN
            OpportunityEntry.Variation := OpportunityEntry."Estimated Value (LCY)";
            //+REF+OPPORT//
        end;
    end;

    [EventSubscriber(ObjectType::Table, 5093, 'OnBeforeCreateStageList', '', true, true)]
    local procedure OnBeforeCreateStageList(var OpportunityEntry: Record "Opportunity Entry"; var OpportunityEntryRec: Record "Opportunity Entry"; var IsHandled: Boolean)
    begin
        //#8918
        OpportunityEntry.fCreateMultiActions(OpportunityEntry."Opportunity No.");
        //#8918//
    end;


    //*************************************Table 5405************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeOnInsert', '', true, true)]
    local procedure OnBeforeOnInsert5405(var ProductionOrder: Record "Production Order"; var xProductionOrder: Record "Production Order"; var InvtAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)"; var IsHandled: Boolean)
    begin
        //  IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeCheckStatusNotFinished', '', true, true)]
    local procedure OnBeforeCheckStatusNotFinished(ProductionOrder: Record "Production Order"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeAssignItemNo', '', true, true)]
    local procedure OnBeforeAssignItemNo(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Item: Record Item; CallingFieldNo: Integer)
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        ProductionBOMHeader.SETRANGE("Article Lié", ProdOrder."Source No.");
        IF ProductionBOMHeader.FINDFIRST THEN
            IF ProductionBOMHeader.Stockable THEN
                ProdOrder.Stockable := TRUE
            ELSE
                ProdOrder.Stockable := FALSE;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeAssignFamily', '', true, true)]
    local procedure OnBeforeAssignFamily(var ProdOrder: Record "Production Order"; xProdOrder: Record "Production Order"; var Family: Record Family; CallingFieldNo: Integer)
    begin
        // >> HJ SORO 17-08-2016
        IF Family."Sans Consommation" THEN ProdOrder.Stockable := TRUE;
        ProdOrder."Nombre Heure Travail" := Family."Heure Travail Par Jour";
        // >> HJ SORO 17-08-2016

    end;


    //*************************************Table 5406************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnValidateItemNoOnAfterAssignItemValues', '', true, true)]
    local procedure OnValidateItemNoOnAfterAssignItemValues(var ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; xProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    begin
        ProdOrderLine."Unit Cost" := Item."Last Direct Cost";
    end;


    /*GL2024 [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnAfterGetUpdateFromSKU', '', true, true)]
     local procedure OnAfterGetUpdateFromSKU(var ProdOrderLine: Record "Prod. Order Line"; var Item: Record Item; var StockkeepingUnit: Record "Stockkeeping Unit")
     begin

         Item.Get(ProdOrderLine."Item No.");

         if not (StockkeepingUnit.Get(ProdOrderLine."Location Code", ProdOrderLine."Item No.", ProdOrderLine."Variant Code")) then
             ProdOrderLine."Unit Cost" := Item."Last Direct Cost";

     end;*/


    //*************************************Table 5740************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterInitFromTransferFromLocation', '', true, true)]
    local procedure OnAfterInitFromTransferFromLocation(var TransferHeader: Record "Transfer Header"; Location: Record Location)
    begin
        // >> HJ SORO 13-06-2015
        // TransferHeader."Chantier Origine" := Location.Affectation;
        // >> HJ SORO 13-06-2015
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterInitFromTransferToLocation', '', true, true)]
    local procedure OnAfterInitFromTransferToLocation(var TransferHeader: Record "Transfer Header"; Location: Record Location)
    begin
        // >> HJ SORO 13-06-2015
        // TransferHeader."Chantier Destination" := Location.Affectation;
        // >> HJ SORO 13-06-2015 
    end;



    //*************************************Table 5900************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnDeleteHeaderOnBeforeDeleteRelatedRecords', '', true, true)]
    local procedure OnDeleteHeaderOnBeforeDeleteRelatedRecords(var ServiceHeader: Record "Service Header"; var ServShptHeader: Record "Service Shipment Header"; var ServInvHeader: Record "Service Invoice Header"; var ServCrMemoHeader: Record "Service Cr.Memo Header"; var IsHandled: Boolean)
    var
        ServContract: Record "Service Contract Header";
        lServLedgEntry: Record "Service Ledger Entry";
    //GL2024 lDimLedgEntry: Record 355;

    begin
        IF ServiceHeader."Document Type" = ServiceHeader."Document Type"::Invoice THEN BEGIN
            //#6859
            IF ServiceHeader."Contract No." <> '' THEN BEGIN
                //#6859//
                ServContract.GET(1, ServiceHeader."Contract No.");
                ServContract."Change Status" := ServContract."Change Status"::Open;
                //#7880
                //    ServContract.VALIDATE("Next Invoice Date",ServContract."Last Invoice Date");
                ServContract.VALIDATE("Last Invoice Date");
                //#7880//
                ServContract."Change Status" := ServContract."Change Status"::Locked;
                ServContract.MODIFY;
                //#6859
            END;
            //#6859//
            lServLedgEntry.RESET;
            lServLedgEntry.SETCURRENTKEY("Entry Type", "Document Type", "Document No.");
            lServLedgEntry.SETRANGE("Entry Type", lServLedgEntry."Entry Type"::Sale);
            lServLedgEntry.SETRANGE("Document No.", ServiceHeader."No.");
            /*  IF lServLedgEntry.FINDSET THEN BEGIN
                  lDimLedgEntry.RESET;
                  lDimLedgEntry.SETRANGE("Table ID", DATABASE::"Service Ledger Entry");
                  REPEAT
                      lDimLedgEntry.SETRANGE("Entry No.", lServLedgEntry."Entry No.");
                      lDimLedgEntry.DELETEALL;
                  UNTIL lServLedgEntry.NEXT = 0;
              END;*/
            lServLedgEntry.DELETEALL;
        END;
        //SERVICE//
    end;


    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnAfterInitDefaultDimensionSources', '', true, true)]
    local procedure OnAfterInitDefaultDimensionSources5900(var ServiceHeader: Record "Service Header"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    var
        DimMgt: Codeunit DimensionManagement;

    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::Job, ServiceHeader."Job No.", FieldNo = ServiceHeader.FieldNo("Job No."));

    end;



    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnAfterUpdateServLinesByFieldNo', '', true, true)]
    local procedure OnAfterUpdateServLinesByFieldNo(var ServiceHeader: Record "Service Header"; var ServiceLine: Record "Service Line"; ChangedFieldNo: Integer)
    begin

        if ServiceHeader.ServLineExists() then begin
            ServiceLine.LockTable();
            ServiceLine.Reset();
            ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
            ServiceLine.SetRange("Document No.", ServiceHeader."No.");

            ServiceLine.SetRange("Quantity Shipped", 0);
            ServiceLine.SetRange("Quantity Invoiced", 0);
            ServiceLine.SetRange("Quantity Consumed", 0);
            ServiceLine.SetRange("Shipment No.", '');

            if ServiceLine.Find('-') then
                repeat
                    case ChangedFieldNo of
                        //JOB_SERVICE
                        ServiceHeader.FieldNo("Job No."):
                            BEGIN
                                ServiceLine.VALIDATE("Job No.", ServiceHeader."Job No.");
                                ServiceLine.MODIFY(TRUE);
                            END;
                    //JOB_SERVICE//
                    end;
                until ServiceLine.Next() = 0;
        end;



    end;
    //*************************************Table 5902************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Line", 'OnAfterAssignHeaderValues', '', true, true)]
    local procedure OnAfterAssignHeaderValues(var ServiceLine: Record "Service Line"; ServiceHeader: Record "Service Header")
    begin
        //JOB_SERVICE
        ServiceLine."Job No." := ServiceHeader."Job No.";
        IF ServiceLine."Job No." <> '' THEN
            ServiceLine.VALIDATE("Job No.");
        //JOB_SERVICE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Line", 'OnBeforeValidateJobNo', '', true, true)]
    local procedure OnBeforeValidateJobNo(var ServiceLine: Record "Service Line"; xServiceLine: Record "Service Line"; var IsHandled: Boolean);
    var
        Job: Record Job;
        lJobStatus: Record "Job Status";
    begin
        ServiceLine.TestField("Quantity Consumed", 0);
        ServiceLine.Validate("Job Task No.", '');

        if ServiceLine."Job No." <> '' then begin
            Job.Get(ServiceLine."Job No.");
            Job.TestBlocked();
            //+JOB+
            Job.wCheckBlockedJob(ServiceLine."Job No.");
            lJobStatus.Check(ServiceLine."Job No.", lJobStatus.FIELDNO("Sales Posting"));
            ServiceLine.VALIDATE("Job Task No.", Job.gGetDefaultJobTask());
            //+JOB+//
        end;

        ServiceLine.CreateDimFromDefaultDim(ServiceLine.FieldNo("Job No."));
    end;

    //*************************************Table 5964************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Contract Line", 'OnValidateServiceItemNoOnAfterInit', '', true, true)]
    local procedure OnValidateServiceItemNoOnAfterInit(var ServContractLineRec: Record "Service Contract Line"; ServContractLine: Record "Service Contract Line")
    var
    begin
        //GL2024 "Dans la version standard de BC2024, TempServContractLine n'existe pas, il utilise ServContractLine."
        //SERVICE
        //GL2024  ServContractLineRec."Job No." := TempServContractLine."Job No.";
        ServContractLineRec."Job No." := ServContractLine."Job No.";
        IF ServContractLineRec."Job No." = '' THEN
            ServContractLineRec."Job No." := ServContractLine."Job No."
        ELSE
            ServContractLineRec.VALIDATE("Job No.");
        //GL2024 ServContractLineRec.Quantity := TempServContractLine.Quantity;
        ServContractLineRec.Quantity := ServContractLine.Quantity;
        //SERVICE// 
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Contract Line", 'OnAfterSetupNewLine', '', true, true)]
    local procedure OnAfterSetupNewLine(var ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
    begin
        //SERVICE//
        ServiceContractLine.VALIDATE("Job No.", ServiceContractHeader."Job No.");
        //SERVICE
    end;


    //*************************************Table 5965************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnAfterUpdContractChangeLog', '', true, true)]
    local procedure OnAfterUpdContractChangeLog(var ServiceContractHeader: Record "Service Contract Header"; OldServiceContractHeader: Record "Service Contract Header")
    var
        ContractChangeLog: Record "Contract Change Log";
    begin
        //SERVICE
        IF ServiceContractHeader."Job No." <> OldServiceContractHeader."Job No." THEN
            ContractChangeLog.LogContractChange(
              ServiceContractHeader."Contract No.", 0, ServiceContractHeader.FIELDCAPTION("Job No."), 0,
              FORMAT(OldServiceContractHeader."Job No."), FORMAT(ServiceContractHeader."Job No."),
              '', 0);
        //SERVICE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnBeforeAskContractAmountDistribution', '', true, true)]
    local procedure OnBeforeAskContractAmountDistribution(var ServiceContractHeader: Record "Service Contract Header"; var OK: Boolean; var Result: Integer; var IsHandled: Boolean)
    var
        ContractAmountDistribution: Page "Contract Amount Distribution";
    begin

        Clear(ContractAmountDistribution);
        ContractAmountDistribution.SetValues(ServiceContractHeader."Annual Amount", ServiceContractHeader."Calcd. Annual Amount");
        //+ONE+
        //GL2024   if ContractAmountDistribution.RunModal() = ACTION::Yes then begin
        //GL2024
        IF ((ContractAmountDistribution.RUNMODAL = ACTION::Yes) OR (ContractAmountDistribution.RUNMODAL = ACTION::LookupOK)) then begin
            //+ONE+//
            //GL2024
            Result := ContractAmountDistribution.GetResult();
            OK := true;
        end;

        IsHandled := true;
    end;
    //*************************************Table 5992************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Invoice Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords5992(var ServiceInvoiceHeader: Record "Service Invoice Header"; ShowRequestPage: Boolean; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        lSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //+REF+INVOICE
        //  ReportSelection.FIND('-');
        IF NOT DummyReportSelections.FIND('-') THEN BEGIN
            lSalesInvoiceHeader.SETVIEW('GETVIEW');
            lSalesInvoiceHeader.SETRANGE("Print Document Type", DATABASE::"Service Invoice Header");
            lSalesInvoiceHeader.PrintRecords(TRUE);
        END ELSE
            //+REF+INVOICE//
            DocumentSendingProfile.TrySendToPrinter(
        DummyReportSelections.Usage::"SM.Invoice".AsInteger(), ServiceInvoiceHeader, ServiceInvoiceHeader.FieldNo("Bill-to Customer No."), ShowRequestPage);

        IsHandled := true;
    end;



    //*************************************Table 5994************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Service Cr.Memo Header", 'OnBeforePrintRecords', '', true, true)]
    local procedure OnBeforePrintRecords5994(var ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ShowRequestForm: Boolean; var IsHandled: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        lSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //+REF+INVOICE
        //  ReportSelection.FIND('-');
        IF NOT DummyReportSelections.FIND('-') THEN BEGIN
            lSalesInvoiceHeader.SETVIEW('GETVIEW');
            lSalesInvoiceHeader.SETRANGE("Print Document Type", DATABASE::"Service Cr.Memo Header");
            lSalesInvoiceHeader.PrintRecords(TRUE);
        END ELSE
            //+REF+INVOICE//
           DocumentSendingProfile.TrySendToPrinter(
          DummyReportSelections.Usage::"SM.Credit Memo".AsInteger(), ServiceCrMemoHeader, ServiceCrMemoHeader.FieldNo("Bill-to Customer No."), ShowRequestForm);

        IsHandled := true;
    end;


    //*************************************Table 7004************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Sales Line Discount", 'OnBeforeValidateUnitofMeasureCode', '', true, true)]
    local procedure OnBeforeValidateUnitofMeasureCode(var SalesLineDiscount: Record "Sales Line Discount"; xSalesLineDiscount: Record "Sales Line Discount"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //*************************************Table 10866************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterSetUpNewLine', '', true, true)]
    local procedure OnAfterSetUpNewLine10866(var PaymentLine: Record "Payment Line")
    var
        PaymentClass: Record "Payment Class";

        RecGPaymentStatus: Record "Payment Status";
        RecGGLSetup: Record "General Ledger Setup";
        Statement: Record "Payment Header";

    begin
        IF PaymentLine."No." <> '' THEN BEGIN
            Statement.Get(PaymentLine."No.");
            // STD V2.00
            IF PaymentClass.GET(Statement."Payment Class") THEN;
            CASE PaymentClass.Suggestions OF
                1:
                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                2:
                    PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
            END;

            //>>>MBK:24/11/2010
            CASE PaymentClass.Suggestions OF
                1:
                    PaymentLine."Type de compte" := PaymentLine."Account Type"::Customer;
                2:
                    PaymentLine."Type de compte" := PaymentLine."Account Type"::Vendor;
            END;

            //>>>MBK:24/11/2010

            IF RecGPaymentStatus.GET(Statement."Payment Class", PaymentLine."Status No.") THEN;
            IF RecGGLSetup.GET THEN;
            PaymentLine."Payment in Progress" := RecGPaymentStatus."Payment in Progress";
            // STD V2.00

        END;
    end;

    //*************************************Table 179************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnCheckGLAccOnBeforeTestFields', '', true, true)]
    local procedure OnCheckGLAccOnBeforeTestFields(GLAcc: Record "G/L Account"; GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    begin

        GLAcc.TestField(Blocked, false);
        //PROJET : suppression testfield
        //GLEntry.TESTFIELD("Job No.",'');
        //PROJET//

        IsHandled := true;
    end;

    //*************************************Table 179************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnBeforeSetReverseFilter', '', true, true)]
    local procedure OnBeforeSetReverseFilter(Number: Integer; RevType: Option Transaction,Register; var GLEntry: Record "G/L Entry"; var CustLedgerEntry: Record "Cust. Ledger Entry"; var VendLedgerEntry: Record "Vendor Ledger Entry"; var EmployeeLedgerEntry: Record "Employee Ledger Entry"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var VATEntry: Record "VAT Entry"; var FALedgerEntry: Record "FA Ledger Entry"; var MaintenanceLedgerEntry: Record "Maintenance Ledger Entry"; var GLRegister: Record "G/L Register"; var ReversalEntry: Record "Reversal Entry"; var IsHandled: Boolean)

    begin
        if RevType = RevType::Transaction then begin
            GLEntry.SetCurrentKey("Transaction No.");
            CustLedgerEntry.SetCurrentKey("Transaction No.");
            VendLedgerEntry.SetCurrentKey("Transaction No.");
            EmployeeLedgerEntry.SetCurrentKey("Transaction No.");
            BankAccountLedgerEntry.SetCurrentKey("Transaction No.");
            FALedgerEntry.SetCurrentKey("Transaction No.");
            //#6979
            IF (ReversalEntry.fHasMaintenancePermission) THEN
                MaintenanceLedgerEntry.SetCurrentKey("Transaction No.");
            //#6979//
            VATEntry.SetCurrentKey("Transaction No.");
            GLEntry.SetRange("Transaction No.", Number);
            CustLedgerEntry.SetRange("Transaction No.", Number);
            VendLedgerEntry.SetRange("Transaction No.", Number);
            EmployeeLedgerEntry.SetRange("Transaction No.", Number);
            BankAccountLedgerEntry.SetRange("Transaction No.", Number);
            FALedgerEntry.SetRange("Transaction No.", Number);
            FALedgerEntry.SetFilter("G/L Entry No.", '<>%1', 0);
            //#6979
            IF (ReversalEntry.fHasMaintenancePermission) THEN
                MaintenanceLedgerEntry.SetRange("Transaction No.", Number);
            //#6979//
            VATEntry.SetRange("Transaction No.", Number);
        end else begin
            GLRegister.Get(Number);
            GLEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            CustLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            VendLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            EmployeeLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            BankAccountLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            FALedgerEntry.SetCurrentKey("G/L Entry No.");
            FALedgerEntry.SetRange("G/L Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            //#6979
            IF (ReversalEntry.fHasMaintenancePermission()) THEN BEGIN
                MaintenanceLedgerEntry.SetCurrentKey("G/L Entry No.");
                MaintenanceLedgerEntry.SetRange("G/L Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            END;
            //#6979//
            VATEntry.SetRange("Entry No.", GLRegister."From VAT Entry No.", GLRegister."To VAT Entry No.");
        end;
        IsHandled := true;
    end;
    //*************************************Table 290************************************************//
    [EventSubscriber(ObjectType::Table, Database::"VAT Amount Line", 'OnInsertLine', '', true, true)]
    local procedure OnInsertLine(var VATAmountLine: Record "VAT Amount Line"; var IsHandled: Boolean; var Result: Boolean)
    var
        VATAmountLine2: Record "VAT Amount Line";
        NonDeductibleVAT: Codeunit "Non-Deductible VAT";
    begin
        if not ((VATAmountLine."VAT Base" <> 0) or (VATAmountLine."Amount Including VAT" <> 0)) then
            Result := false;
        //TVA
        VATAmountLine.Validate(Positive, VATAmountLine."Line Amount" >= 0);
        //TVA
        VATAmountLine2 := VATAmountLine;
        if VATAmountLine.Find() then begin
            VATAmountLine."Line Amount" += VATAmountLine2."Line Amount";
            VATAmountLine."Inv. Disc. Base Amount" += VATAmountLine2."Inv. Disc. Base Amount";
            VATAmountLine."Invoice Discount Amount" += VATAmountLine2."Invoice Discount Amount";
            VATAmountLine.Quantity += VATAmountLine2.Quantity;
            VATAmountLine."VAT Base" += VATAmountLine2."VAT Base";
            VATAmountLine."Amount Including VAT" += VATAmountLine2."Amount Including VAT";
            VATAmountLine."VAT Difference" += VATAmountLine2."VAT Difference";
            VATAmountLine."VAT Amount" := VATAmountLine."Amount Including VAT" - VATAmountLine."VAT Base";
            VATAmountLine."Calculated VAT Amount" += VATAmountLine2."Calculated VAT Amount";
            NonDeductibleVAT.Increment(VATAmountLine, VATAmountLine2);

            VATAmountLine.Modify();
        end else begin
            VATAmountLine."VAT Amount" := VATAmountLine."Amount Including VAT" - VATAmountLine."VAT Base";

            VATAmountLine.Insert();
        end;

        Result := true;

        IsHandled := true;
    end;

    //*************************************Table 750************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Standard General Journal", 'OnCopyGenJnlFromStdJnlOnBeforeGenJnlLineTransferFields', '', true, true)]
    local procedure OnCopyGenJnlFromStdJnlOnBeforeGenJnlLineTransferFields(var GenJournalLine: Record "Gen. Journal Line"; var StdGenJournalLine: Record "Standard General Journal Line")
    begin
        //#7909
        GenJournalLine."Job No." := '';
        GenJournalLine.VALIDATE("Job No.", StdGenJournalLine."Job No.");
        //#7909//
    end;
    //*************************************Table 5080************************************************//
    [EventSubscriber(ObjectType::Table, Database::"To-do", 'OnCreateTaskFromTaskOnBeforeStartWizard', '', true, true)]
    local procedure OnCreateTaskFromTaskOnBeforeStartWizard(var Task: Record "To-do"; var FromTask: Record "To-do")
    var
        Opp: Record Opportunity;
    begin
        IF Opp.GET(Task.GETFILTER("Opportunity No.")) THEN BEGIN
            //+REF+OPPORT
            Task.Description := Opp.Description;
            //+REF+OPPORT//
        END;
    end;

    //*************************************Table 5103************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Interaction Tmpl. Language", 'OnCreateAttachmentOnAfterInitialChecks', '', true, true)]
    local procedure OnCreateAttachmentOnAfterInitialChecks(var InteractionTmplLanguage: Record "Interaction Tmpl. Language"; var NewAttachNo: Integer; var IsHandled: Boolean)
    var
    //DYS Codeunit supprimer
    //  WordManagement: Codeunit 5054;
    begin
        //#8444
        //GL2024      WordManagement.fSetAttachment(InteractionTmplLanguage.Attachment);
        //GL2024
        // WordManagement.fSetAttachment(InteractionTmplLanguage."Attachment No.");
        //GL2024
        //#8444//
    end;

    //*************************************Table 99000853************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Inventory Profile", 'OnAfterTransferFromPurchaseLine', '', true, true)]
    local procedure OnAfterTransferFromPurchaseLine(var InventoryProfile: Record "Inventory Profile"; PurchaseLine: Record "Purchase Line")
    begin
        //CDE_INTERNE
        InventoryProfile."Source Order Status" := PurchaseLine."Document Type";
        //CDE_INTERNE//
    end;


    //*************************************Table 167************************************************//
    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBillToCustomerNoUpdatedOnBeforeUpdateBillToContact', '', true, true)]

    local procedure OnBillToCustomerNoUpdatedOnBeforeUpdateBillToContact(var Job: Record Job; xJob: Record Job; Customer: Record Customer; var IsHandled: Boolean)
    var

        Cust: Record Customer;
    begin
        //#6602
        cust.get(Job."Bill-to Customer No.");

        IF Job."Description 2" = '' THEN
            Job."Description 2" := Cust.Name;
        IF (Job."Job Address" = '') AND (Job."Job Address 2" = '') AND (Job."Job City" = '') AND (Job."Job Post Code" = '') THEN BEGIN
            Job."Job Address" := Cust.Address;
            Job."Job Address 2" := Cust."Address 2";
            Job."Job City" := Cust.City;
            Job."Job Post Code" := Cust."Post Code";
        end;

        //#6602
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeValidateBillToContactNo', '', true, true)]

    local procedure OnBeforeValidateBillToContactNo(var Job: Record Job; xJob: Record Job; CallingFieldNo: Integer; var IsHandled: Boolean)
    var

        Cont: Record Contact;

        ContBusinessRelation: Record "Contact Business Relation";
        ContactBusRelDiffCompErr: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment = '%1 = The contact number; %2 = The contact''s name; %3 = The Bill-To Customer Number associated with this job';

    begin

        //#6295
        /*
if (Job."Bill-to Contact No." <> xJob."Bill-to Contact No.") and
(xJob."Bill-to Contact No." <> '')
then
if (Job."Bill-to Contact No." = '') and (Job."Bill-to Customer No." = '') then begin
Job.Init();
Job."No. Series" := xJob."No. Series";
Job.Validate(Description, xJob.Description);
end; */
        //#6295//

        if (Job."Bill-to Customer No." <> '') and (Job."Bill-to Contact No." <> '') then begin
            Cont.Get(Job."Bill-to Contact No.");
            if ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, job."Bill-to Customer No.") then
                if ContBusinessRelation."Contact No." <> Cont."Company No." then
                    Error(ContactBusRelDiffCompErr, Cont."No.", Cont.Name, Job."Bill-to Customer No.");
        end;
        Job.UpdateBillToCust(Job."Bill-to Contact No.");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeInitBillToCustomerNo', '', true, true)]

    local procedure OnBeforeInitBillToCustomerNo(var Job: Record Job; var xJob: Record Job; var IsHandled: Boolean)
    var
        Dimmgt: Codeunit DimensionManagementEvent;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cdufunction: Codeunit SoroubatFucntion;
    begin
        if Job."No." = '' then begin
            //AGENCE
            Cdufunction.fSetRespCenter(Job."Responsibility Center");
            //AGENCE//
        end;

        //#6884
        //+REF+TEMPLATE
        IF (Job."No." = '') AND (Job."No. Series" <> '') THEN
            NoSeriesMgt.InitSeries(Job."No. Series", Job."No. Series", 0D, Job."No.", Job."No. Series");
        //#6884//
        DimMgt.fSetDefaultDim(DATABASE::Job, Job."No.", 1, Job."Global Dimension 1 Code");
        DimMgt.fSetDefaultDim(DATABASE::Job, Job."No.", 2, Job."Global Dimension 2 Code");
        //+REF+TEMPLATE//
        //+ONE+JOB_TASK
        job.gInsertDefaultJobTask();
        //+ONE+JOB_TASK//



    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterOnInsert', '', true, true)]

    local procedure OnAfterOnInsert(var Job: Record Job; var xJob: Record Job)
    var
        lMaskMgt: Codeunit 8003901;
    begin
        //MASK
        IF Job."Mask Code" = '' THEN
            Job."Mask Code" := lMaskMgt.UserMask;
        //MASK//

        //+JOB+TOTALISATION
        Job.lSetJobTotalingField(Job);
        //+JOB+TOTALISATION//
    end;

    //*************************************Table 210************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnBeforeValidateJobTaskNo', '', true, true)]
    local procedure OnBeforeValidateJobTaskNo(var JobJournalLine: Record "Job Journal Line"; var xJobJournalLine: Record "Job Journal Line"; var IsHandled: Boolean)
    var
        JobTask: Record "Job Task";
    begin
        if (JobJournalLine."Job Task No." = '') or ((JobJournalLine."Job Task No." <> xJobJournalLine."Job Task No.") and (xJobJournalLine."Job Task No." <> '')) then begin
            JobJournalLine.Validate("No.", '');
            exit;
        end;
        //RES_USAGE
        IF (JobJournalLine.Type <> JobJournalLine.Type::Resource) OR (JobJournalLine."Entry Type" <> JobJournalLine."Entry Type"::Usage) THEN
            //RES_USAGE//
            JobJournalLine.TestField("Job No.");
        JobTask.Get(JobJournalLine."Job No.", JobJournalLine."Job Task No.");
        JobTask.TestField("Job Task Type", JobTask."Job Task Type"::Posting);

        JobJournalLine.UpdateDimensions();
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnBeforeValidateWorkTypeCode', '', true, true)]
    local procedure OnBeforeValidateWorkTypeCode(var JobJournalLine: Record "Job Journal Line"; var xJobJournalLine: Record "Job Journal Line"; var IsLineDiscountHandled: Boolean; var IsHandled: Boolean)
    var
        Res: Record Resource;

        WorkType: Record "Work Type";

        ResUnitofMeasure: Record "Resource Unit of Measure";

        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin

        JobJournalLine.TestField(Type, JobJournalLine.Type::Resource);
        //#9085
        xJobJournalLine."Work Type Code" := '';
        //#9085//
        if not IsLineDiscountHandled then
            JobJournalLine.Validate("Line Discount %", 0);
        if (JobJournalLine."Work Type Code" = '') and (xJobJournalLine."Work Type Code" <> '') then begin
            Res.Get(JobJournalLine."No.");
            JobJournalLine."Unit of Measure Code" := Res."Base Unit of Measure";
            JobJournalLine.Validate("Unit of Measure Code");
        end;
        //POINTAGE
        if WorkType.Get(JobJournalLine."Work Type Code") then
            //#8272 IF WorkType.GET("Work Type Code") AND ("No." <> '') THEN BEGIN
            IF (JobJournalLine."No." <> '') THEN BEGIN
                JobJournalLine.wMajDescription;
                IF WorkType."Job Absence No." <> '' THEN BEGIN
                    JobJournalLine.VALIDATE("Job No.", WorkType."Job Absence No.");
                END;
                JobJournalLine."Work Time Type" := WorkType."Work Time Type";
                IF WorkType."Gen. Prod. Posting Group" <> '' THEN
                    JobJournalLine."Gen. Prod. Posting Group" := WorkType."Gen. Prod. Posting Group";
                //POINTAGE//
                if WorkType."Unit of Measure Code" <> '' then begin
                    JobJournalLine."Unit of Measure Code" := WorkType."Unit of Measure Code";
                    if ResUnitofMeasure.Get(JobJournalLine."No.", JobJournalLine."Unit of Measure Code") then
                        JobJournalLine."Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";

                    //RES_USAGE
                END ELSE IF NOT WorkType."Quantity (Base) in Hours" THEN BEGIN
                    JobJournalLine."Unit of Measure Code" := '';
                    JobJournalLine."Qty. per Unit of Measure" := 0;
                    //RES_USAGE//
                end else begin
                    Res.Get(JobJournalLine."No.");
                    JobJournalLine."Unit of Measure Code" := Res."Base Unit of Measure";
                    JobJournalLine.Validate("Unit of Measure Code");
                    //   FindResCost;
                    //POINTAGE
                    //  PurchPriceCalcMgt.FindJobJnlLinePrice(Rec,FIELDNO("No."));
                    //POINTAGE//
                    //GL2024  SalesPriceCalcMgt.FindJobJnlLinePrice(JobJournalLine, CurrFieldNo);
                end;
                //POINTAGE
                IF WorkType."Increase %" <> 0 THEN BEGIN
                    //#9085
                    xJobJournalLine."Work Type Code" := JobJournalLine."Work Type Code";
                    //#9085
                    JobJournalLine.VALIDATE("Unit Cost", JobJournalLine."Unit Cost" * (1 + (WorkType."Increase %" / 100)));
                    JobJournalLine.VALIDATE("Direct Unit Cost (LCY)", JobJournalLine."Direct Unit Cost (LCY)" * (1 + (WorkType."Increase %" / 100)));
                END;
                //POINTAGE//
                //#8272
            END ELSE BEGIN
                JobJournalLine."Work Time Type" := WorkType."Work Time Type";
                JobJournalLine.wMajDescription;
                IF WorkType."Job Absence No." <> '' THEN BEGIN
                    JobJournalLine.VALIDATE("Job No.", WorkType."Job Absence No.");
                END;
                IF WorkType."Gen. Prod. Posting Group" <> '' THEN
                    JobJournalLine."Gen. Prod. Posting Group" := WorkType."Gen. Prod. Posting Group";
                IF WorkType."Unit of Measure Code" <> '' THEN BEGIN
                    JobJournalLine."Unit of Measure Code" := WorkType."Unit of Measure Code";
                    IF ResUnitofMeasure.GET(JobJournalLine."No.", JobJournalLine."Unit of Measure Code") THEN
                        JobJournalLine."Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                END;
            END;
        //#8272//
        JobJournalLine.Validate(Quantity);
        //POINTAGE
        IF JobJournalLine.Description = '' THEN BEGIN
            IF WorkType.GET(JobJournalLine."Work Type Code") THEN;
            IF Res.GET(JobJournalLine."No.") THEN;
            JobJournalLine.Description := COPYSTR(Res.Name + ' ' + WorkType.Description, 1, MAXSTRLEN(JobJournalLine.Description));
        END;
        //POINTAGE//
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnValidateUnitOfMeasureCodeOnBeforeOnBeforeValidateQuantity', '', true, true)]
    local procedure OnValidateUnitOfMeasureCodeOnBeforeOnBeforeValidateQuantity(var JobJournalLine: Record "Job Journal Line"; var IsHandled: Boolean)
    var
        WorkType: Record "Work Type";

    begin


        case JobJournalLine.Type of
            JobJournalLine.Type::Resource:
                begin
                    //RES_USAGE
                    if WorkType.GET(JobJournalLine."Work Type Code") then
                        WorkType.TESTFIELD(WorkType."Quantity (Base) in Hours", TRUE);
                    //RES_USAGE//
                end;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnBeforeCopyFromResource', '', true, true)]
    local procedure OnBeforeCopyFromResource(var JobJournalLine: Record "Job Journal Line"; Resource: Record Resource; CurrentFieldNo: Integer; var IsHandled: Boolean)
    var
        lGrRes: Record 152;

        lResGr: Record 8004031;
        JobJnlTemplate: Record "Job Journal Template";
        Job: Record Job;
    begin

        Resource.Get(JobJournalLine."No.");
        Resource.CheckResourcePrivacyBlocked(false);
        Resource.TestField(Blocked, false);


        if JobJournalLine."Time Sheet No." = '' then
            Resource.TestField("Use Time Sheet", false);
        //POINTAGE
        IF NOT JobJnlTemplate.GET(JobJournalLine."Journal Template Name") THEN
            JobJnlTemplate.INIT;
        //#6138
        //       IF JobJnlTemplate.Type = JobJnlTemplate.Type::"1" THEN
        //#6138//
        //#6350

        IF Resource.Type IN [Resource.Type::Person, Resource.Type::Machine] THEN
            //#6350//
            Resource.TESTFIELD("WT Allowed", TRUE);
        //POINTAGE//

        JobJournalLine.Description := Resource.Name;
        JobJournalLine."Description 2" := Resource."Name 2";
        //PLANNING
        IF (JobJournalLine."Resource Group No." = '') AND (CurrentFieldNo <> 0) THEN BEGIN
            COMMIT;
            lResGr.SETRANGE("Resource No.", JobJournalLine."No.");
            IF lResGr.COUNT <= 1 THEN BEGIN
                IF lResGr.FIND('-') THEN
                    JobJournalLine."Resource Group No." := lResGr."Resource Group No.";
            End;
            /*GL2024    END ELSE
                    IF page.RUNMODAL(page::"Resources / Resource Groups", lResGr) = ACTION::LookupOK THEN
                        JobJournalLine."Resource Group No." := lResGr."Resource Group No.";*/
        END;
        IF JobJournalLine."Resource Group No." = '' THEN
            //PLANNING//
            JobJournalLine."Resource Group No." := Resource."Resource Group No.";
        //#7634
        IF (JobJournalLine."Resource Group No." <> '') AND (CurrentFieldNo <> 0) THEN
            Resource.gCheckResGrp(JobJournalLine."No.", JobJournalLine."Resource Group No.", TRUE);
        //#7634//
        //#7248
        //#7403     "Resource Group No." := Res."Resource Group No.";
        JobJournalLine."Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
        //#7248//
        //#5839//
        IF lGrRes.GET(JobJournalLine."Resource Group No.") THEN BEGIN
            IF lGrRes."Gen. Prod. Posting Group" <> '' THEN
                JobJournalLine."Gen. Prod. Posting Group" := lGrRes."Gen. Prod. Posting Group";
        END;
        //#5839//
        //#5059
        IF JobJournalLine."Gen. Prod. Posting Group" = '' THEN
            //#5059//
            JobJournalLine."Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
        JobJournalLine.Validate("Unit of Measure Code", Resource."Base Unit of Measure");
        //POINTAGE
        JobJournalLine.VALIDATE("Resource Group No.");
        //POINTAGE//
        //INTERIM
        JobJournalLine.wReachVendor;
        //INTERIM//
        //POINTAGE
        IF JobJournalLine."Work Type Code" = '' THEN
            JobJournalLine."Work Type Code" := Resource."Work Type Code";
        //+ONE+TRAVEL
        IF (Resource."Travel Code" <> '') AND (JobJournalLine."Job No." <> '') THEN
            IF Job.GET(JobJournalLine."Job No.") THEN
                JobJournalLine.fTravel(Resource, Job);
        //+ONE+TRAVEL//
        //POINTAGE//
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnCopyFromItemOnBeforeValidateUoMCode', '', true, true)]
    local procedure OnCopyFromItemOnBeforeValidateUoMCode(var JobJournalLine: Record "Job Journal Line"; Item: Record Item; var IsHandled: Boolean);
    begin
        //POINTAGE
        JobJournalLine."Resource Group No." := '';
        //POINTAGE//
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnValidateNoOnBeforeValidateQuantity', '', true, true)]

    local procedure OnValidateNoOnBeforeValidateQuantity(var JobJournalLine: Record "Job Journal Line"; var IsHandled: Boolean)
    begin
        //POINTAGE
        IF JobJournalLine.Type = JobJournalLine.Type::Resource THEN
            JobJournalLine.VALIDATE("Work Type Code");
        //POINTAGE//


        //POINTAGE
        JobJournalLine.wMajDescription;
        IF (JobJournalLine.Description = '') AND (JobJournalLine."Work Type Code" <> '') THEN
            JobJournalLine.VALIDATE("Work Type Code");
        //POINTAGE//
        //PROJET_CESSION
        //#5588
        //IF ("Bal. Job No." = '') THEN BEGIN
        //#6628
        //IF ("Bal. Job No." = '') AND lBalJobGenerate THEN BEGIN
        /*GL2024   IF (JobJournalLine."Bal. Job No." = '') AND lBalJobGenerate AND ("Journal Template Name" <> '')  THEN BEGIN
           //#6628//
           //#5588//
             JobJournalLine."Bal. Job No." := lBalJob.SearchBalJobNoFromType(JobJournalLine);
             JobJournalLine.TESTFIELD("Bal. Job No.");
           END;*/
        //PROJET_CESSION//

    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnBeforeValidateJobNo', '', true, true)]

    local procedure OnBeforeValidateJobNo210(var JobJournalLine: Record "Job Journal Line"; var Customer: Record Customer; var DimensionManagement: Codeunit DimensionManagement; var IsHandled: Boolean)
    var
        JobSetup: Record "Jobs Setup";
        Job: record job;
        lJobStatusMgt: Codeunit "Job Status Management";
        lJobJnlLine: Record "Job Journal Line";
        lIC: Record 413;
        Res: Record Resource;
    begin

        if JobJournalLine."Job No." = '' then begin
            //POINTAGE
            JobJournalLine."Purch. Order No." := '';
            //POINTAGE//
            JobJournalLine.Validate("Currency Code", '');
            JobJournalLine.Validate("Job Task No.", '');
            JobJournalLine.CreateDimFromDefaultDim(JobJournalLine.FieldNo(JobJournalLine."Job No."));
            exit;
        end;


        JobJournalLine.TestField("Job No.");
        if JobJournalLine."Job No." <> Job."No." then
            Job.Get(JobJournalLine."Job No.");

        Job.TestBlocked();
        IsHandled := false;


        //#4718
        //#5472
        //IF (Job."Job Type" <> Job."Job Type"::Internal) AND (Job."IC Partner Code" = '') THEN BEGIN
        IF (Job."Job Type" = Job."Job Type"::External) AND (Job."IC Partner Code" = '') THEN BEGIN
            //#5472/
            Job.TestField("Bill-to Customer No.");
            Customer.Get(Job."Bill-to Customer No.");
        end;
        JobJournalLine.Validate("Job Task No.", '');

        //#4718//
        //+JOB+
        //VALIDATE("Job Task No.",'');
        //#5118
        //VALIDATE("Job Task No.",Job.gGetDefaultJobTask);
        JobJournalLine."Job Task No." := Job.gGetDefaultJobTask;
        //#5118//
        //+JOB+//

        JobJournalLine."Customer Price Group" := Job."Customer Price Group";
        JobJournalLine.Validate("Currency Code", Job."Currency Code");
        //JOB_STATUS
        //#4418
        IF JobJournalLine.Quantity <> 0 THEN
            //#4418//
            lJobStatusMgt.CheckJobJnlLine(JobJournalLine);
        //JOB_STATUS//
        //#4876
        IF lJobJnlLine.GET(JobJournalLine."Journal Template Name", JobJournalLine."Journal Batch Name", JobJournalLine."Line No.") THEN
            //#4876//
            JobJournalLine.CreateDimFromDefaultDim(JobJournalLine.FieldNo(JobJournalLine."Job No."));
        //GL2024
        JobJournalLine.Validate(JobJournalLine."Country/Region Code", Job."Bill-to Country/Region Code");
        //GL2024

        JobJournalLine."Price Calculation Method" := Job.GetPriceCalculationMethod();
        JobJournalLine."Cost Calculation Method" := Job.GetCostCalculationMethod();
        JobSetup.Get();
        if JobSetup."Document No. Is Job No." and (JobJournalLine."Document No." = '') then
            JobJournalLine.Validate("Document No.", JobJournalLine."Job No.");

        if JobJournalLine."Job No." = '' then
            //POINTAGE
            JobJournalLine."Purch. Order No." := '';
        //POINTAGE//

        //POINTAGE
        JobJournalLine.CALCFIELDS("Job Description");
        //POINTAGE//

        //POINTAGE
        JobJournalLine.wMajDescription;
        //POINTAGE//
        //IC
        IF Job."IC Partner Code" <> '' THEN BEGIN
            lIC.GET(Job."IC Partner Code");
            JobJournalLine."From Company" := lIC."Inbox Details";
        END
        ELSE
            JobJournalLine."From Company" := '';
        //IC//

        //+ONE+TRAVEL
        IF (Job."Travel Code" <> '') AND (JobJournalLine."No." <> '') THEN
            IF Res.GET(JobJournalLine."No.") THEN
                JobJournalLine.fTravel(Res, Job);
        //+ONE+TRAVEL//


        IsHandled := true;
    end;

    //*************************************Table 1001************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Job Task", 'OnBeforeValidateJobTaskNo', '', true, true)]
    local procedure OnBeforeValidateJobTaskNo1001(var JobTask: Record "Job Task"; var xJobTask: Record "Job Task"; FieldNumber: Integer; var IsHandled: Boolean)
    var

        Job: record job;
        Customer: Record customer;


    begin

        if JobTask."Job Task No." = '' then
            exit;
        Job.Get(JobTask."Job No.");
        //#4718
        //Job.TESTFIELD("Bill-to Customer No.");
        //Cust.GET(Job."Bill-to Customer No.");
        //#5464
        //IF Job."Job Type" <> Job."Job Type"::Internal THEN BEGIN
        IF Job."Job Type" = Job."Job Type"::External THEN BEGIN
            //#5464//
            Job.TestField("Bill-to Customer No.");
            Customer.Get(Job."Bill-to Customer No.");
        END;
        //#4718//
        JobTask."Job Posting Group" := Job."Job Posting Group";
        IsHandled := true;
    end;


    //*************************************Table 1003************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", 'OnAfterCopyFromResource', '', true, true)]
    local procedure OnAfterCopyFromResource(var JobPlanningLine: Record "Job Planning Line"; Job: Record Job; Resource: Record Resource)
    begin

        Resource.Get(JobPlanningLine."No.");
        //#4563
        JobPlanningLine."Resource Type" := Resource.Type;
        //#4563//
    end;



    //*************************************Table 380************************************************//
    /* [EventSubscriber(ObjectType::Table, Database::"Detailed Vendor Ledg. Entry", 'OnSetZeroTransNoOnBeforeDetailedVendorLedgEntryModify', '', true, true)]
     local procedure OnSetZeroTransNoOnBeforeDetailedVendorLedgEntryModify(var DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry")
     begin
         DetailedVendorLedgEntry."Transaction No." := DetailedVendorLedgEntry."Transaction No. Soroubat";
     end;*/


    //*************************************Table 379************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Detailed Cust. Ledg. Entry", 'OnSetZeroTransNoOnBeforeDetailedCustLedgEntryModify', '', true, true)]
    local procedure OnSetZeroTransNoOnBeforeDetailedCustLedgEntryModify(var DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
        DetailedCustLedgEntry."Transaction No." := DetailedCustLedgEntry."Transaction No. Soroubat";
    end;

    //*************************************Table 379************************************************//
    [EventSubscriber(ObjectType::Table, Database::"Accounting Period", 'OnCheckOpenFiscalYearsOnBeforeError', '', true, true)]
    local procedure OnCheckOpenFiscalYearsOnBeforeError(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

}
