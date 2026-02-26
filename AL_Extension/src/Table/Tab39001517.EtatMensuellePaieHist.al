// Table 39001517 "Etat Mensuelle Paie Hist"
// {
//     //GL2024  ID dans Nav 2009 : "39001517"
//     fields
//     {
//         field(1; "Séquence"; Integer)
//         {
//             AutoIncrement = false;
//         }
//         field(2; Matricule; Code[10])
//         {
//             TableRelation = Employee."No." where(Blocked = filter(False));

//             trigger OnValidate()
//             begin
//                 GRecSalary.Reset;
//                 if GRecSalary.Get(Matricule) then begin
//                     GCodNomPrenom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
//                     Nom := GCodNomPrenom;
//                     "Type Salarié" := GRecSalary."Employee's type";
//                     // IF NOT INSERT THEN MODIFY ;
//                 end;
//                 //  Affectation := GRecSalary.Affectation;
//                 //  Qualification := GRecSalary.Qualification;
//                 // RB SORO 28/04/2016
//             end;
//         }
//         field(3; Nom; Text[100])
//         {
//         }
//         field(4; "Nom 1"; Code[10])
//         {
//         }
//         field(5; "D.Hr sup"; Text[30])
//         {
//         }
//         field(6; "Congé Spéciale"; Decimal)
//         {
//         }
//         field(7; "Tot Heurs"; Decimal)
//         {
//         }
//         field(8; "Hr nuit"; Decimal)
//         {
//         }
//         field(9; "Heure 25"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 Salisure := Salisure + "Heure 25";
//                 Modify
//             end;
//         }
//         field(10; "Heure 50"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 Salisure := Salisure + "Heure 50";
//                 Modify
//             end;
//         }
//         field(11; "Présence"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 if EmploymentContract.Get(Matricule) then;
//                 if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
//                 "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
//             end;
//         }
//         field(12; "Congé"; Decimal)
//         {
//         }
//         field(13; "Férier"; Decimal)
//         {
//         }
//         field(14; "Jour repos"; Decimal)
//         {
//         }
//         field(15; Bage; Code[10])
//         {

//             trigger OnValidate()
//             begin
//                 //>>MBY 14/04/2009
//                 GRecSalary.Reset;
//                 GRecSalary.SetRange("N° Badge", Bage);
//                 if GRecSalary.Find('-') then
//                     Validate(Matricule, GRecSalary."No.")
//                 else begin
//                     Matricule := '';
//                     Nom := '';
//                     Message('ATTENTION CIN INEXISTANTE !!!');
//                 end;
//                 //<<MBY
//             end;
//         }
//         field(16; "Heure Sup Majoré à 75 %"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 Salisure := Salisure + "Heure Sup Majoré à 75 %";
//                 Modify
//             end;
//         }
//         field(17; Semaine; Integer)
//         {
//         }
//         field(18; Heure; Decimal)
//         {
//         }
//         field(19; "Type Heure"; Text[30])
//         {
//         }
//         field(20; Absence; Decimal)
//         {
//         }
//         field(21; "Heure ferier"; Decimal)
//         {
//         }
//         field(22; Observation; Text[30])
//         {
//         }
//         field(23; "Suivi Modification"; Code[200])
//         {
//         }
//         field(24; Utilisateur; Code[10])
//         {
//         }
//         field(25; "Heure Sup Majoré à 100 %"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 Salisure := Salisure + "Heure Sup Majoré à 100 %";
//                 Modify
//             end;
//         }
//         field(26; "Type Salarié"; Option)
//         {
//             OptionCaption = 'Base Horaire,Base Mensuelle';
//             OptionMembers = "Base Horaire","Base Mensuelle";
//         }
//         field(27; "Heures Normal"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 Heure := "Heures Normal";
//                 Salisure := 0;
//                 PramResH.Get();
//                 if "Type Salarié" = 0 then
//                     Salisure := Salisure + "Heures Normal"
//                 else
//                     Salisure := Salisure + ("Heures Normal" * PramResH."From Work day to Work hour");
//                 Modify
//             end;
//         }
//         field(50000; "Rembourcement frais"; Decimal)
//         {
//         }
//         field(50001; "Heures compensation"; Decimal)
//         {
//         }
//         field(50002; "Nombre de jour indemnité exep"; Decimal)
//         {
//         }
//         field(50003; Salisure; Decimal)
//         {
//         }
//         field(50004; Douche; Decimal)
//         {
//         }
//         field(50005; "Nbr Jours Deplacement"; Decimal)
//         {
//         }
//         field(50011; "Heure Congé maladie"; Decimal)
//         {
//         }
//         field(50012; "Heure accident de travail"; Decimal)
//         {
//         }
//         field(50013; "Indemnité ration de force"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50014; "Indemnité Habillement"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50015; "Prime semestrielle"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50016; "Indemnité samedi"; Integer)
//         {
//         }
//         field(50017; "Montant congé"; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50018; "Jours Sup Calculé Majoré à 75%"; Decimal)
//         {
//             Editable = true;
//         }
//         field(50019; "Heure Normal Supp Calculé"; Decimal)
//         {
//             Editable = true;
//         }
//         field(50020; "Heure Travaillé"; Decimal)
//         {

