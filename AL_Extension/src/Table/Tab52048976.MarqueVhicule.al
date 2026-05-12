Table 52048976 "Marque Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004676"
    DrillDownPageID = "Marque véhicule";
    LookupPageID = "Marque véhicule";

    fields
    {
        field(1; "Code Marque"; Code[50])
        {
        }
        field(2; "Désignation"; Text[50])
        {
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50002; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }

    keys
    {
        key(STG_Key1; "Code Marque")
        {
            Clustered = true;
        }
        key(STG_Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }
}

