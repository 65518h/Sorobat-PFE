Codeunit 8003962 "Agg. Init. Job Bud. Entries"
{
    // #8127 ML 29/06/10
    // //NAVIBAT_STATS GESWAY 05/07/05 Statistic Aggregates Initial Job Budget Entries


    trigger OnRun()
    begin
        Window.Open('#1##############################\\' +
                    Text002 +
                    Text003);
        Window.Update(1, Entry.TableCaption);

        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);

        StatisticAggregate1.Reset;
        if StatisticAggregate1.Find('+') then
            NextEntry := StatisticAggregate1."Entry No." + 1
        else
            NextEntry := 1;

        Treatment;
        Window.Close;
    end;

    var
        StatisticAggregate1: Record "Statistic aggregate";
        StatisticAggregate2: Record "Statistic aggregate";
        Entry: Record "Job Planning Line";
        "Code": Record Code;
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        Window: Dialog;
        TextType: array[100] of Text[30];
        WorkType: array[100] of Boolean;
        PeriodBasis: array[100, 6] of Boolean;
        StartDate: Date;
        EndDate: Date;
        BasePeriod: Option Day,Week,Month,Quarter,Year,Period;
        SearchDim: array[100] of Boolean;
        FieldEnabled: array[100, 250] of Boolean;
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        LastEntryNo: array[100] of Integer;
        Text002: label 'Read:                    #2#####\';
        Text003: label 'Created:                 #3#####\';


    procedure InitRequest(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period)
    begin
        StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
    end;


    procedure InitEntry()
    begin
        Entry.Reset;
        Entry.SetCurrentkey("Job No.", "Job Task No.", "Gen. Prod. Posting Group");
        Entry.SetRange("Entry Type", Entry."entry type"::Initial);
        Entry.SetRange("Planning Date", StartDate, EndDate);
    end;


    procedure Treatment()
    var
        StartD: Date;
        EndD: Date;
        i: Integer;
        Result: array[20] of Decimal;
    begin
        InitEntry;
        if Entry.Find('-') then
            with Entry do
                repeat
                    NbRead := NbRead + 1;
                    Window.Update(2, NbRead);
                    //#6104
                    //     IF (Quantity <> 0) OR ("Total Cost" <> 0) OR ("Total Price" <> 0) OR ("Gross Total Cost" <> 0) THEN BEGIN
                    if (Quantity <> 0) or ("Total Cost" <> 0) or ("Line Amount (LCY)" <> 0) or ("Gross Total Cost" <> 0) then begin
                        //#6104//
                        StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Planning Date");
                        EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Planning Date");
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := EndD;
                        StatisticAggregate1."Entry Type" := TextType[23];
                        case Type of
                            Type::Item:
                                StatisticAggregate1.Type := StatisticAggregate1.Type::Item;
                            Type::Resource:
                                StatisticAggregate1.Type := StatisticAggregate1.Type::Resource;
                            Type::"G/L Account":
                                StatisticAggregate1.Type := StatisticAggregate1.Type::"Account (G/L)";
                            Type::Text:
                                StatisticAggregate1.Type := StatisticAggregate1.Type::"Resource Group";
                        end;
                        StatisticAggregate1."No." := "No.";
                        StatisticAggregate1."Job No." := "Job No.";
                        StatisticAggregate1."Job Task Code" := "Job Task No.";
                        StatisticAggregate1.Quantity := Quantity;
                        //#6104
                        //        StatisticAggregate1.Amount := "Total Price";
                        StatisticAggregate1.Amount := "Line Amount (LCY)";
                        //#6104//
                        StatisticAggregate1.Cost := "Total Cost";
                        StatisticAggregate1."Free value 1" := "Gross Total Cost";
                        StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                        //#8127
                        if (SearchDim[23]) then begin
                            StatsExplorerTools.SearchDefaultDimension(StatisticAggregate1, 8004160, "Job No.");
                        end;
                        //#8127//
                        UpdateDefaultValues.Run(StatisticAggregate1);
                        if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[23], 23) then begin
                            StatisticAggregate1.Insert;
                            NextEntry := NextEntry + 1;
                            NbCreated := NbCreated + 1;
                        end;
                        Window.Update(3, NbCreated);
                    end;
                until Next = 0;
    end;
}

