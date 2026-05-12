report 50187 "BT GMAO"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BTGMAO.rdlc';
    // Caption = 'BT GMAO';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;

    // dataset
    // {
    //     dataitem("Entete BT"; 52049015)
    //     {
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(N__BT_________Entete_BT__Code; 'N° BT :    ' + "Entete BT".Code)
    //         {
    //         }
    //         column(Entete_BT_Type; Type)
    //         {
    //         }
    //         column(Entete_BT__Date_Lancement_; "Date Lancement")
    //         {
    //         }
    //         column(Entete_BT_Equipement; Equipement)
    //         {
    //         }
    //         column(Entete_BT__Designiation_Equipement_; "Designiation Equipement")
    //         {
    //         }
    //         column(Entete_BT_Gamme; Gamme)
    //         {
    //         }
    //         column(Entete_BT__Designiation_Gamme_; "Designiation Gamme")
    //         {
    //         }
    //         column(Entete_BT__Nom_Chauffeur_; "Nom Chauffeur")
    //         {
    //         }
    //         column(Entete_BT__Designation_Vehicule_; "Designation Vehicule")
    //         {
    //         }
    //         column(Entete_BT__Index_Actuelle_; "Index Actuelle")
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column(Entete_BT_Observation; Observation)
    //         {
    //         }
    //         column("Entete_BT__DA_Associé_"; "DA Associé")
    //         {
    //         }
    //         column(Type__Caption; Type__CaptionLbl)
    //         {
    //         }
    //         column(Date_Lancement__Caption; Date_Lancement__CaptionLbl)
    //         {
    //         }
    //         column(Equipement__Caption; Equipement__CaptionLbl)
    //         {
    //         }
    //         column(Gamme__Caption; Gamme__CaptionLbl)
    //         {
    //         }
    //         column(ChauffeurCaption; ChauffeurCaptionLbl)
    //         {
    //         }
    //         column(VehiculeCaption; VehiculeCaptionLbl)
    //         {
    //         }
    //         column(Index_Actuel__Caption; Index_Actuel__CaptionLbl)
    //         {
    //         }
    //         column(Entete_BT_ObservationCaption; FIELDCAPTION(Observation))
    //         {
    //         }
    //         column("Entete_BT__DA_Associé_Caption"; FIELDCAPTION("DA Associé"))
    //         {
    //         }
    //         column(Entete_BT_Code; Code)
    //         {
    //         }
    //         dataitem("Ligne BT"; 52049016)
    //         {
    //             DataItemLink = "Code BT" = FIELD(Code);
    //             DataItemTableView = SORTING("Code BT", "Num Ligne");
    //             column(Ligne_BT__Code_Article_; "Code Article")
    //             {
    //             }
    //             column(Ligne_BT_Designiation; Designiation)
    //             {
    //             }
    //             column("Ligne_BT__Quantite_Connsomée_"; "Quantite Connsomée")
    //             {
    //             }
    //             column(Ligne_BT__Code_Article_Caption; FIELDCAPTION("Code Article"))
    //             {
    //             }
    //             column(Ligne_BT_DesigniationCaption; FIELDCAPTION(Designiation))
    //             {
    //             }
    //             column("Ligne_BT__Quantite_Connsomée_Caption"; FIELDCAPTION("Quantite Connsomée"))
    //             {
    //             }
    //             column(Liste_Des_ArticlesCaption; Liste_Des_ArticlesCaptionLbl)
    //             {
    //             }
    //             column(Ligne_BT_Code_BT; "Code BT")
    //             {
    //             }
    //             column(Ligne_BT_Num_Ligne; "Num Ligne")
    //             {
    //             }
    //         }
    //         dataitem("Intervenants BT"; 52049021)
    //         {
    //             DataItemLink = "Code BT" = FIELD(Code);
    //             column(Intervenants_BT__Date_Intervention_; "Date Intervention")
    //             {
    //             }
    //             column("Intervenants_BT_Durée"; Durée)
    //             {
    //             }
    //             column(Intervenants_BT__Detaille_Intervention_; "Detaille Intervention")
    //             {
    //             }
    //             column(Intervenants_BT__Nom_Intervenant_; "Nom Intervenant")
    //             {
    //             }
    //             column(IntervenantCaption; IntervenantCaptionLbl)
    //             {
    //             }
    //             column(Intervenants_BT__Nom_Intervenant_Caption; FIELDCAPTION("Nom Intervenant"))
    //             {
    //             }
    //             column(Intervenants_BT__Date_Intervention_Caption; FIELDCAPTION("Date Intervention"))
    //             {
    //             }
    //             column("Intervenants_BT_DuréeCaption"; FIELDCAPTION(Durée))
    //             {
    //             }
    //             column(Details_Intervention_Caption; Details_Intervention_CaptionLbl)
    //             {
    //             }
    //             column(Intervenants_BT_Code_BT; "Code BT")
    //             {
    //             }
    //             column(Intervenants_BT_N__Ligne; "N° Ligne")
    //             {
    //             }
    //         }
    //         dataitem("Gamme_Mode Operatoire"; 52049019)
    //         {
    //             DataItemLink = "Code Gamme" = FIELD(Gamme);
    //             DataItemTableView = SORTING("Code Gamme", "N° Ligne")
    //                                 WHERE(Description = FILTER(<> ''));
    //             column(FORMAT_i_______Description; FORMAT(i) + '- ' + Description)
    //             {
    //             }
    //             column(Mode_OperatoiresCaption; Mode_OperatoiresCaptionLbl)
    //             {
    //             }
    //             column(DescriptionCaption; DescriptionCaptionLbl)
    //             {
    //             }
    //             column(Gamme_Mode_Operatoire_Code_Gamme; "Code Gamme")
    //             {
    //             }
    //             column(Gamme_Mode_Operatoire_N__Ligne; "N° Ligne")
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin
    //                 i += 1;
    //             end;
    //         }
    //         dataitem("Observation BT"; 52049025)
    //         {
    //             DataItemLink = BT = FIELD(Code);
    //             column(Observation_BT_Observation; Observation)
    //             {
    //             }
    //             column("Diagnostic_et_RéparationCaption"; Diagnostic_et_RéparationCaptionLbl)
    //             {
    //             }
    //             column(Observation_BT_ObservationCaption; FIELDCAPTION(Observation))
    //             {
    //             }
    //             column(Observation_BT_BT; BT)
    //             {
    //             }
    //             column(Observation_BT_Type; Type)
    //             {
    //             }
    //         }
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
    //     i: Integer;
    //     Type__CaptionLbl: Label 'Type :';
    //     Date_Lancement__CaptionLbl: Label 'Date Lancement :';
    //     Equipement__CaptionLbl: Label 'Equipement :';
    //     Gamme__CaptionLbl: Label 'Gamme :';
    //     ChauffeurCaptionLbl: Label 'Chauffeur';
    //     VehiculeCaptionLbl: Label 'Vehicule';
    //     Index_Actuel__CaptionLbl: Label 'Index Actuel :';
    //     Liste_Des_ArticlesCaptionLbl: Label 'Liste Des Articles';
    //     IntervenantCaptionLbl: Label 'Intervenant';
    //     Details_Intervention_CaptionLbl: Label '<Details Intervention>';
    //     Mode_OperatoiresCaptionLbl: Label 'Mode Operatoires';
    //     DescriptionCaptionLbl: Label 'Description';
    //     "Diagnostic_et_RéparationCaptionLbl": Label 'Diagnostic et Réparation';
}

