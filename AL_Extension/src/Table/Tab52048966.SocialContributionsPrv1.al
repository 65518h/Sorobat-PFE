table 52048966 "Social Contributions Prév1"
{ //GL2024  ID dans Nav 2009 : "39001463"
    Caption = 'Social Contribution';
    DrillDownPageID = "Social Contribution";
    LookupPageID = "Social Contribution";

    fields
    {
        field(1; "No."; Code[10])
        {
            TableRelation = "Salary Headers";
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
            TableRelation = Indemnities.Indemnity WHERE("No." = FIELD("No."),
                                                         "Employee No." = FIELD(Employee));
        }
        field(5; "Social Contribution"; Code[10])
        {
            Caption = 'Social Contribution';
            TableRelation = "Social Contribution";

            trigger OnValidate()
            begin
                IF SocialContribution.GET("Social Contribution") THEN BEGIN
                    Description := SocialContribution.Description;
                    "Employer's part" := SocialContribution."Employer's part";
                    "Employee's part" := SocialContribution."Employee's part";
                    "Base Amount" := 0;
                    "Real Amount : Employee" := 0;
                    "Real Amount : Employer" := 0;
                    "Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                    "User ID" := USERID;
                    "Last Date Modified" := WORKDATE;
                END
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Employer's part"; Decimal)
        {
            Caption = 'Employer''s part';
            Editable = false;
        }
        field(11; "Employee's part"; Decimal)
        {
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
            AutoFormatType = 2;
            Caption = 'Real Amount : Employer';
            Editable = false;
        }
        field(20; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
        }
        field(21; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(216; "Real Amount : Employee PR"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount : Employee';
            Editable = false;
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
        field(50010; "Mode dévaluation"; Option)
        {
            OptionMembers = "Montant = Base * Taux","Montant = Montant Forfaitaire","Montant = Imposable * Taux","Montant = Brut (Sans AV) * Taux";
        }
        field(50011; "Forfait salarial"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50012; "Forfait patronal"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(8099198; "User ID"; Code[20])
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
        field(39001450; "inclus en compta"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.", Employee, Indemnity, "Social Contribution")
        {
            Clustered = true;
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(Key2; "Employee Posting Group", "Deductible of taxable basis", Employee, "No.", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(Key3; "Social Contribution", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(Key4; "No.", Employee, "Deductible of taxable basis")
        {
            SumIndexFields = "Real Amount : Employee", "Real Amount : Employee PR";
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

    var
        SocialContribution: Record "Social Contributions";
}

