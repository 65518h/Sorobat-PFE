PageExtension 50246 "Purchase Return Ord Sub_PagEXT" extends "Purchase Return Order Subform"
{

    layout
    {
        addbefore("No.")
        {
            field("Type article"; Rec."Type article")
            {
                ApplicationArea = all;
                Visible = false;

            }

        }
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
        }
        //GL2026 modify("No.")
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
        //         lMultiple: Boolean;
        //         wRecordref: RecordRef;
        //         lLookup: Codeunit Lookup;
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
        /*GL2024  modify(Description)
          {
              trigger OnAfterValidate()
              begin
                  IF rec.Type = rec.Type::Item THEN ERROR(Text001);
              end;
          }*/
        addafter(ShortcutDimCode7)
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
        }
    }
    var
        Text001: label 'You cannot modify the designation';
        Text005: Label 'Impossible de modifier la description.';
        RecUserSetup: Record "User Setup";
}