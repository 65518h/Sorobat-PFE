page 50423 "Reordering Requisition Subform"
{
    //  dans nav 2009 id "8003969"
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
    Caption = 'Lignes';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 37;
    Editable = false;
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(" ")
            {

                field(Type; rec.Type)
                {
                }
                field("Filtre Article"; Rec."Filtre Article")
                {
                    Visible = false;
                }
                field("No."; rec."No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lMultiple: Boolean;
                        lRec: Record 37;
                    begin
                        //RTC
                        IF (ISSERVICETIER) THEN
                            xRec.FINDLAST;
                        //RTC//
                        IF rec."Line No." = 0 THEN BEGIN
                            lRec.COPY(Rec);
                            IF lRec.FIND('+') THEN
                                IF xRec."Line No." = lRec."Line No." THEN
                                    lRec.SETFILTER("Line No.", '<=%1', xRec."Line No.")
                                ELSE
                                    lRec.SETFILTER("Line No.", '<%1', xRec."Line No.");
                            IF NOT lRec.FIND('+') THEN
                                rec."Line No." := xRec."Line No." + 10000
                            ELSE BEGIN
                                xRec."Line No." := lRec."Line No.";
                                lRec.SETRANGE("Line No.");
                                IF NOT lRec.FIND('>') THEN
                                    rec."Line No." := xRec."Line No." + 10000
                                ELSE
                                    rec."Line No." := xRec."Line No." + ROUND((lRec."Line No." - xRec."Line No.") / 2, 1);
                            END;
                        END;
                        IF rec.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, pBelowxrec) THEN BEGIN
                            wKOLookUP := lMultiple;
                            IF NOT lMultiple THEN
                                InsertExtendedText(FALSE)
                            ELSE
                                CurrPage.UPDATE(FALSE);
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                // field(Observation; rec.Observation)
                // {
                //     ApplicationArea = all;
                // }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Substitution Available"; rec."Substitution Available")
                {
                    ApplicationArea = all;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    Caption = 'N° fournisseur';
                }

                field(Description; rec.Description)
                {
                    Caption = 'Désignation';

                    trigger OnAssistEdit()
                    begin
                        //#7407
                        //+REF+MEMOPAD
                        CurrPage.SAVERECORD();
                        IF rec.fMemoPad THEN BEGIN
                            IF (rec."Attached to Line No." <> 0) AND (rec.Type <> rec.Type::Resource) THEN
                                rec.GET(REC."Document Type", rec."Document No.", rec."Attached to Line No.")
                            ELSE
                                Rec.GET(Rec."Document Type", Rec."Document No.", Rec."Line No.");
                            CurrPage.UPDATE(FALSE);
                            //+REF+MEMOPAD//
                        END;
                        //#7407//
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                }

                field("Need Qty"; rec."Need Qty")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        lSalesLine: Record 37;
                    begin
                        lSalesLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
                        lSalesLine.SETRANGE("Document Type", rec."Document Type"::Order);
                        lSalesLine.SETRANGE("Supply Order No.", rec."Document No.");
                        lSalesLine.SETRANGE("Supply Order Line No.", rec."Line No.");
                        Page.RUNMODAL(Page::"Sales Lines", lSalesLine, lSalesLine."Need Qty");
                        CurrPage.UPDATE;
                    end;
                }
                field("Need Unit of Measure Code"; rec."Need Unit of Measure Code")
                {
                    Editable = false;
                    Caption = 'Code unité besoin';
                }
                field("Quantité Stock Magasin"; Rec."Quantité Stock Magasin")
                {
                    ApplicationArea = all;
                }
                // field("Stock Magasin En Cours"; Rec."Stock Magasin En Cours")
                // {

                // }
                field("Quantité Stock"; Rec."Quantité Stock")
                {

                }
                field("Stock Total"; Rec."Stock Total")
                {

                }
                field("Quantité Cmd Non Livré"; Rec."Quantité Cmd Non Livré")
                {

                }
                // field("Qte Marhé Rest.";rec.QuantitéMarchéRestante)
                // {

                // }
                field(Quantity; rec.Quantity)
                {
                    BlankZero = true;

                    trigger OnValidate()
                    var
                        OldValue: Decimal;
                        lSalesLine: Record 37;
                        lFirstLevel: Boolean;
                        lAttachedDoc: Boolean;
                    begin
                        //#6630 R18
                        //#7498
                        /*
                        lSalesLine.SETCURRENTKEY("Document Type","Supply Order No.","Supply Order Line No.");
                        lSalesLine.SETRANGE("Document Type","Document Type");
                        lSalesLine.SETRANGE("Supply Order No.","Document No.");
                        lSalesLine.SETRANGE("Supply Order Line No.","Line No.");
                        lAttachedDoc := NOT lSalesLine.ISEMPTY;
                        lSalesLine.SETFILTER("Structure Line No.",'> 0');
                        lFirstLevel := lSalesLine.ISEMPTY;
                        
                        //IF ("Order Type" = "Order Type"::"Supply Order") AND (NOT fCheckIsFirstLevel) THEN
                        //IF ("Order Type" = "Order Type"::"Supply Order") AND (NOT fCheckIsFirstLevel) THEN
                        IF ("Order Type" = "Order Type"::"Supply Order") AND (lFirstLevel) AND (lAttachedDoc) THEN
                        */
                        IF rec.fCheckIsFirstLevel(Rec) THEN
                            //#7498//
                            ERROR(Text8003969, rec.FIELDCAPTION(Quantity));
                        //#6630 R18//

                        wExploseQty;
                        QuantityOnAfterValidate;

                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {


                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field(Provenance; Rec.Provenance)
                {

                }
                field(Destination; Rec.Destination)
                {
                }
                field(Heure; Rec.Heure)
                {

                }
                field(Vehicule; Rec.Vehicule)
                {

                }
                field(Chauffeur; Rec.Chauffeur)
                {

                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    BlankZero = true;
                    Visible = false;
                }


                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    Visible = false;
                }

                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    Visible = false;
                    BlankZero = true;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    Visible = false;
                    BlankZero = true;
                }

                field("Planned Delivery Date"; rec."Planned Delivery Date")
                {
                    Visible = false;
                }
                field("Planned Shipment Date"; rec."Planned Shipment Date")
                {
                    Visible = false;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    Visible = false;
                }

                field("Purch. Order Qty (Base)"; rec."Purch. Order Qty (Base)")
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
        REC.ShowShortcutDimCode(ShortcutDimCode);
        Rec.CALCFIELDS("Quantité Stock");
        OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
        wRecordRef.CLOSE;
        CASE rec.Type OF
            rec.Type::Item:
                wRecordRef.OPEN(27);
            rec.Type::Resource:
                wRecordRef.OPEN(156);
            ELSE
                wRecordRef.OPEN(36);
        END;
        pBelowxrec := BelowxRec;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        IF wQtySetup.GET THEN;
    end;

    var
        SalesHeader: Record 36;
        JobSetup: Record 315;
        SalesPriceCalcMgt: Codeunit 7000;
        TransferExtendedText: Codeunit 378;
        SalesInfoPaneMgt: Codeunit 7171;
        ShortcutDimCode: array[8] of Code[20];
        tOnlyOneLine: Label 'Vous n''avez sélectionné qu''une seule ligne, voulez-vous continuer ?';
        tParamPropAchat: Label 'Vous devez renseigner les paramètres de la proposition d''achat.';
        tErrorVendor: Label 'Vous devez renseigner le N° fournisseur sur la ligne %1 %2.';
        lSearch: Codeunit 8004003;
        tNoLine: Label 'Vous n''avez sélectionné aucune ligne avec une procédure achat.';
        tCreatePurchOrder: Label 'Souhaitez-vous générer les commandes d''achat ?';
        tExploseQty: Label 'Voulez-vous différer le reliquat ?';
        wRecordRef: RecordRef;
        pBelowxrec: Boolean;
        wOKLookUp: Boolean;
        wKOLookUP: Boolean;
        tPurhaseIsEmpty: Label 'Il n''existe pas de document achat associé à cette ligne.';
        wQtySetup: Record 8003994;
        wOldValueQty: array[10] of Decimal;
        tErrorJobTaskNo: Label 'Vous devez renseigner le N° Tâche Affaire pour l''article %1.';
        Text8003969: Label 'Vous ne pouvez pas modifier le champ "%1", car cet article est de premier niveau';


    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
    end;


    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record 38;
        PurchOrder: Page 50;
    begin
        IF (REC."Purchase Order No." = '') AND (REC."Special Order Purchase No." = '') THEN
            ERROR(tPurhaseIsEmpty);
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        IF REC."Purchase Order No." <> '' THEN
            PurchHeader.SETRANGE("No.", REC."Purchase Order No.")
        ELSE IF REC."Special Order Purchase No." <> '' THEN
            PurchHeader.SETRANGE("No.", REC."Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record 38;
        PurchOrder: Page 50;
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


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.UPDATE(TRUE);
            TransferExtendedText.InsertSalesExtText(Rec);
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


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;


    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure ShowTracking()
    var
        TrackingForm: Page 99000822;
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;


    procedure ShowPrices()
    begin
        SalesHeader.GET(rec."Document Type", rec."Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.GET(rec."Document Type", rec."Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure wExplodeLine()
    var
        lSalesLine: Record 37;
    //GL2024  lExplodeLine: Report 8003959;
    begin
        lSalesLine.SETRANGE("Document Type", rec."Document Type");
        lSalesLine.SETRANGE("Document No.", rec."Document No.");
        lSalesLine.SETRANGE("Line No.", rec."Line No.");
        /*GL2024  lExplodeLine.PasseLigne(Rec);
          lExplodeLine.SETTABLEVIEW(lSalesLine);
          lExplodeLine.RUNMODAL;*/
    end;


    procedure wShowDescription()
    var
        lDescription: Record 8004075;
    begin
        //OUVRAGE
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(37, rec."Document Type", rec."Document No.", rec."Line No.");
        //OUVRAGE//
    end;


    procedure wGeneratePurchaseOrder()
    var
        lSalesLine: Record 37;
        lReqWkshTemplate: Record 244;
        lReqWksName: Record 245;
        lReqLine: Record 246;
        lGetSalesOrder: Report 698;
        lPerformAction: Report 493;
        //    lCreatePurchDoc: Page 63905;
        lOrderKO: Boolean;
    //  lPageCreatePurchDoc: Page 63905;
    begin
        //IF NOT CONFIRM(tCreatePurchOrder) THEN
        //  EXIT;
        /*GL2024  IF (NOT ISSERVICETIER) THEN BEGIN
              lCreatePurchDoc.LOOKUPMODE := TRUE;
              IF ACTION::LookupOK = lCreatePurchDoc.RUNMODAL THEN
                  lOrderKO := NOT lCreatePurchDoc.GiveType
              ELSE
                  EXIT;
          END ELSE BEGIN
              lPageCreatePurchDoc.LOOKUPMODE := TRUE;
              IF ACTION::Yes = lPageCreatePurchDoc.RUNMODAL THEN
                  lOrderKO := NOT lPageCreatePurchDoc.GiveType
              ELSE
                  EXIT;
          END;*/
        //ANA_ACTIVITE
        JobSetup.GET;
        //ANA_ACTIVITE//

        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        lSalesLine.SETRANGE("Document Type", rec."Document Type");
        lSalesLine.SETRANGE("Document No.", rec."Document No.");
        lSalesLine.SETFILTER("Purchasing Code", '<>%1', '');
        IF lSalesLine.COUNT = 0 THEN
            ERROR(tNoLine);
        IF lSalesLine.COUNT = 1 THEN
            IF NOT CONFIRM(tOnlyOneLine, TRUE) THEN
                EXIT;
        IF lSalesLine.FIND('-') THEN BEGIN
            REPEAT
                IF (lSalesLine."Vendor No." = '') AND (lSalesLine."Special Order" OR lSalesLine."Drop Shipment") THEN
                    ERROR(tErrorVendor, lSalesLine."Line No.", lSalesLine."No.");
            //#4005    lSalesLine.TESTFIELD("Phase Code");
            /*NAV5.0
            //ANA_ACTIVITE
                IF (JobSetup."Check usage task code" = JobSetup."Check usage task code"::"1") OR
                   (JobSetup."Check usage task code" = JobSetup."Check usage task code"::"4") OR
                   (JobSetup."Check usage task code" = JobSetup."Check usage task code"::"7")
                THEN
                  lSalesLine.TESTFIELD(GetItemCrossRef);
                IF (JobSetup."Check usage step code" = JobSetup."Check usage step code"::"1") OR
                   (JobSetup."Check usage step code" = JobSetup."Check usage step code"::"4") OR
                   (JobSetup."Check usage step code" = JobSetup."Check usage step code"::"7")
                THEN
                  lSalesLine.TESTFIELD(GetResource);
            //ANA_ACTIVITE//
            NAV5.0*/
            UNTIL lSalesLine.NEXT = 0;
            //#6630
            lSalesLine.SETFILTER("Job Task No.", '<>%1', '');
            IF lSalesLine.ISEMPTY THEN
                ERROR(tErrorJobTaskNo, lSalesLine."No.");
            //  lSalesLine.SETFILTER("Job Task No.",'<>%1','0');
            //#6630//
            lSalesLine.FIND('-');
        END;

        lReqWkshTemplate.SETRANGE(Type, lReqWkshTemplate.Type::"Req.");
        lReqWkshTemplate.SETRANGE(Recurring, FALSE);
        IF lReqWkshTemplate.FIND('-') THEN BEGIN
            lReqWksName.SETRANGE("Worksheet Template Name", lReqWkshTemplate.Name);
            lReqWksName.SETRANGE(Name, COPYSTR(USERID, 1, MAXSTRLEN(lReqWksName.Name)));
            IF NOT lReqWksName.FIND('-') THEN BEGIN            //Créer une FS spécifique
                lReqWksName.INIT;
                lReqWksName."Worksheet Template Name" := lReqWkshTemplate.Name;
                lReqWksName.Name := COPYSTR(USERID, 1, MAXSTRLEN(lReqWksName.Name));
                lReqWksName.INSERT;
            END;
        END;
        IF lReqWksName.Name = '' THEN
            ERROR(tParamPropAchat);
        lReqLine.SETRANGE("Worksheet Template Name", lReqWksName."Worksheet Template Name");
        lReqLine.SETRANGE("Journal Batch Name", lReqWksName.Name);
        lReqLine.DELETEALL;
        lReqLine.RESET;
        lReqLine.INIT;
        lReqLine."Worksheet Template Name" := lReqWksName."Worksheet Template Name";
        lReqLine."Journal Batch Name" := lReqWksName.Name;

        lSalesLine.SETRANGE("Drop Shipment", TRUE);
        lSalesLine.SETRANGE("Purchase Order No.", '');
        IF lSalesLine.COUNT > 0 THEN BEGIN
            lGetSalesOrder.SetReqWkshLine(lReqLine, 0);
            lGetSalesOrder.SETTABLEVIEW(lSalesLine);
            lGetSalesOrder.USEREQUESTPAGE(FALSE);
            lGetSalesOrder.RUNMODAL;
            CLEAR(lGetSalesOrder);
        END;
        lSalesLine.SETRANGE("Drop Shipment");
        lSalesLine.SETRANGE("Purchase Order No.");

        lSalesLine.SETRANGE("Special Order", TRUE);
        lSalesLine.SETRANGE("Special Order Purchase No.", '');
        IF lSalesLine.COUNT > 0 THEN BEGIN
            lGetSalesOrder.SetReqWkshLine(lReqLine, 1);
            lGetSalesOrder.SETTABLEVIEW(lSalesLine);
            lGetSalesOrder.USEREQUESTPAGE(FALSE);
            lGetSalesOrder.RUNMODAL;
            CLEAR(lGetSalesOrder);
        END;
        lSalesLine.SETRANGE("Special Order");
        lSalesLine.SETRANGE("Special Order Purchase No.");

        COMMIT;
        lPerformAction.SetReqWkshLine(lReqLine);
        lPerformAction.wSetOrderKO(lOrderKO);
        lPerformAction.USEREQUESTPAGE(FALSE);
        lPerformAction.RUNMODAL;
        CLEAR(lPerformAction);

    end;


    procedure wCreateNewLine(pOldValue: Decimal; pOldValueQty: array[10] of Decimal)
    var
        lNewLine: Record 37;
        lNextLine: Record 37;
        lNextLine2: Record 37;
        lLineNo: Integer;
        lQtySetupOK: Boolean;
        lQtyValue: Decimal;
        lFieldNo: Integer;
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        //QTYVALUE
        lQtySetupOK := (rec."Value 1" <> 0) OR (rec."Value 2" <> 0) OR (rec."Value 3" <> 0) OR
             (rec."Value 4" <> 0) OR (rec."Value 5" <> 0) OR (REC."Value 6" <> 0) OR
             (rec."Value 7" <> 0) OR (rec."Value 8" <> 0) OR (rec."Value 9" <> 0) OR (rec."Value 10" <> 0);
        IF lQtySetupOK THEN BEGIN
            IF (wQtySetup."Executed Formule Qty" > 0) THEN BEGIN
                lFieldNo := wQtySetup."Executed Formule Qty";
                lQtyValue := pOldValueQty[lFieldNo];
                IF lQtyValue = 0 THEN
                    lQtyValue := 1;
            END ELSE
                lQtySetupOK := FALSE;
        END;
        //QTYVALUE//
        lNewLine.COPY(Rec);
        lNextLine.COPY(Rec);
        lNextLine2.COPY(Rec);
        IF lNextLine.NEXT = 0 THEN
            lNewLine."Line No." += 10000
        ELSE BEGIN
            lLineNo := lNewLine."Line No.";
            lNextLine2.SETRANGE("Attached to Line No.", rec."Line No.");
            IF lNextLine2.FIND('+') THEN
                lLineNo := lNextLine2."Line No.";
            lNextLine2.SETRANGE("Attached to Line No.");
            IF lNextLine2.NEXT = 0 THEN
                lNewLine."Line No." := lLineNo + 10000
            ELSE
                lNewLine."Line No." := lLineNo + ((lNextLine2."Line No." - lLineNo) DIV 2);
        END;
        lNewLine.VALIDATE(Quantity, pOldValue - rec.Quantity);

        //QTYVALUE
        IF lQtySetupOK THEN BEGIN
            lRecRef.GETTABLE(lNewLine);
            lFieldRef := lRecRef.FIELD(lFieldNo + rec.FIELDNO("Value 1") - 1);
            lFieldRef.VALUE := ((pOldValue - rec.Quantity) * lQtyValue) / pOldValue;
            lRecRef.SETTABLE(lNewLine);
            //QTYVALUE//

            //QTYVALUE
            lRecRef.GETTABLE(Rec);
            lFieldRef := lRecRef.FIELD(lFieldNo + rec.FIELDNO("Value 1") - 1);
            lFieldRef.VALUE := (rec.Quantity * lQtyValue) / pOldValue;
            lRecRef.SETTABLE(Rec);
            //QTYVALUE//
        END;

        pOldValue := 0;
        IF lNewLine."Requested Delivery Date" = 0D THEN
            lNewLine.VALIDATE("Requested Delivery Date", WORKDATE);
        lNewLine.INSERT(TRUE);
        lNewLine.VALIDATE("No.");



        COMMIT;
        //GL2024  Page.RUNMODAL(Page::"Reliquat Reorder. Requisition", lNewLine);
        IF TransferExtendedText.SalesCheckIfAnyExtText(lNewLine, FALSE) THEN BEGIN
            TransferExtendedText.InsertSalesExtText(lNewLine);
        END;
        IF TransferExtendedText.MakeUpdate THEN;
    end;


    procedure wProposeQtyToShip()
    var
        lSalesLine: Record 37;
    begin
        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        lSalesLine.SETRANGE("Document Type", REC."Document Type");
        lSalesLine.SETRANGE("Document No.", REC."Document No.");
        IF lSalesLine.COUNT = 0 THEN
            ERROR(tNoLine);
        //IF lSalesLine.COUNT = 1 THEN
        //  IF NOT CONFIRM(tOnlyOneLine,TRUE) THEN
        //    EXIT;
        IF lSalesLine.FIND('-') THEN BEGIN
            REPEAT
                lSalesLine."Qty. to Ship" := lSalesLine."Outstanding Quantity";
                lSalesLine."Qty. to Ship (Base)" := lSalesLine."Outstanding Qty. (Base)";
                lSalesLine.InitQtyToInvoice;
                lSalesLine.MODIFY;
            UNTIL lSalesLine.NEXT = 0;
            lSalesLine.FIND('-');
        END;
    end;


    procedure wExploseQty()
    var
        OldValue: Decimal;
        lQtySetupOK: Boolean;
        lFieldNo: Integer;
        lFieldRef: FieldRef;
        lRecRef: RecordRef;
    begin
        OldValue := xRec.Quantity;
        IF OldValue = 0 THEN
            OldValue := 1;
        wOldValueQty[1] := xRec."Value 1";
        wOldValueQty[2] := xRec."Value 2";
        wOldValueQty[3] := xRec."Value 3";
        wOldValueQty[4] := xRec."Value 4";
        wOldValueQty[5] := xRec."Value 5";
        wOldValueQty[6] := xRec."Value 6";
        wOldValueQty[7] := xRec."Value 7";
        wOldValueQty[8] := xRec."Value 8";
        wOldValueQty[9] := xRec."Value 9";
        wOldValueQty[10] := xRec."Value 10";
        lQtySetupOK := NOT wQtySetup.GET;

        IF (xRec.Quantity > REC.Quantity) AND (xRec."Line No." = REC."Line No.") THEN BEGIN
            CurrPage.SAVERECORD;
            IF CONFIRM(tExploseQty, FALSE) THEN BEGIN
                wCreateNewLine(OldValue, wOldValueQty);
                lQtySetupOK := TRUE;
            END;
        END;
        //QTYVALUE
        IF ((REC."Value 1" <> 0) OR (REC."Value 2" <> 0) OR (REC."Value 3" <> 0) OR (REC."Value 4" <> 0) OR (REC."Value 5" <> 0) OR
            (REC."Value 6" <> 0) OR (REC."Value 7" <> 0) OR (REC."Value 8" <> 0) OR (REC."Value 9" <> 0) OR (REC."Value 10" <> 0)) AND
            NOT lQtySetupOK THEN BEGIN
            IF (wQtySetup."Executed Formule Qty" > 0) THEN BEGIN
                lFieldNo := wQtySetup."Executed Formule Qty";
                lRecRef.GETTABLE(Rec);
                lFieldRef := lRecRef.FIELD(lFieldNo + REC.FIELDNO("Value 1") - 1);
                lFieldRef.VALUE := (REC.Quantity * wOldValueQty[lFieldNo]) / OldValue;
                lRecRef.SETTABLE(Rec);
            END;
        END;
        //QTYVALUE//
    end;


    procedure wAfterExploseQty()
    begin
        IF REC.Reserve = REC.Reserve::Always THEN BEGIN
            CurrPage.UPDATE(TRUE);
            REC.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
        CurrPage.UPDATE;
    end;

    local procedure NoOnAfterValidate()
    var
        lMultiple: Boolean;
    begin
        IF NOT wKOLookUP THEN BEGIN
            InsertExtendedText(FALSE);
            IF (REC.Type = REC.Type::"Charge (Item)") AND (REC."No." <> xRec."No.") AND
               (xRec."No." <> '') THEN
                CurrPage.UPDATE(TRUE);
        END
        ELSE BEGIN
            IF wOKLookUp AND (REC."No." <> '') THEN BEGIN
                COMMIT;
                REC.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, pBelowxrec);
                wKOLookUP := lMultiple;
                wOKLookUp := FALSE;
                CurrPage.UPDATE(FALSE);
            END;
        END;
        wKOLookUP := FALSE;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        IF (REC.Reserve = REC.Reserve::Always) AND (REC."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.UPDATE(TRUE);
            REC.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure Value1OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 1 THEN
            wAfterExploseQty;
    end;

    local procedure Value2OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 2 THEN
            wAfterExploseQty;
    end;

    local procedure Value3OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 3 THEN
            wAfterExploseQty;
    end;

    local procedure Value4OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 4 THEN
            wAfterExploseQty;
    end;

    local procedure Value5OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 5 THEN
            wAfterExploseQty;
    end;

    local procedure Value6OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 6 THEN
            wAfterExploseQty;
    end;

    local procedure Value7OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 7 THEN
            wAfterExploseQty;
    end;

    local procedure Value8OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 8 THEN
            wAfterExploseQty;
    end;

    local procedure Value9OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 9 THEN
            wAfterExploseQty;
    end;

    local procedure Value10OnAfterValidate()
    begin
        IF wQtySetup."Executed Formule Qty" = 10 THEN
            wAfterExploseQty;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        wAfterExploseQty;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF REC.Reserve = REC.Reserve::Always THEN BEGIN
            CurrPage.UPDATE(TRUE);
            REC.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        wRecordRef.CLOSE;
        CASE REC.Type OF
            REC.Type::Item:
                wRecordRef.OPEN(27);
            REC.Type::Resource:
                wRecordRef.OPEN(156);
            ELSE
                wRecordRef.OPEN(36);
        END;
    end;

    local procedure NoOnAfterInput(var Text: Text[1024])
    var
        lRecRef: RecordRef;
        lCode: Code[20];
        lRes: Record 156;
    begin
        lCode := Text;
        IF NOT wKOLookUP THEN
            CASE REC.Type OF
                REC.Type::Item:
                    BEGIN
                        wRecordRef.CLOSE;
                        wRecordRef.OPEN(27);
                        lSearch.Search(wRecordRef, lCode);
                        IF lCode <> '' THEN
                            Text := lCode
                        ELSE
                            IF Text <> '' THEN
                                wOKLookUp := TRUE;
                    END;
                REC.Type::Resource:
                    BEGIN
                        wRecordRef.CLOSE;
                        wRecordRef.GETTABLE(lRes);
                        lSearch.Search(wRecordRef, lCode);
                        IF lCode <> '' THEN
                            Text := lCode
                        ELSE
                            IF Text = '' THEN
                                wOKLookUp := TRUE;
                    END;
            END;
    end;
}

