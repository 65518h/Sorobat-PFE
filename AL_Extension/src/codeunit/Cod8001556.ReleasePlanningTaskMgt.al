Codeunit 8001556 "Release Planning Task Mgt"
{
    //GL2024  ID dans Nav 2009 : "8035009"
    TableNo = "Planning Header";

    trigger OnRun()
    var
        lArchiveMgt: Codeunit "Planning Task Archive Mgt";
    begin
        if rec.Status = rec.Status::Release then
            exit;
        fParamVerify(Rec);
        lCompressAllWLEntry(Rec);
        rec.Status := rec.Status::Release;
        fUpdatePlanningLinesStatus(Rec);
        if fProjectisFinish(Rec) then
            Rec.Type := Rec.Type::Finished;
        lArchiveMgt.StorePlanning(Rec);
        rec.Modify;
    end;

    var
        Text001: label 'You can''t modify this document because his status is released';
        Text002: label 'Vous ne pouvez pas lancer ce projet car le paramétrage du champ "%1" d''une des tâches est incomplet';


    procedure gReOpen(var pRec: Record "Planning Header")
    begin
        if (pRec.Status = pRec.Status::Open) then
            exit;
        pRec.Status := pRec.Status::Open;
        if not fProjectisFinish(pRec) then
            pRec.Type := pRec.Type::Scheduled;
        pRec.Modify;
        fUpdatePlanningLinesStatus(pRec);
    end;

    local procedure lCompressAllWLEntry(pRec: Record "Planning Header")
    var
        lTaskWorkLoad: Record "Planning Task Work Load";
        lTaskWorkLoad2: Record "Planning Task Work Load";
        PlanningLine: Record "Planning Line";
    begin
        lTaskWorkLoad.SetCurrentkey("Project Header No.", "WBS Code", "Task No.", Date, "Posting DateTime");
        lTaskWorkLoad.SetRange("Project Header No.", pRec."No.");
        lTaskWorkLoad.SetFilter("Posting DateTime", '%1', 0DT);
        lTaskWorkLoad.SetRange(Type, lTaskWorkLoad.Type::Allocated);
        lCompressWLEntry(lTaskWorkLoad);
    end;

    local procedure lCompressTaskWLEntry(pRec: Record "Planning Line")
    var
        lTaskWorkLoad: Record "Planning Task Work Load";
        lTaskWorkLoad2: Record "Planning Task Work Load";
        PlanningLine: Record "Planning Line";
    begin
        lTaskWorkLoad.SetCurrentkey("Project Header No.", "WBS Code", "Task No.", Date, "Posting DateTime");
        lTaskWorkLoad.SetRange("Project Header No.", pRec."Project Header No.");
        lTaskWorkLoad.SetRange("Project Header No.", pRec."Task No.");
        lTaskWorkLoad.SetFilter("Posting DateTime", '%1', 0DT);
        lTaskWorkLoad.SetRange(Type, lTaskWorkLoad.Type::Allocated);
        lCompressWLEntry(lTaskWorkLoad);
    end;

    local procedure lCompressWLEntry(var pTaskWorkLoad: Record "Planning Task Work Load")
    var
        lTaskWorkLoad2: Record "Planning Task Work Load";
        PlanningLine: Record "Planning Line";
    begin
        if pTaskWorkLoad.IsEmpty then
            exit;
        pTaskWorkLoad.FindSet(true, true);
        repeat
            if PlanningLine."Task No." <> pTaskWorkLoad."Task No." then begin
                if PlanningLine."Task No." <> '' then
                    lTaskWorkLoad2.Insert(true);
                PlanningLine.Get(pTaskWorkLoad."Task No.");
                lTaskWorkLoad2.Init;
                lTaskWorkLoad2."Project Header No." := PlanningLine."Project Header No.";
                lTaskWorkLoad2."Task No." := PlanningLine."Task No.";
                lTaskWorkLoad2.Date := CurrentDatetime;
                lTaskWorkLoad2."WBS Code" := PlanningLine."WBS Code";
                lTaskWorkLoad2."Posting DateTime" := CurrentDatetime;
            end;
            lTaskWorkLoad2."Work Load (h)" += pTaskWorkLoad."Work Load (h)";
        until pTaskWorkLoad.Next = 0;
        lTaskWorkLoad2.Insert(true);
        pTaskWorkLoad.DeleteAll;
    end;

    local procedure fParamVerify(pRec: Record "Planning Header")
    var
        PlanningLine: Record "Planning Line";
        planningSetup: Record "Planning Setup";
    begin
        //pRec.TESTFIELD("Job No.");
        planningSetup.Get();

        PlanningLine.SetRange("Project Header No.", pRec."No.");
        PlanningLine.SetFilter(Type, '<>%1&<>%2', PlanningLine.Type::" ", PlanningLine.Type::"Group Task");

        if planningSetup."Gen. Prod. Post Required" then begin
            PlanningLine.SetRange("Gen. Prod. Posting Group", '');
            if not PlanningLine.IsEmpty then
                Error(Text002, PlanningLine.FieldCaption("Gen. Prod. Posting Group"));
            PlanningLine.SetRange("Gen. Prod. Posting Group");
        end;
        if planningSetup."Work Type Code Required" then begin
            PlanningLine.SetRange("Work Type Code", '');
            if not PlanningLine.IsEmpty then
                Error(Text002, PlanningLine.FieldCaption("Work Type Code"));
            PlanningLine.SetRange("Work Type Code");
        end;
        if pRec.Type = pRec.Type::Scheduled then begin
            PlanningLine.SetRange("Person Responsible", '');
            if not PlanningLine.IsEmpty then
                Error(Text002, PlanningLine.FieldCaption("Person Responsible"));
            PlanningLine.SetRange("Person Responsible");
            PlanningLine.SetRange("Job No.", '');
            if not PlanningLine.IsEmpty then
                Error(Text002, PlanningLine.FieldCaption("Job No."));
            PlanningLine.SetRange("Job No.");
            PlanningLine.SetRange("Job Task No.", '');
            if not PlanningLine.IsEmpty then
                Error(Text002, PlanningLine.FieldCaption("Job Task No."));
            PlanningLine.SetRange("Job Task No.");
        end;
    end;


    procedure fTestProjectDoc(pRec: Record "Planning Header")
    begin
        if pRec.Status = pRec.Status::Open then
            exit;
        Error(Text001);
    end;


    procedure fTestProjectTask(pRec: Record "Planning Line")
    var
        lHeader: Record "Planning Header";
    begin
        if not lHeader.Get(pRec."Project Header No.") then
            exit;
        if (lHeader.Status = lHeader.Status::Open) or (lHeader.Type = lHeader.Type::Finished) then
            exit;
        Error(Text001);
    end;


    procedure fUpdatePlanningLinesStatus(pRec: Record "Planning Header")
    var
        PlanningLine: Record "Planning Line";
    begin
        PlanningLine.SetRange("Project Header No.", pRec."No.");
        PlanningLine.SetFilter(PlanningLine.Status, '<>%1', PlanningLine.Status::Finish);
        PlanningLine.ModifyAll(Status, pRec.Status);
    end;


    procedure fProjectisFinish(var pRec: Record "Planning Header") return: Boolean
    var
        lPlanningLine: Record "Planning Line";
    begin
        lPlanningLine.SetRange("Project Header No.", pRec."No.");
        lPlanningLine.SetFilter(Type, '%1|%2', lPlanningLine.Type::Task, lPlanningLine.Type::Milestome);
        lPlanningLine.SetFilter(Status, '<>%1', lPlanningLine.Status::Finish);
        return := lPlanningLine.IsEmpty;
    end;
}

