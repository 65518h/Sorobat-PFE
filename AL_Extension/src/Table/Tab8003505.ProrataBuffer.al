Table 8003505 "Prorata Buffer"
{
    // //+REP+ GESWAY 19/09/01 Table Buffer calcul des prorata


    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

