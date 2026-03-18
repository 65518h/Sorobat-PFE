TableExtension 50018 "Sales LineEXT" extends "Sales Line"
{
    //DYS propriete not allowed
    //Permissions = TableData 5936 = rd;

    fields
    {


        modify("No.")
        {
            TableRelation = if (Type = const(" "),
                                "Line Type" = const(" ")) "Standard Text"
            else
            if (Type = const(" "),
                                         "Line Type" = const(Structure)) Resource where(Type = const(Structure))
            else
            if ("Line Type" = const(Totaling),
                                                  "Job No." = filter(<> ''),
                                                  "No." = const('')) "Job Task"."Job Task No." where("Job No." = field("Job No."))
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item where("Location Filter" = field("Location Code"))
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource),
                                                           "Line Type" = const(Person)) Resource."No." where(Type = const(Person))
            else
            if (Type = const(Resource),
                                                                    "Line Type" = const(Machine)) Resource."No." where(Type = const(Machine))
            else
            if (Type = const(Resource),
                                                                             "Line Type" = const(Structure)) Resource."No." where(Type = const(Structure))
            else
            if (Type = const(Resource),
                                                                                      "Line Type" = const(Other)) Resource."No." where(Type = filter(Other));




            trigger OnbeforeValidate()
            var

                SalesLine2: Record "Sales Line";
                lSalesLine: Record "Sales Line";
            begin

                // // >> HJ SORO 15-01-2015
                // IF Type = Type::Item THEN BEGIN
                //     IF ("No." <> 'IMM') AND ("No." <> '3000010000001') THEN BEGIN
                //         SalesLine2.SETRANGE("No.", "No.");
                //         SalesLine2.SETRANGE("Document No.", "Document No.");
                //         SalesLine2.SETRANGE("Document Type", "Document Type");
                //         //KA 20-01-23    IF SalesLine2.FINDFIRST THEN ERROR(Text033);
                //     END;
                // END;
                // // >> HJ SORO 15-01-2015

                // // >> HJ SORO 06-03-2018
                // IF "Order Type" = lSalesLine."Order Type"::"Supply Order" THEN CduSoro.VerifMateriauxChantier("Job No.", "No.");

                // // >> HJ SORO 06-03-2018


            end;






            //GL2024
            /*
                        trigger OnLookup
                        var
                         lMultiple: Boolean;
                        lLooku: Codeunit 8001427;
            begin


                            //+ONE+
                            CASE Type OF
                                Type::Item:
                                    BEGIN
                                        wRecordref.OPEN(DATABASE::Item);
                                        wLookUpNo(Rec, xRec, wRecordref, lMultiple, FALSE);
                                    END;
                                Type::Resource:
                                    BEGIN
                                        wRecordref.OPEN(DATABASE::Resource);
                                        wLookUpNo(Rec, xRec, wRecordref, lMultiple, FALSE);
                                    END
                                ELSE
                                    //+REF+SUGG_ACC
                                    lLookup.SalesLineNo(Rec);
                            //+REF+SUGG_ACC//
                            END;
                            wRecordre

                        end;*/
        }



        /*GL2024 modify("Sell-to Customer No.")
         {
             Editable = true;
         }
             modify("VAT %")
           {
               Editable = true;
           }
              modify("Qty. Shipped Not Invoiced")
           {
               Editable = true;
           }
              modify("Shipped Not Invoiced")
           {
               Editable = true;
           }
              modify("Quantity Shipped")
           {
               Editable = true;
           }
              modify("Quantity Invoiced")
           {
               Editable = true;
           }
              modify("Bill-to Customer No.")
           {
               Editable = true;
           }
              modify("Attached to Line No.")
           {
               Editable = true;
           }
                 modify("Special Order")
           {
               Editable = true;
           }
                     modify("Special Order")
           {
               Editable = true;
           }
           */






        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }


        modify("Prepmt. Amt. Inv.")
        {
            Caption = 'Prepmt. Amt. Inv.';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
        }




        modify(Type)
        {
            trigger OnBeforeValidate()
            begin
                //DEVIS
                // IF (SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order") AND NOT (Type IN [Type::Item, Type::" "]) THEN;// HJ SORO
                // ANNUELR ERROR(ErrorSupplyOrder,Type);
                IF "Document Type" <> "Document Type"::Quote THEN
                    //DEVIS//

                    //#9365
                    //CDE_INTERNE
                    IF (SalesHeader."Order Type" = SalesHeader."Order Type"::Transfer) AND ("Structure Line No." = 0) THEN BEGIN
                        IF NOT (Type IN [Type::Resource, Type::" "]) THEN
                            ERROR(ErrorTransferOrder, Type)
                        ELSE
                            IF (Type = Type::Resource) AND ("Line Type" <> "Line Type"::Structure) THEN
                                ERROR(ErrorTransferOrder, "Line Type");
                    END;
                //#9365//
            end;
        }


        /*  modify("Location Code")
          {
              trigger OnAfterValidate()
              begin
                  //#4928
                  IF CurrFieldNo = FIELDNO("Location Code") THEN
                      wStructureMgt.UpdateStructureLine(Rec, FIELDNO("Location Code"), FALSE);
                  //#4928//

                  // >> HJ SORO 05-06-2014
                  CALCFIELDS("Stock Magasin En Cours");
                  // >> HJ SORO 05-06-2014
                  Location.RESET;
                  IF Location.GET("Location Code") THEN BEGIN
                      IF Location.Affectation <> '' THEN
                          VALIDATE("Job No.", Location.Affectation);
                  END
              end;
          }*/



        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS  IF NOT PlannedShipmentDateCalculated THEN
                IF ("Planned Shipment Date" = 0D) THEN
                    //DEVIS//
                    "Planned Shipment Date" := CalcPlannedShptDate(FieldNo("Shipment Date"));
                //DEVIS  IF NOT PlannedDeliveryDateCalculated THEN
                IF ("Planned Delivery Date" = 0D) THEN
                    //DEVIS//
                    "Planned Delivery Date" := CalcPlannedDeliveryDate(FieldNo("Shipment Date"));
            end;
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                TestStatusOpen;
                IF CurrFieldNo = FIELDNO(Description) THEN
                    IF ("No." = '') AND NOT ("Line Type" IN ["Line Type"::" ", "Line Type"::Totaling]) AND ("Structure Line No." = 0) THEN BEGIN
                        "Attached to Line No." := 0;
                        VALIDATE("Line Type", "Line Type"::" ");
                    END;
                //DEVIS//
            END;

        }


        modify("Description 2")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                TestStatusOpen;
                //DEVIS//
            END;

        }




        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var

                lxRec: Record "Sales Line";
            begin
                TestStatusOpen;
                //+ONE+
                //HS
                /*   lxRec := Rec;
                   //+ONE+//
                   // >> HJ SORO 17-02-2017
                   "Quantity (Base)" := Quantity;
                   "Outstanding Quantity" := Quantity - "Quantity Shipped";
                   "Outstanding Qty. (Base)" := Quantity - "Quantity Shipped";
                   "Qty. Shipped (Base)" := "Quantity Shipped";
                   // >> HJ SORO 17-02-2017
                   //#6767
                   IF (lQtySetup.GET()) THEN BEGIN
                       IF (lQtySetup.fSalesUsed()) THEN BEGIN
                           // obtenons le valeur de la quantit‚ li‚ au calcul de la formule
                           // puis comparons la avec la quantite courante
                           // si different, alors on effectue un RAZ des champs "ValueX"
                           lCalculateQty := lCalcQty.fGetSalesCalcQty(Rec);
                           IF (lCalculateQty <> Rec.Quantity) THEN BEGIN
                               lCalcQty.fSalesReset(Rec);
                           END;
                       END;
                   END;
                   //#6767//

                   //AVANCEMENT
                   IF (Quantity <> xRec.Quantity) THEN BEGIN
                       wTestInvoicedQty(FIELDNO(Quantity));
                       //#5020
                       TESTFIELD("Purchase Order No.", '');
                       //#5020//
                   END;
                   //AVANCEMENT//

                   //CDE_INTERNE
                   wSalesLineMgt.SupplyOrderMessage(Rec, xRec, CurrFieldNo);
                   //CDE_INTERNE//

                   //SUBCONTRACTOR
                   IF (CurrFieldNo IN [FIELDNO(Quantity), FIELDNO("Quantity per"), FIELDNO("Quantity (Base)"),
                      FIELDNO("Number of Resources"), FIELDNO("Rate Quantity")]) THEN
                       TESTFIELD(Disable, FALSE);
                   //SUBCONTRACTOR//
                   IF (xRec.Quantity <> Quantity) AND (CurrFieldNo = FIELDNO(Quantity)) THEN BEGIN
                       wCalcQty.wCalcQty(Rec, FIELDNO(Quantity));
                       lInit := TRUE;
                   END;
   */
                //HS
            end;






            trigger OnAfterValidate()
            var
                lSalesline: Record "Sales Line";

            begin
                //HS
                //CADENCE
                /*  wUpdateDuration(FIELDNO("Quantity (Base)"));
                  //CADENCE//

                  //OUVRAGE
                  //MARGE
                  IF ("Line Type" = "Line Type"::Structure) THEN
                      wSalesLineMgt.UpdateStructLine(Rec, xRec, StatusCheckSuspended)
                  ELSE
                      IF ("Structure Line No." = 0) THEN
                          wOverhead.SalesLine(Rec, TRUE, TRUE);
                  //MARGE//
                  IF ("Structure Line No." <> 0) AND (Type <> Type::" ") AND
                     ((CurrFieldNo = FIELDNO(Quantity)) OR (CurrFieldNo = FIELDNO("Quantity (Base)"))) THEN
                      VALIDATE("Unit Cost (LCY)");
                  //OUVRAGE//

                  //CDE_INTERNE
                  IF "Order Type" = "Order Type"::"Supply Order" THEN BEGIN
                      //  "Unit Cost (LCY)" := wGetDirectCost;
                      //  VALIDATE("Unit Cost (LCY)");         //17/03/05
                      GetUnitCost();
                      EXIT;
                  END;
                  //CDE_INTERNE//

                  //DEVIS
                  IF ("Cross-Ref. Line No." <> 0) AND ("Line No." <> "Cross-Ref. Line No.") THEN
                      IF lSalesline.GET("Document Type", "Document No.", "Cross-Ref. Line No.") THEN BEGIN
                          lSalesline."Quantity (Base)" += Quantity - xRec.Quantity;
                          lSalesline.MODIFY;
                      END;
                  //#7121
                  //#6926
                  //IF ("Order Type" <> "Order Type"::"Supply Order") AND ("Structure Line No." = 0) THEN BEGIN
                  //IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) AND
                  //   ("Order Type" <> "Order Type"::"Supply Order") AND ("Structure Line No." = 0) THEN BEGIN
                  //#6926//
                  IF ("Order Type" <> "Order Type"::"Supply Order") AND ("Structure Line No." = 0) THEN BEGIN
                      //#7121//
                      //#8243
                      //#8437 IF lSalesline."Blanket Order No." <> '' THEN
                      //#8243
                      IF MODIFY THEN;
                      wUpdateLine(Rec, xRec, lInit);
                  END;
                  //DEVIS//
                  // >> HJ SORO 13-08-2014
                  UpdateUMIM;
                  // >> HJ SORO 13-08-2014
                  // >> HJ SORO 17-02-2017

                  // >> HJ SORO 17-02-2017
                  // >> HJ SORO 17-02-2017
                  "Shipped Not Invoiced" := "Quantity Shipped" * "Unit Price";
                  // >> HJ SORO 17-02-2017

                  // MH SORO 28-08-2020

                  RecPrixBeton.RESET;
                  RecPrixBeton.SETRANGE(CodeBeton, "No.");
                  IF RecPrixBeton.FINDFIRST THEN Rec.VALIDATE("Unit Price", RecPrixBeton."Prix Reelle");
  */
                // MH SORO 28-08-2020
            end;
        }

        modify("Qty. to Invoice")
        {
            trigger OnBeforeValidate()
            begin
                //CESSION
                IF (CurrFieldNo = FIELDNO("Qty. to Invoice")) AND ("Order Type" = "Order Type"::Transfer) THEN
                    "Qty. to Invoice" := "Qty. to Ship";
                //CESSION//
            end;
        }
        field(10000; XRec_Unit_Price; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("unit price")
        {
            trigger OnBeforeValidate()
            var
            begin
                XRec_Unit_Price := xRec."Unit Price";
            end;

            trigger OnAfterValidate()
            begin
                IF xRec."Assignment Basis" <> xRec."Assignment Basis"::" " THEN
                    TESTFIELD("Assignment Basis", "Assignment Basis"::" ");
                //+ONE+
                //  IF CurrFieldNo = FIELDNO("Unit Price") THEN
                wUpdateLine(Rec, xRec, FALSE);
                //+ONE+//
            end;
        }
        /*    modify("Unit Cost")
            {
                trigger OnBeforeValidate()
                var

                    lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
                    Text043: label 'cannot be %1';
                    Currency: Record Currency;

                begin
                    //facture
                    //IF ("Document Type" = "Document Type"::Invoice) AND ("Main Order No."<> '') AND  (xRec."Unit Price" <> Rec."Unit Price") THEN
                    //  ERROR(tLineNotModificable);
                    //facture//

                    //#5397
                    IF (CurrFieldNo = FIELDNO("Unit Price")) AND ("Unit Price" = xRec."Unit Price") THEN
                        EXIT;
                    //#5397//
                    //#4365
                    //#5923
                    GetSalesHeader;
                    //#5923//

                    //#4956
                    IF "Unit-Amount Rounding Precision" <> 0 THEN
                        "Unit Price" := ROUND("Unit Price", "Unit-Amount Rounding Precision")
                    ELSE BEGIN
                        //#4956
                        //IF "Currency Code" <> '' THEN
                        //#5923  "Unit Price" := ROUND("Unit Price",Currency."Amount Rounding Precision")
                        //#5989
                        IF Currency."Sales Unit-Amt Round. Prec." = 0 THEN
                            Currency.FIELDERROR("Sales Unit-Amt Round. Prec.",
                              STRSUBSTNO(
                                Text043, Currency."Sales Unit-Amt Round. Prec."));
                        //#5989//
                        "Unit Price" := ROUND("Unit Price", Currency."Sales Unit-Amt Round. Prec.");
                    END;
                    //#5923//
                    //#4365//

                    //DEVIS
                    IF "Unit Price" <> 0 THEN
                        IF xRec."Assignment Basis" <> xRec."Assignment Basis"::" " THEN
                            TESTFIELD(Rec."Assignment Basis", Rec."Assignment Basis"::" ");
                    IF ("Unit Price" <> xRec."Unit Price") THEN BEGIN
                        //DEVIS//
                        // TestStatusOpen;
                        //+ABO+
                        IF "Document Type" = "Document Type"::Subscription THEN
                            fSubscrIntegration(FIELDNO("Unit Price"));
                        //+ABO+//
                        //AVANCEMENT
                        wTestInvoicedQty(FIELDNO("Unit Price"));
                        //AVANCEMENT//
                        //DEVIS
                    END;
                    IF ("Unit Price" <> xRec."Unit Price") AND (CurrFieldNo = FIELDNO("Unit Price")) THEN BEGIN
                        "Fixed Price" := TRUE;
                        IF "Profit %" <> 0 THEN
                            VALIDATE("Profit %", 0);
                    END;
                    //DEVIS//

                    //OUVRAGE
                    IF (Type > 0) AND
                       //GL2024 ("Cross-Reference No." <> '') AND
                       ("Structure Line No." = 0) AND
                       //#6428
                       //   (CurrFieldNo = FIELDNO("Unit Price"))
                       ((CurrFieldNo = FIELDNO("Unit Price")) OR (CurrFieldNo = FIELDNO("Line Amount")))
                    //#6428//
                    THEN
                        lSalesCrossRefMgt.wUpdateField(Rec, "Unit Price", FIELDNO("Unit Price"));
                    //  lSalesCrossRefMgt.wUpdateCrossRefPrice(Rec);
                    //OUVRAGE//
                end;

                trigger OnAfterValidate()
                begin
                    //+ONE+
                    IF CurrFieldNo = FIELDNO("Unit Price") THEN
                        wUpdateLine(Rec, xRec, FALSE);
                    //+ONE+//
                end;
            }*/


        modify("Unit Cost (LCY)")
        {
            //blankzero = true;


            trigger OnAfterValidate()
            var

                lQty: Decimal;
                Currency: Record Currency;
            begin
                //DEVIS
                IF Type <> Type::" " THEN BEGIN
                    //  IF Quantity <> 0 THEN
                    //    "Total Cost (LCY)" := "Unit Cost (LCY)" * Quantity
                    //#6629
                    //  IF ("Line Type" = "Line Type"::Structure) THEN
                    //#6909
                    //#7583
                    IF ("Line Type" = "Line Type"::Structure) THEN
                        //  IF ("Structure Line No." <> 0) THEN
                        //#7583//
                        //#6909//
                        //#6629//
                        lQty := "Quantity (Base)"
                    ELSE
                        lQty := Quantity;

                    IF lQty <> 0 THEN
                        "Total Cost (LCY)" := "Unit Cost (LCY)" * lQty
                    ELSE
                        "Total Cost (LCY)" := "Unit Cost (LCY)";
                    IF ("Order Type" <> "Order Type"::"Supply Order") AND ("Line Type" <> "Line Type"::" ") THEN
                        wOverhead.SalesLine(Rec, TRUE, TRUE);
                END;
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
                    VALIDATE(
                        "Outstanding Amt Excl VAT(LCY)",
                        ROUND(
                          "Unit Cost (LCY)" * "Outstanding Quantity",
                          Currency."Amount Rounding Precision"));
                //DEVIS//
                //#4003
                //IF CurrFieldNo = FIELDNO("Unit Cost (LCY)") THEN
                //  wUpdateLine(Rec,lxRec,FALSE);
                //#4003//

            end;
        }



        modify("Line Discount %")
        {

            trigger OnAfterValidate()
            var
                lFixe: Boolean;
                lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
            begin
                //+REF+REMISE
                IF ("Line Discount %" <> xRec."Line Discount %") AND
                   ((CurrFieldNo = FIELDNO("Line Discount %")) OR (CurrFieldNo = FIELDNO("Profit %"))) THEN BEGIN

                    "Customer Disc. Group" := '';
                    //#4590
                    IF "Line Discount %" = 0 THEN
                        "Global Disc. Amount" := 0;
                    //#4590//
                    //MARGE
                    wUpdateLine(Rec, xRec, FALSE);
                    //MARGE//
                END;
                //+REF+REMISE//

                //#6428
                IF (Type > 0) AND
                   //GL2024 ("Cross-Reference No." <> '') AND
                   ("Structure Line No." = 0) AND
                   (CurrFieldNo = FIELDNO("Line Discount %"))
                THEN
                    lSalesCrossRefMgt.wUpdateField(Rec, "Line Discount %", FIELDNO("Line Discount %"))
                //  lSalesCrossRefMgt.wUpdateDiscount(Rec);
                //#6428//
            end;
        }
        modify("Line Discount Amount")
        {
            //blankzero = true;
            trigger OnBeforeValidate()
            begin
                //MARGE
                IF ("Profit %" <> 0) AND ("Line Discount %" <> 0) AND (CurrFieldNo = FIELDNO("Line Discount Amount")) THEN
                    wStructureMgt.wSetProfit(Rec, 0, TRUE);
                //MARGE//

                //AVANCEMENT
                IF "Line Discount Amount" <> xRec."Line Discount Amount" THEN
                    wTestInvoicedQty(FIELDNO("Line Discount Amount"));
                //AVANCEMENT//

            end;

            trigger OnAfterValidate()
            var
                lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
            begin

                //+REF+REMISE
                IF ("Line Discount %" <> xRec."Line Discount %") AND
                   ((CurrFieldNo = FIELDNO("Line Discount %")) OR (CurrFieldNo = FIELDNO("Profit %"))) THEN BEGIN
                    "Customer Disc. Group" := '';
                END;
                //+REF+REMISE//
                //MARGE
                IF ("Line Discount Amount" <> xRec."Line Discount Amount") AND (CurrFieldNo = FIELDNO("Line Discount Amount")) THEN
                    wUpdateLine(Rec, xRec, FALSE);
                //MARGE//

                //#6428new
                IF (Type > 0) AND
                   //GL2024 ("Cross-Reference No." <> '') AND
                   ("Structure Line No." = 0)
                THEN
                    lSalesCrossRefMgt.wUpdateField(Rec, "Line Discount %", FIELDNO("Line Discount %"))
                //  lSalesCrossRefMgt.wUpdateDiscount(Rec);
                //#6428//
            end;
        }

        modify(Amount)
        {
            trigger OnBeforeValidate()
            begin
                //DEVIS
                IF "Line Type" IN ["Line Type"::Totaling, "Line Type"::Structure] THEN
                    ERROR(Text8003911, FIELDCAPTION(Amount), "Line Type");
                //DEVIS//
            end;
        }

        modify("Amount Including VAT")
        {
            trigger OnBeforeValidate()
            begin
                //DEVIS
                //AC-06/06/06 IF "Line Type" IN ["Line Type"::Totaling,"Line Type"::Structure] THEN
                IF "Line Type" IN ["Line Type"::Totaling] THEN
                    ERROR(Text8003911, FIELDCAPTION("Amount Including VAT"), "Line Type");
                //DEVIS//

            end;
        }
        modify("Allow Invoice Disc.")
        {
            trigger OnBeforeValidate()
            begin
                //#9181
                IF ("Line Type" <> "Line Type"::Other) THEN BEGIN
                    //#9181//
                    //#8334
                    IF ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") AND
                       ("Allow Invoice Disc.") THEN BEGIN
                        IF wSalesLineMgt.InvDiscountIsAllowed(Rec, FALSE) = FALSE THEN
                            TESTFIELD("Allow Invoice Disc.", FALSE);
                    END;
                    //#8334//
                    //#9181
                END;
                //#9181//

            end;
        }

        modify("Gross Weight")
        {
            trigger OnBeforeValidate()
            begin
                wCalcQty.wCalcQty(Rec, FIELDNO("Gross Weight"));
            end;
        }
        modify("Net Weight")
        {
            trigger OnBeforeValidate()
            begin
                wCalcQty.wCalcQty(Rec, FIELDNO("Net Weight"));
            end;
        }

        modify("Unit Volume")
        {
            trigger OnBeforeValidate()
            begin
                wCalcQty.wCalcQty(Rec, FIELDNO("Unit Volume"));
            end;
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            begin
                //#7391
                IF (Type = Type::" ") OR ("Structure Line No." <> 0) THEN
                    EXIT;


            end;

            trigger OnafterValidate()
            var
                lStructureMgt: Codeunit "Structure Management";
            begin


                lStructureMgt.UpdateStructureLine(Rec, FIELDNO("Shortcut Dimension 1 Code"), FALSE);
                //#5017//
            end;
        }


        modify("Customer Price Group")
        {
            trigger OnBeforeValidate()
            begin

                IF (Type = Type::Resource) THEN
               //DISC//
               //TARIF
               BEGIN

                    //TARIF//
                    UpdateUnitPrice(FIELDNO("Customer Price Group"));
                    //TARIF
                END;
                //TARIF//


                IF (Type = Type::Item) OR (Type = Type::Resource) THEN
                    "Found Price" := 0;






            end;
        }

        modify("Job No.")
        {
            Description = 'Modif TableRelation + Editable = <Yes>';

            //GL2024  ValidateTableRelation = true;

            TableRelation = if ("Order Type" = filter("Supply Order" | Transfer)) Job where("IC Partner Code" = const())
            else
            if (Type = const("Fixed Asset"),
                                     "Order Type" = const(" ")) Job where("IC Partner Code" = const())
            else
            Job where("IC Partner Code" = const());
            Caption = 'Job No.';
            trigger OnBeforeValidate()
            VAR
                lPurchHead: Record "Purchase Header";
                lJob: Record Job;
                lJobStatus: Record "Job Status";
                lSalesLine: Record "Sales Line";
                lSalesLine2: Record "Sales Line";
            begin
                //TestStatusOpen;
                //PROJET
                lJob.wCheckBlockedJob("Job No.");
                //JOB_STATUS
                IF "Job No." <> '' THEN BEGIN
                    lJobStatus.Check("Job No.", lJobStatus.FIELDNO("Sales Document"));
                    //JOB_STATUS//
                    //PROJET//
                    //DEVIS
                    //TESTFIELD("Drop Shipment",FALSE);
                    //DEVIS//
                    //+JOB+
                    lJob.GET("Job No.");
                    "Job Task No." := lJob.gGetDefaultJobTask();
                    //#6061
                    IF "Job Task No." = '' THEN BEGIN
                        IF lSalesLine2.GET("Document Type", "Document No.", "Structure Line No.") THEN
                            "Job Task No." := lSalesLine2."Job Task No.";
                    END;
                    //#6061//
                END ELSE
                    "Job Task No." := '';
                //+JOB+//

                IF (xRec."Job No." <> "Job No.") AND (Quantity <> 0) AND
                    //DEVIS
                    ("Document Type" <> "Document Type"::Quote) THEN BEGIN
                    //DEVIS//
                    CALCFIELDS("Reserved Qty. (Base)");
                    TESTFIELD("Reserved Qty. (Base)", 0);
                    WhseValidateSourceLine.SalesLineVerifyChange(Rec, xRec);
                END;
                //DEVIS
                IF "Line Type" = "Line Type"::Structure THEN
                    wStructureMgt.UpdateStructureLine(Rec, FIELDNO("Job No."), FALSE);
                GetSalesHeader;
                IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN
                    IF ("Unit Price" = 0) THEN
                        //DEVIS//
                        UpdateUnitPrice(FIELDNO("Job No."));
                //PROJET
                IF "Purchasing Order No." <> '' THEN
                    IF lPurchHead.GET("Purchasing Document Type", "Purchasing Order No.") THEN BEGIN
                        lPurchHead.SetHideValidationDialog(TRUE);
                        lPurchHead.VALIDATE("Job No.", "Job No.");
                        lPurchHead.MODIFY;
                        lPurchHead.SetHideValidationDialog(FALSE);
                    END;
                IF ("Unit Price" <> 0) AND ("Unit Price" <> xRec."Unit Price") THEN
                    //PROJET//
                    VALIDATE("Unit Price");

                //PROJET
                //IF Type IN [Type::"Fixed Asset",Type::"Charge (Item)"] THEN
                //  IF "Job No." <> '' THEN
                //    FIELDERROR(
                //      "Job No.",STRSUBSTNO(Text018,FIELDCAPTION(Type),Type));
                //PROJET//

                //#6334
                /*   {
                   IF CurrFieldNo = 0 THEN BEGIN
IF (Rec."Shortcut Dimension 1 Code" = '') THEN
//#7391
VALIDATE("Shortcut Dimension 1 Code", lJob."Global Dimension 1 Code");
IF ("Shortcut Dimension 2 Code" = '') THEN
VALIDATE("Shortcut Dimension 2 Code", lJob."Global Dimension 2 Code");
END ELSE BEGIN
                   }*/
                //#7391
                IF (Rec."Shortcut Dimension 1 Code" = '') AND ("Line Type" <> "Line Type"::" ")
                  //#7685
                  AND ("Line Type" <> "Line Type"::Totaling)
                  //#7685//
                  THEN BEGIN
                    //#7391//
                    "Shortcut Dimension 1 Code" := lJob."Global Dimension 1 Code";
                END;
                //#7391
                IF ("Shortcut Dimension 2 Code" = '') AND ("Line Type" <> "Line Type"::" ")
                  //#7685
                  AND ("Line Type" <> "Line Type"::Totaling)
                //#7685//
                THEN BEGIN
                    "Shortcut Dimension 2 Code" := lJob."Global Dimension 2 Code";
                END;
                //#7391//
                //END;
                //#6334//

                //#5000
                /*    {DELETE
                    CreateDim(
                      DATABASE::Job,"Job No.",
                      DimMgt.TypeToTableID3(Type),"No.",
                      DATABASE::"Responsibility Center","Responsibility Center");
                    DELETE}*/
                //#5000//

                //SUBCONTRACTOR
                IF ("Vendor No." <> '') AND ("Purchasing Order No." <> '') AND (Subcontracting <> 0) THEN
                    IF PurchLine.GET("Purchasing Document Type", "Purchasing Order No.", "Purchasing Order Line No.") THEN BEGIN
                        PurchLine."Job No." := "Job No.";
                        PurchLine."Job Task No." := "Job Task No.";
                        PurchLine.MODIFY;
                    END;
                //SUBCONTRACTOR//

                //#4126
                lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line Type");
                lSalesLine.SETRANGE("Document Type", "Document Type");
                lSalesLine.SETRANGE("Document No.", "Document No.");
                lSalesLine.SETRANGE("Line Type", 0, 1);
                lSalesLine.SETRANGE(Type, 0);
                lSalesLine.SETRANGE("Attached to Line No.", "Line No.");
                //#5539
                //IF NOT lSalesLine.ISEMPTY THEN BEGIN
                IF NOT lSalesLine.ISEMPTY AND ("Line No." <> 0) THEN BEGIN
                    //#5539//
                    lSalesLine.MODIFYALL("Job No.", "Job No.");
                    lSalesLine.MODIFYALL("Job Task No.", "Job Task No.");
                END;
                //#4126//
                //#5198
                lSalesLine.SETRANGE("Line Type");
                lSalesLine.SETRANGE(Type);
                lSalesLine.SETRANGE("Attached to Line No.");
                lSalesLine.SETRANGE("Structure Line No.", "Line No.");
                //#5539
                //IF NOT lSalesLine.ISEMPTY THEN BEGIN
                IF NOT lSalesLine.ISEMPTY AND ("Line No." <> 0) THEN BEGIN
                    //#5539//
                    lSalesLine.MODIFYALL("Job No.", "Job No.");
                    lSalesLine.MODIFYALL("Job Task No.", "Job Task No.");
                END;
                lSalesLine.RESET;
                //#5198//

            end;
        }






        modify("Profit %")
        {
            trigger OnBeforeValidate()
            begin
                //#5383
                IF ("Structure Line No." <> 0) THEN BEGIN
                    wNavibatSetup.GET;
                    wNavibatSetup.TESTFIELD("Profit Calculation Method",
                            wNavibatSetup."Profit Calculation Method"::"Structure line");
                END;
                //#5383//

            end;
        }





        modify("Prepayment %")
        {
            trigger OnBeforeValidate()
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
                Text045: Label 'cannot be more than %1';
                VATPostingSetup: Record "VAT Posting Setup";
                CannotChangePrepmtAmtDiffVAtPctErr: Label 'You cannot change the prepayment amount because the prepayment invoice has been posted with a different VAT percentage. Please check the settings on the prepayment G/L account.';

            begin
                //+ONE+PREPAYMENT
                //#5110
                IF Option OR ("Assignment Basis" <> 0) OR ("Structure Line No." <> 0) OR ("Line Type" = 0) THEN BEGIN
                    "Prepayment %" := xRec."Prepayment %";
                    EXIT;
                END;
                //#5110//
                //+ONE+PREPAYMENT//

                if ("Prepayment %" <> 0) and (Type <> Type::" ") then begin
                    if not ("Document Type" in ["Document Type"::Order, "Document Type"::Quote]) then
                        FieldError("Document Type");
                    TestField("No.");
                    if CurrFieldNo = FieldNo("Prepayment %") then
                        if "System-Created Entry" and not IsServiceChargeLine() then
                            FieldError("Prepmt. Line Amount", StrSubstNo(Text045, 0));
                    if "System-Created Entry" and not IsServiceChargeLine() then
                        "Prepayment %" := 0;









                    //+ONE+PREPAYMENT
                    GetSalesHeader;
                    //#6783-#6838

                    //SalesHeader.TESTFIELD("No. Prepayment Request Printed",0);
                    IF (lSalesHeader.GET("Document Type", "Document No.")) THEN BEGIN
                        lSalesHeader.TESTFIELD("No. Prepayment Request Printed", 0);
                    END ELSE BEGIN
                        SalesHeader.TESTFIELD("No. Prepayment Request Printed", 0);
                    END;

                    //#6783-#6838//
                    //#5134 : Que les lignes provenant du devis ou d‚ductions
                    IF ("Quote No." = '') AND ("Line Type" <> "Line Type"::Other) AND
                       (SalesHeader."Invoicing Method" = SalesHeader."Invoicing Method"::Completion) THEN BEGIN
                        "Prepayment %" := xRec."Prepayment %";
                        EXIT;
                    END;
                    //#5134//
                    IF "Line Type" = "Line Type"::Totaling THEN BEGIN
                        lPrepaymentMgt.SetSalesLine(Rec);
                        EXIT;
                    END;
                    //+ONE+PREPAYMENT//









                    GenPostingSetup.Get("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                    if GenPostingSetup."Sales Prepayments Account" <> '' then begin
                        GLAcc.Get(GenPostingSetup."Sales Prepayments Account");
                        VATPostingSetup.Get("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                        VATPostingSetup.TestField("VAT Calculation Type", "VAT Calculation Type");
                    end else
                        Clear(VATPostingSetup);
                    if ("Prepayment VAT %" <> 0) and ("Prepayment VAT %" <> VATPostingSetup."VAT %") and ("Prepmt. Amt. Inv." <> 0) then
                        Error(CannotChangePrepmtAmtDiffVAtPctErr);
                    "Prepayment VAT %" := VATPostingSetup."VAT %";
                    "Prepmt. VAT Calc. Type" := VATPostingSetup."VAT Calculation Type";
                    "Prepayment VAT Identifier" := VATPostingSetup."VAT Identifier";
                    if "Prepmt. VAT Calc. Type" in
                       ["Prepmt. VAT Calc. Type"::"Reverse Charge VAT", "Prepmt. VAT Calc. Type"::"Sales Tax"]
                    then
                        "Prepayment VAT %" := 0;
                    "Prepayment Tax Group Code" := GLAcc."Tax Group Code";
                    //#8599



                END ELSE BEGIN
                    IF "Line Type" = "Line Type"::Totaling THEN BEGIN
                        lPrepaymentMgt.SetSalesLine(Rec);
                        EXIT;
                    end;
                    //#8599//
                END;
                //#6241TestStatusOpen;

                //+ONE+PREPAYMENT
                "Prepayment VAT %" := "VAT %";
                "Prepmt. VAT Calc. Type" := "VAT Calculation Type";
                "Prepayment VAT Identifier" := "VAT Identifier";
                //#5613
                //"Prepayment Tax Group Code" := "VAT Prod. Posting Group";
                "Prepayment Tax Group Code" := "Tax Group Code";
                //#5613//

                //+ONE+PREPAYMENT//

                //#8638
                //IF Type <> Type::" " THEN
                //  UpdateAmounts;
                IF (Type <> Type::" ") AND ("Unit Price" <> 0) THEN begin
                    if HasTypeToFillMandatoryFields() then
                        UpdateAmounts;

                end;
                UpdateBaseAmounts2(Amount, "Amount Including VAT", "VAT Base Amount");

            end;

        }

        modify("Prepmt. Line Amount")
        {
            trigger OnBeforeValidate()
            var
                Text044: Label 'cannot be less than %1';
                Text045: Label 'cannot be more than %1';
                Text043: label 'cannot be %1';
            begin

                //+ONE+PREPAYMENT
                //TestStatusOpen;
                //#8634
                //IF Type <> Type::Resource THEN
                //  TestStatusOpen;
                //#8634
                //+ONE+PREPAYMENT//
                TESTFIELD("Line Amount");
                //+ONE+PREPAYMENT
                IF NOT gPrepaymentReversal THEN BEGIN
                    //+ONE+PREPAYMENT//
                    //#5539
                    IF ABS("Prepmt. Line Amount") < ABS("Prepmt. Amt. Inv.") THEN
                        FIELDERROR("Prepmt. Line Amount", STRSUBSTNO(Text044, "Prepmt. Amt. Inv."));
                    IF ABS("Prepmt. Line Amount") > ABS("Line Amount") THEN
                        FIELDERROR("Prepmt. Line Amount", STRSUBSTNO(Text043, "Line Amount"));
                    //#5539//
                    //+ONE+PREPAYMENT
                    IF "System-Created Entry" THEN
                        FIELDERROR("Prepmt. Line Amount", STRSUBSTNO(Text045, 0));

                    //+ONE+PREPAYMENT
                END;
                //#5539//
                //+ONE+PREPAYMENT//
                IF Quantity <> 0 THEN BEGIN
                    //#8197
                    //VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" /
                    //    ("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity) * 100,0.00001))
                    VALIDATE("Prepayment %", "Prepmt. Line Amount" /
                        ("Line Amount" * (Quantity - "Quantity Invoiced") / Quantity) * 100);

                    //#8197//
                END ELSE BEGIN
                    //#8197
                    //VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
                    VALIDATE("Prepayment %", "Prepmt. Line Amount" * 100 / "Line Amount");
                    //#8197//
                END;
            end;
        }




        modify("Job Task No.")
        {
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."),
                                                             Blocked = filter(False));
            Caption = 'Job Task No.';
            trigger OnBeforeValidate()
            var
                lSalesLine: Record "Sales Line";
                lJobTask: Record "Job Task";
            begin
                //+ONE+JOBTASK
                //#5361
                /*    {
                    IF ("Job Task No." <> xRec."Job Task No.") AND
                       ("Document Type" IN ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) THEN
FIELDERROR("Job Task No.", tJobTaskNotEditable);
                    }*/

                //#6063
                IF ("Job Task No." <> xRec."Job Task No.") THEN BEGIN
                    lJobTask.SETRANGE(lJobTask."Job No.", "Job No.");
                    lJobTask.SETRANGE(lJobTask."Job Task No.", "Job Task No.");
                    IF lJobTask.FIND('-') THEN
                        IF lJobTask.Blocked THEN
                            FIELDERROR("Job Task No.", tJobTaskNoIsBlocked);
                END;
                //#6063//

                //#6031
                lSalesLine.SETRANGE("Document Type", "Document Type");
                lSalesLine.SETRANGE("Document No.", "Document No.");
                //#6031//

                //#5361//
                //#5125
                IF CurrFieldNo = FIELDNO("Job Task No.") THEN BEGIN
                    lSalesLine.SETRANGE("Line Type");
                    lSalesLine.SETRANGE(Type);
                    lSalesLine.SETRANGE("Attached to Line No.");
                    lSalesLine.SETRANGE("Structure Line No.", "Line No.");
                    IF NOT lSalesLine.ISEMPTY THEN BEGIN
                        lSalesLine.MODIFYALL("Job No.", "Job No.");
                        lSalesLine.MODIFYALL("Job Task No.", "Job Task No.");
                    END;
                END;
                //#5125//  
                //+ONE+JOBTASK//
            end;
        }


        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';

        }





        modify("Qty. per Unit of Measure")
        {
            Description = '+One ';
            //GL2024 Editable=true;
            trigger OnBeforeValidate()
            var

                tErrQtyPerUnit: Label 'You cannot change %1 if the type of line is the line is item.;FRA=Vous ne pouvez pas modifier %1 si le type de  ligne est %2.';
            begin
                //#6749
                IF NOT ("Line Type" IN ["Line Type"::" ", "Line Type"::Structure]) AND (CurrFieldNo = FIELDNO("Qty. per Unit of Measure")) THEN
                    ERROR(tErrQtyPerUnit,
                      FIELDCAPTION("Qty. per Unit of Measure"), FIELDCAPTION("Line Type"));
                //6749//

                //#4971
                IF CurrFieldNo = FIELDNO("Qty. per Unit of Measure") THEN BEGIN
                    //#7583
                    IF "Line Type" IN ["Line Type"::Machine, "Line Type"::Person] THEN
                        "Unit Cost (LCY)" := "Unit Cost (LCY)" * ("Qty. per Unit of Measure" / xRec."Qty. per Unit of Measure");
                    //#7583//
                    VALIDATE(Quantity);
                END;
                //#4971//
            end;
        }



        modify("Unit of Measure code")
        {
            trigger OnBeforeValidate()
            var
                lCurrFieldNo: Integer;
                lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
            begin
                //PERF
                lCurrFieldNo := CurrFieldNo;
                //PERF
            end;

            trigger OnAfterValidate()
            begin
                //DEVIS
                VALIDATE("Quantity (Base)", ROUND(Quantity * "Qty. per Unit of Measure", 0.00001));
                //    VALIDATE("Unit Cost (LCY)");
                //DEVIS//

                //#6806
                IF CurrFieldNo = FIELDNO("Unit of Measure Code") THEN
                    VALIDATE(Quantity);
                //#6806//
            end;
        }





        modify("Quantity (Base)")
        {
            trigger OnBeforeValidate()
            begin
                //  TESTFIELD("Job Contract Entry No.", 0);
                TestJobPlanningLine();

                //QTYBASE
                //TESTFIELD("Qty. per Unit of Measure",1);
                //VALIDATE(Quantity,"Quantity (Base)");
                //UpdateUnitPrice(FIELDNO("Quantity (Base)"));

                CheckAssocPurchOrder(FIELDCAPTION("Quantity (Base)"));
                IF ("Cross-Ref. Line No." <> 0) AND (xRec."Quantity (Base)" = 0) AND (CurrFieldNo = FIELDNO("Quantity (Base)")) THEN
                    ERROR(ErrorModifyCrossRef);
                IF (xRec."Quantity (Base)" <> "Quantity (Base)") AND (CurrFieldNo = FIELDNO("Quantity (Base)")) THEN
                    wCalcQty.wCalcQty(Rec, FIELDNO("Quantity (Base)"));



                TESTFIELD("Qty. per Unit of Measure");
                if "Quantity (Base)" <> xRec."Quantity (Base)" then
                    PlanPriceCalcByField(FieldNo("Quantity (Base)"));
                //  UpdateUnitPrice(FIELDNO("Quantity (Base)"));
                UpdateUnitPriceByField(FieldNo("Quantity (Base)"));
                IF ("Line Type" <> "Line Type"::Structure) THEN
                    VALIDATE(Quantity, "Quantity (Base)" / "Qty. per Unit of Measure")
                ELSE BEGIN
                    //#7588
                    wNavibatSetup.GET();
                    IF (Quantity <> 0) AND ("Quantity (Base)" <> 0) AND NOT wNavibatSetup."Specific Struct. Price Calcul" THEN
                        "Qty. per Unit of Measure" := "Quantity (Base)" / Quantity;
                    //#7588//
                    VALIDATE(Quantity);
                END;
                //QTYBASE//
            end;
        }



        /* GL2024  modify("Outstanding Qty. (Base)")
           {
               Editable = true;
           }

           modify("Qty. Shipped (Base)")
           {
               Editable = true;
           }
           modify("Qty. Invoiced (Base)")
           {
               Editable = true;
           }
           */

        //GL2024 modify("Cross-Reference No.")
        modify("item Reference No.")
        {
            trigger OnBeforeValidate()
            var

                lxRec: Record "Sales Line";


            begin
                //+ONE+
                lxRec := Rec;
                //+ONE+//
                //DEVIS
                TestStatusOpen;



            end;

            trigger OnAfterValidate()
            begin
                lSalesCrossRefMgt.wValidateCrossRefStructure(Rec, xRec);
            end;
        }






        modify("Purchasing Code")
        {
            trigger OnBeforeValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
                //#4744
                IF (("Document Type" = "Document Type"::Quote)
                     AND ("Structure Line No." <> 0) AND
                         (Subcontracting = Subcontracting::" ")) OR
                         ("Line Type" <> "Line Type"::Item) THEN BEGIN
                    //#5066
                    CASE "Line Type" OF
                        "Line Type"::Item:
                            IF PurchasingCode.GET("Purchasing Code") THEN BEGIN
                                "Drop Shipment" := PurchasingCode."Drop Shipment";
                                "Special Order" := PurchasingCode."Special Order";
                            END;
                        "Line Type"::Structure:
                            IF Subcontracting <> Subcontracting::" " THEN BEGIN
                                lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lSalesLine.SETRANGE("Document Type", "Document Type");
                                lSalesLine.SETRANGE("Document No.", "Document No.");
                                lSalesLine.SETRANGE("Structure Line No.", "Line No.");
                                lSalesLine.SETRANGE(Type, Type::Item);
                                lSalesLine.SETRANGE(Subcontracting, Subcontracting);
                                IF lSalesLine.FINDFIRST THEN BEGIN
                                    lSalesLine.VALIDATE("Purchasing Code", "Purchasing Code");
                                    lSalesLine.MODIFY;
                                END;
                            END;
                    END;
                    //#5066//
                    EXIT;
                END;
                //#4744//
                //DEVIS
                IF xRec."Purchasing Code" <> "Purchasing Code" THEN
                    //DEVIS//
                    //TestStatusOpen;
                    //SUBCONTRACTOR
                    IF ("Vendor No." = '') AND (xRec."Vendor No." = '') AND (Subcontracting = 0) THEN
                        //SUBCONTRACTOR//
                        TESTFIELD(Type, Type::Item);

            end;
        }







        modify("Completely Shipped")
        {
            Description = 'Modif : Editable OUI + Validate';
            //  Editable=true;
            trigger OnBeforeValidate()
            var
                lSalesLine: Record "Sales Line";

            begin
                //SOLDE_CDE
                IF (CurrFieldNo = 0) OR ("Drop Shipment" = TRUE) OR ("Special Order" = TRUE) OR (Quantity = 0) OR
                   ("Completely Shipped" = xRec."Completely Shipped") THEN
                    EXIT;
                GetSalesHeader;
                SalesHeader.TESTFIELD("Invoicing Method", SalesHeader."Invoicing Method"::Direct);
                InitOutstanding;
                InitQtyToShip;
                UpdateWithWarehouseShip;

                IF SalesHeader.Finished THEN BEGIN
                    SalesHeader.Finished := FALSE;
                    SalesHeader.MODIFY;
                END;
                lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SETRANGE("Document Type", "Document Type");
                lSalesLine.SETRANGE("Document No.", "Document No.");
                lSalesLine.SETRANGE("Structure Line No.", 0);
                lSalesLine.SETFILTER("Line No.", '<>%1', "Line No.");
                lSalesLine.SETFILTER(Type, '<>%1', lSalesLine.Type::" ");
                lSalesLine.SETFILTER("Qty. Shipped Not Invoiced", '<>0');
                IF lSalesLine.ISEMPTY THEN BEGIN
                    lSalesLine.SETRANGE("Qty. Shipped Not Invoiced");
                    lSalesLine.SETFILTER("Outstanding Quantity", '<>0');
                    IF lSalesLine.ISEMPTY THEN BEGIN
                        SalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.");
                        SalesHeader.Finished := "Completely Shipped";
                        SalesHeader.MODIFY;
                    END;
                END;
                //SOLDE_CDE//
            end;
        }



        modify("Customer Disc. Group")
        {
            trigger OnBeforeValidate()
            begin
                //DISC
                //IF Type = Type::Item THEN
                IF (Type = Type::Resource) THEN
                    //DISC//

                    UpdateUnitPriceByField(FieldNo("Customer Disc. Group"));
            end;


        }




        field(50000; "Code Etude"; Code[10])
        {
            Description = 'HJ DSFT 29-06-2012';

            trigger OnLookup()
            begin
                // >> HJ DSFT 29-06-2012
                GetCodeEtude;
                // >> HJ DSFT 29-06-2012
            end;

            trigger OnValidate()
            begin
                // >> HJ DSFT 29-06-2012
                GetCodeEtude;
                // >> HJ DSFT 29-06-2012
            end;
        }
        field(50001; "Filtre Article"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';

            trigger OnValidate()
            begin
                // >> HJ DST 02-02-2013
                "Filtre Article" := RecItem.GetItemFilter("Filtre Article");
                Validate("No.", "Filtre Article");
                "Filtre Article" := '';
                // >> HJ DST 02-02-2013
            end;

        }
        field(50005; Synchronise; Boolean)
        {
            Description = 'HJ SORO 13-08-2014';
        }
        field(50006; "Quantité Stock"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));

            Description = 'HJ SORO 13-08-2014';
            Editable = false;

        }
        field(50007; "Type Divers"; Option)
        {
            Description = 'HJ SORO 13-08-2014';
            OptionMembers = " ",Divers,Transport,"Sous Traitance";
        }
        field(50008; Materiel; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50009; "Main Oeuvre Materiel"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50010; "Consommation Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50011; "Transport Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50012; "Sous Traitance Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50013; "Divers Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50014; "Fourniture Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50015; "Main Oeuvre Materiel Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50016; "Materiel Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50017; "Fourniture Et Divers Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50018; "Lubrifiants Petit Entre Detail"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014 : Lubrifiant Et Petit Entretient';
        }
        field(50019; "Sur Model"; Text[100])
        {
            Description = 'HJ SORO 17-09-2014';

            trigger OnValidate()
            begin
                if "No." <> '' then exit;
                if Type <> Type::Item then exit;
                if not Confirm(Text027) then exit;
                RecItem."No." := NoSeriesMgt.GetNextNo('SM', 0D, true);
                RecItem.Validate(Description, "Sur Model");
                RecItem.Validate("Base Unit of Measure", 'PIECE');
                RecItem.Validate("Tree Code", 'SM');
                RecItem.Validate("Inventory Posting Group", 'PR');
                RecItem.Validate("Gen. Prod. Posting Group", 'SM');
                RecItem.Validate("VAT Prod. Posting Group", 'TVA18');
                RecItem.Validate("Purchasing Code", 'SPECIALE');
                RecItem.Statut := 1;
                RecItem.Insert;
                Validate("No.", RecItem."No.");
                Message(Text032, RecItem."No." + ' :: ' + "Sur Model");
            end;
        }
        field(50020; Statut; Option)
        {
            Caption = 'Approval';
            Description = '// DDE D''APPRO';
            OptionCaption = 'Pending,accepted,refused';
            OptionMembers = Ouvert,"Lancé","Partiellement Pris En Charge","Totallement Pris En Charge",Archiver;

            trigger OnValidate()
            var
                RecPurchaseSetup: Record "Purchases & Payables Setup";
                RecItem: Record Item;
                RecSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(50021; "Appliquer BIC"; Boolean)
        {
            Description = 'HJ SORO 20-01-2015';
        }
        field(50022; "Article Lié Au Frais Annexe"; Code[20])
        {
            TableRelation = Item;
        }
        field(50023; "Date Comptabilisation"; Date)
        {
            Description = 'MH SORO 21/08/2015';
        }
        field(50024; "User ID"; Code[40])
        {
            Description = 'MH SORO 21/08/2015';
        }
        field(50025; "Code Prix"; Code[5])
        {
            Description = 'HJ SORO 21-09-2015';
        }
        field(50026; Provenance; Text[20])
        {
            Description = 'RB SORO 19/09/2017';
            TableRelation = "Chargement - Dechargement";
        }
        field(50027; Destination; Text[20])
        {
            Description = 'RB SORO 19/09/2017';
            TableRelation = "Chargement - Dechargement";
        }
        field(50028; Heure; Time)
        {
            Description = 'RB SORO 19/09/2017';
        }
        field(50029; Vehicule; Code[20])
        {
            Description = 'RB SORO 19/09/2017';
            TableRelation = Véhicule;
        }
        field(50030; Chauffeur; Code[20])
        {
            Description = 'RB SORO 19/09/2017';
            TableRelation = "Shipping Agent";
        }
        field(50032; Consommation; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 24-08-2014';
        }
        field(50033; Transport; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50034; "Sous Traitance"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50035; Divers; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50036; "Fourniture Et Divers"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014';
        }
        field(50037; "Lubrifiants Petit Entretient"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 13-08-2014 : Lubrifiant Et Petit Entretient';
        }
        field(50038; "Main Oeuvre Detail"; Decimal)
        {
            Description = 'HJ SORO 31-10-2014';
        }
        field(50039; "Main Oeuvre"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 31-10-2014';
        }
        field(50040; Fournitures; Decimal)
        {
            Description = 'HJ SORO 31-10-2014';
        }
        field(50041; "Prix N°"; Code[20])
        {
            Description = 'HJ SORO 31-10-2014';
        }
        field(50042; Trie; Integer)
        {
        }
        field(50043; UM; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 31-10-2014';
            Editable = false;
        }
        field(50044; IM; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 31-10-2014';
            Editable = false;
        }
        field(50045; "Type Operation"; Option)
        {
            Description = 'HJ SORO 17-01-2018';
            OptionMembers = " ",D,M;

        }
        field(50046; "Coeficient Rapport"; Decimal)
        {
            Description = 'HJ SORO 17-01-2018';
        }
        field(50047; "Stock Total"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No.")));
            Description = 'HJ SORO 13-08-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50048; "Quantité Cmd Non Livré"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("No." = field("No."),
                                                                            "Job No." = field("Job No.")));
            Description = 'HJ SORO 13-08-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50170; "Type article"; Enum "Item Type")
        {
            trigger OnValidate()
            var
            begin

            end;
        }
        field(60003; "Quantité Intiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(60004; "Avenant 1"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            END;
        }
        field(60005; "Type DA"; Option)
        {
            OptionMembers = "Consultation Externe","Consultation Interne";


            // trigger OnValidate()
            // begin
            //     Validate(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            // end;
        }
        field(60006; "Avenant 3"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                Validate(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(60007; "Avenant 4"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                Validate(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(60008; "Montant Initiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(60009; "Prix Unitaire  Initiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(60010; "Avenant 2"; Decimal)
        {
            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            END;
        }

        field(60011; "Quantité Stock Magasin"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                                                       "Location Code" = FIELD("Location Code")));


        }

        field(8001400; Separator; Integer)
        {
        }
        field(8001401; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(8001402; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

            trigger OnValidate()
            begin
                //+REF+LOT
                fCheckSerialNoQty;
                //+REF+LOT//
            end;
        }
        field(8001403; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription Starting Date"));
                //+ABO+//
            end;
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

            trigger OnValidate()
            begin
                //+ABO+
                fSubscrIntegration(FieldNo("Subscription End Date"));
                //+ABO+//
            end;
        }
        field(8001902; "Subscription Posting Date"; Date)
        {
            Caption = 'Subscription Posting Date';
            Editable = false;
        }
        field(8001903; "Contract Base Unit Price"; Decimal)
        {
            Caption = 'Contract Base Unit Price';
        }
        field(8001904; "Contract Budget Date"; Date)
        {
            Caption = 'Contract Budget Date';
            Editable = false;
        }
        field(8001905; "Review Option"; Option)
        {
            Caption = 'Review Option';
            OptionCaption = ' ,Formula';
            OptionMembers = " ",Formula;
        }
        field(8003903; "Scheduler Line No."; Integer)
        {
            Caption = 'Scheduler Line No.';
            Editable = false;
        }
        field(8003904; "Previous Prod. Completion %"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Production Completion Entry"."Completion Difference (%)" where("Order No." = field("Document No."),
                                                                                               "Order Line No." = field("Line No.")));
            Caption = 'Previous  Prod. Completion (%)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003907; "Outstanding Amt Excl VAT(LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Coût total en commande HT (DS)';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
                //#8731
                /*DELETE
                GetSalesHeader;
                Currency2.InitRoundingPrecision;
                IF SalesHeader."Currency Code" <> '' THEN
                  "Outstanding Amt Excl VAT(LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "Outstanding Amt Excl VAT(LCY)",SalesHeader."Currency Factor"),
                      Currency2."Amount Rounding Precision");
                DELETE*/
                //#8731//

            end;
        }
        field(8003908; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Editable = false;
            OptionCaption = ' ,Supply Order,Transfer';
            OptionMembers = " ","Supply Order",Transfer;
        }
        field(8003910; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
            Editable = false;
        }
        field(8003911; "Imported Line"; Boolean)
        {
            Caption = 'Imported Line';
        }
        field(8003912; "Internal Description"; Text[50])
        {
            Caption = 'Internal Description';

            trigger OnValidate()
            begin
                if CurrFieldNo = FieldNo(Description) then
                    if ("No." = '') and not ("Line Type" in ["line type"::" ", "line type"::Totaling]) and ("Structure Line No." = 0) then begin
                        "Attached to Line No." := 0;
                        Validate("Line Type", "line type"::" ");
                    end;
            end;
        }
        field(8003913; "Excel Line No."; Integer)
        {
            Caption = 'Excel Line No.';
        }
        field(8003914; "Unit-Amount Rounding Precision"; Decimal)
        {
            //blankzero = true;
            Caption = 'Unit-Amount Rounding Precision';
            DecimalPlaces = 0 : 9;
            MinValue = 0;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
                if ((xRec."Unit-Amount Rounding Precision" = "Unit-Amount Rounding Precision") and
                   ("Line Type" <> "line type"::Totaling)) or ("Line Type" = "line type"::" ") or
                   ("Structure Line No." <> 0) then
                    exit;

                //#7190
                /*DELETE
                IF "Line Type" = "Line Type"::Totaling THEN BEGIN
                  lSalesLine.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.","Structure Line No.");
                  lSalesLine.SETRANGE("Document Type","Document Type");
                  lSalesLine.SETRANGE("Document No.","Document No.");
                  lSalesLine.SETRANGE("Attached to Line No.","Line No.");
                  lSalesLine.SETRANGE("Structure Line No.",0);
                  IF NOT lSalesLine.ISEMPTY THEN BEGIN
                    lSalesLine.FINDSET(TRUE,FALSE);
                    REPEAT
                      lSalesLine.VALIDATE("Unit-Amount Rounding Precision","Unit-Amount Rounding Precision");
                      lSalesLine.MODIFY;
                    UNTIL lSalesLine.NEXT = 0;
                  END;
                END ELSE BEGIN
                  VALIDATE(Quantity);
                END;
                DELETE//*/
                fUpdateUnitAmountRounding;
                //#7190//

            end;
        }
        field(8003915; "Cross-Ref. Line No."; Integer)
        {
            Caption = 'Cross-Ref. Line No.';
        }
        field(8003916; Marker; Code[20])
        {
            Caption = 'Marker';

            trigger OnValidate()
            begin
                //DEVIS
                if ("Line Type" = "line type"::Totaling) and ("No." = '') then
                    "No." := Marker;
                //DEVIS//
            end;
        }
        field(8003919; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(8003943; "Purchasing Document Type"; Option)
        {
            Caption = 'Purchasing Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8003945; "Purchasing Order No."; Code[20])
        {
            Caption = 'Purchasing Order No.';
            TableRelation = if ("Special Order" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order),
                                                                                            "No." = field("Special Order Purchase No."))
            else
            if ("Drop Shipment" = const(true)) "Purchase Header"."No." where("Document Type" = const(Order),
                                                                                                                                                                 "No." = field("Purchase Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8003946; "Purchasing Order Line No."; Integer)
        {
            Caption = 'Purchasing Order Line No.';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8003947; "Purch. Order Qty (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = lookup("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = field("Purchasing Document Type"),
                                                                                  "Document No." = field("Purchasing Order No."),
                                                                                  "Line No." = field("Purchasing Order Line No.")));
            Caption = 'Purchase Qty (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            FieldClass = FlowField;
        }
        field(8003948; "Purch. Order Receipt Date"; Date)
        {
            CalcFormula = lookup("Purchase Line"."Expected Receipt Date" where("Document Type" = const(Order),
                                                                                "Document No." = field("Purchasing Order No."),
                                                                                "Line No." = field("Purchasing Order Line No.")));
            Caption = 'Purch. Order Expected Receipt Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003949; "Purch. Order Rcpt. Qty (Base)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purch. Rcpt. Line"."Quantity (Base)" where("Sales Order No." = field("Document No."),
                                                                           "Sales Order Line No." = field("Line No.")));
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003950; Option; Boolean)
        {
            Caption = 'Option';

            trigger OnValidate()
            var
                lStructLine: Record "Sales Line";
                lRec: Record "Sales Line";
                lTotalingRec: Record "Sales Line";
                lJobCostAssign: Record "Job Cost Assignment";
                lxRec: Record "Sales Line";
            begin
                //DEVIS
                if "Document Type" <> "document type"::Quote then
                    TestField(Option, false);
                //DEVIS//

                /*
                //#6204
                IF (Subcontracting > 0) AND ("Line Type" <> "Line Type"::Item) THEN
                  TESTFIELD(Subcontracting,0);
                //#6204//
                */

                TestStatusOpen;
                lxRec := Rec;
                TestField("Assignment Basis", "assignment basis"::" ");
                if "Cross-Ref. Line No." <> 0 then
                    FieldError("Item Reference No.", ErrorOptionCrossRef);


                if (Option = xRec.Option) and ("Line No." = xRec."Line No.") then
                    exit;

                //Gestion des exceptions
                if ("Structure Line No." = 0) then begin
                    lJobCostAssign.SetRange("Document Type", "Document Type");
                    lJobCostAssign.SetRange("Document No.", "Document No.");
                    lJobCostAssign.SetRange("Applies-to Doc. Line No.", "Line No.");
                    if not lJobCostAssign.IsEmpty then
                        FieldError(Option, StrSubstNo(ErrorOptionJobCost, "Line Type"));

                    if (Type <> Type::" ") then begin
                        lRec.Reset;
                        lRec.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                        lRec.SetRange("Document Type", "Document Type");
                        lRec.SetRange("Document No.", "Document No.");
                        lRec.SetRange("Structure Line No.", 0);
                        lRec.SetFilter("Global Disc. Amount", '<>0');
                        //#5068
                        lRec.SetRange("Line No.", "Line No.");
                        //#5068//
                        if not lRec.IsEmpty then
                            Error(ErrorGlobalDiscount, "Document Type", "Document No.");
                    end;
                end;

                //gestion sur la ligne à modifier
                if (Type = Type::" ") then begin
                end else begin
                    if Option then begin
                        Validate("Optionnal Quantity", Quantity);
                        Quantity := 0;
                        //#4496
                        "Job Costs (LCY)" := 0;
                        "Job Costs Margin Included" := 0;
                        //#4496//
                    end else begin
                        Quantity := "Optionnal Quantity";
                        "Optionnal Quantity" := 0;
                        Validate(Quantity);
                    end;
                    InitOutstanding;
                    wOverhead.SalesLine(Rec, true, false);
                    if "Line Type" = "line type"::Structure then begin
                        wStructureMgt.UpdateStructureLine(Rec, FieldNo(Option), true);
                        wStructureMgt.SumStructureLines(Rec);
                    end;
                end;

                if "Structure Line No." = 0 then begin
                    wUpdateAttachLine("Document Type", "Document No.", "Attached to Line No.", Option);

                    //option sur la descendance
                    if Modify then;
                    if ("Structure Line No." = 0) then begin
                        Clear(lRec);
                        lRec.Reset;
                        lRec.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                        lRec.SetRange("Document Type", "Document Type");
                        lRec.SetRange("Document No.", "Document No.");
                        lRec.SetRange("Attached to Line No.", "Line No.");
                        lRec.SetRange("Structure Line No.", 0);
                        if not lRec.IsEmpty then begin
                            lRec.FindSet(true, false);
                            repeat
                                if lRec."Line Type" = lRec."line type"::" " then begin
                                    lRec.Option := Option;
                                    lRec.Modify;
                                end else
                                    if lRec."Assignment Basis" = lRec."assignment basis"::" " then begin
                                        lRec.Validate(Option, Option);
                                        lRec.Modify;
                                    end;
                            until lRec.Next = 0;
                            //Mise à jour du parent
                            if ("Line Type" = "line type"::Totaling) then
                                Get("Document Type", "Document No.", "Line No.");
                        end;
                    end;

                    if ("Line Type" = "line type"::Totaling) then
                        wSalesLineMgt.wUpdateTotalLine(Rec)
                    else
                        if ("Line Type" > "line type"::Totaling) then
                            wUpdateLine(Rec, xRec, true);
                end;

            end;
        }
        field(8003951; "Assignment Basis"; Option)
        {
            //blankzero = true;
            Caption = 'Distribution Basis';
            OptionCaption = ' ,Person Quantity,Direct Cost,Cost Price,Estimated Price,Specific';
            OptionMembers = " ","Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;

            trigger OnValidate()
            var
                lStructLine: Record "Sales Line";
                lRec: Record "Sales Line";
                lTextError: label 'You cannot enter %1 on a text line.';
                lxRec: Record "Sales Line";
            begin
                TestField(Option, false);
                TestStatusOpen;
                lxRec := Rec;
                if (CurrFieldNo <> 0) and (Type = Type::" ") then
                    Error(lTextError, FieldCaption("Assignment Basis"));

                if ("Assignment Basis" = "assignment basis"::" ") and (CurrFieldNo <> FieldNo("Assignment Method")) then
                    Validate("Assignment Method", "assignment method"::" ");

                if (("Unit Price" <> 0) or ("Line Amount" <> 0)) and ("Structure Line No." = 0) and (Type <> Type::" ") then
                    Validate("Unit Price", 0);
                if (xRec."Assignment Basis" <> 0) and ("Structure Line No." = 0) and (Type <> Type::" ") then
                    Validate("Fixed Price", false);

                //#5239
                "Job Costs Margin Included" := 0;
                //#5239

                wOverhead.SalesLine(Rec, true, false);

                if "Line Type" = "line type"::Structure then begin
                    wStructureMgt.UpdateStructureLine(Rec, FieldNo("Assignment Basis"), true);
                    wStructureMgt.SumStructureLines(Rec);
                end;
                wUpdateLine(Rec, lxRec, false);

                //Texte étendu
                lRec.Reset;
                lRec.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetRange("Attached to Line No.", "Line No.");
                lRec.SetRange(Type, Type::" ");
                if lRec.Find('-') then
                    repeat
                        lRec."Assignment Basis" := "Assignment Basis";
                        lRec.Modify;
                    until lRec.Next = 0;
            end;
        }
        field(8003952; "Assignment Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionCaption = ' ,All,Totaling,Selection,No Subcontracting,Subcontracting';
            OptionMembers = " ",All,Totaling,Selection,"No Subcontracting",Subcontracting;

            trigger OnValidate()
            var
                lTextNoAssgnt: label 'You must enter a %1.';
                lTextError: label 'You cannot enter %1 on a text line.';
            begin
                if ("Assignment Method" <> "assignment method"::" ") and ("Assignment Basis" = "assignment basis"::" ") then
                    Error(lTextNoAssgnt, FieldCaption("Assignment Basis"));
                if (CurrFieldNo <> 0) and (Type = Type::" ") then
                    Error(lTextError, FieldCaption("Assignment Basis"));

                if ("Assignment Method" <> xRec."Assignment Method") and (xRec."Assignment Method" <> xRec."assignment method"::" ") then begin
                    wDeleteCostJobCostAssgnt;
                    "Job Cost Assignment" := '';
                    "Gen. Prod. Posting Prorata" := '';
                    if ("Assignment Method" = "assignment method"::" ") and (CurrFieldNo = FieldNo("Assignment Method")) then begin
                        Validate("Assignment Basis", "assignment basis"::" ");
                        if "Line Type" = "line type"::Structure then begin
                            wStructureMgt.UpdateStructureLine(Rec, FieldNo("Assignment Basis"), true);
                            wStructureMgt.SumStructureLines(Rec);
                        end;
                    end;
                end;
            end;
        }
        field(8003953; "Job Cost Assignment"; Code[10])
        {
            Caption = 'Job Cost Marked';

            trigger OnValidate()
            begin
                TestField("Assignment Method", "assignment method"::Selection);
            end;
        }
        field(8003954; "Value Option"; Option)
        {
            Caption = 'Mode de calcul';
            OptionCaption = 'Amount,% on Base,% on Result';
            OptionMembers = Amount,"% on Base","% on Result";
        }
        field(8003955; "Rate Amount"; Decimal)
        {
            Caption = 'Rate or Amount';
            Description = 'Taux ou montant de frais ou de remise en fonction du mode de calcul sélectionné';

            trigger OnValidate()
            begin
                //#4567
                if SalesHeader."No." = '' then
                    GetSalesHeader;
                //PREPAYMENT
                if "Quote No." <> '' then
                    //PREPAYMENT//
                    SalesHeader.TestField(Status, SalesHeader.Status::Open)
                //PREPAYMENT
                else
                    SuspendStatusCheck(true);
                //PREPAYMENT//
                //#4567//
                //#4476
                Validate("Unit Price", 0);
                //#4476//
            end;
        }
        field(8003956; "Gen. Prod. Posting Prorata"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Prorata';
            TableRelation = if ("Assignment Basis" = filter(<> " ")) "Gen. Product Posting Group";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                lTextNoAssgnt: label 'You must enter a %1.';
                lTextError: label 'You cannot enter %1 on a text line.';
            begin
                if ("Assignment Method" <> "assignment method"::" ") and ("Assignment Basis" = "assignment basis"::" ") then
                    Error(lTextNoAssgnt, FieldCaption("Assignment Basis"));
                if (CurrFieldNo <> 0) and (Type = Type::" ") then
                    Error(lTextError, FieldCaption("Assignment Basis"));
            end;
        }
        field(8003983; "Amount Excl. VAT (LCY)"; Decimal)
        {
            Caption = 'Amount Excl. VAT (LCY)';

            trigger OnValidate()
            begin
                //Montant net (rem. fact déduite)
                //DEVIS
                //IF SalesHeader."No." <> "Document No." THEN
                GetSalesHeader;
                if (SalesHeader."Order Type" <> SalesHeader."order type"::"Supply Order") and (Quantity <> 0) then
                    if SalesHeader."Prices Including VAT" then begin
                        Validate("Amount Including VAT", "Line Amount" - "Inv. Discount Amount");
                        "Amount Excl. VAT (LCY)" := "VAT Base Amount";
                    end else
                        "Amount Excl. VAT (LCY)" := "Line Amount" - "Inv. Discount Amount";
                if SalesHeader."Currency Code" <> '' then
                    "Amount Excl. VAT (LCY)" :=
                         ROUND(
                         CurrExchRate.ExchangeAmtFCYToLCY(
                         GetDate, SalesHeader."Currency Code",
                         "Amount Excl. VAT (LCY)", SalesHeader."Currency Factor"),
                         Currency."Amount Rounding Precision");
                //DEVIS//
            end;
        }
        field(8003984; "WIP Amount Posted"; Decimal)
        {
            Caption = 'WIP Amount Posted';
        }
        field(8003985; "Global Disc. Amount"; Decimal)
        {
            Caption = 'Global Disc. Amount';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                wOverhead.SalesLine(Rec, false, true);
            end;
        }
        field(8003986; "Vendor Order Address Code"; Code[10])
        {
            Caption = 'Vendor Order Address Code';
            TableRelation = "Order Address".Code where("Vendor No." = field("Vendor No."));
        }
        field(8003991; "Rider Rank"; Integer)
        {
            Caption = 'Rider Rank';
        }
        field(8003992; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
        }
        field(8003996; "Line Type Filter"; Option)
        {
            Caption = 'Line Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account";
        }
        field(8003997; "Order No."; Code[20])
        {
            Editable = false;
        }
        field(8004048; "Number of Resources"; Decimal)
        {
            //blankzero = true;
            Caption = 'Number of Resources';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                TestField(Type, Type::Resource);
                if "Quantity per" <> 0 then
                    Validate("Quantity per")
                else
                    if "Rate Quantity" <> 0 then
                        Validate("Rate Quantity")
                    else
                        Validate("Quantity Fixed");
            end;
        }
        field(8004049; "Rate Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lQtyPer: Decimal;
                lAttachLine: Record "Sales Line";
            begin
                if "Line Type" <> "line type"::Structure then
                    TestField(Type, Type::Resource);
                //#7590
                if ("Rate Quantity" <> 0) then begin
                    if Rate <> 0 then
                        lQtyPer := "Rate Quantity" / Rate
                    else
                        lQtyPer := "Rate Quantity";

                    if ("Attached to Line No." <> 0) and lAttachLine.Get("Document Type", "Document No.", "Attached to Line No.") then
                        if (lAttachLine."Quantity per" <> 0) then
                            lQtyPer := lQtyPer * lAttachLine."Quantity per";

                    if "Optionnal Quantity" <> 0 then
                        "Optionnal Quantity" := lQtyPer
                    else
                        Validate("Quantity per", lQtyPer);
                end;
            end;
        }
        field(8004050; "Line Type"; Option)
        {
            Caption = 'Type de Ligne';
            OptionCaption = '  ,Chapitre,Article,Main d''oeuvre,Matériel,Ouvrage,Compte général,Frais annexes,Autre,Immobilisation';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account","Charge (Item)",Other,"Fixed Asset";

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lTabCode: array[20] of Integer;
            begin
                //DEVIS
                if ("Line Type" = "line type"::Totaling) and ("No." = '') and ("Attached to Line No." <> 0) and (Description <> '') then
                    Error(ErrorAtt);
                /*
                IF (("Line Type" = "Line Type"::Totaling) AND (Level >= 5) AND (xRec."Line Type" = "Line Type"::Totaling)) OR
                   (("Line Type" = "Line Type"::Totaling) AND (Level > 5) AND (xRec."Line Type" <> "Line Type"::Totaling))  THEN
                  ERROR(ErrorLevel);
                */
                if "Line Type" = "line type"::"Charge (Item)" then begin
                    GetSalesHeader;
                    SalesHeader.TestField("Invoicing Method", SalesHeader."invoicing method"::Direct);
                end;
                //DEVIS
                if (xRec."Line Type" <> "Line Type") and not "Imported Line" and ("Line Type" > 0)
                   and (CurrFieldNo = FieldNo("Line Type")) then
                    TestField(Description, '');
                //DEVIS//
                wPresentationMgt.wInsertBetweenExtendedText(Rec, xRec);
                //TestStatusOpen;
                if ("Structure Line No." <> 0) and ("Line Type" = "line type"::Totaling) then
                    FieldError("Line Type", Text8003920);

                //Cas où le lot est transformé en texte ou autre
                if (xRec."Line Type" = "line type"::Totaling) and ("Line Type" <> "line type"::Totaling) then begin
                    SalesLine2.Reset;
                    SalesLine2.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.");
                    SalesLine2.SetRange("Document Type", "Document Type");
                    SalesLine2.SetRange("Document No.", "Document No.");
                    SalesLine2.SetRange("Attached to Line No.", "Line No.");
                    SalesLine2.SetRange("Line Type", "line type"::Totaling, "line type"::"Charge (Item)");
                    if not SalesLine2.IsEmpty then
                        Error(Text8003906);
                    /*DELETE
                      BEGIN
                    //#4785
                    //    IF SalesLine2.FIND('-') THEN
                        SalesLine2.FIND('+');
                    //#4785
                        REPEAT
                          IF (SalesLine2."Line Type" = SalesLine2."Line Type"::" ") AND (SalesLine2."No." = '') THEN BEGIN
                            lSalesLine.COPY(SalesLine2);
                            lSalesLine."Attached to Line No." := 0;
                            lSalesLine.MODIFY;
                            wPresentationMgt.OnDetach(lSalesLine,"Line No.");
                          END ELSE BEGIN

                    //        lSalesLine.COPY(SalesLine2);
                    //        wPresentationMgt.wLeft(lSalesLine,FALSE);
                          END;
                        UNTIL SalesLine2.NEXT(-1) = 0;
                      END;
                    DELETE*/
                end;

                //#4785
                if ("Line Type" = "line type"::" ") and ("No." = '') and ("Structure Line No." = 0) then begin
                    if "Imported Line" then begin
                        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "Document No.");
                        lSalesLine.SetFilter("Presentation Code", '<=%1', "Presentation Code");
                        if lSalesLine.FindLast then begin
                            if (lSalesLine."Line Type" <> lSalesLine."line type"::" ") and (lSalesLine."No." = '') then
                                lSalesLine.SetFilter("Presentation Code", '<%1', "Presentation Code");
                            if lSalesLine.FindLast then begin
                                if ((lSalesLine."Line Type" <> lSalesLine."line type"::" ") and
                                     (lSalesLine."Line No." <> "Line No.")) or
                                     ((lSalesLine."Line Type" = lSalesLine."line type"::" ") and (lSalesLine."No." <> '') and
                                     (lSalesLine."Line No." <> "Line No.")) then
                                    "Attached to Line No." := lSalesLine."Line No."
                                else
                                    "Attached to Line No." := lSalesLine."Attached to Line No.";
                            end;
                            "Presentation Code" := lSalesLine."Presentation Code";
                            "Structure Line No." := lSalesLine."Structure Line No.";
                        end;
                    end else begin
                        wPresentationMgt.wMajTab(Rec, lTabCode);
                        if (Level = 0) then begin
                            if lTabCode[1] = 0 then begin
                                lSalesLine.Reset;
                                lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                                lSalesLine.SetRange("Order Type", "Order Type");
                                lSalesLine.SetRange("Document Type", "Document Type");
                                lSalesLine.SetRange("Document No.", "Document No.");
                                lSalesLine.SetRange("Structure Line No.", 0);
                                if lSalesLine.FindLast then begin
                                    Level := lSalesLine.Level;
                                    wPresentationMgt.wMajTab(lSalesLine, lTabCode);
                                    lTabCode[Level] += 1;
                                    "Presentation Code" := wPresentationMgt.wCreatePresentationCode(lTabCode, Level);
                                    "Attached to Line No." := lSalesLine."Line No.";
                                end;
                            end;
                        end else
                            if (Level <> 1) or (lTabCode[Level] <> 1) then begin
                                lSalesLine.Reset;
                                lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                                lSalesLine.SetRange("Order Type", "Order Type");
                                lSalesLine.SetRange("Document Type", "Document Type");
                                lSalesLine.SetRange("Document No.", "Document No.");
                                lSalesLine.SetRange("Structure Line No.", 0);
                                if lTabCode[Level] > 1 then begin
                                    lTabCode[Level] -= 1;
                                    lSalesLine.SetRange("Presentation Code", wPresentationMgt.wCreatePresentationCode(lTabCode, Level));
                                end else
                                    if (Level > 1) then
                                        lSalesLine.SetRange("Presentation Code", wPresentationMgt.wCreatePresentationCode(lTabCode, Level - 1));
                                lSalesLine.FindFirst;
                                "Presentation Code" := lSalesLine."Presentation Code";
                                "Attached to Line No." := lSalesLine."Line No.";
                                Level := lSalesLine.Level;
                            end;
                    end;
                end;

                /*DELETE
                //gestion des lignes de textes de premier niveau
                IF ("Line Type" ="Line Type"::" ") AND ("Structure Line No." = 0 ) THEN BEGIN
                  lSalesLine.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code");
                  lSalesLine.SETRANGE("Document Type","Document Type");
                  lSalesLine.SETRANGE("Document No.","Document No.");
                  lSalesLine.SETRANGE("Structure Line No.",0);
                  IF "Imported Line" THEN BEGIN
                    lSalesLine.SETFILTER("Presentation Code",'<=%1',"Presentation Code");
                    IF lSalesLine.FIND('+') THEN BEGIN
                      IF lSalesLine."Line Type" <> lSalesLine."Line Type"::" " THEN
                        lSalesLine.SETFILTER("Presentation Code",'<%1',"Presentation Code");
                      IF lSalesLine.FIND('+') THEN BEGIN
                        IF ((lSalesLine."Line Type" <> lSalesLine."Line Type"::" ") AND
                             (lSalesLine."Line No." <> "Line No.")) OR
                             ((lSalesLine."Line Type" = lSalesLine."Line Type"::" ") AND (lSalesLine."No." <> '') AND
                             (lSalesLine."Line No." <> "Line No.")) THEN
                          "Attached to Line No." := lSalesLine."Line No."
                        ELSE
                          "Attached to Line No." := lSalesLine."Attached to Line No.";
                      END;
                      "Presentation Code" := lSalesLine."Presentation Code";
                      "Structure Line No." := lSalesLine."Structure Line No.";
                    END;
                  END ELSE BEGIN
                //    IF (Level > 1) OR ("Line Type" <> "Line Type"::" ") THEN BEGIN
                      IF ("No." = '') AND ("Attached to Line No." <> 0) AND (CurrFieldNo <>  FIELDNO("Line Type")) OR
                         (xRec."Line Type" = "Line Type") THEN
                        lSalesLine.SETFILTER("Presentation Code",'<=%1',"Presentation Code")
                      ELSE
                        lSalesLine.SETFILTER("Presentation Code",'<%1',"Presentation Code");
                      IF lSalesLine.FIND('+') THEN BEGIN
                        IF (lSalesLine."Line Type" <> lSalesLine."Line Type"::" ") OR (lSalesLine."Attached to Line No." <> 0) THEN BEGIN
                          "Presentation Code" := lSalesLine."Presentation Code";
                          IF ((lSalesLine."Line Type" <> lSalesLine."Line Type"::" ") AND
                             (lSalesLine."Line No." <> "Line No.")) OR
                             ((lSalesLine."Line Type" = lSalesLine."Line Type"::" ") AND (lSalesLine."No." <> '') AND
                             (lSalesLine."Line No." <> "Line No.")) THEN
                            "Attached to Line No." := lSalesLine."Line No."
                        ELSE
                            "Attached to Line No." := lSalesLine."Attached to Line No.";
                          "Structure Line No." := lSalesLine."Structure Line No.";
                          IF ("Line Type" = "Line Type"::" ") THEN
                            Level := lSalesLine.Level;
                        END
                        ELSE
                        IF (lSalesLine."Line Type" = lSalesLine."Line Type"::" ") AND (lSalesLine."No." <> '') THEN BEGIN
                          "Attached to Line No." := lSalesLine."Line No.";
                          Level := lSalesLine.Level;
                        END;
                      END;
                //    END;
                  END;
                END;
                DELETE*/
                //#4785//
                case "Line Type" of
                    "line type"::" ", "line type"::Totaling:
                        Validate(Type, Type::" ");
                    "line type"::"G/L Account":
                        Validate(Type, Type::"G/L Account");
                    //PIED_DEVIS
                    //  "Line Type"::Person,"Line Type"::Structure,"Line Type"::Machine:
                    "line type"::Person, "line type"::Structure, "line type"::Machine, "line type"::Other:
                        //PIED_DEVIS//
                        Validate(Type, Type::Resource);
                    "line type"::Item:
                        Validate(Type, Type::Item);
                    "line type"::"Charge (Item)":
                        Validate(Type, Type::"Charge (Item)");
                    "line type"::"Fixed Asset":
                        Validate(Type, Type::"Fixed Asset");
                    else
                        ;
                end;

                if (xRec."Line Type" = xRec."line type"::" ") and ("Structure Line No." = 0) or "Imported Line" then begin
                    if ("No." = '') and ("Attached to Line No." = 0) and ("Line Type" = "line type"::" ") then
                        "No." := '.';
                    // IF "Line Type"<>"Line Type"::"G/L Account" THEN  wPresentationMgt.wNextRecordTextWithNo(Rec);
                    //  wPresentationMgt.wNextRecordTextWithNo(Rec);
                end;

                //DEVIS//

            end;
        }
        field(8004052; "Structure Line No."; Integer)
        {
            Caption = 'Structure Line No.';
        }
        field(8004053; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lStructureLine: Record "Sales Line";
                lStructureLine2: Record "Sales Line";
                lCostTot: Decimal;
                lPriceTot: Decimal;
                lOverhead: Decimal;
                lProfit: Decimal;
                lNumber: Decimal;
                lUnitCost: Decimal;
                lStrQty: Decimal;
                lNbRes: Decimal;
                lRecStrucQty: Decimal;
                lStructQty2: Decimal;
                lxRecStrucQty: Decimal;
                lValidateQty: Boolean;
            begin
                //OUVRAGE
                if ("Line Type" = "line type"::" ") or ("Structure Line No." = 0) then
                    exit;

                if not (CurrFieldNo in [FieldNo("Value 1"), FieldNo("Value 2"),
                                      FieldNo("Value 3"), FieldNo("Value 4"),
                                      FieldNo("Value 5"), FieldNo("Value 6"),
                                      FieldNo("Value 7"), FieldNo("Value 8"),
                                      FieldNo("Value 9"), FieldNo("Value 10"),
                                      FieldNo("Quantity Fixed"), FieldNo("Number of Resources"), 0]) then begin
                    wSalesLineMgt.wInitCalcValue(Rec);
                end;

                if ("Line Type" = "line type"::Structure) and (Type = Type::" ") then begin       //MAJ Qté par du sous-ouvrage éclaté
                                                                                                  //#7078
                    wSalesLineMgt.wValidateStructQtyPer(Rec, xRec);
                    //#7078//
                end else begin
                    if ((xRec.Disable = Rec.Disable) and Rec.Disable) and
                       (CurrFieldNo in [FieldNo("Quantity per"),
                                        FieldNo("Number of Resources"),
                                        FieldNo("Rate Quantity"),
                                        FieldNo("Quantity Fixed")]) then
                        Error(Text8003931, FieldCaption("Quantity per"));

                    if lStructureLine.Get("Document Type", "Document No.", "Structure Line No.") then begin
                        if "Attached to Line No." <> 0 then
                            wSalesLineMgt.wValidateQtyPer(Rec, xRec, lStructureLine, lStructureLine2,
                                                        lStructureLine2.Get("Document Type", "Document No.", "Attached to Line No."))
                        else
                            wSalesLineMgt.wValidateQtyPer(Rec, xRec, lStructureLine, lStructureLine2, false);
                    end;
                end;
                if (xRec."Quantity per" <> "Quantity per") and (CurrFieldNo = FieldNo("Quantity per")) then
                    wCalcQty.wCalcQty(Rec, FieldNo("Quantity per"));
                //OUVRAGE//
            end;
        }
        field(8004054; "Found Price"; Decimal)
        {
            Caption = 'Found Price';
        }
        field(8004055; "Quantity Fixed"; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity Fixed';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if ("Rate Quantity" <> 0) and (Rate <> 0) then
                    Validate("Rate Quantity")
                else
                    Validate("Quantity per");
            end;
        }
        field(8004056; "Presentation Code"; Text[20])
        {
            Caption = 'Presentation Code';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSalesLineBis: Record "Sales Line" temporary;
                lTabCodeNew: array[20] of Integer;
                lTabCode: array[20] of Integer;
                lCode: Text[80];
                i: Integer;
            begin
                //IF ("No." = '') AND ("Line Type" <> "Line Type"::Totaling) THEN
                //  EXIT;
                //mise à jour du sous détail
                if ("Line Type" = "line type"::Structure) then begin
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                    lSalesLine.SetRange("Document Type", "Document Type");
                    lSalesLine.SetRange("Document No.", "Document No.");
                    lSalesLine.SetRange("Structure Line No.", "Line No.");
                    //#4744
                    if not lSalesLine.IsEmpty then
                        //#4744//
                        lSalesLine.ModifyAll("Presentation Code", "Presentation Code", false);
                end;
                //mise à jour du text attaché
                lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                lSalesLine.SetRange("Document Type", "Document Type");
                lSalesLine.SetRange("Document No.", "Document No.");
                lSalesLine.SetRange("Attached to Line No.", "Line No.");
                lSalesLine.SetRange("Structure Line No.", 0);
                lSalesLine.SetRange("Line Type", "line type"::" ");
                lSalesLine.SetRange("No.", '');
                if not lSalesLine.IsEmpty then begin
                    lSalesLine.ModifyAll("Presentation Code", "Presentation Code", false);
                    lSalesLine.ModifyAll(Level, Level, false);
                end;
            end;
        }
        field(8004057; Level; Integer)
        {
            Caption = 'Level';
        }
        field(8004058; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = if (Subcontracting = filter(<> " ")) Vendor where(Subcontractor = const(true))
            else
            Vendor;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSubsetup: Record "Subcontractor Setup";
                lSubCost: Decimal;
                lCurrFieldNo: Integer;
                lxRec: Record "Sales Line";
            begin
                //CDE_INTERNE
                if ("Order Type" = "order type"::"Supply Order") then begin
                    "Unit Cost (LCY)" := wGetDirectCost;
                    exit;
                end;
                //CDE_INTERNE//
                lxRec := Rec;
                if (Subcontracting = Subcontracting::" ") and (xRec.Subcontracting = Subcontracting::" ") then begin
                    if (Type <> Type::" ") and ("No." = '') then
                        exit;
                    TestField(Type, Type::Item);
                    "Vendor Order Address Code" := '';
                end else begin
                    TestField(Option, false);
                    //  TESTFIELD("Assignment Basis","Assignment Basis"::" ");
                    lSubsetup.Get;
                    if "Line Type" = "line type"::Structure then begin
                        lCurrFieldNo := CurrFieldNo;
                        if "Vendor No." <> '' then
                            Validate("Purchasing Code", lSubsetup."Purchasing Code")
                        else
                            Validate("Purchasing Code", '');
                        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "Document No.");
                        lSalesLine.SetRange(Type, Type::Item);
                        lSalesLine.SetFilter("Presentation Code", '%1', "Presentation Code" + '*');
                        lSalesLine.SetRange("Purchasing Order Line No.", 0);
                        lSalesLine.SetFilter(Subcontracting, '<>%1', lSalesLine.Subcontracting::" ");
                        lSalesLine.SetRange(Disable, false);        //PERF
                        if lSalesLine.Find('-') then
                            repeat
                                lSalesLine."Vendor No." := "Vendor No.";
                                lSalesLine."Purchasing Code" := lSubsetup."Purchasing Code";
                                //#6667
                                /*
                                //#4818
                                //        IF lSalesLine.Subcontracting = Subcontracting THEN BEGIN
                                        IF (lSalesLine.Subcontracting = Subcontracting) AND (lSalesLine."Unit Cost (LCY)"=0) THEN BEGIN
                                //#4818
                                */
                                if lSalesLine.Subcontracting = Subcontracting then begin
                                    //#6667//
                                    lSubCost := wFindSubCost(lSalesLine, "No.");
                                    if (lSubCost <> lSalesLine."Unit Cost (LCY)") then
                                        lSalesLine.Validate("Unit Cost (LCY)", lSubCost);
                                end;
                                lSalesLine.Modify;
                            until lSalesLine.Next = 0;
                        wStructureMgt.SumStructureLines(Rec);
                        Modify;
                        if lCurrFieldNo = FieldNo("Vendor No.") then
                            wUpdateLine(Rec, lxRec, false);
                    end else begin
                        if (Type = Type::Item) and (Subcontracting <> Subcontracting::" ") then
                            Validate("Purchasing Code", lSubsetup."Purchasing Code");
                    end;
                    if "Line Type" = "line type"::Totaling then begin
                        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "Document No.");
                        lSalesLine.SetFilter("Presentation Code", '%1', "Presentation Code" + '*');
                        lSalesLine.SetRange("Structure Line No.", 0);
                        lSalesLine.SetFilter("Line Type", '%1|%2', "line type"::Structure, "line type"::Totaling);
                        lSalesLine.SetFilter("Line No.", '<>%1', "Line No.");
                        lSalesLine.SetRange("Purchasing Order Line No.", 0);
                        lSalesLine.SetFilter(Subcontracting, '<>%1', lSalesLine.Subcontracting::" ");
                        if lSalesLine.Find('-') then begin
                            repeat
                                lSalesLine.Validate("Vendor No.", "Vendor No.");
                                lSalesLine.Modify;
                            until lSalesLine.Next = 0;
                            lxRec := Rec;
                            Rec.Find('=');
                            wSalesLineMgt.wUpdateTotalLine(Rec);
                            "Vendor No." := lxRec."Vendor No.";
                        end;
                    end;
                end;
                wUpdateTotalingForSubcontract(Rec);

            end;
        }
        field(8004059; "Total Cost (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Coût direct';
            Editable = false;
        }
        field(8004060; "Supply Order No."; Code[20])
        {
            Caption = 'Supply Order No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "Order Type" = const("Supply Order"),
                                                        "Job No." = field("Job No."));

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSalesLine2: Record "Sales Line";
                i: Integer;
                j: Integer;
            begin
                /*CW
                IF "Structure Line No." <> 0 THEN BEGIN
                  IF lSalesLine.GET("Document Type","Document No.","Structure Line No.") THEN BEGIN
                    IF "Supply Order No." <> '' THEN BEGIN
                      IF STRPOS(lSalesLine."Structure Supply Order No.","Supply Order No.") = 0 THEN BEGIN
                        IF lSalesLine."Structure Supply Order No." <> '' THEN
                          lSalesLine."Structure Supply Order No." += '|';
                        lSalesLine."Structure Supply Order No." += "Supply Order No.";
                        lSalesLine.MODIFY;
                      END;
                    END ELSE
                    IF (xRec."Supply Order No." <> '') AND
                       (STRPOS(lSalesLine."Structure Supply Order No.",xRec."Supply Order No.") <> 0) THEN BEGIN
                      lSalesLine2.SETRANGE("Document Type",lSalesLine."Document Type");
                      lSalesLine2.SETRANGE("Document No.",lSalesLine."Document No.");
                      lSalesLine2.SETRANGE("Structure Line No.",lSalesLine."Line No.");
                      lSalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
                      lSalesLine2.SETRANGE("Supply Order No.",xRec."Supply Order No.");
                      IF lSalesLine2.ISEMPTY THEN BEGIN
                        i := 0;
                        j := 0;
                        IF STRPOS(lSalesLine."Structure Supply Order No.",xRec."Supply Order No.") > 1 THEN
                          i := 1;
                        IF STRPOS(lSalesLine."Structure Supply Order No.",xRec."Supply Order No.") = 1 THEN
                          IF lSalesLine."Structure Supply Order No."[STRLEN(xRec."Supply Order No.") + 1] = '|' THEN
                            j := 1;
                        lSalesLine."Structure Supply Order No." := DELSTR(lSalesLine."Structure Supply Order No.",
                                  STRPOS(lSalesLine."Structure Supply Order No.",xRec."Supply Order No.")-i,
                                  STRLEN(xRec."Supply Order No.")+i+j);
                        lSalesLine.MODIFY;
                      END;
                    END;
                  END;
                END;
                */

            end;
        }
        field(8004061; "Supply Order Line No."; Integer)
        {
            Caption = 'Supply Order Line No.';
            TableRelation = "Sales Line"."Line No." where("Document Type" = const(Order),
                                                           "Document No." = field("Supply Order No."));
        }
        field(8004062; "Theoretical Profit Amount(LCY)"; Decimal)
        {
            Caption = 'Marge étude';
            Editable = false;
        }
        field(8004063; "Overhead Amount (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Overhead Amount (LCY)';
            Editable = false;
        }
        field(8004064; "Fixed Price"; Boolean)
        {
            Caption = 'Prix fixe';

            trigger OnValidate()
            var
                lNavibat: Record NavibatSetup;
                lDetStruct: Record "Sales Line";
                lxRec: Record "Sales Line";
                lSingleInstance: Codeunit "Import SingleInstance2";
                lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
            begin
                //DEVIS
                if "Fixed Price" and ("Profit %" <> 0) then
                    Validate("Profit %", 0);

                if ("Line Type" in ["line type"::Totaling]) and (FieldNo("Fixed Price") = CurrFieldNo) then
                    Error(Text8003911, FieldCaption("Fixed Price"), "Line Type");
                if Type = Type::Item then begin
                    GetItem;
                    Validate("Allow Invoice Disc.", Item."Allow Invoice Disc." and not "Fixed Price");
                end else
                    if not (Type in [Type::"Fixed Asset", Type::"Charge (Item)", Type::" "]) then
                        Validate("Allow Invoice Disc.", not "Fixed Price");
                //DEVIS//

                //PROJET_FG
                if "Fixed Price" <> xRec."Fixed Price" then begin
                    //4590
                    if "Fixed Price" and (CurrFieldNo = FieldNo("Fixed Price")) and ("Line Discount Amount" <> 0) then begin
                        lSingleInstance.wInitCurrency;
                        lSingleInstance.wSetCurrency(Currency, SalesHeader);
                        //#4956
                        if "Unit-Amount Rounding Precision" <> 0 then
                            "Unit Price" := ROUND("Unit Price" * (100 - "Line Discount %") / 100, "Unit-Amount Rounding Precision")
                        else
                            //#4956
                            "Unit Price" := ROUND("Unit Price" * (100 - "Line Discount %") / 100
                                            //#5923                            , Currency."Unit-Amount Rounding Precision");
                                            , Currency."Sales Unit-Amt Round. Prec.");
                        //#5923//
                        Validate("Line Discount Amount", 0);
                        "Line Amount" := "Unit Price" * Quantity;
                    end;
                    //4590//

                    //AVANCEMENT
                    wTestInvoicedQty(FieldNo("Fixed Price"));
                    //AVANCEMENT//
                    //DEVIS
                    if not "Fixed Price" and ("Found Price" <> 0) then
                        UpdateUnitPrice(FieldNo("Fixed Price"));
                    //DEVIS//
                    if not "Fixed Price" and ("Line Discount Amount" <> 0) and ("Found Price" = 0) then begin
                        "Fixed Price" := true;
                        Validate("Line Discount Amount", 0);
                        "Global Disc. Amount" := 0;
                        "Fixed Price" := false;
                    end;
                    if ((CurrFieldNo <> FieldNo("Fixed Price")) or not "Fixed Price") and ("Found Price" = 0) then begin
                        if "Line Type" = "line type"::Structure then begin
                            lNavibat.GET2;
                            if lNavibat."Profit Calculation Method" = lNavibat."profit calculation method"::"Structure line" then begin
                                lDetStruct.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                                lDetStruct.SetRange("Document Type", "Document Type");
                                lDetStruct.SetRange("Document No.", "Document No.");
                                lDetStruct.SetRange("Structure Line No.", "Line No.");
                                if lDetStruct.Find('-') then
                                    repeat
                                        lDetStruct."Fixed Price" := "Fixed Price";
                                        wOverhead.SalesLine(lDetStruct, false, true);
                                        lDetStruct.Modify;
                                    until lDetStruct.Next = 0;
                                wStructureMgt.SumStructureLines(Rec);
                            end else
                                wOverhead.SalesLine(Rec, false, true);
                        end else
                            wOverhead.SalesLine(Rec, false, true);
                    end;
                    if Modify then;
                end;
                //PROJET_FG//
                wCalcAmount(Rec);
                wUpdateLine(Rec, xRec, false);
                //DEVIS
                //#6814
                //IF NOT "Fixed Price" AND ("Cross-Reference No." <> '') THEN
                lSalesCrossRefMgt.wUpdateField(Rec, "Fixed Price", CurrFieldNo);
                //DEVIS//
            end;
        }
        field(8004065; "Optionnal Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Option Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 1"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 2"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 3"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 4"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 5"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 6"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 7"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 8"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 9"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wCalcQty.wCalcQty(Rec, FieldNo("Value 10"));
                if ("Order Type" <> "order type"::"Supply Order") and ("Structure Line No." = 0) then begin
                    if Modify then;
                    //#6768
                    wUpdateTotalingLine(Rec, xRec, false);
                    //wUpdateLine(Rec,xRec,FALSE);
                    //#6768//
                end;
            end;
        }
        field(8004076; Comment; Boolean)
        {
            CalcFormula = exist("Sales Comment Line" where("Document Type" = field("Document Type"),
                                                            "No." = field("Document No."),
                                                            "Document Line No." = field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004077; "Job Costs (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Job Costs (LCY)';
            Editable = false;
        }
        field(8004078; "Amount 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(1, DATABASE::"Sales Line");
            Caption = 'Amount 1';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004079; "Amount 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(2, DATABASE::"Sales Line");
            Caption = 'Amount 2';
            Editable = false;
            // FieldClass = FlowFilter;
        }
        field(8004080; "Amount 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(3, DATABASE::"Sales Line");
            Caption = 'Amount 3';
            Editable = false;
            // FieldClass = FlowFilter;
        }
        field(8004081; "Amount 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(4, DATABASE::"Sales Line");
            Caption = 'Amount 4';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004082; "Amount 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(5, DATABASE::"Sales Line");
            Caption = 'Amount 5';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004083; "Amount 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(6, DATABASE::"Sales Line");
            Caption = 'Amount 6';
            Editable = false;
            // FieldClass = FlowFilter;
        }
        field(8004084; "Amount 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(7, DATABASE::"Sales Line");
            Caption = 'Amount 7';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004085; "Amount 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(8, DATABASE::"Sales Line");
            Caption = 'Amount 8';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004086; "Amount 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(9, DATABASE::"Sales Line");
            Caption = 'Amount 9';
            Editable = false;
            //FieldClass = FlowFilter;
        }
        field(8004087; "Amount 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wCalcAmountM.AmountGetCaptionClass(10, DATABASE::"Sales Line");
            Caption = 'Amount 10';
            Editable = false;
            // FieldClass = FlowFilter;
        }
        field(8004088; "Machine Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Sales Line"."Quantity (Base)" where("Document Type" = field("Document Type"),
                                                                    "Document No." = field("Document No."),
                                                                    "Line Type" = const(Machine),
                                                                    "Structure Line No." = field("Line No."),
                                                                    "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                    Disable = const(false),
                                                                    Option = const(false)));
            Caption = 'Machine Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004089; "Person Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Sales Line"."Quantity (Base)" where("Document Type" = field("Document Type"),
                                                                    "Document No." = field("Document No."),
                                                                    "Line Type" = const(Person),
                                                                    "Structure Line No." = field("Line No."),
                                                                    "Gen. Prod. Posting Group" = field("Gen. Prod Posting Group Filter"),
                                                                    Disable = const(false),
                                                                    Option = const(false)));
            Caption = 'Person Quantity';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //#6079
                wUpdateQtyMO("Person Quantity", FieldNo("Person Quantity"));
                //#6079
            end;
        }
        field(8004090; "Print Option Line"; Option)
        {
            Caption = 'Print Option Line';
            OptionCaption = ' ,Page Skip';
            OptionMembers = " ","Page Skip";
        }
        field(8004091; "Total Cost LCY by Line Type"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Sales Line"."Total Cost (LCY)" where("Document Type" = field("Document Type"),
                                                                     "Document No." = field("Document No."),
                                                                     "Line Type" = field("Line Type Filter"),
                                                                     "Structure Line No." = field("Line No."),
                                                                     Disable = const(false),
                                                                     Option = const(false)));
            Caption = 'Total Cost LCY by Line Type';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004092; "Vendor Ledger Entry No."; Integer)
        {
            Caption = 'Vendor Ledger Entry No.';
        }
        field(8004093; "Print Structure Line"; Boolean)
        {
            Caption = 'Print Structure Line';
        }
        field(8004094; Rate; Decimal)
        {
            //blankzero = true;
            Caption = 'Rate';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
                lSalesLine: Record "Sales Line";
            begin
                //CADENCE
                if "Structure Line No." = 0 then begin
                    TestField("Line Type", "line type"::Structure);
                    wStructureMgt.UpdateStructureLine(Rec, FieldNo(Rate), true);
                    wStructureMgt.SumStructureLines(Rec);
                end else begin
                    if xRec.Rate = 0 then
                        xRec.Rate := 1;
                    if ("Line Type" in ["line type"::Person, "line type"::Machine]) then begin
                        if Rate <> 0 then begin
                            if "Rate Quantity" <> 0 then
                                Validate("Rate Quantity")
                            else
                                Validate("Quantity per");
                        end else begin
                            //#7590
                            //      "Rate Quantity" := 0;
                            if ("Attached to Line No." <> 0) and lSalesLine.Get("Document Type", "Document No.", "Attached to Line No.") then
                                if (lSalesLine."Quantity per" + lSalesLine."Optionnal Quantity") <> 0 then
                                    "Rate Quantity" := "Rate Quantity" / (lSalesLine."Quantity per" + lSalesLine."Optionnal Quantity");
                            //#7590//

                        end;
                        //AC 23/09/05      VALIDATE("Quantity per","Quantity per" / Rate);
                    end else
                        if "Line Type" = "line type"::Structure then
                            //#7590
                            wStructureMgt.UpdateStructureLine(Rec, FieldNo(Rate), true);
                    //#7590//
                end;
                wUpdateDuration(FieldNo(Rate));
                //CADENCE//
                //DEVIS
                lSalesCrossRefMgt.wUpdateField(Rec, Rate, CurrFieldNo);
                //lSalesCrossRefMgt.wUpdateCrossRefRate(Rec);
                //DEVIS//
            end;
        }
        field(8004095; Dummy; Text[30])
        {
            Caption = 'Dummy';
        }
        field(8004096; "Need Qty"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Sales Line"."Quantity (Base)" where("Document Type" = const(Order),
                                                                    "Supply Order No." = field("Document No."),
                                                                    "Supply Order Line No." = field("Line No.")));
            Caption = 'Need Qty';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(8004098; Duration; Decimal)
        {
            //blankzero = true;
            Caption = 'Duration';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                wUpdateDuration(FieldNo(Duration));
            end;
        }
        field(8004099; "Job Costs Margin Included"; Decimal)
        {
            //blankzero = true;
            Caption = 'Job Costs Margin Included';
            Editable = false;
        }
        field(8004101; "Field Filter"; Integer)
        {
            Caption = 'Field Filter';
            //FieldClass = FlowFilter;
        }
        field(8004104; "Need Unit of Measure Code"; Code[10])
        {
            CalcFormula = lookup(Item."Base Unit of Measure" where("No." = field("No.")));
            Caption = 'Need Unit of Measure Code';
            FieldClass = FlowField;
        }
        field(8004106; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionCaption = ' ,Specific,Generic';
            OptionMembers = " ",Specific,Generic;
        }
        field(8004131; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            // FieldClass = FlowFilter;
        }
        field(8004132; "Gen. Prod Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod Posting Group Filter';
            //  FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group" where("Resource Type" = filter(<> " "));
        }
        field(8004134; Subcontracting; Option)
        {
            Caption = 'Subcontracting';
            OptionCaption = ' ,Furniture and Fixing,Fixing';
            OptionMembers = " ","Furniture and Fixing",Fixing;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lLineType: label ' ,Totaling,Item,Person,Machine,Structure,G/L Account';
                lSubcontractingMgt: Codeunit "Subcontracting Management";
                lSubCost: Decimal;
                lxDisable: Boolean;
                lxRec: Record "Sales Line";
            begin
                //#4893
                TestField(Option, false);
                //#4893//
                if ("Line Type" <> "line type"::Structure) and
                   ("Line Type" <> "line type"::Totaling) and
                   ("Structure Line No." = 0) then
                    Error(TextSubcontracting, Format("Line Type"));

                TestStatusOpen;
                lxRec := Rec;

                if (Type <> Type::" ") and ("No." = '') then begin
                    Subcontracting := xRec.Subcontracting;
                    exit;
                end;

                if (xRec.Subcontracting <> xRec.Subcontracting::" ") and (Subcontracting = Subcontracting::" ") and
                //2591   ("Line Type" = "Line Type"::Totaling)
                   ("Vendor No." <> '') then
                    Validate("Vendor No.", '');

                if "Line Type" = "line type"::Totaling then begin
                    lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No."); //PERF
                    lSalesLine.SetRange("Order Type", "Order Type");
                    lSalesLine.SetRange("Document Type", "Document Type");
                    lSalesLine.SetRange("Document No.", "Document No.");
                    lSalesLine.SetFilter("Presentation Code", '%1', "Presentation Code" + '*');
                    lSalesLine.SetRange("Structure Line No.", 0);
                    lSalesLine.SetFilter("Line Type", '%1|%2', "line type"::Totaling, "line type"::Structure);
                    lSalesLine.SetFilter(Level, '>%1', Level);
                    lSalesLine.SetFilter(Subcontracting, '<>%1', Subcontracting);
                    if lSalesLine.Find('-') then
                        repeat
                            if lSalesLine."Line Type" = lSalesLine."line type"::Structure then
                                lSalesLine.Validate(Subcontracting, Subcontracting)
                            else
                                lSalesLine.Subcontracting := Subcontracting;
                            lSalesLine.Modify;
                        until lSalesLine.Next = 0;
                end else begin
                    if xRec.Subcontracting <> Subcontracting then begin
                        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");         //Détail ouvrage
                        lSalesLine.SetRange("Document Type", "Document Type");
                        lSalesLine.SetRange("Document No.", "Document No.");
                        lSalesLine.SetRange("Structure Line No.", "Line No.");
                        lSalesLine.SetFilter("Line Type", '<>%1', "line type"::" ");
                        if lSalesLine.Find('-') then begin
                            repeat
                                lSubcontractingMgt.CheckSubcontractingItem(lSalesLine, Subcontracting, "No.");
                                lxDisable := lSalesLine.Disable;
                                case Subcontracting of
                                    Subcontracting::" ":
                                        begin
                                            if lSalesLine.Type = lSalesLine.Type::Item then begin
                                                if (lSalesLine.Subcontracting <> 0) then
                                                    lSalesLine.Disable := true
                                                else
                                                    lSalesLine.Disable := false;
                                            end else
                                                lSalesLine.Disable := false;
                                            if lSalesLine.Subcontracting <> Subcontracting then
                                                lSalesLine."Total Cost (LCY)" := 0;
                                        end;
                                    Subcontracting::"Furniture and Fixing":
                                        begin
                                            if lSalesLine.Type = lSalesLine.Type::Item then
                                                lSalesLine.Disable := lSalesLine.Subcontracting <> lSalesLine.Subcontracting::"Furniture and Fixing"
                                            else
                                                lSalesLine.Disable := true;
                                            //#4818
                                            /*DELETE
                                                           IF (NOT lSalesLine.Disable AND (lSalesLine."Unit Cost (LCY)" = 0)) OR
                                                              (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") THEN BEGIN
                                                             lSubCost := wFindSubCost(lSalesLine,"No.");
                                                             IF (lSubCost <> lSalesLine."Unit Cost (LCY)") THEN
                                                               lSalesLine."Unit Cost (LCY)" := lSubCost;
                                            DELETE*/
                                            if not lSalesLine.Disable and (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") and
                                              (lSalesLine."Unit Cost (LCY)" = 0) then begin
                                                lSubCost := wFindSubCost(lSalesLine, "No.");
                                                lSalesLine."Unit Cost (LCY)" := lSubCost;
                                                //#4818//
                                            end;
                                        end;
                                    Subcontracting::Fixing:
                                        begin
                                            lSalesLine.Disable := (lSalesLine."Line Type" in [lSalesLine."line type"::Person,
                                                                           lSalesLine."line type"::Machine,
                                                                           lSalesLine."line type"::Structure]) or
                                               ((lSalesLine.Type = lSalesLine.Type::Item) and
                                                (lSalesLine.Subcontracting = lSalesLine.Subcontracting::"Furniture and Fixing"));

                                            //#4818
                                            /*DELETE
                                                           IF NOT lSalesLine.Disable and (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") THEN BEGIN
                                                             lSubCost := wFindSubCost(lSalesLine,"No.");
                                                             IF (lSubCost <> lSalesLine."Unit Cost (LCY)") THEN
                                                               lSalesLine."Unit Cost (LCY)" := lSubCost;
                                            DELETE*/
                                            if not lSalesLine.Disable and (lSalesLine.Subcontracting <> lSalesLine.Subcontracting::" ") and
                                              (lSalesLine."Unit Cost (LCY)" = 0) then begin
                                                lSubCost := wFindSubCost(lSalesLine, "No.");
                                                lSalesLine."Unit Cost (LCY)" := lSubCost;
                                                //#4818//
                                            end;
                                        end;
                                end;
                                if lxDisable <> lSalesLine.Disable then
                                    lSalesLine.Validate(Disable);
                                lSalesLine.Modify;
                            until lSalesLine.Next = 0;
                            if "Line Type" = "line type"::Structure then
                                lSubcontractingMgt.UpdateSubcontractor(Rec);
                            wStructureMgt.SumStructureLines(Rec);
                            Modify;
                            wUpdateLine(Rec, lxRec, true);
                        end;
                    end;
                end;

            end;
        }
        field(8004135; Disable; Boolean)
        {
            Caption = 'Disable';

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
            begin
                //CDE_CESSION
                if "Supply Order No." <> '' then
                    if lSalesHeader.Get("document type"::Order, "Supply Order No.") then
                        if (lSalesHeader."Order Type" = lSalesHeader."order type"::Transfer) then
                            Error(
                              tTransfer,
                              FieldCaption("No."),
                              "Supply Order No.");
                //CDE_CESSION

                if Type = Type::" " then
                    exit;
                if Disable then begin
                    if "Quantity per" <> 0 then begin
                        Validate("Disable Quantity", "Quantity per");
                        Validate("Quantity per", 0);
                    end;
                    Validate(Quantity, 0);
                end;
                if not Disable then begin
                    Validate("Quantity per", "Disable Quantity");
                    Validate("Disable Quantity", 0);
                end;
                wOverhead.SalesLine(Rec, true, false);
            end;
        }
        field(8004136; "Disable Quantity"; Decimal)
        {
            Caption = 'Disable Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(8004137; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
        }
        field(8004138; "Advanced Person Budget (Qty)"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Advanced Job Budget Entry".Quantity where("Line Type" = const(Person),
                                                                          "Document Type" = field("Document Type"),
                                                                          "Document No." = field("Document No."),
                                                                          Date = field("Date Filter"),
                                                                          "Line No." = field("Line No.")));
            Caption = 'Period Planning Quantity';
            DecimalPlaces = 0 : 2;
            FieldClass = FlowField;
        }
        field(8004139; "Non Valued Code"; Code[10])
        {
            Caption = 'Non-Valued Code';
            TableRelation = Code.Code where("Table No" = const(37),
                                             "Field No" = const(8004139));
        }
    }
    keys
    {

        /*GL2024
        key(STG_Key23; "Document Type", "Supply Order No.", "Supply Order Line No.")
        {
            SumIndexFields = "Quantity (Base)", "Outstanding Qty. (Base)";
        }
  
        key(STG_Key24;"Document Type","Document No.","Attached to Line No.","Structure Line No.")
        {
        }
       
        key(STG_Key25;"Resource Group No.","Document Type","Document No.")
        {
        SumIndexFields = "Quantity (Base)";
        }
      
        key(STG_Key26;"Order Type","Document Type","Structure Line No.","Job No.","Job Task No.",Type)
        {
        Enabled = false;
        SumIndexFields = "Amount Excl. VAT (LCY)";
        }
      
        key(STG_Key27;"Order Type","Document Type","Document No.","Presentation Code","Structure Line No.","Job No.")
        {
        SumIndexFields = "Quantity (Base)","Total Cost (LCY)";
        }
       
        key(STG_Key28;"Document Type","Document No.","Structure Line No.","Line No.","Line Type","Assignment Basis",Option,Disable,"Gen. Prod. Posting Group","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code")
        {
        MaintainSQLIndex = false;
        SumIndexFields = Amount,"Amount Including VAT","Line Amount","Global Disc. Amount","Inv. Discount Amount","Job Costs (LCY)","Total Cost (LCY)","Theoretical Profit Amount(LCY)","Quantity (Base)","Overhead Amount (LCY)","Amount Excl. VAT (LCY)";
        }
        
        key(STG_Key29;"Document Type","Document No.","Line Type","Cross-Reference No.","Cross-Ref. Line No.","Structure Line No.",Option)
        {
        MaintainSQLIndex = false;
        SumIndexFields = "Quantity (Base)";
        }
        
        key(STG_Key30;"Job No.","Job Task No.","Document Type","Gen. Prod. Posting Group",Disable,Option,"Line Type","Structure Line No.","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code")
        {
        MaintainSQLIndex = false;
        SumIndexFields = "Prepmt. Line Amount","Prepmt. Amt. Inv.","Amount Excl. VAT (LCY)";
        }
        
        key(STG_Key31;"Job No.","Document Type","Document No.","Presentation Code","Line No.")
        {
        Enabled = false;
        MaintainSIFTIndex = false;
        MaintainSQLIndex = false;
        }

        key(STG_Key32;"Job No.","Document Type","Document No.","Structure Line No.","Gen. Prod. Posting Group",Type,"Presentation Code",Disable,Option,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code")
        {
        MaintainSIFTIndex = false;
        MaintainSQLIndex = false;
        }
        key(STG_Key33; "Job No.", "Job Task No.", "Line Type")
        {
            SumIndexFields = Quantity, "Outstanding Quantity", "Quantity Shipped";
        }*/
        key(STG_Key34; Synchronise)
        {
        }

        key(STG_Key35; "VAT %")
        {
        }
        key(STG_Key36; "Vendor No.")
        {
        }
        key(STG_Key37; "No.")
        {
        }
        key(STG_Key38; "Job No.", "No.")
        {
        }

        key(STG_Key39; "Sell-to Customer No.", "No.")
        {
        }
        key(STG_Key40; "Date Comptabilisation")
        {
        }
        key(STG_Key41; "Code Prix")
        {
        }
    }

    trigger OnBeforeInsert()
    var
    begin
        //COMMIT-LINE
        IF NOT wSingleInstance.wGetIntegrityVerify THEN BEGIN
            GetSalesHeader;
            wRollBackLog.CopyIntegrityVerify(SalesHeader);
        END;
        //COMMIT-LINE//
    end;

    trigger OnAfterInsert()
    var
        lSalesLine: Record "Sales Line";
        lJob: Record Job;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lRecRef: RecordRef;
    begin
        //DEVIS
        //#6926
        IF ("Presentation Code" <> '') THEN BEGIN
            //#7246
            //IF ("Presentation Code" <> '') AND ("Document Type" IN ["Document Type"::Quote,"Document Type"::Order]) THEN
            //#7246//
            //#6926//
            wPresentationMgt.OnInsert(Rec);
        END;
        //DEVIS//

        //#6115
        lRecRef.GETTABLE(Rec);
        lBOQCustMgt.gOnInsert(lRecRef);
        //#6115//


        //TOTAL-LOT
        IF "Line Type" = "Line Type"::Totaling THEN BEGIN
            IF lSalesLine.GET("Document Type", "Document No.", xRec."Attached to Line No.")
               AND (lSalesLine."Line Type" = lSalesLine."Line Type"::Totaling) THEN
                wSalesLineMgt.wUpdateTotalLine(lSalesLine);
        END;
        //TOTAL-LOT

        //CDE_INTERNE
        GetSalesHeader;
        "Order Type" := SalesHeader."Order Type";
        //CDE_INTERNE//


        //PROJET_FACT
        IF (SalesHeader."Job No." <> '') AND ("Job No." = '') THEN BEGIN
            "Job No." := SalesHeader."Job No.";
            //#6334
            IF (lJob.GET(SalesHeader."Job No.")) THEN BEGIN
                IF (Rec."Shortcut Dimension 1 Code" = '') THEN
                    "Shortcut Dimension 1 Code" := lJob."Global Dimension 1 Code";
                IF ("Shortcut Dimension 2 Code" = '') THEN
                    "Shortcut Dimension 2 Code" := lJob."Global Dimension 2 Code";
            END;
            //#6334//

        END;
        //PROJET_FACT//

        //OPTION
        IF ("Attached to Line No." <> 0) AND ("Structure Line No." = 0) THEN BEGIN
            IF ("Line Type" = "Line Type"::" ") AND
               lSalesLine.GET("Document Type", "Document No.", "Attached to Line No.") THEN BEGIN
                Option := lSalesLine.Option;
                "Assignment Basis" := lSalesLine."Assignment Basis";
            END ELSE
                wUpdateAttachLine("Document Type", "Document No.", "Attached to Line No.", FALSE);
        END;
        //OPTION//

        //EXTENDING-TEXT
        IF ("Attached to Line No." <> 0) AND ("Structure Line No." = 0) AND ("Line Type" = "Line Type"::" ") THEN BEGIN
            "Sell-to Customer No." := lSalesLine."Sell-to Customer No.";
            "Bill-to Customer No." := lSalesLine."Bill-to Customer No.";
            "Job No." := lSalesLine."Job No.";
            //#6253
            "Quote No." := lSalesLine."Quote No.";
            //#6253//
        END;
        //EXTENDING-TEXT
    end;


    trigger OnBeforeModify()
    begin
        //     TestStatusOpen;
        //COMMIT-LINE
        IF NOT wSingleInstance.wGetIntegrityVerify THEN BEGIN
            GetSalesHeader;
            IF NOT wRollBackLog.CopyIntegrityVerify(SalesHeader) THEN
                IF NOT FIND('=') THEN
                    EXIT;
        END;
        //COMMIT-LINE//

        //#7774
        IF "Order Date" = 0D THEN
            "Order Date" := WORKDATE;
        //#7774
    end;

    trigger OnAfterModify()
    begin
        //+ABO+
        fSubscrIntegration(0);
        //+ABO+//
    end;



    trigger OnBeforeDelete()
    var
        //GL2024 DocDim: Record 357;
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        // >> HJ 12-10-2018
        //IF SalesHeader.GET("Document Type","Document No.") THEN IF SalesHeader.Approber THEN ERROR(Text050);
        // >> HJ 12-10-2018
        TestStatusOpen;
        //COMMIT-LINE
        IF NOT wSingleInstance.wGetIntegrityVerify THEN BEGIN
            GetSalesHeader;
            IF NOT wRollBackLog.CopyIntegrityVerify(SalesHeader) THEN
                IF NOT FIND('=') THEN
                    EXIT;
        END;
        //COMMIT-LINE//

        //#7678
        IF (("Document Type" = "Document Type"::Order) AND
            (Type = Type::Resource) AND
            ("Line Type" = "Line Type"::Other) AND
            ("Prepmt. Amt. Inv." = "Prepmt. Line Amount")
            //#9182
            AND ("Prepmt. Line Amount" <> 0)
            //#9182//
            ) THEN BEGIN
            ERROR(tErrorDelPrepLineInvoiced, "No.");
        END;
        //#7678//

        //PERF-LOCK
        /* GL2024 DocDim.SETRANGE("Table ID", 37);
        DocDim.SETRANGE("Document Type", "Document Type");
        DocDim.SETRANGE("Document No.", "Document No.");*/
        //PERF-LOCK//

        //DEVIS
        //#5177 TESTFIELD("Quantity Invoiced",0);

        //#6813
        IF Type <> Type::" " THEN
            //#6813//
            lSalesCrossRefMgt.wDeleteCrossRef(Rec);
    end;





    trigger OnAfterDelete()
    var

        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";

    begin
        //+ABO+
        fSubscrIntegration(-1);
        //+ABO+//
        //OUVRAGE
        IF "Line Type" = "Line Type"::Structure THEN
            wStructureMgt.DeleteStructure(Rec);

        //IF NOT wDeleteHeader THEN
        //  wUpdateLine;
        //OUVRAGE//

        //DEVIS
        IF lSalesDocCost.GET("Document Type", "Document No.", lSalesDocCost.Type::Item, "No.", "Line No.", "Purchasing Code") THEN
            lSalesDocCost.DELETE;

        IF ("Presentation Code" <> '') AND ("Structure Line No." = 0) AND NOT wDeleteHeader
           AND (("Line Type" <> "Line Type"::" ") OR ("No." <> '')) THEN BEGIN
            wPresentationMgt.OnDelete(Rec);
            IF GET("Document Type", "Document No.", "Line No.") THEN;
        END;

        lDescriptionLine.SETRANGE("Table ID", DATABASE::"Sales Line");
        lDescriptionLine.SETRANGE("Document Type", "Document Type");
        lDescriptionLine.SETRANGE("Document No.", "Document No.");
        lDescriptionLine.SETRANGE("Document Line No.", "Line No.");
        IF NOT lDescriptionLine.ISEMPTY THEN
            lDescriptionLine.DELETEALL;
        //DEVIS//

        //CDE_INTERNE
        GetSalesHeader;
        IF SalesHeader."Order Type" = SalesHeader."Order Type"::"Supply Order" THEN BEGIN
            lSalesLine.RESET;
            lSalesLine.SETCURRENTKEY("Document Type", "Supply Order No.", "Supply Order Line No.");
            lSalesLine.SETRANGE("Document Type", lSalesLine."Document Type"::Order);
            lSalesLine.SETRANGE("Supply Order No.", "Document No.");
            lSalesLine.SETRANGE("Supply Order Line No.", "Line No.");
            IF NOT lSalesLine.ISEMPTY THEN BEGIN
                lSalesLine.FINDSET;
                REPEAT
                    //#5029
                    IF (lSalesLine."Quantity Invoiced" <> 0) THEN
                        ERROR(Text8003904, lSalesLine."Document No.", lSalesLine."Line No.");

                    lSalesLine2.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
                    lSalesLine2.VALIDATE("Supply Order No.", '');
                    lSalesLine2."Supply Order Line No." := 0;
                    IF lSalesLine2."Structure Line No." = 0 THEN BEGIN
                        lSalesLine2."Outstanding Quantity" := lSalesLine2.Quantity;
                        lSalesLine2."Quantity Shipped" := 0;
                        lSalesLine2."Qty. Shipped Not Invoiced" := 0;
                        lSalesLine2."Qty. to Ship (Base)" := lSalesLine2."Quantity (Base)";
                        //#7117
                        lSalesLine2."Qty. to Ship" := lSalesLine2.Quantity;
                        lSalesLine2."Outstanding Qty. (Base)" := lSalesLine2.Quantity;
                        //#7117//
                        lSalesLine2."Qty. Shipped Not Invd. (Base)" := 0;
                        lSalesLine2."Qty. Shipped (Base)" := 0;
                    END;
                    lSalesLine2.MODIFY;
                //#5029//
                UNTIL lSalesLine.NEXT = 0;
            END;
        END;
        //CDE_INTERNE//

        /* {AC-DELETE
         //#6115
         lRecRef.GETTABLE(Rec);
  lBOQCustMgt.gOndelete(lRecRef, lOkDelete);
  //#6115//
  DELETE-AC}*/

        //FRAIS
        IF "Assignment Basis" <> 0 THEN
            wDeleteCostJobCostAssgnt
        ELSE
            wDeleteJobCostAssgnt("Document Type", "Document No.", "Line No.", 0);
        //FRAIS//
    end;













    procedure fCheckSerialNoQty()
    begin
        //+REF+LOT
        if "Serial No." <> '' then
            if not ("Quantity (Base)" in [-1, 0, 1]) then
                Error(Text8001400, FieldCaption("Quantity (Base)"), FieldCaption("Serial No."));
        //+REF+LOT//
    end;

    procedure wCalcAmount(var pSalesLine: Record "Sales Line")
    var
        lOverhead: Codeunit "Overhead Calculation";
    begin
        if (pSalesLine."Line Type" = pSalesLine."line type"::Totaling) or
           (pSalesLine."Fixed Price") then
            exit;

        GetSalesHeader;
        if (SalesHeader."Order Type" <> SalesHeader."order type"::" ") then
            exit;

        with pSalesLine do
            if ("Line Amount" <> 0) and (Quantity <> 0) then
                "Unit Price" := (("Line Amount" + "Line Discount Amount") / Quantity);
    end;

    procedure wUpdateLine(pRec: Record "Sales Line"; pxRec: Record "Sales Line"; pInit: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        if (pRec.Quantity = 0) and (pxRec.Quantity = 0) and
           (pRec."Quantity (Base)" = 0) and (pxRec."Quantity (Base)" = 0) then
            exit;

        if (xRec.Option = Rec.Option) and (Rec.Option) then
            exit;

        //IF MODIFY THEN;  //Rem. sur MODIFY pour éviter un message sous SQL
        if ("Structure Line No." <> 0) and ("Attached to Line No." = 0) then
            exit;
        if "Order Type" = "order type"::"Supply Order" then
            exit;
        if Level > 1 then begin
            if lSalesLine.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then begin
                    if not pInit then
                        wSalesLineMgt.wUpdateTotalLine2(lSalesLine, pRec, pxRec)
                    else
                        wSalesLineMgt.wUpdateTotalLine(lSalesLine);
                end else
                    if (lSalesLine."Line Type" = lSalesLine."line type"::Structure) then
                        if lSalesLine.Get("Document Type", "Document No.", lSalesLine."Attached to Line No.") then
                            if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then begin
                                if not pInit then
                                    wSalesLineMgt.wUpdateTotalLine2(lSalesLine, pRec, pxRec)
                                else
                                    wSalesLineMgt.wUpdateTotalLine(lSalesLine);
                            end;
            end;
        end
    end;

    procedure fSubscrIntegration(pFieldNo: Integer)
    begin
        //+ABO+
        if gAddOnLicencePermission.HasPermissionABO then
            case pFieldNo of
                0:
                    gSubscrIntegration.LineOnModify(xRec, Rec);
                -1:
                    gSubscrIntegration.LineOnDelete(Rec);
                else
                    //#8948 ajout d'un paramétre
                    gSubscrIntegration.LineOnValidate(xRec, Rec, pFieldNo, not StatusCheckSuspended);
            end;
        //+ABO+//
    end;

    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        case FieldNumber of
            1:
                begin
                    if ((lQtySetup."Value 1 Name" = '') or
                       (lQtySetup."Used in 1" = lQtySetup."used in 1"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 1"));
                    exit('8004050,' + lQtySetup."Value 1 Name");
                end;
            2:
                begin
                    if ((lQtySetup."Value 2 Name" = '') or
                       (lQtySetup."Used in 2" = lQtySetup."used in 2"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 2"));
                    exit('8004050,' + lQtySetup."Value 2 Name");
                end;
            3:
                begin
                    if ((lQtySetup."Value 3 Name" = '') or
                       (lQtySetup."Used in 3" = lQtySetup."used in 3"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 3"));
                    exit('8004050,' + lQtySetup."Value 3 Name");
                end;
            4:
                begin
                    if ((lQtySetup."Value 4 Name" = '') or
                       (lQtySetup."Used in 4" = lQtySetup."used in 4"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 4"));
                    exit('8004050,' + lQtySetup."Value 4 Name");
                end;
            5:
                begin
                    if ((lQtySetup."Value 5 Name" = '') or
                       (lQtySetup."Used in 5" = lQtySetup."used in 5"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 5"));
                    exit('8004050,' + lQtySetup."Value 5 Name");
                end;
            6:
                begin
                    if ((lQtySetup."Value 6 Name" = '') or
                       (lQtySetup."Used in 6" = lQtySetup."used in 6"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 6"));
                    exit('8004050,' + lQtySetup."Value 6 Name");
                end;
            7:
                begin
                    if ((lQtySetup."Value 7 Name" = '') or
                       (lQtySetup."Used in 7" = lQtySetup."used in 7"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 7"));
                    exit('8004050,' + lQtySetup."Value 7 Name");
                end;
            8:
                begin
                    if ((lQtySetup."Value 8 Name" = '') or
                       (lQtySetup."Used in 8" = lQtySetup."used in 8"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 8"));
                    exit('8004050,' + lQtySetup."Value 8 Name");
                end;
            9:
                begin
                    if ((lQtySetup."Value 9 Name" = '') or
                       (lQtySetup."Used in 9" = lQtySetup."used in 9"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 9"));
                    exit('8004050,' + lQtySetup."Value 9 Name");
                end;
            10:
                begin
                    if ((lQtySetup."Value 10 Name" = '') or
                       (lQtySetup."Used in 10" = lQtySetup."used in 10"::Purchases)) then
                        exit('8004050,' + FieldCaption("Value 10"));
                    exit('8004050,' + lQtySetup."Value 10 Name");
                end;
        end;
    end;

    procedure wLookUpNo(var rec: Record "Sales Line"; pxRec: Record "Sales Line"; var pRecordRef: RecordRef; var pMultiple: Boolean; pBelowxrec: Boolean): Boolean
    var
        lStdText: Record "Standard Text";
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lFixedAsset: Record "Fixed Asset";
        lItemCharge: Record "Item Charge";
        lRes: Record Resource;
        lExtendedText: Record "Extended Text Header";
        lOK: Boolean;
        lFormRes: page "Resource List";
        lFormItem: page "Item List";
        lFormGL: page "G/L Account List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //DEVIS
        if xRec."No." <> '' then
            xRec := pxRec;
        CurrFieldNo := FieldNo("No.");
        case Type of
            Type::" ":
                case "Line Type" of
                    "line type"::" ", "line type"::Totaling:
                        begin
                            if ("Line Type" = "line type"::" ") and ("No." <> '') then
                                lStdText.Get("No.");
                            //#6438----------
                            lExtendedText.SetRange("Table Name", lExtendedText."table name"::"Standard Text");
                            lStdText.Reset;
                            if lStdText.Find('-') then begin
                                repeat
                                    lExtendedText.SetRange("No.", lStdText.Code);
                                    case "Document Type" of
                                        "document type"::Quote:
                                            lExtendedText.SetRange("Sales Quote", true);
                                        "document type"::Invoice:
                                            lExtendedText.SetRange("Sales Invoice", true);
                                        "document type"::Order:
                                            lExtendedText.SetRange("Sales Order", true);
                                        "document type"::"Credit Memo":
                                            lExtendedText.SetRange("Sales Credit Memo", true);
                                        "document type"::"Blanket Order":
                                            lExtendedText.SetRange("Sales Blanket Order", true);
                                        "document type"::"Return Order":
                                            lExtendedText.SetRange("Sales Return Order", true);
                                    end;
                                    if not lExtendedText.IsEmpty then
                                        lStdText.Mark(true);
                                until lStdText.Next = 0;
                            end;
                            lStdText.MarkedOnly(true);
                            //#6438-----//
                            if page.RunModal(0, lStdText) = Action::LookupOK then begin
                                lOK := true;
                                Validate("No.", lStdText.Code);
                            end;
                        end;
                    "line type"::Structure:
                        wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Structure, 9, pBelowxrec);
                end;
            Type::"G/L Account":
                begin
                    if "No." <> '' then begin
                        lGLAccount.Get("No.");
                        lFormGL.SetRecord(lGLAccount);
                    end;
                    //SUGG_ACCT
                    lGLAccount.SetRange("Sugg. for Sales Doc.", true);
                    //SUGG_ACCT//
                    lFormGL.SetTableview(lGLAccount);
                    lFormGL.LookupMode(true);
                    if lFormGL.RunModal = Action::LookupOK then begin
                        //#8850
                        /*Delete
                        //#7203
                        //        lFormGL.fSetSelectionFilter(lGLAccount);
                                lFormGL.SetSelection(lGLAccount);
                                lGLAccount.MARKEDONLY(TRUE);
                        */
                        lFormGL.fSetSelectionFilter(lGLAccount);
                        //#8850//
                        lNbre := lGLAccount.COUNTAPPROX;
                        if lNbre = 1 then begin
                            //#7203//
                            lFormGL.GetRecord(lGLAccount);
                            lOK := true;
                            Validate("No.", lGLAccount."No.");
                            //#7203
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lGLAccount.TableCaption) then
                                    exit(false);
                            GetSalesHeader;
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetSalesHeader(SalesHeader);
                            lGetRecord.SetSalesLine(rec);
                            lGetRecord.SetNbEnr(lNbre);
                            lGetRecord.CreateSalesLinesFromAccount(lGLAccount, pBelowxrec);
                            pMultiple := true;
                            lFenetre.Close;
                            lOK := true;
                        end;
                        //#7203//
                    end;
                end;
            Type::Item:
                begin
                    if "No." <> '' then begin
                        lItem.Get("No.");
                        lFormItem.SetRecord(lItem);
                    end;
                    if pRecordRef.Number = Database::Item then
                        lItem.SetFilter("Search Description", CopyStr(pRecordRef.GetFilters, StrPos(pRecordRef.GetFilters, ':') + 1));
                    if "Location Code" <> '' then
                        lItem.SetRange("Location Filter", "Location Code");
                    lItem.SetRange(Subcontracting, 0);
                    lFormItem.SetTableview(lItem);
                    lFormItem.LookupMode(true);
                    if lFormItem.RunModal = Action::LookupOK then begin
                        lFormItem.wSetSelectionFilter(lItem);
                        lNbre := lItem.COUNTAPPROX;
                        if lNbre = 1 then begin
                            lFormItem.GetRecord(lItem);
                            Validate("No.", lItem."No.");
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lItem.TableCaption) then
                                    exit(false);
                            GetSalesHeader;
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetSalesHeader(SalesHeader);
                            lGetRecord.SetSalesLine(rec);
                            //#4434
                            lGetRecord.SetNbEnr(lNbre);
                            //#4434//
                            lGetRecord.CreateSalesLinesFromItem(lItem, pBelowxrec);
                            pMultiple := true;
                            lFenetre.Close;
                        end;
                        lOK := true;
                    end;
                end;
            Type::"Fixed Asset":
                begin
                    if "No." <> '' then
                        lFixedAsset.Get("No.");
                    if page.RunModal(0, lFixedAsset) = Action::LookupOK then begin
                        lOK := true;
                        Validate("No.", lFixedAsset."No.");
                    end;
                end;
            Type::"Charge (Item)":
                begin
                    if "No." <> '' then
                        lItemCharge.Get("No.");
                    if page.RunModal(0, lItemCharge) = Action::LookupOK then begin
                        lOK := true;
                        Validate("No.", lItemCharge."No.");
                    end;
                end;
            Type::Resource:
                case "Line Type" of
                    "line type"::Person:
                        wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Person, lRes.Status::Generic, pBelowxrec);
                    "line type"::Machine:
                        wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Machine, lRes.Status::Generic, pBelowxrec);
                    "line type"::Structure:
                        wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Structure, 9, pBelowxrec);
                    //PIED_DEVIS
                    "line type"::Other:
                        wLookupResource(rec, pRecordRef, pMultiple, lOK, lRes.Type::Other, 9, pBelowxrec);
                    //PIED_DEVIS
                    "line type"::" ":
                        begin
                            if "No." <> '' then
                                lRes.Get("No.");
                            lRes.SetFilter(Type, '%1|%2', lRes.Type::Person, lRes.Type::Machine);
                            if page.RunModal(0, lRes) = Action::LookupOK then begin
                                lOK := true;
                                Validate("No.", lRes."No.");
                            end;
                        end;
                end;
        end;
        exit(lOK);

    end;

    procedure wDeleteSalesHeader(pDeleteHeader: Boolean)
    begin
        //DEVIS
        wDeleteHeader := pDeleteHeader;
        //DEVIS//
    end;

    procedure wUpdateDuration(pFromFieldNo: Integer)
    begin
        //CADENCE
        if "Structure Line No." <> 0 then
            exit;
        case pFromFieldNo of
            FieldNo(Quantity), FieldNo("Quantity (Base)"), FieldNo(Rate):
                if Rate <> 0 then
                    Duration := "Quantity (Base)" / Rate
                else
                    Duration := 0;
            FieldNo(Duration):
                if Duration <> 0 then
                    Validate(Rate, "Quantity (Base)" / Duration)
                else
                    Validate(Rate, 0);
        end;
        //CADENCE//
    end;

    procedure wUpdateGlobalDiscAmount(pGlobalAmount: Decimal)
    var
        lSalesLine: Record "Sales Line";
        lTot: Decimal;
        lGlob: Decimal;
        lDisc: Decimal;
        lLineQty1: Integer;
        lTextError: label 'There is no line to split %1.';
        lQtyMin: Decimal;
        lAmountMax: Decimal;
        lDiff: Decimal;
        lRoundOK: Boolean;
    begin
        //DEVIS
        //#5142
        if pGlobalAmount = 0 then begin
            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetFilter(Type, '<>%1', lSalesLine.Type::" ");
            lSalesLine.SetFilter("Line Discount Amount", '<>0');
            lSalesLine.SetRange("Line Discount %", 0);
            if lSalesLine.FindSet(true, false) then
                repeat
                    lSalesLine."Line Discount %" := 0;
                    lSalesLine."Line Discount Amount" := 0;
                    lSalesLine."Inv. Discount Amount" := 0;
                    lSalesLine."Inv. Disc. Amount to Invoice" := 0;
                    lSalesLine."Global Disc. Amount" := 0;
                    if not lSalesLine."Fixed Price" then begin
                        lSalesLine.Validate(Quantity);
                    end;
                    lSalesLine.Modify;
                until lSalesLine.Next = 0;

            lSalesLine.SetRange(Type);
            lSalesLine.SetRange("Line Type", lSalesLine."line type"::Totaling);
            if lSalesLine.Find('+') then
                repeat
                    wSalesLineMgt.wUpdateTotalLine(lSalesLine);
                until lSalesLine.Next(-1) = 0;

        end else begin
            lTot := 0;
            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            //#5928
            lSalesLine.SetFilter("Line Type", '>%1&<>%2', lSalesLine."line type"::Totaling, lSalesLine."line type"::Other);
            //#5928//
            //#8334
            //#8744
            //lSalesLine.SETRANGE("Allow Invoice Disc.",TRUE)
            if wNavibatSetup."Discount Method Calculation" = wNavibatSetup."discount method calculation"::"Invoice Discount" then
                lSalesLine.SetRange("Allow Invoice Disc.", true)
            else
                lSalesLine.SetRange("Allow Invoice Disc.");
            //#8744//
            //#8334//
            lSalesLine.SetRange(lSalesLine."Assignment Basis", lSalesLine."assignment basis"::" ");
            lSalesLine.SetRange(Option, false);
            lSalesLine.SetRange("Fixed Price", false);
            lSalesLine.SetRange("Line Discount %", 0);
            GetSalesHeader;

            if lSalesLine.FindSet then begin
                lQtyMin := 9999999999999.0;  //valeur defaut
                lAmountMax := -9999999999999.0;
                repeat
                    lTot += lSalesLine.Quantity * lSalesLine."Unit Price";
                    if ((lSalesLine.Quantity < lQtyMin) or
                        ((lSalesLine.Quantity = lQtyMin) and (lSalesLine.Quantity * lSalesLine."Unit Price" > lAmountMax))) and
                       (lSalesLine.Quantity * lSalesLine."Unit Price" > 0) then begin
                        lLineQty1 := lSalesLine."Line No.";
                        lQtyMin := lSalesLine.Quantity;
                        lAmountMax := lSalesLine.Quantity * lSalesLine."Unit Price";
                    end;
                until lSalesLine.Next = 0;
            end;

            if lTot = 0 then
                Error(lTextError, FieldCaption("Global Disc. Amount"));


            if lSalesLine.FindSet(true, false) then begin
                repeat
                    if (lSalesLine.Quantity * lSalesLine."Unit Price" <> 0) then begin
                        lDisc := pGlobalAmount * (lSalesLine.Quantity * lSalesLine."Unit Price") / lTot;

                        lSalesLine.Validate("Line Discount Amount",
                                ROUND(ROUND(lDisc + lDiff, Currency."Amount Rounding Precision" * Abs(lSalesLine.Quantity))
                                      , Currency."Amount Rounding Precision"));
                        lSalesLine."Line Discount %" := 0;

                        lDiff := lDisc - lSalesLine."Line Discount Amount";
                        lGlob += lSalesLine."Line Discount Amount";
                        lSalesLine.Modify;
                    end;
                until lSalesLine.Next = 0;
            end;

            if (lGlob <> pGlobalAmount) and (lLineQty1 <> 0) then begin
                lRoundOK := (ROUND(ROUND(pGlobalAmount - lGlob, Currency."Amount Rounding Precision" * Abs(lQtyMin))
                                   , Currency."Amount Rounding Precision") =
                              ROUND(pGlobalAmount - lGlob, Currency."Amount Rounding Precision"));
                if not lRoundOK then
                    lRoundOK := Confirm(Text8003905, true);
                if lRoundOK then begin
                    lSalesLine.Get("Document Type", "Document No.", lLineQty1);
                    lSalesLine.Validate("Line Discount Amount", lSalesLine."Line Discount Amount" + pGlobalAmount - lGlob);
                    lSalesLine."Line Discount %" := 0;
                    lSalesLine.Modify;
                end;
            end;
        end;
        //#5142//
        //DEVIS//
    end;

    procedure wLookupResource(var rec: Record "Sales Line"; var pRecordRef: RecordRef; var pMultiple: Boolean; var pOK: Boolean; pType: Integer; pStatus: Integer; pBelowxrec: Boolean)
    var
        lRes: Record Resource;
        lFormRes: page "Resource List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
        lFieldRef: FieldRef;
        lErr: label 'The reference %1 does not exist.';
        //DYS page addon non migrer
        // lFormPerson: page 8035107;
        // lFormMachine: page 8035105;
        // lFormStructure: page 8035106;
        lOK: Boolean;
    begin
        lRes.SetCurrentkey(Type, "No.");
        lRes.SetRange(Type, pType);
        if pStatus <> 9 then
            lRes.SetRange(Status, pStatus);
        if not lRes.Find('-') then
            lRes.SetRange(Status);
        if "No." <> '' then begin
            lRes.Get("No.");
            lFormRes.SetRecord(lRes);
        end;
        lFieldRef := pRecordRef.Field(4);
        lRes.SetFilter("Search Name", lFieldRef.GetFilter);
        if "Structure Line No." <> 0 then
            lRes.SetRange(Subcontracting, 0);
        if lRes.IsEmpty then begin
            pOK := false;
            Message(lErr, DelChr(lFieldRef.GetFilter, '=', '*'));
            exit;
        end;

        lFormRes.SetTableview(lRes);
        lFormRes.LookupMode(true);
        //#9081
        //IF lFormRes.RUNMODAL = ACTION::LookupOK THEN BEGIN
        if ISSERVICETIER then begin
            case "Line Type" of
                //DYS
                /*
                     "line type"::Person:
                        lOK := lFormPerson.RunModal = Action::LookupOK;
                    "line type"::Machine:
                        lOK := lFormMachine.RunModal = Action::LookupOK;
                    "line type"::Structure:
                        lOK := lFormStructure.RunModal = Action::LookupOK;
                        */
                "line type"::Other:
                    lOK := lFormRes.RunModal = Action::LookupOK;
                else
                    lOK := lFormRes.RunModal = Action::LookupOK;
            end;
        end else begin
            lOK := lFormRes.RunModal = Action::LookupOK;
        end;
        if lOK then begin
            //#9081//
            lFormRes.wSetSelectionFilter(lRes);
            lNbre := lRes.COUNTAPPROX;
            if lNbre = 1 then begin
                lFormRes.GetRecord(lRes);
                Validate("No.", lRes."No.");
            end
            else begin
                if lNbre > 100 then
                    if not Confirm(TextToMuch, false, lNbre, lRes.Type) then
                        exit;
                GetSalesHeader;
                lFenetre.Open(TextMultiple);
                lGetRecord.SetSalesHeader(SalesHeader);
                lGetRecord.SetSalesLine(rec);
                //#4434
                lGetRecord.SetNbEnr(lNbre);
                //#4434//
                lGetRecord.CreateSalesLinesFromRes(lRes, pBelowxrec);
                pMultiple := true;
                lFenetre.Close;
            end;
            pOK := true;
        end;
    end;

    procedure wInitLocationCode()
    var
        lSalesLine: Record "Sales Line";
    begin
        if "Document No." = '' then
            exit;
        if "Structure Line No." = 0 then begin
            GetSalesHeader;
            if SalesHeader.get("Document Type", "Document No.") then;
            "Location Code" := SalesHeader."Location Code";
        end else
            if "Structure Line No." <> 0 then
                if lSalesLine.Get("Document Type", "Document No.", "Structure Line No.") then
                    "Location Code" := lSalesLine."Location Code";
    end;

    procedure wFindSubCost(pSalesLine: Record "Sales Line"; pStructureNo: Code[20]): Decimal
    var
        lStructureComponent: Record "Structure Component";
        lStructureLine: Record "Sales Line";
        lReqLineTmp: Record "Requisition Line" temporary;
        lSubCost: Decimal;
    begin
        //SUBCONTRACTOR
        if (pSalesLine.Type <> pSalesLine.Type::Item) or
           (pSalesLine.Subcontracting = 0) then
            exit;

        if pStructureNo = '' then begin
            if pSalesLine."Structure Line No." = 0 then
                exit;
            lStructureLine.Get(pSalesLine."Document Type",
                                      pSalesLine."Document No.",
                                      pSalesLine."Structure Line No.");
            pStructureNo := lStructureLine."No.";
        end;
        if pSalesLine."Vendor No." <> '' then
            with lReqLineTmp do begin
                "Purchasing Code" := pSalesLine."Purchasing Code";
                "Action Message" := "action message"::New;
                "Accept Action Message" := true;
                "Sales Document Type" := pSalesLine."Document Type" + 1;
                "Sales Order No." := pSalesLine."Document No.";
                "Sales Order Line No." := pSalesLine."Line No.";
                Type := pSalesLine.Type;
                "No." := pSalesLine."No.";
                "Unit of Measure Code" := pSalesLine."Unit of Measure Code";
                //3252    "Order Date" := WORKDATE;
                GetSalesHeader;
                if pSalesLine."Document Type" in [pSalesLine."document type"::Invoice, pSalesLine."document type"::"Credit Memo"] then
                    "Order Date" := SalesHeader."Posting Date"
                else
                    "Order Date" := SalesHeader."Order Date";
                "Currency Code" := '';
                //PERF    VALIDATE("Vendor No.",pSalesLine."Vendor No.");
                "Vendor No." := pSalesLine."Vendor No.";
                GetDirectCost(FieldNo("Vendor No."));
                if "Direct Unit Cost" <> 0 then
                    lSubCost := "Direct Unit Cost"
                else
                    //2532      lSubCost := pSalesLine."Unit Cost (LCY)";
                    lSubCost := 0;
            end;
        if lSubCost = 0 then begin
            lStructureComponent.SetRange("Parent Structure No.", pStructureNo);
            lStructureComponent.SetRange(Type, lStructureComponent.Type::Item);
            lStructureComponent.SetRange("No.", pSalesLine."No.");
            if not lStructureComponent.IsEmpty then
                if lStructureComponent.FindFirst then
                    lSubCost := lStructureComponent."Subcontracted Unit Cost";
        end;
        if lSubCost = 0 then begin
            if Item."No." <> pSalesLine."No." then
                Item.Get(pSalesLine."No.");
            lSubCost := Item."Standard Cost" * pSalesLine."Qty. per Unit of Measure";
        end;
        exit(lSubCost);
    end;

    procedure wTestInvoicedQty(pCurrFieldNo: Integer)
    begin
        if (CurrFieldNo <> pCurrFieldNo) or ("Document Type" <> "document type"::Order) then
            exit;
        GetSalesHeader;
        if (SalesHeader."Invoicing Method" <> SalesHeader."invoicing method"::Direct) and ("Quantity Invoiced" <> 0) then
            Error(tQtyFact);
        //#7910
        if (SalesHeader."Invoicing Method" <> SalesHeader."invoicing method"::Direct) and ("Quantity Shipped" <> 0) and
           (("Quote No." <> '') or ("Line Type" <> "line type"::Other) or (not "Prepayment Line")) then
            Error(tQtyShip);
        //#7910
    end;

    procedure wGetStructureTranslation()
    begin
        //TRAD
        GetSalesHeader;
        if SalesHeader."Language Code" <> '' then
            //#5107
            //IF CodeTranslation.GET(156,1,"No.",0,SalesHeader."Language Code") THEN BEGIN
            if CodeTranslation.Get(156, 1, "No.", SalesHeader."Language Code", 0) then begin
                //#5107//
                "Internal Description" := Description;
                Description := CodeTranslation.Description;
                //    "Description 2" := CodeTranslation."Description 2";
            end;
        //TRAD//
    end;

    procedure wGetStandardText()
    var
        lSalesLine: Record "Sales Line";
        lLanguageCode: Code[20];
        lLanguage: Record Language;
    begin
        //TRAD
        GetSalesHeader;
        Description := StdTxt.Description;
        Separator := 1;
        //#8421
        /*delete
        IF SalesHeader."Language Code" <> '' THEN
          //#5107
          //IF CodeTranslation.GET(7,1,"No.",0,SalesHeader."Language Code") THEN BEGIN
          IF CodeTranslation.GET(7,1,"No.",SalesHeader."Language Code",0) THEN BEGIN
          //#5107//
        */

        if SalesHeader."Language Code" = '' then
            /* GL2024 Procedure standard dans nav2009 n'existe dans bc24
              lLanguageCode := lLanguage.GetUserLanguage
            else*/
        lLanguageCode := SalesHeader."Language Code";
        if CodeTranslation.Get(Database::"Standard Text", 2, "No.", lLanguageCode) then begin
            //#8421//
            Description := CodeTranslation.Description;
            //    "Description 2" := CodeTranslation."Description 2";
            "Internal Description" := StdTxt.Description;
        end;
        //TRAD//

    end;

    procedure wCalcQuantity(var pSalesLine: Record "Sales Line"; pStructureQty: Decimal)
    var
        lNumberOfRes: Decimal;
        lResource: Record Resource;
    begin
        with pSalesLine do begin
            lNumberOfRes := 1;
            //#7679
            if ("Line Type" in ["line type"::Person, "line type"::Machine]) then begin
                if ("Number of Resources" <> 0) then begin
                    lNumberOfRes := "Number of Resources";
                end else begin
                    // recherche du nombre de ressources, à partir de la table resource
                    case "Line Type" of
                        "line type"::Person:
                            lResource.SetRange(Type, lResource.Type::Person);
                        "line type"::Machine:
                            lResource.SetRange(Type, lResource.Type::Machine);
                    end;
                    lResource.SetRange("No.", pSalesLine."No.");
                    if (not lResource.IsEmpty) then begin
                        lResource.FindFirst;
                        if (lResource."Default Number of Resources" <> 0) then begin
                            "Number of Resources" := lResource."Default Number of Resources";
                            lNumberOfRes := lResource."Default Number of Resources";
                        end;
                    end;
                end;
            end;
            //#7679//
            if pStructureQty <> 0 then begin
                Quantity := ((pStructureQty * "Quantity per") + "Quantity Fixed") * lNumberOfRes;
            end else
                Quantity := 0;

            if Option then begin
                "Optionnal Quantity" := Quantity;
                Quantity := 0;
            end;
        end;
    end;

    procedure wGetDirectCost(): Decimal
    var
        lPurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        lReqLine: Record "Requisition Line";
    begin
        //CDE_INTERNE
        if Type = Type::Item then begin
            GetItem;
            if Item."Item Type" <> 0 then
                exit("Unit Cost (LCY)");
        end;
        GetSalesHeader;
        lReqLine.Init;
        lReqLine."Action Message" := lReqLine."action message"::New;
        lReqLine."Accept Action Message" := true;
        lReqLine."Sales Document Type" := "Document Type" + 1;
        lReqLine."Sales Order No." := "Document No.";
        lReqLine."Sales Order Line No." := "Line No.";
        //3252  lReqLine."Order Date" := WORKDATE;
        if SalesHeader."Document Type" in [SalesHeader."document type"::Invoice, SalesHeader."document type"::"Credit Memo"] then
            lReqLine."Order Date" := SalesHeader."Posting Date"
        else
            lReqLine."Order Date" := SalesHeader."Order Date";
        //#4895
        //lReqLine."Currency Code" := "Currency Code";
        lReqLine.Validate("Currency Code", "Currency Code");
        //#4895//
        lReqLine.Type := Type;
        lReqLine."No." := "No.";
        lReqLine.Quantity := Quantity;
        lReqLine."Location Code" := "Location Code";
        lReqLine."Variant Code" := "Variant Code";
        lReqLine."Unit of Measure Code" := "Unit of Measure Code";
        lReqLine."Vendor No." := "Vendor No.";
        lReqLine.GetDirectCost(FieldNo("Vendor No."));
        lReqLine.Validate(Quantity);
        if lReqLine."Direct Unit Cost" = 0 then
            lReqLine."Direct Unit Cost" := Item."Unit Cost";
        //#7478
        //lReqLine."Direct Unit Cost" := lReqLine."Direct Unit Cost" * "Qty. per Unit of Measure";
        lReqLine."Direct Unit Cost" := lReqLine."Direct Unit Cost" * "Qty. per Unit of Measure" *
                                       (1 - (lReqLine."Line Discount %" / 100));
        //#7478//
        exit(lReqLine."Direct Unit Cost");
        //CDE_INTERNE//
    end;

    procedure wShowJobCostAssgnt()
    var
    //DYS page addon non migrer
    // lJobCostAssgnts: page 8003957;
    begin
        TestField("Assignment Method", "assignment method"::Selection);
        Commit;
        //DYS
        // lJobCostAssgnts.Initialize(Rec);
        // lJobCostAssgnts.LookupMode := true;
        // lJobCostAssgnts.RunModal;
    end;

    procedure wDeleteJobCostAssgnt(pDocType: Option; pDocNo: Code[20]; pDocLineNo: Integer; pJobCostLineNo: Integer)
    var
        lJobCostAssgnt: Record "Job Cost Assignment";
    begin
        lJobCostAssgnt.SetRange("Document Type", pDocType);
        lJobCostAssgnt.SetRange("Document No.", pDocNo);
        if pJobCostLineNo <> 0 then
            lJobCostAssgnt.SetRange("Document Line No.", pJobCostLineNo);
        if pDocLineNo <> 0 then
            lJobCostAssgnt.SetRange("Applies-to Doc. Line No.", pDocLineNo);

        if not lJobCostAssgnt.IsEmpty then
            lJobCostAssgnt.DeleteAll;
    end;

    procedure wDeleteCostJobCostAssgnt()
    var
        lJobCostAssgnt: Record "Job Cost Assignment";
    begin
        lJobCostAssgnt.Reset;
        lJobCostAssgnt.SetRange("Document Type", "Document Type");
        lJobCostAssgnt.SetRange("Document No.", "Document No.");
        lJobCostAssgnt.SetRange("Document Line No.", "Line No.");
        if lJobCostAssgnt.Find('-') then
            lJobCostAssgnt.DeleteAll;
    end;

    procedure wUpdateTotalingForSubcontract(pRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lVendor: Code[20];
        lSubcontracting: Boolean;
    begin
        //2591 : RAZ "Vendor No.", Subcontracting sur les lignes de lot dont les ouvrage ont des valeurs différentes

        with pRec do begin
            if ("Vendor No." = xRec."Vendor No.") or (Level = 1) or
               ((Subcontracting = Subcontracting::" ") and (xRec.Subcontracting = xRec.Subcontracting::" ")) then
                exit;
            lVendor := "Vendor No.";
            if Subcontracting = Subcontracting::" " then
                lSubcontracting := true;
            if "Line Type" <> "line type"::Totaling then begin      //Lot de la ligne
                if not pRec.Get("Document Type", "Document No.", "Attached to Line No.") then
                    exit;
                if pRec."Vendor No." <> lVendor then
                    "Vendor No." := '';
                if lSubcontracting then
                    pRec.Subcontracting := pRec.Subcontracting::" ";
                Modify;
                if Level = 1 then
                    exit;
            end;
            lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No."); //PERF
            lSalesLine.SetRange("Order Type", "Order Type");
            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            lSalesLine.SetFilter("Presentation Code", '%1',
                  CopyStr("Presentation Code", 1, StrPos("Presentation Code", '.') - 1) + '*');
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Line Type", "line type"::Totaling);
            lSalesLine.SetFilter(Level, '<%1', Level);
            lSalesLine.SetFilter(Subcontracting, '<>0');

            if not lSalesLine.IsEmpty then begin
                lSalesLine.Find('-');
                repeat
                    if lSalesLine."Vendor No." <> lVendor then begin
                        lSalesLine."Vendor No." := '';
                        if lSubcontracting then
                            lSalesLine.Subcontracting := lSalesLine.Subcontracting::" ";
                        lSalesLine.Modify;
                    end;
                until lSalesLine.Next = 0;
            end;
        end;
        //2591//
    end;

    procedure wUpdateAttachLine(var pDocumentType: Option; var pDocumentNo: Code[20]; var pAttachLine: Integer; pOption: Boolean)
    var
        lTotalingRec: Record "Sales Line";
        lRec: Record "Sales Line";
    begin
        if (pAttachLine = 0) then
            exit;
        GetSalesHeader;
        if lTotalingRec.Get(pDocumentType, pDocumentNo, pAttachLine) then begin
            if (lTotalingRec.Option = pOption) then
                exit;
            if (lTotalingRec.Type <> lTotalingRec.Type::" ") then begin
                lTotalingRec.Validate(Option, pOption);
                lTotalingRec.Get(pDocumentType, pDocumentNo, pAttachLine);
            end else
                lTotalingRec.Option := false;
            lTotalingRec.Modify;
            lRec.Reset;
            lRec.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
            lRec.SetRange("Document Type", lTotalingRec."Document Type");
            lRec.SetRange("Document No.", lTotalingRec."Document No.");
            lRec.SetRange("Attached to Line No.", lTotalingRec."Line No.");
            lRec.SetRange("Structure Line No.", 0);
            lRec.SetRange(Type, Type::" ");
            lRec.SetRange("Line Type", "line type"::" ");
            lRec.ModifyAll(Option, lTotalingRec.Option);
        end;

        wUpdateAttachLine(pDocumentType, pDocumentNo, lTotalingRec."Attached to Line No.", pOption);
    end;

    procedure wSetUpdateQty(xQtyPer: Decimal; xQtyFixed: Decimal)
    begin
        wxQtyPer := xQtyPer;
        wxQtyFixed := xQtyFixed;
    end;

    procedure wGetLastCurrNo(pDocType: Option; pDocNo: Code[20]; pInc: Integer) LineNo: Integer
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.SetRange("Document Type", pDocType);
        lSalesLine.SetRange("Document No.", pDocNo);
        if lSalesLine.IsEmpty then
            exit(pInc);
        lSalesLine.FindLast;
        exit(lSalesLine."Line No." + pInc);
    end;

    procedure wSetwConfirmDeleteTot(pValue: Boolean)
    begin
        wConfirmDeleteTot := pValue;
        wDeleteHeader := wConfirmDeleteTot;
    end;

    procedure wDeleteAllSalesLine(pDocumentType: Option; pDocumentNo: Code[20])
    begin
        SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        SetRange("Document Type", pDocumentType);
        SetRange("Document No.", pDocumentNo);
        SetRange("Attached to Line No.", 0);
        SetRange("Structure Line No.", 0);
        if not IsEmpty then begin
            Find('-');
            repeat
                wDeleteHeader := true;
                Delete(true);
            until Next = 0;
        end;
    end;

    procedure fPrepaymentReversal(pBoolean: Boolean)
    begin
        //+ONE+PREPAYMENT
        gPrepaymentReversal := pBoolean;
        //+ONE+PREPAYMENT//
    end;

    procedure wUndoTrackingTransfer(pSalesLine: Record "Sales Line")
    var
        lFromReservationEntry: Record "Reservation Entry";
        lToReservationEntry: Record "Reservation Entry";
    begin
        with pSalesLine do begin
            if "Order Type" <> "order type"::"Supply Order" then
                exit;


            lFromReservationEntry.SetCurrentkey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
                   "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
            lFromReservationEntry.SetRange("Source Type", Database::"Sales Line");
            lFromReservationEntry.SetRange("Source Subtype", "document type"::Order);
            lFromReservationEntry.SetRange("Source ID", "Document No.");
            lFromReservationEntry.SetRange("Source Ref. No.", "Line No.");
            if lFromReservationEntry.IsEmpty then
                exit;

        end;
    end;

    procedure fMemoPad(): Boolean
    var
        lRec: Record "Sales Line";
        lRecordRef: RecordRef;
        lMemoPad: Codeunit "MemoPad Management";
    begin
        //+REF+MEMOPAD
        //+ONE+MEMOPAD
        //IF "Attached to Line No." = 0 THEN
        if ("Attached to Line No." = 0) or ("No." <> '') or ("Line Type" <> 0) then
            //+ONE+MEMOPAD//
            lRec := Rec
        else
            lRec.Get("Document Type", "Document No.", "Attached to Line No.");

        with lRec do begin
            //+ONE+MEMOPAD
            SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
            SetRange("No.", '');
            SetRange("Presentation Code", "Presentation Code");
            SetRange(Level, Level);
            SetRange("Order Type", "Order Type");
            SetRange("Structure Line No.", "Structure Line No.");
            SetRange("Job No.", "Job No.");
            //#6253
            if "Quote No." <> '' then
                SetRange("Quote No.", "Quote No.")
            else
                SetRange("Quote No.");
            //#6253//

            //+ONE+MEMOPAD//

            SetRange("Document Type", "Document Type");
            SetRange("Document No.", "Document No.");
            SetRange("Attached to Line No.", "Line No.");
        end;
        lRecordRef.GetTable(lRec);
        exit(lMemoPad.Edit(lRecordRef, ''));
        //+REF+MEMOPAD//
    end;

    procedure wUpdateQtyMO(pValue: Decimal; pFieldNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        tNoPerson: label 'There is no person in this structure';
        tMoreOnePersone: label 'It''s impossible to modify this strcture beacause you are configure more one person.';
        lnbres: Decimal;
        lxRec: Record "Sales Line";
        lQty: Decimal;
    begin
        if "Line Type" <> "line type"::Structure then
            exit;
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "Document No.");
        lSalesLine.SetRange("Structure Line No.", "Line No.");
        lSalesLine.SetRange("Line Type", "line type"::Person);
        lSalesLine.SetRange(Option, false);
        lSalesLine.SetRange(Disable, false);
        if lSalesLine.IsEmpty then
            Error(tNoPerson);
        if (lSalesLine.COUNTAPPROX > 1) then
            Error(tMoreOnePersone);
        lSalesLine.FindFirst;
        case pFieldNo of
            FieldNo("Person Quantity"):
                lQty := pValue;
            else
                lQty := pValue * Quantity;
        end;

        lxRec := lSalesLine;
        lSalesLine."Quantity (Base)" := lQty;

        if lSalesLine."Qty. per Unit of Measure" <> 0 then
            lSalesLine.Quantity := lQty / lSalesLine."Qty. per Unit of Measure"
        else
            lSalesLine.Quantity := lQty;

        wSalesLineMgt.UpdateQtyPer(lSalesLine, lxRec, FieldNo("Quantity (Base)"));

        wOverhead.SalesLine(lSalesLine, true, true);
        lSalesLine.Modify;

        lStructureMgt.SumStructureLines(Rec);
        Modify;

        if "Attached to Line No." <> 0 then begin
            lSalesLine.Reset;
            lSalesLine.Get("Document Type", "Document No.", "Attached to Line No.");
            wSalesLineMgt.wUpdateTotalLine(lSalesLine);
        end;
    end;

    procedure gCompletelyShipped()
    var
        lSalesLine: Record "Sales Line";
    begin
        GetSalesHeader();
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "Document No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetFilter("Line No.", '<>%1', "Line No.");
        lSalesLine.SetFilter(Type, '<>%1', lSalesLine.Type::" ");
        lSalesLine.SetFilter("Qty. Shipped Not Invoiced", '<>0');
        if lSalesLine.IsEmpty then begin
            lSalesLine.SetRange("Qty. Shipped Not Invoiced");
            lSalesLine.SetFilter("Outstanding Quantity", '<>0');
            if lSalesLine.IsEmpty then begin
                SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.");
                SalesHeader.Finished := "Completely Shipped";
                SalesHeader.Modify;
            end;
        end;
    end;

    procedure fSetCompletelyShippedHeader()
    var
        lSalesLine: Record "Sales Line";
    begin
        //#6499
        GetSalesHeader();
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", "Document Type");
        lSalesLine.SetRange("Document No.", "Document No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetFilter("Line No.", '<>%1', "Line No.");
        lSalesLine.SetFilter(Type, '<>%1', lSalesLine.Type::" ");
        lSalesLine.SetFilter("Qty. Shipped Not Invoiced", '<>0');
        if lSalesLine.IsEmpty then begin
            lSalesLine.SetRange("Qty. Shipped Not Invoiced");
            lSalesLine.SetFilter("Outstanding Quantity", '<>0');
            if lSalesLine.IsEmpty then begin
                SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.");
                SalesHeader.Finished := "Completely Shipped";
                SalesHeader.Modify;
            end;
        end;
        //#6499//
    end;

    procedure wUpdateTotalingLine(pRec: Record "Sales Line"; pxRec: Record "Sales Line"; pInit: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        //#6768
        if (pRec.Quantity = 0) and (pxRec.Quantity = 0) and
           (pRec."Quantity (Base)" = 0) and (pxRec."Quantity (Base)" = 0) then
            exit;

        if (xRec.Option = Rec.Option) and (Rec.Option) then
            exit;

        //IF MODIFY THEN;  //Rem. sur MODIFY pour éviter un message sous SQL
        if ("Structure Line No." <> 0) and ("Attached to Line No." = 0) then
            exit;
        if "Order Type" = "order type"::"Supply Order" then
            exit;
        if Level > 1 then begin
            if lSalesLine.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then begin
                    if not pInit then
                        wSalesLineMgt.wUpdateTotalLine2(lSalesLine, pRec, pxRec)
                    else
                        wSalesLineMgt.wUpdateTotalLine(lSalesLine);
                end else
                    if (lSalesLine."Line Type" = lSalesLine."line type"::Structure) then
                        if lSalesLine.Get("Document Type", "Document No.", lSalesLine."Attached to Line No.") then
                            if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then begin
                                if not pInit then
                                    wSalesLineMgt.wUpdateTotalLine2(lSalesLine, pRec, pxRec)
                                else
                                    wSalesLineMgt.wUpdateTotalLine(lSalesLine);
                            end;
                wSalesLineMgt.wUpdateTotalingLine(lSalesLine);
            end;
        end
        //#6768//
    end;

    procedure fUpdateUnitAmountRounding()
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
        lUnitRoundPrecision: Decimal;
    begin
        //#7190
        if Rec."Line Type" = Rec."line type"::Totaling then begin
            lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            lSalesLine.SetRange("Structure Line No.", 0);
            lSalesLine.SetRange("Presentation Code",
               "Presentation Code",
               "Presentation Code" + '999');
            lSalesLine.SetFilter("Line Type", '<>%1', "line type"::" ");
            if lSalesLine.Count > 1 then begin
                lUnitRoundPrecision := "Unit-Amount Rounding Precision";
                //il y a un modify sur un validate qui provoque une erreur !?!  Le champ est remis à jour après
                Rec."Unit-Amount Rounding Precision" := xRec."Unit-Amount Rounding Precision";

                if not lSalesLine.IsEmpty then begin
                    lSalesLine.FindSet(true, false);
                    repeat
                        lSalesLine."Unit-Amount Rounding Precision" := lUnitRoundPrecision;
                        if lSalesLine.Quantity <> 0 then
                            lSalesLine.Validate(Quantity);
                        lSalesLine.Modify;
                    until lSalesLine.Next = 0;
                end;
            end;
        end else begin
            Validate(Quantity);
        end;
        //#7190//
    end;

    procedure fInitUnitAmountRounding()
    var
        lSalesLine: Record "Sales Line";
    begin
        //#7190
        if ("Attached to Line No." <> 0) and (Rec."Line Type" <> "line type"::" ") and ("Structure Line No." = 0) and
          ("Document Type" = "document type"::Quote) then begin
            if lSalesLine.Get("Document Type", "Document No.", Rec."Attached to Line No.")
             then begin
                "Unit-Amount Rounding Precision" := lSalesLine."Unit-Amount Rounding Precision";
            end;
        end;
        //#7190//
    end;

    procedure fCheckIsFirstLevel(pRec: Record "Sales Line"): Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        if pRec."Order Type" <> pRec."order type"::"Supply Order" then
            exit(false);
        lSalesLine.SetCurrentkey("Document Type", "Supply Order No.", "Supply Order Line No.");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Supply Order No.", pRec."Document No.");
        lSalesLine.SetRange("Supply Order Line No.", pRec."Line No.");
        if lSalesLine.FindFirst then
            exit(lSalesLine."Structure Line No." = 0);
    end;

    procedure fShowLineCard()
    var
        lRec: Record "Sales Line";
    begin
        //#7652
        TestField("Document No.");
        TestField("Line No.");
        TestField(Type);
        lRec := Rec;
        lRec.SetView(GetView);
        //DYS page addon non migrer
        //page.RunModal(page::"Sales Line Card", lRec);
        //#7652//
    end;

    procedure fUpdateCurrFieldNoRTC(From_No: Integer)
    begin
        //#9084
        gCurrFieldNoRTC := From_No;
        //#9084
    end;

    procedure "// HJ DSFT"()
    begin
    end;

    procedure GetCodeEtude()
    var
        RecLItem: Record Item;
        RecLResource: Record Resource;
    begin
        // >> HJ DSFT 29-06-2012
        RecLItem.Reset;
        RecLResource.Reset;
        if "Line Type" = "line type"::Item then begin
            RecLItem.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            if page.RunModal(page::"Bureau Ordre Envoyé à", RecLItem) = Action::LookupOK then begin
                Validate("No.", RecLItem."No.");
                "Code Etude" := RecLItem."Code Etude";
            end;
        end;
        if "Line Type" = "line type"::Person then begin
            RecLResource.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            RecLResource.SetRange(Type, RecLResource.Type::Person);
            if page.RunModal(page::"Bureau Ordre Diffusion Detail", RecLResource) = Action::LookupOK then begin
                Validate("No.", RecLResource."No.");
                "Code Etude" := RecLResource."Code Etude";
            end;
        end;
        if "Line Type" = "line type"::Machine then begin
            RecLResource.SetFilter("Code Etude", '%1', '*' + "Code Etude" + '*');
            RecLResource.SetRange(Type, RecLResource.Type::Machine);
            if page.RunModal(page::"Bureau Ordre Diffusion Detail", RecLResource) = Action::LookupOK then begin
                Validate("No.", RecLResource."No.");
                "Code Etude" := RecLResource."Code Etude";
            end;

        end;

        // >> HJ DSFT 29-06-2012
    end;

    procedure InsertionLigneChapitre()
    var
        RecLStandardText: Record "Standard Text";
        RecLResource: Record Resource;
        RecLSalesLine: Record "Sales Line";
        IntLCompteur: Integer;
        IntLevel: Integer;
        CdePrestaionCode: Code[10];
        IntPresentationCode: Integer;
        TxtCodePresentation: Text[30];
        TxtEspace: Text[2];
        IntLigneInitial: Integer;
    //DYS page addon non migrer
    //lSalesLineStc: page 8004051;
    begin
        // >> HJ DSFT 20-06-2012
        IntLCompteur := 0;
        if "Document Type" <> "document type"::Quote then exit;
        if "Line Type" = "line type"::Totaling then begin
            if RecLStandardText.Get("No.") then begin
                if not RecLStandardText."Insertion Automatique" then exit;
                RecLResource.SetRange(Section, "No.");
                RecLResource.SetRange(Type, RecLResource.Type::Structure);
                RecLResource.SetRange(Intégrer, true);
                IntLCompteur := "Line No.";
                IntLigneInitial := "Line No.";
                CdePrestaionCode := "Presentation Code";
                if RecLResource.FindFirst then
                    repeat
                        IntLCompteur += 10;
                        IntPresentationCode += 1;
                        RecLSalesLine."Document Type" := "Document Type";
                        RecLSalesLine."Document No." := "Document No.";
                        RecLSalesLine.Type := RecLSalesLine.Type::Resource;
                        RecLSalesLine."Line No." := IntLCompteur;
                        RecLSalesLine."Line Type" := "line type"::Structure;
                        RecLSalesLine.Validate("No.", RecLResource."No.");
                        RecLSalesLine."Attached to Line No." := IntLigneInitial;
                        RecLSalesLine.Level := 2;
                        TxtEspace := CopyStr('  ', 1, 2);
                        TxtCodePresentation := TxtEspace + CdePrestaionCode + '.' + '  ' + Format(IntPresentationCode);
                        RecLSalesLine."Presentation Code" := TxtCodePresentation;
                        if not RecLSalesLine.Insert(true) then RecLSalesLine.Modify;
                    //DYS
                    // lSalesLineStc.SetRecord(RecLSalesLine);
                    // lSalesLineStc.UpdateDetailOuvrage(true);
                    until RecLResource.Next = 0;
            end;
        end;
        // >> HJ DSFT 20-06-2012
    end;

    procedure UpdateUMIM()
    var
        UM: Decimal;
        IM: Decimal;
        VConsommation: Decimal;
        VTransport: Decimal;
        VDivers: Decimal;
        VSoustraitance: Decimal;
        VFournitures: Decimal;
        VFournituresEtDivers: Decimal;
        VMO: Decimal;
        VMOConducteur: Decimal;
        VLubrifiantPetitEntret: Decimal;
        VMateriel: Decimal;
        V1: Decimal;
        V2: Decimal;
        V3: Decimal;
        V4: Decimal;
        V5: Decimal;
        VUM: Decimal;
        VIM: Decimal;
        SalesLine: Record "Sales Line";
        SalesLineRate: Record "Sales Line";
        VLubrifiant: Decimal;
    begin
        // >> HJ SORO 12-08-2014

        SalesLine4.SetRange("Document Type", "Document Type");
        SalesLine4.SetRange("Document No.", "Document No.");
        SalesLine4.SetFilter("Line Type", '%1', SalesLine3."line type"::Structure);
        SalesLine4.SetRange("Structure Line No.", 0);
        if SalesLine4.FindFirst then
            repeat
                VMO := 0;
                VFournitures := 0;
                VFournituresEtDivers := 0;
                VMOConducteur := 0;
                VMateriel := 0;
                VLubrifiant := 0;
                VConsommation := 0;
                VLubrifiantPetitEntret := 0;
                VUM := 0;
                VIM := 0;
                VDivers := 0;
                VSoustraitance := 0;
                SalesLine3.SetRange("Document Type", "Document Type");
                SalesLine3.SetRange("Document No.", "Document No.");
                SalesLine3.SetFilter(Type, '%1|%2', SalesLine3.Type::Resource, SalesLine3.Type::Item);
                SalesLine3.SetRange("Structure Line No.", SalesLine4."Line No.");
                if SalesLine3.FindFirst then
                    repeat

                        if SalesLine3."Line Type" = SalesLine3."line type"::Item then begin
                            if RecItem.Get(SalesLine3."No.") then begin
                                if RecItem."Type Lié Ouvrage" = 0 then begin
                                    // Item
                                    if SalesLine3.Rate <> 0 then begin
                                        SalesLine3."Fourniture Detail" := (RecItem.Fourniture + RecItem.Perte) * SalesLine3."Rate Quantity" * SalesLine3.Rate;
                                        SalesLine3."Transport Detail" := RecItem.Transport * SalesLine3."Rate Quantity" * SalesLine3.Rate;
                                        //SalesLine3.VALIDATE("Quantity per","Rate Quantity"*SalesLine3.Rate);
                                    end;
                                    VFournitures += SalesLine3."Fourniture Detail";
                                    VTransport += SalesLine3."Transport Detail";
                                end;
                                if RecItem."Type Lié Ouvrage" = 1 then begin
                                    // DIVERS
                                    SalesLine3."Divers Detail" := SalesLine3."Unit Cost";       // Divers
                                    VDivers += SalesLine3."Divers Detail";
                                end;
                                if RecItem."Type Lié Ouvrage" = 2 then begin
                                    //Transport
                                    SalesLine3."Transport Detail" := SalesLine3."Unit Cost";
                                    VTransport += SalesLine3."Transport Detail";
                                end;
                                if RecItem."Type Lié Ouvrage" = 3 then begin
                                    // Sous Traitance
                                    SalesLine3."Sous Traitance Detail" := SalesLine3."Unit Cost";
                                    VSoustraitance += SalesLine3."Sous Traitance Detail";
                                end;
                            end;
                        end;
                        if SalesLine3."Line Type" = SalesLine3."line type"::Person then begin
                            //VMO+=SalesLine3."Total Cost (LCY)";
                            if SalesLine3.Rate <> 0 then
                                SalesLine3."Main Oeuvre Detail" := SalesLine3."Unit Cost" * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                            VMO += SalesLine3."Main Oeuvre Detail";
                        end;

                        if SalesLine3."Line Type" = SalesLine3."line type"::Machine then begin
                            if Resource.Get(SalesLine3."No.") then begin
                                if SalesLine3.Rate <> 0 then begin
                                    SalesLine3."Materiel Detail" := (Resource."UM Cout Direct" + Resource."IM Cout Direct" +
                                    Resource."Lubrifiant Pt Entre Cout Direc") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    VUM += (Resource."UM Cout Direct") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    VIM += (Resource."IM Cout Direct") * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    SalesLine3."Lubrifiants Petit Entre Detail" := Resource."Lubrifiant Pt Entre Cout Direc"
                                                                                * SalesLine3."Rate Quantity" / SalesLine3.Rate;
                                    ;
                                end;
                                VMateriel += SalesLine3."Materiel Detail";
                                VLubrifiant += SalesLine3."Lubrifiants Petit Entre Detail";
                                if SalesLine3.Rate <> 0 then
                                    SalesLine3."Main Oeuvre Materiel Detail" := (Resource."Cout MO Materielle Direct" *
                                    SalesLine3."Rate Quantity") / SalesLine3.Rate;

                                VMO += SalesLine3."Main Oeuvre Materiel Detail";
                                if SalesLine3.Rate <> 0 then
                                    SalesLine3."Consommation Detail" := Resource."Cout Consommation Direct" * SalesLine3."Rate Quantity" / SalesLine3.Rate;

                                VConsommation += SalesLine3."Consommation Detail";
                            end;
                        end;
                        SalesLine3."Fourniture Et Divers Detail" := SalesLine3."Consommation Detail" + SalesLine3."Fourniture Detail" +
                        SalesLine4."Transport Detail" + SalesLine3."Sous Traitance Detail" + SalesLine3."Divers Detail";
                        SalesLine3.Modify;
                    until SalesLine3.Next = 0;

                SalesLine4.Materiel := VMateriel;
                VFournituresEtDivers := VConsommation + VTransport + VSoustraitance + VDivers;
                SalesLine4."Main Oeuvre" := VMO;
                SalesLine4.UM := VUM;
                SalesLine4.IM := VIM;
                SalesLine4."Lubrifiants Petit Entretient" := VLubrifiant;
                SalesLine4.Consommation := VConsommation;
                SalesLine4.Transport := VTransport;
                SalesLine4."Sous Traitance" := VSoustraitance;
                SalesLine4.Divers := VDivers;
                SalesLine4.Fournitures := VFournitures;
                SalesLine4."Fourniture Et Divers" := VFournituresEtDivers;
                SalesLine4.Modify;

            until SalesLine4.Next = 0;
        // >> HJ SORO 12-08-2014
    end;




    // GL 2024 Procédure spécifique car la procédure standard est locale 
    //Utilisé dans un event
    procedure CheckLineAmount2(MaxLineAmount: Decimal)
    var
        LineAmountInvalidErr: Label 'You have set the line amount to a value that results in a discount that is not valid. Consider increasing the unit price instead.';
    begin


        if "Line Amount" < 0 then
            if "Line Amount" < MaxLineAmount then
                Error(LineAmountInvalidErr);

        if "Line Amount" > 0 then
            if "Line Amount" > MaxLineAmount then
                Error(LineAmountInvalidErr);
    end;

    procedure UpdateBaseAmounts2(NewAmount: Decimal; NewAmountIncludingVAT: Decimal; NewVATBaseAmount: Decimal)
    begin
        Amount := NewAmount;
        "Amount Including VAT" := NewAmountIncludingVAT;
        "VAT Base Amount" := NewVATBaseAmount;


    end;

    // GL 2024 fin


    var
        lGenProductPostGr: Record "Gen. Product Posting Group";
        lResGr: Record "Resource Group";
        Resource: Record Resource;

        lTotalNeedParameter: Record "Sales Document Cost";
        lDescr: Text[50];
        lQtyBase: Decimal;
        lUnit: Code[10];
        lPrice: Decimal;
        lRes: Record Resource;
        lStructureOK: Boolean;
        "//HJ": Integer;
        TextL001: label 'Article %1 Non parametré pour ce marché, consiluter votre administrateur';
        // CduSoro: Codeunit "Soroubat cdu";
        lSalesline: Record "Sales Line";
        lPuchLine: Record "Purchase Line";
        lText: Text[250];
        lStructureLine: Record "Sales Line";
        lGetPurchLine: Boolean;
        lSalesLineTot: Record "Sales Line";
        lNbRes: Decimal;
        lInit: Boolean;
        lQtySetup: Record "Quantity Setup";
        lCalcQty: Codeunit "Calculate Quantity";
        lCalculateQty: Decimal;
        lSubLine: Record "Sales Line";
        lQty: Decimal;
        lRec: Record "Sales Line";
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
        lStructureMgt: Codeunit "Structure Management";
        lPurchHead: Record "Purchase Header";
        lJob: Record Job;
        lJobStatus: Record "Job Status";
        lPrepaymentMgt: Codeunit "Prepayment Management";
        lSalesHeader: Record "Sales Header";
        lCurrFieldNo: Integer;
        lResPrice: Record "Resource Price";
        lCrossRef: Code[20];
        lToSalesLineComp: Record "Sales Line";
        lxRec: Record "Sales Line";
        lDescriptionLine: Record "Description Line";
        lOkDelete: Boolean;
        lTransferOrderLink: Record "Transfer Order Link";
        lSalesDocCost: Record "Sales Document Cost";
        lSalesLine2: Record "Sales Line";
        lRecRef: RecordRef;
        lFatherRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lBOQMgt: Codeunit "BOQ Management";
        lT37: Record "Sales Line";
        Text027: label 'Lancer la Creation de l''Article Sur Model ?';
        Text032: label 'l''Article %1 à Eté Crée Avec Succé';
        Text033: label 'Article Deja Existant Dans Cette Commande, Vous n''avez Le droit D''untilser Un Article Qu''une Seule Fois';
        Text050: label 'DA Approbé';
        tTransfer: label 'You cannot change %1 because the order line is associated with transfer %2.';
        CodeTranslation: Record Translation2;
        Text8001400: label '%1 must be -1, 0 or 1 when %2 is stated.';
        gLicensePermission: Record "License Permission";
        gSubscrIntegration: Codeunit "Sales Subscription Integr.";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        Text8003900: label 'You must delete or change the level of the next line.\The current line cannot have a down tree.';
        Text8003901: label 'You must change the level of the prevous line.';
        Text8003902: label 'You mustn''t change %1 in %2, because this line has a down tree.';
        Text8003903: label 'You mustn''t change the level %1 to %2, because the type or the level of the previous line isn''t compatible.';
        Text8003904: label 'You cannot delete this line because it is associated with purchase order %1 line %2 that was already invoiced';
        Text8003905: label 'A rounding error was noted. However no line contains a quantity that cannot absorb this error. If you decide to continue the rounding will be absorbed in detriment to the presentation of amounts from the printing  of the document.';
        Text8003906: label 'This modification is not allowed.\you must detach éléments attach to this totaling between to modify this';
        Text8003907: label 'The shpiment management of this item is transfering in the supply Order %1 on the Line %2';
        Text8003911: label 'You mustn''t specify %1 when the line type is %2.';
        Text8003912: label 'You mustn''t modify %1, when %2 is true.';
        Text8003913: label 'The previous line must have "Line Type" %1.';
        Text8003914: label 'You must move to the left before to move down.';
        Text8003915: label 'You must move to the left before to move up.';
        Text8003916: label 'You mustn''t move the first line.';
        Text8003917: label 'This move is not possible.';
        wCalcQty: Codeunit "Calculate Quantity";
        Text8003918: label 'The quantity issue from a formula, you must modify the values of calculation.';
        Text8003919: label '%1 must be superior to %2.';
        Text8003920: label 'You mustn''t use this type for a structure.';
        wOverhead: Codeunit "Overhead Calculation";
        wStructureMgt: Codeunit "Structure Management";
        Text8003921: label 'Fixed Price, do you want to refresh price?';
        Text8003922: label 'Do you want to delete the detail of the totaling %1 ?';
        wDeleteHeader: Boolean;
        Text8003923: label 'Rate must be 0 in %1 %2.';
        wHideDialog: Boolean;
        wTest: Boolean;
        Text8003924: label 'This line is attached to requisition order %1';
        Text8003925: label 'The length of Structure No. cannot be superior to 10 characters.';
        wRecordref: RecordRef;
        Text8003926: label '%1 is not the same in imported line.';
        Text8003927: label 'You cannot delete the line %1 because it is associated with purchase %2 .';
        Text8003929: label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text8003930: label 'You mustn''t specify %1 when the line type is %2 what containt more one line';
        Text8003931: label 'You can''t modify this field  "%1", because this ligne has a disable flag.';
        Text8003958: label 'Vous ne pouvez pas modifier le champ "%1", car cet article provient initialement d''un sous-détail';
        TextRespectWarn: label 'The update has been interrupted to respect the warning.';
        TextMultiple: label 'Insert in progress.';
        TextToMuch: label 'Do you want to insert the %1 %2s?';
        TextSubcontracting: label 'You cannot have a subcontracting for a %1.';
        tNoItemCompletion: label 'not enable for Item type or job cost';
        tQtyFact: label 'You cannot change a line already invoiced.';
        tQtyShip: label 'You cannot change a line already shipped.';
        ErrorLevel: label 'You are limited at 4 levels of totaling.';
        ErrorGlobalDiscount: label 'You must display the glogal discount on %1 %2.';
        ErrorAtt: label 'You can''t modify the type of this line.';
        ResUnitOfMeasure: Record "Resource Unit of Measure";
        PurchLine: Record "Purchase Line";
        LineAmountQuestion: label 'Do you want to copy this price on all the lines with %1 %2?';
        wQtySetup: Record "Quantity Setup";
        ErrorDeleteCrossRef: label 'You must ungroup the cross-Réf. before to delete this line.';
        ErrorModifyCrossRef: label 'You must ungroup the cross-Réf. before to modify this line.';
        SubcontractingMgt: Codeunit "Subcontracting Management";
        wNavibatSetup: Record NavibatSetup;
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ErrorOptionCrossRef: label 'must be ungrouped before to put thisl ine in optionnal.';
        ErrorRateQty: label 'You don''t modify the quantity per because rate quantity is defined';
        ErrorSupplyOrder: label 'You cannot have the type %1 in an supply order.';
        wUpdateSalesOverHead: Boolean;
        ErrorUnGroup: label 'You cannot ungroup this line before to ungroup the lines grouped with this line.';
        ErrorOptionJobCost: label 'Can''t modify because this %1 include in specific job cost repartition';
        wSalesLineMgt: Codeunit "SalesLine Management";
        wUpdateQty: Boolean;
        wxQtyPer: Decimal;
        wxQtyFixed: Decimal;
        xRecExist: Boolean;
        wFirstLineNo: Integer;
        tProgressTotUpd: label 'Update Totaling Line in Progress...';
        wConfirmDeleteTot: Boolean;
        wRollBackLog: Record "RollBack Log";
        wCalcAmountM: Codeunit "Calc. Amount Management";
        tLineNotModificable: label 'You can''t modify this line.';
        wGLSetup: Record "General Ledger Setup";
        wSingleInstance: Codeunit "Import SingleInstance2";
        wPresentationMgt: Codeunit "Presentation Management";
        gPrepaymentReversal: Boolean;
        tJobTaskNotEditable: label 'not editable for invoice and credit memo';
        tJobTaskNoIsBlocked: label 'is blocked';
        tErrorDelPrepLineInvoiced: label 'You can''t delete this line %1 because she''s linked with an invoice';
        gCreditAlreadyCheck: Boolean;
        gCurrFieldNoRTC: Integer;
        ErrorTransferOrder: label 'You cannot have the type %1 in a transfer order.';
        "// Var HJ DSFT": Integer;
        RecItem: Record Item;
        Currency: Record Currency;

        Ressource: Record Resource;
        SalesLine4: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        UM: Decimal;
        IM: Decimal;
        VConsommation: Decimal;
        VTransport: Decimal;
        VDivers: Decimal;
        VSoustraitance: Decimal;
        VFournitures: Decimal;
        VMO: Decimal;
        VMOConducteur: Decimal;
        VLubrifiantPetitEntret: Decimal;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "// RB SORO BETON": Integer;
        RecSalesHeaderBeton: Record "Sales Header";
        RecPrixBeton: Record "Temp beton Prix";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        ll: Codeunit "Whse. Validate Source Line";
        PurchasingCode: Record Purchasing;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesLine2: Record "Sales Line";
        ResCost: Record "Resource Cost";
        JobLedgEntry: Record "Job Ledger Entry";
        //DYS page addon non migrer
        //JobLedgEntries: PAGE 8004162;
        JobPostLine: Codeunit "Job Post-Line2";
        Item: Record Item;
        StdTxt: Record "Standard Text";


        Text049: Label 'cannot be %1.';
        Text048: Label 'You cannot use item tracking on a %1 created from a %2.';




}

