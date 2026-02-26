Table 52048909 "Etat Mensuelle Paie"
{
    //GL2024  ID dans Nav 2009 : "39001439"
    fields
    {
        field(1; "Séquence"; Integer)
        {
            // AutoIncrement = false;
        }
        field(2; Matricule; Code[10])
        {
            TableRelation = Employee."No.";
            SqlDataType = Integer;

            trigger OnValidate()
            begin
                if RecEtatMensuellePaie.Get(Rec.Matricule) then
                    Error('L''enregistrement dans la table Etat Mensuelle Paie existe déjà. Champs et valeurs d''identification : Matricule= %1', Rec.Matricule);
                GRecSalary.Reset;
                if GRecSalary.Get(Matricule) then begin
                    GCodNomPrenom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                    Nom := GCodNomPrenom;
                    "Type Salarié" := GRecSalary."Employee's type";
                    MODIFY;


                end;

            end;
        }
        field(3; Nom; Text[100])
        {
        }
        field(4; "Nom 1"; Code[10])
        {
        }
        field(5; "D.Hr sup"; Text[30])
        {
        }
        field(6; "Panier"; Decimal)
        {
            trigger OnValidate()
            begin
                //"Nbre Jours Absence" := 26 - "Jours Travaillé" - "Congé Spéciale" - Congé - Férier;
            end;
        }
        field(7; "Tot Heurs"; Decimal)
        {
        }
        field(8; "Hr nuit"; Decimal)
        {
        }
        field(9; "Heure 15"; Decimal)
        {

            trigger OnValidate()
            begin
                Salisure := Salisure + "Heure 15";
                Modify
            end;
        }
        field(10; "Heure 35"; Decimal)
        {

            trigger OnValidate()
            begin
                Salisure := Salisure + "Heure 35";
                Modify
            end;
        }
        field(11; "Présence"; Decimal)
        {

            /*  trigger OnValidate()
              begin
                  if EmploymentContract.Get(Matricule) then;
                  if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
                  "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
              end;*/
        }
        field(12; "Congé"; Decimal)
        {
            /*  trigger OnValidate()
              begin
                  "Nbre Jours Absence" := 26 - "Jours Travaillé" - "Congé Spéciale" - Congé - Férier;
              end;*/
        }
        field(13; "Férier"; Decimal)
        {
            /*trigger OnValidate()
            begin
                "Nbre Jours Absence" := 26 - "Jours Travaillé" - "Congé Spéciale" - Congé - Férier;
            end;*/
        }
        field(14; "Jour repos"; Decimal)
        {
        }
        field(15; Bage; Code[10])
        {

            trigger OnValidate()
            begin
                //>>MBY 14/04/2009
                GRecSalary.Reset;
                GRecSalary.SetRange("N° Badge", Bage);
                if GRecSalary.Find('-') then
                    Validate(Matricule, GRecSalary."No.")
                else begin
                    Matricule := '';
                    Nom := '';
                    Message('ATTENTION CIN INEXISTANTE !!!');
                end;
                //<<MBY
            end;
        }
        field(16; "Heure 50"; Decimal)
        {

            trigger OnValidate()
            begin
                Salisure := Salisure + "Heure 50";
                Modify
            end;
        }
        field(17; Semaine; Integer)
        {
        }
        field(18; Heure; Decimal)
        {
        }
        field(19; "Type Heure"; Text[30])
        {
        }
        field(20; Absence; Decimal)
        {
        }
        field(21; "Heure ferier"; Decimal)
        {
        }
        field(22; Observation; Text[30])
        {
        }
        field(23; "Suivi Modification"; Code[200])
        {
        }
        field(24; Utilisateur; Code[10])
        {
        }
        field(25; "Heure 120"; Decimal)
        {

            /* trigger OnValidate()
             begin
                 Salisure := Salisure + "Heure Sup Majoré à 100 %";
                 Modify
             end;*/
        }
        field(26; "Type Salarié"; Option)
        {
            OptionCaption = 'Base Horaire,Base Mensuelle';
            OptionMembers = "Base Horaire","Base Mensuelle";
        }
        field(27; "Heures Normal"; Decimal)
        {

            trigger OnValidate()
            begin
                Heure := "Heures Normal";
                Salisure := 0;
                PramResH.Get();
                if "Type Salarié" = 0 then
                    Salisure := Salisure + "Heures Normal"
                else
                    Salisure := Salisure + ("Heures Normal" * PramResH."From Work day to Work hour");
                Modify
            end;
        }
        field(50000; "Rembourcement frais"; Decimal)
        {
        }
        field(50001; "Heures compensation"; Decimal)
        {
        }
        field(50002; "Nombre de jour indemnité exep"; Decimal)
        {
        }
        field(50003; Salisure; Decimal)
        {
        }
        field(50004; Douche; Decimal)
        {
        }
        /*    field(50005; "Nbr Jours Deplacement"; Decimal)
            {
            }*/
        field(50011; "Heure Congé maladie"; Decimal)
        {
        }
        field(50012; "Heure accident de travail"; Decimal)
        {
        }
        field(50013; "Indemnité ration de force"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50014; "Indemnité Habillement"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50015; "Prime semestrielle"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50016; "Indemnité samedi"; Integer)
        {
        }
        field(50017; "Montant congé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50018; "Nombre Jour Prime Panier"; Decimal)
        {
            Editable = true;
        }
        field(50019; "Heure 60"; Decimal)
        {
            Editable = true;
        }
        field(50020; "Disponible"; Boolean)
        {
            Editable = false;

            // trigger OnValidate()
            // begin

            //     if PramResH.Get then;
            //     if EmploymentContract.Get(Matricule) then begin
            //         if not EmploymentContract."Appliquer Heure Supp" then exit;
            //         if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
            //         "Heure Normal" := 0;
            //         HeureCalcule := 0;
            //         "Heures Retenues" := 0;
            //         "Jours Sup Calculé Majoré à 75%" := 0;
            //         "Jours Sup Normal" := 0;
            //         "Heure Sup Majoré à 75 %" := 0;
            //         Présence := 0;
            //         "Nbr Jours Deplacement" := 0;
            //         Congé := 0;
            //         Férier := 0;
            //         "Congé Spéciale" := 0;
            //         // Premier Cas Nbr Jour < 26 And Heure Travaill < "Work Hours per month"
            //         if ("Jours Travaillé" <= 26) and ("Heure Travaillé" <= RegimesoFwork."Work Hours per month") then begin

            //             Val1 := "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour";
            //             if Val1 <= "Heure Travaillé" then begin
            //                 Val2 := "Heure Travaillé" - Val1;
            //                 if Val2 > 0 then begin
            //                     "Heure Normal" := Val2;
            //                     if Val2 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
            //                         //  "Jours Sup Normal":=Val2 DIV RegimesoFwork."Nombre Heure Par Jour";
            //                         //  "Heure Normal Supp Calculé":=Val2 MOD RegimesoFwork."Nombre Heure Par Jour";
            //                     end;
            //                 end
            //                 else begin
            //                     Val1 := "Heure Travaillé" / RegimesoFwork."Nombre Heure Par Jour";
            //                     Val2 := Val1 * RegimesoFwork."Nombre Heure Par Jour";
            //                     "Jours Travaillé" := Val1;
            //                     "Heure Normal" := "Heure Travaillé" - Val2;
            //                     if ("Heure Travaillé" - Val2) DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
            //                         //MH    "Jours Sup Normal":=("Heure Travaillé"-Val2) DIV RegimesoFwork."Nombre Heure Par Jour";
            //                         "Heure Normal" := ("Heure Travaillé" - Val2) MOD RegimesoFwork."Nombre Heure Par Jour";
            //                     end;

            //                 end;
            //                 Présence := "Jours Travaillé";
            //             end
            //             else begin
            //                 Présence := "Jours Travaillé";
            //                 "Heures Retenues" := Val1 - "Heure Travaillé";
            //             end;
            //         end;
            //         /// NE Rien a Faire

            //         // Deuxiéme Cas Nbr Jour < 26 And Heure Travaill > "Work Hours per month"

            //         if ("Jours Travaillé" <= 26) and ("Heure Travaillé" >= RegimesoFwork."Work Hours per month") then begin
            //             Présence := "Jours Travaillé";
            //             Val1 := "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour";
            //             Val2 := RegimesoFwork."Work Hours per month" - Val1;
            //             "Heure Normal" := Val2;
            //             Val3 := "Heure Travaillé" - RegimesoFwork."Work Hours per month";
            //             if Val3 > RegimesoFwork."Max. Supp. Hours per month" then Val3 := RegimesoFwork."Max. Supp. Hours per month";
            //             //MH   "Heure Sup Majoré à 75 %":=Val3;
            //             if Val3 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
            //                 //  "Jours Sup Calculé Majoré à 75%":=Val3 DIV RegimesoFwork."Nombre Heure Par Jour";
            //                 //  "Heure Sup Majoré à 75 %":=Val3 MOD RegimesoFwork."Nombre Heure Par Jour";
            //             end;

            //         end;

            //         // Troisieme Cas Nbr Jour >26 And Heure Travaill < "Work Hours per month"

            //         if ("Jours Travaillé" > 26) and ("Heure Travaillé" <= RegimesoFwork."Work Hours per month") then begin
            //             Val1 := "Heure Travaillé" / RegimesoFwork."Nombre Heure Par Jour";
            //             Val2 := Val1 * RegimesoFwork."Nombre Heure Par Jour";
            //             Val3 := "Heure Travaillé" - Val2;
            //             Présence := Val1;
            //             "Heure Normal" := Val3;
            //             if Val3 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
            //                 //MH       "Jours Sup Normal":=Val3 DIV RegimesoFwork."Nombre Heure Par Jour";
            //                 "Heure Normal" := Val3 MOD RegimesoFwork."Nombre Heure Par Jour";
            //             end;


            //         end;


            //         // Quatriemme Cas Nbr Jour >26 And Heure Travaill > "Work Hours per month"

            //         if ("Jours Travaillé" >= 26) and ("Heure Travaillé" >= RegimesoFwork."Work Hours per month") then begin
            //             if ("Heure Travaillé" - "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour") >= 0 then begin
            //                 Val1 := "Jours Travaillé";
            //                 Présence := 26;
            //                 //MH  "Jours Sup Calculé Majoré à 75%":=Val1-26;
            //                 Val2 := "Heure Travaillé" - Val1 * RegimesoFwork."Nombre Heure Par Jour";
            //                 if Val2 > RegimesoFwork."Max. Supp. Hours per month" then Val2 := RegimesoFwork."Max. Supp. Hours per month";
            //                 //MH IF Val2 >0 THEN "Heure Sup Majoré à 75 %":=Val2;

            //             end
            //             else begin
            //                 Val1 := "Heure Travaillé" - 26 * RegimesoFwork."Nombre Heure Par Jour";
            //                 Présence := 26;
            //                 //MH   "Jours Sup Calculé Majoré à 75%":=0;
            //                 Val2 := Val1;
            //                 if Val2 > RegimesoFwork."Max. Supp. Hours per month" then Val2 := RegimesoFwork."Max. Supp. Hours per month";
            //                 if Val2 > 0 then begin
            //                     //MH   "Heure Sup Majoré à 75 %":=Val2;
            //                     if Val2 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
            //                         //MH    "Jours Sup Calculé Majoré à 75%":=Val2 DIV RegimesoFwork."Nombre Heure Par Jour";
            //                         //MH     "Heure Sup Majoré à 75 %":=Val2 MOD RegimesoFwork."Nombre Heure Par Jour";
            //                     end;

            //                 end;
            //             end;

            //         end;

            //     end;
            //     if Employee.Get(Matricule) then begin
            //         if RecQualification.Get(Employee.Qualification) then
            //             if RecQualification."Sans Heure Supp" then begin
            //                 "Heure Sup Majoré à 75 %" := 0;
            //                 "Heure Normal" := 0;
            //             end;
            //     end;

            //     //IF EmploymentContract.GET(Matricule) THEN;
            //     //IF RegimesoFwork.GET(EmploymentContract."Regimes of work") THEN;

            //     //MH SORO 03-08-2020
            //     "Heure Sup BR" := 0;
            //     "Heure 25" := 0;
            //     EmploymentContract.Reset;
            //     if EmploymentContract.Get(Matricule) then begin
            //         if RegimesoFwork.Get(EmploymentContract."Regimes of work") then begin

            //             if "Heure Travaillé" > RegimesoFwork."Work Hours per month" then begin
            //                 Diff := "Heure Travaillé" - RegimesoFwork."Work Hours per month";
            //                 "Heure Travaillé" := RegimesoFwork."Work Hours per month";
            //                 "Heure Sup BR" := Diff;
            //                 "Heure 25" := Diff;
            //             end;
            //         end;
            //     end;
            //     Validate("Nombre de jour", Présence);
            //     "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
            // end;
        }
        /* field(50021; "Jours Travaillé"; Decimal)
         {

             // trigger OnValidate()
             // begin
             //     if PramResH.Get then;
             //     "Heure Normal" := 0;
             //     HeureCalcule := 0;
             //     "Heures Retenues" := 0;
             //     "Nbr Jours Deplacement" := 0;
             //     "Jours Sup Calculé Majoré à 75%" := 0;
             //     "Heure Sup Majoré à 75 %" := 0;
             //     "Heure Travaillé" := 0;
             //     if "Jours Travaillé" <= 26 then Présence := "Jours Travaillé";
             //     if "Jours Travaillé" > 26 then begin
             //         Présence := 26;
             //         "Jours Sup Calculé Majoré à 75%" := "Jours Travaillé" - 26;
             //     end;
             //     if EmploymentContract.Get(Matricule) then;
             //     if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
             //     Validate("Heure Travaillé", "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour");
             //     "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
             //     "Heures Normal" := Présence;
             //     "Nombre de jour" := Présence;
             //     if PramResH."Indemnite Kilometrage" <> '' then begin
             //         DefaultIndemnities.SetRange("Employment Contract Code", Matricule);
             //         DefaultIndemnities.SetRange("Indemnity Code", PramResH."Indemnite Kilometrage");
             //         if DefaultIndemnities.FindFirst then begin
             //             Kmetrage := PramResH."Montant Indem Kilometrage" * 10000 * Présence;
             //         end;
             //     end;
             //     "Nbre Jours Absence" := 26 - "Jours Travaillé" - "Congé Spéciale" - Congé - Férier;
             // end;
         }
         field(50022; Rappel; Decimal)
         {
             DecimalPlaces = 3 : 3;
         }
         field(50023; Retenu; Decimal)
         {
             DecimalPlaces = 3 : 3;
         }
         field(50024; Cession; Decimal)
         {
             DecimalPlaces = 3 : 3;
         }
         field(50025; Qualification; Code[20])
         {
             Description = 'HJ SORO 25-09-2014';
         }
         field(50026; Affectation; Code[20])
         {
             Description = 'HJ SORO 25-09-2014';

         }
         field(50027; "Heures Retenues"; Decimal)
         {
             Description = 'HJ SORO 22-10-2014';
             Editable = true;
         }
         field(50028; "Heure Travaillé réel"; Decimal)
         {
             Description = 'HJ SORO 28-10-2014';
         }
         field(50029; "Jours Dimanche"; Decimal)
         {
         }
         field(50030; Kmetrage; Decimal)
         {
             Description = 'RB SORO 06/02/2016';
         }
         field(50031; "Jours Sup Normal"; Decimal)
         {
             Editable = true;
         }
         field(50032; "Droit Congé"; Decimal)
         {
             Description = 'RB SORO 03/05/2016';
         }
         field(50033; "Rappel Salarié"; Decimal)
         {
             CalcFormula = lookup("Default Indemnities"."Default amount" where("Employment Contract Code" = field(Matricule),
                                                                                "Indemnity Code" = filter('443')));
             DecimalPlaces = 3 : 3;
             Description = 'RB SORO 03/05/2016';
             FieldClass = FlowField;
         }
         field(50034; "Mois Ancienté"; Decimal)
         {
         }
         field(50035; Age; Text[30])
         {
             Description = 'MH SORO 13-01-2017';
         }
         field(50036; "Heure Sup BR"; Decimal)
         {
         }
         field(50037; "Ne pas appliquer Taux %"; Boolean)
         {
             Description = 'MH SORO 12-09-2020';
         }
         field(50038; "Description Qualification"; Text[150])
         {
             Description = 'MH SORO 02-10-2023';
         }
         field(50039; "Nbre Jours Absence"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(50040; "Nbre Jours Sanction"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(50041; "Motif Sanction"; Text[150])
         {
             Description = 'MH SORO 22-04-2024';
         }*/
        field(39001490; "type calcul paie"; Option)
        {
            OptionCaption = 'Mensuel,Quinzaine';
            OptionMembers = Mensuel,Quinzaine;
        }
        field(39001491; "Nombre de jour"; Decimal)
        {
        }
        field(39001492; "Productivité"; Decimal)
        {

        }
        field(39001493; "Total nb jours"; Decimal)
        {
            CalcFormula = sum("Etat Mensuelle Paie"."Nombre de jour");

            FieldClass = FlowField;
        }
        field(39001494; "Total nb heures"; Decimal)
        {
            CalcFormula = sum("Etat Mensuelle Paie".Heure where("Type Salarié" = filter("Base Horaire")));

            FieldClass = FlowField;
        }
        field(39001495; "Nombre Salarier"; Integer)
        {
            CalcFormula = count("Etat Mensuelle Paie");
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Matricule)
        {
            Clustered = true;
            SumIndexFields = Heure, "Nombre de jour";
        }

        key(Key2; "Type Salarié")
        {
            SumIndexFields = Heure, "Nombre de jour";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Séquence = 0 then
            Séquence := 1
        else
            Séquence := xRec.Séquence + 1;
    end;

    var
        RecEtatMensuellePaie: Record "Etat Mensuelle Paie";
        DefaultIndemnities: Record "Default Indemnities";
        GCodNomPrenom: Text[100];
        GRecSalary: Record Employee;
        PramResH: Record "Human Resources Setup";
        EmploymentContract: Record "Employment Contract";
        RegimesoFwork: Record "Regimes of work";
        NombrJour: Decimal;
        NombreHeure: Decimal;
        HeureCalcule: Decimal;
        Val1: Decimal;
        Val2: Decimal;
        Val3: Decimal;

        RecQualification: Record Qualification;
        Employee: Record Employee;
        "// RB SORO": Integer;
        RecEmployeeCg: Record Employee;
        Mois: Integer;
        Annee: Integer;
        DateLimite: Date;
        Text001: label 'Erreur, Date Fin contart est %1  pour le salarié %2 %3 !!!';
        FinDeMois: Date;
        Text002: label 'Age Superieure 60 Ans Salarié %1';
        Diff: Decimal;
        RecQualification2: Record Qualification;
}

