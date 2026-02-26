page 52048919 "Rec. Absence Overview by Cat."
{
    //GL2024  ID dans Nav 2009 : "39001440"
    Caption = 'Absence Overview by Categories';
    DataCaptionExpression = '';
    PageType = Card;
    SaveValues = true;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("Employee No. Filter"; rec."Employee No. Filter")
                {
                    ApplicationArea = all;
                }
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = all;
                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';
                    ToolTip = 'Day';

                    trigger OnValidate()
                    begin
                        IF PeriodType = PeriodType::"Accounting Period" THEN
                            AccountingPerioPeriodTypeOnVal;
                        IF PeriodType = PeriodType::Year THEN
                            YearPeriodTypeOnValidate;
                        IF PeriodType = PeriodType::Quarter THEN
                            QuarterPeriodTypeOnValidate;
                        IF PeriodType = PeriodType::Month THEN
                            MonthPeriodTypeOnValidate;
                        IF PeriodType = PeriodType::Week THEN
                            WeekPeriodTypeOnValidate;
                        IF PeriodType = PeriodType::Day THEN
                            DayPeriodTypeOnValidate;
                    end;
                }
            }
            part(SubForm; "Rec. Abs. Over. by Cat. Matrix")
            {
                ApplicationArea = all;
            }
            field(AbsenceAmountType; AbsenceAmountType)
            {
                ApplicationArea = all;
                OptionCaption = 'Balance at Date,Net Change';
                ToolTip = 'Net Change';

                trigger OnValidate()
                begin
                    IF AbsenceAmountType = AbsenceAmountType::"Balance at Date" THEN
                        BalanceatDateAbsenceAmountType;
                    IF AbsenceAmountType = AbsenceAmountType::"Net Change" THEN
                        NetChangeAbsenceAmountTypeOnVa;
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        PasteFilter;
    end;

    trigger OnOpenPage()
    begin
        PasteFilter;
    end;

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";
        EmployeeNoFilter: Text[250];

    local procedure PasteFilter()
    begin
        EmployeeNoFilter := rec.GETFILTER("Employee No. Filter");
        //GL2024
        /*CurrPage.Subpage.FORM.MatrixUpdate(
          AbsenceAmountType,PeriodType,
          EmployeeNoFilter);          */

    end;

    local procedure AccountingPerioPeriodTypOnPush()
    begin
        PasteFilter;
    end;

    local procedure YearPeriodTypeOnPush()
    begin
        PasteFilter;
    end;

    local procedure QuarterPeriodTypeOnPush()
    begin
        PasteFilter;
    end;

    local procedure MonthPeriodTypeOnPush()
    begin
        PasteFilter;
    end;

    local procedure WeekPeriodTypeOnPush()
    begin
        PasteFilter;
    end;

    local procedure DayPeriodTypeOnPush()
    begin
        PasteFilter;
    end;

    local procedure NetChangeAbsenceAmountTyOnPush()
    begin
        PasteFilter;
    end;

    local procedure BalanceatDateAbsenceAmouOnPush()
    begin
        PasteFilter;
    end;

    local procedure DayPeriodTypeOnValidate()
    begin
        DayPeriodTypeOnPush;
    end;

    local procedure WeekPeriodTypeOnValidate()
    begin
        WeekPeriodTypeOnPush;
    end;

    local procedure MonthPeriodTypeOnValidate()
    begin
        MonthPeriodTypeOnPush;
    end;

    local procedure QuarterPeriodTypeOnValidate()
    begin
        QuarterPeriodTypeOnPush;
    end;

    local procedure YearPeriodTypeOnValidate()
    begin
        YearPeriodTypeOnPush;
    end;

    local procedure AccountingPerioPeriodTypeOnVal()
    begin
        AccountingPerioPeriodTypOnPush;
    end;

    local procedure NetChangeAbsenceAmountTypeOnVa()
    begin
        NetChangeAbsenceAmountTyOnPush;
    end;

    local procedure BalanceatDateAbsenceAmountType()
    begin
        BalanceatDateAbsenceAmouOnPush;
    end;
}

