
Table 52049000 "Sous Nature Panne"
{
    //GL2024  ID dans Nav 2009 : "39004750"
    // DrillDownPageID = "Sous Nature Panne";
    //  LookupPageID = "Sous Nature Panne";

    fields
    {
        field(1; "Nature Panne"; Option)
        {
            OptionMembers = " ","Mécanique",Electrique,Pneumatique,Tollerie;
        }
        field(2; "Sous Nature Panne"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Nature Panne", "Sous Nature Panne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

