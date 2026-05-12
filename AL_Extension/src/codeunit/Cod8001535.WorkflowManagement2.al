Codeunit 8001535 "Workflow Management2"
{
    //GL2024  ID dans Nav 2009 : "8004202"
    // #7878 CW 21/02/10 +Reject()
    // //+WKF+ CW 07/08/02 Workflow Management
    // //+WKF+ MB 12/09/06 + CompleteDefaultNextOperation

    TableNo = "Workflow Journal Line";

    trigger OnRun()
    begin
    end;

    var
        tRoleNotGranted: label 'You need %1 role to start procedure %2 for %3 %4';
        tAlreadyExists: label 'Procedure %1 already exists for %2 %3';
        tUseWorkflow: label 'You must use workflow for this function';
        tRejectCommentReasons: label 'You must comment reject reasons.';
        tRejected: label 'REJECTED : %1';


    procedure DeleteTypeNo(pType: Integer; pTemplate: Code[10]; pNo: Code[20])
    var
        lRec: Record "Workflow Journal Line";
    begin
        lRec.SetCurrentkey(Type, "No.");
        lRec.SetRange(Type, pType);
        lRec.SetRange("No.", pNo);
        lRec.DeleteAll;
    end;


    procedure RenameTypeNo(pTemplate: Code[10]; pFromType: Integer; pFromNo: Code[20]; pToType: Integer; pToNo: Code[20])
    var
        lFromRec: Record "Workflow Journal Line";
        lToRec: Record "Workflow Journal Line";
    begin
        lFromRec.SetCurrentkey(Type, "No.");
        lFromRec.SetRange(Type, pFromType);
        lFromRec.SetRange("No.", pFromNo);
        if not lFromRec.IsEmpty then begin
            lFromRec.Find('-');
            repeat
                lToRec.Copy(lFromRec);
                lFromRec.Delete;
                lToRec.Type := pToType;
                lToRec."No." := pToNo;
                lToRec.Insert;
            until lFromRec.Next = 0;
        end;
    end;


    procedure Notify(pType: Integer; pNo: Code[20]; pToUser: Code[20]; pToRole: Code[10]; pDescription: Text[250])
    var
        lRec: Record "Workflow Journal Line";
        lProcedureLine: Record "Workflow Procedure Line";
        lRoleUser: Record "Workflow Role - User";
    begin
        with lRec do begin
            Init;
            Type := pType;
            "No." := pNo;
            "To Role" := pToRole;
            Subject := CopyStr(pDescription, 1, MaxStrLen(Subject));
            Notification := true;
            if pToRole = '' then begin
                lProcedureLine.SetRange("Workflow Type", pType);
                lProcedureLine.SetRange("Workflow Code", '');
                if lProcedureLine.Find('-') then begin
                    "Operation No." := lProcedureLine."Operation No.";
                    "To Role" := lProcedureLine."Role ID";
                    Subject := lProcedureLine.Description;
                    if lRoleUser.Get("To Role", pToUser) then
                        "To User ID" := pToUser;
                end;
            end;
            if pToUser <> UserId then begin
                //GL2024 NAVIBAT  Codeunit.Run(Codeunit::"Workflow Operation", lRec);
                "Attached to Line No." := lRec."Entry No.";
                Modify;
            end;
        end;
    end;


    procedure WorkflowTypeNo(pType: Integer; pJnlTemplate: Code[10]; pNo: Code[20]; pProcedure: Code[10]; pToUser: Code[20]): Boolean
    var
        lRec: Record "Workflow Journal Line";
        lProcedureHeader: Record "Workflow Procedure Header";
        lProcedureLine: Record "Workflow Procedure Line";
        lRoleUser: Record "Workflow Role - User";
        lType: Record "Workflow Type";
        lWorkflowNo: Codeunit "Workflow No.";
    //GL2024  lFormWkf: Page 8004213;
    begin
        //#4644
        //IF NOT lProcedureHeader.GET(pType,pProcedure) THEN BEGIN
        if lProcedureHeader.Get(pType, pProcedure) then begin
            //#4644//
            lProcedureHeader.SetRange("Workflow Type", pType);
            if lProcedureHeader.Find('-') then begin
                lRec.SetRange(Type, pType);
                lRec.SetRange("Template Name", pJnlTemplate);
                lRec.SetRange("No.", pNo);
                //#4913    COMMIT;
                //    Page.RunModal(Page::"Workflow No.",lRec);
                //#3816    PAGE.Run(page::"Workflow No.",lRec);
                //GL2024 lFormWkf.PassToUserID(pToUser);
                //GL2024 lFormWkf.SetTableview(lRec);
                //#5113
                //GL2024  if lFormWkf.wOnOpen(lRec) then
                //#5113//
                //GL2024   lFormWkf.Run;
                //#3816//
                //#5143    EXIT(TRUE);
                exit(not lRec.IsEmpty);
                //#5143//
            end;
        end else
            with lRec do begin
                Init;
                Type := pType;
                "No." := pNo;
                Name := lWorkflowNo.GetName(pType, pJnlTemplate, pNo);
                "Workflow Code" := lProcedureHeader.Code;
                CalcFields("Type Description");
                SetCurrentkey(Type, "No.");
                SetRange(Type, Type);
                SetRange("No.", "No.");
                SetRange("Workflow Code", "Workflow Code");
                SetRange(Open, true);
                if FindFirst then
                    if not Confirm(tAlreadyExists, true, Subject, "Type Description", "No.") then
                        Error('');
                //   ERROR(tAlreadyExists,"Workflow Description","Type Description","No.");
                if lProcedureHeader."Role ID" <> '' then
                    if not lRoleUser.Get(lProcedureHeader."Role ID", UserId) then begin
                        Error(tRoleNotGranted, lProcedureHeader."Role ID", lProcedureHeader.Code, "Type Description", "No.");
                    end;
                lProcedureLine.SetRange("Workflow Type", pType);
                lProcedureLine.SetRange("Workflow Code", "Workflow Code");
                if lProcedureLine.FindFirst then begin
                    "Operation No." := lProcedureLine."Operation No.";
                    "To Role" := lProcedureLine."Role ID";
                    Subject := lProcedureLine.Description;
                    if lRoleUser.Get("To Role", pToUser) then
                        "To User ID" := pToUser;
                    //GL2024 NAVIBAT     Codeunit.Run(Codeunit::"Workflow Operation", lRec);
                end;
            end;
        exit(false);
    end;


    procedure CompleteDefaultNextOperation(var pWkfProcHeader: Record "Workflow Procedure Header")
    var
        lWkfProcLine: Record "Workflow Procedure Line";
        lNextWkfProcLine: Record "Workflow Procedure Line";
    begin
        if pWkfProcHeader.Count > 0 then
            repeat
                lWkfProcLine.SetRange("Workflow Type", pWkfProcHeader."Workflow Type");
                lWkfProcLine.SetRange("Workflow Code", pWkfProcHeader.Code);
                if lWkfProcLine.Find('-') then begin
                    lNextWkfProcLine.Copy(lWkfProcLine);
                    if (lNextWkfProcLine.Next <> 0) then
                        repeat
                            lWkfProcLine."Next Operation No." := lNextWkfProcLine."Operation No.";
                            lWkfProcLine.Modify;
                            lWkfProcLine.Next;
                        until lNextWkfProcLine.Next = 0;
                end;
            until pWkfProcHeader.Next = 0;
    end;


    procedure Exists(pType: Integer; pProcedure: Code[10]): Boolean
    var
        lProcedureHeader: Record "Workflow Procedure Header";
    begin
        exit(lProcedureHeader.Get(pType, pProcedure))
    end;


    procedure Approve(var pRec: Record "Workflow Journal Line")
    var
        tNoLineSelected: label 'No line selected';
    begin
        if pRec."Entry No." = 0 then
            Error(tNoLineSelected);
        if pRec.Notification then
            pRec.Delete
        else begin
            pRec.TestField(Open);
            pRec.NextOperation(pRec);
        end;
    end;


    procedure Reject(pRec: Record "Workflow Journal Line")
    var
        lRec: Record "Workflow Journal Line";
        lCommentLine: Record "Workflow Comment Line";
        lNotify: Record "Workflow Journal Line";
    begin
        pRec.CalcFields(Comment);
        pRec.TestField(Comment);
        /*
        lCommentLine.SETRANGE("Journal Line No.",pRec."Entry No.");
        IF lCommentLine.ISEMPTY THEN BEGIN
          lCommentLine."Journal Line No." := pRec."Entry No.";
          Page.RunModal(Page::"Workflow Journal Comment Sheet",lCommentLine);
          IF lCommentLine.ISEMPTY THEN BEGIN
            EXIT;
          END;
        END;
        */
        lRec.SetCurrentkey(Type, "No.");
        lRec.SetRange(Type, pRec.Type);
        lRec.SetRange("No.", pRec."No.");
        if lRec.FindFirst then begin
            //  Notify(pRec.Type,pRec."No.",lRec."From User ID",lRec."From Role",
            //    COPYSTR(STRSUBSTNO(tRejected,pRec.Subject),1,MAXSTRLEN(pRec.Subject)));

            with lNotify do begin
                Init;
                Type := lRec.Type;
                "No." := lRec."No.";
                "From Role" := pRec."To Role";
                "From User ID" := pRec."To User ID";
                "To Role" := lRec."From Role";
                "To User ID" := lRec."From User ID";
                Subject := CopyStr(StrSubstNo(tRejected, pRec.Subject), 1, MaxStrLen(Subject));
                "Attached to Line No." := lRec."Entry No.";
                Notification := true;
                //GL2024 NAVIBAT     Codeunit.Run(Codeunit::"Workflow Operation", lNotify);
            end;

            pRec.Open := false;
            pRec.Modify;
        end;

    end;


    procedure HasLink(pRec: Record "Workflow Journal Line"): Boolean
    var
        lRecordLink: Record "Record Link";
        lWorkflowType: Record "Workflow Type";
    begin
        if not lWorkflowType.Get(pRec.Type) or (lWorkflowType."Table ID" = 0) then
            exit(false);
        lRecordLink.SetFilter("Record ID", StrSubstNo('%1: %2', lWorkflowType."Table ID", pRec."No."));
        exit(not lRecordLink.IsEmpty);
    end;


    procedure Links(pRec: Record "Workflow Journal Line")
    var
        lRecordLink: Record "Record Link";
        lWorkflowType: Record "Workflow Type";
    begin
        lWorkflowType.Get(pRec.Type);
        lWorkflowType.TestField("Table ID");
        lRecordLink.FilterGroup(2);
        lRecordLink.SetFilter("Record ID", StrSubstNo('%1: %2', lWorkflowType."Table ID", pRec."No."));
        if lRecordLink.FindSet then;
        lRecordLink.FilterGroup(0);
        //GL2024 NAVIBAT  Page.RunModal(Page::"Workflow RecordLinks", lRecordLink);
    end;
}

