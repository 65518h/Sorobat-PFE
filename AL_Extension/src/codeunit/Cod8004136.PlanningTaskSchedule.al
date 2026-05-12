Codeunit 8004136 "Planning Task Schedule"
{
    // //+ONE+MS-PROJECT CW 10/10/07

    TableNo = "Sales Line";

    trigger OnRun()
    begin
    end;

    var
        CalendarMgt: Codeunit "Calendar Management";
        PlanningSetup: Record "Planning Setup";
        tNoWorkingDay: label 'No workking day in this period.';
        tMissingParm: label 'Missing Parameter';


    procedure Schedule(var pPlanningLine: Record "Planning Line"; pWorkingDays: Decimal; pQtyPerDay: Decimal; pReplaceMode: Boolean; pFromDate: Date; pToDate: Date)
    var
        lPlanning: Record "Planning Entry";
        lQuantityToPlan: Decimal;
        lWorkingDays: Integer;
        lDate: Date;
        lDummy: Text[30];
    begin
        if PlanningSetup."Primary Key" = '' then begin
            PlanningSetup.Get;
            PlanningSetup."Primary Key" := 'Done';
        end;
        if pWorkingDays <> 0 then
            pQtyPerDay := ROUND(pPlanningLine."Work Load (h)" / pWorkingDays, 0.01);

        lPlanning.SetCurrentkey("Job No.", "Job Task No.");
        lPlanning.SetRange("Planning Task No.", pPlanningLine."Task No.");

        if pReplaceMode then
            lQuantityToPlan := pPlanningLine."Work Load (h)"
        else begin
            lPlanning.CalcSums(Quantity);
            lQuantityToPlan := pPlanningLine."Work Load (h)" - lPlanning.Quantity;
        end;

        if lQuantityToPlan <= 0 then
            exit;

        lPlanning.Init;
        lPlanning.Validate("Planning Task No.", pPlanningLine."Task No.");

        lPlanning.Quantity := pQtyPerDay;

        if (pFromDate <> 0D) and (pToDate <> 0D) then begin
            if lPlanning.Quantity = 0 then begin
                lDate := pFromDate;
                repeat
                    /* //GL2024  if not CalendarMgt.CheckDateStatus(PlanningSetup."Base Calendar Code", lDate, lDummy) then
                          lWorkingDays += 1;*/
                    lDate := lDate + 1;
                until lDate > pToDate;
                if lWorkingDays = 0 then
                    Error(tNoWorkingDay);
                lPlanning.Quantity := ROUND(lQuantityToPlan / lWorkingDays, 0.01);
            end;
            Distribute(lPlanning, pFromDate, pToDate, +1, lQuantityToPlan, pQtyPerDay);
        end else
            if (pFromDate = 0D) and (pToDate = 0D) or (pQtyPerDay <= 0) then
                Error(tMissingParm)
            else
                if pFromDate <> 0D then
                    Distribute(lPlanning, pFromDate, 0D, +1, lQuantityToPlan, pQtyPerDay)
                else
                    Distribute(lPlanning, pToDate, 0D, -1, lQuantityToPlan, pQtyPerDay);
    end;

    local procedure Distribute(pPlanning: Record "Planning Entry"; pFromDate: Date; pToDate: Date; pStep: Integer; pQuantityToPlan: Decimal; pQtyPerDay: Decimal)
    var
        lPlannedQuantity: Decimal;
        lDate: Date;
        lDummy: Text[30];
    begin
        lDate := pFromDate;
        repeat
            /* //GL2024 if not CalendarMgt.CheckDateStatus(PlanningSetup."Base Calendar Code", lDate, lDummy) then begin
                 pPlanning.Date := lDate;
                 pPlanning.Insert(true);
                 lPlannedQuantity += pPlanning.Quantity;
             end;*/
            lDate := lDate + pStep;
        until (lPlannedQuantity >= pQuantityToPlan) or (pToDate <> 0D) and (lDate > pToDate);
        if (lPlannedQuantity <> pQuantityToPlan) and ((pQtyPerDay = 0) or (pFromDate = 0D) or (pToDate = 0D)) then begin
            pPlanning.Quantity := pPlanning.Quantity + (pQuantityToPlan - lPlannedQuantity);
            pPlanning.Modify;
        end;
    end;
}

