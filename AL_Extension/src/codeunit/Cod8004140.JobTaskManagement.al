Codeunit 8004140 "Job Task Management"
{
    // //PLANNING_TASK CW 31/08/09


    trigger OnRun()
    begin
    end;

    var
        PlanningEntry: Record "Planning Entry";
        ServicePeriod: Record "Job Task Period";
        JobTaskAllocation: Record "Planning Task Assignment";
        StartingDate: Date;
        gSalesHeader: Record "Sales Header";
        gCalendarMgt: Codeunit "Calendar Management";
        gCustomizedCalendar: Record "Customized Calendar Change";

    local procedure Schedule(var pJobTask: Record "Job Task"; pStartingDate: Date)
    var
        lPlanningSetup: Record "Planning Setup";
        lEndingDate: Date;
        lJobLedgerEntry: Record "Job Ledger Entry";
        lPlanningEntry: Record "Planning Entry";
        lDummyText: Text[30];
    begin
        /*
        IF pJobTask."Frequency Code" = '' THEN
          EXIT;
        IF NOT CheckEntry(pJobTask) THEN
          EXIT;
        PlanningDelete(pJobTask,pStartingDate);
        
        IF pJobTask."Starting Date" = 0D THEN
          EXIT;
        
        //PlanningEntry.RESET;
        //PlanningEntry.SETCURRENTKEY("Entry No.");
        IF lPlanningEntry.FIND('+') THEN
          PlanningEntry."Entry No." := lPlanningEntry."Entry No."
        ELSE
          PlanningEntry."Entry No." := 0;
        
        ServicePeriod.GET(pJobTask."Frequency Code");
        {
        //Calcul CoefMois
        CASE Frequency.Périodicité OF
          Frequency.Périodicité::"0" : BEGIN
            CoefMois := 0;
            IF pJobTask.Lundi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Mardi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Mercredi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Jeudi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Vendredi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Samedi THEN CoefMois := CoefMois + 1;
            IF pJobTask.Dimanche THEN CoefMois := CoefMois + 1;
            CoefMois := CoefMois * (52 / 12);
          END;
          Frequency.Périodicité::"1" :
            CoefMois := 52 / 12;
          Frequency.Périodicité::"2" :
            CoefMois := 1;
          Frequency.Périodicité::"3"..Frequency.Périodicité::"6" :
            CoefMois := 1;
        END;
        
        IF Frequency.Intervalle <> 0 THEN
          CoefMois := CoefMois / Frequency.Intervalle;
        }
        pJobTask."Work Load per Month (h)" := pJobTask."Work Load (h)" * ServicePeriod."Monthly Factor";
        
        JobTaskAllocation.SETRANGE("Project Header No.",pJobTask."Job No.");
        JobTaskAllocation.SETRANGE("Job Task No.",pJobTask."Job Task No.");
        IF JobTaskAllocation.ISEMPTY THEN
          EXIT;
        PlanningEntry."Job No." :=  pJobTask."Job No.";
        PlanningEntry."Job Task No." := pJobTask."Job Task No.";
        PlanningEntry.Type := PlanningEntry.Type::Person;
        PlanningEntry.Quantity := ROUND(pJobTask."Work Load (h)" / JobTaskAllocation.COUNT,0.1,'>');
        PlanningEntry."Work Type Code" := pJobTask."Work Type Code";
        PlanningEntry."Resource Group No." := pJobTask."Resource Group No.";
        PlanningEntry."Prod. Posting Group" := pJobTask."Gen. Prod. Posting Group";
        
        IF pStartingDate <> 0D THEN BEGIN
          IF pJobTask."Starting Date" > pStartingDate THEN
            StartingDate := pJobTask."Starting Date"
          ELSE
            StartingDate := pStartingDate;
        END ELSE BEGIN
        //  lPlanningEntry.SETCURRENTKEY("Job No.",Date);
          lPlanningEntry.SETCURRENTKEY("Job No.","Job Task No.",Date);
          lPlanningEntry.SETRANGE("Job No.",pJobTask."Job No.");
          lPlanningEntry.SETRANGE("Job Task No.",pJobTask."Job Task No.");
          lPlanningEntry.SETRANGE(Status,PlanningEntry.Status::Deleted);
          IF lPlanningEntry.FINDLAST THEN
            StartingDate := lPlanningEntry.Date + 1
          ELSE
            StartingDate := pJobTask."Starting Date";
        END;
        
        // Travaux exceptionnels
        IF (pJobTask."Frequency Code" = '') AND
           (pJobTask."Job Task Type" = pJobTask."Job Task Type"::Posting) THEN BEGIN // Travaux exceptionnels
          pJobTask."Work Load per Month (h)" := 0;
          PlanningEntry.Date := pJobTask."Starting Date";
          PlanningInsert(pJobTask);
          EXIT;
        END;
        
        lPlanningSetup.GET;
        
        IF pJobTask."Starting Date" = 0D THEN
          PlanningEntry.Date := StartingDate
        ELSE
          PlanningEntry.Date := pJobTask."Starting Date";
        IF (pJobTask."Ending Date" = 0D) OR (pJobTask."Ending Date" > CALCDATE(lPlanningSetup."Schedule Horizon")) THEN
          lEndingDate := CALCDATE(lPlanningSetup."Schedule Horizon")
        ELSE
          lEndingDate := pJobTask."Ending Date";
        
        {à revoir
        CASE Frequency.Périodicité OF
          Frequency.Périodicité::"0" : BEGIN
            WHILE PlanningEntry.Date <= lEndingDate DO BEGIN
              CASE DATE2DWY(PlanningEntry.Date,1) OF
                1:IF pJobTask.Lundi THEN Inserer(pJobTask);
                2:IF pJobTask.Mardi THEN Inserer(pJobTask);
                3:IF pJobTask.Mercredi THEN Inserer(pJobTask);
                4:IF pJobTask.Jeudi THEN Inserer(pJobTask);
                5:IF pJobTask.Vendredi THEN Inserer(pJobTask);
                6:IF pJobTask.Samedi THEN Inserer(pJobTask);
                7:IF pJobTask.Dimanche THEN Inserer(pJobTask);
              END;
            PlanningEntry.Date := PlanningEntry.Date + 1;
            END;
          END;
          Frequency.Périodicité::"1",Frequency.Périodicité::"2" : BEGIN
            IF Frequency.Périodicité = Frequency.Périodicité::"1" THEN
              lFormula := STRSUBSTNO('<+%1W>',Frequency.Intervalle);
            IF Frequency.Périodicité = Frequency.Périodicité::"2" THEN
              lFormula := STRSUBSTNO('<+%1M>',Frequency.Intervalle);
            WHILE PlanningEntry.Date <= lEndingDate DO BEGIN
              Decaler(pJobTask);
              Inserer(pJobTask);
              PlanningEntry.Date := CALCDATE(lFormula,PlanningEntry.Date);
            END;
          END;
          Frequency.Périodicité::"3"..Frequency.Périodicité::"6" : BEGIN
            IF Frequency.Intervalle <= 1 THEN
              lFormula := '<-CM+1M>'
            ELSE
              lFormula := STRSUBSTNO('<-CM+%1M>',Frequency.Intervalle);
            PlanningEntry.Date := CALCDATE('<-CM>',PlanningEntry.Date); // 1er jour du mois
            WHILE PlanningEntry.Date <= lEndingDate DO BEGIN
              Decaler(pJobTask); //CW 15/01/01
              IF Frequency.Périodicité = Frequency.Périodicité::"4" THEN
                PlanningEntry.Date := CALCDATE('<+1W>',PlanningEntry.Date);
              IF Frequency.Périodicité = Frequency.Périodicité::"5" THEN
                PlanningEntry.Date := CALCDATE('<+2W>',PlanningEntry.Date);
              IF Frequency.Périodicité = Frequency.Périodicité::"6" THEN
                PlanningEntry.Date := CALCDATE('<+3W>',PlanningEntry.Date);
              IF PlanningEntry.Date < pJobTask."Date d'effet" THEN
                PlanningEntry.Date := CALCDATE('<CM+1D>',PlanningEntry.Date)
              ELSE BEGIN
                Inserer(pJobTask);
                PlanningEntry.Date := CALCDATE(lFormula,PlanningEntry.Date);
              END;
            END;
          END;
        END;
        }
        
        //PlanningEntry.Date := CALCDATE('<-CM>',PlanningEntry.Date); // 1er jour du mois
        IF pJobTask."Calendar Code" <> '' THEN
          gCalendarMgt.GetCalendarCode(gCustomizedCalendar."Source Type"::Service,pJobTask."Calendar Code",'')
        ELSE
          gCalendarMgt.GetCalendarCode(gCustomizedCalendar."Source Type"::Company,lPlanningSetup."Base Calendar Code",'');
        WHILE PlanningEntry.Date <= lEndingDate DO BEGIN
        
          IF pJobTask."Calendar Code" <> '' THEN
            WHILE gCalendarMgt.CheckDateStatus(pJobTask."Calendar Code",PlanningEntry.Date,lDummyText) DO
              PlanningEntry.Date += 1;
        
          PlanningInsert(pJobTask);
          PlanningEntry.Date := CALCDATE(ServicePeriod."Date Calculation",PlanningEntry.Date);
        END;
        
        JobTaskAllocation.FIND('-');
        REPEAT
          JobTaskAllocation.Quantity := PlanningEntry.Quantity * ServicePeriod."Monthly Factor";
          JobTaskAllocation.MODIFY;
        UNTIL JobTaskAllocation.NEXT = 0;
        */

    end;

    local procedure PlanningDelete(pJobTask: Record "Job Task"; pStartingDate: Date)
    begin
        with PlanningEntry do begin
            SetRange("Job Task No.", pJobTask."Job Task No.");
            //BAT5.01
            SetFilter(Status, '%1|%2', PlanningEntry.Status::Confirm, PlanningEntry.Status::Suggested);
            //
            if pStartingDate <> 0D then
                SetRange(Date, pStartingDate, 99991231D);
            DeleteAll(true);
        end;
    end;

    local procedure PlanningInsert(pJobTask: Record "Job Task")
    begin
        if PlanningEntry.Date < StartingDate then
            exit;
        if JobTaskAllocation.Find('-') then
            with PlanningEntry do
                repeat
                    "No." := JobTaskAllocation."No.";
                    "Entry No." := "Entry No." + 1;

                    if "No." <> '' then begin

                        PlanningEntry."User ID" := UserId;
                        PlanningEntry.Status := PlanningEntry.Status::Confirm;
                        PlanningEntry."Job Task No." := pJobTask."Job Task No.";
                        PlanningEntry.Description := pJobTask.Description;
                        Insert;

                    end;
                until JobTaskAllocation.Next = 0;
    end;

    local procedure DeleteJobTaskDocument(pSalesHeader: Record "Sales Header")
    var
        lJobTask: Record "Job Task";
    begin
        Message('A revoir');
        /*??
        IF pSalesHeader."Document Type" <> pSalesHeader."Document Type":: "11" THEN
          EXIT;
        
        lJobTask.SETRANGE("Entry No.",pSalesHeader."Document Type");
        IF lJobTask.FIND('-') THEN
          REPEAT
            lJobTask.DELETE(TRUE);
          UNTIL lJobTask.NEXT = 0;
        */

    end;

    local procedure DeleteJobTaskLine(pSalesLine: Record "Sales Line")
    var
        lJobTask: Record "Job Task";
    begin
        Message('A revoir');
        /*??
        IF pSalesLine."Document Type" <> pSalesLine."Document Type":: "11" THEN
          EXIT;
        
        lJobTask.SETRANGE("Entry No.",pSalesLine."Document Type");
        //??lJobTask.SETRANGE("Document No.",pSalesLine."No.");
        //??lJobTask.SETRANGE("Document Line No.",pSalesLine."Line No.");
        IF lJobTask.FIND('-') THEN
          REPEAT
            lJobTask.DELETE(TRUE);
          UNTIL lJobTask.NEXT = 0;
        */

    end;

    local procedure UpdateJobTaskDate(pSubscrHeader: Record "Sales Header"; pConfirm: Boolean)
    var
        lSubscrPrest: Record "Job Task";
        tFieldModified: label 'You have modified %1.';
        tConfirmUpdateLines: label 'Do you want to update lines?';
    begin
        Message('A revoir');
        /*??
        lSubscrPrest.SETRANGE("Entry No.",pSubscrHeader."Document Type");
        //??lSubscrPrest.SETRANGE("Document No.",pSubscrHeader."No.");
        lSubscrPrest.SETRANGE("Task Type",lSubscrPrest."Task Type"::Subscription);
        IF lSubscrPrest.ISEMPTY THEN
          EXIT;
        
        IF pSubscrHeader."Subscription End Date" = 0D THEN
          EXIT;
        
        IF pConfirm AND GUIALLOWED THEN
          IF NOT CONFIRM(STRSUBSTNO(tFieldModified + '\' + tConfirmUpdateLines,
            pSubscrHeader.FIELDCAPTION("Subscription End Date"))) THEN
            EXIT;
        
        lSubscrPrest.LOCKTABLE;
        lSubscrPrest.FINDSET;
        REPEAT
          IF (lSubscrPrest."Ending Date" = 0D) THEN BEGIN
            lSubscrPrest.VALIDATE("Ending Date",pSubscrHeader."Subscription End Date");
            lSubscrPrest.MODIFY(TRUE);
          END;
        UNTIL lSubscrPrest.NEXT = 0;
        */

    end;

    local procedure CheckEntry(var pJobTask: Record "Job Task"): Boolean
    var
        ltRequired: label '%1 est obligatoire.';
    begin
        /*
        WITH pJobTask DO BEGIN
          IF Description = '' THEN
            MESSAGE(STRSUBSTNO(ltRequired),FIELDCAPTION(Description))
          ELSE IF ("Job Task Type" = "Job Task Type"::Posting) AND ("Frequency Code" = '') THEN
            MESSAGE(STRSUBSTNO(ltRequired),FIELDCAPTION("Frequency Code"))
          ELSE IF  "Starting Date" = 0D THEN
            MESSAGE(STRSUBSTNO(ltRequired),FIELDCAPTION("Starting Date"))
          ELSE IF "Resource Group No." = '' THEN
            MESSAGE(STRSUBSTNO(ltRequired),FIELDCAPTION("Resource Group No."))
          ELSE IF "Work Load (h)" = 0 THEN
            MESSAGE(STRSUBSTNO(ltRequired),FIELDCAPTION("Work Load (h)"))
          ELSE
            EXIT(TRUE);
        END;
        */

    end;

    local procedure Suggest(pRec: Record "Job Task")
    var
        lJob: Record Job;
        lJobRecordRef: RecordRef;
        lJobFilter: Record "Filter Header";
        lCustomer: Record Customer;
        lCustRecordRef: RecordRef;
        lCustFilter: Record "Filter Header";
        lFilterMgt: Codeunit "Filter Management";
        lTemplate: Record "Job Task Standard";
        lRec: Record "Job Task";
    begin
        /*
        WITH pRec DO BEGIN
          TESTFIELD("Job No.");
          TESTFIELD("Job Task No.",'');
          lJob.GET("Job No.");
          lJobRecordRef.GETTABLE(lJob);
          IF lJob."Bill-to Customer No." <> '' THEN BEGIN
            lCustomer.GET(lJob."Bill-to Customer No.");
            lCustRecordRef.GETTABLE(lCustomer);
          END;
        
          IF lTemplate.FINDSET THEN
            REPEAT
              lRec.SETCURRENTKEY("Job No.","Job Task No.");
              lRec.SETRANGE("Job No.","Job No.");
              //lRec.SETRANGE("Job Task No.","Job Task No.");
              lRec.SETRANGE("Standard Task Code",lTemplate.Code);
              IF lRec.ISEMPTY THEN BEGIN
                IF lTemplate."Customer Filter Code" = '' THEN
                  CLEAR(lCustFilter)
                ELSE IF lTemplate."Customer Filter Code" <> lCustFilter.Code THEN
                  lCustFilter.GET(DATABASE::Customer,lTemplate."Customer Filter Code");
                IF lTemplate."Job Filter Code" = '' THEN
                  CLEAR(lJobFilter)
                ELSE IF lTemplate."Job Filter Code" <> lJobFilter.Code THEN
                  lJobFilter.GET(DATABASE::Job,lTemplate."Job Filter Code");
                IF lCustFilter.IsInFilter(lCustRecordRef) AND
                   lJobFilter.IsInFilter(lJobRecordRef) THEN BEGIN
                  TRANSFERFIELDS(lTemplate);
                  "Job Task No." := lTemplate.Code;
                  INSERT(TRUE);
                END;
              END;
            UNTIL lTemplate.NEXT = 0;
        END;
        */

    end;

    local procedure LeftPadStr(pString: Text[30]; pLength: Integer; pPadChar: Text[1]): Text[30]
    begin
        if StrLen(pString) > pLength then
            exit(CopyStr(pString, StrLen(pString) - pLength + 1));
        if pPadChar = '' then
            pPadChar := ' ';
        while StrLen(pString) < pLength do
            pString := InsStr(pString, pPadChar, 1);
        exit(pString);
    end;

    local procedure AssignmentRefresh(var pRec: Record "Job Task")
    var
        ltConfirm: label 'Do you want to refresh planning?';
        lPlanningEntry: Record "Planning Entry";
    begin
        lPlanningEntry.SetCurrentkey("Job No.", "Job Task No.");
        lPlanningEntry.SetRange("Job No.", pRec."Job No.");
        lPlanningEntry.SetRange("Job Task No.", pRec."Job Task No.");
        lPlanningEntry.SetRange(Status, lPlanningEntry.Status::Confirm, lPlanningEntry.Status::Suggested);
        if not lPlanningEntry.IsEmpty then
            if Confirm(ltConfirm, false) then
                Schedule(pRec, 0D);
    end;

    local procedure AssignmentOnValidate(var pRec: Record "Job Task")
    var
        lAssignment: Record "Planning Task Assignment";
        ltConfirm: label 'Do you want to refresh planning?';
    begin
        /*
        lAssignment.SETRANGE("Project Header No.",pRec."Job No.");
        lAssignment.SETRANGE("Job Task No.",pRec."Job Task No.");
        lAssignment.DELETEALL;
        
        lAssignment.INIT;
        lAssignment."Project Header No." := pRec."Job No.";
        lAssignment."Job Task No." := pRec."Job Task No.";
        lAssignment.VALIDATE("No.",pRec.Assignment);
        lAssignment.INSERT;
        
        AssignmentRefresh(pRec);
        */

    end;

    local procedure AssignmentOnFormat(var pRec: Record "Job Task"): Code[20]
    var
        lJobTaskAssignment: Record "Planning Task Assignment";
        lCount: Integer;
    begin
        /*
        lJobTaskAssignment.SETRANGE("Project Header No.",pRec."Job No.");
        lJobTaskAssignment.SETRANGE("Job Task No.",pRec."Job Task No.");
        lCount := lJobTaskAssignment.COUNT;
        CASE lCount OF
          0:EXIT('');
          1:EXIT(pRec.Assignment);
          ELSE
            EXIT('(' + FORMAT(lCount) + ')');
        END;
        */

    end;

    local procedure AssignmentOnLookup(var pRec: Record "Job Task"; var pResource: Record Resource) Return: Boolean
    begin
        /*
        pResource.RESET;
        pResource.SETRANGE(Type,pResource.Type::Person);
        pResource.SETRANGE(Blocked,FALSE);
        IF pRec."Resource Group No." <> '' THEN BEGIN
          pResource.SETRANGE("Res. Group Filter",pRec."Resource Group No.");
          pResource.SETRANGE("In Res. Group",TRUE);
        END;
        Return := Page.RunModal(0,pResource) = ACTION::LookupOK;
        IF Return THEN
          pRec.Assignment := pResource."No.";
        */

    end;

    local procedure ShowAssignments(var pRec: Record "Job Task")
    var
        //GL2024 NAVIBAT   lFormAssignments: Page 8004145;
        lAssignment: Record "Planning Task Assignment";
    begin
        /*
        lAssignment.SETRANGE("Project Header No.",pRec."Job No.");
        lAssignment.SETRANGE("Job Task No.",pRec."Job Task No.");
        lFormAssignments.SETTABLEVIEW(lAssignment);
        lFormAssignments.RUNMODAL;
        IF lFormAssignments.IsModified THEN
          Schedule(pRec,0D);
        */

    end;

    local procedure IsRecurring(var pRec: Record "Job Task"): Boolean
    begin
        /*
        WITH pRec DO
          EXIT(("Frequency Code" <> '') OR Monday OR Tuesday OR Wenesday OR Thursday OR Friday OR Saturday OR Sunday);
        */

    end;

    local procedure AssignmentNames(var pRec: Record "Job Task") Return: Text[1000]
    var
        lResource: Record Resource;
        lAssignment: Record "Planning Task Assignment";
        lMoreResources: Boolean;
        i: Integer;
    begin
        /*
        WITH pRec DO BEGIN
          lAssignment.SETRANGE("Project Header No.","Job No.");
          lAssignment.SETRANGE("Job Task No.","Job Task No.");
          CASE lAssignment.COUNT OF
            0:lResource.INIT;
            1:BEGIN
                lAssignment.FIND('-');
                IF NOT lResource.GET(lAssignment."No.") THEN
                  lResource.INIT;
                lResource."No." := lAssignment."No.";
                Return := lResource.Name;
              END;
            ELSE BEGIN
              lAssignment.FINDFIRST;
              REPEAT
                IF NOT lResource.GET(lAssignment."No.") THEN
                  lResource.INIT;
                IF Return = '' THEN
                  Return := FORMAT(lAssignment.COUNT) + ':' + lResource.Name
                ELSE IF STRLEN(Return) + STRLEN(lResource.Name) + 1 <= MAXSTRLEN(Return) THEN
                  Return := Return + ';' + lResource.Name
                ELSE
                  lMoreResources := TRUE;
              UNTIL (lAssignment.NEXT = 0) OR (lMoreResources);
              IF lMoreResources THEN
                FOR i := STRLEN(Return) TO MAXSTRLEN(Return) DO
                  Return[i] := '.';
            END;
          END;
        END;
        */

    end;
}

