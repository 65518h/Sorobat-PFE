Codeunit 8001501 "Aggr., Item Ledger Entries"
{
    //GL2024  ID dans Nav 2009 : "8001301"
    // #9129 AC 03/10/11
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Process Aggregates, Item Ledger Entry
    // 
    // This codeunit was changed for 3.60 version, amounts are very different from other versions


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

        StatisticAggregate1.SetCurrentkey("Entry Type", "Ending Date");
        StatisticAggregate1.SetRange("Period Length", BasePeriod);
        StatisticAggregate1.SetRange("Ending Date", StartDate, EndDate);

        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);

        StatisticAggregate2.SetCurrentkey("Period Length", "Ending Date", "Entry Type", Type, "No.", "Source Type", "Source No."
        , "Location Code", "Inventory Posting Group", "Source Posting Group", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group",
        "Salespers./Purch. Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Country Code", "Business Unit Code");

        StatisticAggregate1.SetCurrentkey("Entry No.");
        StatisticAggregate1.Reset;
        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        TypeFilter := '';
        if WorkType[5] then
            TypeFilter := '1';

        if WorkType[10] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|0'
            else
                TypeFilter := '0';

        if WorkType[40] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|2'
            else
                TypeFilter := '2';

        if WorkType[45] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|3'
            else
                TypeFilter := '3';

        if WorkType[50] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|4'
            else
                TypeFilter := '4';

        if WorkType[80] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|5'
            else
                TypeFilter := '5';

        if WorkType[81] then
            if TypeFilter <> '' then
                TypeFilter := TypeFilter + '|6'
            else
                TypeFilter := '6';

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
                        if PeriodBasis[5, i] or PeriodBasis[10, i] or PeriodBasis[40, i] or PeriodBasis[45, i] or PeriodBasis[50, i]
                           or PeriodBasis[80, i] or PeriodBasis[81, i] then begin
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
        Entry: Record "Value Entry";
        "Code": Record Code;
        //GL2024  LedgerEntryDimension: Record 355;
        StatisticsSetup: Record "Statistics setup";
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        Window: Dialog;
        StartDate: Date;
        EndDate: Date;
        BasePeriod: Option Day,Week,Month,Quarter,Year,Period;
        TextType: array[100] of Text[30];
        FieldEnabled: array[100, 250] of Boolean;
        WorkType: array[100] of Boolean;
        PeriodBasis: array[100, 6] of Boolean;
        SearchDim: array[100] of Boolean;
        NbRead: Integer;
        NbCreated: Integer;
        NextEntry: Integer;
        TypeFilter: Text[250];
        SearchDimensions: Boolean;
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
            Entry.SetCurrentkey("Item Ledger Entry Type", "Item No.", "Source Type", "Source No.", "Location Code", "Inventory Posting Group",
                 "Source Posting Group", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Salespers./Purch. Code",
                 "Global Dimension 1 Code", "Global Dimension 2 Code", "Reason Code", "Posting Date");
            Entry.SetRange("Posting Date", StartDate, EndDate);
        end else begin
            Entry.SetCurrentkey("Entry No.");
            Entry.SetRange("Entry No.", EntryNo);
        end;
        Entry.SetFilter("Item Ledger Entry Type", TypeFilter);
        Entry.SetRange(Inventoriable, true);
        //Entry.SETRANGE(Entry."Expected Cost",FALSE);
    end;


    procedure SearchEntry()
    var
        SDate: Date;
        EDate: Date;
        i: Integer;
        Result: array[20] of Decimal;
        NoType: Integer;
    begin
        with Entry do begin
            InitEntry;
            if not IsEmpty then begin
                FindSet;
                repeat
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(2, NbRead);
                    SDate := StatsExplorerTools.StartDateCalc(BasePeriod, "Posting Date");
                    EDate := StatsExplorerTools.EndDateCalc(BasePeriod, "Posting Date");
                    StatisticAggregate1.Init;
                    StatisticAggregate1."Entry No." := NextEntry;
                    StatisticAggregate1."Period Length" := BasePeriod;
                    StatisticAggregate1."Ending Date" := EDate;
                    case "Item Ledger Entry Type" of
                        "item ledger entry type"::Purchase:
                            NoType := 10;
                        "item ledger entry type"::Sale:
                            NoType := 5;
                        "item ledger entry type"::"Positive Adjmt.":
                            NoType := 40;
                        "item ledger entry type"::"Negative Adjmt.":
                            NoType := 45;
                        "item ledger entry type"::Transfer:
                            NoType := 50;
                        "item ledger entry type"::Consumption:
                            NoType := 80;
                        "item ledger entry type"::Output:
                            NoType := 81;
                    end;
                    StatisticAggregate1."Entry Type" := TextType[NoType];
                    StatisticAggregate1.Type := StatisticAggregate1.Type::Item;
                    StatisticAggregate1."No." := "Item No.";
                    StatisticAggregate1."Source Type" := "Source Type";
                    StatisticAggregate1."Source No." := "Source No.";
                    StatisticAggregate1."Location Code" := "Location Code";
                    StatisticAggregate1."Inventory Posting Group" := "Inventory Posting Group";
                    StatisticAggregate1."Source Posting Group" := "Source Posting Group";
                    StatisticAggregate1."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
                    StatisticAggregate1."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                    StatisticAggregate1."Salespers./Purch. Code" := "Salespers./Purch. Code";
                    StatisticAggregate1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                    StatisticAggregate1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                    StatisticAggregate1."Reason Code" := "Reason Code";
                    StatisticAggregate1."Item Charge No." := "Item Charge No.";
                    StatisticAggregate1."Variant Code" := "Variant Code";
                    StatisticAggregate1."Return Reason Code" := "Return Reason Code";
                    case "Item Ledger Entry Type" of
                        "item ledger entry type"::"Positive Adjmt.", "item ledger entry type"::Purchase, "item ledger entry type"::Transfer,
                        "item ledger entry type"::"Negative Adjmt.":
                            begin
                                StatisticAggregate1.Quantity := "Invoiced Quantity";
                                StatisticAggregate1.Amount := "Cost Amount (Actual)";
                                //STOCK
                                //#8877          IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Purchase THEN BEGIN
                                //#8877            StatisticAggregate1.Quantity := "Invoiced Quantity" + "Job Quantity";
                                //#8877            StatisticAggregate1.Amount := "Cost Amount (Actual)" + "Job Cost";
                                //#8877          END;
                                //STOCK//
                            end;
                        "item ledger entry type"::Sale:
                            begin
                                StatisticAggregate1.Quantity := -"Invoiced Quantity";
                                StatisticAggregate1.Amount := +"Sales Amount (Actual)";
                                StatisticAggregate1.Cost := -"Cost Amount (Actual)";
                                StatisticAggregate1."Campaign No." := FindCampaign(Entry);
                            end;
                        "item ledger entry type"::Consumption:
                            begin
                                //#9129
                                //          StatisticAggregate1.Quantity := -"Valued Quantity";
                                StatisticAggregate1.Quantity := -"Item Ledger Entry Quantity";
                                //#9129//
                                StatisticAggregate1.Amount := -"Cost Amount (Actual)";
                            end;
                        "item ledger entry type"::Output:
                            begin
                                StatisticAggregate1.Quantity := "Valued Quantity";
                                StatisticAggregate1.Amount := "Cost Amount (Actual)";
                            end;
                    end;
                    if (SearchDim[NoType]) then begin
                        //GL2024   StatsExplorerTools.SearchLedgerEntryDimension(StatisticAggregate1, 5802, "Entry No.");
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
                until Next = 0;
            end;
        end;
    end;


    procedure FindCampaign(pEntry: Record "Value Entry"): Code[20]
    var
        lSalesInv: Record "Sales Invoice Header";
        lSalesCr: Record "Sales Cr.Memo Header";
        lSalesSh: Record "Sales Shipment Header";
    begin
        if pEntry."Document No." <> '' then begin
            if lSalesSh.Get(pEntry."Document No.") then
                exit(lSalesSh."Campaign No.")
            else
                if lSalesInv.Get(pEntry."Document No.") then
                    exit(lSalesInv."Campaign No.")
                else
                    if lSalesCr.Get(pEntry."Document No.") then
                        exit(lSalesCr."Campaign No.")
                    else
                        exit('');
        end
        else
            exit('');
    end;
}

