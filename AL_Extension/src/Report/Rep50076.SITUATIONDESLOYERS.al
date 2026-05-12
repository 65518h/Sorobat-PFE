report 50076 "SITUATION DES LOYERS"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/SITUATIONDESLOYERS.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'SITUATION DES LOYERS';
    // dataset
    // {
    //     dataitem("Payment Line"; 10866)
    //     {
    //         DataItemTableView = SORTING("Account No.", Appartement, "Date Loyer")
    //                             ORDER(Ascending)
    //                             WHERE(Posted = FILTER(false),
    //                                   Chantier = FILTER(<> ''));
    //         RequestFilterFields = Chantier, "Account Type", "Account No.";
    //         column(Payment_Line__Account_No__; "Account No.")
    //         {
    //         }
    //         column(Payment_Line_Chantier; Chantier)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(NomChantier; NomChantier)
    //         {
    //         }
    //         column("Payment_Line__Payment_Line__Libellé"; "Payment Line".Libellé)
    //         {
    //         }
    //         column(Payment_Line__Date_Loyer_; "Date Loyer")
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount_; "Debit Amount")
    //         {
    //         }
    //         column(Payment_Line_Commentaires; Commentaires)
    //         {
    //         }
    //         column(Payment_Line_Deduction; Deduction)
    //         {
    //         }
    //         column(Payment_Line_Appartement; Appartement)
    //         {
    //         }
    //         column(Payment_Line__Payment_Line___No__; "Payment Line"."No.")
    //         {
    //         }
    //         column(Nature; Nature)
    //         {
    //         }
    //         column(Folio; Folio)
    //         {
    //         }
    //         column(Payment_Line__External_Document_No__; "External Document No.")
    //         {
    //         }
    //         column(Payment_Line__Compte_Bancaire_; "Compte Bancaire")
    //         {
    //         }
    //         column(RecLoyer__Date_Debut_; RecLoyer."Date Debut")
    //         {
    //         }
    //         column(Payment_Line__Status_Name_; "Status Name")
    //         {
    //         }
    //         column(TotalFor___FIELDCAPTION__Account_No___; TotalFor + FIELDCAPTION("Account No."))
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount__Control1000000039; "Debit Amount")
    //         {
    //         }
    //         column(N__compte__Caption; N__compte__CaptionLbl)
    //         {
    //         }
    //         column(Chantier__Caption; Chantier__CaptionLbl)
    //         {
    //         }
    //         column(SITUATION_DES_LOYERSCaption; SITUATION_DES_LOYERSCaptionLbl)
    //         {
    //         }
    //         column("Propriétaire__Caption"; Propriétaire__CaptionLbl)
    //         {
    //         }
    //         column(NatureCaption; NatureCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line__Date_Loyer_Caption; FIELDCAPTION("Date Loyer"))
    //         {
    //         }
    //         column(Payment_Line_AppartementCaption; FIELDCAPTION(Appartement))
    //         {
    //         }
    //         column(Payment_Line_CommentairesCaption; FIELDCAPTION(Commentaires))
    //         {
    //         }
    //         column(Payment_Line_DeductionCaption; FIELDCAPTION(Deduction))
    //         {
    //         }
    //         column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
    //         {
    //         }
    //         column("N__RéglementCaption"; N__RéglementCaptionLbl)
    //         {
    //         }
    //         column(N__FolioCaption; N__FolioCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line__External_Document_No__Caption; External_Document)
    //         {
    //         }
    //         column(Payment_Line__Compte_Bancaire_Caption; FIELDCAPTION("Compte Bancaire"))
    //         {
    //         }
    //         column(Date_DebutCaption; Date_DebutCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line__Status_Name_Caption; FIELDCAPTION("Status Name"))
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             Folio := '';
    //             RecPaymentLine2.RESET;
    //             IF RecPaymentLine2.GET("Payment Line"."Copied To No.", 10000) THEN BEGIN
    //                 RecPaymentLine2.CALCFIELDS("Folio N°");
    //                 Folio := RecPaymentLine2."Folio N°";
    //             END;
    //             //RecPaymentLine2.SETRANGE("No.","Payment Line"."Copied To No.");
    //             //RecLoyer.SETRANGE(Proprietaire,"Account No.");
    //             IF RecLoyer.GET(Chantier, "Account No.", Appartement) THEN;



    //             IF RecChantier.GET("Payment Line".Chantier) THEN;
    //             NomChantier := RecChantier.Description;


    //             IF "Payment Line".Commentaires = 'CAUTION' THEN
    //                 Nature := 'Caution'
    //             ELSE
    //                 Nature := 'Mensualité';
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Account No.");
    //         end;
    //     }
    //     dataitem(Loyer; 50024)
    //     {
    //         DataItemTableView = SORTING(Chantier, Proprietaire, "Code Appartement")
    //                             WHERE("Fin Contrat" = CONST(true));

    //         trigger OnPreDataItem()
    //         begin

    //             Loyer.SETRANGE(Proprietaire, "Payment Line"."Account No.");
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
    //     TotalFor: Label 'Total ';
    //     NomChantier: Text[100];
    //     RecChantier: Record 50039;
    //     Nature: Text[30];
    //     RecPaymentLine2: Record 10866;
    //     Folio: Code[20];
    //     RecLoyer: Record 50024;
    //     N__compte__CaptionLbl: Label 'N° compte :';
    //     Chantier__CaptionLbl: Label 'Chantier =';
    //     SITUATION_DES_LOYERSCaptionLbl: Label 'SITUATION DES LOYERS';
    //     "Propriétaire__CaptionLbl": Label 'Propriétaire :';
    //     NatureCaptionLbl: Label 'Nature';
    //     "Net_à_PayerCaptionLbl": Label 'Net à Payer';
    //     "N__RéglementCaptionLbl": Label 'N° Réglement';
    //     N__FolioCaptionLbl: Label 'N° Folio';
    //     Date_DebutCaptionLbl: Label 'Date Debut';
    //     External_Document: label 'N° Piece de Paiement';
}

