table 52048998 "Bon chargement Enregistrer"
{

    //GL2024  ID dans Nav 2009 : "39004715"
    DrillDownPageID = "Ligne Rendement Vehicule Enreg";
    LookupPageID = "Ligne Rendement Vehicule Enreg";

    fields
    {
        field(1; "N Séquence"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "N° Expédition"; Code[20])
        {
        }
        field(3; "Code Article"; Code[20])
        {
        }
        field(4; "Désignation Article"; Text[80])
        {
        }
        field(5; "Quantité"; Decimal)
        {
        }
        field(6; Conditionnement; Decimal)
        {
        }
        field(7; Poids; Decimal)
        {
        }
        field(8; "N° Lot"; Text[100])
        {
        }
        field(9; Transporteur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(10; "Départ"; Code[20])
        {
            TableRelation = Territory;
        }
        field(11; "Déstination"; Code[20])
        {
            TableRelation = Territory;
        }
        field(12; Kilometrage; Decimal)
        {
        }
        field(13; "N° Bon Chargenemt"; Code[20])
        {
        }
        field(14; "Code Camion"; Code[20])
        {
        }
        field(15; "Frais Transport Associé"; Code[20])
        {
        }
        field(16; "Plus Loin Distance"; Boolean)
        {
        }
        field(17; Alerte; Text[250])
        {
        }
        field(18; "Tonnage Camion"; Decimal)
        {
        }
        field(19; "Date Livraison"; Date)
        {
        }
        field(20; "N° Sequence Ecriture Article"; Integer)
        {
        }
        field(21; "Chargement enregistrer"; Boolean)
        {
        }
        field(22; "Chargement A valider"; Boolean)
        {
        }
        field(23; Encours; Boolean)
        {
        }
        field(24; "N° Seaquence Initial"; Integer)
        {
        }
        field(25; Type; Option)
        {
            OptionMembers = "Bon De Livraision","Retour Vente","Ordre De Transfert","Bon De Reception","Retour Achat";
        }
        field(26; Enlever; Boolean)
        {
        }
        field(27; "Date Chargement"; Date)
        {
        }
        field(28; "N°Mission"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Expédition", "N° Bon Chargenemt", "Code Article")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

