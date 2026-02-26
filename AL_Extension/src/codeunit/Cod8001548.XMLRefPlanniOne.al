Codeunit 8001548 "XML Ref PlanniOne"
{
    //GL2024  ID dans Nav 2009 : "8035001"
    // //PLANNINGFORCE AC 01/09/09


    trigger OnRun()
    begin
    end;

    var
        wFilter: Code[10];
        gResGroupTmp: Record "Resource Group" temporary;
        gResourceTmp: Record Resource temporary;

    /* //GL2024 Automation non compatible

        procedure SetRoles(var pXmlDoc: Automation; pInfo: Text[30]; pEnable: Boolean; pFilter: Code[10])
        var
            lXmlRoot: Automation;
            lXmlNode: Automation;
            lTree: Record 8003929;
        begin
            lXmlRoot := pXmlDoc.documentElement;
            lXmlNode := pXmlDoc.createElement(pInfo + 's');
            lXmlRoot.appendChild(lXmlNode);
            wFilter := pFilter;
            if not pEnable then
                exit;

            // On traite d'abord les éléments non attachés à une famille
            lAddRole(pXmlDoc, lXmlNode, '', pInfo);

            //on traite les éléments lié à un groupe de rôle
            lTree.Init;
            lTree.Type := lTree.Type::"Resource Group";
            lTree.Level := 0;
            lGetFolder(pXmlDoc, lXmlNode, lTree, pInfo);
        end;
    */

    /* //GL2024 Automation non compatible

    local procedure lGetFolder(var pXmlDoc: Automation; var pXmlRoot: Automation; var pTree: Record 8003929; pInfo: Text[30])
    var
        lTree: Record 8003929;
        lXmlSubRoot: Automation;
    begin
        lTree.SetRange(Type, pTree.Type);
        lTree.SetRange(Level, pTree.Level);
        if pTree.Level > 0 then
            lTree.SetFilter(Code, '%1', pTree.Code + '*');
        if lTree.IsEmpty then
            exit;
        lTree.FindSet;
        repeat
            lAddRoleFolder(pXmlDoc, pXmlRoot, lXmlSubRoot, lTree);
            case lTree.Type of
                lTree.Type::Person:
                    lAddResource(pXmlDoc, lXmlSubRoot, lTree.Code, pInfo);
                lTree.Type::Skill:
                    lAddSkill(pXmlDoc, lXmlSubRoot, lTree.Code, pInfo);
                lTree.Type::"Resource Group":
                    lAddRole(pXmlDoc, lXmlSubRoot, lTree.Code, pInfo);
            end;
            lTree.Level += 1;
            lTree.Type := pTree.Type;
            lGetFolder(pXmlDoc, lXmlSubRoot, lTree, pInfo);
        until lTree.Next = 0;
    end;

    local procedure lAddRefElement(var pXmlDoc: Automation; var pXMLRoot: Automation; pID: Code[20]; pName: Text[80]; pInfo: Text[30])
    var
        lXMLNode: Automation;
    begin
        lXMLNode := pXmlDoc.createElement(pInfo);
        fAddAttribute(lXMLNode, 'id', pID);
        fAddAttribute(lXMLNode, 'name', pName);
        pXMLRoot.appendChild(lXMLNode);
    end;

    local procedure lAddRole(var pXmlDoc: Automation; var pXmlRoot: Automation; pTreeCode: Code[20]; pInfo: Text[30])
    var
        lResourceGroup: Record 152;
        lXMLFilterPlaniOne: Codeunit "XML Filter PlanniOne";
    begin
        //lXMLFilterPlaniOne.fFilterRole(lResourceGroup,wFilter);
        if gResGroupTmp.IsEmpty then begin
            lXMLFilterPlaniOne.fFilterRole(lResourceGroup, wFilter);
            if lResourceGroup.FindSet then begin
                repeat
                    gResGroupTmp.Copy(lResourceGroup);
                    gResGroupTmp.Insert;
                until lResourceGroup.Next = 0;
            end;
        end;

        gResGroupTmp.SetRange("Tree Code", pTreeCode);
        if gResGroupTmp.IsEmpty then
            exit;
        gResGroupTmp.FindSet;
        repeat
            lAddRefElement(pXmlDoc, pXmlRoot, gResGroupTmp."No.", gResGroupTmp.Name, pInfo);
        until gResGroupTmp.Next() = 0;
    end;

    local procedure lAddRoleFolder(var pXmlDoc: Automation; var pXMLRoot: Automation; var pXMLNode: Automation; pT8003929: Record 8003929)
    var
        lXMLNode: Automation;
    begin
        case pT8003929.Type of
            pT8003929.Type::Person:
                lXMLNode := pXmlDoc.createElement('resource-folder');
            pT8003929.Type::Skill:
                lXMLNode := pXmlDoc.createElement('skill-folder');
            pT8003929.Type::"Resource Group":
                lXMLNode := pXmlDoc.createElement('role-folder');
            else
                Error('Donnée incorrect');
        end;

        fAddAttribute(lXMLNode, 'id', pT8003929.Code);
        fAddAttribute(lXMLNode, 'name', pT8003929.Description);
        pXMLNode := pXMLRoot.appendChild(lXMLNode);
    end;


    procedure SetSkills(var pXmlDoc: Automation; pInfo: Text[30]; pEnable: Boolean; pFilter: Code[10])
    var
        lXmlRoot: Automation;
        lXmlNode: Automation;
        lTree: Record 8003929;
    begin
        lXmlRoot := pXmlDoc.documentElement;
        lXmlNode := pXmlDoc.createElement(pInfo + 's');
        lXmlRoot.appendChild(lXmlNode);
        wFilter := pFilter;
        if not pEnable then
            exit;

        // On traite d'abord les éléments non attachés à une famille
        lAddSkill(pXmlDoc, lXmlNode, '', pInfo);

        //on traite les éléments lié à un groupe de rôle
        lTree.Init;
        lTree.Type := lTree.Type::Skill;
        lTree.Level := 0;
        lGetFolder(pXmlDoc, lXmlNode, lTree, pInfo);
    end;

    local procedure lAddSkill(var pXmlDoc: Automation; var pXmlRoot: Automation; pTreeCode: Code[20]; pInfo: Text[30])
    var
        lSkill: Record 8035001;
        lXMLFilterPlaniOne: Codeunit "XML Filter PlanniOne";
    begin
        lXMLFilterPlaniOne.fFilterSkill(lSkill, wFilter);

        lSkill.SetRange("Tree Code", pTreeCode);
        if lSkill.IsEmpty then
            exit;
        lSkill.FindSet;
        repeat
            lAddRefElement(pXmlDoc, pXmlRoot, lSkill.Code, lSkill.Description, pInfo);
        until lSkill.Next() = 0;
    end;


    procedure SetSchedules(var pXmlDoc: Automation; pEnable: Boolean; pFilter: Code[10])
    var
        lXmlRoot: Automation;
        lXmlNode: Automation;
    begin
        lXmlRoot := pXmlDoc.documentElement;
        lXmlNode := pXmlDoc.createElement('schedules');
        lXmlRoot.appendChild(lXmlNode);
        wFilter := pFilter;
        if not pEnable then
            exit;

        lAddWkScheduleTemplate(pXmlDoc, lXmlNode);
        lAddNoWkSchedule(pXmlDoc, lXmlNode);
    end;

    local procedure lAddWkScheduleTemplate(var pXmlDoc: Automation; var pXmlRoot: Automation)
    var
        lWeeklyScheduleTemplate: Record 8035005;
        lXMLNode: Automation;
        lXMLFilterPlaniOne: Codeunit "XML Filter PlanniOne";
        lXMLPlanExpMgt: Codeunit "XML PLanniOne Export Mgt";
        lPlanningSetup: Record 8004133;
        lDenominator: Decimal;
    begin
        lPlanningSetup.Get;
        lDenominator := lPlanningSetup."Def. Hours per Day";
        lXMLFilterPlaniOne.fFilterScheduleTemplate(lWeeklyScheduleTemplate, wFilter);

        if lWeeklyScheduleTemplate.FindSet(false, false) then
            repeat
                lXMLNode := pXmlDoc.createElement('weekly-schedule');
                fAddAttribute(lXMLNode, 'id', Format(lWeeklyScheduleTemplate.Code));
                fAddAttribute(lXMLNode, 'name', Format(lWeeklyScheduleTemplate.Description));

                fAddAttribute(lXMLNode, 'monday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Monday / lDenominator)));
                fAddAttribute(lXMLNode, 'tuesday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Tuesday / lDenominator)));
                fAddAttribute(lXMLNode, 'wednesday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Wednesday / lDenominator)));
                fAddAttribute(lXMLNode, 'thursday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Thursday / lDenominator)));
                fAddAttribute(lXMLNode, 'friday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Friday / lDenominator)));
                fAddAttribute(lXMLNode, 'saturday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Saturday / lDenominator)));
                fAddAttribute(lXMLNode, 'sunday', lXMLPlanExpMgt.fFormatDecimal(Format(lWeeklyScheduleTemplate.Sunday / lDenominator)));
                pXmlRoot.appendChild(lXMLNode);
            until lWeeklyScheduleTemplate.Next = 0;
    end;

    local procedure lAddNoWkSchedule(var pXmlDoc: Automation; var pXmlRoot: Automation)
    var
        lXMLNode: Automation;
        lXMLNode2: Automation;
        lBaseCalendar: Record 7600;
        lBaseCalendarChange: Record 7601;
        lEmployeeAbsence: Record 5207;
        lEmployee: Record 5200;
        lResource: Record 156;
    begin
        if lBaseCalendar.FindSet(false, false) then
            repeat
                lAddNonWorkingschedule(pXmlDoc, pXmlRoot, lXMLNode, lBaseCalendar.Code, lBaseCalendar.Name);
                lBaseCalendarChange.SetRange("Base Calendar Code", lBaseCalendar.Code);
                lBaseCalendarChange.SetRange(Nonworking, true);
                lBaseCalendarChange.SetFilter("Recurring System", '<>%1', lBaseCalendarChange."recurring system"::"Weekly Recurring");
                lXMLNode2 := pXmlDoc.createElement('nonworking-days');
                lXMLNode := lXMLNode.appendChild(lXMLNode2);

                if lBaseCalendarChange.FindSet(false, false) then begin
                    repeat
                        if lBaseCalendarChange."To Date" = 0D then
                            lAddDay(pXmlDoc, lXMLNode, fCalcDate(lBaseCalendarChange."Recurring System", lBaseCalendarChange.Date))
                        else
                            lAddDayRange(pXmlDoc, lXMLNode, fCalcDate(lBaseCalendarChange."Recurring System", lBaseCalendarChange.Date),
                               fCalcDate(lBaseCalendarChange."Recurring System", lBaseCalendarChange."To Date"));
                    until lBaseCalendarChange.Next = 0;
                end;
            until lBaseCalendar.Next = 0;
    end;

    local procedure lAddNonWorkingschedule(var pXmlDoc: Automation; var pXmlRoot: Automation; var pXmlSubRoot: Automation; pID: Code[20]; pName: Text[80])
    var
        lXmlNode: Automation;
    begin
        lXmlNode := pXmlDoc.createElement('nonworking-schedule');
        fAddAttribute(lXmlNode, 'id', pID);
        fAddAttribute(lXmlNode, 'name', pName);
        pXmlSubRoot := pXmlRoot.appendChild(lXmlNode);
    end;

    local procedure lAddDay(var pXmlDoc: Automation; var pXmlRoot: Automation; pDate: Date)
    var
        lXmlNode: Automation;
        ltext: Text[30];
    begin
        lXmlNode := pXmlDoc.createElement('day');
        ltext := Format(pDate, 0, 9);    // 9 ='XML format'
        fAddAttribute(lXmlNode, 'date', ltext);
        pXmlRoot.appendChild(lXmlNode);
    end;

    local procedure lAddDayRange(var pXmlDoc: Automation; var pXmlRoot: Automation; pFromDate: Date; pToDate: Date)
    var
        lXmlNode: Automation;
    begin
        lXmlNode := pXmlDoc.createElement('day-range');
        fAddAttribute(lXmlNode, 'from', Format(pFromDate, 0, 9));
        fAddAttribute(lXmlNode, 'to', Format(pToDate, 0, 9));
        pXmlRoot.appendChild(lXmlNode);
    end;


    procedure SetResources(var pXmlDoc: Automation; pInfo: Text[30]; pEnable: Boolean; pFilter: Code[10])
    var
        lXmlRoot: Automation;
        lXmlNode: Automation;
        lTree: Record 8003929;
    begin
        lXmlRoot := pXmlDoc.documentElement;
        lXmlNode := pXmlDoc.createElement('resources');
        lXmlRoot.appendChild(lXmlNode);
        wFilter := pFilter;
        if not pEnable then
            exit;

        // On traite d'abord les éléments non attachés à une famille
        lAddResource(pXmlDoc, lXmlNode, '', pInfo);

        //on traite les éléments lié à un groupe de rôle
        lTree.Init;
        lTree.Type := lTree.Type::Person;
        lTree.Level := 0;
        lGetFolder(pXmlDoc, lXmlNode, lTree, pInfo);
    end;

    local procedure lAddResource(var pXmlDoc: Automation; var pXmlRoot: Automation; pTreeCode: Code[20]; pInfo: Text[30])
    var
        lResource: Record 156;
        lXMLFilterPlanione: Codeunit "XML Filter PlanniOne";
    begin
        //lXMLFilterPlanione.fFilterRes(lResource,wFilter);
        gResourceTmp.Reset;
        if gResourceTmp.IsEmpty then begin
            lXMLFilterPlanione.fFilterRes(lResource, wFilter);
            if lResource.FindSet then begin
                repeat
                    gResourceTmp.Copy(lResource);
                    gResourceTmp.Insert;
                until lResource.Next = 0;
            end;
        end;

        gResourceTmp.SetRange("Tree Code", pTreeCode);
        gResourceTmp.SetRange(Blocked, false);
        //lResource.SETRANGE("WT Allowed",TRUE);
        if gResourceTmp.IsEmpty then
            exit;
        gResourceTmp.FindSet;
        repeat
            //lAddRefElement(pXmlDoc,pXmlRoot,lResource."No.",lResource.Name,pInfo);
            lAddRefResource(pXmlDoc, pXmlRoot, gResourceTmp."No.", gResourceTmp.Name, pInfo, gResourceTmp);
        until gResourceTmp.Next() = 0;
    end;

    local procedure lAddRefResource(var pXmlDoc: Automation; var pXMLRoot: Automation; pID: Code[20]; pName: Text[80]; pInfo: Text[30]; pResource: Record 156)
    var
        lXMLNode: Automation;
        lPlanningSetup: Record 8004133;
    begin
        lXMLNode := pXmlDoc.createElement(pInfo);
        fAddAttribute(lXMLNode, 'id', pID);
        fAddAttribute(lXMLNode, 'name', pName);
        if pResource."Default Number of Resources" > 0 then
            fAddAttribute(lXMLNode, 'quantity', Format(pResource."Default Number of Resources"))
        else
            fAddAttribute(lXMLNode, 'quantity', '1');
        if pResource."Weekly Schedule Code" <> '' then
            fAddAttribute(lXMLNode, 'weeklySchedule', pResource."Weekly Schedule Code")
        else
            if lPlanningSetup.Get then begin
                lPlanningSetup.TestField("Scheduler Template Default");
                fAddAttribute(lXMLNode, 'weeklySchedule', lPlanningSetup."Scheduler Template Default")
            end else
                fAddAttribute(lXMLNode, 'weeklySchedule', '');
        //fAddAttribute(lXMLNode,'nonWorkingSchedule',fNonWorkingSchedule(pID));
        // Pas pris en compte : profiles, available... date

        // Lien n,n entre Resources et autres entités
        lAddResourceNodes(pXmlDoc, lXMLNode, pResource);

        pXMLRoot.appendChild(lXMLNode);
    end;

    local procedure lAddResourceNodes(var pXmlDoc: Automation; var pXmlRoot: Automation; pResource: Record 156)
    var
        lResourceSkill: Record 8035002;
        lResourceRole: Record 8004031;
        lResourcePlanning: Record 8004130;
        lXMLNode: Automation;
    begin
        lXMLNode := pXmlDoc.createElement('profile');
        //Roles
        lResourceRole.SetRange("Resource No.", pResource."No.");
        if not lResourceRole.IsEmpty then begin
            lResourceRole.FindSet;
            repeat
                lAddProfileNode(pXmlDoc, lXMLNode, 'profile-role', lResourceRole."Resource Group No.");
            until lResourceRole.Next() = 0;
        end;
        //Compétences
        lResourceSkill.SetRange("No.", pResource."No.");
        if not lResourceSkill.IsEmpty then begin
            lResourceSkill.FindSet;
            repeat
                lAddProfileNode(pXmlDoc, lXMLNode, 'profile-skill', lResourceSkill."Skill Code");
            until lResourceSkill.Next() = 0;
        end;
        pXmlRoot.appendChild(lXMLNode);

        //Abscences
        lResourcePlanning.SetRange("No.", pResource."No.");
        lResourcePlanning.SetFilter("Employee Absence Entry No.", '<>0');
        if not lResourcePlanning.IsEmpty then begin
            lXMLNode := pXmlDoc.createElement('schedule-exceptions');
            lResourcePlanning.FindSet;
            repeat
                lAddscheduleExceptionNode(pXmlDoc, lXMLNode, 'schedule-exception', lResourcePlanning);
            until lResourcePlanning.Next = 0;
        end;

        pXmlRoot.appendChild(lXMLNode);
    end;

    local procedure lAddProfileNode(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Text[30]; pId: Code[10])
    var
        lXMLNode: Automation;
    begin
        lXMLNode := pXmlDoc.createElement(pNode);
        fAddAttribute(lXMLNode, 'id', pId);
        pXmlRoot.appendChild(lXMLNode);
    end;

    local procedure lAddscheduleExceptionNode(var pXmlDoc: Automation; var pXmlRoot: Automation; pNode: Text[30]; pResourcePlanning: Record 8004130)
    var
        lXMLNode: Automation;
        lCapacity: Integer;
        lPlanningSetup: Record 8004133;
    begin
        lPlanningSetup.Get;
        lXMLNode := pXmlDoc.createElement(pNode);
        fAddAttribute(lXMLNode, 'day', Format(pResourcePlanning.Date, 0, 9));
        lCapacity := lPlanningSetup."Def. Hours per Day";
        if lCapacity - pResourcePlanning.Quantity < 0 then
            fAddAttribute(lXMLNode, 'capacity', Format(0))
        else
            fAddAttribute(lXMLNode, 'capacity', Format((lCapacity - pResourcePlanning.Quantity) / lPlanningSetup."Def. Hours per Day"));
        pXmlRoot.appendChild(lXMLNode);
    end;
*/
    local procedure fNonWorkingSchedule(pResourceNo: Code[20]): Code[20]
    var
        lEmployee: Record Employee;
        lEmployeeAbsence: Record "Employee Absence";
        lPlanningSetup: Record "Planning Setup";
    begin
        if not lPlanningSetup.Get then
            lPlanningSetup.Init;
        //#7555
        if lEmployee.SetCurrentkey("Resource No.") then;
        //#7555//
        lEmployee.SetRange("Resource No.", pResourceNo);
        if lEmployee.FindFirst then begin
            lEmployeeAbsence.SetCurrentkey("Employee No.", "From Date");
            lEmployeeAbsence.SetRange("Employee No.", lEmployee."No.");
            if lEmployeeAbsence.FindSet then
                exit(pResourceNo)
            else
                exit(lPlanningSetup."Base Calendar Code")
        end else
            exit(lPlanningSetup."Base Calendar Code");
    end;

    local procedure fCalcDate(pType: Option; pDate: Date): Date
    var
        pBaseCalendarChange: Record "Base Calendar Change";
    begin
        case pType of
            0:
                exit(pDate);
            1:
                exit(Dmy2date(Date2dmy(pDate, 1), Date2dmy(pDate, 2), Date2dmy(WorkDate, 3)));
        end;
    end;
    /* //GL2024 Automation non compatible

        local procedure fAddAttribute(var pXMLNode: Automation; pName: Text[260]; pNodeValue: Text[260]) ExitStatus: Integer
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
    */

    procedure fGetDenominator() return: Decimal
    var
        lPlanningSetup: Record "Planning Setup";
    begin
        lPlanningSetup.Get;
        return := lPlanningSetup."Def. Hours per Day";
        if return = 0 then
            return := 8;
    end;


    procedure fSetRefFromTasks(pRecordRef: RecordRef; pFilterRole: Code[10]; pFilterSkill: Code[10]; pFilterSource: Code[10])
    var
        lProject: Record "Planning Header";
        lPlanningLineAssign: Record "Planning Task Assignment";
        lResourceGroup: Record "Resource Group";
        lSkill: Record "Planning Skill";
        lXMLFilterPlaniOne: Codeunit "XML Filter PlanniOne";
    begin
        lProject.SetView(pRecordRef.GetView);
        if not lProject.FindFirst then
            exit
        else begin
            lXMLFilterPlaniOne.fFilterRole(lResourceGroup, pFilterRole);
            lXMLFilterPlaniOne.fFilterSkill(lSkill, pFilterSkill);
            repeat
                lPlanningLineAssign.SetRange("Project Header No.", lProject."No.");
                if lPlanningLineAssign.FindSet then;
                repeat
                    case lPlanningLineAssign.Type of
                        lPlanningLineAssign.Type::"Resource Group":
                            begin
                                fSetRefFromResGroup(gResourceTmp, lResourceGroup, lPlanningLineAssign."No.");
                            end;
                        lPlanningLineAssign.Type::Resource:
                            begin
                                fSetRefFromRes(gResourceTmp, lPlanningLineAssign."No.");
                            end;
                    /* GL2024  lPlanningLineAssign.Type::"2":
                           begin
                               fSetRefFromSkill(gResourceTmp, lResourceGroup, lSkill, lPlanningLineAssign."No.");
                           end;*/
                    end;
                until lPlanningLineAssign.Next = 0;
            until lProject.Next = 0;
        end;
    end;


    procedure fSetRefFromRes(var pResource: Record Resource; pNo: Code[20])
    var
        lResource: Record Resource;
    begin
        if not pResource.Get(pNo) then begin
            lResource.Get(pNo);
            pResource.TransferFields(lResource);
            pResource.Insert;
        end;
    end;


    procedure fSetRefFromResGroup(var pResource: Record Resource; pResourceGroup: Record "Resource Group"; pNo: Code[20])
    var
        lResourceByResourceGroup: Record "Resource / Resource Group";
    begin
        if pResourceGroup.Get(pNo) then begin
            lResourceByResourceGroup.SetFilter("Resource Group No.", pNo);
            if not lResourceByResourceGroup.IsEmpty then begin
                lResourceByResourceGroup.FindSet(true, true);
                repeat
                    fSetRefFromRes(pResource, lResourceByResourceGroup."Resource No.");
                until lResourceByResourceGroup.Next = 0;
            end;
        end;
    end;


    procedure fSetRefFromSkill(var pResource: Record Resource; pResourceGroup: Record "Resource Group"; pSkill: Record "Planning Skill"; pNo: Code[20])
    var
        lResBySkill: Record "Resource / Planning Skill";
    begin
        if pSkill.Get(pNo) then begin
            lResBySkill.SetFilter(lResBySkill."Skill Code", pNo);
            if not lResBySkill.IsEmpty then begin
                lResBySkill.FindSet(true, true);
                repeat
                    fSetRefFromRes(gResourceTmp, lResBySkill."No.");
                /*
                      CASE lResBySkill.Type OF
                        lResBySkill.Type::"0" : fSetRefFromRes(gResourceTmp,lResBySkill."No.");
                        lResBySkill.Type::"1" : fSetRefFromResGroup(gResourceTmp,pResourceGroup,lResBySkill."No.");
                      END;
                */
                until lResBySkill.Next = 0;
            end;
        end;

    end;
}

