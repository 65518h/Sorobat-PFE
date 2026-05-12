report 50215 "Bordereau des Cheque Impayé"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereaudesChequeImpayé.rdlc';

    // dataset
    // {
    //     dataitem("Payment Header"; 10865)
    //     {
    //         DataItemTableView = SORTING("No.")
    //                             WHERE("Payment Class" = FILTER('ENC-CHQREGIMPY'));
    //         RequestFilterFields = "No.";
    //         column(RIBBANK; RIBBANK)
    //         {
    //         }
    //         column(Adresse; Adresse)
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Payment_Header_Agence; Agence)
    //         {
    //         }
    //         column(N________No__; 'N° :  ' + "No.")
    //         {
    //         }
    //         column(Banque; Banque)
    //         {
    //         }
    //         column(N________No___Control1000000006; 'N° :  ' + "No.")
    //         {
    //         }
    //         column("Nous_vous_informons_que_nous_portons_au_crédit_de_votre_compte_le_montant_des_chèques_suivants_sauf_bonne_finCaption"; Nous_vous_informons_que_nous_portons_au_crédit)
    //         {
    //         }
    //         column(Compte_N___Caption; Compte_N___CaptionLbl)
    //         {
    //         }
    //         column(Raison_SocialCaption; Raison_SocialCaptionLbl)
    //         {
    //         }
    //         column(LECaption; LECaptionLbl)
    //         {
    //         }
    //         column(BORDEREAU_DE_VERSEMENT_DES_CHEQUESCaption; BORDEREAU_DE_VERSEMENT_DES_CHEQUESCaptionLbl)
    //         {
    //         }
    //         column(AGENCE__Caption; AGENCE__CaptionLbl)
    //         {
    //         }
    //         column(AdresseCaption; AdresseCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column("EchéanceCaption"; EchéanceCaptionLbl)
    //         {
    //         }
    //         column(N__EFFET___Lieu_de_PaiementCaption; N__EFFET___Lieu_de_PaiementCaptionLbl)
    //         {
    //         }
    //         column("Nom_du_TiréCaption"; Nom_du_TiréCaptionLbl)
    //         {
    //         }
    //         column(BORDEREAU_DES_CHEQUES_IMPAYESCaption; BORDEREAU_DES_CHEQUES_IMPAYESCaptionLbl)
    //         {
    //         }
    //         column(N__EFFET___Lieu_de_PaiementCaption_Control1000000022; N__EFFET___Lieu_de_PaiementCaption_Control1000000022Lbl)
    //         {
    //         }
    //         column("Nom_du_TiréCaption_Control1000000023"; Nom_du_TiréCaption_Control1000000023Lbl)
    //         {
    //         }
    //         column(MontantCaption_Control1000000024; MontantCaption_Control1000000024Lbl)
    //         {
    //         }
    //         column("EchéanceCaption_Control1000000030"; EchéanceCaption_Control1000000030Lbl)
    //         {
    //         }
    //         column(Payment_Header_No_; "No.")
    //         {
    //         }
    //         dataitem("Payment Line"; 10866)
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", "Line No.");
    //             column(ABS_Amount_; ABS(Amount))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column("Payment_Line_Libellé"; Libellé)
    //             {
    //             }
    //             column(Payment_Line__External_Document_No__; "External Document No.")
    //             {
    //             }
    //             column(Payment_Line__Payment_Line___Due_Date_; "Payment Line"."Due Date")
    //             {
    //                 // DecimalPlaces = 3:3;
    //             }
    //             column(ABS_Total_; ABS(Total))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(TOTAL_Caption; TOTAL_CaptionLbl)
    //             {
    //             }
    //             column(Signature_du_responsable_et_cachet_de_l_agenceCaption; Signature_du_responsable_et_cachet_de_l_agenceCaptionLbl)
    //             {
    //             }
    //             column(Signature_de_la_partie_versanteCaption; Signature_de_la_partie_versanteCaptionLbl)
    //             {
    //             }
    //             column(Payment_Line_No_; "No.")
    //             {
    //             }
    //             column(Payment_Line_Line_No_; "Line No.")
    //             {
    //             }
    //             column(Payment_Line_Amount; Amount)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin
    //                 Total := Total + Amount;
    //                 IF BankAccount.GET("Payment Line"."Compte Bancaire") THEN;
    //                 Banque := BankAccount.Banque;
    //             end;
    //         }
    //         trigger OnAfterGetRecord()
    //         begin
    //             IF CompanyInformation.GET() THEN;
    //             Adresse := CompanyInformation."Address 2";
    //             IF BankAccount.GET("Payment Header"."Account No.") THEN;
    //             RIBBANK := BankAccount.RIB;
    //             Agence := BankAccount.City;
    //             Banque := FORMAT(BankAccount.Banque);
    //             Total := 0;

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("No.");
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
    //     CompanyInformation: Record 79;
    //     Adresse: Text[100];
    //     BankAccount: Record 270;
    //     RIBBANK: Text[100];
    //     Total: Decimal;
    //     Banque: Text[30];
    //     Agence: Text[100];
    //     "Nous_vous_informons_que_nous_portons_au_crédit": Label 'Nous vous informons que nous portons au crédit de votre compte le montant des chèques suivants sauf bonne fin';
    //     Compte_N___CaptionLbl: Label 'Compte N° :';
    //     Raison_SocialCaptionLbl: Label 'Raison Social';
    //     LECaptionLbl: Label 'LE';
    //     BORDEREAU_DE_VERSEMENT_DES_CHEQUESCaptionLbl: Label 'BORDEREAU DE VERSEMENT DES CHEQUES';
    //     AGENCE__CaptionLbl: Label 'AGENCE :';
    //     AdresseCaptionLbl: Label 'Adresse';
    //     MontantCaptionLbl: Label 'Montant';
    //     "EchéanceCaptionLbl": Label 'Echéance';
    //     N__EFFET___Lieu_de_PaiementCaptionLbl: Label 'N° EFFET / Lieu de Paiement';
    //     "Nom_du_TiréCaptionLbl": Label 'Nom du Tiré';
    //     BORDEREAU_DES_CHEQUES_IMPAYESCaptionLbl: Label 'BORDEREAU DES CHEQUES IMPAYES';
    //     N__EFFET___Lieu_de_PaiementCaption_Control1000000022Lbl: Label 'N° EFFET / Lieu de Paiement';
    //     "Nom_du_TiréCaption_Control1000000023Lbl": Label 'Nom du Tiré';
    //     MontantCaption_Control1000000024Lbl: Label 'Montant';
    //     "EchéanceCaption_Control1000000030Lbl": Label 'Echéance';
    //     TOTAL_CaptionLbl: Label 'TOTAL ';
    //     Signature_du_responsable_et_cachet_de_l_agenceCaptionLbl: Label 'Signature du responsable et cachet de l''agence';
    //     Signature_de_la_partie_versanteCaptionLbl: Label 'Signature de la partie versante';
}

