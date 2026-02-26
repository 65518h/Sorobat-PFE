Table 8004003 "Lignes commentaires pointage"
{
    // //LIBRE GESWAY 18/12/02 Libre


    fields
    {
        field(1; "N°"; Integer)
        {
        }
        field(2; Job; Text[30])
        {
        }
        field(3; "code phase"; Text[30])
        {
        }
        field(4; "Code tâche"; Text[30])
        {
        }
        field(5; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "N°")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

