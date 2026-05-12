report 50185 "Bordereau de Remise Effet 1"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereaudeRemiseEffet1.rdlc';

    // dataset
    // {
    //     dataitem("Payment Header"; 10865)
    //     {
    //         DataItemTableView = SORTING("No.")
    //                             WHERE("Payment Class" = FILTER('ENC-TRAITE'),
    //                                   "Status No." = FILTER(>= 16000));
    //         RequestFilterFields = "No.";
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Adresse; Adresse)
    //         {
    //         }
    //         column(RIBBANK; RIBBANK)
    //         {
    //         }
    //         column(Payment_Header_Agence; Agence)
    //         {
    //         }
    //         column(Banque; Banque)
    //         {
    //         }
    //         column(N________No__; 'N° :  ' + "No.")
    //         {
    //         }
    //         column(BORDEREAU_DE_REMISE_EFFETSCaption; BORDEREAU_DE_REMISE_EFFETSCaptionLbl)
    //         {
    //         }
    //         column(AGENCE__Caption; AGENCE__CaptionLbl)
    //         {
    //         }
    //         column("Nom_Du_bénéficiaire__Caption"; Nom_Du_bénéficiaire__CaptionLbl)
    //         {
    //         }
    //         column(Adresse__Caption; Adresse__CaptionLbl)
    //         {
    //         }
    //         column(MEGRINE_LECaption; MEGRINE_LECaptionLbl)
    //         {
    //         }
    //         column(Compte_N___Caption; Compte_N___CaptionLbl)
    //         {
    //         }
    //         column(N__EFFET___Lieu_de_PaiementCaption; N__EFFET___Lieu_de_PaiementCaptionLbl)
    //         {
    //         }
    //         column("Nom_du_TiréCaption"; Nom_du_TiréCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(A_L_ENCAISSEMENTCaption; A_L_ENCAISSEMENTCaptionLbl)
    //         {
    //         }
    //         column(A_L_ESCOMPTECaption; A_L_ESCOMPTECaptionLbl)
    //         {
    //         }
    //         column("EchéanceCaption"; EchéanceCaptionLbl)
    //         {
    //         }
    //         column(Signature_de_la_partie_versanteCaption; Signature_de_la_partie_versanteCaptionLbl)
    //         {
    //         }
    //         column(Signature_du_responsable_et_cachet_de_l_agenceCaption; Signature_du_responsable_et_cachet_de_l_agenceCaptionLbl)
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
    //                 "Payment Line"."Type Remise" := "Payment Line"."Type Remise"::"a l'encaissement";
    //                 "Payment Line".MODIFY;

    //                 IF BankAccount.GET("Payment Line"."Compte Bancaire") THEN;
    //                 Banque := BankAccount.Banque;

    //                 Total := Total + Amount;
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
    //     BORDEREAU_DE_REMISE_EFFETSCaptionLbl: Label 'BORDEREAU DE REMISE EFFETS';
    //     AGENCE__CaptionLbl: Label 'AGENCE :';
    //     "Nom_Du_bénéficiaire__CaptionLbl": Label 'Nom Du bénéficiaire :';
    //     Adresse__CaptionLbl: Label 'Adresse :';
    //     MEGRINE_LECaptionLbl: Label 'MEGRINE LE';
    //     Compte_N___CaptionLbl: Label 'Compte N° :';
    //     N__EFFET___Lieu_de_PaiementCaptionLbl: Label 'N° EFFET / Lieu de Paiement';
    //     "Nom_du_TiréCaptionLbl": Label 'Nom du Tiré';
    //     MontantCaptionLbl: Label 'Montant';
    //     A_L_ENCAISSEMENTCaptionLbl: Label '*         A L''ENCAISSEMENT';
    //     A_L_ESCOMPTECaptionLbl: Label '*         A L''ESCOMPTE';
    //     "EchéanceCaptionLbl": Label 'Echéance';
    //     Signature_de_la_partie_versanteCaptionLbl: Label 'Signature de la partie versante';
    //     Signature_du_responsable_et_cachet_de_l_agenceCaptionLbl: Label 'Signature du responsable et cachet de l''agence';
    //     TOTAL_CaptionLbl: Label 'TOTAL ';
}

