Table 8004140 "Planning Task Comment Line"
{
    // //TACHES CW 01/12/99 New

    Caption = 'Task Comment Line';
    //DrillDownPageID = 59803;
    //LookupPageID = 59803;

    fields
    {
        field(1; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Header"."No.";
        }
        field(3; "Task No."; Text[20])
        {
            Caption = 'Task No.';
        }
        field(4; "Comment Line No."; Integer)
        {
            Caption = 'Comment Line No.';
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Project Header No.", "Task No.", "Comment Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

