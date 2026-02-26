// xmlport 50111 "Etat Mensuel Paie"
// {

//         //GL2024  ID dans Nav 2009 : "39001405"
//         Format = VariableText;
//         FieldSeparator = ';';
//         RecordSeparator = '<NewLine>';
//         TableSeparator = '<NewLine><NewLine>';
//         schema
//         {
//             textelement(NodeName1)
//             {
//                 tableelement("EtatMensuellePaie"; "Etat Mensuelle Paie")
//                 {
//                     SourceTableView = SORTING(Matricule);
//                     AutoSave = TRUE;
//                     AutoUpdate = TRUE;
//                     // MinOccurs = Zero;
//                     textattribute(Mat)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(NomPrenom)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(JoursTravailler)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(HeureTravailler)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(Ferier)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(DecConge)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(DecCongeSpeciale)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(Deplacement)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(Affectation)
//                     {
//                         Width = 0;
//                     }
//                     textattribute(Kmetrage)
//                     {
//                         Width = 0;
//                     }
//                     trigger OnPreXmlItem()
//                     begin


//                     end;

//                     trigger OnAfterGetRecord()
//                     begin


//                         Emp.RESET;
//                         // RB SORO 02/05/2016 VERIFICATION NOM ET PRENOM SALARIE
//                         Saut := FALSE;
//                         RecVerifierPointageSalaries.RESET;
//                         RecVerifierPointageSalaries2.RESET;
//                         RecVerifierPointageSalaries3.RESET;
//                         RecVerifEmployee.GET(Mat);
//                         /*
//                         IF UPPERCASE(RecVerifEmployee."First And Last Name") <> UPPERCASE(NomPrenom) THEN BEGIN
//                                                 RecVerifierPointageSalaries.Matricule := RecVerifEmployee."No.";
//                                                 RecVerifierPointageSalaries."Nom et Prenom NAV" := RecVerifEmployee."First And Last Name";
//                                                 RecVerifierPointageSalaries."Nom et Prenom Pointage" := NomPrenom;
//                                                 RecVerifierPointageSalaries.Affectation := Affectation;
//                                                 IF NOT RecVerifierPointageSalaries.INSERT THEN RecVerifierPointageSalaries.MODIFY;
//                                                 Saut := TRUE;
//                                                 //CurrDataport.SKIP;
//                                             END;
//                         */
//                         // RB SORO 02/05/2016 VERIFICATION NOM ET PRENOM SALARIE
//                         // RB VERIFIER LES DATES FIN CONTRAT
//                         Mois := DATE2DMY(TODAY, 2);
//                         Annee := DATE2DMY(TODAY, 3);
//                         IF Mois = 1 THEN
//                             DateLimite := DMY2DATE(15, 12, Annee - 1)
//                         ELSE
//                             DateLimite := DMY2DATE(15, Mois - 1, Annee);
//                         IF (RecVerifEmployee."Termination Date" <> 0D) AND (RecVerifEmployee."Termination Date" < DateLimite) THEN BEGIN
//                             RecVerifierPointageSalaries2.Matricule := RecVerifEmployee."No.";
//                             RecVerifierPointageSalaries2."Nom et Prenom NAV" := RecVerifEmployee."First Name";
//                             //RecVerifierPointageSalaries2."Nom et Prenom Pointage" := NomPrenom;
//                             RecVerifierPointageSalaries2."Date Fin Contrat" := RecVerifEmployee."Termination Date";
//                             RecVerifierPointageSalaries2.Affectation := Affectation;
//                             IF NOT RecVerifierPointageSalaries2.INSERT THEN RecVerifierPointageSalaries2.MODIFY;
//                             Saut := TRUE;
//                             //CurrDataport.SKIP;
//                         END;
//                         // RB VERIFIER LES DATES FIN CONTRAT
//                         // RB VERIFIER AGE PERSONNEL 60 ANS RETRAITE
//                         FinDeMois := CALCDATE('+FM', DMY2DATE(1, Mois - 1, Annee));
//                         IF (RecVerifEmployee."Birth Date" <> 0D) AND (((FinDeMois - RecVerifEmployee."Birth Date") / 365) > 60) THEN BEGIN
//                             RecVerifierPointageSalaries3.Matricule := RecVerifEmployee."No.";
//                             RecVerifierPointageSalaries3."Nom et Prenom NAV" := RecVerifEmployee."First Name";
//                             //RecVerifierPointageSalaries."Nom et Prenom Pointage" := NomPrenom;
//                             RecVerifierPointageSalaries3.Age := ((FinDeMois - RecVerifEmployee."Birth Date") / 365);
//                             RecVerifierPointageSalaries3.Affectation := Affectation;
//                             IF NOT RecVerifierPointageSalaries3.INSERT THEN RecVerifierPointageSalaries3.MODIFY;
//                             Saut := TRUE;
//                             //CurrDataport.SKIP;
//                         END;
//                         // RB VERIFIER AGE PERSONNEL 60 ANS RETRAITE
//                         IF Saut THEN currXMLport.SKIP;
//                         //EtatMensuellePaie.Matricule:=Mat;
//                         EtatMensuellePaie.VALIDATE(Matricule, Mat);
//                         IF Emp.GET(Mat) THEN EtatMensuellePaie.Nom := Emp."First Name" + ' ' + Emp."Last Name";
//                         //EtatMensuellePaie.Heure            := HeureNormale;
//                         EtatMensuellePaie.VALIDATE("Jours Travaillé", EvaluateAsDecimal(JoursTravailler));
//                         EtatMensuellePaie.VALIDATE("Heure Travaillé", EvaluateAsDecimal(HeureTravailler));

