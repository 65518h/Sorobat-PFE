table 52049030 "Liste Moyens de transport"
{ //GL2024  ID dans Nav 2009 : "39001502"
  //GL2024  LookupPageID = 70141;

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
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

