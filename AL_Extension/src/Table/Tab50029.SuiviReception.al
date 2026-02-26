Table 50029 "Suivi Reception"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Ligne No."; Integer)
        {
            Editable = false;
        }
        field(3; "Article No."; Code[20])
        {
            Editable = false;
        }
        field(5; Description; Text[100])
        {
        }
        field(6; "Quantité Commandé"; Decimal)
        {
        }
        field(7; "Quantité Restante"; Decimal)
        {
        }
        field(8; "Quantité Livré"; Decimal)
        {
        }
        field(9; "Quantité Prévue"; Decimal)
        {
        }
        field(10; "Date Livraison Prevue"; Date)
        {
        }
        field(11; Fournisseur; Code[20])
        {
        }
        field(12; Nom; Text[100])
        {
        }
        field(13; Affectation; Text[50])
        {
        }
        field(14; "Lieu Livraison"; Text[50])
        {
        }
        field(15; Demarcheur; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Ligne No.", "Article No.", "Quantité Commandé", "Quantité Restante", "Quantité Livré")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

