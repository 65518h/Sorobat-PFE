Table 50030 Synchronisation
{

    fields
    {
        field(1; "Num Sequence"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Date Syncronisation"; Date)
        {
        }
        field(3; "Heure Syncronisation"; Time)
        {
        }
        field(4; User; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Num Sequence")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

