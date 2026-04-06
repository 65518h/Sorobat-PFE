table 52048946 "Employee Ledger Entry2"
{
    //GL2024  ID dans Nav 2009 : "39001431"
    Caption = 'Employee Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Salaries';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Salaries;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                            "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                    "Entry Type" = FILTER("Initial Entry"),
                                                                                    "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                    "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Amount (LCY)" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                    "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'),
                                                                                    "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Purchase (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase (LCY)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(21; "Buy-from Employee No."; Code[20])
        {
            Caption = 'Buy-from Employee No.';
            TableRelation = Employee;
        }
        field(22; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Description = '30';
            TableRelation = "Employee Posting Group";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(25; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(27; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit 418;
            begin
                //GL2024   LoginMgt.LookupUserID("User ID");
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Salaries';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Salaries;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(37; "Due Date"; Date)
        {
            Caption = 'Due Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(39; "Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS(Amount, "Remaining Amount");
                IF "Pmt. Disc. Possible" * Amount < 0 THEN
                    FIELDERROR("Pmt. Disc. Possible", STRSUBSTNO(Text000, FIELDCAPTION(Amount)));
                IF ABS("Pmt. Disc. Possible") > ABS("Remaining Amount") THEN
                    FIELDERROR("Pmt. Disc. Possible", STRSUBSTNO(Text001, FIELDCAPTION("Remaining Amount")));
            end;
        }
        field(40; "Pmt. Disc. Rcd.(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Rcd.(LCY)';
        }
        field(43; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(44; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "Employee Ledger Entry";
        }
        field(45; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
        }
        field(46; "Closed by Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(52; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF ("Bal. Account Type" = CONST(Employee)) Employee;
        }
        field(53; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount (LCY)';
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Debit Amount" WHERE("Employee Ledger Entry No." = FIELD("Entry No."), "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'), "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Credit Amount" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                     "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'),
                                                                                     "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Debit Amount (LCY)" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                          "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'),
                                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Employee Ledg. Entry"."Credit Amount (LCY)" WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                                           "Entry Type" = FILTER('Initial Entry' | 'Unrealized Loss' | 'Unrealized Gain' | 'Realized Loss' | 'Realized Gain' | 'Payment Discount' | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)'),
                                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(63; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(65; "Closed by Currency Code"; Code[10])
        {
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(66; "Closed by Currency Amount"; Decimal)
        {
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0 : 5;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0 : 5;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Employee Ledg. Entry".Amount WHERE("Employee Ledger Entry No." = FIELD("Entry No."),
                                                                            "Entry Type" = FILTER("Initial Entry"),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; direction; Code[10])
        {
        }
        field(78; service; Code[10])
        {
        }
        field(79; section; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Employee No.", "Posting Date", "Currency Code")
        {
        }
        key(STG_Key3; "Document Type", "Document No.", "Employee No.")
        {
        }
        key(STG_Key4; "Document Type", "External Document No.", "Employee No.")
        {
        }
        key(STG_Key5; "Employee No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(STG_Key6; Open, "Due Date")
        {
        }
        key(STG_Key7; "Document Type", "Employee No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Purchase (LCY)", "Inv. Discount (LCY)";
        }
        key(STG_Key8; "Closed by Entry No.")
        {
        }
        key(STG_Key9; "Transaction No.")
        {
        }
        key(STG_Key10; "Source Code", "Posting Date", "Document No.")
        {
        }
        key(STG_Key11; "Source Code", "Document No.", "Posting Date")
        {
        }
        key(STG_Key12; "Employee No.", "Posting Date", "Source Code")
        {
        }
        key(STG_Key13; "Employee No.", "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'doit avoir le même signe que %1';
        Text001: Label 'ne doit pas être supérieur(e) à %1';
        DimMgt: Codeunit 408;

    procedure DrillDownOnEntries(var DtldEmplLedgEntry: Record "Detailed Employee Ledg. Entry")
    var
        EmplLedgEntry: Record "Employee Ledger Entry";
    begin
        EmplLedgEntry.RESET;
        DtldEmplLedgEntry.COPYFILTER("Employee No.", EmplLedgEntry."Employee No.");
        DtldEmplLedgEntry.COPYFILTER("Currency Code", EmplLedgEntry."Currency Code");
        DtldEmplLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", EmplLedgEntry."Global Dimension 1 Code");
        DtldEmplLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", EmplLedgEntry."Global Dimension 2 Code");
        EmplLedgEntry.SETCURRENTKEY("Employee No.", "Posting Date");
        page.RUN(0, EmplLedgEntry);
    end;
}

