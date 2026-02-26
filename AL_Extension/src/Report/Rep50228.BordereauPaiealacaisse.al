report 50228 "Bordereau Paie a la caisse"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereauPaiealacaisse.rdlc';

    // dataset
    // {
    //     dataitem("Payment Line"; "Payment Line")
    //     {
    //         DataItemTableView = SORTING("No.", "Line No.")
    //                             WHERE("Code Opération" = CONST('P1'));
    //         RequestFilterFields = "No.", Affect, "Type Caisse";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("Date_Journée______Journecaisse"; 'Date Journée :  ' + Journecaisse)
    //         {
    //         }
    //         column("Journée_de_caisse_n_________No__"; 'Journée de caisse n° :   ' + "No.")
    //         {
    //         }
    //         column(Payment_Line__Payment_Line___Nom_Benificiaire_; "Payment Line"."Nom Benificiaire")
    //         {
    //         }
    //         column(Payment_Line__Payment_Line___Credit_Amount_; "Payment Line"."Credit Amount")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Payment_Line_Benificiaire; Benificiaire)
    //         {
    //         }
    //         column(Payment_Line__Payment_Line___Designation_Affectation_; "Payment Line"."Designation Affectation")
    //         {
    //         }
    //         column(TotalMantant; TotalMantant)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Nbre______FORMAT__Nbre_; 'Nbre :  ' + FORMAT(Nbre))
    //         {
    //             //DecimalPlaces = 3 : 3;
    //         }
    //         column(Payment_Line__Payment_Line___Nom_Receptionneur_; "Payment Line"."Nom Receptionneur")
    //         {
    //             //DecimalPlaces = 3 : 3;
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
    //         {
    //         }
    //         column(EmargementCaption; EmargementCaptionLbl)
    //         {
    //         }
    //         column(Bordereau_de_PaieCaption; Bordereau_de_PaieCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(Total_Mantant__Caption; Total_Mantant__CaptionLbl)
    //         {
    //         }
    //         column(Signature_CaissierCaption; Signature_CaissierCaptionLbl)
    //         {
    //         }
    //         column(Signature_ReceptionneurCaption; Signature_ReceptionneurCaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin

    //             Cumul += Amount;
    //             TotalMantant := TotalMantant + "Payment Line"."Credit Amount";
    //             Nbre := Nbre + 1;

    //             PaymentHeader.RESET;
    //             PaymentHeader.SETRANGE(PaymentHeader."No.", "Payment Line"."No.");
    //             IF PaymentHeader.FINDFIRST THEN Journecaisse := FORMAT(PaymentHeader."Document Date");
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("No.");
    //             CurrReport.CREATETOTALS("Payment Line"."Credit Amount", "Payment Line"."Debit Amount");
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
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Cumul: Decimal;
    //     PaymentHeader: Record 10865;
    //     Journecaisse: Text[30];
    //     Extracomptable: Text[50];
    //     TotalMantant: Decimal;
    //     Nbre: Integer;
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     "Net_à_PayerCaptionLbl": Label 'Net à Payer';
    //     EmargementCaptionLbl: Label 'Emargement';
    //     Bordereau_de_PaieCaptionLbl: Label 'Bordereau de Paie';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     Total_Mantant__CaptionLbl: Label 'Total Mantant :';
    //     Signature_CaissierCaptionLbl: Label 'Signature Caissier';
    //     Signature_ReceptionneurCaptionLbl: Label 'Signature Receptionneur';
}

