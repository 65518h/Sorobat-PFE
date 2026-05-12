Table 8003508 Section
{

    //GL2024  ID dans Nav 2009 : "39001458"
   // LookupPageID = Sections;

    fields
    {
        field(1; Direction; Code[10])
        {
            TableRelation = Direction.Code;
        }
        field(2; Service; Code[10])
        {
            TableRelation = Service.Service where(Direction = field(Direction));
        }
        field(3; Section; Code[10])
        {
        }
        field(4; Decription; Text[50])
        {
        }
        field(5; "Gpe Stat empl"; Code[10])
        {
            TableRelation = "Employee Statistics Group".Code;
        }
        field(50001; Chantier; Code[20])
        {
            TableRelation = Job;
        }
    }

    keys
    {
        key(Key1; Section)
        {
            Clustered = true;
        }
        key(Key2; Direction, Service, Section)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Section, Decription)
        {

        }
    }
}

