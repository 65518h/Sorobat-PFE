Table 52048916 Service
{
    //GL2024  ID dans Nav 2009 : "39001457"
    LookupPageID = Services;

    fields
    {
        field(1; Direction; Code[10])
        {
            TableRelation = Direction.Code;
        }
        field(2; Service; Code[10])
        {

        }
        field(3; Description; Text[50])
        {
        }
    }

    keys
    {
        key(STG_Key1; Direction, Service)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

