Table 70531 "ESR Setup"
{
    //GL2024  ID dans Nav 2009 : "3010531"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="ES"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Payment Documents / Payment Forms (ESR)</add>
    //   <change id="CH2010" dev="SRYSER" date="2006-05-15" area="ES"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="PS9879">
    //     Removed Communication Fields</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="ES"
    //     baseversion="CH4.00.03" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>

    Caption = 'ESR Setup';
    //DrillDownPageID = 3010531;
    //LookupPageID = 3010531;
    PasteIsValid = false;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            TableRelation = "Bank Account";
            ValidateTableRelation = false;
        }
        field(2; "ESR System"; Option)
        {
            Caption = 'ESR System';
            OptionCaption = 'ESR,ESR+';
            OptionMembers = ESR,"ESR+";
        }
        field(3; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(4; "ESR Filename"; Text[50])
        {
            Caption = 'ESR Filename';
            NotBlank = true;
        }
        field(5; "BESR Customer ID"; Code[11])
        {
            Caption = 'BESR Customer ID';
            InitValue = '00000000000';
            Numeric = true;

            trigger OnValidate()
            begin
                // CHeck length of Customer ID
                if StrLen("BESR Customer ID") < MaxStrLen("BESR Customer ID") then
                    Error(Text000, FieldCaption("BESR Customer ID"), MaxStrLen("BESR Customer ID"));
            end;
        }
        field(6; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(7; "ESR Payment Method Code"; Code[10])
        {
            Caption = 'ESR Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(8; "ESR Main Bank"; Boolean)
        {
            Caption = 'ESR Main Bank';

            trigger OnValidate()
            begin
                // Only one Main Bank possible
                if "ESR Main Bank" then begin
                    SetRange("ESR Main Bank", true);
                    ModifyAll("ESR Main Bank", false);
                    SetRange("ESR Main Bank");
                end;
            end;
        }
        field(10; "ESR Account No."; Code[11])
        {
            Caption = 'ESR Account No.';
            CharAllowed = '09--';
            NotBlank = true;

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                // BankMgt.CheckPostAccountNo("ESR Account No.");
            end;
        }
        field(11; "ESR Member Name 1"; Text[30])
        {
            Caption = 'ESR Member Name 1';
        }
        field(12; "ESR Member Name 2"; Text[30])
        {
            Caption = 'ESR Member Name 2';
        }
        field(13; "ESR Member Name 3"; Text[30])
        {
            Caption = 'ESR Member Name 3';
        }
        field(19; "Beneficiary Text"; Text[30])
        {
            Caption = 'Beneficiary Text';
        }
        field(20; Beneficiary; Text[30])
        {
            Caption = 'Beneficiary';
        }
        field(21; "Beneficiary 2"; Text[30])
        {
            Caption = 'Beneficiary 2';
        }
        field(22; "Beneficiary 3"; Text[30])
        {
            Caption = 'Beneficiary 3';
        }
        field(23; "Beneficiary 4"; Text[30])
        {
            Caption = 'Beneficiary 4';
        }
        field(24; "Beneficiary 5"; Text[30])
        {
            Caption = 'Beneficiary 5';
        }
        field(40; "ESR Currency Code"; Code[10])
        {
            Caption = 'ESR Currency Code';
            TableRelation = Currency;
        }
        field(50; "Backup Copy"; Boolean)
        {
            Caption = 'Backup Copy';
        }
        field(51; "Backup Folder"; Text[50])
        {
            Caption = 'Backup Folder';

            trigger OnValidate()
            begin
                //DYS CDU NON MIGRER
                // GeneralMgt.CheckFolderName("Backup Folder");
            end;
        }
        field(52; "Last Backup No."; Code[4])
        {
            Caption = 'Last Backup No.';
            InitValue = '0000';
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

    var
        Text000: label 'The %1 must be a number with %2 digits or be filled with zeros.';
    //BankMgt: Codeunit 11500;
    //GeneralMgt: Codeunit 11501;
}

