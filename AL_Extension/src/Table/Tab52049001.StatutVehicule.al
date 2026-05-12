Table 52049001 "Statut Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004722"
    DrillDownPageID = "Statut Vehicule";
    LookupPageID = "Statut Vehicule";

    fields
    {
        field(1; Statut; Code[20])
        {
        }
        field(2; Designation; Text[50])
        {
        }
    }

    keys
    {
        key(STG_Key1; Statut)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

