Table 50033 "Regroupement Rapport DG"
{
    DrillDownPageID = "Regroupement Rapport DG";
    LookupPageID = "Regroupement Rapport DG";

    fields
    {
        field(1; "Code"; Code[20])
        {
            SQLDataType = Varchar;
        }
        field(2; Designation; Text[100])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = " ","Rapport DG",Bilan,Materiaux,"Nouvelle Entrée","frais annexe";
        }
        field(4; Chantier; Code[20])
        {
        }
        field(5; "Integer"; Boolean)
        {
        }
        field(6; "Quantité Estimer"; Decimal)
        {
        }
        field(7; "Quantité Revue 1"; Decimal)
        {
        }
        field(8; "Quantité Revue 2"; Decimal)
        {
        }
        field(9; "Quantité Revue 3"; Decimal)
        {
        }
        field(10; "Quantité Revue 4"; Decimal)
        {
        }
        field(11; "Quantité Revue 5"; Decimal)
        {
        }
        field(12; "Quantité Revue 6"; Decimal)
        {
        }
        field(13; "Quantité Revue 7"; Decimal)
        {
        }
        field(14; "Quantité Livré"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field(Code),
                                                                  "Job No." = field(Chantier)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", Chantier)
        {
            Clustered = true;
        }
        key(Key2; Type, "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

