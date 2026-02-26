Codeunit 8001555 "Planning Task Management"
{
    //GL2024  ID dans Nav 2009 : "8035008"
    trigger OnRun()
    begin
    end;

    var
        Text001: label 'Les Tâches que vous mergées doivent être de même type (%1)';
        Text002: label 'Vous devez sélectionner au moins deux tâches';
        Text003: label 'Vous ne pouvez pas fusionner cette tâche car elle est déjà lié à une écriture planning ou une écriture affaire';
        Text004: label 'Vous ne pouvez pas supprimer cette tâche car elle est utilisé dans une écriture planning ou dans une écriture affaire';


    procedure gOnDelete(pRec: Record "Planning Line")
    var
        lPlanningLineAssign: Record "Planning Task Assignment";
        lPlanningLineWorkLoad: Record "Planning Task Work Load";
        lPlanningLineArch: Record "Planning Line Archive";
        lPlanningLinkSourceID: Record "Planning Link Source ID";
        lTaskPred: Record "Planning Task Predecessor";
    begin
        with pRec do begin
            if not fPlanningLineModifyVerify(pRec) then
                Error(Text004);

            lPlanningLineAssign.SetRange("Project Header No.", "Project Header No.");
            lPlanningLineAssign.SetRange("Task No.", "Task No.");
            lPlanningLineAssign.DeleteAll;

            lPlanningLineArch.SetRange("Task No.", "Task No.");
            if lPlanningLineArch.IsEmpty then begin
                lPlanningLineWorkLoad.SetRange("Project Header No.", "Project Header No.");
                lPlanningLineWorkLoad.SetRange("Task No.", "Task No.");
                lPlanningLineWorkLoad.DeleteAll;

                lPlanningLinkSourceID.SetRange("Planning Task No.", "Task No.");
                lPlanningLineWorkLoad.DeleteAll;

                lTaskPred.SetRange("Project Header", "Project Header No.");
                lTaskPred.SetRange("Task No.", "Task No.");
                lTaskPred.DeleteAll;
                lTaskPred.SetRange("Project Header Predecessor", "Project Header No.");
                lTaskPred.SetRange("Task No. Predecessor", "Task No.");
                lTaskPred.DeleteAll;
            end;
        end;
    end;


    procedure wUpdateGroupTask(var pRec: Record "Planning Line"; pXRec: Record "Planning Line")
    var
        pGpRec: Record "Planning Line";
        pxGpRec: Record "Planning Line";
    begin
        if pRec."Attached To Task No." = '' then
            exit;
        if pGpRec.Get(pRec."Project Header No.", pRec."Attached To Task No.") then begin
            pxGpRec := pGpRec;
            pGpRec."Work Load (h)" += (pRec."Work Load (h)" - pXRec."Work Load (h)");
            pGpRec.Modify;
            wUpdateGroupTask(pGpRec, pxGpRec);
        end;
    end;


    procedure wValidateField(var pRec: Record "Planning Line"; pFieldNo: Integer)
    var
        lToRecRef: RecordRef;
        lToFieldRef: FieldRef;
        lFromRecRef: RecordRef;
        lFromFieldRef: FieldRef;
        lRec: Record "Planning Line";
        lVariant: Variant;
    begin
        if pRec.Type = pRec.Type::"Group Task" then begin
            lFromRecRef.GetTable(pRec);
            lFromFieldRef := lFromRecRef.Field(pFieldNo);

            lRec.SetCurrentkey("Attached To Task No.");

            lRec.SetRange("Project Header No.", pRec."Project Header No.");
            lRec.SetRange("Attached To Task No.", pRec."Task No.");

            if not lRec.IsEmpty then begin
                lRec.FindSet(true, false);
                repeat
                    lToRecRef.GetTable(lRec);
                    lToFieldRef := lToRecRef.Field(pFieldNo);
                    lToFieldRef.Validate(lFromFieldRef.Value);
                    lToRecRef.Modify(true);
                    lToRecRef.Close;
                until lRec.Next = 0;
            end;
            lVariant := lFromFieldRef.Value;
            if lVariant.ISOPTION or lVariant.Isinteger or lVariant.IsDecimal then
                lFromFieldRef.Value := 0
            //  ELSE IF lVariant.ISCHAR OR lVariant.ISTEXT OR lVariant.ISCODE OR lVariant.ISDATEFORMULA THEN
            //    lFromFieldRef.VALUE := ''
            else
                if lVariant.IsDate then
                    lFromFieldRef.Value := 0D
                else
                    if lVariant.IsTime then
                        lFromFieldRef.Value := 0T;

            lFromRecRef.SetTable(pRec);
            lFromRecRef.Close;
        end;
    end;


    procedure fGetAssignDesc(pRec: Record "Planning Task Assignment") return: Text[80]
    var
        lRes: Record Resource;
        lResGp: Record "Resource Group";
        lSkill: Record "Planning Skill";
    begin
        return := '';
        with pRec do
            case Type of
                Type::Resource:
                    begin
                        if lRes.Get("No.") then
                            return := lRes.Name;
                    end;
                Type::"Resource Group":
                    begin
                        if lResGp.Get("No.") then
                            return := lResGp.Name;
                    end;
            /* GL2024 Type::"2":
                  begin
                      if lSkill.Get("No.") then
                          return := lSkill.Description;
                  end;*/
            end;
        exit(return);
    end;


    procedure wShowTaskAssignment(pRec: Record "Planning Line"; pOption: Option Resource,"Resource Group",Skill)
    var
        lResAss: Record "Planning Task Assignment";
    begin
        with pRec do begin
            lResAss.SetRange("Project Header No.", "Project Header No.");
            lResAss.SetRange("Task No.", "Task No.");
            lResAss.SetRange(Type, pOption);
            //GL2024 NAVIBAT  if Page.RunModal(Page::"Planning Task Assignment List", lResAss) = Action::LookupOK then;
        end;
    end;


    procedure gOnValidateJobJnlLine(var pRec: Record "Job Journal Line"; pCurrFieldNo: Integer)
    var
        lTaskRec: Record "Planning Line";
    begin
        with pRec do begin
            if pRec."Planning Task No." <> '' then begin
                lTaskRec.Get(pRec."Planning Task No.");
                pRec."Project Header No." := lTaskRec."Project Header No.";
                pRec.Validate("Job No.", lTaskRec."Job No.");
                pRec.Validate("Job Task No.", lTaskRec."Job Task No.");
                pRec.Validate("Gen. Prod. Posting Group", lTaskRec."Gen. Prod. Posting Group");
                pRec.Validate("Work Type Code", lTaskRec."Work Type Code");
                pRec.Description := lTaskRec.Description;
                pRec."Source Record ID" := lTaskRec."Source Record ID";
                lTaskRec.CalcFields("Source Line No.");
                pRec."Source Line No." := lTaskRec."Source Line No.";
            end;
        end;
    end;


    procedure gOnValidatePlanningEntry(var pRec: Record "Planning Entry"; pCurrFieldNo: Integer)
    var
        lTaskRec: Record "Planning Line";
    begin
        with pRec do begin
            if pRec."Planning Task No." <> '' then begin
                lTaskRec.Get(pRec."Planning Task No.");
                pRec.Validate("Job No.", lTaskRec."Job No.");
                pRec.Validate("Job Task No.", lTaskRec."Job Task No.");
                pRec.Validate(pRec."Prod. Posting Group", lTaskRec."Gen. Prod. Posting Group");
                pRec.Validate("Work Type Code", lTaskRec."Work Type Code");
                pRec.Description := lTaskRec.Description;
            end;
        end;
    end;


    procedure gMerge(var pTaskNos: Record "Planning Line")
    var
        lPlanningLine: Record "Planning Line";
        lFromPlanningLineWorkLoad: Record "Planning Task Work Load";
        l2PlanningLineWorkLoad: Record "Planning Task Work Load";
        lPlanningEntry: Record "Planning Entry";
    begin
        pTaskNos.MarkedOnly(true);
        pTaskNos.SetFilter(Type, '<>%1', lPlanningLine.Type::"Group Task");
        if pTaskNos.Count < 2 then
            Error(Text002);
        /* //GL2024 if Page.RunModal(Page::"Planning Task List", pTaskNos) = Action::LookupOK then begin
              lPlanningLine := pTaskNos;
              if lPlanningLine.Type = lPlanningLine.Type::"Group Task" then
                  Error(Text001);
              pTaskNos.SetFilter("Task No.", '<>%1', pTaskNos."Task No.");
              pTaskNos.FindFirst;
              repeat
                  if lPlanningLine.Type <> pTaskNos.Type then
                      Error(Text001, lPlanningLine.Type);

                  lPlanningEntry.SetRange("Planning Task No.", pTaskNos."Task No.");
                  lPlanningEntry.SetFilter(Status, '<>%1', lPlanningEntry.Status::Deleted);
                  if not lPlanningEntry.IsEmpty then
                      lPlanningEntry.ModifyAll("Planning Task No.", lPlanningLine."Task No.");

                  if not fPlanningLineModifyVerify(pTaskNos) then
                      Error(Text003);
                  lFromPlanningLineWorkLoad.SetCurrentkey("Project Header No.", "WBS Code", "Task No.", Date);
                  lFromPlanningLineWorkLoad.SetRange("Project Header No.", lPlanningLine."Project Header No.");
                  lFromPlanningLineWorkLoad.SetRange("Task No.", pTaskNos."Task No.");
                  if not lFromPlanningLineWorkLoad.IsEmpty then begin
                      lFromPlanningLineWorkLoad.ModifyAll("WBS Code", lPlanningLine."WBS Code");
                      lFromPlanningLineWorkLoad.ModifyAll("Task No.", lPlanningLine."Task No.");
                  end;
                  lCopyLinkSourceID(pTaskNos, lPlanningLine, true);
                  lCopyTaskPredecessor(pTaskNos, lPlanningLine, true);
                  lCopyTaskAssign(pTaskNos, lPlanningLine, true);
              until pTaskNos.Next = 0;
              pTaskNos.DeleteAll(true);
              pTaskNos.SetRange("Task No.");
          end;*/
        pTaskNos.ClearMarks;
        pTaskNos.MarkedOnly(false);
    end;


    procedure gSplit(var pTaskNos: Record "Planning Line"; var pNewQty: Decimal)
    var
        lPlanningLine: Record "Planning Line";
        lNewQty: Decimal;
        lWBSMgt: Codeunit "WBS Management";
    begin
        lPlanningLine.TransferFields(pTaskNos);
        lPlanningLine.Insert(true);
        lWBSMgt.wDown(lPlanningLine, false);
        pTaskNos.CalcFields("Work Load (h)");
        if pTaskNos."Work Load (h)" < pNewQty then begin
            lPlanningLine.Validate("Work Load (h)", pNewQty - pTaskNos."Work Load (h)");
            pNewQty := pTaskNos."Work Load (h)";
        end else
            lPlanningLine.Validate("Work Load (h)", pTaskNos."Work Load (h)" - pNewQty);
        lCopyTaskAssign(pTaskNos, lPlanningLine, false);
        lCopyLinkSourceID(pTaskNos, lPlanningLine, false);
        lCopyTaskAssign(pTaskNos, lPlanningLine, false);
    end;

    local procedure lCopyTaskAssign(pFromTaskNos: Record "Planning Line"; pToTaskNos: Record "Planning Line"; pMerge: Boolean)
    var
        lFromPlanningLineAssign: Record "Planning Task Assignment";
        lToPlanningLineAssign: Record "Planning Task Assignment";
    begin
        //Fonction de copie des affectation, le dernier paramétre permet de fusionner les affectation de 2 tâches
        lFromPlanningLineAssign.SetRange("Project Header No.", pFromTaskNos."Project Header No.");
        lFromPlanningLineAssign.SetRange("Task No.", pFromTaskNos."Task No.");
        if not lFromPlanningLineAssign.IsEmpty then begin
            lFromPlanningLineAssign.FindSet(true, true);
            repeat
                lToPlanningLineAssign."Project Header No." := lFromPlanningLineAssign."Project Header No.";
                lToPlanningLineAssign."Task No." := pToTaskNos."Task No.";
                lToPlanningLineAssign.Type := lFromPlanningLineAssign.Type;
                lToPlanningLineAssign."No." := lFromPlanningLineAssign."No.";
                lToPlanningLineAssign.Quantity := lFromPlanningLineAssign.Quantity;
                if not (lToPlanningLineAssign.Insert) and pMerge then begin
                    lToPlanningLineAssign.Find;
                    if lToPlanningLineAssign.Quantity < lFromPlanningLineAssign.Quantity then begin
                        lToPlanningLineAssign.Quantity := lFromPlanningLineAssign.Quantity;
                        lToPlanningLineAssign.Modify;
                    end;
                end;
            until lFromPlanningLineAssign.Next = 0;
            if pMerge then
                lFromPlanningLineAssign.DeleteAll;
        end;
    end;

    local procedure lCopyLinkSourceID(pFromTaskNos: Record "Planning Line"; pToTaskNos: Record "Planning Line"; pMerge: Boolean)
    var
        lLinkSourceID: Record "Planning Link Source ID";
        lLinkSourceID2: Record "Planning Link Source ID";
    begin
        //Fonction de copie des liens, le dernier paramétre permet de fusionner les affectation de 2 tâches
        lLinkSourceID.SetRange("Planning Task No.", pFromTaskNos."Task No.");
        if not lLinkSourceID.IsEmpty then begin
            lLinkSourceID.FindSet(true, true);
            repeat
                lLinkSourceID2 := lLinkSourceID;
                lLinkSourceID2."Planning Task No." := pToTaskNos."Task No.";
                if not lLinkSourceID2.Insert and pMerge then begin
                    if lLinkSourceID2."Task Load Purcent" < lLinkSourceID."Task Load Purcent" then begin
                        lLinkSourceID2."Task Load Purcent" := lLinkSourceID."Task Load Purcent";
                        lLinkSourceID2.Modify;
                    end;
                end;
            until lLinkSourceID.Next = 0;
        end;
        if pMerge then
            lLinkSourceID.DeleteAll;
    end;

    local procedure lCopyTaskPredecessor(pFromTaskNos: Record "Planning Line"; pToTaskNos: Record "Planning Line"; pMerge: Boolean)
    var
        lTaskPred: Record "Planning Task Predecessor";
        lTaskPred2: Record "Planning Task Predecessor";
        lPredecessorTaskMgt: Codeunit "Predecessor Task Management";
    begin
        //Fonction de copie des prédesseurs et des aantécédent d'une tâche
        //  le dernier paramétre permet de fusionner les affectation de 2 tâches

        //Suppression des liens entre les deux tâches
        if pMerge then begin
            lTaskPred.SetRange("Project Header", pToTaskNos."Project Header No.");
            lTaskPred.SetRange("Task No.", pToTaskNos."Task No.");
            lTaskPred.SetRange("Project Header Predecessor", pFromTaskNos."Project Header No.");
            lTaskPred.SetRange("Task No. Predecessor", pFromTaskNos."Task No.");
            lTaskPred.DeleteAll;

            //Suppression des liens entre les deux tâches
            lTaskPred.SetRange("Project Header", pFromTaskNos."Project Header No.");
            lTaskPred.SetRange("Task No.", pFromTaskNos."Task No.");
            lTaskPred.SetRange("Project Header Predecessor", pToTaskNos."Project Header No.");
            lTaskPred.SetRange("Task No. Predecessor", pToTaskNos."Task No.");
            lTaskPred.DeleteAll;
        end;

        //Copies des liens
        lTaskPred.Reset;
        lTaskPred.SetRange("Project Header", pFromTaskNos."Project Header No.");
        lTaskPred.SetRange("Task No.", pFromTaskNos."Task No.");
        if not lTaskPred.IsEmpty then begin
            lTaskPred.FindSet(true, true);
            repeat
                lTaskPred2 := lTaskPred;
                lTaskPred2."Project Header" := pToTaskNos."Project Header No.";
                lTaskPred2."Task No." := pToTaskNos."Task No.";
                lPredecessorTaskMgt.lCircularRefVerify(lTaskPred2."Project Header Predecessor", lTaskPred2."Task No. Predecessor",
                                                       lTaskPred2."Project Header", lTaskPred2."Task No.", true);
                if lTaskPred2.Insert(true) then;
            until lTaskPred.Next = 0
        end;
        if pMerge then
            lTaskPred.DeleteAll;

        //Copies des liens
        lTaskPred.Reset;
        lTaskPred.SetRange("Project Header Predecessor", pFromTaskNos."Project Header No.");
        lTaskPred.SetRange("Task No. Predecessor", pFromTaskNos."Task No.");
        if not lTaskPred.IsEmpty then begin
            lTaskPred.FindSet(true, true);
            repeat
                lTaskPred2 := lTaskPred;
                lTaskPred2."Project Header Predecessor" := pToTaskNos."Project Header No.";
                lTaskPred2."Task No. Predecessor" := pToTaskNos."Task No.";
                lPredecessorTaskMgt.lCircularRefVerify(lTaskPred2."Project Header Predecessor", lTaskPred2."Task No. Predecessor",
                                                       lTaskPred2."Project Header", lTaskPred2."Task No.", true);
                if lTaskPred2.Insert(true) then;
            until lTaskPred.Next = 0
        end;
        if pMerge then
            lTaskPred.DeleteAll;
    end;


    procedure fPlanningLineModifyVerify(pRec: Record "Planning Line"): Boolean
    var
        lPlanningEntry: Record "Planning Entry";
        lJobLedgerEntry: Record "Job Ledger Entry";
    begin
        lPlanningEntry.SetRange("Planning Task No.", pRec."Task No.");
        lPlanningEntry.SetRange(Status, lPlanningEntry.Status::Deleted);
        if not lPlanningEntry.IsEmpty then
            exit(false);
        lJobLedgerEntry.SetRange("Planning Task No.", pRec."Task No.");
        if not lJobLedgerEntry.IsEmpty then
            exit(false);
        exit(true);
    end;


    procedure fDec2Duration(pDec: Decimal; pHoursPerDay: Decimal) return: Duration
    var
        lJour: Decimal;
    begin
        if pHoursPerDay = 0 then
            pHoursPerDay := 24;
        lJour := (pDec DIV pHoursPerDay);
        return := ROUND((lJour * 24 + (pDec - lJour * pHoursPerDay)) * 3600000, 1);
    end;


    procedure fDuration2Dec(pDur: Duration; pHoursPerDay: Decimal) return: Decimal
    var
        lJour: Decimal;
    begin
        if pHoursPerDay = 0 then
            pHoursPerDay := 24;
        lJour := (pDur DIV (24 * 3600000));
        return := ROUND((lJour * pHoursPerDay + (pDur - lJour * 24)) / 3600000, 0.00001);
    end;


    procedure fGetDuration(var pPlanningLine: Record "Planning Line"; pLoadMgt: Boolean) return: Decimal
    var
        ltaskAssign: Record "Planning Task Assignment";
        lNbRes: Decimal;
    begin
        if pPlanningLine.Type <> pPlanningLine.Type::Task then
            exit;
        ltaskAssign.SetRange("Task No.", pPlanningLine."Task No.");
        ltaskAssign.CalcSums(ltaskAssign.Quantity);
        pPlanningLine.CalcFields("Work Load (h)");

        lNbRes := ltaskAssign.Quantity;
        if lNbRes = 0 then
            return := pPlanningLine."Work Load (h)"
        else begin
            if pLoadMgt then
                return := pPlanningLine."Work Load (h)" / lNbRes
            else
                return := pPlanningLine."Work Load (h)" * lNbRes;
        end;
    end;


    procedure fTaskFinish(var pTask: Record "Planning Line"; pTaskNo: Code[20])
    var
        lPlanningLine: Record "Planning Line";
    begin
        if pTask."Task No." = pTaskNo then
            fCheckTaskAscendant(pTask);
        if pTask.Type = pTask.Type::"Group Task" then begin
            lPlanningLine.SetRange("Attached To Task No.", pTask."Task No.");
            if lPlanningLine.Find('-') then
                repeat
                    lPlanningLine.Status := pTask.Status;
                    lPlanningLine.Modify(true);
                    fTaskFinish(lPlanningLine, pTaskNo);
                until lPlanningLine.Next = 0;
        end;
    end;

    local procedure fCheckTaskAscendant(var pTask: Record "Planning Line")
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

    local procedure fCheckTaskAscendantIsFinish(var pTask: Record "Planning Line") return: Boolean
    var
        lPlanningLine: Record "Planning Line";
    begin
        lPlanningLine.SetRange("Attached To Task No.", pTask."Task No.");
        lPlanningLine.SetFilter(Status, '<>%1', lPlanningLine.Status::Finish);
        exit(lPlanningLine.IsEmpty);
    end;
}

