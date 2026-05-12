table 50011 "Salarier"
{


    DrillDownPageID = "Salarier";
    LookupPageID = "Salarier";

    fields
    {
        field(1; Salarie; Code[50])
        {
        }
        field(2; "Nom Et Prenom"; Text[100])
        {
        }
    }

    keys
    {
        key(STG_Key1; Salarie)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

