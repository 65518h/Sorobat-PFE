Table 52049023 "Sous Affectation Marche"
{
    //GL2024  ID dans Nav 2009 : "39004747"
    DrillDownPageID = "Sous Affectation Marche";
    LookupPageID = "Sous Affectation Marche";

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(50000; Description; Text[100])
        {
        }
        field(50001; Marche; Code[20])
        {
            Editable = true;
            TableRelation = Job;
        }
        field(50002; Stockable; boolean)
        {

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

