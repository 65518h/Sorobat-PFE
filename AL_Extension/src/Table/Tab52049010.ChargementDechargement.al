Table 52049010 "Chargement - Dechargement"
{
    //GL2024  ID dans Nav 2009 : "39004734"
    DrillDownPageID = "Pointt Charg Decharg";
    LookupPageID = "Pointt Charg Decharg";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
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

