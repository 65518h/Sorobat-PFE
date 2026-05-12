Codeunit 8001911 "Purch. Subscription Integr."
{
    // #8661 CW 21/12/10
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
        tOnValidate: label 'Trigger not defined for table %1 field %2';
        gHeader: Record "Purchase Header";
        tSubscriptionDate: label '%1 must be inferior than %2';
        tSubscrPostingDate: label 'Warning. This ligne already be invoices. Do you confirm themodification of this line.';
        tSubscrLine: label 'You cannot change %1 %2 %3 line %4 because this line is associated with contract %5 line %6.';
        UserExit: Codeunit UserExit;


    procedure HeaderOnInsert(var pRec: Record "Purchase Header")
    begin
    end;


    procedure HeaderOnModify(var pxRec: Record "Purchase Header"; var pRec: Record "Purchase Header")
    begin
        with pRec do begin
            if ("Document Type" = "document type"::Subscription) and (pxRec.Status <> Status) then
                TestField(Status, Status::Open);
        end;
    end;


    procedure HeaderOnDelete(var pRec: Record "Purchase Header")
    begin
        with pRec do begin
            if "Document Type" = "document type"::Subscription then
                TestField(Status, Status::Open);
        end;
    end;


    procedure HeaderOnValidate(var pxRec: Record "Purchase Header"; var pRec: Record "Purchase Header"; pFieldNo: Integer)
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
                FieldNo("Next Invoice Calculation"):
                    fCalcNextInvoiceDate(pRec);
                FieldNo("Invoicing Periodicity Code"):
                    ;
                else
                    Error(tOnValidate, TableCaption, pFieldNo);
            end;
        end;
    end;


    procedure LineOnModify(var pxRec: Record "Purchase Line"; var pRec: Record "Purchase Line")
    begin
        with pRec do begin
            if ("Document Type" in ["document type"::Invoice, "document type"::"Credit Memo"]) and
               ("Subscription Posting Date" <> 0D) then
                Error(tSubscrLine, TableCaption, "Document Type", "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.");
        end;
    end;


    procedure LineOnDelete(var pRec: Record "Purchase Line")
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


    procedure LineOnValidate(var pxRec: Record "Purchase Line"; var pRec: Record "Purchase Line"; pFieldNo: Integer)
    var
        lResource: Record Resource;
    begin
        with pRec do begin
            case pFieldNo of
                FieldNo("No."):
                    begin
                        lGetHeader("Document Type", "Document No.", true);
                        "Subscription Starting Date" := gHeader."Subscription Starting Date";
                        "Subscription End Date" := gHeader."Subscription End Date";
                        if "Document Type" = "document type"::Subscription then begin
                            if gHeader."Posting Date" = 0D then
                                "Subscription Starting Date" := gHeader."Subscription Starting Date"
                            else
                                "Subscription Starting Date" := gHeader."Posting Date" + 1;
                        end;
                    end;
                FieldNo("Direct Unit Cost"):
                    if Quantity = 0 then
                        Validate(Quantity, 1);
                FieldNo("Subscription Starting Date"):
                    begin
                        lGetHeader("Document Type", "Document No.", true);
                        TestField("Subscription Posting Date", 0D);
                        if ("Subscription Starting Date" > "Subscription End Date") and ("Subscription End Date" <> 0D) then
                            Error(tSubscriptionDate, FieldCaption("Subscription Starting Date"), FieldCaption("Subscription End Date"));
                    end;
                FieldNo("Subscription End Date"):
                    begin
                        lGetHeader("Document Type", "Document No.", true);
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
        if pTestStatusOpen then
            gHeader.TestField(Status, gHeader.Status::Open);
    end;


    procedure fCalcNextInvoiceDate(var pRec: Record "Purchase Header")
    begin
        if pRec."Document Date" = 0D then
            pRec."Next Invoice Date" := pRec."Document Date"
        else
            pRec."Next Invoice Date" := CalcDate(pRec."Next Invoice Calculation", pRec."Document Date");
    end;


    procedure CheckInvoicePending(var pSubscrHeader: Record "Purchase Header"): Boolean
    var
        lSubscrLine: Record "Purchase Line";
    begin
        lSubscrLine.Reset;
        lSubscrLine.SetCurrentkey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
        lSubscrLine.SetRange("Document Type", lSubscrLine."document type"::Invoice);
        lSubscrLine.SetRange("Blanket Order No.", pSubscrHeader."No.");
        if lSubscrLine.IsEmpty then
            exit(false);
        lSubscrLine.FindFirst;
        Error(tInvoicePending + '\' + tOpen, lSubscrLine."Blanket Order No.", pSubscrHeader."No.");
    end;


    procedure UpdateSubscrLine(var pSubscrHeader: Record "Purchase Header"; pFieldCaption: Text[100]; pConfirm: Boolean)
    var
        lSubscrLine: Record "Purchase Line";
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


    procedure UpdateSubscrPostingDate(var pRec: Record "Purchase Line")
    var
        lSubscrHeader: Record "Purchase Header";
        lSubscrLine: Record "Purchase Line";
        lRecordRef: RecordRef;
    begin
        if pRec."Blanket Order Line No." = 0 then begin
            lSubscrHeader.Get(
              lSubscrHeader."document type"::Subscription, pRec."Blanket Order No.");
            if (pRec."Subscription Posting Date" <= lSubscrHeader."Subscription Starting Date") and
               (lSubscrHeader."Posting Date" <> 0D) then
                lSubscrHeader."Posting Date" := 0D // First invoice reversed
            else
                lSubscrHeader."Posting Date" := pRec."Subscription Posting Date";
            lSubscrHeader.Modify;
            //+ABO+USEREXIT
            lRecordRef.GetTable(lSubscrHeader);
            UserExit.CodeunitOnRun(lRecordRef, Codeunit::"Purch. Subscription Integr.", 0);
            lRecordRef.SetTable(lSubscrHeader);
            //+ABO+USEREXIT//
        end else begin
            lSubscrLine.Get(
              lSubscrLine."document type"::Subscription, pRec."Blanket Order No.", pRec."Blanket Order Line No.");
            if (pRec."Subscription Posting Date" <= lSubscrLine."Subscription Starting Date") and
               (lSubscrLine."Subscription Posting Date" <> 0D) then
                lSubscrLine."Subscription Posting Date" := 0D // First invoice reversed
            else
                lSubscrLine."Subscription Posting Date" := pRec."Subscription Posting Date";
            lSubscrLine.Modify;
        end;
    end;


    procedure OnDeleteSubscrLine(var pSubscrLine: Record "Purchase Line")
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


    procedure Release(var pSubscrHeader: Record "Purchase Header")
    var
        tInvoiceExist: label 'You cannot open %1 %2. %3 %4 is link.';
        lUserExit: Codeunit UserExit;
        lSubscrLine: Record "Purchase Line";
        lRecordRef: RecordRef;
    begin
        if pSubscrHeader."Document Type" <> pSubscrHeader."document type"::Subscription then
            exit;

        pSubscrHeader.TestField(pSubscrHeader."Invoicing Periodicity Code");
        lSubscrLine.SetRange("Document Type", pSubscrHeader."Document Type");
        lSubscrLine.SetRange("Document No.", pSubscrHeader."No.");
        lSubscrLine.SetFilter(Type, '>0');
        if lSubscrLine.FindSet then
            repeat
                lSubscrLine.TestField(lSubscrLine."Subscription Starting Date");
            until lSubscrLine.Next = 0;

        /*
        //+REF+USER_EXIT
        lRecordRef.GETTABLE(pSubscrHeader);
        lUserExit.CodeunitOnRun(lRecordRef,CODEUNIT::"Release Purchase Document",+1);
        lRecordRef.SETTABLE(pSubscrHeader);
        //+REF+USER_EXIT//
        */

    end;


    procedure ReOpen(var pSubscrHeader: Record "Purchase Header")
    var
        lUserExit: Codeunit UserExit;
        lRecordRef: RecordRef;
    begin
        if pSubscrHeader."Document Type" <> pSubscrHeader."document type"::Subscription then
            exit;

        CheckInvoicePending(pSubscrHeader);
    end;


    procedure GetFromInvoice(var pRec: Record "Purchase Header")
    var
        lRec: Record "Purchase Header";
    //GL2024 NAVIBAT    lGetPurchContract: Page 8001917;
    //GL2024     lInvoicePurchContract: Codeunit 8001912;
    begin
        pRec.TestField("Pay-to Vendor No.");
        lRec.SetCurrentkey("Pay-to Vendor No.");
        lRec.SetRange("Pay-to Vendor No.", pRec."Pay-to Vendor No.");
        lRec.SetRange("Document Type", lRec."document type"::Subscription);
        lRec.SetRange("Currency Code", pRec."Currency Code");
        /*  //GL2024 NAVIBAT  lGetPurchContract.SetTableview(lRec);
        lGetPurchContract.LookupMode(true);
        if lGetPurchContract.RunModal = Action::LookupOK then begin
            lGetPurchContract.SetSelectionFilter(lRec);
            lInvoicePurchContract.SetInvoice(pRec);
            lInvoicePurchContract.Run(lRec);
        end;*/
    end;
}

