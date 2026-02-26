Table 8001543 "Stock Line"
{
    //GL2024  ID dans Nav 2009 : "8001611"
    // //+RAP+VMP GESWAY 01/08/02 Table "Stock Line"
    //                   07/02/03 Ne pas envoyer de mail en direct
    //                   01/07/05 Modification de la propriété DecimalePlaces
    //                            - 0:5 sur Quantité
    //                            - 0:2 sur Montants

    Caption = 'Stock Line';
    // DrillDownPageID = 8001625;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Stock Code"; Code[20])
        {
            Caption = 'Stock Code';
            TableRelation = "Stock Header".Code;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField("Posting Date");
                StockSetup.Get;
                "Value Date" := CalcDate(StockSetup."Value Date Calculation", "Posting Date");
                CopyHeader;
            end;
        }
        field(4; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Call,Put,Charge';
            OptionMembers = Purchase,Sale,Charge;

            trigger OnValidate()
            begin
                if (xRec.Type <> Type) and
                   ((Quantity > 0) or (Type = Type::Charge)) then
                    GetDescription;

                if Type = Type::Charge then begin
                    Clear(Quantity);
                    Clear("Signed Quantity");
                    Clear("Unit Price");
                    Clear(Amount);
                end;
            end;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                StockHeader.Get("Stock Code");
                if Type = Type::Charge then
                    TestField(Quantity, 0)
                else begin
                    GetDescription;
                    "Unit Price" := GetStockPrice;
                    UpdateAmount;
                end;
            end;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                if Type = Type::Charge then
                    TestField("Unit Price", 0)
                else
                    UpdateAmount;
            end;
        }
        field(9; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            MinValue = 0;

            trigger OnValidate()
            begin
                GetCurrency;
                Amount := ROUND(Amount, Currency."Amount Rounding Precision");

                if Type = Type::Charge then
                    TestField(Amount, 0)
                else
                    UpdateUnitPrice;
            end;
        }
        field(10; "Charges Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Charge Amount';
            MinValue = 0;
        }
        field(11; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            MinValue = 0;
        }
        field(30; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'Bank,G/L Account';
            OptionMembers = Bank,"G/L Account";

            trigger OnValidate()
            begin
                if xRec."Bal. Account Type" <> "Bal. Account Type" then
                    "Bal. Account No." := '';
            end;
        }
        field(31; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = filter("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = filter(Bank)) "Bank Account";
        }
        field(32; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(33; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(34; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(35; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(36; "Assigned Quantity"; Decimal)
        {
            Caption = 'Assigned Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(37; Open; Boolean)
        {
            Caption = 'Open';
            Editable = false;
            InitValue = true;
        }
        field(38; Posted; Boolean)
        {
            Caption = 'Posted to G/L';
            Editable = false;
        }
        field(39; "Capital Gain Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Capital Gain Amount';
            Editable = false;
        }
        field(40; "Loss In Value Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Loss In Value Amount';
            Editable = false;
        }
        field(41; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(42; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(43; Certified; Boolean)
        {
            Caption = 'Certified';
            Editable = false;
        }
        field(50; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(51; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(52; "Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(53; "Charges Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Charge Amount (LCY)';
        }
        field(54; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
        }
        field(55; "Capital Gain Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Capital Gain Amount (LCY)';
        }
        field(56; "Loss In Value Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Loss In Value Amount (LCY)';
        }
        field(57; "Signed Quantity"; Decimal)
        {
            Caption = 'Signed Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(58; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(59; "Average Cost"; Decimal)
        {
            Caption = 'Average Cost';
        }
        field(60; "Average Cost (LCY)"; Decimal)
        {
            Caption = 'Average Cost (LCY)';
        }
    }

    keys
    {
        key(Key1; "Stock Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date", Type)
        {
            SumIndexFields = Quantity, "Signed Quantity", "Amount (LCY)", "Charges Amount (LCY)", "Capital Gain Amount (LCY)", "Loss In Value Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Posted, false);
        TestField("Assigned Quantity", 0);
    end;

    trigger OnInsert()
    begin
        UpdateFields;
    end;

    trigger OnModify()
    begin
        if (xRec."Posting Date" <> "Posting Date") or
          (xRec.Type <> Type) or
          (xRec.Quantity <> Quantity) or
          (xRec."Unit Price" <> "Unit Price")
        then
            TestField(Certified, false);
        if (xRec."Posting Date" <> "Posting Date") or
          (xRec.Type <> Type) or
          (xRec.Quantity <> Quantity) or
          (xRec."Unit Price" <> "Unit Price") or
          (xRec."Charges Amount" <> "Charges Amount") or
          (xRec."VAT Amount" <> "VAT Amount") or
          (xRec."Bal. Account Type" <> "Bal. Account Type") or
          (xRec."Bal. Account No." <> "Bal. Account No.")
        then
            TestField(Posted, false);

        UpdateFields;
    end;

    var
        StockHeader: Record "Stock Header";
        StockLine: Record "Stock Line";
        BankAccount: Record "Bank Account";
        Currency: Record Currency;
        CurrencyExchange: Record "Currency Exchange Rate";
        StockSetup: Record "Stock Setup";
        StockPostGroup: Record "Stock Posting Group";
        StockPriceRegister: Record "Stock Price Register";
        TextHeader: Record "Extended Text Header";
        TextLine: Record "Extended Text Line";
        MailMngt: Codeunit Mail;
        //  PostStock: Codeunit "Stock-Post";
        FNavigate: Page Navigate;
        EmailAttachment: Text[250];
        Text001: label 'Stock Transaction';
        Text002: label 'Bank Account does not exists.';
        Text003: label 'Attempt to send confirmation by E-mail has failed. ';
        EmailSend: Boolean;
        Text004: label 'Do you confirm to send by e-mail ?';
        "-": Integer;
        ErrorNo: Integer;


    procedure UpdateAmount()
    begin
        Amount := Quantity * "Unit Price";
    end;


    procedure UpdateUnitPrice()
    begin
        TestField(Quantity);
        "Unit Price" := Amount / Quantity;
    end;


    procedure ConfirmByMail()
    begin
        StockLine := Rec;
        TestField("Bal. Account Type", "bal. account type"::Bank);
        TestField("Bal. Account No.");
        TestField(Quantity);
        TestField(Amount);

        StockLine.SetRecfilter;
        //DYS REPORT ADDON NON MIGRER
        //Report.Run(Report::"Stock Confirmation Letter", true, false, StockLine);
    end;


    procedure ConfirmByEMail()
    begin
        if not Confirm(Text004, false) then
            exit;

        Clear(MailMngt);
        StockSetup.Get;
        StockLine := Rec;
        TestField("Bal. Account Type", "bal. account type"::Bank);
        TestField("Bal. Account No.");
        TestField(Quantity);
        TestField(Amount);

        if BankAccount.Get("Bal. Account No.") then
            BankAccount.TestField("E-Mail");

        //EmailAttachment := ENVIRON('TEMP') + '\CONFIRM.HTM';
        //GL2024 License   EmailAttachment := TemporaryPath + '\CONFIRM.HTM';
        StockLine.SetRecfilter;
        //DYS REPORT ADDON NON MIGRER
        // if not Report.SaveAsHtml(
        //     Report::"Stock Confirmation Letter", EmailAttachment, false, StockLine)
        // then
        //     EmailAttachment := '';

        /*  //GL2024 License   MailMngt.NewMessage(
               BankAccount."E-Mail", '', Text001, '', '', EmailAttachment, true);//GL2024 License*/

        if StockSetup."Email Confirmation Text Code" <> '' then begin
            TextLine.Reset;
            TextLine.SetRange("Table Name", TextLine."table name"::"Standard Text");
            TextLine.SetRange("No.", StockSetup."Email Confirmation Text Code");
            if BankAccount."Language Code" <> '' then begin
                TextLine.SetRange("Language Code", BankAccount."Language Code");
                if not TextLine.FindFirst then
                    TextLine.SetRange("Language Code", '');
            end else
                TextLine.SetRange("Language Code", '');

            if not TextLine.IsEmpty then begin
                TextLine.Find('-');
                /*//GL2024 License repeat
                     MailMngt.AddBodyline(TextLine.Text);
                 until TextLine.Next = 0; //GL2024 License*/
            end;
        end;

        //GL2024 License  EmailSend := MailMngt.Send;
        Clear(MailMngt);
        /* //GL2024 License if EmailAttachment <> '' then
             Erase(EmailAttachment);//GL2024 License*/

        //IF NOT EmailSend THEN
        //  ERROR(Text003);
    end;


    procedure CopyHeader()
    begin
        StockSetup.Get;
        StockHeader.Get("Stock Code");
        if "Bal. Account No." = '' then begin
            "Bal. Account No." := StockHeader."Bal. Account No.";
            "Bal. Account Type" := StockHeader."Bal. Account Type";
        end;
        "Currency Code" := StockHeader."Currency Code";

        //Code motif depuis StockSetup
        //"Reason Code" := StockHeader."Reason Code";
        if ("Reason Code" <> '') and
           (StockSetup."Reason Code" <> '')
        then
            "Reason Code" := StockSetup."Reason Code";
    end;


    procedure Navigate(StockLine: Record "Stock Line")
    begin
        with StockLine do begin
            TestField(Posted);
            if Posted then begin
                FNavigate.SetDoc("Posting Date", "Applies-to ID");
                FNavigate.Run;
            end;
        end;
    end;


    procedure UpdateFields()
    begin
        StockLine.Copy(Rec);

        case Type of
            Type::Purchase:
                begin
                    "Signed Quantity" := Quantity;
                    Clear("Capital Gain Amount");
                    Clear("Loss In Value Amount");
                end;

            Type::Sale:
                "Signed Quantity" := -Quantity;

            Type::Charge:
                begin
                    Clear(Quantity);
                    Clear("Signed Quantity");
                    Clear("Unit Price");
                    Clear(Amount);
                    Clear("Capital Gain Amount");
                    Clear("Loss In Value Amount");
                end;
        end;

        GetCurrency;
        "Unit Price (LCY)" := UpdateLCYValue("Unit Price");
        "Amount (LCY)" := UpdateLCYValue(Amount);
        "Charges Amount (LCY)" := UpdateLCYValue("Charges Amount");
        "VAT Amount (LCY)" := UpdateLCYValue("VAT Amount");

        if Type <> Type::Charge then
            UpdateStockPrice;
    end;


    procedure GetDescription()
    begin
        StockHeader.Get("Stock Code");
        StockSetup.Get;

        case Type of
            Type::Purchase:
                Description := CopyStr(
                  StrSubstNo('%1 %2 %3',
                    StockSetup."Call Description", Quantity, StockHeader.Description), 1, 50);

            Type::Sale:
                Description := CopyStr(
                  StrSubstNo('%1 %2 %3',
                    StockSetup."Put Description", Quantity, StockHeader.Description), 1, 50);

            Type::Charge:
                Description := CopyStr(
                  StrSubstNo('%1 %2',
                    StockSetup."Bank Charges Description", StockHeader.Description), 1, 50);
        end;
    end;


    procedure GetCurrency()
    begin
        StockHeader.Get("Stock Code");
        "Currency Code" := StockHeader."Currency Code";
        "Currency Factor" := CurrencyExchange.ExchangeRate("Posting Date", "Currency Code");

        if "Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else
            if "Currency Code" <> Currency.Code then begin
                Currency.Get("Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
    end;


    procedure UpdateLCYValue(pAmount: Decimal): Decimal
    begin
        if "Currency Code" = '' then
            exit(pAmount);

        exit(
          ROUND(
            CurrencyExchange.ExchangeAmtFCYToLCY(
              "Posting Date",
              "Currency Code",
              pAmount, "Currency Factor")));
    end;


    procedure GetStockPrice(): Decimal
    begin
        StockPriceRegister.Reset;
        StockPriceRegister.SetRange("Stock Code", "Stock Code");
        StockPriceRegister.SetFilter(Date, '<=%1', "Posting Date");
        if StockPriceRegister.FindLast then
            exit(StockPriceRegister.Value)
        else
            exit(0);
    end;


    procedure UpdateStockPrice()
    begin
        if "Unit Price" <> 0 then begin
            StockPriceRegister.Init;
            StockPriceRegister.Value := "Unit Price";
            StockPriceRegister."Stock Code" := "Stock Code";
            StockPriceRegister.Date := "Posting Date";
            StockPriceRegister."Currency Code" := "Currency Code";
            StockPriceRegister."Currency Factor" := "Currency Factor";
            StockPriceRegister."Value (LCY)" := UpdateLCYValue(StockPriceRegister.Value);
            if not StockPriceRegister.Insert then
                StockPriceRegister.Modify;
        end;
    end;
}

