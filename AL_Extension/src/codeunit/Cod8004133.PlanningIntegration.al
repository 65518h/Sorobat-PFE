Codeunit 8004133 "Planning Integration"
{

    trigger OnRun()
    begin
    end;

    var
        tImpossible: label 'can''t be moved this way';
        gPlanningSetup: Record "Planning Setup";
        gPlanSetupRead: Boolean;
        gPlanningEntry: Record "Planning Entry";
        gJobJnlLine: Record "Job Journal Line";
        tPlanningSetupNotExist: label 'There is no Planning Setup record.';
        gJobJnlLineNo: Integer;
        tAttachedToDoc: label 'Ne peut être vide. Ce champ doit être renseigné';


    procedure RunCheck(var PLanningEntry: Record "Planning Entry")
    var
        lJob: Record Job;
        lPlanningSetup: Record "Planning Setup";
    begin
        with PLanningEntry do begin
            TestField(Quantity);

            lPlanningSetup.Get;
            if lPlanningSetup."Work Type Code Required" then
                TestField("Work Type Code");
        end;
    end;


    procedure "Code"(CheckLine: Boolean)
    var
        lPlanningCheckLine: Codeunit "Planning Integration";
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    begin
        with gPlanningEntry do begin
            if IsEmptyEntry then
                exit;

            if CheckLine then
                lPlanningCheckLine.RunCheck(gPlanningEntry);

            LoadJobJnlLine(lJobJnlLine, gPlanningEntry, true);

            Status := Status::Posted;
            Modify;

            lJobJnlPostLine.Run(lJobJnlLine);
        end;
    end;


    procedure RunWithoutCheck(var PlanningEntry2: Record "Planning Entry")
    begin
        gPlanningEntry.Copy(PlanningEntry2);
        Code(false);
        PlanningEntry2 := gPlanningEntry;
    end;


    procedure RunWithCheck(var PlanningEntry2: Record "Planning Entry")
    begin
        gPlanningEntry.Copy(PlanningEntry2);
        Code(true);
        PlanningEntry2 := gPlanningEntry;
    end;

    local procedure GetGLSetup()
    begin
        if not gPlanSetupRead then
            if not gPlanningSetup.Get then
                Error(tPlanningSetupNotExist);
        gPlanSetupRead := true;
    end;


    procedure InitJobJnlLine(JobJnlLine2: Record "Job Journal Line")
    begin
        gJobJnlLine."Journal Template Name" := JobJnlLine2."Journal Template Name";
        gJobJnlLine."Journal Batch Name" := JobJnlLine2."Journal Batch Name";

        gJobJnlLineNo := GetJobJnlLineNo(JobJnlLine2);
    end;

    local procedure SetJobJnlLine(var pJobJnlLine: Record "Job Journal Line")
    begin
        pJobJnlLine."Journal Template Name" := gJobJnlLine."Journal Template Name";
        pJobJnlLine."Journal Batch Name" := gJobJnlLine."Journal Batch Name";

        gJobJnlLineNo := GetJobJnlLineNo(pJobJnlLine) + 10000;
        pJobJnlLine."Line No." := gJobJnlLineNo
    end;


    procedure SetResJnlLine(var pResJnlLine: Record "Res. Journal Line"; var pJobJnlLine: Record "Job Journal Line")
    var
        lPlanningEntry: Record "Planning Entry";
        lPlanningLine: Record "Planning Line";
        lPlanningSetup: Record "Planning Setup";
    begin
        pResJnlLine."Planning Source" := true;
        pResJnlLine."Employee Absence Entry No." := pJobJnlLine."Employee Absence Entry No.";
        pResJnlLine."Project Header No." := pJobJnlLine."Project Header No.";
        pResJnlLine."Planning Task No." := pJobJnlLine."Planning Task No.";
        pResJnlLine."Source Record ID" := pJobJnlLine."Source Record ID";
        pResJnlLine."Source  Line No." := pJobJnlLine."Source Line No.";

        if lPlanningEntry.Get(pJobJnlLine."Planning Entry No.") then begin
            pResJnlLine."Start Time" := lPlanningEntry."Start Time";
            if lPlanningLine.Get(pResJnlLine."Planning Task No.") then begin
                pResJnlLine."Responsable Person" := lPlanningLine."Person Responsible";
            end;
        end else begin
            lPlanningSetup.Get;
            lPlanningSetup."Planning Entry" += 1;
            lPlanningSetup.Modify;
            pResJnlLine."External Document No." := Format(lPlanningSetup."Planning Entry");
            pJobJnlLine."External Document No." := pResJnlLine."External Document No.";
        end;
    end;


    procedure SetResLedgEntry(var pResLedgEntry: Record "Res. Ledger Entry"; pResJnlLine: Record "Res. Journal Line")
    begin
        pResLedgEntry."Planning Source" := pResJnlLine."Planning Source";
        pResLedgEntry."Start Time" := pResJnlLine."Start Time";
        pResLedgEntry."Source Record ID" := pResJnlLine."Source Record ID";
        pResLedgEntry."Source Line No." := pResJnlLine."Source  Line No.";
        pResLedgEntry."Employee Absence Entry No." := pResJnlLine."Employee Absence Entry No.";
        pResLedgEntry."Project Header No." := pResJnlLine."Project Header No.";
        pResLedgEntry."Planning Task No." := pResJnlLine."Planning Task No.";
        pResLedgEntry."Responsable Person" := pResJnlLine."Responsable Person";
    end;


    procedure DeletePlanningEntry(pJobJnlLine: Record "Job Journal Line")
    var
        lPlanningEntry: Record "Planning Entry";
    begin
        if pJobJnlLine."Planning Entry No." <> 0 then begin
            lPlanningEntry.Get(pJobJnlLine."Planning Entry No.");
            lPlanningEntry.Delete;
        end;
    end;


    procedure LoadJobJnlLine(var pJobJnlLine: Record "Job Journal Line"; var pPlanningEntry: Record "Planning Entry"; pPosted: Boolean)
    begin
        if pPosted then
            pJobJnlLine.Init;
        //Chargement du nom de la feuille
        SetJobJnlLine(pJobJnlLine);
        //Affectation des valeurs
        pJobJnlLine."Document No." := '';
        pJobJnlLine.Validate("Posting Date", pPlanningEntry.Date);
        pJobJnlLine."Line No." := pPlanningEntry."Entry No.";
        pJobJnlLine."External Document No." := Format(pPlanningEntry."Entry No.");

        //#8225
        pJobJnlLine."Project Header No." := pPlanningEntry."Project Header No.";
        //#8225//
        pJobJnlLine.Validate("Planning Task No.", pPlanningEntry."Planning Task No.");
        pJobJnlLine.Validate("Job No.", pPlanningEntry."Job No.");
        pJobJnlLine.Validate("Job Task No.", pPlanningEntry."Job Task No.");

        pJobJnlLine.Type := gJobJnlLine.Type::Resource;
        pJobJnlLine.Validate("No.", pPlanningEntry."No.");
        pJobJnlLine.Validate("Resource Group No.", pPlanningEntry."Resource Group No.");
        pJobJnlLine.Validate("Gen. Prod. Posting Group", pPlanningEntry."Prod. Posting Group");
        pJobJnlLine.Validate("Work Type Code", pPlanningEntry."Work Type Code");
        pJobJnlLine.Description := pPlanningEntry.Description;
        pJobJnlLine.Validate(Quantity, pPlanningEntry.Quantity);
        pJobJnlLine."Planning Entry No." := pPlanningEntry."Entry No.";

        pJobJnlLine."Source Record ID" := pPlanningEntry."Source Record ID";
        pJobJnlLine."Source Line No." := pPlanningEntry."Source Line No.";

        //Gestion des abscences
        pJobJnlLine."Employee Absence Entry No." := pPlanningEntry."Employee Absence Entry No.";

        if pPosted then
            pPlanningEntry.Status := pPlanningEntry.Status::Posted;
        pPlanningEntry.Modify;
    end;


    procedure JobJnlLineOnDelete(pJobJnlLine: Record "Job Journal Line")
    var
        lPlanningEntry: Record "Planning Entry";
    begin
        if pJobJnlLine."Planning Entry No." = 0 then
            exit;
        if lPlanningEntry.Get(pJobJnlLine."Planning Entry No.") then begin
            lPlanningEntry.Status := lPlanningEntry.Status::Confirm;
            lPlanningEntry.Modify;
        end;
    end;

    local procedure GetJobJnlLineNo(pJobJnlLine: Record "Job Journal Line"): Integer
    var
        lJobJnlLine: Record "Job Journal Line";
    begin
        if gJobJnlLineNo <> 0 then
            exit(gJobJnlLineNo);

        lJobJnlLine.SetRange("Journal Template Name", pJobJnlLine."Journal Template Name");
        lJobJnlLine.SetRange("Journal Batch Name", pJobJnlLine."Journal Batch Name");

        if lJobJnlLine.FindLast then
            exit(lJobJnlLine."Line No.")
        else
            exit(0);
    end;


    procedure CapacitySelect(pWorkTemplateRec: Record "Work-Hour Template"; pTempDate: Date) Hours: Decimal
    begin
        case Date2dwy(pTempDate, 1) of
            1:
                Hours := pWorkTemplateRec.Monday;
            2:
                Hours := pWorkTemplateRec.Tuesday;
            3:
                Hours := pWorkTemplateRec.Wednesday;
            4:
                Hours := pWorkTemplateRec.Thursday;
            5:
                Hours := pWorkTemplateRec.Friday;
            6:
                Hours := pWorkTemplateRec.Saturday;
            7:
                Hours := pWorkTemplateRec.Sunday;
        end;
    end;


    procedure CapacitySumWeekTotal(pWorkTemplateRec: Record "Work-Hour Template") return: Decimal
    begin
        return := pWorkTemplateRec.Monday + pWorkTemplateRec.Tuesday + pWorkTemplateRec.Wednesday +
          pWorkTemplateRec.Thursday + pWorkTemplateRec.Friday + pWorkTemplateRec.Saturday + pWorkTemplateRec.Sunday;
    end;


    procedure SetCapacity(pResNo: Code[20]; pStartDate: Date; pEndDate: Date; pWorkTemplateRec: Record "Work-Hour Template"; pShowMessage: Boolean)
    var
        lWeightTotal: Integer;
        lWeight: Integer;
        lResGp: Record "Resource / Resource Group";
        Text001: label 'You must select a work-hour template.';
        Text002: label 'You must fill in the Starting Date field.';
        Text003: label 'You must fill in the Ending Date field.';
        Text004: label 'Do you want to change the capacity for %1 %2?';
        Text006: label 'The capacity for %1 days was changed successfully.';
        Text007: label 'The capacity for %1 day was changed successfully.';
        Text008: label 'The capacity change was unsuccessful.';
        lCalChange: Record "Customized Calendar Change";
        lResCapacityEntry: Record "Res. Capacity Entry";
        lCompanyInformation: Record "Company Information";
        lResCapacityEntry2: Record "Res. Capacity Entry";
        lCalendarMgmt: Codeunit "Calendar Management";
        lTempDate: Date;
        lTempCapacity: Decimal;
        lChangedDays: Integer;
        lLastEntry: Decimal;
        lHoliday: Boolean;
        lNewDescription: Text[50];
        lCalendarCustomized: Boolean;
    begin
        if CapacitySumWeekTotal(pWorkTemplateRec) <= 0 then
            Error(Text001);

        if pStartDate = 0D then
            Error(Text002);

        if pEndDate = 0D then
            Error(Text003);

        if pShowMessage then
            if not Confirm(Text004, false, Database::Resource, pResNo) then
                exit;

        /*  //GL2024   if lCompanyInformation.Get then
                if lCompanyInformation."Base Calendar Code" <> '' then
                    lCalendarCustomized :=
                      lCalendarMgmt.CustomizedChangesExist(lCalChange."source type"::Company, '', '', lCompanyInformation."Base Calendar Code");*/

        lResCapacityEntry.Reset;
        lResCapacityEntry.SetCurrentkey("Resource Group No.", "Resource No.", Date);
        lResCapacityEntry.SetRange(lResCapacityEntry."Resource No.", pResNo);
        lTempDate := pStartDate;
        lChangedDays := 0;

        lResGp.SetCurrentkey("Resource Group No.", "Resource No.");
        lResGp.SetRange("Resource No.", pResNo);
        lResGp.CalcSums(Weight);
        lWeightTotal := lResGp.Weight;

        if lWeightTotal = 0 then
            lWeightTotal := 1;

        repeat
            /* //GL2024 if lCalendarCustomized then
                 lHoliday :=
                   lCalendarMgmt.CheckCustomizedDateStatus(
                     lCalChange."source type"::Company, '', '', lCompanyInformation."Base Calendar Code", lTempDate, lNewDescription)
             else
                 lHoliday := lCalendarMgmt.CheckDateStatus(lCompanyInformation."Base Calendar Code", lTempDate, lNewDescription);
 */
            if not lHoliday then begin
                lResCapacityEntry.SetRange(Date, lTempDate);
                lTempCapacity := 0;
                if lResCapacityEntry.Find('-') then begin
                    repeat
                        lTempCapacity := lTempCapacity + lResCapacityEntry.Capacity;
                    until lResCapacityEntry.Next = 0;
                end;
                if lResGp.FindSet then
                    repeat
                        lResCapacityEntry2.Reset;
                        if lResCapacityEntry2.Find('+') then;
                        lLastEntry := lResCapacityEntry2."Entry No." + 1;
                        lResCapacityEntry2.Reset;
                        lResCapacityEntry2."Entry No." := lLastEntry;
                        lWeight := lResGp.Weight;
                        if lWeight = 0 then
                            lWeight := 1;
                        lResCapacityEntry2.Capacity := -(lWeight / lWeightTotal) * (lTempCapacity - CapacitySelect(pWorkTemplateRec, lTempDate));
                        lResCapacityEntry2."Resource No." := pResNo;
                        lResCapacityEntry2."Resource Group No." := lResGp."Resource Group No.";
                        lResCapacityEntry2.Date := lTempDate;
                        if lResCapacityEntry2.Capacity <> 0 then
                            if lResCapacityEntry2.Insert(true) then
                                lChangedDays := lChangedDays + 1;
                    until lResGp.Next = 0
                else begin
                    lResCapacityEntry2.Reset;
                    if lResCapacityEntry2.Find('+') then;
                    lLastEntry := lResCapacityEntry2."Entry No." + 1;
                    lResCapacityEntry2.Reset;
                    lResCapacityEntry2."Entry No." := lLastEntry;
                    lWeight := lResGp.Weight;
                    if lWeight = 0 then
                        lWeight := 1;
                    lResCapacityEntry2.Capacity := -1 * (lTempCapacity - CapacitySelect(pWorkTemplateRec, lTempDate));
                    lResCapacityEntry2."Resource No." := pResNo;
                    lResCapacityEntry2."Resource Group No." := lResGp."Resource Group No.";
                    lResCapacityEntry2.Date := lTempDate;
                    if lResCapacityEntry2.Capacity <> 0 then
                        if lResCapacityEntry2.Insert(true) then
                            lChangedDays := lChangedDays + 1;
                end;
            end;
            lTempDate := lTempDate + 1;
        until lTempDate > pEndDate;
        Commit;
        if pShowMessage then begin
            if lChangedDays > 1 then
                Message(Text006, lChangedDays)
            else
                if lChangedDays = 1 then
                    Message(Text007, lChangedDays)
                else
                    Message(Text008);
        end;
    end;
}

