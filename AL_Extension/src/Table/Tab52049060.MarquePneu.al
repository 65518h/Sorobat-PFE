
Table 52049060 "Marque Pneu"
{
    //GL2024  ID dans Nav 2009 : "39004695"
    //GL2024   DrillDownPageID = "Marque Pneu";
    //GL2024   LookupPageID = "Marque Pneu";

    fields
    {
        field(1; "Code marque"; Code[10])
        {
        }
        field(2; "Désignation"; Text[30])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code marque")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

