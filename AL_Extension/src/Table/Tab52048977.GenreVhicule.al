Table 52048977 "Genre Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004677"
    LookupPageID = "Liste Genres Véhicules";

    fields
    {
        field(1; "Code Genre"; Code[50])
        {
        }
        field(2; "Désignation"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code Genre")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

