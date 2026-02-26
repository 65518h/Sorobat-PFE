Table 8001424 Sort
{
    // //+BGW+SORT CW 29/07/04 Sort Table

    Caption = 'Sort';

    fields
    {
        field(1; DateTime; DateTime)
        {
        }
        field(4; "Entry No."; Integer)
        {
        }
        field(5; RecID; RecordID)
        {
        }
        field(11; "Key 1"; Text[30])
        {
        }
        field(12; "Key 2"; Text[30])
        {
        }
        field(13; "Key 3"; Text[30])
        {
        }
        field(14; "Key 4"; Text[30])
        {
        }
        field(15; "Key 5"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; DateTime, "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; DateTime, "Key 1", "Key 2", "Key 3", "Key 4", "Key 5")
        {
        }
    }

    fieldgroups
    {
    }
}

