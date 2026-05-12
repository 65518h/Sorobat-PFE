page 50422 "NaviOne Invoice Subform"
{

    //
    Caption = 'Ligne';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = CONST(Invoice), "Structure Line No." = CONST(0), "Line Type" = FILTER(<> Other));

    layout
    {
        area(content)
        {
            repeater("")
            {
                Editable = true;
                Enabled = true;
                ShowCaption = false;
                FreezeColumn = Description;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                Visible = true;
                // field("Line No."; rec."Line No.")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field("Attached to Line No."; "Attached to Line No.")
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                // field(PresentationCodeText; PresentationCodeText)
                // {
                //     CaptionClass = FIELDCAPTION("Presentation Code");
                //     Editable = false;
                //     HideValue = "Presentation CodeHideValue";
                //     Style = Strong;
                //     StyleExpr = "Presentation CodeEmphasize";
                //     Visible = false;
                // }
                // field(Level; Level)
                // {
                //     Editable = false;
                //     HideValue = LevelHideValue;
                //     Style = Strong;
                //     StyleExpr = LevelEmphasize;
                //     Visible = false;
                // }
                /*GL2024   FIELD(Afficher; ActualExpansionStatus)
                   {
                       ApplicationArea = all;
                       Caption = 'Afficher';
                   }*/
                field("Line Type"; rec."Line Type")
                {
                    Style = Strong;
                    StyleExpr = "Line TypeEmphasize";

                    trigger OnValidate()
                    begin
                        //#4379
                        IF rec."Line Type" = rec."Line Type"::Other THEN
                            ERROR(tOtherResource);
                        //#4379//
                        LineTypeOnAfterValidate;
                    end;
                }
                field("Type article"; Rec."Type article")
                {
                    Visible = false;
                }
                field("No."; rec."No.")
                {
                    Style = Strong;
                    StyleExpr = "No.Emphasize";

                    /*GL2024    trigger OnLookup(var Text: Text): Boolean
                        begin
                            wOnLookup;
                            //#7427
                            fRecalculateBOQ();
                            //#7427//
                        end;*/
                    // trigger OnLookup(var Text: Text): Boolean
                    // var

                    //     lMultiple: Boolean;



                    //     PageItelLookup: Page "Item Lookup";
                    //     RecStandardText: Record "Standard Text";
                    //     RecGLAccount: Record "G/L Account";
                    //     RecResource: Record Resource;
                    //     RecFixedAsset: Record "Fixed Asset";
                    //     RecItemCharge: Record "Item Charge";
                    //     RecAllocationAccount: Record "Allocation Account";
                    //     RecItem: Record Item;
                    // begin
                    //     if Rec.Type = Rec.Type::"Allocation Account" then begin
                    //         if RecAllocationAccount.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Allocation Account List", RecAllocationAccount) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecAllocationAccount."No.");
                    //             end;
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::"Charge (Item)" then begin
                    //         /*  if RecItemCharge.FindSet() then begin
                    //               if PAGE.RunModal(PAGE::"Item Charges", RecItemCharge) = ACTION::LookupOK then begin
                    //                   Rec.Validate("No.", RecItemCharge."No.");
                    //               end;
                    //           end;*/
                    //         Message('La liste des frais annexes est vide');
                    //     end;
                    //     if Rec.Type = Rec.Type::"Fixed Asset" then begin
                    //         if RecFixedAsset.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Fixed Asset List", RecFixedAsset) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecFixedAsset."No.");
                    //             end;
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::Resource then begin
                    //         if RecResource.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Resource List", RecResource) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecResource."No.");
                    //             end;
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::Item then begin
                    //         RecItem.Reset();
                    //         RecItem.SetRange(Type, Rec."Type article");
                    //         if RecItem.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"Item Lookup", RecItem) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecItem."No.");
                    //             end;
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::" " then begin
                    //         if PAGE.RunModal(PAGE::"Standard Text Codes", RecStandardText) = ACTION::LookupOK then begin
                    //             Rec.Validate("No.", RecStandardText."code");
                    //         end;
                    //     end;
                    //     if Rec.Type = Rec.Type::"G/L Account" then begin
                    //         RecGLAccount.Reset();
                    //         RecGLAccount.SetRange("Account Type", RecGLAccount."Account Type"::Posting);
                    //         RecGLAccount.SetRange(Blocked, false);
                    //         RecGLAccount.SetRange("Direct Posting", true);
                    //         if RecGLAccount.FindSet() then begin
                    //             if PAGE.RunModal(PAGE::"G/L Account List", RecGLAccount) = ACTION::LookupOK then begin
                    //                 Rec.Validate("No.", RecGLAccount."No.");
                    //             end;
                    //         end;
                    //     end;

                    // end;


                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        wOKLookup := FALSE;

                        //MIG 5.00
                        /*IF (Type = Type::Item) AND ("No." <> xRec."No.") AND ("No." <> '') AND (wItem.GET("No.")) AND
                          (wItem."Default Task Code" <> '') AND ("Structure Line No." = 0) THEN

                              GetItemCrossRef := wItem."Default Task Code";
                        MIG5.00 */
                        NoOnAfterValidate;

                    end;

                }

                // field("Apply Fodec"; Rec."Apply Fodec")
                // {
                //     ApplicationArea = all;
                // }
                // field(Option; Option)
                // {
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         //#RTC - 2009
                //         CurrPage.SAVERECORD();
                //         //gSaveRecord()
                //         //#RTC - 2009//
                //         OptionOnAfterValidate;
                //     end;
                // }
                // field("Assignment Basis"; "Assignment Basis")
                // {
                //     HideValue = "Assignment BasisHideValue";
                //     Style = Strong;
                //     StyleExpr = "Assignment BasisEmphasize";
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         AssignmentBasisOnAfterValidate;
                //     end;
                // }
                // field("Assignment Method"; "Assignment Method")
                // {
                //     HideValue = "Assignment MethodHideValue";
                //     Style = Strong;
                //     StyleExpr = "Assignment MethodEmphasize";
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         //#RTC - 2009
                //         CurrPage.SAVERECORD();
                //         //gSaveRecord()
                //         //#RTC - 2009//
                //     end;
                // }
                // field("Gen. Prod. Posting Prorata"; "Gen. Prod. Posting Prorata")
                // {
                //     Visible = false;
                // }
                // field(JobCostAssignment; "Job Cost Assignment")
                // {
                //     Caption = 'Job Cost Marked';
                //     HideValue = "Job Cost AssignmentHideValue";
                //     Style = Strong;
                //     StyleExpr = JobCostAssignmentEmphasize;
                //     Visible = false;

                //     trigger OnDrillDown()
                //     begin
                //         //FRAIS
                //         //#RTC - 2009
                //         //gSaveRecord();
                //         CurrPage.SAVERECORD();
                //         //#RTC - 2009//
                //         Rec.wShowJobCostAssgnt;
                //         UpdateForm(FALSE);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         JobCostAssignmentOnAfterValida;
                //     end;
                // }
                // field(Subcontracting; Subcontracting)
                // {
                //     HideValue = SubcontractingHideValue;
                //     Style = Strong;
                //     StyleExpr = SubcontractingEmphasize;
                //     Visible = false;

                //     trigger OnValidate()
                //     var
                //         lSubcontracting: Integer;
                //     begin
                //         IF rec."Line Type" = rec."Line Type"::Totaling THEN BEGIN
                //             lSubcontracting := Subcontracting;
                //             FIND('=');
                //             Subcontracting := lSubcontracting;
                //         END;
                //         //#RTC - 2009
                //         //gSaveRecord();
                //         CurrPage.SAVERECORD();
                //         //#RTC - 2009//
                //         SubcontractingOnAfterValidate;
                //     end;
                // }
                // field("Variant Code"; "Variant Code")
                // {
                //     Style = Strong;
                //     StyleExpr = "Variant CodeEmphasize";
                //     Visible = false;
                // }
                // field("Substitution Available"; "Substitution Available")
                // {
                //     Visible = false;
                // }
                // field(Nonstock; Nonstock)
                // {
                //     Visible = false;
                // }
                // field(Marker; Marker)
                // {
                //     Style = Strong;
                //     StyleExpr = MarkerEmphasize;
                //     Visible = false;
                // }
                // field("Cross-Reference No."; "Cross-Reference No.")
                // {
                //     Style = Strong;
                //     StyleExpr = "Cross-Reference No.Emphasize";
                //     Visible = false;

                //     trigger OnValidate()
                //     begin
                //         CrossReferenceNoOnAfterValidat;
                //     end;
                // }
                // field("Purchasing Code"; "Purchasing Code")
                // {
                //     Style = Strong;
                //     StyleExpr = "Purchasing CodeEmphasize";
                //     Visible = false;
                // }
                // field("Vendor No."; "Vendor No.")
                // {
                //     Style = Strong;
                //     StyleExpr = "Vendor No.Emphasize";
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     var
                //         lVendor: Record 23;
                //         lVendorCode: Code[20];
                //     begin
                //         IF Subcontracting <> Subcontracting::" " THEN
                //             lVendor.SETRANGE(Subcontractor, TRUE);
                //         lVendor."No." := "Vendor No.";
                //         IF Page.RUNMODAL(0, lVendor) = ACTION::LookupOK THEN BEGIN
                //             VALIDATE("Vendor No.", lVendor."No.");
                //             lVendorCode := "Vendor No.";
                //             FIND('=');
                //             "Vendor No." := lVendorCode;
                //             CurrPage.UPDATE;
                //         END;
                //     end;

                //     trigger OnValidate()
                //     var
                //         lVendor: Code[20];
                //     begin
                //         IF rec."Line Type" = rec."Line Type"::Totaling THEN BEGIN
                //             lVendor := "Vendor No.";
                //             FIND('=');
                //             "Vendor No." := lVendor;
                //         END;
                //         //#RTC - 2009
                //         //gSaveRecord();
                //         CurrPage.SAVERECORD();
                //         //#RTC - 2009//
                //         VendorNoOnAfterValidate;
                //     end;
                // }
                // field("Purch. Order Qty (Base)"; "Purch. Order Qty (Base)")
                // {
                //     Visible = false;
                // }
                // field("Purch. Order Receipt Date"; "Purch. Order Receipt Date")
                // {
                //     Visible = false;
                // }
                // field("Purch. Order Rcpt. Qty (Base)"; "Purch. Order Rcpt. Qty (Base)")
                // {
                //     Visible = false;
                // }
                // field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                // {
                //     Style = Strong;
                //     StyleExpr = GenProdPostingGroupEmphasize;
                //     Visible = false;
                // }
                // field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                // {
                //     Style = Strong;
                //     StyleExpr = VATProdPostingGroupEmphasize;
                //     Visible = false;
                // }
                // field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                // {
                //     Style = Strong;
                //     StyleExpr = VATBusPostingGroupEmphasize;
                //     Visible = false;
                // }
                field(Description; rec.Description)
                {
                    Style = Strong;
                    StyleExpr = DescriptionEmphasize;

                    trigger OnAssistEdit()
                    var
                        lSCRefMgt: Codeunit 8004062;
                    begin
                        // //#5464
                        // //lAssistEdit;
                        // //#5464

                        // //+REF+MEMOPAD
                        // //#RTC - 2009
                        // //gSaveRecord();
                        // CurrPage.SAVERECORD();
                        // //#RTC - 2009//
                        // //#5464
                        // //IF wEditMemoPad THEN
                        // IF rec.fMemoPad THEN BEGIN
                        //     //#5464//
                        //     //#7592
                        //     //  IF ("Attached to Line No." <> 0) THEN
                        //     //    GET("Document Type","Document No.","Attached to Line No.")
                        //     IF (rec."Attached to Line No." <> 0) AND (rec.Type <> rec.Type::Resource) THEN
                        //         rec.GET(rec."Document Type", rec."Document No.", rec."Attached to Line No.")
                        //     ELSE
                        //         Rec.GET(Rec."Document Type", Rec."Document No.", Rec."Line No.");
                        //     //#7592//
                        //     IF rec."Item Reference No." <> '' THEN
                        //         lSCRefMgt.wUpdateField(Rec, rec.Description, rec.FIELDNO(Description));
                        //     //    lSCRefMgt.wValidateExtendedText(Rec);
                        //     CurrPage.UPDATE(FALSE);
                        //     //+REF+MEMOPAD//
                        // END;

                        IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
                        //  IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

                        //IF (Type=Type::"Charge (Item)")  THEN
                        //  BEGIN
                        //    IF RecUserSetup.GET(UPPERCASE(USERID)) THEN
                        //      IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);
                        //  END;
                        // IF (rec.Type = rec.Type::Item) THEN BEGIN
                        //     IF (rec."No." <> '3000010000001') AND (rec."No." <> 'IMM') AND (rec."Type article" <> rec."Type article"::Service) THEN
                        //         ERROR(Text005);
                        // END;
                    end;

                    trigger OnValidate()
                    begin
                        DescriptionOnAfterValidate;
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                // field("Job Task No."; Rec."Job Task No.")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }

                field(Quantity; rec.Quantity)
                {
                    BlankZero = true;
                    Editable = QuantityEditable;
                    Style = Strong;
                    StyleExpr = QuantityEmphasize;

                    trigger OnAssistEdit()
                    begin
                        //lAssistEdit;
                        lMetre();
                    end;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }

                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    Style = Strong;
                    StyleExpr = "Unit of Measure CodeEmphasize";

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }

                field("Unit Price"; REC."Unit Price")
                {
                    BlankZero = true;
                    Editable = "Unit PriceEditable";
                    Style = Strong;
                    StyleExpr = "Unit PriceEmphasize";

                    trigger OnValidate()
                    begin
                        IF rec."Line Type" = rec."Line Type"::Totaling THEN
                            rec.FIELDERROR("Line Type");
                        UnitPriceOnAfterValidate;
                    end;
                }

                field("Line Amount"; rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = "Line AmountEditable";
                    HideValue = "Line AmountHideValue";
                    Style = Strong;
                    StyleExpr = "Line AmountEmphasize";

                    trigger OnValidate()
                    begin
                        IF rec."Line Type" = rec."Line Type"::Totaling THEN
                            rec.FIELDERROR("Line Type");
                        LineAmountOnAfterValidate;
                    end;
                }
                field("Fixed Price"; rec."Fixed Price")
                {
                    Editable = "Fixed PriceEditable";

                    trigger OnValidate()
                    begin
                        FixedPriceOnAfterValidate;
                    end;
                }
                field("Appliquer BIC"; Rec."Appliquer BIC")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        lRecRef: RecordRef;
        lAmount1Visible: Boolean;
        lAmount2Visible: Boolean;
        lAmount3Visible: Boolean;
        lAMount4Visible: Boolean;
        lAmount5Visible: Boolean;
        lAmount6Visible: Boolean;
        lAmount7Visible: Boolean;
        lAmount8Visible: Boolean;
        lAmount9Visible: Boolean;
        lAmount10Visible: Boolean;
        lAmountVisible: Boolean;
        lVisible: Boolean;
    begin
        "wAmount[10]HideValue" := FALSE;
        "wAmount[9]HideValue" := FALSE;
        "wAmount[8]HideValue" := FALSE;
        "wAmount[7]HideValue" := FALSE;
        "wAmount[6]HideValue" := FALSE;
        "wAmount[5]HideValue" := FALSE;
        "wAmount[4]HideValue" := FALSE;
        "wAmount[3]HideValue" := FALSE;
        "wAmount[2]HideValue" := FALSE;
        "wAmount[1]HideValue" := FALSE;
        "Person QuantityHideValue" := FALSE;
        "Line AmountHideValue" := FALSE;
        wProfitHideValue := FALSE;
        "Job Costs (LCY)HideValue" := FALSE;
        TheoreticalProfitAmountLCYHide := FALSE;
        "Overhead Amount (LCY)HideValue" := FALSE;
        "Total Cost (LCY)HideValue" := FALSE;
        QtyperUnitofMeasureHideValue := FALSE;
        "Value 10HideValue" := FALSE;
        "Value 9HideValue" := FALSE;
        "Value 8HideValue" := FALSE;
        "Value 7HideValue" := FALSE;
        "Value 6HideValue" := FALSE;
        "Value 5HideValue" := FALSE;
        "Value 4HideValue" := FALSE;
        "Value 3HideValue" := FALSE;
        "Value 2HideValue" := FALSE;
        "Value 1HideValue" := FALSE;
        DescriptionIndent := 0;
        SubcontractingHideValue := FALSE;
        "Job Cost AssignmentHideValue" := FALSE;
        "Assignment MethodHideValue" := FALSE;
        "Assignment BasisHideValue" := FALSE;
        LevelHideValue := FALSE;
        "Presentation CodeHideValue" := FALSE;
        IF wFirst THEN
            gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
        ActualExpansionStatus := 2;
        IF rec."Line Type" = rec."Line Type"::" " THEN
            ActualExpansionStatus := 3
        ELSE IF rec."Line Type" = rec."Line Type"::Totaling THEN BEGIN
            IF gOneSubFormMgt.gIsExpanded(Rec) THEN
                ActualExpansionStatus := 1
            ELSE
                IF gOneSubFormMgt.gHasChildren(Rec) THEN
                    ActualExpansionStatus := 0
                ELSE
                    ActualExpansionStatus := 3;
        END;

        rec.ShowShortcutDimCode(ShortcutDimCode);
        //TRS-2009
        lVisible := TotalCostLCYbyLineTypeVisible;
        //TRS-2009//
        IF lVisible THEN BEGIN
            rec.SETFILTER("Line Type Filter", '<>%1', rec."Line Type Filter"::Person);
            rec.CALCFIELDS("Total Cost LCY by Line Type");
        END;

        //TRS-2009
        lVisible := TMVisible;
        //TRS-2009//
        IF lVisible THEN
            StructureMgt.wGetProfit(wProfit, Rec, lVisible);

        //#6079
        wQtyPersonPerUnit := 0;
        IF (rec.Quantity <> 0) THEN BEGIN
            //TRS-2009
            lVisible := "Person QuantityVisible";
            //TRS-2009//
            IF (NOT lVisible OR (rec."Person Quantity" = 0)) AND
               (rec."Line Type" = rec."Line Type"::Structure) THEN
                rec.CALCFIELDS("Person Quantity");
            wQtyPersonPerUnit := rec."Person Quantity" / rec.Quantity;
        END;
        //#6079

        //TRS-2009
        lAmount1Visible := "Amount 1Visible";
        lAmount2Visible := "Amount 2Visible";
        lAmount3Visible := "Amount 3Visible";
        lAMount4Visible := "Amount 4Visible";
        lAmount5Visible := "Amount 5Visible";
        lAmount6Visible := "Amount 6Visible";
        lAmount7Visible := "Amount 7Visible";
        lAmount8Visible := "Amount 8Visible";
        lAmount9Visible := "Amount 9Visible";
        lAmount10Visible := "Amount 10Visible";
        IF lAmount1Visible OR lAmount2Visible OR lAmount3Visible OR
          lAMount4Visible OR lAmount5Visible OR lAmount6Visible OR
          lAmount7Visible OR lAmount8Visible OR lAmount9Visible OR
          lAmount10Visible THEN
            CalcAmount.SalesLineCalcAmount(Rec, wAmount);
        //TRS-2009
        //#8919
        /*
        //#6115
        IF wBOQLoad THEN BEGIN
          lRecRef.GETTABLE(Rec);
          OkMetre := wBOQMgt.GetBOQDefined(lRecRef.RECORDID);
        END ELSE
          OkMetre := 0;
        //#8919
        IF (Rec.Type = Rec.Type::" ") THEN
          wBoqState := 0
        ELSE
          wBoqState := (OkMetre + 1);
        //#8919//
        //#6115//
        */
        gOneSubFormMgt.fCheckBOQLine(wBOQMgt, Rec, wBOQLoad, OkMetre, wBoqState);
        //#8919//
        wFormatFields;

        IF (rec.Quantity <> 0) AND (rec."Qty. to Invoice" <> 0) THEN
            QtyCumToInv := (rec."Quantity Invoiced" + rec."Qty. to Invoice") / rec.Quantity * 100
        ELSE
            QtyCumToInv := 0;

        wShowTotalingValue := (rec."Document Type" = rec."Document Type"::Quote) AND (SalesHeader.Status = SalesHeader.Status::Open) AND
                              (wNavibatSetup."Disable update totaling") AND (rec."Line Type" = rec."Line Type"::Totaling);
        //#6409
        fCalculateProfitAmount;
        //#6409//
        OnAfterGetCurrRecord;
        PresentationCodeText := FORMAT(rec."Presentation Code");
        PresentationCodeTextOnFormat(PresentationCodeText);
        LevelOnFormat;
        LineTypeOnFormat;
        NoOnFormat;
        AssignmentBasisOnFormat;
        AssignmentMethodOnFormat;
        JobCostAssignmentOnFormat(FORMAT(rec."Job Cost Assignment"));
        SubcontractingOnFormat;
        VariantCodeOnFormat;
        MarkerOnFormat;
        CrossReferenceNoOnFormat;
        PurchasingCodeOnFormat;
        VendorNoOnFormat;
        GenProdPostingGroupOnFormat;
        VATProdPostingGroupOnFormat;
        VATBusPostingGroupOnFormat;
        DescriptionOnFormat;
        Description2OnFormat;
        InternalDescriptionOnFormat;
        LocationCodeOnFormat;
        CustomerPriceGroupOnFormat;
        Value1OnFormat;
        Value2OnFormat;
        Value3OnFormat;
        Value4OnFormat;
        Value5OnFormat;
        Value6OnFormat;
        Value7OnFormat;
        Value8OnFormat;
        Value9OnFormat;
        Value10OnFormat;
        QuantityOnFormat(FORMAT(rec.Quantity));
        QtyperUnitofMeasureOnFormat;
        QuantityBaseOnFormat;
        UnitofMeasureCodeOnFormat;
        UnitofMeasureOnFormat;
        RateOnFormat;
        DurationOnFormat;
        RateAmountOnFormat;
        UnitCostLCYOnFormat;
        TotalCostLCYOnFormat;
        OverheadAmountLCYOnFormat;
        TheoreticalProfitAmountLCYOnFo;
        JobCostsLCYOnFormat;
        wProfitOnFormat(FORMAT(wProfit));
        UnitPriceOnFormat;
        LineAmountOnFormat(FORMAT(rec."Line Amount"));
        LineDiscount37OnFormat;
        LineDiscountAmountOnFormat;
        InvDiscountAmountOnFormat;
        PrintOptionLineOnFormat;
        JobNoOnFormat;
        WorkTypeCodeOnFormat;
        ShortcutDimension1CodeOnFormat;
        ShortcutDimension2CodeOnFormat;
        PersonQuantityOnFormat;
        TotalCostLCYbyLineTypeOnFormat;
        wAmount1OnFormat;
        wAmount2OnFormat;
        wAmount3OnFormat;
        wAmount4OnFormat;
        wAmount5OnFormat;
        wAmount6OnFormat;
        wAmount7OnFormat;
        wAmount8OnFormat;
        wAmount9OnFormat;
        wAmount10OnFormat;

    end;

    trigger OnDeleteRecord(): Boolean
    var
        lRec: Record 37;
        lxRec: Record 37;
        lDeleteAll: Boolean;
        lCount: Integer;
        lSalesLineMgt: Codeunit 8004061;
        lSalesCrossRefMgt: Codeunit 8004062;
    begin
        lxRec := Rec;
        lRec.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(lRec);
        lRec.SETFILTER("Line Type", '<>%1', rec."Line Type"::" ");
        lCount := lRec.COUNT;
        lRec.wSetwConfirmDeleteTot(lCount = SalesHeader.wCountActiveLine);
        lRec.SETRANGE("Line Type");
        IF lRec.FIND('+') THEN
            REPEAT
                IF lRec.Type = lRec.Type::" " THEN BEGIN
                    IF lRec."Line No." = lRec."Attached to Line No." THEN
                        lRec.DELETE(FALSE)
                    ELSE
                        lRec.DELETE(TRUE);
                END ELSE
                    lRec.DELETE(TRUE);
            UNTIL lRec.NEXT(-1) = 0;

        IF rec.FIND('=') THEN;

        IF ((rec."Line Type" = rec."Line Type"::Totaling) AND (rec.Level > 1)) OR (lCount >= 2) THEN BEGIN
            lRec.RESET;
            lRec.COPY(Rec);
            lRec.SETRANGE("Line Type", rec."Line Type"::Totaling);
            IF NOT lRec.ISEMPTY THEN BEGIN
                lRec.FIND('-');
                REPEAT
                    lSalesLineMgt.wUpdateTotalLine(lRec);
                UNTIL lRec.NEXT = 0;
            END;
        END ELSE
            rec.wUpdateLine(Rec, xRec, TRUE);

        lSalesCrossRefMgt.wUpdateAttachedLine(Rec, 1);

        CurrPage.UPDATE(FALSE);

        EXIT(FALSE);
    end;

    trigger OnInit()
    begin
        "Line AmountEditable" := TRUE;
        "Allow Invoice Disc.Editable" := TRUE;
        "Line Discount %Editable" := TRUE;
        "Fixed PriceEditable" := TRUE;
        "Unit PriceEditable" := TRUE;
        QuantityEditable := TRUE;
        "Value 10Editable" := TRUE;
        "Value 9Editable" := TRUE;
        "Value 8Editable" := TRUE;
        "Value 7Editable" := TRUE;
        "Value 6Editable" := TRUE;
        "Value 5Editable" := TRUE;
        "Value 4Editable" := TRUE;
        "Value 3Editable" := TRUE;
        "Value 2Editable" := TRUE;
        "Value 1Editable" := TRUE;
        TMEditable := TRUE;
        "Unit Cost (LCY)Editable" := TRUE;
        QtyPersonPerUntEditable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXIT(fOnInsert(BelowxRec));
    end;

    trigger OnModifyRecord(): Boolean
    begin
        fOnModify();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        wKOLookup := FALSE;
        wProfit := 0;

        CASE rec."Line Type" OF
            rec."Line Type"::" ", rec."Line Type"::Totaling:
                rec.Type := rec.Type::" ";
            rec."Line Type"::Item:
                rec.Type := rec.Type::Item;
            rec."Line Type"::Person, rec."Line Type"::Machine, rec."Line Type"::Structure:
                rec.Type := rec.Type::Resource;
            rec."Line Type"::"G/L Account":
                rec.Type := rec.Type::"G/L Account";
            rec."Line Type"::"Charge (Item)":
                rec.Type := rec.Type::"Charge (Item)";
            rec."Line Type"::Other:
                BEGIN
                    rec."Line Type" := rec."Line Type"::Structure;
                    rec.Type := rec.Type::Resource;
                END;
            ELSE
                ;
        END;

        rec."Document Type" := SalesHeader."Document Type";
        rec."Document No." := SalesHeader."No.";
        rec."Order Type" := SalesHeader."Order Type";

        PresentationMgt.OnNewRecord(Rec, xRec, BelowxRec, FALSE);

        IF (xRec."Line Type" = 0) OR (xRec."Line Type" = rec."Line Type"::Other) THEN BEGIN
            rec."Line Type" := rec."Line Type"::Structure;
            rec.Type := rec.Type::Resource;
        END;

        rec.wInitLocationCode;
        CLEAR(ShortcutDimCode);
        wNew := TRUE;
        wRecordRef.CLOSE;
        CASE rec.Type OF
            rec.Type::Item:
                wRecordRef.OPEN(27);
            rec.Type::Resource:
                wRecordRef.OPEN(156);
            ELSE
                wRecordRef.OPEN(36);
        END;
        gBelowxrec := BelowxRec;
        IF wMarked THEN
            rec.MARK(TRUE);
        OkMetre := 0;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lSalesLine: Record 37;
        lGLSetup: Record 98;
    begin
        wNavibatSetup.GET2;
        lGLSetup.GET;
        IF STRPOS(FORMAT(lGLSetup."Amount Rounding Precision"), ',') <> 0 THEN
            wSeparator := ','
        ELSE
            wSeparator := '.';

        wShowExtendedText := TRUE;
        IF wQtySetup.GET THEN;
        OnActivateForm;
    end;

    var
        UpdateAllowedVar: Boolean;
        SalesHeader: Record 36;
        gOneSubFormMgt: Codeunit 8004048;
        wItem: Record 27;
        wNavibatSetup: Record 8003900;
        SetupStudy: Record 8004053;
        xSetupStudy: Record 8004053;
        SalesPriceCalcMgt: Codeunit 7000;
        TransferExtendedText: Codeunit 378;
        TransferExtendedText2: Codeunit 50026;
        SalesInfoPaneMgt: Codeunit 7171;
        PresentationMgt: Codeunit 8004052;
        StructureMgt: Codeunit 8004053;
        CalcAmount: Codeunit 8004033;
        Search: Codeunit 8004003;
        Overhead: Codeunit 8003951;
        SubcontractingMgt: Codeunit 8003982;
        ShortcutDimCode: array[8] of Code[20];
        ActualExpansionStatus: Integer;
        Text000: Label 'Unable to execute this function while in view only mode.';
        Text8003900: Label 'You can delete only one line.';
        Text8003901: Label 'The No. isnot right with the level you want to have.';
        tExtentedText: Label 'You must show detail form tomodify extended texts';
        tOnlyOneLine: Label 'Only one line selected. Do you want to continue?';
        wNew: Boolean;
        OkMetre: Integer;
        wRecordRef: RecordRef;
        wLookUp: Boolean;
        gBelowxrec: Boolean;
        tIndentationTotaling: Label 'Do you want to indent this totaling?';
        tInsertExtendedText: Label 'Do you want to add extended text from structure/item ?';
        JobCostAssgnt: Text[250];
        wShowLevel: Integer;
        wShowExtendedText: Boolean;
        ForeColor: Integer;
        FontBold: Boolean;
        tUpdate: Label 'Download....';
        ErrorInsert: Label 'You must do F3 before to insert.';
        wProfit: Decimal;
        wMarked: Boolean;
        wOKLookup: Boolean;
        tPurhaseIsEmpty: Label 'There is no purchase document associated to this line.';
        QtyCumToInv: Decimal;
        wAmount: array[10] of Decimal;
        tFreeAmount: Label 'Not Used';
        wSeparator: Text[1];
        wFirst: Boolean;
        tErrorTransfer: Label 'Qty shipped must be 0';
        tOtherResource: Label 'You cannot select Other resources in this form.';
        wKOLookup: Boolean;
        wShowTotalingValue: Boolean;
        wEdit: Boolean;
        wQtySetup: Record 8003994;
        wQtyPersonPerUnit: Decimal;
        wBOQMgt: Codeunit 8001446;
        wBOQLoad: Boolean;
        Text005: Label 'Impossible de modifier la description.';
        RecUserSetup: Record "User Setup";
        gProfitAmount: Decimal;
        wBoqState: Option " ","None","Has Just Variables","Has Results","Has Errors";
        [InDataSet]
        TotalCostLCYbyLineTypeVisible: Boolean;
        [InDataSet]
        TMVisible: Boolean;
        [InDataSet]
        "Person QuantityVisible": Boolean;
        [InDataSet]
        "Amount 1Visible": Boolean;
        [InDataSet]
        "Amount 2Visible": Boolean;
        [InDataSet]
        "Amount 3Visible": Boolean;
        [InDataSet]
        "Amount 4Visible": Boolean;
        [InDataSet]
        "Amount 5Visible": Boolean;
        [InDataSet]
        "Amount 6Visible": Boolean;
        [InDataSet]
        "Amount 7Visible": Boolean;
        [InDataSet]
        "Amount 8Visible": Boolean;
        [InDataSet]
        "Amount 9Visible": Boolean;
        [InDataSet]
        "Amount 10Visible": Boolean;
        [InDataSet]
        QtyPersonPerUntEditable: Boolean;
        [InDataSet]
        "Unit Cost (LCY)Editable": Boolean;
        [InDataSet]
        TMEditable: Boolean;
        [InDataSet]
        "Value 1Editable": Boolean;
        [InDataSet]
        "Value 2Editable": Boolean;
        [InDataSet]
        "Value 3Editable": Boolean;
        [InDataSet]
        "Value 4Editable": Boolean;
        [InDataSet]
        "Value 5Editable": Boolean;
        [InDataSet]
        "Value 6Editable": Boolean;
        [InDataSet]
        "Value 7Editable": Boolean;
        [InDataSet]
        "Value 8Editable": Boolean;
        [InDataSet]
        "Value 9Editable": Boolean;
        [InDataSet]
        "Value 10Editable": Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        "Fixed PriceEditable": Boolean;
        [InDataSet]
        "Allow Invoice Disc.Editable": Boolean;
        [InDataSet]
        "Line Discount %Editable": Boolean;
        [InDataSet]
        "Line Discount AmountEditable": Boolean;
        [InDataSet]
        "Presentation CodeHideValue": Boolean;
        [InDataSet]
        "Presentation CodeEmphasize": Boolean;
        [InDataSet]
        PresentationCodeText: Text[1024];
        [InDataSet]
        LevelHideValue: Boolean;
        [InDataSet]
        LevelEmphasize: Boolean;
        [InDataSet]
        "Line TypeEmphasize": Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        "Assignment BasisHideValue": Boolean;
        [InDataSet]
        "Assignment BasisEmphasize": Boolean;
        [InDataSet]
        "Assignment MethodHideValue": Boolean;
        [InDataSet]
        "Assignment MethodEmphasize": Boolean;
        [InDataSet]
        "Job Cost AssignmentHideValue": Boolean;
        [InDataSet]
        JobCostAssignmentEmphasize: Boolean;
        [InDataSet]
        SubcontractingHideValue: Boolean;
        [InDataSet]
        SubcontractingEmphasize: Boolean;
        [InDataSet]
        "Variant CodeEmphasize": Boolean;
        [InDataSet]
        MarkerEmphasize: Boolean;
        [InDataSet]
        "Cross-Reference No.Emphasize": Boolean;
        [InDataSet]
        "Purchasing CodeEmphasize": Boolean;
        [InDataSet]
        "Vendor No.Emphasize": Boolean;
        [InDataSet]
        GenProdPostingGroupEmphasize: Boolean;
        [InDataSet]
        VATProdPostingGroupEmphasize: Boolean;
        [InDataSet]
        VATBusPostingGroupEmphasize: Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        "Description 2Emphasize": Boolean;
        [InDataSet]
        "Internal DescriptionEmphasize": Boolean;
        [InDataSet]
        "Location CodeEmphasize": Boolean;
        [InDataSet]
        "Customer Price GroupEmphasize": Boolean;
        [InDataSet]
        "Value 1HideValue": Boolean;
        [InDataSet]
        "Value 1Emphasize": Boolean;
        [InDataSet]
        "Value 2HideValue": Boolean;
        [InDataSet]
        "Value 2Emphasize": Boolean;
        [InDataSet]
        "Value 3HideValue": Boolean;
        [InDataSet]
        "Value 3Emphasize": Boolean;
        [InDataSet]
        "Value 4HideValue": Boolean;
        [InDataSet]
        "Value 4Emphasize": Boolean;
        [InDataSet]
        "Value 5HideValue": Boolean;
        [InDataSet]
        "Value 5Emphasize": Boolean;
        [InDataSet]
        "Value 6HideValue": Boolean;
        [InDataSet]
        "Value 6Emphasize": Boolean;
        [InDataSet]
        "Value 7HideValue": Boolean;
        [InDataSet]
        "Value 7Emphasize": Boolean;
        [InDataSet]
        "Value 8HideValue": Boolean;
        [InDataSet]
        "Value 8Emphasize": Boolean;
        [InDataSet]
        "Value 9HideValue": Boolean;
        [InDataSet]
        "Value 9Emphasize": Boolean;
        [InDataSet]
        "Value 10HideValue": Boolean;
        [InDataSet]
        "Value 10Emphasize": Boolean;
        [InDataSet]
        QuantityEmphasize: Boolean;
        [InDataSet]
        QtyperUnitofMeasureHideValue: Boolean;
        [InDataSet]
        "Quantity (Base)Emphasize": Boolean;
        [InDataSet]
        "Unit of Measure CodeEmphasize": Boolean;
        [InDataSet]
        "Unit of MeasureEmphasize": Boolean;
        [InDataSet]
        RateEmphasize: Boolean;
        [InDataSet]
        DurationEmphasize: Boolean;
        [InDataSet]
        "Rate AmountEmphasize": Boolean;
        [InDataSet]
        "Unit Cost (LCY)Emphasize": Boolean;
        [InDataSet]
        "Total Cost (LCY)HideValue": Boolean;
        [InDataSet]
        "Total Cost (LCY)Emphasize": Boolean;
        [InDataSet]
        "Overhead Amount (LCY)HideValue": Boolean;
        [InDataSet]
        "Overhead Amount (LCY)Emphasize": Boolean;
        [InDataSet]
        TheoreticalProfitAmountLCYHide: Boolean;
        [InDataSet]
        TheoreticalProfitAmountLCYEmph: Boolean;
        [InDataSet]
        "Job Costs (LCY)HideValue": Boolean;
        [InDataSet]
        "Job Costs (LCY)Emphasize": Boolean;
        [InDataSet]
        wProfitHideValue: Boolean;
        [InDataSet]
        TMEmphasize: Boolean;
        [InDataSet]
        "Unit PriceEmphasize": Boolean;
        [InDataSet]
        "Line AmountHideValue": Boolean;
        [InDataSet]
        "Line AmountEmphasize": Boolean;
        [InDataSet]
        "Line Discount %Emphasize": Boolean;
        [InDataSet]
        "Line Discount AmountEmphasize": Boolean;
        [InDataSet]
        "Inv. Discount AmountEmphasize": Boolean;
        [InDataSet]
        "Print Option LineEmphasize": Boolean;
        [InDataSet]
        "Job No.Emphasize": Boolean;
        [InDataSet]
        "Work Type CodeEmphasize": Boolean;
        [InDataSet]
        ShortcutDimension1CodeEmphasiz: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEmphasiz: Boolean;
        [InDataSet]
        "Person QuantityHideValue": Boolean;
        [InDataSet]
        "Person QuantityEmphasize": Boolean;
        [InDataSet]
        TotalCostLCYbyLineTypeEmphasiz: Boolean;
        [InDataSet]
        "wAmount[1]HideValue": Boolean;
        [InDataSet]
        "Amount 1Emphasize": Boolean;
        [InDataSet]
        "wAmount[2]HideValue": Boolean;
        [InDataSet]
        "Amount 2Emphasize": Boolean;
        [InDataSet]
        "wAmount[3]HideValue": Boolean;
        [InDataSet]
        "Amount 3Emphasize": Boolean;
        [InDataSet]
        "wAmount[4]HideValue": Boolean;
        [InDataSet]
        "Amount 4Emphasize": Boolean;
        [InDataSet]
        "wAmount[5]HideValue": Boolean;
        [InDataSet]
        "Amount 5Emphasize": Boolean;
        [InDataSet]
        "wAmount[6]HideValue": Boolean;
        [InDataSet]
        "Amount 6Emphasize": Boolean;
        [InDataSet]
        "wAmount[7]HideValue": Boolean;
        [InDataSet]
        "Amount 7Emphasize": Boolean;
        [InDataSet]
        "wAmount[8]HideValue": Boolean;
        [InDataSet]
        "Amount 8Emphasize": Boolean;
        [InDataSet]
        "wAmount[9]HideValue": Boolean;
        [InDataSet]
        "Amount 9Emphasize": Boolean;
        [InDataSet]
        "wAmount[10]HideValue": Boolean;
        [InDataSet]
        "Amount 10Emphasize": Boolean;
        [InDataSet]
        "Unit PriceEditable": Boolean;
        [InDataSet]
        "Line AmountEditable": Boolean;


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
        lSalesLine: Record 37;
        PurchOrder: Page 50;
        lPurchQuote: Page 49;
        lPurchasDocType: Option;
        lPurchasDocNo: Code[20];
    begin
        //SUBCONTRACTOR
        IF rec.Type = rec.Type::" " THEN BEGIN
            IF lSalesLine.GET(rec."Document Type", rec."Document No.", rec."Attached to Line No.") THEN BEGIN
                lPurchasDocType := lSalesLine."Purchasing Document Type";
                lPurchasDocNo := lSalesLine."Purchasing Order No.";
            END ELSE BEGIN
                lPurchasDocType := 0;
                lPurchasDocNo := '';
            END;
        END ELSE BEGIN
            lPurchasDocType := rec."Purchasing Document Type";
            lPurchasDocNo := rec."Purchasing Order No.";
        END;

        PurchHeader.SETRANGE("Document Type", lPurchasDocType);
        PurchHeader.SETRANGE("No.", lPurchasDocNo);
        IF PurchHeader.ISEMPTY THEN
            ERROR(tPurhaseIsEmpty);
        IF rec."Purchasing Document Type" = rec."Purchasing Document Type"::Quote THEN BEGIN
            lPurchQuote.SETTABLEVIEW(PurchHeader);
            lPurchQuote.EDITABLE := FALSE;
            lPurchQuote.RUN;
        END ELSE
            IF rec."Purchasing Document Type" = rec."Purchasing Document Type"::Order THEN BEGIN
                //SUBCONTRACTOR//
                PurchOrder.SETTABLEVIEW(PurchHeader);
                PurchOrder.EDITABLE := FALSE;
                PurchOrder.RUN;
                //SUBCONTRACTOR
            END;
        //SUBCONTRACTOR//
    end;


    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record 38;
        PurchOrder: Page 50;
    begin
        rec.TESTFIELD("Special Order Purchase No.");
        PurchHeader.SETRANGE("No.", rec."Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN;
    end;


    procedure InsertExtendedText(Unconditionally: Boolean; pxRecNo: Code[20])
    var
        lInsertText: Boolean;
    begin
        /*Original code
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          gSaveRecord()
          TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          UpdateForm(TRUE);
        */

        lInsertText := NOT rec."Imported Line";

        //#6300----------
        lInsertText := rec."Item Reference No." = '';
        //#6300----------//

        IF lInsertText THEN BEGIN
            wNew := FALSE;
            IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
                //#5427
                IF rec."Item Reference No." = '' THEN BEGIN
                    //#5427//
                    //#RTC - 2009
                    //gSaveRecord();
                    CurrPage.SAVERECORD();
                    //#RTC - 2009//
                END;
                TransferExtendedText.InsertSalesExtText(Rec);
            END;
            TransferExtendedText2.wDeleteSalesLineDescription(Rec);
            IF TransferExtendedText.MakeUpdate OR
               TransferExtendedText2.wInsertSalesLineDescription(Rec)
            THEN BEGIN
                gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);
                //#5427
                IF rec."Item Reference No." = '' THEN
                    //#5427//
                    UpdateForm(TRUE);
            END;
        END;

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


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;


    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
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
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.GET(rec."Document Type", rec."Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record 99000880 temporary;
    begin
        OrderPromisingLine.SETRANGE("Source Type", rec."Document Type");
        OrderPromisingLine.SETRANGE("Source ID", rec."Document No.");
        OrderPromisingLine.SETRANGE("Source Line No.", rec."Line No.");
        Page.RUNMODAL(Page::"Order Promising Lines", OrderPromisingLine);
    end;


    procedure ToggleExpandCollapse(pExpandAll: Boolean)
    var
        lSalesLine: Record 37;
    begin
        IF gOneSubFormMgt.gToggleExpandCollapse(pExpandAll, ActualExpansionStatus, Rec, wMarked) THEN
            CurrPage.UPDATE;
    end;


    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment", Rec);
    end;


    procedure GetJobLedger()
    begin
        //MIG 5.00
        //GetJobUsage.SetCurrentSalesLine(Rec);
        //GetJobUsage.RUNMODAL;
        //CLEAR(GetJobUsage);
        MESSAGE('F8004048.GetJobLedger : Cette fonction est provisoirement désactivée');
        //MIG 5.00//
    end;


    procedure Move(MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lFatherLine: Record 37;
        lSalesLine: Record 37;
        lSalesLine2: Record 37;
        lSalesLineMng: Codeunit 8004061;
        lDirection: Integer;
        lEOF: Text[1];
        lFromRecRef: RecordRef;
        lFatherref: RecordRef;
        lLoadOK: Boolean;
        "---": Integer;
        lCount: Integer;
        lOldValue: Decimal;
    begin
        CLEAR(PresentationMgt);
        IF lSalesLine.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN
            lSalesLine2.SETCURRENTKEY("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        CurrPage.SETSELECTIONFILTER(lSalesLine2);
        IF MoveOpt IN [MoveOpt::Left, MoveOpt::Down] THEN BEGIN
            lEOF := '+';
            lDirection := -1;
        END ELSE BEGIN
            lEOF := '-';
            lDirection := 1;
        END;
        IF NOT lSalesLine2.ISEMPTY THEN BEGIN
            //#6115
            lFatherref.GETTABLE(SalesHeader);
            //#6115//
            lSalesLine2.FIND(lEOF);
            REPEAT
                lSalesLine.GET(lSalesLine2."Document Type", lSalesLine2."Document No.", lSalesLine2."Line No.");
                IF (lSalesLine."Presentation Code" = lSalesLine2."Presentation Code") AND NOT lSalesLine.MARK THEN BEGIN
                    CASE MoveOpt OF
                        MoveOpt::Left:
                            PresentationMgt.wLeft(lSalesLine, FALSE);
                        MoveOpt::Right:
                            PresentationMgt.wRight(lSalesLine, FALSE);
                        MoveOpt::Up:
                            PresentationMgt.wUp(lSalesLine, FALSE);
                        MoveOpt::Down:
                            PresentationMgt.wDown(lSalesLine, FALSE);
                        ELSE
                            ;
                    END;
                    lSalesLine."Value 10" := lOldValue;
                    IF lSalesLine.MODIFY THEN;
                    lSalesLine.MARK(TRUE);
                    //#6115
                    IF wBOQLoad THEN BEGIN
                        IF lSalesLine."Attached to Line No." <> 0 THEN BEGIN
                            lFatherLine.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Attached to Line No.");
                            lFatherref.GETTABLE(lFatherLine);
                        END;
                        lFromRecRef.GETTABLE(lSalesLine);
                        wBOQMgt.AssignFatherNode(lFatherref.RECORDID, lFromRecRef.RECORDID);
                        wBOQMgt.Save('');
                        //#9035
                        fRecalculateBOQ();
                        //#9035//
                    END;
                    //#6115//
                END;
                //9088
                lSalesLine2.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
            //9088//
            UNTIL lSalesLine2.NEXT(lDirection) = 0;
        END;
        CLEAR(lSalesLine2);
        IF lSalesLine2.GET(rec."Document Type", rec."Document No.", rec."Attached to Line No.") THEN
            lSalesLineMng.wUpdateTotalLine(lSalesLine2);
        rec.GET(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
        IF lSalesLine2.GET(rec."Document Type", rec."Document No.", rec."Attached to Line No.") THEN
            lSalesLineMng.wUpdateTotalLine(lSalesLine2);
        CurrPage.UPDATE(FALSE);
    end;


    procedure ShowColumns(var pPresentationCode: Code[10])
    var
        lClassicVisible: Boolean;
    begin
        IF SetupStudy.GET(pPresentationCode) THEN BEGIN
            //TRS-2009
            lClassicVisible := FALSE;
            lClassicVisible := SetupStudy."No.";
            lClassicVisible := SetupStudy."Location Code";
            lClassicVisible := SetupStudy."Customer Price Group";
            lClassicVisible := SetupStudy."Shipment Date";
            lClassicVisible := SetupStudy.Description;
            lClassicVisible := SetupStudy."Description 2";
            lClassicVisible := SetupStudy."Qty. per Unit of Measure";
            lClassicVisible := SetupStudy."Unit of Measure";
            lClassicVisible := SetupStudy.Quantity;
            lClassicVisible := SetupStudy."Quantity (Base)";
            lClassicVisible := SetupStudy."Qty. to Ship";
            lClassicVisible := SetupStudy."Quantity Shipped";
            lClassicVisible := SetupStudy."Qty. to Invoice";
            lClassicVisible := SetupStudy."Quantity Invoiced";
            lClassicVisible := SetupStudy."Profit %";
            lClassicVisible := SetupStudy."Unit Price";
            lClassicVisible := SetupStudy."Line Discount %";
            lClassicVisible := SetupStudy."Line Discount Amount";
            lClassicVisible := SetupStudy."Allow Invoice Disc.";
            lClassicVisible := SetupStudy."Shortcut Dimension 1 Code";
            lClassicVisible := SetupStudy."Shortcut Dimension 2 Code";
            lClassicVisible := SetupStudy."Job No.";
            lClassicVisible := SetupStudy."Job Task No.";
            lClassicVisible := SetupStudy."Work Type Code";
            lClassicVisible := SetupStudy."Gen. Prod. Posting Group";
            lClassicVisible := SetupStudy."VAT Prod. Posting Group";
            lClassicVisible := SetupStudy."VAT Bus. Posting Group";
            lClassicVisible := SetupStudy."Unit Cost";
            lClassicVisible := SetupStudy."Line Amount";
            lClassicVisible := SetupStudy."Variant Code";
            lClassicVisible := SetupStudy."Unit of Measure Code";
            lClassicVisible := SetupStudy."Substitution Available";
            lClassicVisible := SetupStudy."Cross-Reference No.";
            lClassicVisible := SetupStudy.Marker;
            lClassicVisible := SetupStudy."Non Stock";
            lClassicVisible := SetupStudy."Purchasing code";
            lClassicVisible := SetupStudy."Vendor No.";
            lClassicVisible := SetupStudy."Purch. Order Qty (Base)";
            lClassicVisible := SetupStudy."Purch. Order Receipt Date";
            lClassicVisible := SetupStudy."Purch. Order Rcpt. Qty (Base)";
            lClassicVisible := SetupStudy."Line Type";
            lClassicVisible := SetupStudy."Presentation Code";
            lClassicVisible := SetupStudy.Level;
            lClassicVisible := SetupStudy."Rate Amount";
            lClassicVisible := SetupStudy."Total Cost (LCY)";
            lClassicVisible := SetupStudy."Theoretical Profit Amount(LCY)";
            lClassicVisible := SetupStudy."Overhead Amount (LCY)";
            lClassicVisible := SetupStudy."Fixed Price";
            lClassicVisible := SetupStudy.SalesPriceExist;
            lClassicVisible := SetupStudy."Value 1";
            lClassicVisible := SetupStudy."Value 2";
            lClassicVisible := SetupStudy."Value 3";
            lClassicVisible := SetupStudy."Value 4";
            lClassicVisible := SetupStudy."Value 5";
            lClassicVisible := SetupStudy."Value 6";
            lClassicVisible := SetupStudy."Value 7";
            lClassicVisible := SetupStudy."Value 8";
            lClassicVisible := SetupStudy."Value 9";
            lClassicVisible := SetupStudy."Value 10";
            lClassicVisible := SetupStudy."Bill of quantities";
            lClassicVisible := SetupStudy."Job Costs (LCY)";
            lClassicVisible := SetupStudy."FA Posting Date";
            lClassicVisible := SetupStudy."Depreciation Book Code";
            lClassicVisible := SetupStudy."Depr. until FA Posting Date";
            lClassicVisible := SetupStudy."Amount 1";
            lClassicVisible := SetupStudy."Amount 2";
            lClassicVisible := SetupStudy."Amount 3";
            lClassicVisible := SetupStudy."Amount 4";
            lClassicVisible := SetupStudy."Amount 5";
            lClassicVisible := SetupStudy."Amount 6";
            lClassicVisible := SetupStudy."Amount 7";
            lClassicVisible := SetupStudy."Amount 8";
            lClassicVisible := SetupStudy."Amount 9";
            lClassicVisible := SetupStudy."Amount 10";
            lClassicVisible := SetupStudy."Person Quantity";
            //#6079
            lClassicVisible := SetupStudy."Person Quantity";
            //#6079
            lClassicVisible := SetupStudy."Total Cost LCY Excl. Person";
            lClassicVisible := SetupStudy.Rate;
            lClassicVisible := SetupStudy.Duration;
            lClassicVisible := SetupStudy.Subcontracting;
            lClassicVisible := SetupStudy."Completely Shipped";
            lClassicVisible := SetupStudy.Option;
            lClassicVisible := SetupStudy."Distribution Basis";
            lClassicVisible := SetupStudy."Distribution Method";
            lClassicVisible := SetupStudy."Job Cost Marked";
            lClassicVisible := SetupStudy."Unit-Amount Rounding Precision";
            lClassicVisible := SetupStudy."Gen. Prod. Posting Prorata";
            lClassicVisible := SetupStudy."Internal Description";
            lClassicVisible := SetupStudy."Job Costs Margin Included";
            lClassicVisible := SetupStudy."Inv. Discount Amount";
            lClassicVisible := SetupStudy."Print Option Line";
            lClassicVisible := SetupStudy."Depr. until FA Posting Date";
            lClassicVisible := SetupStudy."Fixed Price";
            lClassicVisible := SetupStudy."Sales Line Disc. Exists";
            lClassicVisible := SetupStudy."% to Invoice";
            lClassicVisible := SetupStudy."Non Valued Code";
            //#6409
            lClassicVisible := SetupStudy."Profit Amount";
            //#6409//
        END;
        xSetupStudy := SetupStudy;
        CurrPage.UPDATE(FALSE);
    end;


    procedure wEditable()
    var
        lEditable: Boolean;
    begin
        lEditable := (Rec."Line Type" <> Rec."Line Type"::Structure);
        "Unit Cost (LCY)Editable" := lEditable;
        lEditable := TRUE;
        IF lEditable AND (Rec."Line Type" <> Rec."Line Type"::Structure) THEN
            "Unit Cost (LCY)Editable" := TRUE
        ELSE
            "Unit Cost (LCY)Editable" := FALSE;
        "Unit PriceEditable" := lEditable;
        "Fixed PriceEditable" := lEditable;
        "Line Discount %Editable" := lEditable;
        "Line Discount AmountEditable" := lEditable;
        "Allow Invoice Disc.Editable" := lEditable;
        "Line AmountEditable" := lEditable;
    end;


    procedure wCalculateQty()
    var
        lCalcQty: Codeunit 8004051;
    begin
        /*GL2024   IF OkMetre <> 2 THEN
               IF Page.RUNMODAL(Page::"Quantity Calculation Form", Rec) <> ACTION::LookupOK THEN
                   Rec := xRec;*/
    end;


    procedure wFindLevel()
    var
        lLevel: Integer;
        i: Integer;
    begin
        IF rec."Line Type" = rec."Line Type"::Totaling THEN BEGIN
            lLevel := 1;
            IF rec."No." <> '.' THEN BEGIN
                FOR i := 1 TO STRLEN(rec."No.") DO
                    IF (rec."No."[i] = '.') AND (STRLEN(rec."No.") <> i) THEN
                        lLevel += 1;
            END;
            IF lLevel > rec.Level THEN BEGIN
                WHILE lLevel > rec.Level DO
                    Move(2);
            END
            ELSE IF lLevel < rec.Level THEN
                WHILE lLevel < rec.Level DO
                    Move(1);
        END;
    end;


    procedure ShowDescription()
    var
        lDescriptionLine: Record 8004075;
    begin
        //DESCRIPTION
        rec.TESTFIELD("Line No.");
        lDescriptionLine.ShowDescription(DATABASE::"Sales Line", rec."Document Type", rec."Document No.", rec."Line No.");
        //DESCRIPTION//
    end;


    procedure SetAfterGet(pPresentationCode: Code[10])
    var
        lRecRef: RecordRef;
        lSingleInstance: Codeunit 8001405;
    begin
        IF NOT SetupStudy.GET(pPresentationCode) THEN
            SetupStudy.INIT;
        IF NOT wFirst THEN
            rec.CLEARMARKS;
        rec.MARKEDONLY(wFirst);
        wMarked := FALSE;
        wFirst := FALSE;
        //#6115
        CLEAR(wBOQMgt);
        lRecRef.GETTABLE(SalesHeader);
        wBOQLoad := wBOQMgt.Load(lRecRef.RECORDID);
        //#6115//
    end;

    local procedure lAssistEdit()
    var
        lRec: Record 37;
        lxRec: Record 37;
        //GL2024   lSalesLineStc: Page 64054;
        lRecordRef: RecordRef;
        lCustomBoq: Codeunit 8003909;
    begin
        //#5348
        IF Rec.Description <> xRec.Description THEN BEGIN
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SAVERECORD();
            //#RTC - 2009//
        END;
        //#5348
        lxRec := Rec;
        lRec.COPY(Rec);
        lRec.FILTERGROUP(10);
        //#5447
        //IF (lRec."Line Type" = lRec."Line Type"::" ") AND (lRec."Attached to Line No." = 0) AND (lRec."No." = '') THEN
        IF (lRec."Attached to Line No." = 0) AND (lRec."No." = '') THEN
            EXIT;
        //#5447//
        IF (lRec."Line Type" = lRec."Line Type"::" ") AND (lRec."Attached to Line No." <> 0) AND (lRec."No." = '') THEN BEGIN
            lRec.SETRANGE("Document Type", lRec."Document Type");
            lRec.SETRANGE("Document No.", lRec."Document No.");
            lRec.SETRANGE("Line No.", lRec."Attached to Line No.");
            IF lRec.FINDFIRST THEN
                //#5447
                IF (lRec."Attached to Line No." = 0) AND (lRec."No." = '') THEN
                    EXIT;
            //#5447//
        END ELSE
            lRec.SETRECFILTER;
        lRec.FILTERGROUP(0);
        IF lRec.FINDFIRST THEN BEGIN
            //#7357
            //Page.RUNMODAL(Page::"Sales Line Structure",lRec);
            /*GL2024  lSalesLineStc.SETRECORD(lRec);
              lSalesLineStc.RUNMODAL();
              IF (lSalesLineStc.fRecalculateBOQ()) THEN BEGIN
                  lRecordRef.GETTABLE(Rec);
                  lCustomBoq.fCalcBOQRef(lRecordRef, TRUE, TRUE);
                  lCustomBoq.fFinalise();
                  Rec.wUpdateLine(Rec, lxRec, TRUE);
              END;*/
            //#7357//
        END;
        Rec.GET(rec."Document Type", rec."Document No.", rec."Line No.");
        CurrPage.UPDATE;

        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);
    end;


    /*GL2024 procedure wStructure()
     var
         lRec: Record 37;
         lxRec: Record 37;
     begin
         lxRec := Rec;
         lRec.COPY(Rec);
         lRec.FILTERGROUP(10);
         lRec.SETRECFILTER;
         lRec.FILTERGROUP(0);
         Page.RUNMODAL(Page::"Sales Line Structure", lRec);
         rec.FIND;
         //wUpdateLine(Rec,lxRec,FALSE);
         CurrPage.UPDATE;
     end;*/


    procedure wSupplyOrder()
    var
        lSupplyOrderMgt: Codeunit 8003954;
        lSalesLine: Record 37;
        //GL2024   lGenerateSupplyOrder: Report 8003958;
        lSalesHeader: Record 36;
        lSalesHeaderInternal: Record 36;
        lJobNo: Code[20];
        lSalesLine2: Record 37;
        lSalesLine3: Record 37;
        lFilterCount: Integer;
        lSalesList: Page 45;
    begin
        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        IF lSalesHeader.GET(rec."Document Type", rec."Document No.") THEN;
        IF lSalesLine.COUNT = 1 THEN BEGIN
            IF NOT CONFIRM(tOnlyOneLine, TRUE) THEN
                EXIT;
            //GL2024 IF lSupplyOrderMgt.fGenerateSupplyOrder(lSalesHeader, lSalesLine, rec."Job No.", lSalesHeaderInternal) THEN
            //GL2024 Page.RUNMODAL(Page::"Reordering Requisition", lSalesHeaderInternal);
        END
        ELSE BEGIN
            lSalesLine.FIND('-');
            REPEAT
                lSalesLine.MARK(TRUE);
            UNTIL lSalesLine.NEXT = 0;
            //#
            lSalesLine.MARKEDONLY(TRUE);
            lSalesLine3.SETCURRENTKEY("Job No.", "Job Task No.", "Document Type", "Gen. Prod. Posting Group", Disable, Option, "Line Type",
                "Structure Line No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            //#//
            lSalesLine3.COPYFILTERS(Rec);
            lSalesLine3.FIND('-');
            lJobNo := '';
            REPEAT
                IF lSalesLine.GET(lSalesHeader."Document Type", lSalesHeader."No.", lSalesLine3."Line No.") THEN BEGIN
                    IF (lJobNo <> lSalesLine."Job No.") THEN BEGIN
                        lSalesLine2.RESET;
                        lSalesLine2.COPYFILTERS(Rec);
                        CurrPage.SETSELECTIONFILTER(lSalesLine2);
                        lSalesLine2.SETRANGE("Job No.", lSalesLine3."Job No.");
                        IF lSupplyOrderMgt.fGenerateSupplyOrder(lSalesHeader, lSalesLine2, lSalesLine3."Job No.", lSalesHeaderInternal) THEN BEGIN
                            lFilterCount += 1;
                        END;
                    END;
                END;
                lJobNo := lSalesLine3."Job No.";
            UNTIL lSalesLine3.NEXT = 0;
            //COR SCRIPT DA
            lSalesHeaderInternal.SETFILTER("Job No.", lJobNo);
            //COR SCRIPT DA//
            IF lFilterCount > 1 THEN BEGIN
                lSalesHeaderInternal.MARKEDONLY(TRUE);
                lSalesList.SETTABLEVIEW(lSalesHeaderInternal);
                lSalesList.RUNMODAL;
            END
            //GL2024 ELSE
            //GL2024 Page.RUNMODAL(Page::"Reordering Requisition", lSalesHeaderInternal);
        END;
        //#6630//
    end;


    procedure wFindSupplyOrder()
    var
        lSupplyOrderMgt: Codeunit 8003954;
    begin
        lSupplyOrderMgt.FindLinesOrder(Rec);
    end;


    procedure wCalcJobCostRepartition()
    begin
        CODEUNIT.RUN(CODEUNIT::"Job Cost Assignment", Rec);
    end;


    procedure lMetre()
    var
        lRec: Record 37;
        lxRec: Record 37;
        lSetupSty: Record 8003994;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit 8003909;
    begin
        //#8919
        /*
        IF lSetupSty.GET THEN
          IF NOT lSetupSty."Formula desactivated / Sales" THEN BEGIN
            rec.TESTFIELD("Value 1",0);
            rec.TESTFIELD("Value 2",0);
            rec.TESTFIELD("Value 3",0);
            rec.TESTFIELD("Value 4",0);
            rec.TESTFIELD("Value 5",0);
            rec.TESTFIELD("Value 6",0);
            rec.TESTFIELD("Value 7",0);
            rec.TESTFIELD("Value 8",0);
            rec.TESTFIELD("Value 9",0);
            rec.TESTFIELD("Value 10",0);
        END;
        //#6115
        IF rec."Line Type" = rec."Line Type"::" " THEN
          EXIT;
        lRecRef.GETTABLE(Rec);
        IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
          EXIT;
        //#6115//
        FIND;
        rec.wUpdateLine(Rec,lxRec,TRUE);
        CurrForm.UPDATE;
        //#6115
         CLEAR(wBOQMgt);
         lRecRef.GETTABLE(SalesHeader);
         wBOQLoad := wBOQMgt.Load(lRecRef.RECORDID);
        //#6115//
        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText,Rec,wMarked);
        */
        gOneSubFormMgt.fShowBOQ(wBOQMgt, Rec, wShowExtendedText, wMarked, wBOQLoad);
        CurrPage.UPDATE;
        //#8919//

    end;


    procedure wGenerateSubcontracting()
    var
        lSalesHeader: Record 36;
        lSalesLine: Record 37;
    //GL2024 lGenerateSubcontracting: Report 8003982;
    begin
        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        IF lSalesLine.COUNT = 1 THEN
            IF NOT CONFIRM(tOnlyOneLine, TRUE) THEN
                EXIT;
        IF lSalesHeader.GET(rec."Document Type", rec."Document No.") THEN;
        //GL2024  lGenerateSubcontracting.SETTABLEVIEW(lSalesLine);
        //GL2024 lGenerateSubcontracting.RUNMODAL;
    end;


    procedure wFormatFields()
    var
        lTransferOrderLink: Record 8003972;
    begin
        IF rec.Option THEN
            ForeColor := 8421504 //Grey
        ELSE IF rec."Assignment Basis" <> 0 THEN
            ForeColor := 16711680 // Blue
        ELSE
            ForeColor := 0;
        FontBold := (rec."Line Type" = rec."Line Type"::Totaling);
    end;


    procedure wCostEditable(): Boolean
    var
        lSalesLine: Record 37;
    begin
        IF (rec.Type <> rec.Type::" ") THEN
            IF Rec."Line Type" <> Rec."Line Type"::Structure THEN
                EXIT(TRUE)
            ELSE
                EXIT(Rec.Subcontracting = Rec.Subcontracting::"Furniture and Fixing");
        EXIT(FALSE);
    end;


    procedure wSetMarked(pMarked: Boolean; var pShowExtendText: Boolean)
    var
        lRec: Record 37;
        lRecRef: RecordRef;
    begin
        gOneSubFormMgt.gSetMarked(pMarked, pShowExtendText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
    end;


    procedure wSetVarMarked(pMarked: Boolean; pShowExtendText: Boolean)
    var
        lRec: Record 37;
    begin
        wMarked := pMarked;
        wShowExtendedText := pShowExtendText;
    end;


    procedure wPassEnt(pEnt: Record 36)
    begin
        rec.SETRANGE("Document Type", pEnt."Document Type");
        rec.SETRANGE("Document No.", pEnt."No.");
        SalesHeader.COPY(pEnt);
    end;


    procedure wGroupCrossRef()
    var
        lSalesCrossRefMgt: Codeunit 8004063;
    begin
        lSalesCrossRefMgt.wGroup(Rec);
    end;


    procedure wUnGroupCrossRef()
    var
        lSalesCrossRefMgt: Codeunit 8004063;
    begin
        //#6814
        IF (rec."Cross-Ref. Line No." <> 0) AND (rec."Cross-Ref. Line No." <> rec."Line No.") THEN
            IF rec.GET(rec."Document Type", rec."Document No.", rec."Cross-Ref. Line No.") THEN
                CurrPage.UPDATE(FALSE);
        //#6814//

        lSalesCrossRefMgt.wUnGroup(Rec, FALSE);
    end;


    procedure wOnLookup()
    var
        lxRecNo: Code[20];
        lMultiple: Boolean;
        lSalesPriceMgt: Codeunit 7000;
        lRec: Record 37;
        lRecNo: Code[20];
        lRecRef: RecordRef;
    begin
        lxRecNo := xRec."No.";
        IF rec."Line Type" = rec."Line Type"::Other THEN
            rec."Line Type" := rec."Line Type"::Structure;

        IF rec.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, gBelowxrec) THEN
            IF (rec."No." <> '') OR lMultiple THEN BEGIN
                lRecNo := rec."No.";
                IF (rec."Line Type" > rec."Line Type"::" ") THEN
                    IF NOT lRec.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN
                        rec."Line No." := rec.wGetLastCurrNo(rec."Document Type", rec."Document No.", 10000);
                rec."No." := lRecNo;
                IF NOT lMultiple THEN BEGIN
                    //#RTC - 2009
                    //gSaveRecord();
                    CurrPage.SAVERECORD();
                    //#RTC - 2009//
                END;
                wKOLookup := lMultiple;
                IF (lxRecNo = '') AND NOT lMultiple THEN
                    PresentationMgt.wModifyRecordTextWithNo(Rec);
                IF NOT lMultiple THEN
                    OnAfterLookup(lxRecNo);
                //Affichage
                IF lMultiple AND (wMarked OR NOT wShowExtendedText) THEN BEGIN
                    lRec := Rec;
                    rec.MARKEDONLY(FALSE);
                    rec.SETRANGE(rec.Level, rec.Level - 1, rec.Level);
                    rec.SETFILTER("Presentation Code", '%1', COPYSTR(rec."Presentation Code", 1, STRLEN(rec."Presentation Code") - 3) + '*');
                    IF rec.FIND('+') THEN
                        REPEAT
                            rec.MARK(wShowExtendedText OR NOT ((rec."Attached to Line No." <> 0) AND (rec."Line Type" = rec."Line Type"::" ")))
                        UNTIL rec.NEXT(-1) = 0;
                    rec.SETRANGE(Level);
                    rec.SETRANGE(rec."Presentation Code");
                    rec.GET(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                    rec.MARKEDONLY(TRUE);
                END;
                //#6115
                lRecRef.GETTABLE(SalesHeader);
                wBOQLoad := wBOQMgt.Load(lRecRef.RECORDID);
                //#6115//
                CurrPage.UPDATE;
                //Affichage//
            END;
    end;


    procedure wCopyLine(pArchive: Boolean)
    var
        lSalesLine: Record 37;
        //GL2024     lCopyStructure: Report 8004070;
        //GL2024    lCopyLine: Page 64073;
        lRecRef: RecordRef;
    //GL2024   lCopyLineArchive: Page 64086;
    begin
        IF rec.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN
            ERROR(ErrorInsert);
        //#RTC - 2009
        //gSaveRecord();   sd : gsaverecord remplace currform.saverecord mais insert ds fonction
        CurrPage.SAVERECORD();
        //#RTC - 2009//

        lSalesLine.COPY(Rec);
        lSalesLine.NEXT(-1);

        /*//GL2024     CLEAR(lCopyLine);
            //#8254
            IF (pArchive) THEN BEGIN
                lCopyLineArchive.SetToSalesLine(Rec);
                lCopyLineArchive.RUNMODAL;
            END ELSE BEGIN
                lCopyLine.SetToSalesLine(Rec);
                lCopyLine.RUNMODAL;
            END;*/
        //#8254//

        rec.COPY(lSalesLine);
        gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
        //#6115
        CLEAR(wBOQMgt);
        lRecRef.GETTABLE(SalesHeader);
        wBOQLoad := wBOQMgt.Load(lRecRef.RECORDID);
        //#6115//
        CurrPage.UPDATE(FALSE);
    end;


    procedure OnAfterLookup(pxRecNo: Code[20])
    var
        lSalesHeader: Record 36;
        lSalesLine: Record 37;
        lSalesPriceMgt: Codeunit 7000;
        lBoqCalcMgt: Codeunit 8001445;
    begin
        IF (rec."Line Type" = rec."Line Type"::Structure) AND (rec."No." <> '') THEN BEGIN
            StructureMgt.ExplodeStructure(Rec);
            //#7128
            lBoqCalcMgt.fFinalize();
            //#7128//
            SubcontractingMgt.UpdateSubcontractor(Rec);
            COMMIT;
            wNavibatSetup.GET2;
            IF (rec."Structure Line No." = 0) AND
               (wNavibatSetup."Profit Calculation Method" = wNavibatSetup."Profit Calculation Method"::Structure) THEN BEGIN
                xRec."Unit Price" := rec."Unit Price";
                lSalesHeader.GET(rec."Document Type", rec."Document No.");
                lSalesPriceMgt.FindSalesLineLineDisc(lSalesHeader, Rec);
                lSalesPriceMgt.FindSalesLinePrice(lSalesHeader, Rec, rec.FIELDNO("No."));
                Overhead.SalesLine(Rec, FALSE, TRUE);
                StructureMgt.SumStructureLines(Rec);
            END;
            rec.wUpdateLine(Rec, xRec, TRUE);
        END;

        IF NOT wKOLookup THEN
            InsertExtendedText(FALSE, pxRecNo);
    end;


    procedure wTransfer()
    var
        lSalesLine: Record 37;
        lSalesLine2: Record 37;
        //GL2024  lGenerateTransfer: Report 8003972;
        lSalesHeader: Record 36;
    begin
        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        lSalesLine2.COPY(lSalesLine);
        lSalesLine2.SETRANGE("Structure Line No.", 0);
        lSalesLine2.SETFILTER("Quantity Shipped", '<>%1', 0);
        IF NOT lSalesLine2.ISEMPTY THEN
            ERROR(tErrorTransfer);

        IF lSalesLine.COUNT = 1 THEN
            IF NOT CONFIRM(tOnlyOneLine, TRUE) THEN
                EXIT;
        IF lSalesHeader.GET(rec."Document Type", rec."Document No.") THEN;
        /*//GL2024    lGenerateTransfer.InitRequest(lSalesHeader);
           lGenerateTransfer.SETTABLEVIEW(lSalesLine);
           lGenerateTransfer.RUNMODAL;
           lGenerateTransfer.RecupCdeCession(lSalesLine);*/


        /*//GL2024     IF lSalesHeader.GET(lSalesLine."Document Type", lSalesLine."Document No.") THEN
                Page.RUNMODAL(Page::"Internal Order", lSalesHeader);*/
    end;


    procedure wFindTransfer()
    var
        lSupplyOrderMgt: Codeunit 8003954;
    begin
        lSupplyOrderMgt.FindTransfer(Rec);
    end;


    procedure gGenerateDropShipment()
    var
        lSalesHeader: Record 36;
        lSalesLine: Record 37;
    //GL2024    lGenerateDropShipment: Report 8003979;
    begin
        lSalesLine.COPYFILTERS(Rec);
        CurrPage.SETSELECTIONFILTER(lSalesLine);
        IF lSalesLine.COUNT = 1 THEN
            IF NOT CONFIRM(tOnlyOneLine, TRUE) THEN
                EXIT;
        IF lSalesHeader.GET(rec."Document Type", rec."Document No.") THEN;
        //GL2024     lGenerateDropShipment.SETTABLEVIEW(lSalesLine);
        //GL2024    lGenerateDropShipment.RUNMODAL;
    end;


    procedure wCalculateCurrentBOQ(pField: Integer)
    var
        lxRec: Record 37;
        lSetupSty: Record 8003994;
        lDialog: Dialog;
        lTextProcess: Label 'Calculation underway...';
        lBOQCustMgt: Codeunit 8003909;
        lRecRef: RecordRef;
    begin
        //#5771
        lDialog.OPEN(lTextProcess);
        IF lSetupSty.GET THEN
            IF NOT lSetupSty."Formula desactivated / Sales" THEN BEGIN
                rec.TESTFIELD("Value 1", 0);
                rec.TESTFIELD("Value 2", 0);
                rec.TESTFIELD("Value 3", 0);
                rec.TESTFIELD("Value 4", 0);
                rec.TESTFIELD("Value 5", 0);
                rec.TESTFIELD("Value 6", 0);
                rec.TESTFIELD("Value 7", 0);
                rec.TESTFIELD("Value 8", 0);
                rec.TESTFIELD("Value 9", 0);
                rec.TESTFIELD("Value 10", 0);
            END;

        IF NOT (rec."Line Type" IN
                 [rec."Line Type"::Item, rec."Line Type"::Person, rec."Line Type"::Machine, rec."Line Type"::Structure, rec."Line Type"::Totaling]) THEN
            EXIT;
        lxRec := Rec;

        SalesHeader.GET(rec."Document Type", rec."Document No.");

        //#6115
        lRecRef.GETTABLE(SalesHeader);
        lBOQCustMgt.fCalcBOQRef(lRecRef, TRUE, TRUE);
        //#7128
        lBOQCustMgt.fFinalise();
        //#7128//
        //#6115//

        IF rec.FIND THEN;
        rec.wUpdateLine(Rec, lxRec, TRUE);
        CurrPage.UPDATE;

        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);

        lDialog.CLOSE;
        //#5771
    end;


    procedure fCalculateProfitAmount()
    begin
        //#7127
        /*
        IF SalesHeader."Currency Code" = '' THEN
          gProfitAmount := "Line Amount" -
            ("Total Cost (LCY)"  + "Overhead Amount (LCY)" +  "Job Costs (LCY)"  - "Job Costs Margin Included")
        ELSE
          gProfitAmount := "Line Amount" -
            (("Total Cost (LCY)"  + "Overhead Amount (LCY)" +  "Job Costs (LCY)"  - "Job Costs Margin Included") *
             SalesHeader."Currency Factor");
        */
        gProfitAmount :=
           rec."Amount Excl. VAT (LCY)" - (rec."Total Cost (LCY)" + rec."Overhead Amount (LCY)" + rec."Job Costs (LCY)" - rec."Job Costs Margin Included");
        //##8422 condition erronée
        IF SalesHeader."Currency Code" <> '' THEN
            gProfitAmount := gProfitAmount * SalesHeader."Currency Factor";
        //#7127//

    end;


    procedure fRecalculateBOQ()
    var
        lRecordID: RecordID;
        lRecordRef: RecordRef;
    begin
        //#7427
        lRecordRef.GETTABLE(Rec);
        lRecordID := lRecordRef.RECORDID;
        IF (wNavibatSetup.ISEMPTY()) THEN
            wNavibatSetup.GET2();
        IF ((NOT wNavibatSetup."Disable BOQ Calculation") AND (Rec."Line Type" = Rec."Line Type"::Structure) AND
           (wBOQMgt.fHasBOQ(lRecordID, TRUE))) THEN BEGIN
            wCalculateCurrentBOQ(Rec.FIELDNO(Quantity));
        END;
        //#7427//
    end;


    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END ELSE
            EXIT(TRUE);
    end;


    procedure ShowLineCard()
    begin
        //#7652
        Rec.fShowLineCard;
        //#7652//
    end;


    procedure fHasVarReferenceField(pFieldNo: Integer) Retour: Boolean
    var
        lRecordRef: RecordRef;
        lRecordID: RecordID;
    begin
        //#7768
        Retour := FALSE;
        lRecordRef.GETTABLE(Rec);
        lRecordID := lRecordRef.RECORDID;
        IF (wNavibatSetup.ISEMPTY()) THEN
            wNavibatSetup.GET2();
        IF ((NOT wNavibatSetup."Disable BOQ Calculation") AND
           (Rec."Line Type" = Rec."Line Type"::Structure) AND
           (wBOQMgt.fHasBOQ(lRecordID, TRUE))) THEN BEGIN
            Retour := wBOQMgt.HasReferenceVariable(lRecordID, pFieldNo)
        END;
        //#7768//
    end;


    procedure fOnInsert(pBelowxRec: Boolean) Retour: Boolean
    begin
        Retour := TRUE;
        IF wKOLookup THEN BEGIN
            wKOLookup := FALSE;
            Retour := FALSE;
        END ELSE BEGIN
            gBelowxrec := FALSE;
            IF wMarked OR NOT wShowExtendedText THEN
                rec.MARK(TRUE);
        END;
    end;


    procedure fOnModify()
    begin
        gBelowxrec := FALSE;
    end;


    procedure gSaveRecord()
    var
        lSalesLine: Record 37;
    begin
        IF lSalesLine.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN BEGIN
            rec.MODIFY(TRUE);
            fOnModify();
        END ELSE IF rec.INSERT(TRUE) THEN
                fOnInsert(FALSE);
    end;

    local procedure LineTypeOnAfterValidate()
    var
        lRec: Record 37;
        lSalesLineMng: Codeunit 8004061;
        lRecLineType: Option;
        lLevel: Integer;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit 8003909;
        lBOQMgt: Codeunit 8001446;
        lUpdate: Boolean;
    begin
        //#4688
        //#RTC - 2009
        lUpdate := NOT ISSERVICETIER;
        //#RTC - 2009//
        lRecLineType := rec."Line Type";
        IF (rec."Line Type" > rec."Line Type"::" ") THEN
            IF NOT lRec.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN
                rec."Line No." := rec.wGetLastCurrNo(rec."Document Type", rec."Document No.", 10000);
        rec."Line Type" := lRecLineType;
        //#4688//

        lRec := xRec;
        IF (xRec."Line Type" <> rec."Line Type") THEN BEGIN
            IF (xRec."Line Type" <> rec."Line Type"::" ") THEN
                TransferExtendedText2.wDeleteSalesLineDescription(Rec)
            ELSE
                PresentationMgt.wInsertBetweenExtendedText(Rec, xRec);
        END;
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//

        //#6115
        lRecRef.GETTABLE(SalesHeader);
        IF lBOQMgt.Load(lRecRef.RECORDID) THEN
            lBOQCustMgt.gMoveChid(Rec);
        //#6115//

        wEditable;

        CurrPage.UPDATE(lUpdate);

        IF rec."Line Type" = rec."Line Type"::Totaling THEN
            lSalesLineMng.wUpdateTotalLine(Rec);
        CurrPage.UPDATE(lUpdate);
    end;

    local procedure NoOnAfterValidate()
    var
        lSalesHeader: Record 36;
        lSalesPriceMgt: Codeunit 7000;
        lxRecNo: Code[20];
        lMultiple: Boolean;
        lRec: Record 37;
        lxRec: Record 37;
        lRecNo: Code[20];
        lxLineNo: Integer;
    begin
        lxRecNo := xRec."No.";
        //#4688
        lRecNo := rec."No.";
        //#9178
        lxLineNo := rec."Line No.";
        //#9178//
        IF (rec."Line Type" > rec."Line Type"::" ") THEN
            IF NOT lRec.GET(rec."Document Type", rec."Document No.", rec."Line No.") THEN
                rec."Line No." := rec.wGetLastCurrNo(rec."Document Type", rec."Document No.", 10000);
        rec."No." := lRecNo;
        //#4688//

        //#9178
        //GL2024   gOneSubFormMgt.fUpdateDimension(lxLineNo, Rec);
        //#9178//

        IF NOT wKOLookup THEN BEGIN
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SAVERECORD();
            //#RTC - 2009//
        END;
        IF wOKLookup AND (rec."No." <> '') THEN BEGIN
            COMMIT;
            rec.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, gBelowxrec);
            wKOLookup := lMultiple;
            wOKLookup := FALSE;
            lxRecNo := rec."No.";
            IF lMultiple AND (wMarked OR NOT wShowExtendedText) THEN BEGIN
                lRec := Rec;
                rec.MARKEDONLY(FALSE);
                rec.SETRANGE(Level, rec.Level - 1, rec.Level);
                rec.SETFILTER("Presentation Code", '%1', COPYSTR(rec."Presentation Code", 1, STRLEN(rec."Presentation Code") - 4) + '*');
                IF rec.FIND('+') THEN
                    REPEAT
                        IF wShowExtendedText OR NOT ((rec."Attached to Line No." <> 0) AND (rec."Line Type" = rec."Line Type"::" ")) THEN
                            rec.MARK(TRUE);
                    UNTIL rec.NEXT(-1) = 0;
                rec.SETRANGE(Level);
                rec.SETRANGE("Presentation Code");
                rec.GET(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                rec.MARKEDONLY(TRUE);
            END;
        END;

        IF (lxRecNo = '') AND NOT wKOLookup THEN
            PresentationMgt.wModifyRecordTextWithNo(Rec);

        OnAfterLookup(lxRecNo);
        //#7427
        fRecalculateBOQ();
        //#7427//
        CurrPage.UPDATE;
        wKOLookup := FALSE;
    end;

    local procedure OptionOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure AssignmentBasisOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure JobCostAssignmentOnAfterValida()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SubcontractingOnAfterValidate()
    var
        lSCRefMgt: Codeunit 8004062;
    begin
        //#6300---------
        lSCRefMgt.wUpdateField(Rec, rec.Subcontracting, rec.FIELDNO(Subcontracting));
        //lSCRefMgt.wUpdateSubContracting(Rec);
        //#6300----------//

        CurrPage.UPDATE;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    var
        lSalesHeader: Record 36;
        lSalesPriceMgt: Codeunit 7000;
        lxRecNo: Code[20];
        lSalesLine: Record 37;
        lToSalesLineComp: Record 37;
    begin
        //BAT
        lxRecNo := xRec."No.";
        //#6068
        //#8186
        //IF (xRec."No." <> '') THEN BEGIN
        IF (xRec."No." <> '') AND (xRec."Line Type" <> xRec."Line Type"::Totaling) THEN BEGIN
            //#8186//
            //#6068
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SAVERECORD();
            //#RTC - 2009//
        END;
        //#5428 : Comme la désignation
        IF (xRec.Description <> rec.Description) OR (xRec."Description 2" <> rec."Description 2") THEN
            //#5428//
            InsertExtendedText(FALSE, lxRecNo);
        CurrPage.UPDATE(FALSE);
        //BAT//
    end;

    local procedure VendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure DescriptionOnAfterValidate()
    var
        lSCRefMgt: Codeunit 8004062;
    begin
        //#6300----------
        //IF "No." <> '' THEN
        //  CurrForm.UPDATE;
        //IF "Cross-Reference No." <> '' THEN
        //  lSCRefMgt.wValidateExtendedText(Rec);
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        lSCRefMgt.wUpdateField(Rec, rec.Description, rec.FIELDNO(Description));
        //lSCRefMgt.wValidateExtendedText(Rec);
        CurrPage.UPDATE(FALSE);
        //#6300----------//
    end;

    local procedure Description2OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value1OnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    local procedure Value2OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value3OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value4OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value5OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value6OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value7OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value8OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value9OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Value10OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure QuantityOnAfterValidate()
    var
        TextCompletion: Label 'You cannot change a completion document.';
    begin
        //PROJET_FACT
        IF (rec."Document Type" IN [rec."Document Type"::Invoice, rec."Document Type"::"Credit Memo"]) AND
            (rec."Scheduler Line No." <> 0) THEN
            ERROR(TextCompletion);
        //PROJET_FACT//

        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SAVERECORD();
            //#RTC - 2009//
            rec.AutoReserve;
        END;
        CurrPage.UPDATE;
    end;

    local procedure QtyperUnitofMeasureOnAfterVali()
    begin
        //#6806
        CurrPage.UPDATE;
        //#6806
    end;

    local procedure QuantityBaseOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    var
        lSCRefMgt: Codeunit 8004062;
    begin
        IF rec.Reserve = rec.Reserve::Always THEN BEGIN
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SAVERECORD();
            //#RTC - 2009//
            rec.AutoReserve;
        END;

        //#6300---------
        lSCRefMgt.wUpdateField(Rec, rec."Unit of Measure Code", rec.FIELDNO("Unit of Measure Code"));
        //lSCRefMgt.wUpdateUnitOfMeasure(Rec);
        CurrPage.UPDATE;
        //#6300----------//
    end;

    local procedure RateOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        rec.wUpdateLine(Rec, xRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure DurationOnAfterValidate()
    begin
        rec.wUpdateLine(Rec, xRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure UnitCostLCYOnAfterValidate()
    var
        lxRec: Record 37;
    begin
        lxRec := xRec;
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        rec.wUpdateLine(Rec, lxRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure OverheadAmountLCYOnAfterValida()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        rec.wUpdateLine(Rec, xRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure wProfitOnAfterValidate()
    var
        lClassicVisible: Boolean;
    begin
        //DELETE-RTC2009
        lClassicVisible := TRUE;
        wNavibatSetup.MarginRateOnValidate(wProfit);
        StructureMgt.wSetProfit(Rec, wProfit, lClassicVisible);
        CurrPage.UPDATE(TRUE);
    end;

    local procedure UnitPriceOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        //wUpdateLine(Rec,xRec,FALSE);
        CurrPage.UPDATE;
    end;

    local procedure UnitAmountRoundingPrecisionOnA()
    begin
        //#7190
        CurrPage.UPDATE;
        //#7190//
    end;

    local procedure LineAmountOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        rec.wUpdateLine(Rec, xRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure FixedPriceOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
        //"Fixed price" := xRec."Fixed Price";
    end;

    local procedure LineDiscount37OnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        //wUpdateLine(Rec,xRec,FALSE);
        CurrPage.UPDATE;
    end;

    local procedure LineDiscountAmountOnAfterValid()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SAVERECORD();
        //#RTC - 2009//
        rec.wUpdateLine(Rec, xRec, FALSE);
        CurrPage.UPDATE;
    end;

    local procedure PersonQuantityOnAfterValidate()
    begin
        //#6079
        CurrPage.UPDATE(FALSE);
        //#6079//
    end;

    local procedure wQtyPersonPerUnitOnAfterValida()
    begin
        //#6079
        CurrPage.UPDATE(FALSE);
        //#6079//
    end;

    local procedure OnAfterGetCurrRecord()
    var
        lSalesLine: Record 37;
        lSingleInstance: Codeunit 8001405;
        lEditable: Boolean;
    begin
        xRec := Rec;
        wFormatFields;
        wRecordRef.CLOSE;
        CASE rec.Type OF
            rec.Type::Item:
                wRecordRef.OPEN(27);
            rec.Type::Resource:
                wRecordRef.OPEN(156);
            ELSE
                wRecordRef.OPEN(36);
        END;
        gBelowxrec := FALSE;

        //#6079
        lEditable := rec."Line Type" = rec."Line Type"::Structure;
        QtyPersonPerUntEditable := lEditable;
        //#6079
        //mise à jour du coût unitaire
        "Unit Cost (LCY)Editable" := wCostEditable;
        //COMMIT-LINE
        lSingleInstance.wSetIntegrityVerify(FALSE);
        //COMMIT-LINE//
        lEditable := NOT rec."Fixed Price" AND (rec.Type <> rec.Type::" ");
        TMEditable := lEditable;
        IF (rec."Document No." <> xRec."Document No.") AND (wMarked OR NOT wShowExtendedText) THEN
            gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);

        //#8281
        //lEditable := (wQtySetup."Formula desactivated / Sales" AND NOT("Line Type" IN ["Line Type"::Totaling,"Line Type"::Structure]))
        //             OR (NOT wQtySetup."Formula desactivated / Sales" AND (OkMetre <> 2));
        IF (wQtySetup."Formula desactivated / Sales") THEN BEGIN
            lEditable := NOT (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure]);
            IF wQtySetup."Value 1 Total" THEN
                "Value 1Editable" := lEditable;
            IF wQtySetup."Value 2 Total" THEN
                "Value 2Editable" := lEditable;
            IF wQtySetup."Value 3 Total" THEN
                "Value 3Editable" := lEditable;
            IF wQtySetup."Value 4 Total" THEN
                "Value 4Editable" := lEditable;
            IF wQtySetup."Value 5 Total" THEN
                "Value 5Editable" := lEditable;
            IF wQtySetup."Value 6 Total" THEN
                "Value 6Editable" := lEditable;
            IF wQtySetup."Value 7 Total" THEN
                "Value 7Editable" := lEditable;
            IF wQtySetup."Value 8 Total" THEN
                "Value 8Editable" := lEditable;
            IF wQtySetup."Value 9 Total" THEN
                "Value 9Editable" := lEditable;
            IF wQtySetup."Value 10 Total" THEN
                "Value 10Editable" := lEditable;
        END ELSE BEGIN
            lEditable := (OkMetre <> 2);
            "Value 1Editable" := lEditable;
            "Value 2Editable" := lEditable;
            "Value 3Editable" := lEditable;
            "Value 4Editable" := lEditable;
            "Value 5Editable" := lEditable;
            "Value 6Editable" := lEditable;
            "Value 7Editable" := lEditable;
            "Value 8Editable" := lEditable;
            "Value 9Editable" := lEditable;
            "Value 10Editable" := lEditable;
        END;
        //#8281//
        lEditable := OkMetre <> 2;
        QuantityEditable := lEditable;

        IF rec.Quantity <> 0 THEN
            QtyCumToInv := (rec."Quantity Invoiced" + rec."Qty. to Invoice") / rec.Quantity * 100
        ELSE
            QtyCumToInv := 0;
    end;

    local procedure FixedPriceOnActivate()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := rec."Line Type" <> rec."Line Type"::Totaling;
        "Fixed PriceEditable" := lEditable;
        //TRS-2009//
    end;

    local procedure AllowInvoiceDiscOnActivate()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := rec."Line Type" <> rec."Line Type"::Totaling;
        "Allow Invoice Disc.Editable" := lEditable;
        //TRS-2009//
    end;

    local procedure OnActivateForm()
    var
        lSalesOverhead: Record 8004061;
    begin
        IF rec."Document No." <> '' THEN BEGIN
            IF SalesHeader.GET(rec."Document Type", rec."Document No.") THEN;
            lSalesOverhead.SETRANGE("Document Type", rec."Document Type");
            lSalesOverhead.SETRANGE("Document No.", rec."Document No.");
            IF lSalesOverhead.ISEMPTY THEN BEGIN
                IF (SalesHeader."Sell-to Customer No." <> '') OR (SalesHeader."Sell-to Customer Templ. Code" <> '') THEN
                    CODEUNIT.RUN(CODEUNIT::"Overhead Calculation", SalesHeader);
            END;
            CODEUNIT.RUN(CODEUNIT::"Sales RollBack Mgt", SalesHeader);
        END;
    end;

    local procedure NoOnAfterInput(var Text: Text[1024])
    var
        lCode: Code[20];
        lCodeOrig: Code[20];
        lRes: Record 156;
    begin
        IF (rec."No." <> '') AND wOKLookup THEN
            Text := rec."No.";

        lCode := Text;
        lCodeOrig := Text;
        //#4754
        wRecordRef.CLOSE;
        //#4754//
        IF NOT wKOLookup THEN
            CASE rec."Line Type" OF
                rec."Line Type"::Item:
                    BEGIN
                        wRecordRef.OPEN(27);
                        Search.Search(wRecordRef, lCode);
                        IF lCode > ' ' THEN
                            Text := lCode
                        ELSE BEGIN
                            IF Text <> '' THEN
                                wOKLookup := TRUE;
                        END;
                    END;
                rec."Line Type"::Person, rec."Line Type"::Machine, rec."Line Type"::Structure:
                    BEGIN
                        CASE rec."Line Type" OF
                            rec."Line Type"::Person:
                                lRes.SETRANGE(Type, lRes.Type::Person);
                            rec."Line Type"::Machine:
                                lRes.SETRANGE(Type, lRes.Type::Machine);
                            rec."Line Type"::Structure:
                                lRes.SETRANGE(Type, lRes.Type::Structure);
                        END;
                        wRecordRef.GETTABLE(lRes);
                        Search.Search(wRecordRef, lCode);
                        IF lCode > ' ' THEN
                            Text := lCode
                        ELSE
                            IF Text <> '' THEN BEGIN  //Erreur ou pas de sélection
                                wOKLookup := TRUE;
                                Text := '???' + lCodeOrig;
                            END;
                    END;
            END;
    end;

    local procedure QuantityOnBeforeInput()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := OkMetre <> 2;
        QuantityEditable := lEditable;
        //TRS-2009//
    end;

    local procedure LineDiscount37OnBeforeInput()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := rec."Line Type" <> rec."Line Type"::Totaling;
        "Line Discount %Editable" := lEditable;
        //TRS-2009//
    end;

    local procedure LineDiscountAmountOnBeforeInpu()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := rec."Line Type" <> rec."Line Type"::Totaling;
        "Line Discount AmountEditable" := lEditable;
        //TRS-2009//
    end;

    local procedure ActualExpansionStatusOnPush()
    var
        lRec: Record 37;
    begin
        IF (rec."Line Type" = 0) AND (rec."Attached to Line No." <> 0) THEN BEGIN
        END
        ELSE IF ActualExpansionStatus > 1 THEN
            lAssistEdit
        ELSE BEGIN
            IF NOT wMarked THEN BEGIN
                lRec.COPY(Rec);
                IF rec.FIND('-') THEN
                    REPEAT
                        rec.MARK(TRUE);
                    UNTIL rec.NEXT = 0;
                rec.GET(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                rec.MARKEDONLY(TRUE);
                wMarked := TRUE;
            END;
            IF wMarked THEN
                CASE ActualExpansionStatus OF
                    0:
                        BEGIN
                            rec.MARKEDONLY(FALSE);
                            rec.SETRANGE(Level, rec.Level, rec.Level + 1);
                            rec.SETFILTER("Presentation Code", '%1', rec."Presentation Code" + '*');
                            IF rec.FIND('+') THEN
                                REPEAT
                                    IF wShowExtendedText OR NOT ((rec."Attached to Line No." <> 0) AND (rec."Line Type" = rec."Line Type"::" ")) THEN
                                        rec.MARK(TRUE);
                                UNTIL rec.NEXT(-1) = 0;
                            rec.SETRANGE(Level);
                            rec.SETRANGE("Presentation Code");
                            rec.MARKEDONLY(TRUE);
                        END;
                    1:
                        BEGIN
                            lRec.COPY(Rec);
                            rec.SETFILTER("Presentation Code", '%1', rec."Presentation Code" + '?*');
                            IF rec.FIND('+') THEN
                                REPEAT
                                    rec.MARK(FALSE);
                                UNTIL rec.NEXT(-1) = 0;
                            rec.SETRANGE("Presentation Code");
                            rec.GET(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                        END;
                    ELSE
                        ;
                END;
        END;
    end;

    local procedure CommentOnPush()
    var
        lDescriptionLine: Record 8004075;
    begin
        IF rec."Line Type" = rec."Line Type"::" " THEN
            EXIT;
        //#5821
        /*
        lDescriptionLine.SETRANGE("Table ID",DATABASE::"Sales Line");
        lDescriptionLine.SETRANGE("Document Type","Document Type");
        lDescriptionLine.SETRANGE("Document No.","Document No.");
        lDescriptionLine.SETRANGE("Document Line No.","Line No.");
        lDescriptionLine.Description := Description;
        Page.RUNMODAL(Page::Form8004083,lDescriptionLine);
        */
        ShowLineComments;
        //#5821//

    end;

    local procedure OkMetreOnPush()
    begin
        lMetre();
    end;

    local procedure PresentationCodeTextOnFormat(var Text: Text[1024])
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            "Presentation CodeHideValue" := TRUE;
        Text := DELCHR(Text);
        wFormatFields;
        "Presentation CodeEmphasize" := FontBold;
    end;

    local procedure LevelOnFormat()
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            LevelHideValue := TRUE;
        wFormatFields;
        LevelEmphasize := FontBold;
    end;

    local procedure LineTypeOnFormat()
    begin
        wFormatFields;
        "Line TypeEmphasize" := FontBold;
    end;

    local procedure NoOnFormat()
    begin
        wFormatFields;
        "No.Emphasize" := FontBold;
    end;

    local procedure AssignmentBasisOnFormat()
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            "Assignment BasisHideValue" := TRUE;

        wFormatFields;
        "Assignment BasisEmphasize" := FontBold;
    end;

    local procedure AssignmentMethodOnFormat()
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            "Assignment MethodHideValue" := TRUE;

        wFormatFields;
        "Assignment MethodEmphasize" := FontBold;
    end;

    local procedure JobCostAssignmentOnFormat(Text: Text[1024])
    var
        lAssgntJobCost: Codeunit 8004050;
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            "Job Cost AssignmentHideValue" := TRUE;

        wFormatFields;
        JobCostAssignmentEmphasize := FontBold;
        IF rec."Assignment Basis" = 0 THEN
            Text := lAssgntJobCost.Assignment(Rec);
    end;

    local procedure SubcontractingOnFormat()
    begin
        IF (rec."Attached to Line No." <> 0) AND (rec."Line Type" = 0) AND (rec."No." = '') THEN
            SubcontractingHideValue := TRUE;

        wFormatFields;
        SubcontractingEmphasize := FontBold;
    end;

    local procedure VariantCodeOnFormat()
    begin
        wFormatFields;
        "Variant CodeEmphasize" := FontBold;
    end;

    local procedure MarkerOnFormat()
    begin
        wFormatFields;
        MarkerEmphasize := FontBold;
    end;

    local procedure CrossReferenceNoOnFormat()
    begin
        wFormatFields;
        "Cross-Reference No.Emphasize" := FontBold;
    end;

    local procedure PurchasingCodeOnFormat()
    begin
        wFormatFields;
        "Purchasing CodeEmphasize" := FontBold;
    end;

    local procedure VendorNoOnFormat()
    begin
        wFormatFields;
        "Vendor No.Emphasize" := FontBold;
    end;

    local procedure GenProdPostingGroupOnFormat()
    begin
        wFormatFields;
        GenProdPostingGroupEmphasize := FontBold;
    end;

    local procedure VATProdPostingGroupOnFormat()
    begin
        wFormatFields;
        VATProdPostingGroupEmphasize := FontBold;
    end;

    local procedure VATBusPostingGroupOnFormat()
    begin
        wFormatFields;
        VATBusPostingGroupEmphasize := FontBold;
    end;

    local procedure DescriptionOnFormat()
    var
        lLevel: Integer;
    begin
        //TRS-2009
        IF (ISSERVICETIER) THEN
            lLevel := rec.Level - 1
        ELSE
            lLevel := (rec.Level - 1) * 220;
        IF (lLevel >= 0) AND (rec."Attached to Line No." <> 0) THEN
            DescriptionIndent := lLevel;
        //RTS-2009//
        wFormatFields;
        DescriptionEmphasize := FontBold;
        IF (rec."Line Type" = rec."Line Type"::" ") AND (rec."Attached to Line No." = 0) AND (rec."Job Task No." = '')
           AND (rec."Rider Rank" <> 0) THEN;
    end;

    local procedure Description2OnFormat()
    begin
        wFormatFields;
        "Description 2Emphasize" := FontBold;
    end;

    local procedure InternalDescriptionOnFormat()
    begin
        wFormatFields;
        "Internal DescriptionEmphasize" := FontBold;
    end;

    local procedure LocationCodeOnFormat()
    begin
        wFormatFields;
        "Location CodeEmphasize" := FontBold;
    end;

    local procedure CustomerPriceGroupOnFormat()
    begin
        wFormatFields;
        "Customer Price GroupEmphasize" := FontBold;
    end;

    local procedure Value1OnFormat()
    begin
        wFormatFields;
        "Value 1Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 1 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 1"))) THEN
            "Value 1HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value2OnFormat()
    begin
        wFormatFields;
        "Value 2Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
          NOT wQtySetup."Value 2 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
          AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 2"))) THEN
            "Value 2HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value3OnFormat()
    begin
        wFormatFields;
        "Value 3Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 3 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 3"))) THEN
            "Value 3HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value4OnFormat()
    begin
        wFormatFields;
        "Value 4Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 4 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 4"))) THEN
            "Value 4HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value5OnFormat()
    begin
        wFormatFields;
        "Value 5Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 5 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 5"))) THEN
            "Value 5HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value6OnFormat()
    begin
        wFormatFields;
        "Value 6Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 6 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 6"))) THEN
            "Value 6HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value7OnFormat()
    begin
        wFormatFields;
        "Value 7Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 7 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 7"))) THEN
            "Value 7HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value8OnFormat()
    begin
        wFormatFields;
        "Value 8Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 8 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 8"))) THEN
            "Value 8HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value9OnFormat()
    begin
        wFormatFields;
        "Value 9Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 9 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 9"))) THEN
            "Value 9HideValue" := TRUE;
        //#7768//
    end;

    local procedure Value10OnFormat()
    begin
        wFormatFields;
        "Value 10Emphasize" := FontBold;
        //#7768
        IF wQtySetup."Formula desactivated / Sales" AND
           NOT wQtySetup."Value 10 Total" AND (rec."Line Type" IN [rec."Line Type"::Totaling, rec."Line Type"::Structure])
           AND (NOT fHasVarReferenceField(rec.FIELDNO("Value 10"))) THEN
            "Value 10HideValue" := TRUE;
        //#7768//
    end;

    local procedure QuantityOnFormat(Text: Text[1024])
    begin
        wFormatFields;
        QuantityEmphasize := FontBold;
        IF rec.Option AND (rec."Optionnal Quantity" <> 0) THEN
            Text := FORMAT(rec."Optionnal Quantity");
    end;

    local procedure QtyperUnitofMeasureOnFormat()
    begin
        IF rec.Type = rec.Type::" " THEN
            QtyperUnitofMeasureHideValue := TRUE;
    end;

    local procedure QuantityBaseOnFormat()
    begin
        wFormatFields;
        "Quantity (Base)Emphasize" := FontBold;
    end;

    local procedure UnitofMeasureCodeOnFormat()
    begin
        wFormatFields;
        "Unit of Measure CodeEmphasize" := FontBold;
    end;

    local procedure UnitofMeasureOnFormat()
    begin
        wFormatFields;
        "Unit of MeasureEmphasize" := FontBold;
    end;

    local procedure RateOnFormat()
    begin
        wFormatFields;
        RateEmphasize := FontBold;
    end;

    local procedure DurationOnFormat()
    begin
        wFormatFields;
        DurationEmphasize := FontBold;
    end;

    local procedure RateAmountOnFormat()
    begin
        wFormatFields;
        "Rate AmountEmphasize" := FontBold;
    end;

    local procedure UnitCostLCYOnFormat()
    begin
        wFormatFields;
        "Unit Cost (LCY)Emphasize" := FontBold;
    end;

    local procedure TotalCostLCYOnFormat()
    begin
        wFormatFields;
        "Total Cost (LCY)Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "Total Cost (LCY)HideValue" := TRUE;
        //#4797//
    end;

    local procedure OverheadAmountLCYOnFormat()
    begin
        wFormatFields;
        "Overhead Amount (LCY)Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "Overhead Amount (LCY)HideValue" := TRUE;
        //#4797//
    end;

    local procedure TheoreticalProfitAmountLCYOnFo()
    begin
        wFormatFields;
        TheoreticalProfitAmountLCYEmph := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            TheoreticalProfitAmountLCYHide := TRUE;
        //#4797//
    end;

    local procedure JobCostsLCYOnFormat()
    begin
        wFormatFields;
        "Job Costs (LCY)Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "Job Costs (LCY)HideValue" := TRUE;
        //#4797//
    end;

    local procedure wProfitOnFormat(Text: Text[1024])
    var
        lFontBold: Boolean;
    begin
        //TRS-2009
        lFontBold := (rec."Profit %" <> 0) OR FontBold;
        //TRS-2009//
        wFormatFields;
        TMEmphasize := lFontBold;
        wNavibatSetup.MarginRateOnFormat(Text);
        //#4797
        IF (wShowTotalingValue) THEN
            wProfitHideValue := TRUE;
        //#4797//
    end;

    local procedure UnitPriceOnFormat()
    begin
        wFormatFields;
        "Unit PriceEmphasize" := FontBold;
    end;

    local procedure LineAmountOnFormat(Text: Text[1024])
    var
        llenght: Integer;
    begin
        wFormatFields;
        "Line AmountEmphasize" := FontBold;
        IF rec.Option AND (rec."Optionnal Quantity" <> 0) THEN BEGIN
            Text := FORMAT(ROUND(rec."Optionnal Quantity" * rec."Unit Price" * (1 - rec."Line Discount %" / 100), 0.01));
            IF (STRPOS(FORMAT(ROUND(rec."Optionnal Quantity" * rec."Unit Price", 0.01)), wSeparator) = 0) THEN
                Text += wSeparator + '00'
        END;
        //#4797
        IF (wShowTotalingValue) THEN
            "Line AmountHideValue" := TRUE;
        //#4797//
    end;

    local procedure LineDiscount37OnFormat()
    begin
        wFormatFields;
        "Line Discount %Emphasize" := FontBold;
    end;

    local procedure LineDiscountAmountOnFormat()
    begin
        wFormatFields;
        "Line Discount AmountEmphasize" := FontBold;
    end;

    local procedure InvDiscountAmountOnFormat()
    begin
        wFormatFields;
        "Inv. Discount AmountEmphasize" := FontBold;
    end;

    local procedure PrintOptionLineOnFormat()
    begin
        "Print Option LineEmphasize" := FontBold;
    end;

    local procedure JobNoOnFormat()
    begin
        wFormatFields;
        "Job No.Emphasize" := FontBold;
    end;

    local procedure WorkTypeCodeOnFormat()
    begin
        wFormatFields;
        "Work Type CodeEmphasize" := FontBold;
    end;

    local procedure ShortcutDimension1CodeOnFormat()
    begin
        wFormatFields;
        ShortcutDimension1CodeEmphasiz := FontBold;
    end;

    local procedure ShortcutDimension2CodeOnFormat()
    begin
        wFormatFields;
        ShortcutDimension2CodeEmphasiz := FontBold;
    end;

    local procedure PersonQuantityOnFormat()
    begin
        wFormatFields;
        "Person QuantityEmphasize" := FontBold;
        IF rec."Line Type" = 0 THEN // Evite la répétition sur les lignes de texte étendu
            "Person QuantityHideValue" := TRUE;
    end;

    local procedure TotalCostLCYbyLineTypeOnFormat()
    begin
        wFormatFields;
        TotalCostLCYbyLineTypeEmphasiz := FontBold;
    end;

    local procedure wAmount1OnFormat()
    begin
        wFormatFields;
        "Amount 1Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[1]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount2OnFormat()
    begin
        wFormatFields;
        "Amount 2Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[2]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount3OnFormat()
    begin
        wFormatFields;
        "Amount 3Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[3]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount4OnFormat()
    begin
        wFormatFields;
        "Amount 4Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[4]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount5OnFormat()
    begin
        wFormatFields;
        "Amount 5Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[5]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount6OnFormat()
    begin
        wFormatFields;
        "Amount 6Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[6]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount7OnFormat()
    begin
        wFormatFields;
        "Amount 7Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[7]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount8OnFormat()
    begin
        wFormatFields;
        "Amount 8Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[8]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount9OnFormat()
    begin
        wFormatFields;
        "Amount 9Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[9]HideValue" := TRUE;
        //#4797//
    end;

    local procedure wAmount10OnFormat()
    begin
        wFormatFields;
        "Amount 10Emphasize" := FontBold;
        //#4797
        IF (wShowTotalingValue) THEN
            "wAmount[10]HideValue" := TRUE;
        //#4797//
    end;
}

