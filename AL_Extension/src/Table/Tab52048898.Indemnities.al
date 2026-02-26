Table 52048898 Indemnities
{//GL2024  ID dans Nav 2009 : "39001425"
    Caption = 'Indemnities';
    DrillDownPageID = Indemnities;
    LookupPageID = Indemnities;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            TableRelation = "Salary Headers";
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
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
            TableRelation = Indemnity;

            trigger OnValidate()
            begin
                Ind.Reset;
                Ind.Get(Indemnity);
                Description := Ind.Description;
                Type := Ind.Type;
                "Evaluation mode" := Ind."Evaluation mode";
                "Base Amount" := Ind."Default amount";
                "Minimum value" := Ind."Minimum value";
            end;
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
            OptionCaption = 'Forfaitaire,sur Période payée,sur Période ouvrée,sur Heures travaillées,Nombre X Montant par défaut,Nbre Jours Travaillées,Montant = Brut * taux,Montant = Base * Montant,3*Smig Hor. Base,STC,Base*Nbr Jour';
            OptionMembers = Forfaitaire,"sur Période payée","sur Période ouvrée","sur Heures travaillées","Nombre X Montant par défaut","Nbre Jours Travaillées","Montant = Brut * taux","Montant = Base * Montant","3*Smig Hor. Base",STC,"Base*Nbr Jour";
        }
        field(10; "Base Amount"; Decimal)
        {
            AutoFormatType = 3;
            Caption = 'Base Amount';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                "Real Amount" := ROUND("Base Amount" * Rate / 100, 0.001);
            end;
        }
        field(11; "Real Amount"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Real Amount';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(12; Rate; Decimal)
        {
            Caption = 'Ratio';
            DecimalPlaces = 0 : 3;
            Editable = true;
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(211; "Real Amount PR"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Real Amount';
            Editable = false;
        }
        field(50000; "Minimum value"; Decimal)
        {
            Caption = 'Minimum value';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(50001; Nom; Text[60])
        {
        }
        field(50002; "Nombre de jours"; Integer)
        {
        }
        field(50003; "Non déductible accident de Tra"; Boolean)
        {
        }
        field(50005; Abattement; Boolean)
        {
        }
        field(50006; "% Abattement"; Decimal)
        {
        }
        field(50007; "Exonération"; Boolean)
        {
        }
        field(50008; "% Exonération"; Decimal)
        {
        }
        field(50009; "Plafond Exonération"; Decimal)
        {
        }
        field(50010; "Mois d'application"; Text[30])
        {
        }
        field(50011; "Non Inclue en Calcul CNSS"; Boolean)
        {
        }
        field(50012; "Montant Exonération"; Decimal)
        {
        }
        field(50013; "Montant Abattement"; Decimal)
        {
        }
        field(50014; "Type STC"; Option)
        {
            OptionMembers = " ",Licenciement,"Decés","Depart Retraite","Congé Payé",Preavis,Forfaitaire;
        }
        field(50015; "Inclu Calcul Brut STC"; Boolean)
        {
        }
        field(50050; "Non Inclis en AV NAt"; Boolean)
        {
        }
        field(50052; "Compte indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50053; "Compte contre partie indemnité"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        /* field(50054; "Indemnité conventionnelle"; Boolean)
         {
         }
         field(50062; Retraite; Boolean)
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
         field(50066; "Non Imposable"; Boolean)
         {
             Description = 'HJ SORO 02/06/2018';
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
        field(39001440; Taux; Decimal)
        {
            DecimalPlaces = 0 : 5;
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
        field(39001467; "base deduction indemnité/jours"; Integer)
        {
        }
        field(39001468; "base deduction indemnité/heure"; Integer)
        {
        }
        field(39001469; "Avantage en nature"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", Indemnity, "Non Inclus en Prime")
        {
            Clustered = true;
            SumIndexFields = "Real Amount";
        }
        key(Key2; "Employee Posting Group", Type, "No.", "Employee No.", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key3; Indemnity, "Employee Statistic Group", "Employee Posting Group", "Global Dimension 1", "Global Dimension 2")
        {
            SumIndexFields = "Real Amount";
        }
        key(Key4; "No.", "Employee No.", Type)
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        /*key(Key5; "No.", "Employee No.", Type, "Non Inclis en AV NAt")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key6; "No.", "Employee No.", Type, "Non Inclis en AV NAt", "Indemnité conventionnelle")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }*/
        key(Key7; "No.", "Employee Statistic Group", Type)
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key8; Indemnity, "Employee Posting Group")
        {
            SumIndexFields = "Real Amount", "Real Amount PR";
        }
        key(Key9; "No.", "Employee No.", "Non Inclus en Prime")
        {
            SumIndexFields = "Real Amount", "Base Amount";
        }
        key(Key10; "No.", "Employee No.", Indemnity, Type)
        {
            SumIndexFields = "Real Amount", "Base Amount";
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
        SalaryLine: Record "Salary Lines";
        Employee: Record Employee;
        EmploymentContract: Record "Employment Contract";
        DefaultIndemnities: Record "Default Indemnities";
        DefaultSocContribution: Record "Default Soc. Contribution";
        SocialContributions: Record "Social Contributions";
        SocialContribution: Record "Social Contribution";
        FormIndemnity: page Indemnity;
        recIndemnity: Record Indemnity;
        SelectedInd: Record Indemnity;
        Ind: Record Indemnity;
}

