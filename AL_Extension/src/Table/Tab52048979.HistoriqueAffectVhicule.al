table 52048979 "Historique Affect. Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004679"
    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Affectation,Réaffectation';
            OptionMembers = Affectation,"Réaffectation";
        }
        field(2; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
        }
        field(3; "Date Affectation"; Date)
        {
        }
        field(4; "Type Affectation"; Option)
        {
            OptionCaption = 'Direction,Service,Parc Auto';
            OptionMembers = Direction,Service,"Parc Auto";
        }
        field(5; Affectation; Code[10])
        {
            TableRelation = IF ("Type Affectation" = CONST(Direction)) "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTEMENT'))
            ELSE IF ("Type Affectation" = CONST(Service)) "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTEMENT'));
        }
        field(6; Observation; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Date Affectation", "N° Véhicule")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

