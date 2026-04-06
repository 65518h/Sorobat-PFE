Table 70117 "Imp Extended Text Line"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = "Standard Text","G/L Account",Item,Resource,Mission;
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; "Language Code"; Code[10])
        {
        }
        field(4; "Text No."; Integer)
        {
        }
        field(5; "Line No."; Integer)
        {
        }
        field(6; Text; Text[50])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(8001400; Separator; Integer)
        {
        }
        field(8001401; "Text 2"; Text[50])
        {
        }
        field(8001402; Style; Option)
        {
            OptionMembers = Normal,Bold,Reduced;
        }
    }

    keys
    {
        key(STG_Key1; "Table Name", "No.", "Language Code", "Text No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

