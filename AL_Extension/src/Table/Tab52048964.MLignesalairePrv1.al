
Table 52048964 "MLigne salaire Prév.1"
{

    //GL2024  ID dans Nav 2009 : "39001461"
    //DYS page non migrer
    //  DrillDownPageID = 8099082;
    // LookupPageID = 8099082;

    fields
    {
        field(1; "N° Paie"; Code[20])
        {
        }
        field(2; "Année"; Integer)
        {
        }
        field(3; "N° salarié"; Code[10])
        {
            Caption = 'Emplyee No.';
            TableRelation = Employee where(Status = filter(Active));

            trigger OnValidate()
            begin
                if not ParamGRH.Find('-') then
                    Error('Table Paramètres Ressources Humaines vide.\Impossible de poursuivre.');
                if Salarié.Get("N° salarié") then begin
                    Validate("Nom salarié", Salarié."First Name" + ' ' + Salarié."Last Name");
                    Validate("Salaire de base", Salarié."Basis salary");
                    comptebancaire.Reset;
                    "Code département" := Salarié."Global Dimension 1 Code";
                    "Code dossier" := Salarié."Global Dimension 2 Code";
                    "Groupe compta. salarié" := Salarié."Employee Posting Group";

                end;
            end;
        }
        field(4; "Nom salarié"; Text[60])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(5; "Groupe compta. salarié"; Code[10])
        {
            Caption = 'Employee Posting Groups';
            Editable = false;
            //GL2024  TableRelation = Table0;
        }
        field(6; "Salaire de base"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(7; "Nombre de mois payés"; Integer)
        {
        }
        field(8; "Nbre Mois"; Integer)
        {
            Editable = true;
        }
        field(10; "Indemnités imposables"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Indemnities Prev1"."Real Amount" where("No." = field("N° Paie"),
                                                                       "Employee No." = field("N° salarié"),
                                                                       Type = filter(Imposable)));
            FieldClass = FlowField;
        }
        field(11; "Indemnités No imposables"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Indemnities Prev1"."Real Amount" where("No." = field("N° Paie"),
                                                                       "Employee No." = field("N° salarié"),
                                                                       Type = filter("Non imposable")));
            Description = 'Sum("Indemnités salariés Prév."."Montant indemnité (Base)" WHERE (N° paie=FIELD(N° Paie), N° salarié=FIELD(N° salarié), Type=CONST(No imposable)))';
            FieldClass = FlowField;
        }
        field(19; "Total indémnités"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(20; "Code département"; Code[20])
        {
            //GL2024   TableRelation = Table11;
        }
        field(21; "Code dossier"; Code[20])
        {
            //GL2024   TableRelation = Table12;
        }
        field(25; "Salaire de Base Mensuiel"; Decimal)
        {
            AutoFormatType = 3;
        }
        field(30; "Nombre de jours"; Decimal)
        {
            Caption = 'Number of days';
        }
        field(31; Etat; Option)
        {
            Caption = 'Status';
            OptionMembers = Disponible,Indisponible,"Fin de contrat";
        }
        field(50; "Retri. Provi. en Mois"; Decimal)
        {
            //blankzero = true;
            DecimalPlaces = 0 : 2;
        }
        field(51; "Montant de Retri. Provi."; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
        }
        field(100; "Brut du Période"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(111; "Cotisations sociales employeur"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Social Contributions Prév1"."Real Amount : Employer" where("No." = field("N° Paie"),
                                                                                           Employee = field("N° salarié")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Salaire imposable"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(300; "% Augmentatin Brut"; Integer)
        {
        }
        field(8099060; "N° compte bancaire"; Text[30])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Employee Bank Account".Code where("Employee No." = field("N° salarié"));
        }
    }

    keys
    {
        key(Key1; "N° Paie", "Année", "N° salarié")
        {
            Clustered = true;
            SumIndexFields = "Brut du Période";
        }
        key(Key2; "N° salarié")
        {
            SumIndexFields = "Brut du Période";
        }
        key(Key3; "Code département", "Code dossier", Etat)
        {
            SumIndexFields = "Salaire de base", "Salaire de Base Mensuiel", "Montant de Retri. Provi.", "Brut du Période";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IndemnitésSalariés.Reset;
        IndemnitésSalariés.SetFilter("No.", "N° Paie");
        IndemnitésSalariés.SetFilter("Employee No.", "N° salarié");
        IndemnitésSalariés.DeleteAll;
        RetenueSocialeLnSalaire.Reset;
        RetenueSocialeLnSalaire.SetFilter("No.", "N° Paie");
        RetenueSocialeLnSalaire.SetFilter(Employee, "N° salarié");
        RetenueSocialeLnSalaire.DeleteAll;
    end;

    var
        "Salarié": Record Employee;
        ParamGRH: Record "Human Resources Setup";
        "DéductionFamiliale": Decimal;
        Last: Record "MLigne salaire Prév.1";
        "IndemnitésSalariés": Record "Indemnities Prev1";
        RetenueSocialeLnSalaire: Record "Social Contributions Prév1";
        "EnTêteSalaire": Record "Rec. Social Contributions m";
        errorParamRessHum: label 'Table Paramètres Ressources Humaines vide.\Impossible de poursuivre.';
        comptebancaire: Record "Employee Bank Account";
}

