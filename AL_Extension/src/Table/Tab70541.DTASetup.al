Table 70541 "DTA Setup"
{
    //GL2024  ID dans Nav 2009 : "3010541"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="DT"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Electronic Payment System (DTA)</add>
    //   <change id="CH2310" dev="SRYSER" date="2005-10-26" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.02"  request="11872">
    //     Added 2 BLOB Fields for EZAG Post Logo and EZAG Bar Code</change>
    //   <change id="CH2312" dev="SRYSER" date="2005-10-26" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.02" request="12148">
    //     Field 90 renamed to File Format</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="DT"
    //     baseversion="CH4.00.02" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>

    Caption = 'DTA Setup';
    //LookupPageID = 3010542;

    fields
    {
        field(1; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
            NotBlank = true;
        }
        field(2; "DTA/EZAG"; Option)
        {
            Caption = 'DTA/EZAG';
            OptionCaption = 'DTA,EZAG';
            OptionMembers = DTA,EZAG;
        }
        field(8; "DTA Main Bank"; Boolean)
        {
            Caption = 'DTA Main Bank';

            trigger OnValidate()
            begin
                // Only one Main Bank possible
                if "DTA Main Bank" then begin
                    SetRange("DTA Main Bank", true);
                    ModifyAll("DTA Main Bank", false);
                    SetRange("DTA Main Bank");
                end;
            end;
        }
        field(10; "DTA File Folder"; Text[50])
        {
            Caption = 'DTA File Folder';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                //  GeneralMgt.CheckFolderName("DTA File Folder");
            end;
        }
        field(11; "DTA Filename"; Text[20])
        {
            Caption = 'DTA Filename';
        }
        field(20; "DTA Customer ID"; Code[10])
        {
            Caption = 'DTA Customer ID';
        }
        field(21; "DTA Sender ID"; Code[10])
        {
            Caption = 'DTA Sender ID';
        }
        field(22; "DTA Sender Clearing"; Code[5])
        {
            Caption = 'DTA Sender Clearing';
            // TableRelation = "Bank Directory";

            trigger OnValidate()
            begin
                /*  if "DTA Sender Clearing" <> xRec."DTA Sender Clearing" then begin
                      BankDirectory.Get("DTA Sender Clearing");
                      "DTA Bank Name" := BankDirectory.Name;
                      "DTA Bank Address" := BankDirectory.Address;
                      "DTA Bank Address 2" := BankDirectory."Address 2";
                      "DTA Bank Post Code" := BankDirectory."Post Code";
                      "DTA Bank City" := BankDirectory.City;
                  end;*/
            end;
        }
        field(23; "DTA Debit Acc. No."; Code[24])
        {
            Caption = 'DTA Debit Acc. No.';
        }
        field(24; "DTA Sender Name"; Text[24])
        {
            Caption = 'DTA Sender Name';
        }
        field(25; "DTA Sender Name 2"; Text[24])
        {
            Caption = 'DTA Sender Name 2';
        }
        field(26; "DTA Sender Address"; Text[24])
        {
            Caption = 'DTA Sender Address';
        }
        field(27; "DTA Sender City"; Text[20])
        {
            Caption = 'DTA Sender City';
        }
        field(28; "DTA Sender Post Code"; Code[4])
        {
            Caption = 'DTA Sender Post Code';

            trigger OnValidate()
            begin
                if ZipCode.Get("DTA Sender Post Code") then
                    "DTA Sender City" := ZipCode.City;
            end;
        }
        field(29; "DTA Sender IBAN"; Code[50])
        {
            Caption = 'DTA Sender IBAN';

            trigger OnValidate()
            begin
                CompanyInfo.CheckIBAN("DTA Sender IBAN");
            end;
        }
        field(30; "EZAG File Folder"; Text[50])
        {
            Caption = 'EZAG File Folder';
            InitValue = 'A:\';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                // GeneralMgt.CheckFolderName("EZAG File Folder");
            end;
        }
        field(31; "EZAG Filename"; Text[20])
        {
            Caption = 'EZAG Filename';
            InitValue = 'PTTCRIA';
        }
        field(32; "EZAG Debit Account No."; Code[11])
        {
            Caption = 'EZAG Debit Account No.';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                // "EZAG Debit Account No." := BankMgt.CheckPostAccountNo("EZAG Debit Account No.");
            end;
        }
        field(33; "EZAG Charges Account No."; Code[11])
        {
            Caption = 'EZAG Charges Account No.';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                // "EZAG Charges Account No." := BankMgt.CheckPostAccountNo("EZAG Charges Account No.");
            end;
        }
        field(34; "Last EZAG Order No."; Code[2])
        {
            Caption = 'Last EZAG Order No.';
            CharAllowed = '09';
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                if StrLen("Last EZAG Order No.") < 2 then
                    Error(Text001, FieldCaption("Last EZAG Order No."));
            end;
        }
        field(35; "EZAG Media ID"; Code[10])
        {
            Caption = 'EZAG Media ID';
        }
        field(38; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,,,Bank Account';
            OptionMembers = "G/L Account",,,"Bank Account";

            trigger OnValidate()
            begin
                if "Bal. Account Type" <> xRec."Bal. Account Type" then
                    "Bal. Account No." := '';
            end;
        }
        field(40; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(41; "Credit Limit"; Decimal)
        {
            Caption = 'Credit Limit';
            MinValue = 0;
        }
        field(42; "DTA Currency Code"; Code[10])
        {
            Caption = 'DTA Currency Code';
            TableRelation = Currency;
        }
        field(90; "File Format"; Option)
        {
            Caption = 'File Format';
            OptionCaption = 'With CR/LF,Without CR/LF';
            OptionMembers = "With CR/LF","Without CR/LF";
        }
        field(300; "Computer Bureau Name"; Text[30])
        {
            Caption = 'Computer Bureau Name';
        }
        field(302; "Computer Bureau Name 2"; Text[30])
        {
            Caption = 'Computer Bureau Name 2';
        }
        field(304; "Computer Bureau Address"; Text[30])
        {
            Caption = 'Computer Bureau Address';
        }
        field(306; "Computer Bureau Post Code"; Code[20])
        {
            Caption = 'Computer Bureau Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ZipCode.Get("Computer Bureau Post Code") then
                    "Computer Bureau City" := ZipCode.City;
            end;
        }
        field(308; "Computer Bureau City"; Text[30])
        {
            Caption = 'Computer Bureau City';
        }
        field(310; "Computer Bureau E-Mail"; Text[80])
        {
            Caption = 'Computer Bureau E-Mail';
        }
        field(312; "Computer Bureau Homepage"; Text[80])
        {
            Caption = 'Computer Bureau Homepage';
        }
        field(400; "DTA Bank Name"; Text[30])
        {
            Caption = 'DTA Bank Name';
        }
        field(402; "DTA Bank Name 2"; Text[30])
        {
            Caption = 'DTA Bank Name 2';
        }
        field(404; "DTA Bank Address"; Text[30])
        {
            Caption = 'DTA Bank Address';
        }
        field(405; "DTA Bank Address 2"; Text[30])
        {
            Caption = 'DTA Bank Address 2';
        }
        field(406; "DTA Bank Post Code"; Code[20])
        {
            Caption = 'DTA Bank Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ZipCode.Get("DTA Bank Post Code") then
                    "DTA Bank City" := ZipCode.City;
            end;
        }
        field(408; "DTA Bank City"; Text[30])
        {
            Caption = 'DTA Bank City';
        }
        field(410; "DTA Bank E-Mail"; Text[80])
        {
            Caption = 'DTA Bank E-Mail';
        }
        field(412; "DTA Bank Homepage"; Text[80])
        {
            Caption = 'DTA Bank Homepage';
        }
        field(610; "Yellownet E-Mail"; Text[80])
        {
            Caption = 'Yellownet E-Mail';
        }
        field(612; "Yellownet Homepage"; Text[80])
        {
            Caption = 'Yellownet Homepage';
        }
        field(800; "Backup Copy"; Boolean)
        {
            Caption = 'Backup Copy';
        }
        field(802; "Backup Folder"; Text[50])
        {
            Caption = 'Backup Folder';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                //  GeneralMgt.CheckFolderName("Backup Folder");
            end;
        }
        field(804; "Last Backup No."; Code[4])
        {
            Caption = 'Last Backup No.';
            InitValue = '0000';
        }
        field(900; "EZAG Post Logo"; Blob)
        {
            Caption = 'EZAG Post Logo';
        }
        field(901; "EZAG Bar Code"; Blob)
        {
            Caption = 'EZAG Bar Code';
        }
    }

    keys
    {
        key(Key1; "Bank Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "DTA Sender Name" = '' then begin
            CompanyInfo.Get;
            "DTA Sender Name" := CopyStr(CompanyInfo.Name, 1, MaxStrLen("DTA Sender Name"));
            "DTA Sender Name 2" := CopyStr(CompanyInfo."Name 2", 1, MaxStrLen("DTA Sender Name 2"));
            "DTA Sender Address" := CopyStr(CompanyInfo.Address, 1, MaxStrLen("DTA Sender Address"));
            "DTA Sender Post Code" := CopyStr(CompanyInfo."Post Code", 1, 4);
            "DTA Sender City" := CopyStr(CompanyInfo.City, 1, MaxStrLen("DTA Sender City"));
            "DTA Debit Acc. No." := CompanyInfo."Bank Account No.";

            if StrLen(CompanyInfo."Bank Branch No.") <= 5 then
                "DTA Sender Clearing" := CompanyInfo."Bank Branch No.";
        end;

        if "DTA Filename" = '' then
            "DTA Filename" := 'dtalsv';

        if "Last EZAG Order No." = '' then
            "Last EZAG Order No." := '01';
    end;

    var
        Text001: label '%1 must have 2 digits.';
        ZipCode: Record "Post Code";
        CompanyInfo: Record "Company Information";
    // BankDirectory: Record "Bank Directory";
    //BankMgt: Codeunit 11500;
    //GeneralMgt: Codeunit 11501;
}

