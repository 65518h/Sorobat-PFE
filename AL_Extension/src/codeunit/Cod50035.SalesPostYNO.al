codeunit 50035 SalesPostYNO
{
    trigger OnRun()
    begin

    end;

    PROCEDURE fCheckPurchRecepted(pSalesHeader: Record "Sales Header") Return: Boolean;
    VAR
        lSalesLine: Record "Sales Line";
        lPurchaseHeader: Record "Purchase Header";
        lPurchasing: Record Purchasing;
        TextCheckPurchRecepted: Label 'La commande d''achat %1 doit d''abord être réceptionnée car la procédure est %2.';
        TextPurchasing: label '''Code'' de la commande Spéciale non trouvée';
        lPurchaseLine: Record "Purchase Line";
    BEGIN
        //#6373
        lPurchasing.SETRANGE("Special Order", TRUE);
        //#8817
        //IF NOT lPurchasing.FINDSET THEN
        //  ERROR(TextPurchasing);
        IF lPurchasing.ISEMPTY THEN
            EXIT(TRUE);
        //#8817//
        lSalesLine.SETRANGE("Document Type", pSalesHeader."Document Type");
        lSalesLine.SETRANGE("Document No.", pSalesHeader."No.");
        lSalesLine.SETRANGE("Special Order", TRUE);
        //lSalesLine.SETFILTER("Purchasing Code",lPurchasing.Code);
        lSalesLine.SETFILTER("Qty. to Ship", '<>%1', 0);
        //lPurchaseHeader.SETCURRENTKEY("Document Type","No.");
        Return := TRUE;
        IF lSalesLine.FIND('-') THEN BEGIN
            REPEAT
                //#7333
                IF (lSalesLine."Special Order Purchase No." <> '') THEN
                    IF lPurchaseLine.GET(lPurchaseLine."Document Type"::Order, lSalesLine."Special Order Purchase No.",
                                        lSalesLine."Special Order Purch. Line No.") THEN BEGIN
                        IF (lSalesLine."Qty. to Ship (Base)" + lSalesLine."Qty. Shipped (Base)" > lPurchaseLine."Qty. Received (Base)") THEN BEGIN
                            MESSAGE(STRSUBSTNO(TextCheckPurchRecepted, lPurchaseHeader."No.", lSalesLine.FIELDCAPTION("Special Order")));
                            EXIT(FALSE);
                        END;
                    END;
            //#7333//
            UNTIL lSalesLine.NEXT = 0;
        END;
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRun(var SalesHeader: Record "Sales Header")
    begin
        //#6373
        IF NOT fCheckPurchRecepted(SalesHeader) THEN
            EXIT;
        //#6373//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    begin
        //+REF+FIN_CREDIT 
        IF SalesHeader."Financial Document" AND
           (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"]) THEN
            IF NOT CONFIRM(TextFinancialDoc, FALSE, SalesHeader."Document Type", SalesHeader."No.") THEN
                EXIT;
        //+REF+FIN_CREDIT//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    var
        myInt: Integer;
        lRecordRef: RecordRef;
        lUserExit: Codeunit UserExit;
        lPrepaymentManagement: Codeunit "Prepayment Management";
        // lPostingForm : page 8001429;
        lPostingDate: Date;
        lInvoice: Boolean;
        lReceive: Boolean;
        lShip: Boolean;
        TextFinancialDoc: Label '%1 %2 est un document financier.\Confirmez-vous la validation ?';
        Text8003900: Label 'Livrer en date du %1';
}