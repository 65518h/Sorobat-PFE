Codeunit 8001541 "WorkFlow Mail Notification"
{
    //GL2024  ID dans Nav 2009 : "8004209"
    Permissions = TableData "Vendor Ledger Entry" = rm;

    trigger OnRun()
    begin
    end;

    var
        tMailSenderName: label 'Notify : %1 - %2';
        tErrSmtpSetup: label 'Any Mail server has been set';
        tErrEmailCompany: label 'The Email not set a the company informations';
        tErrUserEmail: label 'You must enter the Company Email for the employee : %1 %2 (%3)';
        tMailSubject: label 'Workflow notification : %1';
        tUserNotFound: label 'The employee %1 is not found. This adress si not available';
        tImport: label 'Import';
        tExport: label 'Export';

    /*GL2024
        procedure SendMail(var pWorkflowJournalLine: Record 8004210)
        var
          //GL2024  lSMTPMail: Codeunit 400;
            lWorkflowProcedureLine: Record 8004206;
            lWorkflowRoleUser: Record 8004203;
            lWorkflowType: Record 8004200;
          //GL2024  lSmtpMailSetup: Record 409;
            lMailTO: Text[255];
            lMailFROM: Text[255];
        begin
            //+WKF+MAIL\\
            lWorkflowProcedureLine.Get(pWorkflowJournalLine.Type, pWorkflowJournalLine."Workflow Code",
                                        pWorkflowJournalLine."Operation No.");
            if not (lWorkflowProcedureLine."Notify By Mail") or //ML
                (pWorkflowJournalLine."To User ID" = '') or
                (pWorkflowJournalLine."From User ID" = pWorkflowJournalLine."To User ID") then
                exit;

            //Verification si la configuration du serveur de mail a été réalisé
            if (not lSmtpMailSetup.Get()) then
                Error(tErrSmtpSetup);


            if fFindMailAdressTO(pWorkflowJournalLine."To User ID", lMailTO) then begin
            if not fFindMailAdressFROM(pWorkflowJournalLine."From User ID", lMailFROM, pWorkflowJournalLine) then
                    Error(tErrEmailCompany);
                pWorkflowJournalLine.CalcFields("Type Description", "Workflow Description");
                lSMTPMail.CreateMessage(lSmtpMailSetup."SMTP Server",
                                        lMailFROM, lMailTO,
                                        StrSubstNo(tMailSenderName, pWorkflowJournalLine."Workflow Description", pWorkflowJournalLine.Subject)
                                        , '', true);
                fGetMailBody(pWorkflowJournalLine, lWorkflowProcedureLine, lSMTPMail);
                lSMTPMail.Send;
            end;
        end;
    */

    procedure fGetMailBody(var pWorkflowJournalLine: Record "Workflow Journal Line"; var pWorkflowProcedureLine: Record "Workflow Procedure Line"/*GL2024 ; var pSMTPMail: Codeunit 400*/) pReturnText: Text[1024]
    var
        InStreamTemplate: InStream;
        InSReadChar: Text[1];
        Body: Text[1024];
        I: Integer;
        lBasic: Codeunit Basic;
        lWkfNo: Codeunit "Workflow No.";
        lRecRef: RecordRef;
        lDataRef: Text[250];
        lDataIsRef: Boolean;
        lTools: Codeunit Tools;
    begin
        Body := '';
        pWorkflowProcedureLine.CalcFields(CommentBLOB);
        pWorkflowProcedureLine.CommentBLOB.CreateInstream(InStreamTemplate);

        while InStreamTemplate.eos() = false do begin
            InStreamTemplate.ReadText(InSReadChar, 1);
            if not (lTools.Ansi2Ascii(InSReadChar) in ['ÿ', 'þ']) then
                Body := Body + InSReadChar;
            if ((StrPos(lDataRef, '%') = 1) or ((lDataRef = '') and (InSReadChar = '%'))) and
               (InSReadChar in ['%', '0' .. '9', '.', '']) then begin
                lDataRef := lDataRef + InSReadChar;
                lDataIsRef := true;
            end else begin
                lDataIsRef := false;
                lDataRef := '';
            end;
            I := I + 1;
            if (I >= 100) and (not lDataIsRef) then begin
                if lWkfNo.GetRecRef(pWorkflowJournalLine.Type, pWorkflowJournalLine."Workflow Code"
                                  , pWorkflowJournalLine."No.", lRecRef) then
                    Body := lBasic.SubstituteValues(Body, lRecRef, StrSubstNo('%' + '%1.', lRecRef.RecordId.TableNo), GlobalLanguage);
                //GL2024    pSMTPMail.AppendBody(DelChr(lTools.Ansi2Ascii(Body), '=', 'ÿ'));
                Body := '';
                I := 0;
            end;
        end;
        /*GL2024  if lWkfNo.GetRecRef(pWorkflowJournalLine.Type, pWorkflowJournalLine."Workflow Code"
                            , pWorkflowJournalLine."No.", lRecRef) then
              pSMTPMail.AppendBody(lBasic.SubstituteValues(Body, lRecRef, StrSubstNo('%' + '%1.', lRecRef.RecordId.TableNo), GlobalLanguage))
          else
              pSMTPMail.AppendBody(DelChr(lTools.Ansi2Ascii(Body), '=', 'ÿ'));*/
    end;


    procedure fFindMailAdressTO(pUserID: Code[20]; var pMailTO: Text[255]) Return: Boolean
    var
        lUserSetup: Record "User Setup";
    begin
        if lUserSetup.Get(pUserID) then begin
            Return := true;
            pMailTO := lUserSetup."E-Mail";
            if pMailTO = '' then
                Error(StrSubstNo(tErrUserEmail, pUserID));
        end else begin
            Message(StrSubstNo(tUserNotFound, pUserID));
            Return := false;
        end;
    end;

    /* GL2024
        procedure fFindMailAdressFROM(pUserID: Code[20]; var pMailFROM: Text[255]; pWkfJnlLine: Record 8004210) Return: Boolean
        var
            lCompanyInformation: Record 79;
            lUserSetup: Record 91;
          //GL2024  lSMTPSetup: Record 409;
        begin
            // Verification si l'adresse mail dans les informations société est bien configuré
           lSMTPSetup.Get;
            if not (lSMTPSetup.Authentication in [lSMTPSetup.Authentication::Anonymous, lSMTPSetup.Authentication::NTLM]) or
                 lSMTPSetup."SSL/TLS" then begin
                pMailFROM := StrSubstNo('%1;%2', lSMTPSetup."User ID", pWkfJnlLine."To User ID");
            end else begin
                if pMailFROM = '' then
                    if lUserSetup.Get(pUserID) then
                        pMailFROM := lUserSetup."E-Mail";
                if pMailFROM = '' then begin
                    lCompanyInformation.Get;
                    pMailFROM := lCompanyInformation."E-Mail";
                end;
            end;
            Return := (pMailFROM <> '');
        end;*/


    procedure ImportBODY(var pWorkflowProcedureLine: Record "Workflow Procedure Line")
    var
        //GL2024  lCommonDlgMgt: Codeunit 412;
        lFileName: Text[260];
    begin
        //GL2024  lFileName := lCommonDlgMgt.OpenFile(tImport, '', 6, '', 0);
        /*//GL2024 License  if Exists(lFileName) then begin
              pWorkflowProcedureLine.CalcFields(CommentBLOB);
              pWorkflowProcedureLine.CommentBLOB.Import(lFileName);
              pWorkflowProcedureLine.Modify;
          end;//GL2024 License*/
    end;


    procedure ExportBODY(pWorkflowProcedureLine: Record "Workflow Procedure Line")
    var
        //GL2024  lCommonDlgMgt: Codeunit 412;
        lFileName: Text[260];
    begin
        pWorkflowProcedureLine.CalcFields(CommentBLOB);
        if pWorkflowProcedureLine.CommentBLOB.Hasvalue then begin
            //GL2024  lFileName := lCommonDlgMgt.OpenFile(tExport, '', 6, '', 1);
            //GL2024 License    pWorkflowProcedureLine.CommentBLOB.Export(lFileName);
        end;
    end;


    procedure DeleteBODY(var pWorkflowProcedureLine: Record "Workflow Procedure Line")
    var
        //GL2024  lCommonDlgMgt: Codeunit 412;
        lFileName: Text[260];
    begin
        pWorkflowProcedureLine.CalcFields(CommentBLOB);
        Clear(pWorkflowProcedureLine.CommentBLOB);
        pWorkflowProcedureLine.Modify;
    end;
}

