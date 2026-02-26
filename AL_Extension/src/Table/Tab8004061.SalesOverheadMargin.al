Table 8004061 "Sales Overhead-Margin"
{
    // //PROJET_FG GESWAY 25/04/03 Nouvelle table des Frais généraux et marge d'un document
    // //PERF AC 03/04/06

    Caption = 'Sales Overhead-Margin';

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
        }
        field(3; "Gen. Prod. Post. Code"; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(4; Overhead; Decimal)
        {
            Caption = 'Value';
        }
        field(5; Margin; Decimal)
        {
            Caption = 'Profit';
        }
        field(6; "Calculation Method Overhead"; Option)
        {
            Caption = 'Overhead Calculation Méthod';
            OptionCaption = 'Amount %,Quantity';
            OptionMembers = "Amount %",Quantity;
        }
        field(7; "Rule Overhead"; Decimal)
        {
        }
        field(8; "Rule Margin"; Decimal)
        {
        }
        field(9; "Calculation Method Margin"; Option)
        {
            Caption = 'Margin Calculation Méthod';
            OptionCaption = 'Amount %,Quantity';
            OptionMembers = "Amount %",Quantity;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Gen. Prod. Post. Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

