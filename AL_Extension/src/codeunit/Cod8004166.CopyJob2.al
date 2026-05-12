Codeunit 8004166 "Copy Job2"
{

    trigger OnRun()
    begin
    end;

    var
        Job: Record Job;
        Job2: Record Job;
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        JobPlanningLine2: Record "Job Planning Line";
        JT: Record "Job Task";
        JT2: Record "Job Task";
        JT3: Record "Job Task";
        RoundingMethod: Record "Rounding Method";
        JobTransferLine: Codeunit "Job Transfer Line2";
        FromDate: Date;
        ToDate: Date;
        FromSource: Option "Job Planning Lines","Job Ledger Entry";
        LedgerEntryType: Option " ",Usage,Sale;
        LineType: Option " ",Schedule,Contract;
        FromJobNo: Code[20];
        FromJTNo: Code[20];
        ToJTNo: Code[20];
        ToJobNo: Code[20];
        ToJobTaskNo: Code[20];
        AmountAdjustFactor: Decimal;
        NextPlanninglineNo: Integer;
        SetNextPlanningLineNo: Integer;
        Sign: Integer;
        NoOfLinesInserted: Integer;
        ApplyPrices: Boolean;
        CopyQuantity: Boolean;


    procedure "Code"()
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
    begin
        case FromSource of
            Fromsource::"Job Planning Lines":
                begin
                    NextPlanninglineNo := SetNextPlanningLineNo;
                    JobPlanningLine.SetRange("Job No.", Job."No.");
                    JobPlanningLine.SetRange("Job Task No.", FromJTNo);
                    if LineType = Linetype::Schedule then
                        JobPlanningLine.SetRange("Schedule Line", true);
                    if LineType = Linetype::Contract then
                        JobPlanningLine.SetRange("Contract Line", true);
                    JobPlanningLine.SetFilter("Planning Date", JT3.GetFilter("Planning Date Filter"));
                    if JobPlanningLine.Find('-') then
                        repeat
                            JobPlanningLine2.Validate("Job No.", Job2."No.");
                            JobPlanningLine2.Validate("Job Task No.", ToJobTaskNo);
                            JobPlanningLine2.Validate("Line No.", NextPlanninglineNo);
                            JobPlanningLine2.TransferFields(JobPlanningLine, false);
                            JobPlanningLine2.Insert(true);
                            NoOfLinesInserted += 1;

                            if (JobPlanningLine2."Line Type" = JobPlanningLine2."line type"::"Both Budget and Billable") and
                               (LineType in [Linetype::Schedule, Linetype::Contract])
                            then begin
                                if LineType = Linetype::Schedule then
                                    JobPlanningLine2.Validate("Line Type", JobPlanningLine2."line type"::"Budget");
                                if LineType = Linetype::Contract then
                                    JobPlanningLine2.Validate("Line Type", JobPlanningLine2."line type"::"Billable");
                            end;

                            if JobPlanningLine2.Type <> JobPlanningLine2.Type::Text then begin
                                if Job."Currency Code" <> Job2."Currency Code" then begin
                                    JobPlanningLine2."Currency Code" := Job2."Currency Code";
                                    JobPlanningLine2.UpdateCurrencyFactor;
                                    Currency.Get(JobPlanningLine2."Currency Code");
                                    Currency.TestField("Amount Rounding Precision");
                                    JobPlanningLine2."Unit Cost" := ROUND(
                                        CurrExchRate.ExchangeAmtLCYToFCY(
                                          JobPlanningLine2."Currency Date", JobPlanningLine2."Currency Code",
                                          JobPlanningLine2."Unit Cost (LCY)", JobPlanningLine2."Currency Factor"),
                                        Currency."Unit-Amount Rounding Precision");
                                    JobPlanningLine2."Unit Price" := ROUND(
                                        CurrExchRate.ExchangeAmtLCYToFCY(
                                          JobPlanningLine2."Currency Date", JobPlanningLine2."Currency Code",
                                          JobPlanningLine2."Unit Price (LCY)", JobPlanningLine2."Currency Factor"),
                                        Currency."Unit-Amount Rounding Precision");
                                    JobPlanningLine2.Validate("Currency Date");
                                end;

                                if AmountAdjustFactor <> 1 then
                                    AdjustAmounts(JobPlanningLine2."Unit Price");
                                if not CopyQuantity then
                                    JobPlanningLine2.Validate(Quantity, 0);
                            end else
                                JobPlanningLine2."Currency Code" := Job2."Currency Code";
                            NextPlanninglineNo += 10000;
                            JobPlanningLine2.Modify;
                        until JobPlanningLine.Next = 0;
                end;
            Fromsource::"Job Ledger Entry":
                begin
                    JobLedgEntry.SetRange("Job No.", Job."No.");
                    JobLedgEntry.SetRange("Job Task No.", FromJTNo);
                    if LedgerEntryType = Ledgerentrytype::Usage then
                        JobLedgEntry.SetRange("Entry Type", JobLedgEntry."entry type"::Usage);
                    if LedgerEntryType = Ledgerentrytype::Sale then
                        JobLedgEntry.SetRange("Entry Type", JobLedgEntry."entry type"::Sale);
                    JobLedgEntry.SetFilter("Posting Date", JT3.GetFilter("Planning Date Filter"));
                    if JobLedgEntry.Find('-') then
                        repeat
                            JobTransferLine.FromJobLedgEntryToPlanningLine(JobLedgEntry, JobPlanningLine2);
                            JobPlanningLine2."Job No." := Job2."No.";
                            JobPlanningLine2.Validate("Line No.", NextPlanninglineNo);
                            JobPlanningLine2.Insert(true);
                            NoOfLinesInserted += 1;
                            if JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Usage then
                                JobPlanningLine2.Validate("Line Type", JobPlanningLine2."line type"::"Budget")
                            else begin
                                JobPlanningLine2.Validate("Line Type", JobPlanningLine2."line type"::"Billable");
                                JobPlanningLine2.Validate(Quantity, -JobLedgEntry.Quantity);
                                JobPlanningLine2.Validate("Unit Cost (LCY)", JobLedgEntry."Unit Cost (LCY)");
                                JobPlanningLine2.Validate("Unit Price (LCY)", JobLedgEntry."Unit Price (LCY)");
                                JobPlanningLine2.Validate("Line Discount %", JobLedgEntry."Line Discount %");
                            end;
                            if Job."Currency Code" <> Job2."Currency Code" then begin
                                JobPlanningLine2."Currency Code" := Job2."Currency Code";
                                JobPlanningLine2.UpdateCurrencyFactor;
                                Currency.Get(JobPlanningLine2."Currency Code");
                                Currency.TestField("Amount Rounding Precision");
                                JobPlanningLine2."Unit Cost" := ROUND(
                                    CurrExchRate.ExchangeAmtLCYToFCY(
                                      JobPlanningLine2."Currency Date", JobPlanningLine2."Currency Code",
                                      JobPlanningLine2."Unit Cost (LCY)", JobPlanningLine2."Currency Factor"),
                                    Currency."Unit-Amount Rounding Precision");
                                JobPlanningLine2."Unit Price" := ROUND(
                                    CurrExchRate.ExchangeAmtLCYToFCY(
                                      JobPlanningLine2."Currency Date", JobPlanningLine2."Currency Code",
                                      JobPlanningLine2."Unit Price (LCY)", JobPlanningLine2."Currency Factor"),
                                    Currency."Unit-Amount Rounding Precision");
                                JobPlanningLine2.Validate("Currency Date");
                            end;
                            if AmountAdjustFactor <> 1 then
                                AdjustAmounts(JobLedgEntry."Unit Price");
                            if not CopyQuantity then
                                JobPlanningLine2.Validate(Quantity, 0);
                            NextPlanninglineNo += 10000;
                            JobPlanningLine2.Modify;
                        until JobLedgEntry.Next = 0;
                end;
        end;
    end;


    procedure CopyJob(): Integer
    begin
        if AmountAdjustFactor = 0 then
            AmountAdjustFactor := 1;
        CopyJobTaskSetfilters;
        CopyJobSetFilters;
        if JT.Find('-') then begin
            repeat
                JT2."Job No." := Job2."No.";
                JT2."Job Task No." := JT."Job Task No.";
                JT2.TransferFields(JT, false);
                JT2.Insert(true);
                NoOfLinesInserted += 1;
            until JT.Next = 0;
        end;
        if ApplyPrices then begin
            TransferPrices;
        end;
        if JT.Find('-') then
            repeat
                SetNextPlanningLineNo := 10000;
                FromJTNo := JT."Job Task No.";
                ToJobTaskNo := JT."Job Task No.";
                Code;
            until JT.Next = 0;
        exit(NoOfLinesInserted);
    end;


    procedure CopyJobTask(): Integer
    begin
        if AmountAdjustFactor = 0 then
            AmountAdjustFactor := 1;
        CopyJobTaskSetfilters;
        JobPlanningLine2.SetRange("Job Task No.", JT."Job Task No.");
        JobPlanningLine2.SetRange("Job Task No.", ToJobTaskNo);
        if JobPlanningLine2.Find('+') then
            SetNextPlanningLineNo := JobPlanningLine2."Line No.";
        SetNextPlanningLineNo += 10000;
        if JT.Find('-') then
            Code;
        exit(NoOfLinesInserted);
    end;


    procedure CopyJobTaskSetfilters()
    begin
        Job.Get(FromJobNo);
        Job.TestField("Bill-to Customer No.");
        JT.SetRange("Job No.", Job."No.");
        Job2.Get(ToJobNo);
        Job2.TestField("Bill-to Customer No.");

        if FromDate <> 0D then begin
            if ToDate <> 0D then
                JT3.SetFilter("Planning Date Filter", '%1..%2', FromDate, ToDate)
            else
                JT3.SetFilter("Planning Date Filter", '%1..', FromDate);
        end else
            if ToDate <> 0D then
                JT3.SetFilter("Planning Date Filter", '..%1', ToDate)
            else
                JT3.SetFilter("Planning Date Filter", '');
    end;


    procedure CopyJobSetFilters()
    begin
        if FromJTNo <> '' then begin
            if ToJTNo <> '' then
                JT.SetFilter("Job Task No.", '%1..%2', FromJTNo, ToJTNo)
            else
                JT.SetFilter("Job Task No.", '%1..', FromJTNo);
        end else
            if ToJTNo <> '' then
                JT.SetFilter("Job Task No.", '..%1', ToJTNo);
    end;


    procedure TransferPrices()
    var
        JobItemPrices: Record "Job Item Price";
        JobResPrices: Record "Job Resource Price";
        JobGLPrices: Record "Job G/L Account Price";
        JobItemPrices2: Record "Job Item Price";
        JobResPrices2: Record "Job Resource Price";
        JobGLPrices2: Record "Job G/L Account Price";
    begin
        JobItemPrices.SetRange("Job No.", Job."No.");
        JobItemPrices.SetRange("Currency Code", Job."Currency Code");

        if JobItemPrices.Find('-') then
            repeat
                JobItemPrices2.TransferFields(JobItemPrices, true);
                JobItemPrices2."Job No." := Job2."No.";
                JobItemPrices2.Insert(true);
                NoOfLinesInserted += 1;
            until JobItemPrices.Next = 0;

        JobResPrices.SetRange("Job No.", Job."No.");
        JobResPrices.SetRange("Currency Code", Job."Currency Code");
        if JobResPrices.Find('-') then
            repeat
                JobResPrices2.TransferFields(JobResPrices, true);
                JobResPrices2."Job No." := Job2."No.";
                JobResPrices2.Insert(true);
                NoOfLinesInserted += 1;
            until JobResPrices.Next = 0;

        JobGLPrices.SetRange("Job No.", Job."No.");
        JobGLPrices.SetRange("Currency Code", Job."Currency Code");
        if JobGLPrices.Find('-') then
            repeat
                JobGLPrices2.TransferFields(JobGLPrices, true);
                JobGLPrices2."Job No." := Job2."No.";
                JobGLPrices2.Insert(true);
                NoOfLinesInserted += 1;
            until JobGLPrices.Next = 0;
    end;


    procedure AdjustAmounts(TempUnitPrice: Decimal)
    begin
        JobPlanningLine2.Quantity := JobPlanningLine2.Quantity * AmountAdjustFactor;
        if RoundingMethod.Code <> '' then begin
            if JobPlanningLine2.Quantity >= 0 then
                Sign := 1
            else
                Sign := -1;
            RoundingMethod."Minimum Amount" := Abs(JobPlanningLine2.Quantity);
            if RoundingMethod.Find('=<') then begin
                JobPlanningLine2.Quantity := JobPlanningLine2.Quantity + Sign * RoundingMethod."Amount Added Before";
                if RoundingMethod.Precision > 0 then
                    JobPlanningLine2.Quantity :=
                      Sign *
                      ROUND(
                        Abs(JobPlanningLine2.Quantity), RoundingMethod.Precision, CopyStr('=><',
                          RoundingMethod.Type + 1, 1));
                JobPlanningLine2.Quantity := JobPlanningLine2.Quantity + Sign * RoundingMethod."Amount Added After";
            end;
        end;
        TempUnitPrice := JobPlanningLine2."Unit Price";
        JobPlanningLine2.Validate("Unit Cost");
        JobPlanningLine2.Validate("Unit Price", TempUnitPrice);
    end;


    procedure SetCopyJob(InitFromSource2: Option "Job Planning Lines","Job Ledger Entry"; FromJobNo2: Code[20]; FromJTNo2: Code[20]; FromDate2: Date; LineType2: Option Schedule,Contract,"Both Schedule and Contract"; LedgerEntryType2: Option; ToDate2: Date; ToJobNo2: Code[20]; AmountAdjustFactor2: Decimal; ApplyPrices2: Boolean; RoundingMethod2: Record "Rounding Method"; ToJTNo2: Code[20]; CopyQuantity2: Boolean)
    begin
        ClearAll;
        FromSource := InitFromSource2;
        FromJobNo := FromJobNo2;
        FromJTNo := FromJTNo2;
        FromDate := FromDate2;
        LineType := LineType2;
        LedgerEntryType := LedgerEntryType2;
        ToDate := ToDate2;
        ToJobNo := ToJobNo2;
        AmountAdjustFactor := AmountAdjustFactor2;
        ApplyPrices := ApplyPrices2;
        RoundingMethod := RoundingMethod2;
        ToJTNo := ToJTNo2;
        CopyQuantity := CopyQuantity2;
    end;


    procedure SetCopyJobTask(FromJobNo2: Code[20]; FromJTNo2: Code[20]; FromDate2: Date; LineType2: Option Schedule,Contract,"Both Schedule and Contract"; LedgerEntryType2: Option; ToDate2: Date; ToJobNo2: Code[20]; AmountAdjustFactor2: Decimal; ApplyPrices2: Boolean; RoundingMethod2: Record "Rounding Method"; ToJTNo2: Code[20]; CopyQuantity2: Boolean)
    begin
        ClearAll;
        FromJobNo := FromJobNo2;
        FromJTNo := FromJTNo2;
        FromDate := FromDate2;
        LineType := LineType2;
        LedgerEntryType := LedgerEntryType2;
        ToDate := ToDate2;
        ToJobNo := ToJobNo2;
        AmountAdjustFactor := AmountAdjustFactor2;
        ApplyPrices := ApplyPrices2;
        RoundingMethod := RoundingMethod2;
        ToJobTaskNo := ToJTNo2;
        CopyQuantity := CopyQuantity2;
    end;
}

