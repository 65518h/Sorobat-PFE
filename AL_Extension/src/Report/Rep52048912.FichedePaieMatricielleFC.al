// report 52048912 "Fiche de Paie MatricielleFC@"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './FichedePaieMatricielleFC.rdl';

//     dataset
//     {
//         dataitem("Salary Headers"; "Salary Headers")
//         {
//             DataItemTableView = SORTING("No.")
//                                 ORDER(Ascending);
//             column(Salary_Headers_No_; "No.")
//             {
//             }
//             dataitem("Salary Lines"; "Salary Lines")
//             {
//                 DataItemLink = "No." = FIELD("No.");
//                 column(Salary_Lines_No_; "No.")
//                 {
//                 }
//                 column(Salary_Lines_Employee; Employee)
//                 {
//                 }
//                 column(Salary_Lines_Month; Month)
//                 {
//                 }
//                 column(Salary_Lines_Year; Year)
//                 {
//                 }
//                 dataitem("Salary Headers1"; "Salary Headers")
//                 {
//                     DataItemLink = "No." = FIELD("No.");
//                     DataItemTableView = SORTING("No.")
//                                         ORDER(Ascending);
//                     column(nom; nom)
//                     {
//                     }
//                     column(CompInfo__Address_2_; CompInfo."Address 2")
//                     {
//                     }
//                     column(Nss; Nss)
//                     {
//                     }
//                     column(Salary_Headers1_Year; Year)
//                     {
//                     }
//                     column(Salary_Headers1_Month; Month)
//                     {
//                     }
//                     column(Salary_Headers1_No_; "No.")
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     begin

//                         IntCompteur := 0;
//                         nom := CompInfo.Name;
//                         adresse := CompInfo.Address;
//                         tél := CompInfo."Phone No.";
//                         fax := CompInfo."Fax No.";
//                         regcom := CompInfo."Matricule Fiscale";
//                         Nsiret := CompInfo."Registration No.";
//                         Nss := CompInfo."N° CNSS";
//                         CompInfo.CALCFIELDS(CompInfo."Entete de page");
//                         LinesPrinted := 0;
//                         CurrReport.SHOWOUTPUT(Month < 12);
//                         IF CurrReport.SHOWOUTPUT THEN
//                             LinesPrinted := LinesPrinted + 11;
//                         IF "Salary Headers1"."Regime quinzaine" <> '' THEN
//                             IF "Salary Headers1".Quinzaine = 0 THEN
//                                 Qaunzaine := '1er Qauinzaine'
//                             ELSE
//                                 Qaunzaine := '2eme Qauinzaine'

//                     end;
//                 }
//                 dataitem(Employee; Employee)
//                 {
//                     DataItemLink = "No." = FIELD(Employee);
//                     DataItemTableView = SORTING("No.")
//                                         ORDER(Ascending);
//                     column(Employee__No__; "No.")
//                     {
//                     }
//                     column(Employee__First_Name_; "First Name")
//                     {
//                     }
//                     column(Employee__Description_Qualification_; "Description Qualification")
//                     {
//                     }
//                     column(Employee__Social_Security_No__; "Social Security No.")
//                     {
//                     }
//                     column(Employee__Nombre_Enfant_; "Nombre Enfant")
//                     {
//                     }
//                     column(Employee__Deccription_Affectation_; "Deccription Affectation")
//                     {
//                     }
//                     column("Employee_Employee_Collège"; Employee.Collège)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     var

//                         salaryqualification: Record "Employee Qualification";
//                     begin

//                         IF CurrReport.SHOWOUTPUT THEN
//                             LinesPrinted := LinesPrinted + 9;

//                         IF RecGContrat.GET("Emplymt. Contract Code") THEN
//                             IF RecGRegime.GET(RecGContrat."Regimes of work") THEN BEGIN
//                                 DECGNBHEURE := RecGRegime."Work Hours per month";
//                                 DECGNBJOURS := RecGRegime."Worked Day Per Month";
//                             END;

