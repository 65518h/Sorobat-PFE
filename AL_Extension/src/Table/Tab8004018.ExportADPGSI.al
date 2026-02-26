Table 8004018 "Export ADP/GSI"
{
    // //ADPGSI CW 12/11/03 Mémoriser dernier export


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'N° séquence';
        }
        field(2; "From Date"; Date)
        {
            Caption = 'Date début';
        }
        field(3; "To Date"; Date)
        {
            Caption = 'Date fin';
        }
        field(4; "Job Ledger Entry No."; Integer)
        {
            Caption = 'N° Ecriture affaire';
        }
        field(5; "Employee Absence Entry No."; Integer)
        {
            Caption = 'N° Absence salarié';
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

