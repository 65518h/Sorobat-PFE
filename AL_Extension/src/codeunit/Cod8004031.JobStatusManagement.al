Codeunit 8004031 "Job Status Management"
{
    // //JOB_STATUS CW 28/10/05 Job Status Management


    trigger OnRun()
    begin
    end;

    var
        tChangeJobStatus: label 'can''t be changed from %1 to %2';
        tNotStartStatus: label 'can''t be the first one';
        tOpenLines: label '%1 not allowed with unposted %2';
        JobStatusLog: Record "Job Status Log";
        JobStatusDate: Date;
        JobStatusFilter: Text[250];
        tStatusNotEnable: label 'not enable for this status on job %1';


    procedure JobStatusChange(var xRec: Record Job; var pRec: Record Job)
    var
        lJobStatus: Record "Job Status";
        xJobStatus: Record "Job Status";
        lJobStatusMatrix: Record "Job Status Matrix";
        lJobStatusLog: Record "Job Status Log";
        lSalesLine: Record "Sales Line";
        lPurchLine: Record "Purchase Line";
    begin
        lJobStatus.Get(pRec."Job Status");
        if lJobStatus."Codeunit ID" <> 0 then
            Codeunit.Run(lJobStatus."Codeunit ID", pRec);

        with pRec do begin
            if lJobStatus.Status <> Status then
                Validate(Status, lJobStatus.Status);
            if "Job Status" <> xRec."Job Status" then
                if (xRec."Job Status" = '') and not lJobStatus."Start Status" then
                    FieldError("Job Status", tNotStartStatus)
                else
                    if (xRec."Job Status" <> '') and not lJobStatusMatrix.Get(xRec."Job Status", "Job Status") then
                        FieldError("Job Status", StrSubstNo(tChangeJobStatus, xRec."Job Status", "Job Status"))
                    else begin
                        if xRec."Job Status" <> '' then begin
                            xJobStatus.Get(xRec."Job Status");
                            if xJobStatus."Sales Document" then begin
                            end;
                            if xJobStatus."Sales Posting" and not lJobStatus."Sales Posting" then begin
                                lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                                lSalesLine.SetRange("Order Type", 0);
                                lSalesLine.SetRange("Document Type", lSalesLine."document type"::Order);
                                lSalesLine.SetRange("Structure Line No.", 0);
                                lSalesLine.SetRange("Job No.", "No.");
                                lSalesLine.SetRange("Completely Shipped", false);
                                lSalesLine.SetFilter(Type, '<>%1', lSalesLine.Type::" ");
                                if lSalesLine.Find('-') then
                                    FieldError("Job Status", StrSubstNo(tOpenLines, lJobStatus.FieldCaption("Sales Posting"), lSalesLine.TableCaption));
                            end;
                            if xJobStatus."Usage Posting" and not lJobStatus."Usage Posting" then begin
                                lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                                lSalesLine.SetRange("Order Type", lSalesLine."order type"::"Supply Order");
                                lSalesLine.SetRange("Job No.", "No.");
                                lSalesLine.SetRange("Completely Shipped", false);
                                lSalesLine.SetFilter(Type, '<>%1', lSalesLine.Type::" ");
                                if lSalesLine.Find('-') then
                                    FieldError("Job Status", StrSubstNo(tOpenLines, lJobStatus.FieldCaption("Usage Posting"), lSalesLine.TableCaption));
                            end;
                            if xJobStatus."Purchase Posting" and not lJobStatus."Purchase Posting" then begin
                                lPurchLine.SetCurrentkey("dysJob No.");
                                lPurchLine.SetRange("dysJob No.", "No.");
                                lPurchLine.SetRange("Completely Received", false);
                                lPurchLine.SetFilter(Type, '<>%1', lPurchLine.Type::" ");
                                if lPurchLine.Find('-') then
                                    FieldError("Job Status", StrSubstNo(tOpenLines, lJobStatus.FieldCaption("Purchase Posting"), lPurchLine.TableCaption));
                            end;
                        end;
                        lJobStatusLog."Job No." := "No.";
                        lJobStatusLog.Date := WorkDate;
                        lJobStatusLog."User ID" := UserId;
                        lJobStatusLog."Old Value" := xRec."Job Status";
                        lJobStatusLog."New Value" := "Job Status";
                        lJobStatusLog.Insert(true);
                    end;
        end;
    end;


    procedure SetJobStatusFilter(var pJob: Record Job)
    begin
        if pJob.GetFilter("Posting Date Filter") <> '' then begin
            JobStatusDate := pJob.GetRangemax("Posting Date Filter");
            JobStatusLog.SetCurrentkey("Job No.", Date);
            JobStatusLog.SetRange(Date, 0D, JobStatusDate);
            JobStatusFilter := pJob.GetFilter("Job Status");
            pJob.SetFilter("Job Status", JobStatusFilter);
        end;
    end;


    procedure SetJobStatusToDate(var pJob: Record Job): Boolean
    var
        lJobStatusLog: Record "Job Status Log";
    begin
        if JobStatusDate = 0D then
            exit(true)
        else begin
            JobStatusLog.SetRange("Job No.", pJob."No.");
            if not JobStatusLog.Find('+') then
                exit(false)
            else
                if JobStatusFilter = '' then
                    exit(true)
                else begin
                    lJobStatusLog := JobStatusLog;
                    lJobStatusLog.SetRecfilter;
                    lJobStatusLog.SetRange("New Value", JobStatusFilter);
                    exit(lJobStatusLog.Find('+'));
                end;
        end;
    end;


    procedure Check(pJobNo: Code[20]; pFieldNo: Integer)
    var
        lJob: Record Job;
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lValue: Boolean;
        lJobStatus: Record "Job Status";
    begin
        lJob.Get(pJobNo);
        lJob.TestField(Blocked, lJob.Blocked::" ");
        //Une affaire de totalisation peut avoir des écritures, sinon il n'est plus possible de transformer
        //un devis en commande avec création de sous affaires
        //lJob.TESTFIELD(Summarize,FALSE);
        //  lJob.TestField("Job Status");
        lJobStatus.Get(lJob."Job Status");
        lRecordRef.GetTable(lJobStatus);
        lFieldRef := lRecordRef.Field(pFieldNo);
        Evaluate(lValue, Format(lFieldRef.Value));
        if not lValue then
            lFieldRef.FieldError(StrSubstNo(tStatusNotEnable, pJobNo));
    end;


    procedure CheckJobJnlLine(var pJobJnlLine: Record "Job Journal Line")
    var
        lJob: Record Job;
        lJobStatus: Record "Job Status";
    begin
        if pJobJnlLine."Entry Type" = pJobJnlLine."entry type"::Sale then
            Check(pJobJnlLine."Job No.", lJobStatus.FieldNo("Sales Posting"))
        else
            if pJobJnlLine.Type = pJobJnlLine.Type::Resource then
                Check(pJobJnlLine."Job No.", lJobStatus.FieldNo("Resource Posting"))
            //#4418
            //#5127  ELSE IF pJobJnlLine."Bal. Job No." = '' THEN
            else
                if pJobJnlLine."Journal Batch Name" = '' then
                    Check(pJobJnlLine."Job No.", lJobStatus.FieldNo("Purchase Posting"))
                //#4418 //
                else
                    Check(pJobJnlLine."Job No.", lJobStatus.FieldNo("Usage Posting"));
    end;
}

