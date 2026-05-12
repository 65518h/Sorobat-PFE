Codeunit 8003958 "Reordering Requisition mgt"
{
    //   Concerne la validation des commandes ventes
    //   SetOrderLineFromReq : Fonction qui lie la livraison de la DA avec les ligne d'article de premier niveau sur la commande
    //   SetQtyToBeInvoiced : initialise la quantité à facturer pour les lignes d'article de premier niveau sur la commande


    trigger OnRun()
    begin
    end;


    procedure SetOrderLineFromReq(pReqOrderLine: Record "Sales Line"; pTempSalesLine: Record "Sales Line"; var pSalesShptLine: Record "Sales Shipment Line") Return: Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        if (pReqOrderLine.Type = pReqOrderLine.Type::Item) and
             (pReqOrderLine."Order Type" = pReqOrderLine."order type"::"Supply Order") then begin
            lSalesLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
            lSalesLine.SetRange("Supply Order No.", pReqOrderLine."Document No.");
            lSalesLine.SetRange("Supply Order Line No.", pReqOrderLine."Line No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            if lSalesLine.FindFirst then begin
                pSalesShptLine."Qty. Shipped Not Invoiced" := pSalesShptLine.Quantity;
                pSalesShptLine."Quantity Invoiced" := 0;
                pSalesShptLine."Qty. Invoiced (Base)" := 0;
                lSalesLine."Quantity Shipped" += pTempSalesLine."Qty. to Ship";
                lSalesLine."Qty. Shipped (Base)" += pTempSalesLine."Qty. to Ship (Base)";
                lSalesLine."Qty. Shipped Not Invoiced" := lSalesLine."Quantity Shipped" - lSalesLine."Quantity Invoiced";
                lSalesLine."Qty. Shipped Not Invd. (Base)" := lSalesLine."Qty. Shipped (Base)" - lSalesLine."Qty. Invoiced (Base)";
                lSalesLine.Modify;
                Return := true;
            end else
                Return := false;
        end;
    end;


    procedure SetQtyToBeInvoiced(pReqOrderLine: Record "Sales Line"; var pQtyToBeInvoiced: Decimal; var pQtyToBeInvoicedBase: Decimal)
    var
        lOrderLine: Record "Sales Line";
    begin
        lOrderLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
        lOrderLine.SetRange("Supply Order No.", pReqOrderLine."Document No.");
        lOrderLine.SetRange("Supply Order Line No.", pReqOrderLine."Line No.");
        lOrderLine.SetRange("Structure Line No.", 0);
        if not lOrderLine.IsEmpty then begin
            pQtyToBeInvoiced := 0;
            pQtyToBeInvoicedBase := 0;
        end;
    end;
}

