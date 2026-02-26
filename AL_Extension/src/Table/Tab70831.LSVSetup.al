Table 70831 "LSV Setup"
{
    //GL2024  ID dans Nav 2009 : "3010831"
    // <changelog>
    //   <add id="CH9500" dev="SRYSER" date="2005-09-21" area="LS"
    //     releaseversion="CH4.00.02"  request="CH-START-400SP2-RENU">
    //     Renumber of Existing Functionality
    //     Swiss Payment Add-On (LSV)</add>
    //   <change id="CH2810" dev="SRYSER" date="2006-04-15" area="LS"
    //     baseversion="CH4.00.02" releaseversion="CH4.00.03" feature="PS9380">
    //     LSV Plus redesign / Correct Name of field 40</change>
    //   <change id="CH9115" dev="SRYSER" feature="PSCORS1300" date="2006-10-14" area="LS"
    //     baseversion="CH4.00.03" releaseversion="CH5.00">
    //     PreCall Cleanup</change>
    // </changelog>

    Caption = 'LSV Setup';
    //DrillDownPageID = 3010831;
    //LookupPageID = 3010831;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            NotBlank = true;
            TableRelation = "Bank Account";
            ValidateTableRelation = false;
        }
        field(20; "LSV Customer ID"; Code[10])
        {
            Caption = 'LSV Customer ID';

            trigger OnValidate()
            begin
                if "LSV Customer ID" <> '' then begin
                    if StrLen("LSV Customer ID") <> 5 then
                        Error(Text000, FieldCaption("LSV Customer ID"), '5');
                    if "LSV Sender ID" = '' then
                        "LSV Sender ID" := "LSV Customer ID";
                end;
            end;
        }
        field(22; "LSV Sender ID"; Code[10])
        {
            Caption = 'LSV Sender ID';

            trigger OnValidate()
            begin
                if "LSV Sender ID" <> '' then
                    if StrLen("LSV Sender ID") <> 5 then
                        Error(Text000, FieldCaption("LSV Customer ID"), '5');
            end;
        }
        field(24; "LSV Sender Clearing"; Code[5])
        {
            Caption = 'LSV Sender Clearing';
            //  TableRelation = "Bank Directory";
            //   ValidateTableRelation = false;
        }
        field(30; "LSV Credit on Account No."; Code[24])
        {
            Caption = 'LSV Credit on Account No.';
        }
        field(40; "LSV Payment Method Code"; Code[10])
        {
            Caption = 'LSV Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(42; "LSV Currency Code"; Code[10])
        {
            Caption = 'LSV Currency Code';
        }
        field(44; "LSV Customer Bank Code"; Code[10])
        {
            Caption = 'LSV Customer Bank Code';
        }
        field(60; "LSV Sender Name"; Text[24])
        {
            Caption = 'LSV Sender Name';
        }
        field(62; "LSV Sender Name 2"; Text[24])
        {
            Caption = 'LSV Sender Name 2';
        }
        field(64; "LSV Sender Address"; Text[24])
        {
            Caption = 'LSV Sender Address';
        }
        field(66; "LSV Sender Post Code"; Code[4])
        {
            Caption = 'LSV Sender Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ZipCode.Get("LSV Sender Post Code") then
                    "LSV Sender City" := CopyStr(ZipCode.City, 1, MaxStrLen("LSV Sender City"));
            end;
        }
        field(68; "LSV Sender City"; Text[20])
        {
            Caption = 'LSV Sender City';
        }
        field(71; "LSV Sender IBAN"; Code[50])
        {
            Caption = 'LSV Sender IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN("LSV Sender IBAN");
            end;
        }
        field(72; "ESR Bank Code"; Code[20])
        {
            Caption = 'ESR Bank Code';
            TableRelation = "ESR Setup"."Bank Code";
        }
        field(80; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(82; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";
        }
        field(90; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(100; "LSV File Folder"; Code[40])
        {
            Caption = 'LSV File Folder';
            InitValue = 'A:\';

            trigger OnValidate()
            begin
                if "LSV File Folder" = '' then
                    exit;

                if CopyStr("LSV File Folder", StrLen("LSV File Folder"), 1) <> '\' then
                    "LSV File Folder" := "LSV File Folder" + '\';
            end;
        }
        field(102; "LSV Filename"; Code[11])
        {
            Caption = 'LSV Filename';
            InitValue = 'DTALSV';
        }
        field(200; Text; Text[250])
        {
            Caption = 'Text';
        }
        field(202; "Text 2"; Text[250])
        {
            Caption = 'Text 2';
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
        field(400; "LSV Bank Name"; Text[30])
        {
            Caption = 'LSV Bank Name';
        }
        field(402; "LSV Bank Name 2"; Text[30])
        {
            Caption = 'LSV Bank Name 2';
        }
        field(404; "LSV Bank Address"; Text[30])
        {
            Caption = 'LSV Bank Address';
        }
        field(406; "LSV Bank Post Code"; Code[20])
        {
            Caption = 'LSV Bank Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if ZipCode.Get("LSV Bank Post Code") then
                    "LSV Bank City" := ZipCode.City;
            end;
        }
        field(408; "LSV Bank City"; Text[30])
        {
            Caption = 'LSV Bank City';
        }
        field(410; "LSV Bank E-Mail"; Text[80])
        {
            Caption = 'LSV Bank E-Mail';
        }
        field(412; "LSV Bank Homepage"; Text[80])
        {
            Caption = 'LSV Bank Homepage';
        }
        field(414; "LSV Bank Transfer Hyperlink"; Text[50])
        {
            Caption = 'LSV Bank Transfer Hyperlink';
        }
        field(600; "DebitDirect Customerno."; Code[6])
        {
            Caption = 'DebitDirect Customerno.';

            trigger OnValidate()
            begin
                if not (StrLen("DebitDirect Customerno.") in [0, 6]) then
                    Error(Text000, "DebitDirect Customerno.", '6');
            end;
        }
        field(614; "Yellownet Homepage"; Text[80])
        {
            Caption = 'Yellownet Homepage';
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

    trigger OnDelete()
    begin
        LsvJournal.SetRange("LSV Bank Code", "Bank Code");
        if LsvJournal.Find('-') then
            Error(Text001, "Bank Code", LsvJournal.TableCaption);
    end;

    trigger OnInsert()
    begin
        if "LSV Sender Name" = '' then begin
            CompanyInfo.Get;
            "LSV Sender Name" := Format(CompanyInfo.Name, -MaxStrLen("LSV Sender Name"));
            "LSV Sender Name 2" := Format(CompanyInfo."Name 2", -MaxStrLen("LSV Sender Name 2"));
            "LSV Sender Address" := Format(CompanyInfo.Address, -MaxStrLen("LSV Sender Address"));
            "LSV Sender Post Code" := Format(CompanyInfo."Post Code", -MaxStrLen("LSV Sender Post Code"));
            "LSV Sender City" := Format(CompanyInfo.City, -MaxStrLen("LSV Sender City"));
            "LSV Credit on Account No." := CompanyInfo."Bank Account No.";
            "LSV Sender Clearing" := CompanyInfo."Bank Branch No.";
        end;

        if "LSV Filename" = '' then
            "LSV Filename" := 'DTALSV';

        "LSV Payment Method Code" := 'LSV';
        "LSV Customer Bank Code" := 'LSV';
    end;

    var
        Text000: label '%1 must have %2 characters.';
        Text001: label 'You cannot delete %1 there are entries in table %2.';
        ZipCode: Record "Post Code";
        CompanyInfo: Record "Company Information";
        LsvJournal: Record "LSV Journal";
}

