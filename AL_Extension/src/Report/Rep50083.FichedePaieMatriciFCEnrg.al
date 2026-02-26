report 50083 "Fiche de Paie Matrici FC@Enrg."
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/FichedePaieMatriciFCEnrg.rdl';

    // dataset
    // {
    //     /*  dataitem("Salary Headers"; "Rec. Salary Headers")  
    //       {
    //           DataItemTableView = SORTING("No.")
    //                               ORDER(Ascending);
    //           column(Salary_Headers_No_; "No.")
    //           {
    //           }*/
    //     dataitem("Salary Lines"; "Rec. Salary Lines")
    //     {
    //         //  DataItemLink = "No." = FIELD("No.");
    //         column(Employee__First_Name_; RecEpmloyee."First Name")
    //         {
    //         }

    //         column(FamilySituationA; RecEpmloyee."Marital Status") { }
    //         column(Employee__Social_Security_No__; RecEpmloyee."Social Security No.")
    //         {
    //         }
    //         column(Employee__Nombre_Enfant_; RecEpmloyee."Nombre Enfant")
    //         {
    //         }
    //         column("RecSalarylines_Catégorie"; RecSalarylines.Catégorie)
    //         {
    //         }
    //         column(qualif; qualif)
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Salary_Lines_No_; "No.")
    //         {
    //         }
    //         column(Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Salary_Lines_Month; Month)
    //         {
    //         }
    //         column(Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(RibSalarie; RibSalarie)
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         dataitem("Salary Headers1"; "Rec. Salary Headers")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.")
    //                                     ORDER(Ascending);
    //             column(nom; nom)
    //             {
    //             }
    //             column(CompInfo__Address_2_; CompInfo."Address 2")
    //             {
    //             }
    //             column(Nss; Nss)
    //             {
    //             }
    //             column(Salary_Headers1_Year; Year)
    //             {
    //             }
    //             column(Salary_Headers1_Month; Month)
    //             {
    //             }
    //             column(DUPLICATACaption; DUPLICATACaptionLbl)
    //             {
    //             }
    //             column(Salary_Headers1_No_; "No.")
    //             {
    //             }
    //         }
    //         dataitem(Employee; "Employee")
    //         {
    //             CalcFields = "Days off =";
    //             DataItemLink = "No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.")
    //                                     ORDER(Ascending);
    //             column(Employee__No__; "No.")
    //             {
    //             }



    //             trigger OnAfterGetRecord()
    //             var
    //                 salaryqualification: Record "Employee Qualification";
    //             begin

    //                 IF CurrReport.SHOWOUTPUT THEN
    //                     LinesPrinted := LinesPrinted + 11;

    //                 IF RecGContrat.GET("Emplymt. Contract Code") THEN
    //                     IF RecGRegime.GET(RecGContrat."Regimes of work") THEN BEGIN
    //                         DECGNBHEURE := RecGRegime."Work Hours per month";
    //                         DECGNBJOURS := RecGRegime."Worked Day Per Month";
    //                     END;

    //                 IF "Employee's type" = 1 THEN BEGIN
    //                     Jourheuretravail := 'NB J';
    //                     jourheureabs := 'NB Jours absence';
    //                     DECGNBJOURS := "Salary Lines"."Paied days";
    //                     NBJourtravail := (DECGNBJOURS);//-"Salary Lines".Absences);
    //                 END
    //                 ELSE BEGIN
    //                     Jourheuretravail := 'NB H';
    //                     jourheureabs := 'NB Heures absence';
    //                     RecSalarylines.RESET;
    //                     RecSalarylines.SETRANGE("No.", "Salary Headers1"."No.");
    //                     RecSalarylines.SETRANGE(Employee, "No.");
    //                     DECGNBHEURE := "Salary Lines"."Worked hours";
    //                     NBJourtravail := (DECGNBHEURE);//-("Salary Lines".Absences));
    //                 END;
    //                 //>>MBY 20/04/2009
    //                 Jourconge := '';
    //                 nbjourconge := 0;
    //                 IF ("Salary Lines".Month = 13) AND ("Employee's type" <> 1) THEN BEGIN
    //                     Jourconge := 'NB J';
    //                     nbjourconge := "Salary Lines"."Days off remaining";
    //                 END;
    //                 //<<MBY

    //                 IF RecGContrat.GET("Emplymt. Contract Code") THEN
    //                     IF RecGRegime.GET(RecGContrat."Regimes of work") THEN
    //                         IF Employee."Employee's type" = 0 THEN BEGIN
    //                             // IF "Salary Lines".congé>0 THEN
    //                             // nbjourconge:=ROUND("Salary Lines".congé/RecGRegime."From Work day to Work hour",0.1);
    //                             // IF "Salary Lines"."Jours Fériés">0 THEN
    //                             // nbjourferie:="Salary Lines"."Jours Fériés"
    //                             // END ELSE
    //                             //  nbjourconge:="Salary Lines".congé;
    //                             //  nbjourferie:="Salary Lines"."Jours Fériés" ;
    //                             //   BEGIN
    //                         END;



    //                 decnote := 0;
    //                 txtnote := '';
    //                 RecSalarylines.RESET;
    //                 RecSalarylines.SETRANGE("No.", "Salary Headers1"."No.");
    //                 RecSalarylines.SETRANGE(Employee, "No.");
    //                 IF RecSalarylines.FIND('-') THEN BEGIN
    //                     decnote := RecSalarylines.Note;
    //                     IF decnote > 0 THEN txtnote := 'Note'
    //                 END;
    //                 salaryqualification.SETFILTER("Employee No.", "No.");
    //                 IF salaryqualification.FINDLAST THEN
    //                     "Job Title" := salaryqualification.Description;



    //                 //*******************MH 22/10/2016 *********************
    //                 RecSalarylines.RESET;
    //                 RecSalarylines.SETRANGE("No.", "Salary Headers1"."No.");
    //                 RecSalarylines.SETRANGE(Employee, "No.");
    //                 IF RecSalarylines.FINDFIRST THEN BEGIN
    //                     RecAffectation.RESET;
    //                     RecAffectation.SETRANGE(RecAffectation.Section, RecSalarylines.Affectation);
    //                     IF RecAffectation.FINDFIRST THEN Affect := RecAffectation.Decription;

    //                     RecQualification.RESET;
    //                     RecQualification.SETRANGE(RecQualification.Code, RecSalarylines.Qualification);
    //                     IF RecQualification.FINDFIRST THEN qualif := RecQualification.Description;

    //                 END;
    //                 //*******************MH 22/10/2016 *********************
    //             end;
    //         }
    //         dataitem("<Recorded Worked hours1>"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "N° Salarié" = FIELD(Employee),
    //                                "Mois de paiement" = FIELD(Month),
    //                                "Année de paiement" = FIELD(Year);
    //             DataItemTableView = SORTING("N° transaction", "N° Ligne", "N° Salarié")
    //                                     ORDER(Ascending)
    //                                     WHERE("Nombre Heures Supp" = FILTER(1));
    //             trigger OnAfterGetRecord()
    //             begin

    //                 ln := 26;  //ABR
    //                            // CurrReport.SHOWOUTPUT :=
    //                            //   CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration");

    //                 IF (CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration")) THEN
    //                     ln := ln + 1;
    //                 //CurrReport.SHOWOUTPUT(FALSE);

    //             end;
    //         }
    //         dataitem("Salary Lines1"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //             column(ROUND__Real_basis_salary__0_001_; ROUND("Real basis salary", 0.001))
    //             {
    //                 AutoFormatType = 0;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salaire_de_Base_; 'Salaire de Base')
    //             {
    //             }
    //             column(Salary_Lines1__Basis_salary_; "Basis salary")
    //             {
    //             }
    //             column(Salary_Lines___Paied_days_; "Salary Lines"."Paied days")
    //             {
    //                 DecimalPlaces = 0 : 2;
    //             }
    //             column(Salary_Lines1_No_; "No.")
    //             {
    //             }
    //             column(Salary_Lines1_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 //IF ("Salary Lines1"."Employee's type" = 0) THEN CurrReport.SHOWOUTPUT (FALSE);

    //                 IntCompteur += 1;
    //                 IF CurrReport.SHOWOUTPUT(NOT "Salary Headers1".STC) THEN BEGIN

    //                     LinesPrinted := LinesPrinted + 1;
    //                 END;
    //                 SBDeduit := 0;
    //                 IF Absences > 0 THEN
    //                     IF "Salary Lines1"."Employee's type" = 1 THEN
    //                         SBDeduit := ("Basis salary" - "Real basis salary")
    //                     ELSE
    //                         SBDeduit := (("Basis salary" * DECGNBHEURE) - "Real basis salary");
    //                 IF "Salary Lines1"."Employee's type" = 1 THEN
    //                     textsalaire := 'Jours Travaillés'
    //                 ELSE
    //                     textsalaire := 'Heures Travaillées';

    //                 IF ("NB Mois Gratif" <> 0) AND (Month > 11) THEN
    //                     textsalaire := 'Nombre de Mois : ' + FORMAT("NB Mois Gratif");
    //             end;
    //         }
    //         dataitem(Indemnities1; "Rec. Indemnities")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                "Employee No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
    //                                     ORDER(Ascending)
    //                                     WHERE(Type = FILTER(Imposable));
    //             column(ROUND__Real_Amount__0_001_; ROUND("Real Amount", 0.001))
    //             {
    //                 AutoFormatType = 0;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Indemnities1_Description; Description)
    //             {
    //             }
    //             column(JoursPayement; JoursPayement)
    //             {
    //                 DecimalPlaces = 0 : 2;
    //             }
    //             column(Indemnities1_No_; "No.")
    //             {
    //             }
    //             column(Indemnities1_Employee_No_; "Employee No.")
    //             {
    //             }
    //             column(Indemnities1_Indemnity; Indemnity)
    //             {
    //             }

    //             trigger OnAfterGetRecord()
    //             var

    //                 Heuresoccaenregm: Record "Heures occa. enreg. m";
    //             begin
    //                 nbrjoursean := 0;
    //                 IF "Evaluation mode" = "Evaluation mode"::"on Flight hours" THEN
    //                     nbrjoursean := Indemnities1.Rate;

    //                 IF CurrReport.SHOWOUTPUT THEN
    //                     LinesPrinted := LinesPrinted + 1;

    //                 MntDeduit := 0;
    //                 IF Indemnities1."Base Amount" > Indemnities1."Real Amount" THEN
    //                     MntDeduit := Indemnities1."Base Amount" - Indemnities1."Real Amount";
    //                 Param.GET;
    //                 JoursPayement := "Salary Lines"."Paied days";
    //                 if Indemnities1."Real Amount" = 0 then
    //                     CurrReport.Skip();
    //                 // CurrReport.SHOWOUTPUT(Indemnities1."Real Amount" <> 0);
    //                 IF Indemnities1."Real Amount" <> 0 THEN IntCompteur += 1;
    //                 Heuresoccaenregm.SETRANGE("Paiement No.", "No.");
    //                 Heuresoccaenregm.SETRANGE("N° Salarié", "Employee No.");
    //                 IF Heuresoccaenregm.FINDFIRST THEN BEGIN
    //                     IF Heuresoccaenregm."Jours Deplacement" <> 0 THEN BEGIN
    //                         IF Indemnity = '003' THEN JoursPayement := "Salary Lines"."Paied days" - Heuresoccaenregm."Jours Deplacement";
    //                         IF Indemnity = '106' THEN JoursPayement := Heuresoccaenregm."Jours Deplacement";
    //                         IF Indemnity = '103' THEN JoursPayement := "Salary Lines"."Paied days" - Heuresoccaenregm."Jours Deplacement";

    //                     END;
    //                 END;
    //                 IF Indemnity = '443' THEN JoursPayement := 0;
    //                 IF Indemnity = '456' THEN JoursPayement := 0;
    //                 IF "Salary Headers1".STC THEN BEGIN
    //                     JoursPayement := 0;
    //                     IF Indemnity = '957' THEN JoursPayement := Employee."Days off =";
    //                 END;

    //             end;
    //         }
    //         dataitem("<Recorded Worked hours2>"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "N° Salarié" = FIELD(Employee),
    //                                "Mois de paiement" = FIELD(Month),
    //                                "Année de paiement" = FIELD(Year),
    //                                Quinzaine = FIELD(Quinzainea);
    //             DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
    //                                     ORDER(Ascending)
    //                                     WHERE("Type Jours" = FILTER("Prime Astreinte"));

    //             trigger OnPreDataItem()
    //             begin
    //                 LastFieldNo := FIELDNO("Montant Ligne");
    //             end;
    //         }
    //         dataitem("<Recorded Worked hours21>"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "N° Salarié" = FIELD(Employee),
    //                                "Mois de paiement" = FIELD(Month),
    //                                "Année de paiement" = FIELD(Year),
    //                                Quinzaine = FIELD(Quinzainea);
    //             DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
    //                                     ORDER(Ascending)
    //                                     WHERE("Type Jours" = FILTER(Nuit));
    //         }
    //         dataitem("<Heures sup. eregistrées m3>"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "N° Salarié" = FIELD(Employee),
    //                                "Mois de paiement" = FIELD(Month),
    //                                "Année de paiement" = FIELD(Year);
    //             DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
    //                                     ORDER(Ascending);
    //             column(Salary_Lines_Supphours; "Salary Lines"."Supp. hours")
    //             {
    //             }
    //             column(ROUND__Montant_Ligne__0_001_; ROUND("Montant Ligne", 0.001))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column("Heures_sup__eregistrées_m3___Nombre_Heures_Supp_"; "Nombre Heures Supp")
    //             {
    //                 DecimalPlaces = 0 : 1;
    //             }
    //             column(DesRebrique; DesRebrique)
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m3__N__transaction"; "N° transaction")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m3__N__Ligne"; "N° Ligne")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m3__N__Salarié"; "N° Salarié")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m3__Mois_de_paiement"; "Mois de paiement")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m3__Année_de_paiement"; "Année de paiement")
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin
    //                 if "Salary Lines"."Supp. hours" = 0 then
    //                     CurrReport.Skip();
    //                 //  CurrReport.SHOWOUTPUT("Salary Lines"."Supp. hours" <> 0);
    //                 IF RecGContrat.GET(Employee."No.") THEN
    //                     IF RecGRegime.GET(RecGContrat."Regimes of work") THEN
    //                         IF RecGRegime."type calcul paie" = 1 THEN
    //                             CurrReport.Skip();
    //                 //  CurrReport.SHOWOUTPUT(FALSE);
    //                 IF CurrReport.SHOWOUTPUT THEN
    //                     LinesPrinted := LinesPrinted + 1;
    //                 IF "Salary Lines"."Supp. hours" <> 0 THEN IntCompteur += 1;
    //                 // RB SORO 04/05/2016
    //                 DesRebrique := ''; //FORMAT("Type Jours")
    //                 IF "<Heures sup. eregistrées m3>"."Type Jours" = "<Heures sup. eregistrées m3>"."Type Jours"::"Congé Annuelle" THEN
    //                     DesRebrique := 'Congé Annuel'
    //                 ELSE //HS
    //                     if "Type Jours" in [5, 8, 9, 10, 11] then
    //                         DesRebrique := 'Travail Supp'
    //                     else
    //                         DesRebrique := FORMAT("Type Jours");
    //                 //HS
    //             end;
    //         }
    //         dataitem("<Heures sup. eregistrées m4>"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "N° Salarié" = FIELD(Employee),
    //                                "Mois de paiement" = FIELD(Month),
    //                                "Année de paiement" = FIELD(Year);
    //             DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
    //                                     ORDER(Ascending)
    //                                     WHERE("Type Jours" = FILTER(Nuit));
    //         }
    //         dataitem("Employee's days off Entry"; "Employee's days off Entry")
    //         {
    //             DataItemLink = "Employee No." = FIELD(Employee),
    //                                "Posting month" = FIELD(Month),
    //                                "Posting year" = FIELD(Year);
    //             DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
    //                                     ORDER(Ascending)
    //                                     WHERE("Line type" = FILTER("Jour férier payé"));
    //         }
    //         dataitem("<Employee's days off Entry1>"; "Employee's days off Entry")
    //         {
    //             DataItemLink = "Employee No." = FIELD(Employee),
    //                                "Posting month" = FIELD(Month),
    //                                "Posting year" = FIELD(Year);
    //             DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
    //                                     ORDER(Ascending)
    //                                     WHERE("Motif D'absence" = FILTER("Congé de Maladie"),
    //                                           "Line type" = FILTER(' '));
    //         }
    //         dataitem("<Employee's days off Entry2>"; "Employee's days off Entry")
    //         {
    //             DataItemLink = "Employee No." = FIELD(Employee),
    //                                "Posting month" = FIELD(Month),
    //                                "Posting year" = FIELD(Year);
    //             DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
    //                                     ORDER(Ascending)
    //                                     WHERE("Motif D'absence" = FILTER("Accident de travail"),
    //                                           "Line type" = FILTER(' '));
    //         }
    //         dataitem("Salary Lines2"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //         }
    //         dataitem("Social Contributions1"; "Rec. Social Contributions")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
    //                                     ORDER(Ascending)
    //                                     WHERE("Deductible of taxable basis" = FILTER(true),
    //                                           "Real Amount : Employee" = FILTER(<> 0));
    //         }
    //         dataitem(Indemnitiesimpassej; "Rec. Indemnities")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                "Employee No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
    //                                     ORDER(Ascending)
    //                                     WHERE(Type = FILTER("Imposable (Non Assujettie Socialement)"));
    //         }
    //         dataitem("Salary Lines3"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //         }
    //         dataitem("<RCGC>"; "Social Contributions")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
    //                                     ORDER(Ascending)
    //                                     WHERE("Deductible of taxable basis" = FILTER(false),
    //                                           "Real Amount : Employee" = FILTER(<> 0));
    //         }
    //         dataitem(Indemnities2; "Rec. Indemnities")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                "Employee No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
    //                                     ORDER(Ascending)
    //                                     WHERE(Type = FILTER("Non imposable"));
    //             column(Indemnities2__Real_Amount_; "Real Amount")
    //             {
    //                 AutoFormatType = 2;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Indemnities2_Description; Description)
    //             {
    //             }
    //             column(Indemnities2_No_; "No.")
    //             {
    //             }
    //             column(Indemnities2_Employee_No_; "Employee No.")
    //             {
    //             }
    //             column(Indemnities2_Indemnity; Indemnity)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF CurrReport.SHOWOUTPUT THEN BEGIN
    //                     LinesPrinted := LinesPrinted + 1;
    //                     // IntCompteur += 1;
    //                 END;
    //                 if Indemnities2."Real Amount" = 0 then
    //                     CurrReport.Skip();
    //                 //CurrReport.SHOWOUTPUT(Indemnities2."Real Amount" <> 0);
    //                 IF Indemnities2."Real Amount" <> 0 THEN IntCompteur += 1;
    //             end;
    //         }
    //         dataitem("Social Contributions2"; "Rec. Social Contributions")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
    //                                     ORDER(Ascending)
    //                                     WHERE("Deductible of taxable basis" = FILTER(true),
    //                                           "Real Amount : Employee" = FILTER(<> 0));
    //         }
    //         dataitem("Expenses to repay Header"; "Expenses to repay Header")
    //         {
    //             DataItemLink = "Employee No." = FIELD(Employee),
    //                                "Payment month" = FIELD(Month),
    //                                "Payment year" = FIELD(Year);
    //             DataItemTableView = SORTING("No.")
    //                                     ORDER(Ascending)
    //                                     WHERE(Status = FILTER(Validated),
    //                                           Repaied = FILTER(false));
    //         }
    //         dataitem("Salary Lines4"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //         }
    //         dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
    //         {
    //             DataItemLink = Employee = FIELD(Employee),
    //                                "Payment No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", "Entry No.")
    //                                     ORDER(Ascending)
    //                                     WHERE("Remboursement Anticipé" = CONST(false));
    //             column(Loan___Advance_Lines__Line_Amount_; "Line Amount")
    //             {
    //                 AutoFormatType = 1;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Loan___Advance_Lines_Type; Type)
    //             {
    //             }
    //             column("Avance______Réf_____NumBonCaisse"; 'Avance' + '   Réf:  ' + NumBonCaisse)
    //             {
    //             }
    //             column(Loan___Advance_Lines_No_; "No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Employee; Employee)
    //             {
    //             }
    //             column(Loan___Advance_Lines_Payment_No_; "Payment No.")
    //             {
    //             }

    //             trigger OnAfterGetRecord()
    //             begin
    //                 LoanAdvanceHeader.GET("Loan & Advance Lines"."No.");

    //                 NumBonCaisse := '';
    //                 if "Line Amount" <> 0 then
    //                     //new add 
    //                     IntCompteur += 1;
    //                 //new add 
    //                 IF CurrReport.SHOWOUTPUT THEN BEGIN
    //                     LinesPrinted := LinesPrinted + 1;
    //                     //  IntCompteur += 1;
    //                 END;
    //                 IF TypeAv.GET("Loan & Advance Lines"."Document type") THEN
    //                     LibelleAv := TypeAv.Description;

    //                 RecLoanAdvanceHeader.RESET;
    //                 IF RecLoanAdvanceHeader.GET("No.") THEN NumBonCaisse := RecLoanAdvanceHeader."N° Bon Caisse";
    //             end;
    //         }
    //         dataitem("Salary Lines6"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //             column(Salary_Lines6__Report_en___; "Report en -")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Arrondissement____Caption; Arrondissement____CaptionLbl)
    //             {
    //             }
    //             column(Salary_Lines6_No_; "No.")
    //             {
    //             }
    //             column(Salary_Lines6_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF "Report en -" <> 0 THEN IntCompteur += 1;
    //                 if "Report en -" = 0 then
    //                     CurrReport.Skip();
    //                 //  CurrReport.SHOWOUTPUT("Report en -" <> 0);

    //                 IF CurrReport.SHOWOUTPUT THEN
    //                     LinesPrinted := LinesPrinted + 1;
    //             end;
    //         }
    //         dataitem("Salary Lines7"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //             column(Salary_Lines7__Ajout__en___; "Ajout  en +")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Arrondissement____Caption_Control1000000080; Arrondissement____Caption_Control1000000080Lbl)
    //             {
    //             }
    //             column(Salary_Lines7_No_; "No.")
    //             {
    //             }
    //             column(Salary_Lines7_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF "Ajout  en +" <> 0 THEN IntCompteur += 1;
    //                 if "Ajout  en +" = 0 then
    //                     CurrReport.Skip();
    //                 //  CurrReport.SHOWOUTPUT("Ajout  en +" <> 0);

    //                 IF CurrReport.SHOWOUTPUT THEN
    //                     LinesPrinted := LinesPrinted + 1;

    //             end;
    //         }
    //         dataitem(Redevance; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     WHERE("Taxe Redevance" = FILTER(<> 0));
    //             column(Redevance__Taxe_Redevance_; "Taxe Redevance")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Redevance_De_CompensationCaption; Redevance_De_CompensationCaptionLbl)
    //             {
    //             }
    //             column(Redevance_No_; "No.")
    //             {
    //             }
    //             column(Redevance_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF "Taxe Redevance" <> 0 THEN IntCompteur += 1;
    //                 if "Taxe Redevance" = 0 then
    //                     CurrReport.Skip();
    //                 //        CurrReport.SHOWOUTPUT("Taxe Redevance" <> 0);
    //             end;
    //         }
    //         dataitem(ContributionSocial; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     WHERE("Contribution Social" = FILTER(<> 0));
    //             column(ContributionSocial__Contribution_Social_; "Contribution Social")
    //             {
    //             }
    //             column("Contribution_Sociale_de_SolidaritéCaption"; Contribution_Sociale_de_SolidaritéCaptionLbl)
    //             {
    //             }
    //             column(ContributionSocial_No_; "No.")
    //             {
    //             }
    //             column(ContributionSocial_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF "Contribution Social" <> 0 THEN IntCompteur += 1;
    //             end;
    //         }
    //         dataitem(SAUT; Integer)
    //         {
    //             column(Compteur_Number; Number)
    //             {
    //             }
    //             trigger OnPreDataItem()
    //             begin
    //                 //     SETRANGE(Number, 1, 24 - IntCompteur);
    //                 SETRANGE(Number, 1, 24 - IntCompteur);
    //             end;
    //         }
    //         dataitem(Compteur; Integer)
    //         {
    //             DataItemTableView = SORTING(Number)
    //                                     ORDER(Ascending);

    //             trigger OnPreDataItem()
    //             begin
    //                 SETRANGE(Number, 1, (50 - LinesPrinted));
    //             end;
    //         }
    //         dataitem("<Indemnities AV Nature>"; "Rec. Indemnities")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                "Employee No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
    //                                     ORDER(Ascending)
    //                                     WHERE(Type = FILTER(Imposable),
    //                                           "Avantage en nature" = FILTER(true));
    //         }
    //         dataitem("Salary Lines5"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                                Employee = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", Employee)
    //                                     ORDER(Ascending);
    //             column(Salary_Lines5__Gross_Salary_; "Gross Salary")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Lines5__Net_salary_cashed_; "Net salary cashed")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Lines5_CNSS; CNSS)
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Lines5__Taxable_salary_; "Taxable salary")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Lines5__Taxe__Month__; "Taxe (Month)")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }

    //             column(Salary_Lines5_No_; "No.")
    //             {
    //             }
    //             column(Salary_Lines5_Employee; Employee)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 // RibSalarie := '';
    //                 // IF RecEpmloyee.GET(Employee) THEN;
    //                 // IF RecEpmloyee."Mode de règlement" = RecEpmloyee."Mode de règlement"::Virement THEN RibSalarie := 'RIB ' + RIB;
    //             end;
    //         }
    //         trigger OnAfterGetRecord()
    //         begin
    //             RibSalarie := '';
    //             IF RecEpmloyee.GET(Employee) THEN;
    //             IF RecEpmloyee."Mode de règlement" = RecEpmloyee."Mode de règlement"::Virement THEN RibSalarie := 'RIB ' + RIB;
    //             //*******************MH 22/10/2016 *********************
    //             RecSalarylines.RESET;
    //             RecSalarylines.SETRANGE("No.", "No.");
    //             RecSalarylines.SETRANGE(Employee, Employee);
    //             IF RecSalarylines.FINDFIRST THEN BEGIN
    //                 RecAffectation.RESET;
    //                 RecAffectation.SETRANGE(RecAffectation.Section, RecSalarylines.Affectation);
    //                 IF RecAffectation.FINDFIRST THEN Affect := RecAffectation.Decription;

    //                 RecQualification.RESET;
    //                 RecQualification.SETRANGE(RecQualification.Code, RecSalarylines.Qualification);
    //                 IF RecQualification.FINDFIRST THEN qualif := RecQualification.Description;

    //             END;
    //             //*******************MH 22/10/2016 *********************
    //             IntCompteur := 0;
    //             nom := CompInfo.Name;
    //             adresse := CompInfo.Address;
    //             tél := CompInfo."Phone No.";
    //             fax := CompInfo."Fax No.";
    //             regcom := CompInfo."Matricule Fiscale";
    //             Nsiret := CompInfo."Registration No.";
    //             Nss := CompInfo."N° CNSS";
    //             CompInfo.CALCFIELDS(CompInfo."Entete de page");
    //             LinesPrinted := 0;
    //             if Month > 12 then
    //                 CurrReport.Skip();
    //             // CurrReport.SHOWOUTPUT(Month < 12);
    //             IF CurrReport.SHOWOUTPUT THEN
    //                 LinesPrinted := LinesPrinted + 11;
    //             IF "Salary Headers1"."Regime quinzaine" <> '' THEN
    //                 IF "Salary Headers1".Quinzaine = 0 THEN
    //                     Qaunzaine := '1er Qauinzaine'
    //                 ELSE
    //                     Qaunzaine := '2eme Qauinzaine';
    //             if STC then
    //                 CurrReport.Skip();
    //             //CurrReport.SHOWOUTPUT(NOT STC);
    //         end;
    //     }
    //     /*  trigger OnAfterGetRecord()
    //       begin

    //           IntCompteur := 0;
    //           nom := CompInfo.Name;
    //           adresse := CompInfo.Address;
    //           tél := CompInfo."Phone No.";
    //           fax := CompInfo."Fax No.";
    //           regcom := CompInfo."Matricule Fiscale";
    //           Nsiret := CompInfo."Registration No.";
    //           Nss := CompInfo."N° CNSS";
    //           CompInfo.CALCFIELDS(CompInfo."Entete de page");
    //           LinesPrinted := 0;
    //           if Month > 12 then
    //               CurrReport.Skip();
    //           // CurrReport.SHOWOUTPUT(Month < 12);
    //           IF CurrReport.SHOWOUTPUT THEN
    //               LinesPrinted := LinesPrinted + 11;
    //           IF "Salary Headers1"."Regime quinzaine" <> '' THEN
    //               IF "Salary Headers1".Quinzaine = 0 THEN
    //                   Qaunzaine := '1er Qauinzaine'
    //               ELSE
    //                   Qaunzaine := '2eme Qauinzaine';
    //           CurrReport.SHOWOUTPUT(NOT STC);
    //       end;
    //   }*/
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     CompInfo.GET();
    // end;

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     LoanAdvanceHeader: Record "Loan & Advance Header";
    //     TotalFor: Label 'Total ';
    //     PrintDetails: Boolean;
    //     ln: Integer;
    //     remaning: Integer;
    //     Param: Record 5218;
    //     base: Decimal;
    //     DescBase: Text[30];
    //     supp: Decimal;
    //     DesSupp: Text[30];
    //     CompInfo: Record 79;
    //     nom: Text[50];
    //     adresse: Text[100];
    //     "tél": Text[20];
    //     fax: Text[20];
    //     regcom: Text[30];
    //     Nsiret: Text[20];
    //     Nss: Code[30];
    //     LinesPrinted: Integer;
    //     MntDeduit: Decimal;
    //     SBDeduit: Decimal;
    //     Jourheuretravail: Text[30];
    //     NBJourtravail: Decimal;
    //     TypeAv: Record "Loan & Advance Type";
    //     LibelleAv: Text[30];
    //     jourheureabs: Text[30];
    //     RecGContrat: Record 5211;
    //     RecGRegime: Record "Regimes of work";
    //     DECGNBHEURE: Decimal;
    //     DECGNBJOURS: Decimal;
    //     RecSalarylines: Record "Rec. Salary Lines";
    //     decnote: Decimal;
    //     txtnote: Text[30];
    //     Jourconge: Text[30];
    //     nbjourconge: Decimal;
    //     nbjourferie: Decimal;
    //     nbrjoursean: Decimal;
    //     textsalaire: Text[30];
    //     Qaunzaine: Text[30];
    //     IntCompteur: Decimal;
    //     RibSalarie: Code[30];
    //     RecEpmloyee: Record 5200;
    //     Affect: Text[150];
    //     qualif: Text[150];
    //     RecAffectation: Record Section;
    //     RecQualification: Record 5202;
    //     JoursPayement: Decimal;
    //     DesRebrique: Text[30];
    //     RecLoanAdvanceHeader: Record "Loan & Advance Header";
    //     NumBonCaisse: Code[20];
    //     DUPLICATACaptionLbl: Label 'DUPLICATA';
    //     Arrondissement____CaptionLbl: Label 'Arrondissement (-)';
    //     Arrondissement____Caption_Control1000000080Lbl: Label 'Arrondissement (+)';
    //     Redevance_De_CompensationCaptionLbl: Label 'Redevance De Compensation';
    //     "Contribution_Sociale_de_SolidaritéCaptionLbl": Label 'Contribution Sociale de Solidarité';
}

