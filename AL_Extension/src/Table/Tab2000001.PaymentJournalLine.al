Table 2000001 "Payment Journal Line"
{
    // #6411 CW 12/10/08
    // //BE_CODA CW 09/10/04 CurrencyCode must be ISO, CountryCode must be ISO

    Caption = 'Payment Journal Line';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Payment Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Type de Compte';
            InitValue = Vendor;
            OptionCaption = ',Customer,Vendor';
            OptionMembers = ,Customer,Vendor;

            trigger OnValidate()
            begin
                "Account No." := '';
                Validate("Account No.");
            end;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'N° de Compte';
            TableRelation = if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor;

            trigger OnValidate()
            begin
                if "Account No." <> xRec."Account No." then begin
                    xRec."Account Type" := "Account Type";
                    xRec."Account No." := "Account No.";
                    xRec."Posting Date" := "Posting Date";
                    xRec."Bank Account" := "Bank Account";
                    Init;
                    "Account Type" := xRec."Account Type";
                    "Account No." := xRec."Account No.";
                    Validate("Posting Date", xRec."Posting Date");
                    Validate("Bank Account", xRec."Bank Account");
                end;
                if "Account No." = '' then begin
                    CreateDim(
                      DimMgt.TypeToTableID1("Account Type"), "Account No.",
                      Database::"Bank Account", "Bank Account");
                    exit;
                end;
                case "Account Type" of
                    "account type"::Customer:
                        begin
                            Cust.Get("Account No.");
                            if ("Applies-to Doc. No." = '') and ("Applies-to ID" = '') then
                                Validate("Currency Code", Cust."Currency Code");
                            Validate("Bank Account Country Code", Cust."Country/Region Code");
                            //#6274
                            //      VALIDATE("Beneficiary Bank Account",Cust."Preferred Bank Account");
                            Validate("Beneficiary Bank Account", gPaymentMgt.GetCustDefBankCode(Cust."No."));
                            //#6274//
                            "Payment Method Code" := Cust."Payment Method Code";
                            if "Applies-to Doc. Type" = 0 then
                                "Applies-to Doc. Type" := "applies-to doc. type"::"Credit Memo";
                        end;
                    "account type"::Vendor:
                        begin
                            Vend.Get("Account No.");
                            if ("Applies-to Doc. No." = '') and ("Applies-to ID" = '') then
                                Validate("Currency Code", Vend."Currency Code");
                            Validate("Bank Account Country Code", Vend."Country/Region Code");
                            //#6274
                            //      VALIDATE("Beneficiary Bank Account",Vend."Preferred Bank Account");
                            Validate("Beneficiary Bank Account", gPaymentMgt.GetVendDefBankCode(Vend."No."));
                            //#6274
                            "Payment Method Code" := Vend."Payment Method Code";
                            if "Applies-to Doc. Type" = 0 then
                                "Applies-to Doc. Type" := "applies-to doc. type"::Invoice;
                        end;
                end;

                CreateDim(
                  DimMgt.TypeToTableID1("Account Type"), "Account No.",
                  Database::"Bank Account", "Bank Account");
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                if ("Pmt. Discount Date" = 0D)
                or ("Pmt. Discount Date" = xRec."Posting Date") then
                    "Pmt. Discount Date" := "Posting Date";
            end;
        }
        field(7; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(8; "Payment Message"; Text[50])
        {
            Caption = 'Payment Message';

            trigger OnValidate()
            begin
                //DYS FONCTION OBSOLET
                // "Standard Format Message" := GenJnlManagement.Mod97Test("Payment Message");
                Validate("Separate Line");
            end;
        }
        field(9; "Standard Format Message"; Boolean)
        {
            Caption = 'Standard Format Message';
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                InitCurrencyCode;
                if "Currency Code" <> '' then begin
                    if ("Currency Code" <> xRec."Currency Code") or
                       ("Posting Date" <> xRec."Posting Date") or
                       (CurrFieldNo = FieldNo("Currency Code")) or
                       ("Currency Factor" = 0)
                    then
                        "Currency Factor" :=
                          CurrencyExchRate.ExchangeRate("Posting Date", "Currency Code");
                end else begin
                    "Currency Factor" := 0;
                end;
                Validate("Currency Factor");
                "ISO Currency Code" := GetISOCurrencyCode;
                SetPaymentType;
            end;
        }
        field(13; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text001, FieldCaption("Currency Code")));
                Validate(Amount);
            end;
        }
        field(14; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Montant';

            trigger OnValidate()
            begin
                InitCurrencyCode;
                Amount := ROUND(Amount, Currency."Amount Rounding Precision");

                if "Currency Code" = '' then
                    "Amount (LCY)" := Amount
                else
                    "Amount (LCY)" := ROUND(
                      CurrencyExchRate.ExchangeAmtFCYToLCY(
                        "Posting Date", "Currency Code",
                        Amount, "Currency Factor"));

                "Partial Payment" := ("Original Remaining Amount" - "Pmt. Disc. Possible") <> Amount;
                Validate("Separate Line");
            end;
        }
        field(15; "Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                if "Pmt. Disc. Possible" * Amount < 0 then
                    FieldError("Pmt. Disc. Possible", StrSubstNo(Text002, FieldCaption(Amount)));

                InitCurrencyCode;
                "Pmt. Disc. Possible" := ROUND("Pmt. Disc. Possible", Currency."Amount Rounding Precision");

                if "Currency Code" <> '' then begin
                    "Pmt. Disc. Possible (LCY)" := ROUND(
                      CurrencyExchRate.ExchangeAmtFCYToLCY(
                        "Posting Date", "Currency Code",
                        "Pmt. Disc. Possible", "Currency Factor"));
                end else begin
                    "Pmt. Disc. Possible (LCY)" := "Pmt. Disc. Possible";
                end;
                if CurrFieldNo = FieldNo("Pmt. Disc. Possible") then
                    Validate(Amount, Amount + xRec."Pmt. Disc. Possible" - Rec."Pmt. Disc. Possible")
                else
                    Validate(Amount);
            end;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    Amount := "Amount (LCY)";
                    Validate(Amount);
                end else begin
                    TestField(Amount);
                    "Currency Factor" := Amount / "Amount (LCY)";
                end;
            end;
        }
        field(17; "Pmt. Disc. Possible (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Possible (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Pmt. Disc. Possible" := "Pmt. Disc. Possible (LCY)";
                    Validate("Pmt. Disc. Possible");
                end else begin
                    TestField("Currency Factor");
                    Validate("Pmt. Disc. Possible", ("Pmt. Disc. Possible (LCY)" / "Currency Factor"));
                end;
            end;
        }
        field(18; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            Editable = true;

            trigger OnValidate()
            begin
                if "Applies-to Doc. No." <> '' then
                    Validate("Applies-to Doc. No.");
            end;
        }
        field(19; "Beneficiary Bank Account"; Code[10])
        {
            Caption = 'Beneficiary Bank Account';
            TableRelation = if ("Account Type" = filter(Customer)) "Customer Bank Account".Code where("Customer No." = field("Account No."))
            else
            if ("Account Type" = filter(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."));

            trigger OnValidate()
            begin
                if "Beneficiary Bank Account" <> '' then
                    case "Account Type" of
                        "account type"::Customer:
                            begin
                                CustBankAcc.Get("Account No.", "Beneficiary Bank Account");
                                Validate("Beneficiary Bank Account No.", CustBankAcc."Bank Account No.");
                                Validate("Bank Account Country Code", CustBankAcc."Country/Region Code")
                            end;
                        "account type"::Vendor:
                            begin
                                VendBankAcc.Get("Account No.", "Beneficiary Bank Account");
                                Validate("Beneficiary Bank Account No.", VendBankAcc."Bank Account No.");
                                Validate("Bank Account Country Code", VendBankAcc."Country/Region Code")
                            end;
                    end
                else
                    Validate("Beneficiary Bank Account No.", '');
            end;
        }
        field(20; "Beneficiary Bank Account No."; Text[30])
        {
            Caption = 'Beneficiary Bank Account No.';
            Editable = false;

            trigger OnValidate()
            begin
                //DYS CDU OBSOLET
                // "Beneficiary Account No. OK" := GenJnlManagement.Mod97Test("Beneficiary Bank Account No.");
            end;
        }
        field(21; "Beneficiary Account No. OK"; Boolean)
        {
            Caption = 'Beneficiary Account No. OK';
            Editable = false;
        }
        field(22; "Bank Account"; Code[20])
        {
            Caption = 'Compte Bancaire';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Bank Account" = '' then
                    Status := Status::" "
                else
                    Status := Status::Marked;

                CreateDim(
                  Database::"Bank Account", "Bank Account",
                  DimMgt.TypeToTableID1("Account Type"), "Account No.");
            end;
        }
        field(23; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            begin
                AccNo := "Account No.";
                AccType := "Account Type";

                case AccType of
                    Acctype::Customer:
                        begin
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date");
                            CustLedgEntry.SetRange("Customer No.", AccNo);
                            CustLedgEntry.SetRange(Open, true);
                            if "Applies-to Doc. No." <> '' then begin
                                CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                if CustLedgEntry.Find('-') then;
                                CustLedgEntry.SetRange("Document Type");
                                CustLedgEntry.SetRange("Document No.");
                            end else
                                if "Applies-to ID" <> '' then begin
                                    CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                    if CustLedgEntry.Find('-') then;
                                    CustLedgEntry.SetRange("Applies-to ID");
                                end else
                                    if "Applies-to Doc. Type" <> 0 then begin
                                        CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                        if CustLedgEntry.Find('-') then;
                                        CustLedgEntry.SetRange("Document Type");
                                    end else
                                        if Amount <> 0 then begin
                                            CustLedgEntry.SetRange(Positive, Amount < 0);
                                            if CustLedgEntry.Find('-') then;
                                            CustLedgEntry.SetRange(Positive);
                                        end;
                            if not CustLedgEntry.Find('-') then begin
                                CustLedgEntry.Init;
                                CustLedgEntry."Customer No." := AccNo;
                            end;
                            Clear(ApplyCustLedgEntries);
                            ApplyCustLedgEntries.SetTableview(CustLedgEntry);
                            ApplyCustLedgEntries.SetRecord(CustLedgEntry);
                            ApplyCustLedgEntries.LookupMode(true);
                            if ApplyCustLedgEntries.RunModal = Action::LookupOK then begin
                                ApplyCustLedgEntries.GetRecord(CustLedgEntry);
                                CustUpdatePayment;
                            end;
                        end;
                    Acctype::Vendor:
                        begin
                            VendLedgEntry.Reset;
                            VendLedgEntry.SetCurrentkey("Vendor No.", Open, Positive, "Due Date");
                            VendLedgEntry.SetRange("Vendor No.", AccNo);
                            VendLedgEntry.SetRange(Open, true);
                            if "Applies-to Doc. No." <> '' then begin
                                VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                if VendLedgEntry.Find('-') then;
                                VendLedgEntry.SetRange("Document Type");
                                VendLedgEntry.SetRange("Document No.");
                            end else
                                if "Applies-to ID" <> '' then begin
                                    VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                                    if VendLedgEntry.Find('-') then;
                                    VendLedgEntry.SetRange("Applies-to ID");
                                end else
                                    if "Applies-to Doc. Type" <> 0 then begin
                                        VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                        if VendLedgEntry.Find('-') then;
                                        VendLedgEntry.SetRange("Document Type");
                                    end else
                                        if Amount <> 0 then begin
                                            VendLedgEntry.SetRange(Positive, Amount < 0);
                                            if VendLedgEntry.Find('-') then;
                                            VendLedgEntry.SetRange(Positive);
                                        end;
                            if not VendLedgEntry.Find('-') then begin
                                VendLedgEntry.Init;
                                VendLedgEntry."Vendor No." := AccNo;
                            end;
                            Clear(ApplyVendLedgEntries);
                            ApplyVendLedgEntries.SetTableview(VendLedgEntry);
                            ApplyVendLedgEntries.SetRecord(VendLedgEntry);
                            ApplyVendLedgEntries.LookupMode(true);
                            if ApplyVendLedgEntries.RunModal = Action::LookupOK then begin
                                ApplyVendLedgEntries.GetRecord(VendLedgEntry);
                                VendUpdatePayment;
                            end;
                        end;
                end;
            end;

            trigger OnValidate()
            begin
                // Empty Applies-to Doc for payment without invoice
                if "Applies-to Doc. No." <> '' then
                    case "Account Type" of
                        "account type"::Customer:
                            begin
                                CustLedgEntry.Reset;
                                CustLedgEntry.SetCurrentkey("Document No.", "Document Type", "Customer No.");
                                CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                CustLedgEntry.SetRange("Customer No.", "Account No.");
                                if not CustLedgEntry.Find('-') then
                                    Error(Text003, "Applies-to Doc. Type", "Applies-to Doc. No.");
                                CustUpdatePayment;
                            end;
                        "account type"::Vendor:
                            begin
                                VendLedgEntry.Reset;
                                VendLedgEntry.SetCurrentkey("Document No.", "Document Type", "Vendor No.");
                                VendLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                                VendLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                                VendLedgEntry.SetRange("Vendor No.", "Account No.");
                                if not VendLedgEntry.Find('-') then
                                    Error(Text004, "Applies-to Doc. Type", "Applies-to Doc. No.");
                                VendUpdatePayment;
                            end;
                    end;
            end;
        }
        field(37; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(38; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            Editable = false;
            OptionCaption = 'Domestic,International';
            OptionMembers = Domestic,International;
        }
        field(39; "Code Payment Method"; Option)
        {
            Caption = 'Code Payment Method';
            InitValue = " ";
            OptionCaption = ' ,TLX,CDC,CDD,CHC,CHD,MAN,EUR';
            OptionMembers = " ",TLX,CDC,CDD,CHC,CHD,MAN,EUR;
        }
        field(40; "Code Expenses"; Option)
        {
            Caption = 'Code Expenses';
            InitValue = " ";
            OptionCaption = ' ,SHA,BEN,OUR';
            OptionMembers = " ",SHA,BEN,OUR;
        }
        field(45; "IBLC/BLWI Code"; Code[3])
        {
            Caption = 'IBLC/BLWI Code';
            Numeric = true;
            TableRelation = "IBLC/BLWI Transaction Code";
        }
        field(46; "IBLC/BLWI Justification"; Text[50])
        {
            Caption = 'IBLC/BLWI Justification';
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Paym. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(53; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = " ";
            OptionCaption = ' ,Marked,Processed,Posted';
            OptionMembers = " ",Marked,Processed,Posted;
        }
        field(54; Processing; Boolean)
        {
            Caption = 'Processing';
            Editable = false;
        }
        field(55; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
            InitValue = false;
        }
        field(60; "ISO Currency Code"; Code[3])
        {
            Caption = 'ISO Currency Code';
            Editable = false;
        }
        field(61; "Bank Account Country Code"; Code[10])
        {
            Caption = 'Bank Account Country Code';
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                if "Bank Account Country Code" = '' then
                    "Bank Acc. ISO Country Code" := Text005
                else
                    //BE_CODA
                    //IF Country.GET("Bank Account Country Code") THEN
                    //  "Bank Acc. ISO Country Code" := Country."ISO Country Code";
                    "Bank Acc. ISO Country Code" := "Bank Account Country Code";
                //BE_CODA//
                SetPaymentType;
            end;
        }
        field(62; "Bank Acc. ISO Country Code"; Code[2])
        {
            Caption = 'Bank Acc. ISO Country Code';
            Editable = false;
        }
        field(63; "Original Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Remaining Amount';
            Editable = false;
        }
        field(64; "Ledger Entry No."; Integer)
        {
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Account Type" = const(Vendor)) "Vendor Ledger Entry" where("Entry No." = field("Ledger Entry No."))
            else
            if ("Account Type" = const(Customer)) "Cust. Ledger Entry" where("Entry No." = field("Ledger Entry No."));
        }
        field(65; "Partial Payment"; Boolean)
        {
            Caption = 'Partial Payment';
        }
        field(66; "Separate Line"; Boolean)
        {
            Caption = 'Separate Line';

            trigger OnValidate()
            begin
                "Separate Line" :=
                  ("Standard Format Message" or "Partial Payment") and
                  (Amount > 0);
            end;
        }
    }

    keys
    {
        key(STG_Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(STG_Key2; "Account Type", "Account No.", "Currency Code", "Applies-to ID", "Separate Line", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(STG_Key3; "ISO Currency Code")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(STG_Key4; "Bank Account", "Beneficiary Bank Account No.", Status, "Account Type", "Account No.", "Currency Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //DYS FONCTION OBSOLET
        // DimMgt.DeleteJnlLineDim(Database::"Payment Journal Line",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0);
    end;

    trigger OnInsert()
    begin
        LockTable;
        PaymJnlTemplate.Get("Journal Template Name");
        "Source Code" := PaymJnlTemplate."Source Code";
        PaymJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        "Reason Code" := PaymJnlBatch."Reason Code";
        //DYS FONCTION OBSOLET
        // DimMgt.UpdateJnlLineDefaultDim(Database::"Payment Journal Line",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0,
        //   "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        if not Processing then
            if xRec.Status = Status::Posted then
                Error(Text000);
        Processing := (Status = Status::Processed);
    end;

    var
        Text000: label 'Payment has been posted, changes are not allowed.';
        Text001: label 'cannot be specified without %1.';
        Text002: label 'must have the same sign as %1.';
        Text003: label '%1 %2 is not a Customer Ledger Entry.';
        Text004: label '%1 %2 is not a Vendor Ledger Entry.';
        Text005: label 'BE';
        Text006: label 'BEF';
        Text007: label 'EUR';
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        PaymJnlTemplate: Record "Payment Journal Template";
        PaymJnlBatch: Record "Paym. Journal Batch";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustBankAcc: Record "Customer Bank Account";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendBankAcc: Record "Vendor Bank Account";
        //GL2024  JnlLineDim: Record 356;
        //GL2024  LedgEntryDim: Record 355;
        ApplyCustLedgEntries: Page "Apply Customer Entries";
        ApplyVendLedgEntries: Page "Apply Vendor Entries";
        LookupCustBankAcc: Page "Customer Bank Account List";
        LookupVendBankAcc: Page "Vendor Bank Account List";
        //GenJnlManagement: Codeunit 2000000;
        DimMgt: Codeunit 408;
        AccNo: Code[20];
        AccType: Option "G/L Account",Customer,Vendor;
        Text008: label 'ce document est déjà entièrement payé.';
        Text009: label 'Il y a déjà des paiements pour ce document.';
        Text010: label 'Il y a déjà une ligne de paiement pour ce document.';
        Text011: label 'Cette ligne de compte fournisseur a déjà été partiellement payée';
        Text012: label 'Cette ligne de compte client a déjà été partiellement payée.';
        GenerateEURPayments: Boolean;
        Text013: label 'There must be one %1 with %2 %3.';
        gPaymentMgt: Codeunit "Payment Management1";

    local procedure InitCompanyInformation()
    begin
        GLSetup.Get;
        GenerateEURPayments := true;
    end;


    procedure InitCurrencyCode()
    begin
        InitCompanyInformation;
        if "Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision;
            //BE_CODA
            //  Currency."ISO Currency Code" := GLSetup."LCY Code"
            Currency.Code := GLSetup."LCY Code"
            //BE_CODA//
        end else
            if "Currency Code" <> Currency.Code then begin
                Currency.Get("Currency Code");
                Currency.TestField("Amount Rounding Precision");
                //BE_CODA
                //    Currency.TESTFIELD("ISO Currency Code")
                //BE_CODA//
            end;
    end;


    procedure GetISOCurrencyCode(): Code[10]
    begin
        if "Currency Code" <> Currency.Code then
            InitCurrencyCode;
        //BE_CODA//
        //EXIT(Currency."ISO Currency Code");
        exit(Currency.Code);
        //BE_CODA//
    end;


    procedure VendUpdatePayment()
    var
        GenJournalLine: Record "Gen. Journal Line";
        PJLine: Record "Payment Journal Line";
        SourceCurrency: Record Currency;
        EURCurrency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        VendLedgEntry.TestField("On Hold", '');
        VendLedgEntry.CalcFields("Remaining Amount");

        InitCompanyInformation();

        if GenerateEURPayments then
            if GLSetup."LCY Code" = Text007 then begin  // Company in EUR
                if VendLedgEntry."Currency Code" <> '' then
                    SourceCurrency.Get(VendLedgEntry."Currency Code");
                if SourceCurrency."EMU Currency" then begin
                    VendLedgEntry.CalcFields("Remaining Amt. (LCY)");
                    VendLedgEntry."Remaining Amount" := VendLedgEntry."Remaining Amt. (LCY)";
                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", SourceCurrency.Code, VendLedgEntry."Remaining Pmt. Disc. Possible",
                          CurrExchRate.ExchangeRate("Posting Date", SourceCurrency.Code)));
                    VendLedgEntry."Currency Code" := '';
                end;
            end else begin  // Company in other currency
                            // test for existance of EUR as ISO currencycode
                            //BE_CODA
                            /*
                                EURCurrency.SETRANGE("ISO Currency Code",Text007);
                                IF EURCurrency.COUNT <> 1 THEN
                                  ERROR(
                                    Text013,PJLine.FIELDCAPTION("Currency Code"),
                                    Currency.FIELDCAPTION("ISO Currency Code"),Text007);
                                EURCurrency.FIND('-');
                            */
                EURCurrency.Get(Text007);
                //BE_CODA//

                if VendLedgEntry."Currency Code" = '' then
                    SourceCurrency."EMU Currency" := GLSetup."EMU Currency"
                else
                    if VendLedgEntry."Currency Code" <> EURCurrency.Code then
                        SourceCurrency.Get(VendLedgEntry."Currency Code");
                if SourceCurrency."EMU Currency" then begin
                    TestField("Posting Date");
                    VendLedgEntry."Remaining Amount" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToFCY(
                          "Posting Date", SourceCurrency.Code, EURCurrency.Code, VendLedgEntry."Remaining Amount"),
                         EURCurrency."Amount Rounding Precision");
                    VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToFCY(
                          "Posting Date", SourceCurrency.Code, EURCurrency.Code, VendLedgEntry."Remaining Pmt. Disc. Possible"),
                        EURCurrency."Amount Rounding Precision");
                    VendLedgEntry."Currency Code" := EURCurrency.Code;
                end;
            end;

        if (VendLedgEntry."Document Type" = VendLedgEntry."document type"::Invoice) and
           ("Pmt. Discount Date" <> 0D) and
           ("Pmt. Discount Date" <= VendLedgEntry."Pmt. Discount Date")
        then begin
            "Original Remaining Amount" := -VendLedgEntry."Remaining Amount";
            Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible");
            "Pmt. Disc. Possible" := -(VendLedgEntry."Remaining Pmt. Disc. Possible");
        end else begin
            "Original Remaining Amount" := -VendLedgEntry."Remaining Amount";
            Amount := -(VendLedgEntry."Remaining Amount");
            "Pmt. Disc. Possible" := 0;
        end;

        if CurrFieldNo = FieldNo("Applies-to Doc. No.") then begin
            if Amount = 0 then
                Message(Text008);

            if VendLedgEntry."Applies-to ID" <> '' then begin
                Message(Text009);
                Amount := 0;
            end;

            PJLine.Reset;
            PJLine.SetCurrentkey("Account Type", "Account No.");
            PJLine.SetRange("Account Type", PJLine."account type"::Vendor);
            PJLine.SetRange("Account No.", VendLedgEntry."Vendor No.");
            PJLine.SetRange("Applies-to Doc. Type", VendLedgEntry."Document Type");
            PJLine.SetRange("Applies-to Doc. No.", VendLedgEntry."Document No.");
            PJLine.SetFilter(Status, '<>%1', PJLine.Status::Posted);
            if PJLine.Find('-') then begin
                Amount := 0;
                Error(Text010);
            end;
        end;

        GenJournalLine.SetCurrentkey("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
        GenJournalLine.SetRange("Account Type", "account type"::Vendor);
        GenJournalLine.SetRange("Account No.", VendLedgEntry."Vendor No.");
        GenJournalLine.SetRange("Applies-to Doc. Type", VendLedgEntry."Document Type");
        GenJournalLine.SetRange("Applies-to Doc. No.", VendLedgEntry."Document No.");

        if GenJournalLine.Find('-') then begin
            if CurrFieldNo = FieldNo("Applies-to Doc. No.") then
                Message(Text011);
            repeat
                Amount := Amount - GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;

        Validate("Currency Code", VendLedgEntry."Currency Code");
        Validate(Amount);
        Validate("Pmt. Disc. Possible");

        if VendLedgEntry."External Document No." <> '' then
            "Payment Message" := VendLedgEntry."External Document No."
        else
            "Payment Message" := VendLedgEntry.Description;
        Validate("Payment Message");

        "External Document No." := VendLedgEntry."External Document No.";
        "Applies-to Doc. Type" := VendLedgEntry."Document Type";
        "Applies-to Doc. No." := VendLedgEntry."Document No.";
        "Applies-to ID" := '';

        /* GL2024   JnlLineDim.SetRange("Table ID", Database::"Payment Journal Line");
            JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
            JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
            JnlLineDim.SetRange("Journal Line No.", "Line No.");
            JnlLineDim.DeleteAll;*/

        /*  GL2024 LedgEntryDim.SetRange("Table ID", Database::"Vendor Ledger Entry");
           LedgEntryDim.SetRange("Entry No.", VendLedgEntry."Entry No.");
           DimMgt.MoveLedgEntryDimToJnlLineDim(
             LedgEntryDim, JnlLineDim, Database::"Payment Journal Line",
             "Journal Template Name", "Journal Batch Name", "Line No.", 0);*/

        "Ledger Entry No." := VendLedgEntry."Entry No."

    end;


    procedure CustUpdatePayment()
    var
        GenJournalLine: Record "Gen. Journal Line";
        PJLine: Record "Payment Journal Line";
        SourceCurrency: Record Currency;
        EURCurrency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        CustLedgEntry.TestField("On Hold", '');
        CustLedgEntry.CalcFields("Remaining Amount");

        InitCompanyInformation();

        if GenerateEURPayments then
            if GLSetup."LCY Code" = Text007 then begin  // Company in EUR
                if CustLedgEntry."Currency Code" <> '' then
                    SourceCurrency.Get(CustLedgEntry."Currency Code");
                if SourceCurrency."EMU Currency" then begin
                    CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                    CustLedgEntry."Remaining Amount" := CustLedgEntry."Remaining Amt. (LCY)";
                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", SourceCurrency.Code, CustLedgEntry."Remaining Pmt. Disc. Possible",
                          CurrExchRate.ExchangeRate("Posting Date", SourceCurrency.Code)));
                    CustLedgEntry."Currency Code" := '';
                end;
            end else begin  // Company in other currency
                            // test for existance of EUR as ISO currencycode
                            //BE_CODA
                            /*
                                EURCurrency.SETRANGE("ISO Currency Code",Text007);
                                IF EURCurrency.COUNT <> 1 THEN
                                  ERROR(
                                    Text013,PJLine.FIELDCAPTION("Currency Code"),
                                    Currency.FIELDCAPTION("ISO Currency Code"),Text007);
                                EURCurrency.FIND('-');
                            */
                EURCurrency.Get(Text007);
                //BE_CODA//

                if CustLedgEntry."Currency Code" = '' then
                    SourceCurrency."EMU Currency" := GLSetup."EMU Currency"
                else
                    if CustLedgEntry."Currency Code" <> EURCurrency.Code then
                        SourceCurrency.Get(CustLedgEntry."Currency Code");
                if SourceCurrency."EMU Currency" then begin
                    TestField("Posting Date");
                    CustLedgEntry."Remaining Amount" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToFCY(
                          "Posting Date", SourceCurrency.Code, EURCurrency.Code, CustLedgEntry."Remaining Amount"),
                         EURCurrency."Amount Rounding Precision");
                    CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtFCYToFCY(
                          "Posting Date", SourceCurrency.Code, EURCurrency.Code, CustLedgEntry."Remaining Pmt. Disc. Possible"),
                        EURCurrency."Amount Rounding Precision");
                    CustLedgEntry."Currency Code" := EURCurrency.Code;
                end;
            end;

        if (CustLedgEntry."Document Type" = CustLedgEntry."document type"::"Credit Memo") and
           ("Pmt. Discount Date" <> 0D) and
           ("Pmt. Discount Date" <= CustLedgEntry."Pmt. Discount Date")
        then begin
            "Original Remaining Amount" := -CustLedgEntry."Remaining Amount";
            Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible");
            "Pmt. Disc. Possible" := -(CustLedgEntry."Remaining Pmt. Disc. Possible");
        end else begin
            "Original Remaining Amount" := -CustLedgEntry."Remaining Amount";
            Amount := -CustLedgEntry."Remaining Amount";
            "Pmt. Disc. Possible" := 0;
        end;

        if CurrFieldNo = FieldNo("Applies-to Doc. No.") then begin
            if Amount = 0 then
                Message(Text008);
            if CustLedgEntry."Applies-to ID" <> '' then begin
                Message(Text009);
                Amount := 0;
            end;

            PJLine.Reset;
            PJLine.SetCurrentkey("Account Type", "Account No.");
            PJLine.SetRange("Account Type", PJLine."account type"::Customer);
            PJLine.SetRange("Account No.", CustLedgEntry."Customer No.");
            PJLine.SetRange("Applies-to Doc. Type", CustLedgEntry."Document Type");
            PJLine.SetRange("Applies-to Doc. No.", CustLedgEntry."Document No.");
            PJLine.SetFilter(Status, '<>%1', PJLine.Status::Posted);
            if PJLine.Find('-') then begin
                Amount := 0;
                Error(Text010);
            end;
        end;

        GenJournalLine.SetCurrentkey("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
        GenJournalLine.SetRange("Account Type", "account type"::Customer);
        GenJournalLine.SetRange("Account No.", CustLedgEntry."Customer No.");
        GenJournalLine.SetRange("Applies-to Doc. Type", CustLedgEntry."Document Type");
        GenJournalLine.SetRange("Applies-to Doc. No.", CustLedgEntry."Document No.");

        if GenJournalLine.Find('-') then begin
            if CurrFieldNo = FieldNo("Applies-to Doc. No.") then
                Message(Text012);
            repeat
                Amount := Amount - GenJournalLine.Amount;
            until GenJournalLine.Next = 0;
        end;


        Validate("Currency Code", CustLedgEntry."Currency Code");
        Validate(Amount);
        Validate("Pmt. Disc. Possible");

        "Payment Message" := CustLedgEntry."Document No.";
        "External Document No." := CustLedgEntry."Document No.";
        "Applies-to Doc. Type" := CustLedgEntry."Document Type";
        "Applies-to Doc. No." := CustLedgEntry."Document No.";
        "Applies-to ID" := '';

        /* GL2024   JnlLineDim.SetRange("Table ID", Database::"Payment Journal Line");
            JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
            JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
            JnlLineDim.SetRange("Journal Line No.", "Line No.");
            JnlLineDim.DeleteAll;*/

        /* GL2024 LedgEntryDim.SetRange("Table ID", Database::"Cust. Ledger Entry");
          LedgEntryDim.SetRange("Entry No.", CustLedgEntry."Entry No.");
          DimMgt.MoveLedgEntryDimToJnlLineDim(
            LedgEntryDim, JnlLineDim, Database::"Payment Journal Line",
            "Journal Template Name", "Journal Batch Name", "Line No.", 0);*/

        "Ledger Entry No." := CustLedgEntry."Entry No."

    end;


    procedure SetPaymentType()
    begin
        if (("ISO Currency Code" = Text006) or ("ISO Currency Code" = Text007))
          and ("Bank Acc. ISO Country Code" = Text005) then
            "Payment Type" := "payment type"::Domestic
        else
            "Payment Type" := "payment type"::International;
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //DYS A VERIFIER
        // DimMgt.GetDefaultDim(
        //   TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.UpdateJnlLineDefaultDim(
        //       Database::"Payment Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0,
        //       "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNo, ShortcutDimCode);
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.SaveJnlLineDim(
        //       Database::"Payment Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, FieldNo, ShortcutDimCode)
        // else
        //     DimMgt.SaveTempDim(FieldNo, ShortcutDimCode);
    end;


    procedure LookupShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNo, ShortcutDimCode);
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.SaveJnlLineDim(
        //       Database::"Payment Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, FieldNo, ShortcutDimCode)
        // else
        //     DimMgt.SaveTempDim(FieldNo, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.ShowJnlLineDim(
        //       Database::"Payment Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, ShortcutDimCode)
        // else
        //     DimMgt.ShowTempDim(ShortcutDimCode);
    end;
}