//                         IF "Employee's type" = 1 THEN BEGIN
//                             Jourheuretravail := 'NB J';
//                             jourheureabs := 'NB Jours absence';
//                             DECGNBJOURS := "Salary Lines"."Paied days";
//                             NBJourtravail := (DECGNBJOURS);//-"Salary Lines".Absences);
//                         END
//                         ELSE BEGIN
//                             Jourheuretravail := 'NB H';
//                             jourheureabs := 'NB Heures absence';
//                             RecSalarylines.RESET;
//                             RecSalarylines.SETRANGE("No.", "Salary Headers"."No.");
//                             RecSalarylines.SETRANGE(Employee, "No.");
//                             DECGNBHEURE := "Salary Lines"."Worked hours";
//                             NBJourtravail := (DECGNBHEURE);//-("Salary Lines".Absences));
//                         END;
//                         //>>MBY 20/04/2009
//                         Jourconge := '';
//                         nbjourconge := 0;
//                         IF ("Salary Lines".Month = 13) AND ("Employee's type" <> 1) THEN BEGIN
//                             Jourconge := 'NB J';
//                             nbjourconge := "Salary Lines"."Days off remaining";
//                         END;
//                         //<<MBY

//                         IF RecGContrat.GET("Emplymt. Contract Code") THEN
//                             IF RecGRegime.GET(RecGContrat."Regimes of work") THEN
//                                 IF Employee."Employee's type" = 0 THEN BEGIN
//                                     // IF "Salary Lines".congé>0 THEN
//                                     // nbjourconge:=ROUND("Salary Lines".congé/RecGRegime."From Work day to Work hour",0.1);
//                                     IF "Salary Lines"."Jours Fériés" > 0 THEN
//                                         nbjourferie := "Salary Lines"."Jours Fériés"
//                                 END ELSE
//                                     nbjourconge := "Salary Lines".congé;
//                         nbjourferie := "Salary Lines"."Jours Fériés";
//                         BEGIN
//                         END;



//                         decnote := 0;
//                         txtnote := '';
//                         RecSalarylines.RESET;
//                         RecSalarylines.SETRANGE("No.", "Salary Headers"."No.");
//                         RecSalarylines.SETRANGE(Employee, "No.");
//                         IF RecSalarylines.FIND('-') THEN BEGIN
//                             decnote := RecSalarylines.Note;
//                             IF decnote > 0 THEN txtnote := 'Note'
//                         END;
//                         salaryqualification.SETFILTER("Employee No.", "No.");
//                         IF salaryqualification.FINDLAST THEN
//                             "Job Title" := salaryqualification.Description;
//                     end;
//                 }
//                 dataitem("<Recorded Worked hours1>"; "Heures sup. eregistrées m")
//                 {
//                     DataItemLink = "N° Salarié" = FIELD(Employee),
//                                    "Mois de paiement" = FIELD(Month),
//                                    "Année de paiement" = FIELD(Year);
//                     DataItemTableView = SORTING("N° transaction", "N° Ligne", "N° Salarié")
//                                         ORDER(Ascending)
//                                         WHERE("Nombre Heures Supp" = FILTER(1));
//                     trigger OnAfterGetRecord()
//                     var
//                     begin

//                         ln := 26;  //ABR
//                         // CurrReport.SHOWOUTPUT :=
//                         //   CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration");

//                         IF (CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration")) THEN
//                             ln := ln + 1;
//                         //CurrReport.SHOWOUTPUT(FALSE);
//                     end;
//                 }
//                 dataitem("Salary Lines1"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                     column(ROUND__Real_basis_salary__0_001_; ROUND("Real basis salary", 0.001))
//                     {
//                         AutoFormatType = 0;
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Salaire_de_Base_; 'Salaire de Base')
//                     {
//                     }
//                     column(Salary_Lines1__Basis_salary_; "Basis salary")
//                     {
//                     }
//                     column(Salary_Lines___Paied_days_; "Salary Lines"."Paied days")
//                     {
//                     }
//                     column(Salary_Lines1_No_; "No.")
//                     {
//                     }
//                     column(Salary_Lines1_Employee; Employee)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     begin

