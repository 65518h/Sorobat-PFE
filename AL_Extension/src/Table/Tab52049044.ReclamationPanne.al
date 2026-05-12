table 52049044 "Reclamation Panne"
{
    //GL2024  ID dans Nav 2009 : "39004706"
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
            // TableRelation = Table70019;
        }
        field(3; "Désignation"; Text[100])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code", "N° Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

