TableExtension 50137 EmployeeEXT extends Employee
{
    //  DataCaptionFields = No.,First Name,Middle Name,Last Name;
    fields
    {
        modify("Employee Posting Group")
        {
            trigger OnafterValidate()
            begin
                CalcFields("Employee Posting Group DESC");
                "Employee Posting Group2" := "Employee Posting Group"
            end;
        }
        /*GL2024 modify("Job Title")
            {

                CalcFormula = Lookup(Qualification.Description WHERE(Code = FIELD(Qualification Code)));
                FieldClass = FlowField;

                Editable = false;
            }*/

        // modify("Global Dimension 2 Filter")
        // {
        //     //GL2024 TableRelation = "Dimension Value".Code where("Dimension Code" = filter('ATELIERS 2'));
        //  //   CaptionClass = '1,3,3';
        // }


        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                "N° Badge" := "No.";
                /*  {EmpCont.RESET;
                  EmpCont.Code  := "No.";
                  EmpCont.Description := "First Name" +' '+ "Last Name";
                  EmpCont.INSERT;} */
            end;
        }

        modify("Last Name")
        {
            trigger OnBeforeValidate()
            begin

                EmpCont.RESET;
                EmpCont.SETRANGE(Code, "No.");
                IF EmpCont.FIND('-') THEN BEGIN
                    EmpCont.Description := "First Name" + ' ' + "Last Name";
                    EmpCont.MODIFY;
                END

            end;
        }


        modify("First Name")
        {
            trigger OnBeforeValidate()
            begin

                EmpCont.RESET;
                EmpCont.SETRANGE(Code, "No.");
                IF EmpCont.FIND('-') THEN BEGIN
                    EmpCont.Description := "First Name" + ' ' + "Last Name";
                    //   EmpCont.Description := "First Name" + "Last Name";
                    EmpCont.MODIFY;
                END
            end;
        }

        /*  modify("Social Security No.")
          {
              trigger OnBeforeValidate()
              begin
                  IF STRLEN("Social Security No.") <> 10 THEN ERROR(Text004);
                  Employee.RESET;
                  Employee.SETRANGE("Social Security No.", "Social Security No.");
                  IF Employee.FIND('-') THEN ERROR(ERROR03, Employee."No.");

              end;
          }*/

        modify(Gender)
        {
            Caption = 'Sexe';
            trigger OnBeforeValidate()
            begin
                //GL2024   IF "Family Situation A" = "Family Situation A"::Married THEN
                IF "Marital Status" = "Marital Status"::Married THEN
                    IF Gender = Gender::Male THEN
                        "Familly chief" := TRUE
                    ELSE
                        "Familly chief" := FALSE
            end;
        }

        modify("Country/Region Code")
        {
            Caption = 'Country Code';
            trigger OnAfterValidate()
            begin
                Country1.RESET;
                IF Country1.GET("Country/Region Code") THEN
                    County := Country1.Name;
            end;
        }
        modify("Emplymt. Contract Code")
        {
            trigger OnAfterValidate()
            BEGIN
                EmploymentContract.GET("Emplymt. Contract Code");
                "Employee's name Contrat" := EmploymentContract.Description;
                "Employee's Type Contrat" := EmploymentContract."Employee's type Contrat";
            END;
        }

        modify("Statistics Group Code")
        {
            trigger OnAfterValidate()
            begin
                EmployeeStatisticsGroup.RESET;
                IF EmployeeStatisticsGroup.GET("Statistics Group Code") THEN
                    "Statistic Gpe Descrip" := EmployeeStatisticsGroup.Description;
                "Departement Code" := EmployeeStatisticsGroup.Departement;
            end;

        }
        modify("Global Dimension 1 Code")
        {
            trigger OnAfterValidate()
            begin
                CALCFIELDS("Global Dimension 1 desc");
                MODIFY;

            end;
        }

        modify("Global Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                CALCFIELDS("Global Dimension 1 desc");
                MODIFY;

            end;
        }


        modify("Marital Status")
        {
            Caption = 'Situation de famille A';

            trigger OnBeforeValidate()
            begin

                // ALTEK
                //GL2024  IF Sex = Sex::Male THEN
                //GL2024   IF "Family Situation A" = "Family Situation A"::Married THEN
                IF Gender = Gender::Male THEN
                    IF "Marital Status" = "Marital Status"::Married THEN
                        "Familly chief" := TRUE
                    ELSE
                        "Familly chief" := FALSE
            end;
        }

        field(50000; "Relation de travail"; Option)
        {
            OptionMembers = " ",Stagiaire,Contractuel,Titulaire;

            trigger OnValidate()
            begin
                //   Message('Veuillez vérifié le Contrat de travail pour le salarié %1', "No.");
            end;
        }
        field(50001; "Non Utilisé"; Code[8])
        {

            /*  trigger OnValidate()
              begin
                  if StrLen("N° CIN") <> 8 then Error(Text002);
                  Employee.Reset;
                  Employee.SetRange("N° CIN", "N° CIN");
                  if Employee.Find('-') then Error(ERROR01, Employee."No.");
              end;*/
        }
        field(50002; "N° Passeport"; Code[10])
        {
        }
        field(50003; "N° CAVIS"; Code[20])
        {
        }
        field(50004; "Lieu CIN"; Text[30])
        {
            Caption = 'Lieu CIN';
            Description = '\\Mehdi MSF';
        }
        field(50005; "Birth place A"; Text[30])
        {
            Caption = 'Lieu Naissance A';
            Description = '\\Mehdi MSF';
        }
        field(50006; "Nombre de contrat"; Integer)
        {
            CalcFormula = count("Carière Enreg" where(Type = filter(Recrutement | "Renouvellement Contrat"),
                                                          Status = const(Active),
                                                          employee = field("No.")));
            FieldClass = FlowField;
        }
        field(50007; "Niveau D'Instruction"; Option)
        {
            Description = '//MBY ENDA';
            OptionMembers = " ",Primaire,Secondaire,"1ier Cycle","2éme Cycle",Bac,Technicien,"Tech. sup.",Maitrise,"Ingénieur","3éme Cycle";
        }
        field(50008; Diplome; Code[50])
        {
            Caption = 'Diplôme';
            Description = '//MBY ENDA';
        }
        field(50009; "Selection demande"; Boolean)
        {
            Caption = 'Selection demande';
            Description = '//MBY ENDA';
        }
        field(50010; "Catégorie soc."; Option)
        {
            OptionMembers = "Hors catégorie","Catégorie société";
        }
        field(50011; Selection; Boolean)
        {
            Description = '//MBY ENDA';
        }
        field(50012; "Année Diplome"; Integer)
        {
            Description = '//MBY ENDA';
        }
        field(50013; Fonction; Text[60])
        {
            Caption = 'Fonction';
            Description = '//MBY ENDA';
        }
        field(50014; "CIN Délivrée le"; Date)
        {
            Description = '//MBY SMD';
        }
        field(50015; "Nombre de Charge"; Decimal)
        {
            Description = 'AGA DSFT 23/08/2012';
        }
        field(50016; "Nombre Salaire Preavis"; Integer)
        {
        }
        field(50017; "Moyenne 6 Dernier Salaire Brut"; Decimal)
        {
        }
        field(50018; Direction; Code[20])
        {
        }
        field(50019; "Heure Supp Sbase+Sursalaire"; Boolean)
        {
            Description = 'HJ GRP SORO';
        }
        field(50021; "Description Direction"; Text[50])
        {
            Description = '//MBY ENDA';
        }
        field(50022; Service; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service),
                                               Departement = FIELD("Departement Code"));

            trigger OnValidate()
            begin
                EmployeeStatisticsGroup.RESET;
                IF EmployeeStatisticsGroup.GET(Service) THEN;
                "Service Code" := EmployeeStatisticsGroup.Service;
                "Description Service" := EmployeeStatisticsGroup.Description;
            end;
        }
        field(50023; "Description Service"; Text[50])
        {
            Description = '//MBY ENDA';
            Editable = false;
        }
        field(50024; Section; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Section),
                                               Departement = FIELD("Departement Code"),
                                               Service = FIELD("Service Code"));

            trigger OnValidate()
            begin
                EmployeeStatisticsGroup.RESET;
                IF EmployeeStatisticsGroup.GET(Section) THEN;
                "Description Section" := EmployeeStatisticsGroup.Description;
            end;
        }
        field(50025; "Description Section"; Text[50])
        {
            Description = '//MBY ENDA';
            Editable = false;
        }
        field(50026; "Expérience Professionnelle"; Integer)
        {
            Description = '//MBY ENDA';
        }
        field(50027; "Somme Indemnités"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Default Indemnities"."Default amount" WHERE("Employment Contract Code" = FIELD("Emplymt. Contract Code"),
                                                                            Type = CONST(Imposable)));
            Caption = 'Somme Indemnités';
            Editable = true;
            FieldClass = FlowField;
        }
        field(50028; "Cumul Salaire Brut"; Decimal)
        {
            CalcFormula = Sum("Rec. Salary Lines"."Gross Salary" WHERE(Employee = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50029; "Cumul Salaire Net Imposable"; Decimal)
        {
            CalcFormula = Sum("Rec. Salary Lines"."Salaire Net Imposable" WHERE(Employee = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50030; "Caisse fond social"; Boolean)
        {
        }
        field(50031; "Cumul Charge Salariale"; Decimal)
        {
            CalcFormula = Sum("Rec. Social Contributions"."Real Amount : Employee" WHERE(Employee = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50032; "Cumul Charge Patronale"; Decimal)
        {
            CalcFormula = Sum("Rec. Social Contributions"."Real Amount : Employer" WHERE(Employee = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50033; "Cumul Mois Travaillé"; Integer)
        {
            CalcFormula = Count("Rec. Salary Lines" WHERE(Employee = FIELD("No."),
                                                           Month = FILTER(< "13ème")));
            FieldClass = FlowField;
        }
        field(50034; "Departement Code"; Code[20])
        {
        }
        field(50035; "Service Code"; Code[20])
        {
        }
        field(50036; "Montant Congé Payé"; Decimal)
        {
            Caption = 'Montant Congé Payé';
        }
        field(50037; "Nombre Mois Congé Payé"; Decimal)
        {
        }
        field(50041; "Date Filter recup"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50042; "Salaire Net Simulé"; Decimal)
        {
        }
        field(50043; "Salaire Net Contrat"; Decimal)
        {
        }
        field(50044; "Num Mobile Money"; code[20])
        {
        }
        field(50110; "Domiciliation bancaire"; Boolean)
        {
        }
        field(50111; RIB; Code[25])
        {
        }
        field(50112; "Date de domiciliation"; Date)
        {
        }
        field(50113; "Délivrée le"; Date)
        {
        }
        field(50114; "Appliquer Retenue SNP"; Boolean)
        {
            Description = 'Mehdi Haddad SORO 19-04-2024';
        }
        field(50200; "Mode de règlement"; Option)
        {
            OptionMembers = "Espèce","Mobile money",Virement;
        }
        field(50300; "Heure début Roulement"; Time)
        {
        }
        field(50301; "date debut contrat"; Date)
        {
        }
        field(50900; Childs; Integer)
        {
            CalcFormula = Count("Employee Relative" WHERE("Employee No." = FIELD("No.")));
            Caption = 'Loaded childs';
            FieldClass = FlowField;
        }
        field(50901; "Carte Séjour"; Boolean)
        {
        }
        field(50902; "Adresee Secondaire"; Decimal)
        {
            CalcFormula = Sum("Alternative Address"."Nbr Adresse Secondaie" WHERE("Employee No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50903; "Nationalité"; Text[30])
        {
        }
        field(50904; "Nom Conjoint"; Text[100])
        {
        }
        field(51000; "First Name soroubat"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(51001; "Job Title soroubat"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "Union Code soroubat"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51003; "Cause of Inactivity soroubat"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60007; Horaire; Boolean)
        {
        }
        field(60008; "Regime 234 Heures"; Boolean)
        {
        }
        field(60009; "Heure / Jour"; Decimal)
        {
        }
        field(60010; "SeuilHeure Sup"; Integer)
        {
        }
        field(60011; "Description Departement"; Code[20])
        {
            //  CalcFormula = Lookup("Employee Statistics Group".Departement WHERE(Code = FIELD("Departement Salarié")));
            Description = '//MBY ENDA';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(80000; "Jours de congés / Mois"; Decimal)
        {

            trigger OnLookup()
            begin
                MESSAGE('Datasoft Tunisie :\Nombre de jours de Droit congé à attribuer automatiquement lors de la validation d''une paie.');
            end;
        }
        field(80001; "Affilé ASS GRP"; Boolean)
        {
        }
        field(80002; "Employee's name Contrat"; Code[30])
        {
        }
        field(80003; "Employee's Type Contrat"; Option)
        {
            CalcFormula = Lookup("Employment Contract"."Employee's type Contrat" WHERE(Code = FIELD("Emplymt. Contract Code")));
            FieldClass = FlowField;
            OptionCaption = ' ,CDD,CDI,SIVP I 1iere Année,SIVP I 2ieme Année,SIVP II,Stagiaire,Particulier';
            OptionMembers = " ",CDD,CDI,"SIVP I 1iere Année","SIVP I 2ieme Année","SIVP II",Stagiaire,Particulier;

            trigger OnValidate()
            begin
                /*EmploymentContract.RESET;
                EmploymentContract.SETRANGE(Code,"Employee's Type Contrat");
               IF  EmploymentContract.FIND('-') THEN
              "Employee's name Contrat" := EmploymentContract.Description;
                EmploymentContract.RESET;
                EmploymentContract.SETRANGE(Code,"No.");
                IF EmploymentContract.FIND('-') THEN
                BEGIN
               // "Employee's name Contrat" := EmploymentContract.Description;
                 EmploymentContract.Code  := "No.";
                 EmploymentContract.Description    := "First Name" + '' +"Last Name";
                 EmploymentContract."Regular payments" := 12;
                 EmploymentContract."Temporary payments" := 1;
                 EmploymentContract."Adjust indemnity amount" := TRUE;
                 EmploymentContract."Employee's type"  :=  "Employee's type";
                 EmploymentContract."Regimes of work" := '48';
                 EmploymentContract."Salary grid"  := 'G 2006';
                 EmploymentContract."Take in account deductions":= TRUE;
                 IF (("Employee's Type Contrat" = 'A') OR ("Employee's Type Contrat" ='J')) THEN
                 EmploymentContract.Taxable  := FALSE
                 ELSE
                 EmploymentContract.Taxable  := TRUE;
                 EmploymentContract."Default Employment Contract"   := TRUE;
                 EmploymentContract."Appliquer Heure Supp":= TRUE;
                 EmploymentContract.MODIFY

                 END
                 ELSE
                 BEGIN
                 //EmploymentContract.Code  := "No.";
                 EmploymentContract.Description    := "First Name" + '' +"Last Name";
                 EmploymentContract."Regular payments" := 12;
                 EmploymentContract."Temporary payments" := 1;
                 EmploymentContract."Adjust indemnity amount" := TRUE;
                 EmploymentContract."Employee's type"  :=  "Employee's type";
                 EmploymentContract."Regimes of work" := '48';
                 EmploymentContract."Salary grid"  := 'G 2006';
                 IF (("Employee's Type Contrat" = 'A') OR ("Employee's Type Contrat" ='J')) THEN
                 EmploymentContract.Taxable  := FALSE
                 ELSE
                 EmploymentContract.Taxable  := TRUE;
                 EmploymentContract."Take in account deductions":= TRUE;
                 EmploymentContract."Default Employment Contract"   := TRUE;
                 EmploymentContract."Appliquer Heure Supp":= TRUE;
                 EmploymentContract.INSERT;
                 END
                 */

            end;
        }
        field(80004; "N° Badge"; Code[10])
        {
            Editable = false;
        }
        field(80005; "Report Employee en -"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(80006; "Hors Grille"; Boolean)
        {
        }
        field(80007; BR; Boolean)
        {
        }
        field(80008; "MO Attaché"; Option)
        {
            OptionMembers = " ",Carriere,"Central Enrobé","Central Beton",Prefa,GRH;
        }
        field(39001410; "Days off  Recup-"; Decimal)
        {
            CalcFormula = Sum("Employee's days off Entry"."Quantity (Days)" WHERE("Employee No." = FIELD("No."),
                                                                                   "Line type" = FILTER("Consomation Recup"),
                                                                                   "Date Validité" = FIELD("Date Filter recup")));
            Caption = 'Day off consumed recup';
            FieldClass = FlowField;
        }
        field(39001411; "Days off + Recup"; Decimal)
        {
            CalcFormula = Sum("Employee's days off Entry"."Quantity (Days)" WHERE("Employee No." = FIELD("No."),
                                                                                   "Line type" = FILTER("Droit Recuperation"),
                                                                                   "Date Validité" = FIELD("Date Filter recup")));
            Caption = 'Day off Right recup.';
            FieldClass = FlowField;
        }
        field(39001412; "Days off = Recup"; Decimal)
        {
            CalcFormula = Sum("Employee's days off Entry"."Quantity (Days)" WHERE("Employee No." = FIELD("No."),
                                                                                   "Line type" = FILTER("Droit Recuperation" | "Consomation Recup"),
                                                                                   "Date Validité" = FIELD("Date Filter recup")));
            Caption = 'Days off remaining Recup.';
            FieldClass = FlowField;
        }
        field(39001420; Grade; Integer)
        {
        }
        field(39001421; Echelle; Code[20])
        {
            TableRelation = Echelle.Echelle WHERE(Catégorie = FIELD(Catégorie));
        }
        field(39001423; Classe; Option)
        {
            OptionMembers = " ",A,B,C;
        }
        field(39001430; "N° Cate"; Code[20])
        {
        }
        field(39001440; "Date Titularisation"; Date)
        {
        }
        field(39001446; "Heures sup."; Decimal)
        {
            CalcFormula = Sum("Heures sup. m"."Nombre d'heures" WHERE("N° Salarié" = FIELD("No."),
                                                                       Date = FIELD("Date Filter"),
                                                                       "Code departement" = FIELD("Global Dimension 1 Filter"),
                                                                       "Code dossier" = FIELD("Global Dimension 2 Filter")));
            Description = 'Datasoft © - Add-on';
            FieldClass = FlowField;
            InitValue = 0;
        }
        field(39001450; "Date Debut Roulement"; Date)
        {
        }
        field(39001460; "Heures sup. validées"; Decimal)
        {
            CalcFormula = Sum("Heures sup. eregistrées m"."Nombre d'heures" WHERE("N° Salarié" = FIELD("No."),
                                                                                   Date = FIELD("Date Filter"),
                                                                                   "Code departement" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Code dossier" = FIELD("Global Dimension 2 Filter")));
            Description = 'Datasoft © - Add-on';
            FieldClass = FlowField;
        }
        field(39001468; "Type Calcul"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'en %,Montant';
            OptionMembers = "en %",Montant;
        }
        field(39001469; "Montant Note"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum(Note1.Note WHERE(Année = FIELD("Filtre Année"),
                                                Trimestre = FIELD(Trimestre),
                                                "N° Salariée" = FIELD("No."),
                                                "Type Note" = FIELD("Type Note")));
            FieldClass = FlowField;
        }
        field(39001470; Note; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate()
            var
                "//DSFT-AGA 15/03/2010": Integer;
            //   ParamPrimeRendement: Record 39001509;
            begin
            end;
        }
        field(39001471; "Type Note"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Rendement,Qualité de rendement,Assiduité et Ponctualité,Conduite,Polyvalence, ';
            OptionMembers = Rendement,"Qualité de rendement","Assiduité et Ponctualité",Conduite,Polyvalence," ";
        }
        field(39001472; Trimestre; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,1ère,2ème,3ème,4ème';
            OptionMembers = " ","1ère","2ème","3ème","4ème";
        }
        field(39001473; "Filtre Année"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(39001474; "Note enreg."; Decimal)
        {
            CalcFormula = Sum("Note Enreg1.".Note WHERE(Année = FIELD("Filtre Année"),
                                                         Trimestre = FIELD(Trimestre),
                                                         "N° Salariée" = FIELD("No."),
                                                         "Type Note" = FIELD("Type Note")));
            FieldClass = FlowField;
        }
        field(39001475; "Montant Note enreg."; Decimal)
        {
            CalcFormula = Sum("Note Enreg1.".Note WHERE(Année = FIELD("Filtre Année"),
                                                         Trimestre = FIELD(Trimestre),
                                                         "N° Salariée" = FIELD("No."),
                                                         "Type Note" = FIELD("Type Note")));
            FieldClass = FlowField;
        }
        field(39001480; "Indemnité imposable"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Sum("Default Indemnities"."Basis amount" WHERE("Employment Contract Code" = FIELD("Emplymt. Contract Code"),
                                                                          Type = FILTER(<> "Non imposable"),
                                                                          "Indemnité conventionnelle" = FILTER(true)));
            Caption = 'Gross Salary';
            Editable = true;
            FieldClass = FlowField;
        }
        field(39001490; "Filtre Mois de compta."; Option)
        {
            Caption = 'Posting Month';
            FieldClass = FlowFilter;
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
        }
        field(39001491; "Filtre Année de compta."; Integer)
        {
            Caption = 'Posting Year';
            FieldClass = FlowFilter;
        }
        field(39001492; Charge; Option)
        {
            OptionMembers = Fixe,Variable,"Fixe/Variable";
        }
        field(39001493; "Basis salary"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Basis salary';
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                IF NOT "Hors Grille" THEN
                    ERROR('Hors grille doit être à oui pour modifier !');

                IF "Hors Grille" THEN
                    IF NOT CONFIRM('Changer le Salaire de Base?') THEN
                        ERROR('Salaire de Base conservé à sa valeur initiale !');

                //AGA 08 03 10


                IF EmploymentContract.GET("Emplymt. Contract Code") THEN BEGIN
                    EmploymentContract.GET("Emplymt. Contract Code");
                    RégimeOfWork.GET(EmploymentContract."Regimes of work");

                    DefaultIndemnity.SETFILTER("Employment Contract Code", "No.");
                    DefaultIndemnity.SETFILTER("% salaire de base", '%1', TRUE);
                    IF DefaultIndemnity.FIND('-') THEN
                        REPEAT
                            IF "Employee's type" = 0 THEN
                                DefaultIndemnity."Default amount" := "Basis salary" * DefaultIndemnity."Taux % salaire de base"
                            ELSE
                                DefaultIndemnity."Default amount" := ("Basis salary" / RégimeOfWork."Work Hours per month") * DefaultIndemnity."Taux % salaire de base";
                            DefaultIndemnity.MODIFY;
                        UNTIL DefaultIndemnity.NEXT = 0;
                END;
                IF "Basis salary" > 0 THEN
                    IF "Employee's type" = 0 THEN
                        "Reel Basis salary" := "Basis salary" * RégimeOfWork."Work Hours per month"
                    ELSE
                        "Reel Basis salary" := "Basis salary";
                //<<AGA
                MODIFY;
            end;
        }
        field(39001494; "Employee's type"; Option)
        {
            Caption = 'Employee''s type';
            OptionCaption = 'Base Horaire,Base Mensuelle';
            OptionMembers = "Hour based","Month based";
        }
        field(39001495; "N° Pièce D'identité"; Code[8])
        {
            Caption = 'National Identity Card No.';
            Description = 'BSK 26-06-2012';
            Numeric = false;

            trigger OnValidate()
            begin
                Employee.RESET;
                //MESSAGE(Employee."National Identity Card No.");
                Employee.SETRANGE("N° Pièce D'identité", "N° Pièce D'identité");
                IF Employee.FIND('-') THEN
                    ERROR(ERROR01, Employee."No.");
                //>>MBY 14/05/2009
                //recherche dans les autre societe
                txtcompany := COMPANYNAME;

                /*IF RecGCompany.FIND('-') THEN
                  REPEAT
                    ReCGEmployee.CHANGECOMPANY(RecGCompany.Name);
                    IF RecGCompany.Name <> txtcompany THEN
                    BEGIN
                      ReCGEmployee.RESET;
                      ReCGEmployee.SETRANGE("National Identity Card No.","National Identity Card No.");
                      IF ReCGEmployee.FIND('-') THEN
                        MESSAGE(ERROR02,ReCGEmployee."No.",RecGCompany.Name);
                    END;
                  UNTIL RecGCompany.NEXT=0;
                  CLEARALL;
                //<<MBY 14/05/2009
                //>>MBY 14/04/2009
                  "N° Badge" := "National Identity Card No.";
                //<<MBY
                */

            end;
        }
        field(39001496; "Passport No."; Code[10])
        {
            Caption = 'Passport No.';
        }
        field(39001497; "Employee Posting Group2"; Code[30])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(39001498; "Catégorie"; Code[10])
        {
            Caption = 'Catégorie';
            TableRelation = CATEGORIES;

            trigger OnValidate()
            begin
                EXIT;
                HumanResSetup.FIND('-');
                EmploymentContract.GET("Emplymt. Contract Code");

                IF NOT CONFIRM('Changer le Salaire de Base?') THEN
                    ERROR('Salaire de Base conservé à sa valeur initiale !') ELSE BEGIN
                    Linegrid.SETFILTER(Linegrid.Code, '%1', EmploymentContract."Salary grid");
                    Linegrid.SETFILTER(Catégorie, '%1', Catégorie);
                    Linegrid.SETFILTER(Echelons, '%1', Echelons);
                    IF Linegrid.FIND('-') THEN
                        "Basis salary" := Linegrid."Salaire de base"
                    ELSE
                        "Basis salary" := 0;
                END
            end;
        }
        field(39001499; Echelons; Code[10])
        {
            Caption = 'Echelons';
            TableRelation = Echelle.Echelle WHERE(Catégorie = FIELD(Catégorie));

            trigger OnValidate()
            begin
                HumanResSetup.FIND('-');
                EmploymentContract.GET("Emplymt. Contract Code");
                Linegrid.SETFILTER(Catégorie, '%1', Catégorie);
                Linegrid.SETFILTER(Echelons, '%1', Echelons);
                IF Echelons <> '' THEN
                    Linegrid.SETRANGE(Echelons, Echelons);
                IF Linegrid.FIND('-') THEN
                    "Basis salary" := Linegrid."Salaire de base"
                ELSE
                    "Basis salary" := 0;
                "Reel Basis salary" := "Basis salary";
                EXIT;
                IF NOT CONFIRM('Changer le Salaire de Base?') THEN
                    ERROR('Salaire de Base conservé à sa valeur initiale !') ELSE BEGIN
                    // Linegrid.SETFILTER(Linegrid.Code,'%1',EmploymentContract."Salary grid");
                    Linegrid.SETFILTER(Catégorie, '%1', Catégorie);
                    Linegrid.SETFILTER(Echelons, '%1', Echelons);
                    IF Echelons <> '' THEN
                        Linegrid.SETRANGE(Echelons, Echelons);
                    IF Linegrid.FIND('-') THEN
                        "Basis salary" := Linegrid."Salaire de base"
                    ELSE
                        "Basis salary" := 0;
                    "Reel Basis salary" := "Basis salary"
                END;
            end;
        }
        field(39001500; "Entry date Cat/Echelon"; Date)
        {
            Caption = 'Entry date Cat/Echelon';
        }
        field(39001501; "Upgrading date Cat/Echelon"; Date)
        {
            Caption = 'Upgrading date Cat/Echelon';
        }
        field(39001502; "Familly chief"; Boolean)
        {
            Caption = 'Familly chief';
        }
        field(39001503; "Deduction Loaded child"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Employee Relative"."Associated deduction" where("Employee No." = field("No."),
                                                                                "Associated deduction" = filter(> 0)));
            Caption = 'Deduction Loaded child';
            Description = '\\Sum("Employee Relative".Field8099000 WHERE (Employee No.=FIELD(No.),Field8099000=FILTER(>0)))';
            FieldClass = FlowField;
        }
        field(39001504; "Loaded childs"; Integer)
        {
            CalcFormula = count("Employee Relative" where("Employee No." = field("No.")));
            Caption = 'Enfants à charge';
            Description = '\\Count("Employee Relative" WHERE (Employee No.=FIELD(No.),Field8099000=FILTER(>0)))';
            FieldClass = FlowField;
        }
        field(39001505; "Total validated Absence"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry".Quantity where("Employee No." = field("No."),
                                                                          "To Date" = field("Date Filter"),
                                                                          "Cause of Absence Code" = field("Cause of Absence Filter")));
            Caption = 'Total validated Absence';
            FieldClass = FlowField;
        }
        field(39001506; "Non paid days"; Decimal)
        {
            CalcFormula = - sum("Employee's days off Entry"."Quantity (Days)" where("Employee No." = field("No."),
                                                                                    "Line type" = filter("Deductible of salary"),
                                                                                    "Posting year" = field("Filtre Année")));
            Caption = 'Non paid days';
            FieldClass = FlowField;
        }
        field(39001507; "Days off -"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Quantity (Days)" where("Employee No." = field("No."),
                                                                                   "Line type" = filter("Day off Consumption"),
                                                                                   "Posting year" = field("Filtre Année")));
            Caption = 'Consommation congé';
            FieldClass = FlowField;
        }
        field(39001508; "Days off +"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Quantity (Days)" where("Employee No." = field("No."),
                                                                                   "Line type" = filter("Day off Right"),
                                                                                   "Posting year" = field("Filtre Année")));
            Caption = 'Droit congé';
            FieldClass = FlowField;
        }
        field(39001509; "Days off ="; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Quantity (Days)" where("Employee No." = field("No."),
                                                                                   "Line type" = filter("Day off Right" | "Day off Consumption"),
                                                                                   "Posting year" = field(upperlimit("Filtre Année"))));
            Caption = 'Solde jours de congés';
            FieldClass = FlowField;
        }
        field(39001510; "Proposed Work Hours"; Decimal)
        {
            Caption = 'Proposed Work Hours';
        }
        field(39001511; "Recorded Supp. Hours"; Decimal)
        {
            Caption = 'Recorded Supp. Hours';
        }
        field(39001512; "Recorded Normal Hours"; Decimal)
        {
            Caption = 'Recorded Normal Hours';
        }
        field(39001513; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(39001514; "Application Method2"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(39001515; "Default Bank Account Code"; Code[10])
        {
            Caption = 'Default Bank Account';
            TableRelation = "Employee Bank Account".Code where("Employee No." = field("No."));

            trigger OnValidate()
            begin
                if "Default Bank Account Code" <> '' then begin
                    Bnk.Reset;
                    Bnk.SetRange("Employee No.", "No.");
                    Bnk.SetRange(Code, "Default Bank Account Code");
                    if Bnk.Find('-') then
                        RIB := Bnk."Bank Branch No." + Bnk."Agency Code" + Bnk."Bank Account No." + Bnk."RIB Key";
                end;
            end;
        }
        field(39001516; "Currency Code2"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(39001517; "Total Gross salary"; Decimal)
        {
            CalcFormula = sum("Rec. Salary Lines"."Gross Salary" where(Employee = field("No."),
                                                                        Quarter = field("Quarter filter"),
                                                                        Year = field("Year filter")));
            Caption = 'Total Gross salary';
            FieldClass = FlowField;
        }
        field(39001518; "Total Taxable salary"; Decimal)
        {
            CalcFormula = sum("Rec. Salary Lines"."Taxable salary" where(Employee = field("No."),
                                                                          Quarter = field("Quarter filter"),
                                                                          Year = field("Year filter")));
            Caption = 'Total Taxable salary';
            FieldClass = FlowField;
        }
        field(39001519; "Year filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(39001520; "Quarter filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionMembers = "1st","2nd","3rd","4th";
        }
        field(39001521; Blocked; Boolean)
        {
            Caption = 'Bloqué';
        }
        field(39001522; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //GL3900 
            /*   CalcFormula = sum("Detailed Employee Ledg. Entry"."Debit Amount" where("Employee No." = field("No."),
                                                                                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = field("Date Filter")));*/ //GL3900 
            Caption = 'Debit Amount';
            Editable = false;
            //   FieldClass = FlowField;
        }
        field(39001523; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //GL3900 
            /*    CalcFormula = sum("Detailed Employee Ledg. Entry"."Credit Amount" where("Employee No." = field("No."),
                                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                         "Posting Date" = field("Date Filter")));*/ //GL3900 
            Caption = 'Credit Amount';
            Editable = false;
            //   FieldClass = FlowField;
        }
        field(39001524; "Loans balance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Entry".Amount where(Employee = field("No."),
                                                                   Type = filter(Loan),
                                                                   Status = filter("In progress"),
                                                                   "Last Date Modified" = field("Date Filter")));
            Caption = 'Solde Prêts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39001525; "Advances balance"; Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = sum("Loan & Advance Entry".Amount where(Employee = field("No."),
                                                                   Type = filter(Advance),
                                                                   Status = filter("In progress"),
                                                                   "Last Date Modified" = field("Date Filter")));
            Caption = 'Solde Avances';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39001526; "Statistic Gpe Descrip"; Text[30])
        {
        }
        field(39001527; "Compte Bancaire Societe"; Code[10])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(39001528; "Montant Assurance"; Decimal)
        {
            CalcFormula = Sum("Parametrage Image"."Derniere Sequence" WHERE("Dernier Document" = FIELD("No.")));
            DecimalPlaces = 3 : 3;
            FieldClass = FlowField;
        }
        field(39001529; "Global Dimension 1 desc"; Text[50])
        {
            CalcFormula = max("Dimension Value".Name where("Global Dimension No." = const(1),
                                                            Code = field("Global Dimension 1 Code")));
            //  CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                Modify;
            end;
        }
        field(39001530; "Global Dimension 2 desc"; Text[50])
        {
            CalcFormula = max("Dimension Value".Name where("Global Dimension No." = const(2),
                                                            Code = field("Global Dimension 2 Code")));
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                //MODIFY;
            end;
        }
        field(39001531; "Employee Posting Group DESC"; Text[60])
        {
            CalcFormula = Max("Employee Posting Group".Description WHERE(Code = FIELD("Employee Posting Group")));
            FieldClass = FlowField;
        }
        field(39001532; "Qualification Code"; Code[10])
        {
            Caption = 'Code Qualification';

            trigger OnValidate()
            begin
                //  CalcFields("Job Title");
            end;
        }
        field(39001533; "Reel Basis salary"; Decimal)
        {
            Caption = 'Salaire de base reél';
        }
        field(39001534; Pourcentage; Decimal)
        {
        }
        field(39001535; "Total Indemnité jour congé"; Decimal)
        {
            CalcFormula = sum("Default Indemnities"."Basis amount" where("Employment Contract Code" = field("No."),
                                                                           "Evaluation mode" = FILTER(< "Nombre X Montant par défaut"),
                                                                          "Non Inclue en jours congé" = filter(False)));
            Description = '// somme des indemnités pour calcul du jour de congé';
            FieldClass = FlowField;
        }
        field(39001536; "Date denier passage Cat/ech"; Date)
        {
        }


        field(39001537; "No. 2"; Code[20])
        {
            Caption = 'No. 2';


        }
    }
    keys
    {

        key(STG_Key6; "Social Security No.")
        {
        }
        // key(STG_Key7; "National Identity Card No.")
        // {
        // }

        key(STG_Key8; "Statistics Group Code", "No.")
        {
        }
        // key(STG_Key9; "Intervenir SAV")
        // {
        //     SumIndexFields = "Salaire Brut";
        // }

        // /*GL2024   key(STG_Key10;Affectation,"No.")
        //    {
        //    }

        //    key(STG_Key11;"Collège","No.")
        //    {
        //    }*/
        // key(STG_Key12; Qualification)
        // {
        // }
    }

    trigger OnAfterInsert()
    var
        EmplBkAcc: Record "Employee Bank Account";
    begin
        IF CONFIRM('Voulez-vous créé un nouveau salarié') THEN BEGIN
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Employee Nos.");
                NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            END;

            /*  "Employee's type" := "Employee's type"::"Month based";
              "Employee Posting Group" := 'SALARIER';
              "Relation de travail" := "Relation de travail"::Contractuel;*/
            DimMgt.UpdateDefaultDim(
             DATABASE::Employee, "No.",
             "Global Dimension 1 Code", "Global Dimension 2 Code");
            /*pour importation
                              EmpCont.RESET;
                              EmpCont.Code  := "No.";
                              EmpCont.Description := "First Name" +' '+ "Last Name";
                              EmpCont.INSERT;
                          */
            EmpCont.RESET;
            EmpCont.Code := "No.";
            EmpCont.Description := "First Name" + ' ' + "Last Name";
            EmpCont."Default Employment Contract" := TRUE;
            EmpCont."Salary grid" := HumanResSetup."Code Grille par défaut";
            /* EmpCont."Regular payments" := 12;
             EmpCont."Employee's type Contrat" := 1; // CDD;
             EmpCont."Employee's type" := 1;// MENSUEL;
             EmpCont."Regimes of work" := 'REGIME01';
             EmpCont."Slice of imposition" := 'T1';
             EmpCont.Taxable := TRUE;
             EmpCont."Take in account deductions" := TRUE;
             EmpCont."Appliquer Heure Supp" := TRUE;
             EmpCont."Type Calendar" := 1; ///'Administratif';
             EmpCont."Code Calendar" := 'SERVICE';
             EmpCont."Salary grid" := 'GRI-0001';*/
            EmpCont.INSERT;

            "Emplymt. Contract Code" := "No.";

            EmplBkAcc."Employee No." := "No.";
            EmplBkAcc.Code := "No.";
            "Default Bank Account Code" := "No.";
            EmplBkAcc.INSERT;
            /* indemnités.SETRANGE(Acquis, TRUE);
             IF indemnités.FINDFIRST THEN
                 REPEAT
                     DefaultIndemnity."Employment Contract Code" := "No.";
                     DefaultIndemnity.VALIDATE("Indemnity Code", indemnités.Code);
                     DefaultIndemnity."Inclus dans heures supp" := FALSE;
                     DefaultIndemnity."Inclure Calcul Exo Impot" := TRUE;
                     IF DefaultIndemnity.INSERT THEN;
                 UNTIL indemnités.NEXT = 0;
             IF SocialContribution.FINDFIRST THEN
                 REPEAT
                     DefaultSocialContribution."Employment Contract Code" := "No.";
                     DefaultSocialContribution."Social Contribution Code" := SocialContribution.Code;
                     DefaultSocialContribution."Employer's part" := SocialContribution."Employer's part";
                     DefaultSocialContribution."Employee's part" := SocialContribution."Employee's part";
                     DefaultSocialContribution."Basis of calculation" := SocialContribution."Basis of calculation";
                     DefaultSocialContribution."Deductible of taxable basis" := SocialContribution."Deductible of taxable basis";
                     DefaultSocialContribution."Forfait salarial" := SocialContribution."Forfait salarial";
                     DefaultSocialContribution."Forfait patronal" := SocialContribution."Forfait patronal";
                     DefaultSocialContribution."Maximum value - Employee" := SocialContribution."Maximum value - Employee";
                     DefaultSocialContribution."Maximum value - Employer" := SocialContribution."Maximum value - Employer";
                     DefaultSocialContribution."Mode dévaluation" := SocialContribution."Mode dévaluation";
                     IF DefaultSocialContribution.INSERT THEN;
                 UNTIL SocialContribution.NEXT = 0;*/
        END ELSE
            ERROR('');
        // "Last Date Modified" := WORKDATE;

        // "User ID" := USERID;
    end;



    trigger OnBeforeModify()
    begin
        "N° Badge" := "No.";
        //<<MBY
        "Last Date Modified" := TODAY;

    end;


    trigger OnBeforeDelete()
    begin
        //EXIT;
        RecSalaryLines.SETRANGE(Employee, "No.");
        IF RecSalaryLines.FINDFIRST THEN
            ERROR('Vous ne pouvez pas supprimer l''employ‚  %1', "No.");

    end;

    /*  trigger OnAfterDelete()
      begin
          Bnk.SETRANGE("Employee No.", "No.");
          Bnk.DELETEALL;

          EmploymentContract.SETRANGE(Code, "No.");
          EmploymentContract.DELETEALL;

          DefaultIndemnity.SETRANGE("Employment Contract Code", "No.");
          DefaultIndemnity.DELETEALL;


          DefaultSocialContribution.SETRANGE("Employment Contract Code", "No.");
          DefaultSocialContribution.DELETEALL;

      end;*/

    procedure MAJDeductions()
    var
        EmployeeRelative: Record "Employee Relative";
    begin
        EmployeeRelative.SetRange("Employee No.", "No.");
        if EmployeeRelative.Find('-') then
            repeat
                if (EmployeeRelative."Holding on end date" <= WorkDate) then begin
                    EmployeeRelative."Associated deduction" := 0;
                    EmployeeRelative."User ID" := UserId;
                    EmployeeRelative."Last Date Modified" := WorkDate;
                end;
            until EmployeeRelative.Next = 0;
    end;

    procedure FullAdress() adr: Text[150]
    begin
        adr := Address + ' ' + "Address 2" + ' ' + "Post Code" + ' ' + City;
    end;



    var
        Linegrid: Record "Line grid";
        EmploymentContract: Record "Employment Contract";
        RecSalaryLines: Record "Rec. Salary Lines";
        I: Integer;
        ParamCpta: Record "General Ledger Setup";
        Country1: Record "Country/Region";
        EmpCont: Record "Employment Contract";
        Bnk: Record "Employee Bank Account";
        ERROR01: label 'Num CIN Existe pour l''employe %1';
        EmployeeStatisticsGroup: Record "Employee Statistics Group";
        RecGCompany: Record Company;
        ReCGEmployee: Record Employee;
        ERROR02: label 'Num CIN Existe pour l''employe %1 dans la société %2';
        txtcompany: Text[30];
        "RégimeOfWork": record "Regimes of work";
        DefaultIndemnity: Record "Default Indemnities";
        Service: Record Service;
        Section: Record "Tranche STC";
        Qualification: Record Qualification;
        Direction: Record Direction;
        RecQualification: Record Qualification;
        Text001: label 'Rib Incorrect';
        "indemnités": record Indemnity;
        SocialContribution: record "Social Contribution";
        DefaultSocialContribution: Record "Default Soc. Contribution";
        EmployeeRelative: Record "Employee Relative";
        Relative2: Record Relative;
        DebutFiltre: Text[3];
        FinFiltre: Text[5];
        Ligne: Integer;
        Text002: label 'CIN Doit Etre Sur 8 Caractéres';
        RecCollege: Record "CATEGORIES";
        DefaultSocContribution: Record "Default Soc. Contribution";
        Text003: label 'Il Faut Preciser le chantier de cette affectation';
        ERROR03: label 'Num CNSS Existe pour l''employe %1';
        Text004: label 'CNSS Doit Etre Sur 10 Caractéres';
        Employee: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        DimMgt: Codeunit 408;
        NoSeriesMgt: Codeunit 396;
}

