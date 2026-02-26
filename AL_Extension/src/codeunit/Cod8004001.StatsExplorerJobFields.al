Codeunit 8004001 "StatsExplorer Job Fields"
{
    // //STATS_NAVIBAT STATSEXPLORER 05/07/02 Search Job Fields for Navibat

    TableNo = "Statistic aggregate";

    trigger OnRun()
    var
        lFormule: Text[30];
        lStatSetup: Record "Statistics setup";
    begin
        lStatSetup.Get;
        if Job.Get(rec."Job No.") then begin
            //   "Free field 1" := FORMAT(Job.Status);                          //A paramétrer dans les champs libres
            //   UpdateDefaultValues.CreateCodeAndDescription(8001300,1001,FORMAT(Job.Status),FORMAT(Job.Status));
            //   "Free date 1" := Job."Starting Date";
            //   "Free date 2" := Job."Ending Date";
            //   "Free boolean 1" := Job.Blocked;
            case rec."Period Length" of
                rec."period length"::Day:
                    lFormule := '<0D>';
                rec."period length"::Week:
                    lFormule := '<-CW>';
                rec."period length"::Month:
                    lFormule := '<-CM>';
                rec."period length"::Quarter:
                    lFormule := '<-CQ>';
                rec."period length"::Year:
                    lFormule := '<-CY>';
                rec."period length"::Period:
                    lFormule := '<-CM>';
                else
                    ;
            end;
            Job.SetRange("Posting Date Filter", CalcDate(lFormule, rec."Ending Date"), rec."Ending Date");
            Job.CalcFields("Posted In Period");
            if lStatSetup."Free check no 1" = '8004060.8003924' then
                rec."Free boolean 1" := Job."Posted In Period";
            if lStatSetup."Free check no 2" = '8004060.8003924' then
                rec."Free boolean 2" := Job."Posted In Period";
            if lStatSetup."Free check no 3" = '8004060.8003924' then
                rec."Free boolean 3" := Job."Posted In Period";
            if lStatSetup."Free check no 4" = '8004060.8003924' then
                rec."Free boolean 4" := Job."Posted In Period";
            if lStatSetup."Free check no 5" = '8004060.8003924' then
                rec."Free boolean 5" := Job."Posted In Period";
        end;
    end;

    var
        Job: Record Job;
        UpdateDefaultValues: Codeunit "Aggr., Update default values";
}

