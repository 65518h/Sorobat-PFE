Codeunit 8001543 "Workflow Form Filter 8004231"
{
    //GL2024  ID dans Nav 2009 : "8004231"
    // //+WKF+ ML 09/05/02 Workflow Form


    trigger OnRun()
    var
        lWorkflowDocument: Record "Workflow Document";
    begin
        lWorkflowDocument.FilterGroup(2);
        //GL2024 NAVIBAT      lWorkflowDocument.SetRange("Document Template", page::"Workflow Document Card1");
        lWorkflowDocument.FilterGroup(0);
        if lWorkflowDocument.FindFirst then;
        //GL2024 NAVIBAT    PAGE.Run(page::"Workflow Documents", lWorkflowDocument);
    end;
}

