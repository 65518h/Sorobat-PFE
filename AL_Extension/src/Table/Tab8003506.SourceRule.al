Table 8003506 "Source Rule"
{
    // //+REP+ GESWAY 19/09/01 Table Loi d'origine


    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; Type; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

