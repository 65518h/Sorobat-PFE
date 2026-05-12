PageExtension 50038 "Purchase Order Subform_PagEXT" extends "Purchase Order Subform"
{
    layout
    {
        // modify(Control1)
        // {
        //   //  Editable = EditableStatus;
        // }


        addbefore("Location Code")
        {

            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = All;
                ShowMandatory = true;

            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                Editable = true;

            }
            field("DYSJob Planning Line No."; Rec."DYSJob Planning Line No.")
            {
                ApplicationArea = All;

            }

        }

        moveafter(Description; "VAT Prod. Posting Group")
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            Editable = true;
        }
        addafter(Description)
        {
            // field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            field("DYS Description"; Rec."DYS Description")
            {
                Visible = false;
                ApplicationArea = All;
                trigger OnAssistEdit()
                begin

                    // >> HJ SORO 06-01-2015
                    rec.ShowLineComments;
                    EXIT;
                    // >> HJ SORO 06-01-2015

                    //+REF+MEMOPAD
                    Currpage.SAVERECORD;
                    COMMIT;
                    IF rec.fMemoPad THEN
                        Currpage.UPDATE;
                    //+REF+MEMOPAD//
                end;

            }
        }
        modify(Type)
        {
            //    Visible = false;
            //ApplicationArea = All;
            trigger OnAfterValidate()
            begin
                //MULTIPLE
                CurrPage.SAVERECORD;
                //MULTIPLE//
            end;
        }


        addafter(Type)
        {
            field("Vendor Item No."; rec."Vendor Item No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Filtre Article"; rec."Filtre Article")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }


        addbefore("No.")
        {
            field("Type article"; Rec."Type article") { ApplicationArea = all; Visible = false; }
            /*  field("Apply Fodec"; rec."Apply Fodec")
              {
                  ApplicationArea = all;
              }*/
        }
        /*GL2026   modify("No.")
           {
               trigger OnLookup(var Text: Text): Boolean
               var
                   PageItelLookup: Page "Item Lookup";
                   RecStandardText: Record "Standard Text";
                   RecGLAccount: Record "G/L Account";
                   RecResource: Record Resource;
                   RecFixedAsset: Record "Fixed Asset";
                   RecItemCharge: Record "Item Charge";
                   RecAllocationAccount: Record "Allocation Account";
                   RecItem: Record Item;
               begin
                   if Rec.Type = Rec.Type::"Allocation Account" then begin
                       if RecAllocationAccount.FindSet() then begin
                           if PAGE.RunModal(PAGE::"Allocation Account List", RecAllocationAccount) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecAllocationAccount."No.");
                           end;
                       end;
                   end;
                   if Rec.Type = Rec.Type::"Charge (Item)" then begin
                       if RecItemCharge.FindSet() then begin
                           if PAGE.RunModal(PAGE::"Item Charges", RecItemCharge) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecItemCharge."No.");
                           end;
                       end;
                   end;
                   if Rec.Type = Rec.Type::"Fixed Asset" then begin
                       if RecFixedAsset.FindSet() then begin
                           if PAGE.RunModal(PAGE::"Fixed Asset List", RecFixedAsset) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecFixedAsset."No.");
                           end;
                       end;
                   end;
                   if Rec.Type = Rec.Type::Resource then begin
                       if RecResource.FindSet() then begin
                           if PAGE.RunModal(PAGE::"Resource List", RecResource) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecResource."No.");
                           end;
                       end;
                   end;
                   if Rec.Type = Rec.Type::Item then begin
                       RecItem.Reset();
                       RecItem.SetRange(Type, Rec."Type article");
                       if RecItem.FindSet() then begin
                           if PAGE.RunModal(PAGE::"Item Lookup", RecItem) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecItem."No.");
                           end;
                       end;
                   end;
                   if Rec.Type = Rec.Type::" " then begin
                       if PAGE.RunModal(PAGE::"Standard Text Codes", RecStandardText) = ACTION::LookupOK then begin
                           Rec.Validate("No.", RecStandardText."code");
                       end;
                   end;
                   if Rec.Type = Rec.Type::"G/L Account" then begin
                       RecGLAccount.Reset();
                       RecGLAccount.SetRange("Account Type", RecGLAccount."Account Type"::Posting);
                       RecGLAccount.SetRange(Blocked, false);
                       RecGLAccount.SetRange("Direct Posting", true);
                       if RecGLAccount.FindSet() then begin
                           if PAGE.RunModal(PAGE::"G/L Account List", RecGLAccount) = ACTION::LookupOK then begin
                               Rec.Validate("No.", RecGLAccount."No.");
                           end;
                       end;
                   end;
               end;
           }*/
        // modify("No.")
        // {
        //     trigger OnLookup(var Text: Text): Boolean

        //     VAR
        //         lMultiple: Boolean;
        //         lLookup: Codeunit Lookup;
        //     begin

        //         //MULTIPLE
        //         //#5084 CurrForm.SAVERECORD;
        //         //#5084 COMMIT;
        //         //#7750
        //         CASE (rec.Type) OF
        //             rec.Type::Item:
        //                 BEGIN
        //                     //#8237
        //                     wRecordref.CLOSE;
        //                     //#8237//
        //                     wRecordref.OPEN(DATABASE::Item);
        //                     IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
        //                         IF NOT lMultiple THEN
        //                             InsertExtendedText(FALSE)
        //                         ELSE
        //                             IF rec."Line No." = 0 THEN
        //                                 wMult := TRUE;
        //                     //#4842
        //                     wRecordref.CLOSE;
        //                     //#4842//
        //                 END;
        //             rec.Type::"G/L Account":
        //                 BEGIN
        //                     //#8237
        //                     wRecordref.CLOSE;
        //                     //#8237//
        //                     wRecordref.OPEN(DATABASE::"G/L Account");
        //                     IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
        //                         IF NOT lMultiple THEN
        //                             InsertExtendedText(FALSE)
        //                         ELSE
        //                             IF rec."Line No." = 0 THEN
        //                                 wMult := TRUE;
        //                     //#4842
        //                     wRecordref.CLOSE;
        //                     //#4842//
        //                 END;
        //             ELSE BEGIN
        //                 lLookup.PurchLineNo(Rec);
        //                 //#8504
        //                 InsertExtendedText(FALSE);
        //                 //#8504//
        //             END;
        //         END;
        //         //#7750//
        //         //MULTIPLE//
        //     end;
        // }



        addafter("No.")
        {
            /*   field(Emplacement; rec.Emplacement)
               {
                   ApplicationArea = all;
                   Editable = false;
               }*/
            field("Article Lié Au Frais Annexe"; rec."Article Lié Au Frais Annexe")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }



        addafter("IC Partner Ref. Type")
        {
            /* GL2024   field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }*/
            field("VAT %"; rec."VAT %")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }


        addafter(Nonstock)
        {
            field("N° Dossier"; rec."N° Dossier")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }


        modify(Description)
        {
            Visible = true;

            trigger OnAssistEdit()
            begin

                // >> HJ SORO 06-01-2015
                rec.ShowLineComments;
                EXIT;
                // >> HJ SORO 06-01-2015

                //+REF+MEMOPAD
                Currpage.SAVERECORD;
                COMMIT;
                IF rec.fMemoPad THEN
                    Currpage.UPDATE;
                //+REF+MEMOPAD//
            end;

            trigger OnAfterValidate()
            begin

                // IF RecUserSetup.GET(UPPERCASE(USERID)) THEN
                //   IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

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
        }
        modify("Description 2")


        {
            ApplicationArea = all;
            Visible = false;

            trigger OnAssistEdit()
            begin
                //+REF+MEMOPAD
                CurrPage.SaveRecord;

                IF rec.fMemoPad THEN
                    CurrPAGE.UPDATE;
                //+REF+MEMOPAD//

            end;
        }
        addafter("Description 2")
        {
            field("Disponibilité Article"; rec."Disponibilité Article")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Délai Livraison"; rec."Délai Livraison")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Completely Received"; rec."Completely Received")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /* GL2024 field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
             {
                 ApplicationArea = all;
                 Visible = false;
             }*/
        }


        modify("Location Code")
        {
            trigger OnAfterValidate()
            begin
                // RB SORO 21/04/2015
                IF rec."Special Order" THEN
                    MESSAGE(Text006, rec."Special Order Sales No.");
                // RB SORO 21/04/2015
            end;
        }


















        addafter("Location Code")
        {
            field("Starting Date"; rec."Starting Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Ending Date"; rec."Ending Date")
            {
                ApplicationArea = all;
                Visible = false;
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
        }

        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = true;

        }

        modify("Unit of Measure")
        {
            Editable = false;
            Visible = false;
        }



        addafter("Unit of Measure")
        {
            field("Qty. Per Invoicing Unit"; rec."Qty. Per Invoicing Unit")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin
                    //ACHATS
                    rec.Validate("Qty. Per Invoicing Unit");
                    wUpdateQtyPerInvoicing;
                    //ACHATS//
                end;
            }
            field("Invoicing Unit"; rec."Invoicing Unit")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin
                    //ACHATS
                    rec.Validate("Invoicing Unit");
                    wUpdateQtyPerInvoicing;
                    //ACHATS//
                end;
            }
            field("Lot No."; rec."Lot No.")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin
                    //+REF+LOT
                    rec.TestField("Quantity Received", 0);
                    CurrPage.SaveRecord;
                    Commit;
                    if rec."Lot No." = '' then begin
                        Clear(gReservePurchLine);
                        rec.TestField(Type, rec.Type::Item);
                        rec.TestField("No.");
                        rec.TestField("Quantity (Base)");

                        CduFunction.fCallItemTracking(Rec, 1, 1, rec."Expiration Date");
                    end
                    else begin
                        Clear(gReservePurchLine);
                        rec.TestField(Type, rec.Type::Item);
                        rec.TestField("No.");
                        rec.TestField("Quantity (Base)");

                        CduFunction.fCallItemTracking(Rec, 2, 1, rec."Expiration Date");
                    end;
                    rec.Find('=');
                    //+REF+LOT//
                    //+REF+LOT
                    CurrPage.Update(false);
                    //+REF+LOT//
                end;
            }
            field("Expiration Date"; rec."Expiration Date")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin
                    //+REF+LOT
                    rec.TestField("Quantity Received", 0);
                    rec.TestField("Lot No.");
                    Clear(gReservePurchLine);
                    rec.TestField(Type, rec.Type::Item);
                    rec.TestField("No.");
                    rec.TestField("Quantity (Base)");

                    CduFunction.fCallItemTracking(Rec, 3, 1, rec."Expiration Date");
                    rec.Find('=');
                    //+REF+LOT//
                end;
            }
            field("Serial No."; rec."Serial No.")
            {
                ApplicationArea = all;
                Visible = false;

                trigger OnValidate()
                begin
                    //+REF+LOT
                    rec.TestField("Quantity Received", 0);
                    if rec."Serial No." = '' then begin
                        Clear(gReservePurchLine);
                        rec.TestField(Type, rec.Type::Item);
                        rec.TestField("No.");
                        rec.TestField("Quantity (Base)");

                        CduFunction.fCallItemTracking(Rec, 1, 0, rec."Expiration Date");
                    end
                    else begin
                        Clear(gReservePurchLine);
                        rec.TestField(Type, rec.Type::Item);
                        rec.TestField("No.");
                        rec.TestField("Quantity (Base)");

                        CduFunction.fCallItemTracking(Rec, 2, 0, rec."Expiration Date");
                    end;
                    rec.Find('=');
                    //+REF+LOT//
                    //+REF+LOT                                                                  S
                    CurrPage.Update(false);
                    //+REF+LOT//
                end;
            }
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                IF rec."Qty. Per Invoicing Unit" = 0 THEN
                    wInvUnitCost := rec."Unit Cost (LCY)"
                ELSE
                    wInvUnitCost := rec."Unit Cost (LCY)" * rec.Quantity / rec."Qty. Per Invoicing Unit";
            end;
        }
        moveafter("Direct Unit Cost"; "Line Discount %")


        addafter("Direct Unit Cost")
        {
            //  field("Line Discount %"; Rec."Line Discount %") { ApplicationArea = all; }
            field("Discount 1 %"; rec."Discount 1 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(wInvUnitCost; wInvUnitCost)
            {
                ApplicationArea = all;
                Caption = 'Invoicing Unit Cost';
                Visible = false;

                trigger OnValidate()
                begin
                    if rec.Quantity <> 0 then
                        rec.Validate("Direct Unit Cost", wInvUnitCost * rec."Qty. Per Invoicing Unit" / rec.Quantity);
                end;
            }
        }









        addafter("Line Amount")
        {

            field("Discount 2 %"; rec."Discount 2 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Discount 3 %"; rec."Discount 3 %")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }

        modify("Line Discount %")
        {
            Visible = true;
        }

        modify("Qty. to Receive")
        {
            trigger OnAfterValidate()
            var


                lItem: Record Item;
            begin

                //+REF+LOT
                IF (rec.Type = rec.Type::Item) AND (rec."Qty. to Receive" <> 0) AND (rec."No." <> '') AND (rec."Prod. Order No." = '') THEN BEGIN
                    Currpage.SAVERECORD;
                    lItem.GET(rec."No.");
                    IF lItem."Lot Nos." <> '' THEN BEGIN
                        rec."Lot No." := NoSeriesMgt.GetNextNo(lItem."Lot Nos.", WORKDATE, TRUE);
                        CduFunction.fCallItemTracking(Rec, 2, 1, rec."Expiration Date");
                        Currpage.UPDATE(FALSE);
                    END;
                END;
                //+REF+LOT//
                //SUBCONTRACTOR
                wCalcCompletion;
                //SUBCONTRACTOR//
            end;
        }

        addafter("Qty. to Receive")
        {
            field("Nouvel avancement (%)"; wNewCompletion)
            {
                ApplicationArea = all;
                Caption = 'New Completion (%)';
                Visible = false;

                trigger OnValidate()
                var
                    lTextCompletion: label 'ENU=New completion (%) must be superior to previous completion (%).';
                begin
                    //SUBCONTRACTOR
                    if wNewCompletion > wPreviousCompletion then
                        rec.Validate("Qty. to Receive", (rec.Quantity * wNewCompletion / 100) - rec."Quantity Received")
                    else
                        if wNewCompletion = 0 then
                            rec.Validate("Qty. to Receive", 0)
                        else
                            Error(lTextCompletion);
                    //SUBCONTRACTOR//
                end;
            }
            field("Not In Conformity Code"; rec."Not In Conformity Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Outstanding Quantity"; rec."Outstanding Quantity")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Qty. Not In Conformity"; rec."Qty. Not In Conformity")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }







        addafter("Quantity Received")
        {
            field(wPreviousCompletion; wPreviousCompletion)
            {
                ApplicationArea = all;
                Caption = 'Previous Completion (%)';
                Editable = false;
                Visible = false;
            }
        }


        addafter("Qty. to Assign")
        {
            field(Materiel; rec.Materiel)
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group1"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                Caption = 'Code nature';
            }
        }



        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }

        addafter("Blanket Order Line No.")
        {
            /* GL2024 field("FA Posting Date"; rec."FA Posting Date")
              {
                  ApplicationArea = all;
                  Visible = false;
              }*/
            field("FA Posting Type"; rec."FA Posting Type")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Depreciation Book Code"; rec."Depreciation Book Code")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }



        modify("Line No.")
        {
            visible = false;
            Editable = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("FA Posting Date")
        {
            Visible = false;

        }
        modify("Item Charge Qty. to Handle")
        {
            Visible = false;
        }
        addafter("FA Posting Date")
        {
            field("Order Date1"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line No.")
        {

            field("Quantités Initaile"; rec."Quantités Initaile")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }







    }



    trigger OnOpenPage()
    VAR

    BEGIN
        //  EDITABLEStatus2();
    END;

    trigger OnAfterGetRecord()
    begin

        //SUBCONTRACTOR
        wCalcCompletion;
        //SUBCONTRACTOR//
        //ACHATS
        wUpdateQtyPerInvoicing;
        //ACHATS//
        //IF PurchHeader.GET("Document Type"::Order,"Document No.") THEN
        //  IF PurchHeader.Status<>PurchHeader.Status::Open THEN CurrForm.EDITABLE:=FALSE ELSE CurrForm.EDITABLE:=TRUE;
        // RB SORO 20/04/2015
        // RB SORO 20/04/2015
        EDITABLEStatus2();
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        RecPurchaseheader: Record "Purchase Header";
    begin



        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
        //ACHATS
        wUpdateQtyPerInvoicing;
        //ACHATS//
        // Currpage.EDITABLE := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //MULTIPLE
        IF wMult THEN BEGIN
            wMult := FALSE;
            EXIT(FALSE);
        END;
        //MULTIPLE//
        //ACHATS
        wUpdateQtyPerInvoicing;
        //ACHATS//
        IF PurchHeader.GET(rec."Document Type"::Order, rec."Document No.") THEN
            IF PurchHeader.Status <> PurchHeader.Status::Open THEN ERROR(Text004);
    end;

    trigger OnModifyRecord(): Boolean
    begin

        IF PurchHeader.GET(rec."Document Type"::Order, rec."Document No.") THEN
            IF PurchHeader.Status <> PurchHeader.Status::Open THEN ERROR(Text004);
    end;


    trigger OnAfterGetCurrRecord()
    begin
        //  EDITABLEStatus2();

    end;

    local PROCEDURE EDITABLEStatus2();
    begin
        // if rec.Status = rec.Status::Released then
        //     EditableStatus := false
        // else
        //     EditableStatus := true;
    end;

    procedure fCompletelyReceived()
    var
        lPurchLine: Record "Purchase Line";
        lPurchHeader: Record "Purchase Header";
    begin
        //+REF+SOLDE_CDE
        CurrPage.SaveRecord;
        lPurchHeader.Get(rec."Document Type", rec."Document No.");
        CODEUNIT.RUN(CODEUNIT::"Complete Purch. Order", lPurchHeader);
        UpdateForm(true);
        //+REF+SOLDE_CDE//
    end;

    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        rec.TestField("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
    end;

    procedure wCalcCompletion()
    begin
        //SUBCONTRACTOR
        if rec.Quantity <> 0 then begin
            if rec."Quantity Received" <> 0 then
                wPreviousCompletion := rec."Quantity Received" / rec.Quantity * 100
            else
                wPreviousCompletion := 0;
            if rec."Qty. to Receive" <> 0 then
                wNewCompletion := (rec."Quantity Received" + rec."Qty. to Receive") / rec.Quantity * 100
            else
                wNewCompletion := 0;
        end else begin
            wNewCompletion := 0;
            wPreviousCompletion := 0;
        end;
    end;

    procedure wUpdateQtyPerInvoicing()
    begin
        if rec."Qty. Per Invoicing Unit" <> 0 then begin
            wInvUnitCost := rec."Unit Cost (LCY)" * rec.Quantity / rec."Qty. Per Invoicing Unit";
        end else begin
            wInvUnitCost := rec."Unit Cost (LCY)";
        end;
    end;


    procedure PurchasePrice(ParaNumDoc: Code[20])
    var
        RecLPurchasePrice: Record "Purchase Price";
        RecLPurchaseLine: Record "Purchase Line";
        BlnOk: Boolean;
    begin
        // >> HJ DSFT 12-10-2012
        RecLPurchaseLine.SetRange("Document Type", RecLPurchaseLine."document type"::Order);
        RecLPurchaseLine.SetRange("Document No.", ParaNumDoc);
        RecLPurchaseLine.SetRange(Type, RecLPurchaseLine.Type::Item);
        if RecLPurchaseLine.FindFirst then
            repeat
                RecLPurchasePrice."Item No." := RecLPurchaseLine."No.";
                RecLPurchasePrice."Vendor No." := RecLPurchaseLine."Buy-from Vendor No.";
                RecLPurchasePrice."Starting Date" := RecLPurchaseLine."Order Date";
                RecLPurchasePrice."Direct Unit Cost" := RecLPurchaseLine."Direct Unit Cost";
                if RecLPurchasePrice.Insert then BlnOk := true else RecLPurchasePrice.Modify;
            until RecLPurchaseLine.Next = 0;
        // >> HJ DSFT 12-10-2012
    end;


    var
        gReservePurchLine: Codeunit "Purch. Line-Reserve";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        wNewCompletion: Decimal;
        wPreviousCompletion: Decimal;
        wRecordref: RecordRef;
        wMult: Boolean;
        wInvUnitCost: Decimal;
        wItem: Record Item;
        RecUserSetup: Record "User Setup";
        Text003: Label 'Suppression impossible, statut non ouvert.';
        Text004: Label 'Modification impossible, status not open';
        Text005: Label 'Impossible de modifier la description.';
        Text006: Label 'You cannot modify the store code; linked order ... to quote no. %1';
        PurchHeader: Record "Purchase Header";
        CduFunction: Codeunit SoroubatFucntion;
        [InDataSet]
        EditableStatus: Boolean;

}

