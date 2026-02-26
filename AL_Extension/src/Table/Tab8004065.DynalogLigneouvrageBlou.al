Table 8004065 "Dynalog - Ligne ouvrage (Blou)"
{
    // //MULTI-DEVIS GESWAY 16/10/02 Interface Multi-Devis Express


    fields
    {
        field(1; "Type tache"; Integer)
        {
        }
        field(2; "Code tache"; Code[18])
        {
        }
        field(3; "Num ligne"; Integer)
        {
        }
        field(4; "Type sous Tache"; Integer)
        {
        }
        field(5; "Code sous Tache"; Code[18])
        {
        }
        field(6; Quantite; Decimal)
        {
        }
        field(7; "Coef de perte"; Decimal)
        {
        }
        field(8; Cadence; Decimal)
        {
        }
        field(9; Metre; Text[250])
        {
        }
        field(10; "Mode calcul"; Boolean)
        {
        }
        field(11; "Pres impression"; Integer)
        {
        }
        field(12; "PVU fixe"; Boolean)
        {
        }
        field(13; Pose; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Type tache", "Code tache", "Num ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

