Codeunit 8001528 "BAR Management"
{
    //GL2024  ID dans Nav 2009 : "8001607"
    // #9235 SD 20/12/11
    // //+RAP+ AC 10/12/10
    //         *SetValueDate2CLE* Mise à jour de la date de valeur sur une écriture client
    //         *SetValueDate2VLE* Mise à jour de la date de valeur sur une écriture fournisseur
    //         *SetDueDate2GJL* Mise à jour de la date de valeur et de la date d'échéance


    trigger OnRun()
    begin
    end;


    procedure SetValueDate2CLE(var pRec: Record "Cust. Ledger Entry")
    begin
        if pRec."Due Date" <> 0D then
            pRec."Value Date" := pRec."Due Date"
        else
            pRec."Value Date" := pRec."Posting Date";
    end;


    procedure SetValueDate2VLE(var pRec: Record "Vendor Ledger Entry")
    begin
        if pRec."Due Date" <> 0D then
            pRec."Value Date" := pRec."Due Date"
        else
            pRec."Value Date" := pRec."Posting Date";
    end;


    procedure SetDueDate2GJL(var pRec: Record "Gen. Journal Line"; pDate: Date; pTestNullDueDate: Boolean)
    begin
        if not pTestNullDueDate or (pRec."Due Date" <> 0D) then begin
            pRec."Due Date" := pDate;
            pRec."Value Date" := pDate;
        end;
    end;


    procedure DeleteBankAccReconciliation(var pRec: Record "Bank Acc. Reconciliation Line"; pCompanyName: Text[255])
    var
        lBARBankEntry: Record "BAR : Bank Entry";
        lBARBankAccount: Record "BAR : Bank Account";
        lBARBankEntry2: Record "BAR : Bank Entry";
    begin
        lBARBankAccount.SetRange(Company, pCompanyName);
        lBARBankAccount.SetRange("Bank Account No.", pRec."Bank Account No.");
        //#9235
        //IF lBARBankAccount.FINDFIRST AND NOT lBARBankAccount."Excluded From Import" THEN BEGIN
        if lBARBankAccount.FindFirst then begin
            //#9235//
            lBARBankEntry.SetCurrentkey(Company, "Bank Account No.", "Statement No. (Treatement)", "Statement Line No. (Treat.)");
            lBARBankEntry.SetRange(Company, pCompanyName);
            lBARBankEntry.SetRange("Statement No. (Treatement)", pRec."Statement No.");
            lBARBankEntry.SetRange("Statement Line No. (Treat.)", pRec."Statement Line No.");
            lBARBankEntry.SetRange("Bank Account No.", pRec."Bank Account No.");
            if not lBARBankEntry.IsEmpty then begin
                lBARBankEntry.FindSet(true, true);
                repeat
                    lBARBankEntry2.Copy(lBARBankEntry);
                    lBARBankEntry2."Statement No. (Treatement)" := '';
                    lBARBankEntry2."Statement Line No. (Treat.)" := 0;
                    lBARBankEntry2.Modify;
                until lBARBankEntry.Next = 0;
            end;
        end;
    end;
}

