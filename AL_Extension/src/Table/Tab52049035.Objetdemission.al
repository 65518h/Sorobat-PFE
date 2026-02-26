table 52049035 "Objet de mission"
{ //GL2024  ID dans Nav 2009 : "39001504"
  //  LookupPageID = 39001557;

    fields
    {
        field(1; "Code"; Code[20])
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

