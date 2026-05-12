Codeunit 8001552 "Planning Task Archive Mgt"
{
    //GL2024  ID dans Nav 2009 : "8035005"
    trigger OnRun()
    begin
    end;

    var
        Text001: label 'Vous ne pouvez pas archiver un document vide';
        Text002: label 'ATTENTION\ cette opération est définiive\ \ Souhaitez vous compresser vos archives';
        Text003: label 'Traitement interrompu';
        Text004: label 'Vous ne pouvez pas compresser des archives liées à un projet actif';


    procedure StorePlanning(var pRec: Record "Planning Header")
    var
        lTaskHeaderArchive: Record "Planning Header Archive";
    begin
        pRec.CalcFields("Version No.");

        lTaskHeaderArchive.SetRange("No.", pRec."No.");
        lTaskHeaderArchive.ModifyAll(Active, false);
        lTaskHeaderArchive.Reset;
        lTaskHeaderArchive.Init;

        lTaskHeaderArchive.TransferFields(pRec, true);
        lTaskHeaderArchive."Version No." := pRec."Version No." + 1;
        lTaskHeaderArchive."Archive Date" := CurrentDatetime;
        lTaskHeaderArchive.Active := true;
        lTaskHeaderArchive.Insert;


        //gestion des tâches
        lStoreTask(pRec, lTaskHeaderArchive);

        //gestion des affectations
        lStoreAssignTask(pRec, lTaskHeaderArchive);
        //Gestion des predecesseurs
        lStorePredTask(pRec, lTaskHeaderArchive);
    end;


    procedure CompressArchive(var pRec: Record "Planning Header Archive")
    var
        lTaskHeader: Record "Planning Header";
        lTaskHeaderArch: Record "Planning Header Archive";
        lTaskArchive: Record "Planning Line Archive";
        lTaskAssignArchive: Record "Planning Task Assign Archive";
        lTaskWorkLoad: Record "Planning Task Work Load";
        lTaskWorkLoad2: Record "Planning Task Work Load";
    begin
        //Fonction de compression des archives
        //cette focntion permet de conserver une seule version des archives et d'en limiter la taille.

        //Test si le projet est actif
        //IF lTaskHeader.GET(pRec."No.") THEN
        //  ERROR(Text004);

        if not Confirm(Text002) then
            Error(Text003);

        pRec.SetRange("No.", pRec."No.");
        pRec.FindLast;

        //Suppresion des vieilles archives
        lTaskHeaderArch.SetRange("No.", pRec."No.");
        lTaskHeaderArch.SetFilter("Version No.", '<%1', pRec."Version No.");
        if lTaskHeaderArch.IsEmpty then
            exit;
        lTaskHeaderArch.DeleteAll;

        //Compression des tâches
        lTaskArchive.SetRange("Project Header No.", pRec."No.");
        lTaskArchive.SetFilter("Deleted Date", '<>%1', 0DT);
        if not lTaskArchive.IsEmpty then begin
            lTaskArchive.DeleteAll;
        end;

        lTaskArchive.SetRange("Deleted Date");
        lTaskArchive.ModifyAll("Archive Date", pRec."Archive Date");

        //Compression des ressources et rôle alloué
        lTaskAssignArchive.SetRange("Project Header No.", pRec."No.");
        lTaskAssignArchive.SetFilter("Deleted Date", '<>%1', 0DT);
        if not lTaskAssignArchive.IsEmpty then
            lTaskAssignArchive.DeleteAll;

        //Compression charge
        lTaskArchive.SetRange("Deleted Date");
        if lTaskArchive.FindSet(true, true) then
            repeat
                //Compression charge type Alloué
                lTaskWorkLoad.SetCurrentkey("Project Header No.", "WBS Code", "Task No.", Date, "Posting DateTime", Type);
                lTaskWorkLoad.SetRange("Project Header No.", pRec."No.");
                lTaskWorkLoad.SetRange("Task No.", lTaskArchive."Task No.");
                lTaskWorkLoad.SetRange(Type, lTaskWorkLoad.Type::Allocated);
                lTaskWorkLoad.CalcSums("Work Load (h)");

                lTaskWorkLoad2.SetHideStatusCtrl();
                lTaskWorkLoad2."Project Header No." := pRec."No.";
                lTaskWorkLoad2."Task No." := lTaskArchive."Task No.";
                lTaskWorkLoad2."Work Load (h)" := lTaskWorkLoad."Work Load (h)";
                lTaskWorkLoad2.Type := lTaskWorkLoad.Type::Allocated;
                lTaskWorkLoad2.Date := pRec."Archive Date";
                lTaskWorkLoad2."WBS Code" := lTaskArchive."WBS Code";
                lTaskWorkLoad2."Posting DateTime" := pRec."Archive Date";


                lTaskWorkLoad.DeleteAll;
                if lTaskWorkLoad2."Work Load (h)" <> 0 then begin
                    lTaskWorkLoad2.Insert(true);
                    lTaskWorkLoad2.Date := pRec."Archive Date";
                    lTaskWorkLoad2.Modify;
                end;
                //Compression charge type Actualisé
                lTaskWorkLoad.SetRange(Type, lTaskWorkLoad.Type::Updated);
                lTaskWorkLoad.CalcSums("Work Load (h)");

                lTaskWorkLoad2.SetHideStatusCtrl();
                lTaskWorkLoad2."Project Header No." := pRec."No.";
                lTaskWorkLoad2."Task No." := lTaskArchive."Task No.";
                lTaskWorkLoad2."Work Load (h)" := lTaskWorkLoad."Work Load (h)";
                lTaskWorkLoad2.Type := lTaskWorkLoad.Type::Updated;
                lTaskWorkLoad2.Date := pRec."Archive Date";
                lTaskWorkLoad2."WBS Code" := lTaskArchive."WBS Code";
                lTaskWorkLoad2."Posting DateTime" := pRec."Archive Date";

                lTaskWorkLoad.DeleteAll;
                if lTaskWorkLoad2."Work Load (h)" <> 0 then begin
                    lTaskWorkLoad2.Insert(true);
                    lTaskWorkLoad2.Date := pRec."Archive Date";
                    lTaskWorkLoad2.Modify;
                end;

            until lTaskArchive.Next = 0;
    end;

    local procedure lStoreAssignTask(pRec: Record "Planning Header"; pTaskHeaderArchive: Record "Planning Header Archive")
    var
        lTaskAssign: Record "Planning Task Assignment";
        lTaskAssignArchive: Record "Planning Task Assign Archive";
    begin
        lTaskAssignArchive.SetRange("Project Header No.", pRec."No.");
        lTaskAssignArchive.SetFilter("Deleted Date", '%1|>%2', 0DT, pTaskHeaderArchive."Archive Date");
        lTaskAssignArchive.SetFilter("Version No.", '..%1', pTaskHeaderArchive."Version No." - 1);
        if lTaskAssignArchive.FindSet(false, false) then
            repeat
                lTaskAssignArchive.Mark(true);
            until lTaskAssignArchive.Next = 0;

        //Traitement des Ajouts et modifications
        lTaskAssign.SetRange("Project Header No.", pRec."No.");
        if not lTaskAssign.IsEmpty then begin
            lTaskAssign.FindSet(true, true);
            repeat
                lTaskAssignArchive.SetRange("Task No.", lTaskAssign."Task No.");
                lTaskAssignArchive.SetRange(Type, lTaskAssign.Type);
                lTaskAssignArchive.SetRange("No.", lTaskAssign."No.");
                //ajout
                if not lTaskAssignArchive.FindFirst then begin
                    lTaskAssignArchive.TransferFields(lTaskAssign, true);
                    lTaskAssignArchive."Version No." := pTaskHeaderArchive."Version No.";
                    lTaskAssignArchive.Insert;
                    //Modification
                end else
                    if lTaskAssignArchive."Last Date Modified" <> lTaskAssign."Last Date Modified" then begin
                        lTaskAssignArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                        lTaskAssignArchive.Modify;
                        lTaskAssignArchive.TransferFields(lTaskAssign, true);
                        lTaskAssignArchive."Version No." := pTaskHeaderArchive."Version No.";
                        lTaskAssignArchive.Insert;
                    end else
                        lTaskAssignArchive.Mark(false);
            until lTaskAssign.Next = 0;
        end;
        //Traitement des suppressions
        lTaskAssignArchive.SetRange("Task No.");
        lTaskAssignArchive.SetRange(Type);
        lTaskAssignArchive.SetRange("No.");
        lTaskAssignArchive.MarkedOnly(true);
        if not lTaskAssignArchive.IsEmpty then begin
            lTaskAssignArchive.FindSet(true, false);
            repeat
                lTaskAssignArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                lTaskAssignArchive.Modify;
            until lTaskAssignArchive.Next = 0;
        end;
    end;

    local procedure lStorePredTask(pRec: Record "Planning Header"; pTaskHeaderArchive: Record "Planning Header Archive")
    var
        lTaskPred: Record "Planning Task Predecessor";
        lTaskPredArchive: Record "Planning Task Pred. Archive";
    begin
        lTaskPredArchive.SetRange("Project Header", pRec."No.");
        lTaskPredArchive.SetFilter("Deleted Date", '%1|>%2', 0DT, pTaskHeaderArchive."Archive Date");
        lTaskPredArchive.SetFilter("Version No.", '..%1', pTaskHeaderArchive."Version No." - 1);
        if lTaskPredArchive.FindSet(false, false) then
            repeat
                lTaskPredArchive.Mark(true);
            until lTaskPredArchive.Next = 0;

        //Traitement des Ajouts et modifications
        lTaskPred.SetRange("Project Header", pRec."No.");
        if not lTaskPred.IsEmpty then begin
            lTaskPred.FindSet(true, true);
            repeat
                lTaskPredArchive.SetRange("Task No.", lTaskPred."Task No.");
                //ajout
                if not lTaskPredArchive.FindFirst then begin
                    lTaskPredArchive.Init;
                    lTaskPredArchive.TransferFields(lTaskPred, true);
                    lTaskPredArchive."Version No." := pTaskHeaderArchive."Version No.";
                    lTaskPredArchive.Insert;
                    //Modification
                end else
                    if lTaskPredArchive."Last Date Modified" <> lTaskPred."Last Date Modified" then begin
                        lTaskPredArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                        lTaskPredArchive.Modify;

                        lTaskPredArchive.Init;
                        lTaskPredArchive.TransferFields(lTaskPred, true);
                        lTaskPredArchive."Version No." := pTaskHeaderArchive."Version No.";
                        lTaskPredArchive.Insert;
                    end else
                        lTaskPredArchive.Mark(false);
            until lTaskPred.Next = 0;
        end;
        //Traitement des suppressions
        lTaskPredArchive.SetRange("Task No.");
        lTaskPredArchive.MarkedOnly(true);
        if not lTaskPredArchive.IsEmpty then begin
            lTaskPredArchive.FindSet(true, false);
            repeat
                lTaskPredArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                lTaskPredArchive.Modify;
            until lTaskPredArchive.Next = 0;
        end;
    end;

    local procedure lStoreTask(pRec: Record "Planning Header"; pTaskHeaderArchive: Record "Planning Header Archive")
    var
        PlanningLine: Record "Planning Line";
        lTaskArchive: Record "Planning Line Archive";
    begin
        PlanningLine.SetRange("Project Header No.", pRec."No.");
        if PlanningLine.IsEmpty then
            Error(Text001);

        lTaskArchive.SetRange("Project Header No.", pRec."No.");
        lTaskArchive.SetFilter("Version No.", '..%1', pTaskHeaderArchive."Version No." - 1);
        lTaskArchive.SetFilter("Deleted Date", '%1|>%2', 0DT, pTaskHeaderArchive."Archive Date");

        if not lTaskArchive.IsEmpty then begin
            lTaskArchive.FindSet(false, false);
            repeat
                lTaskArchive.Mark(true);
            until lTaskArchive.Next = 0;
        end;

        //Traitement des Ajouts et modifications
        PlanningLine.FindSet(true, true);
        repeat
            lTaskArchive.SetRange("Task No.", PlanningLine."Task No.");
            //ajout
            if (lTaskArchive.IsEmpty) then begin
                lTaskArchive.Init;
                lTaskArchive.TransferFields(PlanningLine, true);
                lTaskArchive."Version No." := pTaskHeaderArchive."Version No.";
                lTaskArchive."Archive Date" := pTaskHeaderArchive."Archive Date";
                lTaskArchive.Insert;
                //Modification
            end else
                if (lTaskArchive.FindLast) then begin
                    if (PlanningLine."Last Date Modified" <> lTaskArchive."Last Date Modified") then begin
                        lTaskArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                        lTaskArchive.Modify;

                        lTaskArchive.Init;
                        lTaskArchive.TransferFields(PlanningLine, true);
                        lTaskArchive."Version No." := pTaskHeaderArchive."Version No.";
                        lTaskArchive."Archive Date" := pTaskHeaderArchive."Archive Date";
                        lTaskArchive.Insert;
                    end else
                        lTaskArchive.Mark(false);
                end;
        until PlanningLine.Next = 0;

        //Traitement des suppressions
        lTaskArchive.SetRange("Task No.");
        lTaskArchive.MarkedOnly(true);
        if not lTaskArchive.IsEmpty then begin
            lTaskArchive.FindSet(true, false);
            repeat
                lTaskArchive."Deleted Date" := pTaskHeaderArchive."Archive Date";
                lTaskArchive.Modify;
            until lTaskArchive.Next = 0;
        end;
    end;
}

