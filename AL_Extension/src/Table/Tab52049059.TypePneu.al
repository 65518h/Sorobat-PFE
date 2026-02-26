
Table 52049059 "Type Pneu"
{
    //GL2024  ID dans Nav 2009 : "39004694"
    //GL2024  DrillDownPageID = "Type Pneu";
    //GL2024  LookupPageID = "Type Pneu";

    fields
    {
        field(1; "Code type"; Code[10])
        {
        }
        field(2; "désignation"; Text[30])
        {
        }
        field(6; Largeur; Code[10])
        {
        }
        field(7; "Diamétre"; Code[10])
        {
        }
        field(8; "durée de vie"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
    }

    keys
    {
        key(Key1; "Code type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

