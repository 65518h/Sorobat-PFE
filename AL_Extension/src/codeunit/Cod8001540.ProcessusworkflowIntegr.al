Codeunit 8001540 "Processus workflow Integr."
{
    //GL2024  ID dans Nav 2009 : "8004207"
    // //+NDF+ AC 02/11/2010 Modification de la fonction *ReleasePurchDoc* pour gérer les notes de frais
    // //+WKF+ AC 02/11/2010 *OnInsertItem*  : Bloque l'article si l'option Bloquage nouvel article est activé dans les paramètre workflow
    //                       *SalesQuoteToOrder* : Workflow sur la transformation du devis en commande vente
    //                       *ReleaseSalesDoc* : Workflow qui bloque le lancement d'un document de ventes
    //                                           si dépassement du solde autorisé du client
    //                       *PurchInvoicePostOnHold* : Workflow génération du bon à payer pour les factures
    //                       *PurchCreditPostOnHold*  : Workflow génération du bon à payer pour les avoirs
    //                       *fPurchOnHoldActivate* : déclencheur du bon à payer renvoie
    //                       *PurchOrderGenerate* : Workflow relatif à la génération de commande à partir d'une demande d'achat
    //                       *ReleasePurchDoc* : Gestion du lancement de la commande


    trigger OnRun()
    begin
    end;


    procedure OnInsertItem(var pRec: Record Item)
    var
        lWorkflowSetup: Record "Workflow Setup";
    begin
        if lWorkflowSetup.Get then
            if lWorkflowSetup."Block New Item" then
                pRec.Blocked := true;
    end;


    procedure OnInsertResource(var pRec: Record Resource)
    var
        lWorkflowSetup: Record "Workflow Setup";
    begin
        if lWorkflowSetup.Get then
            if lWorkflowSetup."Block New Item" then
                pRec.Blocked := true;
    end;


    procedure SalesQuoteToOrder(var pQuoteSalesHeader: Record "Sales Header"; var pOrderSalesHeader: Record "Sales Header")
    var
        lWorkflowSetup: Record "Workflow Setup";
        lWorkflowMgt: Codeunit "Workflow Management2";
        Text001: label 'Quote %1 has been changed to order %2.';
    begin
        lWorkflowMgt.RenameTypeNo('', 41, pQuoteSalesHeader."No.", 42, pOrderSalesHeader."No.");
        if lWorkflowSetup.Get and lWorkflowSetup."Notify Sales Quote to Order" then
            lWorkflowMgt.Notify(42, pOrderSalesHeader."No.", pQuoteSalesHeader."Salesperson Code", '',
              StrSubstNo(Text001, pQuoteSalesHeader."No.", pOrderSalesHeader."No."));
    end;


    procedure ReleaseSalesDoc(var pSalesHeader: Record "Sales Header") return: Boolean
    var
        lWorkflowSetup: Record "Workflow Setup";
        lWorkflowMgt: Codeunit "Workflow Management2";
        lCustCheckCreditLimit: Page "Check Credit Limit";
    begin
        if (pSalesHeader."Document Type" = pSalesHeader."document type"::Order) and (pSalesHeader.Status <> -1) then
            if lWorkflowSetup.Get and lWorkflowSetup."Credit Limit Overflow" then
                if lCustCheckCreditLimit.SalesHeaderShowWarning(pSalesHeader) then
                    return := lWorkflowMgt.WorkflowTypeNo(page::"Sales Order", '', pSalesHeader."No.", '', '');
    end;


    procedure PurchInvoicePostOnHold(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        lWorkFlowMgt: Codeunit "Workflow Management2";
    begin
        if fPurchOnHoldActivate(PurchHeader) then
            if lWorkFlowMgt.WorkflowTypeNo(page::"Posted Purchase Invoice", '', PurchInvHeader."No.", '', PurchInvHeader."Purchaser Code") and
               (PurchHeader."On Hold" = '') then begin
                PurchHeader."On Hold" := CopyStr(PurchHeader."Purchaser Code", 1, MaxStrLen(PurchHeader."On Hold"));
            end;
    end;


    procedure PurchCreditPostOnHold(var PurchHeader: Record "Purchase Header"; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        lWorkFlowMgt: Codeunit "Workflow Management2";
    begin
        if fPurchOnHoldActivate(PurchHeader) then
            lWorkFlowMgt.Notify(page::"Posted Purchase Credit Memo", PurchCrMemoHeader."No.", PurchHeader."Purchaser Code",
                                '', PurchCrMemoHeader."Posting Description");
    end;

    local procedure fPurchOnHoldActivate(PurchHeader: Record "Purchase Header") Return: Boolean
    var
        lPaymentMethod: Record "Payment Method";
        lWorkflowSetup: Record "Workflow Setup";
    begin
        if lWorkflowSetup.Get then
            Return := (not lPaymentMethod.Get(PurchHeader."Payment Method Code") or
                                               (lPaymentMethod."Bal. Account No." = ''))
                       and (PurchHeader."Purchaser Code" <> '')
                       and lWorkflowSetup."Purchases OnHold"
        else
            Return := false;
    end;


    procedure PurchOrderGenerate(var pPurchOrder: Record "Purchase Header") Return: Boolean
    var
        lWorkFlowMgt: Codeunit "Workflow Management2";
        lWorkflowSetup: Record "Workflow Setup";
    begin
        if (pPurchOrder."Document Type" = pPurchOrder."document type"::Order) then
            if lWorkflowSetup.Get and lWorkflowSetup."Generate Purchase Order" then
                Return := lWorkFlowMgt.WorkflowTypeNo(page::"Purchase Order", '', pPurchOrder."No.", '', '');
    end;


    procedure ReleasePurchDoc(var pPurchHeader: Record "Purchase Header") return: Boolean
    var
        lWorkflowSetup: Record "Workflow Setup";
        lWorkflowMgt: Codeunit "Workflow Management2";
    begin
        if (pPurchHeader.Status <> -1) then
            case pPurchHeader."Document Type" of
                pPurchHeader."document type"::Order:
                    begin
                        if lWorkflowSetup.Get and lWorkflowSetup."Release Purchase Document" then
                            return := lWorkflowMgt.WorkflowTypeNo(page::"Purchase Order", '', pPurchHeader."No.", '', '');
                    end;
                //+NDF+
                /* GL2024NAVIBAT pPurchHeader."document type"::"Note of Expenses":
                      begin
                          if lWorkflowSetup.Get and lWorkflowSetup."Release Purchase Document" then
                              return := lWorkflowMgt.WorkflowTypeNo(page::"Note of Expenses", '', pPurchHeader."No.", '', '');
                      end;*/
                //+NDF+//
                else
                    return := false;
            end
    end;
}

