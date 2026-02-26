// report 50045 "Etat Loyer"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/EtatLoyer.rdlc';

//     dataset
//     {
//         dataitem("Payment Header"; 10865)
//         {
//             RequestFilterFields = "No.";
//             column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
//             {
//             }
//             column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst)
//             {
//             }
//             column(Payment_Header__No__; "No.")
//             {
//             }
//             column(Payment_Header__Posting_Date_; "Posting Date")
//             {
//             }
//             column(ETAT_DE_PAIEMENT_DE_LOYERCaption; ETAT_DE_PAIEMENT_DE_LOYERCaptionLbl)
//             {
//             }
//             column(N__Loyer__Caption; N__Loyer__CaptionLbl)
//             {
//             }
//             column(Date_Loyer__Caption; Date_Loyer__CaptionLbl)
//             {
//             }
//             column(Payment_Line_DeductionCaption; "Payment Line".FIELDCAPTION(Deduction))
//             {
//             }
//             column(Payment_Line__Debit_Amount_Caption; "Payment Line".FIELDCAPTION("Debit Amount"))
//             {
//             }
//             column(Payment_Line__Montant_Initial_Caption; "Payment Line".FIELDCAPTION("Montant Initial"))
//             {
//             }
//             column(CommentaireCaption; CommentaireCaptionLbl)
//             {
//             }
//             column(FournisseurCaption; FournisseurCaptionLbl)
//             {
//             }
//             column(Payment_Line_ChantierCaption; "Payment Line".FIELDCAPTION(Chantier))
//             {
//             }
//             column("Service_Contrôle_de_GestionCaption"; Service_Contrôle_de_GestionCaptionLbl)
//             {
//             }
//             column(SOROUBATCaption; SOROUBATCaptionLbl)
//             {
//             }
//             column("N__PiéceCaption"; N__PiéceCaptionLbl)
//             {
//             }
//             dataitem("Payment Line"; 10866)
//             {
//                 DataItemLink = "No." = FIELD("No.");
//                 RequestFilterFields = "No.";
//                 column(Payment_Line_Chantier; Chantier)
//                 {
//                 }
//                 column(Payment_Line_Deduction; Deduction)
//                 {
//                 }
//                 column(Payment_Line__Debit_Amount_; "Debit Amount")
//                 {
//                 }
//                 column(Payment_Line__Montant_Initial_; "Montant Initial")
//                 {
//                 }
//                 column(Payment_Line__Drawee_Reference_2; "Drawee Reference")
//                 {
//                 }
//                 column(Payment_Line__Drawee_Reference_; "Drawee Reference Soroubat")
//                 {
//                 }
//                 column("Libellé"; "Libellé")
//                 {

//                 }
//                 column(Chant; Chant)
//                 {
//                 }
//                 column(Payment_Line__Payment_Line__Commentaires; "Payment Line".Commentaires)
//                 {
//                 }
//                 column(Payment_Line__External_Document_No__; "External Document No.")
//                 {
//                 }
//                 column(Total; Total)
//                 {
//                 }
//                 column(Total__Caption; Total__CaptionLbl)
//                 {
//                 }
//                 column(Payment_Line_No_; "No.")
//                 {
//                 }
//                 column(Payment_Line_Line_No_; "Line No.")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin

//                     // CurrReport.SHOWOUTPUT("Payment Line".Chantier<>'');
//                     Total += "Debit Amount";
//                     IF CHantierLoyer.GET("Payment Line".Chantier) THEN;
//                     Chant := CHantierLoyer.Description;
//                     "Payment Line".SETRANGE("Payment Line"."No.", "Payment Header"."No.");
//                 end;
//             }

//             trigger OnPreDataItem()
//             begin
//                 //ReqFilterFields("Payment Header"."No.");
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin

//         //"Payment Line".GETFILTER("No."):="Payment Header".GETFILTER("No.");;
//     end;

//     var
//         CHantierLoyer: Record 50039;
//         Chant: Text[30];
//         PageConst: Label 'Page :';
//         TotalFor: Label 'Total ';
//         Total: Decimal;
//         ETAT_DE_PAIEMENT_DE_LOYERCaptionLbl: Label 'ETAT DE PAIEMENT DE LOYER';
//         N__Loyer__CaptionLbl: Label 'N° Loyer :';
//         Date_Loyer__CaptionLbl: Label 'Date Loyer :';
//         CommentaireCaptionLbl: Label 'Commentaire';
//         FournisseurCaptionLbl: Label 'Fournisseur';
//         "Service_Contrôle_de_GestionCaptionLbl": Label 'Service Contrôle de Gestion';
//         SOROUBATCaptionLbl: Label 'SOROUBAT';
//         "N__PiéceCaptionLbl": Label 'N° Piéce';
//         Total__CaptionLbl: Label 'Total :';
// }