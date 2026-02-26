table 52048963 "Rec. Social Contributions m"
{ //GL2024  ID dans Nav 2009 : "39001460"
    Caption = 'Rec. Social Contributions';
    DrillDownPageID = "Recorded Social Contribution";
    LookupPageID = "Recorded Social Contribution";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            TableRelation = "Rec. Salary Headers"."No.";
        }
        field(2; Employee; Code[10])
        {
            Caption = 'Employee';
            Editable = false;
            TableRelation = Employee;
        }
        field(3; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = false;
            TableRelation = "Employee Posting Group";
        }
        field(4; Indemnity; Code[10])
        {
            Caption = 'Indemnity';
            TableRelation = Indemnity;
        }
        field(5; "Social Contribution"; Code[10])
        {
            Caption = 'Social Contribution';
            TableRelation = "Social Contribution";
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Employer's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employer''s part';
            Editable = false;
        }
        field(11; "Employee's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employee''s part';
            Editable = false;
        }
        field(15; "Base Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Base Amount';
            Editable = false;
        }
        field(16; "Real Amount : Employee"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount : Employee';
            Editable = false;
        }
        field(17; "Real Amount : Employer"; Decimal)
        {
            Caption = 'Real Amount : Employer';
            Editable = false;
        }
        field(20; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
        }
        field(30; "Globla dimension 1"; Code[20])
        {
            Caption = 'Code département';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50000; "Maximum value - Employee"; Decimal)
        {
            Caption = 'Maximum value - Employee';
            DecimalPlaces = 3 : 3;
        }
        field(50001; "Maximum value - Employer"; Decimal)
        {
            Caption = 'Maximum value - Employer';
            DecimalPlaces = 3 : 3;
        }
        field(8099198; "User ID"; Code[10])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001430; "6 * Smig"; Decimal)
        {
        }
        field(39001431; "Année"; Integer)
        {
        }
        field(39001450; "inclus en compta"; Boolean)
        {
        }
        field(39001451; i; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No.", Employee, Indemnity, "Social Contribution", i)
        {
            Clustered = true;
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(Key2; "Employee Posting Group", "Deductible of taxable basis", Employee, "No.", "Globla dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(Key3; "Social Contribution", "Globla dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WORKDATE;
        "User ID" := USERID;
    end;
}

