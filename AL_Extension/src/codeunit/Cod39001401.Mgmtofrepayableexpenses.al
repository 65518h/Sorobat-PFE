Codeunit 39001401 "Mgmt. of repayable expenses"
{

    //GL2024  ID dans Nav 2009 : "39001401"
    trigger OnRun()
    begin
    end;
    //GL3900
    /*
        procedure EnregDoc(ExpensesRepayHeader: Record "Expenses to repay Header")
        var
            errMess: label 'Null Document amount.Impossible to validate this document.';
            Empl: Record Employee;
        begin
            ExpensesRepayHeader.CalcFields("Total amount");
            if (ExpensesRepayHeader."Total amount" > 0) then begin
                ExpensesRepayHeader.Status := 1;
                ExpensesRepayHeader."Document amount" := ExpensesRepayHeader."Total amount";
                ExpensesRepayHeader.Modify;
            end
            else
                Error(errMess);
        end;


        procedure DevaliderDoc(RecExpensesRepayHeader: Record "Expenses to repay Header")
        var
            errMess: label 'Null Document amount.Impossible to validate this document.';
        begin
            if not RecExpensesRepayHeader.Repaied then begin
                RecExpensesRepayHeader.Status := 0;
                RecExpensesRepayHeader."Document amount" := 0;
                RecExpensesRepayHeader.Modify;
            end
        end;
        */
    //GL3900
}

