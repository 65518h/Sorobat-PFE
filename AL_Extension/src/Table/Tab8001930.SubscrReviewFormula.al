Table 8001930 "Subscr. Review Formula"
{
    // #6710 CW 03/12/09
    // //+ABO_REVIEW CW 17/03/09
    // #2714 CW 23/06/08
    // //PRICE_REVIEW OF 01/06/08

    Caption = 'Review Formula';
    // LookupPageID = 8001930;

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
        field(5; "Date Calculation"; DateFormula)
        {
            Caption = 'Date Calculation';
        }
        field(6; "Review Text Code"; Code[10])
        {
            Caption = 'Review Text Code';
            TableRelation = "Standard Text";
        }
        field(7; "Starting Date Calculation"; DateFormula)
        {
            Caption = 'Starting Date Calculation';
        }
        field(11; "Index 1 Code"; Code[10])
        {
            Caption = 'Index 1 Code';
            TableRelation = "Subscr. Review Index";
        }
        field(12; "Index 2 Code"; Code[10])
        {
            Caption = 'Index 2 Code';
            TableRelation = "Subscr. Review Index";
        }
        field(13; "Index 3 Code"; Code[10])
        {
            Caption = 'Index 3 Code';
            TableRelation = "Subscr. Review Index";
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
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure fReviewFactor(pBaseDate: Date; pReviewDate: Date): Decimal
    var
        lSum: Integer;
    begin
        exit(
          ROUND(1 - "Index 1 Weight" - "Index 2 Weight" - "Index 3 Weight" +
            "Index 1 Weight" * fIndex("Index 1 Code", pBaseDate, pReviewDate) +
            "Index 2 Weight" * fIndex("Index 2 Code", pBaseDate, pReviewDate) +
            "Index 3 Weight" * fIndex("Index 3 Code", pBaseDate, pReviewDate),
          "Ratio Rounding Precision"));
    end;


    procedure fIndex(pCode: Code[10]; pBaseDate: Date; pReviewDate: Date): Decimal
    var
        lIndexValue: Record "Subscr. Review Value";
        lBaseValue: Decimal;
    begin
        if (pCode = '') or (pBaseDate = 0D) or (pReviewDate = 0D) then
            exit(0);
        lIndexValue.SetRange("Index Code", pCode);
        lIndexValue.SetRange("Starting Date", 0D, pBaseDate);
        lIndexValue.FindLast;
        lBaseValue := lIndexValue.Value;
        lIndexValue.SetRange("Starting Date", 0D, pReviewDate);
        lIndexValue.FindLast;
        exit(lIndexValue.Value / lBaseValue);
    end;
}

