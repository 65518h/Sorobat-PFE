Table 8001502 "Sales Line Discount Entry"
{
    // //+RFA+ GESWAY 11/07/02 Nouvelle table de stockage des remises des lignes vente.

    Caption = 'Sale Line Discount Entry';
    // DrillDownPageID = 8001502;
    //LookupPageID = 8001502;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,,Posted Invoice,Posted Credit Memo,Posted Return Receipt';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",,"Posted Invoice","Posted Credit Memo","Posted Return Receipt";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[50])
        {
            CalcFormula = lookup("Sales Line".Description where("Document Type" = field("Document Type"),
                                                                 "Document No." = field("Document No."),
                                                                 "Line No." = field("Line No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Disc. Commission Type"; Option)
        {
            Caption = 'Discount And Comm. Type';
            OptionCaption = 'Line Discount,Footer Discount,Back Discount,Commission';
            OptionMembers = "Line Discount","Footer Discount","Back Discount",Commission;
        }
        field(6; "Rule No."; Code[20])
        {
            Caption = 'Rule No.';
            TableRelation = "Discount Rule"."No." where("Discount and comm. type" = field("Disc. Commission Type"),
                                                         "No." = field("Rule No."));
        }
        field(10; "Continue Calculation"; Option)
        {
            Caption = 'Continue Calculation';
            OptionCaption = 'Yes,Line Discount,Footer Discount,End of Period Discount,No';
            OptionMembers = Yes,"Line Discount","Footer Discount","End of Period Discount",No;
        }
        field(11; Basis; Option)
        {
            Caption = 'Basis';
            OptionCaption = 'Gross,Net Line,Net Footer,Net End of Period Discount';
            OptionMembers = Gross,"Net Line","Net Footer","Net End of Period Discount";
        }
        field(12; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Sale,Order';
            OptionMembers = Sale,"Order";
        }
        field(13; "Base (LCY)"; Decimal)
        {
            Caption = 'Base (LCY)';
        }
        field(14; "Discount Amount (LCY)"; Decimal)
        {
            Caption = 'Discount Amount (LCY)';
        }
        field(15; "Coefficient (LCY)"; Decimal)
        {
            Caption = 'Coefficient (LCY)';
            DecimalPlaces = 0 : 5;
        }
        field(20; Base; Decimal)
        {
            Caption = 'Base';
        }
        field(21; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';
        }
        field(22; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Line No.", "Disc. Commission Type", "Rule No.")
        {
            Clustered = true;
            SumIndexFields = "Discount Amount", "Discount Amount (LCY)";
        }
        key(STG_Key2; "Document Type", "Document No.", "Disc. Commission Type", "Rule No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

