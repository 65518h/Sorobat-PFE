Table 11300 "VAT VIES Correction"
{
    Caption = 'VAT VIES Correction';

    fields
    {
        field(1; Period; Code[10])
        {
            Caption = 'Period';
            NotBlank = true;
            Numeric = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'N° Ligne';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'N° Client';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Cust.Get("Customer No.");
                "Country/Region Code" := Cust."Country/Region Code";
                Validate("VAT Registration No.", Cust."VAT Registration No.");
            end;
        }
        field(4; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Montant';
            NotBlank = true;

            trigger OnValidate()
            begin
                GLSetup.Get;
                if GLSetup."Additional Reporting Currency" <> '' then begin
                    AddCurrencyFactor :=
                      CurrencyExchRate.ExchangeRate(Date, GLSetup."Additional Reporting Currency");
                    Currency.Get(GLSetup."Additional Reporting Currency");
                    Currency.TestField("Amount Rounding Precision");
                    "Additional-Currency Amount" :=
                      ROUND(
                        CurrencyExchRate.ExchangeAmtLCYToFCY(
                          Date, GLSetup."Additional Reporting Currency",
                          Amount, AddCurrencyFactor),
                        Currency."Amount Rounding Precision");
                end;
            end;
        }
        field(5; "Month/Quarter"; Text[2])
        {
            Caption = 'Month/Quarter';
            Editable = false;
        }
        field(6; Year; Text[30])
        {
            Caption = 'Année';
            Editable = false;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            var
                PeriodYear: Integer;
                PeriodQuarter: Integer;
                CorrectionYear: Integer;
                CorrectionQuarter: Integer;
                Text001: label 'You can not make a correction on %1 in Period %2';
                PeriodMonth: Integer;
                CorrectionMonth: Integer;
            begin
                //Year := FORMAT(DATE2DMY(Date,3));
                //Quarter := FORMAT(ROUND(DATE2DMY(Date,2) / 3,1,'>'));

                //CorrectionYear := DATE2DMY(Date,3);
                //CorrectionQuarter := ROUND(DATE2DMY(Date,2) / 3,1,'>');
                //EVALUATE(PeriodYear,COPYSTR(Period,STRPOS(Period,'/')+1));
                //EVALUATE(PeriodQuarter,COPYSTR(Period,1,STRPOS(Period,'/')-1));
                //IF (CorrectionYear > PeriodYear) OR
                //  ((CorrectionYear = PeriodYear) AND (CorrectionQuarter > PeriodQuarter))
                //THEN
                //  ERROR(Text001,FORMAT(Date),Period);


                Year := Format(Date2dmy(Date, 3));
                CorrectionYear := Date2dmy(Date, 3);
                CorrectionQuarter := ROUND(Date2dmy(Date, 2) / 3, 1, '>');
                Evaluate(PeriodYear, CopyStr(Period, StrPos(Period, '/') + 1));

                if GetPeriodType <> 0 then begin
                    "Month/Quarter" := Format(Date2dmy(Date, 2));
                    CorrectionMonth := Date2dmy(Date, 2);
                    Evaluate(PeriodMonth, DelStr(PeriodStr, GetPeriodType, 1));
                    if (CorrectionYear > PeriodYear) or
                      ((CorrectionYear = PeriodYear) and (CorrectionMonth > PeriodMonth))
                    then
                        Error(Text001, Format(Date), Period);
                end else begin
                    "Month/Quarter" := Format(ROUND(Date2dmy(Date, 2) / 3, 1, '>'));
                    Evaluate(PeriodQuarter, CopyStr(Period, 1, StrPos(Period, '/') - 1));
                    if (CorrectionYear > PeriodYear) or
                      ((CorrectionYear = PeriodYear) and (CorrectionQuarter > PeriodQuarter))
                    then
                        Error(Text001, Format(Date), Period)
                end;
            end;
        }
        field(9; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
            Editable = false;
        }
        field(10; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                TestField("Country/Region Code");
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", '', Database::"VAT VIES Correction");
            end;
        }
        field(11; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                Validate("VAT Registration No.");
            end;
        }
        field(36; "EU Service"; Boolean)
        {
            Caption = 'EU Service';
        }
    }

    keys
    {
        key(STG_Key1; Period, "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Customer No.", Period, "VAT Registration No.", "EU 3-Party Trade", Year, "Month/Quarter")
        {
            SumIndexFields = Amount, "Additional-Currency Amount";
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        AddCurrencyFactor: Decimal;
        PeriodStr: Code[10];


    procedure GetCurrencyCode(): Code[10]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        exit(GLSetup."Additional Reporting Currency");
    end;


    procedure GetPeriodType(): Integer
    begin
        PeriodStr := (CopyStr(Period, 1, StrPos(Period, '/') - 1));
        exit(StrPos(PeriodStr, 'M'));
    end;
}

