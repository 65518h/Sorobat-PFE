Table 89433 "UPG Handled IC Outbox Purch. L"
{

    fields
    {
        field(4; "Line No."; Integer)
        {
        }
        field(125; "IC Partner Code"; Code[20])
        {
        }
        field(126; "IC Transaction No."; Integer)
        {
        }
        field(127; "Transaction Source"; Option)
        {
            OptionMembers = "Rejected by Current Company","Created by Current Company";
        }
        field(8001410; "Unit Of Measure Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "IC Partner Code", "IC Transaction No.", "Transaction Source")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

