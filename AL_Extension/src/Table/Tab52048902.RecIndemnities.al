Table 52048902 "Rec. Indemnities"
{//GL2024  ID dans Nav 2009 : "39001429"
    Caption = 'Rec. Indemnities';
    DrillDownPageID = "Recorded Indemnities";
    LookupPageID = "Recorded Indemnities";

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            TableRelation = "Rec. Salary Headers"."No.";
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
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
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Taxable,Non taxable,Imposable (Non Assujettie Socialement)';
            OptionMembers = Imposable,"Non imposable","Imposable (Non Assujettie Socialement)";
        }
        field(7; "Evaluation mode"; Option)
        {
            Caption = 'Evaluation mode';
            OptionCaption = 'Forfaitaire,sur Période payée,sur Période ouvrée,sur Heures travaillées,Nombre X Montant par défaut,Nbre Jours Travaillées,Montant = Brut * taux,Montant = Base * Montant,jour travail Mission,jour repos mission';
            OptionMembers = Inclusive,"on Paid period","on Worked period","on Worked hour","on Flight hours","Nbre Days Worked","Montant = Brut * taux","Montant = Base * Taux","on Worked Day Mission","3*Smig Hor. Base";
        }
        field(10; "Base Amount"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Base Amount';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                "Real Amount" := "Base Amount" * Rate / 100;
            end;
        }
        field(11; "Real Amount"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real Amount';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(12; Rate; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Ratio';
            Editable = false;
        }
        field(13; "Global dimension 1"; Code[20])
        {
            Caption = 'Code département';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global dimension 2"; Code[20])
        {
            Caption = 'Code Dossier';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(211; "Real Amount PR"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real Amount';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50000; "Minimum value"; Decimal)
        {
            Caption = 'Minimum value';
            DecimalPlaces = 3 : 3;
        }
        field(50002; "Nombre de jours"; Integer)
        {
        }
        field(50003; "Non déductible accident de Tra"; Boolean)
        {
        }
        /*    field(50004; "Inclus dans heures supp"; Boolean)
            {
            }
            field(50008; "Min Comptabilisable"; Decimal)
            {
            }*/
        field(50052; "Compte indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50053; "Compte contre partie indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        /*  field(50062; Retraite; Boolean)
          {
          }
          field(50064; "Non Cotisable"; Boolean)
          {
              Description = 'RB SORO 05/04/2016';
          }
          field(50065; "Panier Au Prorata Deplacement"; Boolean)
          {
              Description = 'HJ SORO 08-06-2016';
          }
          field(50067; STC; Boolean)
          {
              Description = 'HJ SORO 21-06-2018';
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
        field(39001431; "Année"; Integer)
        {
        }
        field(39001440; Taux; Decimal)
        {
        }
        field(39001441; "Type Indemnité"; Option)
        {
            OptionMembers = Regular,"Non Regular";
        }
        field(39001450; "inclus en compta"; Boolean)
        {
        }
        field(39001451; "Non Inclus en Prime"; Boolean)
        {
        }
        field(39001460; "Precision Arrondi Montant"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(39001461; "Direction Arrondi"; Option)
        {
            OptionMembers = "=","<",">";
        }
        field(39001462; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee statistic Group';
            Editable = true;
            TableRelation = "Employee Statistics Group";
        }
        field(39001463; direction; Code[10])
        {
        }
        field(39001464; service; Code[10])
        {
        }
        field(39001465; section; Code[10])
        {
        }
        field(39001466; "Non Inclue en jours congé"; Boolean)
        {
        }
        field(39001467; "Avantage en nature"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", Indemnity)
        {
            Clustered = true;
            SumIndexFields = "Real Amount";
        }
        key(Key2; "Employee Posting Group", Type, "No.", "Employee No.", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key3; Indemnity, "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key4; Indemnity, "Employee Posting Group", "Global dimension 1", "Global dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key5; "Employee Posting Group", "Global dimension 1", "Global dimension 2", Indemnity, "Compte contre partie indemnité")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key6; "No.", "Employee No.", "Non Inclus en Prime", "Type Indemnité", Type)
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key7; "Employee Statistic Group", Type, "No.")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key8; "Compte contre partie indemnité", "Compte indemnité")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key9; "Employee Posting Group", "Global dimension 1", "Global dimension 2", "Compte indemnité")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key10; "No.", Indemnity)
        {
            SumIndexFields = "Real Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        SocialContributions.Reset;
        SocialContributions.SetRange("No.", "No.");
        SocialContributions.SetRange(Employee, "Employee No.");
        SocialContributions.SetRange(Indemnity, Indemnity);

        if SocialContributions.Find('-') then
            SocialContributions.DeleteAll;
    end;

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

    var
        Employee: Record Employee;
        EmploymentContract: Record "Employment Contract";
        DefaultIndemnities: Record "Default Indemnities";
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocialContribution: Record "Social Contribution";
}

