Codeunit 8004162 "Job Create-Invoice2"
{

    trigger OnRun()
    begin
    end;

    var
        Currency: Record Currency;
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempJobPlanningLine: Record "Job Planning Line" temporary;
        Text000: label 'The lines were successfully transferred to an invoice.';
        Text001: label 'The lines were not transferred to an invoice.';
        Text002: label 'There were no lines to transfer.';
        Text003: label '%1 %2 = %3 " for %4 were successfully transferred to invoice %5.';
        Text004: label 'You must specify Invoice No. or New Invoice.';
        Text005: label 'You must specify Credit Memo No. or New Invoice.';
        Text007: label 'You must specify %1.';
        TransferExtendedText: Codeunit "Transfer Extended Text";
        JobInvCurrency: Boolean;
        UpdateExchangeRates: Boolean;
        Text008: label 'The lines were successfully transferred to a credit memo.';
        Text009: label 'The selected planning lines must have the same %1.';
        Text010: label 'The currency dates on all planning lines will be updated based on the invoice posting date because there is a difference in currency exchange rates. Recalculations will be based on the Exch. Calculation setup for the Cost and Price values for the job. Do you want to continue?';


    procedure CreateSalesInvoice(var JobPlanningLine: Record "Job Planning Line"; CrMemo: Boolean)
    var
        SalesHeader: Record "Sales Header";
        JT: Record "Job Task";
        GetSalesInvoiceNo: Report "Job Transfer to Sales Invoice";
        GetSalesCrMemoNo: Report "Job Transfer to Credit Memo";
        Done: Boolean;
        NewInvoice: Boolean;
        PostingDate: Date;
        InvoiceNo: Code[20];
    begin
        JT.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        if not CrMemo then begin
            GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Job No.");
            GetSalesInvoiceNo.RunModal;
            GetSalesInvoiceNo.GetInvoiceNo(Done, NewInvoice, PostingDate, InvoiceNo);
        end else begin
            GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Job No.");
            GetSalesCrMemoNo.RunModal;
            GetSalesCrMemoNo.GetCreditMemoNo(Done, NewInvoice, PostingDate, InvoiceNo);
        end;

        if Done then begin
            if (PostingDate = 0D) and NewInvoice then
                Error(Text007, SalesHeader.FieldCaption("Posting Date"));
            if (InvoiceNo = '') and not NewInvoice then begin
                if CrMemo then
                    Error(Text005);
                Error(Text004);
            end;
            CreateSalesInvoiceLines(
              JobPlanningLine."Job No.", JobPlanningLine, InvoiceNo, NewInvoice, PostingDate, CrMemo);
        end;
    end;


    procedure CreateSalesInvoiceLines(JobNo: Code[20]; var JobPlanningLine: Record "Job Planning Line"; InvoiceNo: Code[20]; NewInvoice: Boolean; PostingDate: Date; CreditMemo: Boolean)
    var
        Cust: Record Customer;
        Job: Record Job;
        LineCounter: Integer;
    begin
        ClearAll;
        Job.Get(JobNo);
        if Job.Blocked = Job.Blocked::All then
            Job.TestBlocked;
        if Job."Currency Code" = '' then
            JobInvCurrency := Job."Invoice Currency Code" <> '';
        Job.TestField("Bill-to Customer No.");
        Cust.Get(Job."Bill-to Customer No.");
        if CreditMemo then
            SalesHeader2."Document Type" := SalesHeader2."document type"::"Credit Memo"
        else
            SalesHeader2."Document Type" := SalesHeader2."document type"::Invoice;

        if not NewInvoice then
            SalesHeader.Get(SalesHeader2."Document Type", InvoiceNo);

        if JobPlanningLine.Find('-') then
            repeat
                if JobPlanningLine."Contract Line" /*/*GL2024 and not JobPlanningLine.Transferred*/ then begin
                    LineCounter := LineCounter + 1;
                    if JobPlanningLine."Job No." <> JobNo then
                        Error(Text009, JobPlanningLine.FieldCaption("Job No."));
                    if NewInvoice then
                        TestExchangeRate(JobPlanningLine, PostingDate)
                    else
                        TestExchangeRate(JobPlanningLine, SalesHeader."Posting Date");
                end;
            until JobPlanningLine.Next = 0;
        if LineCounter = 0 then
            Error(Text002);
        if NewInvoice then
            CreateSalesheader(Job, PostingDate)
        else
            TestSalesHeader(SalesHeader, Job);
        /*GL2024 if JobPlanningLine.Find('-') then
             repeat
                 if JobPlanningLine."Contract Line" and not JobPlanningLine.Transferred then begin
                     if JobPlanningLine.Type in [JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item,
                       JobPlanningLine.Type::"G/L Account"] then
                         JobPlanningLine.TestField("No.");
                     CreateSalesLine(JobPlanningLine);
                  /*GL2024   if SalesHeader2."Document Type" = SalesHeader2."document type"::Invoice then begin
                         JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::Invoice;
                         JobPlanningLine."Invoice No." := SalesHeader."No.";
                     end;
                     if SalesHeader2."Document Type" = SalesHeader2."document type"::"Credit Memo" then begin
                         JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"Credit Memo";
                         JobPlanningLine."Invoice No." := SalesHeader."No.";
                     end;
                     JobPlanningLine.Transferred := true;
                     JobPlanningLine."Transferred Date" := PostingDate;
                     JobPlanningLine.Modify;
                 end;
             until JobPlanningLine.Next = 0;*/
        Commit;
        if CreditMemo then
            Message(Text008)
        else
            Message(Text000);
    end;


    procedure DeleteSalesInvoiceBuffer()
    begin
        ClearAll;
        TempJobPlanningLine.DeleteAll;
    end;


    procedure CreateSalesInvoiceJT(var JT2: Record "Job Task"; PostingDate: Date; InvoicePerTask: Boolean; var NoOfInvoices: Integer; var OldJobNo: Code[20]; var OldJTNo: Code[20]; LastJobTask: Boolean)
    var
        Cust: Record Customer;
        Job: Record Job;
        JT: Record "Job Task";
        JobPlanningLine: Record "Job Planning Line";
    begin
        ClearAll;
        if not LastJobTask then begin
            JT := JT2;
            if JT."Job No." = '' then
                exit;
            if JT."Job Task No." = '' then
                exit;
            JT.Find;
            if JT."Job Task Type" <> JT."job task type"::Posting then
                exit;
            Job.Get(JT."Job No.");
        end;
        if LastJobTask then begin
            if not TempJobPlanningLine.Find('-') then
                exit;
            Job.Get(TempJobPlanningLine."Job No.");
            JT.Get(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.");
        end;
        Job.TestField("Bill-to Customer No.");
        if Job.Blocked = Job.Blocked::All then
            Job.TestBlocked;
        if Job."Currency Code" = '' then
            JobInvCurrency := Job."Invoice Currency Code" <> '';
        Cust.Get(Job."Bill-to Customer No.");

        if CreateNewInvoice(JT, InvoicePerTask, OldJobNo, OldJTNo, LastJobTask) then begin
            Job.Get(TempJobPlanningLine."Job No.");
            JT.Get(TempJobPlanningLine."Job No.", TempJobPlanningLine."Job Task No.");
            if Job."Currency Code" = '' then
                JobInvCurrency := Job."Invoice Currency Code" <> '';
            Cust.Get(Job."Bill-to Customer No.");
            NoOfInvoices := NoOfInvoices + 1;
            SalesHeader2."Document Type" := SalesHeader2."document type"::Invoice;
            CreateSalesheader(Job, PostingDate);
            if TempJobPlanningLine.Find('-') then
                repeat
                    JobPlanningLine := TempJobPlanningLine;
                    JobPlanningLine.Find;
                    if JobPlanningLine.Type in [JobPlanningLine.Type::Resource, JobPlanningLine.Type::Item,
                      JobPlanningLine.Type::"G/L Account"] then
                        JobPlanningLine.TestField("No.");
                    TestExchangeRate(JobPlanningLine, PostingDate);
                    CreateSalesLine(JobPlanningLine);
                    /*GL2024  if SalesHeader2."Document Type" = SalesHeader2."document type"::Invoice then begin
                          JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::Invoice;
                          JobPlanningLine."Invoice No." := SalesHeader."No.";
                      end;
                      if SalesHeader2."Document Type" = SalesHeader2."document type"::"Credit Memo" then begin
                          JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"Credit Memo";
                          JobPlanningLine."Invoice No." := SalesHeader."No.";
                      end;*/
                    //GL2024   JobPlanningLine.Transferred := true;
                    //GL2024    JobPlanningLine."Transferred Date" := PostingDate;
                    JobPlanningLine.Modify;
                until TempJobPlanningLine.Next = 0;
            TempJobPlanningLine.DeleteAll;
        end;
        if LastJobTask then
            exit;
        JobPlanningLine.Reset;
        JobPlanningLine.SetCurrentkey("Job No.", "Job Task No.");
        JobPlanningLine.SetRange("Job No.", JT2."Job No.");
        JobPlanningLine.SetRange("Job Task No.", JT2."Job Task No.");
        JobPlanningLine.SetFilter("Planning Date", JT2.GetFilter("Planning Date Filter"));

        if JobPlanningLine.Find('-') then
            repeat
                if JobPlanningLine."Contract Line" /*/*GL2024and not JobPlanningLine.Transferred */then begin
                    TempJobPlanningLine := JobPlanningLine;
                    TempJobPlanningLine.Insert;
                end;
            until JobPlanningLine.Next = 0;
    end;

    local procedure CreateNewInvoice(var JT: Record "Job Task"; InvoicePerTask: Boolean; var OldJobNo: Code[20]; var OldJTNo: Code[20]; LastJobTask: Boolean): Boolean
    var
        NewInvoice: Boolean;
    begin
        if LastJobTask then
            NewInvoice := true
        else begin
            if OldJobNo <> '' then begin
                if InvoicePerTask then
                    if (OldJobNo <> JT."Job No.") or (OldJTNo <> JT."Job Task No.") then
                        NewInvoice := true;
                if not InvoicePerTask then
                    if OldJobNo <> JT."Job No." then
                        NewInvoice := true;
            end;
            OldJobNo := JT."Job No.";
            OldJTNo := JT."Job Task No.";
        end;
        if not TempJobPlanningLine.Find('-') then
            NewInvoice := false;
        exit(NewInvoice);
    end;

    local procedure CreateSalesheader(Job: Record Job; PostingDate: Date)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
    begin
        Clear(SalesHeader);
        SalesHeader."Document Type" := SalesHeader2."Document Type";
        SalesSetup.Get;
        if SalesHeader."Document Type" = SalesHeader."document type"::Invoice then
            SalesSetup.TestField("Invoice Nos.");
        if SalesHeader."Document Type" = SalesHeader."document type"::"Credit Memo" then
            SalesSetup.TestField("Credit Memo Nos.");
        SalesHeader."Posting Date" := PostingDate;
        SalesHeader.Insert(true);
        Cust.Get(Job."Bill-to Customer No.");
        Cust.TestField("Bill-to Customer No.", '');
        SalesHeader.Validate("Sell-to Customer No.", Job."Bill-to Customer No.");
        if Job."Currency Code" <> '' then
            SalesHeader.Validate("Currency Code", Job."Currency Code")
        else
            SalesHeader.Validate("Currency Code", Job."Invoice Currency Code");
        if PostingDate <> 0D then
            SalesHeader.Validate("Posting Date", PostingDate);
        UpdateSalesHeader(SalesHeader, Job);
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLine(var JobPlanningLine: Record "Job Planning Line")
    var
        Job: Record Job;
        Factor: Integer;
    begin
        Factor := 1;
        if SalesHeader2."Document Type" = SalesHeader2."document type"::"Credit Memo" then
            Factor := -1;
        TestTransferred(JobPlanningLine);
        JobPlanningLine.TestField("Planning Date");
        Job.Get(JobPlanningLine."Job No.");
        Clear(SalesLine);
        SalesLine."Document Type" := SalesHeader2."Document Type";
        SalesLine."Document No." := SalesHeader."No.";

        if not JobInvCurrency then begin
            SalesHeader.TestField("Currency Code", JobPlanningLine."Currency Code");
            if Job."Currency Code" <> '' then
                SalesHeader.TestField("Currency Factor", JobPlanningLine."Currency Factor");
            SalesHeader.TestField("Currency Code", Job."Currency Code");
        end;
        if JobPlanningLine.Type = JobPlanningLine.Type::Text then
            SalesLine.Validate(Type, SalesLine.Type::" ");
        if JobPlanningLine.Type = JobPlanningLine.Type::"G/L Account" then
            SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
        if JobPlanningLine.Type = JobPlanningLine.Type::Item then
            SalesLine.Validate(Type, SalesLine.Type::Item);
        if JobPlanningLine.Type = JobPlanningLine.Type::Resource then
            SalesLine.Validate(Type, SalesLine.Type::Resource);

        if SalesLine.Type = SalesLine.Type::" " then begin
            SalesLine.Description := JobPlanningLine.Description;
            SalesLine."Description 2" := JobPlanningLine."Description 2";
        end else begin
            SalesLine.Validate("No.", JobPlanningLine."No.");
            SalesLine.Validate("Location Code", JobPlanningLine."Location Code");
            SalesLine.Validate("Work Type Code", JobPlanningLine."Work Type Code");
            SalesLine.Validate("Variant Code", JobPlanningLine."Variant Code");
            SalesLine.Validate("Unit of Measure Code", JobPlanningLine."Unit of Measure Code");
            SalesLine.Validate(Quantity, Factor * JobPlanningLine.Quantity);
            if JobInvCurrency then begin
                Currency.Get(SalesLine."Currency Code");
                SalesLine.Validate("Unit Price",
                  ROUND(JobPlanningLine."Unit Price" * SalesHeader."Currency Factor",
                    Currency."Unit-Amount Rounding Precision"));
            end else
                SalesLine.Validate("Unit Price", JobPlanningLine."Unit Price");
            SalesLine.Validate("Unit Cost (LCY)", JobPlanningLine."Unit Cost (LCY)");
            SalesLine.Validate("Line Discount %", JobPlanningLine."Line Discount %");
            SalesLine.Description := JobPlanningLine.Description;
            SalesLine."Description 2" := JobPlanningLine."Description 2";
        end;
        if not SalesHeader."Prices Including VAT" then
            SalesLine.Validate("Job Contract Entry No.", JobPlanningLine."Job Contract Entry No.");
        SalesLine."Job No." := JobPlanningLine."Job No.";
        SalesLine."Job Task No." := JobPlanningLine."Job Task No.";
        SalesLine."Line No." := GetNextLineNo(SalesLine);
        SalesLine.Insert(true);

        /*GL2024  if JobInvCurrency then begin
              JobPlanningLine."Invoice Currency" := true;
              JobPlanningLine."Inv. Curr. Unit Price" := SalesLine."Unit Price";
              JobPlanningLine."Inv. Curr. Line Amount" := SalesLine."Line Amount";
              JobPlanningLine."Invoice Currency Code" := Job."Invoice Currency Code";
              JobPlanningLine."Invoice Currency Factor" := SalesHeader."Currency Factor";
          end;*/

        if SalesHeader."Prices Including VAT" and
           (SalesLine.Type <> SalesLine.Type::" ")
        then begin
            if SalesLine."Currency Code" = '' then
                Currency.InitRoundingPrecision
            else
                Currency.Get(SalesLine."Currency Code");
            SalesLine."Unit Price" :=
              ROUND(
                SalesLine."Unit Price" * (1 + (SalesLine."VAT %" / 100)),
                Currency."Unit-Amount Rounding Precision");
            if SalesLine.Quantity <> 0 then begin
                SalesLine."Line Discount Amount" :=
                  ROUND(
                    SalesLine.Quantity * SalesLine."Unit Price" * SalesLine."Line Discount %" / 100,
                    Currency."Amount Rounding Precision");
                SalesLine.Validate("Inv. Discount Amount",
                  ROUND(
                    SalesLine."Inv. Discount Amount" * (1 + (SalesLine."VAT %" / 100)),
                    Currency."Amount Rounding Precision"));
            end;
            SalesLine.Validate("Job Contract Entry No.", JobPlanningLine."Job Contract Entry No.");

            SalesLine.Modify;
            JobPlanningLine."VAT Unit Price" := SalesLine."Unit Price";
            JobPlanningLine."VAT Line Discount Amount" := SalesLine."Line Discount Amount";
            JobPlanningLine."VAT Line Amount" := SalesLine."Line Amount";
            JobPlanningLine."VAT %" := SalesLine."VAT %";
        end;
        if TransferExtendedText.SalesCheckIfAnyExtText(SalesLine, false) then
            TransferExtendedText.InsertSalesExtText(SalesLine);
    end;

    local procedure GetNextLineNo(SalesLine: Record "Sales Line"): Integer
    var
        NextLineNo: Integer;
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type");
        SalesLine.SetRange("Document No.", SalesLine."Document No.");
        NextLineNo := 10000;
        if SalesLine.Find('+') then
            NextLineNo := SalesLine."Line No." + 10000;
        exit(NextLineNo);
    end;

    local procedure TestTransferred(JobPlanningLine: Record "Job Planning Line")
    var
        SalesLine: Record "Sales Line";
        JobTransferLine: Codeunit "Job Transfer Line2";
    begin
        SalesLine.SetCurrentkey("Job Contract Entry No.");
        SalesLine.SetRange("Job Contract Entry No.", JobPlanningLine."Job Contract Entry No.");
        if SalesLine.Find('-') then
            Error(Text003,
              JobPlanningLine.TableCaption,
              JobPlanningLine.FieldCaption("Line No."),
              JobPlanningLine."Line No.",
              JobTransferLine.JTName(JobPlanningLine."Job No.", JobPlanningLine."Job Task No."),
              JobPlanningLine."Job Contract Entry No.",
              SalesLine."Document No.");
        ///*GL2024   JobPlanningLine.TestField(Invoiced, false);
    end;


    procedure DeleteSalesLine(SalesLine: Record "Sales Line")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.SetCurrentkey("Job Contract Entry No.");
        JobPlanningLine.SetRange("Job Contract Entry No.", SalesLine."Job Contract Entry No.");
        if JobPlanningLine.Find('-') then begin
            JobPlanningLine.InitJobPlanningLine;
            JobPlanningLine.Modify;
        end;
    end;


    /*GL2024 procedure GetSalesInvoice(JobPlanningLine: Record "Job Planning Line")
     var
         SalesHeader: Record "Sales Header";
         SalesLine: Record "Sales Line";
         SalesInvHeader: Record "Sales Invoice Header";
         SalesInvLine: Record "Sales Invoice Line";
         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
         SalesCrMemoLine: Record "Sales Cr.Memo Line";
     begin
         ClearAll;
         with JobPlanningLine do begin
             if "Line No." = 0 then
                 exit;
             TestField("Job No.");
             TestField("Job Task No.");
             TestField(Transferred);
             if not Invoiced then begin
                 SalesLine.SetCurrentkey("Job Contract Entry No.");
                 SalesLine.SetRange("Job Contract Entry No.", "Job Contract Entry No.");
                 if SalesLine.Find('-') then begin
                     if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then;
                     if SalesLine."Document Type" = SalesLine."document type"::Invoice then
                         Page.RunModal(Page::"Sales Invoice", SalesHeader)
                     else
                         Page.RunModal(Page::"Sales Credit Memo", SalesHeader);
                 end else
                     Error(Text001);
             end;
             if Invoiced then begin
                 SalesCrMemoLine.SetCurrentkey("Job Contract Entry No.");
                 SalesCrMemoLine.SetRange("Job Contract Entry No.", "Job Contract Entry No.");
                 if SalesCrMemoLine.Find('-') then begin
                     ;
                     if SalesCrMemoHeader.Get(SalesCrMemoLine."Document No.") then;
                     Page.RunModal(Page::"Posted Sales Credit Memo", SalesCrMemoHeader);
                 end else begin
                     SalesInvLine.SetCurrentkey("Job Contract Entry No.");
                     SalesInvLine.SetRange("Job Contract Entry No.", "Job Contract Entry No.");
                     SalesInvLine.Find('-');
                     if SalesInvHeader.Get(SalesInvLine."Document No.") then;
                     Page.RunModal(Page::"Posted Sales Invoice", SalesInvHeader);
                 end;
             end;
         end;
     end;*/

    local procedure UpdateSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job)
    begin
        SalesHeader."Bill-to Contact No." := Job."Bill-to Contact No.";
        SalesHeader."Bill-to Contact" := Job."Bill-to Contact";
        SalesHeader."Bill-to Name" := Job."Bill-to Name";
        SalesHeader."Bill-to Address" := Job."Bill-to Address";
        SalesHeader."Bill-to Address 2" := Job."Bill-to Address 2";
        SalesHeader."Bill-to City" := Job."Bill-to City";
        SalesHeader."Bill-to Post Code" := Job."Bill-to Post Code";

        SalesHeader."Sell-to Contact No." := Job."Bill-to Contact No.";
        SalesHeader."Sell-to Contact" := Job."Bill-to Contact";
        SalesHeader."Sell-to Customer Name" := Job."Bill-to Name";
        SalesHeader."Sell-to Address" := Job."Bill-to Address";
        SalesHeader."Sell-to Address 2" := Job."Bill-to Address 2";
        SalesHeader."Sell-to City" := Job."Bill-to City";
        SalesHeader."Sell-to Post Code" := Job."Bill-to Post Code";

        SalesHeader."Ship-to Contact" := Job."Bill-to Contact";
        SalesHeader."Ship-to Name" := Job."Bill-to Name";
        SalesHeader."Ship-to Address" := Job."Bill-to Address";
        SalesHeader."Ship-to Address 2" := Job."Bill-to Address 2";
        SalesHeader."Ship-to City" := Job."Bill-to City";
        SalesHeader."Ship-to Post Code" := Job."Bill-to Post Code";
    end;

    local procedure TestSalesHeader(var SalesHeader: Record "Sales Header"; var Job: Record Job)
    begin
        SalesHeader.TestField("Bill-to Customer No.", Job."Bill-to Customer No.");
        SalesHeader.TestField("Sell-to Customer No.", Job."Bill-to Customer No.");

        if Job."Currency Code" <> '' then
            SalesHeader.TestField("Currency Code", Job."Currency Code")
        else
            SalesHeader.TestField("Currency Code", Job."Invoice Currency Code");
    end;


    procedure TestExchangeRate(var JobPlanningLine: Record "Job Planning Line"; PostingDate: Date)
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        if JobPlanningLine."Currency Code" <> '' then
            if (CurrencyExchangeRate.ExchangeRate(PostingDate, JobPlanningLine."Currency Code") <> JobPlanningLine."Currency Factor")
              then begin

                if UpdateExchangeRates = false then
                    UpdateExchangeRates := Confirm(Text010, true);

                if UpdateExchangeRates = true then begin
                    JobPlanningLine."Currency Date" := PostingDate;
                    JobPlanningLine."Document Date" := PostingDate;
                    JobPlanningLine.Validate("Currency Date");
                    JobPlanningLine."Last Date Modified" := Today;
                    JobPlanningLine."User ID" := UserId;
                    JobPlanningLine.Modify(true);
                end else begin
                    Error('')
                end;
            end;
    end;
}

