report 50216 "Bordereau des Effets Impayé"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereaudesEffetsImpayé.rdlc';

    // dataset
    // {
    //     dataitem("Payment Header"; 10865)
    //     {
    //         DataItemTableView = SORTING("No.")
    //                             WHERE("Payment Class" = FILTER('ENC-TRTREGIMPY'));
    //         RequestFilterFields = "No.";
    //         column(N________No__; 'N° :  ' + "No.")
    //         {
    //         }
    //         column(Payment_Header_Agence; Agence)
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(Adresse; Adresse)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(RIBBANK; RIBBANK)
    //         {
    //         }
    //         column(Banque; Banque)
    //         {
    //         }
    //         column(BORDEREAU_DES_EFFETS_IMPAYESCaption; BORDEREAU_DES_EFFETS_IMPAYESCaptionLbl)
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
    //         column("EchéanceCaption"; EchéanceCaptionLbl)
    //         {
    //         }
    //         column(A_L_ENCAISSEMENTCaption; A_L_ENCAISSEMENTCaptionLbl)
    //         {
    //         }
    //         column(A_L_ESCOMPTECaption; A_L_ESCOMPTECaptionLbl)
    //         {
    //         }
    //         column(AGENCE__Caption; AGENCE__CaptionLbl)
    //         {
    //         }
    //         column("Nom_Du_bénéficiaire__Caption"; Nom_Du_bénéficiaire__CaptionLbl)
    //         {
    //         }
    //         column(MEGRINE_LECaption; MEGRINE_LECaptionLbl)
    //         {
    //         }
    //         column(Adresse__Caption; Adresse__CaptionLbl)
    //         {
    //         }
    //         column(Compte_N___Caption; Compte_N___CaptionLbl)
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
    //     BORDEREAU_DES_EFFETS_IMPAYESCaptionLbl: Label 'BORDEREAU DES EFFETS IMPAYES';
    //     N__EFFET___Lieu_de_PaiementCaptionLbl: Label 'N° EFFET / Lieu de Paiement';
    //     "Nom_du_TiréCaptionLbl": Label 'Nom du Tiré';
    //     MontantCaptionLbl: Label 'Montant';
    //     "EchéanceCaptionLbl": Label 'Echéance';
    //     A_L_ENCAISSEMENTCaptionLbl: Label '*         A L''ENCAISSEMENT';
    //     A_L_ESCOMPTECaptionLbl: Label '*         A L''ESCOMPTE';
    //     AGENCE__CaptionLbl: Label 'AGENCE :';
    //     "Nom_Du_bénéficiaire__CaptionLbl": Label 'Nom Du bénéficiaire :';
    //     MEGRINE_LECaptionLbl: Label 'MEGRINE   LE';
    //     Adresse__CaptionLbl: Label 'Adresse :';
    //     Compte_N___CaptionLbl: Label 'Compte N° :';
    //     TOTAL_CaptionLbl: Label 'TOTAL ';
}

