table 52048956 "Motif Mission"
{
    //GL2024  ID dans Nav 2009 : "39001452"
    DrillDownPageID = "Motif Mission";
    LookupPageID = "Motif Mission";

    fields
    {
        field(1; "Code Motif"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = "Sortie Affaire Personnelle","Mission de Travail";
        }
    }

    keys
    {
        key(Key1; "Code Motif")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

