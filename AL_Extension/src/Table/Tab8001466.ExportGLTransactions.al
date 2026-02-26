Table 8001466 "Export G/L Transactions"
{
    // #5746 CW 03/10/08
    // //EXPORT GESWAY 02/07/03 Compte-rendu écritures comptables exportées

    Caption = 'Export G/L Transactions';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Source Code"; Text[10])
        {
            Caption = 'Source Code';
        }
        field(3; "Document No."; Text[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Account No."; Text[20])
        {
            Caption = 'Account No.';
        }
        field(5; "Debit Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Debit Amount';
        }
        field(6; "Credit Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Credit Amount';
        }
        field(7; Description; Text[40])
        {
            Caption = 'Description';
        }
        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(9; "Job No."; Text[20])
        {
            Caption = 'Job No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

