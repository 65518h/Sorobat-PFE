PageExtension 50039 "Purch. Invoice Subform_PagEXT" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
            Editable = true;
        }
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                //MULTIPLE
                CurrPage.SAVERECORD;
                //MULTIPLE//
            end;
        }

        addbefore("No.")
        {
            field("Type article"; Rec."Type article") { ApplicationArea = all; Visible = false; }
            /*  field("Apply Fodec"; Rec."Apply Fodec")
              {
                  ApplicationArea = All;
              }*/
        }
        // modify("No.")
        // {
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         PageItelLookup: Page "Item Lookup";
        //         RecStandardText: Record "Standard Text";
        //         RecGLAccount: Record "G/L Account";
        //         RecResource: Record Resource;
        //         RecFixedAsset: Record "Fixed Asset";
        //         RecItemCharge: Record "Item Charge";
        //         RecAllocationAccount: Record "Allocation Account";
        //         RecItem: Record Item;
        //     begin
        //         if Rec.Type = Rec.Type::"Allocation Account" then begin
        //             if RecAllocationAccount.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Allocation Account List", RecAllocationAccount) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecAllocationAccount."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::"Charge (Item)" then begin
        //             /*  if RecItemCharge.FindSet() then begin
        //                   if PAGE.RunModal(PAGE::"Item Charges", RecItemCharge) = ACTION::LookupOK then begin
        //                       Rec.Validate("No.", RecItemCharge."No.");
        //                   end;
        //               end;*/
        //             Message('La liste des frais annexes est vide');
        //         end;
        //         if Rec.Type = Rec.Type::"Fixed Asset" then begin
        //             if RecFixedAsset.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Fixed Asset List", RecFixedAsset) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecFixedAsset."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::Resource then begin
        //             if RecResource.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Resource List", RecResource) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecResource."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::Item then begin
        //             RecItem.Reset();
        //             RecItem.SetRange(Type, Rec."Type article");
        //             if RecItem.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"Item Lookup", RecItem) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecItem."No.");
        //                 end;
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::" " then begin
        //             if PAGE.RunModal(PAGE::"Standard Text Codes", RecStandardText) = ACTION::LookupOK then begin
        //                 Rec.Validate("No.", RecStandardText."code");
        //             end;
        //         end;
        //         if Rec.Type = Rec.Type::"G/L Account" then begin
        //             RecGLAccount.Reset();
        //             RecGLAccount.SetRange("Account Type", RecGLAccount."Account Type"::Posting);
        //             RecGLAccount.SetRange(Blocked, false);
        //             RecGLAccount.SetRange("Direct Posting", true);
        //             if RecGLAccount.FindSet() then begin
        //                 if PAGE.RunModal(PAGE::"G/L Account List", RecGLAccount) = ACTION::LookupOK then begin
        //                     Rec.Validate("No.", RecGLAccount."No.");
        //                 end;
        //             end;
        //         end;
        //     end;
        // }


        // modify("No.")
        // {
        //     trigger OnLookup(var Text: Text): Boolean
        //     VAR
        //         lLookup: Codeunit Lookup;
        //         lRecordRef: RecordRef;
        //         lMultiple: Boolean;
        //     begin

        //         //MULTIPLE
        //         //#5084 CurrForm.SAVERECORD;
        //         //#5084 COMMIT;
        //         //#7750
        //         CASE (rec.Type) OF
        //             rec.Type::Item:
        //                 BEGIN
        //                     lRecordRef.OPEN(DATABASE::Item);
        //                     IF rec.wLookUpNo(Rec, lRecordRef, lMultiple, xRec) THEN
        //                         IF NOT lMultiple THEN
        //                             InsertExtendedText(FALSE)
        //                         ELSE
        //                             IF rec."Line No." = 0 THEN
        //                                 wMult := TRUE;
        //                     //#4842
        //                     lRecordRef.CLOSE;
        //                     //#4842//
        //                 END;
        //             rec.Type::"G/L Account":
        //                 BEGIN
        //                     lRecordRef.OPEN(DATABASE::"G/L Account");
        //                     IF rec.wLookUpNo(Rec, lRecordRef, lMultiple, xRec) THEN
        //                         IF NOT lMultiple THEN
        //                             InsertExtendedText(FALSE)
        //                         ELSE
        //                             IF rec."Line No." = 0 THEN
        //                                 wMult := TRUE;
        //                     //#4842
        //                     lRecordRef.CLOSE;
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


        addafter(Type)
        {
            field("Filtre Article"; rec."Filtre Article")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("No.")
        {
            field("Line No.2"; rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }

        addafter("IC Partner Reference")
        {
            field("Posting Group"; rec."Posting Group")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("N° Dossier"; rec."N° Dossier")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("VAT %"; rec."VAT %")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        moveafter("VAT %"; "Gen. Prod. Posting Group")
        addafter("Variant Code")
        {
            field("Gen. Prod. Posting Group2"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                Visible = false;
            }
            /*   field("Compte achat"; Rec."Compte achat")
               {
                   ApplicationArea = all;
                   Editable = false;
               }*/
        }



        modify(Description)
        {

            trigger OnAfterValidate()
            begin
                //  IF rec.Type = rec.Type::Item THEN ERROR(Text001);

                IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
                // IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

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

        addafter("Bin Code")
        {
            field(gInvoicingQty; gInvoicingQty)
            {
                ApplicationArea = all;
                Caption = 'Invoicing Quantity';
                Visible = false;

                trigger OnValidate()
                begin
                    if rec."Qty. Per Invoicing Unit" <> 0 then
                        rec.Validate(Quantity, gInvoicingQty / rec."Qty. Per Invoicing Unit")
                    else
                        rec.Validate(Quantity, gInvoicingQty);
                end;
            }
            field("Invoicing Unit"; rec."Invoicing Unit")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify("Job No.")
        {
            Visible = false;
            Editable = true;
        }
        modify("Job Task No.")
        {
            Visible = false;
            Editable = True;
        }
        addafter(Quantity)
        {
            field("Qty. to Receive"; rec."Qty. to Receive")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("dysJob No."; rec."dysJob No.")
            {
                ApplicationArea = all;
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job Task No. field.', Comment = '%';
            }
            //

            // field("DYSJob Task No."; Rec."DYSJob Task No.")
            // {
            //     ApplicationArea = all;
            // }

            //
            field("Affectation Marche"; rec."Affectation Marche")
            {
                ApplicationArea = all;
                visible = false;
            }
            field("Sous Affectation Marche"; rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
                visible = false;
            }
            field("Gen. Prod. Posting Group1"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                Caption = 'Code nature';
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
        addafter("Indirect Cost %")
        {
            field("N° BL Fournisseur"; rec."N° BL Fournisseur")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Date Reception"; rec."Date Reception")
            {
                ApplicationArea = all;
                Visible = false;
                Editable = false;
            }
        }
        addafter("Line Amount")
        {
            field("Discount 1 %"; rec."Discount 1 %")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(Vehicule; rec.Vehicule)
            {
                ApplicationArea = all;
            }
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
        addafter("Job Line Disc. Amount (LCY)")
        {
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("Subscription Starting Date"; rec."Subscription Starting Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Subscription End Date"; rec."Subscription End Date")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }

        modify("FA Posting Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //ACHATS
        rec.wInitLocationCode;
        //ACHATS//
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //MULTIPLE
        IF wMult THEN BEGIN
            wMult := FALSE;
            EXIT(FALSE);
        END;
        //MULTIPLE//

    end;

    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        rec.TestField("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
    end;

    procedure wUpdateQtyPerInvoicing()
    begin
        if rec."Qty. Per Invoicing Unit" <> 0 then
            gInvoicingQty := rec."Qty. to Invoice" * rec."Qty. Per Invoicing Unit"
        else
            gInvoicingQty := rec."Qty. to Invoice";
    end;

    trigger OnAfterGetRecord()
    var
        RecPurchaseheader: Record "Purchase Header";
    begin
        if rec.Type <> rec.type::" " then begin
            if Rec."DYSJob No." = '' then begin
                if RecPurchaseheader.Get(Rec."Document Type", Rec."Document No.") then begin
                    //      Rec."Job No." := RecPurchaseheader."Job No.";
                    Rec."DysJob No." := RecPurchaseheader."Job No.";
                    if Rec.Modify() then;
                end;
            end;
        end;
    end;

    var
        gInvoicingQty: Decimal;
        wMult: Boolean;
        Text001: label 'You cannot modify the designation';
        Text005: Label 'Impossible de modifier la description.';
        RecUserSetup: Record "User Setup";


}

