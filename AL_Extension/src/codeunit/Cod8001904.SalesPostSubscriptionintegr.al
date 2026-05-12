Codeunit 8001904 "Sales-Post Subscription integr"
{
    // //+ABO+ GESWAY 30/06/08 *GetSalesTotaltAmountToInvoice* : Fonction qui renvoie le montant total à facturer coté Vente
    //                         *SetSalesHeaderbyCreditMemo* : Initialisation de champ en fonction du montant à facturer coté Vente
    //                         *SetSalesInvBufferSubscripDate* : Initialisation des dates d'abonnement du Buffer de facturation
    //                                                           à partir des lignes ventes
    //                         *SetServInvBufferSubscription* : Initialisation des dates d'abonnement du Buffer de facturation
    //                                                           à partir des lignes services


    trigger OnRun()
    begin
    end;


    procedure GetSalesTotaltAmountToInvoice(var pSalesLine: Record "Sales Line"; pInvoice: Boolean) Return: Decimal
    var
        lLineAmountToInvoice: Decimal;
    begin
        if pInvoice then begin
            pSalesLine.FindSet(false, false);
            Return := 0;
            repeat
                lLineAmountToInvoice := pSalesLine."Qty. to Invoice" * pSalesLine."Unit Price";
                if pSalesLine."Line Discount %" <> 0 then
                    lLineAmountToInvoice := lLineAmountToInvoice * (100 - pSalesLine."Line Discount %") / 100;
                Return += lLineAmountToInvoice;
            until (pSalesLine.Next = 0);
        end;
    end;


    procedure SetSalesHeaderbyCreditMemo(var pSalesHeader: Record "Sales Header"; pTotalAmountToInvoice: Decimal)
    begin
        if pTotalAmountToInvoice < 0 then begin
            pSalesHeader."Pmt. Discount Date" := 0D;
            pSalesHeader."Payment Discount %" := 0;
        end;
    end;


    procedure SetSalesInvBufferSubscription(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pSalesLine: Record "Sales Line")
    var
    //GL2024   lInvBufferSubscriptIntegr: Codeunit 8001906;
    begin
        //GL2024 lInvBufferSubscriptIntegr.SetInvBufferSubscriptionDate(pInvPostingBuffer,
        //GL2024            pSalesLine."Subscription Starting Date", pSalesLine."Subscription End Date");
    end;


    procedure SetServInvBufferSubscription(var pInvPostingBuffer: Record "Invoice Post. Buffer"; pServLine: Record "Service Line")
    var
    //GL2024    lInvBufferSubscriptIntegr: Codeunit 8001906;
    begin
        //GL2024     lInvBufferSubscriptIntegr.SetInvBufferSubscriptionDate(pInvPostingBuffer,
        //GL2024      pServLine."Subscription Starting Date", pServLine."Subscription End Date");
    end;
}

