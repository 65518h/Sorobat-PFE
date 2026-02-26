Table 52048988 Pannes
{
    //GL2024  ID dans Nav 2009 : "39004691"
    DrillDownPageID = pannes;
    LookupPageID = pannes;

    fields
    {
        field(1; "Code reparation"; Code[10])
        {
        }
        field(2; "Désignation"; Text[100])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Corrective,Préventive';
            OptionMembers = " ",Corrective,"Préventive";
        }
    }

    keys
    {
        key(Key1; "Code reparation")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

