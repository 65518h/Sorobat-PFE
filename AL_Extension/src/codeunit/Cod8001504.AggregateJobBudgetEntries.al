Codeunit 8001504 "Aggregate, Job Budget Entries"
{
    //GL2024  ID dans Nav 2009 : "8001304"
    // #8127 ML 29/06/10
    // #6572 SD 25/03/10
    // #6622 ML 05/11/08
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic Aggregates Job Budget Entries
    // //NAVIBAT_STATS GESWAY 05/07/05 Ajout champ Code nature + valeur 51 Prix revient


    trigger OnRun()
    begin
        //#6572
        if GuiAllowed then begin
            //#6572//
            Window.Open('#1##############################\\' +
                        Text002 +
                        Text003);
            Window.Update(1, Entry.TableCaption);
            //#6572
        end;
        //#6572//

        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);

        StatisticAggregate1.Reset;
        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        Treatment;
        //#6572
        if GuiAllowed then
            //#6572//
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
        Entry.SetCurrentkey("Job No.", "Job Task No.", "Line No.");
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
        if not Entry.IsEmpty then begin
            Entry.FindSet;
            with Entry do
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    //#6622
                    //     IF (Quantity <> 0) OR ("Line Amount (LCY)" <> 0) OR ("Total Cost" <> 0) OR ("Gross Total Cost" <> 0) THEN BEGIN
                    if (Quantity <> 0) or ("Line Amount (LCY)" <> 0) or ("Total Cost (LCY)" <> 0) or ("Gross Total Cost" <> 0) then begin
                        //#6622//
                        //#6104//
                        //NAVIBAT_STATS//
                        StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Planning Date");
                        EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Planning Date");
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := EndD;
                        StatisticAggregate1."Entry Type" := TextType[25];
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
                        //      StatisticAggregate1.Amount := "Total Price";
                        StatisticAggregate1.Amount := "Line Amount (LCY)";
                        //#6104//
                        //#6622
                        //      StatisticAggregate1.Cost := "Total Cost";
                        StatisticAggregate1.Cost := "Total Cost (LCY)";
                        //#6622//
                        //NAVIBAT_STATS
                        StatisticAggregate1."Free value 1" := "Gross Total Cost";
                        StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                        if (SearchDim[25]) then begin
                            StatsExplorerTools.SearchDefaultDimension(StatisticAggregate1, 8004160, "Job No.");
                        end;
                        //NAVIBAT_STATS//
                        UpdateDefaultValues.Run(StatisticAggregate1);
                        if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[25], 25) then begin
                            StatisticAggregate1.Insert;
                            NextEntry := NextEntry + 1;
                            NbCreated := NbCreated + 1;
                        end;
                        //#6572
                        if GuiAllowed then
                            //#6572//
                            Window.Update(3, NbCreated);
                    end;
                until Next = 0;
        end;
    end;
}

