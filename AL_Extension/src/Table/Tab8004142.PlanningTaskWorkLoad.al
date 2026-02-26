Table 8004142 "Planning Task Work Load"
{
    // //PLANNING_TASK CW 31/08/09

    Caption = 'Task Work Load';
    // DrillDownPageID = 8004144;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Header"."No.";
        }
        field(3; "Task No."; Text[20])
        {
            Caption = 'Task No.';
            TableRelation = "Planning Line"."Task No." where("Project Header No." = field("Project Header No."));
        }
        field(4; "Work Load (h)"; Decimal)
        {
            Caption = 'Work Load (h)';
        }
        field(5; Date; DateTime)
        {
            Caption = 'Date';
        }
        field(200; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Allocated,Updated';
            OptionMembers = Allocated,Updated;
        }
        field(204; "WBS Code"; Text[30])
        {
            Caption = 'WBS Code';
            Editable = false;
        }
        field(205; "Posting DateTime"; DateTime)
        {
            Caption = 'Posting DateTime';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            MaintainSIFTIndex = false;
        }
        key(Key2; "Project Header No.", "WBS Code", "Task No.", Date, "Posting DateTime", Type)
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = "Work Load (h)";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lPlanningLine: Record "Planning Line";
        lRec: Record "Planning Task Work Load";
        lReleasePlanMgt: Codeunit "Release Planning Task Mgt";
    begin
        Date := CurrentDatetime;

        lPlanningLine.Get("Task No.");
        "WBS Code" := lPlanningLine."WBS Code";
        if not HideStatusCtrl then
            lReleasePlanMgt.fTestProjectTask(lPlanningLine);

        if lRec.FindLast then;
        "Entry No." := lRec."Entry No." + 1;
    end;

    var
        HideStatusCtrl: Boolean;


    procedure SetHideStatusCtrl()
    begin
        HideStatusCtrl := true;
    end;
}

