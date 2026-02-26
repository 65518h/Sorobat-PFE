Table 8003504 "Entries to Distribue Buffer"
{
    // //+REP+ GESWAY 19/09/01 Nouvelle table de travail pour répartition analytique


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'General Ledger,Job';
            OptionMembers = "General Ledger",Job;
        }
        field(3; "Origin Entry No."; Integer)
        {
            Caption = 'Origin Entry No.';
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(6; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
        }
        field(7; "Job no."; Code[20])
        {
            Caption = 'Job no.';
        }
        field(8; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
        }
        field(9; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
        }
        field(10; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        field(11; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(12; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(13; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Resource,Item,Account (G/L)';
            OptionMembers = " ",Resource,Item,"Account (G/L)";
        }
        field(14; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(15; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';
        }
        field(16; "Resource Group No"; Code[20])
        {
            Caption = 'Resource Group No.';
        }
        field(17; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(18; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
        }
        field(22; "Job Entry Type"; Option)
        {
            Caption = 'Job Entry Type';
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(24; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(25; "Distribution Rule Code"; Code[20])
        {
            Caption = 'Analytical Distribution Rule Code';
        }
        field(27; "Shortcut Dimension 3 Code"; Code[20])
        {
            //CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
        }
        field(28; "Shortcut Dimension 4 Code"; Code[20])
        {
            //CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
        }
        field(29; "Shortcut Dimension 5 Code"; Code[20])
        {
            //CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
        }
        field(30; "Shortcut Dimension 6 Code"; Code[20])
        {
            //CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
        }
        field(31; "Shortcut Dimension 7 Code"; Code[20])
        {
            //CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
        }
        field(32; "Shortcut Dimension 8 Code"; Code[20])
        {
            //CaptionClass = '1,2,8';
            Caption = 'Shortcutl Dimension 8 Code';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code", "Job no.", "Reason Code", "Gen. Prod. Posting Group", "Gen. Bus. Posting Group", Type, "No.", "Job Posting Group", "Work Type Code", "Job Task No.", "Business Unit Code")
        {
        }
        key(Key3; "Entry Type", "Origin Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

