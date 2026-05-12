Codeunit 8004199 "NaviOne Demo Initialize"
{
    // //PROJET GESWAY 18/10/02 Initialisation : Stade d'avancement


    trigger OnRun()
    var
        lSalesHeader: Record "Sales Header";
    begin
        lSalesHeader."Document Type" := lSalesHeader."document type"::Quote;
        InitProgressDegree('1-QUALIF', Text8003907, lSalesHeader);
        InitProgressDegree('2-ETUDE', Text8003900, lSalesHeader);
        InitProgressDegree('3-DEVIS', Text8003901, lSalesHeader);
        InitProgressDegree('4-ACCORD', Text8003902, lSalesHeader);

        lSalesHeader."Document Type" := lSalesHeader."document type"::Order;
        InitProgressDegree('5-CDE', Text8003903, lSalesHeader);
        InitProgressDegree('6-FIN', Text8003904, lSalesHeader);
    end;

    var
        Text8003900: label 'In Study';
        Text8003901: label 'Quote sent';
        Text8003902: label 'Verbal Agreement';
        Text8003903: label 'In Progress';
        Text8003904: label 'Completed';
        Text8003905: label 'Lost';
        Text8003906: label 'Given up';
        Text8003907: label 'In Qualification';
        Text8003908: label '1-QUALIFY';
        Text8003909: label '2-STUDY';
        Text8003910: label '3-QUOTE';
        Text8003911: label '4-OK';
        Text8003912: label '5-ORDER';
        Text8003913: label '6-END';
        Text8003914: label '7-LOST';
        Text8003915: label '8-GIVENUP';


    procedure InitProgressDegree("Code": Code[10]; Description: Text[30]; SalesHeader: Record "Sales Header")
    var
        lJobProgressDegree: Record "Document Progress Degree";
    begin
        if not lJobProgressDegree.Get(Code, SalesHeader."Document Type") then begin
            lJobProgressDegree.Code := Code;
            lJobProgressDegree.Description := Description;
            lJobProgressDegree."Document Type" := SalesHeader."Document Type";
            lJobProgressDegree.Insert;
        end;
    end;
}

