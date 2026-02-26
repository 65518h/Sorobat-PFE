Table 52048939 "Historique contrat de travail"
{
    //GL2024  ID dans Nav 2009 : "39001510"
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "No. of Contracts"; Integer)
        {
            CalcFormula = count(Employee where(Status = const(Active),
                                                "Emplymt. Contract Code" = field(Code)));
            Caption = 'No. of Contracts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
            Editable = false;
            FieldClass = Normal;
        }
        field(8; Address; Text[60])
        {
            Caption = 'Address';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(24; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[50])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(10800; "Family Situation A"; Option)
        {
            Caption = 'Family Situation';
            OptionCaption = ' ,Single,Married,Divorcee,Widowed';
            OptionMembers = " ",Single,Married,Divorcee,Widowed;

            trigger OnValidate()
            begin
                // ALTEK
            end;
        }
        field(50000; "Relation de travail"; Option)
        {
            OptionMembers = " ",Stagiaire,Contractuel,Titulaire;
        }
        field(50001; "Employee's type Contrat"; Option)
        {
            Description = 'Ramzi : Spéciallement pour Altek';
            OptionCaption = ' ,CDD,CDI,SIVP I 1iere Année,SIVP I 2ieme Année,SIVP II,Stagiaire,Particulier';
            OptionMembers = " ",CDD,CDI,"SIVP I 1iere Année","SIVP I 2ieme Année","SIVP II",Stagiaire,Particulier;
        }
        field(50013; "Spécialité"; Text[60])
        {
            Description = '//MBY ENDA';
        }
        field(50301; "date debut contrat"; Date)
        {
        }
        field(50903; "Nationalité"; Text[30])
        {
        }
        field(80006; "Hors Grille"; Boolean)
        {
        }
        field(8099000; "Regular payments"; Integer)
        {
            Caption = 'Regular payments';
        }
        field(8099001; "Temporary payments"; Integer)
        {
            Caption = 'Temporary payments';
        }
        field(8099005; "Adjust indemnity amount"; Boolean)
        {
            Caption = 'Adjust indemnity amount';
        }
        field(8099010; "Employee's type"; Option)
        {
            Caption = 'Employee''s type';
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(8099020; "Regimes of work"; Code[10])
        {
            Caption = 'Regime of work';
            TableRelation = "Regimes of work".Code;
        }
        field(8099030; "Salary grid"; Code[10])
        {
            Caption = 'Salary grid';
            TableRelation = "Salary grid header".Code;
        }
        field(8099100; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(8099101; "Take in account deductions"; Boolean)
        {
            Caption = 'Take in account deductions';
        }
        field(8099110; "Calculation mode of the taxes"; Option)
        {
            Caption = 'Calculation mode of the taxes';
            OptionCaption = 'Standard Mode,Inclusive Mode';
            OptionMembers = "Barème standard",Forfaitaire;
        }
        field(8099111; "Inclusive ratio"; Decimal)
        {
            Caption = 'Inclusive ratio';
        }
        field(8099150; "Default Employment Contract"; Boolean)
        {
            Caption = 'Default Employment Contract';
        }
        field(8099190; "No. Series"; Code[10])
        {
            //GL204   TableRelation = Table0;
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
        field(39001420; Grade; Integer)
        {
        }
        field(39001421; Echelle; Integer)
        {
        }
        field(39001423; Classe; Option)
        {
            OptionMembers = " ",A,B,C;
        }
        field(39001440; "Type Calendar"; Option)
        {
            OptionMembers = " ",Administratif,Roulement,Chantier;
        }
        field(39001441; "Code Calendar"; Code[20])
        {
        }
        field(39001450; "Appliquer Heure Supp"; Boolean)
        {
        }
        field(39001451; "Type Assiduité"; Option)
        {
            OptionMembers = "Par Heure","Par Jour";
        }
        field(39001452; "Slice of imposition"; Code[4])
        {
            Caption = 'Tranche d''imposition';
            TableRelation = "Slices of imposition".Code;
        }
        field(39001470; Note; Decimal)
        {
        }
        field(39001480; "Gross Salary"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Gross Salary';
            Editable = true;
            FieldClass = Normal;
        }
        field(39001493; "Basis salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Basis salary';
            DecimalPlaces = 3 : 3;
        }
        field(39001495; "National Identity Card No."; Code[10])
        {
            Caption = 'National Identity Card No.';
            Numeric = false;
        }
        field(39001497; "Employee Posting Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group2";
        }
        field(39001498; "Collège"; Code[10])
        {
            Caption = 'Collège';
            TableRelation = CATEGORIES;
        }
        field(39001499; Echelon; Integer)
        {
            Caption = 'Echelon';
            TableRelation = "Baréme De Charge"."Nombre De Charge";
        }
        field(39001500; "Entry date Cat/Echelon"; Date)
        {
            Caption = 'Entry date Cat/Echelon';
        }
        field(39001501; "Upgrading date Cat/Echelon"; Date)
        {
            Caption = 'Upgrading date Cat/Echelon';
        }
        field(39001504; "Loaded childs"; Integer)
        {
            Caption = 'Loaded childs';
            Description = '\\Count("Employee Relative" WHERE (Employee No.=FIELD(No.),Field8099000=FILTER(>0)))';
            FieldClass = Normal;
        }
        field(39001507; "Days off -"; Decimal)
        {
            Caption = 'Day off consumed';
            FieldClass = Normal;
        }
        field(39001508; "Days off +"; Decimal)
        {
            Caption = 'Day off Right';
            FieldClass = Normal;
        }
        field(39001509; "Days off ="; Decimal)
        {
            Caption = 'Days off remaining';
            FieldClass = Normal;
        }
        field(39001536; "Date denier passage Cat/ech"; Date)
        {
        }
        field(39001537; "Code contrat archivé"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Code contrat archivé")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

