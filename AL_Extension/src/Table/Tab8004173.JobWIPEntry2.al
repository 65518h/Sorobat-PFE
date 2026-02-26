Table 8004173 "Job WIP Entry2"
{
    Caption = 'Job WIP Entry';
    //DrillDownPageID = 8004186;
    //LookupPageID = 8004186;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job2;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(5; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
        }
        field(6; "WIP Entry Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'WIP Entry Amount';
        }
        field(7; "Job Posting Group"; Code[10])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group2";
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'WIP Sales,WIP Costs,Recognized Costs,Recognized Sales,Accrued Costs,Accrued Sales';
            OptionMembers = "WIP Sales","WIP Costs","Recognized Costs","Recognized Sales","Accrued Costs","Accrued Sales";
        }
        field(9; "G/L Bal. Account No."; Code[20])
        {
            Caption = 'G/L Bal. Account No.';
            TableRelation = "G/L Account";
        }
        field(10; "WIP Method Used"; Option)
        {
            Caption = 'WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(11; "Job Complete"; Boolean)
        {
            Caption = 'Job Complete';
        }
        field(20; "WIP Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Cost)';
            Editable = false;
        }
        field(21; "WIP Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Price)';
            Editable = false;
        }
        field(22; "WIP Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Cost)';
            Editable = false;
        }
        field(23; "WIP Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Price)';
            Editable = false;
        }
        field(24; "WIP Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Cost)';
            Editable = false;
        }
        field(25; "WIP Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Price)';
            Editable = false;
        }
        field(26; "WIP (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Price)';
            Editable = false;
        }
        field(27; "WIP (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Cost)';
            Editable = false;
        }
        field(28; "WIP Posting Date Filter"; Text[250])
        {
            Caption = 'WIP Posting Date Filter';
            Editable = false;
        }
        field(29; "WIP Planning Date Filter"; Text[250])
        {
            Caption = 'WIP Planning Date Filter';
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Posting Group", "WIP Posting Date", Type, "Job Complete")
        {
            SumIndexFields = "WIP Entry Amount";
        }
        key(Key3; "G/L Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /* //GL2024   LedgerEntryDimension.SetRange("Table ID", Database::"Job WIP Entry2");
            LedgerEntryDimension.SetRange("Entry No.", "Entry No.");
            if not LedgerEntryDimension.IsEmpty then
                LedgerEntryDimension.DeleteAll;*/
    end;

    var
    //GL2024   LedgerEntryDimension: Record "Ledger Entry Dimension";
}

