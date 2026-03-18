Table 8003507 "Destination Rule"
{
    // //+REP+ GESWAY 19/09/01 Table Loi de destination


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

