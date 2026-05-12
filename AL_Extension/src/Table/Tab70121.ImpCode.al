Table 70121 "Imp Code"
{

    fields
    {
        field(1; "Table No"; Integer)
        {
        }
        field(2; "Field No"; Integer)
        {
        }
        field(3; "Code"; Code[20])
        {
        }
        field(4; Description; Text[30])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Table No", "Field No", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

