PageExtension 50047 "Sales Cr. Memo Subform_PagEXT" extends "Sales Cr. Memo Subform"
{
    layout
    {
        //  modify("No.")
        // {
        /*GL2024   trigger OnLookup(var Text: Text): Boolean
           VAR
               lMultiple: Boolean;
           begin

               //MULTIPLE
               wRecordRef.Close();
               CASE rec.Type OF
                   rec.Type::Item:
                       wRecordRef.OPEN(27);
                   rec.Type::Resource:
                       wRecordRef.OPEN(156);
                   ELSE
                       wRecordRef.OPEN(36);
               END;
               IF rec.wLookUpNo(Rec, xRec, wRecordRef, lMultiple, FALSE) THEN
                   IF (rec."No." <> '') OR lMultiple THEN BEGIN
                       IF NOT lMultiple THEN
                           Currpage.SAVERECORD;
                       InsertExtendedText(FALSE);
                       Currpage.UPDATE;
                   END;
               //MULTIPLE//*/







        //  GL2026   trigger OnLookup(var Text: Text): Boolean
        //     var

        //         lMultiple: Boolean;



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
        modify(Description)
        {

            trigger OnAfterValidate()
            begin
                //  IF rec.Type = rec.Type::Item THEN ERROR(Text001);

                IF RecUserSetup.GET(UPPERCASE(USERID)) THEN;
                //    IF RecUserSetup."Chang Descrip Interdit" THEN ERROR(Text005);

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
            field("Type article"; Rec."Type article") { ApplicationArea = all; Visible = false; }

        }
    }



    procedure wShowDescription()
    var
        lDescription: Record "Description Line";
    begin
        rec.TestField("Line No.");
        lDescription.ShowDescription(37, rec."Document Type", rec."Document No.", rec."Line No.");
    end;


    var
        wRecordRef: RecordRef;
        Text005: Label 'Impossible de modifier la description.';
        RecUserSetup: Record "User Setup";
}

