Table 8001465 "Export G/L Account"
{
    // #5746 CW 03/10/08
    // //EXPORT GESWAY 02/07/03 Export écritures comptabilité. Historique Export

    Caption = 'Export G/L Account';
    //DrillDownPageID = 8001465;
    //LookupPageID = 8001465;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(3; "Starting Entry No."; Integer)
        {
            Caption = 'Starting Entry No.';
        }
        field(4; "End Entry No."; Integer)
        {
            Caption = 'End Entry No.';
        }
        field(6; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(8; "Creation Time"; Time)
        {
            Caption = 'Time';
        }
        field(9; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Source Code")
        {
        }
    }

    fieldgroups
    {
    }
}

