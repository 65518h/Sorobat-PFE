Table 52049026 "Affectation Marche"
{
    //GL2024  ID dans Nav 2009 : "39004751"
    DrillDownPageID = "Affectation Marche";
    LookupPageID = "Affectation Marche";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Marche; Code[20])
        {
            TableRelation = Job;
        }
    }

    keys
    {
        key(Key1; "Code", Marche)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

