Codeunit 8001442 "Workflow Connector"
{
    // //+WKF+CONNECTOR CW 26/01/10 Connect to Workflow
    // //+BGW+WKF_CONNECTOR CW 26/01/10 Workflow Connector (Overloaded by Workflow Add-on)


    trigger OnRun()
    var
        lWorkflowJnlLine: Record "Workflow Journal Line";
    begin
        // From Codeunit1 CompanyOpen
        //RTC - 2009
        //#8774
        //IF ((lWorkflowJnlLine.READPERMISSION) AND (NOT ISSERVICETIER)) THEN BEGIN
        /*  //GL2024 NAVIBAT   if ((lWorkflowJnlLine.ReadPermission) and (wWfkSingleInstance.fGetSelectedClient() = 1)) then begin
               //#8774//
               //RTC - 2009//
               PAGE.Run(page::"Workflow Notification");
           end;*/
    end;

    var
        tNoWorkflow: label 'Workflow not Implemented.';
        wWfkSingleInstance: Codeunit "Workflow SingleInstance";


    procedure OnPush(pFormID: Integer; pRecordRef: RecordRef)
    var
        lFieldRef: FieldRef;
        i: Integer;
        lWorkflowJournalLine: Record "Workflow Journal Line";
    begin
        //+WKF+CONNECTOR
        repeat
            i += 1;
            lFieldRef := pRecordRef.FieldIndex(i);
        until (lFieldRef.Name in ['No.', 'Document No.']) or (i = pRecordRef.FieldCount);

        with lWorkflowJournalLine do begin
            SetCurrentkey(Type, "No.");
            SetRange(Type, pFormID);
            "No." := lFieldRef.Value;
            SetRange("No.", "No.");
        end;
        //GL2024 NAVIBAT    Page.RunModal(Page::"Workflow No.", lWorkflowJournalLine);
        //+WKF+CONNECTOR
    end;
}

