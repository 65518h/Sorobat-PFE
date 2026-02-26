Codeunit 8001524 "BAR : Post+Print"
{
    //GL2024  ID dans Nav 2009 : "8001603"
    // //+RAP+RAPPRO GESWAY 26/06/02 Confirmation de la validation et impression du rapprochement bancaire automatique

    TableNo = "Bank Acc. Reconciliation";

    trigger OnRun()
    begin
        RapprBqe.Copy(Rec);

        if not Confirm(Text10000, false) then
            exit;

        RapprBqeCompta.Run(RapprBqe);
        Rec := RapprBqe;
        Commit;

        if ReleveBqe.Get(rec."Bank Account No.", rec."Statement No.") then
            DocImpr.PrintBankAccStmt(ReleveBqe);
    end;

    var
        RapprBqe: Record "Bank Acc. Reconciliation";
        ReleveBqe: Record "Bank Account Statement";
        RapprBqeCompta: Codeunit "BAR : Post Reconciliation";
        DocImpr: Codeunit "Document-Print";
        Text10000: label 'Do you want to post and print reconciliation ?';
}

