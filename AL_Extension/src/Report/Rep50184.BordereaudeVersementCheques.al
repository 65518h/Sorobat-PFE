report 50184 "Bordereau de Versement Cheques"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereaudeVersementCheques.rdlc';

    // dataset
    // {
    //     dataitem("Payment Header"; 10865)
    //     {
    //         DataItemTableView = SORTING("No.")
    //                             WHERE("Payment Class" = FILTER('ENC-CHEQUE'));
    //         RequestFilterFields = "No.";
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(N________No__; 'N° :  ' + "No.")
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
    //         column(BORDEREAU_DE_VERSEMENT_CHEQUESCaption; BORDEREAU_DE_VERSEMENT_CHEQUESCaptionLbl)
    //         {
    //         }
    //         column(AGENCE__Caption; AGENCE__CaptionLbl)
    //         {
    //         }
    //         column(Raison_SocialCaption; Raison_SocialCaptionLbl)
    //         {
    //         }
    //         column(AdresseCaption; AdresseCaptionLbl)
    //         {
    //         }
    //         column(LECaption; LECaptionLbl)
    //         {
    //         }
    //         column("Nous_vous_informons_que_nous_portons_au_crédit_de_votre_compte_le_montant_des_chèques_suivants_sauf_bonne_finCaption"; Nous_vous_informons_que_nous_portons_au_crédit)
    //         {
    //         }
    //         column(Compte_N___Caption; Compte_N___CaptionLbl)
    //         {
    //         }
    //         column("N__de_Chèque_____BanqueCaption"; N__de_Chèque_____BanqueCaptionLbl)
    //         {
    //         }
    //         column(TireurCaption; TireurCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
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
    //     BORDEREAU_DE_VERSEMENT_CHEQUESCaptionLbl: Label 'BORDEREAU DE VERSEMENT CHEQUES';
    //     AGENCE__CaptionLbl: Label 'AGENCE :';
    //     Raison_SocialCaptionLbl: Label 'Raison Social';
    //     AdresseCaptionLbl: Label 'Adresse';
    //     LECaptionLbl: Label 'LE';
    //     "Nous_vous_informons_que_nous_portons_au_crédit": Label 'Nous vous informons que nous portons au crédit de votre compte le montant des chèques suivants sauf bonne fin';
    //     Compte_N___CaptionLbl: Label 'Compte N° :';
    //     "N__de_Chèque_____BanqueCaptionLbl": Label 'N° de Chèque  /  Banque';
    //     TireurCaptionLbl: Label 'Tireur';
    //     MontantCaptionLbl: Label 'Montant';
    //     Signature_de_la_partie_versanteCaptionLbl: Label 'Signature de la partie versante';
    //     Signature_du_responsable_et_cachet_de_l_agenceCaptionLbl: Label 'Signature du responsable et cachet de l''agence';
    //     TOTAL_CaptionLbl: Label 'TOTAL ';
}

