Codeunit 8001503 "Aggregate, Job Ledger Entries"
{
    //GL2024  ID dans Nav 2009 : "8001303"
    // #8125 ML 29/06/10
    // #6572 SD 25/03/10
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic Aggregates, Job Ledger Entries, Usages and Sales
    // //NAVIBAT_STATS GESWAY 05/07/05 Ajout valeur 51 Coût de revient


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
        if WorkType[20] then
            TypeFilter := '0';

        if WorkType[15] then
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
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
        //GL2024 License

        StatisticAggregate1: Record "Statistic aggregate";
        StatisticAggregate2: Record "Statistic aggregate";
        Entry: Record "Job Ledger Entry";
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
        SearchDimensions: Boolean;
        EntryNo: Integer;
        i: Integer;
        LastEntryNo: array[100] of Integer;
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
            Entry.SetCurrentkey("Entry Type", Type, "No.",
                                "Gen. Prod. Posting Group", "Resource Group No.",
                                "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No.",
                                "Work Type Code", "Reason Code", "Posting Date");
            Entry.SetRange("Posting Date", StartDate, EndDate);
        end else begin
            Entry.SetCurrentkey("Entry No.");
            Entry.SetRange("Entry No.", EntryNo);
        end;
        Entry.SetFilter("Entry Type", TypeFilter);
    end;


    procedure SearchEntry()
    var
        CalculerDate: Codeunit "StatsExplorer, Tools";
        ArretTraitement: Boolean;
        DateD: Date;
        DateF: Date;
        i: Integer;
        Resultat: array[20] of Decimal;
        NoType: Integer;
    begin
        ArretTraitement := false;
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
                    DateD := CalculerDate.StartDateCalc(BasePeriod, "Posting Date");
                    DateF := CalculerDate.EndDateCalc(BasePeriod, "Posting Date");
                    //NAVIBAT_STATS
                    //   IF (Quantity <> 0) OR ("Total Price" <> 0) OR ("Total Cost" <> 0) THEN BEGIN
                    //#6104
                    //       IF (Quantity <> 0) OR ("Total Price (LCY)" <> 0) OR ("Total Cost (LCY)" <> 0) OR ("Overhead Amount" <> 0) THEN BEGIN
                    if (Quantity <> 0) or ("Line Amount (LCY)" <> 0) or ("Total Cost (LCY)" <> 0) or ("Overhead Amount" <> 0) then begin
                        //#6104//
                        //NAVIBAT_STATS//
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := DateF;
                        case "Entry Type" of
                            "entry type"::Usage:
                                NoType := 20;
                            "entry type"::Sale:
                                NoType := 15;
                        end;
                        StatisticAggregate1."Entry Type" := TextType[NoType];
                        case Type of
                            Type::Item:
                                StatisticAggregate1.Type := StatisticAggregate1.Type::Item;
                            Type::Resource:
                                StatisticAggregate1.Type := StatisticAggregate1.Type::Resource;
                            Type::"G/L Account":
                                StatisticAggregate1.Type := StatisticAggregate1.Type::"Account (G/L)";
                        end;
                        StatisticAggregate1."No." := "No.";
                        StatisticAggregate1."Resource Group No." := "Resource Group No.";
                        StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                        StatisticAggregate1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        StatisticAggregate1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        StatisticAggregate1."Reason Code" := "Reason Code";
                        StatisticAggregate1."Job No." := "Job No.";
                        StatisticAggregate1."Job Task Code" := "Job Task No.";
                        StatisticAggregate1."Work Type Code" := "Work Type Code";
                        case "Entry Type" of
                            "entry type"::Usage:
                                begin
                                    StatisticAggregate1.Quantity := Quantity;
                                    StatisticAggregate1.Amount := "Total Cost (LCY)";
                                    StatisticAggregate1.Cost := "Total Price (LCY)";
                                    //NAVIBAT_STATS
                                    if "Vendor No." <> '' then begin
                                        StatisticAggregate1."Source Type" := StatisticAggregate1."source type"::Vendor;
                                        StatisticAggregate1."Source No." := "Vendor No.";
                                    end;
                                    StatisticAggregate1."Free value 1" := "Total Cost" + "Overhead Amount";
                                    //NAVIBAT_STATS//
                                end;
                            "entry type"::Sale:
                                begin
                                    StatisticAggregate1.Quantity := -Quantity;
                                    //#6104
                                    //             StatisticAggregate1.Amount := -"Total Price (LCY)";
                                    StatisticAggregate1.Amount := -"Line Amount (LCY)";
                                    //#6104//
                                    StatisticAggregate1.Cost := -"Total Cost (LCY)";
                                    //NAVIBAT_STATS
                                    StatisticAggregate1."Free value 1" := -("Total Cost" + "Overhead Amount");
                                    //NAVIBAT_STATS//
                                end;
                        end;
                        if ((StatisticAggregate1."Entry Type" = TextType[15]) and (SearchDim[15])) or
                           ((StatisticAggregate1."Entry Type" = TextType[20]) and (SearchDim[20])) then begin
                            //NANIBAT_STATS
                            //            StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1,169,"Entry No.");
                            //GL2024   StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1, 8004161, "Entry No.");
                            //NAVIBAT_STATS//
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

