table 59993 "Solder Piece Incorrect"
{

    fields
    {
        field(1; Annee; Integer)
        {
        }
        field(2; Journal; Code[20])
        {
        }
        field(3; "Numero Piece"; Code[20])
        {
        }
        field(4; "Nouveau Numero Piece"; Code[20])
        {
        }
        field(5; Compteur; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; Annee, Journal, "Numero Piece", Compteur)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

