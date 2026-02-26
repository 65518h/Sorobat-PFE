Table 8004184 "Formule Beton"
{
    DrillDownPageID = "Formule Beton";
    LookupPageID = "Formule Beton";

    fields
    {
        field(1; "Code Formule"; Code[20])
        {
        }
        field(2; Ciment; Text[30])
        {
        }
        field(3; Formule; Text[30])
        {
        }
        field(4; "Gravier 6/14"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(5; "Gravier 12/20"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(6; "gravier 25/40"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(7; Sable; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(8; Commentaire; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code Formule")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

