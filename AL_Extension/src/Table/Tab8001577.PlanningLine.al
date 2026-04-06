Table 8001577 "Planning Line"
{
    //GL2024  ID dans Nav 2009 : "8035007"
    //                   Add FlowField comment

    Caption = 'Planning Task';
    //  DrillDownPageID = 8035008;
    // LookupPageID = 8035008;

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
            Editable = false;

            trigger OnValidate()
            var
                lWorkLoad: Record "Planning Task Work Load";
            begin
                lWorkLoad.SetRange("Task No.", "Task No.");
                if lWorkLoad.FindFirst then begin
                    lWorkLoad."Project Header No." := "Project Header No.";
                    lWorkLoad."WBS Code" := "WBS Code";
                    lWorkLoad.Modify;
                end;
            end;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            InitValue = Task;
            OptionCaption = ' ,Task,Group Task,Milestome';
            OptionMembers = " ",Task,"Group Task",Milestome;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if Type = Type::" " then
                    Error('');
            end;
        }
        field(6; Description; Text[80])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
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

            trigger OnValidate()
            begin
                if (xRec."Internal Reference" <> "Internal Reference") and ("Internal Reference" <> '') then
                    fControlRefInt(Rec);
            end;
        }
        field(10; "Work Load (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Task No." = field("Task No."),
                                                                               Type = const(Allocated),
                                                                               "Project Header No." = field("Project Header No.")));
            Caption = 'Work Load (h)';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
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
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Job No."));
                if ("Job Task No." <> xRec."Job Task No.") or not (lJobTask.Get("Job No.", "Job Task No.")) then
                    if ljob.Get("Job No.") then
                        "Job Task No." := ljob.gGetDefaultJobTask()
                    else
                        "Job Task No." := '';
            end;
        }
        field(50; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Starting Date"));
                fControleDate("Starting Date", "Ending Date");
            end;
        }
        field(51; "Ending Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Ending Date"));
                fControleDate("Starting Date", "Ending Date");
            end;
        }
        field(52; "Early Starting Date"; Date)
        {
            Caption = 'Early Starting Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Early Starting Date"));
                fControleDate("Starting Date", "Ending Date");
            end;
        }
        field(53; "Early Ending Date"; Date)
        {
            Caption = 'Early Ending Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Early Ending Date"));
                fControleDate("Early Starting Date", "Early Ending Date");
            end;
        }
        field(55; Priority; Integer)
        {
            //blankzero = true;
            Caption = 'Priority';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo(Priority));
            end;
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

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Gen. Prod. Posting Group"));
            end;
        }
        field(76; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Work Type Code"));
            end;
        }
        field(80; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource."No." where(Type = const(Person));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Person Responsible"));
            end;
        }
        field(81; "Actualize Work Load (h)"; Decimal)
        {
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header No."),
                                                                               "Task No." = field("Task No."),
                                                                               Type = filter(Allocated .. Updated)));
            FieldClass = FlowField;

            trigger OnValidate()
            var
                lWorkLoad: Record "Planning Task Work Load";
            begin
                lWorkLoad."Project Header No." := "Project Header No.";
                lWorkLoad."Task No." := "Task No.";
                lWorkLoad."Work Load (h)" := "Actualize Work Load (h)" - xRec."Actualize Work Load (h)";
                lWorkLoad.Type := lWorkLoad.Type::Updated;
                if lWorkLoad."Work Load (h)" <> 0 then
                    lWorkLoad.Insert(true);
            end;
        }
        field(100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(101; "Source Line No."; Integer)
        {
            CalcFormula = lookup("Planning Link Source ID"."Source Line No." where("Planning Task No." = field("Task No."),
                                                                                    "Source Record ID" = field("Source Record ID")));
            Caption = 'N° ligne document origine';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(102; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Release,Finish';
            OptionMembers = Open,Release,Finish;

            trigger OnValidate()
            begin
                if (xRec.Status <> Status) and (Status = Status::Release) then
                    Error(Text004);
                gProjectPlanMgt.fTaskFinish(Rec, "Task No.");
            end;
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

            trigger OnValidate()
            begin
                gProjectPlanMgt.wValidateField(Rec, FieldNo(Recurence));
            end;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = true;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Job No."));
                gProjectPlanMgt.wValidateField(Rec, FieldNo("Job Task No."));
            end;
        }
        field(2010; "Work Load Totaling (h)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Planning Task Work Load"."Work Load (h)" where("Project Header No." = field("Project Header No."),
                                                                               "WBS Code" = field(filter("WBS Code Filter"))));
            Caption = 'Work Load Totaling (h)';
            FieldClass = FlowField;
        }
        field(2011; "Use Res.Gpr"; Boolean)
        {
            CalcFormula = exist("Planning Task Assignment" where("Task No." = field("Task No."),
                                                                  Type = const("Resource Group"),
                                                                  "No." = field("Resource Grp Filter")));
            Caption = 'Use Ressource Group';
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
                if lWorkLoad.Get("Project Header No.", "Task No.") then begin
                    lWorkLoad."WBS Code" := "WBS Code";
                    lWorkLoad.Modify;
                end;
            end;
        }
        field(3001; "Resource Grp Filter"; Code[20])
        {
            Caption = 'Resource Grp Filter';
            FieldClass = FlowFilter;
        }
        field(5000; Dummy; Boolean)
        {
            Caption = 'Dummy';
            Editable = false;
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
                if not UserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      Text002,
                      RespCenter.TableCaption, UserMgt.GetSalesFilter);
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Task No.")
        {
        }
        key(STG_Key2; "Attached To Task No.")
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key3; "Project Header No.", "WBS Code")
        {
            //GL2024   Clustered = true;
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lWBSMgt: Codeunit "WBS Management";
        lPlanningLineMgt: Codeunit "Planning Task Management";
        lRec: Record "Planning Line";
    begin
        TestField(Status, Status::Open);
        //gReleasePlanMgt.fTestProjectTask(Rec);
        //Suppression des éléments liés
        lPlanningLineMgt.gOnDelete(Rec);
        //Gestion du code WBS
        lWBSMgt.OnDelete(Rec);
    end;

    trigger OnInsert()
    var
        lWBSMgt: Codeunit "WBS Management";
    begin
        //TESTFIELD(Status,Status::Open);
        //gReleasePlanMgt.fTestProjectTask(Rec);
        //Génération du N°
        "Task No." := fTaskNo(Rec);
        // Gestion du code WBS
        lWBSMgt.OnInsert(Rec, true);
    end;

    trigger OnModify()
    var
        lProjectPlanMgt: Codeunit "Planning Task Management";
    begin
        //gReleasePlanMgt.fTestProjectTask(Rec);
        //lProjectPlanMgt.wUpdateGroupTask(Rec,xRec);
        "Last Date Modified" := CurrentDatetime;
    end;

    var
        gProjectPlanMgt: Codeunit "Planning Task Management";
        Text002: label 'Your identification is set up to process from %1 %2 only.';
        Text001: label 'La date de début ne peut être supérieur à la date de fin';
        //gReleasePlanMgt: Codeunit "Release Planning Task Mgt";
        Text003: label 'Vous ne pouvez pas utiliser deux fois le même numéro interne dans le document';
        Text004: label 'You must use the function "release" of  document';


    procedure fTaskNo(pRec: Record "Planning Line") return: Code[20]
    var
        lRec: Record "Planning Line";
        lPlanningSetup: Record "Planning Setup";
        lWBSMgt: Codeunit "WBS Management";
    begin
        lPlanningSetup.Get();
        lPlanningSetup.TestField("Task Nos.");
        lRec."Task No." := StrSubstNo('%1', lPlanningSetup."Task Nos.");
        return := fTaskNoGenB36(lRec."Task No.");
        lPlanningSetup."Task Nos." := return;
        lPlanningSetup.Modify;
    end;

    local procedure fTaskNoGenB36(pCode: Text[20]) return: Text[20]
    var
        i: Integer;
        lIncG: Integer;
    begin
        return := pCode;
        i := StrLen(return);
        lIncG := 1;
        while (i > 0) and (lIncG = 1) do begin
            if (return[i] = '9') then begin
                return[i] := 'A';
                lIncG := 0;
            end else
                if (return[i] >= 'Z') then begin
                    lIncG := 1;
                    return[i] := '0';
                end else begin
                    return[i] += lIncG;
                    lIncG := 0;
                end;
            i -= 1;
        end;
    end;

    local procedure fControleDate(pStartingDate: Date; pEndingDate: Date)
    begin
        if (("Ending Date" = 0D) or (pStartingDate = 0D)) then
            exit;
        if (pStartingDate > pEndingDate) then
            Error(Text001)
    end;


    procedure fControlRefInt(pRec: Record "Planning Line")
    var
        lPlaningLine: Record "Planning Line";
    begin
        lPlaningLine.SetCurrentkey("Project Header No.", "WBS Code");
        lPlaningLine.SetRange("Project Header No.", pRec."Project Header No.");
        lPlaningLine.SetRange("Internal Reference", pRec."Internal Reference");
        if not lPlaningLine.IsEmpty then
            Error(Text003);
    end;


    procedure fTaskFinish(var pTask: Record "Planning Line"; pTaskNo: Code[20]; pFinish: Boolean)
    var
        lPlanningLine: Record "Planning Line";
    begin
        if pFinish then
            pTask.Status := pTask.Status::Finish
        else
            pTask.Status := pTask.Status::Open;

        pTask.Modify(true);
        if pTask."Task No." = pTaskNo then
            fCheckTaskAscendant(pTask);
        if pTask.Type = pTask.Type::"Group Task" then begin
            lPlanningLine.SetRange("Attached To Task No.", pTask."Task No.");
            if lPlanningLine.Find('-') then
                repeat
                    fTaskFinish(lPlanningLine, pTaskNo, pFinish);
                until lPlanningLine.Next = 0;
        end;
    end;


    procedure fCheckTaskAscendant(var pTask: Record "Planning Line")
    var
        lPlanningLine: Record "Planning Line";
    begin
        if (pTask."Attached To Task No." <> '') then begin
            lPlanningLine.Get(pTask."Attached To Task No.");
            case pTask.Status of
                pTask.Status::Open:
                    begin
                        lPlanningLine.Status := pTask.Status;
                        lPlanningLine.Modify(true);
                        fCheckTaskAscendant(lPlanningLine);
                    end;
                pTask.Status::Finish:
                    begin
                        if fCheckTaskAscendantIsFinish(lPlanningLine) then begin
                            lPlanningLine.Status := pTask.Status;
                            lPlanningLine.Modify(true);
                            fCheckTaskAscendant(lPlanningLine);
                        end;
                    end;
            end;
        end;
    end;


    procedure fCheckTaskAscendantIsFinish(var pTask: Record "Planning Line") return: Boolean
    var
        lPlanningLine: Record "Planning Line";
    begin
        lPlanningLine.SetRange("Attached To Task No.", pTask."Task No.");
        lPlanningLine.SetFilter(Status, '<>%1', Status::Finish);
        exit(lPlanningLine.IsEmpty);
    end;
}