//                         //IF ("Salary Lines1"."Employee's type" = 0) THEN CurrReport.SHOWOUTPUT (FALSE);


//                         IF CurrReport.SHOWOUTPUT THEN BEGIN
//                             IntCompteur += 1;
//                             LinesPrinted := LinesPrinted + 1;
//                         END;
//                         SBDeduit := 0;
//                         IF Absences > 0 THEN
//                             IF "Salary Lines1"."Employee's type" = 1 THEN
//                                 SBDeduit := ("Basis salary" - "Real basis salary")
//                             ELSE
//                                 SBDeduit := (("Basis salary" * DECGNBHEURE) - "Real basis salary");
//                         IF "Salary Lines1"."Employee's type" = 1 THEN
//                             textsalaire := 'Jours Travaillés'
//                         ELSE
//                             textsalaire := 'Heures Travaillées';

//                         IF ("NB Mois Gratif" <> 0) AND (Month > 11) THEN
//                             textsalaire := 'Nombre de Mois : ' + FORMAT("NB Mois Gratif");
//                     end;
//                 }
//                 dataitem(Indemnities1; Indemnities)
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    "Employee No." = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
//                                         ORDER(Ascending)
//                                         WHERE(Type = FILTER(Imposable));
//                     column(ROUND__Real_Amount__0_001_; ROUND("Real Amount", 0.001))
//                     {
//                         AutoFormatType = 0;
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Indemnities1_Description; Description)
//                     {
//                     }
//                     column(Salary_Lines___Paied_days__Control1000000035; "Salary Lines"."Paied days")
//                     {
//                     }
//                     column(Indemnities1_No_; "No.")
//                     {
//                     }
//                     column(Indemnities1_Employee_No_; "Employee No.")
//                     {
//                     }
//                     column(Indemnities1_Indemnity; Indemnity)
//                     {
//                     }
//                     column(Indemnities1_Non_Inclus_en_Prime; "Non Inclus en Prime")
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     var

//                     begin
//                         nbrjoursean := 0;
//                         IF "Evaluation mode" = "Evaluation mode"::"on Flight hours" THEN
//                             nbrjoursean := Indemnities1.Rate;

//                         IF CurrReport.SHOWOUTPUT THEN
//                             LinesPrinted := LinesPrinted + 1;
//                         MntDeduit := 0;
//                         IF Indemnities1."Base Amount" > Indemnities1."Real Amount" THEN
//                             MntDeduit := Indemnities1."Base Amount" - Indemnities1."Real Amount";
//                         Param.GET;
//                         // DSFT-AGA 15/07/2010
//                         CurrReport.SHOWOUTPUT(Indemnities1."Real Amount" <> 0);
//                         IF Indemnities1."Real Amount" <> 0 THEN IntCompteur += 1;
//                     end;
//                 }
//                 dataitem("<Recorded Worked hours2>"; "Heures sup. eregistrées m")
//                 {
//                     DataItemLink = "N° Salarié" = FIELD(Employee),
//                                    "Mois de paiement" = FIELD(Month),
//                                    "Année de paiement" = FIELD(Year),
//                                    Quinzaine = FIELD(Quinzaine);
//                     DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
//                                         ORDER(Ascending)
//                                         WHERE("Type Jours" = FILTER("Prime Astreinte"));

