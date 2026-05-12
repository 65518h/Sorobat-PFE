Table 8004039 "En-tête planning achats"
{
    // //LIBRE GESWAY 18/12/02 Libre


    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; "Code"; Text[30])
        {
        }
        field(3; "Désignation"; Text[30])
        {
        }
        field(4; "Date Filter"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

