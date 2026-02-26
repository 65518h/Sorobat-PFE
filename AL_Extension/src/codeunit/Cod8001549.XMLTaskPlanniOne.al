Codeunit 8001549 "XML Task PlanniOne"
{
    //GL2024  ID dans Nav 2009 : "8035002"
    // //AFF PLAN PLANNINGFORCE


    trigger OnRun()
    begin
    end;

    var
        gProject: Record "Planning Header";

    /*//GL2024
        procedure SetTasks(var pXmlDoc: Automation)
        var
            lXmlRoot: Automation;
            lXmlNode: Automation;
        begin
            lXmlRoot := pXmlDoc.documentElement;
            lXmlNode := pXmlDoc.createElement('tasks');
            lXmlRoot := lXmlRoot.appendChild(lXmlNode);

            //ajout des projets
            lAddProject(pXmlDoc, lXmlRoot);

            //25/02/10
            //lAddDynamicField(pXmlDoc,lXmlRoot);
        end;
    */

    procedure SetFilterTask(pRecref: RecordRef)
    var
        lRecRef: RecordRef;
    begin
        gProject.SetView(pRecref.GetView);
    end;
    /*//GL2024
        local procedure lAddAttribute(var pXMLNode: Automation; pName: Text[260]; pNodeValue: Text[260]) ExitStatus: Integer
        var
            lXMLNewAttributeNode: Automation;
            lChar: Char;
        begin
            lXMLNewAttributeNode := pXMLNode.ownerDocument.createAttribute(pName);

            if pName = 'id' then
                pNodeValue := DelChr(pNodeValue, '=', ' ');

            if ISCLEAR(lXMLNewAttributeNode) then begin
                ExitStatus := 60;
                exit(ExitStatus)
            end;

            if pNodeValue <> '' then
                lXMLNewAttributeNode.nodeValue := pNodeValue;

            pXMLNode.attributes.setNamedItem(lXMLNewAttributeNode);
        end;

        local procedure lAddProject(var pXmlDoc: Automation; var pXmlRoot: Automation)
        var
            lProject: Record 8035006;
            lXMLNode: Automation;
            lProjectXMLNode: Automation;
            lRecordref: RecordRef;
            lPlanningSetup: Record 8004133;
            lBasic: Codeunit Basic;
            lDescription: Text[250];
            lXMLPlanExpMgt: Codeunit "XML PLanniOne Export Mgt";
        begin
            lProject.Copy(gProject);
            lPlanningSetup.Get;
            if not lProject.IsEmpty then begin
                lProject.FindSet;
                repeat
                    lRecordref.GetTable(lProject);
                    Clear(lBasic);
                    lXMLNode := pXmlDoc.createElement('project');
                    lAddAttribute(lXMLNode, 'id', lXMLPlanExpMgt.fFormatID(lProject."No."));
                    lDescription := lPlanningSetup."Project Exported Description";
                    if lPlanningSetup."Project Exported Description" <> '' then
                        lAddAttribute(lXMLNode, 'name', lBasic.SubstituteValues(lDescription, lRecordref, '%', GlobalLanguage))
                    else
                        lAddAttribute(lXMLNode, 'name', lProject.Description);
                    lProjectXMLNode := pXmlRoot.appendChild(lXMLNode);
                    //ajout de la composition du document
                    lAddChildren(pXmlDoc, lProjectXMLNode, lRecordref);
                    lRecordref.Close;
                until lProject.Next() = 0;
            end;
        end;
    *//*//GL2024
        local procedure lAddChildren(var pXmlDoc: Automation; var pXmlRoot: Automation; pRecRef: RecordRef)
        var
            lXMLNode: Automation;
            lOwnerNode: Automation;
            lNode: Record 8035007;
        begin
            lXMLNode := pXmlDoc.createElement('children');
            lOwnerNode := pXmlRoot.appendChild(lXMLNode);
            lAddChildrenRec(pRecRef, lNode);

            if not lNode.IsEmpty then begin
                lNode.FindSet;
                repeat
                    if (lNode.Type = lNode.Type::"Group Task") then
                        lAddTaskGroup(pXmlDoc, lOwnerNode, lNode)
                    else
                        if (lNode.Type = lNode.Type::Milestome) then
                            lAddMilestone(pXmlDoc, lOwnerNode, lNode)
                        else
                            lAddTask(pXmlDoc, lOwnerNode, lNode);
                until lNode.Next() = 0;
            end;
        end;
    */
    local procedure lAddChildrenRec(pRecRef: RecordRef; var pJobTask: Record "Planning Line")
    var
        lProject: Record "Planning Header";
        lPlanningLine: Record "Planning Line";
        lTemp: Text[20];
    begin
        pJobTask.Reset;
        pJobTask.SetCurrentkey("Project Header No.", "WBS Code");

        case pRecRef.RecordId.TableNo of
            Database::"Planning Header":
                begin
                    pRecRef.SetTable(lProject);
                    pJobTask.SetRange("Project Header No.", lProject."No.");
                    pJobTask.SetRange("Attached To Task No.", '');
                end;
            Database::"Planning Line":
                begin
                    pRecRef.SetTable(lPlanningLine);
                    pJobTask.SetRange("Project Header No.", lPlanningLine."Project Header No.");
                    pJobTask.SetRange("Attached To Task No.", lPlanningLine."Task No.");
                end;
        end;
    end;
    /*/ //GL2024 Automation non compatible
        local procedure lAddTaskGroup(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Record 8035007)
        var
            lXMLNode: Automation;
            lOwnerNode: Automation;
            lRecRef: RecordRef;
        begin
            lXMLNode := pXmlDoc.createElement('task-group');
            lAddAttribute(lXMLNode, 'id', Format(pNode."Task No."));
            lAddAttribute(lXMLNode, 'name', pNode.Description);
            lOwnerNode := pXmlRoot.appendChild(lXMLNode);
            //
            lRecRef.GetTable(pNode);
            lAddChildren(pXmlDoc, lOwnerNode, lRecRef);
            lAddLinks(pXmlDoc, lOwnerNode, pNode);
        end;

        local procedure lAddTask(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Record 8035007)
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
            lXMLRefPlanniOne: Codeunit "XML Ref PlanniOne";
            lXMLPlanExpMgt: Codeunit "XML PLanniOne Export Mgt";
            lPLanningSetup: Record 8004133;
        begin
            lXMLNode := pXmlDoc.createElement('single-task');
            //lAddAttribute(lXMLNode,'id',pNode."Project Header No." +'-'+ FORMAT(pNode."Task No."));
            lRecordRef.GetTable(pNode);
            lAddAttribute(lXMLNode, 'id', lXMLPlanExpMgt.fFormatID(pNode."Task No."));
            lAddAttribute(lXMLNode, 'name', pNode.Description);

            pNode.CalcFields("Work Load (h)");
            //lAddAttribute(lXMLNode,'load',FORMAT(pNode."Alloted Time (h)"/lXMLRefPlanniOne.fGetDenominator));
            lPLanningSetup.Get;
            if lPLanningSetup."Def. Hours per Day" <> 0 then
                lAddAttribute(lXMLNode, 'load',
                  lXMLPlanExpMgt.fFormatDecimal(Format(pNode."Work Load (h)" / lPLanningSetup."Def. Hours per Day")));

            if GetDate(pNode."Early Starting Date", pNode."Starting Date", true) <> 0D then
                lAddAttribute(lXMLNode, 'earliestStartDate', Format(GetDate(pNode."Early Starting Date", pNode."Starting Date", true), 0, 9));
            if GetDate(pNode."Early Ending Date", pNode."Ending Date", true) <> 0D then
                lAddAttribute(lXMLNode, 'latestEndDate', Format(GetDate(pNode."Early Ending Date", pNode."Ending Date", true), 0, 9));

            lAddRequirement(pXmlDoc, lXMLNode, pNode);
            lAddLinks(pXmlDoc, lXMLNode, pNode);

            pXmlRoot.appendChild(lXMLNode);
        end;

        local procedure lAddMilestone(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Record 8035007)
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
            lXMLRefPlanniOne: Codeunit "XML Ref PlanniOne";
            lXMLPlanExpMgt: Codeunit "XML PLanniOne Export Mgt";
        begin
            lXMLNode := pXmlDoc.createElement('milestone');
            lRecordRef.GetTable(pNode);
            lAddAttribute(lXMLNode, 'id', lXMLPlanExpMgt.fFormatID(pNode."Task No."));
            lAddAttribute(lXMLNode, 'name', pNode.Description);

            if GetDate(pNode."Early Starting Date", pNode."Starting Date", true) <> 0D then
                lAddAttribute(lXMLNode, 'earliestStartDate', Format(GetDate(pNode."Early Starting Date", pNode."Starting Date", true), 0, 9));
            if GetDate(pNode."Early Ending Date", pNode."Ending Date", true) <> 0D then
                lAddAttribute(lXMLNode, 'latestEndDate', Format(GetDate(pNode."Early Ending Date", pNode."Ending Date", true), 0, 9));

            lAddLinks(pXmlDoc, lXMLNode, pNode);
            pXmlRoot.appendChild(lXMLNode);
        end;

        local procedure lAddLinks(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Record 8035007)
        var
            lXMLNode: Automation;
            lOwnerNode: Automation;
            lPlanningLinePredecessor: Record 8004143;
        begin
            // role-requirement
            lPlanningLinePredecessor.SetRange("Task No.", pNode."Task No.");
            if lPlanningLinePredecessor.IsEmpty then
                exit;

            lXMLNode := pXmlDoc.createElement('links');
            lOwnerNode := pXmlRoot.appendChild(lXMLNode);
            lPlanningLinePredecessor.FindSet(false, false);
            repeat
                lAddLink(pXmlDoc, lOwnerNode, lPlanningLinePredecessor."Task No. Predecessor", 0, lPlanningLinePredecessor.Type, 0);
            until lPlanningLinePredecessor.Next = 0;
        end;

        local procedure lAddLink(var pXmlDoc: Automation; var pXmlRoot: Automation; pTask: Code[20]; pType: Option; pLag: Decimal; pProgress: Decimal)
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
        begin
            lXMLNode := pXmlDoc.createElement('link');
            case pType of
                Ptype::"0":
                    lAddAttribute(lXMLNode, 'type', 'EE');
                Ptype::"1":
                    lAddAttribute(lXMLNode, 'type', 'ES');
                Ptype::"2":
                    lAddAttribute(lXMLNode, 'type', 'SE');
                Ptype::"3":
                    lAddAttribute(lXMLNode, 'type', 'SS');
            end;
            lAddAttribute(lXMLNode, 'from', Format(pTask));
            lAddAttribute(lXMLNode, 'lag', Format(pLag));
            lAddAttribute(lXMLNode, 'progress', Format(pProgress));
            pXmlRoot.appendChild(lXMLNode);
        end;

        local procedure lAddRequirement(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Record 8035007)
        var
            lXMLNode: Automation;
            lOwnerNode: Automation;
            lPlanningLineAssignment: Record 8004141;
        begin
            // role-requirement
            lPlanningLineAssignment.SetRange("Project Header No.", pNode."Project Header No.");
            lPlanningLineAssignment.SetRange("Task No.", pNode."Task No.");
            if lPlanningLineAssignment.IsEmpty then
                exit;
            lXMLNode := pXmlDoc.createElement('requirements');
            lOwnerNode := pXmlRoot.appendChild(lXMLNode);
            if lPlanningLineAssignment.FindSet(false, false) then begin
                repeat
                    case lPlanningLineAssignment.Type of
                        lPlanningLineAssignment.Type::Resource:
                            lAddResRqt(pXmlDoc, lOwnerNode, lPlanningLineAssignment."No.", lPlanningLineAssignment
    .Quantity);
                        lPlanningLineAssignment.Type::"Resource Group":
                            lAddRoleRqt(pXmlDoc, lOwnerNode, lPlanningLineAssignment."No.", lPlanningLineAssignment.Quantity, pNode."Task No.")
                    end;
                until lPlanningLineAssignment.Next = 0;
            end;
        end;

        local procedure lAddRoleRqt(var pXmlDoc: Automation; var pXmlRoot: Automation; pRole: Code[20]; pQty: Decimal; pTask: Code[20])
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
            lTaskRoleSkillAssign: Record 8004146;
        begin
            lXMLNode := pXmlDoc.createElement('role-requirement');
            lAddAttribute(lXMLNode, 'role', pRole);
            lAddAttribute(lXMLNode, 'quantity', Format(pQty));

            lTaskRoleSkillAssign.SetRange("Task No.", pTask);
            lTaskRoleSkillAssign.SetRange("Resource Group No.", pRole);
            if not lTaskRoleSkillAssign.IsEmpty then begin
                lTaskRoleSkillAssign.FindSet(false, false);
                repeat
                    lAddRoleSkillRqt(pXmlDoc, lXMLNode, lTaskRoleSkillAssign."Skill No.");
                until lTaskRoleSkillAssign.Next = 0;
            end;

            pXmlRoot.appendChild(lXMLNode);
        end;

        local procedure lAddRoleSkillRqt(var pXmlDoc: Automation; var pXmlRoot: Automation; pId: Code[20])
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
        begin
            lXMLNode := pXmlDoc.createElement('required-skill');
            lAddAttribute(lXMLNode, 'id', pId);
            pXmlRoot.appendChild(lXMLNode);
        end;

        local procedure lAddResRqt(var pXmlDoc: Automation; var pXmlRoot: Automation; pRes: Code[20]; pQty: Decimal)
        var
            lXMLNode: Automation;
            lRecordRef: RecordRef;
        begin
            lXMLNode := pXmlDoc.createElement('resource-requirement');
            lAddAttribute(lXMLNode, 'resource', pRes);
            lAddAttribute(lXMLNode, 'quantity', Format(pQty));
            pXmlRoot.appendChild(lXMLNode);
        end;


        procedure SetEmptyTask(var pXmlDoc: Automation)
        var
            lXmlRoot: Automation;
            lXmlNode: Automation;
        begin
            // Create an empty Task when option of requestForm is 'Refentiel' only
            lXmlRoot := pXmlDoc.documentElement;
            lXmlNode := pXmlDoc.createElement('tasks');
            lXmlRoot := lXmlRoot.appendChild(lXmlNode);
        end;


        procedure lAddDynamicField(var pXmlDoc: Automation; var pXmlRoot: Automation)
        var
            lXMLNode: Automation;
            lProjectXMLNode: Automation;
        begin
            lXMLNode := pXmlDoc.createElement('dynamic-field-categories');
            lProjectXMLNode := pXmlRoot.appendChild(lXMLNode);
            //ajout de la composition du niveau
            lAddChildrenDynFldCat(pXmlDoc, lProjectXMLNode);
        end;

        local procedure lAddChildrenDynFldCat(var pXmlDoc: Automation; var pXmlRoot: Automation)
        var
            lXMLNode: Automation;
            lOwnerNode: Automation;
            lNode: Record 8004170;
        begin
            lXMLNode := pXmlDoc.createElement('dynamic-field-category');
            lAddAttribute(lXMLNode, 'name', 'DynFieldCat 1');
            lOwnerNode := pXmlRoot.appendChild(lXMLNode);
        end;
    */
    local procedure GetDate(pDate1: Date; pDate2: Date; pBegin: Boolean) return: Date
    begin
        if (pDate1 = 0D) and (pDate2 = 0D) then
            exit(0D);
        if (pDate2 = 0D) then
            exit(pDate1);
        if (pDate1 = 0D) then
            exit(pDate2);
        if pBegin and (pDate1 < pDate2) then
            exit(pDate1)
        else
            if pBegin then
                exit(pDate2)
            else
                if (pDate1 > pDate2) then
                    exit(pDate1)
                else
                    exit(pDate2);
    end;
}

