Page 50015 "Sous-form. demande de prix"
{
    // TRS-2009 XPE 02/10/09
    //  //+OFF+OFFRE GESWAY 17/10/02 Appel formulaire "Show Related Offer Lines" -> wShowRelatedOfferLines
    //                                 Ajout fonction SetRelatedOffer
    //                                 Interdire l'insertion de lignes si offres fournisseur -> OnInsertNewRecord
    //                                 Get des lignes de la demande principale si offre générée -> OnAfterGetRecord
    //                                 OnFormat sur "Quantity","Direct Unit Cost","Unit Cost (LCY)","Line Amount"
    //                                 Ajout colonne "Offer Comments","Vendor Item No.","Lead Time Calculation"
    //                       06/11/02 Ajout de wShowTracking
    //                       31/03/03 Interdire la modification d'une ligne en commande -> OnModifyRecord
    // //+OFF+REMISE GESWAY 17/10/02 Ajout de "Discount 1 %","Discount 2 %","Discount 3 %"
    //                                "Line Discount %" en Visible=NO
    // //SUBCONTRACTOR GESWAY 10/07/03 Ajout fonction wOpenSalesForm (visu devis ou cde vente)
    // //ACHATS GESWAY 16/02/04 Ajout du champ Gen. Prod. Posting Group", Visible No par défaut
    //                 17/03/04 Appel de la fonction wInitLocationCode sur le OnNewrecord
    //                 21/10/04 Ajout du champ "Requested Receipt Date"
    //                          Ajout désignation 2
    //                          Ajout fonction wEditMemoPad appelée dans les désignations
    // //MULTIPLE GESWAY 25/02/05 Ajout de CurrForm.UPDATE; sur Form - OnActivateForm()
    //                            OnLookUp No. + OnAfterValidate de type
    // //PROJET GESWAY 18/10/07 Ajout des champ Job No., Job Task No.
    // //OUVRAGE GESWAY 12/03/03 ajout fonction wShowDescription

    AutoSplitKey = true;
    Caption = 'Purchase Quote Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Purchase Line";
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = false;
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

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lMultiple: Boolean;
                        lLookup: Codeunit Lookup;
                    begin
                        //MULTIPLE
                        //#5084 CurrForm.SAVERECORD;
                        //#5084 COMMIT;
                        //#7750
                        case (rec.Type) of
                            rec.Type::Item:
                                begin
                                    wRecordref.Open(Database::Item);
                                    if rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) then
                                        if not lMultiple then
                                            InsertExtendedText(false)
                                        else
                                            if rec."Line No." = 0 then
                                                wMult := true;
                                    //#4842
                                    wRecordref.Close;
                                    //#4842//
                                end;
                            rec.Type::"G/L Account":
                                begin
                                    wRecordref.Open(Database::"G/L Account");
                                    if rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) then
                                        if not lMultiple then
                                            InsertExtendedText(false)
                                        else
                                            if rec."Line No." = 0 then
                                                wMult := true;
                                    //#4842
                                    wRecordref.Close;
                                    //#4842//
                                end;
                            else begin
                                lLookup.PurchLineNo(Rec);
                                //#8504
                                InsertExtendedText(false);
                                //#8504//
                            end;
                        end;
                        //#7750//
                        //MULTIPLE//
                    end;

                    trigger OnValidate()
                    begin
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cross-Reference No."; rec."Item Reference No.")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemReference: Record "Item Reference";
                        ItemVendorCatalog: Record "Item Vendor";
                    begin
                        //GL2024  CrossReferenceNoLookUp;
                        //GL2024
                        if REC."No." <> '' then
                            case REC."IC Partner Ref. Type" of
                                REC."IC Partner Ref. Type"::"Cross Reference":
                                    begin
                                        REC.GetPurchHeader();
                                        ItemReference.Reset();
                                        ItemReference.SetCurrentKey("Reference Type", "Reference Type No.");
                                        ItemReference.SetFilter(
                                            "Reference Type", '%1|%2',
                                            ItemReference."Reference Type"::Vendor, ItemReference."Reference Type"::" ");
                                        ItemReference.SetFilter("Reference Type No.", '%1|%2', PurchHeader."Buy-from Vendor No.", '');
                                        if PAGE.RunModal(PAGE::"Item Reference List", ItemReference) = ACTION::LookupOK then
                                            REC.Validate("IC Item Reference No.", ItemReference."Reference No.");
                                    end;
                                REC."IC Partner Ref. Type"::"Vendor Item No.":
                                    begin
                                        REC.GetPurchHeader();
                                        ItemVendorCatalog.SetCurrentKey("Vendor No.");
                                        ItemVendorCatalog.SetRange("Vendor No.", PurchHeader."Buy-from Vendor No.");
                                        if PAGE.RunModal(PAGE::"Vendor Item Catalog", ItemVendorCatalog) = ACTION::LookupOK then
                                            REC.Validate("IC Item Reference No.", ItemVendorCatalog."Vendor Item No.");
                                    end;
                            end;
                        //GL2024
                        InsertExtendedText(false);
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Quantity Received"; rec."Quantity Received")
                {
                    ApplicationArea = all;
                    Style = AttentionAccent;
                    StyleExpr = true;

                }

                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        //ACHATS
                        CurrPage.SaveRecord;
                        //#9175
                        Commit;
                        if rec.fMemoPad then
                            CurrPage.Update;
                        //IF wEditMemoPad THEN
                        //  CurrForm.UPDATE;
                        //#9175//
                        //ACHATS//
                    end;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        //ACHATS
                        CurrPage.SaveRecord;
                        if wEditMemoPad then
                            CurrPage.Update;
                        //ACHATS//
                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                // field("Emplacement"; rec."Emplacement")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Tree Code"; rec."Tree Code")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
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
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    //blankzero = true;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                }
                /*  field("Quantity Received"; Rec."Quantity Received")
                  {
                      ApplicationArea = all;
                      //blankzero = true;
                  }*/
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                }
                field("Indirect Cost %"; rec."Indirect Cost %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Price (LCY)"; rec."Unit Price (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                }
                field("Discount 1 %"; rec."Discount 1 %")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = false;
                }
                field("Discount 2 %"; rec."Discount 2 %")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = false;
                }
                field("Discount 3 %"; rec."Discount 3 %")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = false;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    Visible = false;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Qty. to Assign"; rec."Qty. to Assign")
                {
                    ApplicationArea = all;
                    //blankzero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; rec."Qty. Assigned")
                {
                    ApplicationArea = all;
                    //blankzero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Prod. Order No."; rec."Prod. Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order Line No."; rec."Blanket Order Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
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
                field(wInternalOrderExist; wInternalOrderExist)
                {
                    ApplicationArea = all;
                    Caption = 'Internal Order';
                    Editable = false;
                    //    OptionCaption = 'Boolean';
                    Visible = false;
                }
                field(wTransferOrderExist; wTransferOrderExist)
                {
                    ApplicationArea = all;
                    Caption = 'Transfer Order';
                    Editable = false;
                    // OptionCaption = 'Boolean';
                }
            }
            /*   group(ItemPanel)
               {
                   Caption = 'Item Information';
                   field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcAvailability(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcAvailability(Rec)))
                   {
                       ShowCaption = false;
                       ApplicationArea = all;
                       Editable = false;
                   }
                   field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                   {
                       ShowCaption = false;
                       ApplicationArea = all;
                       Editable = false;
                   }
                   field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
                   {
                       ShowCaption = false;
                       ApplicationArea = all;
                       Editable = false;
                   }
               }*/
        }
    }

    actions
    {
        area(processing)
        {
            action("Purchase Line &Discounts")
            {
                ApplicationArea = all;
                Caption = 'Remises ligne achat';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowLineDisc;
                    CurrPage.Update;
                end;
            }
            action("Purcha&se Prices")
            {
                ApplicationArea = all;
                Caption = 'Prix achat';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowPrices;
                    CurrPage.Update;
                end;
            }
            action("Availa&bility")
            {
                ApplicationArea = all;
                Caption = 'Disponibilité';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Cduitemava: Codeunit "Item Availability Forms Mgt";
                begin
                    Cduitemava.ShowItemAvailFromPurchLine(REC, 0);
                    //  ItemAvailability(0);
                    CurrPage.Update(true);
                end;
            }
            action("Ite&m Card")
            {
                ApplicationArea = all;
                Caption = 'Fiche article';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LookupItem(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
        //+OFF+OFFRE
        wInitialPurchLine.Init;
        if wIsRelatedOffer then
            if not wInitialPurchLine.Get(rec."Attached to Doc. Type", rec."Attached to Doc. No.", rec."Line No.") then
                wInitialPurchLine.Init;
        //+OFF+OFFRE//
        QuantityOnFormat;
        DirectUnitCostOnFormat;
        UnitCostLCYOnFormat;
        LineAmountOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (rec.Quantity <> 0) and REC.ItemExists(rec."No.") then begin
            Commit;
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //MULTIPLE
        if wMult then begin
            wMult := false;
            exit(false);
        end;
        //MULTIPLE//
    end;

    trigger OnModifyRecord(): Boolean
    var
        lPurchLine: Record "Purchase Line";
    begin
        //+OFF+OFFRE
        if rec."Attached to Doc. No." <> '' then begin
            lPurchLine.SetRange("Document Type", lPurchLine."document type"::Order);
            lPurchLine.SetRange("Line No.", rec."Line No.");
            lPurchLine.SetRange("Price Offer No.", rec."Attached to Doc. No.");
            if lPurchLine.Find('-') then
                Error(Text8004091, lPurchLine."Document No.")
            else
                if lPurchLine.Get(rec."Attached to Doc. Type", rec."Attached to Doc. No.", rec."Line No.") then
                    if lPurchLine."Ordered Line" then
                        Error(Text8004092);
        end;
        //+OFF+OFFRE//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Init;
        //+OFF+OFFRE
        if wIsRelatedOffer then begin
            Message(Text8004090);
            exit;
        end;
        //+OFF+OFFRE//
        rec.Type := xRec.Type;
        Clear(ShortcutDimCode);
        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
    end;

    trigger OnOpenPage()
    begin
        //GL2024 OnActivateForm;
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: label 'Unable to execute this function while in view only mode.';
        PurchHeader: Record "Purchase Header";
        wIsRelatedOffer: Boolean;
        wInitialPurchLine: Record "Purchase Line";
        Text8004090: label 'You can''t insert line when inherited attachments exist.';
        Text8004091: label 'You cannot change this line because it is associated with purchase order no. %1.';
        Text8004092: label 'You cannot change this line because it has been invoiced.';
        wRecordref: RecordRef;
        wMult: Boolean;
        wInternalOrderExist: Boolean;
        wTransferOrderExist: Boolean;
        wItem, Item : Record Item;

        QuantityEmphasize: Boolean;

        "Direct Unit CostEmphasize": Boolean;

        "Unit Cost (LCY)Emphasize": Boolean;

        "Line AmountEmphasize": Boolean;


    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Purch.-Disc. (Yes/No)", Rec);
    end;


    procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Purch.-Calc.Discount", Rec);
    end;


    procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Purch.-Explode BOM", Rec);
    end;


    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;

    //DYS procedure modifier dans BC
    /*procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        REC.ItemAvailability(AvailabilityType);
    end;
*/

    procedure ShowDimensions1()
    begin
        Rec.ShowDimensions;
    end;


    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;


    procedure OpenItemTrackingLines1()
    begin
        Rec.OpenItemTrackingLines;
    end;


    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
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


    procedure ShowPrices()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        PurchHeader.Get(rec."Document Type", rec."Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;


    procedure ShowLineDisc()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        lItem: Record Item;
    begin
        PurchHeader.Get(rec."Document Type", rec."Document No.");
        Clear(PurchPriceCalcMgt);
        //+OFF+REMISE
        //PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader,Rec);
        if rec.Type = rec.Type::Item then
            lItem.Get(rec."No.");
        //DYS
        // PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec, lItem."Item Disc. Group");
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
        //+OFF+REMISE//
    end;


    procedure ShowLineComments1()
    begin
        Rec.ShowLineComments;
    end;


    procedure wEditMemoPad(): Boolean
    var
        lCaption: Text[250];
        lMemoPad: Codeunit "MemoPad Management";
        lNewText: Boolean;
        lRec: Record "Purchase Line";
        lRec2: Record "Purchase Line";
        lRecordRef: RecordRef;
    begin
        //ACHATS
        lNewText := (rec."Line No." = 0);
        if rec."Attached to Line No." = 0 then begin
            rec.TestField("No.");
            lRec := Rec;
        end else
            lRec.Get(rec."Document Type", rec."Document No.", rec."Attached to Line No.");
        lCaption := lRec.Description;

        if not lNewText then begin
            lRec.Init; //Keep Primary key
            lRec.SetRange("Document Type", rec."Document Type");
            lRec.SetRange("Document No.", rec."Document No.");
            lRec.SetRange(Type, lRec.Type::" ");
            lRec.SetRange("No.", '');
            lRec.SetRange("Attached to Line No.", lRec."Line No.");
            lRec.Description := lCaption;
            lRec."Attached to Line No." := lRec."Line No.";
        end else begin
            rec.Validate(Description, ' ');
            CurrPage.Update(true);
            lRec.Init; //Keep Primary key
            lRec.SetRange("Document Type", rec."Document Type");
            lRec.SetRange("Document No.", rec."Document No.");
            lRec.SetRange("Line No.", rec."Line No.");
            lRec."Line No." := rec."Line No.";
        end;

        lRecordRef.GetTable(lRec);
        //#5464
        //EXIT(lMemoPad.Edit2(lRecordRef,lCaption,FALSE,FIELDNO(Description),FIELDNO("Description 2"),FIELDNO(Separator)));
        exit(lMemoPad.Edit(lRecordRef, lCaption));
        //#5464//
    end;


    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        //OUVRAGE
        rec.TestField("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
        //OUVRAGE//
    end;


    procedure wShowRelatedOfferLines()
    var
        lPurchLine: Record "Purchase Line";
    //DYS page addon non migrer
    //lShowOfferLine: Page 8004093;
    begin
        //OFFRE_DE_PRIX
        lPurchLine.Reset;
        lPurchLine.SetCurrentkey("Attached to Doc. Type", "Attached to Doc. No.");
        lPurchLine.SetRange("Attached to Doc. Type", rec."Document Type");
        lPurchLine.SetRange("Attached to Doc. No.", rec."Document No.");
        lPurchLine.SetRange("No.", rec."No.");
        lPurchLine.SetRange("Line No.", rec."Line No.");
        if lPurchLine.Find('-') then begin
            //DYS
            // lShowOfferLine.SetTableview(lPurchLine);
            // lShowOfferLine.Run;
        end;
        //OFFRE_DE_PRIX//
    end;


    procedure wSetRelatedOffer(Status: Boolean)
    begin
        //+OFF+OFFRE
        wIsRelatedOffer := Status;
        //+OFF+OFFRE//
    end;


    procedure wShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        //+OFF+OFFRE
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RunModal;
        //+OFF+OFFRE//
    end;


    procedure wOpenSalesForm()
    var
        lSalesHeader: Record "Sales Header";
        lSalesNavibatQuote: Page "Sales Quote";
        lSalesNavibatOrder: Page "Sales Order";
    begin
        //SUBCONTRACTOR
        if rec."Sales Order Line No." <> 0 then
            lSalesHeader.SetRange("No.", rec."Sales Order No.")
        else
            if rec."Special Order Sales Line No." <> 0 then
                lSalesHeader.SetRange("No.", rec."Special Order Sales No.");
        case rec."Sales Document Type" of
            rec."sales document type"::Quote:
                begin
                    lSalesNavibatQuote.SetTableview(lSalesHeader);
                    lSalesNavibatQuote.Editable := false;
                    lSalesNavibatQuote.Run;
                end;
            rec."sales document type"::Order, rec."sales document type"::" ":
                begin
                    lSalesNavibatOrder.SetTableview(lSalesHeader);
                    lSalesNavibatOrder.Editable := false;
                    lSalesNavibatOrder.Run;
                end;
        end;
        //SUBCONTRACTOR//
    end;

    procedure LookupItem(PurchLine: Record "Purchase Line")
    begin

        PurchLine.TESTFIELD(Type, PurchLine.Type::Item);
        PurchLine.TESTFIELD("No.");
        GetItem(PurchLine);
        PAGE.RUNMODAL(PAGE::"Item Card", Item);
    end;

    procedure GetItem(var PurchLine: Record "Purchase Line"): Boolean
    begin

        WITH Item DO BEGIN
            IF (PurchLine.Type <> PurchLine.Type::Item) OR (PurchLine."No." = '') THEN
                EXIT(FALSE);

            IF PurchLine."No." <> "No." THEN
                GET(PurchLine."No.");
            EXIT(TRUE);
        END;
    end;

















    local procedure TypeOnAfterValidate()
    begin
        //MULTIPLE
        CurrPage.SaveRecord;
        //MULTIPLE//
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (rec.Type = rec.Type::"Charge (Item)") and (rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    /* local procedure OnActivateForm()
     begin
         //MULTIPLE
         CurrPage.Update;
         if wMult then
             if rec.Find('-') then;
         //MULTIPLE//
     end;*/

    local procedure QuantityOnFormat()
    var
        lFontBold: Boolean;
    begin
        //OFFRE_DE_PRIX
        //TRS-2009
        lFontBold := (wInitialPurchLine."Selected Doc. No." = rec."Document No.") and
                     (wInitialPurchLine."Selected Doc. Line No." = rec."Line No.");
        QuantityEmphasize := lFontBold;
        //TRS-2009//
        //OFFRE_DE_PRIX//
    end;

    local procedure DirectUnitCostOnFormat()
    var
        lFontBold: Boolean;
    begin
        //OFFRE_DE_PRIX
        //TRS-2009

        lFontBold := (wInitialPurchLine."Selected Doc. No." = rec."Document No.") and
                     (wInitialPurchLine."Selected Doc. Line No." = rec."Line No.");

        "Direct Unit CostEmphasize" := lFontBold;
        //TRS-2009/
        //OFFRE_DE_PRIX//
    end;

    local procedure UnitCostLCYOnFormat()
    var
        lFontBold: Boolean;
    begin
        //OFFRE_DE_PRIX
        //TRS-2009

        lFontBold := (wInitialPurchLine."Selected Doc. No." = rec."Document No.") and
                     (wInitialPurchLine."Selected Doc. Line No." = rec."Line No.");
        "Unit Cost (LCY)Emphasize" := lFontBold;
        //TRS-2009//
        //OFFRE_DE_PRIX//
    end;

    local procedure LineAmountOnFormat()
    var
        lFontBold: Boolean;
    begin
        //OFFRE_DE_PRIX
        //TRS-2009
        lFontBold := (wInitialPurchLine."Selected Doc. No." = rec."Document No.") and
                     (wInitialPurchLine."Selected Doc. Line No." = rec."Line No.");
        "Line AmountEmphasize" := lFontBold;
        //TRS-2009//
        //OFFRE_DE_PRIX//
    end;
}

