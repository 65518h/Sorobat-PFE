Table 70124 "Imp Description Line"
{

    fields
    {
        field(1; "Table ID"; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionMembers = "0","1","2","3","4";
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Document Line No."; Integer)
        {
        }
        field(5; "Description Type"; Option)
        {
            OptionMembers = External,Internal;
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[10])
        {
        }
        field(9; Description; Text[80])
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
        key(Key1; "Table ID", "Document Type", "Document No.", "Document Line No.", "Description Type", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

