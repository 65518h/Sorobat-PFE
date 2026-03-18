table 52048970 "MLigne salaire Prév."
{ //GL2024  ID dans Nav 2009 : "39001483"

    //  DrillDownPageID = "Lignes paiement salariés Prév";
    // LookupPageID = "Lignes paiement salariés Prév";

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
            TableRelation = Employee WHERE(Status = FILTER(Active));

            trigger OnValidate()
            begin
                IF NOT ParamGRH.FIND('-') THEN
                    ERROR('Table Paramètres Ressources Humaines vide.\Impossible de poursuivre.');
                IF Salarié.GET("N° salarié") THEN BEGIN
                    VALIDATE("Nom salarié", Salarié."First Name" + ' ' + Salarié."Last Name");
                    VALIDATE("Salaire de base", Salarié."Basis salary");
                    comptebancaire.RESET;
                    "Code département" := Salarié."Global Dimension 1 Code";
                    "Code dossier" := Salarié."Global Dimension 2 Code";
                    "Groupe compta. salarié" := Salarié."Employee Posting Group";

                END;
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
            // TableRelation = Table0;
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
            CalcFormula = Sum("Indemnities Prev"."Real Amount" WHERE("No." = FIELD("N° Paie"),
                                                                      "Employee No." = FIELD("N° salarié"),
                                                                      Type = FILTER(Imposable)));
            FieldClass = FlowField;
        }
        field(11; "Indemnités No imposables"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum(Indemnities."Real Amount" WHERE("No." = FIELD("N° Paie"),
                                                               "Employee No." = FIELD("N° salarié"),
                                                               Type = FILTER("Non imposable")));
            Description = 'Sum("Indemnités salariés Prév."."Montant indemnité (Base)" WHERE (N° paie=FIELD(N° Paie), N° salarié=FIELD(N° salarié), Type=CONST(No imposable)))';
            FieldClass = FlowField;
        }
        field(19; "Total indémnités"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(20; "Code département"; Code[10])
        {
            //TableRelation = Table11;
        }
        field(21; "Code dossier"; Code[10])
        {
            //TableRelation = Table12;
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
            BlankZero = true;
            DecimalPlaces = 0 : 2;
        }
        field(51; "Montant de Retri. Provi."; Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
        }
        field(100; "Brut du Période"; Decimal)
        {
            AutoFormatType = 2;
            Editable = false;
        }
        field(111; "Cotisations sociales employeur"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Social Contributions Prév"."Real Amount : Employer" WHERE("No." = FIELD("N° Paie"),
                                                                                          Employee = FIELD("N° salarié")));
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
            TableRelation = "Employee Bank Account".Code WHERE("Employee No." = FIELD("N° salarié"));
        }
    }

    keys
    {
        key(STG_Key1; "N° Paie", "Année", "N° salarié")
        {
            Clustered = true;
            SumIndexFields = "Brut du Période";
        }
        key(STG_Key2; "N° salarié")
        {
            SumIndexFields = "Brut du Période";
        }
        key(STG_Key3; "Code département", "Code dossier", Etat)
        {
            SumIndexFields = "Salaire de base", "Salaire de Base Mensuiel", "Montant de Retri. Provi.", "Brut du Période";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IndemnitésSalariés.RESET;
        IndemnitésSalariés.SETFILTER("No.", "N° Paie");
        IndemnitésSalariés.SETFILTER("Employee No.", "N° salarié");
        IndemnitésSalariés.DELETEALL;
        RetenueSocialeLnSalaire.RESET;
        RetenueSocialeLnSalaire.SETFILTER("No.", "N° Paie");
        RetenueSocialeLnSalaire.SETFILTER(Employee, "N° salarié");
        RetenueSocialeLnSalaire.DELETEALL;
    end;

    var
        "Salarié": Record 5200;
        ParamGRH: Record 5218;
        "DéductionFamiliale": Decimal;
        Last: Record "MLigne salaire Prév.";
        "IndemnitésSalariés": Record "Indemnities Prev";
        RetenueSocialeLnSalaire: Record "Social Contributions Prév";
        "EnTêteSalaire": Record "En-tête salaire Prév.";
        errorParamRessHum: Label 'Table Paramètres Ressources Humaines vide.\Impossible de poursuivre.';
        comptebancaire: Record "Employee Bank Account";
}

