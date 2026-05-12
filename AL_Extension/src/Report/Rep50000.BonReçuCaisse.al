report 50000 "Bureau Ordre"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BonReçuCaisse.rdlc';

    // dataset
    // {
    //     dataitem("Payment Line"; 10866)
    //     {
    //         DataItemTableView = SORTING("No.", "Line No.");
    //         RequestFilterFields = "No.";
    //         column(CompanyPicture; RecCompnyInfo.Picture) { }
    //         column(Credit_Amount___Debit_Amount_; "Credit Amount" + "Debit Amount")
    //         {
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
    //         column(FORMAT_TODAY_0_4__Control1000000025; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Payment_Line_Motif; Motif)
    //         {
    //         }
    //         column("Payment_Line_Libellé"; Libellé)
    //         {
    //         }
    //         column(Payment_Line__Nom_Benificiaire__Control1000000035; "Nom Benificiaire")
    //         {
    //         }
    //         column(Payment_Line_Benificiaire_Control1000000036; Benificiaire)
    //         {
    //         }
    //         column(Credit_Amount___Debit_Amount__Control1000000037; "Credit Amount" + "Debit Amount")
    //         {
    //         }
    //         column("Payment_Line_Libellé_Control1000000038"; Libellé)
    //         {
    //         }
    //         column(Payment_Line_Motif_Control1000000039; Motif)
    //         {
    //         }
    //         column(Numero_Bon__________Numero_Seq__Control1000000046; 'Numero Bon :     ' + "Numero Seq")
    //         {
    //         }
    //         column(Montant__Caption; Montant__CaptionLbl)
    //         {
    //         }
    //         column(Payment_LineCaption; Payment_LineCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_Prénom__Caption"; Nom_et_Prénom__CaptionLbl)
    //         {
    //         }
    //         column(Matricule__Caption; Matricule__CaptionLbl)
    //         {
    //         }
    //         column("Signature_BénificiaireCaption"; Signature_BénificiaireCaptionLbl)
    //         {
    //         }
    //         column(Signature_CaissierCaption; Signature_CaissierCaptionLbl)
    //         {
    //         }
    //         column(Signature_CaissierCaption_Control1000000012; Signature_CaissierCaption_Control1000000012Lbl)
    //         {
    //         }
    //         column("Signature_BénificiaireCaption_Control1000000016"; Signature_BénificiaireCaption_Control1000000016Lbl)
    //         {
    //         }
    //         column(EmptyStringCaption; EmptyStringCaptionLbl)
    //         {
    //         }
    //         column(MOIS_DECaption; MOIS_DECaptionLbl)
    //         {
    //         }
    //         column(Motif__Caption; Motif__CaptionLbl)
    //         {
    //         }
    //         column("Libellé__Caption"; Libellé__CaptionLbl)
    //         {
    //         }
    //         column("Nom_et_Prénom__Caption_Control1000000040"; Nom_et_Prénom__Caption_Control1000000040Lbl)
    //         {
    //         }
    //         column(Montant__Caption_Control1000000041; Montant__Caption_Control1000000041Lbl)
    //         {
    //         }
    //         column(Matricule__Caption_Control1000000042; Matricule__Caption_Control1000000042Lbl)
    //         {
    //         }
    //         column(Motif__Caption_Control1000000043; Motif__Caption_Control1000000043Lbl)
    //         {
    //         }
    //         column("Libellé__Caption_Control1000000044"; Libellé__Caption_Control1000000044Lbl)
    //         {
    //         }
    //         column(Payment_LineCaption_Control1000000045; Payment_LineCaption_Control1000000045Lbl)
    //         {
    //         }
    //         column(MOIS_DECaption_Control1000000047; MOIS_DECaption_Control1000000047Lbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }

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
    //     Montant__CaptionLbl: Label 'Montant :';
    //     Payment_LineCaptionLbl: Label 'Ligne bordereau';
    //     "Nom_et_Prénom__CaptionLbl": Label 'Nom et Prénom :';
    //     Matricule__CaptionLbl: Label 'Matricule :';
    //     "Signature_BénificiaireCaptionLbl": Label 'Signature Bénificiaire';
    //     Signature_CaissierCaptionLbl: Label 'Signature Caissier';
    //     Signature_CaissierCaption_Control1000000012Lbl: Label 'Signature Caissier';
    //     "Signature_BénificiaireCaption_Control1000000016Lbl": Label 'Signature Bénificiaire';
    //     EmptyStringCaptionLbl: Label '-';
    //     MOIS_DECaptionLbl: Label 'MOIS DE  . . . . . . . . . . . . . . . . . . . . . . . . . .';
    //     Motif__CaptionLbl: Label 'Motif :';
    //     "Libellé__CaptionLbl": Label 'Libellé :';
    //     "Nom_et_Prénom__Caption_Control1000000040Lbl": Label 'Nom et Prénom :';
    //     Montant__Caption_Control1000000041Lbl: Label 'Montant :';
    //     Matricule__Caption_Control1000000042Lbl: Label 'Matricule :';
    //     Motif__Caption_Control1000000043Lbl: Label 'Motif :';
    //     "Libellé__Caption_Control1000000044Lbl": Label 'Libellé :';
    //     Payment_LineCaption_Control1000000045Lbl: Label 'Payment Line';
    //     MOIS_DECaption_Control1000000047Lbl: Label 'MOIS DE';
}

