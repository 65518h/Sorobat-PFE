
Table 52048955 "Coef Gratification1"
{
    //GL2024  ID dans Nav 2009 : "39001451"
    fields
    {
        field(1; Prime; Code[10])
        {
            NotBlank = true;
            TableRelation = Prime;
        }
        field(2; "Collège"; Code[20])
        {
            NotBlank = true;
            TableRelation = CATEGORIES;
        }
        field(3; Note; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(4; "Min Coef gratif."; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(5; "Coef Gratification"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(Key1; Prime, "Collège", Note)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

