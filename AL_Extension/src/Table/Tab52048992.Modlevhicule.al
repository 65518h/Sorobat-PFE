Table 52048992 "Modéle véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004701"
    // DrillDownPageID = "Modéle Véhicule";
    // LookupPageID = "Modéle Véhicule";

    fields
    {
        field(1; "Code Marque"; Code[30])
        {
        }
        field(2; "Code Modéle"; Code[30])
        {
        }
        field(3; "Désignation"; Text[60])
        {
        }
    }

    keys
    {
        key(Key1; "Code Marque", "Code Modéle")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

