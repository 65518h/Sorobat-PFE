Codeunit 8001525 "BAR : Apply"
{
    //GL2024  ID dans Nav 2009 : "8001604"
    // //+RAP+RAPPRO GESWAY 26/06/02 Issu du codeunit 374
    //                          Changement de formulaire sur LettrerEcrCpteBque
    //                          Changement de la clé de tri sur EcrCpteBqe
    //                          Ajout filtre / date relevé  sur EcrCpteBqe."Date comptabilisation"

    TableNo = "Bank Acc. Reconciliation Line";

    trigger OnRun()
    begin
    end;

    var
        LigRapprBqe2: Record "Bank Acc. Reconciliation Line";
        EcrCpteBqe: Record "Bank Account Ledger Entry";
        //GL2024 NAVIBAT    LettrerEcrCpteBqe: Page 8001612;
        EcrCheque: Record "Check Ledger Entry";
        LettrerEcrCheque: Page "Apply Check Ledger Entries";
        OK: Boolean;

    //GL2024
    procedure LettrerEcr(var LigRapprBqe: Record "Bank Acc. Reconciliation Line"; DateReleve: Date)
    begin
        LigRapprBqe2 := LigRapprBqe;
        LigRapprBqe2.TestField("Ready for Application", true);
        with LigRapprBqe2 do begin
            /*  //GL2024 case Type of
                  Type::"Bank Account Ledger Entry":
                      begin
                          EcrCpteBqe.Reset;
                          EcrCpteBqe.SetCurrentkey("Bank Account No.", Open, "Posting Date", "Due Date", "Document No.",
                                                   "Remaining Amount", "Reason Code", "Statement Status");
                          EcrCpteBqe.SetRange("Bank Account No.", "Bank Account No.");
                          EcrCpteBqe.SetRange(Open, true);
                          EcrCpteBqe.SetFilter(
                            "Statement Status", '%1|%2', EcrCpteBqe."statement status"::Open,
                            EcrCpteBqe."statement status"::"Bank Acc. Entry Applied");
                          EcrCpteBqe.SetFilter("Statement No.", '''''|%1', "Statement No.");
                          EcrCpteBqe.SetFilter("Statement Line No.", '0|%1', "Statement Line No.");
                          EcrCpteBqe.SetRange("Posting Date", 0D, DateReleve);
                              /  LettrerEcrCpteBqe.DefLigReleve(LigRapprBqe);
                          LettrerEcrCpteBqe.SetRecord(EcrCpteBqe);
                          LettrerEcrCpteBqe.SetTableview(EcrCpteBqe);
                          LettrerEcrCpteBqe.LookupMode(true);
                          OK := LettrerEcrCpteBqe.RunModal = Action::LookupOK;
                          Clear(LettrerEcrCpteBqe);
                      end;
                  Type::"Check Ledger Entry":
                      begin
                          EcrCheque.Reset;
                          EcrCheque.SetCurrentkey("Bank Account No.", Open);
                          EcrCheque.SetRange("Bank Account No.", "Bank Account No.");
                          EcrCheque.SetRange(Open, true);
                          EcrCheque.SetFilter(
                            "Entry Status", '%1|%2', EcrCheque."entry status"::Posted,
                            EcrCheque."entry status"::"Financially Voided");
                          EcrCheque.SetFilter(
                            "Statement Status", '%1|%2', EcrCheque."statement status"::Open,
                            EcrCheque."statement status"::"Check Entry Applied");
                          EcrCheque.SetFilter("Statement No.", '''''|%1', "Statement No.");
                          EcrCheque.SetFilter("Statement Line No.", '0|%1', "Statement Line No.");
                          LettrerEcrCheque.SetStmtLine(LigRapprBqe);
                          LettrerEcrCheque.SetRecord(EcrCheque);
                          LettrerEcrCheque.SetTableview(EcrCheque);
                          LettrerEcrCheque.LookupMode(true);
                          OK := LettrerEcrCheque.RunModal = Action::LookupOK;
                          Clear(LettrerEcrCheque);
                      end;
              end;*/
        end;
    end;
}