//             trigger OnValidate()
//             begin

//                 if PramResH.Get then;
//                 if EmploymentContract.Get(Matricule) then begin
//                     if not EmploymentContract."Appliquer Heure Supp" then exit;
//                     if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
//                     "Heure Normal Supp Calculé" := 0;
//                     HeureCalcule := 0;
//                     "Heures Retenues" := 0;
//                     "Jours Sup Calculé Majoré à 75%" := 0;
//                     "Jours Sup Normal" := 0;
//                     "Heure Sup Majoré à 75 %" := 0;
//                     Présence := 0;
//                     "Nbr Jours Deplacement" := 0;
//                     Congé := 0;
//                     Férier := 0;
//                     "Congé Spéciale" := 0;
//                     // Premier Cas Nbr Jour < 26 And Heure Travaill < "Work Hours per month"
//                     if ("Jours Travaillé" <= 26) and ("Heure Travaillé" <= RegimesoFwork."Work Hours per month") then begin

//                         Val1 := "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour";
//                         if Val1 <= "Heure Travaillé" then begin
//                             Val2 := "Heure Travaillé" - Val1;
//                             if Val2 > 0 then begin
//                                 "Heure Normal Supp Calculé" := Val2;
//                                 if Val2 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
//                                     "Jours Sup Normal" := Val2 DIV RegimesoFwork."Nombre Heure Par Jour";
//                                     "Heure Normal Supp Calculé" := Val2 MOD RegimesoFwork."Nombre Heure Par Jour";
//                                 end;
//                             end
//                             else begin
//                                 Val1 := "Heure Travaillé" / RegimesoFwork."Nombre Heure Par Jour";
//                                 Val2 := Val1 * RegimesoFwork."Nombre Heure Par Jour";
//                                 "Jours Travaillé" := Val1;
//                                 "Heure Normal Supp Calculé" := "Heure Travaillé" - Val2;
//                                 if ("Heure Travaillé" - Val2) DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
//                                     "Jours Sup Normal" := ("Heure Travaillé" - Val2) DIV RegimesoFwork."Nombre Heure Par Jour";
//                                     "Heure Normal Supp Calculé" := ("Heure Travaillé" - Val2) MOD RegimesoFwork."Nombre Heure Par Jour";
//                                 end;

//                             end;
//                             Présence := "Jours Travaillé";
//                         end
//                         else begin
//                             Présence := "Jours Travaillé";
//                             "Heures Retenues" := Val1 - "Heure Travaillé";
//                         end;
//                     end;
//                     /// NE Rien a Faire

//                     // Deuxiéme Cas Nbr Jour < 26 And Heure Travaill > "Work Hours per month"

//                     if ("Jours Travaillé" <= 26) and ("Heure Travaillé" >= RegimesoFwork."Work Hours per month") then begin
//                         Présence := "Jours Travaillé";
//                         Val1 := "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour";
//                         Val2 := RegimesoFwork."Work Hours per month" - Val1;
//                         "Heure Normal Supp Calculé" := Val2;
//                         Val3 := "Heure Travaillé" - RegimesoFwork."Work Hours per month";
//                         if Val3 > RegimesoFwork."Max. Supp. Hours per month" then Val3 := RegimesoFwork."Max. Supp. Hours per month";
//                         "Heure Sup Majoré à 75 %" := Val3;
//                         if Val3 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
//                             "Jours Sup Calculé Majoré à 75%" := Val3 DIV RegimesoFwork."Nombre Heure Par Jour";
//                             "Heure Sup Majoré à 75 %" := Val3 MOD RegimesoFwork."Nombre Heure Par Jour";
//                         end;

//                     end;

//                     // Troisieme Cas Nbr Jour >26 And Heure Travaill < "Work Hours per month"

