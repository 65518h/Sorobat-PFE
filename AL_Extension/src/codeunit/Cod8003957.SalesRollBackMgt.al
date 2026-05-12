Codeunit 8003957 "Sales RollBack Mgt"
{
    TableNo = "Sales Header";

    trigger OnRun()
    var
        lRollBack: Record "RollBack Log";
    begin
        lRollBack.CopyIntegrityVerify(Rec);
    end;
}

