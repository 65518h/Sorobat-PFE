Codeunit 8003980 "Prepayment Management"
{
    // //+ONE+PREPAYMENT CW 05/09/07


    trigger OnRun()
    begin
    end;

    var
        tLessThanInv: label '%1 can be reduced for %2 line(s).';
        tInvoicingMethod: label '''Prepayments'' require to post 100% prepayments before posting the order';
        tInvoicePostingDate: label 'must be after previous prepayment invoice posting date (%1)';
        tCrMemoPostingDate: label 'must be equal to last prepayment invoice posting date (%1)';
        tBothPostingDate: label 'must be after or equal to last prepayment invoice posting date (%1)';
        tDeleteSalesInvoice: label 'doit être soldée avant de supprimer les factures et avoirs associés';


    procedure SetSalesLine(var pSalesLine: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lCount: Integer;
        lTempSalesLine: Record "Sales Line";
    begin
        if pSalesLine."Line Type" <> pSalesLine."line type"::Totaling then
            exit;
        with lSalesLine do begin
            Copy(pSalesLine);
            CopyFilters(pSalesLine);
            while (Next <> 0) and (Level > pSalesLine.Level) do begin
                if Type <> 0 then begin
                    lTempSalesLine.Copy(lSalesLine);
                    lTempSalesLine."Prepmt. Amt. Inv." := 0;
                    lTempSalesLine.Validate("Prepayment %", pSalesLine."Prepayment %");
                    if lTempSalesLine."Prepmt. Line Amount" < "Prepmt. Amt. Inv." then
                        lCount += 1
                    else begin
                        Validate("Prepayment %", pSalesLine."Prepayment %");
                        Modify;
                    end;
                end;
            end;
        end;

        pSalesLine."Prepayment %" := 0;
        pSalesLine."Prepmt. Line Amount" := 0;
        if lCount <> 0 then
            Message(tLessThanInv, lSalesLine.FieldCaption("Prepayment %"), lCount);
    end;


    procedure ResetSalesLine(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
    begin
        with lSalesLine do begin
            SetRange("Document Type", pSalesHeader."Document Type");
            SetRange("Document No.", pSalesHeader."No.");
            SetFilter(Type, '<>0');
            SetRange("Structure Line No.", 0);
            if FindSet then
                repeat
                    if "Prepmt. Line Amount" <> "Prepmt. Amt. Inv." then begin
                        Validate("Prepmt. Line Amount", "Prepmt. Amt. Inv.");
                        Modify;
                    end;
                until Next = 0;
        end;
    end;


    procedure SetToShipped(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lAmount: Decimal;
        lCount: Integer;
    begin
        with lSalesLine do begin
            SetRange("Document Type", pSalesHeader."Document Type");
            SetRange("Document No.", pSalesHeader."No.");
            SetFilter(Type, '<>0');
            SetRange("Structure Line No.", 0);
            SetFilter(Quantity, '<>0');
            if FindSet then
                repeat
                    lAmount := "Line Amount" * "Quantity Shipped" / Quantity;
                    if lAmount < "Prepmt. Amt. Inv." then
                        lCount += 1
                    else
                        if lAmount <> "Prepmt. Line Amount" then begin
                            Validate("Prepmt. Line Amount", lAmount);
                            Modify;
                        end;
                until Next = 0;
        end;

        if lCount <> 0 then
            Message(tLessThanInv, lSalesLine.FieldCaption("Prepayment %"), lCount);
    end;


    procedure SalesPostYN(var pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lError: Boolean;
    begin
        with pSalesHeader do begin
            if Invoice and ("Invoicing Method" in ["invoicing method"::Completion]) then begin
                lSalesLine.SetCurrentkey(
                  "Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option);
                lSalesLine.SetRange("Document Type", "Document Type");
                lSalesLine.SetRange("Document No.", "No.");
                lSalesLine.SetRange("Structure Line No.", 0);
                lSalesLine.SetFilter("Line Type", '>%1', lSalesLine."line type"::Totaling);
                //#5110
                lSalesLine.SetRange("Assignment Basis", 0);
                lSalesLine.SetRange(Option, false);
                //#5110//
                if lSalesLine.FindSet then
                    repeat
                        lError := lSalesLine."Prepmt. Line Amount" <> lSalesLine."Line Amount";
                        //#5134
                        if lError and (lSalesLine."Quote No." = '') and not lSalesLine."Prepayment Line" then     //Ligne ajoutée sur cde
                            lError := false;
                    //#5134//
                    until (lSalesLine.Next = 0) or lError;
                if lError then
                    pSalesHeader.FieldError("Invoicing Method", tInvoicingMethod);
            end;

        end;
    end;


    procedure SalesPostingDate(var pSalesHeader: Record "Sales Header"; pDocumentType: Option Invoice,"Credit Memo",Both)
    var
        lSalesInvoiceHeader: Record "Sales Invoice Header";
        lDateCtrl: Date;
    begin
        with lSalesInvoiceHeader do begin
            //#5817
            //  SETCURRENTKEY("Prepayment Order No.","Prepayment Invoice");
            SetCurrentkey("Prepayment Order No.", "Posting Date");
            //#5817//
            SetRange("Prepayment Order No.", pSalesHeader."No.");
            SetRange("Prepayment Invoice", true);
            SetRange("Reverse Prepmt. Cr. Memo No.", '');
            if not FindLast then begin
            end
            else
                if (pDocumentType = Pdocumenttype::Invoice) and (pSalesHeader."Posting Date" <= "Posting Date") then
                    pSalesHeader.FieldError("Posting Date", StrSubstNo(tInvoicePostingDate, "Posting Date"))
                //#6251
                //  ELSE IF (pDocumentType = pDocumentType::"Credit Memo") AND (pSalesHeader."Posting Date" <> "Posting Date") THEN
                //    pSalesHeader.FIELDERROR("Posting Date",STRSUBSTNO(tCrMemoPostingDate,"Posting Date"))
                //  ELSE IF (pDocumentType = pDocumentType::Both) AND (pSalesHeader."Posting Date" < "Posting Date") THEN
                //    pSalesHeader.FIELDERROR("Posting Date",STRSUBSTNO(tBothPostingDate,"Posting Date"))
                //#7596  ELSE IF pSalesHeader."Posting Date" < "Posting Date" THEN
                //    pSalesHeader.FIELDERROR("Posting Date",STRSUBSTNO(tInvoicePostingDate,"Posting Date"))
                else
                    if pSalesHeader."Document Date" < "Document Date" then
                        pSalesHeader.FieldError("Document Date", StrSubstNo(tInvoicePostingDate, "Document Date"))
            //#7596//
            //#6251//
        end;
    end;


    procedure DeleteSalesInvoice(var pSalesInvoiceHeader: Record "Sales Invoice Header")
    var
        lSalesHeader: Record "Sales Header";
    begin
        if pSalesInvoiceHeader."Prepayment Order No." <> '' then
            if lSalesHeader.Get(lSalesHeader."document type"::Order, pSalesInvoiceHeader."Prepayment Order No.") then
                pSalesInvoiceHeader.FieldError("Prepayment Order No.", tDeleteSalesInvoice);
        if pSalesInvoiceHeader."Order No." <> '' then
            if lSalesHeader.Get(lSalesHeader."document type"::Order, pSalesInvoiceHeader."Order No.") then
                pSalesInvoiceHeader.FieldError("Order No.", tDeleteSalesInvoice);
    end;


    procedure SalesPrepaymentRequestPrinted(var pSalesHeader: Record "Sales Header"; pPrinted: Boolean)
    var
        lSalesHeader: Record "Sales Header";
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        if pPrinted then
            pSalesHeader."No. Prepayment Request Printed" += 1
        else
            pSalesHeader."No. Prepayment Request Printed" := 0;
        pSalesHeader.Modify;
        Commit;
        lSingleInstance.wSetSalesHeader(pSalesHeader);
    end;


    procedure ResetCanceledPrepayment(var pSalesHeader: Record "Sales Header"; var pSalesInvoiceHeader: Record "Sales Invoice Header")
    var
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lSalesLine: Record "Sales Line";
        lModified: Boolean;
    begin
        //#6249
        if pSalesInvoiceHeader."No." = '' then begin
            pSalesInvoiceHeader.SetCurrentkey("Prepayment Order No.");
            pSalesInvoiceHeader.SetRange("Prepayment Order No.", pSalesHeader."No.");
            pSalesInvoiceHeader.SetFilter("Reverse Prepmt. Cr. Memo No.", '<>%1', '');
            if Page.RunModal(Page::"Posted Sales Invoices", pSalesInvoiceHeader) <> Action::LookupOK then
                exit;
        end;

        pSalesInvoiceHeader.TestField("Prepayment Invoice");
        with lSalesLine do begin
            SetRange("Document Type", pSalesHeader."Document Type");
            SetRange("Document No.", pSalesHeader."No.");
            SetFilter(Type, '<>0');
            SetRange("Structure Line No.", 0);
            if FindSet then
                repeat
                    lSalesInvoiceLine.SetCurrentkey("Prepayment Order No.", "Prepayment Order Line No.");
                    lSalesInvoiceLine.SetRange("Prepayment Order No.", lSalesLine."Document No.");
                    lSalesInvoiceLine.SetRange("Prepayment Order Line No.", lSalesLine."Line No.");
                    lSalesInvoiceLine.SetRange("Document No.", pSalesInvoiceHeader."No.");
                    if not lSalesInvoiceLine.FindFirst then
                        lSalesInvoiceLine."Invoiced Amount" := 0;
                    if "Prepmt. Line Amount" <> lSalesInvoiceLine."Invoiced Amount" then begin
                        Validate("Prepmt. Line Amount", lSalesInvoiceLine."Invoiced Amount");
                        Modify;
                        lModified := true;
                    end;
                until Next = 0;
        end;
        if lModified then
            pSalesHeader."No. Prepayment Invoiced" := pSalesInvoiceHeader."Prepayment Rank No."
        //#6249//
    end;


    procedure fDateCompare(pSalesHeader: Record "Sales Header"; pDocumentType: Option Invoice,"Credit Memo",Both; pReversal: Boolean; pPartialCredit: Boolean)
    var
        lInvoiceHeader: Record "Sales Invoice Header";
        lCrMemoHeader: Record "Sales Cr.Memo Header";
        lInvDate: Date;
        lCrDate: Date;
        lCtrlDate: Date;
        lSalesDate: Date;
    begin
        //#8981\\
        //Cherche dans l'historique (facture ET avoir) la dernière date de situation
        lCrMemoHeader.SetCurrentkey("Prepayment Order No.");
        lCrMemoHeader.SetRange("Prepayment Order No.", pSalesHeader."No.");
        if pReversal then
            lSalesDate := pSalesHeader."Document Date"
        else
            lSalesDate := pSalesHeader."Posting Date";
        //Invoice
        lInvDate := 0D;
        lInvoiceHeader.SetCurrentkey("Prepayment Order No.", "Posting Date");
        lInvoiceHeader.SetRange("Prepayment Order No.", pSalesHeader."No.");
        lInvoiceHeader.SetRange("Prepayment Invoice", true);
        lInvoiceHeader.SetRange("Reverse Prepmt. Cr. Memo No.", '');
        if lInvoiceHeader.FindLast then begin
            repeat
                lCrMemoHeader.SetRange("Reverse Prepmt. Inv. No.", lInvoiceHeader."No.");
                if not lCrMemoHeader.FindSet then begin
                    if not pReversal then
                        lInvDate := lInvoiceHeader."Posting Date"
                    else
                        lInvDate := lInvoiceHeader."Document Date";
                end;
            until (lInvoiceHeader.Next(-1) = 0) or (lInvDate <> 0D);
        end;
        //Credit Memo
        lCrDate := 0D;
        lInvoiceHeader.SetRange("Prepayment Invoice");
        lInvoiceHeader.SetRange("Reverse Prepmt. Cr. Memo No.");
        lCrMemoHeader.SetRange("Prepayment Order No.", pSalesHeader."No.");
        lCrMemoHeader.SetRange("Prepayment Credit Memo", true);
        lCrMemoHeader.SetRange("Reverse Prepmt. Inv. No.", '');
        if lCrMemoHeader.FindLast then begin
            repeat
                lInvoiceHeader.SetRange("Reverse Prepmt. Cr. Memo No.", lCrMemoHeader."No.");
                if not lInvoiceHeader.FindSet then begin
                    if not pReversal then
                        lCrDate := lCrMemoHeader."Posting Date"
                    else
                        lCrDate := lCrMemoHeader."Document Date";
                end;
            until (lCrMemoHeader.Next(-1) = 0) or (lCrDate <> 0D);
        end;

        if lInvDate > lCrDate then
            lCtrlDate := lInvDate
        else
            lCtrlDate := lCrDate;

        if not pReversal then begin
            if (not pPartialCredit and (pDocumentType = Pdocumenttype::"Credit Memo")) then begin
                if lSalesDate < lCtrlDate then
                    pSalesHeader.FieldError("Posting Date", StrSubstNo(tInvoicePostingDate, lCtrlDate));
            end else
                if lSalesDate <= lCtrlDate then
                    pSalesHeader.FieldError("Posting Date", StrSubstNo(tInvoicePostingDate, lCtrlDate));
        end
        else
            if lSalesDate < lCtrlDate then
                pSalesHeader.FieldError("Document Date", StrSubstNo(tInvoicePostingDate, lCtrlDate));
    end;
}

