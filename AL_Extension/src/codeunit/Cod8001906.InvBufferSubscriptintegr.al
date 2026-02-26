Codeunit 8001906 "Inv. Buffer Subscript integr"
{
    // //+ABO+ GESWAY 30/06/08 *SetGenJnlLineSubscripDate* : Initialisation des dates d'abonnement du journal comptable
    //                         *SetBreakBufferSubscription* : Gestion des ruptures pour la comptabilisation
    //                                                        (initalisation de la table invoice Buffer).
    //                         *SetInvBufferSubscriptionDate* : Initialisation des dates d'abonnement du Buffer de facturation


    trigger OnRun()
    begin
    end;


    procedure GetPurchTotalAmountToInvoice(var pPurchaseHeader: Record "Purchase Header"; var pPurchaseLine: Record "Purchase Line"; pInvoice: Boolean) Return: Decimal
    var
        lLineAmountToInvoice: Decimal;
    begin
        if pInvoice then begin
            pPurchaseLine.FindSet(false, false);
            Return := 0;
            repeat
                lLineAmountToInvoice := pPurchaseLine."Qty. to Invoice" * pPurchaseLine."Unit Cost";
                if pPurchaseLine."Line Discount %" <> 0 then
                    lLineAmountToInvoice := lLineAmountToInvoice * (100 - pPurchaseLine."Line Discount %") / 100;
                Return += lLineAmountToInvoice;
            until (pPurchaseLine.Next = 0);
            if Return < 0 then
                pPurchaseHeader."Vendor Cr. Memo No." := pPurchaseHeader."Vendor Invoice No.";
        end;
    end;


    procedure SetPurchHeaderbyCreditMemo(var pPurchHeader: Record "Purchase Header"; pTotalAmountToInvoice: Decimal)
    begin
        if pTotalAmountToInvoice < 0 then begin
            pPurchHeader."Pmt. Discount Date" := 0D;
            pPurchHeader."Payment Discount %" := 0;
        end;
    end;


    procedure SetPurchInvBufferSubscription(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pPurchLine: Record "Purchase Line")
    begin
        SetInvBufferSubscriptionDate(pInvPostingBuffer, pPurchLine."Subscription Starting Date", pPurchLine."Subscription End Date");
    end;


    procedure SetPurchCreditGLAccount(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pGenPostingSetup: Record "General Posting Setup"; pPurchLine: Record "Purchase Line"; pTotalAmountToInvoice: Decimal)
    begin
        if (pPurchLine."Document Type" in [pPurchLine."document type"::Order, pPurchLine."document type"::Invoice])
           and (pTotalAmountToInvoice < 0) then begin
            pGenPostingSetup.TestField("Purch. Credit Memo Account");
            pInvPostingBuffer."G/L Account" := pGenPostingSetup."Purch. Credit Memo Account";
        end;
    end;


    procedure SetServInvBufferSubscription(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pServLine: Record "Service Line")
    begin
        SetInvBufferSubscriptionDate(pInvPostingBuffer, pServLine."Subscription Starting Date", pServLine."Subscription End Date");
    end;


    procedure SetGenJnlLineSubscripDate(var pGenJnlLine: Record "Gen. Journal Line"; pInvPostingBuffer: Record "Invoice Post. Buffer")
    begin
        if pGenJnlLine."Account Type" = pGenJnlLine."account type"::"G/L Account" then begin
            pGenJnlLine."Subscription Starting Date" := pInvPostingBuffer."Subscription Starting Date";
            pGenJnlLine."Subscription End Date" := pInvPostingBuffer."Subscription End Date";
            ;
        end;
    end;


    procedure SetBreakBufferSubscription(var pFromInvPostingBuffer: Record "Invoice Post. Buffer"; var pToInvPostingBuffer: Record "Invoice Post. Buffer"; var pFALineNo: Integer)
    begin
        pToInvPostingBuffer.Reset;
        pToInvPostingBuffer.SetRange(Type, pFromInvPostingBuffer.Type);
        pToInvPostingBuffer.SetRange("G/L Account", pFromInvPostingBuffer."G/L Account");
        pToInvPostingBuffer.SetRange("Gen. Bus. Posting Group", pFromInvPostingBuffer."Gen. Bus. Posting Group");
        pToInvPostingBuffer.SetRange("Gen. Prod. Posting Group", pFromInvPostingBuffer."Gen. Prod. Posting Group");
        pToInvPostingBuffer.SetRange("VAT Bus. Posting Group", pFromInvPostingBuffer."VAT Bus. Posting Group");
        pToInvPostingBuffer.SetRange("VAT Prod. Posting Group", pFromInvPostingBuffer."VAT Prod. Posting Group");
        pToInvPostingBuffer.SetRange("Tax Area Code", pFromInvPostingBuffer."Tax Area Code");
        pToInvPostingBuffer.SetRange("Tax Group Code", pFromInvPostingBuffer."Tax Group Code");
        pToInvPostingBuffer.SetRange("Tax Liable", pFromInvPostingBuffer."Tax Liable");
        pToInvPostingBuffer.SetRange("Use Tax", pFromInvPostingBuffer."Use Tax");
        //GL2024   pToInvPostingBuffer.SetRange("Dimension Entry No.", pFromInvPostingBuffer."Dimension Entry No.");
        pToInvPostingBuffer.SetRange("Job No.", pFromInvPostingBuffer."Job No.");
        //  pToInvPostingBuffer.setrange("Fixed Asset Line No.",pFromInvPostingBuffer."Fixed Asset Line No.");
        pToInvPostingBuffer.SetRange("Subscription Starting Date", pFromInvPostingBuffer."Subscription Starting Date");
        pToInvPostingBuffer.SetRange("Subscription End Date", pFromInvPostingBuffer."Subscription End Date");
        if not pToInvPostingBuffer.FindFirst then begin
            pFALineNo := pFALineNo + 1;
            pFromInvPostingBuffer."Fixed Asset Line No." := pFALineNo;
        end else begin
            if pFromInvPostingBuffer.Type <> pFromInvPostingBuffer.Type::"Fixed Asset" then
                pFromInvPostingBuffer."Fixed Asset Line No." := pToInvPostingBuffer."Fixed Asset Line No.";
        end;
        pToInvPostingBuffer.Reset;
    end;


    procedure SetInvBufferSubscriptionDate(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pStartDate: Date; pEndDate: Date)
    begin
        pInvPostingBuffer."Subscription Starting Date" := pStartDate;
        pInvPostingBuffer."Subscription End Date" := pEndDate;
    end;
}

