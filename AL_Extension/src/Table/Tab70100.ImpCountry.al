Table 70100 "Imp Country"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(6; "EU Country Code"; Code[10])
        {
        }
        field(7; "Intrastat Code"; Code[10])
        {
        }
        field(8; "Address Format"; Option)
        {
            OptionMembers = "Post Code+City","City+Post Code","City+County+Post Code","Blank Line+Post Code+City";
        }
        field(9; "Contact Address Format"; Option)
        {
            OptionMembers = First,"After Company Name",Last;
        }
        field(8001400; "Map URL"; Text[250])
        {
        }
        field(8001401; "Map Country Code"; Code[10])
        {
        }
        field(8001402; "Map URL 2"; Text[250])
        {
        }
        field(8001403; "Journey URL"; Text[250])
        {
        }
        field(8001404; "Journey URL 2"; Text[250])
        {
        }
        field(8001405; "ISO Code A3"; Code[3])
        {
        }
        field(8001406; "ISO Code N3"; Code[3])
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

