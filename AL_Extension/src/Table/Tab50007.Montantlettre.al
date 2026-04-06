Table 50007 "Montant lettre"
{

    fields
    {
        field(1; "Code mnt"; Code[10])
        {
        }
        field(2; "Libelle mnt"; Text[200])
        {
        }
        field(3; "Libelle montant arabe"; Text[200])
        {
        }
        field(4; "Libelle montant Ang"; Text[200])
        {
            Description = 'Houcine';
        }
    }

    keys
    {
        key(STG_Key1; "Code mnt")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

