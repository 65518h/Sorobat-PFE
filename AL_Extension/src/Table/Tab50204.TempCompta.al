

Table 50204 "Temp Compta"
{

    fields
    {
        field(1; "N° Document"; Code[20])
        {
        }
        field(2; "N° Compte"; Code[20])
        {
        }
        field(3; "Date d'échience"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "N° Document")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

