Table 8001542 "Stock Header"
{
    //GL2024  ID dans Nav 2009 : "8001610"
    // //+RAP+VMP GESWAY 01/08/02 Table 8001610 "Stock Header"

    Caption = 'Stock Header';
    DataCaptionFields = "Code", Description;
    // DrillDownPageID = 8001624;
    //LookupPageID = 8001624;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                if (Code <> xRec.Code) and (CurrFieldNo = FieldNo(Code)) then begin
                    StockSetup.Get;
                    NoSeriesMngt.TestManual(StockSetup."Stock No. Series");
                end;
            end;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(4; "Number of Shares"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Signed Quantity" where("Stock Code" = field(Code),
                                                                    "Posting Date" = field("Date Filter")));
            Caption = 'Number Of Shares';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Stock Posting Group"; Code[10])
        {
            Caption = 'Stock Posting Group';
            TableRelation = "Stock Posting Group";
        }
        field(7; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'Bank,G/L Account';
            OptionMembers = Bank,"G/L Account";

            trigger OnValidate()
            begin
                if xRec."Bal. Account Type" <> "Bal. Account Type" then begin
                    if StockLineExist then
                        Message(
                          Text002 +
                          Text003,
                          FieldCaption("Bal. Account Type"));
                    "Bal. Account No." := '';
                end;
            end;
        }
        field(8; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = filter(Bank)) "Bank Account";

            trigger OnValidate()
            begin
                if xRec."Bal. Account No." <> "Bal. Account No." then
                    if StockLineExist then
                        Message(
                          Text002 +
                          Text003,
                          FieldCaption("Bal. Account No."));

                if ("Bal. Account Type" = "bal. account type"::Bank) and
                   ("Bal. Account No." <> '')
                then begin
                    BankAccount.Get("Bal. Account No.");
                    if not StockLineExist then
                        Validate("Currency Code", BankAccount."Currency Code");
                end;
            end;
        }
        field(9; "ISIN Code"; Text[20])
        {
            Caption = 'ISIN Code';
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if xRec."Currency Code" <> "Currency Code" then
                    if StockLineExist then begin
                        "Currency Code" := xRec."Currency Code";
                        Error(Text001, FieldCaption("Currency Code"));
                    end;
            end;
        }
        field(11; "Call Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Amount (LCY)" where("Stock Code" = field(Code),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 Type = filter(Purchase)));
            Caption = 'Calls Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Put Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Amount (LCY)" where("Stock Code" = field(Code),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 Type = filter(Sale)));
            Caption = 'Puts Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Bank Charges (LCY)"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Charges Amount (LCY)" where("Stock Code" = field(Code),
                                                                         "Posting Date" = field("Date Filter")));
            Caption = 'Bank Charges (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Capital Gain Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Capital Gain Amount (LCY)" where("Stock Code" = field(Code),
                                                                              "Posting Date" = field("Date Filter")));
            Caption = 'Capital Gain Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Loss In Value Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Stock Line"."Loss In Value Amount (LCY)" where("Stock Code" = field(Code),
                                                                               "Posting Date" = field("Date Filter")));
            Caption = 'Loss In Value Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Category; Option)
        {
            Caption = 'Category';
            OptionCaption = ' ,Stock,Bond';
            OptionMembers = " ",Stock,Bond;
        }
        field(17; "Call Quantity"; Decimal)
        {
            CalcFormula = sum("Stock Line".Quantity where("Stock Code" = field(Code),
                                                           "Posting Date" = field("Date Filter"),
                                                           Type = filter(Purchase)));
            Caption = 'Call Quantity';
            FieldClass = FlowField;
        }
        field(18; "Put Quantity"; Decimal)
        {
            CalcFormula = sum("Stock Line".Quantity where("Stock Code" = field(Code),
                                                           "Posting Date" = field("Date Filter"),
                                                           Type = filter(Sale)));
            Caption = 'Put Quantity';
            FieldClass = FlowField;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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

    trigger OnDelete()
    begin
        if StockLineExist then
            StockLine.DeleteAll(true);

        StockPriceReg.SetRange("Stock Code", Code);
        if StockPriceReg.Find('-') then
            StockPriceReg.DeleteAll;
    end;

    trigger OnInsert()
    begin
        "Creation Date" := WorkDate;
        if Code = '' then begin
            StockSetup.Get;
            StockSetup.TestField("Stock No. Series");
            NoSeriesMngt.InitSeries(StockSetup."Stock No. Series", '', 0D, Code, "No. Series");
        end;
    end;

    var
        StockLine: Record "Stock Line";
        StockSetup: Record "Stock Setup";
        StockPriceReg: Record "Stock Price Register";
        BankAccount: Record "Bank Account";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        Text001: label 'You cannot change %1 because there are one or more transactions associated with this stock.';
        Text002: label 'You have changed %1 on the stock header, but it has not been changed on the existing transactions.\';
        Text003: label 'You must update the existing lines manually.';


    procedure AssistEdit(StockHeader: Record "Stock Header"): Boolean
    begin
        StockSetup.Get;
        StockSetup.TestField("Stock No. Series");
        if NoSeriesMngt.SelectSeries(StockSetup."Stock No. Series", '', StockHeader."No. Series") then
            exit(true);
    end;


    procedure StockLineExist(): Boolean
    begin
        StockLine.Reset;
        StockLine.SetRange("Stock Code", Code);
        exit(StockLine.Find('-'));
    end;
}

