page 52048921 "Rec. Abs. Overview by Periods"
{
    //GL2024  ID dans Nav 2009 : "39001442"
    PageType = List;
    SaveValues = true;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("<Filtre motif absence>"; rec."Cause of Absence Filter")
            {
                ApplicationArea = all;
                Caption = '<Filtre motif absence>';
            }
            repeater("<Control1000000002>")
            {
                ShowCaption = false;

                field("<N°>"; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = '<N°>';
                }
                field("Nom complet"; rec.FullName)
                {
                    ApplicationArea = all;
                }
                field("Total absences"; rec."Total validated Absence")
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
        // PeriodFormMgt: Codeunit 359;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AbsenceAmountType: Option "Balance at Date","Net Change";

    local procedure SetDateFilter()
    begin

        SetDateFilter()
        /*IF AbsenceAmountType = AbsenceAmountType::"Net Change" THEN
          IF CurrForm.Matrix.MatrixRec."Period Start" = CurrForm.Matrix.MatrixRec."Period End" THEN
            SETRANGE("Date Filter",CurrForm.Matrix.MatrixRec."Period Start")
          ELSE
            SETRANGE("Date Filter",CurrForm.Matrix.MatrixRec."Period Start",CurrForm.Matrix.MatrixRec."Period End")
        ELSE
          SETRANGE("Date Filter",0D,CurrForm.Matrix.MatrixRec."Period End");*/
    end;
}

