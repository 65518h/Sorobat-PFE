page 52048920 "Rec. Abs. Over. by Cat. Matrix"
{
    //GL2024  ID dans Nav 2009 : "39001441"
    // CurrForm.Matrix.MatrixRec."Total Absence"
    // CurrForm.Matrix.MatrixRec."Total validated Absence"

    Caption = 'Absence Over. by Cat. Matrix';
    PageType = ListPart;
    SourceTable = Date;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("<Début période>"; rec."Period Start")
            {
                ApplicationArea = all;
                Caption = 'Period Start';
            }
            field("<Nom période>"; rec."Period Name")
            {
                ApplicationArea = all;
                Caption = 'Nom période';
            }
            label("Total absences enregistrées")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        //EXIT(PeriodFormMgt.FindDate(Which, Rec, PeriodType));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //EXIT(PeriodFormMgt.NextDate(Steps, Rec, PeriodType));
    end;

    var
        EmployeeAbsence: Record "Employee's days off Entry";
        // PeriodFormMgt: Codeunit 359;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";
        EmployeeNoFilter: Text[250];


    procedure MatrixUpdate(NewAbsenceType: Option "Absence to Date","Absence at Date"; NewPeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period"; NewEmployeeNoFilter: Text[250])
    begin
        AbsenceAmountType := NewAbsenceType;
        PeriodType := NewPeriodType;
        EmployeeNoFilter := NewEmployeeNoFilter;
        CurrPage.UPDATE(FALSE);
    end;
}

