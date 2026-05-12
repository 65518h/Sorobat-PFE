
Table 52049063 "Veh. Reparation Préventive"
{
    //GL2024  ID dans Nav 2009 : "39004698"
    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
        }
        field(2; "Code Reparation"; Code[10])
        {
            TableRelation = Pannes."Code reparation" where(Type = filter(Préventive));

            trigger OnValidate()
            begin
                if rep.Get("Code Reparation") then
                    "Désignation réparation" := rep.Désignation;
            end;
        }
        field(3; "Désignation réparation"; Text[100])
        {
        }
        field(4; "Fréquence (Index)"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(5; "Fréquence (Jour)"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Véhicule", "Code Reparation")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        rep: Record Pannes;
}

