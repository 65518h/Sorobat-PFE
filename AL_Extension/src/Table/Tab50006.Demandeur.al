Table 50006 Demandeur
{
    DrillDownPageID = "Liste Utilisateurs";
    LookupPageID = "Liste Utilisateurs";

    fields
    {
        field(1; "Nom Et Prenom"; Code[30])
        {
            Editable = true;
        }
        field(2; Synchronise; Boolean)
        {
        }
        field(3; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 19-05-2015';
        }
    }

    keys
    {
        key(STG_Key1; "Nom Et Prenom")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

