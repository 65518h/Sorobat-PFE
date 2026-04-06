Table 84161 "UPG Job Ledger Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
        }
        field(8001901; "Subscription End Date"; Date)
        {
        }
        field(8001902; "Subscription Generation Date"; Date)
        {
        }
        field(8001903; "Subscription No."; Code[20])
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

