
Table 52049058 "Assurance Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004672"
    //  DrillDownPageID = "Liste Assurance Véhicule";
    //   LookupPageID = "Liste Assurance Véhicule";

    fields
    {
        field(1; "N° Veh"; Code[10])
        {
            TableRelation = Véhicule."N° Vehicule";
        }
        field(2; "Date Document"; Date)
        {
        }
        field(3; "Catégorie"; Text[30])
        {
        }
        field(4; "N° Police"; Code[12])
        {
        }
        field(5; Tarif; Decimal)
        {
        }
        field(6; "Date debut valdite"; Date)
        {
            Description = 'MBY COMAF 24/12/2010';
        }
        field(7; "Date fin valdite"; Date)
        {
            Description = 'MBY COMAF 24/12/2010';
        }
        field(8; "Seuil alerte"; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; "N° Veh", "Date Document")
        {
            Clustered = true;
            SumIndexFields = Tarif;
        }
    }

    fieldgroups
    {
    }
}

