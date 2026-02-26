Table 8004019 "Fournisseurs d'intérim"
{
    // //LIBRE GESWAY 18/12/02 Libre


    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; Nom; Text[30])
        {
        }
        field(3; "Adresse 1"; Text[30])
        {
        }
        field(4; "Adresse 2"; Text[30])
        {
        }
        field(5; "C.P."; Text[30])
        {
        }
        field(6; Vill; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

