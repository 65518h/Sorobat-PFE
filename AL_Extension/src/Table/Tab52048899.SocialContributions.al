Table 52048899 "Social Contributions"
{//GL2024  ID dans Nav 2009 : "39001426"
    // //>>DELTASOFT ACHOUR  27/02/2013
    // AJOUT OPTION

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
        field(3; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Posting Group2";
        }
        field(4; Indemnity; Code[20])
        {
            Caption = 'Indemnity';
            TableRelation = Indemnities.Indemnity where("No." = field("No."),
                                                         "Employee No." = field(Employee));
        }
        field(5; "Social Contribution"; Code[10])
        {
            Caption = 'Social Contribution';
            TableRelation = "Social Contribution";

            trigger OnValidate()
            begin
                if SocialContribution.Get("Social Contribution") then begin
                    Description := SocialContribution.Description;
                    "Employer's part" := SocialContribution."Employer's part";
                    "Employee's part" := SocialContribution."Employee's part";
                    "Base Amount" := 0;
                    "Real Amount : Employee" := 0;
                    "Real Amount : Employer" := 0;
                    "Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                    "User ID" := UserId;
                    "Last Date Modified" := WorkDate;
                end
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
        field(14; "Basis of calculation"; Option)
        {
            Caption = 'Basis of calculation';
            Description = 'ACHOUR 27/02/2013 ajout option ,Base = Net du mois';
            Editable = false;
            OptionCaption = 'Base = Brut du mois,Base = Brut du mois-(6*SMIG),Base = Salaire de base,Net imposable';
            OptionMembers = "Base = Brut du mois","Base = Brut du mois-(6*SMIG)","Base = Salaire de base",Netimposable;
        }
        field(15; "Base Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Base Amount';
            Editable = false;
        }
        field(16; "Real Amount : Employee"; Decimal)
        {
            AutoFormatType = 3;
            Caption = 'Real Amount : Employee';
            Editable = false;
        }
        field(17; "Real Amount : Employer"; Decimal)
        {
            AutoFormatType = 3;
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(22; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(216; "Real Amount : Employee PR"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount : Employee';
            Editable = false;
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
            Description = 'RB SORO 05/04/2016 Indemnité Non Cotisable';
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
        field(39001430; "6 * Smig"; Decimal)
        {
        }
        field(39001450; "inclus en compta"; Boolean)
        {
        }
        field(39001451; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
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
        key(Key1; "No.", Employee, Indemnity, "Social Contribution")
        {
            Clustered = true;
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        key(Key2; "Employee Posting Group", "Deductible of taxable basis", Employee, "No.", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        key(Key3; "Social Contribution", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        key(Key4; "No.", Employee, "Deductible of taxable basis")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        key(Key5; "No.", "Deductible of taxable basis", "Employee Statistic Group")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        key(Key6; "No.", "Deductible of taxable basis", "Employee Posting Group")
        {
            SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
        }
        /*  key(Key7; "No.", Employee, "Deductible of taxable basis", "Basis of calculation")
          {
              SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
          }
          key(Key8; "No.", Employee, "Deductible of taxable basis", "Basis of calculation", "Non Cotisable")
          {
              SumIndexFields = "Employer's part", "Employee's part", "Base Amount", "Real Amount : Employee", "Real Amount : Employer", "Real Amount : Employee PR";
          }*/
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        "User ID" := UserId;
        /*   RecParGRH.Get;
           "6 * Smig" := RecParGRH."Minimum wage guarantee" * 6;*/
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

    var
        SocialContribution: Record "Social Contribution";
        RecParGRH: Record "Human Resources Setup";
}

