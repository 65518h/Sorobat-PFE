

Table 59991 "Recuperation Historique"
{

    fields
    {
        field(1; "Date Ecriture"; Date)
        {
        }
        field(2; "N° Pièce"; Code[20])
        {
        }
        field(3; "Type Compte"; Integer)
        {
        }
        field(4; "N° Compte Général"; Code[20])
        {
        }
        field(5; "Compte Tiers"; Code[20])
        {
        }
        field(6; "Libellé Ecriture"; Text[250])
        {
        }
        field(7; "Code Journal"; Code[20])
        {
        }
        field(8; "Montant DS"; Decimal)
        {
        }
        field(9; "Débit / Crédit"; Text[30])
        {
        }
        field(10; Compteur; Integer)
        {
            AutoIncrement = false;
        }
        field(11; Cle; Integer)
        {
        }
        field(12; Devise; Code[10])
        {
        }
        field(13; "Montant Devise"; Decimal)
        {
        }
        field(14; "Compte Immo Correspond"; Code[20])
        {
        }
        field(15; "Num Immo"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; Cle)
        {
            Clustered = true;
        }
        key(STG_Key2; "Code Journal", "Date Ecriture", "N° Pièce", "N° Compte Général")
        {
        }
        key(STG_Key3; "N° Compte Général")
        {
        }
        key(STG_Key4; "Compte Tiers")
        {
        }
        key(STG_Key5; "Code Journal", "N° Pièce")
        {
        }
        key(STG_Key6; "Date Ecriture")
        {
        }
    }

    fieldgroups
    {
    }
}