//                     if ("Jours Travaillé" > 26) and ("Heure Travaillé" <= RegimesoFwork."Work Hours per month") then begin
//                         Val1 := "Heure Travaillé" / RegimesoFwork."Nombre Heure Par Jour";
//                         Val2 := Val1 * RegimesoFwork."Nombre Heure Par Jour";
//                         Val3 := "Heure Travaillé" - Val2;
//                         Présence := Val1;
//                         "Heure Normal Supp Calculé" := Val3;
//                         if Val3 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
//                             "Jours Sup Normal" := Val3 DIV RegimesoFwork."Nombre Heure Par Jour";
//                             "Heure Normal Supp Calculé" := Val3 MOD RegimesoFwork."Nombre Heure Par Jour";
//                         end;


//                     end;


//                     // Quatriemme Cas Nbr Jour >26 And Heure Travaill > "Work Hours per month"

//                     if ("Jours Travaillé" >= 26) and ("Heure Travaillé" >= RegimesoFwork."Work Hours per month") then begin
//                         if ("Heure Travaillé" - "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour") >= 0 then begin
//                             Val1 := "Jours Travaillé";
//                             Présence := 26;
//                             "Jours Sup Calculé Majoré à 75%" := Val1 - 26;
//                             Val2 := "Heure Travaillé" - Val1 * RegimesoFwork."Nombre Heure Par Jour";
//                             if Val2 > RegimesoFwork."Max. Supp. Hours per month" then Val2 := RegimesoFwork."Max. Supp. Hours per month";
//                             if Val2 > 0 then "Heure Sup Majoré à 75 %" := Val2;

//                         end
//                         else begin
//                             Val1 := "Heure Travaillé" - 26 * RegimesoFwork."Nombre Heure Par Jour";
//                             Présence := 26;
//                             "Jours Sup Calculé Majoré à 75%" := 0;
//                             Val2 := Val1;
//                             if Val2 > RegimesoFwork."Max. Supp. Hours per month" then Val2 := RegimesoFwork."Max. Supp. Hours per month";
//                             if Val2 > 0 then begin
//                                 "Heure Sup Majoré à 75 %" := Val2;
//                                 if Val2 DIV RegimesoFwork."Nombre Heure Par Jour" > 0 then begin
//                                     "Jours Sup Calculé Majoré à 75%" := Val2 DIV RegimesoFwork."Nombre Heure Par Jour";
//                                     "Heure Sup Majoré à 75 %" := Val2 MOD RegimesoFwork."Nombre Heure Par Jour";
//                                 end;

//                             end;
//                         end;

//                     end;

