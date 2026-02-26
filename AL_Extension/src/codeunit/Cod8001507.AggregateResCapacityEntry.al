Codeunit 8001507 "Aggregate, Res. Capacity Entry"
{
    //GL2024  ID dans Nav 2009 : "8001307"
    // #6572 SD 25/03/10
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Aggregate, Resource Capacity Entry


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
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
        //GL2024 License

        Entry: Record "Res. Capacity Entry";
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
        Entry.SetCurrentkey("Resource No.", Date);
        Entry.SetRange(Date, StartDate, EndDate);
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
            with Entry do repeat
                              NbRead := NbRead + 1;
                              //#6572
                              if GuiAllowed then
                                  //#6572//
                                  Window.Update(2, NbRead);
                              StartD := StatsExplorerTools.StartDateCalc(BasePeriod, Date);
                              EndD := StatsExplorerTools.EndDateCalc(BasePeriod, Date);
                              if (Capacity <> 0) then begin
                                  StatisticAggregate1.Init;
                                  StatisticAggregate1."Entry No." := NextEntry;
                                  StatisticAggregate1."Period Length" := BasePeriod;
                                  StatisticAggregate1."Ending Date" := EndD;
                                  StatisticAggregate1."Entry Type" := TextType[27];
                                  StatisticAggregate1.Type := StatisticAggregate1.Type::Resource;
                                  StatisticAggregate1."No." := "Resource No.";
                                  StatisticAggregate1."Resource Group No." := "Resource Group No.";
                                  StatisticAggregate1.Quantity := Capacity;
                                  //      IF SearchDim[27] THEN
                                  //         StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1,160,"Entry No.");
                                  UpdateDefaultValues.Run(StatisticAggregate1);
                                  if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[27], 27) then begin
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

