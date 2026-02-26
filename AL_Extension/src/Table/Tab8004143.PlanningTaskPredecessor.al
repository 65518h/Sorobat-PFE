Table 8004143 "Planning Task Predecessor"
{
    // //PLANNING GESWAY 30/03/05 Mémorisation des prédécesseurs de project

    Caption = 'Job Task Predecessor';

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
        field(104; "No. of Resources"; Decimal)
        {
            CalcFormula = sum("Planning Task Assignment".Quantity where("Project Header No." = field("Project Header"),
                                                                         "Task No." = field(filter("Task No."))));
            Caption = 'No. of Resources';
            FieldClass = FlowField;
        }
        field(105; "No. of Predecessor"; Decimal)
        {
            CalcFormula = sum("Planning Task Assignment".Quantity where("Project Header No." = field("Project Header Predecessor"),
                                                                         "Task No." = field(filter("Task No. Predecessor"))));
            Caption = 'No. of Predecessor';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Project Header", "Task No.", "Project Header Predecessor", "Task No. Predecessor")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := CurrentDatetime;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := CurrentDatetime;
    end;
}

