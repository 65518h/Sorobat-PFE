PageExtension 50225 "Whse. Receipt Subform_PagEXT" extends "Whse. Receipt Subform"

{
    layout
    {
        addafter(Description)
        {
            field("N° Camion"; Rec."N° Camion")
            {
                ApplicationArea = all;
            }
            field("Poids Brut Fournisseur"; Rec."Poids Brut Fournisseur")
            {
                ApplicationArea = all;
            }
            field("Tare Chez Fournisseur"; Rec."Tare Chez Fournisseur")
            {
                ApplicationArea = all;
            }
            field("Tare Chantier"; Rec."Tare Chantier")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }



    PROCEDURE InsertPVReception() NumSequence: Integer;
    VAR
        RecLPurchaseHeader: Record "Purchase Header";
        RecLPurchaseLine: Record "Purchase Line";
        RecPvReception: Record "PV Reception";
        RecPvReceptionII: Record "PV Reception";
        RecLWarehouseReceiptHeader: Record "Warehouse Receipt Header";
        RecLWarehouseReceiptLine: Record "Warehouse Receipt Line";
        RecItem: Record Item;
        IntNumSequence: Integer;
        TextL001: Label 'Please define the order number before starting the creation of the reception report';
        TextL002: Label 'Start the creation of the report ?';
    BEGIN
        //>> HJ DSFT 25-04-2012
        IF RecItem.GET(rec."Item No.") THEN IF NOT RecItem."PV Reception Requis" THEN EXIT;
        IF RecLWarehouseReceiptHeader.GET(rec."No.") THEN
            IF RecPvReception.GET(RecLWarehouseReceiptHeader."N° Sequence", rec."Source No.", rec."Item No.") THEN BEGIN
                RecPvReception."N° BL Fournisseur" := RecLWarehouseReceiptHeader."Vendor Shipment No.";
                RecPvReception.VALIDATE("Tare Chez Fournisseur", rec."Tare Chez Fournisseur");
                RecPvReception.VALIDATE("Poids Brut Fournisseur", rec."Poids Brut Fournisseur");
                RecPvReception."N° Camion" := rec."N° Camion";
                //RecPvReception.VALIDATE("Poids Net Fournisseur","Qty. to Receive");
                RecPvReception.VALIDATE("Tare Chantier", rec."Tare Chantier");
                RecPvReception.MODIFY;
                EXIT(RecLWarehouseReceiptHeader."N° Sequence");
            END;
        //IF NOT CONFIRM(TextL002,FALSE) THEN EXIT;

        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order, rec."Source No.") THEN BEGIN
            RecPvReception.INIT;
            RecPvReception."N° Commande" := rec."Source No.";
            RecPvReception."N° Article" := rec."Item No.";
            RecPvReception."N° Camion" := rec."N° Camion";
            RecPvReception."Date Commande" := RecLPurchaseHeader."Order Date";
            RecPvReception."Lieu De Chargement" := RecLPurchaseHeader."Pay-to Name";
            RecPvReception."Code Fournisseur" := RecLPurchaseHeader."Buy-from Vendor No.";
            RecPvReception."N° BL Fournisseur" := RecLWarehouseReceiptHeader."Vendor Shipment No.";
            RecPvReception."N° Affaire" := RecLPurchaseHeader."Job No.";
            RecPvReception."N° Receptipon" := rec."No.";
            RecPvReception.VALIDATE("Tare Chez Fournisseur", rec."Tare Chez Fournisseur");
            RecPvReception.VALIDATE("Poids Brut Fournisseur", rec."Poids Brut Fournisseur");
            //RecPvReception.VALIDATE("Poids Net Fournisseur","Qty. to Receive");
            RecPvReception.VALIDATE("Tare Chantier", rec."Tare Chantier");
            RecPvReception.INSERT;
            IntNumSequence := RecPvReception."N° Sequence";
        END;
        EXIT(IntNumSequence);
        //>> HJ DSFT 25-04-2012
    END;

    PROCEDURE PurgeDonnées();
    VAR
        RecWarehouseReceiptLine: Record "Warehouse Receipt Line";
    BEGIN
        // >> HJ DSFT 25-04-2012
        RecWarehouseReceiptLine.SETRANGE("No.", rec."No.");
        IF RecWarehouseReceiptLine.FINDFIRST THEN
            REPEAT
                RecWarehouseReceiptLine."Tare Chez Fournisseur" := 0;
                RecWarehouseReceiptLine."Poids Brut Fournisseur" := 0;
                RecWarehouseReceiptLine."Tare Chantier" := 0;
                IF RecWarehouseReceiptLine.MODIFY THEN;
            UNTIL RecWarehouseReceiptLine.NEXT = 0;
        // >> HJ DSFT 25-04-2012
    END;

    PROCEDURE UpdateJobNo(ParaModif: Boolean);
    VAR
        RecLPurchaseHeader: Record "Purchase Header";
    BEGIN
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order, rec."Source No.") THEN BEGIN
            IF ParaModif THEN BEGIN
                RecLPurchaseHeader."Job No." := '';
                RecLPurchaseHeader.MODIFY;
            END
            ELSE BEGIN
                RecLPurchaseHeader."Job No." := 'LOT1';
                RecLPurchaseHeader.MODIFY;

            END;
        END;
    END;

}