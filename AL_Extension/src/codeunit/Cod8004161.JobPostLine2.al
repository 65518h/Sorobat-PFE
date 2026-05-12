Codeunit 8004161 "Job Post-Line2"
{
    // //+ONE+JOB ML 01/10/07 Valider les achats avec Job No.

    Permissions = TableData "Job Planning Line" = rimd;

    trigger OnRun()
    begin
    end;

    var
        TempJobJnlLine: Record "Job Journal Line" temporary;
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
        JobTransferLine: Codeunit "Job Transfer Line2";
        Text000: label 'has been changed (initial a %1: %2= %3, %4= %5)';
        Text001: label 'You should consume %1 %2 in %3 %4 before you post sales invoice %5 %6 = %7.';
        Text003: label 'You cannot change the sales line because it is linked to\';
        Text004: label ' %1: %2= %3, %4= %5.';
        Text005: label 'You must post more usage or credit the sale of %1 %2 in %3 %4 before you can post purchase credit memo %5 %6 = %7.';


    procedure InsertPlanningLine(JobJnlLine: Record "Job Journal Line")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        if JobJnlLine."Line Type" = JobJnlLine."line type"::" " then
            exit;
        Clear(JobPlanningLine);
        JobPlanningLine."Job No." := JobJnlLine."Job No.";
        JobPlanningLine."Job Task No." := JobJnlLine."Job Task No.";
        JobPlanningLine.SetRange("Job No.", JobPlanningLine."Job No.");
        JobPlanningLine.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
        if JobPlanningLine.Find('+') then;
        JobPlanningLine."Line No." := JobPlanningLine."Line No." + 10000;
        JobPlanningLine.Init;
        JobPlanningLine.Reset;
        Clear(JobTransferLine);
        JobTransferLine.FromJnlToPlanningLine(JobJnlLine, JobPlanningLine);
        PostPlanningLine(JobPlanningLine);
    end;


    procedure InsertPlLineFromLedgEntry(JobLedgEntry: Record "Job Ledger Entry")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        if JobLedgEntry."Line Type" = JobLedgEntry."line type"::" " then
            exit;
        ClearAll;
        JobPlanningLine."Job No." := JobLedgEntry."Job No.";
        JobPlanningLine."Job Task No." := JobLedgEntry."Job Task No.";
        JobPlanningLine.SetRange("Job No.", JobPlanningLine."Job No.");
        JobPlanningLine.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
        if JobPlanningLine.Find('+') then;
        JobPlanningLine."Line No." := JobPlanningLine."Line No." + 10000;
        JobPlanningLine.Init;
        JobPlanningLine.Reset;
        Clear(JobTransferLine);
        JobTransferLine.FromJobLedgEntryToPlanningLine(JobLedgEntry, JobPlanningLine);
        PostPlanningLine(JobPlanningLine);
    end;

    local procedure PostPlanningLine(JobPlanningLine: Record "Job Planning Line")
    var
        Job: Record Job;
    begin
        if JobPlanningLine."Line Type" = JobPlanningLine."line type"::"Both Budget and Billable" then begin
            Job.Get(JobPlanningLine."Job No.");
            if not Job."Allow Schedule/Contract Lines" or
               (JobPlanningLine.Type = JobPlanningLine.Type::"G/L Account")
            then begin
                JobPlanningLine.Validate("Line Type", JobPlanningLine."line type"::Budget);
                JobPlanningLine.Insert(true);
                JobPlanningLine."Job Contract Entry No." := 0;
                JobPlanningLine.Validate("Line Type", JobPlanningLine."line type"::Billable);
                JobPlanningLine."Line No." := JobPlanningLine."Line No." + 10000;
            end;
        end;
        if (JobPlanningLine.Type = JobPlanningLine.Type::"G/L Account") and
           (JobPlanningLine."Line Type" = JobPlanningLine."line type"::Billable)
        then
            ChangeGLNo(JobPlanningLine);
        JobPlanningLine.Insert(true);
    end;


    procedure PostInvoiceContractLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var TempJnlLineDim: Record "Dim. Value per Account"): Boolean
    var
        Job: Record Job;
        JT: Record "Job Task";
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        Factor: Integer;
        Txt: Text[500];
    begin
        Factor := 1;
        if SalesLine."Document Type" = SalesLine."document type"::"Credit Memo" then
            Factor := -1;
        JobPlanningLine.SetCurrentkey("Job Contract Entry No.");
        JobPlanningLine.SetRange("Job Contract Entry No.", SalesLine."Job Contract Entry No.");
        JobPlanningLine.Find('-');
        Job.Get(JobPlanningLine."Job No.");
        IF JT.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.") THEN;
        Txt := StrSubstNo(Text000,
            JT.TableCaption, JT.FieldCaption("Job No."), JT."Job No.",
            JT.FieldCaption("Job Task No."), JT."Job Task No.");

        /*GL2024  if not JobPlanningLine."Invoice Currency" then begin
              Job.TestField("Currency Code", SalesHeader."Currency Code");
              Job.TestField("Currency Code", JobPlanningLine."Currency Code");
              SalesHeader.TestField("Currency Code", JobPlanningLine."Currency Code");
              SalesHeader.TestField("Currency Factor", JobPlanningLine."Currency Factor");
          end else begin
              Job.TestField("Currency Code", '');
              JobPlanningLine.TestField("Currency Code", '');
          end;*/
        SalesHeader.TestField("Bill-to Customer No.", Job."Bill-to Customer No.");
        //GL2024  JobPlanningLine.TestField(Invoiced, false);
        //GL2024  JobPlanningLine.TestField(Transferred);

        if JobPlanningLine.Type = JobPlanningLine.Type::Text then
            if SalesLine.Type <> SalesLine.Type::" " then
                SalesLine.FieldError(Type, Txt);
        if JobPlanningLine.Type = JobPlanningLine.Type::Resource then
            if SalesLine.Type <> SalesLine.Type::Resource then
                SalesLine.FieldError(Type, Txt);
        if JobPlanningLine.Type = JobPlanningLine.Type::Item then
            if SalesLine.Type <> SalesLine.Type::Item then
                SalesLine.FieldError(Type, Txt);
        if JobPlanningLine.Type = JobPlanningLine.Type::"G/L Account" then
            if SalesLine.Type <> SalesLine.Type::"G/L Account" then
                SalesLine.FieldError(Type, Txt);

        if SalesLine."No." <> JobPlanningLine."No." then
            SalesLine.FieldError("No.", Txt);
        if SalesLine."Location Code" <> JobPlanningLine."Location Code" then
            SalesLine.FieldError("Location Code", Txt);
        if SalesLine."Unit of Measure Code" <> JobPlanningLine."Unit of Measure Code" then
            SalesLine.FieldError("Unit of Measure Code", Txt);
        if SalesLine."Variant Code" <> JobPlanningLine."Variant Code" then
            SalesLine.FieldError("Variant Code", Txt);
        if SalesLine.Quantity <> Factor * JobPlanningLine.Quantity then
            SalesLine.FieldError(Quantity, Txt);
        if SalesLine."Gen. Prod. Posting Group" <> JobPlanningLine."Gen. Prod. Posting Group" then
            SalesLine.FieldError("Gen. Prod. Posting Group", Txt);
        if SalesLine."Line Discount %" <> JobPlanningLine."Line Discount %" then
            SalesLine.FieldError("Line Discount %", Txt);
        if SalesLine."Quantity (Base)" <> Factor * JobPlanningLine."Quantity (Base)" then
            SalesLine.FieldError("Quantity (Base)", Txt);
        if SalesLine.Type = SalesLine.Type::" " then
            if SalesLine."Line Amount" <> 0 then
                SalesLine.FieldError("Line Amount", Txt);
        if JobPlanningLine."Unit Cost (LCY)" <> SalesLine."Unit Cost (LCY)" then
            SalesLine.FieldError("Unit Cost (LCY)", Txt);

        if SalesHeader."Prices Including VAT" then begin
            if JobPlanningLine."VAT Unit Price" <> SalesLine."Unit Price" then
                SalesLine.FieldError("Unit Price", Txt);
            if JobPlanningLine."VAT Line Discount Amount" <> SalesLine."Line Discount Amount" then
                SalesLine.FieldError("Line Amount", Txt);
            if JobPlanningLine."VAT Line Amount" <> SalesLine."Line Amount" then
                SalesLine.FieldError("Line Amount", Txt);
            if JobPlanningLine."VAT %" <> SalesLine."VAT %" then
                SalesLine.FieldError("VAT %", Txt);
        end; /* GL2024 else begin
            if JobPlanningLine."Invoice Currency" then begin
                if JobPlanningLine."Inv. Curr. Line Amount" <> SalesLine."Line Amount" then
                    SalesLine.FieldError("Line Amount", Txt);
                if JobPlanningLine."Inv. Curr. Unit Price" <> SalesLine."Unit Price" then
                    SalesLine.FieldError("Unit Price", Txt);
            end else begin
                if JobPlanningLine."Line Amount" <> Factor * SalesLine."Line Amount" then
                    SalesLine.FieldError("Line Amount", Txt);
                if JobPlanningLine."Unit Price" <> SalesLine."Unit Price" then
                    SalesLine.FieldError("Unit Price", Txt);
            end;
    end;*/
        JobPlanningLine."Invoiced Amount (LCY)" := JobPlanningLine."Line Amount (LCY)";
        JobPlanningLine."Invoiced Cost Amount (LCY)" := JobPlanningLine."Total Cost (LCY)";
        //GL2024  JobPlanningLine.Invoiced := true;
        //  GL2024   JobPlanningLine."Invoiced Date" := SalesHeader."Posting Date";
        /*GL2024 if SalesHeader."Document Type" = SalesHeader."document type"::Invoice then begin
             JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"Posted Invoice";
             JobPlanningLine."Invoice No." := SalesLine."Document No.";
         end;
         if SalesHeader."Document Type" = SalesHeader."document type"::"Credit Memo" then begin
             JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"Posted Credit Memo";
             JobPlanningLine."Invoice No." := SalesLine."Document No.";
         end;*/
        if JobLedgEntry.Find('+') then;
        JobPlanningLine."Job Ledger Entry No." := JobLedgEntry."Entry No." + 1;
        JobPlanningLine.Modify;

        if JobPlanningLine.Type = JobPlanningLine.Type::Item then
            CheckItemQuantity(JobPlanningLine, SalesHeader, SalesLine);

        if JobPlanningLine.Type <> JobPlanningLine.Type::Text then
            InsertJobLedgEntry(JobPlanningLine, SalesHeader, SalesLine, TempJnlLineDim);
    end;

    local procedure InsertJobLedgEntry(JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var TempJnlLineDim: Record "Dim. Value per Account")
    var
        JobJnlLine: Record "Job Journal Line";
    begin
        JobTransferLine.FromPlanningSalesLinetoJnlLine(JobPlanningLine, SalesHeader, SalesLine, JobJnlLine);
        //GL2024   JobJnlPostLine.RunWithCheck(JobJnlLine, TempJnlLineDim);
    end;

    local procedure CheckItemQuantity(JobPlanningLine: Record "Job Planning Line"; var Salesheader: Record "Sales Header"; var Salesline: Record "Sales Line")
    var
        Item: Record Item;
        Job: Record Job;
    begin
        Job.Get(JobPlanningLine."Job No.");
        if JobPlanningLine."Quantity (Base)" > 0 then begin
            if (Job.GetQuantityAvailable(JobPlanningLine."No.", JobPlanningLine."Location Code", JobPlanningLine."Variant Code", 0, 0) +
                Job.GetQuantityAvailable(JobPlanningLine."No.", JobPlanningLine."Location Code", JobPlanningLine."Variant Code", 1, 1)) <
                JobPlanningLine."Quantity (Base)" then
                Error(
                  Text001, Item.TableCaption, JobPlanningLine."No.", Job.TableCaption,
                  JobPlanningLine."Job No.", Salesheader."No.",
                  Salesline.FieldCaption("Line No."), Salesline."Line No.", Salesheader."Document Type");
        end else begin
            if (Job.GetQuantityAvailable(JobPlanningLine."No.", JobPlanningLine."Location Code", JobPlanningLine."Variant Code", 0, 1) +
                Job.GetQuantityAvailable(JobPlanningLine."No.", JobPlanningLine."Location Code", JobPlanningLine."Variant Code", 1, 0)) >
                JobPlanningLine."Quantity (Base)" then
                Error(
                  Text001, Item.TableCaption, JobPlanningLine."No.", Job.TableCaption,
                  JobPlanningLine."Job No.", Salesheader."No.",
                  Salesline.FieldCaption("Line No."), Salesline."Line No.", Salesheader."Document Type");
        end;
    end;


    procedure PostGenJnlLine(GenJnlLine: Record "Gen. Journal Line"; GLEntry: Record "G/L Entry"; var TempJnlLineDim: Record "Dim. Value per Account")
    var
        JobJnlLine: Record "Job Journal Line";
        Job: Record Job;
        JT: Record "Job Task";
        SourceCodeSetup: Record "Source Code Setup";
        JobTransferLine: Codeunit "Job Transfer Line2";
    begin
        if GenJnlLine."System-Created Entry" then
            exit;
        if GenJnlLine."Job No." = '' then
            exit;
        SourceCodeSetup.Get;
        if GenJnlLine."Source Code" = SourceCodeSetup."Job G/L WIP" then
            exit;
        GenJnlLine.TestField("Job Task No.");
        GenJnlLine.TestField("Job Quantity");
        Job.LockTable;
        JT.LockTable;
        Job.Get(GenJnlLine."Job No.");
        GenJnlLine.TestField("Job Currency Code", Job."Currency Code");
        IF JT.Get(GenJnlLine."Job No.", GenJnlLine."Job Task No.") THEN;
        JT.TestField("Job Task Type", JT."job task type"::Posting);
        //+ONE+JOB
        JT.TestField(Blocked, false);
        //+ONE+JOB//

        JobTransferLine.FromGenJnlLineToJnlLine(GenJnlLine, JobJnlLine);

        JobJnlPostLine.SetGLEntryNo(GLEntry."Entry No.");
        //GL2024  JobJnlPostLine.RunWithCheck(JobJnlLine, TempJnlLineDim);
        JobJnlPostLine.SetGLEntryNo(0);
    end;


    procedure InitPostPurchLine()
    begin
        TempJobJnlLine.DeleteAll;
    end;


    procedure InsertPurchLine(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; Sourcecode: Code[10]; var TempJnlLineDim: Record "Dim. Value per Account")
    var
        JobJnlLine: Record "Job Journal Line";
        Job: Record Job;
        JT: Record "Job Task";
        lCession: Codeunit "Create Bal. Job Journal Line";
    begin
        //#5414
        //IF (PurchLine.Type <> PurchLine.Type::Item) AND (PurchLine.Type <> PurchLine.Type::"G/L Account") THEN
        if (PurchLine.Type <> PurchLine.Type::Item) and (PurchLine.Type <> PurchLine.Type::"G/L Account") and
        //#8921
           (PurchLine.Type <> PurchLine.Type::Resource) and
        //#8921//
           (PurchLine.Type <> PurchLine.Type::"Note of Expenses") then
            //#5414//
            exit;
        Clear(JobJnlLine);
        PurchLine.TestField("Job No.");
        //  PurchLine.TestField("Job Task No.");
        Job.LockTable;
        JT.LockTable;
        Job.Get(PurchLine."Job No.");
        PurchLine.TestField("Job Currency Code", Job."Currency Code");
        IF JT.Get(PurchLine."Job No.", PurchLine."Job Task No.") THEN;
        JobTransferLine.FromPurchaseLineToJnlLine(
          PurchHeader, PurchInvHeader, PurchCrMemoHeader, PurchLine, Sourcecode, JobJnlLine);
        JobJnlLine."Job Posting Only" := true;
        //GL2024   JobJnlPostLine.RunWithCheck(JobJnlLine, TempJnlLineDim);
    end;


    procedure TestSalesLine(var SalesLine: Record "Sales Line")
    var
        JT: Record "Job Task";
        JobPlanningLine: Record "Job Planning Line";
        Txt: Text[250];
    begin
        if SalesLine."Job Contract Entry No." = 0 then
            exit;
        JobPlanningLine.SetCurrentkey("Job Contract Entry No.");
        JobPlanningLine.SetRange("Job Contract Entry No.", SalesLine."Job Contract Entry No.");
        if JobPlanningLine.Find('-') then begin
            IF JT.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.") THEN;
            Txt := Text003 + StrSubstNo(Text004,
                JT.TableCaption, JT.FieldCaption("Job No."), JT."Job No.",
                JT.FieldCaption("Job Task No."), JT."Job Task No.");
            Error(Txt);
        end;
    end;


    procedure ChangeGLNo(var JobPlanningLine: Record "Job Planning Line")
    var
        GLAcc: Record "G/L Account";
        Job: Record Job;
        JT: Record "Job Task";
        JobPostingGr: Record "Job Posting Group";
        Cust: Record Customer;
    begin
        IF JT.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.") THEN;
        Job.Get(JobPlanningLine."Job No.");
        Cust.Get(Job."Bill-to Customer No.");
        if JT."Job Posting Group" <> '' then
            JobPostingGr.Get(JT."Job Posting Group")
        else begin
            Job.TestField("Job Posting Group");
            JobPostingGr.Get(Job."Job Posting Group");
        end;
        if JobPostingGr."G/L Expense Acc. (Contract)" = '' then
            exit;
        GLAcc.Get(JobPostingGr."G/L Expense Acc. (Contract)");
        GLAcc.CheckGLAcc;
        JobPlanningLine."No." := GLAcc."No.";
        JobPlanningLine."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
        JobPlanningLine."Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
    end;


    procedure CheckItemQuantityPurchCredit(var Purchheader: Record "Purchase Header"; var Purchline: Record "Purchase Line")
    var
        Item: Record Item;
        Job: Record Job;
    begin
        //+ONE+JOB (#5362)
        /*Supprimé
        Job.GET(Purchline."Job No.");
        IF (Job.GetQuantityAvailable(
             Purchline."No.",Purchline."Location Code",Purchline."Variant Code",0,2) < Purchline."Quantity (Base)"
        THEN
          ERROR(
            Text005,Item.TABLECAPTION,Purchline."No.",Job.TABLECAPTION,
            Purchline."Job No.",Purchheader."No.",
            Purchline.FIELDCAPTION("Line No."),Purchline."Line No.");
        */
        //+ONE+JOB//

    end;
}

