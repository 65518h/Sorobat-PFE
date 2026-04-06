Table 8001578 "Planning Task Buffer"
{
    //GL2024  ID dans Nav 2009 : "8035008"
    //                   Ajout d'un champ commentaire

    Caption = 'Planning Task Buffer';
    LinkedObject = false;

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
        field(4; "WBS Code"; Text[30])
        {
            Caption = 'WBS Code';

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
        field(7; Comment; Boolean)
        {
            CalcFormula = exist("Planning Task Comment Line" where("Project Header No." = field("Project Header No."),
                                                                    "Task No." = field("Task No.")));
            Caption = 'Comment';
            FieldClass = FlowField;
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
                                                                               Type = const(Allocated)));
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
            CalcFormula = lookup("Planning Header".Status where("No." = field("Project Header No.")));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
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
                                                                               Type = const(Allocated)));
            Caption = 'Work Load Totaling (h)';
            FieldClass = FlowField;
        }
        field(2011; "Number Of Resource Assign"; Decimal)
        {
            CalcFormula = sum("Planning Task Assignment".Quantity where("Task No." = field("Task No.")));
            Caption = 'Number Of Resource Assign';
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
        field(3001; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(3002; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
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
            Editable = false;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                RespCenter: Record "Responsibility Center";
            begin
                if not UserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      Text002,
                      RespCenter.TableCaption, UserMgt.GetSalesFilter);
            end;
        }
        field(8035000; "Period Planning Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Planning Task No." = field(filter("Task No.")),
                                                               Date = field("Date Filter"),
                                                               "Resource Group No." = field("Resource Group Filter"),
                                                               Status = filter(<> Deleted),
                                                               "Project Header No." = field("Project Header No.")));
            Caption = 'Period Planning Quantity';
            FieldClass = FlowField;
        }
        field(8035001; "Person Posted Time (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Quantity (Base)" where("Planning Task No." = field(filter("Task No.")),
                                                                           "Project Header No." = field("Project Header No.")));
            Caption = 'Person Posted Time (h)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8035002; "Planned Time (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Entry".Quantity where("Planning Task No." = field(filter("Task No.")),
                                                               "Resource Group No." = field("Resource Group Filter"),
                                                               Status = filter(<> Deleted),
                                                               "Project Header No." = field("Project Header No.")));
            Caption = 'Planned Time (h)';
            FieldClass = FlowField;

            trigger OnLookup()
            var
                lPlaningEntryTmp: Record "Planning Entry" temporary;


                //DYS page addon non migrer
                // lForm: Page 8004130;

                lPlaFilter: Record "Planning Filter Header";
            begin
                if "Task No." <> '' then
                    lPlaningEntryTmp.SetFilter("Planning Task No.", "Task No.");
                if GetFilter("Resource Group Filter") <> '' then
                    lPlaningEntryTmp.SetFilter("Resource Group No.", GetFilter("Resource Group Filter"));
                lPlaningEntryTmp.SetFilter(Status, '<>%1', lPlaningEntryTmp.Status::Deleted);
                lPlaningEntryTmp.SetRange("Project Header No.", "Project Header No.");

                // lForm.GetRecord(lPlaningEntryTmp);
                // lForm.SetTableview(lPlaningEntryTmp);
                // lForm.SetOnOpenForm();
                // lForm.SetShowHistory(false);

                // if lFORM.RunModal = Action::LookupOK then;

            end;
        }
        field(8035003; "Period Person Posted Time (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Res. Ledger Entry"."Quantity (Base)" where("Planning Task No." = field(filter("Task No.")),
                                                                           "Posting Date" = field("Date Filter"),
                                                                           "Project Header No." = field("Project Header No.")));
            Caption = 'Period Person Posted Time (h)';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Project Header No.", "WBS Code", "Task No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        // lWBSMgt: Codeunit "WBS Management";
        //  lPlanningLineMgt: Codeunit "Planning Task Management";
        lRec: Record "Planning Line";
    begin
    end;

    trigger OnInsert()
    var
    //  lWBSMgt: Codeunit "WBS Management";
    begin
    end;

    trigger OnModify()
    var
    // lProjectPlanMgt: Codeunit "Planning Task Management";
    begin
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        Text002: label 'Your identification is set up to process from %1 %2 only.';
}

