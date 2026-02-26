page 8001452 "Receipt Purchase Order"
{
    // #4868 AC 01/08/07
    // //+REF+ACHAT_FACT CLA 04/06/03 Nouveau formulaire de validation
    //                                       On propose la date de travail pour date compta et date de document
    //                          DL  29/11/05 Editable = Yes sur date de comptabilisation
    // //+RFA+ GESWAY 11/07/02 Ajout du bouton Remises
    //                             CurrForm.EDITABLE = FALSE si add-on RFA utilisé (OnOpenForm)
    //                             New Globals : wDiscSetup
    // //+REF+SOLDE_CDE CLA 04/06/03 Ajout "Solder commande"

    Caption = 'Réceptionner commande achat';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";

    layout
    {
        area(content)
        {
            group(Receipt)
            {
                Caption = 'Réception';
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'N° affaire';
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    Caption = 'En attente';
                    ApplicationArea = all;
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                    Caption = 'En attente';
                }
                field(CompleteProp; wComplete)
                {
                    ApplicationArea = all;
                    Caption = 'Solder commande';
                }
                field(CompleteProp1; wPrint)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        PurchLine: Record 39;
        TempPurchLine: Record 39 temporary;
    begin
        //CurrForm.CAPTION(STRSUBSTNO(Text000,"Document Type"));

        IF PrevNo = rec."No." THEN
            EXIT;
        PrevNo := rec."No.";
        rec.FILTERGROUP(2);
        rec.SETRANGE("No.", PrevNo);
        rec.FILTERGROUP(0);

        //+REF+FACTURATION_ACHAT
        wCalcValues;
        wAmountToInvoice := TotalPurchLine[2]."Line Amount";
        //+REF+FACTURATION_ACHAT//

        SubformIsReady := TRUE;

        //+REF+FACTURATION_ACHAT
        rec."Posting Date" := Rec."Posting Date";
        rec."Document Date" := Rec."Posting Date";
        //+REF+FACTURATION_ACHAT//
    end;

    trigger OnOpenPage()
    begin
        PurchSetup.GET;
    end;

    var
        Text000: Label 'Statistiques %1 achat';
        Text001: Label 'Total';
        Text002: Label 'Montant';
        Text003: Label '%1 ne doit pas être 0.';
        Text004: Label '%1 ne doit pas être supérieur(e) à %2.';
        Text005: Label 'Vous ne pouvez pas modifier la remise facture car il existe un enregistrement %1 pour %2 %3.';
        PurchSetup: Record 312;
        TotalPurchLine: array[3] of Record 39;
        TotalPurchLineLCY: array[3] of Record 39;
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping;
        PrevTab: Option General,Invoicing,Shipping;
        SubformIsReady: Boolean;
        SubformIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        wReceive: Boolean;
        wInvoice: Boolean;
        wPrint: Boolean;
        Text8003900: Label 'Montant commande';
        Text8003901: Label 'Montant à facturer';
        wComplete: Boolean;
        wAmountToInvoice: Decimal;
        wAmountAlreadyInvoiced: Decimal;
        Text8003902: Label 'Montant facturé';
        "-": Integer;
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        ced: Page "Affectation Marche";


    procedure wInitRequest(pReceive: Boolean; pInvoice: Boolean; pPrintDoc: Boolean)
    begin
        wReceive := pReceive;
        wInvoice := pInvoice;
        wPrint := pPrintDoc;
    end;


    procedure wFinishRequest(var pReceive: Boolean; var pInvoice: Boolean; var pComplete: Boolean; var pPostingDate: Date; var pPrint: Boolean)
    begin
        pReceive := wReceive;
        pInvoice := wInvoice;
        //+REF+SOLDE_CDE
        pComplete := wComplete;
        //+REF+SOLDE_CDE//
        pPostingDate := rec."Posting Date";
        pPrint := wPrint;
    end;


    procedure wCalcAmountInvoiced(): Decimal
    var
        lPurchLine: Record 39;
        lAmountInvoiced: Decimal;
    begin
        CLEAR(lAmountInvoiced);
        lPurchLine.SETRANGE("Document Type", rec."Document Type");
        lPurchLine.SETRANGE("Document No.", rec."No.");
        lPurchLine.SETFILTER("Quantity Invoiced", '<>0');
        IF lPurchLine.FIND('-') THEN
            REPEAT
                lAmountInvoiced += lPurchLine."Quantity Invoiced" * lPurchLine."Line Amount" / lPurchLine.Quantity;
            UNTIL lPurchLine.NEXT = 0;
        EXIT(lAmountInvoiced);
    end;


    procedure wCalcValues()
    var
        PurchLine: Record 39;
        TempPurchLine: Record 39 temporary;
    begin
        CLEAR(PurchLine);
        PurchLine.SETRANGE("Document No.", rec."No.");

        IF PurchLine.FIND('-') THEN
            REPEAT
                LineQty := LineQty + PurchLine.Quantity;
                TotalNetWeight := TotalNetWeight + (PurchLine.Quantity * PurchLine."Net Weight");
                TotalGrossWeight := TotalGrossWeight + (PurchLine.Quantity * PurchLine."Gross Weight");
                TotalVolume := TotalVolume + (PurchLine.Quantity * PurchLine."Unit Volume");
                IF PurchLine."Units per Parcel" > 0 THEN
                    TotalParcels := TotalParcels + ROUND(PurchLine.Quantity / PurchLine."Units per Parcel", 1, '>');
            UNTIL PurchLine.NEXT = 0;
    end;

    local procedure GetCaptionClass(FieldCaption: Text[100]; ReverseCaption: Boolean): Text[80]
    begin
        IF rec."Prices Including VAT" XOR ReverseCaption THEN
            EXIT('2,1,' + FieldCaption)
        ELSE
            EXIT('2,0,' + FieldCaption);
    end;
}

