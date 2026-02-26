Codeunit 8001513 "Aggregate, Res. Ledger Entries"
{
    //GL2024  ID dans Nav 2009 : "8001313"
    // #6572 SD 25/03/10
    // //STATSEXPLORER STATSEXPLORER 01/10/00 Aggregate, Resource Ledger Entries


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

        StatisticsSetup.Get;

        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        TypeFilter := '';
        if WorkType[29] then
            TypeFilter := '0';

        if WorkType[28] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|1'
            else
                TypeFilter := '1';

        if TypeFilter <> '' then
            if EntryNo = 0 then
                SearchEntry
            else begin
                if StatisticsSetup."Period total basis" <> StatisticsSetup."period total basis"::"According to every flow" then begin
                    BasePeriod := StatisticsSetup."Period total basis";
                    SearchEntry;
                end else begin
                    repeat
                        i := i + 1;
                        if PeriodBasis[15, i] or PeriodBasis[20, i] then begin
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
        Entry: Record "Res. Ledger Entry";
        "Code": Record Code;
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        StatisticsSetup: Record "Statistics setup";
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        Window: Dialog;
        TextType: array[100] of Text[30];
        WorkType: array[100] of Boolean;
        PeriodBasis: array[100, 6] of Boolean;
        SearchDim: array[100] of Boolean;
        StartDate: Date;
        EndDate: Date;
        BasePeriod: Option Day,Week,Month,Quarter,Year,Period;
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        TypeFilter: Text[250];
        SearchDimensions: Boolean;
        FieldEnabled: array[100, 250] of Boolean;
        EntryNo: Integer;
        LastEntryNo: array[100] of Integer;
        i: Integer;
        Text002: label 'Read:                    #2#####\';
        Text003: label 'Created:                 #3#####\';


    procedure InitRequest(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period; wEntryNo: Integer)
    begin
        StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
        EntryNo := wEntryNo;
    end;


    procedure InitEntry()
    begin
        Entry.Reset;
        if EntryNo = 0 then begin
            Entry.SetCurrentkey("Entry Type", "Resource No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Resource Group No.",
                            "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.", "Work Type Code", "Reason Code", "Posting Date");
            Entry.SetRange("Posting Date", StartDate, EndDate);
        end else begin
            Entry.SetCurrentkey("Entry No.");
            Entry.SetRange("Entry No.", EntryNo);
        end;
        Entry.SetFilter("Entry Type", TypeFilter);
    end;


    procedure SearchEntry()
    var
        StartD: Date;
        EndD: Date;
        i: Integer;
        Result: array[20] of Decimal;
        NoType: Integer;
    begin
        InitEntry;
        with Entry do
            if not IsEmpty then begin
                FindSet;
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Posting Date");
                    EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Posting Date");
                    if (Quantity <> 0) or ("Total Price" <> 0) or ("Total Cost" <> 0) then begin
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := EndD;
                        case "Entry Type" of
                            "entry type"::Sale:
                                NoType := 28;
                            "entry type"::Usage:
                                NoType := 29;
                        end;
                        StatisticAggregate1."Entry Type" := TextType[NoType];
                        StatisticAggregate1.Type := StatisticAggregate1.Type::Resource;
                        StatisticAggregate1."No." := "Resource No.";
                        StatisticAggregate1."Resource Group No." := "Resource Group No.";
                        StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                        StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                        StatisticAggregate1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        StatisticAggregate1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        StatisticAggregate1."Reason Code" := "Reason Code";
                        StatisticAggregate1."Job No." := "Job No.";
                        StatisticAggregate1."Work Type Code" := "Work Type Code";
                        StatisticAggregate1."Source Type" := Entry."Source Type";
                        StatisticAggregate1."Source No." := Entry."Source No.";
                        case "Entry Type" of
                            "entry type"::Usage:
                                begin
                                    StatisticAggregate1.Quantity := Quantity;
                                    StatisticAggregate1.Amount := "Total Cost";
                                    StatisticAggregate1.Cost := "Total Price";
                                end;
                            "entry type"::Sale:
                                begin
                                    StatisticAggregate1.Quantity := -Quantity;
                                    StatisticAggregate1.Amount := -"Total Price";
                                    StatisticAggregate1.Cost := -"Total Cost";
                                end;
                        end;
                        if ((StatisticAggregate1."Entry Type" = TextType[28]) and (SearchDim[28])) or
                           ((StatisticAggregate1."Entry Type" = TextType[29]) and (SearchDim[29])) then begin
                            //GL2024   StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1, 203, "Entry No.");
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

