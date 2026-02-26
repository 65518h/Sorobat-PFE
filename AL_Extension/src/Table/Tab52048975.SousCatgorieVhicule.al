Table 52048975 "Sous Catégorie Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004675"
    DrillDownPageID = "Sous-Catégorie Véhicule";
    LookupPageID = "Sous-Catégorie Véhicule";

    fields
    {
        field(1; "Code Catégorie"; Code[50])
        {
        }
        field(2; "Code Sous-Catégorie"; Code[50])
        {
        }
        field(3; Description; Text[30])
        {
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
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
        key(Key1; "Code Catégorie", "Code Sous-Catégorie")
        {
            Clustered = true;
        }
        key(Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }
}

