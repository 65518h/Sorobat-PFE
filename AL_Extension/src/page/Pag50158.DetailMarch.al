Page 50158 "Detail Marché"
{
    // //#9088 OF 20/09/11 : decalage vers la droite de plusieurs ligne
    // //COR SCRIPT DA
    // //TRS-2009 XPE 06/10/09
    // //DELETE-RTC2009 
    // //#6439 tOtherResource
    // //#6300 Description
    //                    Unit Of Measure Code - OnAfterValidate
    //                    Subcontracting - OnAfterValidate
    //                    Function Insert Extended text
    // //#5771 Modification
    // //#5771 Ajout 
    // //#6079 Ajout
    // //PROJET MB 13/07/07 +Job Task No.
    // //PIED_DEVIS MB 11/01/07 +"Rate Amount"
    // //PROJET GESWAY 01/11/01 Job No. : Visible OUI
    //                          Ajout des champs Phase Code (visible oui),
    //                           Task Code, Step Code, Work Type Code (visible non)
    // //OUVRAGE GESWAY 01/07/02 Eclatement si article Nomenclature dans OnAfterValidate de Quantité
    // //OUVRAGE GESWAY 20/03/03 Ajout fonction wCopyStructureLine
    //           CW     07/05/03 OnFormat("Code présentation") Ne pas afficher si TexteEtendu
    //           GESWAY 20/03/05 Ajout wCopyLine qui remplace wCopyStructureLine
    // //ETATS GESWAY 20/06/03 Ajout champ "Print Option"
    // //SUBCONTRACTOR GESWAY 10/07/03 Modification fonction OpenPurchOrderForm
    //                        02/06/04 Ajout fonction wGenerateSubcontracting
    //                        15/06/04 MAJ du fournisseur sur ligne ouvrage (OnAfterValidate de No.)
    // //DEVIS GESWAY 18/07/03 Appel du calcul de répartition des frais directs
    //                17/08/04 Confimer l'insertion du texte étendu si ligne importée -> InsertExtendedText
    // //PROJET_FG CW 10/02/04 Génération des taux FG et marge du devis (copie des lois)
    // //FRAIS CLA 15/02/05 Ajout des frais directs
    // //CDE_CESSION MB 08/11/06 Ajout des fonctions wTransfer et wFindTranfer

    Caption = 'Détail Marché';
    //GL2024 DelayedInsert = true;
    //GL2024 Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document No.", "Line No.", "Document Type")
                      where("Document Type" = const(Order), "Structure Line No." = const(0), "Line Type" = filter(<> Other));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field(ActualExpansionStatus; ActualExpansionStatus)
                {
                    ApplicationArea = all;
                    Caption = 'Expand';
                    Editable = false;
                    // OptionCaption = 'Integer';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ActualExpansionStatusOnPush;
                    end;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = "Line No.Visible";
                }
                field("Attached to Line No."; rec."Attached to Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(PresentationCodeText; PresentationCodeText)
                {
                    ApplicationArea = all;
                    //  //CaptionClass = FIELDCAPTION("Presentation Code");
                    Editable = false;
                    HideValue = "Presentation CodeHideValue";
                    Visible = false;
                }
                field(Level; rec.Level)
                {
                    ApplicationArea = all;
                    Editable = false;
                    HideValue = LevelHideValue;
                    Visible = LevelVisible;
                }
                field("Line Type"; rec."Line Type")
                {
                    ApplicationArea = all;
                    OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account,Charge (Item),Other,Fixed Asset';
                    Visible = "Line TypeVisible";

                    trigger OnValidate()
                    begin
                        //#4379
                        if rec."Line Type" = rec."line type"::Other then
                            Error(tOtherResource);
                        //#4379//
                        LineTypeOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Visible = "No.Visible";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        wOnLookup;
                        //#7427
                        fRecalculateBOQ();
                        //#7427//
                    end;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        wOKLookup := false;

                        //MIG 5.00
                        /*IF (Type = Type::Item) AND ("No." <> xRec."No.") AND ("No." <> '') AND (wItem.GET("No.")) AND
                          (wItem."Default Task Code" <> '') AND ("Structure Line No." = 0) THEN
                        
                              GetItemCrossRef := wItem."Default Task Code";
                        MIG5.00 */
                        NoOnAfterValidate;

                    end;
                }
                // field("Description "; rec."Description")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Désignation';
                //     Editable = false;

                // }
                field(Option; rec.Option)
                {
                    ApplicationArea = all;
                    Visible = OptionVisible;

                    trigger OnValidate()
                    begin
                        //#RTC - 2009
                        CurrPage.SaveRecord();
                        //gSaveRecord()
                        //#RTC - 2009//
                        OptionOnAfterValidate;
                    end;
                }
                field("Assignment Basis"; rec."Assignment Basis")
                {
                    ApplicationArea = all;
                    HideValue = "Assignment BasisHideValue";
                    Visible = "Assignment BasisVisible";

                    trigger OnValidate()
                    begin
                        AssignmentBasisOnAfterValidate;
                    end;
                }
                field("Assignment Method"; rec."Assignment Method")
                {
                    ApplicationArea = all;
                    HideValue = "Assignment MethodHideValue";
                    Visible = "Assignment MethodVisible";

                    trigger OnValidate()
                    begin
                        //#RTC - 2009
                        CurrPage.SaveRecord();
                        //gSaveRecord()
                        //#RTC - 2009//
                    end;
                }
                field("Gen. Prod. Posting Prorata"; rec."Gen. Prod. Posting Prorata")
                {
                    ApplicationArea = all;
                    Visible = GenProdPostingProrataVisible;
                }
                field(JobCostAssignment; rec."Job Cost Assignment")
                {
                    ApplicationArea = all;
                    Caption = 'Job Cost Marked';
                    HideValue = "Job Cost AssignmentHideValue";
                    Visible = JobCostAssignmentVisible;

                    trigger OnDrillDown()
                    begin
                        //FRAIS
                        //#RTC - 2009
                        //gSaveRecord();
                        CurrPage.SaveRecord();
                        //#RTC - 2009//
                        Rec.wShowJobCostAssgnt;
                        UpdateForm(false);
                    end;

                    trigger OnValidate()
                    begin
                        JobCostAssignmentOnAfterValida;
                    end;
                }
                field(Subcontracting; rec.Subcontracting)
                {
                    ApplicationArea = all;
                    HideValue = SubcontractingHideValue;
                    Visible = SubcontractingVisible;

                    trigger OnValidate()
                    var
                        lSubcontracting: Integer;
                    begin
                        if rec."Line Type" = rec."line type"::Totaling then begin
                            lSubcontracting := rec.Subcontracting;
                            rec.Find('=');
                            rec.Subcontracting := lSubcontracting;
                        end;
                        //#RTC - 2009
                        //gSaveRecord();
                        CurrPage.SaveRecord();
                        //#RTC - 2009//
                        SubcontractingOnAfterValidate;
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = "Variant CodeVisible";
                }
                field("Substitution Available"; rec."Substitution Available")
                {
                    ApplicationArea = all;
                    Visible = "Substitution AvailableVisible";
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                    Visible = NonstockVisible;
                }
                field(Marker; rec.Marker)
                {
                    ApplicationArea = all;
                    Visible = MarkerVisible;
                }
                field("Cross-Reference No."; rec."Item Reference No.")
                {
                    ApplicationArea = all;
                    Visible = "Cross-Reference No.Visible";

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                    ApplicationArea = all;
                    Visible = "Purchasing CodeVisible";
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = "Vendor No.Visible";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lVendor: Record Vendor;
                        lVendorCode: Code[20];
                    begin
                        if rec.Subcontracting <> rec.Subcontracting::" " then
                            lVendor.SetRange(Subcontractor, true);
                        lVendor."No." := rec."Vendor No.";
                        if Page.RunModal(0, lVendor) = Action::LookupOK then begin
                            rec.Validate("Vendor No.", lVendor."No.");
                            lVendorCode := rec."Vendor No.";
                            rec.Find('=');
                            rec."Vendor No." := lVendorCode;
                            CurrPage.Update;
                        end;
                    end;

                    trigger OnValidate()
                    var
                        lVendor: Code[20];
                    begin
                        if rec."Line Type" = rec."line type"::Totaling then begin
                            lVendor := rec."Vendor No.";
                            rec.Find('=');
                            rec."Vendor No." := lVendor;
                        end;
                        //#RTC - 2009
                        //gSaveRecord();
                        CurrPage.SaveRecord();
                        //#RTC - 2009//
                        VendorNoOnAfterValidate;
                    end;
                }
                field("Purch. Order Qty (Base)"; rec."Purch. Order Qty (Base)")
                {
                    ApplicationArea = all;
                    Visible = "Purch. Order Qty (Base)Visible";
                }
                field("Purch. Order Receipt Date"; rec."Purch. Order Receipt Date")
                {
                    ApplicationArea = all;
                    Visible = PurchOrderReceiptDateVisible;
                }
                field("Purch. Order Rcpt. Qty (Base)"; rec."Purch. Order Rcpt. Qty (Base)")
                {
                    ApplicationArea = all;
                    Visible = PurchOrderRcptQtyBaseVisible;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = GenProdPostingGroupVisible;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = "VAT Prod. Posting GroupVisible";
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = "VAT Bus. Posting GroupVisible";
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Visible = DescriptionVisible;

                    trigger OnAssistEdit()
                    var
                        lSCRefMgt: Codeunit "Sales Cross-Ref Management";
                    begin
                        //#5464
                        //lAssistEdit;
                        //#5464

                        //+REF+MEMOPAD
                        //#RTC - 2009
                        //gSaveRecord();
                        CurrPage.SaveRecord();
                        //#RTC - 2009//
                        //#5464
                        //IF wEditMemoPad THEN
                        if rec.fMemoPad then begin
                            //#5464//
                            //#7592
                            //  IF ("Attached to Line No." <> 0) THEN
                            //    GET("Document Type","Document No.","Attached to Line No.")
                            if (rec."Attached to Line No." <> 0) and (rec.Type <> rec.Type::Resource) then
                                rec.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.")
                            else
                                Rec.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.");
                            //#7592//
                            if rec."Item Reference No." <> '' then
                                lSCRefMgt.wUpdateField(Rec, rec.Description, rec.FieldNo(Description));
                            //    lSCRefMgt.wValidateExtendedText(Rec);
                            CurrPage.Update(false);
                            //+REF+MEMOPAD//
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        DescriptionOnAfterValidate;
                    end;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                    Visible = "Description 2Visible";

                    trigger OnValidate()
                    begin
                        if rec."No." = '' then begin
                            //#RTC - 2009
                            //gSaveRecord();
                            CurrPage.SaveRecord();
                            //#RTC - 2009//
                        end;
                        Description2OnAfterValidate;
                    end;
                }
                field("Internal Description"; rec."Internal Description")
                {
                    ApplicationArea = all;
                    Visible = "Internal DescriptionVisible";
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                    Editable = false;
                    // OptionCaption = 'Bitmap37,Bitmap6';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CommentOnPush;
                    end;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = all;
                    Visible = "Completely ShippedVisible";
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = "Location CodeVisible";
                }
                field("Customer Price Group"; rec."Customer Price Group")
                {
                    ApplicationArea = all;
                    Visible = "Customer Price GroupVisible";
                }
                field("Value 1"; rec."Value 1")
                {
                    ApplicationArea = all;
                    Editable = "Value 1Editable";
                    HideValue = "Value 1HideValue";
                    Visible = "Value 1Visible";

                    trigger OnValidate()
                    begin
                        Value1OnAfterValidate;
                    end;
                }
                field("Value 2"; rec."Value 2")
                {
                    ApplicationArea = all;
                    Editable = "Value 2Editable";
                    HideValue = "Value 2HideValue";
                    Visible = "Value 2Visible";

                    trigger OnValidate()
                    begin
                        Value2OnAfterValidate;
                    end;
                }
                field("Value 3"; rec."Value 3")
                {
                    ApplicationArea = all;
                    Editable = "Value 3Editable";
                    HideValue = "Value 3HideValue";
                    Visible = "Value 3Visible";

                    trigger OnValidate()
                    begin
                        Value3OnAfterValidate;
                    end;
                }
                field("Value 4"; rec."Value 4")
                {
                    ApplicationArea = all;
                    Editable = "Value 4Editable";
                    HideValue = "Value 4HideValue";
                    Visible = "Value 4Visible";

                    trigger OnValidate()
                    begin
                        Value4OnAfterValidate;
                    end;
                }
                field("Value 5"; rec."Value 5")
                {
                    ApplicationArea = all;
                    Editable = "Value 5Editable";
                    HideValue = "Value 5HideValue";
                    Visible = "Value 5Visible";

                    trigger OnValidate()
                    begin
                        Value5OnAfterValidate;
                    end;
                }
                field("Value 6"; rec."Value 6")
                {
                    ApplicationArea = all;
                    Editable = "Value 6Editable";
                    HideValue = "Value 6HideValue";
                    Visible = "Value 6Visible";

                    trigger OnValidate()
                    begin
                        Value6OnAfterValidate;
                    end;
                }
                field("Value 7"; rec."Value 7")
                {
                    ApplicationArea = all;
                    Editable = "Value 7Editable";
                    HideValue = "Value 7HideValue";
                    Visible = "Value 7Visible";

                    trigger OnValidate()
                    begin
                        Value7OnAfterValidate;
                    end;
                }
                field("Value 8"; rec."Value 8")
                {
                    ApplicationArea = all;
                    Editable = "Value 8Editable";
                    HideValue = "Value 8HideValue";
                    Visible = "Value 8Visible";

                    trigger OnValidate()
                    begin
                        Value8OnAfterValidate;
                    end;
                }
                field("Value 9"; rec."Value 9")
                {
                    ApplicationArea = all;
                    Editable = "Value 9Editable";
                    HideValue = "Value 9HideValue";
                    Visible = "Value 9Visible";

                    trigger OnValidate()
                    begin
                        Value9OnAfterValidate;
                    end;
                }
                field("Value 10"; rec."Value 10")
                {
                    ApplicationArea = all;
                    Editable = "Value 10Editable";
                    HideValue = "Value 10HideValue";
                    Visible = "Value 10Visible";

                    trigger OnValidate()
                    begin
                        Value10OnAfterValidate;
                    end;
                }
                field("Bill of Quantities"; OkMetre)
                {
                    ApplicationArea = all;
                    Caption = 'Bill of Quantities';
                    Editable = false;
                    // OptionCaption = 'Integer';
                    Visible = "Bill of QuantitiesVisible";

                    trigger OnValidate()
                    begin
                        OkMetreOnPush;
                    end;
                }
                field(wBoqState; wBoqState)
                {
                    ApplicationArea = all;
                    AssistEdit = true;
                    Caption = 'BOQ State';
                    Editable = false;
                    OptionCaption = ' ,  ,VARIABLE,RESULT,ERROR';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        //#8919
                        lMetre();
                        //#8919//
                    end;
                }
                field("Quantité Intiale Marché"; rec."Quantité Intiale Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Prix Unitaire  Initiale Marché"; rec."Prix Unitaire  Initiale Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Montant Initiale Marché"; rec."Montant Initiale Marché")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(QuantityText; QuantityText)
                {
                    ApplicationArea = all;
                    //  //blankzero = true;
                    // //CaptionClass = FIELDCAPTION(Quantity);
                    Editable = QuantityEditable;
                    caption = 'Quantité';
                    Style = Strong;
                    StyleExpr = true;

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
                field("Avenant 1"; rec."Avenant 1")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Avenant1OnAfterValidate;
                    end;
                }
                field("Avenant 2"; rec."Avenant 2")
                {
                    ApplicationArea = all;
                    // Visible = false;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        Avenant2OnAfterValidate;
                    end;
                }
                field("Avenant 3"; rec."Avenant 3")
                {
                    ApplicationArea = all;
                    //  Visible = false;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        Avenant3OnAfterValidate;
                    end;
                }
                field("Avenant 4"; rec."Avenant 4")
                {
                    ApplicationArea = all;
                    // Visible = false;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        Avenant4OnAfterValidate;
                    end;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = all;
                    // //blankzero = true;
                    Caption = 'Qte Exécutée';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = "Quantity ShippedVisible";
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = all;
                    // //blankzero = true;
                    Visible = "Qty. to ShipVisible";
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                    HideValue = QtyperUnitofMeasureHideValue;
                    Visible = QtyperUnitofMeasureVisible;

                    trigger OnValidate()
                    begin
                        QtyperUnitofMeasureOnAfterVali;
                    end;
                }
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                    //   //blankzero = true;
                    Visible = "Quantity (Base)Visible";

                    trigger OnValidate()
                    begin
                        QuantityBaseOnAfterValidate;
                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Visible = "Unit of Measure CodeVisible";

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = "Unit of MeasureVisible";
                }
                field(Rate; rec.Rate)
                {
                    ApplicationArea = all;
                    Visible = RateVisible;

                    trigger OnValidate()
                    begin
                        RateOnAfterValidate;
                    end;
                }
                field(Duration; rec.Duration)
                {
                    ApplicationArea = all;
                    Visible = DurationVisible;

                    trigger OnValidate()
                    begin
                        DurationOnAfterValidate;
                    end;
                }
                field("Rate Amount"; rec."Rate Amount")
                {
                    ApplicationArea = all;
                    // //blankzero = true;
                    Visible = "Rate AmountVisible";
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                    //  //blankzero = true;
                    // DecimalPlaces = 2 : 2;
                    Editable = "Unit Cost (LCY)Editable";
                    Visible = "Unit Cost (LCY)Visible";

                    trigger OnAssistEdit()
                    begin
                        lAssistEdit;
                    end;

                    trigger OnValidate()
                    begin
                        UnitCostLCYOnAfterValidate;
                    end;
                }
                field("Total Cost (LCY)"; rec."Total Cost (LCY)")
                {
                    ApplicationArea = all;
                    HideValue = "Total Cost (LCY)HideValue";
                    Visible = "Total Cost (LCY)Visible";

                    trigger OnAssistEdit()
                    begin
                        lAssistEdit;
                    end;
                }
                field("Overhead Amount (LCY)"; rec."Overhead Amount (LCY)")
                {
                    ApplicationArea = all;
                    HideValue = "Overhead Amount (LCY)HideValue";
                    Visible = "Overhead Amount (LCY)Visible";

                    trigger OnValidate()
                    begin
                        OverheadAmountLCYOnAfterValida;
                    end;
                }
                field("Theoretical Profit Amount(LCY)"; rec."Theoretical Profit Amount(LCY)")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    HideValue = TheoreticalProfitAmountLCYHide;
                    Visible = TheoreticalProfitAmountLCYVisi;
                }
                field(ProfitAmount; gProfitAmount)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Profit Amount';
                    Editable = false;
                    Visible = ProfitAmountVisible;
                }
                field("Job Costs (LCY)"; rec."Job Costs (LCY)")
                {
                    ApplicationArea = all;
                    HideValue = "Job Costs (LCY)HideValue";
                    Visible = "Job Costs (LCY)Visible";
                }
                field("Job Costs Margin Included"; rec."Job Costs Margin Included")
                {
                    ApplicationArea = all;
                    Visible = JobCostsMarginIncludedVisible;
                }
                field("Existing Price"; rec.PriceExists)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = "Existing PriceVisible";
                }
                field(TM; wProfit)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Profit %';
                    DecimalPlaces = 0 : 3;
                    Editable = TMEditable;
                    HideValue = wProfitHideValue;
                    Visible = TMVisible;

                    trigger OnValidate()
                    begin
                        wProfitOnAfterValidate;
                    end;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Editable = "Unit PriceEditable";
                    Visible = "Unit PriceVisible";

                    trigger OnValidate()
                    begin
                        if rec."Line Type" = rec."line type"::Totaling then
                            rec.FieldError("Line Type");
                        UnitPriceOnAfterValidate;
                    end;
                }
                field("Unit-Amount Rounding Precision"; rec."Unit-Amount Rounding Precision")
                {
                    ApplicationArea = all;
                    Visible = UnitAmountRoundingPrecisionVis;

                    trigger OnValidate()
                    begin
                        UnitAmountRoundingPrecisionOnA;
                    end;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Montant Marché';
                    Editable = "Line AmountEditable";
                    HideValue = "Line AmountHideValue";
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = "Line AmountVisible";

                    trigger OnValidate()
                    begin
                        if rec."Line Type" = rec."line type"::Totaling then
                            rec.FieldError("Line Type");
                        LineAmountOnAfterValidate;
                    end;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //  Caption = 'Montant Marché';
                    Editable = "Line AmountEditable";
                    HideValue = "Line AmountHideValue";
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = "Line AmountVisible";

                    trigger OnValidate()
                    begin
                        if rec."Line Type" = rec."line type"::Totaling then
                            rec.FieldError("Line Type");
                        LineAmountOnAfterValidate;
                    end;
                }
                field("Shipped Not Invoiced"; rec."Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Montant Excuté TTC';
                    Editable = false;
                    Style = favorable;
                    StyleExpr = true;
                }
                field("Outstanding Amount"; rec."Outstanding Amount")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Montant Excuté HT';
                    Editable = false;
                    Style = favorable;
                    StyleExpr = true;
                }
                field(Avancement2; Avancement2)
                {
                    ApplicationArea = all;
                    Caption = 'Avancement 2';
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Avancement; Avancement)
                {
                    ApplicationArea = all;
                    Caption = 'Avancement';
                    ExtendedDatatype = Ratio;
                    MaxValue = 100;
                }
                field("Fixed Price"; rec."Fixed Price")
                {
                    Caption = 'Prix fixe';
                    ApplicationArea = all;
                    Editable = "Fixed PriceEditable";
                    Visible = "Fixed PriceVisible";

                    trigger OnValidate()
                    begin
                        FixedPriceOnAfterValidate;
                    end;
                }
                field("Disc. Line Existing"; rec.LineDiscExists)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    Visible = false;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Editable = "Line Discount %Editable";
                    Visible = "Line Discount %Visible";

                    trigger OnValidate()
                    begin
                        LineDiscount37OnAfterValidate;
                    end;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                    Editable = "Line Discount AmountEditable";
                    Visible = "Line Discount AmountVisible";

                    trigger OnValidate()
                    begin
                        LineDiscountAmountOnAfterValid;
                    end;
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = "Inv. Discount AmountVisible";
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                    Editable = "Allow Invoice Disc.Editable";
                    Visible = "Allow Invoice Disc.Visible";
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                    Visible = "Shipment DateVisible";
                }

                field(PToInvoice; QtyCumToInv)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = '% To Invoice';
                    Visible = PToInvoiceVisible;

                    trigger OnValidate()
                    begin
                        rec.Validate("Qty. to Invoice", ((QtyCumToInv / 100) * rec.Quantity) - rec."Quantity Invoiced");
                    end;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = "Qty. to InvoiceVisible";

                    trigger OnValidate()
                    begin
                        if rec.Quantity <> 0 then
                            QtyCumToInv := (rec."Quantity Invoiced" + rec."Qty. to Invoice") / rec.Quantity * 100
                        else
                            QtyCumToInv := 0;
                    end;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = "Quantity InvoicedVisible";
                }
                field("Print Option Line"; rec."Print Option Line")
                {
                    ApplicationArea = all;
                    Visible = "Print Option LineVisible";
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Visible = "Job No.Visible";

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                    Visible = "Job Task No.Visible";
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = all;
                    Visible = "Work Type CodeVisible";
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = ShortcutDimension1CodeVisible;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = ShortcutDimension2CodeVisible;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '1,2,3';
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
                    //CaptionClass = '1,2,4';
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
                    //CaptionClass = '1,2,5';
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
                    //CaptionClass = '1,2,6';
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
                    //CaptionClass = '1,2,7';
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
                    //CaptionClass = '1,2,8';
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
                field("Person Quantity"; rec."Person Quantity")
                {
                    ApplicationArea = all;
                    HideValue = "Person QuantityHideValue";
                    Visible = "Person QuantityVisible";

                    trigger OnDrillDown()
                    begin
                        lAssistEdit;
                    end;

                    trigger OnValidate()
                    begin
                        PersonQuantityOnAfterValidate;
                    end;
                }
                field(QtyPersonPerUnt; wQtyPersonPerUnit)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Caption = 'Person Quantity Per Unit';
                    DecimalPlaces = 0 : 5;
                    Editable = QtyPersonPerUntEditable;
                    Visible = QtyPersonPerUntVisible;

                    trigger OnValidate()
                    begin
                        //#6079
                        rec.wUpdateQtyMO(wQtyPersonPerUnit, 0);
                        //#6079//
                        wQtyPersonPerUnitOnAfterValida;
                    end;
                }
                field("Total Cost LCY by Line Type"; rec."Total Cost LCY by Line Type")
                {
                    ApplicationArea = all;
                    Caption = 'Total Cost LCY except Person';
                    Visible = TotalCostLCYbyLineTypeVisible;

                    trigger OnDrillDown()
                    begin
                        lAssistEdit;
                    end;
                }
                field("FA Posting Date"; rec."FA Posting Date")
                {
                    ApplicationArea = all;
                    Visible = "FA Posting DateVisible";
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = all;
                    Visible = "Depreciation Book CodeVisible";
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = all;
                    Visible = DepruntilFAPostingDateVisible;
                }
                field("Amount 1"; wAmount[1])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(1, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[1]HideValue";
                    Visible = "Amount 1Visible";
                }
                field("Amount 2"; wAmount[2])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(2, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[2]HideValue";
                    Visible = "Amount 2Visible";
                }
                field("Amount 3"; wAmount[3])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(3, DATABASE::"Sales Line");
                    HideValue = "wAmount[3]HideValue";
                    Visible = "Amount 3Visible";
                }
                field("Amount 4"; wAmount[4])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(4, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[4]HideValue";
                    Visible = "Amount 4Visible";
                }
                field("Amount 5"; wAmount[5])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(5, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[5]HideValue";
                    Visible = "Amount 5Visible";
                }
                field("Amount 6"; wAmount[6])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(6, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[6]HideValue";
                    Visible = "Amount 6Visible";
                }
                field("Amount 7"; wAmount[7])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(7, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[7]HideValue";
                    Visible = "Amount 7Visible";
                }
                field("Amount 8"; wAmount[8])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(8, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[8]HideValue";
                    Visible = "Amount 8Visible";
                }
                field("Amount 9"; wAmount[9])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(9, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[9]HideValue";
                    Visible = "Amount 9Visible";
                }
                field("Amount 10"; wAmount[10])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = CalcAmount.AmountGet//CaptionClass(10, DATABASE::"Sales Line");
                    Editable = false;
                    HideValue = "wAmount[10]HideValue";
                    Visible = "Amount 10Visible";
                }
                field("Non Valued Code"; rec."Non Valued Code")
                {
                    ApplicationArea = all;
                    Visible = "Non Valued CodeVisible";
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
        "//HJ": Integer;
        LSalesMine: Record "Sales Line";
        LAvancementChapitre: Decimal;
        "LQuantitéChapitre": Decimal;
    begin
        "wAmount[10]HideValue" := false;
        "wAmount[9]HideValue" := false;
        "wAmount[8]HideValue" := false;
        "wAmount[7]HideValue" := false;
        "wAmount[6]HideValue" := false;
        "wAmount[5]HideValue" := false;
        "wAmount[4]HideValue" := false;
        "wAmount[3]HideValue" := false;
        "wAmount[2]HideValue" := false;
        "wAmount[1]HideValue" := false;
        "Person QuantityHideValue" := false;
        "Line AmountHideValue" := false;
        wProfitHideValue := false;
        "Job Costs (LCY)HideValue" := false;
        TheoreticalProfitAmountLCYHide := false;
        "Overhead Amount (LCY)HideValue" := false;
        "Total Cost (LCY)HideValue" := false;
        QtyperUnitofMeasureHideValue := false;
        "Value 10HideValue" := false;
        "Value 9HideValue" := false;
        "Value 8HideValue" := false;
        "Value 7HideValue" := false;
        "Value 6HideValue" := false;
        "Value 5HideValue" := false;
        "Value 4HideValue" := false;
        "Value 3HideValue" := false;
        "Value 2HideValue" := false;
        "Value 1HideValue" := false;
        DescriptionIndent := 0;
        SubcontractingHideValue := false;
        "Job Cost AssignmentHideValue" := false;
        "Assignment MethodHideValue" := false;
        "Assignment BasisHideValue" := false;
        LevelHideValue := false;
        "Presentation CodeHideValue" := false;

        if wFirst then
            gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
        ActualExpansionStatus := 2;
        if rec."Line Type" = rec."line type"::" " then
            ActualExpansionStatus := 3
        else
            if rec."Line Type" = rec."line type"::Totaling then begin
                if gOneSubFormMgt.gIsExpanded(Rec) then
                    ActualExpansionStatus := 1
                else
                    if gOneSubFormMgt.gHasChildren(Rec) then
                        ActualExpansionStatus := 0
                    else
                        ActualExpansionStatus := 3;
            end;

        rec.ShowShortcutDimCode(ShortcutDimCode);
        //TRS-2009
        lVisible := TotalCostLCYbyLineTypeVisible;
        //TRS-2009//
        if lVisible then begin
            rec.SetFilter("Line Type Filter", '<>%1', rec."line type filter"::Person);
            rec.CalcFields("Total Cost LCY by Line Type");
        end;

        //TRS-2009
        lVisible := TMVisible;
        //TRS-2009//
        if lVisible then
            StructureMgt.wGetProfit(wProfit, Rec, lVisible);

        //#6079
        wQtyPersonPerUnit := 0;
        if (rec.Quantity <> 0) then begin
            //TRS-2009
            lVisible := "Person QuantityVisible";
            //TRS-2009//
            if (not lVisible or (rec."Person Quantity" = 0)) and
               (rec."Line Type" = rec."line type"::Structure) then
                rec.CalcFields("Person Quantity");
            wQtyPersonPerUnit := rec."Person Quantity" / rec.Quantity;
        end;
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
        if lAmount1Visible or lAmount2Visible or lAmount3Visible or
          lAMount4Visible or lAmount5Visible or lAmount6Visible or
          lAmount7Visible or lAmount8Visible or lAmount9Visible or
          lAmount10Visible then
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

        if (rec.Quantity <> 0) and (rec."Qty. to Invoice" <> 0) then
            QtyCumToInv := (rec."Quantity Invoiced" + rec."Qty. to Invoice") / rec.Quantity * 100
        else
            QtyCumToInv := 0;

        wShowTotalingValue := (rec."Document Type" = rec."document type"::Quote) and (SalesHeader.Status = SalesHeader.Status::Open) and
                              (wNavibatSetup."Disable update totaling") and (rec."Line Type" = rec."line type"::Totaling);
        //#6409
        fCalculateProfitAmount;
        //#6409//
        // >> HJ SORO 17-02-2017
        //Avancement:=0;
        //Avancement2:='';
        if rec.Quantity <> 0 then begin
            Avancement := (rec."Quantity Shipped" / rec.Quantity) * 100;
            Avancement2 := Format((rec."Quantity Shipped" / rec.Quantity) * 100) + ' %';
        end;
        /*   LAvancementChapitre := 0;
           LQuantitéChapitre := 0;
           if rec."Line Type" = rec."line type"::Totaling then begin
               LSalesMine.SetRange("Document Type", LSalesMine."document type"::Order);
               LSalesMine.SetRange("Document No.", rec."Document No.");
               LSalesMine.SetRange("Attached to Line No.", rec."Line No.");
               if LSalesMine.FindFirst then
                   repeat
                       LQuantitéChapitre += LSalesMine.Quantity;
                       LAvancementChapitre += LSalesMine."Quantity Shipped";
                   until LSalesMine.Next = 0;
               if LQuantitéChapitre <> 0 then begin
                   Avancement := (LAvancementChapitre / LQuantitéChapitre) * 100;
                   Avancement2 := Format((LAvancementChapitre / LQuantitéChapitre) * 100) + ' %';
               end;

           end;

           // >> HJ SORO 17-02-2017
           OnAfterGetCurrRecord;
           PresentationCodeText := Format(rec."Presentation Code");
           PresentationCodeTextOnFormat(PresentationCodeText);
           LevelOnFormat;
           LineTypeOnFormat;
           NoOnFormat;
           AssignmentBasisOnFormat;
           AssignmentMethodOnFormat;
           JobCostAssignmentOnFormat(Format(rec."Job Cost Assignment"));
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
           QuantityText := Format(rec.Quantity);
           QuantityTextOnFormat(QuantityText);
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
           wProfitOnFormat(Format(wProfit));
           UnitPriceOnFormat;
           LineAmountOnFormat(Format(rec."Line Amount"));
           ShippedNotInvoicedOnFormat;
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
           wAmount10OnFormat;*/

    end;

    trigger OnDeleteRecord(): Boolean
    var
        lRec: Record "Sales Line";
        lxRec: Record "Sales Line";
        lDeleteAll: Boolean;
        lCount: Integer;
        lSalesLineMgt: Codeunit "SalesLine Management";
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        lxRec := Rec;
        lRec.Copy(Rec);
        CurrPage.SetSelectionFilter(lRec);
        lRec.SetFilter("Line Type", '<>%1', rec."line type"::" ");
        lCount := lRec.Count;
        lRec.wSetwConfirmDeleteTot(lCount = SalesHeader.wCountActiveLine);
        lRec.SetRange("Line Type");
        if lRec.Find('+') then
            repeat
                if lRec.Type = lRec.Type::" " then begin
                    if lRec."Line No." = lRec."Attached to Line No." then
                        lRec.Delete(false)
                    else
                        lRec.Delete(true);
                end else
                    lRec.Delete(true);
            until lRec.Next(-1) = 0;

        if rec.Find('=') then;

        if ((rec."Line Type" = rec."line type"::Totaling) and (rec.Level > 1)) or (lCount >= 2) then begin
            lRec.Reset;
            lRec.Copy(Rec);
            lRec.SetRange("Line Type", rec."line type"::Totaling);
            if not lRec.IsEmpty then begin
                lRec.Find('-');
                repeat
                    lSalesLineMgt.wUpdateTotalLine(lRec);
                until lRec.Next = 0;
            end;
        end else
            rec.wUpdateLine(Rec, xRec, true);

        lSalesCrossRefMgt.wUpdateAttachedLine(Rec, 1);

        CurrPage.Update(false);

        exit(false);
    end;

    trigger OnInit()
    begin
        "Line AmountEditable" := true;
        "Allow Invoice Disc.Editable" := true;
        "Line Discount %Editable" := true;
        "Fixed PriceVisible" := true;
        "Unit of Measure CodeVisible" := true;
        "Line AmountVisible" := true;
        "Unit PriceVisible" := true;
        "Quantity ShippedVisible" := true;
        "Qty. to ShipVisible" := true;
        DescriptionVisible := true;
        "No.Visible" := true;
        "Value 10Editable" := true;
        "Value 9Editable" := true;
        "Value 8Editable" := true;
        "Value 7Editable" := true;
        "Value 6Editable" := true;
        "Value 5Editable" := true;
        "Value 4Editable" := true;
        "Value 3Editable" := true;
        "Value 2Editable" := true;
        "Value 1Editable" := true;
        TMEditable := true;
        "Unit Cost (LCY)Editable" := true;
        QtyPersonPerUntEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(fOnInsert(BelowxRec));
    end;

    trigger OnModifyRecord(): Boolean
    begin
        fOnModify();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        wKOLookup := false;
        wProfit := 0;

        case rec."Line Type" of
            rec."line type"::" ", rec."line type"::Totaling:
                rec.Type := rec.Type::" ";
            rec."line type"::Item:
                rec.Type := rec.Type::Item;
            rec."line type"::Person, rec."line type"::Machine, rec."line type"::Structure:
                rec.Type := rec.Type::Resource;
            rec."line type"::"G/L Account":
                rec.Type := rec.Type::"G/L Account";
            rec."line type"::"Charge (Item)":
                rec.Type := rec.Type::"Charge (Item)";
            rec."line type"::Other:
                begin
                    rec."Line Type" := rec."line type"::Structure;
                    rec.Type := rec.Type::Resource;
                end;
            else
                ;
        end;

        rec."Document Type" := SalesHeader."Document Type";
        rec."Document No." := SalesHeader."No.";
        rec."Order Type" := SalesHeader."Order Type";

        PresentationMgt.OnNewRecord(Rec, xRec, BelowxRec, false);

        if (xRec."Line Type" = 0) or (xRec."Line Type" = rec."line type"::Other) then begin
            rec."Line Type" := rec."line type"::Structure;
            rec.Type := rec.Type::Resource;
        end;

        rec.wInitLocationCode;
        Clear(ShortcutDimCode);
        wNew := true;
        wRecordRef.Close;
        case rec.Type of
            rec.Type::Item:
                wRecordRef.Open(27);
            rec.Type::Resource:
                wRecordRef.Open(156);
            else
                wRecordRef.Open(36);
        end;
        gBelowxrec := BelowxRec;
        if wMarked then
            rec.Mark(true);
        OkMetre := 0;
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lSalesLine: Record "Sales Line";
        lGLSetup: Record "General Ledger Setup";
    begin
        wNavibatSetup.GET;
        lGLSetup.Get;
        if StrPos(Format(lGLSetup."Amount Rounding Precision"), ',') <> 0 then
            wSeparator := ','
        else
            wSeparator := '.';

        wShowExtendedText := true;
        if wQtySetup.Get then;
        OnActivateForm;
    end;

    var
        UpdateAllowedVar: Boolean;
        SalesHeader: Record "Sales Header";
        gOneSubFormMgt: Codeunit "NaviOne SubForm Management";
        wItem: Record Item;
        wNavibatSetup: Record NavibatSetup;
        SetupStudy: Record "Sales Line View";
        xSetupStudy: Record "Sales Line View";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        TransferExtendedText2: Codeunit SoroubatFucntion;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        PresentationMgt: Codeunit "Presentation Management";
        StructureMgt: Codeunit "Structure Management";
        CalcAmount: Codeunit "Calc. Amount Management";
        Search: Codeunit SearchCode;
        Overhead: Codeunit "Overhead Calculation";
        SubcontractingMgt: Codeunit "Subcontracting Management";
        ShortcutDimCode: array[8] of Code[20];
        ActualExpansionStatus: Integer;
        Text000: label 'Unable to execute this function while in view only mode.';
        Text8003900: label 'You can delete only one line.';
        Text8003901: label 'The No. isnot right with the level you want to have.';
        tExtentedText: label 'You must show detail form tomodify extended texts';
        tOnlyOneLine: label 'Only one line selected. Do you want to continue?';
        wNew: Boolean;
        OkMetre: Integer;
        wRecordRef: RecordRef;
        wLookUp: Boolean;
        gBelowxrec: Boolean;
        tIndentationTotaling: label 'Do you want to indent this totaling?';
        tInsertExtendedText: label 'Do you want to add extended text from structure/item ?';
        JobCostAssgnt: Text[250];
        wShowLevel: Integer;
        wShowExtendedText: Boolean;
        ForeColor: Integer;
        FontBold: Boolean;
        tUpdate: label 'Download....';
        ErrorInsert: label 'You must do F3 before to insert.';
        wProfit: Decimal;
        wMarked: Boolean;
        wOKLookup: Boolean;
        tPurhaseIsEmpty: label 'There is no purchase document associated to this line.';
        QtyCumToInv: Decimal;
        wAmount: array[10] of Decimal;
        tFreeAmount: label 'Not Used';
        wSeparator: Text[1];
        wFirst: Boolean;
        tErrorTransfer: label 'Qty shipped must be 0';
        tOtherResource: label 'You cannot select Other resources in this page.';
        wKOLookup: Boolean;
        wShowTotalingValue: Boolean;
        wEdit: Boolean;
        wQtySetup: Record "Quantity Setup";
        wQtyPersonPerUnit: Decimal;
        wBOQMgt: Codeunit "BOQ Management";
        wBOQLoad: Boolean;
        gProfitAmount: Decimal;
        wBoqState: Option " ","None","Has Just Variables","Has Results","Has Errors";
        Avancement: Decimal;
        Avancement2: Text[30];
        [InDataSet]
        TMVisible: Boolean;
        [InDataSet]
        TotalCostLCYbyLineTypeVisible: Boolean;
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
        QuantityText: Text[1024];
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
        "Shipped Not InvoicedEmphasize": Boolean;
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
        "Line No.Visible": Boolean;
        [InDataSet]
        "No.Visible": Boolean;
        [InDataSet]
        "Location CodeVisible": Boolean;
        [InDataSet]
        "Customer Price GroupVisible": Boolean;
        [InDataSet]
        "Shipment DateVisible": Boolean;
        [InDataSet]
        DescriptionVisible: Boolean;
        [InDataSet]
        "Description 2Visible": Boolean;
        [InDataSet]
        QtyperUnitofMeasureVisible: Boolean;
        [InDataSet]
        "Unit of MeasureVisible": Boolean;
        [InDataSet]
        QuantityVisible: Boolean;
        [InDataSet]
        "Quantity (Base)Visible": Boolean;
        [InDataSet]
        "Qty. to ShipVisible": Boolean;
        [InDataSet]
        "Quantity ShippedVisible": Boolean;
        [InDataSet]
        "Qty. to InvoiceVisible": Boolean;
        [InDataSet]
        "Quantity InvoicedVisible": Boolean;
        [InDataSet]
        "Unit PriceVisible": Boolean;
        [InDataSet]
        "Line Discount %Visible": Boolean;
        [InDataSet]
        "Line Discount AmountVisible": Boolean;
        [InDataSet]
        "Allow Invoice Disc.Visible": Boolean;
        [InDataSet]
        ShortcutDimension1CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension2CodeVisible: Boolean;
        [InDataSet]
        "Job No.Visible": Boolean;
        [InDataSet]
        "Job Task No.Visible": Boolean;
        [InDataSet]
        "Work Type CodeVisible": Boolean;
        [InDataSet]
        GenProdPostingGroupVisible: Boolean;
        [InDataSet]
        "VAT Prod. Posting GroupVisible": Boolean;
        [InDataSet]
        "VAT Bus. Posting GroupVisible": Boolean;
        [InDataSet]
        "Unit Cost (LCY)Visible": Boolean;
        [InDataSet]
        "Line AmountVisible": Boolean;
        [InDataSet]
        "Variant CodeVisible": Boolean;
        [InDataSet]
        "Unit of Measure CodeVisible": Boolean;
        [InDataSet]
        "Substitution AvailableVisible": Boolean;
        [InDataSet]
        "Cross-Reference No.Visible": Boolean;
        [InDataSet]
        MarkerVisible: Boolean;
        [InDataSet]
        NonstockVisible: Boolean;
        [InDataSet]
        "Purchasing CodeVisible": Boolean;
        [InDataSet]
        "Vendor No.Visible": Boolean;
        [InDataSet]
        "Purch. Order Qty (Base)Visible": Boolean;
        [InDataSet]
        PurchOrderReceiptDateVisible: Boolean;
        [InDataSet]
        PurchOrderRcptQtyBaseVisible: Boolean;
        [InDataSet]
        "Line TypeVisible": Boolean;
        [InDataSet]
        "Presentation CodeVisible": Boolean;
        [InDataSet]
        LevelVisible: Boolean;
        [InDataSet]
        "Rate AmountVisible": Boolean;
        [InDataSet]
        "Total Cost (LCY)Visible": Boolean;
        [InDataSet]
        TheoreticalProfitAmountLCYVisi: Boolean;
        [InDataSet]
        "Overhead Amount (LCY)Visible": Boolean;
        [InDataSet]
        "Fixed PriceVisible": Boolean;
        [InDataSet]
        "Existing PriceVisible": Boolean;
        [InDataSet]
        "Value 1Visible": Boolean;
        [InDataSet]
        "Value 2Visible": Boolean;
        [InDataSet]
        "Value 3Visible": Boolean;
        [InDataSet]
        "Value 4Visible": Boolean;
        [InDataSet]
        "Value 5Visible": Boolean;
        [InDataSet]
        "Value 6Visible": Boolean;
        [InDataSet]
        "Value 7Visible": Boolean;
        [InDataSet]
        "Value 8Visible": Boolean;
        [InDataSet]
        "Value 9Visible": Boolean;
        [InDataSet]
        "Value 10Visible": Boolean;
        [InDataSet]
        "Bill of QuantitiesVisible": Boolean;
        [InDataSet]
        "Job Costs (LCY)Visible": Boolean;
        [InDataSet]
        "FA Posting DateVisible": Boolean;
        [InDataSet]
        "Depreciation Book CodeVisible": Boolean;
        [InDataSet]
        DepruntilFAPostingDateVisible: Boolean;
        [InDataSet]
        QtyPersonPerUntVisible: Boolean;
        [InDataSet]
        RateVisible: Boolean;
        [InDataSet]
        DurationVisible: Boolean;
        [InDataSet]
        SubcontractingVisible: Boolean;
        [InDataSet]
        "Completely ShippedVisible": Boolean;
        [InDataSet]
        OptionVisible: Boolean;
        [InDataSet]
        "Assignment BasisVisible": Boolean;
        [InDataSet]
        "Assignment MethodVisible": Boolean;
        [InDataSet]
        JobCostAssignmentVisible: Boolean;
        [InDataSet]
        UnitAmountRoundingPrecisionVis: Boolean;
        [InDataSet]
        GenProdPostingProrataVisible: Boolean;
        [InDataSet]
        "Internal DescriptionVisible": Boolean;
        [InDataSet]
        JobCostsMarginIncludedVisible: Boolean;
        [InDataSet]
        "Inv. Discount AmountVisible": Boolean;
        [InDataSet]
        "Print Option LineVisible": Boolean;
        [InDataSet]
        PToInvoiceVisible: Boolean;
        [InDataSet]
        "Non Valued CodeVisible": Boolean;
        [InDataSet]
        ProfitAmountVisible: Boolean;
        [InDataSet]
        "Unit PriceEditable": Boolean;
        [InDataSet]
        "Fixed PriceEditable": Boolean;
        [InDataSet]
        "Line Discount %Editable": Boolean;
        [InDataSet]
        "Line Discount AmountEditable": Boolean;
        [InDataSet]
        "Allow Invoice Disc.Editable": Boolean;
        [InDataSet]
        "Line AmountEditable": Boolean;
        //GL2024
        DescriptionUPDATESELECTED: Boolean;


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


    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        lSalesLine: Record "Sales Line";
        PurchOrder: Page "Purchase Order";
        lPurchQuote: Page "Purchase Quote";
        lPurchasDocType: Option;
        lPurchasDocNo: Code[20];
    begin
        //SUBCONTRACTOR
        if rec.Type = rec.Type::" " then begin
            if lSalesLine.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.") then begin
                lPurchasDocType := lSalesLine."Purchasing Document Type";
                lPurchasDocNo := lSalesLine."Purchasing Order No.";
            end else begin
                lPurchasDocType := 0;
                lPurchasDocNo := '';
            end;
        end else begin
            lPurchasDocType := rec."Purchasing Document Type";
            lPurchasDocNo := rec."Purchasing Order No.";
        end;

        PurchHeader.SetRange("Document Type", lPurchasDocType);
        PurchHeader.SetRange("No.", lPurchasDocNo);
        if PurchHeader.IsEmpty then
            Error(tPurhaseIsEmpty);
        if rec."Purchasing Document Type" = rec."purchasing document type"::Quote then begin
            lPurchQuote.SetTableview(PurchHeader);
            lPurchQuote.Editable := false;
            lPurchQuote.Run;
        end else
            if rec."Purchasing Document Type" = rec."purchasing document type"::Order then begin
                //SUBCONTRACTOR//
                PurchOrder.SetTableview(PurchHeader);
                PurchOrder.Editable := false;
                PurchOrder.Run;
                //SUBCONTRACTOR
            end;
        //SUBCONTRACTOR//
    end;


    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        rec.TestField("Special Order Purchase No.");
        PurchHeader.SetRange("No.", rec."Special Order Purchase No.");
        PurchOrder.SetTableview(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;


    procedure InsertExtendedText(Unconditionally: Boolean; pxRecNo: Code[20])
    var
        lInsertText: Boolean;
        Cdufunction: Codeunit SoroubatFucntion;
    begin
        /*Original code
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          gSaveRecord()
          TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          UpdateForm(TRUE);
        */

        lInsertText := not rec."Imported Line";

        //#6300----------
        lInsertText := rec."Item Reference No." = '';
        //#6300----------//

        if lInsertText then begin
            wNew := false;
            if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
                //#5427
                if rec."Item Reference No." = '' then begin
                    //#5427//
                    //#RTC - 2009
                    //gSaveRecord();
                    CurrPage.SaveRecord();
                    //#RTC - 2009//
                end;
                TransferExtendedText.InsertSalesExtText(Rec);
            end;
            Cdufunction.wDeleteSalesLineDescription(Rec);
            if TransferExtendedText.MakeUpdate or
               Cdufunction.wInsertSalesLineDescription(Rec)
            then begin
                gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);
                //#5427
                if rec."Item Reference No." = '' then
                    //#5427//
                    UpdateForm(true);
            end;
        end;

    end;


    procedure ShowReservation()
    begin
        rec.Find;
        Rec.ShowReservation;
    end;

    //DYS
    // procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    // begin
    //     rec.ItemAvailability(AvailabilityType);
    // end;


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
        Trackingpage: Page "Order Tracking";
    begin

        Trackingpage.SetSalesLine(Rec);
        Trackingpage.RUNMODAL;
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
        SalesHeader.Get(rec."Document Type", rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;


    procedure ShowLineDisc()
    begin
        SalesHeader.Get(rec."Document Type", rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;


    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
    begin
        OrderPromisingLine.SetRange("Source Type", rec."Document Type");
        OrderPromisingLine.SetRange("Source ID", rec."Document No.");
        OrderPromisingLine.SetRange("Source Line No.", rec."Line No.");
        Page.RunModal(Page::"Order Promising Lines", OrderPromisingLine);
    end;


    procedure ToggleExpandCollapse(pExpandAll: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        if gOneSubFormMgt.gToggleExpandCollapse(pExpandAll, ActualExpansionStatus, Rec, wMarked) then
            CurrPage.Update;
    end;


    procedure GetShipment()
    begin
        Codeunit.Run(Codeunit::"Sales-Get Shipment", Rec);
    end;


    procedure GetJobLedger()
    begin
        //MIG 5.00
        //GetJobUsage.SetCurrentSalesLine(Rec);
        //GetJobUsage.RUNMODAL;
        //CLEAR(GetJobUsage);
        Message('F8004048.GetJobLedger : Cette fonction est provisoirement désactivée');
        //MIG 5.00//
    end;


    procedure Move(MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lFatherLine: Record "Sales Line";
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lSalesLineMng: Codeunit "SalesLine Management";
        lDirection: Integer;
        lEOF: Text[1];
        lFromRecRef: RecordRef;
        lFatherref: RecordRef;
        lLoadOK: Boolean;
        "---": Integer;
        lCount: Integer;
        lOldValue: Decimal;
    begin
        Clear(PresentationMgt);
        if lSalesLine.Get(rec."Document Type", rec."Document No.", rec."Line No.") then
            lSalesLine2.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        CurrPage.SetSelectionFilter(lSalesLine2);
        if MoveOpt in [Moveopt::Left, Moveopt::Down] then begin
            lEOF := '+';
            lDirection := -1;
        end else begin
            lEOF := '-';
            lDirection := 1;
        end;
        if not lSalesLine2.IsEmpty then begin
            //#6115
            lFatherref.GetTable(SalesHeader);
            //#6115//
            lSalesLine2.Find(lEOF);
            repeat
                lSalesLine.Get(lSalesLine2."Document Type", lSalesLine2."Document No.", lSalesLine2."Line No.");
                if (lSalesLine."Presentation Code" = lSalesLine2."Presentation Code") and not lSalesLine.Mark then begin
                    case MoveOpt of
                        Moveopt::Left:
                            PresentationMgt.wLeft(lSalesLine, false);
                        Moveopt::Right:
                            PresentationMgt.wRight(lSalesLine, false);
                        Moveopt::Up:
                            PresentationMgt.wUp(lSalesLine, false);
                        Moveopt::Down:
                            PresentationMgt.wDown(lSalesLine, false);
                        else
                            ;
                    end;
                    lSalesLine."Value 10" := lOldValue;
                    if lSalesLine.Modify then;
                    lSalesLine.Mark(true);
                    //#6115
                    if wBOQLoad then begin
                        if lSalesLine."Attached to Line No." <> 0 then begin
                            lFatherLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Attached to Line No.");
                            lFatherref.GetTable(lFatherLine);
                        end;
                        lFromRecRef.GetTable(lSalesLine);
                        wBOQMgt.AssignFatherNode(lFatherref.RecordId, lFromRecRef.RecordId);
                        wBOQMgt.Save('');
                        //#9035
                        fRecalculateBOQ();
                        //#9035//
                    end;
                    //#6115//
                end;
                //9088
                lSalesLine2.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
            //9088//
            until lSalesLine2.Next(lDirection) = 0;
        end;
        Clear(lSalesLine2);
        if lSalesLine2.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.") then
            lSalesLineMng.wUpdateTotalLine(lSalesLine2);
        rec.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
        if lSalesLine2.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.") then
            lSalesLineMng.wUpdateTotalLine(lSalesLine2);
        CurrPage.Update(false);
    end;


    procedure ShowColumns(var pPresentationCode: Code[10])
    var
        lClassicVisible: Boolean;
    begin
        if SetupStudy.Get(pPresentationCode) then begin
            //TRS-2009
            lClassicVisible := false;
            "Line No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."No.";
            "No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Location Code";
            "Location CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Customer Price Group";
            "Customer Price GroupVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Shipment Date";
            "Shipment DateVisible" := lClassicVisible;
            lClassicVisible := SetupStudy.Description;
            DescriptionVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Description 2";
            "Description 2Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Qty. per Unit of Measure";
            QtyperUnitofMeasureVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Unit of Measure";
            "Unit of MeasureVisible" := lClassicVisible;
            lClassicVisible := SetupStudy.Quantity;
            QuantityVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Quantity (Base)";
            "Quantity (Base)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Qty. to Ship";
            "Qty. to ShipVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Quantity Shipped";
            "Quantity ShippedVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Qty. to Invoice";
            "Qty. to InvoiceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Quantity Invoiced";
            "Quantity InvoicedVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Profit %";
            TMVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Unit Price";
            "Unit PriceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Line Discount %";
            "Line Discount %Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Line Discount Amount";
            "Line Discount AmountVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Allow Invoice Disc.";
            "Allow Invoice Disc.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Shortcut Dimension 1 Code";
            ShortcutDimension1CodeVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Shortcut Dimension 2 Code";
            ShortcutDimension2CodeVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Job No.";
            "Job No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Job Task No.";
            "Job Task No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Work Type Code";
            "Work Type CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Gen. Prod. Posting Group";
            GenProdPostingGroupVisible := lClassicVisible;
            lClassicVisible := SetupStudy."VAT Prod. Posting Group";
            "VAT Prod. Posting GroupVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."VAT Bus. Posting Group";
            "VAT Bus. Posting GroupVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Unit Cost";
            "Unit Cost (LCY)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Line Amount";
            "Line AmountVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Variant Code";
            "Variant CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Unit of Measure Code";
            "Unit of Measure CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Substitution Available";
            "Substitution AvailableVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Cross-Reference No.";
            "Cross-Reference No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy.Marker;
            MarkerVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Non Stock";
            NonstockVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Purchasing code";
            "Purchasing CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Vendor No.";
            "Vendor No.Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Purch. Order Qty (Base)";
            "Purch. Order Qty (Base)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Purch. Order Receipt Date";
            PurchOrderReceiptDateVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Purch. Order Rcpt. Qty (Base)";
            PurchOrderRcptQtyBaseVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Line Type";
            "Line TypeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Presentation Code";
            "Presentation CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy.Level;
            LevelVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Rate Amount";
            "Rate AmountVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Total Cost (LCY)";
            "Total Cost (LCY)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Theoretical Profit Amount(LCY)";
            TheoreticalProfitAmountLCYVisi := lClassicVisible;
            lClassicVisible := SetupStudy."Overhead Amount (LCY)";
            "Overhead Amount (LCY)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Fixed Price";
            "Fixed PriceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy.SalesPriceExist;
            "Existing PriceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 1";
            "Value 1Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 2";
            "Value 2Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 3";
            "Value 3Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 4";
            "Value 4Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 5";
            "Value 5Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 6";
            "Value 6Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 7";
            "Value 7Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 8";
            "Value 8Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 9";
            "Value 9Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Value 10";
            "Value 10Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Bill of quantities";
            "Bill of QuantitiesVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Job Costs (LCY)";
            "Job Costs (LCY)Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."FA Posting Date";
            "FA Posting DateVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Depreciation Book Code";
            "Depreciation Book CodeVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Depr. until FA Posting Date";
            DepruntilFAPostingDateVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 1";
            "Amount 1Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 2";
            "Amount 2Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 3";
            "Amount 3Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 4";
            "Amount 4Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 5";
            "Amount 5Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 6";
            "Amount 6Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 7";
            "Amount 7Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 8";
            "Amount 8Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 9";
            "Amount 9Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Amount 10";
            "Amount 10Visible" := lClassicVisible;
            lClassicVisible := SetupStudy."Person Quantity";
            "Person QuantityVisible" := lClassicVisible;
            //#6079
            lClassicVisible := SetupStudy."Person Quantity";
            QtyPersonPerUntVisible := lClassicVisible;
            //#6079
            lClassicVisible := SetupStudy."Total Cost LCY Excl. Person";
            TotalCostLCYbyLineTypeVisible := lClassicVisible;
            lClassicVisible := SetupStudy.Rate;
            RateVisible := lClassicVisible;
            lClassicVisible := SetupStudy.Duration;
            DurationVisible := lClassicVisible;
            lClassicVisible := SetupStudy.Subcontracting;
            SubcontractingVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Completely Shipped";
            "Completely ShippedVisible" := lClassicVisible;
            lClassicVisible := SetupStudy.Option;
            OptionVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Distribution Basis";
            "Assignment BasisVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Distribution Method";
            "Assignment MethodVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Job Cost Marked";
            JobCostAssignmentVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Unit-Amount Rounding Precision";
            UnitAmountRoundingPrecisionVis := lClassicVisible;
            lClassicVisible := SetupStudy."Gen. Prod. Posting Prorata";
            GenProdPostingProrataVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Internal Description";
            "Internal DescriptionVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Job Costs Margin Included";
            JobCostsMarginIncludedVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Inv. Discount Amount";
            "Inv. Discount AmountVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Print Option Line";
            "Print Option LineVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Depr. until FA Posting Date";
            DepruntilFAPostingDateVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Fixed Price";
            "Fixed PriceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."Sales Line Disc. Exists";
            "Existing PriceVisible" := lClassicVisible;
            lClassicVisible := SetupStudy."% to Invoice";
            PToInvoiceVisible := lClassicVisible;
            lClassicVisible := SetupStudy."Non Valued Code";
            "Non Valued CodeVisible" := lClassicVisible;
            //#6409
            lClassicVisible := SetupStudy."Profit Amount";
            ProfitAmountVisible := lClassicVisible;
            //#6409//
        end;
        xSetupStudy := SetupStudy;
        CurrPage.Update(false);
    end;


    procedure wEditable()
    var
        lEditable: Boolean;
    begin
        lEditable := (Rec."Line Type" <> Rec."line type"::Structure);
        "Unit Cost (LCY)Editable" := lEditable;
        lEditable := true;
        if lEditable and (Rec."Line Type" <> Rec."line type"::Structure) then
            "Unit Cost (LCY)Editable" := true
        else
            "Unit Cost (LCY)Editable" := false;
        "Unit PriceEditable" := lEditable;
        "Fixed PriceEditable" := lEditable;
        "Line Discount %Editable" := lEditable;
        "Line Discount AmountEditable" := lEditable;
        "Allow Invoice Disc.Editable" := lEditable;
        "Line AmountEditable" := lEditable;
    end;


    /* GL2024 NAVIBAT  procedure wCalculateQty()
       var
           lCalcQty: Codeunit 8004051;
       begin
           if OkMetre <> 2 then
               if Page.RunModal(Page::"Quantity Calculation Form", Rec) <> Action::LookupOK then
                   Rec := xRec;
       end;*/


    procedure wFindLevel()
    var
        lLevel: Integer;
        i: Integer;
    begin
        if rec."Line Type" = rec."line type"::Totaling then begin
            lLevel := 1;
            if rec."No." <> '.' then begin
                for i := 1 to StrLen(rec."No.") do
                    if (rec."No."[i] = '.') and (StrLen(rec."No.") <> i) then
                        lLevel += 1;
            end;
            if lLevel > rec.Level then begin
                while lLevel > rec.Level do
                    Move(2);
            end
            else
                if lLevel < rec.Level then
                    while lLevel < rec.Level do
                        Move(1);
        end;
    end;


    procedure ShowDescription()
    var
        lDescriptionLine: Record "Description Line";
    begin
        //DESCRIPTION
        rec.TestField("Line No.");
        lDescriptionLine.ShowDescription(Database::"Sales Line", rec."Document Type", rec."Document No.", rec."Line No.");
        //DESCRIPTION//
    end;


    procedure SetAfterGet(pPresentationCode: Code[10])
    var
        lRecRef: RecordRef;
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        if not SetupStudy.Get(pPresentationCode) then
            SetupStudy.Init;
        if not wFirst then
            rec.ClearMarks;
        rec.MarkedOnly(wFirst);
        wMarked := false;
        wFirst := false;
        //#6115
        Clear(wBOQMgt);
        lRecRef.GetTable(SalesHeader);
        wBOQLoad := wBOQMgt.Load(lRecRef.RecordId);
        //#6115//
    end;

    local procedure lAssistEdit()
    var
        lRec: Record "Sales Line";
        lxRec: Record "Sales Line";
        //GL2024   lSalesLineStc: Page 8004054;
        lRecordRef: RecordRef;
        lCustomBoq: Codeunit "BOQ Custom Management";
    begin
        //#5348
        if Rec.Description <> xRec.Description then begin
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SaveRecord();
            //#RTC - 2009//
        end;
        //#5348
        lxRec := Rec;
        lRec.Copy(Rec);
        lRec.FilterGroup(10);
        //#5447
        //IF (lRec."Line Type" = lRec."Line Type"::" ") AND (lRec."Attached to Line No." = 0) AND (lRec."No." = '') THEN
        if (lRec."Attached to Line No." = 0) and (lRec."No." = '') then
            exit;
        //#5447//
        if (lRec."Line Type" = lRec."line type"::" ") and (lRec."Attached to Line No." <> 0) and (lRec."No." = '') then begin
            lRec.SetRange("Document Type", lRec."Document Type");
            lRec.SetRange("Document No.", lRec."Document No.");
            lRec.SetRange("Line No.", lRec."Attached to Line No.");
            if lRec.FindFirst then
                //#5447
                if (lRec."Attached to Line No." = 0) and (lRec."No." = '') then
                    exit;
            //#5447//
        end else
            lRec.SetRecfilter;
        lRec.FilterGroup(0);
        if lRec.FindFirst then begin
            //#7357
            //page.RUNMODAL(page::"Sales Line Structure",lRec);
            //GL2024    lSalesLineStc.SetRecord(lRec);
            //GL2024     lSalesLineStc.RunModal();
            /*GL2024    if (lSalesLineStc.fRecalculateBOQ()) then begin
                  lRecordRef.GetTable(Rec);
                  lCustomBoq.fCalcBOQRef(lRecordRef, true, true);
                  lCustomBoq.fFinalise();
                  Rec.wUpdateLine(Rec, lxRec, true);
              end;*/
            //#7357//
        end;
        Rec.Get(rec."Document Type", rec."Document No.", rec."Line No.");
        CurrPage.Update;

        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);
    end;


    procedure wStructure()
    var
        lRec: Record "Sales Line";
        lxRec: Record "Sales Line";
    begin
        lxRec := Rec;
        lRec.Copy(Rec);
        lRec.FilterGroup(10);
        lRec.SetRecfilter;
        lRec.FilterGroup(0);
        //GL2024  Page.RunModal(Page::"Sales Line Structure", lRec);
        rec.Find;
        //wUpdateLine(Rec,lxRec,FALSE);
        CurrPage.Update;
    end;


    procedure wSupplyOrder()
    var
        lSupplyOrderMgt: Codeunit "Reordering Req. Management";
        lSalesLine: Record "Sales Line";
        //GL2024 lGenerateSupplyOrder: Report 8003958;
        lSalesHeader: Record "Sales Header";
        lSalesHeaderInternal: Record "Sales Header";
        lJobNo: Code[20];
        lSalesLine2: Record "Sales Line";
        lSalesLine3: Record "Sales Line";
        lFilterCount: Integer;
        lSalesList: Page "Sales List";
    begin
        lSalesLine.CopyFilters(Rec);
        CurrPage.SetSelectionFilter(lSalesLine);
        if lSalesHeader.Get(rec."Document Type", rec."Document No.") then;
        if lSalesLine.Count = 1 then begin
            if not Confirm(tOnlyOneLine, true) then
                exit;
            /*  GL2024 if lSupplyOrderMgt.fGenerateSupplyOrder(lSalesHeader, lSalesLine, rec."Job No.", lSalesHeaderInternal) then
                   Page.RunModal(Page::"Reordering Requisition", lSalesHeaderInternal);*/
        end
        else begin
            lSalesLine.Find('-');
            repeat
                lSalesLine.Mark(true);
            until lSalesLine.Next = 0;
            //#
            lSalesLine.MarkedOnly(true);
            lSalesLine3.SetCurrentkey("Job No.", "Job Task No.", "Document Type", "Gen. Prod. Posting Group", Disable, Option, "Line Type",
                "Structure Line No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            //#//
            lSalesLine3.CopyFilters(Rec);
            lSalesLine3.Find('-');
            lJobNo := '';
            repeat
                if lSalesLine.Get(lSalesHeader."Document Type", lSalesHeader."No.", lSalesLine3."Line No.") then begin
                    if (lJobNo <> lSalesLine."Job No.") then begin
                        lSalesLine2.Reset;
                        lSalesLine2.CopyFilters(Rec);
                        CurrPage.SetSelectionFilter(lSalesLine2);
                        lSalesLine2.SetRange("Job No.", lSalesLine3."Job No.");
                        if lSupplyOrderMgt.fGenerateSupplyOrder(lSalesHeader, lSalesLine2, lSalesLine3."Job No.", lSalesHeaderInternal) then begin
                            lFilterCount += 1;
                        end;
                    end;
                end;
                lJobNo := lSalesLine3."Job No.";
            until lSalesLine3.Next = 0;
            //COR SCRIPT DA
            lSalesHeaderInternal.SetFilter("Job No.", lJobNo);
            //COR SCRIPT DA//
            if lFilterCount > 1 then begin
                lSalesHeaderInternal.MarkedOnly(true);
                lSalesList.SetTableview(lSalesHeaderInternal);
                lSalesList.RunModal;
            end;
            /*GL2024  else
                  Page.RunModal(Page::"Reordering Requisition", lSalesHeaderInternal);*/
        end;
        //#6630//
    end;


    procedure wFindSupplyOrder()
    var
        lSupplyOrderMgt: Codeunit "Reordering Req. Management";
    begin
        lSupplyOrderMgt.FindLinesOrder(Rec);
    end;


    procedure wCalcJobCostRepartition()
    begin
        Codeunit.Run(Codeunit::"Job Cost Assignment", Rec);
    end;


    procedure lMetre()
    var
        lRec: Record "Sales Line";
        lxRec: Record "Sales Line";
        lSetupSty: Record "Quantity Setup";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#8919
        /*
        IF lSetupSty.GET THEN
          IF NOT lSetupSty."Formula desactivated / Sales" THEN BEGIN
            TESTFIELD("Value 1",0);
            TESTFIELD("Value 2",0);
            TESTFIELD("Value 3",0);
            TESTFIELD("Value 4",0);
            TESTFIELD("Value 5",0);
            TESTFIELD("Value 6",0);
            TESTFIELD("Value 7",0);
            TESTFIELD("Value 8",0);
            TESTFIELD("Value 9",0);
            TESTFIELD("Value 10",0);
        END;
        //#6115
        IF "Line Type" = "Line Type"::" " THEN
          EXIT;
        lRecRef.GETTABLE(Rec);
        IF NOT lBOQCustMgt.fShowBOQLine(lRecRef) THEN
          EXIT;
        //#6115//
        FIND;
        wUpdateLine(Rec,lxRec,TRUE);
        Currpage.UPDATE;
        //#6115
         CLEAR(wBOQMgt);
         lRecRef.GETTABLE(SalesHeader);
         wBOQLoad := wBOQMgt.Load(lRecRef.RECORDID);
        //#6115//
        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText,Rec,wMarked);
        */
        gOneSubFormMgt.fShowBOQ(wBOQMgt, Rec, wShowExtendedText, wMarked, wBOQLoad);
        CurrPage.Update;
        //#8919//

    end;


    procedure wGenerateSubcontracting()
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024 lGenerateSubcontracting: Report 8003982;
    begin
        lSalesLine.CopyFilters(Rec);
        CurrPage.SetSelectionFilter(lSalesLine);
        if lSalesLine.Count = 1 then
            if not Confirm(tOnlyOneLine, true) then
                exit;
        if lSalesHeader.Get(rec."Document Type", rec."Document No.") then;
        //GL2024  lGenerateSubcontracting.SetTableview(lSalesLine);
        //GL2024  lGenerateSubcontracting.RunModal;
    end;


    procedure wFormatFields()
    var
        lTransferOrderLink: Record "Transfer Order Link";
    begin
        if rec.Option then
            ForeColor := 8421504 //Grey
        else
            if rec."Assignment Basis" <> 0 then
                ForeColor := 16711680 // Blue
            else
                ForeColor := 0;
        FontBold := (rec."Line Type" = rec."line type"::Totaling);
    end;


    procedure wCostEditable(): Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        if (rec.Type <> rec.Type::" ") then
            if Rec."Line Type" <> Rec."line type"::Structure then
                exit(true)
            else
                exit(Rec.Subcontracting = Rec.Subcontracting::"Furniture and Fixing");
        exit(false);
    end;


    procedure wSetMarked(pMarked: Boolean; var pShowExtendText: Boolean)
    var
        lRec: Record "Sales Line";
        lRecRef: RecordRef;
    begin
        gOneSubFormMgt.gSetMarked(pMarked, pShowExtendText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
    end;


    procedure wSetVarMarked(pMarked: Boolean; pShowExtendText: Boolean)
    var
        lRec: Record "Sales Line";
    begin
        wMarked := pMarked;
        wShowExtendedText := pShowExtendText;
    end;


    procedure wPassEnt(pEnt: Record "Sales Header")
    begin
        rec.SetRange("Document Type", pEnt."Document Type");
        rec.SetRange("Document No.", pEnt."No.");
        SalesHeader.Copy(pEnt);
    end;


    procedure wGroupCrossRef()
    var
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Group Mgt";
    begin
        lSalesCrossRefMgt.wGroup(Rec);
    end;


    procedure wUnGroupCrossRef()
    var
        lSalesCrossRefMgt: Codeunit "Sales Cross-Ref Group Mgt";
    begin
        //#6814
        if (rec."Cross-Ref. Line No." <> 0) and (rec."Cross-Ref. Line No." <> rec."Line No.") then
            if rec.Get(rec."Document Type", rec."Document No.", rec."Cross-Ref. Line No.") then
                CurrPage.Update(false);
        //#6814//

        lSalesCrossRefMgt.wUnGroup(Rec, false);
    end;


    procedure wOnLookup()
    var
        lxRecNo: Code[20];
        lMultiple: Boolean;
        lSalesPriceMgt: Codeunit "Sales Price Calc. Mgt.";
        lRec: Record "Sales Line";
        lRecNo: Code[20];
        lRecRef: RecordRef;
    begin
        lxRecNo := xRec."No.";
        if rec."Line Type" = rec."line type"::Other then
            rec."Line Type" := rec."line type"::Structure;

        if rec.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, gBelowxrec) then
            if (rec."No." <> '') or lMultiple then begin
                lRecNo := rec."No.";
                if (rec."Line Type" > rec."line type"::" ") then
                    if not lRec.Get(rec."Document Type", rec."Document No.", rec."Line No.") then
                        rec."Line No." := rec.wGetLastCurrNo(rec."Document Type", rec."Document No.", 10000);
                rec."No." := lRecNo;
                if not lMultiple then begin
                    //#RTC - 2009
                    //gSaveRecord();
                    CurrPage.SaveRecord();
                    //#RTC - 2009//
                end;
                wKOLookup := lMultiple;
                if (lxRecNo = '') and not lMultiple then
                    PresentationMgt.wModifyRecordTextWithNo(Rec);
                if not lMultiple then
                    OnAfterLookup(lxRecNo);
                //Affichage
                if lMultiple and (wMarked or not wShowExtendedText) then begin
                    lRec := Rec;
                    rec.MarkedOnly(false);
                    rec.SetRange(Level, rec.Level - 1, rec.Level);
                    rec.SetFilter("Presentation Code", '%1', CopyStr(rec."Presentation Code", 1, StrLen(rec."Presentation Code") - 3) + '*');
                    if rec.Find('+') then
                        repeat
                            rec.Mark(wShowExtendedText or not ((rec."Attached to Line No." <> 0) and (rec."Line Type" = rec."line type"::" ")))
                        until rec.Next(-1) = 0;
                    rec.SetRange(Level);
                    rec.SetRange("Presentation Code");
                    rec.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                    rec.MarkedOnly(true);
                end;
                //#6115
                lRecRef.GetTable(SalesHeader);
                wBOQLoad := wBOQMgt.Load(lRecRef.RecordId);
                //#6115//
                CurrPage.Update;
                //Affichage//
            end;
    end;


    procedure wCopyLine(pArchive: Boolean)
    var
        lSalesLine: Record "Sales Line";
        //GL2024  lCopyStructure: Report 8004070;
        //GL2024  lCopyLine: Page 8004073;
        lRecRef: RecordRef;
    //GL2024 lCopyLineArchive: Page 8004086;
    begin
        if rec.Get(REC."Document Type", rec."Document No.", rec."Line No.") then
            Error(ErrorInsert);
        //#RTC - 2009
        //gSaveRecord();   sd : gsaverecord remplace currpage.saverecord mais insert ds fonction
        CurrPage.SaveRecord();
        //#RTC - 2009//

        lSalesLine.Copy(Rec);
        lSalesLine.Next(-1);

        //GL2024 Clear(lCopyLine);
        //#8254
        /*GL2024   if (pArchive) then begin
               lCopyLineArchive.SetToSalesLine(Rec);
               lCopyLineArchive.RunModal;
           end else begin
               lCopyLine.SetToSalesLine(Rec);
               lCopyLine.RunModal;
           end;*/
        //#8254//

        REC.Copy(lSalesLine);
        gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);
        //#6115
        Clear(wBOQMgt);
        lRecRef.GetTable(SalesHeader);
        wBOQLoad := wBOQMgt.Load(lRecRef.RecordId);
        //#6115//
        CurrPage.Update(false);
    end;


    procedure OnAfterLookup(pxRecNo: Code[20])
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
        lSalesPriceMgt: Codeunit "Sales Price Calc. Mgt.";
        lBoqCalcMgt: Codeunit "BOQ Calculate Mgt";
    begin
        if (rec."Line Type" = rec."line type"::Structure) and (rec."No." <> '') then begin
            StructureMgt.ExplodeStructure(Rec);
            //#7128
            lBoqCalcMgt.fFinalize();
            //#7128//
            SubcontractingMgt.UpdateSubcontractor(Rec);
            Commit;
            wNavibatSetup.GET;
            if (rec."Structure Line No." = 0) and
               (wNavibatSetup."Profit Calculation Method" = wNavibatSetup."profit calculation method"::Structure) then begin
                xRec."Unit Price" := rec."Unit Price";
                lSalesHeader.Get(rec."Document Type", rec."Document No.");
                lSalesPriceMgt.FindSalesLineLineDisc(lSalesHeader, Rec);
                lSalesPriceMgt.FindSalesLinePrice(lSalesHeader, Rec, rec.FieldNo("No."));
                Overhead.SalesLine(Rec, false, true);
                StructureMgt.SumStructureLines(Rec);
            end;
            rec.wUpdateLine(Rec, xRec, true);
        end;

        if not wKOLookup then
            InsertExtendedText(false, pxRecNo);
    end;


    procedure wTransfer()
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        //GL2024  lGenerateTransfer: Report 8003972;
        lSalesHeader: Record "Sales Header";
    begin
        lSalesLine.CopyFilters(Rec);
        CurrPage.SetSelectionFilter(lSalesLine);
        lSalesLine2.Copy(lSalesLine);
        lSalesLine2.SetRange("Structure Line No.", 0);
        lSalesLine2.SetFilter("Quantity Shipped", '<>%1', 0);
        if not lSalesLine2.IsEmpty then
            Error(tErrorTransfer);

        if lSalesLine.Count = 1 then
            if not Confirm(tOnlyOneLine, true) then
                exit;
        if lSalesHeader.Get(rec."Document Type", rec."Document No.") then;
        /*GL2024   lGenerateTransfer.InitRequest(lSalesHeader);
          lGenerateTransfer.SetTableview(lSalesLine);
          lGenerateTransfer.RunModal;
          lGenerateTransfer.RecupCdeCession(lSalesLine);*/


        /* GL2024 if lSalesHeader.Get(lSalesLine."Document Type", lSalesLine."Document No.") then
              Page.RunModal(Page::"Internal Order", lSalesHeader);*/
    end;


    procedure wFindTransfer()
    var
        lSupplyOrderMgt: Codeunit "Reordering Req. Management";
    begin
        lSupplyOrderMgt.FindTransfer(Rec);
    end;


    procedure gGenerateDropShipment()
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    //GL2024    lGenerateDropShipment: Report 8003979;
    begin
        lSalesLine.CopyFilters(Rec);
        CurrPage.SetSelectionFilter(lSalesLine);
        if lSalesLine.Count = 1 then
            if not Confirm(tOnlyOneLine, true) then
                exit;
        if lSalesHeader.Get(rec."Document Type", rec."Document No.") then;
        //GL2024      lGenerateDropShipment.SetTableview(lSalesLine);
        //GL2024     lGenerateDropShipment.RunModal;
    end;


    procedure wCalculateCurrentBOQ(pField: Integer)
    var
        lxRec: Record "Sales Line";
        lSetupSty: Record "Quantity Setup";
        lDialog: Dialog;
        lTextProcess: label 'Calculation underway...';
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lRecRef: RecordRef;
    begin
        //#5771
        lDialog.Open(lTextProcess);
        if lSetupSty.Get then
            if not lSetupSty."Formula desactivated / Sales" then begin
                rec.TestField("Value 1", 0);
                rec.TestField("Value 2", 0);
                rec.TestField("Value 3", 0);
                rec.TestField("Value 4", 0);
                rec.TestField("Value 5", 0);
                rec.TestField("Value 6", 0);
                rec.TestField("Value 7", 0);
                rec.TestField("Value 8", 0);
                rec.TestField("Value 9", 0);
                rec.TestField("Value 10", 0);
            end;

        if not (rec."Line Type" in
                 [rec."line type"::Item, rec."line type"::Person, rec."line type"::Machine, rec."line type"::Structure, rec."line type"::Totaling]) then
            exit;
        lxRec := Rec;

        SalesHeader.Get(rec."Document Type", rec."Document No.");

        //#6115
        lRecRef.GetTable(SalesHeader);
        lBOQCustMgt.fCalcBOQRef(lRecRef, true, true);
        //#7128
        lBOQCustMgt.fFinalise();
        //#7128//
        //#6115//

        if REC.Find then;
        REC.wUpdateLine(Rec, lxRec, true);
        CurrPage.Update;

        gOneSubFormMgt.gRefreshExtendedText(wShowExtendedText, Rec, wMarked);

        lDialog.Close;
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
           REC."Amount Excl. VAT (LCY)" - (REC."Total Cost (LCY)" + REC."Overhead Amount (LCY)" + REC."Job Costs (LCY)" - REC."Job Costs Margin Included");
        //##8422 condition erronée
        if SalesHeader."Currency Code" <> '' then
            gProfitAmount := gProfitAmount * SalesHeader."Currency Factor";
        //#7127//

    end;


    procedure fRecalculateBOQ()
    var
        lRecordID: RecordID;
        lRecordRef: RecordRef;
    begin
        //#7427
        lRecordRef.GetTable(Rec);
        lRecordID := lRecordRef.RecordId;
        if (wNavibatSetup.IsEmpty()) then
            wNavibatSetup.GET();
        if ((not wNavibatSetup."Disable BOQ Calculation") and (Rec."Line Type" = Rec."line type"::Structure) and
           (wBOQMgt.fHasBOQ(lRecordID, true))) then begin
            wCalculateCurrentBOQ(Rec.FieldNo(Quantity));
        end;
        //#7427//
    end;


    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;


    procedure UpdateAllowed(): Boolean
    begin
        if UpdateAllowedVar = false then begin
            Message(Text000);
            exit(false);
        end else
            exit(true);
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
        Retour := false;
        lRecordRef.GetTable(Rec);
        lRecordID := lRecordRef.RecordId;
        if (wNavibatSetup.IsEmpty()) then
            wNavibatSetup.GET();
        if ((not wNavibatSetup."Disable BOQ Calculation") and
           (Rec."Line Type" = Rec."line type"::Structure) and
           (wBOQMgt.fHasBOQ(lRecordID, true))) then begin
            Retour := wBOQMgt.HasReferenceVariable(lRecordID, pFieldNo)
        end;
        //#7768//
    end;


    procedure fOnInsert(pBelowxRec: Boolean) Retour: Boolean
    begin
        Retour := true;
        if wKOLookup then begin
            wKOLookup := false;
            Retour := false;
        end else begin
            gBelowxrec := false;
            if wMarked or not wShowExtendedText then
                REC.Mark(true);
        end;
    end;


    procedure fOnModify()
    begin
        gBelowxrec := false;
    end;


    procedure gSaveRecord()
    var
        lSalesLine: Record "Sales Line";
    begin
        if lSalesLine.Get(REC."Document Type", REC."Document No.", REC."Line No.") then begin
            REC.Modify(true);
            fOnModify();
        end else
            if REC.Insert(true) then
                fOnInsert(false);
    end;



























































    local procedure LineTypeOnAfterValidate()
    var
        lRec: Record "Sales Line";
        lSalesLineMng: Codeunit "SalesLine Management";
        lRecLineType: Option;
        lLevel: Integer;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lBOQMgt: Codeunit "BOQ Management";
        lUpdate: Boolean;
    begin
        //#4688
        //#RTC - 2009
        lUpdate := not ISSERVICETIER;
        //#RTC - 2009//
        lRecLineType := REC."Line Type";
        if (REC."Line Type" > REC."line type"::" ") then
            if not lRec.Get(REC."Document Type", REC."Document No.", REC."Line No.") then
                REC."Line No." := REC.wGetLastCurrNo(REC."Document Type", REC."Document No.", 10000);
        REC."Line Type" := lRecLineType;
        //#4688//

        lRec := xRec;
        if (xRec."Line Type" <> REC."Line Type") then begin
            if (xRec."Line Type" <> REC."line type"::" ") then
                TransferExtendedText2.wDeleteSalesLineDescription(Rec)
            else
                PresentationMgt.wInsertBetweenExtendedText(Rec, xRec);
        end;
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//

        //#6115
        lRecRef.GetTable(SalesHeader);
        if lBOQMgt.Load(lRecRef.RecordId) then
            lBOQCustMgt.gMoveChid(Rec);
        //#6115//

        wEditable;

        CurrPage.Update(lUpdate);

        if REC."Line Type" = REC."line type"::Totaling then
            lSalesLineMng.wUpdateTotalLine(Rec);
        CurrPage.Update(lUpdate);
    end;

    local procedure NoOnAfterValidate()
    var
        lSalesHeader: Record "Sales Header";
        lSalesPriceMgt: Codeunit "Sales Price Calc. Mgt.";
        lxRecNo: Code[20];
        lMultiple: Boolean;
        lRec: Record "Sales Line";
        lxRec: Record "Sales Line";
        lRecNo: Code[20];
        lxLineNo: Integer;
    begin
        lxRecNo := xRec."No.";
        //#4688
        lRecNo := REC."No.";
        //#9178
        lxLineNo := REC."Line No.";
        //#9178//
        if (REC."Line Type" > REC."line type"::" ") then
            if not lRec.Get(REC."Document Type", REC."Document No.", REC."Line No.") then
                REC."Line No." := REC.wGetLastCurrNo(REC."Document Type", REC."Document No.", 10000);
        REC."No." := lRecNo;
        //#4688//

        //#9178
        //GL2024    gOneSubFormMgt.fUpdateDimension(lxLineNo, Rec);
        //#9178//

        if not wKOLookup then begin
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SaveRecord();
            //#RTC - 2009//
        end;
        if wOKLookup and (REC."No." <> '') then begin
            Commit;
            REC.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, gBelowxrec);
            wKOLookup := lMultiple;
            wOKLookup := false;
            lxRecNo := REC."No.";
            if lMultiple and (wMarked or not wShowExtendedText) then begin
                lRec := Rec;
                REC.MarkedOnly(false);
                REC.SetRange(REC.Level, REC.Level - 1, REC.Level);
                REC.SetFilter(REC."Presentation Code", '%1', CopyStr(REC."Presentation Code", 1, StrLen(REC."Presentation Code") - 4) + '*');
                if REC.Find('+') then
                    repeat
                        if wShowExtendedText or not ((REC."Attached to Line No." <> 0) and (REC."Line Type" = REC."line type"::" ")) then
                            REC.Mark(true);
                    until REC.Next(-1) = 0;
                REC.SetRange(Level);
                REC.SetRange("Presentation Code");
                REC.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                REC.MarkedOnly(true);
            end;
        end;

        if (lxRecNo = '') and not wKOLookup then
            PresentationMgt.wModifyRecordTextWithNo(Rec);

        OnAfterLookup(lxRecNo);
        //#7427
        fRecalculateBOQ();
        //#7427//
        CurrPage.Update;
        wKOLookup := false;
    end;

    local procedure OptionOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure AssignmentBasisOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure JobCostAssignmentOnAfterValida()
    begin
        CurrPage.Update;
    end;

    local procedure SubcontractingOnAfterValidate()
    var
        lSCRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        //#6300---------
        lSCRefMgt.wUpdateField(Rec, REC.Subcontracting, REC.FieldNo(Subcontracting));
        //lSCRefMgt.wUpdateSubContracting(Rec);
        //#6300----------//

        CurrPage.Update;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    var
        lSalesHeader: Record "Sales Header";
        lSalesPriceMgt: Codeunit "Sales Price Calc. Mgt.";
        lxRecNo: Code[20];
        lSalesLine: Record "Sales Line";
        lToSalesLineComp: Record "Sales Line";
    begin
        //BAT
        lxRecNo := xRec."No.";
        //#6068
        //#8186
        //IF (xRec."No." <> '') THEN BEGIN
        if (xRec."No." <> '') and (xRec."Line Type" <> xRec."line type"::Totaling) then begin
            //#8186//
            //#6068
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SaveRecord();
            //#RTC - 2009//
        end;
        //#5428 : Comme la désignation
        if (xRec.Description <> REC.Description) or (xRec."Description 2" <> REC."Description 2") then
            //#5428//
            InsertExtendedText(false, lxRecNo);
        CurrPage.Update(false);
        //BAT//
    end;

    local procedure VendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure DescriptionOnAfterValidate()
    var
        lSCRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        //#6300----------
        //IF "No." <> '' THEN
        //  Currpage.UPDATE;
        //IF "Cross-Reference No." <> '' THEN
        //  lSCRefMgt.wValidateExtendedText(Rec);
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        lSCRefMgt.wUpdateField(Rec, REC.Description, REC.FieldNo(Description));
        //lSCRefMgt.wValidateExtendedText(Rec);
        CurrPage.Update(false);
        //#6300----------//
    end;

    local procedure Description2OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value1OnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure Value2OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value3OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value4OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value5OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value6OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value7OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value8OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value9OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Value10OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure QuantityOnAfterValidate()
    var
        TextCompletion: label 'You cannot change a completion document.';
    begin
        //PROJET_FACT
        if (REC."Document Type" in [REC."document type"::Invoice, REC."document type"::"Credit Memo"]) and
            (REC."Scheduler Line No." <> 0) then
            Error(TextCompletion);
        //PROJET_FACT//

        if REC.Reserve = REC.Reserve::Always then begin
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SaveRecord();
            //#RTC - 2009//
            REC.AutoReserve;
        end;
        CurrPage.Update;
    end;

    local procedure Avenant1OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Avenant2OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Avenant3OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure Avenant4OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure QtyperUnitofMeasureOnAfterVali()
    begin
        //#6806
        CurrPage.Update;
        //#6806
    end;

    local procedure QuantityBaseOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    var
        lSCRefMgt: Codeunit "Sales Cross-Ref Management";
    begin
        if REC.Reserve = REC.Reserve::Always then begin
            //#RTC - 2009
            //gSaveRecord();
            CurrPage.SaveRecord();
            //#RTC - 2009//
            REC.AutoReserve;
        end;

        //#6300---------
        lSCRefMgt.wUpdateField(Rec, REC."Unit of Measure Code", REC.FieldNo("Unit of Measure Code"));
        //lSCRefMgt.wUpdateUnitOfMeasure(Rec);
        CurrPage.Update;
        //#6300----------//
    end;

    local procedure RateOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        REC.wUpdateLine(Rec, xRec, false);
        CurrPage.Update;
    end;

    local procedure DurationOnAfterValidate()
    begin
        REC.wUpdateLine(Rec, xRec, false);
        CurrPage.Update;
    end;

    local procedure UnitCostLCYOnAfterValidate()
    var
        lxRec: Record "Sales Line";
    begin
        lxRec := xRec;
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        REC.wUpdateLine(Rec, lxRec, false);
        CurrPage.Update;
    end;

    local procedure OverheadAmountLCYOnAfterValida()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        REC.wUpdateLine(Rec, xRec, false);
        CurrPage.Update;
    end;

    local procedure wProfitOnAfterValidate()
    var
        lClassicVisible: Boolean;
    begin
        //DELETE-RTC2009
        lClassicVisible := true;
        TMVisible := lClassicVisible;
        wNavibatSetup.MarginRateOnValidate(wProfit);
        StructureMgt.wSetProfit(Rec, wProfit, lClassicVisible);
        CurrPage.Update(true);
    end;

    local procedure UnitPriceOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        //wUpdateLine(Rec,xRec,FALSE);
        CurrPage.Update;
    end;

    local procedure UnitAmountRoundingPrecisionOnA()
    begin
        //#7190
        CurrPage.Update;
        //#7190//
    end;

    local procedure LineAmountOnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        REC.wUpdateLine(Rec, xRec, false);
        CurrPage.Update;
    end;

    local procedure FixedPriceOnAfterValidate()
    begin
        CurrPage.Update(true);
        //"Fixed price" := xRec."Fixed Price";
    end;

    local procedure LineDiscount37OnAfterValidate()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        //wUpdateLine(Rec,xRec,FALSE);
        CurrPage.Update;
    end;

    local procedure LineDiscountAmountOnAfterValid()
    begin
        //#RTC - 2009
        //gSaveRecord();
        CurrPage.SaveRecord();
        //#RTC - 2009//
        REC.wUpdateLine(Rec, xRec, false);
        CurrPage.Update;
    end;

    local procedure PersonQuantityOnAfterValidate()
    begin
        //#6079
        CurrPage.Update(false);
        //#6079//
    end;

    local procedure wQtyPersonPerUnitOnAfterValida()
    begin
        //#6079
        CurrPage.Update(false);
        //#6079//
    end;

    local procedure OnAfterGetCurrRecord()
    var
        lSalesLine: Record "Sales Line";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lEditable: Boolean;
    begin
        xRec := Rec;
        wFormatFields;
        wRecordRef.Close;
        case REC.Type of
            REC.Type::Item:
                wRecordRef.Open(27);
            REC.Type::Resource:
                wRecordRef.Open(156);
            else
                wRecordRef.Open(36);
        end;
        gBelowxrec := false;

        //#6079
        lEditable := REC."Line Type" = REC."line type"::Structure;
        QtyPersonPerUntEditable := lEditable;
        //#6079
        //mise à jour du coût unitaire
        "Unit Cost (LCY)Editable" := wCostEditable;
        //COMMIT-LINE
        lSingleInstance.wSetIntegrityVerify(false);
        //COMMIT-LINE//
        lEditable := not REC."Fixed Price" and (REC.Type <> REC.Type::" ");
        TMEditable := lEditable;
        if (REC."Document No." <> xRec."Document No.") and (wMarked or not wShowExtendedText) then
            gOneSubFormMgt.gSetMarked(wMarked, wShowExtendedText, wKOLookup, wBOQLoad, SalesHeader, Rec, wBOQMgt);

        //#8281
        //lEditable := (wQtySetup."Formula desactivated / Sales" AND NOT("Line Type" IN ["Line Type"::Totaling,"Line Type"::Structure]))
        //             OR (NOT wQtySetup."Formula desactivated / Sales" AND (OkMetre <> 2));
        if (wQtySetup."Formula desactivated / Sales") then begin
            lEditable := not (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure]);
            if wQtySetup."Value 1 Total" then
                "Value 1Editable" := lEditable;
            if wQtySetup."Value 2 Total" then
                "Value 2Editable" := lEditable;
            if wQtySetup."Value 3 Total" then
                "Value 3Editable" := lEditable;
            if wQtySetup."Value 4 Total" then
                "Value 4Editable" := lEditable;
            if wQtySetup."Value 5 Total" then
                "Value 5Editable" := lEditable;
            if wQtySetup."Value 6 Total" then
                "Value 6Editable" := lEditable;
            if wQtySetup."Value 7 Total" then
                "Value 7Editable" := lEditable;
            if wQtySetup."Value 8 Total" then
                "Value 8Editable" := lEditable;
            if wQtySetup."Value 9 Total" then
                "Value 9Editable" := lEditable;
            if wQtySetup."Value 10 Total" then
                "Value 10Editable" := lEditable;
        end else begin
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
        end;
        //#8281//
        lEditable := OkMetre <> 2;
        QuantityEditable := lEditable;

        if REC.Quantity <> 0 then
            QtyCumToInv := (REC."Quantity Invoiced" + REC."Qty. to Invoice") / REC.Quantity * 100
        else
            QtyCumToInv := 0;
    end;

    local procedure FixedPriceOnActivate()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := REC."Line Type" <> REC."line type"::Totaling;

        //GL2024 CurrPage."Fixed Price".UPDATEEDITABLE(lEditable);
        //TRS-2009//
    end;

    local procedure AllowInvoiceDiscOnActivate()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := REC."Line Type" <> REC."line type"::Totaling;
        //GL2024CurrPage."Allow Invoice Disc.".UPDATEEDITABLE(lEditable);
        //TRS-2009//
    end;

    local procedure OnActivateForm()
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
    begin
        if REC."Document No." <> '' then begin
            if SalesHeader.Get(REC."Document Type", REC."Document No.") then;
            lSalesOverhead.SetRange("Document Type", REC."Document Type");
            lSalesOverhead.SetRange("Document No.", REC."Document No.");
            if lSalesOverhead.IsEmpty then begin
                if (SalesHeader."Sell-to Customer No." <> '') or (SalesHeader."Sell-to Customer Templ. Code" <> '') then
                    Codeunit.Run(Codeunit::"Overhead Calculation", SalesHeader);
            end;
            Codeunit.Run(Codeunit::"Sales RollBack Mgt", SalesHeader);
        end;
    end;

    local procedure NoOnAfterInput(var Text: Text[1024])
    var
        lCode: Code[20];
        lCodeOrig: Code[20];
        lRes: Record Resource;
    begin
        if (REC."No." <> '') and wOKLookup then
            Text := REC."No.";

        lCode := Text;
        lCodeOrig := Text;
        //#4754
        wRecordRef.Close;
        //#4754//
        if not wKOLookup then
            case REC."Line Type" of
                REC."line type"::Item:
                    begin
                        wRecordRef.Open(27);
                        Search.Search(wRecordRef, lCode);
                        if lCode > ' ' then
                            Text := lCode
                        else begin
                            if Text <> '' then
                                wOKLookup := true;
                        end;
                    end;
                REC."line type"::Person, REC."line type"::Machine, REC."line type"::Structure:
                    begin
                        case REC."Line Type" of
                            REC."line type"::Person:
                                lRes.SetRange(Type, lRes.Type::Person);
                            REC."line type"::Machine:
                                lRes.SetRange(Type, lRes.Type::Machine);
                            REC."line type"::Structure:
                                lRes.SetRange(Type, lRes.Type::Structure);
                        end;
                        wRecordRef.GetTable(lRes);
                        Search.Search(wRecordRef, lCode);
                        if lCode > ' ' then
                            Text := lCode
                        else
                            if Text <> '' then begin  //Erreur ou pas de sélection
                                wOKLookup := true;
                                Text := '???' + lCodeOrig;
                            end;
                    end;
            end;
    end;

    local procedure QuantityOnBeforeInput()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := OkMetre <> 2;
        QuantityEDITABLE := (lEditable);
        //TRS-2009//
    end;

    local procedure LineDiscount37OnBeforeInput()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := REC."Line Type" <> REC."line type"::Totaling;
        "Line Discount %EDITABLE" := (lEditable);
        //TRS-2009//
    end;

    local procedure LineDiscountAmountOnBeforeInpu()
    var
        lEditable: Boolean;
    begin
        //TRS-2009
        lEditable := REC."Line Type" <> REC."line type"::Totaling;
        "Line Discount AmountEDITABLE" := (lEditable);
        //TRS-2009//


    end;

    local procedure ActualExpansionStatusOnPush()
    var
        lRec: Record "Sales Line";
    begin
        if (REC."Line Type" = 0) and (REC."Attached to Line No." <> 0) then begin
        end
        else
            if ActualExpansionStatus > 1 then
                lAssistEdit
            else begin
                if not wMarked then begin
                    lRec.Copy(Rec);
                    if REC.Find('-') then
                        repeat
                            REC.Mark(true);
                        until REC.Next = 0;
                    REC.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                    REC.MarkedOnly(true);
                    wMarked := true;
                end;
                if wMarked then
                    case ActualExpansionStatus of
                        0:
                            begin
                                REC.MarkedOnly(false);
                                REC.SetRange(REC.Level, rec.Level, REC.Level + 1);
                                REC.SetFilter("Presentation Code", '%1', REC."Presentation Code" + '*');
                                if REC.Find('+') then
                                    repeat
                                        if wShowExtendedText or not ((REC."Attached to Line No." <> 0) and (REC."Line Type" = REC."line type"::" ")) then
                                            REC.Mark(true);
                                    until REC.Next(-1) = 0;
                                REC.SetRange(Level);
                                REC.SetRange("Presentation Code");
                                REC.MarkedOnly(true);
                            end;
                        1:
                            begin
                                lRec.Copy(Rec);
                                REC.SetFilter("Presentation Code", '%1', REC."Presentation Code" + '?*');
                                if rec.Find('+') then
                                    repeat
                                        REC.Mark(false);
                                    until REC.Next(-1) = 0;
                                REC.SetRange("Presentation Code");
                                REC.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.");
                            end;
                        else
                            ;
                    end;
            end;
    end;

    local procedure CommentOnPush()
    var
        lDescriptionLine: Record "Description Line";
    begin
        if REC."Line Type" = REC."line type"::" " then
            exit;
        //#5821
        /*
        lDescriptionLine.SETRANGE("Table ID",DATABASE::"Sales Line");
        lDescriptionLine.SETRANGE("Document Type","Document Type");
        lDescriptionLine.SETRANGE("Document No.","Document No.");
        lDescriptionLine.SETRANGE("Document Line No.","Line No.");
        lDescriptionLine.Description := Description;
        page.RUNMODAL(page::Form8004083,lDescriptionLine);
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
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            "Presentation CodeHideValue" := true;
        Text := DelChr(Text);
        wFormatFields;
        "Presentation CodeEmphasize" := FontBold;
    end;

    local procedure LevelOnFormat()
    begin
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            LevelHideValue := true;
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
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            "Assignment BasisHideValue" := true;

        wFormatFields;
        "Assignment BasisEmphasize" := FontBold;
    end;

    local procedure AssignmentMethodOnFormat()
    begin
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            "Assignment MethodHideValue" := true;

        wFormatFields;
        "Assignment MethodEmphasize" := FontBold;
    end;

    local procedure JobCostAssignmentOnFormat(Text: Text[1024])
    var
        lAssgntJobCost: Codeunit "Job Cost Assignment";
    begin
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            "Job Cost AssignmentHideValue" := true;

        wFormatFields;
        JobCostAssignmentEmphasize := FontBold;
        if REC."Assignment Basis" = 0 then
            Text := lAssgntJobCost.Assignment(Rec);
    end;

    local procedure SubcontractingOnFormat()
    begin
        if (REC."Attached to Line No." <> 0) and (REC."Line Type" = 0) and (REC."No." = '') then
            SubcontractingHideValue := true;

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
        if (ISSERVICETIER) then
            lLevel := REC.Level - 1
        else
            lLevel := (REC.Level - 1) * 220;
        if (lLevel >= 0) and (REC."Attached to Line No." <> 0) then
            DescriptionIndent := lLevel;
        //RTS-2009//
        wFormatFields;
        DescriptionEmphasize := FontBold;
        if (REC."Line Type" = REC."line type"::" ") and (REC."Attached to Line No." = 0) and (REC."Job Task No." = '')
           and (REC."Rider Rank" <> 0) then
            DescriptionUPDATESELECTED := (TRUE);
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
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 1 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 1"))) then
            "Value 1HideValue" := true;
        //#7768//
    end;

    local procedure Value2OnFormat()
    begin
        wFormatFields;
        "Value 2Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
          not wQtySetup."Value 2 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
          and (not fHasVarReferenceField(REC.FieldNo("Value 2"))) then
            "Value 2HideValue" := true;
        //#7768//
    end;

    local procedure Value3OnFormat()
    begin
        wFormatFields;
        "Value 3Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 3 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 3"))) then
            "Value 3HideValue" := true;
        //#7768//
    end;

    local procedure Value4OnFormat()
    begin
        wFormatFields;
        "Value 4Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 4 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 4"))) then
            "Value 4HideValue" := true;
        //#7768//
    end;

    local procedure Value5OnFormat()
    begin
        wFormatFields;
        "Value 5Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 5 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 5"))) then
            "Value 5HideValue" := true;
        //#7768//
    end;

    local procedure Value6OnFormat()
    begin
        wFormatFields;
        "Value 6Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 6 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 6"))) then
            "Value 6HideValue" := true;
        //#7768//
    end;

    local procedure Value7OnFormat()
    begin
        wFormatFields;
        "Value 7Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 7 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 7"))) then
            "Value 7HideValue" := true;
        //#7768//
    end;

    local procedure Value8OnFormat()
    begin
        wFormatFields;
        "Value 8Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 8 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 8"))) then
            "Value 8HideValue" := true;
        //#7768//
    end;

    local procedure Value9OnFormat()
    begin
        wFormatFields;
        "Value 9Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 9 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 9"))) then
            "Value 9HideValue" := true;
        //#7768//
    end;

    local procedure Value10OnFormat()
    begin
        wFormatFields;
        "Value 10Emphasize" := FontBold;
        //#7768
        if wQtySetup."Formula desactivated / Sales" and
           not wQtySetup."Value 10 Total" and (REC."Line Type" in [REC."line type"::Totaling, REC."line type"::Structure])
           and (not fHasVarReferenceField(REC.FieldNo("Value 10"))) then
            "Value 10HideValue" := true;
        //#7768//
    end;

    local procedure QuantityTextOnFormat(var Text: Text[1024])
    begin
        wFormatFields;
        //Currpage.Quantity.UPDATEFORECOLOR(ForeColor);
        //Currpage.Quantity.UPDATEFONTBOLD(FontBold);
        if REC.Option and (REC."Optionnal Quantity" <> 0) then
            Text := Format(REC."Optionnal Quantity");
    end;

    local procedure QtyperUnitofMeasureOnFormat()
    begin
        if REC.Type = REC.Type::" " then
            QtyperUnitofMeasureHideValue := true;
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
        if (wShowTotalingValue) then
            "Total Cost (LCY)HideValue" := true;
        //#4797//
    end;

    local procedure OverheadAmountLCYOnFormat()
    begin
        wFormatFields;
        "Overhead Amount (LCY)Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "Overhead Amount (LCY)HideValue" := true;
        //#4797//
    end;

    local procedure TheoreticalProfitAmountLCYOnFo()
    begin
        wFormatFields;
        TheoreticalProfitAmountLCYEmph := FontBold;
        //#4797
        if (wShowTotalingValue) then
            TheoreticalProfitAmountLCYHide := true;
        //#4797//
    end;

    local procedure JobCostsLCYOnFormat()
    begin
        wFormatFields;
        "Job Costs (LCY)Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "Job Costs (LCY)HideValue" := true;
        //#4797//
    end;

    local procedure wProfitOnFormat(Text: Text[1024])
    var
        lFontBold: Boolean;
    begin
        //TRS-2009
        lFontBold := (REC."Profit %" <> 0) or FontBold;
        //TRS-2009//
        wFormatFields;
        TMEmphasize := lFontBold;
        wNavibatSetup.MarginRateOnFormat(Text);
        //#4797
        if (wShowTotalingValue) then
            wProfitHideValue := true;
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
        if REC.Option and (REC."Optionnal Quantity" <> 0) then begin
            Text := Format(ROUND(REC."Optionnal Quantity" * REC."Unit Price" * (1 - REC."Line Discount %" / 100), 0.01));
            if (StrPos(Format(ROUND(REC."Optionnal Quantity" * REC."Unit Price", 0.01)), wSeparator) = 0) then
                Text += wSeparator + '00'
        end;
        //#4797
        if (wShowTotalingValue) then
            "Line AmountHideValue" := true;
        //#4797//
    end;

    local procedure ShippedNotInvoicedOnFormat()
    begin
        if REC."Line Type" = REC."line type"::Totaling then "Shipped Not InvoicedEmphasize" := true;
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
        if REC."Line Type" = 0 then // Evite la répétition sur les lignes de texte étendu
            "Person QuantityHideValue" := true;
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
        if (wShowTotalingValue) then
            "wAmount[1]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount2OnFormat()
    begin
        wFormatFields;
        "Amount 2Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[2]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount3OnFormat()
    begin
        wFormatFields;
        "Amount 3Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[3]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount4OnFormat()
    begin
        wFormatFields;
        "Amount 4Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[4]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount5OnFormat()
    begin
        wFormatFields;
        "Amount 5Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[5]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount6OnFormat()
    begin
        wFormatFields;
        "Amount 6Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[6]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount7OnFormat()
    begin
        wFormatFields;
        "Amount 7Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[7]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount8OnFormat()
    begin
        wFormatFields;
        "Amount 8Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[8]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount9OnFormat()
    begin
        wFormatFields;
        "Amount 9Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[9]HideValue" := true;
        //#4797//
    end;

    local procedure wAmount10OnFormat()
    begin
        wFormatFields;
        "Amount 10Emphasize" := FontBold;
        //#4797
        if (wShowTotalingValue) then
            "wAmount[10]HideValue" := true;
        //#4797//
    end;
}

