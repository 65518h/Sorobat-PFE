Table 50042 "Solde Fournisseur II"
{

    fields
    {
        field(1; "Code Fournisseur"; Code[20])
        {
        }
        field(2; User; Code[20])
        {
        }
        field(3; "Date Calcule"; Date)
        {
        }
        field(4; "Heure Calcule"; Time)
        {
        }
        field(5; "Nom Fournisseur"; Text[50])
        {
        }
        field(6; "Facture 2014 Non Soldées"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(7; "Facture 2015 Non Soldées"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(8; "Facture 2016 Non Soldées"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(9; "Facture En Cours de Verificati"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(10; "Reglement Non Lettres"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(11; Solde; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(12; "Montant En Cours De Signiature"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(13; "Solde Total"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(14; "Autre Solde Total"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(15; "Montant Traite Non Echue"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Fournisseur", User)
        {
            Clustered = true;
        }
        key(STG_Key2; Solde)
        {
        }
    }

    fieldgroups
    {
    }
}

