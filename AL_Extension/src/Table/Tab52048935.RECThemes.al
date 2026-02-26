table 52048935 "REC-Themes"
{

    //GL2024  ID dans Nav 2009 : "39001492"
    // LookupPageID = "REC-Themes";

    fields
    {
        field(1; "Code theme"; Code[20])
        {
        }
        field(2; Description; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code theme")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

