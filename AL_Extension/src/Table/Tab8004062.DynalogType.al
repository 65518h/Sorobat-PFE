Table 8004062 "Dynalog - Type"
{
    // //MULTI-DEVIS GESWAY 16/10/02 Interface Multi-Devis Express


    fields
    {
        field(1; "Code Type"; Integer)
        {
        }
        field(2; Designation; Text[25])
        {
        }
        field(3; Unite; Text[5])
        {
        }
        field(4; "Coef FG"; Decimal)
        {
        }
        field(5; "Coef Benefice"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

