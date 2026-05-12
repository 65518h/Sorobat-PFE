Table 70120 "Imp Import Payment Method"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Bal. Account Type"; Option)
        {
            OptionMembers = "G/L Account","Bank Account";
        }
        field(4; "Bal. Account No."; Code[20])
        {
        }
        field(8001401; "Bill Type"; Option)
        {
            OptionMembers = ,"Not Accepted",Accepted,BOR;
        }
        field(8001402; "Payment Type"; Option)
        {
            OptionMembers = ,Check,Bill,Transfer,"Direct Debit","Credit Card",VCOM;
        }
        field(8001403; "Reason Code"; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

