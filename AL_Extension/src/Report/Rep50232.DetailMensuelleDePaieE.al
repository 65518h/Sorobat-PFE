report 50232 "Detail Mensuelle De Paie E"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/DetailMensuelleDePaieE.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         DataItemTableView = SORTING(Employee, Year, Month, "Type Prime");
    //         RequestFilterFields = "No.", Employee, Year, Month, Affectation, "Code Mode Réglement";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(FORMAT_Month____________FORMAT_Year_; FORMAT(Month) + ' / ' + FORMAT(Year))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Rec__Salary_Lines__Name; "Rec. Salary Lines".Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Paied_days_; "Paied days")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Real_basis_salary_; "Real basis salary")
    //         {
    //         }
    //         column(DecSalaireBrut; DecSalaireBrut)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Rec__Salary_Lines_CNSS; CNSS)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Taxable_salary_; "Taxable salary")
    //         {
    //         }
    //         column(DecImpot; DecImpot)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Rec__Salary_Lines_Advances; Advances)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Loans; Loans)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Ajout__en___; "Ajout  en +")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Report_en___; "Report en -")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //         {
    //         }
    //         column(Compteur; Compteur)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(Rec__Salary_Lines__No__; "No.")
    //         {
    //         }
    //         column(TotDays; TotDays)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Contribution_Social_; "Contribution Social")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Paied_days__Control1000000016; "Paied days")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Real_basis_salary__Control1000000019; "Real basis salary")
    //         {
    //         }
    //         column(TotalSalBrut; TotalSalBrut)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Rec__Salary_Lines_CNSS_Control1000000025; CNSS)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Taxable_salary__Control1000000028; "Taxable salary")
    //         {
    //         }
    //         column(TotalImpot; TotalImpot)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Rec__Salary_Lines_Advances_Control1000000034; Advances)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Loans_Control1000000037; Loans)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Ajout__en____Control1000000040; "Ajout  en +")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Report_en____Control1000000043; "Report en -")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed__Control1000000046; "Net salary cashed")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Contribution_Social__Control1000000057; "Contribution Social")
    //         {
    //         }
    //         column(Rec__Salary_LinesCaption; Rec__Salary_LinesCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_EmployeeCaption; FIELDCAPTION(Employee))
    //         {
    //         }
    //         column(Nom___PrenomCaption; Nom___PrenomCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Paied_days_Caption; FIELDCAPTION("Paied days"))
    //         {
    //         }
    //         column(Rec__Salary_Lines__Real_basis_salary_Caption; FIELDCAPTION("Real basis salary"))
    //         {
    //         }
    //         column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_CNSSCaption; FIELDCAPTION(CNSS))
    //         {
    //         }
    //         column(Rec__Salary_Lines__Taxable_salary_Caption; FIELDCAPTION("Taxable salary"))
    //         {
    //         }
    //         column(IMPOT__MOIS_Caption; IMPOT__MOIS_CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_AdvancesCaption; FIELDCAPTION(Advances))
    //         {
    //         }
    //         column(Rec__Salary_Lines_LoansCaption; FIELDCAPTION(Loans))
    //         {
    //         }
    //         column(AR__Caption; AR__CaptionLbl)
    //         {
    //         }
    //         column(AR__Caption_Control1000000042; AR__Caption_Control1000000042Lbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed_Caption; FIELDCAPTION("Net salary cashed"))
    //         {
    //         }
    //         column(N_Caption; N_CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_AffectationCaption; FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column(N__PaieCaption; N__PaieCaptionLbl)
    //         {
    //         }
    //         column(Autres_JoursCaption; Autres_JoursCaptionLbl)
    //         {
    //         }
    //         column(Contribution_SocialCaption; Contribution_SocialCaptionLbl)
    //         {
    //         }
    //         column(TotalCaption; TotalCaptionLbl)
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         begin

    //             DecSalaireBrut := 0;
    //             DecImpot := 0;
    //             Compteur += 1;
    //             TotDays := 0;
    //             HeuresSupEregistréesM.SETRANGE("Paiement No.", "No.");
    //             HeuresSupEregistréesM.SETRANGE("N° Salarié", Employee);
    //             HeuresSupEregistréesM.SETFILTER("Type Jours", '%1|%2|%3', HeuresSupEregistréesM."Type Jours"::"Jour(s) Ferie(s)",
    //             HeuresSupEregistréesM."Type Jours"::"Congé Annuelle", HeuresSupEregistréesM."Type Jours"::"Congé Exceptionnel");
    //             IF HeuresSupEregistréesM.FINDFIRST THEN
    //                 REPEAT
    //                     TotDays += HeuresSupEregistréesM."Nombre Heures Supp";
    //                 UNTIL HeuresSupEregistréesM.NEXT = 0;
    //             //IF RecEmployeur.GET(Employee) THEN;
    //             // RB SORO 25/03/2016
    //             //IF "Code Banque Virement" THEN
    //             //   CongePaies := 'Conge Ann'
    //             //ELSE
    //             //   CongePaies := '';
    //             IF RecEmployee.GET(Employee) THEN;
    //             RecEmployee.CALCFIELDS(RecEmployee."Employee's Type Contrat");
    //             // KA 10/04/18
    //             //IF (RecEmployee."Employee's Type Contrat" = RecEmployee."Employee's Type Contrat"::CDI) OR
    //             //   (RecEmployee."Employee's Type Contrat" = RecEmployee."Employee's Type Contrat"::CDD) THEN
    //             // KA 10/04/18
    //             BEGIN
    //                 DecSalaireBrut := "Rec. Salary Lines"."Gross Salary";
    //                 TotalSalBrut += "Rec. Salary Lines"."Gross Salary";
    //                 DecImpot := "Rec. Salary Lines"."Taxe (Month)";
    //                 TotalImpot += "Rec. Salary Lines"."Taxe (Month)";
    //             END;
    //             //ELSE
    //             //BEGIN
    //             //   DecSalaireBrut := 0;
    //             //   DecImpot := 0;
    //             //END;
    //             // RB SORO 25/03/2016
    //             // RB SORO 06/04/2015
    //             IF PrintToExcel THEN;
    //             BEGIN
    //                 MakeExcelDataBody;
    //             END;
    //             // RB SORO 06/04/2015
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

    // trigger OnPostReport()
    // begin
    //     // RB SORO 06/04/2015
    //     // IF PrintToExcel THEN
    //     // CreateExcelbook;
    //     // RB SORO 06/04/2015
    // end;

    // trigger OnPreReport()
    // begin
    //     // RB SORO 06/04/2015
    //     // IF PrintToExcel THEN
    //     // MakeExcelInfo;
    //     // RB SORO 06/04/2015
    // end;

    // var
    //     RecEmployeur: Record 5200;
    //     "HeuresSupEregistréesM": Record 52048892;
    //     Compteur: Integer;
    //     TotDays: Decimal;
    //     "// RB SORO": Integer;
    //     CongePaies: Text[30];
    //     RecEmployee: Record 5200;
    //     DecSalaireBrut: Decimal;
    //     TotalSalBrut: Decimal;
    //     DecImpot: Decimal;
    //     TotalImpot: Decimal;
    //     Text001: Label 'Données';
    //     Text002: Label 'Detail Mensuelle De Paie Enreg';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     FilterModeRegl: Code[20];
    //     "// RB SORO EXPORT EXCEL": Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Rec__Salary_LinesCaptionLbl: Label 'Lignes salaires Enreg.';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Nom___PrenomCaptionLbl: Label 'Nom & Prenom';
    //     Salaire_BrutCaptionLbl: Label 'Salaire Brut';
    //     IMPOT__MOIS_CaptionLbl: Label 'IMPOT (MOIS)';
    //     AR__CaptionLbl: Label 'AR +';
    //     AR__Caption_Control1000000042Lbl: Label 'AR -';
    //     N_CaptionLbl: Label 'N°';
    //     N__PaieCaptionLbl: Label 'N° Paie';
    //     Autres_JoursCaptionLbl: Label 'Autres Jours';
    //     Contribution_SocialCaptionLbl: Label 'Contribution Social';
    //     TotalCaptionLbl: Label 'Total';

    // // [Scope('Internal')]
    // procedure MakeExcelInfo()
    // begin
    //     ExcelBuf.SetUseInfoSheet;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(REPORT::"Solde Pret", FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     //ExcelBuf.NewRow;
    //     ExcelBuf.ClearNewRow;
    //     MakeExcelDataHeader;
    // end;

    // local procedure MakeExcelDataHeader()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('N°', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salarié', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nom & Prenom', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Jours Payés', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salaire de base réel', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salaire Brut', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('CNSS', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salaire Imposable', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Impot (Mois)', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Avances', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Prêt', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('AR +', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('AR -', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Contribution Social', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salaire Net Perçu', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Mois', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Année', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Catégorie', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('N° Paie', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure MakeExcelDataBody()
    // begin

    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn(Compteur, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Employee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Name, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Paied days", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Real basis salary", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(DecSalaireBrut, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".CNSS, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Taxable salary", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(DecImpot, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Advances, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Loans, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Ajout  en +", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Report en -", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Contribution Social", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Net salary cashed", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(FORMAT("Rec. Salary Lines".Month), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Year, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Affectation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Catégorie, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('Detail Mensuelle De Paie E');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;
}

