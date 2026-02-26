Table 8003972 "Transfer Order Link"
{
    // //CDE_CESSION MB 16/11/06 Lien cde cession

    Caption = 'Transfer Order Link';

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
        field(3; "Structure Line No."; Integer)
        {
            Caption = 'Structure Line No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Transfer Document Type"; Option)
        {
            Caption = 'Transfer Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(6; "Transfer Document No."; Code[20])
        {
            Caption = 'Transfer Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Transfer Document Type"));
        }
        field(7; "Transfer Structure Line No."; Integer)
        {
            Caption = 'Transfer Structure Line No.';
        }
        field(8; "Transfer Line No."; Integer)
        {
            Caption = 'Transfer Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Structure Line No.", "Line No.", "Transfer Document Type", "Transfer Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Transfer Document Type", "Transfer Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

