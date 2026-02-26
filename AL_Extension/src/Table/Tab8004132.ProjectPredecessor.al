Table 8004132 "Project Predecessor"
{
    // //PLANNING GESWAY 30/03/05 Mémorisation des prédécesseurs de project

    Caption = 'Project Predecessor';

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
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Predecessor Document Type"; Option)
        {
            Caption = 'Predecessor Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(5; "Predecessor Document No."; Code[20])
        {
            Caption = 'Predecessor Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(6; "Predecessor Line No."; Integer)
        {
            Caption = 'Predecessor Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", "Predecessor Document Type", "Predecessor Document No.", "Predecessor Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

