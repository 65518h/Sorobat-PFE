Codeunit 8003912 "Purge Supply Order"
{

    trigger OnRun()
    begin
        fInitialize;
        fProcess;
    end;

    var
        wSupplyOrderHeader: Record "Sales Header";
        wSupplyOrderLine: Record "Sales Line";
        wLineOrderExist: Record "Sales Line";
        wSalesCommentLine: Record "Sales Comment Line";
        wWhseRqst: Record "Warehouse Request";
        wReserveSalesLine: Codeunit "Sales Line-Reserve";


    procedure fDeleteSupplyOrder(pRec: Record "Sales Header")
    begin
        if pRec.HasLinks then
            pRec.DeleteLinks;

        pRec.Delete;
        wReserveSalesLine.DeleteInvoiceSpecFromHeader(pRec);
        if wSupplyOrderLine.FindFirst then
            repeat
                if wSupplyOrderLine.HasLinks then
                    wSupplyOrderLine.DeleteLinks;
            until wSupplyOrderLine.Next = 0;
        wSupplyOrderLine.DeleteAll;
        fDeleteItemChargeAssgnt(wSupplyOrderLine);
        wSalesCommentLine.SetRange("Document Type", pRec."Document Type");
        wSalesCommentLine.SetRange("No.", pRec."No.");
        if not wSalesCommentLine.IsEmpty then
            wSalesCommentLine.DeleteAll;
        wWhseRqst.SetCurrentkey("Source Type", "Source Subtype", "Source No.");
        wWhseRqst.SetRange("Source Type", Database::"Sales Line");
        wWhseRqst.SetRange("Source Subtype", pRec."Document Type");
        wWhseRqst.SetRange("Source No.", pRec."No.");
        if not wWhseRqst.IsEmpty then
            wWhseRqst.DeleteAll;
    end;


    procedure fDeleteItemChargeAssgnt(pRec: Record "Sales Line")
    var
        lItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
    begin
        lItemChargeAssgntSales.SetRange("Document Type", pRec."Document Type");
        lItemChargeAssgntSales.SetRange("Document No.", pRec."Document No.");
        if not lItemChargeAssgntSales.IsEmpty then
            lItemChargeAssgntSales.DeleteAll;
    end;


    procedure fInitialize()
    begin
        wSupplyOrderHeader.SetRange("Order Type", wSupplyOrderHeader."order type"::"Supply Order");
        wSupplyOrderHeader.SetRange(Finished, true);
    end;


    procedure fProcess()
    begin
        if (not wSupplyOrderHeader.IsEmpty()) then begin
            wSupplyOrderHeader.Find('-');
            repeat
                // regardons s'il il existe des commandes ayant cette demande d'appro en lien
                wLineOrderExist.SetRange(wLineOrderExist."Supply Order No.", wSupplyOrderHeader."No.");
                if (wLineOrderExist.IsEmpty()) then begin
                    // Comme il n'existe plus de commande ayant un lien avec cet demande d'appro, on peut la suprimer
                    // mais aveant, il faut recuperer l'ensemble des lignes de demande d'appro
                    wSupplyOrderLine.SetRange(wSupplyOrderLine."Document No.", wSupplyOrderHeader."No.");
                    fDeleteSupplyOrder(wSupplyOrderHeader);
                end;
            until (wSupplyOrderHeader.Next() = 0);
        end;
    end;
}

