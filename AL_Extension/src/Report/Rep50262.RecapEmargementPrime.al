report 50262 "Recap Emargement Prime"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapEmargementPrime.rdlc';

    // dataset
    // {
    //     dataitem(Notes; 52048938)
    //     {
    //         DataItemTableView = SORTING(Affectation, Année, Matricule)
    //                             WHERE(Note = FILTER(> 0),
    //                                   Payé = FILTER(False));
    //         RequestFilterFields = Affectation, "Année", "Nbre Fiche";
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("RECAP_AVANCE_SUR_PRIME_DE_RENDEMENT___GETFILTER_Notes_Année_"; 'RECAP AVANCE SUR PRIME DE RENDEMENT ' + GETFILTER(Notes.Année))
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO__Control1000000002; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME_Control1000000003; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4__Control1000000004; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("RECAP_PRIME_DE_RENDEMENT___GETFILTER_Notes_Année_"; 'RECAP PRIME DE RENDEMENT ' + GETFILTER(Notes.Année))
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(Notes__Avance_sur_Prime_; "Avance sur Prime")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Notes__Description_Affectation_; "Description Affectation")
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(Notes__Montant_Prime_Base_calcul_; "Montant Prime Base calcul")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Notes__Description_Affectation__Control1000000016; "Description Affectation")
    //         {
    //         }
    //         column(Nbre_Control1000000035; Nbre)
    //         {
    //         }
    //         column(TotalAvancePrime; TotalAvancePrime)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(NbreTotal; NbreTotal)
    //         {
    //         }
    //         column(TiotalPrime; TiotalPrime)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(NbreTotal_Control1000000037; NbreTotal)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(Total_Montant_Avance_sur_PrimeCaption; Total_Montant_Avance_sur_PrimeCaptionLbl)
    //         {
    //         }
    //         column(NbreCaption; NbreCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption_Control1000000010; AffectationCaption_Control1000000010Lbl)
    //         {
    //         }
    //         column(Total_Montant_PrimeCaption; Total_Montant_PrimeCaptionLbl)
    //         {
    //         }
    //         column(NbreCaption_Control1000000032; NbreCaption_Control1000000032Lbl)
    //         {
    //         }
    //         column(TOTALS__Caption; TOTALS__CaptionLbl)
    //         {
    //         }
    //         column(TOTALS__Caption_Control1000000001; TOTALS__Caption_Control1000000001Lbl)
    //         {
    //         }
    //         column("Notes_Année"; Année)
    //         {
    //         }
    //         column(Notes_Matricule; Matricule)
    //         {
    //         }
    //         column(Notes_Affectation; Affectation)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin
    //             Nbre := 0;

    //             Nbre := 0;

    //             Nbre := 0;

    //             Nbre := Nbre + 1;
    //             NbreTotal := NbreTotal + 1;

    //             TotalAvancePrime := TotalAvancePrime + Notes."Avance sur Prime";

    //             TiotalPrime := TiotalPrime + Notes."Montant Prime Base calcul";

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Affectation);
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
    //     TiotalPrime: Decimal;
    //     AvancePrime: Boolean;
    //     TotalAvancePrime: Decimal;
    //     Nbre: Integer;
    //     NbreTotal: Integer;
    //     AffectationCaptionLbl: Label 'Affectation';
    //     Total_Montant_Avance_sur_PrimeCaptionLbl: Label 'Total Montant Avance sur Prime';
    //     NbreCaptionLbl: Label 'Nbre';
    //     AffectationCaption_Control1000000010Lbl: Label 'Affectation';
    //     Total_Montant_PrimeCaptionLbl: Label 'Total Montant Prime';
    //     NbreCaption_Control1000000032Lbl: Label 'Nbre';
    //     TOTALS__CaptionLbl: Label 'TOTALS :';
    //     TOTALS__Caption_Control1000000001Lbl: Label 'TOTALS :';
}

