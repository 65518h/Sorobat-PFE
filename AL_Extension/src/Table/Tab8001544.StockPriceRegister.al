Table 8001544 "Stock Price Register"
{
    //GL2024  ID dans Nav 2009 : "8001612"
    // //+RAP+VMP GESWAY 01/08/02 Table "Quotation Source"

    Caption = 'Stock Price Register';
    DataCaptionFields = "Stock Code";

    fields
    {
        field(1; "Stock Code"; Code[20])
        {
            Caption = 'Stock Code';
            TableRelation = "Stock Header".Code;
        }
        field(2; Date; Date)
        {
            Caption = 'Quotation Date';

            trigger OnValidate()
            begin
                UpdateValueLCY;
            end;
        }
        field(3; Value; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Value';

            trigger OnValidate()
            begin
                TestField(Date);
                UpdateValueLCY;
            end;
        }
        field(4; "Value (LCY)"; Decimal)
        {
            Caption = 'Value (LCY)';
            Editable = false;
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(8; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Stock Code", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StockHeader: Record "Stock Header";
        CurrExchRate: Record "Currency Exchange Rate";


    procedure UpdateValueLCY()
    begin
        StockHeader.Get("Stock Code");
        "Currency Code" := StockHeader."Currency Code";
        "Currency Factor" := CurrExchRate.ExchangeRate(Date, "Currency Code");
        "Value (LCY)" := ROUND(
          CurrExchRate.ExchangeAmtFCYToLCY(
            Date, "Currency Code", Value, "Currency Factor"))
    end;


    procedure SearchValue("Code": Code[20]; StockPriceDate: Date; LCY: Boolean) StockPriceValue: Decimal
    begin
        Reset;
        SetRange("Stock Code", Code);
        SetFilter(Date, '<=%1', StockPriceDate);

        StockPriceValue := 0;
        if Find('+') then begin
            if LCY then
                StockPriceValue := "Value (LCY)"
            else
                StockPriceValue := Value;
        end;
    end;
}

