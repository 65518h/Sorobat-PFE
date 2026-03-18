Table 8004166 "Job Posting Buffer2"
{
    Caption = 'Job Posting Buffer';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job2;
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(3; "Posting Group Type"; Option)
        {
            Caption = 'Posting Group Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = "Job Posting Group2";
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(9; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(20; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(21; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost';
        }
        field(23; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        field(24; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(25; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(26; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(27; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
        }
        field(28; "Dimension Entry No."; Integer)
        {
            Caption = 'Dimension Entry No.';
        }
        field(29; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
    }

    keys
    {
        key(STG_Key1; "Job No.", "Entry Type", "Posting Group Type", "No.", "Variant Code", "Posting Group", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "Unit of Measure Code", "Work Type Code", "Dimension Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

