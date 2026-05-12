report 52048902 Pointage
{
    // //GL2024  ID dans Nav 2009 : "39001428"
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Pointage.rdlc';

    // dataset
    // {
    //     dataitem("Etat Mensuelle Paie"; "Etat Mensuelle Paie")
    //     {
    //         DataItemTableView = SORTING(Affectation);
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Mois; Mois)
    //         {
    //         }
    //         column(DATE2DMY_TODAY_3_; DATE2DMY(TODAY, 3))
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Affectation; Affectation)
    //         {
    //         }
    //         column(Section_Decription; Section.Decription)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Matricule; "Etat Mensuelle Paie".Matricule)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Nom; Nom)
    //         {
    //         }
    //         column(Etat_Mensuelle_Paie_Qualification; Qualification)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Présence"; "Etat Mensuelle Paie".Présence)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie__Heure_Travaillé_"; "Heure Travaillé")
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Jours_Travaillé_"; "Etat Mensuelle Paie"."Jours Travaillé")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Travaillé_réel_"; "Etat Mensuelle Paie"."Heure Travaillé réel")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie__Rappel_Salarié_"; "Rappel Salarié")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column(Etat_Mensuelle_Paie__Heures_Retenues_; "Heures Retenues")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Férier"; "Etat Mensuelle Paie".Férier)
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie_Congé"; Congé)
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Congé_Spéciale_"; "Etat Mensuelle Paie"."Congé Spéciale")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Nbr_Jours_Deplacement_; "Etat Mensuelle Paie"."Nbr Jours Deplacement")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Jours_Sup_Calculé_Majoré_à_75__"; "Etat Mensuelle Paie"."Jours Sup Calculé Majoré à 75%")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Normal_; "Etat Mensuelle Paie"."Heure Normal")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column(RecQualification_Description; RecQualification.Description)
    //         {
    //         }
    //         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Sup_Majoré_à_75___"; "Etat Mensuelle Paie"."Heure Sup Majoré à 75 %")
    //         {
    //             DecimalPlaces = 2 : 2;
    //         }
    //         column(Etat_Mensuelle_Paie__Heure_Sup_BR_; "Heure Sup BR")
    //         {
    //             DecimalPlaces = 2 : 2;
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
    //         column(Etat_Mensuelle_Paie_QualificationCaption; FIELDCAPTION(Qualification))
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
    //         column(Heur_Sup_BRCaption; Heur_Sup_BRCaptionLbl)
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


    //             IF DATE2DMY(TODAY, 2) - 1 = 1 THEN Mois := 'JANVIER';
    //             IF DATE2DMY(TODAY, 2) - 1 = 2 THEN Mois := 'FEVRIER';
    //             IF DATE2DMY(TODAY, 2) - 1 = 3 THEN Mois := 'MARS';
    //             IF DATE2DMY(TODAY, 2) - 1 = 4 THEN Mois := 'AVRIL';
    //             IF DATE2DMY(TODAY, 2) - 1 = 5 THEN Mois := 'MAI';
    //             IF DATE2DMY(TODAY, 2) - 1 = 6 THEN Mois := 'JUIN';
    //             IF DATE2DMY(TODAY, 2) - 1 = 7 THEN Mois := 'JUILLET';
    //             IF DATE2DMY(TODAY, 2) - 1 = 8 THEN Mois := 'AOUT';
    //             IF DATE2DMY(TODAY, 2) - 1 = 9 THEN Mois := 'SEPTEMBRE';
    //             IF DATE2DMY(TODAY, 2) - 1 = 10 THEN Mois := 'OCTOBRE';
    //             IF DATE2DMY(TODAY, 2) - 1 = 11 THEN Mois := 'NOVEMBRE';
    //             IF DATE2DMY(TODAY, 2) - 1 = 12 THEN Mois := 'DECEMBRE';

    //             Nbre := Nbre + 1;


    //             //GL2024 CurrReport.SHOWOUTPUT :=  CurrReport.TOTALSCAUSEDBY = "Etat Mensuelle Paie".FIELDNO(Affectation);
    //             IF Section.GET(Affectation) THEN;
    //             //gl2024    descriptionSection := Section.Decription;
    //             //G2024   CurrReport.SHOWOUTPUT :=    CurrReport.TOTALSCAUSEDBY = LastFieldNo;

    //             /*GL2024
    //             IF NOT FooterPrinted THEN
    //               LastFieldNo := CurrReport.TOTALSCAUSEDBY;
    //             CurrReport.SHOWOUTPUT := NOT FooterPrinted;
    //             FooterPrinted := TRUE;*/

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
    //     RecAffectation: Record Section;
    //     RecQualification: Record 5202;
    //     HeureSuppEnreg: Record "Heures sup. eregistrées m";
    //     Qualif: Text[100];
    //     Affect: Text[100];
    //     Nbre: Integer;
    //     "C.A": Decimal;
    //     Ferie: Integer;
    //     "C.Ex": Integer;
    //     "J.Dim": Integer;
    //     "J.Extra": Integer;
    //     "H.supp": Integer;
    //     Section: Record Section;
    //     descriptionSection: text[50];
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
    //     Heur_Sup_BRCaptionLbl: Label 'Heur Sup BR';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     Nombre__CaptionLbl: Label 'Nombre :';
}

