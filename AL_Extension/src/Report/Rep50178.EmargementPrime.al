report 50178 "Emargement Prime"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EmargementPrime.rdlc';

    // dataset
    // {
    //     dataitem(Notes; 52048938)
    //     {
    //         DataItemTableView = SORTING(Affectation, Année, Matricule)
    //                             WHERE(Imposable = CONST(false),
    //                                   Note = FILTER(> 0),
    //                                   Payé = FILTER('No'),
    //                                   Net = FILTER(> 0));
    //         RequestFilterFields = Affectation, "Année", "Nbre Fiche", Matricule;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column("Notes_Année"; Année)
    //         {
    //         }
    //         column(Notes_Affectation; Affectation)
    //         {
    //         }
    //         column(Notes__Description_Affectation_; "Description Affectation")
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4__Control1000000002; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME_Control1000000003; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO_Control1000000004; CurrReport.PAGENO)
    //         {
    //         }
    //         column("Notes_Année_Control1000000011"; Année)
    //         {
    //         }
    //         column(Notes_Affectation_Control1000000008; Affectation)
    //         {
    //         }
    //         column(Notes__Description_Affectation__Control1000000017; "Description Affectation")
    //         {
    //         }
    //         column(USERID_Control1000000076; USERID)
    //         {
    //         }
    //         column(Notes__Description_Qualification_; "Description Qualification")
    //         {
    //         }
    //         column(ROUND_Notes__Avance_sur_Prime__1_; ROUND(Notes."Avance sur Prime", 1))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Notes__Nom_Salariée_"; "Nom Salariée")
    //         {
    //         }
    //         column(Notes_Matricule; Matricule)
    //         {
    //         }
    //         column(Notes_Matricule_Control1000000014; Matricule)
    //         {
    //         }
    //         column(Notes__Description_Qualification__Control1000000023; "Description Qualification")
    //         {
    //         }
    //         column(Notes_Net; Net)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Notes__Nom_Salariée__Control1000000001"; "Nom Salariée")
    //         {
    //         }
    //         column(ROUND_Notes__Avance_sur_Prime__1__Control1000000067; ROUND(Notes."Avance sur Prime", 1))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Notes__Montant_Prime_Base_calcul___ROUND_Notes__Avance_sur_Prime__1_; (Notes."Montant Prime Base calcul") - ROUND(Notes."Avance sur Prime", 1))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Num; Num)
    //         {
    //         }
    //         column(Notes_Note; Note)
    //         {
    //         }
    //         column("Nbresalarié"; Nbresalarié)
    //         {
    //         }
    //         column(TotAvance; TotAvance)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Notes__Montant_Prime_; "Montant Prime")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Nbresalarié_Control1000000006"; Nbresalarié)
    //         {
    //         }
    //         column(Notes_Net_Control1000000018; Net)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Avance_sur_Prime_de_rendementCaption; Avance_sur_Prime_de_rendementCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENO_Control1000000004Caption; CurrReport_PAGENO_Control1000000004CaptionLbl)
    //         {
    //         }
    //         column(Prime_de_rendementCaption; Prime_de_rendementCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption_Control1000000012"; Année__Caption_Control1000000012Lbl)
    //         {
    //         }
    //         column(Affectation__Caption_Control1000000009; Affectation__Caption_Control1000000009Lbl)
    //         {
    //         }
    //         column("Nom_SalariéeCaption"; Nom_SalariéeCaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(QualificationCaption; QualificationCaptionLbl)
    //         {
    //         }
    //         column(Montant_Avance_sur_PrimeCaption; Montant_Avance_sur_PrimeCaptionLbl)
    //         {
    //         }
    //         column(EmargementCaption; EmargementCaptionLbl)
    //         {
    //         }
    //         column(NoteCaption; NoteCaptionLbl)
    //         {
    //         }
    //         column(Notes_Matricule_Control1000000014Caption; FIELDCAPTION(Matricule))
    //         {
    //         }
    //         column(QualificationCaption_Control1000000024; QualificationCaption_Control1000000024Lbl)
    //         {
    //         }
    //         column(Montant_PrimeCaption; Montant_PrimeCaptionLbl)
    //         {
    //         }
    //         column("Notes__Nom_Salariée__Control1000000001Caption"; FIELDCAPTION("Nom Salariée"))
    //         {
    //         }
    //         column(EmargementCaption_Control1000000020; EmargementCaption_Control1000000020Lbl)
    //         {
    //         }
    //         column(AvanceCaption; AvanceCaptionLbl)
    //         {
    //         }
    //         column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
    //         {
    //         }
    //         column(N_Caption; N_CaptionLbl)
    //         {
    //         }
    //         column(NoteCaption_Control1000000082; NoteCaption_Control1000000082Lbl)
    //         {
    //         }
    //         column(Notes_NoteCaption; FIELDCAPTION(Note))
    //         {
    //         }
    //         column(Nbre__Caption; Nbre__CaptionLbl)
    //         {
    //         }
    //         column(Total_Mantant_Avance_Sur_Prime__Caption; Total_Mantant_Avance_Sur_Prime__CaptionLbl)
    //         {
    //         }
    //         column(Total_Mantant_Prime__Caption; Total_Mantant_Prime__CaptionLbl)
    //         {
    //         }
    //         column(Nbre__Caption_Control1000000007; Nbre__Caption_Control1000000007Lbl)
    //         {
    //         }
    //         column(AvancePrime; AvancePrime)
    //         {
    //         }
    //         trigger OnAfterGetRecord()

    //         var

    //         begin


    //             TotAvance += ROUND("Avance sur Prime", 1);

    //             Num += 1;
    //             Nbresalarié := Nbresalarié + 1;
    //             nbretotal := nbretotal + 1;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             Nbresalarié := 0;
    //             Num := 0;
    //             LastFieldNo := FIELDNO(Affectation);
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {
    //             field(AvancePrime;AvancePrime)
    //             {
    //                 ApplicationArea = All;
    //                 Caption = 'Avance sur Prime';
    //             }
    //         }
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
    //     TotalFor: Label 'Total ';
    //     "Nbresalarié": Integer;
    //     nbretotal: Integer;
    //     AvancePrime: Boolean;
    //     TotAvance: Decimal;
    //     Num: Integer;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Avance_sur_Prime_de_rendementCaptionLbl: Label 'Avance sur Prime de rendement';
    //     "Année__CaptionLbl": Label 'Année :';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     CurrReport_PAGENO_Control1000000004CaptionLbl: Label 'Page';
    //     Prime_de_rendementCaptionLbl: Label 'Prime de rendement';
    //     "Année__Caption_Control1000000012Lbl": Label 'Année :';
    //     Affectation__Caption_Control1000000009Lbl: Label 'Affectation :';
    //     "Nom_SalariéeCaptionLbl": Label 'Nom Salariée';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     QualificationCaptionLbl: Label 'Qualification';
    //     Montant_Avance_sur_PrimeCaptionLbl: Label 'Montant Avance sur Prime';
    //     EmargementCaptionLbl: Label 'Emargement';
    //     NoteCaptionLbl: Label 'Note';
    //     QualificationCaption_Control1000000024Lbl: Label 'Qualification';
    //     Montant_PrimeCaptionLbl: Label 'Montant Prime';
    //     EmargementCaption_Control1000000020Lbl: Label 'Emargement';
    //     AvanceCaptionLbl: Label 'Avance';
    //     "Net_à_PayerCaptionLbl": Label 'Net à Payer';
    //     N_CaptionLbl: Label 'N°';
    //     NoteCaption_Control1000000082Lbl: Label 'Note';
    //     Nbre__CaptionLbl: Label 'Nbre :';
    //     Total_Mantant_Avance_Sur_Prime__CaptionLbl: Label 'Total Mantant Avance Sur Prime :';
    //     Total_Mantant_Prime__CaptionLbl: Label 'Total Mantant Prime :';
    //     Nbre__Caption_Control1000000007Lbl: Label 'Nbre :';
}

