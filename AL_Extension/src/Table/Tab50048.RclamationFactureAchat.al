Table 50048 "Réclamation Facture Achat"
{

    fields
    {
        field(1; "N° Facture"; Code[20])
        {
        }
        field(2; "date Comptabilisation"; Date)
        {
        }
        field(3; "N° Fournisseur"; Code[10])
        {
        }
        field(4; "Nom Fournisseur"; Text[150])
        {
        }
        field(5; "N° facture Fournisseur"; Code[30])
        {
        }
        field(6; "Date échéance"; Date)
        {
        }
        field(7; "Statut Facture"; Option)
        {
            OptionMembers = "Verifié","Réglement en Préparation","En Cours De Signature","Signée","Payée","Partiellement Payé","Contrôle Financier en Cours","Réglement Préparé";
        }
        field(8; "Montant HT"; Decimal)
        {
        }
        field(9; "Montant TTC"; Decimal)
        {
        }
        field(10; "Date Réclamation"; Date)
        {
        }
        field(11; "Prise en charge"; Boolean)
        {
        }
        field(12; "Date Prise en Charge"; Date)
        {
        }
        field(13; Utilisateur; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Facture")
        {
            Clustered = true;
        }
        key(STG_Key2; "date Comptabilisation")
        {
        }
        key(STG_Key3; "Date Réclamation")
        {
        }
        key(STG_Key4; "Date Prise en Charge")
        {
        }
    }

    fieldgroups
    {
    }
}

