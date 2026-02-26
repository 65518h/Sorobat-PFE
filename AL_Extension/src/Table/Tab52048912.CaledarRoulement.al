table 52048912 "Caledar Roulement"
{  //GL2024  ID dans Nav 2009 : "39001445"


    // DrillDownPageID = "Liste Ordre Mission";
    //   LookupPageID = "Liste Ordre Mission";

    fields
    {
        field(1; "Code calend Roulement"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Designation; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code calend Roulement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

