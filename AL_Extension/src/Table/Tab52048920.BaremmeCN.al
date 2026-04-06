table 52048920 "Baremme CN"
{
    //GL2024  ID dans Nav 2009 : "39001468"
    fields
    {
        field(1; "No ligne"; Integer)
        {
        }
        field(2; "Bornne inferieur"; Decimal)
        {
        }
        field(3; "Borne supperieur"; Decimal)
        {
        }
        field(4; Taux; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "No ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

