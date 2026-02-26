Table 8004181 "Job Difference Buffer2"
{
    Caption = 'Job Difference Buffer';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";
        }
        field(4; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(5; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(6; "Unit of Measure code"; Code[10])
        {
            Caption = 'Unit of Measure code';
        }
        field(7; "Entry type"; Option)
        {
            Caption = 'Entry type';
            OptionCaption = 'Schedule,Usage';
            OptionMembers = Schedule,Usage;
        }
        field(8; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
        }
        field(9; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(11; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
        }
        field(12; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
    }

    keys
    {
        key(Key1; "Job No.", "Job Task No.", Type, "Entry type", "No.", "Location Code", "Variant Code", "Unit of Measure code", "Work Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

