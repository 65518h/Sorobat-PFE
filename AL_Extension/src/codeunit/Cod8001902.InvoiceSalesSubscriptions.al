Codeunit 8001902 "Invoice Sales Subscriptions"
{
    // #8814 CW 24/02/11 if ProrataTemporis <> 0 then "Unit of measure" := '';
    // #8240 SD 09/12/10
    // #8560 CW 23/11/10
    // #8298 SD 05/11/10
    // #8243 SD 28/10/10
    // #8241 SD 21/09/10
    // #8243 SD 17/09/10
    // #8025 CW 28/05/10
    // #7933 CW 12/04/10
    // #7710 CW 23/12/09
    // #7707 CW 03/12/09
    // #7291 CW 11/06/09
    // #7275 CW 04/06/09
    // //+ABO+ CW 10/01/09

    TableNo = "Sales Header";

    trigger OnRun()
    var
        lRec: Record "Sales Header";
        lSubscrLine: Record "Sales Line";
        xSubscrLine: Record "Sales Line";
        //GL2024  lComDlg: Codeunit 412;
        lStartDate: Date;
        lEndDate: Date;
        lAlreadyInvoiced: label 'Le contrat %1 a déjà été facturé jusqu''au %1';
    begin
        SubscrSetup.Get;
        REC.SetCurrentkey("Document Type", "Combine Shipments", "Bill-to Customer No.");
        REC.SetRange("Document Type", REC."document type"::Subscription);
        REC.SetRange(Status, REC.Status::Released);

        if not REC.FindSet then
            exit;

        //GL2024  lComDlg.ProgressOpen('', REC.COUNTAPPROX);

        repeat
            //GL2024    lComDlg.ProgressUpdate();
            REC.TestField(Status, REC.Status::Released);

            if (REC."Bill-to Customer No." <> Customer."No.") then begin
                Customer.Get(REC."Bill-to Customer No.");
                Customer.TestField(Blocked, 0);
            end;

            // Calc Next invoicing period (lStartDate..lEndDate) for this subscription
            SubscrInvoicingPeriod.Get(REC."Invoicing Periodicity Code");
            if SubscrInvoicingPeriod.fSetNextInvoicePeriod(
                 REC."Subscription Starting Date", REC."Subscription End Date", REC."Posting Date", gStartDate,
                 lStartDate, lEndDate) or (gStartDate = 0D) then begin

                lSubscrLine.SetRange("Document Type", REC."Document Type");
                lSubscrLine.SetRange("Document No.", REC."No.");
                if lSubscrLine.FindSet then
                    repeat
                        //#7707
                        //        IF (lSubscrLine."Subscription Posting Date" >= lEndDate) AND
                        if ((lSubscrLine."Subscription Posting Date" >= lEndDate) or (lSubscrLine."Subscription Starting Date" > lEndDate)) and
                             //#7707//
                             ((lSubscrLine."Subscription End Date" = 0D) or (lSubscrLine."Subscription End Date" >= lEndDate)) then begin
                            // Nothing to invoice
                        end else
                            if
                      (lSubscrLine."Subscription Posting Date" <> lSubscrLine."Subscription End Date") or
                      (lSubscrLine."Subscription Posting Date" = 0D) and (lSubscrLine."Subscription Starting Date" <= lEndDate) or
                      (lSubscrLine."Subscription Posting Date" > lSubscrLine."Subscription End Date") then begin

                                if (ToInvoiceHeader."No." = '') or
                                   (REC."Bill-to Customer No." <> ToInvoiceHeader."Bill-to Customer No.") or
                                   (lSubscrLine."Document No." <> xSubscrLine."Document No.") and
                                     (not REC."Combine Shipments" or not ToInvoiceHeader."Combine Shipments") or
                                   (REC."Responsibility Center" <> ToInvoiceHeader."Responsibility Center") or
                                   (REC."Currency Code" <> ToInvoiceHeader."Currency Code") then begin

                                    if ToInvoiceHeader."No." <> '' then
                                        FinalizeInvoice(ToInvoiceHeader);
                                    InsertInvoiceHeader(Rec, ToInvoiceHeader, lStartDate, lEndDate);

                                end;

                                InsertInvoiceLine(Rec, lSubscrLine, lStartDate, lEndDate);
                                xSubscrLine := lSubscrLine;
                            end;
                    until lSubscrLine.Next = 0;

            end;

        until REC.Next = 0;

        if ToInvoiceHeader."No." <> '' then
            FinalizeInvoice(ToInvoiceHeader);

        //GL2024   lComDlg.ProgressClose();

        if (NoOfInvoice = 1) and not gPost then
            page.RunModal(page::"Sales Invoice", ToInvoiceHeader)
        else
            if NoOfInvoice = 0 then
                Message(tNoInvoice)
            else
                if (NoOfInvoice = 1) and (ToInvoiceHeader."Last Posting No." <> '') then
                    Message(tUniquePostedInvoice, ToInvoiceHeader."Last Posting No.")
                else
                    if gPost then
                        //#8241
                        //  MESSAGE(tPostedInvoices,NoOfInvoice,NoOfPosted)
                        Message(StrSubstNo(tCreatedInvoices, NoOfInvoice) + '\' + StrSubstNo(tPostedInvoices, NoOfPosted))
                    //#8241//
                    else
                        Message(tCreatedInvoices, NoOfInvoice);
    end;

    var
        Counter: Integer;
        LineInit: Record "Sales Line";
        tSubscrHeader: label 'Contract no. %1:';
        ToInvoiceHeader: Record "Sales Header";
        ToInvoiceLine: Record "Sales Line";
        SubscrInvoicingPeriod: Record "Subscr. Invoicing Period";
        Currency: Record Currency;
        tInvoiceLinePending: label 'Unposted invoice %3, line %4 for contrat %1 line %2.';
        tIndent: label '    ';
        UnitOfMeasure: Record "Unit of Measure";
        gPostingDate: Date;
        gStartDate: Date;
        gPost: Boolean;
        NoOfInvoice: Integer;
        NoOfPosted: Integer;
        SalesPost: Codeunit "Sales-Post";
        Customer: Record Customer;
        tPostError: label '%1 invoice(s) can''t be posted.';
        tNoInvoice: label 'There is nothing to invoice.';
        tCreatedInvoices: label '%1 invoice(s) created.';
        FormatAddress: Codeunit "Format Address";
        BillToAddr: array[8] of Text[50];
        tPostedInvoices: label '%1 posted invoices';
        tUniquePostedInvoice: label 'Invoice %1 posted';
        SubscrSetup: Record "Subscription Setup";
        TranslationMgt: Codeunit "Translation Management";
        ReviewFactor: Decimal;
        ReviewText: Record "Standard Text";
        tReviewFactor: label 'Review factor : %1';
        tAdditionalInvoice: label 'Do you want to create an additional invoice for the period already invoiced?';
        Basic: Codeunit Basic;


    procedure InitRequest(pPostingDate: Date; pStartDate: Date; pPost: Boolean)
    begin
        gPostingDate := pPostingDate;
        gStartDate := pStartDate;
        gPost := pPost;
    end;

    local procedure InsertInvoiceHeader(pSubscrHeader: Record "Sales Header"; var pToInvoiceHeader: Record "Sales Header"; pStartDate: Date; pEndDate: Date)
    var
        lFromDocDim: Record "Gen. Jnl. Dim. Filter";
        lToDocDim: Record "Gen. Jnl. Dim. Filter";
        lRecordRef: RecordRef;
    begin
        with pToInvoiceHeader do begin
            //#7275
            //  INIT;
            if pSubscrHeader."Combine Shipments" then
                Init
            else
                Copy(pSubscrHeader);
            //#7275//
            SetHideValidationDialog(true);

            if pSubscrHeader."Combine Shipments" then begin
                "Document Type" := "document type"::Invoice;
                "No." := '';
                "Responsibility Center" := pSubscrHeader."Responsibility Center"; // for RespCenterInitSeriesNo
                Insert(true);
                Validate("Sell-to Customer No.", pSubscrHeader."Bill-to Customer No.");
                //  IF "Bill-to Customer No." <> "Sell-to Customer No." THEN
                //    VALIDATE("Bill-to Customer No.",pSubscrHeader."Bill-to Customer No.");
                if "Responsibility Center" <> '' then
                    Validate("Responsibility Center"); // Set Dim
                Validate("Posting Date", gPostingDate);
                Validate("Document Date", gPostingDate);
                Validate("Currency Code", pSubscrHeader."Currency Code");
                //  "Salesperson Code" := pSubscrHeader."Salesperson Code";
                //    VALIDATE("Shortcut Dimension 1 Code",pSubscrHeader."Shortcut Dimension 1 Code");
                //    VALIDATE("Shortcut Dimension 2 Code",pSubscrHeader."Shortcut Dimension 2 Code");
                "Combine Shipments" := pSubscrHeader."Combine Shipments";

                //#7518
                /*
                    MODIFY;
                    COMMIT;
                */
                //#7518//

                FormatAddress.SalesHeaderBillTo(BillToAddr, pToInvoiceHeader);

            end else begin
                TransferFields(pSubscrHeader, false);
                Status := Status::Open;
                Validate("Document Type", "document type"::Invoice);
                "No." := '';
                "Responsibility Center" := pSubscrHeader."Responsibility Center"; // for RespCenterInitSeriesNo
                pToInvoiceHeader.Insert(true);
                Validate("Posting Date", gPostingDate);
                Validate("Document Date", gPostingDate);
                //    "Applies-to ID" := pSubscrHeader."No."; // Move to "Order No." when Posting
                /*GL2024  CopyDocDim(
                    Database::"Sales Header",
                    pSubscrHeader."Document Type", pSubscrHeader."No.", 0,
                    pToInvoiceHeader."Document Type", pToInvoiceHeader."No.", 0);*/
            end;

            //#8025
            if pSubscrHeader."Combine Shipments" then
                "Posting Description" := SubscrSetup."Sales Comb. Inv. Posting Desc."
            else begin
                "Posting Description" := pSubscrHeader."Posting Description";
                "Subscription Starting Date" := pStartDate;
                "Subscription End Date" := pEndDate;
            end;
            lRecordRef.GetTable(pToInvoiceHeader);
            Basic.SubstituteValues("Posting Description", lRecordRef, '%', GlobalLanguage);
            //#8025//

            //#7518
            Modify;
            //#7933  COMMIT;
            //#7518//
        end;

        SetInvoice(pToInvoiceHeader);

        //#8025
        InsertExtendedText(SubscrSetup."Invoice Text Code");
        //#8025//

    end;


    procedure FinalizeInvoice(var pInvoiceHeader: Record "Sales Header")
    begin
        Commit;
        NoOfInvoice += 1;
        LineInit."Line No." := 0;

        if gPost then begin
            Clear(SalesPost);
            if SalesPost.Run(pInvoiceHeader) then
                NoOfPosted += 1;
        end;
    end;


    procedure InsertInvoiceLine(var pSubscrHeader: Record "Sales Header"; var pSubscrLine: Record "Sales Line"; pStartDate: Date; pEndDate: Date)
    var
        tDescrProrataDate: label 'Prorata temporis %1-%2';
        tDescrProrata2Date: label 'Prorata temp. %1-%2 %3-%4';
        tDescrDateCrMemo: label 'Credit memo from %1 to %2';
        tDescrDateInvoice: label 'Invoice from %1 to %2';
        lFromDocDim: Record "Gen. Jnl. Dim. Filter";
        lToDocDim: Record "Gen. Jnl. Dim. Filter";
        lSubscrLine: Record "Sales Line";
        lShipToAddr: array[8] of Text[50];
        i: Integer;
        lShowShippingAddr: Boolean;
        lReviewFormula: Record "Subscr. Review Formula";
        lReviewDate: Date;
        lSubscrHeader: Record "Sales Header";
        lRecordRef: RecordRef;
    begin
        // Check Line Invoicing is pending
        lSubscrLine.SetCurrentkey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        lSubscrLine.SetRange("Document Type", lSubscrLine."document type"::Invoice);
        lSubscrLine.SetRange("Blanket Order No.", pSubscrLine."Document No.");
        lSubscrLine.SetRange("Blanket Order Line No.", pSubscrLine."Line No.");
        if lSubscrLine.FindFirst then
            Error(tInvoiceLinePending,
              pSubscrLine."Document No.", pSubscrLine."Line No.", lSubscrLine."Document No.", lSubscrLine."Line No.");

        // Insert Contract Header Lines
        if pSubscrHeader."No." <> LineInit."Blanket Order No." then begin
            Counter += 1;
            if LineInit."Line No." <> 0 then
                InsertTextLine(' ');

            LineInit."Blanket Order No." := pSubscrHeader."No.";
            LineInit."Line No." += 10000;
            ToInvoiceLine := LineInit;
            ToInvoiceLine."Subscription Starting Date" := pStartDate;
            ToInvoiceLine."Subscription End Date" := pEndDate;
            ToInvoiceLine."Subscription Posting Date" := pEndDate;
            //#8025
            /*
              ToInvoiceLine.Description :=
                COPYSTR(STRSUBSTNO(
                  TranslationMgt.Format(DATABASE::"Subscription Setup",SubscrSetup.FIELDNO("Invoice Line Description"),'',
                    pSubscrHeader."Language Code",SubscrSetup."Invoice Line Description"),
                  COPYSTR(pSubscrHeader."No.",1,15),pStartDate,pEndDate),1,50);
            */

            ToInvoiceLine.Description :=
              TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Invoice Line Description"), '',
                pSubscrHeader."Language Code", SubscrSetup."Invoice Line Description");
            lSubscrHeader := pSubscrHeader;
            lSubscrHeader."Subscription Starting Date" := pStartDate;
            lSubscrHeader."Subscription End Date" := pEndDate;
            lRecordRef.GetTable(lSubscrHeader);
            Basic.SubstituteValues(ToInvoiceLine.Description, lRecordRef, '%', GlobalLanguage);
            ToInvoiceLine.Insert;
            //#8025//

            InsertTextLine(pSubscrHeader."Your Reference");
            //#7275
            if pSubscrHeader."Combine Shipments" then begin
                //#7275//
                //GL2024   FormatAddress.SalesHeaderShipTo(lShipToAddr, pSubscrHeader);
                for i := 1 to ArrayLen(lShipToAddr) do
                    if lShipToAddr[i] <> BillToAddr[i] then
                        lShowShippingAddr := true;
                if lShowShippingAddr then begin
                    CompressArray(lShipToAddr);
                    for i := 1 to ArrayLen(lShipToAddr) do
                        InsertTextLine(lShipToAddr[i]);
                end;
                //#7275
            end;
            //#7275//

            if pSubscrHeader."Review Formula Code" = '' then
                ReviewFactor := 0
            //#7710
            //  ELSE IF NOT lReviewFormula.GET(pSubscrHeader."Review Formula Code") OR
            //       (pStartDate < CALCDATE(lReviewFormula."Waiting Period Calculation",pSubscrHeader."Subscription Starting Date")) THEN
            //#7933
            /*
              ELSE BEGIN
                lReviewFormula.GET(pSubscrHeader."Review Formula Code");
                lReviewDate := CALCDATE(lReviewFormula."Starting Date Calculation",pSubscrHeader."Subscription Starting Date");
                lReviewDate := CALCDATE(lReviewFormula."Date Calculation",lReviewDate); // First one
            */
            else begin
                lReviewFormula.Get(pSubscrHeader."Review Formula Code");
                pSubscrHeader.TestField("Review Base Date");
                if pStartDate < CalcDate(lReviewFormula."Starting Date Calculation", pSubscrHeader."Review Base Date") then
                    ReviewFactor := 0
                else
                    if pStartDate < CalcDate(lReviewFormula."Date Calculation", pSubscrHeader."Subscription Starting Date") then
                        ReviewFactor := 0
                    else begin
                        //#7933//
                        //      lReviewDate := CALCDATE(lReviewFormula."Date Calculation",pSubscrHeader."Subscription Starting Date"); // First one
                        lReviewDate := pSubscrHeader."Subscription Starting Date";
                        //#7710//
                        while CalcDate(lReviewFormula."Date Calculation", lReviewDate) <= pStartDate do
                            lReviewDate := CalcDate(lReviewFormula."Date Calculation", lReviewDate);
                        ReviewFactor := lReviewFormula.fReviewFactor(pSubscrHeader."Review Base Date", lReviewDate);

                        if (pStartDate <= lReviewDate) and (lReviewDate <= pEndDate) and
                           (ReviewFactor <> 1) and
                           (lReviewFormula."Review Text Code" <> '') then begin
                            //#8025
                            /*
                                    LineInit."Line No." += 10000;
                                    ToInvoiceLine := LineInit;
                                    ToInvoiceLine."No." := lReviewFormula."Review Text Code";
                                    ToInvoiceLine.INSERT;
                                    IF TransferExtendedText.SalesCheckIfAnyExtText(ToInvoiceLine,TRUE) THEN BEGIN
                                      TransferExtendedText.InsertSalesExtText(ToInvoiceLine);
                                      LineInit."Line No." := FindLastLineNo(LineInit);
                                    END;
                            */
                            InsertExtendedText(lReviewFormula."Review Text Code");
                            //#8025//
                            InsertTextLine(StrSubstNo(tReviewFactor, ReviewFactor));
                        end;
                    end;
            end;

        end;

        ToInvoiceLine := pSubscrLine;
        ToInvoiceLine."Document Type" := LineInit."Document Type";
        ToInvoiceLine."Document No." := LineInit."Document No.";

        if (ReviewFactor <> 0) and (ToInvoiceLine."Review Option" = ToInvoiceLine."review option"::Formula) then
            ToInvoiceLine.Validate("Unit Price", ROUND(ToInvoiceLine."Unit Price" * ReviewFactor, Currency."Unit-Amount Rounding Precision"));

        if (pSubscrLine."Unit of Measure Code" <> UnitOfMeasure.Code) and (pSubscrLine."Unit of Measure Code" <> '') then
            UnitOfMeasure.Get(pSubscrLine."Unit of Measure Code");

        if (pSubscrLine."Subscription End Date" <> 0D) and
           (pSubscrLine."Subscription End Date" < pSubscrLine."Subscription Posting Date") then // Credit Line

            InsertLine(
            pSubscrLine, ToInvoiceLine, -1,
            pSubscrLine."Subscription End Date" + 1, pSubscrLine."Subscription Posting Date", pSubscrLine."Subscription End Date")

        else begin

            // Insert Full Line

            if pSubscrLine."Unit of Measure Code" <> '' then begin
                if (Format(UnitOfMeasure."Time Unit") <> '') and (UnitOfMeasure."Time Unit" <> SubscrInvoicingPeriod."Date Calculation") then
                    //#8243
                    //      ToInvoiceLine.VALIDATE(Quantity,
                    //        ToInvoiceLine.Quantity * SubscrInvoicingPeriod.fTimeUnitsPerPeriod(UnitOfMeasure."Time Unit"));
                    ToInvoiceLine.Quantity :=
                     ToInvoiceLine.Quantity * SubscrInvoicingPeriod.fTimeUnitsPerPeriod(UnitOfMeasure."Time Unit");
                //#8243//
            end;

            InsertLine(
              pSubscrLine, ToInvoiceLine, 0,
              pStartDate, pEndDate, pEndDate);

            if (pSubscrLine."Unit of Measure Code" <> '') and (Format(UnitOfMeasure."Time Unit") <> '') then begin // Prorata Temporis

                if pSubscrLine."Subscription Posting Date" = 0D then
                    pSubscrLine."Subscription Posting Date" := pSubscrLine."Subscription Starting Date" - 1;

                if pStartDate > pSubscrLine."Subscription Posting Date" + 1 then // Start before pStartDate
                    InsertLine(
                      pSubscrLine, ToInvoiceLine, +1,
                      pSubscrLine."Subscription Posting Date" + 1, pStartDate - 1, pEndDate)
                else
                    if pStartDate < pSubscrLine."Subscription Posting Date" + 1 then // Start after pStartDate
                        InsertLine(
                          pSubscrLine, ToInvoiceLine, -1,
                          pStartDate, pSubscrLine."Subscription Posting Date", pEndDate);

                if (pSubscrLine."Subscription End Date" <> 0D) and
                   (pSubscrLine."Subscription End Date" < pEndDate) then // End before pEndDate
                    InsertLine(
                      pSubscrLine, ToInvoiceLine, -1,
                      pSubscrLine."Subscription End Date" + 1, pEndDate, pSubscrLine."Subscription End Date");
            end;
        end;

    end;


    procedure InsertTextLine(pDescription: Text[50])
    begin
        if pDescription <> '' then begin
            LineInit."Line No." += 10000;
            ToInvoiceLine := LineInit;
            ToInvoiceLine.Description := CopyStr(pDescription, 1, 50);
            ToInvoiceLine.Insert;
        end;
    end;


    procedure SetInvoice(pRec: Record "Sales Header")
    var
        lLineNo: Integer;
    begin
        ToInvoiceHeader := pRec;
        LineInit.SetRange("Document Type", pRec."Document Type");
        LineInit.SetRange("Document No.", pRec."No.");
        if LineInit.FindLast then;
        lLineNo := LineInit."Line No.";
        LineInit.Init;
        LineInit."Document Type" := pRec."Document Type";
        LineInit."Document No." := pRec."No.";
        LineInit."Line No." := lLineNo;
        if pRec."Currency Code" <> '' then
            Currency.Get(pRec."Currency Code")
        else
            Currency.InitRoundingPrecision;
    end;

    /*GL2024
        procedure CopyDocDim(pTableID: Integer; pFromDocType: Integer; pFromDocNo: Code[20]; pFromLineNo: Integer; pToDocType: Integer; pToDocNo: Code[20]; pToLineNo: Integer)
        var
            lFromDocDim: Record 357;
            lToDocDim: Record 357;
        begin
            lFromDocDim.SetRange("Table ID", pTableID);
            lFromDocDim.SetRange("Document Type", pFromDocType);
            lFromDocDim.SetRange("Document No.", pFromDocNo);
            lFromDocDim.SetRange("Line No.", pFromLineNo);
            if lFromDocDim.FindSet then
                repeat
                    lToDocDim := lFromDocDim;
                    lToDocDim."Document Type" := pToDocType;
                    lToDocDim."Document No." := pToDocNo;
                    lToDocDim."Line No." := pToLineNo;
                    lToDocDim.Insert;
                until lFromDocDim.Next = 0;
        end;

    */
    procedure InsertLine(var pSubscrLine: Record "Sales Line"; var pToInvoiceLine: Record "Sales Line"; pProrataTemporis: Integer; pStartDate: Date; pEndDate: Date; pPostingDate: Date)
    begin
        // pProratatemporis : -1 : Deduct, +1 : Add, 0 : As is

        with pToInvoiceLine do begin
            LineInit."Line No." += 10000;
            "Line No." := LineInit."Line No.";

            "Blanket Order No." := pSubscrLine."Document No.";
            "Blanket Order Line No." := pSubscrLine."Line No.";

            //#8025
            /*
              CASE TRUE OF
                pProrataTemporis < 0 : BEGIN
                  Description := tIndent + STRSUBSTNO(tProrataTempDeduct,pStartDate,pEndDate);
                  VALIDATE(Quantity,1);
                  VALIDATE("Unit Price",
                    SubscrInvoicingPeriod.fProrataTemporis(-1 * pSubscrLine."Unit Price",UnitOfMeasure."Time Unit",pStartDate,pEndDate,
                    Currency."Unit-Amount Rounding Precision"));
                END;
                pProrataTemporis > 0 : BEGIN
                  Description := tIndent + STRSUBSTNO(tProrataTempAdd,pStartDate,pEndDate);
                  VALIDATE(Quantity,1);
                  VALIDATE("Unit Price",
                    SubscrInvoicingPeriod.fProrataTemporis(pSubscrLine."Unit Price",UnitOfMeasure."Time Unit",pStartDate,pEndDate,
                    Currency."Unit-Amount Rounding Precision"));
                END;
              END;

              "Subscription Starting Date" := pStartDate;
              "Subscription End Date" := pEndDate;
              "Subscription Posting Date" := pPostingDate;
              INSERT;
            */
            case true of
                pProrataTemporis < 0:
                    begin
                        Description :=
                          TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Prorata Decrease"), '',
                            ToInvoiceHeader."Language Code", SubscrSetup."Prorata Decrease");
                        Description := tIndent + StrSubstNo(Description, pStartDate, pEndDate);
                        Validate(Quantity, 1);
                        Validate("Unit Price",
                          SubscrInvoicingPeriod.fProrataTemporis(-pSubscrLine.Quantity * pSubscrLine."Unit Price",
                          UnitOfMeasure."Time Unit", pStartDate, pEndDate,
                          Currency."Unit-Amount Rounding Precision"));
                    end;
                pProrataTemporis > 0:
                    begin
                        Description :=
                          TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Prorata Increase"), '',
                            ToInvoiceHeader."Language Code", SubscrSetup."Prorata Increase");
                        Description := tIndent + StrSubstNo(Description, pStartDate, pEndDate);
                        Validate(Quantity, 1);
                        Validate("Unit Price",
                          SubscrInvoicingPeriod.fProrataTemporis(pSubscrLine.Quantity * pSubscrLine."Unit Price",
                          UnitOfMeasure."Time Unit", pStartDate, pEndDate,
                          Currency."Unit-Amount Rounding Precision"));
                    end;
            end;

            "Subscription Starting Date" := pStartDate;
            "Subscription End Date" := pEndDate;
            "Subscription Posting Date" := pPostingDate;
            //#8814
            if pProrataTemporis <> 0 then
                "Unit of Measure" := '';
            //#8814//

            //#8560
            if Type <> Type::" " then
                //#8560//
                //#8243
                ToInvoiceLine.Validate(Quantity);
            //#8243

            if (Type = 0) or ("Unit Price" <> 0) then
                Insert;
            //#8025
            /* GL2024   CopyDocDim(
                  Database::"Sales Line",
                  pSubscrLine."Document Type", pSubscrLine."Document No.", pSubscrLine."Line No.",
                  ToInvoiceLine."Document Type", ToInvoiceLine."Document No.", ToInvoiceLine."Line No.");*/
        end;

    end;


    procedure FindLastLineNo(pLine: Record "Sales Line"): Integer
    begin
        with pLine do begin
            SetRange("Document Type", "Document Type");
            SetRange("Document No.", "Document No.");
            FindLast;
            exit("Line No.");
        end;
    end;


    procedure AdditionalInvoice(var pSubscrHeader: Record "Sales Header")
    var
        lRec: Record "Sales Header";
        lSubscrLine: Record "Sales Line";
        lDateFormula: DateFormula;
    begin
        SubscrSetup.Get;
        with pSubscrHeader do begin
            if ("Document Type" <> "document type"::Subscription) or ("Posting Date" = 0D) then
                exit;
            TestField(Status, Status::Released);
            if ("Bill-to Customer No." <> Customer."No.") then begin
                Customer.Get("Bill-to Customer No.");
                Customer.TestField(Blocked, 0);
            end;

            lSubscrLine.SetRange("Document Type", "Document Type");
            lSubscrLine.SetRange("Document No.", "No.");
            lSubscrLine.SetRange("Subscription Posting Date", 0D);
            lSubscrLine.SetRange("Subscription Starting Date", 0D, "Posting Date");
            if not lSubscrLine.FindSet then
                exit
            else
                if Confirm(tAdditionalInvoice, true) then begin
                    gPostingDate := WorkDate;
                    SubscrInvoicingPeriod.Get("Invoicing Periodicity Code");
                    Evaluate(lDateFormula, '-' + Format(SubscrInvoicingPeriod."Date Calculation"));
                    gStartDate := CalcDate(lDateFormula, "Posting Date" + 1);
                    InsertInvoiceHeader(pSubscrHeader, ToInvoiceHeader, gStartDate, "Posting Date");

                    repeat
                        InsertInvoiceLine(pSubscrHeader, lSubscrLine, gStartDate, "Posting Date");

                    until lSubscrLine.Next = 0;

                    //#8298
                    lSubscrLine.SetFilter("Subscription Posting Date", '<>%1', 0D);
                    lSubscrLine.SetRange("Subscription Starting Date", 0D, "Posting Date");
                    lSubscrLine.SetRange("Subscription End Date", 0D, "Posting Date");
                    if lSubscrLine.FindSet then
                        repeat
                            if lSubscrLine."Subscription End Date" < lSubscrLine."Subscription Posting Date" then begin
                                InsertTextLine(lSubscrLine.Description);
                                InsertInvoiceLine(pSubscrHeader, lSubscrLine, gStartDate, "Posting Date");
                            end;
                        until lSubscrLine.Next = 0;
                    //#8298//

                    FinalizeInvoice(ToInvoiceHeader);

                    //#8240
                    //    FORM.RUNmodaL(FORM::"Sales Invoice",ToInvoiceHeader);
                    page.Run(Page::"Sales Invoice", ToInvoiceHeader);
                    //#8240//

                end;
        end;
    end;


    procedure InsertExtendedText(pStandardTextCode: Code[10])
    var
        lStandardText: Record "Standard Text";
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        if pStandardTextCode = '' then
            exit;
        lStandardText.Get(pStandardTextCode);
        LineInit."Line No." += 10000;
        ToInvoiceLine := LineInit;
        ToInvoiceLine."No." := pStandardTextCode;
        ToInvoiceLine.Description := lStandardText.Description;
        ToInvoiceLine.Insert;
        if TransferExtendedText.SalesCheckIfAnyExtText(ToInvoiceLine, true) then begin
            TransferExtendedText.InsertSalesExtText(ToInvoiceLine);
            LineInit."Line No." := FindLastLineNo(LineInit);
        end;
    end;
}

