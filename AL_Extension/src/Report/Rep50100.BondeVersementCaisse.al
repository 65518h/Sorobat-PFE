report 50100 "Bon de Versement Caisse"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BondeVersementCaisse.rdlc';

    // dataset
    // {
    //     dataitem(DataItem3474; 10866)
    //     {
    //         DataItemTableView = SORTING("No.", "Line No.");
    //         RequestFilterFields = "No.";
    //         column(CompanyPicture; RecCompnyInfo.Picture) { }
    //         column(Credit_Amount___Debit_Amount_; "Credit Amount" + "Debit Amount")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Numero_Bon__________Numero_Seq_; 'Numero Bon :     ' + "Numero Seq")
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Payment_Line__Nom_Benificiaire_; "Nom Benificiaire")
    //         {
    //         }
    //         column(Payment_Line_Benificiaire; Benificiaire)
    //         {
    //         }
    //         column(LibelleCaisse; LibelleCaisse)
    //         {
    //         }
    //         column(STR; STR)
    //         {
    //         }
    //         column(Payment_Line__Due_Date_; "Due Date")
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(Payment_LineCaption; Payment_LineCaptionLbl)
    //         {
    //         }
    //         column(Nom__Caption; Nom__CaptionLbl)
    //         {
    //         }
    //         column("Qualité__Caption"; Qualité__CaptionLbl)
    //         {
    //         }
    //         column(Le_DirecteurCaption; Le_DirecteurCaptionLbl)
    //         {
    //         }
    //         column(Le_CaissierCaption; Le_CaissierCaptionLbl)
    //         {
    //         }
    //         column(MOTIF_DU_VERSEMENTCaption; MOTIF_DU_VERSEMENTCaptionLbl)
    //         {
    //         }
    //         column(Montant_en_lettres__Caption; Montant_en_lettres__CaptionLbl)
    //         {
    //         }
    //         column("Le_ContrôleurCaption"; Le_ContrôleurCaptionLbl)
    //         {
    //         }
    //         column(DateCaption; DateCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             STR := '';
    //             Convert."Montant en texte"(STR, Amount);
    //             IF ("Code Opération" = '1') OR ("Code Opération" = '00') OR ("Code Opération" = '00X') THEN
    //                 LibelleCaisse := 'ALIMENTATION CAISSE :  ' + Libellé
    //             ELSE
    //                 LibelleCaisse := Libellé;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("No.");
    //             RecCompnyInfo.get();
    //             RecCompnyInfo.CalcFields(Picture);
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
    //     RecCompnyInfo: Record "Company Information";
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Convert: Codeunit 50005;
    //     STR: Text[500];
    //     LibelleCaisse: Text[500];
    //     MontantCaptionLbl: Label 'Montant';
    //     Payment_LineCaptionLbl: Label 'Ligne bordereau';
    //     Nom__CaptionLbl: Label 'Nom :';
    //     "Qualité__CaptionLbl": Label 'Qualité :';
    //     Le_DirecteurCaptionLbl: Label 'Le Directeur';
    //     Le_CaissierCaptionLbl: Label 'Le Caissier';
    //     MOTIF_DU_VERSEMENTCaptionLbl: Label 'MOTIF DU VERSEMENT';
    //     Montant_en_lettres__CaptionLbl: Label 'Montant en lettres :';
    //     "Le_ContrôleurCaptionLbl": Label 'Le Contrôleur';
    //     DateCaptionLbl: Label 'Date';
}

