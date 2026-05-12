report 50170 "Calcul Rappel"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/CalculRappel.rdlc';
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = all;
    // Caption = 'Calcul Rappel';


    // dataset
    // {
    //     dataitem(DataItem7528; 5200)
    //     {
    //         DataItemTableView = SORTING("No.");
    //         RequestFilterFields = "No.";
    //         column(Employee__No__; "No.")
    //         {
    //         }
    //         column(Employee__First_Name_; "First Name")
    //         {
    //         }
    //         column(DiffSb; DiffSb)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DiffIndem1; DiffIndem1)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DiffIndem2; DiffIndem2)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(DiffIndem3; DiffIndem3)
    //         {
    //         }
    //         column(DiffIndem4; DiffIndem4)
    //         {
    //         }
    //         column(DiffIndem5; DiffIndem5)
    //         {
    //         }
    //         column("JoursTravaillé"; JoursTravaillé)
    //         {
    //         }
    //         column(DiffIndem1_DiffIndem2_DiffIndem3_DiffIndem4_DiffIndem5; DiffIndem1 + DiffIndem2 + DiffIndem3 + DiffIndem4 + DiffIndem5)
    //         {
    //         }
    //         column(MontantRappel; MontantRappel)
    //         {
    //         }
    //         column(EmployeeCaption; EmployeeCaptionLbl)
    //         {
    //         }
    //         column(Diff_SbCaption; Diff_SbCaptionLbl)
    //         {
    //         }
    //         column(Diff_ind1Caption; Diff_ind1CaptionLbl)
    //         {
    //         }
    //         column(Diff_ind2Caption; Diff_ind2CaptionLbl)
    //         {
    //         }
    //         column(Diff_ind3Caption; Diff_ind3CaptionLbl)
    //         {
    //         }
    //         column(Diff_ind4Caption; Diff_ind4CaptionLbl)
    //         {
    //         }
    //         column(Diff_ind5Caption; Diff_ind5CaptionLbl)
    //         {
    //         }
    //         column(JoursCaption; JoursCaptionLbl)
    //         {
    //         }
    //         column(Mnt_IndCaption; Mnt_IndCaptionLbl)
    //         {
    //         }
    //         column(RappelCaption; RappelCaptionLbl)
    //         {
    //         }
    //         column(SIMULATION_RAPPELCaption; SIMULATION_RAPPELCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF RappelEnregistre2.GET(AnneeRappel, "No.") THEN RappelEnregistre2.DELETE;
    //             Trouver := FALSE;
    //             SbaseDebut := 0;
    //             SbaseFin := 0;
    //             DiffSb := 0;
    //             PaieDebut := '';
    //             PaieFin := '';
    //             IndemDebut1 := 0;
    //             IndemDebut2 := 0;
    //             IndemDebut3 := 0;
    //             IndemDebut4 := 0;
    //             IndemDebut5 := 0;
    //             IndemFin1 := 0;
    //             IndemFin2 := 0;
    //             IndemFin3 := 0;
    //             IndemFin4 := 0;
    //             IndemFin5 := 0;
    //             DiffIndem1 := 0;
    //             DiffIndem2 := 0;
    //             DiffIndem3 := 0;
    //             DiffIndem4 := 0;
    //             DiffIndem5 := 0;
    //             PaieDebut := '';
    //             JoursTravaillé := 0;
    //             JoursBaseIndem := 0;
    //             JoursDep := 0;
    //             MontantRappel := 0;
    //             MontantIndem := 0;
    //             IF HumanResourcesSetup.GET THEN;
    //             // Trouver Le Premier Mois De Paie
    //             SalaryLinesEnreg.RESET;
    //             SalaryLinesEnreg.SETRANGE(Year, AnneeDebut);
    //             SalaryLinesEnreg.SETFILTER(Month, '%1..%2', MoisDebut, 11);
    //             SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //             IF SalaryLinesEnreg.FINDFIRST THEN BEGIN
    //                 PaieDebut := SalaryLinesEnreg."No.";
    //             END;// SalaryLinesEnreg.NEXT=0;
    //             // Si Premiere Paie non trouer
    //             // Trouver Le Premier Mois De Paie
    //             IF PaieDebut = '' THEN BEGIN
    //                 SalaryLinesEnreg.RESET;
    //                 SalaryLinesEnreg.SETRANGE(Year, AnneeFin);
    //                 SalaryLinesEnreg.SETFILTER(Month, '<=%1', MoisFin);
    //                 SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //                 IF SalaryLinesEnreg.FINDFIRST THEN BEGIN
    //                     PaieDebut := SalaryLinesEnreg."No.";
    //                 END;// SalaryLinesEnreg.NEXT=0;
    //             END;
    //             // Trouver Paie Fin
    //             SalaryLinesEnreg.RESET;
    //             SalaryLinesEnreg.SETRANGE(Year, AnneeFin);
    //             SalaryLinesEnreg.SETFILTER(Month, '<=%1', MoisFin);
    //             SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //             IF SalaryLinesEnreg.FINDLAST THEN BEGIN
    //                 PaieFin := SalaryLinesEnreg."No.";
    //             END;// SalaryLinesEnreg.NEXT=0;

    //             IF PaieFin = '' THEN BEGIN
    //                 SalaryLinesEnreg.RESET;
    //                 SalaryLinesEnreg.SETRANGE(Year, AnneeDebut);
    //                 SalaryLinesEnreg.SETFILTER(Month, '%1..%2', MoisDebut, 11);
    //                 SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //                 IF SalaryLinesEnreg.FINDLAST THEN BEGIN
    //                     PaieFin := SalaryLinesEnreg."No.";
    //                 END;// SalaryLinesEnreg.NEXT=0;

    //             END;

    //             // >> HJ SORO 14-12-2017
    //             IF AnneeDebut = AnneeFin THEN BEGIN
    //                 PaieDebut := '';
    //                 PaieFin := '';
    //                 SalaryLinesEnreg.RESET;
    //                 SalaryLinesEnreg.SETRANGE(Year, AnneeDebut);
    //                 SalaryLinesEnreg.SETFILTER(Month, '%1..%2', MoisDebut, MoisFin);
    //                 SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //                 IF SalaryLinesEnreg.FINDFIRST THEN BEGIN
    //                     PaieDebut := SalaryLinesEnreg."No.";
    //                 END;// SalaryLinesEnreg.NEXT=0;
    //                 SalaryLinesEnreg.RESET;
    //                 SalaryLinesEnreg.SETRANGE(Year, AnneeDebut);
    //                 SalaryLinesEnreg.SETFILTER(Month, '%1..%2', MoisDebut, MoisFin);
    //                 SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //                 IF SalaryLinesEnreg.FINDLAST THEN BEGIN
    //                     PaieFin := SalaryLinesEnreg."No.";
    //                 END;

    //             END;
    //             // >> HJ SORO 14-12-2017

    //             // Salaire Base Initial Et Final
    //             SalaryLinesEnreg.RESET;
    //             SalaryLinesEnreg.SETRANGE("No.", PaieDebut, PaieFin);
    //             SalaryLinesEnreg.SETRANGE(Employee, "No.");
    //             IF SalaryLinesEnreg.FINDFIRST THEN
    //                 REPEAT
    //                     IF (COPYSTR(SalaryLinesEnreg.Catégorie, 1, 2) <> 'SV') AND (COPYSTR(SalaryLinesEnreg.Catégorie, 1, 2) <> 'KR') THEN BEGIN
    //                         SbaseDebut := SalaryLinesEnreg."Basis salary";
    //                         IF Linegrid.GET('GRI-0001', SalaryLinesEnreg.Catégorie, 0, 0, 0) THEN;
    //                         IF RegimeOfWork.GET(SalaryLinesEnreg."Regime of work") THEN;
    //                         IF SalaryLinesEnreg."Employee's type" = SalaryLinesEnreg."Employee's type"::"Month based" THEN
    //                             SbaseFin := Linegrid."Salaire de base"
    //                         ELSE BEGIN
    //                             SbaseDebut := SalaryLinesEnreg."Basis salary" * RegimeOfWork."Work Hours per month";
    //                             SbaseFin := Linegrid."Salaire de base" * RegimeOfWork."Work Hours per month";
    //                         END;
    //                         IF AveFerCong THEN BEGIN
    //                             FerCong := 0;
    //                             HeuresSupEnregistrer.RESET;
    //                             HeuresSupEnregistrer.SETFILTER("N° Salarié", "No.");
    //                             HeuresSupEnregistrer.SETRANGE("Mois de paiement", SalaryLinesEnreg.Month);
    //                             HeuresSupEnregistrer.SETRANGE("Année de paiement", SalaryLinesEnreg.Year);
    //                             IF HeuresSupEnregistrer.FINDFIRST THEN
    //                                 REPEAT
    //                                     IF (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."Type Jours"::"Jour(s) Ferie(s)")
    //                                     OR (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."Type Jours"::"Congé Annuelle")
    //                                     OR (HeuresSupEnregistrer."Type Jours" = HeuresSupEnregistrer."Type Jours"::"Congé Exceptionnel") THEN
    //                                         FerCong += HeuresSupEnregistrer."Nombre Heures Supp";
    //                                 UNTIL HeuresSupEnregistrer.NEXT = 0;

    //                         END;
    //                         JoursDep := SalaryLinesEnreg."Jours Deplacements";
    //                         JoursTravaillé := SalaryLinesEnreg."Paied days" + FerCong;
    //                         // Diff Base
    //                         DiffSb += ROUND((SbaseFin - SbaseDebut) * (JoursTravaillé + FerCong) / 26, 0.001);
    //                         // Indem 1
    //                         JoursBaseIndem := JoursTravaillé;
    //                         // Calcul Indemnité 1
    //                         IF Indem1 = HumanResourcesSetup."Indemnite Transport" THEN JoursBaseIndem := JoursTravaillé - JoursDep;

    //                         DefaultIndemnities.RESET;
    //                         DefaultIndemnities.SETRANGE("Employment Contract Code", "No.");
    //                         DefaultIndemnities.SETRANGE("Indemnity Code", Indem1);
    //                         IF DefaultIndemnities.FINDFIRST THEN IndemFin1 := DefaultIndemnities."Default amount";

    //                         IndemnitiesEnreg.RESET;
    //                         IndemnitiesEnreg.SETRANGE("No.", SalaryLinesEnreg."No.");
    //                         IndemnitiesEnreg.SETRANGE("Employee No.", "No.");
    //                         IndemnitiesEnreg.SETRANGE(Indemnity, Indem1);
    //                         IF IndemnitiesEnreg.FINDFIRST THEN IndemDebut1 := IndemnitiesEnreg."Base Amount";

    //                         DiffIndem1 += ROUND(((IndemFin1 - IndemDebut1) * JoursBaseIndem) / 26, 0.001);

    //                         //MESSAGE(' indem 1 paie %1  indf %2 Indei %3 JbasInde %4  DIFF %5 ',SalaryLinesEnreg."No.",IndemFin1,IndemDebut1,JoursBaseIndem,
    //                         // ROUND(((IndemFin1-IndemDebut1)*JoursBaseIndem)/26,0.001));


    //                         // Indem 2
    //                         JoursBaseIndem := JoursTravaillé;
    //                         // Calcul Indemnité 1
    //                         IF Indem2 = HumanResourcesSetup."Indemnite Transport" THEN JoursBaseIndem := JoursTravaillé - JoursDep;

    //                         DefaultIndemnities.RESET;
    //                         DefaultIndemnities.SETRANGE("Employment Contract Code", "No.");
    //                         DefaultIndemnities.SETRANGE("Indemnity Code", Indem2);
    //                         IF DefaultIndemnities.FINDFIRST THEN IndemFin2 := DefaultIndemnities."Default amount";

    //                         IndemnitiesEnreg.RESET;
    //                         IndemnitiesEnreg.SETRANGE("No.", SalaryLinesEnreg."No.");
    //                         IndemnitiesEnreg.SETRANGE("Employee No.", "No.");
    //                         IndemnitiesEnreg.SETRANGE(Indemnity, Indem2);
    //                         IF IndemnitiesEnreg.FINDFIRST THEN IndemDebut2 := IndemnitiesEnreg."Base Amount";

    //                         DiffIndem2 += ROUND(((IndemFin2 - IndemDebut2) * JoursBaseIndem) / 26, 0.001);

    //                         // message(' indem 2 paie %1  indf %2 Indei %3 JbasInde %4  DIFF %5 ',SalaryLinesEnreg."No.",IndemFin2,IndemDebut2,JoursBaseIndem,
    //                         //  ROUND(((IndemFin2-IndemDebut2)*JoursBaseIndem)/26,0.001));

    //                         // Indem 3
    //                         JoursBaseIndem := JoursTravaillé;
    //                         // Calcul Indemnité 1
    //                         IF Indem3 = HumanResourcesSetup."Indemnite Transport" THEN JoursBaseIndem := JoursTravaillé - JoursDep;

    //                         DefaultIndemnities.RESET;
    //                         DefaultIndemnities.SETRANGE("Employment Contract Code", "No.");
    //                         DefaultIndemnities.SETRANGE("Indemnity Code", Indem3);
    //                         IF DefaultIndemnities.FINDFIRST THEN IndemFin3 := DefaultIndemnities."Default amount";

    //                         IndemnitiesEnreg.RESET;
    //                         IndemnitiesEnreg.SETRANGE("No.", SalaryLinesEnreg."No.");
    //                         IndemnitiesEnreg.SETRANGE("Employee No.", "No.");
    //                         IndemnitiesEnreg.SETRANGE(Indemnity, Indem3);
    //                         IF IndemnitiesEnreg.FINDFIRST THEN IndemDebut2 := IndemnitiesEnreg."Base Amount";

    //                         DiffIndem3 += ROUND(((IndemFin3 - IndemDebut3) * JoursBaseIndem) / 26, 0.001);

    //                         // Indem 4
    //                         JoursBaseIndem := JoursTravaillé;
    //                         // Calcul Indemnité 1
    //                         IF Indem4 = HumanResourcesSetup."Indemnite Transport" THEN JoursBaseIndem := JoursTravaillé - JoursDep;

    //                         DefaultIndemnities.RESET;
    //                         DefaultIndemnities.SETRANGE("Employment Contract Code", "No.");
    //                         DefaultIndemnities.SETRANGE("Indemnity Code", Indem4);
    //                         IF DefaultIndemnities.FINDFIRST THEN IndemFin4 := DefaultIndemnities."Default amount";

    //                         IndemnitiesEnreg.RESET;
    //                         IndemnitiesEnreg.SETRANGE("No.", SalaryLinesEnreg."No.");
    //                         IndemnitiesEnreg.SETRANGE("Employee No.", "No.");
    //                         IndemnitiesEnreg.SETRANGE(Indemnity, Indem4);
    //                         IF IndemnitiesEnreg.FINDFIRST THEN IndemDebut4 := IndemnitiesEnreg."Base Amount";

    //                         DiffIndem4 += ROUND(((IndemFin4 - IndemDebut4) * JoursBaseIndem) / 26, 0.001);

    //                         // Indem 5
    //                         JoursBaseIndem := JoursTravaillé;
    //                         IF Indem5 = HumanResourcesSetup."Indemnite Transport" THEN JoursBaseIndem := JoursTravaillé - JoursDep;

    //                         DefaultIndemnities.RESET;
    //                         DefaultIndemnities.SETRANGE("Employment Contract Code", "No.");
    //                         DefaultIndemnities.SETRANGE("Indemnity Code", Indem5);
    //                         IF DefaultIndemnities.FINDFIRST THEN IndemFin5 := DefaultIndemnities."Default amount";

    //                         IndemnitiesEnreg.RESET;
    //                         IndemnitiesEnreg.SETRANGE("No.", SalaryLinesEnreg."No.");
    //                         IndemnitiesEnreg.SETRANGE("Employee No.", "No.");
    //                         IndemnitiesEnreg.SETRANGE(Indemnity, Indem5);
    //                         IF IndemnitiesEnreg.FINDFIRST THEN IndemDebut5 := IndemnitiesEnreg."Base Amount";

    //                         DiffIndem5 += ROUND(((IndemFin5 - IndemDebut5) * JoursBaseIndem) / 26, 0.001);

    //                         MontantIndem += DiffIndem1 + DiffIndem2 + DiffIndem3 + DiffIndem4 + DiffIndem5;
    //                         Trouver := TRUE;
    //                     END;

    //                 UNTIL SalaryLinesEnreg.NEXT = 0;

    //             IF Trouver THEN BEGIN
    //                 MontantRappel := DiffSb + DiffIndem1 + DiffIndem2 + DiffIndem3 + DiffIndem4 + DiffIndem5;

    //                 RappelEnregistre."Annee Rappel" := AnneeRappel;
    //                 RappelEnregistre."Employee No." := "No.";
    //                 RappelEnregistre.Affectation := Affectation;
    //                 RappelEnregistre.Qualification := Qualification;
    //                 RappelEnregistre.Nom := "First Name";
    //                 RappelEnregistre."Annee Debut" := AnneeDebut;
    //                 RappelEnregistre."Mois Debut" := MoisDebut;
    //                 RappelEnregistre."Annee Fin" := AnneeFin;
    //                 RappelEnregistre."Mois Fin" := MoisFin;
    //                 RappelEnregistre."Montant SB" := DiffSb;
    //                 RappelEnregistre."Indem 1" := DiffIndem1;
    //                 RappelEnregistre."Indem 2" := DiffIndem2;
    //                 RappelEnregistre."Montant Indem" := DiffIndem1 + DiffIndem2 + DiffIndem3 + DiffIndem4 + DiffIndem5;
    //                 RappelEnregistre."Montant Rappel" := MontantRappel;
    //                 IF NOT RappelEnregistre.INSERT THEN RappelEnregistre.MODIFY;

    //                 IF IntegrerCalcul THEN BEGIN
    //                     IF Rappel = Rappel::R1 THEN BEGIN
    //                         "Annee Rappel 1" := AnneeRappel;
    //                         "Montant Rappel 1" := MontantRappel;
    //                         MODIFY;
    //                     END;
    //                     IF Rappel = Rappel::R2 THEN BEGIN
    //                         "Annee Rappel 2" := AnneeRappel;
    //                         "Montant Rappel 2" := MontantRappel;
    //                         MODIFY;
    //                     END;

    //                 END;
    //             END;
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

    // trigger OnInitReport()
    // begin
    //     AnneeDebut := 2016;
    //     MoisDebut := 7;
    //     AnneeFin := 2017;
    //     MoisFin := 3;
    //     Indem1 := '003';
    //     Indem2 := '201';
    //     AnneeRappel := 2016;
    // end;

    // trigger OnPreReport()
    // begin
    //     IF AnneeRappel = 0 THEN ERROR(Text001);
    // end;

    // var
    //     SalaryLinesEnreg: Record 52048901;
    //     SalaryLinesEnreg2: Record 52048901;
    //     IndemnitiesEnreg: Record 52048902;
    //     DefaultIndemnities: Record 52048884;
    //     HeuresSupEnregistrer: Record 52048892;
    //     RegimeOfWork: Record 52048882;
    //     Linegrid: Record 52048905;
    //     HumanResourcesSetup: Record 5218;
    //     RappelEnregistre: Record 52048925;
    //     RappelEnregistre2: Record 52048925;
    //     SbaseDebut: Decimal;
    //     SbaseFin: Decimal;
    //     Indem1: Code[20];
    //     Indem2: Code[20];
    //     Indem3: Code[20];
    //     Indem4: Code[20];
    //     Indem5: Code[20];
    //     DiffSb: Decimal;
    //     IndemDebut1: Decimal;
    //     IndemDebut2: Decimal;
    //     IndemDebut3: Decimal;
    //     IndemDebut4: Decimal;
    //     IndemDebut5: Decimal;
    //     IndemFin1: Decimal;
    //     IndemFin2: Decimal;
    //     IndemFin3: Decimal;
    //     IndemFin4: Decimal;
    //     IndemFin5: Decimal;
    //     DiffIndem1: Decimal;
    //     DiffIndem2: Decimal;
    //     DiffIndem3: Decimal;
    //     DiffIndem4: Decimal;
    //     DiffIndem5: Decimal;
    //     AnneeDebut: Integer;
    //     MoisDebut: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
    //     AnneeFin: Integer;
    //     MoisFin: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
    //     AnneeChangementSb: Integer;
    //     MoisChangementSb: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
    //     JoursPaye: Decimal;
    //     MontantSb: Decimal;
    //     MontantIndem: Decimal;
    //     MontantRappel: Decimal;
    //     PaieDebut: Code[20];
    //     PaieFin: Code[20];
    //     IntegrerCalcul: Boolean;
    //     FerCong: Decimal;
    //     AveFerCong: Boolean;
    //     "Heures sup. eregistrées m": Integer;
    //     "JoursTravaillé": Decimal;
    //     JoursDep: Decimal;
    //     JoursBaseIndem: Decimal;
    //     Rappel: Option R1,R2;
    //     AnneeRappel: Integer;
    //     Text001: Label 'Preciser Année Rappel';
    //     Trouver: Boolean;
    //     EmployeeCaptionLbl: Label 'Employee';
    //     Diff_SbCaptionLbl: Label 'Diff Sb';
    //     Diff_ind1CaptionLbl: Label 'Diff ind1';
    //     Diff_ind2CaptionLbl: Label 'Diff ind2';
    //     Diff_ind3CaptionLbl: Label 'Diff ind3';
    //     Diff_ind4CaptionLbl: Label 'Diff ind4';
    //     Diff_ind5CaptionLbl: Label 'Diff ind5';
    //     JoursCaptionLbl: Label 'Jours';
    //     Mnt_IndCaptionLbl: Label 'Mnt Ind';
    //     RappelCaptionLbl: Label 'Rappel';
    //     SIMULATION_RAPPELCaptionLbl: Label 'SIMULATION RAPPEL';
}

