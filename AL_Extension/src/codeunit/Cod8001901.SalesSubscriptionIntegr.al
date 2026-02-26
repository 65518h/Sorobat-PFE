Codeunit 8001901 "Sales Subscription Integr."
{
    // #9190 AC 19/12/11
    // #8970 CW 06/06/11
    // #8948 AC 24/05/11
    // #8893 CW 26/04/11 +UserExit/SubscrLine
    // #8661 CW 21/12/10
    // #8240 SD 09/12/10
    // #7737 CW 16/12/09
    // //+ABO+USEREXIT CW 04/06/09
    // //++ABO++ GESWAY 30/06/08


    trigger OnRun()
    begin
    end;

    var
        tInvoicePending: label 'Invoice %1 is pending for contract %2.';
        tOpen: label 'You cannot open this contract.';
        tDeleteLine: label 'You cannot delete %1 %2 %3 because %4 is not equal to %5.';
        tReview: label 'and %1 are both required or empty';
        tNextReview: label 'Next review date doesn''t match with an invoicing period.';
        tContinue: label 'Do you want to continue?';
        tGreaterThan: label 'is greater than %1';
        tOnValidate: label 'Trigger not defined for table %1 field %2';
        tReviewWarning: label 'Field %1 has been modified. Check prices update if required';
        gHeader: Record "Sales Header";
        tSubscriptionDate: label '%1 must be inferior than %2';
        tSubscrPostingDate: label 'Warning. This ligne already be invoices. Do you confirm themodification of this line.';
        tSubscrLine: label 'You cannot change %1 %2 %3 line %4 because this line is associated with contract %5 line %6.';
        UserExit: Codeunit UserExit;


    procedure HeaderOnInsert(var pRec: Record "Sales Header")
    var
    //GL2024 Automation non compatible   lSetup: Record 8001900;
    begin
        with pRec do begin
            if "Document Type" = "document type"::Subscription then begin
                //GL2024 Automation non compatible  lSetup.Get;
                //GL2024 Automation non compatible   "Posting Description" := lSetup."Sales Contract Posting Desc.";
            end;
        end;
    end;


    procedure HeaderOnModify(var pxRec: Record "Sales Header"; var pRec: Record "Sales Header")
    begin
        with pRec do begin
            //#8240
            if (pxRec.Status = pxRec.Status::Open) and (pRec.Status = pRec.Status::Released) then
                exit;
            //#8240//
            if ("Document Type" = "document type"::Subscription) and (pxRec.Status <> Status) then
                TestField(Status, Status::Open);
        end;
    end;


    procedure HeaderOnDelete(var pRec: Record "Sales Header")
    var
        //GL2024 Automation non compatible   lContractValueEntry: Record 8001907;
        ltHasBeenReleased: label 'has been released. You should use the delete canceled contracts batch job';
    begin
        with pRec do begin
            if "Document Type" = "document type"::Subscription then begin
                TestField(Status, Status::Open);
                //#8970
                //GL2024 Automation non compatible     lContractValueEntry.SetRange("Document Type", "Document Type");
                //GL2024 Automation non compatible   lContractValueEntry.SetRange("Document No.", "No.");
                //GL2024 Automation non compatible  if not lContractValueEntry.IsEmpty then
                //GL2024 Automation non compatible      FieldError("No.", ltHasBeenReleased);
                //#8970//
            end;
        end;
    end;


    procedure HeaderOnValidate(var pxRec: Record "Sales Header"; var pRec: Record "Sales Header"; pFieldNo: Integer)
    begin
        with pRec do begin
            if not (pFieldNo in [FieldNo("Document Date"), FieldNo("Next Invoice Calculation")]) then
                TestField(Status, Status::Open);
            case pFieldNo of
                FieldNo("Document Date"):
                    fCalcNextInvoiceDate(pRec);
                FieldNo("Subscription Starting Date"):
                    UpdateSubscrLine(pRec, FieldCaption("Subscription Starting Date"), true);
                FieldNo("Subscription End Date"):
                    UpdateSubscrLine(pRec, FieldCaption("Subscription End Date"), true);
                /* GL2024  FieldNo("Review Base Date"):
                       ;*/
                FieldNo("Next Invoice Calculation"):
                    fCalcNextInvoiceDate(pRec);
                FieldNo("Invoicing Periodicity Code"):
                    ;
                FieldNo("Review Formula Code"):
                    ;
                FieldNo("Review Base Date"):
                    if (pxRec."Review Base Date" <> 0D) and ("Review Base Date" <> pxRec."Review Base Date") then
                        Message(tReviewWarning, FieldCaption("Review Base Date"));
                else
                    Error(tOnValidate, TableCaption, pFieldNo);
            end;
        end;
    end;


    procedure LineOnModify(var pxRec: Record "Sales Line"; var pRec: Record "Sales Line")
    begin
        with pRec do begin
            if ("Document Type" in ["document type"::Invoice, "document type"::"Credit Memo"]) and
               ("Subscription Posting Date" <> 0D) then
                Error(tSubscrLine, TableCaption, "Document Type", "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.");
        end;
    end;


    procedure LineOnDelete(var pRec: Record "Sales Line")
    begin
        with pRec do begin
            //#7737
            if ("Document Type" = "document type"::Subscription) and
               ("Subscription Posting Date" <> 0D) and ("Subscription Posting Date" <> "Subscription End Date") then
                Error(tDeleteLine,
                  "Document Type", "Document No.", "Line No.", FieldCaption("Subscription Posting Date"), FieldCaption("Subscription End Date"));
            //#7737//
        end;
    end;


    procedure LineOnValidate(var pxRec: Record "Sales Line"; var pRec: Record "Sales Line"; pFieldNo: Integer; pTestStatusOpen: Boolean)
    var
        lResource: Record Resource;
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        with pRec do begin
            case pFieldNo of
                FieldNo("No."):
                    begin
                        lGetHeader("Document Type", "Document No.", pTestStatusOpen);
                        //#      lGetHeader("Document Type","Document No.",TRUE);
                        "Subscription Starting Date" := gHeader."Subscription Starting Date";
                        "Subscription End Date" := gHeader."Subscription End Date";
                        if "Document Type" = "document type"::Subscription then begin
                            if Type = Type::Resource then begin
                                lResource.Get("No.");
                                pRec."Review Option" := lResource."Review Option";
                            end;
                            if gHeader."Posting Date" = 0D then
                                "Subscription Starting Date" := gHeader."Subscription Starting Date"
                            else
                                "Subscription Starting Date" := gHeader."Posting Date" + 1;
                        end;
                        //#9190
                        if Quantity = 0 then begin
                            PriceCalcMgt.FindSalesLineLineDisc(gHeader, pRec);
                            PriceCalcMgt.FindSalesLinePrice(gHeader, pRec, pFieldNo);
                        end;
                        //#9190//
                    end;
                FieldNo("Unit Price"):
                    if Quantity = 0 then
                        Validate(Quantity, 1);
                FieldNo("Subscription Starting Date"):
                    begin
                        lGetHeader("Document Type", "Document No.", pTestStatusOpen);
                        TestField("Subscription Posting Date", 0D);
                        if ("Subscription Starting Date" > "Subscription End Date") and ("Subscription End Date" <> 0D) then
                            Error(tSubscriptionDate, FieldCaption("Subscription Starting Date"), FieldCaption("Subscription End Date"));
                    end;
                FieldNo("Subscription End Date"):
                    begin
                        lGetHeader("Document Type", "Document No.", pTestStatusOpen);
                        if ("Subscription Starting Date" > "Subscription End Date") and ("Subscription End Date" <> 0D) then
                            Error(tSubscriptionDate, FieldCaption("Subscription Starting Date"), FieldCaption("Subscription End Date"));
                        if ("Subscription End Date" <> pxRec."Subscription End Date") and ("Subscription End Date" < "Subscription Posting Date")
                  and
                           ("Subscription Posting Date" <> 0D) and ("Subscription End Date" <> 0D) then
                            if not Confirm(tSubscrPostingDate, true, "Subscription Posting Date") then
                                Error('');
                    end;
                else
                    Error(tOnValidate, TableCaption, pFieldNo);
            end;
        end;
    end;

    local procedure lGetHeader(pDocumentType: Integer; pDocumentNo: Code[20]; pTestStatusOpen: Boolean)
    begin
        if (pDocumentType <> gHeader."Document Type") or (pDocumentNo <> gHeader."No.") then
            gHeader.Get(pDocumentType, pDocumentNo);
        IF pTestStatusOpen THEN;
        //      gHeader.TESTFIELD(Status, gHeader.Status::Open);
    end;


    procedure fCalcNextInvoiceDate(var pRec: Record "Sales Header")
    begin
        if pRec."Document Date" = 0D then
            pRec."Next Invoice Date" := pRec."Document Date"
        else
            pRec."Next Invoice Date" := CalcDate(pRec."Next Invoice Calculation", pRec."Document Date");
    end;


    procedure CheckInvoicePending(var pSubscrHeader: Record "Sales Header"): Boolean
    var
        lSubscrLine: Record "Sales Line";
    begin
        lSubscrLine.Reset;
        lSubscrLine.SetCurrentkey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        lSubscrLine.SetRange("Document Type", lSubscrLine."document type"::Invoice);
        lSubscrLine.SetRange("Blanket Order No.", pSubscrHeader."No.");
        if lSubscrLine.IsEmpty then
            exit(false);
        lSubscrLine.FindFirst;
        Error(tInvoicePending + '\' + tOpen, lSubscrLine."Document No.", pSubscrHeader."No.");
    end;


    procedure UpdateSubscrLine(var pSubscrHeader: Record "Sales Header"; pFieldCaption: Text[100]; pConfirm: Boolean)
    var
        lSubscrLine: Record "Sales Line";
        tFieldModified: label 'You have modified %1.';
        tConfirmUpdateLines: label 'Do you want to update lines?';
    begin
        lSubscrLine.SetRange("Document Type", pSubscrHeader."Document Type");
        lSubscrLine.SetRange("Document No.", pSubscrHeader."No.");
        lSubscrLine.SetFilter(Type, '>0');
        if lSubscrLine.IsEmpty then
            exit;

        if pConfirm and GuiAllowed then
            if not Confirm(StrSubstNo(tFieldModified + '\' + tConfirmUpdateLines, pFieldCaption)) then
                exit;

        lSubscrLine.LockTable;
        lSubscrLine.FindSet;
        repeat
            if (lSubscrLine."Subscription End Date" <> lSubscrLine."Subscription Posting Date") or
               (lSubscrLine."Subscription End Date" = 0D) then begin
                case pFieldCaption of
                    pSubscrHeader.FieldCaption("Subscription Starting Date"):
                        lSubscrLine.Validate("Subscription Starting Date", pSubscrHeader."Subscription Starting Date");
                    pSubscrHeader.FieldCaption("Subscription End Date"):
                        lSubscrLine.Validate("Subscription End Date", pSubscrHeader."Subscription End Date");
                end;
                lSubscrLine.Modify(true);
            end;
        until lSubscrLine.Next = 0;
    end;


    procedure UpdateSubscrPostingDate(var pRec: Record "Sales Line")
    var
        lSubscrHeader: Record "Sales Header";
        lSubscrLine: Record "Sales Line";
        lRecordRef: RecordRef;
    begin
        if pRec."Blanket Order Line No." = 0 then begin
            lSubscrHeader.Get(
              lSubscrHeader."document type"::Subscription, pRec."Blanket Order No.");
            if (pRec."Subscription Posting Date" <= lSubscrHeader."Subscription Starting Date") and
               (lSubscrHeader."Posting Date" <> 0D) then
                lSubscrHeader.Validate("Posting Date", 0D) // First invoice reversed
            else
                lSubscrHeader.Validate("Posting Date", pRec."Subscription Posting Date");
            //+ABO+USEREXIT
            lRecordRef.GetTable(lSubscrHeader);
            UserExit.CodeunitOnRun(lRecordRef, Codeunit::"Sales Subscription Integr.", 0);
            lRecordRef.SetTable(lSubscrHeader);
            //+ABO+USEREXIT//
            lSubscrHeader.Modify;
        end else begin
            lSubscrLine.Get(
              lSubscrLine."document type"::Subscription, pRec."Blanket Order No.", pRec."Blanket Order Line No.");
            if (pRec."Subscription Posting Date" <= lSubscrLine."Subscription Starting Date") and
               (lSubscrLine."Subscription Posting Date" <> 0D) then
                lSubscrLine."Subscription Posting Date" := 0D // First invoice reversed
            else
                lSubscrLine."Subscription Posting Date" := pRec."Subscription Posting Date";
            //+ABO+USEREXIT
            lRecordRef.GetTable(lSubscrLine);
            UserExit.CodeunitOnRun(lRecordRef, Codeunit::"Sales Subscription Integr.", 0);
            lRecordRef.SetTable(lSubscrLine);
            //+ABO+USEREXIT//
            lSubscrLine.Modify;
        end;
    end;


    procedure OnDeleteSubscrLine(var pSubscrLine: Record "Sales Line")
    begin
        if pSubscrLine."Document Type" <> pSubscrLine."document type"::Subscription then
            exit;

        if pSubscrLine."Subscription Posting Date" = 0D then
            exit;

        if pSubscrLine."Subscription Posting Date" < pSubscrLine."Subscription End Date" then
            Error(
              tDeleteLine,
              pSubscrLine."Document Type", pSubscrLine."Document No.", pSubscrLine."Line No.",
              pSubscrLine.FieldCaption(pSubscrLine."Subscription Posting Date"),
              pSubscrLine.FieldCaption(pSubscrLine."Subscription End Date"));
    end;


    procedure Release(var pSubscrHeader: Record "Sales Header")
    var
        tInvoiceExist: label 'You cannot open %1 %2. %3 %4 is link.';
        lSubscrLine: Record "Sales Line";
        lReleaseSalesDoc: Codeunit "Release Sales Document";
    //GL2024 Automation non compatible    lInvoiceSubscr: Codeunit 8001902;
    begin
        with pSubscrHeader do begin
            if (Status = Status::Released) or ("Document Type" <> "document type"::Subscription) then
                exit;

            TestField("Invoicing Periodicity Code");
            lSubscrLine.SetRange("Document Type", "Document Type");
            lSubscrLine.SetRange("Document No.", "No.");
            lSubscrLine.SetFilter(Type, '>0');
            if lSubscrLine.FindSet then
                repeat
                    lSubscrLine.TestField(lSubscrLine."Subscription Starting Date");
                until lSubscrLine.Next = 0;

            if ("Review Formula Code" <> '') and ("Review Base Date" = 0D) or
               ("Review Formula Code" = '') and ("Review Base Date" <> 0D) then
                FieldError("Review Base Date", StrSubstNo(tReview, FieldCaption("Review Formula Code")))
            else
                if "Review Formula Code" <> '' then
                    CheckReviewDate(pSubscrHeader);

            lReleaseSalesDoc.PerformManualRelease(pSubscrHeader);
            //GL2024 Automation non compatible       lInvoiceSubscr.AdditionalInvoice(pSubscrHeader);
            //#8970
            //GL2024 Automation non compatible   Codeunit.Run(Codeunit::ContractValueEntryMgt, pSubscrHeader);
            //#8970//
        end;
    end;


    procedure ReOpen(var pSubscrHeader: Record "Sales Header")
    begin
        if pSubscrHeader."Document Type" <> pSubscrHeader."document type"::Subscription then
            exit;

        CheckInvoicePending(pSubscrHeader);
    end;


    procedure CheckReviewDate(var pSubscrHeader: Record "Sales Header")
    var
        lReviewFormula: Record "Subscr. Review Formula";
        lNextReviewDate: Date;
        //GL2024 Automation non compatible  lSubscrInvoicingPeriod: Record 8001902;
        lPostingDate: Date;
    begin
        lReviewFormula.Get(pSubscrHeader."Review Formula Code");
        lReviewFormula.TestField("Date Calculation");
        //GL2024 Automation non compatible    lSubscrInvoicingPeriod.Get(pSubscrHeader."Invoicing Periodicity Code");
        //GL2024 Automation non compatible     lSubscrInvoicingPeriod.TestField("Date Calculation");
        pSubscrHeader.TestField("Subscription Starting Date");
        //#7710
        /*
        IF pSubscrHeader."Review Base Date" > pSubscrHeader."Subscription Starting Date" THEN
          pSubscrHeader.FIELDERROR("Review Base Date",STRSUBSTNO(tGreaterThan,pSubscrHeader.FIELDCAPTION("Subscription Starting Date")));
        REPEAT
          lNextReviewDate := CALCDATE(lReviewFormula."Date Calculation",pSubscrHeader."Subscription Starting Date");
        UNTIL lNextReviewDate >= pSubscrHeader."Posting Date";
        */
        lNextReviewDate := CalcDate(lReviewFormula."Starting Date Calculation", pSubscrHeader."Subscription Starting Date");
        repeat
            lNextReviewDate := CalcDate(lReviewFormula."Date Calculation", lNextReviewDate);
        until lNextReviewDate >= pSubscrHeader."Posting Date";
        //#7710//
        //GL2024 Automation non compatible  if pSubscrHeader."Posting Date" = 0D then
        //GL2024 Automation non compatible    lPostingDate := CalcDate(lSubscrInvoicingPeriod."Starting Date Calculation", pSubscrHeader."Subscription Starting Date")
        //GL2024 Automation non compatible else
        if lNextReviewDate = pSubscrHeader."Posting Date" + 1 then
            exit
        else
            lPostingDate := pSubscrHeader."Posting Date";
        while lPostingDate < lNextReviewDate do
            //GL2024 Automation non compatible       lPostingDate := CalcDate(lSubscrInvoicingPeriod."Date Calculation", lPostingDate);
            if lPostingDate <> lNextReviewDate then
                if not Confirm(tNextReview + '\' + tContinue, false) then
                    Error('');

    end;
}

