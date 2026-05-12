Codeunit 8001522 "BAR : Post Reconciliation"
{
    //GL2024  ID dans Nav 2009 : "8001601"
    // //+RAP+RAPPRO GESWAY 26/06/02 Validation du rapprochement bancaire automatique

    Permissions = TableData "Bank Account Ledger Entry" = rm,
                  TableData "Check Ledger Entry" = rm,
                  TableData "Bank Account Statement" = ri,
                  TableData "Bank Account Statement Line" = ri;
    TableNo = "Bank Acc. Reconciliation";

    trigger OnRun()
    var
        lStatementAmount: Decimal;
        lAppliedAmount: Decimal;
    begin
        Fenetre.Open(Text001);
        Fenetre.Update(1, rec."Bank Account No.");
        Fenetre.Update(2, rec."Statement No.");

        rec.TestField("Statement Date");

        LigRapprBqe2.Reset;
        //LigRapprBqe2.SETCURRENTKEY("Bank Account No.","Statement No.",Difference);
        LigRapprBqe2.SetRange("Bank Account No.", rec."Bank Account No.");
        LigRapprBqe2.SetRange("Statement No.", rec."Statement No.");
        LigRapprBqe2.SetRange(Difference, 0);
        //LigRapprBqe2.CALCSUMS("Statement Amount","Applied Amount");
        if LigRapprBqe2.FindSet then begin
            repeat
                lStatementAmount += LigRapprBqe2."Statement Amount";
                lAppliedAmount += LigRapprBqe2."Applied Amount";
            until LigRapprBqe2.Next = 0;
            LigRapprBqe2."Statement Amount" := lStatementAmount;
            LigRapprBqe2."Applied Amount" := lAppliedAmount;
        end;

        if LigRapprBqe2."Applied Amount" <> LigRapprBqe2."Statement Amount" then
            Error(Text002);

        // Parcourir les lignes
        LigRapprBqe.Reset;
        //LigRapprBqe.SETCURRENTKEY("Bank Account No.","Statement No.",Difference);
        LigRapprBqe.SetRange("Bank Account No.", rec."Bank Account No.");
        LigRapprBqe.SetRange("Statement No.", rec."Statement No.");
        LigRapprBqe.SetRange(Difference, 0);
        TotalMontant := 0;
        TotalMntLettre := 0;
        TotalDiff := 0;
        Lignes := 0;
        if LigRapprBqe.Find('-') then begin
            EcrCpteBqe.LockTable;
            EcrCheque.LockTable;
            repeat
                Lignes := Lignes + 1;
                Fenetre.Update(3, Lignes);
                MntLettre := 0;
                // Ajuster les écritures
                // Montant test et montant arrêté
                /*  //GL2024  case LigRapprBqe.Type of
                       LigRapprBqe.Type::"Bank Account Ledger Entry":
                           begin
                               EcrCpteBqe.Reset;
                               EcrCpteBqe.SetCurrentkey("Bank Account No.", Open, "Posting Date", "Due Date", "Document No."
                                                        , "Remaining Amount", "Reason Code", "Statement Status");
                               EcrCpteBqe.SetRange("Bank Account No.", LigRapprBqe."Bank Account No.");
                               EcrCpteBqe.SetRange(Open, true);
                               EcrCpteBqe.SetRange(
                                 "Statement Status", EcrCpteBqe."statement status"::"Bank Acc. Entry Applied");
                               EcrCpteBqe.SetRange("Statement No.", LigRapprBqe."Statement No.");
                               EcrCpteBqe.SetRange("Statement Line No.", LigRapprBqe."Statement Line No.");
                               if EcrCpteBqe.Find('-') then
                                   repeat
                                       MntLettre := MntLettre + EcrCpteBqe."Remaining Amount";
                                       EcrCpteBqe."Remaining Amount" := 0;
                                       EcrCpteBqe.Open := false;
                                       EcrCpteBqe."Statement Status" := EcrCpteBqe."statement status"::Closed;
                                       EcrCpteBqe.Modify;

                                       EcrCheque.Reset;
                                       EcrCheque.SetCurrentkey("Bank Account Ledger Entry No.");
                                       EcrCheque.SetRange(
                                         "Bank Account Ledger Entry No.", EcrCpteBqe."Entry No.");
                                       EcrCheque.SetRange(EcrCheque.Open, true);
                                       if EcrCheque.Find('-') then
                                           repeat
                                               EcrCheque.TestField(Open, true);
                                               EcrCheque.TestField(
                                                 "Statement Status",
                                                 EcrCheque."statement status"::"Bank Acc. Entry Applied");
                                               EcrCheque.TestField("Statement No.", '');
                                               EcrCheque.TestField("Statement Line No.", 0);
                                               EcrCheque.Open := false;
                                               EcrCheque."Statement Status" := EcrCheque."statement status"::Closed;
                                               EcrCheque.Modify;
                                           until EcrCheque.Next = 0;
                                   until EcrCpteBqe.Next = 0;
                           end;
                       LigRapprBqe.Type::"Check Ledger Entry":
                           begin
                               EcrCheque.Reset;
                               EcrCheque.SetCurrentkey("Bank Account No.", Open);
                               EcrCheque.SetRange("Bank Account No.", LigRapprBqe."Bank Account No.");
                               EcrCheque.SetRange(Open, true);
                               EcrCheque.SetRange(
                                 "Statement Status", EcrCheque."statement status"::"Check Entry Applied");
                               EcrCheque.SetRange("Statement No.", LigRapprBqe."Statement No.");
                               EcrCheque.SetRange("Statement Line No.", LigRapprBqe."Statement Line No.");
                               if EcrCheque.Find('-') then
                                   repeat
                                       MntLettre := MntLettre - EcrCheque.Amount;
                                       EcrCheque.Open := false;
                                       EcrCheque."Statement Status" := EcrCheque."statement status"::Closed;
                                       EcrCheque.Modify;

                                       EcrCpteBqe.Get(EcrCheque."Bank Account Ledger Entry No.");
                                       EcrCpteBqe.TestField(Open, true);
                                       EcrCpteBqe.TestField(
                                       "Statement Status", EcrCpteBqe."statement status"::"Check Entry Applied");
                                       EcrCpteBqe.TestField("Statement No.", '');
                                       EcrCpteBqe.TestField("Statement Line No.", 0);
                                       EcrCpteBqe."Remaining Amount" :=
                                         EcrCpteBqe."Remaining Amount" + EcrCheque.Amount;
                                       if EcrCpteBqe."Remaining Amount" = 0 then begin
                                           EcrCpteBqe.Open := false;
                                           EcrCpteBqe."Statement Status" := EcrCpteBqe."statement status"::Closed;
                                       end else begin
                                           EcrCheque2.Reset;
                                           EcrCheque2.SetCurrentkey("Bank Account Ledger Entry No.", "Entry Status");
                                           EcrCheque2.SetRange("Bank Account Ledger Entry No.", EcrCpteBqe."Entry No.");
                                           EcrCheque2.SetRange(Open, true);
                                           EcrCheque2.SetRange("Check Type", EcrCheque2."check type"::"Partial Check");
                                           EcrCheque2.SetRange(
                                             "Statement Status", EcrCheque2."statement status"::"Check Entry Applied");
                                           if not EcrCheque2.Find('-') then
                                               EcrCpteBqe."Statement Status" := EcrCpteBqe."statement status"::Open;
                                       end;
                                       EcrCpteBqe.Modify;
                                   until EcrCheque.Next = 0;
                           end;
                       LigRapprBqe.Type::Difference:
                           TotalDiff := TotalDiff + LigRapprBqe."Statement Amount";
                   end;*/
                LigRapprBqe.TestField("Applied Amount", MntLettre);
                TotalMontant := TotalMontant + LigRapprBqe."Statement Amount";
                TotalMntLettre := TotalMntLettre + MntLettre;
            until LigRapprBqe.Next = 0;
        end else
            Error('Rien à valider');

        Fenetre.Close;
        Fenetre.Open('Mise à jour de la base en cours ...');

        // Montant test
        if TotalMontant <> TotalMntLettre + TotalDiff then
            Error(
              'Le lettrage est incorrect. Le montant total lettré est %1 ; il devrait être %2.',
              TotalMntLettre + TotalDiff, TotalMontant);

        if LigRapprBqe2.Difference <> TotalDiff then
            Error('La différence totale est %1. Elle doit être %2.', LigRapprBqe2.Difference, TotalDiff);

        // Extraire banque
        CpteBqe.LockTable;
        CpteBqe.Get(rec."Bank Account No.");
        CpteBqe.TestField(CpteBqe.Blocked, false);
        CpteBqe."Last Statement No." := rec."Statement No.";
        CpteBqe."Balance Last Statement" := 0;
        CpteBqe.Modify;

        // Copy and delete statement
        LigReleveBqe.SetRange("Statement No.", rec."Statement No.");
        LigReleveBqe.SetRange("Bank Account No.", rec."Bank Account No.");
        LigReleveBqe.LockTable;
        if LigReleveBqe.Find('+') then
            NumSuiv := LigReleveBqe."Statement Line No.";
        NumSuiv := NumSuiv + 1;
        LigRapprBqe.Reset;
        //LigRapprBqe.SETCURRENTKEY("Bank Account No.","Statement No.",Difference);
        LigRapprBqe.SetRange("Bank Account No.", rec."Bank Account No.");
        LigRapprBqe.SetRange("Statement No.", rec."Statement No.");
        LigRapprBqe.SetRange(Difference, 0);
        if LigRapprBqe.Find('-') then
            repeat
                LigReleveBqe.TransferFields(LigRapprBqe);
                LigReleveBqe."Statement Line No." := NumSuiv;
                LigReleveBqe.Insert;
                NumSuiv := NumSuiv + 1;

                ImportBanc.SetCurrentkey(Company, "Bank Account No.", "Statement No. (Treatement)", "Statement Line No. (Treat.)");
                ImportBanc.SetRange(Company, COMPANYNAME);
                ImportBanc.SetRange("Statement No. (Treatement)", LigRapprBqe."Statement No.");
                ImportBanc.SetRange("Bank Account No.", LigRapprBqe."Bank Account No.");
                ImportBanc.SetRange("Statement Line No. (Treat.)", LigRapprBqe."Statement Line No.");
                ImportBanc.ModifyAll("Statement Line No. (Treat.)", LigReleveBqe."Statement Line No.");

                EcrCpteBqe.Reset;
                EcrCpteBqe.SetCurrentkey("Bank Account No.", "Statement No.", "Statement Line No.", "Posting Date");
                EcrCpteBqe.SetRange("Bank Account No.", LigRapprBqe."Bank Account No.");
                EcrCpteBqe.SetRange("Statement No.", LigRapprBqe."Statement No.");
                EcrCpteBqe.SetRange("Statement Line No.", LigRapprBqe."Statement Line No.");
                EcrCpteBqe.ModifyAll("Statement Line No.", LigReleveBqe."Statement Line No.");

            until LigRapprBqe.Next = 0;
        LigRapprBqe.DeleteAll;

        ReleveBqe.SetRange("Bank Account No.", rec."Bank Account No.");
        ReleveBqe.SetRange("Statement No.", rec."Statement No.");
        if not ReleveBqe.Find('-') then begin
            ReleveBqe.TransferFields(Rec);
            ReleveBqe.Insert;
        end;

        LigRapprBqe.Reset;
        //LigRapprBqe.SETCURRENTKEY("Bank Account No.","Statement No.",Difference);
        LigRapprBqe.SetRange("Bank Account No.", rec."Bank Account No.");
        LigRapprBqe.SetRange("Statement No.", rec."Statement No.");
        if not LigRapprBqe.Find('-') then
            rec.Delete;
    end;

    var
        LigRapprBqe: Record "Bank Acc. Reconciliation Line";
        LigRapprBqe2: Record "Bank Acc. Reconciliation Line";
        CpteBqe: Record "Bank Account";
        EcrCpteBqe: Record "Bank Account Ledger Entry";
        EcrCheque: Record "Check Ledger Entry";
        EcrCheque2: Record "Check Ledger Entry";
        ReleveBqe: Record "Bank Account Statement";
        LigReleveBqe: Record "Bank Account Statement Line";
        ImportBanc: Record "BAR : Bank Entry";
        MntLettre: Decimal;
        TotalMontant: Decimal;
        TotalMntLettre: Decimal;
        TotalDiff: Decimal;
        Lignes: Integer;
        NumSuiv: Integer;
        Fenetre: Dialog;
        Text001: label 'Bank Account          #1##################\Statement No.         #2##################\Validate lines        #3##################';
        Text002: label 'There is out of balance\\between reconciliated and statements amounts.';
}