//                     trigger OnPreDataItem()
//                     begin
//                         LastFieldNo := FIELDNO("Montant Ligne");
//                     end;
//                 }
//                 dataitem("<Recorded Worked hours21>"; "Heures sup. eregistrées m")
//                 {
//                     DataItemLink = "N° Salarié" = FIELD(Employee),
//                                    "Mois de paiement" = FIELD(Month),
//                                    "Année de paiement" = FIELD(Year),
//                                    Quinzaine = FIELD(Quinzaine);
//                     DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
//                                         ORDER(Ascending)
//                                         WHERE("Type Jours" = FILTER(Nuit));
//                 }
//                 dataitem("<Heures sup. eregistrées m3>"; "Heures sup. eregistrées m")
//                 {
//                     DataItemLink = "N° Salarié" = FIELD(Employee),
//                                    "Mois de paiement" = FIELD(Month),
//                                    "Année de paiement" = FIELD(Year);
//                     DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
//                                         ORDER(Ascending);
//                     column(ROUND__Montant_Ligne__0_001_; ROUND("Montant Ligne", 0.001))
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column("Heures_sup__eregistrées_m3___Nombre_Heures_Supp_"; "Nombre Heures Supp")
//                     {
//                         DecimalPlaces = 0 : 1;
//                     }
//                     column(FORMAT__Type_Jours__; FORMAT("Type Jours"))
//                     {
//                     }
//                     column("Heures_sup__eregistrées_m3__N__transaction"; "N° transaction")
//                     {
//                     }
//                     column("Heures_sup__eregistrées_m3__N__Ligne"; "N° Ligne")
//                     {
//                     }
//                     column("Heures_sup__eregistrées_m3__N__Salarié"; "N° Salarié")
//                     {
//                     }
//                     column("Heures_sup__eregistrées_m3__Mois_de_paiement"; "Mois de paiement")
//                     {
//                     }
//                     column("Heures_sup__eregistrées_m3__Année_de_paiement"; "Année de paiement")
//                     {
//                     }
//                 }
//                 dataitem("<Heures sup. eregistrées m4>"; "Heures sup. eregistrées m")
//                 {
//                     DataItemLink = "N° Salarié" = FIELD(Employee),
//                                    "Mois de paiement" = FIELD(Month),
//                                    "Année de paiement" = FIELD(Year);
//                     DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
//                                         ORDER(Ascending)
//                                         WHERE("Type Jours" = FILTER(Nuit));
//                 }
//                 dataitem("Employee's days off Entry"; "Employee's days off Entry")
//                 {
//                     DataItemLink = "Employee No." = FIELD(Employee),
//                                    "Posting month" = FIELD(Month),
//                                    "Posting year" = FIELD(Year);
//                     DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
//                                         ORDER(Ascending)
//                                         WHERE("Line type" = FILTER('Jour férier payé'));
//                 }
//                 dataitem("<Employee's days off Entry1>"; "Employee's days off Entry")
//                 {
//                     DataItemLink = "Employee No." = FIELD(Employee),
//                                    "Posting month" = FIELD(Month),
//                                    "Posting year" = FIELD(Year);
//                     DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
//                                         ORDER(Ascending)
//                                         WHERE("Motif D'absence" = FILTER('Congé de Maladie'),
//                                               "Line type" = FILTER(' '));
//                 }
//                 dataitem("<Employee's days off Entry2>"; "Employee's days off Entry")
//                 {
//                     DataItemLink = "Employee No." = FIELD(Employee),
//                                    "Posting month" = FIELD(Month),
//                                    "Posting year" = FIELD(Year);
//                     DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
//                                         ORDER(Ascending)
//                                         WHERE("Motif D'absence" = FILTER('Accident de travail'),
//                                               "Line type" = FILTER(' '));
//                 }
//                 dataitem("Salary Lines2"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                 }
//                 dataitem("Social Contributions1"; "Social Contributions")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
//                                         ORDER(Ascending)
//                                         WHERE("Deductible of taxable basis" = FILTER(true),
//                                               "Real Amount : Employee" = FILTER(<> 0));
//                 }
//                 dataitem(Indemnitiesimpassej; Indemnities)
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    "Employee No." = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
//                                         ORDER(Ascending)
//                                         WHERE(Type = FILTER('Imposable (Non Assujettie Socialement)'));
//                 }
//                 dataitem("Salary Lines3"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                 }
//                 dataitem("<RCGC>"; "Social Contributions")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
//                                         ORDER(Ascending)
//                                         WHERE("Deductible of taxable basis" = FILTER(false),
//                                               "Real Amount : Employee" = FILTER(<> 0));
//                 }
//                 dataitem(Indemnities2; Indemnities)
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    "Employee No." = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
//                                         ORDER(Ascending)
//                                         WHERE(Type = FILTER('Non imposable'));
//                     column(Indemnities2__Real_Amount_; "Real Amount")
//                     {
//                         AutoFormatType = 2;
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Indemnities2_Description; Description)
//                     {
//                     }
//                     column(Indemnities2_No_; "No.")
//                     {
//                     }
//                     column(Indemnities2_Employee_No_; "Employee No.")
//                     {
//                     }
//                     column(Indemnities2_Indemnity; Indemnity)
//                     {
//                     }
//                     column(Indemnities2_Non_Inclus_en_Prime; "Non Inclus en Prime")
//                     {
//                     }
//                 }
//                 dataitem("Social Contributions2"; "Social Contributions")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
//                                         ORDER(Ascending)
//                                         WHERE("Deductible of taxable basis" = FILTER(true),
//                                               "Real Amount : Employee" = FILTER(<> 0));
//                 }
//                 dataitem("Expenses to repay Header"; "Expenses to repay Header")
//                 {
//                     DataItemLink = "Employee No." = FIELD(Employee),
//                                    "Payment month" = FIELD(Month),
//                                    "Payment year" = FIELD(Year);
//                     DataItemTableView = SORTING("No.")
//                                         ORDER(Ascending)
//                                         WHERE(Status = FILTER(Validated),
//                                               Repaied = FILTER(false));
//                 }
//                 dataitem("Salary Lines4"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                 }
//                 dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
//                 {
//                     DataItemLink = Employee = FIELD(Employee),
//                                    "Payment No." = FIELD("No.");
//                     DataItemTableView = SORTING("No.", "Entry No.")
//                                         ORDER(Ascending)
//                                         WHERE("Remboursement Anticipé" = CONST(false));
//                     column(Loan___Advance_Lines__Line_Amount_; "Line Amount")
//                     {
//                         AutoFormatType = 1;
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Loan___Advance_Lines_Type; Type)
//                     {
//                     }
//                     column(Avance_; 'Avance')
//                     {
//                     }
//                     column(Loan___Advance_Lines_No_; "No.")
//                     {
//                     }
//                     column(Loan___Advance_Lines_Entry_No_; "Entry No.")
//                     {
//                     }
//                     column(Loan___Advance_Lines_Employee; Employee)
//                     {
//                     }
//                     column(Loan___Advance_Lines_Payment_No_; "Payment No.")
//                     {
//                     }

