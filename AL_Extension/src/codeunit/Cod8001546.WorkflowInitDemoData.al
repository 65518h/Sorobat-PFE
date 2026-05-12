Codeunit 8001546 "Workflow Init Demo Data"
{
    //GL2024  ID dans Nav 2009 : "8004299"
    // //+WKF+ CW 07/08/02 Workflow Initialization
    //         DL 12/02/03 Adaptation à la renumérotation des objets


    trigger OnRun()
    begin
        //#8212
        //IF NOT CONFIRM(tDataInitConfirm+'\'+tDataInitWarning,FALSE,tSuperDataRole) THEN
        if not Confirm(tDataInitConfirm, false) then
            exit;
        //#8212//

        InsertTypes;

        InsertRole(tRole1);
        InsertRole(tRole2);
        InsertRole(tRole3);
        InsertRole(tRole4);
        InsertRole(tRole5);
        InsertRole(tRole6);
        InsertRole(tRole7);

        //#8212
        /*
        InsertUser(tUser0);
        InsertUser(tUser1);
        InsertUser(tUser2);
        InsertMemberOf(tUser0,tSuperDataRole);
        InsertMemberOf(tUser1,tSuperDataRole);
        InsertMemberOf(tUser2,tSuperDataRole);
        InsertMemberOf(tUser0,tAllUsersRole);
        InsertMemberOf(tUser1,tAllUsersRole);
        InsertMemberOf(tUser2,tAllUsersRole);
        
        InsertGrant(tUser0,tRole1);
        InsertGrant(tUser0,tRole2);
        InsertGrant(tUser0,tRole3);
        InsertGrant(tUser0,tRole4);
        InsertGrant(tUser0,tRole5);
        InsertGrant(tUser0,tRole6);
        InsertGrant(tUser0,tRole7);
        InsertGrant(tUser1,tRole1);
        InsertGrant(tUser1,tRole2);
        InsertGrant(tUser2,tRole3);
        InsertGrant(tUser2,tRole4);
        */
        InsertGrant(UserId, tRole1);
        InsertGrant(UserId, tRole2);
        InsertGrant(UserId, tRole3);
        InsertGrant(UserId, tRole4);
        InsertGrant(UserId, tRole5);
        InsertGrant(UserId, tRole6);
        InsertGrant(UserId, tRole7);
        //#8212//

        InsertWorkflowHeader(30, tProc30a);
        InsertWorkflowLine(30, tProc30a, tOpe30a10, '', '', tRole1, false, 0);
        InsertWorkflowLine(30, tProc30a, tOpe30a20, '', '', tRole5, false, 0);
        InsertWorkflowLine(30, tProc30a, tOpe30a30, '', '', tRole4, false, -1);

        InsertWorkflowHeader(30, tProc30b);
        InsertWorkflowLine(30, tProc30b, tOpe30b10, '', '', '', false, +1);

        InsertWorkflowHeader(41, tProc41a);
        InsertWorkflowLine(41, tProc41a, tOpe41a10, '', '', tRole1, false, 0);
        InsertWorkflowLine(41, tProc41a, tOpe41a20, '', '', tRole5, false, 0);

        InsertWorkflowHeader(41, tProc41b);
        InsertWorkflowLine(41, tProc41b, tOpe41b10, '', '20|30', tRole2, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b20, '', '40', tRole3, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b30, '', '40', tRole5, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b40, '20|30', '', tRole3, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b50, '', '', tRole5, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b60, '', '', tRole4, false, 0);
        InsertWorkflowLine(41, tProc41b, tOpe41b70, '', '', tRole5, false, 0);

        InsertWorkflowHeader(42, tProc42);
        InsertWorkflowLine(42, tProc42, tOpe4210, '', '', tRole2, false, -1);

        InsertWorkflowHeader(50, tProc50);
        InsertWorkflowLine(50, tProc50, tOpe5010, '', '', tRole6, false, 0);
        InsertWorkflowLine(50, tProc50, tOpe5020, '', '', tRole7, true, -1);

        InsertWorkflowHeader(138, tProc138);
        InsertWorkflowLine(138, tProc138, tOpe13810, '', '', tRole6, false, -1);

        InsertWorkflowHeader(291, tProc291);
        InsertWorkflowLine(291, tProc291, tOpe29110, '', '', tRole6, false, 0);

        InsertTemplate(8004230, tTemplate1, tTemplate1Captions);
        InsertWorkflowHeader(8004230, tProc1);
        InsertWorkflowLine(8004230, tProc1, tOpe110, '', '', tRole4, false, 0);

        InsertTemplateCode(8004225, 12, 8004230, tTemplate1Status1);
        InsertTemplateCode(8004225, 12, 8004230, tTemplate1Status2);

        InsertTemplate(8004231, tTemplate2, tTemplate2Captions);
        InsertTemplateCode(8004225, 12, 8004231, tTemplate2Status1);
        InsertTemplateCode(8004225, 12, 8004231, tTemplate2Status2);
        InsertTemplateCode(8004225, 301, 8004231, tTemplate2Code11);
        InsertTemplateCode(8004225, 301, 8004231, tTemplate2Code12);

        InsertTemplate(8004232, tTemplate3, tTemplate3Captions);
        InsertTemplateCode(8004225, 301, 8004232, tTemplate3Code11);
        InsertTemplateCode(8004225, 301, 8004232, tTemplate3Code12);

        Message(tInitDone);

    end;

    var
        tSuperDataRole: label 'SUPER (DATA)';
        tAllUsersRole: label 'ALL';
        tDataInitConfirm: label 'Do you want do init demosntration data ?';
        tDataInitWarning: label 'WARNING : users will be inserted with %1 role';
        tInitDone: label 'Init done';
        tRole1: label 'LEDGER,General Ledger';
        tRole2: label 'CREDIT,Credit Management';
        tRole3: label 'DESIGN,Design';
        tRole4: label 'QUALITY,Quality';
        tRole5: label 'SALES,Sales Management';
        tRole6: label 'PURCHASES,Purchases';
        tRole7: label 'CEO,C.E.O.';
        tProc30a: label 'NEW,New Item';
        tOpe30a10: label '10,Fill-in Posting Groups';
        tOpe30a20: label '20,Define Prices and discounts';
        tOpe30a30: label '30,Release Item';
        tProc30b: label 'BLOCK,Block Item';
        tOpe30b10: label ',Block Item';
        tProc41a: label 'SIMPLE,Simple Quote';
        tOpe41a10: label '10,Check credit';
        tOpe41a20: label '20,Send Quote';
        tProc41b: label 'SPECIAL,Special Quote';
        tOpe41b10: label '10Check Credit';
        tOpe41b20: label '20,Check possible';
        tOpe41b30: label '30,Write specifications';
        tOpe41b40: label '40,Estimate';
        tOpe41b50: label '50,Finish Offer';
        tOpe41b60: label '60,Validate Offer';
        tOpe41b70: label '70,Remind Offer';
        tProc42: label 'CRED-LIMIT,Credit Limit Overflow';
        tOpe4210: label '10,Accept Overflow,Release order';
        tProc50: label 'SIGN,Release';
        tOpe5010: label '10,Accept order';
        tOpe5020: label '20,Sign Order,Release order';
        tProc138: label ',Release Payment';
        tOpe13810: label '10,Accept Release Payment,Release paymentt';
        tProc291: label 'ORDER,Carry Out requisition';
        tOpe29110: label '10,Order';
        tProc1: label ',Quality procedure';
        tOpe110: label '10,Quality Card Transfer';
        tTemplate1: label 'Quality Card,WKF-QUAL';
        tTemplate1Captions: label 'Level,,,,,,,,,,,,,';
        tTemplate2: label 'Service Request Card,WKF-SRVREQ';
        tTemplate2Captions: label ',,,,Level,,,,,,Lead Time,,,';
        tTemplate3: label 'Absence Autorisation,WKF-ABS';
        tTemplate3Captions: label '# Days,,Remark,,Vacancy Code,,,,Resp. person OK,HR OK,Beginning Date,Ending Date,,';
        tTemplate1Status1: label 'INPROGRESS,In Progress';
        tTemplate1Status2: label 'WAIT,Waiting';
        tTemplate2Status1: label 'QUOTE,Quote';
        tTemplate2Status2: label 'CONTRACT,In Contact';
        tTemplate2Code11: label 'D,Immediately';
        tTemplate2Code12: label '+1DNext Day';
        tTemplate3Code11: label 'VAC,Vacancy';
        tTemplate3Code12: label 'OTHER,Other';


    procedure InsertTypes()
    var
        lWorkflowNo: Codeunit "Workflow No.";
        lWorkflowType: Record "Workflow Type";
    begin
        lWorkflowNo.InsertTypes;
    end;


    procedure InsertRole(pValues: Text[250])
    var
        lRec: Record "Workflow Role";
    begin
        lRec."Role ID" := ExtractCode(pValues);
        lRec.Description := ExtractText(pValues);
        if lRec.Insert then;
    end;


    /*GL2024  procedure InsertUser(pValues: Text[250])
      var
          lRec: Record 2000000002;
          lMemberOf: Record 2000000003;
      begin
          lRec."User ID" := ExtractCode(pValues);
          lRec.Name := ExtractText(pValues);
          if lRec.Insert then;
      end;


      procedure InsertMemberOf(pUser: Text[30]; pRole: Text[30])
      var
          lRec: Record 2000000003;
      begin
          lRec."Role ID" := ExtractCode(pRole);
          lRec."User ID" := ExtractCode(pUser);
          lRec.Company := COMPANYNAME;
          if lRec.Insert then;
      end;*/


    procedure InsertGrant(pUser: Text[30]; pRole: Text[30])
    var
        lRec: Record "Workflow Role - User";
    begin
        lRec."Role ID" := ExtractCode(pRole);
        lRec."User ID" := ExtractCode(pUser);
        //#8212
        lRec.TestField("User ID");
        //#8212//
        if lRec.Insert then;
    end;


    procedure InsertWorkflowHeader(pType: Integer; pValues: Text[250])
    var
        lRec: Record "Workflow Procedure Header";
    begin
        lRec."Workflow Type" := pType;
        lRec.Code := ExtractCode(pValues);
        lRec.Description := ExtractText(pValues);
        if lRec.Insert then;
    end;


    procedure InsertWorkflowLine(pType: Integer; pCode: Text[250]; pOperation: Text[250]; pPrevious: Text[250]; pNext: Text[250]; pRole: Text[250]; pNotify: Boolean; pTriggerID: Integer)
    var
        lRec: Record "Workflow Procedure Line";
    begin
        lRec."Workflow Type" := pType;
        lRec."Workflow Code" := ExtractCode(pCode);
        lRec."Operation No." := ExtractCode(pOperation);
        lRec."Next Operation No." := ExtractText(pNext);
        lRec."Role ID" := ExtractCode(pRole);
        lRec.Description := ExtractText(pOperation);
        lRec.Notify := pNotify;
        lRec."Trigger ID" := pTriggerID;
        lRec."Confirmation Message" := ExtractText(pOperation);
        if lRec.Insert then;
    end;


    procedure InsertTemplate(pTemplate: Integer; pValues: Text[250]; pCaptions: Text[250])
    var
        lRec: Record "Workflow Document Template";
        //GL2024   lNoSeries: Record 308;
        //GL2024  lNoSeriesLine: Record 309;
        i: Integer;
    begin
        lRec."Document Template" := pTemplate;
        lRec.Description := ExtractText(pValues);
        lRec."No. Series" := ExtractCode(pValues);
        lRec.Integer1 := ExtractText(pCaptions);
        lRec.Integer2 := ExtractText(pCaptions);
        lRec.Text1 := ExtractText(pCaptions);
        lRec.Integer2 := ExtractText(pCaptions);
        lRec.Code1 := ExtractText(pCaptions);
        lRec.Code2 := ExtractText(pCaptions);
        lRec.Decimal1 := ExtractText(pCaptions);
        lRec.Decimal2 := ExtractText(pCaptions);
        lRec.Boolean1 := ExtractText(pCaptions);
        lRec.Boolean2 := ExtractText(pCaptions);
        lRec.Date1 := ExtractText(pCaptions);
        lRec.Date2 := ExtractText(pCaptions);
        lRec.Time1 := ExtractText(pCaptions);
        lRec.Time2 := ExtractText(pCaptions);
        if lRec.Insert then;

        /*GL2024  lNoSeries.Code := lRec."No. Series";
          lNoSeries.Description := lRec.Description + ' ' + Format(pTemplate);
          lNoSeries."Default Nos." := true;
          lNoSeries."Manual Nos." := true;
          if lNoSeries.Insert then;

          lNoSeriesLine."Series Code" := lRec."No. Series";
          lNoSeriesLine."Line No." := 10000;
          lNoSeriesLine."Starting No." := '1';
          if lNoSeriesLine.Insert then;*/
    end;


    procedure ExtractCode(var pText: Text[250]) Return: Code[20]
    var
        i: Integer;
    begin
        i := StrPos(pText, ',');
        if i = 0 then begin
            Return := pText;
            pText := '';
        end else begin
            Return := CopyStr(pText, 1, i - 1);
            pText := CopyStr(pText, i + 1);
        end;
    end;


    procedure ExtractText(var pText: Text[250]) Return: Text[30]
    var
        i: Integer;
    begin
        i := StrPos(pText, ',');
        if i = 0 then begin
            Return := pText;
            pText := '';
        end else begin
            Return := CopyStr(pText, 1, i - 1);
            pText := CopyStr(pText, i + 1);
        end;
    end;


    procedure InsertTemplateCode(pTable: Integer; pField: Integer; pTemplate: Integer; pValues: Text[250])
    var
        lRec: Record "Workflow Document Code";
    begin
        lRec."Table No" := pTable;
        lRec."Field No" := pField;
        lRec.Code := ExtractCode(pValues);
        lRec."Document Template" := pTemplate;
        lRec.Description := ExtractText(pValues);
        if lRec.Insert then;
    end;
}

