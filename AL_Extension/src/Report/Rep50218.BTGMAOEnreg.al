report 50218 "BT GMAO Enreg"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BTGMAOEnreg.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'BT GMAO Enreg';

    // dataset
    // {
    //     dataitem("Entete BT Enreg"; 52049017)
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
    //         column(N__BT_________Entete_BT_Enreg__Code; 'N° BT :    ' + "Entete BT Enreg".Code)
    //         {
    //         }
    //         column(Entete_BT_Enreg_Type; Type)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Date_Lancement_; "Date Lancement")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Equipement; Equipement)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Equipement_; "Designiation Equipement")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Gamme; Gamme)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Gamme_; "Designiation Gamme")
    //         {
    //         }
    //         column(Entete_BT_Enreg__Index_Actuelle_; "Index Actuelle")
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column(Entete_BT_Enreg_Observation; Observation)
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Equipement__Control1000000003; "Designiation Equipement")
    //         {
    //         }
    //         column(Entete_BT_Enreg_Chauffeur; Chauffeur)
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
    //         column(Index_Actuel__Caption; Index_Actuel__CaptionLbl)
    //         {
    //         }
    //         column(Entete_BT_Enreg_ObservationCaption; FIELDCAPTION(Observation))
    //         {
    //         }
    //         column(Entete_BT_Enreg__Designiation_Equipement__Control1000000003Caption; FIELDCAPTION("Designiation Equipement"))
    //         {
    //         }
    //         column(Entete_BT_Enreg_ChauffeurCaption; FIELDCAPTION(Chauffeur))
    //         {
    //         }
    //         column(Entete_BT_Enreg_Code; Code)
    //         {
    //         }
    //         column(DesEquipementlab; DesEquipementlab)
    //         {
    //         }

    //         column(Chauffreurlab; Chauffreurlab)
    //         {
    //         }
    //         column(Observationlab; Observationlab)
    //         {

    //         }





    //         dataitem("Ligne BT Enreg"; 52049018)
    //         {
    //             DataItemLink = "Code BT" = FIELD(Code);
    //             DataItemTableView = SORTING("Code BT", "Num Ligne", "Code Article");
    //             column(Ligne_BT_Enreg__Code_Article_; "Code Article")
    //             {
    //             }
    //             column(Ligne_BT_Enreg_Designiation; Designiation)
    //             {
    //             }
    //             column("Ligne_BT_Enreg__Quantite_Connsomée_"; "Quantite Connsomée")
    //             {
    //             }
    //             column(Ligne_BT_Enreg__Code_Article_Caption; FIELDCAPTION("Code Article"))
    //             {
    //             }
    //             column(Ligne_BT_Enreg_DesigniationCaption; FIELDCAPTION(Designiation))
    //             {
    //             }
    //             column("Ligne_BT_Enreg__Quantite_Connsomée_Caption"; FIELDCAPTION("Quantite Connsomée"))
    //             {
    //             }
    //             column(Liste_Des_ArticlesCaption; Liste_Des_ArticlesCaptionLbl)
    //             {
    //             }
    //             column(Ligne_BT_Enreg_Code_BT; "Code BT")
    //             {
    //             }
    //             column(Ligne_BT_Enreg_Num_Ligne; "Num Ligne")
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
    //     Index_Actuel__CaptionLbl: Label 'Index Actuel :';
    //     Liste_Des_ArticlesCaptionLbl: Label 'Liste Des Articles';
    //     IntervenantCaptionLbl: Label 'Intervenant';
    //     Details_Intervention_CaptionLbl: Label 'Details Intervention';
    //     Mode_OperatoiresCaptionLbl: Label 'Mode Operatoires';
    //     DescriptionCaptionLbl: Label 'Description';
    //     "Diagnostic_et_RéparationCaptionLbl": Label 'Diagnostic et Réparation';
    //     "DesEquipementlab": Label 'Designiation Equipement';
    //     Chauffreurlab: Label 'Chauffeur';
    //     Observationlab: Label 'Observation';

}

