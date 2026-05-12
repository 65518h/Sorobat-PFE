Table 50010 "Bureau Ordre Envoyé a"
{

    fields
    {
        field(1; "No. Document"; Code[20])
        {
        }
        field(2; Utilisateur; Code[20])
        {
        }
        field(3; Service; Option)
        {
            Description = 'HJ DSFT 30-06-2012';
            OptionMembers = " ","Direction Comptable","Direction Achat","Direction Administratif","Direction RH","Direction Parc Auto"," Direction Magasin","Direction Fianciére","Direction General";
        }
        field(4; "Envoyé à"; Boolean)
        {
            Description = 'HJ DSFT 30-06-2012';
        }
    }

    keys
    {
        key(STG_Key1; "No. Document", Utilisateur)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

