TableExtension 50079 "Vendor Bank AccountEXT" extends "Vendor Bank Account"
{
    fields
    {

        field(11580; "Payment Fee Code"; Option)
        {
            Caption = 'Payment Fee Code';
            InitValue = " ";
            OptionCaption = ' ,Own,Beneficiary,Share';
            OptionMembers = " ",Own,Beneficiary,Share;
        }
        field(50001; AGENCE; Text[30])
        {
            Caption = 'Agency Code';
            InitValue = '00000';

            trigger OnValidate()
            begin
                if StrLen(AGENCE) < 5 then
                    AGENCE := PadStr('', 5 - StrLen(AGENCE), '0') + AGENCE;
                "RIB Checked" := RIBKey.Check("Bank Branch No.", AGENCE, "Bank Account No.", "RIB Key");
            end;
        }
        field(50002; "RIB Key1"; Integer)
        {
            Caption = 'RIB Key';

            trigger OnValidate()
            begin
                "RIB Checked" := RIBKey.Check("Bank Branch No.", AGENCE, "Bank Account No.", "RIB Key");
            end;
        }
        field(50003; "RIB Checked1"; Boolean)
        {
            Caption = 'RIB Checked';
            Editable = false;
        }
        field(50004; RIB; Code[25])
        {
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(3010541; "Clearing No."; Code[10])
        {
            Caption = 'Clearing No.';
            //  TableRelation = "Bank Directory";

            trigger OnValidate()
            begin
                /* if "Clearing No." <> '' then begin
                     if "Payment Form" <> "payment form"::"Bank Payment Domestic" then
                         Error(Text000);
                     BankDirectory.Get("Clearing No.");
                     Name := BankDirectory.Name;
                     Address := BankDirectory.Address;
                     "Address 2" := BankDirectory."Address 2";
                     "Post Code" := BankDirectory."Post Code";
                     City := BankDirectory.City;
                 end;*/
            end;
        }
        field(3010542; "Payment Form"; Option)
        {
            Caption = 'Payment Form';
            InitValue = ESR;
            OptionCaption = 'ESR,ESR+,Post Payment Domestic,Bank Payment Domestic,Cash Outpayment Order Domestic,Post Payment Abroad,Bank Payment Abroad,SWIFT Payment Abroad,Cash Outpayment Order Abroad';
            OptionMembers = ESR,"ESR+","Post Payment Domestic","Bank Payment Domestic","Cash Outpayment Order Domestic","Post Payment Abroad","Bank Payment Abroad","SWIFT Payment Abroad","Cash Outpayment Order Abroad";

            trigger OnValidate()
            begin
                if "Payment Form" <> xRec."Payment Form" then begin
                    xPmtType := "Payment Form";  // Store
                    Init;
                    "Payment Form" := xPmtType;  // Get
                end;
            end;
        }
        field(3010543; "ESR Type"; Option)
        {
            Caption = 'ESR Type';
            InitValue = " ";
            OptionCaption = ' ,5/15,9/27,9/16';
            OptionMembers = " ","5/15","9/27","9/16";

            trigger OnValidate()
            begin
                if "ESR Type" <> xRec."ESR Type" then begin
                    xPmtType := "Payment Form";  // Store
                    xEsrType := "ESR Type";
                    xBalAccount := "Balance Account No.";
                    xDebitBank := "Debit Bank";
                    Init;
                    "Payment Form" := xPmtType;  // Get
                    "ESR Type" := xEsrType;
                    "Balance Account No." := xBalAccount;
                    "Debit Bank" := xDebitBank;
                end;
            end;
        }
        field(3010544; "Giro Account No."; Code[11])
        {
            Caption = 'Giro Account No.';

            trigger OnValidate()
            begin
                if "Giro Account No." = '' then
                    exit;

                if "Payment Form" <> "payment form"::"Post Payment Domestic" then  // EZ Post
                    Error(Text002);

                // Check and expand
                //"Giro Account No." := BankMgt.CheckPostAccountNo("Giro Account No.");
            end;
        }
        field(3010545; "ESR Account No."; Code[11])
        {
            Caption = 'ESR Account No.';

            trigger OnValidate()
            begin
                /*IF "ESR Account No." = '' THEN
                  EXIT;
                
                IF "Payment Form" > 1 THEN  // <> ESR, ESR+
                  ERROR(Text003);
                
                IF "ESR Type" = 0 THEN
                  ERROR(Text004);
                
                // CHeck and expand
                IF "ESR Type" IN ["ESR Type"::"9/27","ESR Type"::"9/16"] THEN
                  "ESR Account No." := BankMgt.CheckPostAccountNo("ESR Account No.");
                
                IF "ESR Type" = "ESR Type"::"5/15" THEN BEGIN
                  IF STRLEN("ESR Account No.") <> 5 THEN
                    ERROR(Text005);
                  IF COPYSTR("ESR Account No.",5,1) <> BankMgt.CalcCheckDigit(COPYSTR("ESR Account No.",1,4)) THEN
                    ERROR(Text006);
                END;   */

            end;
        }
        field(3010546; "Bank Identifier Code"; Code[21])
        {
            Caption = 'Bank Identifier Code';
        }
        field(3010547; "Balance Account No."; Code[20])
        {
            Caption = 'Balance Account No.';
            TableRelation = "G/L Account";
        }
        field(3010548; "Invoice No. Startposition"; Integer)
        {
            //blankzero = true;
            Caption = 'Invoice No. Startposition';
            MaxValue = 26;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Invoice No. Startposition" > 0) and ("Payment Form" > 1) then
                    Error(Text008);
            end;
        }
        field(3010549; "Invoice No. Length"; Integer)
        {
            //blankzero = true;
            Caption = 'Invoice No. Length';
            MaxValue = 26;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Invoice No. Length" > 0) and ("Payment Form" > 1) then
                    Error(Text009);
            end;
        }
        field(3010550; "Debit Bank"; Code[10])
        {
            Caption = 'Debit Bank';
            TableRelation = "DTA Setup";
        }
        field(8004100; "Default Bank Account"; Boolean)
        {
            Caption = 'Default Account';

            trigger OnValidate()
            var
                lVendorBankAccount: Record "Vendor Bank Account";
            begin
                //+PMT+
                if "Default Bank Account" then begin
                    lVendorBankAccount.SetRange("Vendor No.", "Vendor No.");
                    lVendorBankAccount.SetRange("Default Bank Account", true);
                    if lVendorBankAccount.FindFirst then begin
                        lVendorBankAccount."Default Bank Account" := false;
                        lVendorBankAccount.Modify;
                    end;
                end;
                //+PMT+//
            end;
        }
    }
    keys
    {
        key(Key2; "ESR Account No.")
        {
        }
    }


    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        Text000: label 'The Clearing No is only used with Payment Type EZ Bank.';
        Text002: label 'The Post Account is only used with domestic post remittance.';
        Text003: label 'The ESR Account is only used with ESR and ESR+.';
        Text004: label 'When using an ESR-Account, the ESR-Type must be defined previously.';
        Text005: label 'The ESR Account for ESR 5/15 must have 5 digits.';
        Text006: label 'The Checksum for this ESR Account is incorrect.';
        Text008: label 'The Starting Position of the Invoice is only used for ESR and ESR+.';
        Text009: label 'The Length of the Invoice is only used for ESR and ESR+.';
        //    BankDirectory: Record "Bank Directory";
        xPmtType: Integer;
        xEsrType: Integer;
        xBalAccount: Code[20];
        xDebitBank: Code[10];
        RIBKey: Codeunit "RIB Key";
}

