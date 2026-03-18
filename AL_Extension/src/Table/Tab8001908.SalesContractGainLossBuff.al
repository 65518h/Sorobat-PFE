Table 8001908 "Sales Contract Gain/Loss Buff."
{
    // //+ABO+VALUE CW 02/06/11 Copy from SalesLine (without any code), keep field IDs for TransferFields

    Caption = 'Sales Contract Gain/Loss Buff.';

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(4; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            TableRelation = Job;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(8001911; "Change Date"; Date)
        {
            Caption = 'Change Date';
        }
        field(8001943; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.", Type, "Change Date", "Sell-to Customer No.", "Salesperson Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Job No.", "Gen. Prod. Posting Group", "Currency Code", "Job Task No.", "Responsibility Center")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

