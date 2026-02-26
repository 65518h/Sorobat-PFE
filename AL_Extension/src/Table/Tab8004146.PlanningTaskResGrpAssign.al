Table 8004146 "Planning Task Res. Grp. Assign"
{
    // //PLANNING_TASK CW 31/08/09

    Caption = 'Job Task Allocation';
    // DrillDownPageID = 8035006;
    // LookupPageID = 8035006;

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
        field(5; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            NotBlank = true;
            TableRelation = "Resource Group"."No." where(Type = filter(Person .. Machine));
        }
        field(6; "Skill No."; Code[20])
        {
            Caption = 'Skill No.';
            TableRelation = "Planning Skill".Code;
        }
        field(10; Description; Text[50])
        {
            CalcFormula = lookup("Planning Skill".Description where(Code = field("Skill No.")));
            Caption = 'Description';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Task No.", "Resource Group No.", "Skill No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(Key2; "Project Header No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(tRenameNotAllowed);
    end;

    var
        tRenameNotAllowed: label 'Affectation non modifiable. Supprimez cette ligne et ajoutez la nouvelle.';
}

