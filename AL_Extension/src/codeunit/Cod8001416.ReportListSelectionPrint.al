Codeunit 8001416 "ReportList Selection-Print"
{
    // //+ONE+REPORT_LIST CW 01/07/08 +Job(8004160) +PlanningEntry
    // //+BGW+REPORT_LIST GESWAY 30/03/05 Liste des états à partir de devis,affaires,...

    TableNo = ReportList;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'Do you want to print all the marked reports?';


    procedure Start(var ReportList: Record ReportList; pRecordRef: RecordRef)
    var
        ShowRequestForm: Boolean;
        lSalesHeader: Record "Sales Header";
        lPurchHeader: Record "Purchase Header";
        lJob: Record Job;
        lContact: Record Contact;
        lOpportunity: Record Opportunity;
        lPlanningEntry: Record "Planning Entry";
    begin
        with ReportList do begin
            ShowRequestForm := true;
            if Find('-') then
                if Next() <> 0 then begin
                    if not Confirm(Text000, true) then
                        exit;

                    ShowRequestForm := false;
                end;

            //+BGW+REPORT_LIST
            if "Report ID" = 0 then
                exit;
            case pRecordRef.Number of
                0:
                    //+BGW+REPORT_LIST//

                    if Find('-') then begin
                        repeat
                            Report.Run("Report ID", ShowRequestForm);
                        until Next = 0;
                    end;

                //+BGW+REPORT_LIST
                Database::"Sales Header":
                    begin // 36
                        lSalesHeader.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lSalesHeader);
                            until Next = 0;
                    end;
                Database::"Purchase Header":
                    begin // 38
                        lPurchHeader.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lPurchHeader);
                            until Next = 0;
                    end;
                Database::"Job":
                    begin // 167
                        lJob.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lJob);
                            until Next = 0;
                    end;
                Database::Contact:
                    begin // 5050
                        lContact.SetPosition(pRecordRef.GetPosition);
                        lContact.SetRecfilter;
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lContact);
                            until Next = 0;
                    end;
                Database::Opportunity:
                    begin // 5092
                        lOpportunity.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lOpportunity);
                            until Next = 0;
                    end;
                //+BGW+REPORT_LIST//
                //+ONE+REPORT_LIST
                Database::Job:
                    begin // 8004160
                        lJob.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lJob);
                            until Next = 0;
                    end;
                Database::"Planning Entry":
                    begin // 8004130
                        lPlanningEntry.SetView(pRecordRef.GetView);
                        if Find('-') then
                            repeat
                                Report.Run("Report ID", ShowRequestForm, true, lPlanningEntry);
                            until Next = 0;
                    end;
            end;
            //+ONE+REPORT_LIST//

            Reset;
        end;
    end;
}

