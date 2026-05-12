page 8003959 "Purchase Receipt Subform"
{
    //GL2024  ID dans Nav 2009 : "8003959" 


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
    Caption = 'Sous-form. commande achat';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                // field(Emplacement; Rec.Emplacement)
                // {
                //     ApplicationArea = all;
                //     Style = AttentionAccent;
                //     StyleExpr = true;
                //     Editable = false;

                // }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Cross-Reference No."; rec."Item Reference No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lItemCrossReference: Record "Item Reference";
                        lPurchHeader: Record 38;
                    begin
                        //GL2024   rec.CrossReferenceNoLookUp;

                        InsertExtendedText(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Vendor Item No."; rec."Vendor Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Width = 40;
                    // trigger OnLookup(var Text: Text): Boolean
                    // begin
                    //     Item.SETRANGE("No.", rec."No.");
                    //     REPORT.RUNMODAL(REPORT::"Article Barcode (Code128)", TRUE, TRUE, Item);
                    // end;

                    /*  trigger OnAssistEdit()
                      begin
                          Item.SETRANGE("No.", rec."No.");
                          REPORT.RUNMODAL(REPORT::"Article Barcode (Code128)", TRUE, TRUE, Item);
                          EXIT;
                          //+REF+MEMOPAD
                          CurrPage.UPDATE(TRUE);
                          IF wEditMemoPad THEN
                              CurrPage.UPDATE;
                          //+REF+MEMOPAD//
                      end;
                  }*/
                    /*  field(barcodeprinter; barcodeprinter)
                      {
                          ShowCaption = false;
                          ApplicationArea = all;
                          StyleExpr = true;
                          Style = Favorable;
                          trigger OnAssistEdit()
                          begin
                              Item.SETRANGE("No.", rec."No.");
                              REPORT.RUNMODAL(REPORT::"Article Barcode (Code128)", TRUE, TRUE, Item);
                          end;*/
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost") { ApplicationArea = all; Editable = false; }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                    trigger OnValidate()
                    var
                        RecLocation: Record Location;
                    begin
                        if RecLocation.Get(rec."Location Code") then begin
                            Rec."dysJob No." := RecLocation.Affaire;
                            Rec.Modify();
                        end;
                    end;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    Caption = 'Quantité commandée';
                    Editable = false;
                }

                field("Outstanding Quantity"; Rec."Outstanding Quantity") { ApplicationArea = all; Editable = false; }
                field("Quantity Received"; Rec."Quantity Received") { ApplicationArea = all; Editable = false; }
                field("Direct Unit Cost"; Rec."Direct Unit Cost") { ApplicationArea = all; Editable = false; }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Value 1"; rec."Value 1")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 2"; rec."Value 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 3"; rec."Value 3")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 4"; rec."Value 4")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 5"; rec."Value 5")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 6"; rec."Value 6")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 7"; rec."Value 7")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 8"; rec."Value 8")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 9"; rec."Value 9")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Value 10"; rec."Value 10")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                /*  field("Quantity Received"; rec."Quantity Received")
                  {
                      ApplicationArea = all;
                      BlankZero = true;
                  }*/
                field("Qty. Not In Conformity"; rec."Qty. Not In Conformity")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Not In Conformity Code"; rec."Not In Conformity Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Planned Receipt Date"; rec."Planned Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Job No."; rec."dysJob No.")
                {
                    ApplicationArea = all;
                    Style = Standard;
                    StyleExpr = true;
                    Caption = 'Marche';


                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("DYSJob Task No."; Rec."DYSJob Task No.")
                {
                    ApplicationArea = all;
                    Caption = 'Numéro de tâche du travail';
                }

                field("Affectation Marche"; Rec."Affectation Marche")
                {
                    ApplicationArea = all;
                    Caption = 'Affectation Marche';
                    Style = Standard;
                    StyleExpr = true;
                }

                field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
                {
                    ApplicationArea = all;
                    Caption = 'Sous Affectation Marche';
                    Style = Standard;
                    StyleExpr = true;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("Fournisseur Transport"; Rec."Fournisseur Transport")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Fournisseur Transport';
                // }
                field(Provenance; Rec.Provenance)
                {
                    ApplicationArea = all;
                    Caption = 'Provenance';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = all;
                    Caption = 'Destination';
                }
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = all;
                    Caption = 'Vehicule';
                }
                field("Durée Theorique (Minute)"; Rec."Durée Theorique (Minute)")
                {
                    ApplicationArea = all;
                    Caption = 'Durée Theorique (Minute)';
                }
                field(Heure; Rec.Heure)
                {
                    ApplicationArea = all;
                    Caption = 'Heure';
                }
                field(Chauffeur; Rec.Chauffeur)
                {
                    ApplicationArea = all;
                    Caption = 'Chauffeur';
                }
                field("Distance Parcourus"; Rec."Distance Parcourus")
                {
                    ApplicationArea = all;
                    Caption = 'Distance Parcourus';
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = all;
                    Caption = 'Volume';
                }


                field("Whse. Outstanding Qty. (Base)"; rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,3';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,4';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,5';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,6';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,7';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,8';
                    Editable = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Dimensions)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Axe analytiques';
                Image = Dimensions;
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                end;
            }
        }

    }
    var

        Item: Record "Item";

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
        ShortcutDimCode: array[8] of Code[20];


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;


    procedure GetPhaseTaskStep()
    begin
        //GL2024  CODEUNIT.RUN(CODEUNIT::Codeunit75, Rec);
    end;


    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record 36;
        //GL2024 SalesOrder: Page "Reordering Requisition";//8003966
        lSalesOrder2: Record 36;
        lNavibatOrder: Page 42;
    begin
        SalesHeader.SETRANGE("No.", rec."Sales Order No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order, rec."Sales Order No.") AND
           (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
            lNavibatOrder.SETTABLEVIEW(SalesHeader);
            lNavibatOrder.EDITABLE := FALSE;
            lNavibatOrder.RUN;
        END ELSE BEGIN
            //DEVIS//
            //GL2024  SalesOrder.SETTABLEVIEW(SalesHeader);
            //GL2024 SalesOrder.EDITABLE := FALSE;
            //GL2024  SalesOrder.RUN;
            //DEVIS
        END;
        //DEVIS//
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
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
        TrackingPage: Page 99000822;
    begin
        TrackingPage.SetPurchLine(Rec);
        TrackingPage.RUNMODAL;
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
        //GL2024  SalesOrder: Page "Reordering Requisition";//8003966
        lSalesOrder2: Record 36;
        lNavibatOrder: Page 42;
    begin
        SalesHeader.SETRANGE("No.", rec."Special Order Sales No.");
        //DEVIS
        IF lSalesOrder2.GET(lSalesOrder2."Document Type"::Order, rec."Special Order Sales No.") AND
           (lSalesOrder2."Order Type" = lSalesOrder2."Order Type"::" ") THEN BEGIN
            lNavibatOrder.SETTABLEVIEW(SalesHeader);
            lNavibatOrder.EDITABLE := FALSE;
            lNavibatOrder.RUN;
        END ELSE BEGIN
            //DEVIS//
            //GL2024 SalesOrder.SETTABLEVIEW(SalesHeader);
            //GL2024  SalesOrder.EDITABLE := FALSE;
            //GL2024  SalesOrder.RUN;
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
            lRec.GET(rec."Document Type", rec."Document No.", rec."Attached to Line No.");
        lCaption := lRec.Description;

        IF NOT lNewText THEN BEGIN
            lRec.INIT; //Keep Primary key
            lRec.SETRANGE("Document Type", rec."Document Type");
            lRec.SETRANGE("Document No.", rec."Document No.");
            lRec.SETRANGE(Type, lRec.Type::" ");
            lRec.SETRANGE("No.", '');
            lRec.SETRANGE("Attached to Line No.", lRec."Line No.");
            lRec.Description := lCaption;
            lRec."Attached to Line No." := lRec."Line No.";
        END ELSE BEGIN
            rec.VALIDATE(Description, ' ');
            CurrPage.UPDATE(TRUE);
            lRec.INIT; //Keep Primary key
            lRec.SETRANGE("Document Type", rec."Document Type");
            lRec.SETRANGE("Document No.", rec."Document No.");
            lRec.SETRANGE("Line No.", rec."Line No.");
            lRec."Line No." := rec."Line No.";
        END;

        lRecordRef.GETTABLE(lRec);
        //#5464
        //EXIT(lMemoPad.Edit2(lRecordRef,lCaption,FALSE,FIELDNO(Description),FIELDNO("Description 2"),FIELDNO(Separator)));
        EXIT(lMemoPad.Edit(lRecordRef, lCaption));
        //#5464//
    end;


    procedure _wCompletelyReceived()
    var
        lPurchHeader: Record 38;
    begin
        //+REF+SOLDE_CDE
        CurrPage.UPDATE(TRUE);
        lPurchHeader.GET(rec."Document Type", rec."Document No.");
        CODEUNIT.RUN(CODEUNIT::"Purch. Order - Post", lPurchHeader);
        UpdateForm(TRUE);
        //+REF+SOLDE_CDE//
    end;


    procedure wCompletelyReceived()
    var
        lPurchHeader: Record 38;
    begin
        //+REF+SOLDE_CDE
        CurrPage.UPDATE(TRUE);
        lPurchHeader.GET(rec."Document Type", rec."Document No.");
        CODEUNIT.RUN(CODEUNIT::"Purch. Order - Post", lPurchHeader);
        UpdateForm(TRUE);
        //+REF+SOLDE_CDE//
    end;


    procedure wShowDescription()
    var
        lDescription: Record 8004075;
    begin
        //OUVRAGE
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
        //OUVRAGE//
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

    procedure InsertPVReception() NumSequence: Integer
    var

        RecLPurchaseHeader: Record "Purchase Header";
        RecLPurchaseLine: Record "Purchase Line";
        RecPvReception: Record "PV Reception";
        RecPvReceptionII: Record "PV Reception";
        RecLWarehouseReceiptHeader: Record "Warehouse Receipt Header";
        RecLWarehouseReceiptLine: Record "Warehouse Receipt Line";
        RecItem: Record "Item";
        IntNumSequence: Integer;
    begin

        //>> HJ DSFT 25-04-2012
        IF rec.Type <> rec.Type::Item THEN EXIT;
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order, rec."Document No.") THEN
            IF rec."PV Generer" THEN BEGIN
                IF RecPvReception.GET(rec."Sequence PV", rec."Document No.", rec."No.") THEN BEGIN
                    RecPvReception."N° BL Fournisseur" := RecLPurchaseHeader."Vendor Shipment No.";
                    RecPvReception."N° Ligne" := rec."Line No.";
                    RecPvReception.MODIFY;
                    EXIT(rec."Sequence PV");
                END;
            END;
        IF RecLPurchaseHeader.GET(RecLPurchaseHeader."Document Type"::Order, rec."Document No.") THEN BEGIN
            RecPvReception.INIT;
            RecPvReception."N° Commande" := rec."Document No.";
            RecPvReception."N° Ligne" := rec."Line No.";
            RecPvReception."N° Article" := rec."No.";
            RecPvReception."Date Commande" := RecLPurchaseHeader."Order Date";
            RecPvReception."Lieu De Chargement" := RecLPurchaseHeader."Pay-to Name";
            RecPvReception."Code Fournisseur" := RecLPurchaseHeader."Buy-from Vendor No.";
            RecPvReception."N° BL Fournisseur" := RecLPurchaseHeader."Vendor Shipment No.";
            RecPvReception."N° Affaire" := RecLPurchaseHeader."Job No.";
            RecPvReception."N° Receptipon" := rec."No.";
            RecPvReception.VALIDATE("Poids Net Fournisseur", rec."Qty. to Receive");
            RecPvReception.INSERT;
            IntNumSequence := RecPvReception."N° Sequence";
            IF RecLPurchaseLine.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN BEGIN
                RecLPurchaseLine."PV Generer" := TRUE;
                RecLPurchaseLine."Sequence PV" := IntNumSequence;
                RecLPurchaseLine.MODIFY;
            END;
            //"PV Generer":=TRUE;
            //"Sequence PV":=IntNumSequence;
        END;
        EXIT(IntNumSequence);
        //>> HJ DSFT 25-04-2012
    end;

    var
        barcodeprinter: label 'Imprimer Barcode';
}

