Table 89441 "UPG Handled IC Inbox Purch. Li"
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
            OptionMembers = "Returned by Partner","Created by Partner";
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

