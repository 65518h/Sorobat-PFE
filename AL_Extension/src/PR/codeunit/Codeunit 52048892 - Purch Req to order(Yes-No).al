namespace Microsoft.Purchases.Document;

using System.Utilities;

codeunit 52048892 "Purch-Request to Order(Yes/No)"
{
    //  HS 
    TableNo = "Purchase Request";

    trigger OnRun()
    var
        ConfirmManagement: Codeunit "Confirm Management";
        IsHandled: Boolean;
        TxtL001: Label '%1 commande(s) a été créée .';
    begin

        /* if not ConfirmManagement.GetResponseOrDefault(ConvertQuoteToOrderQst, true) then
             exit;*/

        IsHandled := false;
        // OnBeforePurchQuoteToOrder(Rec, IsHandled);
        if IsHandled then
            exit;

        PurchQuoteToOrder.Run(Rec);
        // PurchQuoteToOrder.GetPurchOrderHeader(PurchOrderHeader, Rec);
        Message(TxtL001, PurchQuoteToOrder.GetPurchOrderHeader(PurchOrderHeader, Rec));
        IsHandled := false;
        // OnAfterCreatePurchOrder(PurchOrderHeader, IsHandled);
        // if not IsHandled then
        //     if ConfirmManagement.GetResponseOrDefault(StrSubstNo(OpenNewOrderQst, PurchOrderHeader."No."), true) then
        //         PAGE.Run(PAGE::"Purchase Order", PurchOrderHeader);
    end;

    var
        ConvertQuoteToOrderQst: Label 'Do you want to convert the quote to an order?';
        PurchOrderHeader: Record "Purchase Header";
        PurchQuoteToOrder: Codeunit "Purch.-Request to Order";
        OpenNewOrderQst: Label 'The quote has been converted to order number %1. Do you want to open the new order?', Comment = '%1 - No. of new purchase order.';

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;
}

