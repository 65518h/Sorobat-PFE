Table 50203 "Tableau Comparatif"
{

    fields
    {
        field(1; Qualite; Integer)
        {
        }
        field(2; "Prix (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(3; "Delai De Livraison"; DateFormula)
        {
        }
        field(4; Fournisseurs; Code[20])
        {
        }
        field(5; "Date Comparatif"; Date)
        {
        }
        field(6; "Raison Social"; Text[50])
        {
        }
        field(7; "Qualite Inverse"; Integer)
        {
            Description = '//Pour Maintenir l''ordre croissant pour Une Note pres de 20 (19 Devient 1, 18 Devien 2)';
        }
        field(8; Note; Integer)
        {
            Description = '//AGA DSFT 12 07 2010';
        }
        field(9; "Note de trie"; Integer)
        {
            Description = '//AGA DSFT 12 07 2010';
        }
        field(10; "N° Article"; Code[20])
        {
        }
        field(11; "Num Commande"; Code[20])
        {
            Description = '//MBY MEGA 21/10/2010';
        }
        field(12; "Num Demande Appro"; Code[20])
        {
        }
        field(13; "Prix en Devise"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = '// IMS SOROUBAT';
        }
        field(14; "Code Devise"; Code[10])
        {
            Description = '// IMS SOROUBAT';
        }
        field(15; "Num Devis"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Qualite Inverse", "Prix (DS)", "Date Comparatif", "Delai De Livraison", Fournisseurs)
        {
            Clustered = true;
        }
        key(STG_Key2; "Prix (DS)", Note, "Date Comparatif")
        {
        }
        key(STG_Key3; "Prix (DS)", "Date Comparatif", "Note de trie")
        {
        }
        key(STG_Key4; "Date Comparatif", "Prix (DS)", "Note de trie")
        {
        }
        key(STG_Key5; "Date Comparatif", "Note de trie", "Prix (DS)")
        {
        }
        key(STG_Key6; "Note de trie", "Date Comparatif", "Prix (DS)")
        {
        }
        key(STG_Key7; "Note de trie", "Prix (DS)", "Date Comparatif")
        {
        }
        key(STG_Key8; "N° Article", Fournisseurs)
        {
        }
    }

    fieldgroups
    {
    }
}

