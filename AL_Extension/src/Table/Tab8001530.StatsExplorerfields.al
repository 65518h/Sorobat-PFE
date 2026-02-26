Table 8001530 "StatsExplorer fields"
{
    //GL2024  ID dans Nav 2009 : "8001324"
    // //STATSEXPLORER STATSEXPLORER 20/01/02 Sorts


    fields
    {
        field(1; "Entry name"; Text[30])
        {
            Caption = 'Entry Type';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter(Flow));
        }
        field(2; "Entry No"; Integer)
        {
            CalcFormula = lookup("Statistic criteria"."Field No." where(Type = filter(Flow),
                                                                         "Field name" = field("Entry name")));
            Caption = 'Entry No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Field No"; Integer)
        {
            Caption = 'Field No.';
        }
        field(11; "Field Caption"; Text[30])
        {
            CalcFormula = lookup("Statistic criteria"."Field name" where(Type = filter("Sort criteria"),
                                                                          "Field No." = field("Field No")));
            Caption = 'Field name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
        field(21; Available; Boolean)
        {
            Caption = 'Available';
        }
    }

    keys
    {
        key(Key1; "Entry name", "Field No")
        {
            Clustered = true;
        }
        key(Key2; "Field No", Available, "Entry name")
        {
        }
    }

    fieldgroups
    {
    }


    procedure InitStatsExplorerFields(FlowName: Text[50]; FieldNumber1: Integer; FieldNumber2: Integer; FieldNumber3: Integer; FieldNumber4: Integer; FieldNumber5: Integer; FieldNumber6: Integer; FieldNumber7: Integer; FieldNumber8: Integer; FieldNumber9: Integer; FieldNumber10: Integer)
    var
        StatisticCriteria1: Record "Statistic criteria";
        StatisticCriteria2: Record "Statistic criteria";
        i: Integer;
        "Fields": array[10] of Integer;
    begin
        if StrLen(FlowName) > 30 then
            FlowName := CopyStr(FlowName, 1, 30);
        Fields[1] := FieldNumber1;
        Fields[2] := FieldNumber2;
        Fields[3] := FieldNumber3;
        Fields[4] := FieldNumber4;
        Fields[5] := FieldNumber5;
        Fields[6] := FieldNumber6;
        Fields[7] := FieldNumber7;
        Fields[8] := FieldNumber8;
        Fields[9] := FieldNumber9;
        Fields[10] := FieldNumber10;

        if not StatisticCriteria1.Get(StatisticCriteria1.Type::Flow, FlowName) then
            exit;
        StatisticCriteria2.SetCurrentkey(Type, "Field No.");
        StatisticCriteria2.SetRange(Type, StatisticCriteria2.Type::"Sort criteria");
        i := 0;
        repeat
            i := i + 1;
            if Fields[i] <> 0 then begin
                StatisticCriteria2.SetRange("Field No.", Fields[i]);
                if not StatisticCriteria2.IsEmpty then
                    if StatisticCriteria2.FindFirst then
                        if not Get(StatisticCriteria1."Field name", StatisticCriteria2."Field No.") then begin
                            Init;
                            "Entry name" := FlowName;
                            "Field No" := Fields[i];
                            Enabled := StatisticCriteria1.Enabled and StatisticCriteria2.Enabled;
                            Available := true;
                            Insert;
                        end;
            end;
        until i = 10;
    end;


    procedure EnableDisableField(NoField: Integer; SetEnabled: Boolean)
    var
        StatisticCriteria: Record "Statistic criteria";
    begin
        SetCurrentkey("Field No", Available, "Entry name");
        SetRange("Field No", NoField);
        SetRange(Available, true);
        repeat
            if StatisticCriteria.Get(StatisticCriteria.Type::Flow, "Entry name") then begin
                Enabled := StatisticCriteria.Enabled and SetEnabled;
                Modify;
            end;
        until Next = 0;
    end;


    procedure EnableDisableFlow(EntryName: Text[80]; SetEnabled: Boolean)
    var
        StatisticCriteria: Record "Statistic criteria";
    begin
        SetRange("Entry name", EntryName);
        SetRange(Available, true);
        if not IsEmpty then begin
            FindFirst;
            repeat
                CalcFields("Field Caption");
                if StatisticCriteria.Get(StatisticCriteria.Type::"Sort criteria", "Field Caption") then begin
                    Enabled := StatisticCriteria.Enabled and SetEnabled;
                    Modify;
                end;
            until Next = 0;
        end;
    end;


    procedure DesactivateFields(EntryName: Text[80]; FieldFilter: Text[250])
    begin
        SetRange("Entry name", EntryName);
        SetFilter("Field No", FieldFilter);
        if not IsEmpty then begin
            ModifyAll(Available, false);
            ModifyAll(Enabled, false);
        end;
    end;
}

