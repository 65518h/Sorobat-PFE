Codeunit 8001905 "Purch-Post Subscription integr"
{
    // //+ABO+ GESWAY 30/06/08 *GetPurchTotaltAmountToInvoice* : Fonction qui renvoie le montant total à facturer coté Achat
    //                         *SetPurchHeaderbyCreditMemo* : Initialisation de champ en fonction du montant à facturer coté Achat
    //                         *SetPurchInvBufferSubscripDate* : Initialisation des dates d'abonnement du Buffer de facturation
    //                                                           à partir des lignes achats
    //                         *SetPurchCreditGLAccount* : vérification du paramétrage du compte lié à la génération d'avoir


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
    var
    //GL2024    lInvBufferSubscriptIntegr: Codeunit 8001906;
    begin
        //GL2024   lInvBufferSubscriptIntegr.SetInvBufferSubscriptionDate(pInvPostingBuffer,
        //GL2024            pPurchLine."Subscription Starting Date", pPurchLine."Subscription End Date");
    end;


    procedure SetPurchCreditGLAccount(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pGenPostingSetup: Record "General Posting Setup"; pPurchLine: Record "Purchase Line"; pTotalAmountToInvoice: Decimal)
    begin
        if (pPurchLine."Document Type" in [pPurchLine."document type"::Order, pPurchLine."document type"::Invoice])
           and (pTotalAmountToInvoice < 0) then begin
            pGenPostingSetup.TestField("Purch. Credit Memo Account");
            pInvPostingBuffer."G/L Account" := pGenPostingSetup."Purch. Credit Memo Account";
        end;
    end;
}

