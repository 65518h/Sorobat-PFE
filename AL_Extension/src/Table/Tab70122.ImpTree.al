Table 70122 "Imp Tree"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Person,Machine,Structure,Item,NACE;
        }
        field(2; "Code"; Text[20])
        {
        }
        field(3; Description; Text[80])
        {
        }
        field(4; Level; Integer)
        {
        }
        field(73754; Replication; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