//                         // RB SORO 02/05/2016

//                         EtatMensuellePaie.Congé := EvaluateAsDecimal(DecConge);
//                         EtatMensuellePaie."Congé Spéciale" := EvaluateAsDecimal(DecCongeSpeciale);

//                         EtatMensuellePaie.Affectation := Affectation;
//                         EtatMensuellePaie.Férier := EvaluateAsDecimal(Ferier);
//                         EtatMensuellePaie."Nbr Jours Deplacement" := EvaluateAsDecimal(deplacement);

//                         //******************************
//                         IF RecGEmp.GET(Mat) THEN BEGIN
//                             // MH SORO 13-01-2017 Anciente
//                             IF FORMAT(RecGEmp."Employment Date") <> '' THEN BEGIN
//                                 IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté(RecGEmp."No.", TODAY);
//                                 NbrJour := TODAY - RecGEmp."Employment Date";
//                                 IntAnnéeAncienneté := NbrJour DIV 365;
//                                 IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
//                                 IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
//                                 IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
//                                 IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
//                                 Ancienneté := FORMAT(IntAnnéeAncienneté) + ' An(s), ' + FORMAT(IntMoisAncienneté) + ' Mois';
//                                 NbreMoisAnciente := (IntAnnéeAncienneté * 12) + IntMoisAncienneté;
//                                 EtatMensuellePaie."Mois Ancienté" := NbreMoisAnciente;
//                                 //IF (NbreMoisAnciente<49) AND (NbreMoisAnciente>45)  THEN   NbreSalarié:= NbreSalarié+1;

//                             END;
//                             // MH SORO 13-01-2017

//                             // MH SORO 13-01-2017 Age
//                             IF FORMAT(RecGEmp."Birth Date") <> '' THEN BEGIN
//                                 IntMoisAncienneté2 := Managementofsalary.CalculerAge(RecGEmp."No.", TODAY);
//                                 NbrJour2 := TODAY - RecGEmp."Birth Date";
//                                 IntAnnéeAncienneté2 := NbrJour2 DIV 365;
//                                 IntMoisAncienneté2 := (NbrJour2 - IntAnnéeAncienneté2 * 365) DIV 30;
//                                 IntAncienneteJour2 := NbrJour2 - IntAnnéeAncienneté2 * 365 - IntMoisAncienneté2 * 30;
//                                 IF IntAncienneteJour2 < 0 THEN IntAncienneteJour2 := 0;
//                                 IF IntAncienneteJour2 < 0 THEN IntAncienneteJour2 := 0;
//                                 AgeSalarier := FORMAT(IntAnnéeAncienneté2) + ' An(s), ' + FORMAT(IntMoisAncienneté2) + ' Mois';
//                                 EtatMensuellePaie.Age := AgeSalarier;
//                             END;
//                             // MH SORO 13-01-2017
//                         END;

