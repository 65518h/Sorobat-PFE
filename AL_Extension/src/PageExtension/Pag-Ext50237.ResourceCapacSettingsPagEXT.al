PageExtension 50237 "Resource Capac Settings_PagEXT" extends "Resource Capacity Settings"
{
    layout
    {


    }
    actions
    {
        modify(UpdateCapacity)
        {
            //GL2024  trigger OnAfterAction()
            trigger OnBeforeAction()
            VAR
                lPlanningIntegration: Codeunit "Planning Integration";
            begin
                lPlanningIntegration.SetCapacity(rec."No.", StartDate, EndDate, WorkTemplateRec, TRUE);
                //GL2024 CurrPage.CLOSE;
            end;
        }


    }
    trigger OnOpenPage()
    begin
        StartDate := 0D;
        EndDate := 0D;
    end;

    var

        WorkTemplateRec: Record "Work-Hour Template";
        StartDate: Date;
        EndDate: Date;





}

