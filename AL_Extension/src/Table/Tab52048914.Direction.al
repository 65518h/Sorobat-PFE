Table 52048914 Direction
{
    LinkedObject = false;
    LookupPageID = Direction;
    //GL2024  ID dans Nav 2009 : "39001447"
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Designation; Text[50])
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

