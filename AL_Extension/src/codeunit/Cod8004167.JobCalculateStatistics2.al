Codeunit 8004167 "Job Calculate Statistics2"
{

    trigger OnRun()
    begin
    end;

    var
        JobLedgEntry: Record "Job Ledger Entry";
        JobPlanningLine: Record "Job Planning Line";
        ResUsageCostAmountLCY: Decimal;
        ResUsagePriceAmountLCY: Decimal;
        ResSaleCostAmountLCY: Decimal;
        ResSalePriceAmountLCY: Decimal;
        ResSchCostAmountLCY: Decimal;
        ResSchPriceAmountLCY: Decimal;
        ResContCostAmountLCY: Decimal;
        ResContPriceAmountLCY: Decimal;
        ItemUsageCostAmountLCY: Decimal;
        ItemUsagePriceAmountLCY: Decimal;
        ItemSaleCostAmountLCY: Decimal;
        ItemSalePriceAmountLCY: Decimal;
        ItemSchCostAmountLCY: Decimal;
        ItemSchPriceAmountLCY: Decimal;
        ItemContCostAmountLCY: Decimal;
        ItemContPriceAmountLCY: Decimal;
        GLUsageCostAmountLCY: Decimal;
        GLUsagePriceAmountLCY: Decimal;
        GLSaleCostAmountLCY: Decimal;
        GLSalePriceAmountLCY: Decimal;
        GLSchCostAmountLCY: Decimal;
        GLSchPriceAmountLCY: Decimal;
        GLContCostAmountLCY: Decimal;
        GLContPriceAmountLCY: Decimal;
        ResUsageCostAmount: Decimal;
        ResUsagePriceAmount: Decimal;
        ResSaleCostAmount: Decimal;
        ResSalePriceAmount: Decimal;
        ResSchCostAmount: Decimal;
        ResSchPriceAmount: Decimal;
        ResContCostAmount: Decimal;
        ResContPriceAmount: Decimal;
        ItemUsageCostAmount: Decimal;
        ItemUsagePriceAmount: Decimal;
        ItemSaleCostAmount: Decimal;
        ItemSalePriceAmount: Decimal;
        ItemSchCostAmount: Decimal;
        ItemSchPriceAmount: Decimal;
        ItemContCostAmount: Decimal;
        ItemContPriceAmount: Decimal;
        GLUsageCostAmount: Decimal;
        GLUsagePriceAmount: Decimal;
        GLSaleCostAmount: Decimal;
        GLSalePriceAmount: Decimal;
        GLSchCostAmount: Decimal;
        GLSchPriceAmount: Decimal;
        GLContCostAmount: Decimal;
        GLContPriceAmount: Decimal;
        Text000: label 'Sch. Price,Usage Price,Contract Price,Inv. Price,Sch. Cost,Usage Cost,Contract Cost,Inv. Cost,Sch. Profit,Usage Profit,Contract Profit,Inv. Profit';


    procedure ReportAnalysis(var Job: Record Job; var JT: Record "Job Task"; var Amt: array[8] of Decimal; AmountField: array[8] of Option " ",SchPrice,UsagePrice,ContractPrice,InvoicedPrice,SchCost,UsageCost,ContractCost,InvoicedCost,SchProfit,UsageProfit,ContractProfit,InvoicedProfit; CurrencyField: array[8] of Option LCY,FCY; JobLevel: Boolean)
    var
        PL: array[16] of Decimal;
        CL: array[16] of Decimal;
        P: array[16] of Decimal;
        C: array[16] of Decimal;
        I: Integer;
    begin
        if JobLevel then
            JobCalculateCommonFilters(Job)
        else
            JTCalculateCommonFilters(JT, Job, true);
        CalculateAmounts;
        GetLCYCostAmounts(CL);
        GetCostAmounts(C);
        GetLCYPriceAmounts(PL);
        GetPriceAmounts(P);
        Clear(Amt);
        for I := 1 to 8 do begin
            if AmountField[I] = AmountField[I] ::SchPrice then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[4]
                else
                    Amt[I] := P[4];
            if AmountField[I] = AmountField[I] ::UsagePrice then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[8]
                else
                    Amt[I] := P[8];
            if AmountField[I] = AmountField[I] ::ContractPrice then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[12]
                else
                    Amt[I] := P[12];
            if AmountField[I] = AmountField[I] ::InvoicedPrice then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[16]
                else
                    Amt[I] := P[16];

            if AmountField[I] = AmountField[I] ::SchCost then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := CL[4]
                else
                    Amt[I] := C[4];
            if AmountField[I] = AmountField[I] ::UsageCost then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := CL[8]
                else
                    Amt[I] := C[8];
            if AmountField[I] = AmountField[I] ::ContractCost then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := CL[12]
                else
                    Amt[I] := C[12];
            if AmountField[I] = AmountField[I] ::InvoicedCost then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := CL[16]
                else
                    Amt[I] := C[16];

            if AmountField[I] = AmountField[I] ::SchProfit then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[4] - CL[4]
                else
                    Amt[I] := P[4] - C[4];
            if AmountField[I] = AmountField[I] ::UsageProfit then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[8] - CL[8]
                else
                    Amt[I] := P[8] - C[8];
            if AmountField[I] = AmountField[I] ::ContractProfit then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[12] - CL[12]
                else
                    Amt[I] := P[12] - C[12];
            if AmountField[I] = AmountField[I] ::InvoicedProfit then
                if CurrencyField[I] = CurrencyField[I] ::LCY then
                    Amt[I] := PL[16] - CL[16]
                else
                    Amt[I] := P[16] - C[16];
        end;
    end;


    procedure ReportSuggBilling(var Job: Record Job; var JT: Record "Job Task"; var Amt: array[8] of Decimal; CurrencyField: array[8] of Option LCY,FCY)
    var
        AmountField: array[8] of Option " ",SchPrice,UsagePrice,ContractPrice,InvoicedPrice,SchCost,UsageCost,ContractCost,InvoicedCost,SchProfit,UsageProfit,ContractProfit,InvoicedProfit;
    begin
        AmountField[1] := AmountField[1] ::ContractCost;
        AmountField[2] := AmountField[2] ::ContractPrice;
        AmountField[3] := AmountField[3] ::InvoicedCost;
        AmountField[4] := AmountField[4] ::InvoicedPrice;
        ReportAnalysis(Job, JT, Amt, AmountField, CurrencyField, false);
        Amt[5] := Amt[1] - Amt[3];
        Amt[6] := Amt[2] - Amt[4];
    end;


    procedure RepJobCustomer(var Job2: Record Job; var Amt: array[8] of Decimal)
    var
        JT: Record "Job Task";
        AmountField: array[8] of Option " ",SchPrice,UsagePrice,ContractPrice,InvoicedPrice,SchCost,UsageCost,ContractCost,InvoicedCost,SchProfit,UsageProfit,ContractProfit,InvoicedProfit;
        CurrencyField: array[8] of Option LCY,FCY;
    begin
        Clear(Amt);
        if Job2."No." = '' then
            exit;
        AmountField[1] := AmountField[1] ::SchPrice;
        AmountField[2] := AmountField[2] ::UsagePrice;
        AmountField[3] := AmountField[3] ::InvoicedPrice;
        AmountField[4] := AmountField[4] ::ContractPrice;
        ReportAnalysis(Job2, JT, Amt, AmountField, CurrencyField, true);
        Amt[5] := 0;
        Amt[6] := 0;
        if Amt[1] <> 0 then
            Amt[5] := ROUND(Amt[2] / Amt[1] * 100);
        if Amt[4] <> 0 then
            Amt[6] := ROUND(Amt[3] / Amt[4] * 100);
    end;


    procedure JobCalculateCommonFilters(var Job: Record Job)
    begin
        ClearAll;
        JobPlanningLine.SetCurrentkey("Job No.", "Job Task No.");
        JobLedgEntry.SetCurrentkey("Job No.", "Job Task No.", "Entry Type");
        JobLedgEntry.SetRange("Job No.", Job."No.");
        JobPlanningLine.SetRange("Job No.", Job."No.");
        JobLedgEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
        JobPlanningLine.SetFilter("Planning Date", Job.GetFilter("Planning Date Filter"));
    end;


    procedure JTCalculateCommonFilters(var JT2: Record "Job Task"; var Job: Record Job; UseJobFilter: Boolean)
    var
        JT: Record "Job Task";
    begin
        ClearAll;
        JT := JT2;
        JobPlanningLine.SetCurrentkey("Job No.", "Job Task No.");
        JobLedgEntry.SetCurrentkey("Job No.", "Job Task No.", "Entry Type");
        JobLedgEntry.SetRange("Job No.", JT."Job No.");
        JobPlanningLine.SetRange("Job No.", JT."Job No.");
        if JT."Job Task No." <> '' then begin
            if JT.Totaling <> '' then begin
                JobLedgEntry.SetFilter("Job Task No.", JT.Totaling);
                JobPlanningLine.SetFilter("Job Task No.", JT.Totaling);
            end else begin
                JobLedgEntry.SetRange("Job Task No.", JT."Job Task No.");
                JobPlanningLine.SetRange("Job Task No.", JT."Job Task No.");
            end;
        end;

        if not UseJobFilter then begin
            JobLedgEntry.SetFilter("Posting Date", JT2.GetFilter("Posting Date Filter"));
            JobPlanningLine.SetFilter("Planning Date", JT2.GetFilter("Planning Date Filter"));
        end else begin
            JobLedgEntry.SetFilter("Posting Date", Job.GetFilter("Posting Date Filter"));
            JobPlanningLine.SetFilter("Planning Date", Job.GetFilter("Planning Date Filter"));
        end;
    end;


    procedure CalculateAmounts()
    begin
        with JobLedgEntry do begin
            if Find('-') then
                repeat
                    if "Entry Type" = "entry type"::Usage then begin
                        if Type = Type::Resource then begin
                            ResUsageCostAmountLCY := ResUsageCostAmountLCY + "Total Cost (LCY)";
                            ResUsagePriceAmountLCY := ResUsagePriceAmountLCY + "Line Amount (LCY)";
                            ResUsageCostAmount := ResUsageCostAmount + "Total Cost";
                            ResUsagePriceAmount := ResUsagePriceAmount + "Line Amount";
                        end;
                        if Type = Type::Item then begin
                            ItemUsageCostAmountLCY := ItemUsageCostAmountLCY + "Total Cost (LCY)";
                            ItemUsagePriceAmountLCY := ItemUsagePriceAmountLCY + "Line Amount (LCY)";
                            ItemUsageCostAmount := ItemUsageCostAmount + "Total Cost";
                            ItemUsagePriceAmount := ItemUsagePriceAmount + "Line Amount";
                        end;
                        if Type = Type::"G/L Account" then begin
                            GLUsageCostAmountLCY := GLUsageCostAmountLCY + "Total Cost (LCY)";
                            GLUsagePriceAmountLCY := GLUsagePriceAmountLCY + "Line Amount (LCY)";
                            GLUsageCostAmount := GLUsageCostAmount + "Total Cost";
                            GLUsagePriceAmount := GLUsagePriceAmount + "Line Amount";
                        end;

                    end;
                    if "Entry Type" = "entry type"::Sale then begin
                        if Type = Type::Resource then begin
                            ResSaleCostAmountLCY := ResSaleCostAmountLCY + "Total Cost (LCY)";
                            ResSalePriceAmountLCY := ResSalePriceAmountLCY + "Line Amount (LCY)";
                            ResSaleCostAmount := ResSaleCostAmount + "Total Cost";
                            ResSalePriceAmount := ResSalePriceAmount + "Line Amount";
                        end;
                        if Type = Type::Item then begin
                            ItemSaleCostAmountLCY := ItemSaleCostAmountLCY + "Total Cost (LCY)";
                            ItemSalePriceAmountLCY := ItemSalePriceAmountLCY + "Line Amount (LCY)";
                            ItemSaleCostAmount := ItemSaleCostAmount + "Total Cost";
                            ItemSalePriceAmount := ItemSalePriceAmount + "Line Amount";
                        end;
                        if Type = Type::"G/L Account" then begin
                            GLSaleCostAmountLCY := GLSaleCostAmountLCY + "Total Cost (LCY)";
                            GLSalePriceAmountLCY := GLSalePriceAmountLCY + "Line Amount (LCY)";
                            GLSaleCostAmount := GLSaleCostAmount + "Total Cost";
                            GLSalePriceAmount := GLSalePriceAmount + "Line Amount";
                        end;
                    end;
                until Next = 0;
        end;

        with JobPlanningLine do begin
            if Find('-') then
                repeat
                    if "Schedule Line" then begin
                        if Type = Type::Resource then begin
                            ResSchCostAmountLCY := ResSchCostAmountLCY + "Total Cost (LCY)";
                            ResSchPriceAmountLCY := ResSchPriceAmountLCY + "Line Amount (LCY)";
                            ResSchCostAmount := ResSchCostAmount + "Total Cost";
                            ResSchPriceAmount := ResSchPriceAmount + "Line Amount";
                        end;
                        if Type = Type::Item then begin
                            ItemSchCostAmountLCY := ItemSchCostAmountLCY + "Total Cost (LCY)";
                            ItemSchPriceAmountLCY := ItemSchPriceAmountLCY + "Line Amount (LCY)";
                            ItemSchCostAmount := ItemSchCostAmount + "Total Cost";
                            ItemSchPriceAmount := ItemSchPriceAmount + "Line Amount";
                        end;
                        if Type = Type::"G/L Account" then begin
                            GLSchCostAmountLCY := GLSchCostAmountLCY + "Total Cost (LCY)";
                            GLSchPriceAmountLCY := GLSchPriceAmountLCY + "Line Amount (LCY)";
                            GLSchCostAmount := GLSchCostAmount + "Total Cost";
                            GLSchPriceAmount := GLSchPriceAmount + "Line Amount";
                        end;
                    end;
                    if "Contract Line" then begin
                        if Type = Type::Resource then begin
                            ResContCostAmountLCY := ResContCostAmountLCY + "Total Cost (LCY)";
                            ResContPriceAmountLCY := ResContPriceAmountLCY + "Line Amount (LCY)";
                            ResContCostAmount := ResContCostAmount + "Total Cost";
                            ResContPriceAmount := ResContPriceAmount + "Line Amount";
                        end;
                        if Type = Type::Item then begin
                            ItemContCostAmountLCY := ItemContCostAmountLCY + "Total Cost (LCY)";
                            ItemContPriceAmountLCY := ItemContPriceAmountLCY + "Line Amount (LCY)";
                            ItemContCostAmount := ItemContCostAmount + "Total Cost";
                            ItemContPriceAmount := ItemContPriceAmount + "Line Amount";
                        end;
                        if Type = Type::"G/L Account" then begin
                            GLContCostAmountLCY := GLContCostAmountLCY + "Total Cost (LCY)";
                            GLContPriceAmountLCY := GLContPriceAmountLCY + "Line Amount (LCY)";
                            GLContCostAmount := GLContCostAmount + "Total Cost";
                            GLContPriceAmount := GLContPriceAmount + "Line Amount";
                        end;
                    end;
                until Next = 0;
        end;
    end;


    procedure GetLCYCostAmounts(var Amt: array[16] of Decimal)
    begin
        Amt[1] := ResSchCostAmountLCY;
        Amt[2] := ItemSchCostAmountLCY;
        Amt[3] := GLSchCostAmountLCY;
        Amt[4] := Amt[1] + Amt[2] + Amt[3];
        Amt[5] := ResUsageCostAmountLCY;
        Amt[6] := ItemUsageCostAmountLCY;
        Amt[7] := GLUsageCostAmountLCY;
        Amt[8] := Amt[5] + Amt[6] + Amt[7];
        Amt[9] := ResContCostAmountLCY;
        Amt[10] := ItemContCostAmountLCY;
        Amt[11] := GLContCostAmountLCY;
        Amt[12] := Amt[9] + Amt[10] + Amt[11];
        Amt[13] := -ResSaleCostAmountLCY;
        Amt[14] := -ItemSaleCostAmountLCY;
        Amt[15] := -GLSaleCostAmountLCY;
        Amt[16] := Amt[13] + Amt[14] + Amt[15];
    end;


    procedure GetCostAmounts(var Amt: array[16] of Decimal)
    begin
        Amt[1] := ResSchCostAmount;
        Amt[2] := ItemSchCostAmount;
        Amt[3] := GLSchCostAmount;
        Amt[4] := Amt[1] + Amt[2] + Amt[3];
        Amt[5] := ResUsageCostAmount;
        Amt[6] := ItemUsageCostAmount;
        Amt[7] := GLUsageCostAmount;
        Amt[8] := Amt[5] + Amt[6] + Amt[7];
        Amt[9] := ResContCostAmount;
        Amt[10] := ItemContCostAmount;
        Amt[11] := GLContCostAmount;
        Amt[12] := Amt[9] + Amt[10] + Amt[11];
        Amt[13] := -ResSaleCostAmount;
        Amt[14] := -ItemSaleCostAmount;
        Amt[15] := -GLSaleCostAmount;
        Amt[16] := Amt[13] + Amt[14] + Amt[15];
    end;


    procedure GetLCYPriceAmounts(var Amt: array[16] of Decimal)
    begin
        Amt[1] := ResSchPriceAmountLCY;
        Amt[2] := ItemSchPriceAmountLCY;
        Amt[3] := GLSchPriceAmountLCY;
        Amt[4] := Amt[1] + Amt[2] + Amt[3];
        Amt[5] := ResUsagePriceAmountLCY;
        Amt[6] := ItemUsagePriceAmountLCY;
        Amt[7] := GLUsagePriceAmountLCY;
        Amt[8] := Amt[5] + Amt[6] + Amt[7];
        Amt[9] := ResContPriceAmountLCY;
        Amt[10] := ItemContPriceAmountLCY;
        Amt[11] := GLContPriceAmountLCY;
        Amt[12] := Amt[9] + Amt[10] + Amt[11];
        Amt[13] := -ResSalePriceAmountLCY;
        Amt[14] := -ItemSalePriceAmountLCY;
        Amt[15] := -GLSalePriceAmountLCY;
        Amt[16] := Amt[13] + Amt[14] + Amt[15];
    end;


    procedure GetPriceAmounts(var Amt: array[16] of Decimal)
    begin
        Amt[1] := ResSchPriceAmount;
        Amt[2] := ItemSchPriceAmount;
        Amt[3] := GLSchPriceAmount;
        Amt[4] := Amt[1] + Amt[2] + Amt[3];
        Amt[5] := ResUsagePriceAmount;
        Amt[6] := ItemUsagePriceAmount;
        Amt[7] := GLUsagePriceAmount;
        Amt[8] := Amt[5] + Amt[6] + Amt[7];
        Amt[9] := ResContPriceAmount;
        Amt[10] := ItemContPriceAmount;
        Amt[11] := GLContPriceAmount;
        Amt[12] := Amt[9] + Amt[10] + Amt[11];
        Amt[13] := -ResSalePriceAmount;
        Amt[14] := -ItemSalePriceAmount;
        Amt[15] := -GLSalePriceAmount;
        Amt[16] := Amt[13] + Amt[14] + Amt[15];
    end;


    procedure ShowPlanningLine(Showfield: Integer; JobType: Option " ",Resource,Item,GL; Schedule: Boolean)
    var
    //GL2024 NAVIBAT  PlanningList: Page 8004185;
    begin
        with JobPlanningLine do begin
            SetRange("Contract Line");
            SetRange("Schedule Line");
            SetRange(Type);
            if JobType > 0 then
                SetRange(Type, JobType - 1);
            if Schedule then
                SetRange("Schedule Line", true)
            else
                SetRange("Contract Line", true);
            /* //GL2024 NAVIBAT PlanningList.SetTableview(JobPlanningLine);
             PlanningList.SetActiveField(Showfield);
             PlanningList.Run;*/
        end;
    end;


    procedure ShowLedgEntry(Showfield: Integer; JobType: Option " ",Resource,Item,GL; Usage: Boolean)
    var
    //GL2024 NAVIBAT   JobLedgEntryList: Page 8004162;
    begin
        JobLedgEntry.SetRange(Type);
        if Usage then
            JobLedgEntry.SetRange("Entry Type", JobLedgEntry."entry type"::Usage)
        else
            JobLedgEntry.SetRange("Entry Type", JobLedgEntry."entry type"::Sale);
        if JobType > 0 then
            JobLedgEntry.SetRange(Type, JobType - 1);
        /*  //GL2024 NAVIBAT     JobLedgEntryList.SetTableview(JobLedgEntry);
             JobLedgEntryList.SetActiveField(Showfield);
             JobLedgEntryList.Run;*/
    end;


    procedure GetHeadLineText(AmountField: array[8] of Option " ",SchPrice,UsagePrice,ContractPrice,InvoicedPrice,SchCost,UsageCost,ContractCost,InvoicedCost,SchProfit,UsageProfit,ContractProfit,InvoicedProfit; CurrencyField: array[8] of Option LCY,FCY; var HeadLineText: array[8] of Text[50]; Job: Record Job)
    var
        GLSetup: Record "General Ledger Setup";
        I: Integer;
        Txt: Text[30];
    begin
        Clear(HeadLineText);
        GLSetup.Get;

        for I := 1 to 8 do begin
            Txt := '';
            if CurrencyField[I] > 0 then
                Txt := Job."Currency Code";
            if Txt = '' then
                Txt := GLSetup."LCY Code";
            if AmountField[I] > 0 then
                HeadLineText[I] := SelectStr(AmountField[I], Text000) + '\' + Txt;
        end;
    end;
}

