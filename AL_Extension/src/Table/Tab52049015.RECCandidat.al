table 52049015 "REC-Candidat"
{//GL2024  ID dans Nav 2009 : "39001488"
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    //  DrillDownPageID = "REC-Liste candidat";
    //  LookupPageID = "REC-Liste candidat";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Initials)) OR ("Search Name" = '') THEN
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //GL2024   PostCode.LookUpCity(City, "Post Code", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024    PostCode.ValidateCity(City, "Post Code");
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //GL2024    PostCode.LookUpPostCode(City, "Post Code", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024     PostCode.ValidatePostCode(City, "Post Code");
            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
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
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));

            trigger OnValidate()
            begin
                //IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
                //  EmployeeResUpdate.ResUpdate(Rec)
            end;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10800; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = ' ,Single,Married,Divorced,Widowed';
            OptionMembers = " ",Single,Married,Divorced,Widowed;
        }
        field(50000; "Affiliation date"; Date)
        {
            Caption = 'Affiliation date';
        }
        field(50001; "Délivrée le"; Date)
        {
            Caption = 'Delivered in';
        }
        field(50002; "Civilité"; Option)
        {
            OptionCaption = 'Célibataire,Marié,Divorcé,Veuf';
            OptionMembers = "Célibataire","Marié","Divorcé",Veuf;
        }
        field(50003; "Délivrée à"; Code[10])
        {
            Description = 'GRH-TRIUM1.00';
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                //GL2024     PostCode.LookUpPostCode("Ville delivration", "Délivrée à", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024     PostCode.ValidatePostCode("Ville delivration", "Délivrée à");
            end;
        }
        field(50010; "Date début contrat"; Date)
        {
        }
        field(50011; "Relation de travail"; Option)
        {
            OptionMembers = " ",Stagiaire,Contractuel,Titulaire;
        }
        field(50012; Classe; Option)
        {
            OptionMembers = " ",Cadre,"Cadre de maitrise","Exécution",Apprentis,"SIVP 1","SIVP 2";
        }
        field(50015; "Lieu de naissance"; Code[10])
        {
            Description = 'GRH-TRIUM1.00';
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                //GL2024   PostCode.LookUpPostCode("Ville naissance", "Lieu de naissance", TRUE);
            end;

            trigger OnValidate()
            begin
                //GL2024   PostCode.ValidatePostCode("Ville naissance", "Lieu de naissance");
            end;
        }
        field(50101; "Affile CNSS"; Boolean)
        {
            Caption = 'Affilé CNSS';
        }
        field(50102; "Filtre Sociéte"; Option)
        {
            Caption = 'Filter Société';
            OptionMembers = " ",COG,COGNOR;
        }
        field(50107; Note; Decimal)
        {
            CalcFormula = Average("REC-Entretiens"."Note accordee" WHERE("N° Candidat" = FIELD("No."),
                                                                        "Note accordee" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(50108; "N° de Badge"; Code[10])
        {
        }
        field(50109; Poste; Option)
        {
            OptionMembers = " ",N,"1","2","3",A;
        }
        field(50110; Equipe; Code[10])
        {
            TableRelation = "Work Shift".Code;
        }
        field(50111; "Niveau D'Instruction"; Option)
        {
            OptionMembers = " ",Primaire,Secondaire,"1ier Cycle","2éme Cycle",Bac,Technicien,"Tech. sup.",Maitrise,"Ingénieur","3éme Cycle";
        }
        field(50112; Diplome; Code[50])
        {
            Caption = 'Diplôme';
        }
        field(50113; Degre; Code[10])
        {
            Caption = 'Degré';
        }
        field(50203; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility center';
            TableRelation = "Responsibility Center";
        }
        field(70002; "National Identity Card No."; Code[10])
        {
            Caption = 'National Identity Card No.';
            Numeric = true;
        }
        field(70204; "N° Demande"; Integer)
        {
            TableRelation = "REC-Recrutement des ressources" WHERE("Validation DG" = FILTER(Validee));

            trigger OnValidate()
            var
                RecLEntretient: Record 52048933;
                RecLDemande: Record "REC-Recrutement des ressources";
            begin
                RecLDemande.GET("N° Demande");
                RecLEntretient.SETRANGE("N° Candidat", "No.");
                IF NOT RecLEntretient.FINDFIRST THEN BEGIN
                    RecLEntretient.INIT;
                    RecLEntretient."N° Candidat" := "No.";
                    RecLEntretient.Evaluateur := RecLDemande.Evaluateur;
                    RecLEntretient."Date entretien" := RecLDemande."Date Entretien";
                    RecLEntretient."N°Demande" := "N° Demande";
                    RecLEntretient.INSERT(TRUE);
                    RecLEntretient.CALCFIELDS("Nom Evaluateur");
                END;
            end;
        }
        field(70205; "Ponits forts"; Text[250])
        {
        }
        field(70206; "Ponits faibles"; Text[250])
        {
        }
        field(70207; "Avis chef service"; Text[250])
        {
        }
        field(70208; "Avis directeur service"; Text[250])
        {
        }
        field(70209; "Candidat CV"; Text[250])
        {
            Caption = 'Employment contract';
        }
        field(70210; Statut; Option)
        {
            Editable = true;
            OptionCaption = 'En attente,Non Accepté,Accepté';
            OptionMembers = "En attente","Non accepte",Accepte;
        }
        field(70211; "Nbr. entretiens"; Integer)
        {
            CalcFormula = Max("REC-Entretiens"."N° Entretien" WHERE("N° Candidat" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70212; "Ville naissance"; Text[30])
        {
            Editable = false;
        }
        field(70213; "Ville delivration"; Text[30])
        {
            Editable = false;
        }
        field(70314; "Fin Periode essai"; Date)
        {
            Caption = 'Fin Période essai';
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Search Name")
        {
        }
        key(STG_Key3; Status, "Union Code")
        {
        }
        key(STG_Key4; Status, "Emplymt. Contract Code")
        {
        }
        key(STG_Key5; "Last Name", "First Name", "Middle Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Entretien.SETRANGE(Entretien."N° Candidat", "No.");
        Entretien.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Candidat Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        HumanResSetup: Record 5218;
        PostCode: Record 225;
        confMess: Label 'Apply Basis salary from Salary grid.';
        Text001: Label 'Cette grille n''est plus valide, veuillez mettre à jour la grille et les contrats !';
        Entretien: Record 52048933;
        NoSeriesMgt: Codeunit 396;


    procedure FullName(): Text[100]
    begin
        IF "Middle Name" = '' THEN
            EXIT("First Name" + ' ' + "Last Name")
        ELSE
            EXIT("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}

