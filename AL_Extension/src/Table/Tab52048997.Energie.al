Table 52048997 Energie
{   //GL2024  ID dans Nav 2009 : "39004714"
    DrillDownPageID = Energie;
    LookupPageID = Energie;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Designation; Text[30])
        {
        }
        field(3; "Côut unitaire"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(4; "Article Associé"; Code[20])
        {
            TableRelation = Item;
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

