Codeunit 8001506 "Aggregate, Vendor Ledger Entry"
{
    //GL2024  ID dans Nav 2009 : "8001306"
    // #6572 SD 25/03/10
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Aggregate, Vendor Ledger Entry by Due Date or by Posting Date


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

        StatisticsSetup.Get;
        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);
        StatisticAggregate1.Reset;

        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        if EntryNo = 0 then
            SearchEntry
        else begin
            if StatisticsSetup."Period total basis" <> StatisticsSetup."period total basis"::"According to every flow" then begin
                if WorkType[64] then begin
                    DueDate := true;
                    BasePeriod := StatisticsSetup."Period total basis";
                    SearchEntry;
                end;
                if WorkType[65] then begin
                    DueDate := false;
                    BasePeriod := StatisticsSetup."Period total basis";
                    SearchEntry;
                end;
            end else begin
                repeat
                    i := i + 1;
                    if PeriodBasis[64, i] then begin
                        DueDate := true;
                        BasePeriod := i - 1;
                        SearchEntry;
                    end;
                    if PeriodBasis[65, i] then begin
                        DueDate := false;
                        BasePeriod := i - 1;
                        SearchEntry;
                    end;
                until i = 5;
            end;
        end;

        //#6572
        if GuiAllowed then
            //#6572//
            Window.Close;
    end;

    var
        StatisticAggregate1: Record "Statistic aggregate";
        StatisticAggregate2: Record "Statistic aggregate";
        Entry: Record "Vendor Ledger Entry";
        "Code": Record Code;
        StatisticsSetup: Record "Statistics setup";
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        Window: Dialog;
        TextType: array[100] of Text[30];
        WorkType: array[100] of Boolean;
        PeriodBasis: array[100, 6] of Boolean;
        SearchDim: array[100] of Boolean;
        FieldEnabled: array[100, 250] of Boolean;
        StartDate: Date;
        EndDate: Date;
        BasePeriod: Option Day,Week,Month,Quarter,Year,Period;
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        TypeFilter: Text[250];
        DueDate: Boolean;
        Result: array[2] of Decimal;
        SearchDimensions: Boolean;
        EntryNo: Integer;
        LastEntryNo: array[100] of Integer;
        i: Integer;
        Text002: label 'Read:                    #2#####\';
        Text003: label 'Created:                 #3#####\';


    procedure InitRequest(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period; wDueDate: Boolean; wEntryNo: Integer)
    begin
        StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
        DueDate := wDueDate;
        EntryNo := wEntryNo;
    end;


    procedure InitEntry()
    begin
        Entry.Reset;

        if EntryNo = 0 then begin
            if DueDate then
                Entry.SetCurrentkey("Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code",
                                    "Global Dimension 2 Code", "Currency Code", "Due Date")
            else
                Entry.SetCurrentkey("Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code",
                                    "Global Dimension 2 Code", "Currency Code", "Posting Date");
        end else begin
            Entry.SetCurrentkey("Entry No.");
            Entry.SetRange("Entry No.", EntryNo);
        end;
    end;


    procedure SearchEntry()
    var
        StartD: Date;
        EndD: Date;
        NoType: Integer;
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
                    if DueDate then begin
                        StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Due Date");
                        EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Due Date");
                    end else begin
                        StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Posting Date");
                        EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Posting Date");
                    end;
                    CalcFields(Amount, "Amount (LCY)");
                    if (Amount <> 0) or ("Amount (LCY)" <> 0) then begin
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := EndD;
                        if DueDate then
                            NoType := 64
                        else
                            NoType := 65;
                        StatisticAggregate1."Entry Type" := TextType[NoType];
                        StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Vendor;
                        StatisticAggregate1."Source No." := "Vendor No.";
                        StatisticAggregate1."Source Posting Group" := "Vendor Posting Group";
                        StatisticAggregate1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        StatisticAggregate1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        StatisticAggregate1.Quantity := 1;
                        StatisticAggregate1.Amount := "Amount (LCY)";
                        StatisticAggregate1.Cost := Amount;
                        if ((StatisticAggregate1."Entry Type" = TextType[64]) and (SearchDim[64])) or
                           ((StatisticAggregate1."Entry Type" = TextType[65]) and (SearchDim[65])) then begin
                            //GL2024    StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1, 21, "Entry No.");
                            SearchDimensions := true;
                        end;
                        UpdateDefaultValues.Run(StatisticAggregate1);
                        if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDimensions, NoType) then begin
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

