Table 52048880 "Social Contribution"
{ //GL2024  ID dans Nav 2009 : "39001401"
    // //>>DELTASOFT ACHOUR 27/02/2013
    // Ajout option dans base de calcul ,Base = Net du mois

    Caption = 'Social Contribution';
    // DrillDownPageID = 71401;
    // LookupPageID = 71401;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Employer's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employer''s part';
        }
        field(4; "Employee's part"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Employee''s part';
        }
        field(15; "Basis of calculation"; Option)
        {
            Caption = 'Basis of calculation';
            Description = 'ACHOUR 27/02/2013 ajout option ,Base = Net du mois';
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG),Base = Salaire de base,Net imposable';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)","Base = Salaire de base + Indemnités inclusent","Net imposable";
        }
        field(20; "Apply to all Employees"; Boolean)
        {
            Caption = 'Apply to all Employees';
        }
        field(25; "Deductible of taxable basis"; Boolean)
        {
            Caption = 'Deductible of taxable basis';
        }
        field(30; "Employee : G/L Account"; Code[10])
        {
            Caption = 'Employee : G/L Account';
            TableRelation = "G/L Account";
        }
        field(35; "Employer : G/L Account"; Code[10])
        {
            Caption = 'Employer : G/L Account';
            TableRelation = "G/L Account";
        }
        field(36; "Employer : Bal. Account No."; Code[10])
        {
            Caption = 'Employer : Bal. Account No.';
            TableRelation = "G/L Account";
        }
        field(40; "Payment No. filter"; Code[10])
        {
            Caption = 'Payment No. filter';
            FieldClass = FlowFilter;
            TableRelation = "Salary Headers";
        }
        field(41; "Employee Posting Grp. filter"; Code[10])
        {
            Caption = 'Employee Posting Grp. filter';
            FieldClass = FlowFilter;
            TableRelation = "Employee Posting Group2";
        }
        field(45; "Total employee's part"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Social Contributions"."Real Amount : Employee" where("Social Contribution" = field(Code),
                                                                                     "Employee Posting Group" = field("Employee Posting Grp. filter"),
                                                                                     "No." = field("Payment No. filter")));
            Caption = 'Total employee''s part';
            FieldClass = FlowField;
        }
        field(46; "Total employer's part"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Social Contributions"."Real Amount : Employer" where("Social Contribution" = field(Code),
                                                                                     "Employee Posting Group" = field("Employee Posting Grp. filter"),
                                                                                     "No." = field("Payment No. filter")));
            Caption = 'Total employer''s part';
            FieldClass = FlowField;
        }
        field(47; "Rec. Total employee's part"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Rec. Social Contributions"."Real Amount : Employee" where("Social Contribution" = field(Code),
                                                                                          "Employee Posting Group" = field("Employee Posting Grp. filter"),
                                                                                          "No." = field("Payment No. filter")));
            Caption = 'Total employee''s part';
            FieldClass = FlowField;
        }
        field(48; "Rec. Total employer's part"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Rec. Social Contributions"."Real Amount : Employer" where("Social Contribution" = field(Code),
                                                                                          "Employee Posting Group" = field("Employee Posting Grp. filter"),
                                                                                          "No." = field("Payment No. filter")));
            Caption = 'Total employer''s part';
            FieldClass = FlowField;
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
        field(50013; "Plafond SBase*8%"; Boolean)
        {
        }
        field(50014; CNSS; Boolean)
        {
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
        field(39001450; "non inclus en compta"; Boolean)
        {
        }
        field(39001451; "Non Inclus en Prime"; Boolean)
        {
        }
        field(39001452; "Libellé"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
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

