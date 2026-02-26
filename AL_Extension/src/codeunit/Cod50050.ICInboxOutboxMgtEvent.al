codeunit 50050 ICInboxOutboxMgtEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert', '', true, true)]
    local procedure OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesLine: Record "Sales Line")
    begin

        //+REF+IC
        ICOutboxSalesLine."Qty. per Unit of Measure" := SalesLine."Qty. per Unit of Measure";
        ICOutboxSalesLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
        ICOutboxSalesLine.Modify();
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesInvTransOnBeforeICOutBoxSalesLineInsert', '', true, true)]
    local procedure OnCreateOutboxSalesInvTransOnBeforeICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesInvLine: Record "Sales Invoice Line"; ICOutBoxSalesHeader: Record "IC Outbox Sales Header")
    begin
        //+REF+IC
        ICOutboxSalesLine."Qty. per Unit of Measure" := SalesInvLine."Qty. per Unit of Measure";
        ICOutboxSalesLine."Unit of Measure Code" := SalesInvLine."Unit of Measure Code";
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesCrMemoTransOnBeforeICOutBoxSalesLineInsert', '', true, true)]
    local procedure OnCreateOutboxSalesCrMemoTransOnBeforeICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        //+REF+IC
        ICOutboxSalesLine."Qty. per Unit of Measure" := SalesCrMemoLine."Qty. per Unit of Measure";
        ICOutboxSalesLine."Unit of Measure Code" := SalesCrMemoLine."Unit of Measure Code";
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert', '', true, true)]
    local procedure OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert(var ICOutboxPurchaseLine: Record "IC Outbox Purchase Line"; PurchaseLine: Record "Purchase Line")
    begin
        //+REF+IC
        ICOutboxPurchaseLine."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
        ICOutboxPurchaseLine."Unit of Measure Code" := PurchaseLine."Unit of Measure Code";
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateSalesLinesOnAfterValidateNo', '', true, true)]
    local procedure OnCreateSalesLinesOnAfterValidateNo(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; ICInboxSalesLine: Record "IC Inbox Sales Line")
    begin
        //+REF+IC
        IF ICInboxSalesLine."Unit of Measure Code" <> '' THEN BEGIN
            CASE SalesLine.Type OF
                SalesLine.Type::Item:
                    BEGIN
                        //le code unit of measure n'existe pas pour l'article
                        IF NOT wItemUnitOfMeasure.GET(SalesLine."No.", ICInboxSalesLine."Unit of Measure Code") THEN BEGIN
                            wItemUnitOfMeasure.SETRANGE("Item No.", SalesLine."No.");
                            IF wItemUnitOfMeasure.FIND('-') THEN
                                REPEAT
                                    IF wItemUnitOfMeasure."Qty. per Unit of Measure" = 1 THEN BEGIN
                                        SalesLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                        IF ICInboxSalesLine."Qty. per Unit of Measure" <> 0 THEN BEGIN
                                            ICInboxSalesLine.Quantity := ICInboxSalesLine.Quantity * ICInboxSalesLine."Qty. per Unit of Measure";
                                            ICInboxSalesLine."Unit Price" := ICInboxSalesLine."Unit Price" / ICInboxSalesLine."Qty. per Unit of Measure";
                                        END;
                                    END;
                                UNTIL (wItemUnitOfMeasure.NEXT = 0) OR (wItemUnitOfMeasure."Qty. per Unit of Measure" = 1);
                        END
                        //le code unit of measure existe pour l'article mais la qty per unit of measure est differente
                        //on recherche un code equivalent pour cette qty
                        ELSE
                            IF wItemUnitOfMeasure."Qty. per Unit of Measure" <> ICInboxSalesLine."Qty. per Unit of Measure" THEN BEGIN
                                wItemUnitOfMeasure.SETRANGE("Item No.", SalesLine."No.");
                                wTrouveQtyPerUnit := FALSE;
                                IF wItemUnitOfMeasure.FIND('-') THEN
                                    REPEAT
                                        IF wItemUnitOfMeasure."Qty. per Unit of Measure" = ICInboxSalesLine."Qty. per Unit of Measure" THEN BEGIN
                                            SalesLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                            wTrouveQtyPerUnit := TRUE;
                                        END;
                                    UNTIL (wItemUnitOfMeasure.NEXT = 0) OR wTrouveQtyPerUnit;
                                //il n'existe pas de code equivalent
                                IF NOT wTrouveQtyPerUnit THEN BEGIN
                                    IF wItemUnitOfMeasure.FIND('-') THEN
                                        REPEAT
                                            IF wItemUnitOfMeasure."Qty. per Unit of Measure" = 1 THEN BEGIN
                                                SalesLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                                IF ICInboxSalesLine."Qty. per Unit of Measure" <> 0 THEN BEGIN
                                                    ICInboxSalesLine.Quantity := ICInboxSalesLine.Quantity * ICInboxSalesLine."Qty. per Unit of Measure";
                                                    ICInboxSalesLine."Unit Price" := ICInboxSalesLine."Unit Price" / ICInboxSalesLine."Qty. per Unit of Measure";
                                                END;
                                            END;
                                        UNTIL (wItemUnitOfMeasure.NEXT = 0) OR (wItemUnitOfMeasure."Qty. per Unit of Measure" = 1);
                                END;
                            END
                            ELSE
                                SalesLine.VALIDATE("Unit of Measure Code", ICInboxSalesLine."Unit of Measure Code");
                    END;
            END;
        END;
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnAfterValidateNo', '', true, true)]
    local procedure OnCreatePurchLinesOnAfterValidateNo(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseLine: Record "IC Inbox Purchase Line")
    begin
        //+REF+IC
        IF ICInboxPurchaseLine."Unit of Measure Code" <> '' THEN BEGIN
            CASE PurchaseLine.Type OF
                PurchaseLine.Type::Item:
                    BEGIN
                        //le code unit of measure n'existe pas pour l'article
                        IF NOT wItemUnitOfMeasure.GET(PurchaseLine."No.", ICInboxPurchaseLine."Unit of Measure Code") THEN BEGIN
                            wItemUnitOfMeasure.SETRANGE("Item No.", PurchaseLine."No.");
                            IF wItemUnitOfMeasure.FIND('-') THEN
                                REPEAT
                                    IF wItemUnitOfMeasure."Qty. per Unit of Measure" = 1 THEN BEGIN
                                        PurchaseLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                        IF ICInboxPurchaseLine."Qty. per Unit of Measure" <> 0 THEN BEGIN
                                            ICInboxPurchaseLine.Quantity := ICInboxPurchaseLine.Quantity * ICInboxPurchaseLine."Qty. per Unit of Measure";
                                            ICInboxPurchaseLine."Unit Cost" := ICInboxPurchaseLine."Unit Cost" / ICInboxPurchaseLine."Qty. per Unit of Measure";
                                        END;
                                    END;
                                UNTIL (wItemUnitOfMeasure.NEXT = 0) OR (wItemUnitOfMeasure."Qty. per Unit of Measure" = 1);
                        END
                        //le code unit of measure existe pour l'article mais la qty per unit of measure est differente
                        //on recherche un code equivalent pour cette qty
                        ELSE IF wItemUnitOfMeasure."Qty. per Unit of Measure" <> ICInboxPurchaseLine."Qty. per Unit of Measure" THEN BEGIN
                            wItemUnitOfMeasure.SETRANGE("Item No.", PurchaseLine."No.");
                            wTrouveQtyPerUnit := FALSE;
                            IF wItemUnitOfMeasure.FIND('-') THEN
                                REPEAT
                                    IF wItemUnitOfMeasure."Qty. per Unit of Measure" = ICInboxPurchaseLine."Qty. per Unit of Measure" THEN BEGIN
                                        PurchaseLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                        wTrouveQtyPerUnit := TRUE;
                                    END;
                                UNTIL (wItemUnitOfMeasure.NEXT = 0) OR wTrouveQtyPerUnit;
                            //il n'existe pas de code equivalent
                            IF NOT wTrouveQtyPerUnit THEN
                                IF wItemUnitOfMeasure.FIND('-') THEN
                                    REPEAT
                                        IF wItemUnitOfMeasure."Qty. per Unit of Measure" = 1 THEN BEGIN
                                            PurchaseLine.VALIDATE("Unit of Measure Code", wItemUnitOfMeasure.Code);
                                            IF ICInboxPurchaseLine."Qty. per Unit of Measure" <> 0 THEN BEGIN
                                                ICInboxPurchaseLine.Quantity := ICInboxPurchaseLine.Quantity * ICInboxPurchaseLine."Qty. per Unit of Measure";
                                                ICInboxPurchaseLine."Unit Cost" := ICInboxPurchaseLine."Unit Cost" / ICInboxPurchaseLine."Qty. per Unit of Measure";
                                            END;
                                        END;
                                    UNTIL (wItemUnitOfMeasure.NEXT = 0) OR (wItemUnitOfMeasure."Qty. per Unit of Measure" = 1);
                        END
                        ELSE
                            PurchaseLine.VALIDATE("Unit of Measure Code", ICInboxPurchaseLine."Unit of Measure Code");
                    END;
            END;
        END;
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxPurchLineInsert', '', true, true)]
    local procedure OnBeforeICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
    begin
        //+REF+IC
        ICInboxPurchaseLine."Qty. per Unit of Measure" := ICOutboxSalesLine."Qty. per Unit of Measure";
        ICInboxPurchaseLine."Unit of Measure Code" := ICOutboxSalesLine."Unit of Measure Code";
        //+REF+IC//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesLineInsert', '', true, true)]
    local procedure OnBeforeICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
    begin
        //+REF+IC
        ICInboxSalesLine."Qty. per Unit of Measure" := ICOutboxPurchaseLine."Qty. per Unit of Measure";
        ICInboxSalesLine."Unit of Measure Code" := ICOutboxPurchaseLine."Unit of Measure Code";
        //+REF+IC//
    end;

    var
        myInt: Integer;
        wItemUnitOfMeasure: Record "Item Unit of Measure";
        wTrouveQtyPerUnit: Boolean;
}