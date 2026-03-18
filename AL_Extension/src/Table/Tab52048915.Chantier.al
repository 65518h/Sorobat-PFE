table 52048915 Chantier
{
    //GL2024  ID dans Nav 2009 : "39001454"
    DrillDownPageID = "Ligne Commande";
    LookupPageID = "Ligne Commande";

    fields
    {
        field(1; "Code Chantier"; Code[20])
        {
        }
        field(2; Designation; Text[60])
        {
        }
        field(3; "Montnant Repas/ Jours"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(4; "Calcul Repas Inclus"; Boolean)
        {
        }
        field(5; Blocked; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Chantier")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

