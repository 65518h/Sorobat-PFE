Codeunit 8004110 "Purch.-Post Payment Integr."
{
    // #8487 AC 04/11/10
    // +PMT+ AC 04/11/10 Codeunit de génération des paiements à la validation des factures et avoirs achats
    //                   *PostFractionGenJnlLine* Validation des paiements fractionnés ou non
    //                   *SetGenJnlLineFromSalesHeader* Mise à jour du journal comptable (code motif et due date)
    //                                                  + contrôle du paramétrage lié à la selection de la banque en fonction
    //                                                  du compte de contrepartie et du type de paiement selectionné


    trigger OnRun()
    begin
    end;


    procedure PostFractionGenJnlLine(var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; pPaymentTermsCode: Code[20]; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        lPaymentTerms: Record "Payment Terms";
        lFactionationMgt: Codeunit "Fractionation Management";
    begin
        if (pGenJnlLine."Document Type" = pGenJnlLine."document type"::Invoice) and
           lPaymentTerms.Get(pPaymentTermsCode) then
            lPaymentTerms.CalcFields("Number of Fractionation")
        else
            lPaymentTerms."Number of Fractionation" := 1;
        if lPaymentTerms."Number of Fractionation" <= 1 then
            //GL2024 pGenJnlPostLine.RunWithCheck(pGenJnlLine, pTempJnlLineDim)
            //GL2024
            pGenJnlPostLine.RunWithCheck(pGenJnlLine)
        //GL2024
        else
            lFactionationMgt.GenJnlLineFraction(pGenJnlLine, pTempJnlLineDim, pPaymentTermsCode, pGenJnlPostLine);
    end;


    procedure SetGenJnlLine(var pGenJnlLine: Record "Gen. Journal Line"; pPurchHeader: Record "Purchase Header")
    var
        lPaymentTerms: Record "Payment Terms";
        lBankPaymentType: Record "Bank Payment Type";
        lPaymentMethod: Record "Payment Method";
        lBankAccount: Record "Bank Account";
    begin
        if (pGenJnlLine."Bal. Account Type" = pGenJnlLine."bal. account type"::"Bank Account") then begin
            pPurchHeader.TestField("On Hold", '');
            lPaymentMethod.Get(pPurchHeader."Payment Method Code");
            pGenJnlLine."Bill Type" := lPaymentMethod."Bill Type";
            pGenJnlLine."Reason Code" := lPaymentMethod."Reason Code";
            if (lPaymentMethod."Bal. Account No." <> '') and
               (lPaymentMethod."Bal. Account Type" = lPaymentMethod."bal. account type"::"Bank Account")
            then begin
                lBankPaymentType.SetRange("Bank Account No.", lPaymentMethod."Bal. Account No.");
                lBankPaymentType.SetRange("Payment Type", lPaymentMethod."Payment Type");
                if lBankPaymentType.FindFirst then
                    pGenJnlLine."Reason Code" := lBankPaymentType."Reason Code";
            end;

            if pGenJnlLine."Bill Type" <> 0 then begin
                lPaymentMethod.TestField("Bill Type", lPaymentMethod."bill type"::"Not Accepted");
                lBankAccount.Get(pPurchHeader."Bal. Account No.");
                if pGenJnlLine."Account Type" = pGenJnlLine."account type"::Customer then
                    lBankAccount.TestField("Bank Type", lBankAccount."bank type"::Receivable)
                else
                    if pGenJnlLine."Account Type" = pGenJnlLine."account type"::Vendor then
                        lBankAccount.TestField("Bank Type", lBankAccount."bank type"::Payable);
                pGenJnlLine."Due Date" := pPurchHeader."Due Date";
            end else
                if pPurchHeader."Due Date" > pGenJnlLine."Posting Date" then
                    pGenJnlLine."Posting Date" := pPurchHeader."Due Date";
        end;
    end;
}

