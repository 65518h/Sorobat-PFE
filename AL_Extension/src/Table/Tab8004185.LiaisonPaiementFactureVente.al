Table 8004185 "Liaison Paiement Facture Vente"
{

    fields
    {
        field(1; "N° Bordereaux"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(3; "N° Facture"; Code[20])
        {
            TableRelation = "Sales Invoice Header";
        }
        field(4; "Montant TTC"; Decimal)
        {
        }
        field(5; Commentaire; Text[250])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Bordereaux", "N° Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

