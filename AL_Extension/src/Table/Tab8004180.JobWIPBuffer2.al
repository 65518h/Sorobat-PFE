Table 8004180 "Job WIP Buffer2"
{
    Caption = 'Job WIP Buffer';

    fields
    {
        field(1; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'WIP Sales,WIP Costs,Recognized Costs,Recognized Sales,Accrued Costs,Accrued Sales';
            OptionMembers = "WIP Sales","WIP Costs","Recognized Costs","Recognized Sales","Accrued Costs","Accrued Sales";
        }
        field(3; "WIP Entry Amount"; Decimal)
        {
            Caption = 'WIP Entry Amount';
        }
        field(4; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(5; "Bal. G/L Account No."; Code[20])
        {
            Caption = 'Bal. G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(6; "WIP Method"; Option)
        {
            Caption = 'WIP Method';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(7; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            NotBlank = true;
            TableRelation = Job2;
        }
        field(8; "Job Complete"; Boolean)
        {
            Caption = 'Job Complete';
        }
        field(10; "WIP Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Cost)';
            Editable = false;
        }
        field(11; "WIP Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Price)';
            Editable = false;
        }
        field(12; "WIP Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Cost)';
            Editable = false;
        }
        field(13; "WIP Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Price)';
            Editable = false;
        }
        field(14; "WIP Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Cost)';
            Editable = false;
        }
        field(15; "WIP Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Price)';
            Editable = false;
        }
        field(16; "WIP (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Price)';
            Editable = false;
        }
        field(17; "WIP (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Cost)';
            Editable = false;
        }
        field(18; "WIP Posting Date Filter"; Text[250])
        {
            Caption = 'WIP Posting Date Filter';
            Editable = false;
        }
        field(19; "WIP Planning Date Filter"; Text[250])
        {
            Caption = 'WIP Planning Date Filter';
            Editable = false;
        }
        field(71; "Dim Combination ID"; Integer)
        {
            Caption = 'Dim Combination ID';
        }
    }

    keys
    {
        key(STG_Key1; "Job No.", "Posting Group", Type, "G/L Account No.", "Dim Combination ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