//                 end;
//                 /*if Employee.Get(Matricule) then begin
//                     if RecQualification.Get(Employee.Qualification) then
//                         if RecQualification."Sans Heure Supp" then begin
//                             "Heure Sup Majoré à 75 %" := 0;
//                             "Heure Normal Supp Calculé" := 0;
//                         end;
//                 end;*/
//                 Validate("Nombre de jour", Présence);
//                 //IF EmploymentContract.GET(Matricule) THEN;
//                 //IF RegimesoFwork.GET(EmploymentContract."Regimes of work") THEN;
//                 "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
//             end;
//         }
//         field(50021; "Jours Travaillé"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 "Heure Normal Supp Calculé" := 0;
//                 HeureCalcule := 0;
//                 "Heures Retenues" := 0;
//                 "Nbr Jours Deplacement" := 0;
//                 "Jours Sup Calculé Majoré à 75%" := 0;
//                 "Heure Sup Majoré à 75 %" := 0;
//                 "Heure Travaillé" := 0;
//                 if "Jours Travaillé" <= 26 then Présence := "Jours Travaillé";
//                 if "Jours Travaillé" > 26 then begin
//                     Présence := 26;
//                     "Jours Sup Calculé Majoré à 75%" := "Jours Travaillé" - 26;
//                 end;
//                 if EmploymentContract.Get(Matricule) then;
//                 if RegimesoFwork.Get(EmploymentContract."Regimes of work") then;
//                 Validate("Heure Travaillé", "Jours Travaillé" * RegimesoFwork."Nombre Heure Par Jour");
//                 "Heure Travaillé réel" := Présence * RegimesoFwork."Nombre Heure Par Jour";
//                 "Heures Normal" := Présence;
//                 "Nombre de jour" := Présence;
//             end;
//         }
//         field(50022; Rappel; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50023; Retenu; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50024; Cession; Decimal)
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         field(50025; Qualification; Code[20])
//         {
//             Description = 'HJ SORO 25-09-2014';
//         }
//         field(50026; Affectation; Code[20])
//         {
//             Description = 'HJ SORO 25-09-2014';
//             //  TableRelation = Section.Section;
//         }
//         field(50027; "Heures Retenues"; Decimal)
//         {
//             Description = 'HJ SORO 22-10-2014';
//             Editable = true;
//         }
//         field(50028; "Heure Travaillé réel"; Decimal)
//         {
//             Description = 'HJ SORO 28-10-2014';
//         }
//         field(50029; "Jours Dimanche"; Decimal)
//         {
//         }
//         field(50030; Kmetrage; Decimal)
//         {
//             Description = 'RB SORO 06/02/2016';
//         }
//         field(50031; "Jours Sup Normal"; Decimal)
//         {
//             Editable = true;
//         }
//         field(50032; "Droit Congé"; Decimal)
//         {
//             Description = 'RB SORO 03/05/2016';
//         }
//         field(50033; "Rappel Salarié"; Decimal)
//         {
//             CalcFormula = lookup("Default Indemnities"."Default amount" where("Employment Contract Code" = field(Matricule),
//                                                                                "Indemnity Code" = filter('443')));
//             DecimalPlaces = 3 : 3;
//             Description = 'RB SORO 03/05/2016';
//             FieldClass = FlowField;
//         }
//         field(50036; "Heure Sup BR"; Decimal)
//         {
//         }
//         field(50037; "Ne pas appliquer Taux %"; Boolean)
//         {
//             Description = 'MH SORO 12-09-2020';
//         }
//         field(50038; "Description Qualification"; Text[150])
//         {
//             Description = 'MH SORO 02-10-2023';
//         }
//         field(50039; "Nbre Jours Absence"; Decimal)
//         {
//             Description = 'MH SORO 22-04-2024';
//         }
//         field(50040; "Nbre Jours Sanction"; Decimal)
//         {
//             Description = 'MH SORO 22-04-2024';
//         }
//         field(50041; "Motif Sanction"; Text[150])
//         {
//             Description = 'MH SORO 22-04-2024';
//         }
//         field(60000; Annee; Integer)
//         {
//             Description = 'HJ SORO 18-07-2016';
//         }
//         field(60001; Mois; Option)
//         {
//             Description = 'HJ SORO 18-07-2016';
//             OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Autre,"Solder jour de congé";
//         }
//         field(39001490; "type calcul paie"; Option)
//         {
//             OptionCaption = 'Mensuel,Quinzaine';
//             OptionMembers = Mensuel,Quinzaine;
//         }
//         field(39001491; "Nombre de jour"; Decimal)
//         {
//         }
//         field(39001492; "Productivité"; Decimal)
//         {
//             Description = '//DSFT-AGA 10072010';
//         }
//         field(39001493; "Total nb jours"; Decimal)
//         {
//             CalcFormula = sum("Etat Mensuelle Paie"."Nombre de jour");
//             Description = '//DSFT-AGA 10072010';
//             FieldClass = FlowField;
//         }
//         field(39001494; "Total nb heures"; Decimal)
//         {
//             CalcFormula = sum("Etat Mensuelle Paie".Heure where("Type Salarié" = filter("Base Horaire")));
//             Description = '//DSFT-AGA 10072010';
//             FieldClass = FlowField;
//         }
//         field(39001495; "Nombre Salarier"; Integer)
//         {
//             CalcFormula = count("Etat Mensuelle Paie");
//             FieldClass = FlowField;
//         }
//     }

//     keys
//     {
//         key(Key1; Annee, Mois, Matricule)
//         {
//             Clustered = true;
//             SumIndexFields = Heure, "Nombre de jour";
//         }
//         key(Key2; Affectation)
//         {
//         }
//         key(Key3; "Type Salarié")
//         {
//             SumIndexFields = Heure;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnInsert()
//     begin
//         if Séquence = 0 then
//             Séquence := 1
//         else
//             Séquence := xRec.Séquence + 1;
//     end;

//     var
//         GCodNomPrenom: Text[100];
//         GRecSalary: Record Employee;
//         PramResH: Record "Human Resources Setup";
//         EmploymentContract: Record "Employment Contract";
//         RegimesoFwork: Record "Regimes of work";
//         NombrJour: Decimal;
//         NombreHeure: Decimal;
//         HeureCalcule: Decimal;
//         Val1: Decimal;
//         Val2: Decimal;
//         Val3: Decimal;
//         //Section: Record Section;
//         RecQualification: Record Qualification;
//         Employee: Record Employee;
// }

