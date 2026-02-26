Codeunit 8001517 "Aggregate, Item Availability"
{
    //GL2024  ID dans Nav 2009 : "8001317"
    // #6572 SD 25/03/10
    // //STATSEXPLORER STATSEXPLORER 01/01/00 Calcul de la table de cumuls statistiques, situation du stock par article et magasin


    trigger OnRun()
    begin
        StatsExplorerTools.CreateTypeArray(TextType, WorkType, SearchDim, PeriodBasis, LastEntryNo);

        //#6572
        if GuiAllowed then begin
            //#6572//
            Window.Open('#1##############################\\' +
                        Text002 +
                        Text003 +
                        Text004 +
                        Text005 +
                        Text006);
            Window.Update(1, TextType[39]);
            //#6572
        end;
        //#6572//

        StatisticAggregate1.Reset;
        if not StatisticAggregate1.IsEmpty then
            if StatisticAggregate1.FindLast then
                NextEntry := StatisticAggregate1."Entry No." + 1
            else
                NextEntry := 1;

        Ecart := 0;
        DateF1 := StartDate;
        //BasePeriod := 2;

        repeat
            if BasePeriod = 0 then
                FormuleCalc := StrSubstNo('+%1%2', Ecart, CopyStr(StatsExplorerTools.ConvertDateFormula(BasePeriod), 2, 1))
            else
                FormuleCalc := StrSubstNo('+%1%2', Ecart, CopyStr(StatsExplorerTools.ConvertDateFormula(BasePeriod + 1), 2, 1));
            if Ecart > 0 then
                DateF1 := CalcDate(FormuleCalc, StartDate);
            Ecart := Ecart + 1;
            DateD1 := StatsExplorerTools.StartDateCalc(BasePeriod, DateF1);
            DateF1 := StatsExplorerTools.EndDateCalc(BasePeriod, DateF1);
            //#6572
            if GuiAllowed then
                //#6572//
                Window.Update(2, DateF1);
            if not Magasin.IsEmpty then begin
                Magasin.FindFirst;
                repeat
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(3, Magasin.Code);
                    RechercheEcr;
                until Magasin.Next = 0;
            end;
        until DateF1 = EndDate;

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
        Entry: Record Item;
        Magasin: Record Location;
        "Code": Record Code;
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
        Window: Dialog;
        StartDate: Date;
        EndDate: Date;
        PeriodBasis: array[100, 6] of Boolean;
        BasePeriod: Option Jour,Semaine,Mois,Trimestre,"Année";
        TextType: array[100] of Text[30];
        WorkType: array[100] of Boolean;
        SearchDim: array[100] of Boolean;
        FieldEnabled: array[100, 250] of Boolean;
        NextEntry: Integer;
        NbRead: Integer;
        NbCreated: Integer;
        FiltreType: Text[250];
        Ecart: Integer;
        DateF1: Date;
        DateD1: Date;
        StatsExplorerTools: Codeunit "StatsExplorer, Tools";
        FormuleCalc: Text[30];
        LastEntryNo: array[100] of Integer;
        Text002: label 'End Date:                #2#####\';
        Text003: label 'Location:                #3#####\';
        Text004: label 'Item:                    #4#####\';
        Text005: label 'Read:                    #5#####\';
        Text006: label 'Created:                 #6#####\';


    procedure InitRequete(wStartDate: Date; wEndDate: Date; wBasePeriod: Option Day,Week,Month,Quarter,Year,Period)
    begin
        StartDate := wStartDate;
        EndDate := wEndDate;
        BasePeriod := wBasePeriod;
    end;


    procedure InitEntry()
    begin
        Entry.Reset;
    end;


    procedure RechercheEcr()
    var
        ArretTraitement: Boolean;
        DateD: Date;
        DateF: Date;
        i: Integer;
    begin
        ArretTraitement := false;
        with Entry do begin
            InitEntry;
            if not IsEmpty then begin
                FindSet;
                repeat
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(4, "No.");
                    NbRead := NbRead + 1;
                    //#6572
                    if GuiAllowed then
                        //#6572//
                        Window.Update(5, NbRead);
                    SetRange("Location Filter", Magasin.Code);
                    DateF := DateF1;
                    SetRange("Date Filter", DateD1, DateF1);
                    CalcFields("Net Change");
                    if "Net Change" <> 0 then begin
                        StatisticAggregate1.Init;
                        StatisticAggregate1."Entry No." := NextEntry;
                        StatisticAggregate1."Period Length" := BasePeriod;
                        StatisticAggregate1."Ending Date" := DateF;
                        StatisticAggregate1."Entry Type" := TextType[39];
                        StatisticAggregate1.Type := StatisticAggregate1.Type::Item;
                        StatisticAggregate1."No." := "No.";
                        StatisticAggregate1."Location Code" := Magasin.Code;
                        StatisticAggregate1.Quantity := "Net Change";
                        StatisticAggregate1.Amount := ROUND("Net Change" * "Unit Price");
                        StatisticAggregate1.Cost := ROUND("Net Change" * Entry."Unit Cost");
                        UpdateDefaultValues.Run(StatisticAggregate1);
                        if not StatsExplorerTools.SearchAndModifyAggregate(StatisticAggregate1, StatisticAggregate2, SearchDim[39], 39) then begin
                            StatisticAggregate1.Insert;
                            NextEntry := NextEntry + 1;
                            NbCreated := NbCreated + 1;
                        end;
                        //#6572
                        if GuiAllowed then
                            //#6572//
                            Window.Update(6, NbCreated);
                    end;
                    InitEntry;
                    if not Find('>') then
                        ArretTraitement := true;
                until ArretTraitement = true;
            end;
        end;
    end;
}

