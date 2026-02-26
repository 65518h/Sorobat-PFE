Table 11301 "Manual VAT Correction"
{
    Caption = 'Manual VAT Correction';
    //DrillDownPageID = 11303;
    //LookupPageID = 11303;

    fields
    {
        field(1; "Statement Template Name"; Code[10])
        {
            Caption = 'Statement Template Name';
            TableRelation = "VAT Statement Template";
        }
        field(2; "Statement Name"; Code[10])
        {
            Caption = 'Statement Name';
        }
        field(3; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            NotBlank = true;
        }
        field(6; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                GLSetup.Get;
                if GLSetup."Additional Reporting Currency" <> '' then begin
                    ;
                    AddCurrencyFactor :=
                      CurrencyExchRate.ExchangeRate("Posting Date", GLSetup."Additional Reporting Currency");
                    Currency.Get(GLSetup."Additional Reporting Currency");
                    Currency.TestField("Amount Rounding Precision");
                    "Additional-Currency Amount" :=
                      ROUND(
                        CurrencyExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date", GLSetup."Additional Reporting Currency",
                          Amount, AddCurrencyFactor),
                        Currency."Amount Rounding Precision");
                end;
            end;
        }
        field(7; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(8; "Row No."; Code[10])
        {
            CalcFormula = lookup("VAT Statement Line"."Row No." where("Statement Template Name" = field("Statement Template Name"),
                                                                       "Statement Name" = field("Statement Name"),
                                                                       "Line No." = field("Statement Line No.")));
            Caption = 'Row No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Statement Template Name", "Statement Name", "Statement Line No.", "Posting Date")
        {
            Clustered = true;
            SumIndexFields = Amount, "Additional-Currency Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField(Amount);
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        "User ID" := UserId;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        AddCurrencyFactor: Decimal;


    procedure GetCurrencyCode(): Code[10]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        exit(GLSetup."Additional Reporting Currency");
    end;
}