//                     trigger OnAfterGetRecord()
//                     begin
//                         LoanAdvanceHeader.GET("Loan & Advance Lines"."No.");
//                     end;
//                 }
//                 dataitem("Salary Lines6"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                     column(Salary_Lines6__Report_en___; "Report en -")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Arrondissement____Caption; Arrondissement____CaptionLbl)
//                     {
//                     }
//                     column(Salary_Lines6_No_; "No.")
//                     {
//                     }
//                     column(Salary_Lines6_Employee; Employee)
//                     {
//                     }
//                 }
//                 dataitem("Salary Lines7"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                     column(Salary_Lines7__Ajout__en___; "Ajout  en +")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Arrondissement____Caption_Control1000000080; Arrondissement____Caption_Control1000000080Lbl)
//                     {
//                     }
//                     column(Salary_Lines7_No_; "No.")
//                     {
//                     }
//                     column(Salary_Lines7_Employee; Employee)
//                     {
//                     }
//                 }
//                 dataitem(Redevance; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         WHERE("Taxe Redevance" = FILTER(<> 0));
//                     column(Redevance__Taxe_Redevance_; "Taxe Redevance")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Redevance_De_CompensationCaption; Redevance_De_CompensationCaptionLbl)
//                     {
//                     }
//                     column(Redevance_No_; "No.")
//                     {
//                     }
//                     column(Redevance_Employee; Employee)
//                     {
//                     }
//                 }
//                 dataitem(ContributionSocial; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         WHERE("Contribution Social" = FILTER(<> 0));
//                     column(ContributionSocial__Contribution_Social_; "Contribution Social")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column("Contribution_Sociale_de_SolidaritéCaption"; Contribution_Sociale_de_SolidaritéCaptionLbl)
//                     {
//                     }
//                     column(ContributionSocial_No_; "No.")
//                     {
//                     }
//                     column(ContributionSocial_Employee; Employee)
//                     {
//                     }
//                 }
//                 dataitem(SAUT; Integer)
//                 {
//                 }
//                 dataitem(Compteur; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         ORDER(Ascending);

