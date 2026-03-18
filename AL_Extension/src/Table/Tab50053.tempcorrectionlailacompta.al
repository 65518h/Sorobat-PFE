Table 50053 "temp correction laila compta"
{

    fields
    {
        field(1; "Num Document"; Code[20])
        {
        }
        field(2; "date comptabilisation"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Num Document")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

