PageExtension 50049 "Purch. Cr. Memo Subform_PagEXT" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Job No.2"; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Job Task No.2"; Rec."Job Task No.")
            {
                ApplicationArea = all;
            }

            field("VAT Bus. Posting Group1"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Gen. Bus. Posting Group1"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
        addbefore("Unit of Measure Code")
        {
            field("VAT Prod. Posting Group1"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group1"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
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

        //GL2026 modify("No.")
        // {
        //GL2026 trigger OnLookup(var Text: Text): Boolean
        // var
        //     PageItelLookup: Page "Item Lookup";
        //     RecStandardText: Record "Standard Text";
        //     RecGLAccount: Record "G/L Account";
        //     RecResource: Record Resource;
        //     RecFixedAsset: Record "Fixed Asset";
        //     RecItemCharge: Record "Item Charge";
        //     RecAllocationAccount: Record "Allocation Account";
        //     RecItem: Record Item;
        //     lMultiple: Boolean;
        //     wRecordref: RecordRef;
        //     lLookup: Codeunit Lookup;
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







        //MULTIPLE
        //#7750
        /*GL    CASE (rec.Type) OF
                rec.Type::Item:
                    BEGIN
                        wRecordref.OPEN(DATABASE::Item);
                        IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
                            IF NOT lMultiple THEN
                                InsertExtendedText(FALSE)
                            ELSE
                                IF rec."Line No." = 0 THEN
                                    wMult := TRUE;
                        //#4842
                        wRecordref.CLOSE;
                        //#4842//
                    END;
                rec.Type::"G/L Account":
                    BEGIN
                        wRecordref.OPEN(DATABASE::"G/L Account");
                        IF rec.wLookUpNo(Rec, wRecordref, lMultiple, xRec) THEN
                            IF NOT lMultiple THEN
                                InsertExtendedText(FALSE)
                            ELSE
                                IF rec."Line No." = 0 THEN
                                    wMult := TRUE;
                        //#4842
                        wRecordref.CLOSE;
                        //#4842//
                    END;
                ELSE BEGIN
                    lLookup.PurchLineNo(Rec);
                    //#8504
                    InsertExtendedText(FALSE);
                    //#8504//
                END;
            END;
            //#7750//
            //MULTIPLE//
*/
        //  end;
        //  }

        modify(Description)
        {

            trigger OnAfterValidate()
            begin
                //  IF rec.Type = rec.Type::Item THEN ERROR(Text001);

                IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
                //  IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

                //IF (Type=Type::"Charge (Item)")  THEN
                //  BEGIN
                //    IF RecUserSetup.GET(UPPERCASE(USERID)) THEN
                //      IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);
                //  END;
                //GL2026 IF (rec.Type = rec.Type::Item) THEN BEGIN
                //     IF (rec."No." <> '3000010000001') AND (rec."No." <> 'IMM') AND (rec."Type article" <> rec."Type article"::Service) THEN
                //         ERROR(Text005);
                // END;
            end;
        }
        addbefore("No.")
        {
            field("Type article"; Rec."Type article")
            {
                ApplicationArea = all;
                Visible = false;

            }
        }
        addafter("No.")
        {

            field("Line No."; rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }


        addafter(Quantity)
        {
            field("Qty. to Invoice"; rec."Qty. to Invoice")
            {
                ApplicationArea = all;
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
            field("Qty. to Receive"; rec."Qty. to Receive")
            {
                ApplicationArea = all;
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
        addafter("Line Amount")
        {
            field("Discount 1 %"; rec."Discount 1 %")
            {
                ApplicationArea = all;
                Visible = false;
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
        addafter("Depr. Acquisition Cost")
        {
            field("Duplicate in Depreciation Book"; rec."Duplicate in Depreciation Book")
            {
                ApplicationArea = all;
                Visible = false;
            }
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



    procedure wShowDescription(lDescription: Record "Description Line")
    begin
        rec.TestField("Line No.");
        lDescription.ShowDescription(39, rec."Document Type", rec."Document No.", rec."Line No.");
    end;


    var
        wMult: Boolean;
        Text005: Label 'Impossible de modifier la description.';
        RecUserSetup: Record "User Setup";

}

