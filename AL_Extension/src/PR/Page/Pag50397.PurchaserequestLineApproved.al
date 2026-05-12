Page 50397 "Purchase request LineApproved"
{
    // //RTC
    // //PROJET GESWAY 01/11/01 Job No. : Visible OUI
    //                          Ajout des champs Phase Code (visible oui),
    //                          Task Code, Step Code, Work Type Code (visible non)
    // //CDE_INTERNE GESWAY 01/10/02 Ajout fonction wExplodeLine
    //                      06/08/03 Ajout du champ "Vendor No."
    // //OUVRAGE GESWAY 01/07/02 Eclatement si article Nomenclature dans OnAfterValidate de Quantité
    //                  12/03/03 Ajout fonction wShowDescription
    // //COMREMISE GESWAY 11/07/02 Ajout de "Rule Discount Line Amount" (visible Non)
    // //ACHAT_DIRECT GESWAY 28/02/03 Ajout Qté achetée, Qté reçue, Date de rangement
    // //ANA_ACTIVITE GESWAY 09/12/05 Ajout Testfield sur "Task Code" et "Step Code" -> wGeneratePurchaseOrder

    AutoSplitKey = true;
    Caption = 'Lignes de demande d''achat approuvées';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase request Line";
    // Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Transférer"; Rec."Transférer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transférer';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = TypeEditable;
                }
                field("Filtre Article"; Rec."Filtre Article")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Type article"; Rec."Type article")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = "No.Editable";
                    //GL2026 trigger OnValidate()
                    // var

                    // begin
                    //     CurrPage.Update();
                    // end;

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     RecItem: Record Item;
                    //     PageItelLookup: Page "Item Lookup";
                    //     RecFixedAsset: Record "Fixed Asset";
                    // begin
                    //     if Rec.Type = Rec.Type::Item then begin
                    //         RecItem.Reset();
                    //         RecItem.SetRange(Type, Rec."Type article");
                    //         if RecItem.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Item Lookup", RecItem) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecItem."No.");

                    //             end;
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::"Fixed Asset" then begin
                    //         if RecFixedAsset.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Fixed Asset List", RecFixedAsset) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecFixedAsset."No.");
                    //             end;
                    //         end;
                    //     end;
                    // end;

                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Purchasing CodeEditable";
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic;
                    Editable = "Vendor No.Editable";
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = DescriptionEditable;

                    /*  trigger OnAssistEdit()
                      begin
                          //#7407
                          //+REF+MEMOPAD
                          CurrPage.SaveRecord();
                      /*    if Rec.fMemoPad then begin
                              if ("Attached to Line No." <> 0) and (Type <> Type::Resource) then
                                  Get("Document Type", "Document No.", "Attached to Line No.")
                              else
                                  Rec.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.");
                              CurrPage.Update(false);
                              //+REF+MEMOPAD//
                          end;
                          //#7407//
                      end;*/
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Control1100282006; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Caption = 'Observation';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    //    Editable = "Location CodeEditable";
                    // Editable = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Basic;
                    // Editable = "Job No.Editable";
                    //Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.") { ApplicationArea = all; }
                field("Job Planning Line No."; Rec."Job Planning Line No.") { ApplicationArea = all; ; }
                field("Need Qty"; Rec."Need Qty")
                {
                    ApplicationArea = Basic;
                    Editable = "Need QtyEditable";
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        PurchaseLine: Record "Purchase request Line";
                    begin
                        PurchaseLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
                        PurchaseLine.SetRange("Document Type", Rec."document type"::Order);
                        PurchaseLine.SetRange("Supply Order No.", Rec."Document No.");
                        PurchaseLine.SetRange("Supply Order Line No.", Rec."Line No.");
                        Page.RunModal(Page::"Purchase Lines", PurchaseLine, PurchaseLine."Need Qty");
                        CurrPage.Update;
                    end;
                }
                field("Need Unit of Measure Code"; Rec."Need Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                    Editable = NeedUnitofMeasureCodeEditable;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Editable = QuantityEditable;

                    trigger OnValidate()
                    var
                        OldValue: Decimal;
                        purchReqLine: Record "Sales Line";
                        lFirstLevel: Boolean;
                        lAttachedDoc: Boolean;
                    begin
                        //#6630 R18
                        //#7498
                        /*
                        purchReqLine.SETCURRENTKEY("Document Type","Supply Order No.","Supply Order Line No.");
                        purchReqLine.SETRANGE("Document Type","Document Type");
                        purchReqLine.SETRANGE("Supply Order No.","Document No.");
                        purchReqLine.SETRANGE("Supply Order Line No.","Line No.");
                        lAttachedDoc := NOT purchReqLine.ISEMPTY;
                        purchReqLine.SETFILTER("Structure Line No.",'> 0');
                        lFirstLevel := purchReqLine.ISEMPTY;
                        
                        //IF ("Order Type" = "Order Type"::"Supply Order") AND (NOT fCheckIsFirstLevel) THEN
                        //IF ("Order Type" = "Order Type"::"Supply Order") AND (NOT fCheckIsFirstLevel) THEN
                        IF ("Order Type" = "Order Type"::"Supply Order") AND (lFirstLevel) AND (lAttachedDoc) THEN
                        */
                        /*   if fCheckIsFirstLevel(Rec) then
                               //#7498//
                               Error(Text8003969, FieldCaption(Quantity));*/
                        //#6630 R18//



                    end;
                }
                field("Location inventory In Progress"; Rec."Location inventory In Progress")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stock Magasin';
                    //HS Editable = "Stock Magasin En CoursEditable";
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Total inventory"; Rec."Total inventory")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Quantity ordered Not Delivered"; Rec."Quantity ordered Not Delivered")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 0 : 3;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("QuantitéMarchéRestante"; QuantitéMarchéRestante)
                {
                    ApplicationArea = Basic;
                    Caption = 'Quantité Marché Restante';
                    DecimalPlaces = 0 : 3;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }

                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic;
                    Editable = "Unit of Measure CodeEditable";

                    /*  trigger OnValidate()
                      begin
                          UnitofMeasureCodeOnAfterValidate;
                      end;*/
                }
                field(Statut; Rec.Statut) { ApplicationArea = all; Visible = ApproVisibilty; }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                    Editable = "Unit of MeasureEditable";
                    Visible = false;
                }
                //     field("Job No."; Rec."Job No.") { ApplicationArea = all; }
                //      field("Job Task No."; Rec."Job Task No.") { ApplicationArea = all; }

                field(Origin; Rec.Origin)
                {
                    ApplicationArea = Basic;
                    Editable = ProvenanceEditable;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = Basic;
                    Editable = DestinationEditable;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic;
                    Editable = HeureEditable;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = Basic;
                    Editable = VehiculeEditable;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = Basic;
                    Editable = ChauffeurEditable;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Reason Refusal"; Rec."Reason Refusal") { ApplicationArea = all; Visible = ApproVisibilty; }
                field("Associated Purchase Order"; Rec."Associated Purchase Order") { ApplicationArea = all; Editable = false; }
                field("N° Ordres de transfert"; Rec."N° Ordres de transfert")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action(denied)
            {
                ApplicationArea = Basic;
                Caption = 'Refusé';
                Image = Cancel;
                Visible = ApproVisibilty;
                trigger OnAction()
                var
                    RecPRHeader: Record "Purchase Request";
                    RecPRHeaderLine: Record "Purchase Request Line";
                    Txt0001: Label '%1 lignes ont été modifiées.';
                    Txt0002: Label 'Voulez-vous rejeter ces %1 lignes?';
                    ICounter: Integer;
                begin
                    ICounter := 0;
                    CurrPage.SetSelectionFilter(RecPRHeaderLine);
                    if Confirm(Txt0002, false, Format(RecPRHeaderLine.Count)) then begin
                        RecPRHeaderLine.FindSet();
                        repeat
                            RecPRHeaderLine.Statut := RecPRHeaderLine.Statut::refused;
                            RecPRHeaderLine.Modify();
                            ICounter := ICounter + 1;
                        until RecPRHeaderLine.Next() = 0;
                        Message(Txt0001, ICounter);
                    end;
                end;
            }

        }
    }




    /* trigger OnDeleteRecord(): Boolean
     begin
         if SalesHeader.Get("document type"::Order, "Document No.") then
             if SalesHeader.Statut <> SalesHeader.Statut::Ouvert then Error(Text001);
     end;*/

    trigger OnInit()
    begin
        ChauffeurEditable := true;
        VehiculeEditable := true;
        HeureEditable := true;
        DestinationEditable := true;
        ProvenanceEditable := true;
        "Unit of MeasureEditable" := true;
        "Unit of Measure CodeEditable" := true;
        QuantityEditable := true;
        "Stock Magasin En CoursEditable" := true;
        "Location CodeEditable" := true;
        DescriptionEditable := true;
        "Vendor No.Editable" := true;
        "Purchasing CodeEditable" := true;
        "No.Editable" := true;
        TypeEditable := true;
    end;
    //HS
    procedure wGeneratePurchaseOrder()
    var
        purchReqLine: Record "Purchase Request line";
        PurchReq: Record "Purchase Request";
        lReqWkshTemplate: Record "Req. Wksh. Template";
        lReqWksName: Record "Requisition Wksh. Name";
        lReqLine: Record "Requisition Line";
        lGetSalesOrder: Report "Get Sales Orders";
        lPerformAction: Report "Carry Out Action Msg. - Req.";
        // lCreatePurchDoc: Page 63905;
        lOrderKO: Boolean;
        //  lPageCreatePurchDoc: Page 63905;
        TXT0001: Label 'Créer la commande d''achat';

        fezfzf: page 233;
    begin

        JobSetup.Get;
        purchReqLine.CopyFilters(Rec);
        CurrPage.SetSelectionFilter(purchReqLine);
        purchReqLine.SetRange("Document Type", Rec."Document Type");
        purchReqLine.SetRange("Document No.", Rec."Document No.");
        purchReqLine.SetFilter("Purchasing Code", '<>%1', '');
        if purchReqLine.Count = 1 then
            if not Confirm(tOnlyOneLine, true) then
                exit;
        if purchReqLine.Find('-') then begin
            repeat
                if (purchReqLine."Vendor No." = '') and (purchReqLine."Special Order" or purchReqLine."Drop Shipment") then
                    Error(tErrorVendor, purchReqLine."Line No.", purchReqLine."No.");

            until purchReqLine.Next = 0;
            purchReqLine.SetFilter("Job Task No.", '<>%1', '');
            if purchReqLine.IsEmpty then
                Error(tErrorJobTaskNo, purchReqLine."No.");
            purchReqLine.Find('-');
        end;
        //Hs
        if PurchReq.get(Rec."Document No.") then
            CODEUNIT.Run(CODEUNIT::"Purch-Request to Order(Yes/No)", PurchReq);
        //Hs

    end;

    /*  trigger OnInsertRecord(BelowxRec: Boolean): Boolean
      begin
          // >> HJ DSFT 04-10-2012
          if RecPriceOfferSetup.Get then;
          if "Vendor No." = '' then "Vendor No." := RecPriceOfferSetup."Default Quote Vendor";
          // >> HJ DSFT 04-10-2012
          if SalesHeader.Get("document type"::Order, "Document No.") then
              if SalesHeader.Statut <> SalesHeader.Statut::Ouvert then Error(Text002);
      end;*/

    /*trigger OnModifyRecord(): Boolean
    begin
        if SalesHeader.Get("document type"::Order, "Document No.") then
            if SalesHeader.Statut <> SalesHeader.Statut::Ouvert then Error(Text002);
    end;
*/
    /*  trigger OnNewRecord(BelowxRec: Boolean)
      begin
          CurrPage.Editable := true;
          Type := xRec.Type;
          Clear(ShortcutDimCode);
          wRecordRef.Close;
          case Type of
              Type::Item:
                  wRecordRef.Open(27);
              Type::Resource:
                  wRecordRef.Open(156);
              else
                  wRecordRef.Open(36);
          end;
          pBelowxrec := BelowxRec;
          // >> HJ DSFT 04-10-2012
          if RecPriceOfferSetup.Get then;
          if "Vendor No." = '' then "Vendor No." := RecPriceOfferSetup."Default Quote Vendor";
          // >> HJ DSFT 04-10-2012
          if SalesHeader.Get("document type"::Order, "Document No.") then
              if SalesHeader.Statut <> SalesHeader.Statut::Ouvert then Error(Text002);
          OnAfterGetCurrRecord;
      end;*/


    var
        SalesHeader: Record "Sales Header";
        JobSetup: Record "Jobs Setup";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        ShortcutDimCode: array[8] of Code[20];
        tOnlyOneLine: label 'Une seule ligne sélectionnée. Voulez-vous continuer ?';
        tParamPropAchat: label 'Configuration de la demande non définie.';
        tErrorVendor: label 'Il n''y a pas de numéro de fournisseur sur la ligne %1 %2.';
        // lSearch: Codeunit 8004003;
        tNoLine: label 'Aucune ligne sélectionnée avec le code d''achat.';
        tCreatePurchOrder: label 'Voulez-vous créer des commandes d''achat ?';
        tExploseQty: label 'Voulez-vous différer le solde ?';
        wRecordRef: RecordRef;
        pBelowxrec: Boolean;
        wOKLookUp: Boolean;
        wKOLookUP: Boolean;
        tPurhaseIsEmpty: label 'Aucun document d’achat n’est associé à cette ligne.';
        // wQtySetup: Record 8003994;
        wOldValueQty: array[10] of Decimal;
        tErrorJobTaskNo: label 'Vous devez saisir le numéro de tâche métier pour l’article %1';
        Text8003969: label 'Vous ne pouvez pas modifier le champ "%1", car cet article est de premier niveau';
        "// DSFT": Integer;
        // RecPriceOfferSetup: Record 8004090;
        Text001: label 'Impossible de supprimer, statut différent de Ouvert';
        Text002: label 'Impossible de modifier, statut différent de Ouvert';
        IsOK: Boolean;
        Text003: label 'Commande déjà générée';
        "QuantitéMarchéRestante": Decimal;
        [InDataSet]
        ApproVisibilty: Boolean;
        [InDataSet]
        TypeEditable: Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Purchasing CodeEditable": Boolean;
        [InDataSet]
        "Vendor No.Editable": Boolean;
        [InDataSet]
        DescriptionEditable: Boolean;
        [InDataSet]
        "Location CodeEditable": Boolean;
        [InDataSet]
        "Job No.Editable": Boolean;
        [InDataSet]
        "Need QtyEditable": Boolean;
        [InDataSet]
        NeedUnitofMeasureCodeEditable: Boolean;
        [InDataSet]
        "Stock Magasin En CoursEditable": Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        "Unit of Measure CodeEditable": Boolean;
        [InDataSet]
        "Unit of MeasureEditable": Boolean;
        [InDataSet]
        ProvenanceEditable: Boolean;
        [InDataSet]
        DestinationEditable: Boolean;
        [InDataSet]
        HeureEditable: Boolean;
        [InDataSet]
        VehiculeEditable: Boolean;
        [InDataSet]
        ChauffeurEditable: Boolean;


    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Sales-Explode BOM", Rec);
    end;

    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
    begin
        if RecUserSetup.Get(UserId) then begin
            if RecUserSetup.approver then
                ApproVisibilty := true;
        end;
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order List";
        RecPurchaseReq: Record "Purchase Request";
    begin
        if RecPurchaseReq.get(Rec."Document No.") then begin
            //  RecPurchaseReq.CalcFields("Associated Purchase Order");
            /* HS  if (Rec."Sales Order No." = '') and (Rec."Special Order Sales No." = '') then 
                  Error(tPurhaseIsEmpty);*/
            PurchHeader.SetRange("Document Type", PurchHeader."document type"::Order);
            if RecPurchaseReq."No." <> '' then
                PurchHeader.SetRange("Purchase Request No.", RecPurchaseReq."No.");
            /* HS  if Rec."Purchasing Order No." <> '' then
                  PurchHeader.SetRange("No.", Rec."Purchasing Order No.")
              else if Rec."Special Order Sales No." <> '' then
                  PurchHeader.SetRange("No.", Rec."Special Order Sales No.");*/
            PurchOrder.SetTableview(PurchHeader);
            PurchOrder.Editable := false;
            PurchOrder.Run;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecPurchaseRq: Record "Purchase Request";
    begin
        if RecPurchaseRq.Get(Rec."Document No.") then begin
            Rec."Job No." := RecPurchaseRq."Job No.";
            Rec."Location Code" := RecPurchaseRq."Location Code";
            Rec."Job Task No." := '0';
        end;
        Rec.Type := Rec.Type::Item;
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        //Supprimé
        /*
        IF ("Purchase Order No." = '') AND ("Special Order Purchase No." = '') THEN
          ERROR(tPurhaseIsEmpty);
        PurchHeader.SETRANGE("Document Type",PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("No.","Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
        */

    end;

    /*procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.Update(true);
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;*/





    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        // Rec.ItemAvailability(AvailabilityType);
    end;


    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowItemSub()
    begin
        // Rec.ShowItemSub;
    end;


    procedure ShowNonstockItems()
    begin
        // Rec.ShowNonstock;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure ShowTracking()
    var
    // TrackingForm: Form UnknownForm99000822;
    begin
        // TrackingForm.SetSalesLine(Rec);
        // TrackingForm.RunModal;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        // SalesHeader.Get("Document Type", "Document No.");
        // SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        // SalesHeader.Get("Document Type", "Document No.");
        // SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure wExplodeLine()
    var
        purchReqLine: Record "Sales Line";
    // lExplodeLine: Report UnknownReport8003959;
    begin
        /*    purchReqLine.SetRange("Document Type", "Document Type");
            purchReqLine.SetRange("Document No.", "Document No.");
            purchReqLine.SetRange("Line No.", "Line No.");
            lExplodeLine.PasseLigne(Rec);
            lExplodeLine.SetTableview(purchReqLine);
            lExplodeLine.RunModal;*/
    end;


    procedure wShowDescription()
    var
    //lDescription: Record UnknownRecord8004075;
    begin
        //OUVRAGE
        /*  TestField("Line No.");
          lDescription.ShowDescription(37, "Document Type", "Document No.", "Line No.");*/
        //OUVRAGE//
    end;











    procedure "//HJ"()
    begin
    end;







}

