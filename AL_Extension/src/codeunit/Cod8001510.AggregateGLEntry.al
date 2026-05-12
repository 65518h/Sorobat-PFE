Codeunit 8001510 "Aggregate, G/L Entry"
{
    //GL2024  ID dans Nav 2009 : "8001310"
    // #6572 SD 25/03/10
    // #6943 SD 31/03/09
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Aggregate, G/L Entry


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

        StatisticAggregate1.Reset;
        StatisticsSetup.Get;
        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);

        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        if WorkType[67] then
            if EntryNo = 0 then
                SearchEntry
            else begin
                if StatisticsSetup."Period total basis" <> StatisticsSetup."period total basis"::"According to every flow" then begin
                    BasePeriod := StatisticsSetup."Period total basis";
                    SearchEntry;
                end else begin
                    repeat
                        i := i + 1;
                        if PeriodBasis[67, i] then begin
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
        Entry: Record "G/L Entry";
        "Code": Record Code;
        StatisticsSetup: Record "Statistics setup";
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
            Entry.SetCurrentkey("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
            //   Entry.SETCURRENTKEY("G/L Account No.","Business Unit Code","Global Dimension 1 Code",
            //                       "Global Dimension 2 Code","Close Income Statement Dim. ID","Posting Date");
            Entry.SetRange("Posting Date", StartDate, EndDate);
        end else begin
            Entry.SetCurrentkey("Entry No.");
            Entry.SetRange("Entry No.", EntryNo);
        end;
    end;


    procedure SearchEntry()
    var
        StartD: Date;
        EndD: Date;
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
                              StartD := StatsExplorerTools.StartDateCalc(BasePeriod, "Posting Date");
                              EndD := StatsExplorerTools.EndDateCalc(BasePeriod, "Posting Date");
                              //#6943
                              //    IF (Quantity <> 0) OR (Amount <> 0) OR ("Additional-Currency Amount" <> 0) THEN BEGIN
                              if ((Quantity <> 0) or (Amount <> 0) or ("Additional-Currency Amount" <> 0)) and
                                ("Posting Date" = NormalDate("Posting Date")) then begin
                                  //#6943//
                                  StatisticAggregate1.Init;
                                  StatisticAggregate1."Entry No." := NextEntry;
                                  StatisticAggregate1."Period Length" := BasePeriod;
                                  StatisticAggregate1."Ending Date" := EndD;
                                  StatisticAggregate1."Entry Type" := TextType[67];
                                  StatisticAggregate1.Type := StatisticAggregate1.Type::"Account (G/L)";
                                  StatisticAggregate1."No." := Format("G/L Account No.");
                                  StatisticAggregate1."Business Unit Code" := "Business Unit Code";
                                  StatisticAggregate1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                  StatisticAggregate1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                  StatisticAggregate1.Quantity := Quantity;
                                  StatisticAggregate1.Amount := Amount;
                                  StatisticAggregate1.Cost := "Additional-Currency Amount";
                                  //#6943
                                  StatisticAggregate1."Job No." := Entry."Job No.";
                                  StatisticAggregate1."Gen. Prod. Posting Group" := Entry."Gen. Prod. Posting Group";
                                  //#6943//
                                  if SearchDim[67] then
                                      //GL2024     StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1, 17, "Entry No.");
                                      UpdateDefaultValues.Run(StatisticAggregate1);
                                  if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[67], 67) then begin
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

