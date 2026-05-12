Codeunit 8001542 "Workflow Form Filter 8004230"
{
    //GL2024  ID dans Nav 2009 : "8004230"
    // //+WKF+ ML 09/05/02 Workflow Form


    trigger OnRun()
    var
        lWorkflowDocument: Record "Workflow Document";
    begin
        lWorkflowDocument.FilterGroup(2);
        //GL2024 NAVIBAT      lWorkflowDocument.SetRange("Document Template", page::"Workflow Document Card");
        lWorkflowDocument.FilterGroup(0);
        if lWorkflowDocument.Find('-') then;
        //GL2024 NAVIBAT    PAGE.Run(page::"Workflow Documents", lWorkflowDocument);
    end;
}

