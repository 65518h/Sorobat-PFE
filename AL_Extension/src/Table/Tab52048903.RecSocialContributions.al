Table 52048903 "Rec. Social Contributions"
{//GL2024  ID dans Nav 2009 : "39001430"
    // //>>DELTASOFT 27/02/2013
    //  Ajout option ,Base = Net du mois dans champs base de calcul

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
            Editable = true;
            TableRelation = Employee;
        }
        field(3; "Employee Posting Group"; Code[10])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Posting Group2";
        }
        field(4; Indemnity; Code[20])
        {
            Caption = 'Indemnity';
            TableRelation = Indemnity;
        }
        field(5; "Social Contribution"; Code[20])
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
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(11; "Employee's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employee''s part';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(14; "Basis of calculation"; Option)
        {
            Caption = 'Basis of calculation';
            Description = 'ACHOUR 27/02/2013 ajout option ,Base = Net du mois';
            Editable = false;
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG),Net imposable';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)","Net imposable";
        }
        field(15; "Base Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Base Amount';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(16; "Real Amount : Employee"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount : Employee';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(17; "Real Amount : Employer"; Decimal)
        {
            Caption = 'Real Amount : Employer';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(20; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
        }
        field(30; "Globla dimension 1"; Code[20])
        {
            Caption = 'Code département';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(910; "year of Calculate"; Integer)
        {
            Caption = 'Year of Calculate';
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
        field(50002; "Posting date"; Date)
        {
        }
        /*  field(50064; "Non Cotisable"; Boolean)
          {
              Description = 'RB SORO 05/04/2016';
          }*/
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
        field(39001431; "Année"; Integer)
        {
        }
        field(39001450; "inclus en compta"; Boolean)
        {
        }
        field(39001451; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee statistic Group';
            Editable = true;
            TableRelation = "Employee Statistics Group";
        }
        field(39001452; direction; Code[10])
        {
        }
        field(39001453; service; Code[10])
        {
        }
        field(39001454; section; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "No.", Employee, Indemnity, "Social Contribution")
        {
            Clustered = true;
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(STG_Key2; "Employee Posting Group", "Deductible of taxable basis", Employee, "No.", "Globla dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(STG_Key3; "Social Contribution", "Globla dimension 1", "Global dimension 2", "Employee Posting Group")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
        key(STG_Key4; "Social Contribution", Employee, "year of Calculate")
        {
            SumIndexFields = "Base Amount";
        }
        key(STG_Key5; "Employee Statistic Group", "Deductible of taxable basis", "No.")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
    end;
}

