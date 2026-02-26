Table 2000022 "Domiciliation Journal Line"
{
    // //BE_CODA CW 09/10/04 Currenncy and Country must be ISO

    Caption = 'Domiciliation Journal Line';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Domiciliation Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                if "Customer No." = '' then begin
                    CreateDim(
                      Database::Customer, "Customer No.",
                      Database::"Bank Account", "Bank Account No.");
                    exit;
                end;
                Cust.Get("Customer No.");

                // test on customer
                InitCompanyInformation;
                //DYS FONCTION OBSOLET
                // if not GenJnlManagement.CheckDomiciliationNo(Cust."Domiciliation No.") then
                //     Error(Text001, Cust.FieldCaption("Domiciliation No."));
                if "Applies-to Doc. Type" = 0 then
                    "Applies-to Doc. Type" := "applies-to doc. type"::Invoice;

                if "Customer No." <> xRec."Customer No." then begin
                    xRec."Customer No." := "Customer No.";
                    xRec."Posting Date" := "Posting Date";
                    xRec.Amount := Amount;
                    xRec."Bank Account No." := "Bank Account No.";
                    Init;
                    "Customer No." := xRec."Customer No.";
                    Validate("Posting Date", xRec."Posting Date");
                    Amount := xRec.Amount;
                    "Bank Account No." := xRec."Bank Account No.";
                end;

                CreateDim(
                  Database::Customer, "Customer No.",
                  Database::"Bank Account", "Bank Account No.");
            end;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                if ("Pmt. Discount Date" = 0D)
                or ("Pmt. Discount Date" = xRec."Posting Date") then
                    "Pmt. Discount Date" := "Posting Date";
            end;
        }
        field(5; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                GetCurrencyCode;
                Amount := ROUND(Amount, Currency."Amount Rounding Precision");

                if "Currency Code" = '' then
                    "Amount (LCY)" := Amount
                else
                    "Amount (LCY)" := ROUND(
                      CurrencyExchRate.ExchangeAmtFCYToLCY(
                        "Posting Date", "Currency Code",
                        Amount, "Currency Factor"));
            end;
        }
        field(6; "Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                if "Pmt. Disc. Possible" * Amount < 0 then
                    FieldError("Pmt. Disc. Possible", StrSubstNo(Text004, FieldCaption(Amount)));

                if CurrFieldNo = FieldNo("Pmt. Disc. Possible") then begin
                    Validate(Amount, Amount + xRec."Pmt. Disc. Possible" - Rec."Pmt. Disc. Possible");
                    "Pmt. Discount possible (LCY)" := "Pmt. Disc. Possible";
                end;
            end;
        }
        field(7; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(8; "Message 1"; Text[15])
        {
            Caption = 'Message 1';
        }
        field(9; "Message 2"; Text[15])
        {
            Caption = 'Message 2';
        }
        field(10; Reference; Text[12])
        {
            Caption = 'Reference';
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                GetCurrencyCode;
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
                //BE_CODA
                //"ISO Currency Code" := Currency."ISO Currency Code";
                "ISO Currency Code" := Currency.Code;
                //BE_DOCA//
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
                    FieldError("Currency Factor", StrSubstNo(Text002, FieldCaption("Currency Code")));
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
        field(17; "Pmt. Discount possible (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Discount possible (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                if "Currency Code" = '' then begin
                    "Pmt. Disc. Possible" := "Pmt. Discount possible (LCY)";
                    Validate("Pmt. Disc. Possible");
                end else begin
                    TestField("Currency Factor");
                    Validate("Pmt. Disc. Possible", ("Pmt. Discount possible (LCY)" / "Currency Factor"));
                end;
            end;
        }
        field(22; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Bank Account No." = '' then
                    Status := Status::" "
                else
                    Status := Status::Marked;

                CreateDim(
                  Database::"Bank Account", "Bank Account No.",
                  Database::Customer, "Customer No.");
            end;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value" where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value" where("Global Dimension No." = const(2));

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
                AccNo := "Customer No.";

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
                ApplyCustLedgEntries.SetTableview(CustLedgEntry);
                ApplyCustLedgEntries.SetRecord(CustLedgEntry);
                ApplyCustLedgEntries.LookupMode(true);
                if ApplyCustLedgEntries.RunModal = Action::LookupOK then begin
                    ApplyCustLedgEntries.GetRecord(CustLedgEntry);
                    CustUpdatePayment;
                end;
                Clear(ApplyCustLedgEntries);
            end;

            trigger OnValidate()
            begin
                // Empty Applies-to Doc for payment without invoice
                if "Applies-to Doc. No." <> '' then begin
                    CustLedgEntry.SetCurrentkey("Document No.", "Document Type", "Customer No.");
                    CustLedgEntry.SetRange("Document Type", "Applies-to Doc. Type");
                    CustLedgEntry.SetRange("Document No.", "Applies-to Doc. No.");
                    CustLedgEntry.SetRange("Customer No.", "Customer No.");
                    if not CustLedgEntry.Find('-') then
                        Error(Text003, "Applies-to Doc. Type", "Applies-to Doc. No.");
                    CustUpdatePayment;
                end;
            end;
        }
        field(51; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Domiciliation Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
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
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key2; "Customer No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key3; "Bank Account No.", "Customer No.", "Posting Date")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //DYS FONCTION OBSOLET
        // DimMgt.DeleteJnlLineDim(Database::"Domiciliation Journal Line",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0);
    end;

    trigger OnInsert()
    begin
        LockTable;
        DomJnlTemplate.Get("Journal Template Name");
        "Source Code" := DomJnlTemplate."Source Code";
        DomJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        "Reason Code" := DomJnlBatch."Reason Code";
        //DYS FONCTION OBSOLET
        // DimMgt.UpdateJnlLineDefaultDim(Database::"Domiciliation Journal Line",
        //   "Journal Template Name", "Journal Batch Name", "Line No.", 0,
        //   "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        if not Processing then
            if Status = Status::Posted then
                Error(Text000);
        Processing := (Status = Status::Processed);
    end;

    var
        Text000: label 'Payment has been posted, changes are not allowed.';
        Text001: label 'There is no valid %1 for the Customer.';
        Text002: label 'cannot be specified without %1.';
        Text003: label '%1 %2 is not a Customer Ledger Entry.';
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Currency: Record Currency;
        DomJnlTemplate: Record "Domiciliation Journal Template";
        DomJnlBatch: Record "Domiciliation Journal Batch";
        CustLedgEntry: Record "Cust. Ledger Entry";
        CurrencyExchRate: Record "Currency Exchange Rate";
        //GL2024  JnlLineDim: Record 356;
        //GL2024  LedgEntryDim: Record 355;
        ApplyCustLedgEntries: Page "Apply Customer Entries";
        //GenJnlManagement: Codeunit 2000020;
        DimMgt: Codeunit 408;
        AccNo: Code[20];
        Text004: label 'must have the same sign as %1.';

    local procedure InitCompanyInformation()
    begin
        GLSetup.Get;
    end;


    procedure CustUpdatePayment()
    begin
        CustLedgEntry.TestField("On Hold", '');
        CustLedgEntry.TestField(Open);
        CustLedgEntry.CalcFields("Remaining Amount");
        if ("Pmt. Discount Date" <> 0D)
        and ("Pmt. Discount Date" <= CustLedgEntry."Pmt. Discount Date") then begin
            Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible");
            "Pmt. Disc. Possible" := -(CustLedgEntry."Remaining Pmt. Disc. Possible");
        end else begin
            Amount := -CustLedgEntry."Remaining Amount";
            "Pmt. Disc. Possible" := 0;
        end;
        Validate("Currency Code", CustLedgEntry."Currency Code");
        Validate(Amount);
        Validate("Pmt. Disc. Possible");

        "Applies-to Doc. Type" := CustLedgEntry."Document Type";
        "Applies-to Doc. No." := CustLedgEntry."Document No.";
        "Message 1" := CustLedgEntry."Document No.";
        "Message 2" := CopyStr(CustLedgEntry.Description, 1, MaxStrLen("Message 2"));
        //DYS
        //  Reference := GenJnlManagement.CreateReference(CustLedgEntry);

        /* GL2024   JnlLineDim.SetRange("Table ID", Database::"Domiciliation Journal Line");
            JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
            JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
            JnlLineDim.SetRange("Journal Line No.", "Line No.");
            JnlLineDim.DeleteAll;*/

        /*GL2024  LedgEntryDim.SetRange("Table ID", Database::"Cust. Ledger Entry");
          LedgEntryDim.SetRange("Entry No.", CustLedgEntry."Entry No.");
        DimMgt.MoveLedgEntryDimToJnlLineDim(
          LedgEntryDim, JnlLineDim, Database::"Domiciliation Journal Line",
          "Journal Template Name", "Journal Batch Name", "Line No.", 0);*/
    end;


    procedure GetCurrencyCode()
    begin
        InitCompanyInformation;
        if "Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision;
            //BE_CODA
            //  Currency."ISO Currency Code" := GLSetup."LCY Code"
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
        //       Database::"Domiciliation Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0,
        //       "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;


    procedure ValidateShortcutDimCode(FieldNo: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNo, ShortcutDimCode);
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.SaveJnlLineDim(
        //       Database::"Domiciliation Journal Line", "Journal Template Name",
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
        //       Database::"Domiciliation Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, FieldNo, ShortcutDimCode)
        // else
        //     DimMgt.SaveTempDim(FieldNo, ShortcutDimCode);
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        //DYS FONCTION OBSOLET
        // if "Line No." <> 0 then
        //     DimMgt.ShowJnlLineDim(
        //       Database::"Domiciliation Journal Line", "Journal Template Name",
        //       "Journal Batch Name", "Line No.", 0, ShortcutDimCode)
        // else
        //     DimMgt.ShowTempDim(ShortcutDimCode);
    end;
}

