Codeunit 8003946 "Show Invoice"
{
    // //FACTURATION_ACHAT CLA 11/06/03 Visualisation du montant facturé

    TableNo = "Purchase Header";

    trigger OnRun()
    begin
        with PurchInvoice do begin
            Reset;
            SetCurrentkey("Order No.");
            SetRange("Order No.", Rec."No.");
        end;
        Page.RunModal(Page::"Posted Purchase Invoices", PurchInvoice, PurchInvoice.Amount);
    end;

    var
        PurchInvoice: Record "Purch. Inv. Header";
}

