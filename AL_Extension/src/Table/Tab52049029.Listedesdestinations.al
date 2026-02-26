table 52049029 "Liste des destinations"
{ //GL2024  ID dans Nav 2009 : "39001501"
  //GL2024 LookupPageID = 39001551;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Designation; Text[50])
        {
        }
        field(3; "Groupe destination"; Code[20])
        {
            TableRelation = "Groupe destination";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

