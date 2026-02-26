Codeunit 8001553 "PlanningForce Connector"
{
    //GL2024  ID dans Nav 2009 : "8035006"
    // //PLANNINGFORCE

    TableNo = "Job Task";

    trigger OnRun()
    var
        lJob: Record Job;
    begin
        if rec.GetFilter("Job No.") <> '' then
            lJob.SetFilter("No.", rec.GetFilter("Job No."));
        //GL2024 NAVIBAT  Report.Run(Report::"PlanningForce Export Job Task", true, true, lJob);
    end;

    var
    //GL2024 NAVIBAT PlanningForceExportJobTask: Report 8035000;
}

