Codeunit 8001551 "XML PLanniOne Import Mgt"
{
    //GL2024  ID dans Nav 2009 : "8035004"
    trigger OnRun()
    begin
    end;

    var
    //GL2024  wXmlDoc: Automation;
    /*//GL2024
        local procedure lInitialize(var pXmlDoc: Automation)
        var
         //GL2024   lXmlNode: Automation;
            lPlanningSetup: Record 8004133;
        begin
            if ISCLEAR(pXmlDoc) then begin
                Create(pXmlDoc);
                pXmlDoc.async := false;
                pXmlDoc.validateOnParse := true;
                pXmlDoc.setProperty('SelectionLanguage', 'XPath');
            end;
            lPlanningSetup.Get;
            pXmlDoc.load(lPlanningSetup.PlanningProjectImport);
        end;*/
}

