page 50295 "Ligne Reception Non Stockable"
{
    // //+OFF+REMISE GESWAY 17/10/02 Ajout de "Discount 1 %","Discount 2 %","Discount 3 %"
    //                                "Line Discount %" en Visible=NO
    // //+RFA+ GESWAY 11/07/02 Ajout de "Rule Discount Line Amount" (visible Non)
    // //+REF+SOLDE_CDE CLA 22/01/03 Ajout colonne "Completely Received" et function wCompletelyReceived
    // //+REF+MEMOPAD   CW  15/02/05 OnAssistEdit(Description) and (Description 2)
    // //+REF+COTFRN DL 08/08/05 Ajout colonnes "Quantité non conforme","Code de non conformité"
    // //+REF+LOT GESWAY 15/01/06 Ajout des champs "Lot No.", "Expiration Date" et "Serial No."
    // //OUVRAGE GESWAY 12/03/03 Ajout fonction wShowDescription
    // //DEVIS GESWAY 22/07/03 Modification du formulaire appelé dans OpenSalesOrderForm et OpenSpecOrderSalesOrderForm
    //                         Form Sales order = Internal Order Variable local
    // //ACHATS GESWAY 16/02/04 Ajout du champ "Gen. Prod. Posting Group", Visible No par défaut
    //                 17/03/04 Appel de la fonction wInitLocationCode sur le OnNewRecord
    //                 09/07/04 Ajout champ "Description 2"
    // //MULTIPLE GESWAY 25/02/05 Ajout de CurrForm.UPDATE; sur Form - OnActivateForm()
    // //PROJET GESWAY 01/11/01 Job No. : Visible OUI
    //                          Ajout champs Phase Code (visible oui),Task Code,Step Code,Work Type Code (visible non)

    AutoSplitKey = true;
    Caption = 'Purchase Order Subform';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = Card;
    SourceTable = 39;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
             repeater("Control1")
            {
                field(Type; REC.Type)
                {
                    Editable = false;
                }
                field("No."; rec."No.")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //CrossReferenceNoOnAfterValidateShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    Editable = false;
                    Visible = false;
                }
             /*   field("Cross-Reference No.";  "Cross-Reference No.")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lItemCrossReference: Record 5717;
                        lPurchHeader: Record 38;
                    begin
                        CrossReferenceNoLookUp;

                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        rec.CrossReferenceNoOnAfterValidate;
                    end;
                }*/
                field("Vendor Item No."; rec."Vendor Item No.")
                {
                    Editable = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Nonstock; rec.Nonstock)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        Item.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"BON COMMANDE SOUROUBAT ARCHIVE", TRUE, TRUE, Item);
                        EXIT;
                        //+REF+MEMOPAD
                        CurrPage.UPDATE(TRUE);
                        IF wEditMemoPad THEN
                            CurrPage.UPDATE;
                        //+REF+MEMOPAD//
                    end;
                }
                field("Description 2"; rec."Description 2")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        //+REF+MEMOPAD
                        CurrPage.UPDATE(TRUE);
                        IF wEditMemoPad THEN
                            CurrPage.UPDATE;
                        //+REF+MEMOPAD//
                    end;
                }
                field("Completely Received"; rec."Completely Received")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    BlankZero = true;
                    Caption = 'Ordered Quantity';
                    Editable = false;
                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Value 1"; rec."Value 1")
                {
                    Visible = false;
                }
                field("Value 2"; rec."Value 2")
                {
                    Visible = false;
                }
                field("Value 3"; rec."Value 3")
                {
                    Visible = false;
                }
                field("Value 4"; rec."Value 4")
                {
                    Visible = false;
                }
                field("Value 5"; rec."Value 5")
                {
                    Visible = false;
                }
                field("Value 6"; rec."Value 6")
                {
                    Visible = false;
                }
                field("Value 7"; rec."Value 7")
                {
                    Visible = false;
                }
                field("Value 8"; rec."Value 8")
                {
                    Visible = false;
                }
                field("Value 9";rec."Value 9")
                {
                    Visible = false;
                }
                field("Value 10"; rec."Value 10")
                {
                    Visible = false;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    Visible = false;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    Visible = false;
                }
                field("Serial No."; rec."Serial No.")
                {
                    Visible = false;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    BlankZero = true;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    Editable = false;
                }
                field("Qty. Not In Conformity"; rec."Qty. Not In Conformity")
                {
                    Visible = false;
                }
                field("Not In Conformity Code"; rec."Not In Conformity Code")
                {
                    Visible = false;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Planned Receipt Date"; rec."Planned Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Order Date"; rec."Order Date")
                {
                    Editable = false;
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Job No."; rec."Job No.")
                {
                    Editable = true;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Affectation Marche"; rec."Affectation Marche")
                {
                }
                field("Sous Affectation Marche"; rec."Sous Affectation Marche")
                {
                }
                field("Whse. Outstanding Qty. (Base)"; rec."Whse. Outstanding Qty. (Base)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutDimCode[3]";ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(3,ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]";ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(4,ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]";ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(5,ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]";ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(6,ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]";ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(7,ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]";ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(8,ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                    end;
                }
                field("Bin Code";rec."Bin Code")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
    end;

    var
        PurchHeader: Record 38;
        TransferExtendedText: Codeunit 378;
        ShortcutDimCode: array [8] of Code[20];
        Item: Record 27;
        "// RB SORO 18/04/2015": Integer;
        RecUserSetup: Record 91;

    
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
    end;

    
    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
    end;

    
    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
    end;

    
    procedure GetPhaseTaskStep()
    begin
       // CODEUNIT.RUN(CODEUNIT::Codeunit75,Rec);
    end;

    
    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record 36;
      //  SalesOrder: page 8003966;
        lSalesOrder2: Record 36;
        lNavibatOrder: page 42;
    begin
        SalesHeader.SETRANGE("No.",rec."Sales Order No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order,rec."Sales Order No.") AND
           (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
          lNavibatOrder.SETTABLEVIEW(SalesHeader);
          lNavibatOrder.EDITABLE := FALSE;
          lNavibatOrder.RUN;
        END ELSE BEGIN
        //DEVIS//
     /*   SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;*/
        //DEVIS
        END;
        //DEVIS//
    end;

    
    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          CurrPage.UPDATE(TRUE);
          TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          UpdateForm(TRUE);
    end;

    
    procedure ShowReservation()
    begin
        rec.FIND;
        Rec.ShowReservation;
    end;

    
    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
       ItemAvailability(AvailabilityType);
    end;

    
    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    
    procedure ShowTracking()
    var
        TrackingForm: page 99000822;
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    
    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    
    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    
    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record 36;
     //   SalesOrder: page 8003966;
        lSalesOrder2: Record 36;
        lNavibatOrder: page 42;
    begin
        SalesHeader.SETRANGE("No.",rec."Special Order Sales No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order,rec."Special Order Sales No.") AND
           (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
          lNavibatOrder.SETTABLEVIEW(SalesHeader);
          lNavibatOrder.EDITABLE := FALSE;
          lNavibatOrder.RUN;
        END ELSE BEGIN
        //DEVIS//
      /*  SalesOrder.SETTABLEVIEW(SalesHeader);
        SalesOrder.EDITABLE := FALSE;
        SalesOrder.RUN;*/
        //DEVIS
        END;
        //DEVIS//
    end;

    
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    
    procedure wEditMemoPad(): Boolean
    var
        lCaption: Text[250];
        lMemoPad: Codeunit 8001411;
        lNewText: Boolean;
        lRec: Record 39;
        lRec2: Record 39;
        lRecordRef: RecordRef;
    begin
        lNewText := (rec."Line No." = 0);
        IF rec."Attached to Line No." = 0 THEN BEGIN
          rec.TESTFIELD("No.");
          lRec := Rec;
        END ELSE
          lRec.GET(rec."Document Type",rec."Document No.",rec."Attached to Line No.");
        lCaption := lRec.Description;

        IF NOT lNewText THEN BEGIN
          lRec.INIT; //Keep Primary key
          lRec.SETRANGE("Document Type",rec."Document Type");
          lRec.SETRANGE("Document No.",rec."Document No.");
          lRec.SETRANGE(Type,lRec.Type::" ");
          lRec.SETRANGE("No.",'');
          lRec.SETRANGE("Attached to Line No.",lRec."Line No.");
          lRec.Description := lCaption;
          lRec."Attached to Line No." := lRec."Line No.";
        END ELSE BEGIN
          rec.VALIDATE(Description,' ');
          CurrPage.UPDATE(TRUE);
          lRec.INIT; //Keep Primary key
          lRec.SETRANGE("Document Type",rec."Document Type");
          lRec.SETRANGE("Document No.",rec."Document No.");
          lRec.SETRANGE("Line No.",rec."Line No.");
          lRec."Line No." := rec."Line No.";
        END;

        lRecordRef.GETTABLE(lRec);
        //#5464
        //EXIT(lMemoPad.Edit2(lRecordRef,lCaption,FALSE,FIELDNO(Description),FIELDNO("Description 2"),FIELDNO(Separator)));
        EXIT(lMemoPad.Edit(lRecordRef,lCaption));
        //#5464//
    end;

    
    procedure wCompletelyReceived()
    var
        lPurchHeader: Record 38;
    begin
        //+REF+SOLDE_CDE
        CurrPage.UPDATE(TRUE);
        lPurchHeader.GET(rec."Document Type",rec."Document No.");
        CODEUNIT.RUN(CODEUNIT::"Purch. Order - Post",lPurchHeader);
        UpdateForm(TRUE);
        //+REF+SOLDE_CDE//
    end;

    
    procedure wShowDescription()
    var
        lDescription: Record 8004075;
    begin
        //OUVRAGE
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(39,rec."Document Type",rec."Document No.",rec."Line No.");
        //OUVRAGE//
    end;

    
    procedure "// HJ DSFt"()
    begin
    end;

    
    procedure InsertPVReception() NumSequence: Integer
    var
        RecLPurchaseHeader: Record 38;
        RecLPurchaseLine: Record 39;
        RecPvReception: Record 50004;
        RecPvReceptionII: Record 50004;
        RecLWarehouseReceiptHeader: Record 7316;
        RecLWarehouseReceiptLine: Record 7317;
        RecItem: Record 27;
        IntNumSequence: Integer;
        TextL001: Label 'Veuillez Definir Le N° Du Bon Avant De Lacer La Creation Du Pv De recption';
        TextL002: Label 'Lancer La Creation Du PV ?';
    begin

        //>> HJ DSFT 25-04-2012
        IF rec.Type<>rec.Type::Item THEN EXIT;
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order,rec."Document No.") THEN
          IF rec."PV Generer" THEN
          BEGIN
            IF RecPvReception.GET(rec."Sequence PV",rec."Document No.",rec."No.") THEN
            BEGIN
              RecPvReception."N° BL Fournisseur":=RecLPurchaseHeader."Vendor Shipment No.";
              RecPvReception."N° Ligne":=rec."Line No." ;
              RecPvReception.MODIFY;
              EXIT(rec."Sequence PV");
            END;
          END;
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order,rec."Document No.") THEN
          BEGIN
            RecPvReception.INIT;
            RecPvReception."N° Commande":=rec."Document No.";
            RecPvReception."N° Ligne":=rec."Line No." ;
            RecPvReception."N° Article":=rec."No.";
            RecPvReception."Date Commande" :=RecLPurchaseHeader."Order Date";
            RecPvReception."Lieu De Chargement":=RecLPurchaseHeader."Pay-to Name";
            RecPvReception."Code Fournisseur":=RecLPurchaseHeader."Buy-from Vendor No.";
            RecPvReception."N° BL Fournisseur":=RecLPurchaseHeader."Vendor Shipment No.";
            RecPvReception."N° Affaire":=RecLPurchaseHeader."Job No.";
            RecPvReception."N° Receptipon":=rec."No.";
            RecPvReception.VALIDATE("Poids Net Fournisseur",rec."Qty. to Receive");
            RecPvReception.INSERT;
            IntNumSequence:=RecPvReception."N° Sequence";
            IF  RecLPurchaseLine.GET(rec."Document Type",rec."Document No.",rec."Line No.") THEN
            BEGIN
               RecLPurchaseLine."PV Generer":=TRUE;
               RecLPurchaseLine."Sequence PV":=IntNumSequence;
               RecLPurchaseLine.MODIFY;
            END;
            //"PV Generer":=TRUE;
            //"Sequence PV":=IntNumSequence;
          END;
        EXIT(IntNumSequence);
        //>> HJ DSFT 25-04-2012
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (rec.Type = rec.Type::"Charge (Item)") AND (rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
          CurrPage.UPDATE(TRUE);
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        //ACHATS
        InsertExtendedText(FALSE);
        //ACHATS
    end;
}