//                     trigger OnPreDataItem()
//                     begin
//                         SETRANGE(Number, 1, (50 - LinesPrinted));
//                     end;
//                 }
//                 dataitem("<Indemnities AV Nature>"; Indemnities)
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    "Employee No." = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
//                                         ORDER(Ascending)
//                                         WHERE(Type = FILTER(Imposable),
//                                               "Avantage en nature" = FILTER(true));
//                 }
//                 dataitem("Salary Lines5"; "Salary Lines")
//                 {
//                     DataItemLink = "No." = FIELD("No."),
//                                    Employee = FIELD(Employee);
//                     DataItemTableView = SORTING("No.", Employee)
//                                         ORDER(Ascending);
//                     column(Salary_Lines5__Gross_Salary_; "Gross Salary")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Salary_Lines5__Net_salary_cashed_; "Net salary cashed")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Salary_Lines5_CNSS; CNSS)
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Salary_Lines5__Taxable_salary_; "Taxable salary")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(Salary_Lines5__Taxe__Month__; "Taxe (Month)")
//                     {
//                         DecimalPlaces = 3 : 3;
//                     }
//                     column(RibSalarie; RibSalarie)
//                     {
//                         //DecimalPlaces = 3:3;
//                     }
//                     column(Salary_Lines5_No_; "No.")
//                     {
//                     }
//                     column(Salary_Lines5_Employee; Employee)
//                     {
//                     }
//                 }
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         CompInfo.GET();
//     end;

//     var
//         LastFieldNo: Integer;
//         FooterPrinted: Boolean;
//         LoanAdvanceHeader: Record "Loan & Advance Header";
//         TotalFor: Label 'Total ';
//         PrintDetails: Boolean;
//         ln: Integer;
//         remaning: Integer;
//         Param: Record 5218;
//         base: Decimal;
//         DescBase: Text[30];
//         supp: Decimal;
//         DesSupp: Text[30];
//         CompInfo: Record 79;
//         nom: Text[50];
//         adresse: Text[100];
//         "tél": Text[20];
//         fax: Text[20];
//         regcom: Text[30];
//         Nsiret: Text[20];
//         Nss: Code[30];
//         LinesPrinted: Integer;
//         MntDeduit: Decimal;
//         SBDeduit: Decimal;
//         Jourheuretravail: Text[30];
//         NBJourtravail: Decimal;
//         TypeAv: Record "Loan & Advance Type";
//         LibelleAv: Text[30];
//         jourheureabs: Text[30];
//         RecGContrat: Record 5211;
//         RecGRegime: Record "Regimes of work";
//         DECGNBHEURE: Decimal;
//         DECGNBJOURS: Decimal;
//         RecSalarylines: Record "Salary Lines";
//         decnote: Decimal;
//         txtnote: Text[30];
//         Jourconge: Text[30];
//         nbjourconge: Decimal;
//         nbjourferie: Decimal;
//         nbrjoursean: Decimal;
//         textsalaire: Text[30];
//         Qaunzaine: Text[30];
//         IntCompteur: Decimal;
//         RibSalarie: Code[30];
//         RecEpmloyee: Record 5200;
//         "// RB SORO 09/02/2016": Integer;
//         TAXABLE: Decimal;
//         Arrondissement____CaptionLbl: Label 'Arrondissement (-)';
//         Arrondissement____Caption_Control1000000080Lbl: Label 'Arrondissement (+)';
//         Redevance_De_CompensationCaptionLbl: Label 'Redevance De Compensation';
//         "Contribution_Sociale_de_SolidaritéCaptionLbl": Label 'Contribution Sociale de Solidarité';
// }

