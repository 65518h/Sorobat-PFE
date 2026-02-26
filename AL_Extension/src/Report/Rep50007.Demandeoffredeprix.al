report 50007 "Demande offre de prix"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Demandeoffredeprix.rdl';

    // dataset
    // {
    //     dataitem(DataItem4458; 38)
    //     {
    //         DataItemTableView = WHERE("Document Type" = FILTER(Quote));
    //         RequestFilterFields = "No.";
    //         column(CompânyName; RecCompanyInfo.Name) { }
    //         column(CompânyPicture; RecCompanyInfo.Picture) { }
    //         column(Purchase_Header__No__; "No.")
    //         {
    //         }
    //         column(TODAY; TODAY)
    //         {
    //         }
    //         column(Purchase_Header__Pay_to_Name_; "Pay-to Name")
    //         {
    //         }
    //         column(Desing; Desing)
    //         {
    //         }
    //         column(marque; marque)
    //         {
    //         }
    //         column(chassis; chassis)
    //         {
    //         }
    //         column(Nom; Nom)
    //         {
    //         }
    //         column(Purchase_Header__Generer_A_Partir_DA_; "Generer A Partir DA")
    //         {
    //         }
    //         column(type; type)
    //         {
    //         }
    //         column(Purchase_Header__Pay_to_Name__Control1000000035; "Pay-to Name")
    //         {
    //         }
    //         column(TODAY_Control1000000005; TODAY)
    //         {
    //         }
    //         column(Purchase_Header__No___Control1000000009; "No.")
    //         {
    //         }
    //         column(Purchase_Header__Generer_A_Partir_DA__Control1000000013; "Generer A Partir DA")
    //         {
    //         }
    //         column(Desing_Control1000000017; Desing)
    //         {
    //         }
    //         column(marque_Control1000000022; marque)
    //         {
    //         }
    //         column(type_Control1000000023; type)
    //         {
    //         }
    //         column(chassis_Control1000000024; chassis)
    //         {
    //         }
    //         column(Nom_Control1000000038; Nom)
    //         {
    //         }
    //         column("Société_de_Routes_et_de_BatimentsCaption"; Société_de_Routes_et_de_BatimentsCaptionLbl)
    //         {
    //         }
    //         column(Megrine_Le__Caption; Megrine_Le__CaptionLbl)
    //         {
    //         }
    //         column("A_L_attention_de_la_Société__Caption"; A_L_attention_de_la_Société__CaptionLbl)
    //         {
    //         }
    //         column(DEMANDE_DE_PRIX_No__Caption; DEMANDE_DE_PRIX_No__CaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508Caption; FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508CaptionLbl)
    //         {
    //         }
    //         column(Affaire_Suivie_par__Caption; Affaire_Suivie_par__CaptionLbl)
    //         {
    //         }
    //         column(Numero_DA__Caption; Numero_DA__CaptionLbl)
    //         {
    //         }
    //         column(Vehicule__Caption; Vehicule__CaptionLbl)
    //         {
    //         }
    //         column(No_Chassis__Caption; No_Chassis__CaptionLbl)
    //         {
    //         }
    //         column(Marque__Caption; Marque__CaptionLbl)
    //         {
    //         }
    //         column(Type__Caption; Type__CaptionLbl)
    //         {
    //         }
    //         column(FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508Caption_Control1000000006; FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508Caption_Control1000000006Lbl)
    //         {
    //         }
    //         column("A_L_attention_de_la_Société__Caption_Control1000000007"; A_L_attention_de_la_Société__Caption_Control1000000007Lbl)
    //         {
    //         }
    //         column(Megrine_Le__Caption_Control1000000008; Megrine_Le__Caption_Control1000000008Lbl)
    //         {
    //         }
    //         column(DEMANDE_DE_PRIX_No__Caption_Control1000000019; DEMANDE_DE_PRIX_No__Caption_Control1000000019Lbl)
    //         {
    //         }
    //         column(SOROUBATCaption_Control1000000001; SOROUBATCaption_Control1000000001Lbl)
    //         {
    //         }
    //         column(Affaire_Suivie_par__Caption_Control1000000002; Affaire_Suivie_par__Caption_Control1000000002Lbl)
    //         {
    //         }
    //         column(Numero_DA__Caption_Control1000000003; Numero_DA__Caption_Control1000000003Lbl)
    //         {
    //         }
    //         column(Vehicule__Caption_Control1000000004; Vehicule__Caption_Control1000000004Lbl)
    //         {
    //         }
    //         column(No_Chassis__Caption_Control1000000025; No_Chassis__Caption_Control1000000025Lbl)
    //         {
    //         }
    //         column(Marque__Caption_Control1000000026; Marque__Caption_Control1000000026Lbl)
    //         {
    //         }
    //         column(Type__Caption_Control1000000028; Type__Caption_Control1000000028Lbl)
    //         {
    //         }
    //         column("Société_de_Routes_et_de_BatimentsCaption_Control1000000016"; Société_de_Routes_et_de_BatimentsCaption_Control1000000016Lbl)
    //         {
    //         }
    //         column(Purchase_Header_Document_Type; "Document Type")
    //         {
    //         }
    //         dataitem(DataItem6547; 39)
    //         {
    //             DataItemLink = "Document No." = FIELD("No.");
    //             column(Purchase_Line_Description_; Description)
    //             {
    //             }
    //             column(Purchase_Line_Quantity; Quantity)
    //             {
    //             }
    //             column(Nous_vous_prions_de_bien_vouloir_nous_envoyer_votre_meilleure_offre_de_prix_pour_l_achat_des_articles_suivants__Caption; Nous_vous_prions_de_bien_vouloir__CaptionLbl)
    //             {
    //             }
    //             column(ArticleCaption; ArticleCaptionLbl)
    //             {
    //             }
    //             column("QuantitéCaption"; QuantitéCaptionLbl)
    //             {
    //             }
    //             column("UnitéCaption"; UnitéCaptionLbl)
    //             {
    //             }
    //             column(Prix__HTVACaption; Prix__HTVACaptionLbl)
    //             {
    //             }
    //             column(RemiseCaption; RemiseCaptionLbl)
    //             {
    //             }
    //             column(TVACaption; TVACaptionLbl)
    //             {
    //             }
    //             column(Bien_cordialement__Le_directeur_d_achat__AYMEN_HACHICHACaption; Bien_cordialement__Le_directeur_d_achat__AYMEN_HACHICHACaptionLbl)
    //             {
    //             }
    //             column("N_B___Merci_de_nous_répondre_dans_le_plus_bref_delai_Caption"; N_B___Merci_de_nous_répondre_dans_le_plus_bref_delai_CaptionLbl)
    //             {
    //             }
    //             column(DataItem1000000020; Avenue_de_la_gare_Megrine_sorouLbl)
    //             {
    //             }
    //             column(Delai_Livraison__Caption; Delai_Livraison__CaptionLbl)
    //             {
    //             }
    //             column(EmptyStringCaption; EmptyStringCaptionLbl)
    //             {
    //             }
    //             column(Purchase_Line_Document_Type; "Document Type")
    //             {
    //             }
    //             column(Purchase_Line_Document_No_; "Document No.")
    //             {
    //             }
    //             column(Purchase_Line_Line_No_; "Line No.")
    //             {
    //             }

    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF "Rec-infosté".GET() THEN;
    //             IF "Rec-four".GET("Buy-from Vendor No.") THEN;
    //             IF "Rec-Salesperson/Purchaser".GET("Purchaser Code") THEN;

    //             IF RecEngin.GET("DataItem4458"."Engin") THEN;
    //             Desing := RecEngin.Désignation;
    //             immatr := RecEngin.Immatriculation;
    //             chassis := RecEngin."Num Châssis";
    //             marque := RecEngin.Marque;
    //             type := RecEngin.Type;
    //             //GL2024


    //             /*IF utilisateur.GET("Purchase Header"."User ID") THEN;
    //             Nom :=utilisateur.Name;*/
    //             IF CompanyI.GET THEN;


    //         end;

    //         trigger OnPreDataItem()
    //         var
    //         begin
    //             RecCompanyInfo.get();
    //             RecCompanyInfo.CalcFields(Picture);
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
    //     RecCompanyInfo: Record "Company Information";
    //     "Rec-infosté": Record 79;
    //     "Rec-four": Record 23;
    //     "Rec-Salesperson/Purchaser": Record 13;
    //     RecEngin: Record Véhicule;
    //     Desing: Text[100];
    //     immatr: Text[30];
    //     chassis: Text[30];
    //     marque: Text[30];
    //     type: Text[30];
    //     utilisateur: Record 50021;
    //     Nom: Text[50];
    //     CompanyI: Record 79;
    //     "Société_de_Routes_et_de_BatimentsCaptionLbl": Label 'Société de Routes et de Batiments';
    //     Megrine_Le__CaptionLbl: Label 'Megrine Le :';
    //     "A_L_attention_de_la_Société__CaptionLbl": Label 'A L''attention de la Société :';
    //     DEMANDE_DE_PRIX_No__CaptionLbl: Label 'DEMANDE DE PRIX No :';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508CaptionLbl: Label 'FAX-MESSAGE \ NOTRE FAX DIRECT : 71.429.508';
    //     Affaire_Suivie_par__CaptionLbl: Label 'Affaire Suivie par :';
    //     Numero_DA__CaptionLbl: Label 'Numero DA :';
    //     Vehicule__CaptionLbl: Label 'Vehicule :';
    //     No_Chassis__CaptionLbl: Label 'No Chassis :';
    //     Marque__CaptionLbl: Label 'Marque :';
    //     Type__CaptionLbl: Label 'Type :';
    //     FAX_MESSAGE___NOTRE_FAX_DIRECT___71_429_508Caption_Control1000000006Lbl: Label 'FAX-MESSAGE \ NOTRE FAX DIRECT : 71.429.508';
    //     "A_L_attention_de_la_Société__Caption_Control1000000007Lbl": Label 'A L''attention de la Société :';
    //     Megrine_Le__Caption_Control1000000008Lbl: Label 'Megrine Le :';
    //     DEMANDE_DE_PRIX_No__Caption_Control1000000019Lbl: Label 'DEMANDE DE PRIX No :';
    //     SOROUBATCaption_Control1000000001Lbl: Label 'SOROUBAT';
    //     Affaire_Suivie_par__Caption_Control1000000002Lbl: Label 'Affaire Suivie par :';
    //     Numero_DA__Caption_Control1000000003Lbl: Label 'Numero DA :';
    //     Vehicule__Caption_Control1000000004Lbl: Label 'Vehicule :';
    //     No_Chassis__Caption_Control1000000025Lbl: Label 'No Chassis :';
    //     Marque__Caption_Control1000000026Lbl: Label 'Marque :';
    //     Type__Caption_Control1000000028Lbl: Label 'Type :';
    //     "Société_de_Routes_et_de_BatimentsCaption_Control1000000016Lbl": Label 'Société de Routes et de Batiments';
    //     Nous_vous_prions_de_bien_vouloir__CaptionLbl: Label '** Nous vous prions de bien vouloir nous envoyer votre meilleure offre de prix pour l''achat des articles suivants :';
    //     ArticleCaptionLbl: Label 'Article';
    //     "QuantitéCaptionLbl": Label 'Quantité';
    //     "UnitéCaptionLbl": Label 'Unité';
    //     Prix__HTVACaptionLbl: Label 'Prix \HTVA';
    //     RemiseCaptionLbl: Label 'Remise';
    //     TVACaptionLbl: Label 'TVA';
    //     Bien_cordialement__Le_directeur_d_achat__AYMEN_HACHICHACaptionLbl: Label 'Bien cordialement \Le directeur d''achat \AYMEN HACHICHA';
    //     "N_B___Merci_de_nous_répondre_dans_le_plus_bref_delai_CaptionLbl": Label 'N.B.  Merci de nous répondre dans le plus bref delai.';
    //     "Avenue_de_la_gare_Megrine_sorouLbl": Label 'Avenue de la gare Megrine Riadh - 2014 BEN AROUS Tél.: +216 71 427 868 / +216 71 427 603 / Fax: +216 71 429 508E-Mail:  soroubat.directionachat@yahoo.fr / Site Web : www.groupesoroubat.com';
    //     Delai_Livraison__CaptionLbl: Label 'Delai Livraison :';
    //     EmptyStringCaptionLbl: Label '.......................................................................';
}

