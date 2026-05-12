report 50214 "Bon Provisoire"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BonProvisoire.rdlc';

    // dataset
    // {
    //     dataitem("Payment Line"; "Payment Line")
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
    //         column(Credit_Amount___Debit_Amount__Control1000000013; "Credit Amount" + "Debit Amount")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Payment_Line_Benificiaire_Control1000000018; Benificiaire)
    //         {
    //         }
    //         column(Payment_Line__Nom_Benificiaire__Control1000000019; "Nom Benificiaire")
    //         {
    //         }
    //         column(Numero_Bon__________Numero_Seq__Control1000000020; 'Numero Bon :     ' + "Numero Seq")
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4__Control1000000025; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("Payment_Line_Libellé"; Libellé)
    //         {
    //         }
    //         column("Payment_Line_Libellé_Control1000000028"; Libellé)
    //         {
    //         }
    //         column(Payment_Line_Commentaires; Commentaires)
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
    //         column(Payment_LineCaption_Control1000000021; Payment_LineCaption_Control1000000021Lbl)
    //         {
    //         }
    //         column("Nom_et_Prénom__Caption_Control1000000023"; Nom_et_Prénom__Caption_Control1000000023Lbl)
    //         {
    //         }
    //         column(Montant__Caption_Control1000000026; Montant__Caption_Control1000000026Lbl)
    //         {
    //         }
    //         column(Matricule__Caption_Control1000000027; Matricule__Caption_Control1000000027Lbl)
    //         {
    //         }
    //         column(EmptyStringCaption; EmptyStringCaptionLbl)
    //         {
    //         }
    //         column(Motif__Caption; Motif__CaptionLbl)
    //         {
    //         }
    //         column(Motif__Caption_Control1000000030; Motif__Caption_Control1000000030Lbl)
    //         {
    //         }
    //         column(lesPoints; Point)
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
    //     Payment_LineCaption_Control1000000021Lbl: Label 'Payment Line';
    //     "Nom_et_Prénom__Caption_Control1000000023Lbl": Label 'Nom et Prénom :';
    //     Montant__Caption_Control1000000026Lbl: Label 'Montant :';
    //     Matricule__Caption_Control1000000027Lbl: Label 'Matricule :';
    //     EmptyStringCaptionLbl: Label '-';
    //     Motif__CaptionLbl: Label 'Motif :';
    //     Motif__Caption_Control1000000030Lbl: Label 'Motif :';
    //     Point: Label '....................';
}

