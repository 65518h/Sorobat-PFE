Codeunit 8001428 "Complete Purch. Order"
{
    // //+REF+SOLDE_CDE CLA 17/08/06 Solder commande achat (Entièrement reçu sur chaque ligne)
    // //SUBCONTRACTOR GESWAY 01/01/03 Ajout MAJ SalesLine."Purchasing Document Type" ...

    TableNo = "Purchase Header";

    trigger OnRun()
    begin
        PurchHeader.Copy(Rec);
        Code;
        Rec := PurchHeader;
    end;

    var
        PurchHeader: Record "Purchase Header";


    procedure "Code"()
    var
        lPurchLine: Record "Purchase Line";
        lSalesLine: Record "Sales Line";
    begin
        lPurchLine.SetRange("Document Type", PurchHeader."Document Type");
        lPurchLine.SetRange("Document No.", PurchHeader."No.");
        lPurchLine.SetFilter(Quantity, '<>0');
        if lPurchLine.Find('-') then
            repeat
                if lPurchLine."Drop Shipment" then
                    if lSalesLine.Get(lSalesLine."document type"::Order, lPurchLine."Sales Order No.", lPurchLine."Sales Order Line No.") then begin
                        lSalesLine."Outstanding Quantity" := 0;
                        lSalesLine."Outstanding Qty. (Base)" := 0;
                        lSalesLine."Completely Shipped" := true;
                        lSalesLine.InitQtyToShip;
                        lSalesLine.InitOutstandingAmount;
                        lSalesLine."Purchase Order No." := '';
                        lSalesLine."Purch. Order Line No." := 0;
                        //SUBCONTRACTOR
                        lSalesLine."Purchasing Document Type" := 0;
                        lSalesLine."Purchasing Order No." := '';
                        lSalesLine."Purchasing Order Line No." := 0;
                        //SUBCONTRACTOR//
                        lSalesLine.Modify;
                    end;
                //#6956
                /*DELETE
                    IF lPurchLine."Special Order" THEN
                      IF lSalesLine.GET(lSalesLine."Document Type"::Order,lPurchLine."Special Order Sales No.",
                                        lPurchLine."Special Order Sales Line No.") THEN BEGIN
                        lSalesLine."Outstanding Quantity" :=0;
                        lSalesLine."Outstanding Qty. (Base)" := 0;
                        lSalesLine."Completely Shipped" := TRUE;
                        lSalesLine.InitQtyToShip;
                        lSalesLine.InitOutstandingAmount;
                        lSalesLine."Purchase Order No." := '';
                        lSalesLine."Purch. Order Line No." := 0;
                //SUBCONTRACTOR
                        lSalesLine."Purchasing Document Type" := 0;
                        lSalesLine."Purchasing Order No." := '';
                        lSalesLine."Purchasing Order Line No." := 0;
                //SUBCONTRACTOR//
                        lSalesLine.MODIFY;
                      END;
                DELETE*/
                //#6956//
                lPurchLine."Sales Order No." := '';
                lPurchLine."Sales Order Line No." := 0;
                lPurchLine."Drop Shipment" := false;
                lPurchLine."Special Order" := false;
                lPurchLine."Special Order Sales No." := '';
                lPurchLine."Special Order Sales Line No." := 0;
                lPurchLine."Completely Received" := true;
                lPurchLine."Outstanding Quantity" := 0;
                lPurchLine."Outstanding Qty. (Base)" := 0;
                lPurchLine.InitQtyToReceive;
                lPurchLine.InitOutstandingAmount;
                lPurchLine.Modify;
            until lPurchLine.Next = 0;

    end;
}

