Table 8001549 "Tax Posting Setup"
{
    //GL2024  ID dans Nav 2009 : "8001800"
    // //+TAX+TAXES GESWAY 08/04/03 Nouvelle table : paramètrage et calcul des taxes

    Caption = 'Tax Posting Setup';
    // DrillDownPageID = 8001800;
    //LookupPageID = 8001800;

    fields
    {
        field(1; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Tax Gen. Bus. Posting Group';
            TableRelation = "Tax Gen. Bus. Posting Group".Code where(Type = field(Type));
        }
        field(2; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Tax Gen. Prod. Posting Group';
            TableRelation = "Tax Gen. Prod. Posting Group".Code where(Type = field(Type));
        }
        field(3; Type; Option)
        {
            Caption = 'Tax Type';
            /*  GL2024 MaxValue = "5";
               MinValue = Tax2;*/
            OptionCaption = 'Tax 1,Tax 2,Tax 3,Tax 4,Tax 5';
            OptionMembers = Tax1,Tax2,Tax3,Tax4,Tax5;
        }
        field(10; "Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            OptionCaption = 'No Calculation,Tax Amount,Qty * Rate,Qty * Tax Amount,Amount Excl. VAT * Rate,Amount Excl. VAT * Tax Amount,Gross Amount * Rate,Gross Amount * Tax Amount,Calc. Base Amount * Rate,Calc. Base Amount * Tax Amount,Qty (Base) * Rate,Qty (Base) * Tax Amount';
            OptionMembers = "No Calculation","Tax Amount","Qty * Rate","Qty * Tax Amount","Amount Excl. VAT * Rate","Amount Excl. VAT * Tax Amount","Gross Amount * Rate","Gross Amount * Tax Amount","Calc. Base Amount * Rate","Calc. Base Amount * Tax Amount","Qty (Base) * Rate","Qty (Base) * Tax Amount";
        }
        field(11; "VAT Liable"; Boolean)
        {
            Caption = 'VAT Liable';
        }
        field(12; "Post G/L Entry"; Boolean)
        {
            Caption = 'Post G/L Entry';
        }
        field(13; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Tax %" < 0) or ("Tax %" > 100) then
                    Error(Text8001802);
            end;
        }
        field(15; Amount; Decimal)
        {
            Caption = 'Tax Amount';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Sale Account"; Code[20])
        {
            Caption = 'Sales Account';
            TableRelation = "G/L Account";
        }
        field(17; "Purchase Account"; Code[20])
        {
            Caption = 'Purchases Account';
            TableRelation = "G/L Account";
        }
        field(18; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
    }

    keys
    {
        key(Key1; Type, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group")
        {
            Clustered = true;
        }
        key(Key2; Type, "Gen. Prod. Posting Group", "Gen. Bus. Posting Group")
        {
        }
    }

    fieldgroups
    {
    }

    var
        TaxSetup: Record "Tax Setup2";
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        VATRate: Decimal;
        TaxRate: Decimal;
        TaxAmount: Decimal;
        isMandatory: Boolean;
        Qty: Decimal;
        QtyBase: Decimal;
        LineAmount: Decimal;
        GrossAmount: Decimal;
        CalcBaseAmount: Decimal;
        UnitAmountRoundPrecision: Decimal;
        AmountRoundPrecision: Decimal;
        CalculationMethod: Option "No Calculation","Tax Amount","Qty * Rate","Qty * Tax Amount","Amount Excl. VAT * Rate","Amount Excl. VAT * Tax Amount","Gross Amount * Rate","Gross Amount * Tax Amount","Calc. Base Amount * Rate","Calc. Base Amount * Tax Amount","Qty (Base) * Rate","Qty (Base) * Tax Amount";
        GenBusPostGroup: array[5] of Code[20];
        GenProdPostGroup: array[5] of Code[20];
        Text8001800: label 'Posting group does not exists for\Gen. Bus. Posting Group %1 and Gen. Prod. Posting Group %2.';
        Text8001801: label 'Parafiscal taxes can not be calculate.';
        CurrencyFactor: Decimal;
        CurrencyCode: Code[10];
        Text8001802: label 'Value must bet set between 0 and 100.';


    procedure CalcTaxAmount(SourceType: Boolean; PurchLine: Record "Purchase Line"; SalesLine: Record "Sales Line"; TaxeNo: Integer; pCalcBaseAmount: Decimal; DocumentDate: Date; var pUnitTaxAmount: Decimal; var PTaxAmount: Decimal; var pVATAmount: Decimal)
    begin
        TaxRate := 0;
        TaxAmount := 0;
        CalcBaseAmount := pCalcBaseAmount;

        SearchTaxes(SourceType, PurchLine, SalesLine, TaxeNo, CurrencyCode);
        CalculationMethod := "Calculation Method";
        TaxRate := "Tax %";

        /*IF ((CalculationMethod = CalculationMethod::"Tax Amount") OR
           (CalculationMethod = CalculationMethod::"Qty * Tax Amount") OR
           (CalculationMethod = CalculationMethod::"Amount Excl. VAT * Tax Amount") OR
           (CalculationMethod = CalculationMethod::"Gross Amount * Tax Amount") OR
           (CalculationMethod = CalculationMethod::"Calc. Base Amount * Tax Amount") OR
           (CalculationMethod = CalculationMethod::"Qty (Base) * Tax Amount")) AND
           (CurrencyCode <> '')
        THEN*/
        if CurrencyCode <> '' then
            TaxAmount :=
              CurrencyExchRate.ExchangeAmtLCYToFCY(
                DocumentDate, CurrencyCode, Amount, CurrencyFactor)
        else
            TaxAmount := Amount;

        CalcEachTaxes(pUnitTaxAmount, PTaxAmount, pVATAmount);

    end;


    procedure SearchTaxes(SourceType: Boolean; PurchLine: Record "Purchase Line"; SalesLine: Record "Sales Line"; TaxeNo: Integer; CurrencyCode: Code[10])
    var
        GetOK: Boolean;
    begin
        TaxSetup.Get;
        isMandatory := false;

        if SourceType then
            with PurchLine do begin
                PurchHeader.Get("Document Type", "Document No.");
                isMandatory :=
                  (TaxSetup."Tax 1 Value Posting" = TaxSetup."tax 1 value posting"::Purchase) or
                  (TaxSetup."Tax 1 Value Posting" = TaxSetup."tax 1 value posting"::"Sale and Purchase");

                Qty := Quantity;
                QtyBase := "Quantity (Base)";
                if PurchHeader."Prices Including VAT" and ("VAT %" > 0) then begin
                    "Line Amount" :=
                      ROUND("Line Amount" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                    "Line Discount Amount" :=
                      ROUND("Line Discount Amount" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                end;
                LineAmount := "Line Amount";
                GrossAmount := "Line Amount" + "Line Discount Amount";

                /*GL2024   GenBusPostGroup[1] := "Gen. Bus. Post. Group Tax 1";
                   GenBusPostGroup[2] := "Gen. Bus. Post. Group Tax 2";
                   GenBusPostGroup[3] := "Gen. Bus. Post. Group Tax 3";
                   GenBusPostGroup[4] := "Gen. Bus. Post. Group Tax 4";
                   GenBusPostGroup[5] := "Gen. Bus. Post. Group Tax 5";
                   GenProdPostGroup[1] := "Gen. Prod. Post. Group Tax 1";
                   GenProdPostGroup[2] := "Gen. Prod. Post. Group Tax 2";
                   GenProdPostGroup[3] := "Gen. Prod. Post. Group Tax 3";
                   GenProdPostGroup[4] := "Gen. Prod. Post. Group Tax 4";
                   GenProdPostGroup[5] := "Gen. Prod. Post. Group Tax 5";*/
            end
        else
            with SalesLine do begin
                SalesHeader.Get("Document Type", "Document No.");
                isMandatory :=
                  (TaxSetup."Tax 1 Value Posting" = TaxSetup."tax 1 value posting"::Sale) or
                  (TaxSetup."Tax 1 Value Posting" = TaxSetup."tax 1 value posting"::"Sale and Purchase");

                Qty := Quantity;
                QtyBase := "Quantity (Base)";
                if SalesHeader."Prices Including VAT" and ("VAT %" > 0) then begin
                    "Line Amount" := ROUND("Line Amount" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                    "Line Discount Amount" := ROUND("Line Discount Amount" / (1 + "VAT %" / 100), Currency."Amount Rounding Precision");
                end;
                LineAmount := "Line Amount";
                GrossAmount := "Line Amount" + "Line Discount Amount";

                /* GL2024   GenBusPostGroup[1] := "Gen. Bus. Post. Group Tax 1";
                    GenBusPostGroup[2] := "Gen. Bus. Post. Group Tax 2";
                    GenBusPostGroup[3] := "Gen. Bus. Post. Group Tax 3";
                    GenBusPostGroup[4] := "Gen. Bus. Post. Group Tax 4";
                    GenBusPostGroup[5] := "Gen. Bus. Post. Group Tax 5";
                    GenProdPostGroup[1] := "Gen. Prod. Post. Group Tax 1";
                    GenProdPostGroup[2] := "Gen. Prod. Post. Group Tax 2";
                    GenProdPostGroup[3] := "Gen. Prod. Post. Group Tax 3";
                    GenProdPostGroup[4] := "Gen. Prod. Post. Group Tax 4";
                    GenProdPostGroup[5] := "Gen. Prod. Post. Group Tax 5";*/
            end;

        Rec.Init;
        case TaxeNo of
            1:
                GetOK := Get(Type::Tax1, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
            2:
                GetOK := Get(Type::Tax2, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
            3:
                GetOK := Get(Type::Tax3, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
            4:
                GetOK := Get(Type::Tax4, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
            5:
                GetOK := Get(Type::Tax5, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
        end;

        if not GetOK and isMandatory then
            Error(Text8001800, GenBusPostGroup[TaxeNo], GenProdPostGroup[TaxeNo]);
    end;


    procedure CalcEachTaxes(var UnitAmount: Decimal; var Amount: Decimal; var VATAmount: Decimal)
    begin
        UnitAmount := 0;
        Amount := 0;
        case CalculationMethod of
            Calculationmethod::"No Calculation":
                Amount := 0;
            Calculationmethod::"Tax Amount":
                begin
                    Amount := TaxAmount;
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Qty * Rate":
                begin
                    Amount := ROUND(Qty * (TaxRate / 100), AmountRoundPrecision);
                    UnitAmount := TaxRate;
                end;
            Calculationmethod::"Qty * Tax Amount":
                begin
                    Amount := ROUND(Qty * TaxAmount, AmountRoundPrecision);
                    UnitAmount := TaxAmount;
                end;
            Calculationmethod::"Amount Excl. VAT * Rate":
                begin
                    Amount := ROUND(LineAmount * (TaxRate / 100), AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Amount Excl. VAT * Tax Amount":
                begin
                    Amount := ROUND(LineAmount * TaxAmount, AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Gross Amount * Rate":
                begin
                    Amount := ROUND(GrossAmount * (TaxRate / 100), AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Gross Amount * Tax Amount":
                begin
                    Amount := ROUND(GrossAmount * TaxAmount, AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Calc. Base Amount * Rate":
                begin
                    Amount := ROUND(CalcBaseAmount * (TaxRate / 100), AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Calc. Base Amount * Tax Amount":
                begin
                    Amount := ROUND(CalcBaseAmount * TaxAmount, AmountRoundPrecision);
                    if Qty <> 0 then
                        UnitAmount := ROUND(Amount / Qty, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Qty (Base) * Rate":
                begin
                    Amount := ROUND(QtyBase * (TaxRate / 100), AmountRoundPrecision);
                    if QtyBase <> 0 then
                        UnitAmount := ROUND(Amount / QtyBase, UnitAmountRoundPrecision);
                end;
            Calculationmethod::"Qty (Base) * Tax Amount":
                begin
                    Amount := ROUND(QtyBase * TaxAmount, AmountRoundPrecision);
                    if QtyBase <> 0 then
                        UnitAmount := ROUND(Amount / QtyBase, UnitAmountRoundPrecision);
                end;
            else
                Message(Text8001801);
        end;

        if "VAT Liable" and (VATRate <> 0) then
            VATAmount := ROUND(Amount * VATRate / 100, Currency."Amount Rounding Precision")
        else
            VATAmount := 0;
    end;


    procedure CalcVATTaxes(Amount: Decimal; VATRate: Decimal; CurrencyCode: Decimal)
    begin
    end;


    procedure InitCurrency(pCurrencyCode: Code[10]; pCurrencyFactor: Decimal; pUnitAmountRoundPrecision: Decimal; pAmountRoundPrecision: Decimal; pVATRate: Decimal)
    begin
        CurrencyCode := pCurrencyCode;
        if CurrencyCode = '' then
            Currency.InitRoundingPrecision
        else
            Currency.Get(CurrencyCode);

        UnitAmountRoundPrecision := pUnitAmountRoundPrecision;
        AmountRoundPrecision := pAmountRoundPrecision;
        CurrencyFactor := pCurrencyFactor;
        VATRate := pVATRate;
    end;
}