//                         // RB SORO 02/05/2016
//                         // RB SORO 06/02/2016 SETT
//                         //EtatMensuellePaie.Kmetrage := Kmetrage;
//                         // RB SORO 06/02/2016 SETT
//                         IF NOT EtatMensuellePaie.INSERT THEN EtatMensuellePaie.MODIFY;


//                     end;

//                 }


//             }
//         }

//         requestpage
//         {
//             layout
//             {
//             }

//             actions
//             {

//             }
//         }
//         procedure EvaluateAsDecimal(ValueText: Text): Decimal
//         var
//             Result: Decimal;
//         begin
//             Evaluate(Result, ValueText);
//             exit(Result);
//         end;

//         var
//             Séq: Integer;
//             // Mat: Code[10];
//             Nom1: Text[100];
//             Nom2: Text[30];
//             DHrsup: Text[30];
//             Panier: Decimal;
//             TotHeurs: Decimal;
//             // HeureTravailler: Decimal;
//             // JoursTravailler: Decimal;
//             // EtatMensuellePaie: Record "Etat Mensuelle Paie";
//             HeureNormale: Decimal;
//             BA: Code[10];
//             TypeH: Text[30];
//             Sem: Integer;
//             EtatMensuellePaie1: Record "Etat Mensuelle Paie";
//             i: Integer;
//             seq: Integer;
//             HS: Decimal;
//             HF: Decimal;
//             ABS1: Decimal;
//             CONG1: Decimal;
//             Emp: Record Employee;
//             HS75: Decimal;
//             RecGRegimetrav: Record "Regimes of work";
//             RecGContrattrav: Record "Employment Contract";
//             DecGHeuretravsema: Decimal;
//             FETATMENSUELPAIE: Page "Etat Mensuel De Paie"; // Adapté en Page si Form n’existe plus en BC
//                                                            // Deplacement: Decimal;
//                                                            // Kmetrage: Decimal;
//                                                            // NomPrenom: Text[60];
//                                                            // Affectation: Code[10];
//                                                            // Ferier: Decimal;
//             RecVerifierPointageSalaries: Record "Verifier Pointage Salaries";
//             RecVerifEmployee: Record Employee;
//             // DecConge: Decimal;
//             // DecCongeSpeciale: Decimal;
//             DateLimite: Date;
//             Result: Decimal;
//             Mois: Integer;
//             Annee: Integer;
//             FinDeMois: Date;
//             Saut: Boolean;
//             RecVerifierPointageSalaries2: Record "Verifier Pointage Salaries";
//             RecVerifierPointageSalaries3: Record "Verifier Pointage Salaries";
//             RecGEmp: Record Employee;
//             AgeSalarier: Text[30];
//             IntMoisAncienneté2: Integer;
//             IntAnnéeAncienneté2: Integer;
//             Ancienneté2: Text[50];
//             IntAncienneteJour2: Integer;
//             NbrJour2: Integer;
//             Section: Record Section;
//             MoisAttach: Option;
//             AnneeAttach: Integer;
//             LignePointageSalariéChanti: Record "Ligne Pointage Salarié Chanti";
//             EtatMensuellePaie2: Record "Etat Mensuelle Paie";
//             Recemployee: Record Employee;
//             IntMoisAncienneté: Integer;
//             IntAnnéeAncienneté: Integer;
//             Ancienneté: Text[50];
//             IntAncienneteJour: Integer;
//             DateRefAnciennete: Date;
//             NbreMoisAnciente: Decimal;
//             NbrJour: Integer;
//             Managementofsalary: Codeunit "Management of salary";

// }