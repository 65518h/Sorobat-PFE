report 50080 "Integration Paie En Comptabili"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/IntegrationPaieEnComptabili.rdlc';

    dataset
    {
        dataitem("Rec. Salary Headers"; "Rec. Salary Headers")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Rec__Salary_Headers__No__; "No.")
            {
            }
            column(SNet; SNet)
            {
            }
            column(Avance; Avance)
            {
            }
            column(SBase; SBase)
            {
            }
            column(HSupp; HSupp)
            {
            }
            column(Pret; Pret)
            {
            }
            column(CNSSsalarial; CNSSsalarial)
            {
            }
            column(IUTS; IUTS)
            {
            }
            column(Debiteur; Debiteur)
            {
            }
            column(Crediteur; Crediteur)
            {
            }
            column(RISQUE; RISQUE)
            {
            }
            column(Prestation; Prestation)
            {
            }
            column(Assurance; Assurance)
            {
            }
            column(Prime; Prime)
            {
            }
            column(Rec__Salary_Headers__No___Control1000000044; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000045; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000046; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000047; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000048; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000049; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000050; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000051; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000052; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000053; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000054; "No.")
            {
            }
            column(Rec__Salary_Headers__No___Control1000000055; "No.")
            {
            }
            column(Prime_Control1000000021; Prime)
            {
            }
            column(ChargeSocial; ChargeSocial)
            {
            }
            column(SBaseInitial; SBaseInitial)
            {
            }
            column(Sursalaire; Sursalaire)
            {
            }
            column(Prime_Control1000000064; Prime)
            {
            }
            column(HSupp_Control1000000065; HSupp)
            {
            }
            column(Salary_HeadersCaption; Salary_HeadersCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Numero_PaieCaption; Numero_PaieCaptionLbl)
            {
            }
            column(Salairs_NetCaption; Salairs_NetCaptionLbl)
            {
            }
            column(AvanceCaption; AvanceCaptionLbl)
            {
            }
            column(PretCaption; PretCaptionLbl)
            {
            }
            column(CNSSCaption; CNSSCaptionLbl)
            {
            }
            column(Salaire_Base___SursalaireCaption; Salaire_Base___SursalaireCaptionLbl)
            {
            }
            column(Heures_suplementaireCaption; Heures_suplementaireCaptionLbl)
            {
            }
            column(IUTSCaption; IUTSCaptionLbl)
            {
            }
            column(RisqueCaption; RisqueCaptionLbl)
            {
            }
            column(PrestationCaption; PrestationCaptionLbl)
            {
            }
            column(AssuranceCaption; AssuranceCaptionLbl)
            {
            }
            column(ChargeCaption; ChargeCaptionLbl)
            {
            }
            column(PrimeCaption; PrimeCaptionLbl)
            {
            }
            column("Libellé_écritureCaption"; Libellé_écritureCaptionLbl)
            {
            }
            column("Mvts_débitCaption"; Mvts_débitCaptionLbl)
            {
            }
            column("Mvts_créditCaption"; Mvts_créditCaptionLbl)
            {
            }
            column(Numero_PaieCaption_Control1000000041; Numero_PaieCaption_Control1000000041Lbl)
            {
            }
            column(JourCaption; JourCaptionLbl)
            {
            }
            column(Salaire_BaseCaption; Salaire_BaseCaptionLbl)
            {
            }
            column(SursalaireCaption; SursalaireCaptionLbl)
            {
            }
            column(PrimeCaption_Control1000000063; PrimeCaption_Control1000000063Lbl)
            {
            }
            column(Heures_suplementaireCaption_Control1000000066; Heures_suplementaireCaption_Control1000000066Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Mise a jour Heure Supp
                HeuressuperegistréesCorige.SETRANGE("Année de paiement", Year);
                HeuressuperegistréesCorige.SETRANGE("Mois de paiement", Month);
                HeuressuperegistréesCorige.MODIFYALL("Paiement No.", "No.");
                // Verifier si la date Comptabilisation est Spécifier
                //IF RecSalaryHeader.GET("No.") THEN IF RecSalaryHeader."Intégré en comptabilité" THEN ERROR(Text002,"No.");
                //******************
                IF HumanResourcesSetup.GET THEN;
                IF EmployeePostingGroup.GET('SALARIER') THEN;
                RecSalaryLines.SETRANGE("No.", "No.");
                //RecSalaryLines.SETRANGE(Employee,Employee);

                IF RecSalaryLines.FINDFIRST THEN
                    REPEAT
                        SBaseInitial += RecSalaryLines."Real basis salary";
                        SBase += RecSalaryLines."Real basis salary"; // Calculer Salaire de base
                        IUTS += RecSalaryLines."IUTS Net";           // Calculer IUTS
                        TPA += RecSalaryLines.TPA;                   // Calculer TPA
                        SNet += RecSalaryLines."Net salary cashed";  // Calculer Salaire Net
                        Avance += RecSalaryLines.Advances;           // Calculer Les Avances Personnel
                        Pret += RecSalaryLines.Loans;                // Calculer Les Prets Personnel
                        FSPSalarial += RecSalaryLines."Retenue FSP";
                        SNDSalarial += RecSalaryLines."Retenue SNP";
                    UNTIL RecSalaryLines.NEXT = 0;


                RecIndemnities.SETRANGE("No.", "No.");
                //RecIndemnities.SETRANGE("Employee No.",Employee);
                RecIndemnities.SETFILTER(Indemnity, '<>%1', HumanResourcesSetup."Indem Sursalaire");
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT

                        Prime := Prime + RecIndemnities."Real Amount";  // Calculer tout Les Primes sans les sursalaires

                    UNTIL RecIndemnities.NEXT = 0;

                RecIndemnities.SETRANGE("No.");


                RecIndemnities.SETRANGE("No.", "No.");
                //RecIndemnities.SETRANGE("Employee No.",Employee);
                RecIndemnities.SETRANGE(Indemnity, HumanResourcesSetup."Indem Sursalaire");
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        Sursalaire := Sursalaire + RecIndemnities."Real Amount";    // Calculer les sursalaires
                    UNTIL RecIndemnities.NEXT = 0;



                HeuresSupEnregistrées.SETRANGE("Paiement No.", "No.");
                //HeuresSupEnregistrées.SETRANGE("N° Salarié",Employee);
                IF HeuresSupEnregistrées.FINDFIRST THEN
                    REPEAT
                        HSupp := HSupp + HeuresSupEnregistrées."Montant ligne";     // Calculer les Heures suplementaires
                    UNTIL HeuresSupEnregistrées.NEXT = 0;

                RecSocialContributions.SETRANGE("No.", "No.");
                //RecSocialContributions.SETRANGE(Employee,Employee);
                RecSocialContributions.SETRANGE("Social Contribution", HumanResourcesSetup.CNSS);
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        CNSSsalarial := CNSSsalarial + RecSocialContributions."Real Amount : Employee";   // Calculer CNSS Salarial
                    UNTIL RecSocialContributions.NEXT = 0;
                RecSocialContributions.SETRANGE("No.");

                RecSocialContributions.SETRANGE("No.", "No.");
                //RecSocialContributions.SETRANGE(Employee,Employee);
                RecSocialContributions.SETRANGE("Social Contribution", HumanResourcesSetup."Prestations Familiale");
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        Prestation := Prestation + RecSocialContributions."Real Amount : Employer";      // Calculer Prestations Familiale
                    UNTIL RecSocialContributions.NEXT = 0;
                RecSocialContributions.SETRANGE("No.");

                RecSocialContributions.SETRANGE("No.", "No.");
                //RecSocialContributions.SETRANGE(Employee,Employee);
                RecSocialContributions.SETRANGE("Social Contribution", HumanResourcesSetup."Risque Professionnel");
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        RISQUE := RISQUE + RecSocialContributions."Real Amount : Employer";   // Calculer Risque Professionnel
                    UNTIL RecSocialContributions.NEXT = 0;
                RecSocialContributions.SETRANGE("No.");

                RecSocialContributions.SETRANGE("No.", "No.");
                //RecSocialContributions.SETRANGE(Employee,Employee);
                RecSocialContributions.SETRANGE("Social Contribution", HumanResourcesSetup."Assurance Vieillesse");
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        Assurance := Assurance + RecSocialContributions."Real Amount : Employer";    // Calculer Assurance Vieillesse
                    UNTIL RecSocialContributions.NEXT = 0;
                RecSocialContributions.SETRANGE("No.");

                // ROUND
                SBase := ROUND(SBase, 1);
                IUTS := ROUND(IUTS, 1);
                TPA := ROUND(TPA, 1);
                SNet := ROUND(SNet, 1);
                Avance := ROUND(Avance, 1);
                Pret := ROUND(Pret, 1);
                Prime := ROUND(Prime, 1);
                HSupp := ROUND(HSupp, 1);
                CNSSsalarial := ROUND(CNSSsalarial, 1);
                Prestation := ROUND(Prestation, 1);
                RISQUE := ROUND(RISQUE, 1);
                Assurance := ROUND(Assurance, 1);
                Sursalaire := ROUND(Sursalaire, 1);
                FSPSalarial := ROUND(FSPSalarial, 1);
                SNDSalarial := ROUND(SNDSalarial, 1);

                // ROUND

                SBase := SBase + Sursalaire;                                    // Calculer Salaire Personnel ( = salaire de base + sursalaires )
                ChargeSocial := Prestation + RISQUE + Assurance;            // Calculer Les Charges Sociales
                Debiteur := SBase + Prime + HSupp;                          // Calculer Les Mvts Débit
                Crediteur := Pret + Avance + SNet + CNSSsalarial + IUTS + FSPSalarial + SNDSalarial;    // Calculer Les Mvts Crédit



                // PARTIE COMPTABILISATION
                GenJournalLine."Journal Template Name" := HumanResourcesSetup."General Journal Template";
                GenJournalLine."Journal Batch Name" := HumanResourcesSetup."Gen. Journal Batch (Payroll)";
                GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                GenJournalLine.VALIDATE("Posting Date", DateComptabilisation);
                GenJournalLine."Document No." := 'CPTPAI-' + FORMAT(DATE2DMY(DateComptabilisation, 2)) + '-' + FORMAT(DATE2DMY(DateComptabilisation, 3));
                FOR Compteur := 1 TO 17 DO BEGIN
                    GenJournalLine."Line No." := 10000 * Compteur;
                    IF Compteur = 1 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.Prêt);
                        GenJournalLine.VALIDATE("Amount (LCY)", -Pret);
                        GenJournalLine.Description := 'PRET PERSONNEL';
                    END;
                    IF Compteur = 2 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.Avance);
                        GenJournalLine.VALIDATE("Amount (LCY)", -Avance);
                        GenJournalLine.Description := 'AVANCE PERSONNEL';
                    END;
                    IF Compteur = 3 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Salaire Net");
                        GenJournalLine.VALIDATE("Amount (LCY)", -SNet);
                        GenJournalLine.Description := 'PERSONNEL REMUNERATION DUE';
                    END;
                    IF Compteur = 4 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.CNSS);
                        GenJournalLine.VALIDATE("Amount (LCY)", -CNSSsalarial);
                        GenJournalLine.Description := 'CNSS SALARIAL';
                    END;
                    IF Compteur = 5 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Charge Personnel (Base+Sursal)");
                        GenJournalLine.VALIDATE("Amount (LCY)", SBase);
                        GenJournalLine.Description := 'SALAIRE PRSONNEL';
                    END;
                    IF Compteur = 6 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Heure Supp");
                        GenJournalLine.VALIDATE("Amount (LCY)", HSupp);
                        GenJournalLine.Description := 'HEURE SUPPLEMENTAIRE';
                    END;

                    IF Compteur = 7 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Indemnités Imposable");
                        GenJournalLine.VALIDATE("Amount (LCY)", Prime);
                        GenJournalLine.Description := 'PRIME';
                    END;

                    IF Compteur = 8 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Charge sociale");
                        GenJournalLine.VALIDATE("Amount (LCY)", ChargeSocial);
                        GenJournalLine.Description := 'CHARGE SOCIALE';
                    END;

                    IF Compteur = 9 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Prestations Familiale");
                        GenJournalLine.VALIDATE("Amount (LCY)", -Prestation);
                        GenJournalLine.Description := 'PRESTATION FAMILIALE';
                    END;

                    IF Compteur = 10 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Risque Professionnel");
                        GenJournalLine.VALIDATE("Amount (LCY)", -RISQUE);
                        GenJournalLine.Description := 'RISQUE PROFESSIONNEL';
                    END;

                    IF Compteur = 11 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup."Assurance Vieillesse");
                        GenJournalLine.VALIDATE("Amount (LCY)", -Assurance);
                        GenJournalLine.Description := 'ASSURANCE VIEILLESSE';
                    END;


                    IF Compteur = 12 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.IUTS);
                        GenJournalLine.VALIDATE("Amount (LCY)", -IUTS);
                        GenJournalLine.Description := 'IUTS';
                    END;
                    IF Compteur = 13 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.TPA);
                        GenJournalLine.VALIDATE("Amount (LCY)", -TPA);
                        GenJournalLine.Description := 'TPA';
                    END;
                    IF Compteur = 14 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", '66102000');
                        GenJournalLine.VALIDATE("Amount (LCY)", TPA);
                        GenJournalLine.Description := 'TPA';
                    END;

                    IF Compteur = 15 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.Arrondissement);
                        GenJournalLine.VALIDATE("Amount (LCY)", -(Debiteur - Crediteur));
                        GenJournalLine.Description := 'ARRONDISSEMENT';
                    END;
                    IF Compteur = 16 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.FSP);
                        GenJournalLine.VALIDATE("Amount (LCY)", -FSPSalarial);
                        GenJournalLine.Description := 'FSP';
                    END;
                    IF Compteur = 17 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", EmployeePostingGroup.SND);
                        GenJournalLine.VALIDATE("Amount (LCY)", -SNDSalarial);
                        GenJournalLine.Description := 'SND';
                    END;


                    IF GenJournalLine."Amount (LCY)" <> 0 THEN
                        IF NOT GenJournalLine.INSERT THEN GenJournalLine.MODIFY;
                END;

                IF RecSalaryHeader.GET("No.") THEN BEGIN
                    RecSalaryHeader."Intégré en comptabilité" := TRUE;
                    RecSalaryHeader.MODIFY;
                END;


                // PARTIE COMPTABILISATION
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Date Comptabilisation"; "DateComptabilisation")
                    {
                        Caption = 'Date Comptabilisation';
                    }



                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF DateComptabilisation = 0D THEN ERROR(Text001);
    end;

    var
        RecSalaryHeader: Record "Rec. Salary Headers";
        RecSalaryLines: Record "Rec. Salary Lines";
        RecIndemnities: Record "Rec. Indemnities";
        "HeuresSupEnregistrées": Record "Heures sup. eregistrées m";
        RecSocialContributions: Record "Rec. Social Contributions";
        HumanResourcesSetup: Record 5218;
        GenJournalLine: Record 81;
        EmployeePostingGroup: Record "Employee Posting Group";
        LeSursalaire: Decimal;
        SaliareBase: Decimal;
        HSupp: Decimal;
        SNet: Decimal;
        Avance: Decimal;
        Pret: Decimal;
        IUTS: Decimal;
        Crediteur: Decimal;
        TPA: Decimal;
        Debiteur: Decimal;
        RISQUE: Decimal;
        SBase: Decimal;
        Prestation: Decimal;
        Assurance: Decimal;
        Prime: Decimal;
        Sursalaire: Decimal;
        ChargeSocial: Decimal;
        CNSSsalarial: Decimal;
        Compteur: Integer;
        DateComptabilisation: Date;
        Text001: Label 'Veuillez Spécifier La Date Comptabilisation';
        Text002: Label 'Paie N° %1 Est Deja Intégré en Comptabilité';
        "HeuressuperegistréesCorige": Record "Heures sup. eregistrées m";
        SBaseInitial: Decimal;
        FSPSalarial: Decimal;
        SNDSalarial: Decimal;
        Salary_HeadersCaptionLbl: Label 'En-tête salaires Enreg.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Numero_PaieCaptionLbl: Label 'Numero Paie';
        Salairs_NetCaptionLbl: Label 'Salairs Net';
        AvanceCaptionLbl: Label 'Avance';
        PretCaptionLbl: Label 'Pret';
        CNSSCaptionLbl: Label 'CNSS';
        Salaire_Base___SursalaireCaptionLbl: Label 'Salaire Base + Sursalaire';
        Heures_suplementaireCaptionLbl: Label 'Heures suplementaire';
        IUTSCaptionLbl: Label 'IUTS';
        RisqueCaptionLbl: Label 'Risque';
        PrestationCaptionLbl: Label 'Prestation';
        AssuranceCaptionLbl: Label 'Assurance';
        ChargeCaptionLbl: Label 'Charge';
        PrimeCaptionLbl: Label 'Prime';
        "Libellé_écritureCaptionLbl": Label 'Libellé écriture';
        "Mvts_débitCaptionLbl": Label 'Mvts débit';
        "Mvts_créditCaptionLbl": Label 'Mvts crédit';
        Numero_PaieCaption_Control1000000041Lbl: Label 'Numero Paie';
        JourCaptionLbl: Label 'Jour';
        Salaire_BaseCaptionLbl: Label 'Salaire Base';
        SursalaireCaptionLbl: Label 'Sursalaire';
        PrimeCaption_Control1000000063Lbl: Label 'Prime';
        Heures_suplementaireCaption_Control1000000066Lbl: Label 'Heures suplementaire';
}

