Table 8004093 "Cue BAT"
{

    fields
    {
        field(1; Clef; Code[10])
        {
        }
        field(2; "Affaires Externes"; Integer)
        {
            CalcFormula = count(Job where("Job Type" = const(External)));
            FieldClass = FlowField;
        }
        field(3; "Affaires internes"; Integer)
        {
            CalcFormula = count(Job where("Job Type" = const(Internal)));
            FieldClass = FlowField;
        }
        field(4; "Affaires Stock"; Integer)
        {
            CalcFormula = count(Job where("Job Type" = const(Stock)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Clef)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

