Table 8001580 "Planning Line Archive"
{
    //GL2024  ID dans Nav 2009 : "8035010"
    Caption = 'Planning Task Archive';
    // DrillDownPageID = 8035013;
    // LookupPageID = 8035013;

    fields
    {
        field(1; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = "Planning Task Assign Archive"."Project Header No.";
        }
        field(3; "Task No."; Text[20])
        {
            Caption = 'Task No.';
        }
        field(4; "WBS Code"; Text[30])
        {
            Caption = 'WBS Code';
            Editable = false;

            trigger OnValidate()
            var
                lWorkLoad: Record "Planning Task Work Load";
            begin
            end;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            InitValue = Task;
            OptionCaption = ' ,Task,Group Task,Milestome';
            OptionMembers = " ",Task,"Group Task",Milestome;
        }
        field(6; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(8; "Internal Reference"; Code[10])
        {
            Caption = 'Internal Reference';
        }
        field(10; "Work Load (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header No."),
                                                                               "Task No." = field("Task No."),
                                                                               Type = const(Allocated),
                                                                               Date = field("Date Filter")));
            Caption = 'Work Load (h)';
            FieldClass = FlowField;
        }
        field(11; "Remained Load (h)"; Decimal)
        {
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Task No." = field("Task No."),
                                                                               "Project Header No." = field("Project Header No.")));
            Caption = 'Remained Load (h)';
            FieldClass = FlowField;
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                lJobTask: Record "Job Task";
                ljob: Record Job;
            begin
            end;
        }
        field(50; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(51; "Ending Date"; Date)
        {
            Caption = 'End Date';
        }
        field(52; "Early Starting Date"; Date)
        {
            Caption = 'Early Starting Date';
        }
        field(53; "Early Ending Date"; Date)
        {
            Caption = 'Early Ending Date';
        }
        field(55; Priority; Integer)
        {
            //blankzero = true;
            Caption = 'Priority';
        }
        field(60; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(61; "Deleted Date"; DateTime)
        {
            Caption = 'Deleted Date';
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(76; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(80; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';
        }
        field(101; "Document Line No."; Integer)
        {
            Caption = 'N° ligne document';
        }
        field(102; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(103; Progress; Option)
        {
            Caption = 'Progress';
            Editable = false;
            OptionCaption = ' ,Pending, In Progress, Completed';
            OptionMembers = " ",Pending," In Progress"," Completed";
        }
        field(109; "Archive Date"; DateTime)
        {
            Caption = 'Archive Date';
        }
        field(200; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(201; "Attached To Task No."; Text[20])
        {
            Caption = 'Attached To Line No.';
        }
        field(300; Recurence; Boolean)
        {
            Caption = 'Recurence';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = true;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(2010; "Work Load Totaling (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header No."),
                                                                               "WBS Code" = field(filter("WBS Code Filter")),
                                                                               Date = field("Date Filter")));
            Caption = 'Work Load Totaling (h)';
            FieldClass = FlowField;
        }
        field(3000; "WBS Code Filter"; Text[30])
        {
            Caption = 'WBS Code Filter';
            Editable = false;
            FieldClass = FlowFilter;

            trigger OnLookup()
            var
                lWorkLoad: Record "Planning Task Work Load";
            begin
            end;
        }
        field(3001; "Date Filter"; DateTime)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5000; Dummy; Boolean)
        {
            Caption = 'Dummy';
            Editable = false;
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
                UserMgt: Codeunit "User Setup Management";
                RespCenter: Record "Responsibility Center";
            begin
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Task No.", "Version No.")
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key2; "Attached To Task No.")
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key3; "Project Header No.", "WBS Code", "Version No.")
        {
            //GL2024  Clustered = true;
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        //  lWBSMgt: Codeunit "WBS Management";
        // lPlanningLineMgt: Codeunit "Planning Task Management";
        lRec: Record "Planning Line";
    begin
    end;

    trigger OnInsert()
    var
    //   lWBSMgt: Codeunit "WBS Management";
    begin
    end;

    trigger OnModify()
    var
    // lProjectPlanMgt: Codeunit "Planning Task Management";
    begin
    end;

    var
        Text002: label 'Your identification is set up to process from %1 %2 only.';
        Text001: label 'La date de début ne peut être supérieur à la date de fin';
}

