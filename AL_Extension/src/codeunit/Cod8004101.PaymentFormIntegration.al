Codeunit 8004101 "Payment Form Integration"
{
    // +PMT+ AC 19/11/10
    //              *CUSTwInitDueDateFilter* intiialisation du filtre date d'échéance en fonction de la date de travail


    trigger OnRun()
    begin
    end;

    local procedure lCUSTwInitDueDateFilter(var pRec: Record Customer)
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if GLSetup.Find('-') then
            pRec.SetFilter("Due Date Filter",
              StrSubstNo('%1..', CalcDate(GLSetup."Bank Waiting Period", WorkDate)));
    end;


    procedure CUSTUpdTotalAmountLCY(var pRec: Record Customer; pTotalAmountLCY: Decimal)
    begin
        lCUSTwInitDueDateFilter(pRec);
        pRec.CalcFields("Payments not Due (LCY)");
        pTotalAmountLCY := pTotalAmountLCY + pRec."Payments not Due (LCY)";
    end;
}

