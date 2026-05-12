table 52049041 "Type Dégats"
{ //GL2024  ID dans Nav 2009 : "39004688"
    DrillDownPageID = "Type Dégats";
    LookupPageID = "Type Dégats";

    fields
    {
        field(1; "Code Type Dégat"; Code[10])
        {
        }
        field(2; "Désignation"; Text[30])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Type Dégat")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

