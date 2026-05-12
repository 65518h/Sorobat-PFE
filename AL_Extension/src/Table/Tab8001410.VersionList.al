Table 8001410 "Version List"
{
    // //+BGW+VERSION GESWAY 01/12/01 Version List Management

    DataPerCompany = false;

    fields
    {
        field(1; "Entry ID"; Integer)
        {
        }
        field(2; "Version List"; Text[80])
        {
        }
        field(3; UserID; Code[20])
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Time; Time)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Entry ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

