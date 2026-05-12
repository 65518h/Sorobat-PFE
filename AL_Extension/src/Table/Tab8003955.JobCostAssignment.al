Table 8003955 "Job Cost Assignment"
{
    // //FRAIS CLA 15/02/05 Table d'affectation des frais

    Caption = 'Job Cost Assignment';
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(3; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"),
                                                           "Document No." = field("Document No."));
        }
        field(5; "Job Cost No."; Code[20])
        {
            Caption = 'Job Cost No.';
            NotBlank = true;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; Assigned; Boolean)
        {
            Caption = 'Assigned';
        }
        field(14; "Applies-to Doc. Line No."; Integer)
        {
            Caption = 'Applies-to Doc. Line No.';
        }
        field(20; "To New doc. line No."; Integer)
        {
            Caption = 'To New doc. line No.';
        }
        field(21; "To New Applies-to Line No."; Integer)
        {
            Caption = 'To New Applies-to Line No.';
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Document Line No.", "Applies-to Doc. Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(STG_Key2; "Document Type", "Document No.", "Applies-to Doc. Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: label 'You cannot assign item charges to the %1 because it has been invoiced. Instead you can get the posted document line and then assign the item charge to that line.';
        SalesLine: Record "Sales Line";
        Currency: Record Currency;
}

