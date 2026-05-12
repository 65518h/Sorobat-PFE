Codeunit 8004054 "Variable Global"
{
    // //VARIABLES_GLOBAL GESWAY 05/03/04 Passage de varialbes global

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        LastAttNo: Integer;


    procedure GiveAttNo(var pNo: Integer)
    begin
        LastAttNo := pNo;
    end;


    procedure GetAttNo(var pNo: Integer)
    begin
        pNo := LastAttNo;
    end;
}

