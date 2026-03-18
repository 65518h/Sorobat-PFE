Table 52048942 "Detail de congé consommé"
{//GL2024  ID dans Nav 2009 : "39001513"
    DrillDownPageID = "Detail consommation conge";
    LookupPageID = "Detail consommation conge";

    fields
    {
        field(1; "N°Sequence"; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Salarié"; Code[20])
        {
        }
        field(3; "Annee de Consommation"; Integer)
        {
        }
        field(4; "Nbre consommé"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N°Sequence", "Salarié", "Annee de Consommation")
        {
            Clustered = true;
            SumIndexFields = "Nbre consommé";
        }
        key(STG_Key2; "Salarié", "Annee de Consommation")
        {
            SumIndexFields = "Nbre consommé";
        }
    }

    fieldgroups
    {
    }
}

