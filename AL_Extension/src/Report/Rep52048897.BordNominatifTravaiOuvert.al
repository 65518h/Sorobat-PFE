report 52048897 "Bord Nominatif Travai Ouvert"
//39001444
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/BordNominatifTravaiOuvert.rdlc';
    Caption = 'Bordereau Nominatif Des Travai';

    dataset
    {
        dataitem("Salary Lines"; "Salary Lines")
        {
            DataItemTableView = SORTING("No.", Employee);
            RequestFilterFields = "No.", "congé";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {
            }
            column(CompanyInformation__Entete_de_page_; CompanyInformation."Entete de page")
            {
            }
            column(Salary_Lines_Year; Year)
            {
            }
            column(Salary_Lines_Month; Month)
            {
            }
            column(CompanyInformation__N__CNSS_; CompanyInformation."N° CNSS")
            {
            }
            column(Compteur; Compteur)
            {
            }
            column(Employer__First_Name________Employer__Last_Name_; Employer."First Name" + ' ' + Employer."Last Name")
            {
            }
            column(Salary_Lines_Employee; Employee)
            {
            }
            column(Employer__Social_Security_No__; Employer."Social Security No.")
            {
            }
            column(BaseCOtisation; BaseCOtisation)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Salary_Lines__Paied_days_; "Paied days")
            {
            }
            column(Risque; Risque)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Prestation; Prestation)
            {
                DecimalPlaces = 0 : 0;
            }
            column(VeillessP; VeillessP)
            {
                DecimalPlaces = 0 : 0;
            }
            column(VeillessS; VeillessS)
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalCotisation; TotalCotisation)
            {
                DecimalPlaces = 0 : 0;
            }
            column("Employer_Spécialité"; Employer.Fonction)
            {
            }
            column("Salary_Lines__Congé_Pri_"; "Congé")
            {
            }
            column(TotBaseCOtisation; TotBaseCOtisation)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Salary_Lines__Paied_days__Control1000000035; "Paied days")
            {
            }
            column(Risque_Control1000000036; Risque)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Prestation_Control1000000037; Prestation)
            {
                DecimalPlaces = 0 : 0;
            }
            column(VeillessP_Control1000000038; VeillessP)
            {
                DecimalPlaces = 0 : 0;
            }
            column(VeillessS_Control1000000039; VeillessS)
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalGeneralCotisation; TotalGeneralCotisation)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Compteur_Control1000000033; Compteur)
            {
            }
            column(BORDEREAU_NOMINATIF_DES_TRAVAILLEURS_SALARIES_DE_SOUROUBAT___BFCaption; BORDEREAU_NOMINATIF_DES_TRAVAILLEURS_SALARIES_DE_SOUROUBAT___BFCaptionLbl)
            {
            }
            column(ANNEECaption; ANNEECaptionLbl)
            {
            }
            column(MOISCaption; MOISCaptionLbl)
            {
            }
            column(N__CNSS_EMPLOYEUR__Caption; N__CNSS_EMPLOYEUR__CaptionLbl)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column(MATCaption; MATCaptionLbl)
            {
            }
            column(NOM_ET_PRENOMCaption; NOM_ET_PRENOMCaptionLbl)
            {
            }
            column(N__CNSSCaption; N__CNSSCaptionLbl)
            {
            }
            column(BASE_COTISACaption; BASE_COTISACaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(JOURSCaption; JOURSCaptionLbl)
            {
            }
            column(RISC_PROFCaption; RISC_PROFCaptionLbl)
            {
            }
            column(PREST_FAMILCaption; PREST_FAMILCaptionLbl)
            {
            }
            column(VEILLESS_PATRCaption; VEILLESS_PATRCaptionLbl)
            {
            }
            column(VEILL_SALACaption; VEILL_SALACaptionLbl)
            {
            }
            column(OBSERVATIONCaption; OBSERVATIONCaptionLbl)
            {
            }
            column(FONCTIONCaption; FONCTIONCaptionLbl)
            {
            }
            column(DATE_ENTREECaption; DATE_ENTREECaptionLbl)
            {
            }
            column(TOTALCaption_Control1000000041; TOTALCaption_Control1000000041Lbl)
            {
            }
            column(Salary_Lines_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Indice := 0;
                Risque := 0;
                Prestation := 0;
                VeillessP := 0;
                VeillessS := 0;
                TotalCotisation := 0;
                IF Employer.GET(Employee) THEN;
                SocialContributionsEnregistré.SETRANGE("No.", "No.");
                SocialContributionsEnregistré.SETRANGE(Employee, Employee);
                IF SocialContributionsEnregistré.FINDFIRST THEN
                    REPEAT
                        Indice += 1;
                        IF Indice = 1 THEN Risque := SocialContributionsEnregistré."Real Amount : Employer";
                        IF Indice = 2 THEN Prestation := SocialContributionsEnregistré."Real Amount : Employer";
                        IF Indice = 3 THEN VeillessP := SocialContributionsEnregistré."Real Amount : Employer";
                        IF Indice = 4 THEN VeillessS := SocialContributionsEnregistré."Real Amount : Employee";
                        IF Indice = 1 THEN BEGIN
                            BaseCOtisation := ROUND(SocialContributionsEnregistré."Base Amount", 1);
                            TotBaseCOtisation += ROUND(SocialContributionsEnregistré."Base Amount", 1);
                        END;
                    UNTIL SocialContributionsEnregistré.NEXT = 0;
                TotalCotisation := Risque + Prestation + VeillessP + VeillessS;
                TotalGeneralCotisation += TotalCotisation;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(Risque, Prestation, VeillessP, VeillessS, "Salary Lines"."Gross Salary");
                IF CompanyInformation.GET THEN;
                CompanyInformation.CalcFields("Entete de page", "Pied de page");
            end;
        }
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

    var
        SocialContributions: Record "Social Contributions";
        "SocialContributionsEnregistré": Record "Social Contributions";
        Employer: Record Employee;
        Compteur: Integer;
        Risque: Decimal;
        Prestation: Decimal;
        VeillessP: Decimal;
        VeillessS: Decimal;
        Indice: Integer;
        TotalCotisation: Decimal;
        TotalGeneralCotisation: Decimal;
        CompanyInformation: Record "Company Information";
        HumanResourcesSetup: Record "Human Resources Setup";
        BaseCOtisation: Decimal;
        TotBaseCOtisation: Decimal;
        BORDEREAU_NOMINATIF_DES_TRAVAILLEURS_SALARIES_DE_SOUROUBAT___BFCaptionLbl: Label 'BORDEREAU NOMINATIF DES TRAVAILLEURS SALARIES DE SOUROUBAT - BF';
        ANNEECaptionLbl: Label 'ANNEE';
        MOISCaptionLbl: Label 'MOIS';
        N__CNSS_EMPLOYEUR__CaptionLbl: Label 'N° CNSS EMPLOYEUR :';
        N_CaptionLbl: Label 'N°';
        MATCaptionLbl: Label 'MAT';
        NOM_ET_PRENOMCaptionLbl: Label 'NOM ET PRENOM';
        N__CNSSCaptionLbl: Label 'N° CNSS';
        BASE_COTISACaptionLbl: Label 'BASE COTISA';
        TOTALCaptionLbl: Label 'TOTAL';
        JOURSCaptionLbl: Label 'JOURS';
        RISC_PROFCaptionLbl: Label 'RISC PROF';
        PREST_FAMILCaptionLbl: Label 'PREST FAMIL';
        VEILLESS_PATRCaptionLbl: Label 'VEILLESS PATR';
        VEILL_SALACaptionLbl: Label 'VEILL SALA';
        OBSERVATIONCaptionLbl: Label 'OBSERVATION';
        FONCTIONCaptionLbl: Label 'FONCTION';
        DATE_ENTREECaptionLbl: Label 'DATE ENTREE';
        TOTALCaption_Control1000000041Lbl: Label 'TOTAL';
}

