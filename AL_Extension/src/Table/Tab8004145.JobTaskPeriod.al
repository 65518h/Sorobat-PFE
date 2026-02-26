Table 8004145 "Job Task Period"
{
    Caption = 'Job Task Period';
    // DrillDownPageID = 8004147;
    //LookupPageID = 8004147;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
                //++ABO++ GESWAY 30/06/08
            end;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Date Calculation"; DateFormula)
        {
            Caption = 'Date Calculation';
        }
        field(4; "Monthly Factor"; Decimal)
        {
            //blankzero = true;
            Caption = 'Monthly Factor';
            DecimalPlaces = 0 : 5;
        }
        field(5; "Starting Date Calculation"; DateFormula)
        {
            Caption = 'Starting Date Calculation';
        }
        field(11; Monday; Boolean)
        {
            Caption = 'Monday';
        }
        field(12; Tuesday; Boolean)
        {
            Caption = 'Tuesday';
        }
        field(13; Wenesday; Boolean)
        {
            Caption = 'Wednesday';
        }
        field(14; Thursday; Boolean)
        {
            Caption = 'Thursday';
        }
        field(15; Friday; Boolean)
        {
            Caption = 'Friday';
        }
        field(16; Saterday; Boolean)
        {
            Caption = 'Saturday';
        }
        field(17; Sunday; Boolean)
        {
            Caption = 'Sunday';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        tDivisor: label 'undefined divisor';
        tNotMultiple: label 'must be a multiple or a divisor of time unit %1';


    procedure fSetNextInvoicePeriod(pSubscrStartingDate: Date; pSubscrEndDate: Date; pSubscrPostingDate: Date; pBaseDate: Date; var pPeriodStart: Date; var pPeriodEnd: Date): Boolean
    begin
        if (pSubscrEndDate <> 0D) and (pSubscrPostingDate >= pSubscrEndDate) then
            exit(false);

        if (pBaseDate <> 0D) and (Format("Starting Date Calculation") <> '') then
            pPeriodStart := pBaseDate
        else
            if pSubscrPostingDate = 0D then
                pPeriodStart := pSubscrStartingDate
            else
                pPeriodStart := pSubscrPostingDate + 1;
        if Format("Starting Date Calculation") <> '' then
            pPeriodStart := CalcDate("Starting Date Calculation", pPeriodStart);
        pPeriodEnd := CalcDate("Date Calculation", pPeriodStart) - 1;

        exit((pBaseDate = 0D) or (pBaseDate >= pPeriodStart));
    end;


    procedure fProrataTemporis(pAmount: Decimal; pTimeUnit: DateFormula; pFromDate: Date; pToDate: Date; pRoundingPrecision: Decimal) Return: Decimal
    var
        lDate: Date;
        lDivisor: Integer;
        l1D: DateFormula;
        l1W: DateFormula;
        l1M: DateFormula;
        l1Q: DateFormula;
        l1Y: DateFormula;
        tDivisor: label 'undefined divisor';
    begin
        //IF FORMAT(pTimeUnit) = '' THEN
        //  EXIT(pAmount);
        lDate := pFromDate;
        while CalcDate(pTimeUnit, lDate) - 1 <= pToDate do begin
            Return += pAmount;
            lDate := CalcDate(pTimeUnit, lDate);
        end;

        Evaluate(l1D, '<1D>');
        Evaluate(l1W, '<1W>');
        Evaluate(l1M, '<1M>');
        Evaluate(l1Q, '<1Q>');
        Evaluate(l1Y, '<1Y>');
        case pTimeUnit of
            l1D:
                lDivisor := 1;
            l1W:
                lDivisor := 7;
            l1M:
                lDivisor := 30;
            l1Q:
                lDivisor := 90;
            l1Y:
                lDivisor := 360;
            else
                Error(tDivisor, pTimeUnit);
        end;

        Return += pAmount / lDivisor * (pToDate - lDate + 1);
        exit(ROUND(Return, pRoundingPrecision));
    end;


    procedure fTimeUnitsPerPeriod(pTimeUnit: DateFormula): Decimal
    var
        lDate: Date;
        lEndDate: Date;
        lCount: Integer;
    begin
        if pTimeUnit = "Date Calculation" then
            exit(1);
        lDate := 20000101D;
        if CalcDate(pTimeUnit, lDate) > CalcDate("Date Calculation", lDate) then begin
            lEndDate := CalcDate(pTimeUnit, lDate);
            repeat
                lCount += 1;
                lDate := CalcDate("Date Calculation", lDate);
            until lDate >= lEndDate;
            if lDate <> lEndDate then
                FieldError("Date Calculation", StrSubstNo(tNotMultiple, pTimeUnit));
            exit(1 / lCount);
        end else begin
            lEndDate := CalcDate("Date Calculation", lDate);
            repeat
                lCount += 1;
                lDate := CalcDate(pTimeUnit, lDate);
            until lDate >= lEndDate;
            if lDate <> lEndDate then
                FieldError("Date Calculation", StrSubstNo(tNotMultiple, pTimeUnit));
            exit(lCount);
        end;
    end;
}

