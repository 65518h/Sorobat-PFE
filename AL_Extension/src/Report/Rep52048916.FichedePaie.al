report 52048916 "Fiche de Paie"
{
    //Dans nav 2009 id "39001411"
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FichedePaie2.rdlc';
    //HS
    dataset
    {
        // dataitem("Salary Headers"; "Salary Headers")
        // {
        //     DataItemTableView = SORTING("No.")
        //                         ORDER(Ascending); 
        // column(Salary_Headers_No_; "No.")
        // {
        // }
        dataitem("Salary Lines"; "Salary Lines")
        {
            //  DataItemLink = "No." = FIELD("No.");
            RequestFilterFields = Departement, Service;
            column(TotaCotisPatronale_Control10000000202; Round(TotaCotisPatronale, 1))
            {
                DecimalPlaces = 0 : 0;
            }
            //
            column(CompInfoPicture; CompInfo.Picture) { }
            column(HumanResourcesSetupPicture; RecHumanResourcesSetup.Picture) { }
            column(Employee__No__; Employer."No.")
            {
            }
            column(Salary_Headers__Year; "Salary Headers1".Year)
            {
            }
            column(Salary_Headers__Month; "Salary Headers1".Month)
            {
            }
            column(CALCDATE__FM__TODAY_; CALCDATE('FM', TODAY))
            {
            }
            column("FORMAT_Employee__Mode_de_règlement__"; FORMAT(Employer."Mode de règlement"))
            {
            }
            // column(Employee__No__; "No.")
            // {
            // }
            column("Ancienneté"; Ancienneté)
            {
            }
            column(Employee__Social_Security_No__; Employer."Social Security No.")
            {
            }
            column(Employee_Echelons; Employer.Echelons)
            {
            }
            column(Employee_Fonction; Employer.Fonction)
            {
            }
            column(Employee_Employee__Statistic_Gpe_Descrip_; Employer."Statistic Gpe Descrip")
            {
            }
            column(CCN_CONVENTION_COLLECTIVE_; ' CCN CONVENTION COLLECTIVE')
            {
            }
            column(V173_330_; '173.330')
            {
            }
            column(First_Name_________Last_Name__; Employer."First Name" + ' ' + Employer."Last Name")
            {
            }
            column(Employee__Days_off___; Employer."Days off +")
            {
            }
            column(Employee__Days_off____Control1000000098; Employer."Days off =")
            {
            }
            column(Employee__Days_off____Control1000000099; Employer."Days off -")
            {
            }
            column("Année__Caption"; Année__CaptionLbl)
            {
            }
            column(Mois__Caption; Mois__CaptionLbl)
            {
            }
            column(Paiement_Le__Caption; Paiement_Le__CaptionLbl)
            {
            }
            column(Par__Caption; Par__CaptionLbl)
            {
            }
            column(MatriculeCaption; MatriculeCaptionLbl)
            {
            }
            column(NiveauCaption; NiveauCaptionLbl)
            {
            }
            column(CoeficientCaption; CoeficientCaptionLbl)
            {
            }
            column(IndiceCaption; IndiceCaptionLbl)
            {
            }
            column("AnciennetéCaption"; AnciennetéCaptionLbl)
            {
            }
            column("N__de_Sécurité_SocialeCaption"; N__de_Sécurité_SocialeCaptionLbl)
            {
            }
            column("CatégorieCaption"; CatégorieCaptionLbl)
            {
            }
            column("Emploi_OccupéCaption"; Emploi_OccupéCaptionLbl)
            {
            }
            column("DépartementCaption"; DépartementCaptionLbl)
            {
            }
            column(QualificationCaption; QualificationCaptionLbl)
            {
            }
            column(HoraireCaption; HoraireCaptionLbl)
            {
            }
            column("Repos_Comp__CongésCaption"; Repos_Comp__CongésCaptionLbl)
            {
            }
            column(AcquisCaption; AcquisCaptionLbl)
            {
            }
            column("Reste_à_PrendreCaption"; Reste_à_PrendreCaptionLbl)
            {
            }
            column(PrisCaption; PrisCaptionLbl)
            {
            }
            column(Commentaires__Caption; Commentaires__CaptionLbl)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column("DésignationCaption"; DésignationCaptionLbl)
            {
            }
            column(NombreCaption; NombreCaptionLbl)
            {
            }
            column(BaseCaption; BaseCaptionLbl)
            {
            }
            column(TauxCaption; TauxCaptionLbl)
            {
            }
            column(Part_SalarialCaption; Part_SalarialCaptionLbl)
            {
            }
            column(GainCaption; GainCaptionLbl)
            {
            }
            column(RetenueCaption; RetenueCaptionLbl)
            {
            }
            column(Part_PatronaleCaption; Part_PatronaleCaptionLbl)
            {
            }
            column(TauxCaption_Control1000000123; TauxCaption_Control1000000123Lbl)
            {
            }
            column(Ret__Caption; Ret__CaptionLbl)
            {
            }
            column(Ret__Caption_Control1000000125; Ret__Caption_Control1000000125Lbl)
            {
            }
            //////////////////
            column(TotaCotisEmployee2; TotaCotisEmployee)
            {
                AutoFormatType = 2;
                DecimalPlaces = 0 : 0;
            }
            column(Salary_Lines5__Net_salary_cashed_; "Net salary cashed")
            {
                DecimalPlaces = 3 : 3;
            }
            column(Salary_Lines5__Gross_Salary_; "Gross Salary")
            {
                AutoFormatType = 2;
                DecimalPlaces = 0 : 0;
            }
            column(Salary_Lines5__Salaire_Net_Imposable_; "Salaire Net Imposable")
            {
            }

            // column(TotaCotisPatronale_Control1000000020; TotaCotisPatronale)
            // {
            //     DecimalPlaces = 0 : 0;
            // }
            column(Employer__Cumul_Salaire_Brut_; Employer."Cumul Salaire Brut")
            {
                AutoFormatType = 2;
                DecimalPlaces = 0 : 0;
            }
            column(Employer__Cumul_Salaire_Net_Imposable_; Employer."Cumul Salaire Net Imposable")
            {
            }
            column(Employer__Cumul_Charge_Salariale_; Employer."Cumul Charge Salariale")
            {
                AutoFormatType = 2;
                DecimalPlaces = 0 : 0;
            }
            column(Employer__Cumul_Charge_Patronale_; Round(Employer."Cumul Charge Patronale", 1))
            {
                DecimalPlaces = 0 : 0;
            }
            column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
            {
            }
            column(CumulsCaption; CumulsCaptionLbl)
            {
            }
            column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
            {
            }
            column(Net_ImposableCaption; Net_ImposableCaptionLbl)
            {
            }
            column(Charges_SalarialesCaption; Charges_SalarialesCaptionLbl)
            {
            }
            column(Charges_PatronaleCaption; Charges_PatronaleCaptionLbl)
            {
            }
            column(Heure_SupCaption; Heure_SupCaptionLbl)
            {
            }
            column("Heures_TravailléesCaption"; Heures_TravailléesCaptionLbl)
            {
            }
            column("PériodeCaption"; PériodeCaptionLbl)
            {
            }
            column("AnnéeCaption"; AnnéeCaptionLbl)
            {
            }
            column(Salary_Lines5_No_; "No.")
            {
            }
            column(Salary_Lines5_Employee; Employee)
            {
            }
            column(TotaCotisEmployee_Control1000000019; TotaCotisEmployee)
            {
                AutoFormatType = 2;
                DecimalPlaces = 0 : 0;
            }
            column(Salary_Lines_No_; "No.")
            {
            }
            column(Salary_Lines_Employee; Employee)
            {
            }
            column(Salary_Lines_Month; Month)
            {
            }
            column(Salary_Lines_Year; Year)
            {
            }
            dataitem("Salary Headers1"; "Salary Headers")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.")
                                        ORDER(Ascending);
            }
            dataitem(Employee; 5200)
            {
                CalcFields = "Cumul Salaire Brut", "Cumul Salaire Net Imposable", "Cumul Charge Salariale", "Cumul Charge Patronale";
                DataItemLink = "No." = FIELD(Employee);
                DataItemTableView = SORTING("No.")
                                        ORDER(Ascending);
                // column(Salary_Headers__Year; "Salary Headers1".Year)
                // {
                // }
                // column(Salary_Headers__Month; "Salary Headers1".Month)
                // {
                // }
                // column(CALCDATE__FM__TODAY_; CALCDATE('FM', TODAY))
                // {
                // }
                // column("FORMAT_Employee__Mode_de_règlement__"; FORMAT(Employee."Mode de règlement"))
                // {
                // }
                // // column(Employee__No__; "No.")
                // // {
                // // }
                // column("Ancienneté"; Ancienneté)
                // {
                // }
                // column(Employee__Social_Security_No__; "Social Security No.")
                // {
                // }
                // column(Employee_Echelons; Echelons)
                // {
                // }
                // column(Employee_Fonction; Fonction)
                // {
                // }
                // column(Employee_Employee__Statistic_Gpe_Descrip_; Employee."Statistic Gpe Descrip")
                // {
                // }
                // column(CCN_CONVENTION_COLLECTIVE_; ' CCN CONVENTION COLLECTIVE')
                // {
                // }
                // column(V173_330_; '173.330')
                // {
                // }
                // column(First_Name_________Last_Name__; "First Name" + ' ' + "Last Name")
                // {
                // }
                // column(Employee__Days_off___; "Days off +")
                // {
                // }
                // column(Employee__Days_off____Control1000000098; "Days off =")
                // {
                // }
                // column(Employee__Days_off____Control1000000099; "Days off -")
                // {
                // }
                // column("Année__Caption"; Année__CaptionLbl)
                // {
                // }
                // column(Mois__Caption; Mois__CaptionLbl)
                // {
                // }
                // column(Paiement_Le__Caption; Paiement_Le__CaptionLbl)
                // {
                // }
                // column(Par__Caption; Par__CaptionLbl)
                // {
                // }
                // column(MatriculeCaption; MatriculeCaptionLbl)
                // {
                // }
                // column(NiveauCaption; NiveauCaptionLbl)
                // {
                // }
                // column(CoeficientCaption; CoeficientCaptionLbl)
                // {
                // }
                // column(IndiceCaption; IndiceCaptionLbl)
                // {
                // }
                // column("AnciennetéCaption"; AnciennetéCaptionLbl)
                // {
                // }
                // column("N__de_Sécurité_SocialeCaption"; N__de_Sécurité_SocialeCaptionLbl)
                // {
                // }
                // column("CatégorieCaption"; CatégorieCaptionLbl)
                // {
                // }
                // column("Emploi_OccupéCaption"; Emploi_OccupéCaptionLbl)
                // {
                // }
                // column("DépartementCaption"; DépartementCaptionLbl)
                // {
                // }
                // column(QualificationCaption; QualificationCaptionLbl)
                // {
                // }
                // column(HoraireCaption; HoraireCaptionLbl)
                // {
                // }
                // column("Repos_Comp__CongésCaption"; Repos_Comp__CongésCaptionLbl)
                // {
                // }
                // column(AcquisCaption; AcquisCaptionLbl)
                // {
                // }
                // column("Reste_à_PrendreCaption"; Reste_à_PrendreCaptionLbl)
                // {
                // }
                // column(PrisCaption; PrisCaptionLbl)
                // {
                // }
                // column(Commentaires__Caption; Commentaires__CaptionLbl)
                // {
                // }
                // column(N_Caption; N_CaptionLbl)
                // {
                // }
                // column("DésignationCaption"; DésignationCaptionLbl)
                // {
                // }
                // column(NombreCaption; NombreCaptionLbl)
                // {
                // }
                // column(BaseCaption; BaseCaptionLbl)
                // {
                // }
                // column(TauxCaption; TauxCaptionLbl)
                // {
                // }
                // column(Part_SalarialCaption; Part_SalarialCaptionLbl)
                // {
                // }
                // column(GainCaption; GainCaptionLbl)
                // {
                // }
                // column(RetenueCaption; RetenueCaptionLbl)
                // {
                // }
                // column(Part_PatronaleCaption; Part_PatronaleCaptionLbl)
                // {
                // }
                // column(TauxCaption_Control1000000123; TauxCaption_Control1000000123Lbl)
                // {
                // }
                // column(Ret__Caption; Ret__CaptionLbl)
                // {
                // }
                // column(Ret__Caption_Control1000000125; Ret__Caption_Control1000000125Lbl)
                // {
                // }

                trigger OnAfterGetRecord()
                var

                    salaryqualification: Record "Employee Qualification";
                begin
                    IF CompInfo.GET THEN nom := CompInfo.Name;
                    LinesPrinted := 0;


                    IntMoisAncienneté := Managementofsalary.CalculerAnneeAncienneté("No.");
                    IntAnnéeAncienneté := IntMoisAncienneté DIV 12;
                    Ancienneté := FORMAT(IntAnnéeAncienneté) + '    An(s)  Et ' + FORMAT(IntMoisAncienneté - IntAnnéeAncienneté * 12) + ' Mois';


                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 9;

                    IF RecGContrat.GET("Emplymt. Contract Code") THEN
                        IF RecGRegime.GET(RecGContrat."Regimes of work") THEN BEGIN
                            DECGNBHEURE := RecGRegime."Work Hours per month";
                            DECGNBJOURS := RecGRegime."Worked Day Per Month";
                        END;

                    IF "Employee's type" = 1 THEN BEGIN
                        Jourheuretravail := 'NB J';
                        jourheureabs := 'NB Jours absence';
                        DECGNBJOURS := "Salary Lines"."Paied days";
                        NBJourtravail := (DECGNBJOURS);//-"Salary Lines".Absences);
                    END
                    ELSE BEGIN
                        Jourheuretravail := 'NB H';
                        jourheureabs := 'NB Heures absence';
                        RecSalarylines.RESET;
                        RecSalarylines.SETRANGE("No.", "Salary Headers1"."No.");
                        RecSalarylines.SETRANGE(Employee, "No.");
                        DECGNBHEURE := "Salary Lines"."Worked hours";
                        NBJourtravail := (DECGNBHEURE);//-("Salary Lines".Absences));
                    END;
                    //>>MBY 20/04/2009
                    Jourconge := '';
                    nbjourconge := 0;
                    IF ("Salary Lines".Month = 13) AND ("Employee's type" <> 1) THEN BEGIN
                        Jourconge := 'NB J';
                        nbjourconge := "Salary Lines"."Days off remaining";
                    END;
                    //<<MBY

                    IF RecGContrat.GET("Emplymt. Contract Code") THEN
                        IF RecGRegime.GET(RecGContrat."Regimes of work") THEN
                            IF Employee."Employee's type" = 0 THEN BEGIN
                                IF "Salary Lines".congé > 0 THEN
                                    nbjourconge := ROUND("Salary Lines".congé / RecGRegime."From Work day to Work hour", 0.1);
                                IF "Salary Lines"."Jours Fériés" > 0 THEN
                                    nbjourferie := "Salary Lines"."Jours Fériés"
                            END ELSE
                                nbjourconge := "Salary Lines".congé;
                    nbjourferie := "Salary Lines"."Jours Fériés";
                    BEGIN
                    END;



                    decnote := 0;
                    txtnote := '';
                    RecSalarylines.RESET;
                    RecSalarylines.SETRANGE("No.", "Salary Headers1"."No.");
                    RecSalarylines.SETRANGE(Employee, "No.");
                    IF RecSalarylines.FIND('-') THEN BEGIN
                        decnote := RecSalarylines.Note;
                        IF decnote > 0 THEN txtnote := 'Note'
                    END;
                    salaryqualification.SETFILTER("Employee No.", "No.");
                    IF salaryqualification.FINDLAST THEN
                        "Job Title" := salaryqualification.Description;

                end;
            }
            dataitem("<Recorded Worked hours1>"; "Heures sup. eregistrées m")
            {
                DataItemLink = "N° Salarié" = FIELD(Employee),
                                   "Mois de paiement" = FIELD(Month),
                                   "Année de paiement" = FIELD(Year);
                DataItemTableView = SORTING("N° transaction", "N° Ligne", "N° Salarié")
                                        ORDER(Ascending)
                                        WHERE("Nombre d'heures" = FILTER(1));

                trigger OnAfterGetRecord()
                begin

                    ln := 26;  //ABR
                               //GL2025 CurrReport.SHOWOUTPUT :=
                               //   CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration");

                    // IF (CurrReport.TOTALSCAUSEDBY = "<Recorded Worked hours1>".FIELDNO("Taux de majoration")) THEN
                    //     ln := ln + 1;
                    //CurrReport.SHOWOUTPUT(FALSE);
                end;
            }
            dataitem("Salary Lines1"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
                column(ROUND__Real_basis_salary__0_001_; ROUND("Real basis salary", 0.001))
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(Salaire_de_Base_; 'Salaire de Base')
                {
                }
                column(ROUND__Paied_days__0_01_; ROUND("Paied days", 0.01))
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 2 : 2;
                }
                column(Salary_Lines1__Basis_salary_; "Basis salary")
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(V001Caption; V001CaptionLbl)
                {
                }
                column(Salary_Lines1_No_; "No.")
                {
                }
                column(Salary_Lines1_Employee; Employee)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //                    Message('fffff');

                    //IF ("Salary Lines1"."Employee's type" = 0) THEN CurrReport.SHOWOUTPUT (FALSE);
                    IntCompteur += 1;
                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1;

                    SBDeduit := 0;
                    IF Absences > 0 THEN
                        IF "Salary Lines1"."Employee's type" = 1 THEN
                            SBDeduit := ("Basis salary" - "Real basis salary")
                        ELSE
                            SBDeduit := (("Basis salary" * DECGNBHEURE) - "Real basis salary");
                end;
            }
            dataitem(Indemnities1; Indemnities)
            {
                DataItemLink = "No." = FIELD("No."),
                                   "Employee No." = FIELD(Employee);
                DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER(Imposable));
                column(Indemnities1__Real_Amount_; "Real Amount")
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(Indemnities1_Description; Description)
                {
                }
                column(Indemnities1_Indemnity; Indemnity)
                {
                }
                column(Indemnities1__Base_Amount_; "Base Amount")
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(Indemnities1_No_; "No.")
                {
                }
                column(Indemnities1_Employee_No_; "Employee No.")
                {
                }
                column(Indemnities1_Non_Inclus_en_Prime; "Non Inclus en Prime")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Indemnities1."Real Amount" <> 0 THEN IntCompteur += 1;
                    // Message(Description, Format("Base Amount"));
                    nbrjoursean := 0;
                    IF "Evaluation mode" = "Evaluation mode"::"Nombre X Montant par défaut" THEN
                        nbrjoursean := Indemnities1.Rate;



                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1;
                    MntDeduit := 0;
                    IF Indemnities1."Base Amount" > Indemnities1."Real Amount" THEN
                        MntDeduit := Indemnities1."Base Amount" - Indemnities1."Real Amount";
                    Param.GET;
                    // DSFT-AGA 15/07/2010
                    // IF (Param."Code indemnité de productivité" = Indemnities1.Indemnity) OR (Indemnities1."Real Amount" > 0) THEN
                    //     CurrReport.SHOWOUTPUT(TRUE)
                    // ELSE
                    //     CurrReport.SHOWOUTPUT(FALSE)
                    // if "Base Amount" = 0 then
                    //     CurrReport.Skip();
                    IF (Param."Code indemnité de productivité" <> Indemnities1.Indemnity) and (Indemnities1."Real Amount" <= 0) THEN
                        CurrReport.Skip();

                end;
            }
            dataitem("<Recorded Worked hours2>"; "Heures sup. eregistrées m")
            {
                DataItemLink = "N° Salarié" = FIELD(Employee),
                                   "Mois de paiement" = FIELD(Month),
                                   "Année de paiement" = FIELD(Year),
                                   Quinzaine = FIELD(Quinzaine);
                DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
                                        ORDER(Ascending)
                                        WHERE("Type Jours" = FILTER(Normal));

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Montant ligne");
                end;
            }
            dataitem("<Recorded Worked hours21>"; "Heures sup. eregistrées m")
            {
                DataItemLink = "N° Salarié" = FIELD(Employee),
                                   "Mois de paiement" = FIELD(Month),
                                   "Année de paiement" = FIELD(Year),
                                   Quinzaine = FIELD(Quinzaine);
                DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
                                        ORDER(Ascending)
                                        WHERE("Type Jours" = FILTER(Nuit));
            }
            dataitem("<Heures sup. eregistrées m3>"; "Heures sup. eregistrées m")
            {
                DataItemLink = "N° Salarié" = FIELD(Employee),
                                   "Mois de paiement" = FIELD(Month),
                                   "Année de paiement" = FIELD(Year);
                DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
                                        ORDER(Ascending)
                                        WHERE("Type Jours" = FILTER(Normal));
                column("Heures_sup__eregistrées_m3___Montant_ligne_"; "Montant ligne")
                {
                    DecimalPlaces = 0 : 0;
                }
                column("Heures_sup__eregistrées_m3___Nombre_d_heures_"; "Nombre d'heures")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(HeureSupp; HeureSupp)
                {
                }
                column("Heures_sup__eregistrées_m3___Taux_de_majoration_"; "Taux de majoration")
                {
                }
                column("Heures_sup__eregistrées_m3__N__transaction"; "N° transaction")
                {
                }
                column("Heures_sup__eregistrées_m3__N__Ligne"; "N° Ligne")
                {
                }
                column("Heures_sup__eregistrées_m3__N__Salarié"; "N° Salarié")
                {
                }
                column("Heures_sup__eregistrées_m3__Mois_de_paiement"; "Mois de paiement")
                {
                }
                column("Heures_sup__eregistrées_m3__Année_de_paiement"; "Année de paiement")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Salary Lines"."Supp. hours" = 0 then
                        CurrReport.Skip();
                    // CurrReport.SHOWOUTPUT("Salary Lines"."Supp. hours" <> 0);
                    IF RecGContrat.GET(Employee."No.") THEN
                        IF RecGRegime.GET(RecGContrat."Regimes of work") THEN
                            IF RecGRegime."type calcul paie" = 1 THEN
                                CurrReport.Skip();
                    //  CurrReport.SHOWOUTPUT(FALSE);
                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1;
                    IF "Salary Lines"."Supp. hours" <> 0 THEN IntCompteur += 1;
                    IF "Taux de majoration" = 1.15 THEN HeureSupp := 'H.Sup à 15%';
                    IF "Taux de majoration" = 1.35 THEN HeureSupp := 'H.Sup à 35%';
                    IF "Taux de majoration" = 1.5 THEN HeureSupp := 'H.Sup à 50%';
                    IF "Taux de majoration" = 1.6 THEN HeureSupp := 'H.Sup à 60%';
                    IF "Taux de majoration" = 2.2 THEN HeureSupp := 'H.Sup à 120%';
                end;
            }
            dataitem("<Heures sup. eregistrées m4>"; "Heures sup. eregistrées m")
            {
                DataItemLink = "N° Salarié" = FIELD(Employee),
                                   "Mois de paiement" = FIELD(Month),
                                   "Année de paiement" = FIELD(Year);
                DataItemTableView = SORTING("N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
                                        ORDER(Ascending)
                                        WHERE("Type Jours" = FILTER(Nuit));
            }
            dataitem(DataItem9797; "Employee's days off Entry")
            {
                DataItemLink = "Employee No." = FIELD(Employee),
                                   "Posting month" = FIELD(Month),
                                   "Posting year" = FIELD(Year);
                DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
                                        ORDER(Ascending)
                                        WHERE("Line type" = FILTER("Jour férier payé"));
            }
            dataitem("<Employee's days off Entry1>"; "Employee's days off Entry")
            {
                DataItemLink = "Employee No." = FIELD(Employee),
                                   "Posting month" = FIELD(Month),
                                   "Posting year" = FIELD(Year);
                DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
                                        ORDER(Ascending)
                                        WHERE("Motif D'absence" = FILTER("Congé de Maladie"),
                                              "Line type" = FILTER(' '));
            }
            dataitem("<Employee's days off Entry2>"; "Employee's days off Entry")
            {
                DataItemLink = "Employee No." = FIELD(Employee),
                                   "Posting month" = FIELD(Month),
                                   "Posting year" = FIELD(Year);
                DataItemTableView = SORTING("Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
                                        ORDER(Ascending)
                                        WHERE("Motif D'absence" = FILTER("Accident de travail"),
                                              "Line type" = FILTER(' '));
            }
            dataitem("Salary Lines2"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);

                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
                column(Salary_Lines2__Gross_Salary_; "Gross Salary")
                {
                    AutoFormatType = 2;
                    DecimalPlaces = 0 : 0;
                }
                column(Salary_Lines2__IUTS_Net_; "IUTS Net")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Salary_Lines2__Gross_Salary__Control1000000133; "Gross Salary")
                {
                    AutoFormatType = 2;
                    DecimalPlaces = 0 : 0;
                }
                column(Total_BrutCaption; Total_BrutCaptionLbl)
                {
                }
                column(IUTSCaption; IUTSCaptionLbl)
                {
                }
                column(Salary_Lines2_No_; "No.")
                {
                }
                column(Salary_Lines2_Employee; Employee)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //  Message(Format("Gross Salary"));
                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 2;
                    if "Gross Salary" <> 0 then
                        //new add 
                        IntCompteur += 1;
                end;
            }
            dataitem("Social Contributions1"; "Social Contributions")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
                                        ORDER(Ascending);
                column(Social_Contributions1__Real_Amount___Employee_; "Real Amount : Employee")
                {
                    AutoFormatType = 2;
                    DecimalPlaces = 3 : 3;
                }
                column(Social_Contributions1_Description; Description)
                {
                }
                column(Social_Contributions1__Base_Amount_; "Base Amount")
                {
                    AutoFormatType = 2;
                    DecimalPlaces = 0 : 0;
                }
                column(Social_Contributions1__Employee_s_part_; "Employee's part")
                {
                }
                column(TotaCotisPatronale; TotaCotisPatronale)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Social_Contributions1__Employer_s_part_; "Employer's part")
                {
                }
                column(Social_Contributions1__Real_Amount___Employer_; Round("Real Amount : Employer", 1))
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Social_Contributions1__Social_Contribution_; "Social Contribution")
                {
                }

                column(Total_CotisationCaption; Total_CotisationCaptionLbl)
                {
                }
                column(Social_Contributions1_No_; "No.")
                {
                }
                column(Social_Contributions1_Employee; Employee)
                {
                }
                column(Social_Contributions1_Indemnity; Indemnity)
                {
                }


                trigger OnAfterGetRecord()
                begin
                    // TotaCotisEmployee += "Real Amount : Employee";
                    // TotaCotisPatronale += "Real Amount : Employer";
                    if "Base Amount" <> 0 then
                        //new add 
                        IntCompteur += 1;

                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1
                end;


            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                  WHERE(Number = FILTER(1));

                column(TotaCotisPatronale_Control1000000020; Round(TotaCotisPatronale, 1))
                {
                    DecimalPlaces = 0 : 0;
                }

                column(TotaCotisEmployee; TotaCotisEmployee)
                {
                    AutoFormatType = 2;
                    DecimalPlaces = 0 : 0;
                }

                trigger OnPreDataItem()
                var


                begin
                    TotaCotisEmployee := 0;
                    TotaCotisPatronale := 0;
                    RecSocialContributions.Reset();
                    RecSocialContributions.SetRange("No.", "Salary Lines"."No.");
                    RecSocialContributions.SetRange(Employee, "Salary Lines".Employee);
                    if RecSocialContributions.FindSet() then
                        repeat

                            TotaCotisEmployee += RecSocialContributions."Real Amount : Employee";
                            TotaCotisPatronale += RecSocialContributions."Real Amount : Employer";
                        until RecSocialContributions.Next() = 0;
                end;
            }
            dataitem(Indemnitiesimpassej; "Indemnities")
            {
                DataItemLink = "No." = FIELD("No."),
                                   "Employee No." = FIELD(Employee);
                DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER("Imposable (Non Assujettie Socialement)"));
            }
            dataitem("Salary Lines3"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
            }
            dataitem("Social Contributions2"; "Social Contributions")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
                                        ORDER(Ascending)
                                        WHERE("Deductible of taxable basis" = FILTER(false),
                                              "Real Amount : Employee" = FILTER(<> 0));
            }
            dataitem(DataItem3580; "Expenses to repay Header")
            {
                DataItemLink = "Employee No." = FIELD(Employee),
                                   "Payment month" = FIELD(Month),
                                   "Payment year" = FIELD(Year);
                DataItemTableView = SORTING("No.")
                                        ORDER(Ascending)
                                        WHERE(Status = FILTER(Validated),
                                              Repaied = FILTER(false));
            }
            dataitem("Salary Lines4"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
                column(Salary_Lines4__Ajout__en___; "Ajout  en +")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Salary_Lines4__Report_en___; "Report en -")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(ReportCaption; ReportCaptionLbl)
                {
                }
                column(Salary_Lines4_No_; "No.")
                {
                }
                column(Salary_Lines4_Employee; Employee)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Ajout  en +" = 0) AND ("Salary Lines"."Report en -" = 0) then
                        CurrReport.Skip();

                    IntCompteur += 1;
                    //  CurrReport.SHOWOUTPUT(("Ajout  en +" <> 0) OR ("Salary Lines"."Report en -" <> 0));
                end;
            }
            dataitem(Indemnities2; "Indemnities")
            {
                DataItemLink = "No." = FIELD("No."),
                                   "Employee No." = FIELD(Employee);
                DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER("Non imposable"));
                column(Indemnities2__Real_Amount_; "Real Amount")
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(Indemnities2_Description; Description)
                {
                }
                column(Indemnities2_Indemnity; Indemnity)
                {
                }
                column(Indemnities2__Base_Amount_; "Base Amount")
                {
                    AutoFormatType = 0;
                    DecimalPlaces = 0 : 0;
                }
                column(Indemnities2_No_; "No.")
                {
                }
                column(Indemnities2_Employee_No_; "Employee No.")
                {
                }
                column(Indemnities2_Non_Inclus_en_Prime; "Non Inclus en Prime")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1;
                    IF Indemnities2."Real Amount" <> 0 THEN IntCompteur += 1;
                end;
            }
            dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
            {
                DataItemLink = Employee = FIELD(Employee),
                                   "Payment No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Entry No.")
                                        ORDER(Ascending);
                column(ROUND__Line_Amount__1_; ROUND("Line Amount", 1))
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0 : 0;
                }
                column(Loan___Advance_Lines__Document_type_; "Document type")
                {
                }
                column(Loan___Advance_Lines_No_; "No.")
                {
                }
                column(Loan___Advance_Lines_Entry_No_; "Entry No.")
                {
                }
                column(Loan___Advance_Lines_Employee; Employee)
                {
                }
                column(Loan___Advance_Lines_Payment_No_; "Payment No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LoanAdvanceHeader.GET("Loan & Advance Lines"."No.");



                    IF CurrReport.SHOWOUTPUT THEN
                        LinesPrinted := LinesPrinted + 1;
                    if "Line Amount" <> 0 then
                        IntCompteur += 1;
                    IF TypeAv.GET("Loan & Advance Lines"."Document type") THEN
                        LibelleAv := TypeAv.Description;
                end;
            }
            dataitem("Salary Lines6"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
            }
            dataitem("Salary Lines7"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
            }
            dataitem("Retenue FSP"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        WHERE("Retenue FSP" = FILTER(<> 0));
                column(Retenue_FSP__Retenue_FSP_; "Retenue FSP")
                {
                }
                column(Retenue_FSPCaption; Retenue_FSPCaptionLbl)
                {
                }
                column(V1Caption; V1CaptionLbl)
                {
                }
                column(Retenue_FSP_No_; "No.")
                {
                }
                column(Retenue_FSP_Employee; Employee)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Retenue FSP" <> 0 then
                        //new add 
                        IntCompteur += 1;
                end;
            }
            dataitem("Retenue SND"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        WHERE("Retenue SNP" = FILTER(<> 0));
                column(Retenue_SND__Retenue_SNP_; "Retenue SNP")
                {
                }
                column(V1Caption_Control1000000249; V1Caption_Control1000000249Lbl)
                {
                }
                column(Retenue_SNDCaption; Retenue_SNDCaptionLbl)
                {
                }
                column(Retenue_SND_No_; "No.")
                {
                }
                column(Retenue_SND_Employee; Employee)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Retenue SNP" <> 0 then
                        //new add 
                        IntCompteur += 1;
                end;
            }
            // dataitem(DataItem5444; 2000000026)
            // {
            //     DataItemTableView = SORTING(Number)
            //                         ORDER(Ascending);

            //     trigger OnPreDataItem()
            //     begin
            //         SETRANGE(Number, 1, (43 - LinesPrinted));
            //     end;
            // }
            dataitem("<Indemnities AV Nature>"; "Indemnities")
            {
                DataItemLink = "No." = FIELD("No."),
                                   "Employee No." = FIELD(Employee);
                DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER(Imposable),
                                              "Avantage en nature" = FILTER(true));
            }
            dataitem(SAUT; Integer)
            {
                column(Compteur_Number; Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    //     SETRANGE(Number, 1, 24 - IntCompteur);
                    SETRANGE(Number, 1, 28 - IntCompteur);
                end;
            }
            dataitem("Salary Lines5"; "Salary Lines")
            {
                DataItemLink = "No." = FIELD("No."),
                                   Employee = FIELD(Employee);
                DataItemTableView = SORTING("No.", Employee)
                                        ORDER(Ascending);
                // column(Salary_Lines5__Net_salary_cashed_; "Net salary cashed")
                // {
                //     DecimalPlaces = 3 : 3;
                // }
                // column(Salary_Lines5__Gross_Salary_; "Gross Salary")
                // {
                //     AutoFormatType = 2;
                //     DecimalPlaces = 0 : 0;
                // }
                // column(Salary_Lines5__Salaire_Net_Imposable_; "Salaire Net Imposable")
                // {
                // }

                // // column(TotaCotisPatronale_Control1000000020; TotaCotisPatronale)
                // // {
                // //     DecimalPlaces = 0 : 0;
                // // }
                // column(Employer__Cumul_Salaire_Brut_; Employer."Cumul Salaire Brut")
                // {
                //     AutoFormatType = 2;
                //     DecimalPlaces = 0 : 0;
                // }
                // column(Employer__Cumul_Salaire_Net_Imposable_; Employer."Cumul Salaire Net Imposable")
                // {
                // }
                // column(Employer__Cumul_Charge_Salariale_; Employer."Cumul Charge Salariale")
                // {
                //     AutoFormatType = 2;
                //     DecimalPlaces = 0 : 0;
                // }
                // column(Employer__Cumul_Charge_Patronale_; Employer."Cumul Charge Patronale")
                // {
                //     DecimalPlaces = 0 : 0;
                // }
                // column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
                // {
                // }
                // column(CumulsCaption; CumulsCaptionLbl)
                // {
                // }
                // column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
                // {
                // }
                // column(Net_ImposableCaption; Net_ImposableCaptionLbl)
                // {
                // }
                // column(Charges_SalarialesCaption; Charges_SalarialesCaptionLbl)
                // {
                // }
                // column(Charges_PatronaleCaption; Charges_PatronaleCaptionLbl)
                // {
                // }
                // column(Heure_SupCaption; Heure_SupCaptionLbl)
                // {
                // }
                // column("Heures_TravailléesCaption"; Heures_TravailléesCaptionLbl)
                // {
                // }
                // column("PériodeCaption"; PériodeCaptionLbl)
                // {
                // }
                // column("AnnéeCaption"; AnnéeCaptionLbl)
                // {
                // }
                // column(Salary_Lines5_No_; "No.")
                // {
                // }
                // column(Salary_Lines5_Employee; Employee)
                // {
                // }
                // column(TotaCotisEmployee_Control1000000019; TotaCotisEmployee)
                // {
                //     AutoFormatType = 2;
                //     DecimalPlaces = 0 : 0;
                // }
                trigger OnAfterGetRecord()
                begin
                    // TotaCotisEmployee := 0;
                    // TotaCotisPatronale := 0;
                    // RecSocialContributions.Reset();
                    // RecSocialContributions.SetRange("No.", "Salary Lines"."No.");
                    // RecSocialContributions.SetRange(Employee, "Salary Lines".Employee);
                    // if RecSocialContributions.FindSet() then
                    //     repeat

                    //         TotaCotisEmployee += RecSocialContributions."Real Amount : Employee";
                    //         TotaCotisPatronale += RecSocialContributions."Real Amount : Employer";
                    //     until RecSocialContributions.Next() = 0;
                    IF Employer.GET(Employee) THEN BEGIN
                        Employer.CALCFIELDS("Cumul Salaire Brut", "Cumul Salaire Net Imposable", "Cumul Charge Salariale", "Cumul Charge Patronale");
                    END;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ReComp.get();
                ReComp.CalcFields(Picture);
                IF Employer.GET(Employee) THEN BEGIN
                    Employer.CALCFIELDS("Cumul Salaire Brut", "Cumul Salaire Net Imposable", "Cumul Charge Salariale", "Cumul Charge Patronale", "Days off =", "Days off +", "Days off -");
                    IntMoisAncienneté := Managementofsalary.CalculerAnneeAncienneté(Employer."No.");
                    IntAnnéeAncienneté := IntMoisAncienneté DIV 12;
                    Ancienneté := FORMAT(IntAnnéeAncienneté) + '    An(s)  Et ' + FORMAT(IntMoisAncienneté - IntAnnéeAncienneté * 12) + ' Mois';

                END;
                TotaCotisEmployee := 0;
                TotaCotisPatronale := 0;
                RecSocialContributions.Reset();
                RecSocialContributions.SetRange("No.", "Salary Lines"."No.");
                RecSocialContributions.SetRange(Employee, "Salary Lines".Employee);
                if RecSocialContributions.FindSet() then
                    repeat

                        TotaCotisEmployee += RecSocialContributions."Real Amount : Employee";
                        TotaCotisPatronale += RecSocialContributions."Real Amount : Employer";
                    until RecSocialContributions.Next() = 0;
                if "Basis salary" <> 0 then
                    //new add 
                    IntCompteur += 1;
            end;

            trigger OnPreDataItem()
            begin

                IntCompteur := 0;

            end;
        }
        //}
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInfo.GET();
        CompInfo.CalcFields(Picture);
        RecHumanResourcesSetup.Get();
        RecHumanResourcesSetup.CalcFields(Picture);
    end;

    var
        RecHumanResourcesSetup: Record "Human Resources Setup";
        IntCompteur: Integer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ReComp: Record "Company Information";
        LoanAdvanceHeader: Record "Loan & Advance Header";
        TotalFor: Label 'Total ';
        PrintDetails: Boolean;
        ln: Integer;
        remaning: Integer;
        Param: Record 5218;
        base: Decimal;
        DescBase: Text[30];
        supp: Decimal;
        DesSupp: Text[30];
        CompInfo: Record 79;
        nom: Text[50];
        adresse: Text[100];
        "tél": Text[20];
        fax: Text[20];
        regcom: Text[30];
        Nsiret: Text[20];
        Nss: Code[30];
        LinesPrinted: Integer;
        MntDeduit: Decimal;
        SBDeduit: Decimal;
        Jourheuretravail: Text[30];
        NBJourtravail: Decimal;
        TypeAv: Record "Loan & Advance Type";
        LibelleAv: Text[30];
        jourheureabs: Text[30];
        RecGContrat: Record 5211;
        RecGRegime: Record "Regimes of work";
        DECGNBHEURE: Decimal;
        DECGNBJOURS: Decimal;
        RecSalarylines: Record "Salary Lines";
        decnote: Decimal;
        txtnote: Text[30];
        Jourconge: Text[30];
        nbjourconge: Decimal;
        nbjourferie: Decimal;
        nbrjoursean: Decimal;
        textsalaire: Text[30];
        Qaunzaine: Text[30];
        RecSocialContributions: Record "Social Contributions";
        "IntMoisAncienneté": Integer;
        "IntAnnéeAncienneté": Integer;
        "Ancienneté": Text[50];
        Managementofsalary: Codeunit "Management of salary";
        SalaireDeBase: Decimal;
        Employer: Record 5200;
        HeureSupp: Text[50];
        TotaCotisEmployee: Decimal;
        TotaCotisPatronale: Decimal;
        "IndemnitiesEnregistré": Record "Rec. Indemnities";
        "SocialContributionsEnregistré": Record "Rec. Social Contributions";
        "Année__CaptionLbl": Label 'Année :';
        Mois__CaptionLbl: Label 'Mois :';
        Paiement_Le__CaptionLbl: Label 'Paiement Le :';
        Par__CaptionLbl: Label 'Par :';
        MatriculeCaptionLbl: Label 'Matricule';
        NiveauCaptionLbl: Label 'Niveau';
        CoeficientCaptionLbl: Label 'Coeficient';
        IndiceCaptionLbl: Label 'Indice';
        "AnciennetéCaptionLbl": Label 'Ancienneté';
        "N__de_Sécurité_SocialeCaptionLbl": Label 'N° de Sécurité Sociale';
        "CatégorieCaptionLbl": Label 'Catégorie';
        "Emploi_OccupéCaptionLbl": Label 'Emploi Occupé';
        "DépartementCaptionLbl": Label 'Département';
        QualificationCaptionLbl: Label 'Qualification';
        HoraireCaptionLbl: Label 'Horaire';
        "Repos_Comp__CongésCaptionLbl": Label 'Repos Comp. Congés';
        AcquisCaptionLbl: Label 'Acquis';
        "Reste_à_PrendreCaptionLbl": Label 'Reste à Prendre';
        PrisCaptionLbl: Label 'Pris';
        Commentaires__CaptionLbl: Label 'Commentaires :';
        N_CaptionLbl: Label 'N°';
        "DésignationCaptionLbl": Label 'Désignation';
        NombreCaptionLbl: Label 'Nombre';
        BaseCaptionLbl: Label 'Base';
        TauxCaptionLbl: Label 'Taux';
        Part_SalarialCaptionLbl: Label 'Part Salarial';
        GainCaptionLbl: Label 'Gain';
        RetenueCaptionLbl: Label 'Retenue';
        Part_PatronaleCaptionLbl: Label 'Part Patronale';
        TauxCaption_Control1000000123Lbl: Label 'Taux';
        Ret__CaptionLbl: Label 'Ret +';
        Ret__Caption_Control1000000125Lbl: Label 'Ret -';
        V001CaptionLbl: Label '001';
        Total_BrutCaptionLbl: Label 'Total Brut';
        IUTSCaptionLbl: Label 'IUTS';
        Total_CotisationCaptionLbl: Label 'Total Cotisation';
        ReportCaptionLbl: Label 'Report';
        Retenue_FSPCaptionLbl: Label 'Retenue FSP';
        V1CaptionLbl: Label '1';
        V1Caption_Control1000000249Lbl: Label '1';
        Retenue_SNDCaptionLbl: Label 'Retenue SND';
        "Net_à_PayerCaptionLbl": Label 'Net à Payer';
        CumulsCaptionLbl: Label 'Cumuls';
        Salaire_BrutCaptionLbl: Label 'Salaire Brut';
        Net_ImposableCaptionLbl: Label 'Net Imposable';
        Charges_SalarialesCaptionLbl: Label 'Charges Salariales';
        Charges_PatronaleCaptionLbl: Label 'Charges Patronale';
        Heure_SupCaptionLbl: Label 'Heure Sup';
        "Heures_TravailléesCaptionLbl": Label 'Heures Travaillées';
        "PériodeCaptionLbl": Label 'Période';
        "AnnéeCaptionLbl": Label 'Année';
}