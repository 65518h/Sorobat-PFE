report 50133 "Certificat de Retenue d'Impot"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/CertificatdeRetenuedImpot.rdlc';

    // dataset
    // {
    //     dataitem(Employee; 5200)
    //     {
    //         RequestFilterFields = "No.";
    //         column(NbAnnee; NbAnnee)
    //         {
    //         }
    //         column(Employee_Employee__First_Name_; Employee."First Name")
    //         {
    //         }
    //         column(Employee_Employee_Address; Employee.Address)
    //         {
    //         }
    //         column(Employee_Employee__Description_Qualification_; Employee."Description Qualification")
    //         {
    //         }
    //         column(Employee_Employee__No__; Employee."No.")
    //         {
    //         }
    //         column(Employee_Employee__Nombre_Enfant_; Employee."Nombre Enfant")
    //         {
    //         }
    //         column(InfoSoc__VAT_Registration_No__; InfoSoc."VAT Registration No.")
    //         {
    //         }
    //         column(Employee_Employee_Family_Situation_A_; Employee."Marital Status")
    //         {
    //         }
    //         column(InfoSoc_Name; InfoSoc.Name)
    //         {
    //         }
    //         column(InfoSoc_Address; InfoSoc.Address)
    //         {
    //         }
    //         column(FAnnee; FAnnee)
    //         {
    //         }
    //         column(Employee_Employee__N__CIN_; Employee."N° CIN")
    //         {
    //         }
    //         column(SomRevImposable; SomRevImposable)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SomAvantEnNature; SomAvantEnNature)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SomBrutImposable; SomBrutImposable)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SomMontantRetenues; SomMontantRetenues)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SomCredHabi; SomCredHabi)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SomNetRetenues; SomNetRetenues)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(V31_12___FORMAT_FAnnee_; '31/12/' + FORMAT(FAnnee))
    //         {
    //         }
    //         column(SomContSocial; SomContSocial)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Revenu_ImposableCaption; Revenu_ImposableCaptionLbl)
    //         {
    //         }
    //         column(Dont_Avantages_en_NatureCaption; Dont_Avantages_en_NatureCaptionLbl)
    //         {
    //         }
    //         column(Revenu_Brut_ImposableCaption; Revenu_Brut_ImposableCaptionLbl)
    //         {
    //         }
    //         column(Montant_des_RetenuesCaption; Montant_des_RetenuesCaptionLbl)
    //         {
    //         }
    //         column("Somme_Intérets_Crédit_HabitationCaption"; Somme_Intérets_Crédit_HabitationCaptionLbl)
    //         {
    //         }
    //         column(Revenus_Net_RetenuesCaption; Revenus_Net_RetenuesCaptionLbl)
    //         {
    //         }
    //         column("Période_de_travail_durant_l_année__Caption"; Période_de_travail_durant_l_année__CaptionLbl)
    //         {
    //         }
    //         column(REPUBLIQUE_TUNISIENNE_MINISTERE_DE_L_ECONOMIE_ET_DES_FINANCESCaption; REPUBLIQUE_TUNISIENNE_MINISTERE_DE_L_ECONOMIE_ET_DES_FINANCESCaptionLbl)
    //         {
    //         }
    //         column(DIRECTION_GENERALE_DU_CONTROLE_FISCALCaption; DIRECTION_GENERALE_DU_CONTROLE_FISCALCaptionLbl)
    //         {
    //         }
    //         column(CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LE_REVENU_AU_TITRE_DES_TRAITEMENTS__SALAIRES__PENSIONS_ET_RENTES_VIAGERESCaption; CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LE_REVENU_AU_TITRE_DES_TRAITEMENTS__SALAIRES__PENSIONS_ET_RENTES_VIAGERESCaptionLbl)
    //         {
    //         }
    //         column("Retenue_effectuée_durant_l_année__Caption"; Retenue_effectuée_durant_l_année__CaptionLbl)
    //         {
    //         }
    //         column("Nom_et_Prénon__Caption"; Nom_et_Prénon__CaptionLbl)
    //         {
    //         }
    //         column("Adresse_de_Résidence__Caption"; Adresse_de_Résidence__CaptionLbl)
    //         {
    //         }
    //         column("Emploi_Occupé__Caption"; Emploi_Occupé__CaptionLbl)
    //         {
    //         }
    //         column(A__Employeur_ou_organisme_payeurCaption; A__Employeur_ou_organisme_payeurCaptionLbl)
    //         {
    //         }
    //         column("B__Désignation_du_bénéficiaireCaption"; B__Désignation_du_bénéficiaireCaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(Situation_FamilialCaption; Situation_FamilialCaptionLbl)
    //         {
    //         }
    //         column(Matricule_Fiscale__Caption; Matricule_Fiscale__CaptionLbl)
    //         {
    //         }
    //         column(Raison_Sociale__Caption; Raison_Sociale__CaptionLbl)
    //         {
    //         }
    //         column(Adresse__Caption; Adresse__CaptionLbl)
    //         {
    //         }
    //         column(N__CIN__Caption; N__CIN__CaptionLbl)
    //         {
    //         }
    //         column("Contribution_Sociale_de_SolidaritéCaption"; Contribution_Sociale_de_SolidaritéCaptionLbl)
    //         {
    //         }
    //         column(DataItem1000000056; Je_soussigné__certifie_exacts_et_sincères_les_renseignements)
    //         {
    //         }
    //         column(A_Tunis__leCaption; A_Tunis__leCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             SomRevImposable := 0;
    //             SomAvantEnNature := 0;
    //             SomBrutImposable := 0;
    //             SomRedComp := 0;
    //             SomMontantRetenues := 0;
    //             SomNetRetenues := 0;
    //             NbAnnee := 0;
    //             RecSalaryLines.RESET;
    //             RecSalaryLines.SETFILTER(Year, '%1', FAnnee);
    //             RecSalaryLines.SETFILTER(Imposable, '%1', TRUE);
    //             RecSalaryLines.SETRANGE(Employee, "No.");
    //             //RecSalaryLines.SETRANGE(Imposable,TRUE);
    //             //NbAnnee := RecSalaryLines.COUNT;
    //             IF RecSalaryLines.FINDFIRST THEN
    //                 REPEAT
    //                     IF RecSalaryLines.Imposable THEN NbAnnee += 1;
    //                     SomRevImposable := SomRevImposable + RecSalaryLines."Taxable salary";
    //                     SomAvantEnNature := 0.0;
    //                     SomBrutImposable := SomBrutImposable + RecSalaryLines."Taxable salary";
    //                     SomRedComp := SomRedComp + RecSalaryLines."Taxe Redevance";
    //                     SomContSocial := SomContSocial + RecSalaryLines."Contribution Social";
    //                     SomCredHabi := RecSalaryLines."Credit Habitat";
    //                     SomAssVie := RecSalaryLines."Assurance Vie";
    //                     SomMontantRetenues := SomMontantRetenues + RecSalaryLines."Taxe (Month)";
    //                 UNTIL RecSalaryLines.NEXT = 0;
    //             IF NbAnnee = 0 THEN
    //                 CurrReport.SKIP
    //             ELSE
    //                 SomNetRetenues := SomBrutImposable - SomMontantRetenues - SomRedComp - SomCredHabi - SomAssVie - SomContSocial;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF FAnnee = 0 THEN
    //                 ERROR(Text001);

    //             InfoSoc.GET;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';
    //                 field(NoOfCopies; FAnnee)
    //                 {
    //                     ApplicationArea = Basic;
    //                     Caption = 'Année';
    //                 }

    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // var
    //     RecSalaryLines: Record 52048901;
    //     FAnnee: Integer;
    //     Text001: Label 'Vous devez preciser l''année !!!';
    //     NbAnnee: Integer;
    //     SomRevImposable: Decimal;
    //     SomAvantEnNature: Decimal;
    //     SomBrutImposable: Decimal;
    //     SomRedComp: Decimal;
    //     SomMontantRetenues: Decimal;
    //     SomNetRetenues: Decimal;
    //     SomContSocial: Decimal;
    //     SomCredHabi: Decimal;
    //     SomAssVie: Decimal;
    //     InfoSoc: Record 79;
    //     Revenu_ImposableCaptionLbl: Label 'Revenu Imposable';
    //     Dont_Avantages_en_NatureCaptionLbl: Label 'Dont Avantages en Nature';
    //     Revenu_Brut_ImposableCaptionLbl: Label 'Revenu Brut Imposable';
    //     Montant_des_RetenuesCaptionLbl: Label 'Montant des Retenues';
    //     "Somme_Intérets_Crédit_HabitationCaptionLbl": Label 'Somme Intérets Crédit Habitation';
    //     Revenus_Net_RetenuesCaptionLbl: Label 'Revenus Net Retenues';
    //     "Période_de_travail_durant_l_année__CaptionLbl": Label 'Période de travail durant l''année :';
    //     REPUBLIQUE_TUNISIENNE_MINISTERE_DE_L_ECONOMIE_ET_DES_FINANCESCaptionLbl: Label 'REPUBLIQUE TUNISIENNE MINISTERE DE L''ECONOMIE ET DES FINANCES';
    //     DIRECTION_GENERALE_DU_CONTROLE_FISCALCaptionLbl: Label 'DIRECTION GENERALE DU CONTROLE FISCAL';
    //     CERTIFICAT_DE_RETENUE_D_IMPOT_SUR_LE_REVENU_AU_TITRE_DES_TRAITEMENTS__SALAIRES__PENSIONS_ET_RENTES_VIAGERESCaptionLbl: Label 'CERTIFICAT DE RETENUE D''IMPOT SUR LE REVENU AU TITRE DES TRAITEMENTS, SALAIRES, PENSIONS ET RENTES VIAGERES';
    //     "Retenue_effectuée_durant_l_année__CaptionLbl": Label 'Retenue effectuée durant l''année :';
    //     "Nom_et_Prénon__CaptionLbl": Label 'Nom et Prénon :';
    //     "Adresse_de_Résidence__CaptionLbl": Label 'Adresse de Résidence :';
    //     "Emploi_Occupé__CaptionLbl": Label 'Emploi Occupé :';
    //     A__Employeur_ou_organisme_payeurCaptionLbl: Label 'A- Employeur ou organisme payeur';
    //     "B__Désignation_du_bénéficiaireCaptionLbl": Label 'B- Désignation du bénéficiaire';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     Situation_FamilialCaptionLbl: Label 'Situation Familial';
    //     Matricule_Fiscale__CaptionLbl: Label 'Matricule Fiscale :';
    //     Raison_Sociale__CaptionLbl: Label 'Raison Sociale :';
    //     Adresse__CaptionLbl: Label 'Adresse :';
    //     N__CIN__CaptionLbl: Label 'N° CIN :';
    //     "Contribution_Sociale_de_SolidaritéCaptionLbl": Label 'Contribution Sociale de Solidarité';
    //     "Je_soussigné__certifie_exacts_et_sincères_les_renseignements": Label 'Je soussigné, certifie exacts et sincères les renseignements figurants sur le présent certificat et m''expose aux sanctions prévues par la loi pour toute inéxactitude.';
    //     A_Tunis__leCaptionLbl: Label 'A Tunis, le';
}

