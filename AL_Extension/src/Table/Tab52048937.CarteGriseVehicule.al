
Table 52048937 "Carte Grise Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004671"
    //GL2024   DrillDownPageID = "Liste Cartes Grises";
    //GL2024  LookupPageID = "Liste Cartes Grises";

    fields
    {
        field(1; "N° Veh"; Code[10])
        {
        }
        field(2; "N° Carte"; Code[20])
        {
        }
        field(3; Genre; Code[50])
        {
            TableRelation = "Genre Véhicule";
        }
        field(4; Marque; Code[10])
        {
            TableRelation = "Marque Véhicule";
        }
        field(5; Type; Code[20])
        {
        }
        field(6; "Modéle"; Code[10])
        {
            TableRelation = "Modéle véhicule"."Code Modéle" where("Code Marque" = field(Marque));
        }
        field(7; Puissance; Code[10])
        {
        }
        field(8; "Série"; Code[30])
        {
        }
        field(9; Carrosserie; Text[30])
        {
        }
        field(10; "Poids TTCharges"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(11; "Poids à Vide"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
    }

    keys
    {
        key(STG_Key1; "N° Veh", "N° Carte")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

