report 50176 "Pointage Enregistre"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/PointageEnregistre.rdlc';

    // dataset
    // {
    //     dataitem("Etat Mensuelle Paie Hist"; 52048945)
    //     {
    //         DataItemTableView = SORTING(Affectation);
    //         RequestFilterFields = Annee, Mois;
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Mois; Mois)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Annee; Annee)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Affectation; Affectation)
    //         {
    //         }
    //         column(Section_Decription; Section.Decription)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Matricule; Matricule)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Nom; Nom)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_Qualification; Qualification)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist_Présence"; Présence)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Heure_Travaillé_"; "Heure Travaillé")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Jours_Travaillé_"; "Jours Travaillé")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Heure_Travaillé_réel_"; "Heure Travaillé réel")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Rappel_Salarié_"; "Rappel Salarié")
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist__Heures_Retenues_; "Heures Retenues")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist_Férier"; Férier)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist_Congé"; Congé)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Congé_Spéciale_"; "Congé Spéciale")
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist__Nbr_Jours_Deplacement_; "Nbr Jours Deplacement")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Jours_Sup_Calculé_Majoré_à_75__"; "Jours Sup Calculé Majoré à 75%")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Heure_Normal_Supp_Calculé_"; "Heure Normal Supp Calculé")
    //         {
    //         }
    //         column(RecQualification_Description; RecQualification.Description)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie_Hist__Heure_Sup_Majoré_à_75___"; "Heure Sup Majoré à 75 %")
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(P_O_I_N_T_A_G_ECaption; P_O_I_N_T_A_G_ECaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(Matr_Caption; Matr_CaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Hist_QualificationCaption; FIELDCAPTION(Qualification))
    //         {
    //         }
    //         column(J_PrsCaption; J_PrsCaptionLbl)
    //         {
    //         }
    //         column(H_TrvCaption; H_TrvCaptionLbl)
    //         {
    //         }
    //         column(J_Nrm_Caption; J_Nrm_CaptionLbl)
    //         {
    //         }
    //         column(H_Nrm_Caption; H_Nrm_CaptionLbl)
    //         {
    //         }
    //         column(RappelCaption; RappelCaptionLbl)
    //         {
    //         }
    //         column(RetenuCaption; RetenuCaptionLbl)
    //         {
    //         }
    //         column("FeriéCaption"; FeriéCaptionLbl)
    //         {
    //         }
    //         column(C_A_Caption; C_A_CaptionLbl)
    //         {
    //         }
    //         column(C_Ex_Caption; C_Ex_CaptionLbl)
    //         {
    //         }
    //         column(J_Dep_Caption; J_Dep_CaptionLbl)
    //         {
    //         }
    //         column(J_ExtraCaption; J_ExtraCaptionLbl)
    //         {
    //         }
    //         column(H_SuppCaption; H_SuppCaptionLbl)
    //         {
    //         }
    //         column(H_EXTRACaption; H_EXTRACaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(Nombre__Caption; Nombre__CaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF RecAffectation.GET(Affectation) THEN;
    //             Affect := RecAffectation.Decription;
    //             IF RecQualification.GET(Qualification) THEN;
    //             Qualif := RecQualification.Description;

    //             IF Section.GET(Affectation) THEN;

    //             Nbre := Nbre + 1;
    //             IF RecQualification.GET(Qualification) THEN;
    //         end;
    //     }
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

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     RecAffectation: Record 52048917;
    //     RecQualification: Record 5202;
    //     HeureSuppEnreg: Record 52048892;
    //     Qualif: Text[30];
    //     Affect: Text[30];
    //     Nbre: Integer;
    //     "C.A": Decimal;
    //     Ferie: Integer;
    //     "C.Ex": Integer;
    //     "J.Dim": Integer;
    //     "J.Extra": Integer;
    //     "H.supp": Integer;
    //     Section: Record 52048917;
    //     Mois: Text[10];
    //     P_O_I_N_T_A_G_ECaptionLbl: Label 'P O I N T A G E';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     Matr_CaptionLbl: Label 'Matr.';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     J_PrsCaptionLbl: Label 'J.Prs';
    //     H_TrvCaptionLbl: Label 'H.Trv';
    //     J_Nrm_CaptionLbl: Label 'J.Nrm.';
    //     H_Nrm_CaptionLbl: Label 'H.Nrm.';
    //     RappelCaptionLbl: Label 'Rappel';
    //     RetenuCaptionLbl: Label 'Retenu';
    //     "FeriéCaptionLbl": Label 'Ferié';
    //     C_A_CaptionLbl: Label 'C.A.';
    //     C_Ex_CaptionLbl: Label 'C.Ex.';
    //     J_Dep_CaptionLbl: Label 'J.Dep.';
    //     J_ExtraCaptionLbl: Label 'J.Extra';
    //     H_SuppCaptionLbl: Label 'H.Supp';
    //     H_EXTRACaptionLbl: Label 'H.EXTRA';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     Nombre__CaptionLbl: Label 'Nombre :';
}

