report 52048915 "Recap Paie Prototype"
{
    // //GGL2024 Dans nav2009 id "39001430"
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapPaiePrototype.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Headers"; "Rec. Salary Headers")
    //     {
    //         DataItemTableView = SORTING("No.");
    //         RequestFilterFields = "No.";
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Rec__Salary_Headers_Month; Month)
    //         {
    //         }
    //         column(Rec__Salary_Headers_Year; Year)
    //         {
    //         }
    //         column(Mois__Caption; Mois__CaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column("Récap_de_paieCaption"; Récap_de_paieCaptionLbl)
    //         {
    //         }
    //         column("DésignationCaption"; DésignationCaptionLbl)
    //         {
    //         }
    //         column("DébitCaption"; DébitCaptionLbl)
    //         {
    //         }
    //         column("CréditCaption"; CréditCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Headers_No_; "No.")
    //         {
    //         }
    //         dataitem("Rec. Salary Lines"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(Rec__Salary_Lines__Real_basis_salary_; "Real basis salary")
    //             {
    //             }
    //             column(Rec__Salary_Lines__Real_basis_salary__Control1000000036; "Real basis salary")
    //             {
    //             }
    //             column(Rec__Salary_Lines__Real_basis_salary_Caption; FIELDCAPTION("Real basis salary"))
    //             {
    //             }
    //             column(Salaire_de_baseCaption; Salaire_de_baseCaptionLbl)
    //             {
    //             }
    //             column(Rec__Salary_Lines_No_; "No.")
    //             {
    //             }
    //             column(Rec__Salary_Lines_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem("Rec. Indemnities"; "Rec. Indemnities")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Indemnity);
    //             column(Rec__Indemnities__No__; "No.")
    //             {
    //             }
    //             column(Rec__Indemnities__Employee_No__; "Employee No.")
    //             {
    //             }
    //             column(Rec__Indemnities_Indemnity; Indemnity)
    //             {
    //             }
    //             column(Rec__Indemnities_Description; Description)
    //             {
    //             }
    //             column(Rec__Indemnities__Real_Amount_; "Real Amount")
    //             {
    //             }
    //             column(Rec__Indemnities__Real_Amount__Control1000000008; "Real Amount")
    //             {
    //             }
    //             column(Rec__Indemnities_Description_Control1000000001; Description)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             var

    //             begin
    //                 if "Real Amount" = 0 then
    //                     CurrReport.Skip();
    //                 //   CurrReport.SHOWOUTPUT("Real Amount" > 0);
    //             end;
    //         }
    //         dataitem("Heures sup. eregistrées m"; "Heures sup. eregistrées m")
    //         {
    //             DataItemLink = "Paiement No." = FIELD("No.");
    //             DataItemTableView = SORTING("Paiement No.", "Type Jours");
    //             column("Heures_sup__eregistrées_m__N__Salarié_"; "N° Salarié")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m__Type_Jours_"; "Type Jours")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m__Montant_Ligne_"; "Montant Ligne")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m__Montant_Ligne__Control1000000020"; "Montant Ligne")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m__Type_Jours__Control1000000060"; "Type Jours")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m_N__transaction"; "N° transaction")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m_N__Ligne"; "N° Ligne")
    //             {
    //             }
    //             column("Heures_sup__eregistrées_m_Paiement_No_"; "Paiement No.")
    //             {
    //             }
    //         }
    //         dataitem("SalBrut"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(SalBrut__Gross_Salary_; "Gross Salary")
    //             {
    //             }
    //             column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
    //             {
    //             }
    //             column(SalBrut_No_; "No.")
    //             {
    //             }
    //             column(SalBrut_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem(CNSS1; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(CNSS1_CNSS; CNSS)
    //             {
    //             }
    //             column(CNSSCaption; CNSSCaptionLbl)
    //             {
    //             }
    //             column(CNSS1_No_; "No.")
    //             {
    //             }
    //             column(CNSS1_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem(SalImpossable; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(SalImpossable__Taxable_salary_; "Taxable salary")
    //             {
    //             }
    //             column(Salaire_ImposableCaption; Salaire_ImposableCaptionLbl)
    //             {
    //             }
    //             column(SalImpossable_No_; "No.")
    //             {
    //             }
    //             column(SalImpossable_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem(ImpotMois; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(ImpotMois__Taxe__Month__; "Taxe (Month)")
    //             {
    //             }
    //             column(Impots_mensuelsCaption; Impots_mensuelsCaptionLbl)
    //             {
    //             }
    //             column(ImpotMois_No_; "No.")
    //             {
    //             }
    //             column(ImpotMois_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem(PretAvances; "Loan & Advance Lines")
    //         {
    //             DataItemLink = "Payment No." = FIELD("No.");
    //             DataItemTableView = SORTING(Type, "Payment No.", Employee, "Employee Posting Group", Month, Year, "Global dimension 1", "Global dimension 2", "Document type", "Employee Statistic Group")
    //                                 WHERE(Type = FILTER(Advance));
    //             column(PretAvances__Line_Amount_; "Line Amount")
    //             {
    //             }
    //             column(PretAvances__Line_Amount__Control1000000031; "Line Amount")
    //             {
    //             }
    //             column(AvancesCaption; AvancesCaptionLbl)
    //             {
    //             }
    //             column(PretAvances_No_; "No.")
    //             {
    //             }
    //             column(PretAvances_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(PretAvances_Type; Type)
    //             {
    //             }
    //             column(PretAvances_Payment_No_; "Payment No.")
    //             {
    //             }
    //         }
    //         dataitem(PretCession; "Loan & Advance Lines")
    //         {
    //             DataItemLink = "Payment No." = FIELD("No.");
    //             DataItemTableView = SORTING(Type, "Payment No.", Employee, "Employee Posting Group", Month, Year, "Global dimension 1", "Global dimension 2", "Document type", "Employee Statistic Group")
    //                                 WHERE(Type = FILTER(Loan),
    //                                       "Pret CNSS" = FILTER(Cession));
    //             column(PretCession__Line_Amount_; "Line Amount")
    //             {
    //             }
    //             column(PretCession__Line_Amount__Control1000000024; "Line Amount")
    //             {
    //             }
    //             column(CessionCaption; CessionCaptionLbl)
    //             {
    //             }
    //             column(PretCession_No_; "No.")
    //             {
    //             }
    //             column(PretCession_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(PretCession_Type; Type)
    //             {
    //             }
    //             column(PretCession_Payment_No_; "Payment No.")
    //             {
    //             }
    //         }
    //         dataitem(PretPret; "Loan & Advance Lines")
    //         {
    //             DataItemLink = "Payment No." = FIELD("No.");
    //             DataItemTableView = SORTING(Type, "Payment No.", Employee, "Employee Posting Group", Month, Year, "Global dimension 1", "Global dimension 2", "Document type", "Employee Statistic Group")
    //                                 WHERE(Type = FILTER(Loan),
    //                                       "Pret CNSS" = FILTER(<> Cession));
    //             column(PretPret__Line_Amount_; "Line Amount")
    //             {
    //             }
    //             column(PretPret__Line_Amount__Control1000000028; "Line Amount")
    //             {
    //             }
    //             column("PrêtsCaption"; PrêtsCaptionLbl)
    //             {
    //             }
    //             column(PretPret_No_; "No.")
    //             {
    //             }
    //             column(PretPret_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(PretPret_Type; Type)
    //             {
    //             }
    //             column(PretPret_Payment_No_; "Payment No.")
    //             {
    //             }
    //         }
    //         dataitem("AR+"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(AR___Ajout__en___; "Ajout  en +")
    //             {
    //             }
    //             column(AR__Caption; AR__CaptionLbl)
    //             {
    //             }
    //             column(AR__No_; "No.")
    //             {
    //             }
    //             column(AR__Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem("AR-"; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(AR___Report_en___; "Report en -")
    //             {
    //             }
    //             column(AR__Caption_Control1000000057; AR__Caption_Control1000000057Lbl)
    //             {
    //             }
    //         }
    //         dataitem(CSS; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(CSS__Contribution_Social_; "Contribution Social")
    //             {
    //             }
    //             column(Contributions_SocialesCaption; Contributions_SocialesCaptionLbl)
    //             {
    //             }
    //             column(CSS_No_; "No.")
    //             {
    //             }
    //             column(CSS_Employee; Employee)
    //             {
    //             }
    //         }
    //         dataitem(SalNetPercu; "Rec. Salary Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING("No.", Employee);
    //             column(SalNetPercu__Net_salary_cashed_; "Net salary cashed")
    //             {
    //             }
    //             column("Salaire_Net_PerçuCaption"; Salaire_Net_PerçuCaptionLbl)
    //             {
    //             }
    //             column(SalNetPercu_No_; "No.")
    //             {
    //             }
    //             column(SalNetPercu_Employee; Employee)
    //             {
    //             }
    //         }

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("No.");
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
    //     IF PrintToExcel THEN
    //         CreateExcelbook;
    // end;

    // trigger OnPreReport()
    // begin
    //     IF PrintToExcel THEN
    //         MakeExcelInfo;
    // end;

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Text001: Label 'Données';
    //     Text002: Label 'Récap Paie';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     Mois__CaptionLbl: Label 'Mois :';
    //     "Année__CaptionLbl": Label 'Année :';
    //     "Récap_de_paieCaptionLbl": Label 'Récap de paie';
    //     "DésignationCaptionLbl": Label 'Désignation';
    //     "DébitCaptionLbl": Label 'Débit';
    //     "CréditCaptionLbl": Label 'Crédit';
    //     Salaire_de_baseCaptionLbl: Label 'Salaire de base';
    //     Salaire_BrutCaptionLbl: Label 'Salaire Brut';
    //     CNSSCaptionLbl: Label 'CNSS';
    //     Salaire_ImposableCaptionLbl: Label 'Salaire Imposable';
    //     Impots_mensuelsCaptionLbl: Label 'Impots mensuels';
    //     AvancesCaptionLbl: Label 'Avances';
    //     CessionCaptionLbl: Label 'Cession';
    //     "PrêtsCaptionLbl": Label 'Prêts';
    //     AR__CaptionLbl: Label 'AR +';
    //     AR__Caption_Control1000000057Lbl: Label 'AR -';
    //     Contributions_SocialesCaptionLbl: Label 'Contributions Sociales';
    //     "Salaire_Net_PerçuCaptionLbl": Label 'Salaire Net Perçu';


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
    //     ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, FALSE, FALSE, FALSE, '', 0);
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
    //     ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Débit', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Crédit', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    // end;

    // local procedure MakeExcelDataHeader2()
    // begin
    //     //ExcelBuf.NewRow;
    //     //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    // end;


    // procedure MakeExcelDataBody()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn("Rec. Indemnities".Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND("Rec. Indemnities"."Real Amount", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure CreateExcelbook()
    // begin
    //     //    ExcelBuf.CreateBook('Recap Paie Prototype');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     //   ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;


    // procedure MakeExcelDataBody2()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn(FORMAT("Heures sup. eregistrées m"."Type Jours"), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND("Heures sup. eregistrées m"."Montant Ligne", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodySBase()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Salaire de Base', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND("Rec. Salary Lines"."Real basis salary", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodySBrut()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Salaire Brut', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(SalBrut."Gross Salary", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodyCNSS()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('CNSS', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(CNSS1.CNSS, 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodySImposable()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Salaire Imposable', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(SalImpossable."Taxable salary", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodyImpotMois()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Impots Mensuels', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(ImpotMois."Taxe (Month)", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodyAvances()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Avances', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(PretAvances."Line Amount", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodyCession()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Cession', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(PretCession."Line Amount", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodyPret()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Prêts', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(PretPret."Line Amount", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure "MakeExcelDataBodyAR+"()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('AR+', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND("AR+"."Ajout  en +", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure "MakeExcelDataBodyAR-"()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('AR-', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND("AR-"."Report en -", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;

    // procedure MakeExcelDataBodyCSS()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Contributions Sociales', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(CSS."Contribution Social", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;


    // procedure MakeExcelDataBodySNetPercu()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('Salaire Net Perçu', FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ROUND(SalNetPercu."Net salary cashed", 0.001), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;
}

