Table 70108 "Imp Comment Line"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,Item,Resource,Job,,"Resource Group","Bank Account",Campaign,"Fixed Asset",Insurance,"Nonstock Item","IC Partner";
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; "Code"; Code[10])
        {
        }
        field(6; Comment; Text[80])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

