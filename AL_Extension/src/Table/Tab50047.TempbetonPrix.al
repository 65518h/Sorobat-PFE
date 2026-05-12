Table 50047 "Temp beton Prix"
{

    fields
    {
        field(1; CodeBeton; Code[20])
        {
        }
        field(2; Designation; Text[150])
        {
            CalcFormula = lookup(Item.Description where("No." = field(CodeBeton)));
            FieldClass = FlowField;
        }
        field(3; Prix; Decimal)
        {
        }
        field(4; "Prix Reelle"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; CodeBeton)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

