Table 8001509 "Statistic criteria"
{
    //GL2024  ID dans Nav 2009 : "8001301"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Sort criteria,Flow,Value - Be careful : System Table

    Caption = 'Statistic criteria';
    //LookupPageID = 8001301;

    fields
    {
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Sort criteria,Flow,Value';
            OptionMembers = "Sort criteria",Flow,Value;
        }
        field(4; "Field No."; Integer)
        {
            Caption = 'Field No.';
            MaxValue = 250;
            MinValue = 0;
        }
        field(5; "Field name"; Text[30])
        {
            Caption = 'Field name';
        }
        field(6; Length; Integer)
        {
            Caption = 'Length';
        }
        field(7; Enabled; Boolean)
        {
            Caption = 'Enabled';

            trigger OnValidate()
            var
                StatsExplorerFields: Record "StatsExplorer fields";
            begin
                if Type = Type::Flow then
                    if not Enabled then begin
                        if xRec.Enabled = true then
                            if not Confirm(Confirm1 + Confirm2) then
                                Enabled := true
                            else begin
                                "Process aggregate by day" := false;
                                "Process aggregate by week" := false;
                                "Process aggregate by month" := false;
                                "Process aggregate by quarter" := false;
                                "Process aggregate by year" := false;
                                "Process aggregate by period" := false;
                            end;
                    end else begin
                        if xRec.Enabled = false then
                            Message(Confirm3);
                        ParametresStatistiques.Get;
                        if ParametresStatistiques."Period total basis" =
                          ParametresStatistiques."period total basis"::"According to every flow" then begin
                            "Process aggregate by day" := false;
                            "Process aggregate by week" := false;
                            "Process aggregate by month" := true;
                            "Process aggregate by quarter" := false;
                            "Process aggregate by year" := false;
                            "Process aggregate by period" := false;
                        end;
                    end;

                if (Type = Type::"Sort criteria") and (xRec.Enabled <> Enabled) then
                    StatsExplorerFields.EnableDisableField("Field No.", Enabled);
                if (Type = Type::Flow) and (xRec.Enabled <> Enabled) then
                    StatsExplorerFields.EnableDisableFlow("Field name", Enabled);
            end;
        }
        field(10; "Source name"; Text[30])
        {
            Caption = 'Source name';
        }
        field(20; "Process aggregate by day"; Boolean)
        {
            Caption = 'Process aggregate by day';
        }
        field(21; "Process aggregate by week"; Boolean)
        {
            Caption = 'Process aggregate by week';
        }
        field(22; "Process aggregate by month"; Boolean)
        {
            Caption = 'Process aggregate by month';
        }
        field(23; "Process aggregate by quarter"; Boolean)
        {
            Caption = 'Process aggregate by quarter';
        }
        field(24; "Process aggregate by year"; Boolean)
        {
            Caption = 'Process aggregate by year';
        }
        field(25; "Process aggregate by period"; Boolean)
        {
            Caption = 'Process aggregate by period';
        }
        field(30000; "Process aggregate by dimension"; Boolean)
        {
            Caption = 'Process aggregate by dimension';
            InitValue = true;
        }
        field(30001; "Real-Time Update"; Boolean)
        {
            Caption = 'Real-time update';
        }
        field(30002; "Real-Time Update available"; Boolean)
        {
            Caption = 'Real-time update available';
            Editable = false;
        }
        field(30003; "Last Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; Type, "Field name")
        {
            Clustered = true;
        }
        key(STG_Key2; Type, "Field No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if (Type = Type::Flow) and ("Field No." >= 100) then
            Error(Limite);
    end;

    var
        Limite: label 'Field number is a maximum of 100';
        Confirm1: label 'Attention : If you disable this value, it will not be available in Statistics';
        Confirm2: label 'and printing of statistics. \Do you confirm ?';
        Confirm3: label 'Agregate process required to enable this option';
        ParametresStatistiques: Record "Statistics setup";
}

