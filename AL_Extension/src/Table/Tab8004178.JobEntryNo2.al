Table 8004178 "Job Entry No.2"
{
    Caption = 'Job Entry No.';
    PasteIsValid = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            Editable = false;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetNextEntryNo(): Integer
    begin
        LockTable;
        if not Get then
            Insert;
        "Entry No." := "Entry No." + 1;
        Modify;
        exit("Entry No.");
    end;
}

