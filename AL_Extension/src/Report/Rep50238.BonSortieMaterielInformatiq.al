report 50238 "Bon Sortie Materiel Informatiq"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BonSortieMaterielInformatiq.rdlc';

    // dataset
    // {
    //     dataitem("Entete Suivi Materiel Inf"; 52048954)
    //     {
    //         DataItemTableView = SORTING("N° Document");
    //         RequestFilterFields = "N° Document";
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO__Control1000000029; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME_Control1000000031; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4__Control1000000032; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO__Control1000000002; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME_Control1000000003; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4__Control1000000004; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__Nom_Et_Prenom_; "Nom Et Prenom")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf_Employee; Employee)
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__Document_; "N° Document")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf_Date; Date)
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__BL_; "N° BL")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__BC_; "N° BC")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__Doc_Externe_; "N° Doc Externe")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf_Preleveur; Preleveur)
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__Nom_Preleveur_; "Nom Preleveur")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf_Observation; Observation)
    //         {
    //         }
    //         column(DesignationAffaire; DesignationAffaire)
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__Description_Affectation_; "Description Affectation")
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__Description_Qualification_; "Description Qualification")
    //         {
    //         }
    //         column(BON_SORTIES_MATERIELS_INFORMATIQUESCaption; BON_SORTIES_MATERIELS_INFORMATIQUESCaptionLbl)
    //         {
    //         }
    //         column(BON_RETOURS_MATERIELS_INFORMATIQUESCaption; BON_RETOURS_MATERIELS_INFORMATIQUESCaptionLbl)
    //         {
    //         }
    //         column(BON_TRANSFERT_MATERIELS_INFORMATIQUESCaption; BON_TRANSFERT_MATERIELS_INFORMATIQUESCaptionLbl)
    //         {
    //         }
    //         column(Matricule_Demandeur__Caption; Matricule_Demandeur__CaptionLbl)
    //         {
    //         }
    //         column(Nom_Et_Prenom__Caption; Nom_Et_Prenom__CaptionLbl)
    //         {
    //         }
    //         column(Date_Document__Caption; Date_Document__CaptionLbl)
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__BL_Caption; FIELDCAPTION("N° BL"))
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__BC_Caption; FIELDCAPTION("N° BC"))
    //         {
    //         }
    //         column(Entete_Suivi_Materiel_Inf__N__Doc_Externe_Caption; FIELDCAPTION("N° Doc Externe"))
    //         {
    //         }
    //         column(Preleveur__Caption; Preleveur__CaptionLbl)
    //         {
    //         }
    //         column(Nom_Preleveur__Caption; Nom_Preleveur__CaptionLbl)
    //         {
    //         }
    //         column(Observation__Caption; Observation__CaptionLbl)
    //         {
    //         }
    //         column(Chantier__Caption; Chantier__CaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(Qualification__Caption; Qualification__CaptionLbl)
    //         {
    //         }
    //         column(Type_Document; "Type Document")
    //         {
    //         }
    //         dataitem("Ligne Suivi Mat Inf"; 52048955)
    //         {
    //             DataItemLink = "N° Document" = FIELD("N° Document");
    //             DataItemTableView = SORTING("N° Document", Marque, "N° Serie");
    //             column(Ligne_Suivi_Mat_Inf__N__Serie_; "N° Serie")
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf__Nature_Materiel_; "Nature Materiel")
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_Marque; Marque)
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_Description; Description)
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_Statut; Statut)
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf__N__Serie_Caption; FIELDCAPTION("N° Serie"))
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf__Nature_Materiel_Caption; FIELDCAPTION("Nature Materiel"))
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_MarqueCaption; FIELDCAPTION(Marque))
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_DescriptionCaption; FIELDCAPTION(Description))
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_StatutCaption; FIELDCAPTION(Statut))
    //             {
    //             }
    //             column(Signature_PreleveurCaption; Signature_PreleveurCaptionLbl)
    //             {
    //             }
    //             column(Signature_Responsable_InformatiqueCaption; Signature_Responsable_InformatiqueCaptionLbl)
    //             {
    //             }
    //             column("Signature_Superieur_HiéarchiqueCaption"; Signature_Superieur_HiéarchiqueCaptionLbl)
    //             {
    //             }
    //             column(Ligne_Suivi_Mat_Inf_N__Document; "N° Document")
    //             {
    //             }
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin
    //             IF RecAffaire.GET(Affaire) THEN DesignationAffaire := RecAffaire.Description;
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
    //     RecAffaire: Record 8004160;
    //     DesignationAffaire: Text[250];
    //     BON_SORTIES_MATERIELS_INFORMATIQUESCaptionLbl: Label 'BON SORTIES MATERIELS INFORMATIQUES';
    //     BON_RETOURS_MATERIELS_INFORMATIQUESCaptionLbl: Label 'BON RETOURS MATERIELS INFORMATIQUES';
    //     BON_TRANSFERT_MATERIELS_INFORMATIQUESCaptionLbl: Label 'BON TRANSFERT MATERIELS INFORMATIQUES';
    //     Matricule_Demandeur__CaptionLbl: Label 'Matricule Demandeur :';
    //     Nom_Et_Prenom__CaptionLbl: Label 'Nom Et Prenom :';
    //     Date_Document__CaptionLbl: Label 'Date Document :';
    //     Preleveur__CaptionLbl: Label 'Preleveur :';
    //     Nom_Preleveur__CaptionLbl: Label 'Nom Preleveur :';
    //     Observation__CaptionLbl: Label 'Observation :';
    //     Chantier__CaptionLbl: Label 'Chantier :';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     Qualification__CaptionLbl: Label 'Qualification :';
    //     Signature_PreleveurCaptionLbl: Label 'Signature Preleveur';
    //     Signature_Responsable_InformatiqueCaptionLbl: Label 'Signature Responsable Informatique';
    //     "Signature_Superieur_HiéarchiqueCaptionLbl": Label 'Signature Superieur Hiéarchique';
}

