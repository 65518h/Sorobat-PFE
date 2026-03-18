Table 8001576 "Planning Header"
{
    //GL2024  ID dans Nav 2009 : "8035006"
    Caption = 'Planning Header';
    // DrillDownPageID = 8035002;
    // LookupPageID = 8035002;

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

            trigger OnValidate()
            begin
                lFieldCopy(FieldNo("Job No."));
            end;
        }
        field(50; "Last Date Modified"; DateTime)
        {
            CalcFormula = max("Planning Line"."Last Date Modified" where("Project Header No." = field("No.")));
            Caption = 'Last Date Modified';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; Exported; Boolean)
        {
            Caption = 'Exported';
        }
        field(55; Priority; Integer)
        {
            //blankzero = true;
            Caption = 'Priority';
        }
        field(80; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource."No." where(Type = const(Person));

            trigger OnValidate()
            begin
                lFieldCopy(FieldNo("Person Responsible"));
            end;
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
        field(1000; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';
            Editable = false;
        }
        field(5047; "Version No."; Integer)
        {
            CalcFormula = max("Planning Header Archive"."Version No." where("No." = field("No.")));
            Caption = 'Version No.';
            Editable = false;
            FieldClass = FlowField;
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
                lFieldCopy(FieldNo("Responsibility Center"));
            end;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
        key(STG_Key2; Type)
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lWBSMgt: Codeunit "WBS Management";
    begin
        gReleaseMgt.fTestProjectDoc(Rec);
        //Contrôle avant suppression et suppression des éléments liés
        lWBSMgt.OnDeleteAll(Rec);
    end;

    trigger OnInsert()
    begin
        gReleaseMgt.fTestProjectDoc(Rec);
        //Gestion du centre de gestion
        "Responsibility Center" := UserMgt.GetRespCenter(0, "Responsibility Center");
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate;
        if "No." = '' then begin
            PlanningSetup.Get();
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        gReleaseMgt.fTestProjectDoc(Rec);
    end;

    var
        PlanningSetup: Record "Planning Setup";
        NoSeriesMgt: Codeunit 396;
        Text001: label 'The project %1 already exists.';
        Text002: label 'Your identification is set up to process from %1 %2 only.';
        UserMgt: Codeunit "User Setup Management";
        Text003: label 'Wish you herited the %1 in planning task line';
        gReleaseMgt: Codeunit "Release Planning Task Mgt";


    procedure InitRecord()
    begin
        NoSeriesMgt.SetDefaultSeries("No. Series", PlanningSetup."Project Nos.");
        "Posting Date" := WorkDate;
        "Responsibility Center" := UserMgt.GetRespCenter(0, "Responsibility Center");
    end;


    procedure AssistEdit(OldProjectHeader: Record "Planning Header"): Boolean
    var
        ProjectHeader: Record "Planning Header";
        ProjectHeader2: Record "Planning Header";
    begin
        with ProjectHeader do begin
            Copy(Rec);
            PlanningSetup.Get();
            TestNoSeries;
            if NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldProjectHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                if ProjectHeader2.Get("No.") then
                    Error(Text001, "No.");
                Rec := ProjectHeader;
                exit(true);
            end;
        end;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        PlanningSetup.TestField("Project Nos.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        exit(PlanningSetup."Project Nos.");
    end;

    local procedure lFieldCopy(pFieldNo: Integer)
    var
        lRecordRef: RecordRef;
        lRecordRefHeader: RecordRef;
        lFieldRef: FieldRef;
        lFieldRefHeader: FieldRef;
        lPlanningLine: Record "Planning Line";
    begin
        lRecordRefHeader.GetTable(Rec);
        lFieldRefHeader := lRecordRefHeader.Field(pFieldNo);
        lRecordRef.GetTable(xRec);
        lFieldRef := lRecordRef.Field(pFieldNo);

        if lFieldRefHeader.Value <> lFieldRef.Value then begin
            lPlanningLine.SetCurrentkey("Project Header No.", "WBS Code");
            lPlanningLine.SetRange("Project Header No.", "No.");
            if not lPlanningLine.IsEmpty then
                if Confirm(Text003) then begin
                    lPlanningLine.FindSet(true, false);
                    repeat
                        lRecordRef.GetTable(lPlanningLine);
                        lFieldRef := lRecordRef.Field(pFieldNo);
                        lFieldRef.Validate(Format(lFieldRefHeader.Value));
                        lRecordRef.Modify;
                        lRecordRef.Close;
                    until lPlanningLine.Next = 0;
                end;
        end;
    end;
}

