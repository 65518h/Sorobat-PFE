report 50003 "PV Reception"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PVReception.rdl';

    dataset
    {
        dataitem(DataItem8490; 50004)
        {
            CalcFields = "Designation Article";
            column(PV_Reception__N__Commande_; "N° Commande")
            {
            }
            column(PV_Reception__N__Article_; "N° Article")
            {
            }
            column(PV_Reception__Date_Commande_; "Date Commande")
            {
            }
            column("PV_Reception__N__Reception_Enregistré_"; "N° Reception Enregistré")
            {
            }
            column(PV_Reception__N__Affaire_; "N° Affaire")
            {
            }
            column(PV_Reception__Lieu_De_Chargement_; "Lieu De Chargement")
            {
            }
            column(PV_Reception__N__BL_Fournisseur_; "N° BL Fournisseur")
            {
            }
            column(PV_Reception__N__Camion_; "N° Camion")
            {
            }
            column(PV_Reception__Date_Heure_depart_Chatier_; "Date Heure depart Chatier")
            {
            }
            column(PV_Reception__Date_Heure_Chargement_Frs_; "Date Heure Chargement Frs")
            {
            }
            column(PV_Reception__Date_Heure_Retour_Chantier_; "Date Heure Retour Chantier")
            {
            }
            column(PV_Reception__Tare_Chez_Fournisseur_; "Tare Chez Fournisseur")
            {
            }
            column(PV_Reception__Poids_Brut_Fournisseur_; "Poids Brut Fournisseur")
            {
            }
            column(PV_Reception__Poids_Net_Fournisseur_; "Poids Net Fournisseur")
            {
            }
            column(PV_Reception__Tare_Chantier_; "Tare Chantier")
            {
            }
            column(PV_Reception__Poids_Brut_Chantier_; "Poids Brut Chantier")
            {
            }
            column(PV_Reception__Poids_Net_Chantier_; "Poids Net Chantier")
            {
            }
            column(PV_Reception__Ecart_Poids_Net_Chantier_; "Ecart Poids Net Chantier")
            {
            }
            column(PV_Reception__Poids_Apres_SC_; "Poids Apres SC")
            {
            }
            column("PV_Reception__Quantité_SC_"; "Quantité SC")
            {
            }
            column("PV_Reception__Poids_Aprés_CB_"; "Poids Aprés CB")
            {
            }
            column("PV_Reception__Quantité_CB_"; "Quantité CB")
            {
            }
            column("PV_Reception__Quantité_SC__Control1000000128"; "Quantité SC")
            {
            }
            column(PV_Reception__Ecart_Final_; "Ecart Final")
            {
            }
            column(PV_Reception__Designation_Article_; "Designation Article")
            {
            }
            column(RAPPORT_DE_RECEPTION_DU_Caption; RAPPORT_DE_RECEPTION_DU_CaptionLbl)
            {
            }
            column(Destination__Caption; Destination__CaptionLbl)
            {
            }
            column(COMMANDECaption; COMMANDECaptionLbl)
            {
            }
            column(N__Commande__Caption; N__Commande__CaptionLbl)
            {
            }
            column("Référence_Produit___Caption"; Référence_Produit___CaptionLbl)
            {
            }
            column(Date__Commande__Caption; Date__Commande__CaptionLbl)
            {
            }
            column(Lieu_de_chargement___Caption; Lieu_de_chargement___CaptionLbl)
            {
            }
            column(BON_DE_LIVRAISON_Caption; BON_DE_LIVRAISON_CaptionLbl)
            {
            }
            column(N__du_Bon__Caption; N__du_Bon__CaptionLbl)
            {
            }
            column("Date_eu_Heure_de_départ_ChantierCaption"; Date_eu_Heure_de_départ_ChantierCaptionLbl)
            {
            }
            column(N__du_Camion__Caption; N__du_Camion__CaptionLbl)
            {
            }
            column(Date_eu_Heure_de_chargement_SCACaption; Date_eu_Heure_de_chargement_SCACaptionLbl)
            {
            }
            column(Date_eu_Heure_de_retour_ChantierCaption; Date_eu_Heure_de_retour_ChantierCaptionLbl)
            {
            }
            column(TareCaption; TareCaptionLbl)
            {
            }
            column(CHARGEMENT_Caption; CHARGEMENT_CaptionLbl)
            {
            }
            column(Poids_BrutCaption; Poids_BrutCaptionLbl)
            {
            }
            column("Poids_Net_ChargéCaption"; Poids_Net_ChargéCaptionLbl)
            {
            }
            column(Poids_BrutCaption_Control1000000032; Poids_BrutCaption_Control1000000032Lbl)
            {
            }
            column("Poids_Net_ReçuCaption"; Poids_Net_ReçuCaptionLbl)
            {
            }
            column(RECEPTION_CHANTIER_Caption; RECEPTION_CHANTIER_CaptionLbl)
            {
            }
            column(TareCaption_Control1000000035; TareCaption_Control1000000035Lbl)
            {
            }
            column(Ecart_Poids_NetsCaption; Ecart_Poids_NetsCaptionLbl)
            {
            }
            column("Poids_Aprés_SC_Caption"; Poids_Aprés_SC_CaptionLbl)
            {
            }
            column("Qté_SC_Caption"; Qté_SC_CaptionLbl)
            {
            }
            column("Poids_Aprés_CB_Caption"; Poids_Aprés_CB_CaptionLbl)
            {
            }
            column("Qté_CB_Caption"; Qté_CB_CaptionLbl)
            {
            }
            column("Qté_Totale_DépotéeCaption"; Qté_Totale_DépotéeCaptionLbl)
            {
            }
            column("Ecart__Qté_Dépotée___Qté_Réelle_reçue_Caption"; Ecart__Qté_Dépotée___Qté_Réelle_reçue_CaptionLbl)
            {
            }
            column(REMARQUE__Caption; REMARQUE__CaptionLbl)
            {
            }
            column("Nom_et_Prénom_Caption"; Nom_et_Prénom_CaptionLbl)
            {
            }
            column(Fonction_Caption; Fonction_CaptionLbl)
            {
            }
            column(Organisme_Caption; Organisme_CaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(BN__Caption; BN__CaptionLbl)
            {
            }
            column("Toud_les_poids_sont_exprimés_en_KgCaption"; Toud_les_poids_sont_exprimés_en_KgCaptionLbl)
            {
            }
            column("Le_Directeur_MateriélCaption"; Le_Directeur_MateriélCaptionLbl)
            {
            }
            column(Le_Directeur_de_ProjetCaption; Le_Directeur_de_ProjetCaptionLbl)
            {
            }
            column("Personnes_ConcernéesCaption"; Personnes_ConcernéesCaptionLbl)
            {
            }
            column(Reception_N____Caption; Reception_N____CaptionLbl)
            {
            }
            column(PV_Reception_N__Sequence; "N° Sequence")
            {
            }
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
        RecCompInf: Record 79;
        RAPPORT_DE_RECEPTION_DU_CaptionLbl: Label 'RAPPORT DE RECEPTION DU ';
        Destination__CaptionLbl: Label 'Destination :';
        COMMANDECaptionLbl: Label 'COMMANDE';
        N__Commande__CaptionLbl: Label 'N° Commande :';
        "Référence_Produit___CaptionLbl": Label 'Référence Produit  :';
        Date__Commande__CaptionLbl: Label 'Date  Commande :';
        Lieu_de_chargement___CaptionLbl: Label 'Lieu de chargement  :';
        BON_DE_LIVRAISON_CaptionLbl: Label 'BON DE LIVRAISON ';
        N__du_Bon__CaptionLbl: Label 'N° du Bon :';
        "Date_eu_Heure_de_départ_ChantierCaptionLbl": Label 'Date eu Heure de départ Chantier';
        N__du_Camion__CaptionLbl: Label 'N° du Camion :';
        Date_eu_Heure_de_chargement_SCACaptionLbl: Label 'Date eu Heure de chargement SCA';
        Date_eu_Heure_de_retour_ChantierCaptionLbl: Label 'Date eu Heure de retour Chantier';
        TareCaptionLbl: Label 'Tare';
        CHARGEMENT_CaptionLbl: Label 'CHARGEMENT ';
        Poids_BrutCaptionLbl: Label 'Poids Brut';
        "Poids_Net_ChargéCaptionLbl": Label 'Poids Net Chargé';
        Poids_BrutCaption_Control1000000032Lbl: Label 'Poids Brut';
        "Poids_Net_ReçuCaptionLbl": Label 'Poids Net Reçu';
        RECEPTION_CHANTIER_CaptionLbl: Label 'RECEPTION CHANTIER ';
        TareCaption_Control1000000035Lbl: Label 'Tare';
        Ecart_Poids_NetsCaptionLbl: Label 'Ecart Poids Nets';
        "Poids_Aprés_SC_CaptionLbl": Label 'Poids Aprés SC ';
        "Qté_SC_CaptionLbl": Label 'Qté SC ';
        "Poids_Aprés_CB_CaptionLbl": Label 'Poids Aprés CB ';
        "Qté_CB_CaptionLbl": Label 'Qté CB ';
        "Qté_Totale_DépotéeCaptionLbl": Label 'Qté Totale Dépotée';
        "Ecart__Qté_Dépotée___Qté_Réelle_reçue_CaptionLbl": Label 'Ecart (Qté Dépotée - Qté Réelle reçue)';
        REMARQUE__CaptionLbl: Label 'REMARQUE :';
        "Nom_et_Prénom_CaptionLbl": Label 'Nom et Prénom ';
        Fonction_CaptionLbl: Label 'Fonction ';
        Organisme_CaptionLbl: Label 'Organisme ';
        Signature_CaptionLbl: Label 'Signature ';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        V4CaptionLbl: Label '4';
        V5CaptionLbl: Label '5';
        BN__CaptionLbl: Label 'BN :';
        "Toud_les_poids_sont_exprimés_en_KgCaptionLbl": Label 'Toud les poids sont exprimés en Kg';
        "Le_Directeur_MateriélCaptionLbl": Label 'Le Directeur Materiél';
        Le_Directeur_de_ProjetCaptionLbl: Label 'Le Directeur de Projet';
        "Personnes_ConcernéesCaptionLbl": Label 'Personnes Concernées';
        Reception_N____CaptionLbl: Label 'Reception N°  :';
}

