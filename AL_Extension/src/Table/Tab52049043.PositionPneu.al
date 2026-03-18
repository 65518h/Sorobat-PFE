table 52049043 "Position Pneu"
{ //GL2024  ID dans Nav 2009 : "39004699"
    DrillDownPageID = "Position Pneu";
    LookupPageID = "Position Pneu";

    fields
    {
        field(1; "Code Position"; Code[10])
        {
        }
        field(2; "Désignation"; Text[100])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Position")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

