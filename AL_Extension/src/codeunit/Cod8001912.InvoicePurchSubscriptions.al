Codeunit 8001912 "Invoice Purch. Subscriptions"
{
    // #8953 CW 26/05/11
    // #8251 SD 27/09/10
    // #8025 CW 08/06/10
    // #7784 CW 18/01/10
    // #7707 CW 16/09/09
    // #7525 CW 16/09/09
    // //+ABO+ CW 10/01/09

    TableNo = "Purchase Header";

    trigger OnRun()
    var
        lRec: Record "Purchase Header";
        lSubscrLine: Record "Purchase Line";
        xSubscrLine: Record "Purchase Line";
        //GL2024   lComDlg: Codeunit 412;
        lStartDate: Date;
        lEndDate: Date;
        lAlreadyInvoiced: label 'Le contrat %1 a déjà été facturé jusqu''au %1';
    begin
        SubscrSetup.Get;
        rec.SetRange("Document Type", rec."document type"::Subscription);
        rec.SetRange(Status, rec.Status::Released);
        if not rec.FindSet then
            exit;

        //GL2024   lComDlg.ProgressOpen('', rec.COUNTAPPROX);

        repeat
            //GL2024    lComDlg.ProgressUpdate();
            rec.TestField(Status, rec.Status::Released);

            if (rec."Buy-from Vendor No." <> Vendor."No.") then begin
                Vendor.Get(rec."Buy-from Vendor No.");
                Vendor.TestField(Blocked, 0);
            end;
            // Calc Next invoicing period (lStartDate..lEndDate) for this subscription
            SubscrInvoicingPeriod.Get(rec."Invoicing Periodicity Code");
            if SubscrInvoicingPeriod.fSetNextInvoicePeriod(
                 rec."Subscription Starting Date", rec."Subscription End Date", rec."Posting Date", ToInvoiceHeader."Document Date",
                 lStartDate, lEndDate) then begin

                lSubscrLine.SetRange("Document Type", rec."Document Type");
                lSubscrLine.SetRange("Document No.", rec."No.");
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
                                if gBatchMode then
                                    if (ToInvoiceHeader."No." = '') or
                                       (lSubscrLine."Document No." <> xSubscrLine."Document No.") then begin
                                        if ToInvoiceHeader."No." <> '' then
                                            FinalizeInvoice(ToInvoiceHeader);
                                        InsertInvoiceHeader(Rec, ToInvoiceHeader, lStartDate, lEndDate);
                                    end;

                                InsertInvoiceLine(Rec, lSubscrLine, lStartDate, lEndDate);
                                xSubscrLine := lSubscrLine;
                            end;
                    until lSubscrLine.Next = 0;

            end;

        until rec.Next = 0;

        if ToInvoiceHeader."No." <> '' then
            FinalizeInvoice(ToInvoiceHeader);

        //GL2024  lComDlg.ProgressClose();

        if not gBatchMode then
            exit
        else
            if (NoOfInvoice = 1) and not gPost then
                Page.RunModal(Page::"Purchase Invoice", ToInvoiceHeader)
            else
                if NoOfInvoice = 0 then
                    Message(tNoInvoice)
                else
                    if (NoOfInvoice = 1) and (ToInvoiceHeader."Last Posting No." <> '') then
                        Message(tUniquePostedInvoice, ToInvoiceHeader."Last Posting No.")
                    else
                        if gPost then
                            Message(tPostedInvoices, NoOfInvoice, NoOfPosted)
                        else
                            Message(tCreatedInvoices, NoOfInvoice);
    end;

    var
        Counter: Integer;
        LineInit: Record "Purchase Line";
        tSubscrHeader: label 'Contract no. %1:';
        ToInvoiceHeader: Record "Purchase Header";
        ToInvoiceLine: Record "Purchase Line";
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
        PurchPost: Codeunit "Purch.-Post";
        Vendor: Record Vendor;
        tPostError: label '%1 invoice(s) can''t be posted.';
        tNoInvoice: label 'There is nothing to invoice.';
        tCreatedInvoices: label '%1 invoice(s) created.';
        tPostedInvoices: label '%1 factures validées.';
        tUniquePostedInvoice: label 'Posted invoice No. %1';
        SubscrSetup: Record "Subscription Setup";
        TranslationMgt: Codeunit "Translation Management";
        gBatchMode: Boolean;
        tAdditionalInvoice: label 'Do you want to create an additional invoice for the period already invoiced?';
        Basic: Codeunit Basic;


    procedure InitRequest(pPostingDate: Date; pStartDate: Date; pPost: Boolean)
    begin
        gPostingDate := pPostingDate;
        gStartDate := pStartDate;
        gPost := pPost;
        gBatchMode := true;
    end;

    local procedure InsertInvoiceHeader(pSubscrHeader: Record "Purchase Header"; var pToInvoiceHeader: Record "Purchase Header"; pStartDate: Date; pEndDate: Date)
    var
        lFromDocDim: Record "Gen. Jnl. Dim. Filter";
        lToDocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        with pToInvoiceHeader do begin
            Init;
            SetHideValidationDialog(true);
            TransferFields(pSubscrHeader, false);
            Status := Status::Open;
            Validate("Document Type", "document type"::Invoice);
            "No." := '';
            "Responsibility Center" := pSubscrHeader."Responsibility Center"; // for RespCenterInitSeriesNo
            pToInvoiceHeader.Insert(true);
            Validate("Posting Date", gPostingDate);
            //#7784
            //  VALIDATE("Document Date",gStartDate);
            Validate("Document Date", gPostingDate);
            //#7784//
            //  "Applies-to ID" := pSubscrHeader."No."; // Move to "Order No." when Posting
            /*GL2024 CopyDocDim(
               Database::"Purchase Header",
               pSubscrHeader."Document Type", pSubscrHeader."No.", 0,
               pToInvoiceHeader."Document Type", pToInvoiceHeader."No.", 0);*/
            //#7784
            Modify;
            //??  COMMIT;
            //#7784//
        end;

        //FormatAddress.SalesHeaderBillTo(BillToAddr,pToInvoiceHeader);
        SetInvoice(pToInvoiceHeader);
    end;


    procedure FinalizeInvoice(var pInvoiceHeader: Record "Purchase Header")
    begin
        Commit;
        NoOfInvoice += 1;
        LineInit."Line No." := 0;

        if gPost then begin
            pInvoiceHeader."Vendor Invoice No." := pInvoiceHeader."No."; // Set External Doc. No.
            pInvoiceHeader.Modify;
            Commit;
            Clear(PurchPost);
            if PurchPost.Run(pInvoiceHeader) then
                NoOfPosted += 1;
        end;
    end;


    procedure InsertInvoiceLine(var pSubscrHeader: Record "Purchase Header"; var pSubscrLine: Record "Purchase Line"; pStartDate: Date; pEndDate: Date)
    var
        tDescrProrataDate: label 'Prorata temporis %1-%2';
        tDescrProrata2Date: label 'Prorata temp. %1-%2 %3-%4';
        tDescrDateCrMemo: label 'Credit memo from %1 to %2';
        tDescrDateInvoice: label 'Invoice from %1 to %2';
        lFromDocDim: Record "Gen. Jnl. Dim. Filter";
        lToDocDim: Record "Gen. Jnl. Dim. Filter";
        lSubscrLine: Record "Purchase Line";
        lSubscrHeader: Record "Purchase Header";
        lRecordRef: RecordRef;
    begin
        // Check Line Invoicing is pending
        lSubscrLine.SetCurrentkey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        lSubscrLine.SetRange("Document Type", lSubscrLine."document type"::Invoice);
        lSubscrLine.SetRange("Blanket Order No.", pSubscrLine."Document No.");
        lSubscrLine.SetRange("Blanket Order Line No.", pSubscrLine."Line No.");
        if lSubscrLine.FindFirst then
            if lSubscrLine."Document No." = ToInvoiceHeader."No." then
                exit
            else
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
                COPYSTR(STRSUBSTNO(tSubscrHeader,COPYSTR(pSubscrHeader."No.",1,15),pStartDate,pEndDate),1,50);
            */

            ToInvoiceLine.Description :=
              TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Invoice Line Description"), '',
                pSubscrHeader."Language Code", SubscrSetup."Invoice Line Description");
            lSubscrHeader := pSubscrHeader;
            lSubscrHeader."Subscription Starting Date" := pStartDate;
            lSubscrHeader."Subscription End Date" := pEndDate;
            lRecordRef.GetTable(lSubscrHeader);
            Basic.SubstituteValues(ToInvoiceLine.Description, lRecordRef, '%', GlobalLanguage);
            //#8025//
            ToInvoiceLine.Insert;

            InsertTextLine(pSubscrHeader."Your Reference");
        end;

        ToInvoiceLine := pSubscrLine;
        ToInvoiceLine."Document Type" := LineInit."Document Type";
        ToInvoiceLine."Document No." := LineInit."Document No.";

        if (pSubscrLine."Subscription End Date" <> 0D) and
           (pSubscrLine."Subscription End Date" < pSubscrLine."Subscription Posting Date") then begin // Credit Line
                                                                                                      //#8251
            if pSubscrLine."Unit of Measure Code" <> '' then begin
                if pSubscrLine."Unit of Measure Code" <> UnitOfMeasure.Code then
                    UnitOfMeasure.Get(pSubscrLine."Unit of Measure Code");
            end;
            //#8251//
            InsertLine(
              pSubscrLine, ToInvoiceLine, -1,
              pSubscrLine."Subscription End Date" + 1, pSubscrLine."Subscription Posting Date", pSubscrLine."Subscription End Date");

        end else begin

            // Insert Full Line

            if pSubscrLine."Unit of Measure Code" <> '' then begin
                if pSubscrLine."Unit of Measure Code" <> UnitOfMeasure.Code then
                    UnitOfMeasure.Get(pSubscrLine."Unit of Measure Code");
                if (Format(UnitOfMeasure."Time Unit") <> '') and (UnitOfMeasure."Time Unit" <> SubscrInvoicingPeriod."Date Calculation") then
                    ToInvoiceLine.Validate(Quantity,
                      ToInvoiceLine.Quantity * SubscrInvoicingPeriod.fTimeUnitsPerPeriod(UnitOfMeasure."Time Unit"));
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


    procedure SetInvoice(pRec: Record "Purchase Header")
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

    /* GL2024
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

    procedure InsertLine(var pSubscrLine: Record "Purchase Line"; var pToInvoiceLine: Record "Purchase Line"; pProrataTemporis: Integer; pStartDate: Date; pEndDate: Date; pPostingDate: Date)
    begin
        // pProratatemporis : -1 : Deduct, +1 : Add, 0 : As is

        with pToInvoiceLine do begin
            LineInit."Line No." += 10000;
            "Line No." := LineInit."Line No.";

            "Blanket Order No." := pSubscrLine."Document No.";
            "Blanket Order Line No." := pSubscrLine."Line No.";

            case true of
                pProrataTemporis < 0:
                    begin
                        //#8025
                        //      Description := tIndent + STRSUBSTNO(tProrataTempDeduct,pStartDate,pEndDate);
                        //      VALIDATE(Quantity,1);
                        //      VALIDATE("Direct Unit Cost",
                        //        SubscrInvoicingPeriod.fProrataTemporis(- 1 * pSubscrLine."Direct Unit Cost",
                        //        UnitOfMeasure."Time Unit",pStartDate,pEndDate,
                        //        Currency."Unit-Amount Rounding Precision"));
                        Description :=
                          TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Prorata Decrease"), '',
                            ToInvoiceHeader."Language Code", SubscrSetup."Prorata Decrease");
                        Description := tIndent + StrSubstNo(Description, pStartDate, pEndDate);
                        Validate(Quantity, 1);
                        Validate("Direct Unit Cost",
                          SubscrInvoicingPeriod.fProrataTemporis(-pSubscrLine.Quantity * pSubscrLine."Direct Unit Cost",
                          UnitOfMeasure."Time Unit", pStartDate, pEndDate,
                          Currency."Unit-Amount Rounding Precision"));
                        //#8025//
                    end;
                pProrataTemporis > 0:
                    begin
                        //#8025
                        //      Description := tIndent + STRSUBSTNO(tProrataTempAdd,pStartDate,pEndDate);
                        //      VALIDATE(Quantity,1);
                        //      VALIDATE("Direct Unit Cost",SubscrInvoicingPeriod.fProrataTemporis(pSubscrLine."Direct Unit Cost",
                        //        UnitOfMeasure."Time Unit",pStartDate,pEndDate,
                        //        Currency."Unit-Amount Rounding Precision"));
                        Description :=
                          TranslationMgt.Format(Database::"Subscription Setup", SubscrSetup.FieldNo("Prorata Increase"), '',
                            ToInvoiceHeader."Language Code", SubscrSetup."Prorata Increase");
                        Description := tIndent + StrSubstNo(Description, pStartDate, pEndDate);
                        Validate(Quantity, 1);
                        Validate("Direct Unit Cost",
                          SubscrInvoicingPeriod.fProrataTemporis(pSubscrLine.Quantity * pSubscrLine."Direct Unit Cost",
                          UnitOfMeasure."Time Unit", pStartDate, pEndDate,
                          Currency."Unit-Amount Rounding Precision"));
                        //#8025//
                    end;
            end;

            "Subscription Starting Date" := pStartDate;
            "Subscription End Date" := pEndDate;
            "Subscription Posting Date" := pPostingDate;
            Insert;
            /*GL2024  CopyDocDim(
                Database::"Purchase Line",
                pSubscrLine."Document Type", pSubscrLine."Document No.", pSubscrLine."Line No.",
                ToInvoiceLine."Document Type", ToInvoiceLine."Document No.", ToInvoiceLine."Line No.");*/
        end;
    end;


    procedure AdditionalInvoice(var pSubscrHeader: Record "Purchase Header")
    var
        lRec: Record "Purchase Header";
        lSubscrLine: Record "Purchase Line";
        lDateFormula: DateFormula;
    begin
        SubscrSetup.Get;
        with pSubscrHeader do begin
            if ("Document Type" <> "document type"::Subscription) or ("Posting Date" = 0D) then
                exit;
            TestField(Status, Status::Released);
            if ("Buy-from Vendor No." <> Vendor."No.") then begin
                Vendor.Get("Buy-from Vendor No.");
                Vendor.TestField(Blocked, 0);
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

                    FinalizeInvoice(ToInvoiceHeader);

                    //#8240
                    //    FORM.RUNmodaL(FORM::"Purchase Invoice",ToInvoiceHeader);
                    page.Run(page::"Purchase Invoice", ToInvoiceHeader);
                    //#8240//

                end;
        end;
    end;
}

