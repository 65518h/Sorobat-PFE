Table 8001571 "Planning Task Pred. Archive"
{
    //GL2024  ID dans Nav 2009 : "8035000"
    // //PLANNING GESWAY 30/03/05 Mémorisation des prédécesseurs de project

    Caption = 'Planning Task Pred. Archive';

    fields
    {
        field(1; "Project Header"; Code[20])
        {
            Caption = 'Project Header No.';
            NotBlank = true;
            TableRelation = "Planning Header"."No.";
        }
        field(2; "Project Header Predecessor"; Code[20])
        {
            Caption = 'Project Header No.';
            NotBlank = true;
            TableRelation = "Planning Header"."No.";
        }
        field(3; "Task No."; Text[20])
        {
            Caption = 'Task No.';
            NotBlank = true;
            TableRelation = "Planning Line"."Task No." where("Project Header No." = field("Project Header"));
        }
        field(4; "Task No. Predecessor"; Text[20])
        {
            Caption = 'Predecessor Job Task No.';
            NotBlank = true;
            TableRelation = "Planning Line"."Task No." where("Project Header No." = field("Project Header Predecessor"));
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            InitValue = "Start-End";
            OptionCaption = 'Start-End,Start-Start,End-End,End-Start';
            OptionMembers = "Start-End","Start-Start","End-End","End-Start";
        }
        field(6; Late; Decimal)
        {
            Caption = 'Late';
            MaxValue = 1;
            MinValue = 0;
        }
        field(60; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(61; "Deleted Date"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(100; "Predecessor Description"; Text[80])
        {
            CalcFormula = lookup("Planning Line".Description where("Task No." = field("Task No. Predecessor")));
            Caption = 'Predecessor Description';
            FieldClass = FlowField;
        }
        field(101; "Task Description"; Text[80])
        {
            CalcFormula = lookup("Planning Line".Description where("Task No." = field("Task No.")));
            Caption = 'Predecessor Description';
            FieldClass = FlowField;
        }
        field(102; "Task Load"; Decimal)
        {
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header"),
                                                                               "Task No." = field("Task No."),
                                                                               Type = const(Allocated)));
            Caption = 'Task Load';
            FieldClass = FlowField;
        }
        field(103; "Task Load Predecessor"; Decimal)
        {
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header Predecessor"),
                                                                               "Task No." = field("Task No. Predecessor"),
                                                                               Type = const(Allocated)));
            Caption = 'Task Load';
            FieldClass = FlowField;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Version No. Predecessor"; Integer)
        {
            Caption = 'Version No.';
        }
    }

    keys
    {
        key(STG_Key1; "Project Header", "Task No.", "Version No.", "Project Header Predecessor", "Task No. Predecessor", "Version No. Predecessor")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

