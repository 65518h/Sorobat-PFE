Table 8001531 "Statistic Cue"
{
    //GL2024  ID dans Nav 2009 : "8001325"
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; Statistic; Integer)
        {
            CalcFormula = count("Statistic definition" where("Line No." = const(10000)));
            Caption = 'Statistic';
            FieldClass = FlowField;
        }
        field(3; "Statistic for the user"; Integer)
        {
            CalcFormula = count("Statistic definition" where("Line No." = const(10000),
                                                              "User ID" = field("User ID Filter")));
            Caption = 'Statistic for the user';
            FieldClass = FlowField;
        }
        field(20; "User ID Filter"; Code[20])
        {
            Caption = 'User ID Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

