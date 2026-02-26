Codeunit 8004143 "Planning Task MS-Project"
{
    // //+ONE+MS-PROJECT CW 10/10/07

    TableNo = "Planning Line";

    trigger OnRun()
    var
        //GL2024 NAVIBAT   lProjectConnector: xmlport 8004131;
        lRec: Record "Job Task";
        lPlanningSetup: Record "Planning Setup";
        //GL2024 Automation non compatible    MsProjectApplication: Automation;
        lImportFileName: Text[250];
        lExportFileName: Text[250];
    begin
        /* //GL2024 Automation non compatible lExportFileName := ENVIRON('TEMP') + '\NaviOneProject.txt';
         if Exists(lExportFileName) then
             Erase(lExportFileName);*/
        /* //GL2024 Automation non compatible  lImportFileName := ENVIRON('TEMP') + '\ProjectNaviOne.txt';
          if Exists(lImportFileName) then
              Erase(lImportFileName);*/

        lPlanningSetup.Get;
        //lSalesHeader.GET("Document Type","Document No.");
        lRec.Copy(Rec);
        //lRec.SETRANGE("Date Filter");
        /*    //GL2024 NAVIBAT  lProjectConnector.SetTableview(lRec);
           lProjectConnector.Filename(lExportFileName);
           lProjectConnector.Import(false);
           lProjectConnector.RunModal;*/

        /*   //GL2024 Automation non compatible Create(MsProjectApplication);
           MsProjectApplication.FileOpen(
             lProjectConnector.Filename, false, 0, true, '', '', false, '', '', 'MSProject.txt.9', lPlanningSetup."MS-Project Mapping");
           MsProjectApplication.AppRestore;*/
    end;

    var
        tNoWorkingDay: label 'No workking day in this period.';


    procedure Import(var pJobTask: Record "Job Task")
    var
        lImportFileName: Text[250];
    //GL2024 NAVIBAT   lProjectConnector: xmlport 8004131;
    begin
        //GL2024 Automation non compatible   lImportFileName := ENVIRON('TEMP') + '\ProjectNaviOne.txt';
        /*   //GL2024 NAVIBAT if Exists(lImportFileName) then begin
             lProjectConnector.Filename(lImportFileName);
             lProjectConnector.Import(true);
             lProjectConnector.RunModal;
             Erase(lImportFileName);
         end;*/
    end;
}

