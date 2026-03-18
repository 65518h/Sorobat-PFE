Table 70112 "Imp Unit of Measure"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[10])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

