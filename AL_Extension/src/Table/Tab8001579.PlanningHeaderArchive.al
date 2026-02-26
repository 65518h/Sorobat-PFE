Table 8001579 "Planning Header Archive"
{
    //GL2024  ID dans Nav 2009 : "8035009"
    Caption = 'Project Plan Header';
    // DrillDownPageID = 8035009;
    //LookupPageID = 8035009;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(50; "Last Modified Date"; DateTime)
        {
            CalcFormula = max("Planning Line"."Last Date Modified" where("Project Header No." = field("No.")));
            Caption = 'Last Date Modified';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; Exported; Boolean)
        {
        }
        field(55; Priority; Integer)
        {
            //blankzero = true;
            Caption = 'Priority';
        }
        field(80; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(100; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Simulation,Scheduled,Finished';
            OptionMembers = Simulation,Scheduled,Finished;
        }
        field(101; "Last Date Exported"; DateTime)
        {
            Caption = 'Last Date Exported';
        }
        field(102; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(109; "Archive Date"; DateTime)
        {
            Caption = 'Archive Date';
        }
        field(200; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                RespCenter: Record "Responsibility Center";
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "No.", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        // lWBSMgt: Codeunit "WBS Management";
        lPlanningLineArch: Record "Planning Line Archive";
        lPlanningLineAssignArch: Record "Planning Task Assign Archive";
    begin
        lPlanningLineArch.SetRange(lPlanningLineArch."Project Header No.", "No.");
        lPlanningLineArch.SetRange("Version No.", "Version No.");
        if not lPlanningLineArch.IsEmpty then
            lPlanningLineArch.DeleteAll;
        lPlanningLineAssignArch.SetRange("Project Header No.", "No.");
        lPlanningLineAssignArch.SetRange("Version No.", "Version No.");
        if not lPlanningLineAssignArch.IsEmpty then
            lPlanningLineAssignArch.DeleteAll;
    end;
}

