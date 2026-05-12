Table 8003984 Free8003984
{
    // //PRICE_REVIEW OF 01/06/08

    Caption = 'Review Formula';
    // LookupPageID = 8003956;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; "Ratio Rounding Precision"; Decimal)
        {
            Caption = 'Amount Rounding Precision';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(4; "Apply-To Date"; Option)
        {
            Caption = 'Apply-To Date';
            OptionCaption = 'Order,Invoice';
            OptionMembers = "Order",Invoice;
        }
        field(11; "Index 1 Code"; Code[10])
        {
            Caption = 'Index 1 Code';
            TableRelation = Free8003983;
        }
        field(12; "Index 2 Code"; Code[10])
        {
            Caption = 'Index 2 Code';
            TableRelation = Free8003983;
        }
        field(13; "Index 3 Code"; Code[10])
        {
            Caption = 'Index 3 Code';
            TableRelation = Free8003983;
        }
        field(21; "Index 1 Weight"; Decimal)
        {
            //blankzero = true;
            Caption = 'Index 1 Weight';
        }
        field(22; "Index 2 Weight"; Decimal)
        {
            //blankzero = true;
            Caption = 'Index 2 Weight';
        }
        field(23; "Index 3 Weight"; Decimal)
        {
            //blankzero = true;
            Caption = 'Index 3 Weight';
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

