Codeunit 8001512 "StatsExplorer, Tools"
{
    //GL2024  ID dans Nav 2009 : "8001312"
    // //STATSEXPLORER STATSEXPLORER 01/01/00 StatsExplorer Tools


    trigger OnRun()
    begin
    end;

    var
        Error1: label 'Impossible to calculate the date of the beginning of period for %1';
        Error2: label 'Impossible to calculate the date of the end of period for %1';
        StatisticsSetup: Record "Statistics setup";
        TextType: Text[30];
        FieldEnabled: array[100, 250] of Boolean;


    procedure StartDateCalc(BasePeriod: Option Day,Week,Month,Quarter,Year,Period; Date: Date) SDate: Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        case BasePeriod of
            Baseperiod::Day:
                SDate := Date;
            Baseperiod::Week:
                SDate := CalcDate('-' + ConvertDateFormula(2), Date);
            Baseperiod::Month:
                SDate := CalcDate('-' + ConvertDateFormula(3), Date);
            Baseperiod::Quarter:
                SDate := CalcDate('-' + ConvertDateFormula(4), Date);
            Baseperiod::Year:
                SDate := CalcDate('-' + ConvertDateFormula(5), Date);
            Baseperiod::Period:
                begin
                    AccountingPeriod.SetRange("Starting Date", 0D, Date);
                    if not AccountingPeriod.IsEmpty then
                        if AccountingPeriod.FindLast then
                            SDate := AccountingPeriod."Starting Date"
                        else
                            Error(Error1, Date);
                end;
        end;
    end;


    procedure EndDateCalc(BasePeriod: Option Day,Week,Month,Quarter,Year,Period; Date: Date) EDate: Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        case BasePeriod of
            Baseperiod::Day:
                EDate := Date;
            Baseperiod::Week:
                EDate := CalcDate('+' + ConvertDateFormula(2), Date);
            Baseperiod::Month:
                EDate := CalcDate('+' + ConvertDateFormula(3), Date);
            Baseperiod::Quarter:
                EDate := CalcDate('+' + ConvertDateFormula(4), Date);
            Baseperiod::Year:
                EDate := CalcDate('+' + ConvertDateFormula(5), Date);
            Baseperiod::Period:
                begin
                    AccountingPeriod.SetFilter("Starting Date", '%1..', Date + 1);
                    if not AccountingPeriod.IsEmpty then
                        if AccountingPeriod.FindFirst then
                            EDate := AccountingPeriod."Starting Date" - 1
                        else
                            Error(Error2, Date);
                end;
        end;
    end;


    procedure ConvertDateFormula(Type: Option Day,WeekDay,Week,Month,Quarter,Year) Result: Text[10]
    var
        TextDay: label 'CD';
        TextWeekDay: label 'CWD';
        TextWeek: label 'CW';
        TextMonth: label 'CM';
        TextQuarter: label 'CQ';
        TextYear: label 'CY';
    begin
        case Type of
            Type::Day:
                Result := TextDay;
            Type::WeekDay:
                Result := TextWeekDay;
            Type::Week:
                Result := TextWeek;
            Type::Month:
                Result := TextMonth;
            Type::Quarter:
                Result := TextQuarter;
            Type::Year:
                Result := TextYear;
        end;
    end;


    procedure CreateTypeArray(var TextType: array[100] of Text[30]; var WorkType: array[100] of Boolean; var SearchDim: array[100] of Boolean; var PeriodBasis: array[100, 6] of Boolean; var LastEntryNo: array[100] of Integer)
    var
        StatisticCriteria: Record "Statistic criteria";
        StatsExplorerFields: Record "StatsExplorer fields";
        i: Integer;
    begin
        with StatisticCriteria do begin
            SetRange(Type, Type::Flow);
            if not IsEmpty then begin
                FindSet;
                repeat
                    TextType["Field No."] := "Field name";
                    WorkType["Field No."] := Enabled;
                    SearchDim["Field No."] := "Process aggregate by dimension";
                    LastEntryNo["Field No."] := StatisticCriteria."Last Entry No";
                    PeriodBasis["Field No.", 1] := "Process aggregate by day";
                    PeriodBasis["Field No.", 2] := "Process aggregate by week";
                    PeriodBasis["Field No.", 3] := "Process aggregate by month";
                    PeriodBasis["Field No.", 4] := "Process aggregate by quarter";
                    PeriodBasis["Field No.", 5] := "Process aggregate by year";
                    PeriodBasis["Field No.", 6] := "Process aggregate by period";
                    i := 0;
                    repeat
                        i := i + 1;
                        FieldEnabled["Field No.", i] := true;
                    until i = 100;
                until Next = 0;
            end;
        end;

        with StatsExplorerFields do begin
            if not IsEmpty then begin
                FindSet;
                repeat
                    CalcFields("Entry No");
                    if ("Entry No" <> 0) and ("Field No" <> 0) then
                        FieldEnabled["Entry No", "Field No"] := StatsExplorerFields.Enabled;
                until Next = 0;
            end;
        end;
    end;

    /*GL2024 Les tables 355, 559 et 361 de NAV 2009 ont été remplacées par d'autres tables dans BC 2024
        procedure SearchLedgerEntryDimension(var StatisticAggregate: Record 8001300; TableNo: Integer; EntryNo: Integer)
        var
            LedgerEntryDimension: Record 355;
        begin
            StatisticsSetup.Get;
            with LedgerEntryDimension do begin
                if StatisticsSetup."Dimension 1 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 1 Code") then
                        StatisticAggregate."Dimension 1 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 2 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 2 Code") then
                        StatisticAggregate."Dimension 2 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 3 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 3 Code") then
                        StatisticAggregate."Dimension 3 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 4 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 4 Code") then
                        StatisticAggregate."Dimension 4 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 5 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 5 Code") then
                        StatisticAggregate."Dimension 5 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 6 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 6 Code") then
                        StatisticAggregate."Dimension 6 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 7 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 7 Code") then
                        StatisticAggregate."Dimension 7 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 8 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 8 Code") then
                        StatisticAggregate."Dimension 8 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 9 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 9 Code") then
                        StatisticAggregate."Dimension 9 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 10 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 10 Code") then
                        StatisticAggregate."Dimension 10 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 11 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 11 Code") then
                        StatisticAggregate."Dimension 11 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 12 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 12 Code") then
                        StatisticAggregate."Dimension 12 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 13 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 13 Code") then
                        StatisticAggregate."Dimension 13 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 14 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 14 Code") then
                        StatisticAggregate."Dimension 14 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 15 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 15 Code") then
                        StatisticAggregate."Dimension 15 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 16 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 16 Code") then
                        StatisticAggregate."Dimension 16 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 17 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 17 Code") then
                        StatisticAggregate."Dimension 17 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 18 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 18 Code") then
                        StatisticAggregate."Dimension 18 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 19 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 19 Code") then
                        StatisticAggregate."Dimension 19 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 20 Code" <> '' then
                    if Get(TableNo, EntryNo, StatisticsSetup."Dimension 20 Code") then
                        StatisticAggregate."Dimension 20 Value Code" := "Dimension Value Code";
            end;
        end;


        procedure SearchGLBudgetDimension(var StatisticAggregate: Record 8001300; EntryNo: Integer)
        var
            GLBudgetDimension: Record 361;
        begin
            StatisticsSetup.Get;
            with GLBudgetDimension do begin
                if StatisticsSetup."Dimension 1 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 1 Code") then
                        StatisticAggregate."Dimension 1 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 2 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 2 Code") then
                        StatisticAggregate."Dimension 2 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 3 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 3 Code") then
                        StatisticAggregate."Dimension 3 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 4 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 4 Code") then
                        StatisticAggregate."Dimension 4 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 5 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 5 Code") then
                        StatisticAggregate."Dimension 5 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 6 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 6 Code") then
                        StatisticAggregate."Dimension 6 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 7 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 7 Code") then
                        StatisticAggregate."Dimension 7 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 8 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 8 Code") then
                        StatisticAggregate."Dimension 8 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 9 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 9 Code") then
                        StatisticAggregate."Dimension 9 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 10 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 10 Code") then
                        StatisticAggregate."Dimension 10 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 11 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 11 Code") then
                        StatisticAggregate."Dimension 11 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 12 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 12 Code") then
                        StatisticAggregate."Dimension 12 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 13 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 13 Code") then
                        StatisticAggregate."Dimension 13 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 14 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 14 Code") then
                        StatisticAggregate."Dimension 14 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 15 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 15 Code") then
                        StatisticAggregate."Dimension 15 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 16 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 16 Code") then
                        StatisticAggregate."Dimension 16 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 17 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 17 Code") then
                        StatisticAggregate."Dimension 17 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 18 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 18 Code") then
                        StatisticAggregate."Dimension 18 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 19 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 19 Code") then
                        StatisticAggregate."Dimension 19 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 20 Code" <> '' then
                    if Get(EntryNo, StatisticsSetup."Dimension 20 Code") then
                        StatisticAggregate."Dimension 20 Value Code" := "Dimension Value Code";
            end;
        end;


        procedure SearchPostedDocumentDimension(var StatisticAggregate: Record 8001300; TableNo: Integer; DocNo: Code[20]; LineNo: Integer)
        var
            PostedDocumentDimension: Record 359;
        begin
            StatisticsSetup.Get;
            with PostedDocumentDimension do begin
                if StatisticsSetup."Dimension 1 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 1 Code") then
                        StatisticAggregate."Dimension 1 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 2 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 2 Code") then
                        StatisticAggregate."Dimension 2 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 3 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 3 Code") then
                        StatisticAggregate."Dimension 3 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 4 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 4 Code") then
                        StatisticAggregate."Dimension 4 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 5 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 5 Code") then
                        StatisticAggregate."Dimension 5 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 6 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 6 Code") then
                        StatisticAggregate."Dimension 6 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 7 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 7 Code") then
                        StatisticAggregate."Dimension 7 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 8 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 8 Code") then
                        StatisticAggregate."Dimension 8 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 9 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 9 Code") then
                        StatisticAggregate."Dimension 9 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 10 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 10 Code") then
                        StatisticAggregate."Dimension 10 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 11 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 11 Code") then
                        StatisticAggregate."Dimension 11 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 12 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 12 Code") then
                        StatisticAggregate."Dimension 12 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 13 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 13 Code") then
                        StatisticAggregate."Dimension 13 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 14 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 14 Code") then
                        StatisticAggregate."Dimension 14 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 15 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 15 Code") then
                        StatisticAggregate."Dimension 15 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 16 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 16 Code") then
                        StatisticAggregate."Dimension 16 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 17 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 17 Code") then
                        StatisticAggregate."Dimension 17 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 18 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 18 Code") then
                        StatisticAggregate."Dimension 18 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 19 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 19 Code") then
                        StatisticAggregate."Dimension 19 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 20 Code" <> '' then
                    if Get(TableNo, DocNo, LineNo, StatisticsSetup."Dimension 20 Code") then
                        StatisticAggregate."Dimension 20 Value Code" := "Dimension Value Code";
            end;
        end;


        procedure SearchDocumentDimension(var StatisticAggregate: Record 8001300; TableNo: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," "; DocNo: Code[20]; LineNo: Integer)
        var
            DocumentDimension: Record 357;
        begin
            StatisticsSetup.Get;
            with DocumentDimension do begin
                if StatisticsSetup."Dimension 1 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 1 Code") then
                        StatisticAggregate."Dimension 1 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 2 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 2 Code") then
                        StatisticAggregate."Dimension 2 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 3 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 3 Code") then
                        StatisticAggregate."Dimension 3 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 4 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 4 Code") then
                        StatisticAggregate."Dimension 4 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 5 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 5 Code") then
                        StatisticAggregate."Dimension 5 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 6 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 6 Code") then
                        StatisticAggregate."Dimension 6 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 7 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 7 Code") then
                        StatisticAggregate."Dimension 7 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 8 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 8 Code") then
                        StatisticAggregate."Dimension 8 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 9 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 9 Code") then
                        StatisticAggregate."Dimension 9 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 10 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 10 Code") then
                        StatisticAggregate."Dimension 10 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 11 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 11 Code") then
                        StatisticAggregate."Dimension 11 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 12 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 12 Code") then
                        StatisticAggregate."Dimension 12 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 13 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 13 Code") then
                        StatisticAggregate."Dimension 13 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 14 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 14 Code") then
                        StatisticAggregate."Dimension 14 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 15 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 15 Code") then
                        StatisticAggregate."Dimension 15 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 16 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 16 Code") then
                        StatisticAggregate."Dimension 16 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 17 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 17 Code") then
                        StatisticAggregate."Dimension 17 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 18 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 18 Code") then
                        StatisticAggregate."Dimension 18 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 19 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 19 Code") then
                        StatisticAggregate."Dimension 19 Value Code" := "Dimension Value Code";
                if StatisticsSetup."Dimension 20 Code" <> '' then
                    if Get(TableNo, DocType, DocNo, LineNo, StatisticsSetup."Dimension 20 Code") then
                        StatisticAggregate."Dimension 20 Value Code" := "Dimension Value Code";
            end;
        end;

    */
    procedure SearchDefaultDimension(var StatisticAggregate: Record "Statistic aggregate"; TableNo: Integer; No: Code[20])
    var
        DefaultDimension: Record "Default Dimension";
    begin
        StatisticsSetup.Get;
        with DefaultDimension do begin
            if StatisticsSetup."Dimension 1 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 1 Code") then
                    StatisticAggregate."Dimension 1 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 2 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 2 Code") then
                    StatisticAggregate."Dimension 2 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 3 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 3 Code") then
                    StatisticAggregate."Dimension 3 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 4 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 4 Code") then
                    StatisticAggregate."Dimension 4 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 5 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 5 Code") then
                    StatisticAggregate."Dimension 5 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 6 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 6 Code") then
                    StatisticAggregate."Dimension 6 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 7 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 7 Code") then
                    StatisticAggregate."Dimension 7 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 8 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 8 Code") then
                    StatisticAggregate."Dimension 8 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 9 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 9 Code") then
                    StatisticAggregate."Dimension 9 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 10 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 10 Code") then
                    StatisticAggregate."Dimension 10 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 11 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 11 Code") then
                    StatisticAggregate."Dimension 11 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 12 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 12 Code") then
                    StatisticAggregate."Dimension 12 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 13 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 13 Code") then
                    StatisticAggregate."Dimension 13 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 14 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 14 Code") then
                    StatisticAggregate."Dimension 14 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 15 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 15 Code") then
                    StatisticAggregate."Dimension 15 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 16 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 16 Code") then
                    StatisticAggregate."Dimension 16 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 17 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 17 Code") then
                    StatisticAggregate."Dimension 17 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 18 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 18 Code") then
                    StatisticAggregate."Dimension 18 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 19 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 19 Code") then
                    StatisticAggregate."Dimension 19 Value Code" := "Dimension Value Code";
            if StatisticsSetup."Dimension 20 Code" <> '' then
                if Get(TableNo, No, StatisticsSetup."Dimension 20 Code") then
                    StatisticAggregate."Dimension 20 Value Code" := "Dimension Value Code";
        end;
    end;


    procedure SearchAndModifyAggregate(var StatisticAggregate: Record "Statistic aggregate"; var StatisticAggregate2: Record "Statistic aggregate"; SearchDimensions: Boolean; NoEntry: Integer) RecordFound: Boolean
    var
        StatsExplorerFields: Record "StatsExplorer fields";
    begin
        StatisticsSetup.Get;
        with StatisticAggregate2 do begin
            InitFields(StatisticAggregate, NoEntry);
            SetCurrentkey("Period Length", "Ending Date", "Entry Type", Type, "No.", "Source Type", "Source No.",
                          "Location Code", "Inventory Posting Group", "Source Posting Group", "Gen. Bus. Posting Group",
                          "Gen. Prod. Posting Group", "Salespers./Purch. Code", "Global Dimension 1 Code",
                          "Global Dimension 2 Code", "Country Code", "Business Unit Code");

            SetRange("Period Length", StatisticAggregate."Period Length");
            SetRange("Ending Date", StatisticAggregate."Ending Date");
            SetRange("Entry Type", StatisticAggregate."Entry Type");
            SetRange(Type, StatisticAggregate.Type);
            SetRange("Source Type", StatisticAggregate."Source Type");

            if FieldEnabled[NoEntry, 6] then
                SetRange("No.", StatisticAggregate."No.");
            if FieldEnabled[NoEntry, 9] then
                SetRange("Source No.", StatisticAggregate."Source No.");
            if FieldEnabled[NoEntry, 11] then
                SetRange("Location Code", StatisticAggregate."Location Code");
            if FieldEnabled[NoEntry, 12] then
                SetRange("Inventory Posting Group", StatisticAggregate."Inventory Posting Group");
            if FieldEnabled[NoEntry, 13] then
                SetRange("Source Posting Group", StatisticAggregate."Source Posting Group");
            if FieldEnabled[NoEntry, 14] then
                SetRange("Gen. Bus. Posting Group", StatisticAggregate."Gen. Bus. Posting Group");
            if FieldEnabled[NoEntry, 15] then
                SetRange("Gen. Prod. Posting Group", StatisticAggregate."Gen. Prod. Posting Group");
            if FieldEnabled[NoEntry, 16] then
                SetRange("Salespers./Purch. Code", StatisticAggregate."Salespers./Purch. Code");
            if FieldEnabled[NoEntry, 17] then
                SetRange("Global Dimension 1 Code", StatisticAggregate."Global Dimension 1 Code");
            if FieldEnabled[NoEntry, 18] then
                SetRange("Global Dimension 2 Code", StatisticAggregate."Global Dimension 2 Code");
            if FieldEnabled[NoEntry, 37] then
                SetRange("Business Unit Code", StatisticAggregate."Business Unit Code");
            if FieldEnabled[NoEntry, 40] then
                SetRange("Job No.", StatisticAggregate."Job No.");
            if FieldEnabled[NoEntry, 44] then
                SetRange("Work Type Code", StatisticAggregate."Work Type Code");
            if FieldEnabled[NoEntry, 45] then
                SetRange("Reason Code", StatisticAggregate."Reason Code");
            if FieldEnabled[NoEntry, 46] then
                SetRange("Job Posting Group", StatisticAggregate."Job Posting Group");
            if FieldEnabled[NoEntry, 47] then
                SetRange("Resource Group No.", StatisticAggregate."Resource Group No.");
            if FieldEnabled[NoEntry, 48] then
                SetRange("Person Responsible", StatisticAggregate."Person Responsible");
            if FieldEnabled[NoEntry, 57] then
                SetRange("Campaign No.", StatisticAggregate."Campaign No.");
            if FieldEnabled[NoEntry, 50] then
                SetRange("Item Charge No.", StatisticAggregate."Item Charge No.");
            if FieldEnabled[NoEntry, 51] then
                SetRange("Variant Code", StatisticAggregate."Variant Code");
            if FieldEnabled[NoEntry, 52] then
                SetRange("Return Reason Code", StatisticAggregate."Return Reason Code");
            if FieldEnabled[NoEntry, 59] then
                SetRange("Back disc./commission rule No.", StatisticAggregate."Back disc./commission rule No.");

            if FieldEnabled[NoEntry, 80] and
               (StatisticsSetup."Free field name 1" <> '') then
                SetRange("Free field 1", StatisticAggregate."Free field 1");
            if FieldEnabled[NoEntry, 81] and
               (StatisticsSetup."Free field name 2" <> '') then
                SetRange("Free field 2", StatisticAggregate."Free field 2");
            if FieldEnabled[NoEntry, 82] and
               (StatisticsSetup."Free field name 3" <> '') then
                SetRange("Free field 3", StatisticAggregate."Free field 3");
            if FieldEnabled[NoEntry, 83] and
               (StatisticsSetup."Free field name 4" <> '') then
                SetRange("Free field 4", StatisticAggregate."Free field 4");
            if FieldEnabled[NoEntry, 84] and
               (StatisticsSetup."Free field name 5" <> '') then
                SetRange("Free field 5", StatisticAggregate."Free field 5");
            if FieldEnabled[NoEntry, 85] and
               (StatisticsSetup."Free field name 6" <> '') then
                SetRange("Free field 6", StatisticAggregate."Free field 6");
            if FieldEnabled[NoEntry, 86] and
               (StatisticsSetup."Free field name 7" <> '') then
                SetRange("Free field 7", StatisticAggregate."Free field 7");
            if FieldEnabled[NoEntry, 87] and
               (StatisticsSetup."Free field name 8" <> '') then
                SetRange("Free field 8", StatisticAggregate."Free field 8");
            if FieldEnabled[NoEntry, 88] and
               (StatisticsSetup."Free field name 9" <> '') then
                SetRange("Free field 9", StatisticAggregate."Free field 9");
            if FieldEnabled[NoEntry, 89] and
               (StatisticsSetup."Free field name 10" <> '') then
                SetRange("Free field 10", StatisticAggregate."Free field 10");

            if FieldEnabled[NoEntry, 90] and
               (StatisticsSetup."Free date name 1" <> '') then
                SetRange("Free date 1", StatisticAggregate."Free date 1");
            if FieldEnabled[NoEntry, 91] and
               (StatisticsSetup."Free date name 2" <> '') then
                SetRange("Free date 2", StatisticAggregate."Free date 2");
            if FieldEnabled[NoEntry, 92] and
               (StatisticsSetup."Free date name 3" <> '') then
                SetRange("Free date 3", StatisticAggregate."Free date 3");
            if FieldEnabled[NoEntry, 93] and
               (StatisticsSetup."Free date name 4" <> '') then
                SetRange("Free date 4", StatisticAggregate."Free date 4");
            if FieldEnabled[NoEntry, 94] and
               (StatisticsSetup."Free date name 5" <> '') then
                SetRange("Free date 5", StatisticAggregate."Free date 5");

            if FieldEnabled[NoEntry, 95] and
               (StatisticsSetup."Free check name 1" <> '') then
                SetRange("Free boolean 1", StatisticAggregate."Free boolean 1");
            if FieldEnabled[NoEntry, 96] and
               (StatisticsSetup."Free check name 2" <> '') then
                SetRange("Free boolean 2", StatisticAggregate."Free boolean 2");
            if FieldEnabled[NoEntry, 97] and
               (StatisticsSetup."Free check name 3" <> '') then
                SetRange("Free boolean 3", StatisticAggregate."Free boolean 3");
            if FieldEnabled[NoEntry, 98] and
               (StatisticsSetup."Free check name 4" <> '') then
                SetRange("Free boolean 4", StatisticAggregate."Free boolean 4");
            if FieldEnabled[NoEntry, 99] and
               (StatisticsSetup."Free check name 5" <> '') then
                SetRange("Free boolean 5", StatisticAggregate."Free boolean 5");

            if SearchDimensions then begin
                if FieldEnabled[NoEntry, 201] and
                   (StatisticsSetup."Dimension 1 Code" <> '') then
                    SetRange("Dimension 1 Value Code", StatisticAggregate."Dimension 1 Value Code");
                if FieldEnabled[NoEntry, 202] and
                   (StatisticsSetup."Dimension 2 Code" <> '') then
                    SetRange("Dimension 2 Value Code", StatisticAggregate."Dimension 2 Value Code");
                if FieldEnabled[NoEntry, 203] and
                   (StatisticsSetup."Dimension 3 Code" <> '') then
                    SetRange("Dimension 3 Value Code", StatisticAggregate."Dimension 3 Value Code");
                if FieldEnabled[NoEntry, 204] and
                   (StatisticsSetup."Dimension 4 Code" <> '') then
                    SetRange("Dimension 4 Value Code", StatisticAggregate."Dimension 4 Value Code");
                if FieldEnabled[NoEntry, 205] and
                   (StatisticsSetup."Dimension 5 Code" <> '') then
                    SetRange("Dimension 5 Value Code", StatisticAggregate."Dimension 5 Value Code");
                if FieldEnabled[NoEntry, 206] and
                   (StatisticsSetup."Dimension 6 Code" <> '') then
                    SetRange("Dimension 6 Value Code", StatisticAggregate."Dimension 6 Value Code");
                if FieldEnabled[NoEntry, 207] and
                   (StatisticsSetup."Dimension 7 Code" <> '') then
                    SetRange("Dimension 7 Value Code", StatisticAggregate."Dimension 7 Value Code");
                if FieldEnabled[NoEntry, 208] and
                   (StatisticsSetup."Dimension 8 Code" <> '') then
                    SetRange("Dimension 8 Value Code", StatisticAggregate."Dimension 8 Value Code");
                if FieldEnabled[NoEntry, 209] and
                   (StatisticsSetup."Dimension 9 Code" <> '') then
                    SetRange("Dimension 9 Value Code", StatisticAggregate."Dimension 9 Value Code");
                if FieldEnabled[NoEntry, 210] and
                   (StatisticsSetup."Dimension 10 Code" <> '') then
                    SetRange("Dimension 10 Value Code", StatisticAggregate."Dimension 10 Value Code");
                if FieldEnabled[NoEntry, 211] and
                   (StatisticsSetup."Dimension 11 Code" <> '') then
                    SetRange("Dimension 11 Value Code", StatisticAggregate."Dimension 11 Value Code");
                if FieldEnabled[NoEntry, 212] and
                   (StatisticsSetup."Dimension 12 Code" <> '') then
                    SetRange("Dimension 12 Value Code", StatisticAggregate."Dimension 12 Value Code");
                if FieldEnabled[NoEntry, 213] and
                   (StatisticsSetup."Dimension 13 Code" <> '') then
                    SetRange("Dimension 13 Value Code", StatisticAggregate."Dimension 13 Value Code");
                if FieldEnabled[NoEntry, 214] and
                   (StatisticsSetup."Dimension 14 Code" <> '') then
                    SetRange("Dimension 14 Value Code", StatisticAggregate."Dimension 14 Value Code");
                if FieldEnabled[NoEntry, 215] and
                   (StatisticsSetup."Dimension 15 Code" <> '') then
                    SetRange("Dimension 15 Value Code", StatisticAggregate."Dimension 15 Value Code");
                if FieldEnabled[NoEntry, 216] and
                   (StatisticsSetup."Dimension 16 Code" <> '') then
                    SetRange("Dimension 16 Value Code", StatisticAggregate."Dimension 16 Value Code");
                if FieldEnabled[NoEntry, 217] and
                   (StatisticsSetup."Dimension 17 Code" <> '') then
                    SetRange("Dimension 17 Value Code", StatisticAggregate."Dimension 17 Value Code");
                if FieldEnabled[NoEntry, 218] and
                   (StatisticsSetup."Dimension 18 Code" <> '') then
                    SetRange("Dimension 18 Value Code", StatisticAggregate."Dimension 18 Value Code");
                if FieldEnabled[NoEntry, 219] and
                   (StatisticsSetup."Dimension 19 Code" <> '') then
                    SetRange("Dimension 19 Value Code", StatisticAggregate."Dimension 19 Value Code");
                if FieldEnabled[NoEntry, 220] and
                   (StatisticsSetup."Dimension 20 Code" <> '') then
                    SetRange("Dimension 20 Value Code", StatisticAggregate."Dimension 20 Value Code");
            end;
            if not IsEmpty then begin
                FindFirst;
                Quantity := Quantity + StatisticAggregate.Quantity;
                Volume := Volume + StatisticAggregate.Volume;
                Amount := Amount + StatisticAggregate.Amount;
                Cost := Cost + StatisticAggregate.Cost;
                "Free value 1" := "Free value 1" + StatisticAggregate."Free value 1";
                "Free value 2" := "Free value 2" + StatisticAggregate."Free value 2";
                "Free value 3" := "Free value 3" + StatisticAggregate."Free value 3";
                "Free value 4" := "Free value 4" + StatisticAggregate."Free value 4";
                "Free value 5" := "Free value 5" + StatisticAggregate."Free value 5";
                "Free value 6" := "Free value 6" + StatisticAggregate."Free value 6";
                "Free value 7" := "Free value 7" + StatisticAggregate."Free value 7";
                "Free value 8" := "Free value 8" + StatisticAggregate."Free value 8";
                "Free value 9" := "Free value 9" + StatisticAggregate."Free value 9";
                "Free value 10" := "Free value 10" + StatisticAggregate."Free value 10";
                if (Quantity = 0) and (Volume = 0) and (Amount = 0) and (Cost = 0) and ("Free value 1" = 0) and ("Free value 2" = 0) and
                   ("Free value 3" = 0) and ("Free value 4" = 0) and ("Free value 5" = 0) and ("Free value 6" = 0) and
                   ("Free value 7" = 0) and ("Free value 8" = 0) and ("Free value 9" = 0) and ("Free value 10" = 0) then
                    Delete
                else
                    Modify;
                RecordFound := true;
            end else
                RecordFound := false;
        end;
    end;


    procedure SelectSheetsName(FileName: Text[250]): Text[250]
    var
        i: Integer;
        SheetName: Text[250];
        EndOfLoop: Integer;
        SheetsList: Text[250];
        OptionNo: Integer;
        Text000: label 'Excel not found.';
        Text002: label 'La feuille Excel %1 n''existe pas.';
        Text003: label 'The file %1 doesn''t exist.';
    //GL2024 Automation non compatible  xlApp: Automation;
    //GL2024 Automation non compatible  xlBook: Automation;
    //GL2024 Automation non compatible   xlSheet: Automation;
    begin
        /*//GL2024 License if FileName <> '' then begin
             if not Exists(FileName) then
                 Error(Text003, FileName);
         end else
             exit('');*///GL2024 License

        /*  //GL2024 Automation non compatible 

        if not Create(xlApp, true) then
               Error(Text000);
           xlApp.Workbooks._Open(FileName);
           xlBook := xlApp.ActiveWorkbook;
           i := 1;
           EndOfLoop := xlBook.Worksheets.Count;
           while i <= EndOfLoop do begin
               xlSheet := xlBook.Worksheets.Item(i);
               SheetName := xlSheet.Name;
               if (SheetName <> '') and (StrLen(SheetsList) + StrLen(SheetName) < 250) then
                   SheetsList := SheetsList + SheetName + ','
               else
                   i := EndOfLoop;
               i := i + 1;
           end;
           xlBook.Close(false);
           xlApp.Quit;
           Clear(xlApp);*/
        OptionNo := StrMenu(SheetsList, 1);
        if OptionNo <> 0 then
            exit(SelectStr(OptionNo, SheetsList))
        else
            exit('');
    end;


    procedure InitFields(var StatisticAggregate: Record "Statistic aggregate"; NoEntry: Integer)
    var
        StatsExplorerFields: Record "StatsExplorer fields";
        StatisticsSetup: Record "Statistics setup";
    begin
        StatisticsSetup.Get;
        with StatisticAggregate do begin
            if not FieldEnabled[NoEntry, 6] then
                "No." := '';
            if not FieldEnabled[NoEntry, 9] then
                "Source No." := '';
            if not FieldEnabled[NoEntry, 11] then
                "Location Code" := '';
            if not FieldEnabled[NoEntry, 12] then
                "Inventory Posting Group" := '';
            if not FieldEnabled[NoEntry, 13] then
                "Source Posting Group" := '';
            if not FieldEnabled[NoEntry, 14] then
                "Gen. Bus. Posting Group" := '';
            if not FieldEnabled[NoEntry, 15] then
                "Gen. Prod. Posting Group" := '';
            if not FieldEnabled[NoEntry, 16] then
                "Salespers./Purch. Code" := '';
            if not FieldEnabled[NoEntry, 17] then
                "Global Dimension 1 Code" := '';
            if not FieldEnabled[NoEntry, 18] then
                "Global Dimension 2 Code" := '';
            if not FieldEnabled[NoEntry, 37] then
                "Business Unit Code" := '';
            if not FieldEnabled[NoEntry, 40] then
                "Job No." := '';
            if not FieldEnabled[NoEntry, 44] then
                "Work Type Code" := '';
            if not FieldEnabled[NoEntry, 45] then
                "Reason Code" := '';
            if not FieldEnabled[NoEntry, 46] then
                "Job Posting Group" := '';
            if not FieldEnabled[NoEntry, 47] then
                "Resource Group No." := '';
            if not FieldEnabled[NoEntry, 48] then
                "Person Responsible" := '';
            if not FieldEnabled[NoEntry, 49] then
                "Campaign No." := '';
            if not FieldEnabled[NoEntry, 50] then
                "Item Charge No." := '';
            if not FieldEnabled[NoEntry, 51] then
                "Variant Code" := '';
            if not FieldEnabled[NoEntry, 52] then
                "Return Reason Code" := '';
            if not FieldEnabled[NoEntry, 59] then
                "Back disc./commission rule No." := '';

            if not FieldEnabled[NoEntry, 80] and
               (StatisticsSetup."Free field name 1" <> '') then
                "Free field 1" := '';
            if not FieldEnabled[NoEntry, 81] and
               (StatisticsSetup."Free field name 2" <> '') then
                "Free field 2" := '';
            if not FieldEnabled[NoEntry, 82] and
               (StatisticsSetup."Free field name 3" <> '') then
                "Free field 3" := '';
            if not FieldEnabled[NoEntry, 83] and
               (StatisticsSetup."Free field name 4" <> '') then
                "Free field 4" := '';
            if not FieldEnabled[NoEntry, 84] and
               (StatisticsSetup."Free field name 5" <> '') then
                "Free field 5" := '';
            if not FieldEnabled[NoEntry, 85] and
               (StatisticsSetup."Free field name 6" <> '') then
                "Free field 6" := '';
            if not FieldEnabled[NoEntry, 86] and
               (StatisticsSetup."Free field name 7" <> '') then
                "Free field 7" := '';
            if not FieldEnabled[NoEntry, 87] and
               (StatisticsSetup."Free field name 8" <> '') then
                "Free field 8" := '';
            if not FieldEnabled[NoEntry, 88] and
               (StatisticsSetup."Free field name 9" <> '') then
                "Free field 9" := '';
            if not FieldEnabled[NoEntry, 89] and
               (StatisticsSetup."Free field name 10" <> '') then
                "Free field 10" := '';
            if not FieldEnabled[NoEntry, 90] and
               (StatisticsSetup."Free date name 1" <> '') then
                "Free date 1" := 0D;
            if not FieldEnabled[NoEntry, 91] and
               (StatisticsSetup."Free date name 2" <> '') then
                "Free date 2" := 0D;
            if not FieldEnabled[NoEntry, 92] and
               (StatisticsSetup."Free date name 3" <> '') then
                "Free date 3" := 0D;
            if not FieldEnabled[NoEntry, 93] and
               (StatisticsSetup."Free date name 4" <> '') then
                "Free date 4" := 0D;
            if not FieldEnabled[NoEntry, 94] and
               (StatisticsSetup."Free date name 5" <> '') then
                "Free date 5" := 0D;
            if not FieldEnabled[NoEntry, 95] and
               (StatisticsSetup."Free check name 1" <> '') then
                "Free boolean 1" := false;
            if not FieldEnabled[NoEntry, 96] and
               (StatisticsSetup."Free check name 2" <> '') then
                "Free boolean 2" := false;
            if not FieldEnabled[NoEntry, 97] and
               (StatisticsSetup."Free check name 3" <> '') then
                "Free boolean 3" := false;
            if not FieldEnabled[NoEntry, 98] and
               (StatisticsSetup."Free check name 4" <> '') then
                "Free boolean 4" := false;
            if not FieldEnabled[NoEntry, 99] and
               (StatisticsSetup."Free check name 5" <> '') then
                "Free boolean 5" := false;

            if not FieldEnabled[NoEntry, 201] and
               (StatisticsSetup."Dimension 1 Code" <> '') then
                "Dimension 1 Value Code" := '';
            if not FieldEnabled[NoEntry, 202] and
               (StatisticsSetup."Dimension 2 Code" <> '') then
                "Dimension 2 Value Code" := '';
            if not FieldEnabled[NoEntry, 203] and
               (StatisticsSetup."Dimension 3 Code" <> '') then
                "Dimension 3 Value Code" := '';
            if not FieldEnabled[NoEntry, 204] and
               (StatisticsSetup."Dimension 4 Code" <> '') then
                "Dimension 4 Value Code" := '';
            if not FieldEnabled[NoEntry, 205] and
               (StatisticsSetup."Dimension 5 Code" <> '') then
                "Dimension 5 Value Code" := '';
            if not FieldEnabled[NoEntry, 206] and
               (StatisticsSetup."Dimension 6 Code" <> '') then
                "Dimension 6 Value Code" := '';
            if not FieldEnabled[NoEntry, 207] and
               (StatisticsSetup."Dimension 7 Code" <> '') then
                "Dimension 7 Value Code" := '';
            if not FieldEnabled[NoEntry, 208] and
               (StatisticsSetup."Dimension 8 Code" <> '') then
                "Dimension 8 Value Code" := '';
            if not FieldEnabled[NoEntry, 209] and
               (StatisticsSetup."Dimension 9 Code" <> '') then
                "Dimension 9 Value Code" := '';
            if not FieldEnabled[NoEntry, 210] and
               (StatisticsSetup."Dimension 10 Code" <> '') then
                "Dimension 10 Value Code" := '';
            if not FieldEnabled[NoEntry, 211] and
               (StatisticsSetup."Dimension 11 Code" <> '') then
                "Dimension 11 Value Code" := '';
            if not FieldEnabled[NoEntry, 212] and
               (StatisticsSetup."Dimension 12 Code" <> '') then
                "Dimension 12 Value Code" := '';
            if not FieldEnabled[NoEntry, 213] and
               (StatisticsSetup."Dimension 13 Code" <> '') then
                "Dimension 13 Value Code" := '';
            if not FieldEnabled[NoEntry, 214] and
               (StatisticsSetup."Dimension 14 Code" <> '') then
                "Dimension 14 Value Code" := '';
            if not FieldEnabled[NoEntry, 215] and
               (StatisticsSetup."Dimension 15 Code" <> '') then
                "Dimension 15 Value Code" := '';
            if not FieldEnabled[NoEntry, 216] and
               (StatisticsSetup."Dimension 16 Code" <> '') then
                "Dimension 16 Value Code" := '';
            if not FieldEnabled[NoEntry, 217] and
               (StatisticsSetup."Dimension 17 Code" <> '') then
                "Dimension 17 Value Code" := '';
            if not FieldEnabled[NoEntry, 218] and
               (StatisticsSetup."Dimension 18 Code" <> '') then
                "Dimension 18 Value Code" := '';
            if not FieldEnabled[NoEntry, 219] and
               (StatisticsSetup."Dimension 19 Code" <> '') then
                "Dimension 19 Value Code" := '';
            if not FieldEnabled[NoEntry, 220] and
               (StatisticsSetup."Dimension 20 Code" <> '') then
                "Dimension 20 Value Code" := '';
        end;
    end;


    procedure GetTranslateCaption(pFieldNo: Integer; pCaptiontype: Integer; var pValue: Text[255])
    var
        CaptionClassTranslat: Record "CaptionClass Translation";
        lRange: Integer;
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        case pFieldNo of
            51 .. 60:
                lRange := 99000;
            60 .. 69:
                lRange := 98970;
            70 .. 79:
                lRange := 98933;
            80 .. 89:
                lRange := 98961;
            90 .. 94:
                lRange := 98971;
            95 .. 99:
                lRange := 98976;
            201 .. 220:
                begin
                    pValue := GetDimCaption(pFieldNo - 200);
                    exit;
                end;
            300 .. 309:
                lRange := 98790;
            else
                exit;
        end;
        if CaptionClassTranslat.Exists(8001302, lRange + pFieldNo, GlobalLanguage) then
            pValue := CaptionClassTranslat.GetCaptionClass(GlobalLanguage,
                    StrSubstNo('%1,8001302,%2', pCaptiontype, lRange + pFieldNo))
        else begin
            lRecRef.Open(Database::"Statistics setup");
            lRecRef.Find('-');
            lFieldRef := lRecRef.Field(lRange + pFieldNo);
            if Format(lFieldRef.Value) <> '' then
                pValue := Format(lFieldRef.Value);
        end;
    end;


    procedure GetDimCaption(AnalysisViewDimType: Integer): Text[250]
    var
        Text001: label 'Dimension 1 Value Code';
        Text002: label 'Dimension 2 Value Code';
        Text003: label 'Dimension 3 Value Code';
        Text004: label 'Dimension 4 Value Code';
        Text005: label 'Dimension 5 Value Code';
        Text006: label 'Dimension 6 Value Code';
        Text007: label 'Dimension 7 Value Code';
        Text008: label 'Dimension 8 Value Code';
        Text009: label 'Dimension 9 Value Code';
        Text010: label 'Dimension 10 Value Code';
        Text011: label 'Dimension 11 Value Code';
        Text012: label 'Dimension 12 Value Code';
        Text013: label 'Dimension 13 Value Code';
        Text014: label 'Dimension 14 Value Code';
        Text015: label 'Dimension 15 Value Code';
        Text016: label 'Dimension 16 Value Code';
        Text017: label 'Dimension 17 Value Code';
        Text018: label 'Dimension 18 Value Code';
        Text019: label 'Dimension 19 Value Code';
        Text020: label 'Dimension 20 Value Code';
    begin
        if not StatisticsSetup.Get then
            exit;
        with StatisticsSetup do
            case AnalysisViewDimType of
                1:
                    if "Dimension 1 Code" <> '' then
                        exit('Code ' + "Dimension 1 Code")
                    else
                        exit(Text001);
                2:
                    if "Dimension 2 Code" <> '' then
                        exit('Code ' + "Dimension 2 Code")
                    else
                        exit(Text002);
                3:
                    if "Dimension 3 Code" <> '' then
                        exit('Code ' + "Dimension 3 Code")
                    else
                        exit(Text003);
                4:
                    if "Dimension 4 Code" <> '' then
                        exit('Code ' + "Dimension 4 Code")
                    else
                        exit(Text004);
                5:
                    if "Dimension 5 Code" <> '' then
                        exit('Code ' + "Dimension 5 Code")
                    else
                        exit(Text005);
                6:
                    if "Dimension 6 Code" <> '' then
                        exit('Code ' + "Dimension 6 Code")
                    else
                        exit(Text006);
                7:
                    if "Dimension 7 Code" <> '' then
                        exit('Code ' + "Dimension 7 Code")
                    else
                        exit(Text007);
                8:
                    if "Dimension 8 Code" <> '' then
                        exit('Code ' + "Dimension 8 Code")
                    else
                        exit(Text008);
                9:
                    if "Dimension 9 Code" <> '' then
                        exit('Code ' + "Dimension 9 Code")
                    else
                        exit(Text009);
                10:
                    if "Dimension 10 Code" <> '' then
                        exit('Code ' + "Dimension 10 Code")
                    else
                        exit(Text010);
                11:
                    if "Dimension 11 Code" <> '' then
                        exit('Code ' + "Dimension 11 Code")
                    else
                        exit(Text011);
                12:
                    if "Dimension 12 Code" <> '' then
                        exit('Code ' + "Dimension 12 Code")
                    else
                        exit(Text012);
                13:
                    if "Dimension 13 Code" <> '' then
                        exit('Code ' + "Dimension 13 Code")
                    else
                        exit(Text013);
                14:
                    if "Dimension 14 Code" <> '' then
                        exit('Code ' + "Dimension 14 Code")
                    else
                        exit(Text014);
                15:
                    if "Dimension 15 Code" <> '' then
                        exit('Code ' + "Dimension 15 Code")
                    else
                        exit(Text015);
                16:
                    if "Dimension 16 Code" <> '' then
                        exit('Code ' + "Dimension 16 Code")
                    else
                        exit(Text016);
                17:
                    if "Dimension 17 Code" <> '' then
                        exit('Code ' + "Dimension 17 Code")
                    else
                        exit(Text017);
                18:
                    if "Dimension 18 Code" <> '' then
                        exit('Code ' + "Dimension 18 Code")
                    else
                        exit(Text018);
                19:
                    if "Dimension 19 Code" <> '' then
                        exit('Code ' + "Dimension 19 Code")
                    else
                        exit(Text019);
                20:
                    if "Dimension 20 Code" <> '' then
                        exit('Code ' + "Dimension 20 Code")
                    else
                        exit(Text020);
            end;
    end;


    procedure GetStatCriterFieldNo(pType: Option; pFieldName: Text[100]): Integer
    var
        lStatCriter: Record "Statistic criteria";
    begin
        if lStatCriter.Get(pType, pFieldName) then
            exit(lStatCriter."Field No.");
        exit(0);
    end;
}

