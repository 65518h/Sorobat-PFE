
Table 52048962 "Coef Gratification"
{
    //GL2024  ID dans Nav 2009 : "39001459"
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
        field(5; "Coef Gratif"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(6; "Coef Gratif Compl."; Decimal)
        {
            //blankzero = true;
            DecimalPlaces = 0 : 2;
        }
    }

    keys
    {
        key(STG_Key1; Prime, "Collège", Note)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

