table 52049039 "Groupe destination"
{ //GL2024  ID dans Nav 2009 : "39001506"
  //GL2024    DrillDownPageID = 39001569;
  //GL2024    LookupPageID = 39001569;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
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

