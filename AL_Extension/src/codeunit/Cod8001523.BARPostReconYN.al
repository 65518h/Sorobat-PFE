Codeunit 8001523 "BAR : Post Recon. (Y/N)"
{
    //GL2024  ID dans Nav 2009 : "8001602"
    // //+RAP+RAPPRO GESWAY 26/06/02 Confirmation de la validation du rapprochement bancaire automatique

    TableNo = "Bank Acc. Reconciliation";

    trigger OnRun()
    begin
        RapprBqe.Copy(Rec);

        if not Confirm(Text10000, false) then
            exit;

        RapprBqeCompta.Run(RapprBqe);
        Rec := RapprBqe;
    end;

    var
        RapprBqe: Record "Bank Acc. Reconciliation";
        RapprBqeCompta: Codeunit "BAR : Post Reconciliation";
        Text10000: label 'Do you confirm reconciliation ?';
}

