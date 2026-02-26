Table 8001440 "Bitmap Buffer"
{
    Caption = 'Bitmap Buffer';

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; Bitmap; Blob)
        {
            SubType = Bitmap;
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
}

