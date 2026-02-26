Table 52049006 "Chauffeur Location"
{//GL2024  ID dans Nav 2009 : "39004729"
    //GL2024    DrillDownPageID = 74751;
    //GL2024   LookupPageID = 74751;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Nom; Text[100])
        {
        }
        field(3; "Salaire Journalier"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

