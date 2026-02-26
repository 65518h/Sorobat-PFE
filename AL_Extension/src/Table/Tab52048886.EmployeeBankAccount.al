Table 52048886 "Employee Bank Account"
{//GL2024  ID dans Nav 2009 : "39001408"
    Caption = 'Employee Bank Account';
    DataCaptionFields = "Employee No.", "Code", Name;
    DrillDownPageID = "Employee Bank Account List";
    LookupPageID = "Employee Bank Account List";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Name; Text[60])
        {
            Caption = 'Name';
        }
        field(5; "Name 2"; Text[60])
        {
            Caption = 'Name 2';
        }
        field(6; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(7; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code") then
                    City := PostCode.City;
            end;
        }
        field(10; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(11; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(12; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(13; "Bank Branch No."; Text[10])
        {
            Caption = 'Bank Branch No.';

            trigger OnValidate()
            VAR
                Intrib: Integer;
            begin
                Evaluate(Intrib, rec."RIB Key");
                "RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", Intrib);
            end;
        }
        field(14; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';

            trigger OnValidate()
            VAR
                Intrib: Integer;
            begin
                Evaluate(Intrib, rec."RIB Key");
                "RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", Intrib);
                I := "Bank Account No.";
            end;
        }
        field(15; "Transit No."; Text[20])
        {
            Caption = 'Transit No.';
        }
        field(16; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(17; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(18; County; Text[30])
        {
            Caption = 'County';
        }
        field(19; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(20; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(21; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(22; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(23; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(10851; "Agency Code"; Text[20])
        {
            Caption = 'Agency Code';

            trigger OnValidate()
            VAR
                Intrib: Integer;
            begin
                Evaluate(Intrib, rec."RIB Key");
                "RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", Intrib);
            end;
        }
        field(10852; "RIB Key"; Text[30])
        {
            Caption = 'RIB Key';

            trigger OnValidate()
            VAR
                Intrib: Integer;
            begin
                Evaluate(Intrib, rec."RIB Key");
                "RIB Checked" := RIBKey.ChecK("Bank Branch No.", "Agency Code", "Bank Account No.", Intrib);
            end;
        }
        field(10853; "RIB Checked"; Boolean)
        {
            Caption = 'RIB Checked';
            Editable = false;
        }
        field(50000; "Banque"; code[30])
        {
            TableRelation = "Union";
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Employee No.")
        {
        }
        key(Key3; "Banque")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        RIBKey: Codeunit "RIB Key";
        I: Code[20];
}

