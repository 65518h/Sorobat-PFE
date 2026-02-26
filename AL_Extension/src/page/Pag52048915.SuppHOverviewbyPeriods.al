page 52048915 "Supp.H Overview by Periods"
{
    //GL2024  ID dans Nav 2009 : "39001436"
    Caption = 'Supp.H Overview by Periods';
    PageType = List;
    SaveValues = true;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout

    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }

                field(FullName; Rec.FullName)
                {
                    ApplicationArea = all;
                }
                field("Recorded Supp. Hours"; Rec."Recorded Supp. Hours")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        //PeriodFormMgt: Codeunit 359;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";

    local procedure SetDateFilter()
    begin

        /* IF AbsenceAmountType = AbsenceAmountType::"Net Change" THEN
             IF CurrForm.Matrix.MatrixRec."Period Start" = CurrForm.Matrix.MatrixRec."Period End" THEN
                 SETRANGE("Date Filter", CurrForm.Matrix.MatrixRec."Period Start")
             ELSE
                 SETRANGE("Date Filter", CurrForm.Matrix.MatrixRec."Period Start", CurrForm.Matrix.MatrixRec."Period End")
         ELSE
             SETRANGE("Date Filter", 0D, CurrForm.Matrix.MatrixRec."Period End");*/
    end;
}

