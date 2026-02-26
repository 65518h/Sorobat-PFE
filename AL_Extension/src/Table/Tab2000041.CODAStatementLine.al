Table 2000041 "CODA Statement Line"
{
    Caption = 'CODA Statement Line';
    //DrillDownPageID = 2000043;
    PasteIsValid = false;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            TableRelation = "CODA Statement"."Statement No." where("Bank Account No." = field("Bank Account No."));
        }
        field(3; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(4; ID; Option)
        {
            Caption = 'ID';
            Editable = false;
            OptionCaption = ',,Movement,Information,Free Message';
            OptionMembers = ,,Movement,Information,"Free Message";
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Global,Detail';
            OptionMembers = Global,Detail;
        }
        field(6; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(9; "Bank Reference No."; Text[13])
        {
            Caption = 'Bank Reference No.';
            Editable = false;
        }
        field(10; "Ext. Reference No."; Text[8])
        {
            Caption = 'Ext. Reference No.';
            Editable = false;
        }
        field(11; "Statement Amount"; Decimal)
        {
            Caption = 'Statement Amount';
            Editable = false;
        }
        field(12; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            Editable = false;
        }
        field(13; "Transaction Type"; Integer)
        {
            Caption = 'Transaction Type';
            Editable = false;
        }
        field(14; "Transaction Family"; Integer)
        {
            Caption = 'Transaction Family';
            Editable = false;
        }
        field(15; Transaction; Integer)
        {
            Caption = 'Transaction';
            Editable = false;
        }
        field(16; "Transaction Category"; Integer)
        {
            Caption = 'Transaction Category';
            Editable = false;
        }
        field(17; "Message Type"; Option)
        {
            Caption = 'Message Type';
            Editable = false;
            OptionCaption = 'Non standard format,Standard format';
            OptionMembers = "Non standard format","Standard format";
        }
        field(18; "Type Standard Format Message"; Integer)
        {
            Caption = 'Type Standard Format Message';
            Editable = false;
        }
        field(19; "Statement Message"; Text[250])
        {
            Caption = 'Statement Message';
            Editable = false;
        }
        field(20; "Statement Message (cont.)"; Text[250])
        {
            Caption = 'Statement Message (cont.)';
            Editable = false;
        }
        field(21; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(22; "Globalisation Code"; Integer)
        {
            Caption = 'Globalisation Code';
            Editable = false;
            MaxValue = 9;
            MinValue = 0;
        }
        field(23; "Customer Reference"; Text[26])
        {
            Caption = 'Customer Reference';
            Editable = false;
        }
        field(24; "Bank Account No. Other Party"; Text[12])
        {
            Caption = 'Bank Account No. Other Party';
            Editable = false;
        }
        field(25; "Internal Codes Other Party"; Text[10])
        {
            Caption = 'Internal Codes Other Party';
            Editable = false;
        }
        field(26; "Ext. Acc. No. Other Party"; Text[15])
        {
            Caption = 'Ext. Acc. No. Other Party';
            Editable = false;
        }
        field(27; "Name Other Party"; Text[26])
        {
            Caption = 'Name Other Party';
            Editable = false;
        }
        field(28; "Address Other Party"; Text[26])
        {
            Caption = 'Address Other Party';
            Editable = false;
        }
        field(29; "City Other Party"; Text[26])
        {
            Caption = 'City Other Party';
            Editable = false;
        }
        field(30; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
        }
        field(31; Information; Integer)
        {
            BlankNumbers = BlankZeroAndPos;
            //blankzero = true;
            CalcFormula = count("CODA Statement Line" where("Bank Account No." = field("Bank Account No."),
                                                             "Statement No." = field("Statement No."),
                                                             ID = const("Free Message"),
                                                             "Attached to Line No." = field("Statement Line No.")));
            Caption = 'Information';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(38; "Application Information"; Text[50])
        {
            Caption = 'Application Information';
        }
        field(39; "Application Status"; Option)
        {
            Caption = 'Application Status';
            OptionCaption = ' ,Partly applied,Applied,Indirectly applied';
            OptionMembers = " ","Partly applied",Applied,"Indirectly applied";
        }
        field(40; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" <> xRec."Account Type" then
                    if xRec."Account No." <> '' then
                        Validate("Account No.", '')
            end;
        }
        field(41; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account No." = '' then begin
                    Validate("Account Name", '');
                    UpdateStatus;
                    exit;
                end;

                if ("System-Created Entry" and ("Application Status" in ["application status"::Applied, "application status"::
                "Indirectly applied"
                 ]))
                or (not "System-Created Entry" and ("Application Status" = "application status"::"Indirectly applied")) then
                    Error(Text001,
                      FieldCaption("Application Status"), TableCaption, "Application Status");

                "System-Created Entry" := false;


                case "Account Type" of
                    "account type"::"G/L Account":
                        begin
                            GLAcc.Get("Account No.");
                            Validate("Account Name", GLAcc.Name);
                        end;
                    "account type"::Customer:
                        begin
                            Cust.Get("Account No.");
                            Validate("Account Name", Cust.Name);
                        end;
                    "account type"::Vendor:
                        begin
                            Vend.Get("Account No.");
                            Validate("Account Name", Vend.Name);
                        end
                end;
                UpdateStatus
            end;
        }
        field(42; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(43; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(44; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Amount (LCY)" := Amount
                else
                    "Amount (LCY)" := ROUND(Amount * "Currency Factor" / 100)
            end;
        }
        field(45; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(46; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(47; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;
        }
        field(48; "Unapplied Amount"; Decimal)
        {
            Caption = 'Unapplied Amount';
            Editable = false;

            trigger OnValidate()
            begin
                UpdateStatus
            end;
        }
        field(49; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(50; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            Editable = false;
            TableRelation = "Gen. Journal Template";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            Editable = false;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(52; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(53; "Account Name"; Text[50])
        {
            Caption = 'Account Name';

            trigger OnValidate()
            begin
                if Description = '' then
                    Description := "Account Name"
                else
                    if Description = xRec."Account Name" then
                        Description := ''
            end;
        }
        field(60; "Original Transaction Currency"; Code[3])
        {
            Caption = 'Original Transaction Currency';
            Editable = false;
        }
        field(61; "Original Transaction Amount"; Decimal)
        {
            AutoFormatExpression = "Original Transaction Currency";
            AutoFormatType = 1;
            Caption = 'Original Transaction Amount';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Bank Account No.", "Statement No.", "Statement Line No.")
        {
            Clustered = true;
            SumIndexFields = "Statement Amount";
        }
        key(Key2; "Bank Account No.", "Statement No.", "Attached to Line No.")
        {
        }
        key(Key3; "Bank Account No.", "Statement No.", ID, "Attached to Line No.", Type)
        {
            SumIndexFields = "Statement Amount";
        }
        key(Key4; "Bank Account No.", "Statement No.", "Application Status")
        {
            SumIndexFields = "Unapplied Amount", Amount, "Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You cannot rename a %1.';
        Text001: label '%1 in %2 cannot be %3.';
        Text002: label '%1 in %2 %3 %4 cannot be %5.';
        CodBankStmt: Record "CODA Statement";
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;


    procedure UpdateStatus()
    var
        CodBankStmtLine: Record "CODA Statement Line";
        CodBankStmtLine2: Record "CODA Statement Line";
        StatusCount: array[4] of Integer;
    begin
        if "Account No." = '' then begin
            "Application Status" := "application status"::" ";
            Validate(Amount, 0);
            "Unapplied Amount" := "Statement Amount"
        end else
            if "System-Created Entry" = false then begin
                "Application Status" := "application status"::Applied;
                Validate(Amount, "Statement Amount");
                "Unapplied Amount" := 0
            end;

        // Lines with global info and details
        if Type = Type::Global then begin
            // Modify all details
            CodBankStmtLine.Reset;
            CodBankStmtLine.SetRange("Bank Account No.", "Bank Account No.");
            CodBankStmtLine.SetRange("Statement No.", "Statement No.");
            CodBankStmtLine.SetRange(ID, ID);
            CodBankStmtLine.SetRange("Attached to Line No.", "Statement Line No.");
            if CodBankStmtLine.Find('-') then
                repeat
                    // If partially applied, then first undo
                    if CodBankStmtLine."System-Created Entry"
                    and (CodBankStmtLine."Application Status" <> "application status"::" ") then
                        Error(Text002,
                          FieldCaption("Application Status"), TableCaption,
                          CodBankStmtLine.Type, CodBankStmtLine."Document No.",
                          CodBankStmtLine."Application Status");
                    if "Application Status" = "application status"::" " then begin
                        CodBankStmtLine."Application Status" := "application status"::" ";
                        CodBankStmtLine.Validate(Amount, 0);
                        CodBankStmtLine."Unapplied Amount" := CodBankStmtLine."Statement Amount";
                    end else begin
                        CodBankStmtLine."Unapplied Amount" := 0;
                        CodBankStmtLine."Application Status" := "application status"::"Indirectly applied";
                    end;
                    CodBankStmtLine."System-Created Entry" := false;
                    CodBankStmtLine.Modify
                until CodBankStmtLine.Next = 0
        end else begin
            Modify;

            // Retrieve global info
            CodBankStmtLine.Reset;
            CodBankStmtLine.Get("Bank Account No.", "Statement No.", "Attached to Line No.");
            CodBankStmtLine.Validate(Amount, 0);
            CodBankStmtLine."Unapplied Amount" := CodBankStmtLine."Statement Amount";

            // Run through details
            Clear(StatusCount);
            CodBankStmtLine2.Reset;
            CodBankStmtLine2.SetCurrentkey("Bank Account No.", "Statement No.", ID, "Attached to Line No.");
            CodBankStmtLine2.SetRange("Bank Account No.", CodBankStmtLine."Bank Account No.");
            CodBankStmtLine2.SetRange("Statement No.", CodBankStmtLine."Statement No.");
            CodBankStmtLine2.SetRange(ID, CodBankStmtLine.ID);
            CodBankStmtLine2.SetRange("Attached to Line No.", CodBankStmtLine."Statement Line No.");
            if CodBankStmtLine2.Find('-') then
                repeat
                    if CodBankStmtLine2."Application Status" = "application status"::Applied then begin
                        CodBankStmtLine."Unapplied Amount" :=
                          CodBankStmtLine."Unapplied Amount" - CodBankStmtLine2.Amount;
                    end;
                    StatusCount[CodBankStmtLine2."Application Status" + 1] :=
                      StatusCount[CodBankStmtLine2."Application Status" + 1] + 1
                until CodBankStmtLine2.Next = 0;

            // Update status of global info using detail status info
            if (StatusCount["application status"::" " + 1] > 0) then begin
                if (StatusCount["application status"::Applied + 1] = 0) then
                    CodBankStmtLine."Application Status" := "application status"::" "
                else
                    CodBankStmtLine."Application Status" := "application status"::"Partly applied"
            end else
                CodBankStmtLine."Application Status" := "application status"::"Indirectly applied";
            CodBankStmtLine.Modify;
        end
    end;
}

