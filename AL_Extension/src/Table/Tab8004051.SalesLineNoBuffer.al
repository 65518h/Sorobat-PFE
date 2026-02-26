Table 8004051 "Sales Line No. Buffer"
{
    Caption = 'Sales Line No. Buffer';
    Description = 'Transfert devis en commande pour renumérotation de ligne';

    fields
    {
        field(1; "Old Line No."; Integer)
        {
        }
        field(2; "New Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Old Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

