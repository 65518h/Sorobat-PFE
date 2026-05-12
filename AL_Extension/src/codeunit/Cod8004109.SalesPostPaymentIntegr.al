Codeunit 8004109 "Sales-Post Payment Integr."
{
    // +PMT+ AC 04/11/10 Codeunit de génération des paiements à la validation des factures et avoirs ventes
    //                   *SetAndPostMultiLine* Fonction de génération et validation des écritures comptable sur le compte client
    //                                          dans le cadre de payment multiple
    //                   *SetInvoiceMultiLine* (visibilité privé) Fonction de gestion de la retenu de garantie +
    //                                           retourne le nombre de fractionnment du paiement
    //                   *PostFractionGenJnlLine* (visibilité privé) Validation des paiements fractionnés ou non
    //                   *SetGenJnlLineFromSalesHeader* Mise à jour du journal comptable
    //                                                  + contrôle du paramétrage lié à la selection de la banque en fonction
    //                                                  du compte de contrepartie et du type de paiement selectionné


    trigger OnRun()
    begin
    end;


    procedure SetAndPostMultiLine(pSalesHeader: Record "Sales Header"; pCurrency: Record Currency; var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; var pGenJnlLineDocNo: Code[20]; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        lNbFractionation: Integer;
    begin
        lNbFractionation := SetInvoiceMultiLine(pSalesHeader, pCurrency, pGenJnlLine, pTempJnlLineDim, pGenJnlLineDocNo);
        PostFractionGenJnlLine(pSalesHeader."Payment Terms Code", pGenJnlLine, pTempJnlLineDim, lNbFractionation, pGenJnlPostLine);
    end;

    local procedure SetInvoiceMultiLine(pSalesHeader: Record "Sales Header"; pCurrency: Record Currency; var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; pGenJnlLineDocNo: Code[20]) return: Integer
    var
        lFractionation: Record Fractionation;
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lRetention: Integer;
        lLineNo: Integer;
        lPaymentTerms: Record "Payment Terms";
    begin
        if (pGenJnlLine."Document Type" = pGenJnlLine."document type"::Invoice) and
           lPaymentTerms.Get(pSalesHeader."Payment Terms Code") then begin
            lPaymentTerms.CalcFields("Number of Fractionation");
            //+BAT+
            SetFractSalesInvLine(pSalesHeader, pCurrency, pGenJnlLine, pGenJnlLineDocNo);
            //+BAT+//
        end else
            lPaymentTerms."Number of Fractionation" := 1;

        return := lPaymentTerms."Number of Fractionation";
    end;


    procedure SetFractSalesInvLine(pSalesHeader: Record "Sales Header"; pCurrency: Record Currency; var pGenJnlLine: Record "Gen. Journal Line"; pGenJnlLineDocNo: Code[20])
    var
        lFractionation: Record Fractionation;
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lRetention: Record Retention;
        lLineNo: Integer;
    begin
        //+BAT+
        lFractionation.SetRange("Payment Terms Code", pSalesHeader."Payment Terms Code");
        lFractionation.SetFilter("Retention Code", '<>%1', '');
        if lFractionation.FindSet then begin
            repeat
                lRetention.Get(lFractionation."Retention Code");
                // Append SalesInvoiceLine
                lLineNo += 10000;
                lSalesInvoiceLine."Document No." := pGenJnlLineDocNo;
                lSalesInvoiceLine."Line No." := lLineNo + 2000000000; // Placed at the end
                lSalesInvoiceLine."Sell-to Customer No." := pSalesHeader."Sell-to Customer No.";
                lSalesInvoiceLine.Description :=
                  StrSubstNo('%1 %2%',
                  lRetention.Description, Format(lFractionation."Fractionation %", 0, '<Precision,0:2><Standard Format,0>'));
                lSalesInvoiceLine."Prepayment Order No." := pSalesHeader."No.";
                lSalesInvoiceLine."Line Amount" :=
                  ROUND(-pGenJnlLine.Amount * lFractionation."Fractionation %" / 100,
                         pCurrency."Amount Rounding Precision");
                lSalesInvoiceLine.Insert;
            until lFractionation.Next = 0;
        end;
        //+BAT+//
    end;

    local procedure PostFractionGenJnlLine(pPaymentTermsCode: Code[20]; var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; pNbFractionation: Integer; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        lPaymentTerms: Record "Payment Terms";
        lFactionationlMngt: Codeunit "Fractionation Management";
    begin
        if pNbFractionation <= 1 then
            //GL2024 pGenJnlPostLine.RunWithCheck(pGenJnlLine, pTempJnlLineDim)
            //GL2024
            pGenJnlPostLine.RunWithCheck(pGenJnlLine)
        //GL2024
        else
            lFactionationlMngt.GenJnlLineFraction(pGenJnlLine, pTempJnlLineDim, pPaymentTermsCode, pGenJnlPostLine);
    end;


    procedure SetGenJnlLineFromSalesHeader(var pGenJnlLine: Record "Gen. Journal Line"; pSalesHeader: Record "Sales Header")
    var
        lPaymentMethod: Record "Payment Method";
        lPaymentMgt: Codeunit "Payment Management1";
        lBankAccount: Record "Bank Account";
    begin
        if (pGenJnlLine."Bal. Account Type" = pGenJnlLine."bal. account type"::"Bank Account") then begin
            pSalesHeader.TestField("On Hold", '');
            lPaymentMethod.Get(pSalesHeader."Payment Method Code");
            pGenJnlLine."Bill Type" := lPaymentMethod."Bill Type";
            if pGenJnlLine."Bill Type" <> 0 then begin
                lPaymentMethod.TestField("Bill Type", lPaymentMethod."bill type"::"Not Accepted");
                pGenJnlLine."Payment Bank Account" := lPaymentMgt.GetCustDefBankCode(pSalesHeader."Sell-to Customer No.");
                pGenJnlLine.TestField("Payment Bank Account");
                lBankAccount.Get(pSalesHeader."Bal. Account No.");
                if pGenJnlLine."Account Type" = pGenJnlLine."account type"::Customer then
                    lBankAccount.TestField("Bank Type", lBankAccount."bank type"::Receivable)
                else
                    if pGenJnlLine."Account Type" = pGenJnlLine."account type"::Vendor then
                        lBankAccount.TestField("Bank Type", lBankAccount."bank type"::Payable);
                pGenJnlLine."Due Date" := pSalesHeader."Due Date";
            end else
                if pSalesHeader."Due Date" > pGenJnlLine."Posting Date" then
                    pGenJnlLine."Posting Date" := pSalesHeader."Due Date";
        end;
    end;


    procedure SERV_SetInvoiceMultiLine(pServiceHeader: Record "Service Header"; pCurrency: Record Currency; var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; var pGenJnlLineDocNo: Code[20]; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line") return: Boolean
    var
        lFractionation: Record Fractionation;
        lSalesInvoiceLine: Record "Sales Invoice Line";
        lRetention: Integer;
        lLineNo: Integer;
        lPaymentTerms: Record "Payment Terms";
        lFractionationMgt: Codeunit "Fractionation Management";
    begin
        if (pGenJnlLine."Document Type" = pGenJnlLine."document type"::Invoice) and
           lPaymentTerms.Get(pServiceHeader."Payment Terms Code") then begin
            lPaymentTerms.CalcFields("Number of Fractionation");
        end else
            lPaymentTerms."Number of Fractionation" := 1;
        return := (lPaymentTerms."Number of Fractionation" > 1);
        if return then
            lFractionationMgt.GenJnlLineFraction(pGenJnlLine, pTempJnlLineDim, pServiceHeader."Payment Terms Code", pGenJnlPostLine);
    end;
}

