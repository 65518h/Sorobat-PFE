table 52049052 "Détail Mission Enreg"
{
    //GL2024  ID dans Nav 2009 : "39004712"
    fields
    {
        field(1; "N° Mission"; Code[20])
        {
            TableRelation = "Mission Enregistré"."N° Mission";
        }
        field(2; "Date Mission"; Date)
        {
        }
        field(3; "Type Mission"; Option)
        {
            OptionMembers = Vente,Achat,Autre;
        }
        field(4; "N° Tiers"; Code[20])
        {
        }
        field(5; "Nom Tiers"; Text[80])
        {
        }
        field(6; "Num Document"; Code[20])
        {
        }
        field(7; "Num Ligne Document"; Integer)
        {
        }
        field(8; "Code Article"; Code[20])
        {
        }
        field(9; "Désignation Article"; Text[80])
        {
        }
        field(10; "Grande Famille"; Code[10])
        {
        }
        field(11; Famille; Code[10])
        {
        }
        field(12; "Quantité"; Decimal)
        {
        }
        field(13; "Code Unité"; Code[10])
        {
        }
        field(14; "Code Chantier"; Code[20])
        {
        }
        field(15; "Description Chantier"; Text[50])
        {
        }
        field(16; "Vendor Shipping No."; Code[20])
        {
        }
        field(17; "A Facturer"; Boolean)
        {
        }
        field(18; "Client a facturer"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(19; "Quantité à facturer"; Decimal)
        {
        }
        field(20; "Prix Unitaire"; Decimal)
        {
        }
        field(21; "N° BL"; Code[30])
        {
        }
        field(22; "N° Facture Liée"; Code[20])
        {
            TableRelation = "Sales Header"."No.";
        }
        field(23; "Départ"; Text[30])
        {
        }
        field(24; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule."N° Vehicule";
        }
        field(25; "Fraix Annexes"; Code[20])
        {
        }
        field(26; "Dossier d'importation"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "N° Mission", "Num Document", "Num Ligne Document")
        {
            Clustered = true;
        }
        key(Key2; "Client a facturer")
        {
        }
    }

    fieldgroups
    {
    }
}

