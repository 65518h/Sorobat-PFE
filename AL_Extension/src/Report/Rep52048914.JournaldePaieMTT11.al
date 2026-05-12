report 52048914 "Journal de Paie  MTT11"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/JournaldePaieMTT11.rdl';

    // dataset
    // {
    //     dataitem("Company Information"; "Company Information")
    //     {
    //         DataItemTableView = SORTING("Primary Key")
    //                             ORDER(Ascending);
    //         column(Company_Information_Name; Name)
    //         {
    //         }
    //         column(Company_Information_Address; Address)
    //         {
    //         }
    //         column(Company_Information__Address_2_; "Address 2")
    //         {
    //         }
    //         column(City____________Post_Code_; City + ' - ' + "Post Code")
    //         {
    //         }
    //         column(Company_Information__N__CNSS_; "N° CNSS")
    //         {
    //         }
    //         column(Page_____FORMAT__CurrReport_PAGENO_; 'Page : ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(Company_Information__N__CNSS_Caption; FIELDCAPTION("N° CNSS"))
    //         {
    //         }
    //         column(Company_Information_Primary_Key; "Primary Key")
    //         {
    //         }
    //         dataitem("Salary Headers"; "Salary Headers")
    //         {
    //             CalcFields = "Salary basis total", "Net salary cashed", "Retenue CGC", "Loans repaiment total", "Advances repaiment total", "Total taxable", "Taxes total", "Taxable indemnities total", "Total Supp. Hours", "Total Gross salary";
    //             column(Salary_Headers__Paid_days_; "Paid days")
    //             {
    //             }
    //             column(Salary_Headers__Worked_days_; "Worked days")
    //             {
    //             }
    //             column(Salary_Headers__Last_Date_Modified_; "Last Date Modified")
    //             {
    //             }
    //             column(Salary_Headers_Description; Description)
    //             {
    //             }
    //             column(Salary_Headers__No__; "No.")
    //             {
    //             }
    //             column(Salary_Headers_Month; Month)
    //             {
    //             }
    //             column(Salary_Headers_Year; Year)
    //             {
    //             }
    //             column(Salary_Headers__Salary_basis_total_; "Salary basis total")
    //             {
    //                 AutoFormatType = 3;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Taxable_indemnities_total_; "Taxable indemnities total")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Loans_repaiment_total_; "Loans repaiment total")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Advances_repaiment_total_; "Advances repaiment total")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Taxes_total_; "Taxes total")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Net_salary_cashed_; "Net salary cashed")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Total_Gross_salary_; "Total Gross salary")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Total_taxable_; "Total taxable")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Total_Supp__Hours_; "Total Supp. Hours")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__No___Control1180250146; "No.")
    //             {
    //             }
    //             column(Salary_Headers_Month_Control1180250150; Month)
    //             {
    //             }
    //             column(Salary_Headers_Year_Control1180250152; Year)
    //             {
    //             }
    //             column(CNS1; CNS1)
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Directeur; Directeur)
    //             {
    //             }
    //             column(ROUND__Total_taxable__0_001_; ROUND("Total taxable", 0.001))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(ROUND__Taxes_total__0_001_; ROUND("Taxes total", 0.001))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(ROUND__Net_salary_cashed__0_001_; ROUND("Net salary cashed", 0.001))
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Nbre_de_personnel____FORMAT_SalLines_COUNT_; 'Nbre de personnel: ' + FORMAT(SalLines.COUNT))
    //             {
    //             }
    //             column(TOTGENAVN; TOTGENAVN)
    //             {
    //             }
    //             column(Salary_Headers__Retenue_CGC_; "Retenue CGC")
    //             {
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Salary_Headers__Paid_days_Caption; FIELDCAPTION("Paid days"))
    //             {
    //             }
    //             column(Salary_Headers__Worked_days_Caption; FIELDCAPTION("Worked days"))
    //             {
    //             }
    //             column(Salary_Headers__Last_Date_Modified_Caption; FIELDCAPTION("Last Date Modified"))
    //             {
    //             }
    //             column(Salary_Headers_DescriptionCaption; FIELDCAPTION(Description))
    //             {
    //             }
    //             column(Salary_Headers__No__Caption; FIELDCAPTION("No."))
    //             {
    //             }
    //             column(Salary_Headers_MonthCaption; FIELDCAPTION(Month))
    //             {
    //             }
    //             column(Salary_Headers_YearCaption; FIELDCAPTION(Year))
    //             {
    //             }
    //             column(Journal_de_Paie_Caption; Journal_de_Paie_CaptionLbl)
    //             {
    //             }
    //             column(Salaire_de_base_Caption; Salaire_de_base_CaptionLbl)
    //             {
    //             }
    //             column(Ind__Imposable_Caption; Ind__Imposable_CaptionLbl)
    //             {
    //             }
    //             column("Prêts_Caption"; Prêts_CaptionLbl)
    //             {
    //             }
    //             column(Avances_Caption; Avances_CaptionLbl)
    //             {
    //             }
    //             column("Total_Impôt_Caption"; Total_Impôt_CaptionLbl)
    //             {
    //             }
    //             column("Total_Net_perçu_Caption"; Total_Net_perçu_CaptionLbl)
    //             {
    //             }
    //             column(Salaires_bruts_Caption; Salaires_bruts_CaptionLbl)
    //             {
    //             }
    //             column(Salaires_imposables__Caption; Salaires_imposables__CaptionLbl)
    //             {
    //             }
    //             column(Heures_Sup__Caption; Heures_Sup__CaptionLbl)
    //             {
    //             }
    //             column(TotalisationCaption; TotalisationCaptionLbl)
    //             {
    //             }
    //             column(Salary_Headers__No___Control1180250146Caption; FIELDCAPTION("No."))
    //             {
    //             }
    //             column(Salary_Headers_Month_Control1180250150Caption; FIELDCAPTION(Month))
    //             {
    //             }
    //             column(Salary_Headers_Year_Control1180250152Caption; FIELDCAPTION(Year))
    //             {
    //             }
    //             column(Total_cotisation_Caption; Total_cotisation_CaptionLbl)
    //             {
    //             }
    //             column("Direction_GénéraleCaption"; Direction_GénéraleCaptionLbl)
    //             {
    //             }
    //             column(Avantage_en_Nature_Caption; Avantage_en_Nature_CaptionLbl)
    //             {
    //             }
    //             column(Retenu_C_G_C__Caption; Retenu_C_G_C__CaptionLbl)
    //             {
    //             }
    //             dataitem("Salary Lines"; "Salary Lines")
    //             {
    //                 DataItemLink = "No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Employee Posting Group")
    //                                     ORDER(Ascending);
    //                 column(FORMAT_Month___________FORMAT_Year_; FORMAT(Month) + '  ' + FORMAT(Year))
    //                 {
    //                 }
    //                 column("TabDésig_1_"; TabDésig[1])
    //                 {
    //                 }
    //                 column("TabDésig_2_"; TabDésig[2])
    //                 {
    //                 }
    //                 column("TabDésig_3_"; TabDésig[3])
    //                 {
    //                 }
    //                 column("TabDésig_4_"; TabDésig[4])
    //                 {
    //                 }
    //                 column("TabDésig_5_"; TabDésig[5])
    //                 {
    //                 }
    //                 column("TabDésig_6_"; TabDésig[6])
    //                 {
    //                 }
    //                 column("TabDésig_7_"; TabDésig[7])
    //                 {
    //                 }
    //                 column("Groupe_compta__salarié______________Employee_Posting_Group_"; 'Groupe compta. salarié : ' + ' ' + "Employee Posting Group")
    //                 {
    //                 }
    //                 column(Salary_Lines_Name; Name)
    //                 {
    //                 }
    //                 column(Salary_Lines__Gross_Salary_; "Gross Salary")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Taxable_salary_; "Taxable salary")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Taxe__Month__; "Taxe (Month)")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines_Loans; Loans)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines_Advances; Advances)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines_Employee; Employee)
    //                 {
    //                 }
    //                 column(TabTotCNSS_1_; TabTotCNSS[1])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_2_; TabTotCNSS[2])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_3_; TabTotCNSS[3])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_4_; TabTotCNSS[4])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_5_; TabTotCNSS[5])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_6_; TabTotCNSS[6])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TabTotCNSS_7_; TabTotCNSS[7])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(totindem; totindem)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Retenue_CGC_; "Retenue CGC")
    //                 {
    //                 }
    //                 column(Salary_Lines__Taxable_salary__Control1180250096; "Taxable salary")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Taxe__Month___Control1180250097; "Taxe (Month)")
    //                 {
    //                     AutoFormatType = 0;
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines_Loans_Control1180250106; Loans)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines_Advances_Control1180250107; Advances)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Net_salary_cashed__Control1180250109; "Net salary cashed")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Gross_Salary__Control1180250110; "Gross Salary")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Total________Employee_Posting_Group_; 'Total : ' + "Employee Posting Group")
    //                 {
    //                 }
    //                 column(TABTOT_1_; TABTOT[1])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_2_; TABTOT[2])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_3_; TABTOT[3])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_4_; TABTOT[4])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_5_; TABTOT[5])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_6_; TABTOT[6])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TABTOT_7_; TABTOT[7])
    //                 {
    //                     AutoFormatType = 1;
    //                 }
    //                 column(TOTIND; TOTIND)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Salary_Lines__Retenue_CGC__Control1000000062; "Retenue CGC")
    //                 {
    //                 }
    //                 column(EmployeeCaption; EmployeeCaptionLbl)
    //                 {
    //                 }
    //                 column(EmployeeCaption_Control1000000077; EmployeeCaption_Control1000000077Lbl)
    //                 {
    //                 }
    //                 column(Journal_de_Paie_Caption_Control1000000035; Journal_de_Paie_Caption_Control1000000035Lbl)
    //                 {
    //                 }
    //                 column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
    //                 {
    //                 }
    //                 column(Salaire_ImposableCaption; Salaire_ImposableCaptionLbl)
    //                 {
    //                 }
    //                 column(I_R_P_PCaption; I_R_P_PCaptionLbl)
    //                 {
    //                 }
    //                 column("PrêtsCaption"; PrêtsCaptionLbl)
    //                 {
    //                 }
    //                 column(AvancesCaption; AvancesCaptionLbl)
    //                 {
    //                 }
    //                 column("Salaire_Net_PerçuCaption"; Salaire_Net_PerçuCaptionLbl)
    //                 {
    //                 }
    //                 column(CNSSCaption; CNSSCaptionLbl)
    //                 {
    //                 }
    //                 column(Avt_Nature_Caption; Avt_Nature_CaptionLbl)
    //                 {
    //                 }
    //                 column(C_G_CCaption; C_G_CCaptionLbl)
    //                 {
    //                 }
    //                 column(Salary_Lines_No_; "No.")
    //                 {
    //                 }
    //                 column(Salary_Lines_Employee_Posting_Group; "Employee Posting Group")
    //                 {
    //                 }

    //                 trigger OnAfterGetRecord()
    //                 begin

    //                     //  CurrReport.SHOWOUTPUT(OP = OP::JP);
    //                     if OP <> OP::JP then
    //                         CurrReport.Skip();
    //                     CLEAR(TABTOT);
    //                     TOTIND := 0;


    //                     RecSocialContributions.RESET;
    //                     CAV := 0;
    //                     CNS := 0;
    //                     CUMCNS := 0;
    //                     RecSocialContributions.SETRANGE("No.", "No.");
    //                     RecSocialContributions.SETRANGE(Employee, Employee);
    //                     RecSocialContributions.SETFILTER("Social Contribution", '%1|%2', 'COT001', 'COT002');
    //                     IF RecSocialContributions.FIND('-') THEN
    //                         CNS := RecSocialContributions."Real Amount : Employee";

    //                     RecSocialContributions1.SETRANGE("No.", "No.");
    //                     RecSocialContributions1.SETRANGE(Employee, Employee);
    //                     RecSocialContributions1.SETRANGE("Social Contribution", 'CAVIS');
    //                     IF RecSocialContributions1.FIND('-') THEN
    //                         CAV := RecSocialContributions1."Real Amount : Employee";
    //                     CUMCNS := CNS + CAV;

    //                     i := 1;
    //                     RecSocialC.RESET;
    //                     RecSocialC.SETFILTER("Deductible of taxable basis", '%1', TRUE);
    //                     IF RecSocialC.FINDFIRST THEN
    //                         REPEAT
    //                             TabDésig[i] := RecSocialC.Description;
    //                             i += 1
    //                         UNTIL RecSocialC.NEXT = 0;

    //                     // CurrReport.SHOWOUTPUT(OP = OP::JP);
    //                     if OP <> OP::JP then
    //                         CurrReport.Skip();
    //                     CNS1 := CNS1 + CNSS;
    //                     compteur := compteur + 1;
    //                     i := 1;
    //                     //>> DSFT-IMS 29 03 2011
    //                     totindem := 0;
    //                     CLEAR(TabTotCNSS);
    //                     RecSocialC.RESET;
    //                     RecSocialC.SETFILTER("Deductible of taxable basis", '%1', TRUE);
    //                     IF RecSocialC.FINDFIRST THEN
    //                         REPEAT
    //                             RecSocialCont.RESET;
    //                             RecSocialCont.SETFILTER(RecSocialCont."Deductible of taxable basis", '%1', TRUE);
    //                             RecSocialCont.SETRANGE(Employee, Employee);
    //                             RecSocialCont.SETRANGE("Social Contribution", RecSocialC.Code);
    //                             IF RecSocialCont.FINDFIRST THEN BEGIN
    //                                 REPEAT
    //                                     // TabDésig[i]:= RecSocialCont."Social Contribution" ;
    //                                     TabTotCNSS[i] := RecSocialCont."Real Amount : Employee";

    //                                 UNTIL RecSocialCont.NEXT = 0;
    //                             END
    //                             ELSE BEGIN
    //                                 TabTotCNSS[i] := 0;
    //                             END;
    //                             TABTOT[i] += TabTotCNSS[i];
    //                             i += 1;
    //                         UNTIL RecSocialC.NEXT = 0;
    //                     RecIndem.RESET;
    //                     RecIndem.SETFILTER("Avantage en nature", '%1', TRUE);
    //                     RecIndem.SETRANGE("Employee No.", Employee);
    //                     IF RecIndem.FINDFIRST THEN
    //                         REPEAT
    //                             totindem += RecIndem."Real Amount";
    //                         UNTIL RecIndem.NEXT = 0;
    //                     TOTIND += totindem;
    //                     TOTGENAVN += TOTIND;
    //                     //>> DSFT-IMS 29 03 2011
    //                 end;

    //                 trigger OnPreDataItem()
    //                 begin

    //                 end;
    //             }
    //             dataitem(Indemnities; Indemnities)
    //             {
    //                 DataItemLink = "Employee No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Employee Posting Group", Type, "No.", "Employee No.")
    //                                     ORDER(Ascending);
    //             }
    //             dataitem("Social Contributions"; "Social Contributions")
    //             {
    //                 DataItemLink = "No." = FIELD("No.");
    //                 DataItemTableView = SORTING("No.", Employee, Indemnity, "Social Contribution")
    //                                     ORDER(Ascending);
    //             }
    //             dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
    //             {
    //                 DataItemLink = "Payment No." = FIELD("No.");
    //                 DataItemTableView = SORTING("Document type")
    //                                     ORDER(Ascending);

    //                 trigger OnPreDataItem()
    //                 begin
    //                     //CurrReport.CREATETOTALS ("Loan & Advance Lines"."Line Amount");
    //                 end;
    //             }
    //             trigger OnAfterGetRecord()
    //             var
    //             begin

    //                 //    CurrReport.SHOWOUTPUT(OP = OP::JP);
    //                 if OP <> OP::JP then
    //                     CurrReport.Skip();
    //                 HumanR.GET();
    //                 //Directeur :=HumanR."Directeur général" ;
    //                 SalLines.SETFILTER("No.", "Salary Headers"."No.");
    //             end;
    //         }
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(option)
    //             {
    //                 field(PrintStatPages; PrintStatPages)
    //                 {
    //                     Caption = 'Imprimer pages de statistiques';
    //                 }
    //             }

    //             field("Imprimer Etat"; OP)
    //             {
    //                 OptionCaption = 'Journal de paie,Journal de paie comptable';
    //                 //Caption = 'Nom de la société';
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

    // trigger OnInitReport()
    // begin
    //     PrintStatPages := TRUE;

    //     SalLines.FIND('-');
    // end;

    // trigger OnPreReport()
    // begin
    //     compteur := 0;
    // end;

    // var
    //     PrintStatPages: Boolean;
    //     TypeLA: Record "Loan & Advance Type";
    //     detail: Text[50];
    //     OP: Option JP,JPC;
    //     CAV: Decimal;
    //     CNS: Decimal;
    //     CAV1: Decimal;
    //     CNS1: Decimal;
    //     RecSocialContributions: Record "Social Contributions";
    //     RecSocialContributions1: Record "Social Contributions";
    //     compteur: Integer;
    //     Directeur: Text[30];
    //     HumanR: Record 5218;
    //     CUMCNS: Decimal;
    //     SalLines: Record "Salary Lines";
    //     "// IMS": Integer;
    //     RecSocialC: Record "Social Contribution";
    //     RecSocialCont: Record "Social Contributions";
    //     TabTotCNSS: array[20] of Decimal;
    //     i: Integer;
    //     "TabDésig": array[20] of Text[30];
    //     TABTOT: array[20] of Decimal;
    //     RecIndem: Record Indemnities;
    //     totindem: Decimal;
    //     TOTIND: Decimal;
    //     TOTGENAVN: Decimal;
    //     Journal_de_Paie_CaptionLbl: Label 'Journal de Paie ';
    //     Salaire_de_base_CaptionLbl: Label 'Salaire de base:';
    //     Ind__Imposable_CaptionLbl: Label 'Ind. Imposable:';
    //     "Prêts_CaptionLbl": Label 'Prêts:';
    //     Avances_CaptionLbl: Label 'Avances:';
    //     "Total_Impôt_CaptionLbl": Label 'Total Impôt:';
    //     "Total_Net_perçu_CaptionLbl": Label 'Total Net perçu:';
    //     Salaires_bruts_CaptionLbl: Label 'Salaires bruts:';
    //     Salaires_imposables__CaptionLbl: Label 'Salaires imposables :';
    //     Heures_Sup__CaptionLbl: Label 'Heures Sup.:';
    //     TotalisationCaptionLbl: Label 'Totalisation';
    //     Total_cotisation_CaptionLbl: Label 'Total cotisation ';
    //     "Direction_GénéraleCaptionLbl": Label 'Direction Générale';
    //     Avantage_en_Nature_CaptionLbl: Label 'Avantage en Nature ';
    //     Retenu_C_G_C__CaptionLbl: Label 'Retenu C.G.C :';
    //     EmployeeCaptionLbl: Label 'Employee';
    //     EmployeeCaption_Control1000000077Lbl: Label 'Employee';
    //     Journal_de_Paie_Caption_Control1000000035Lbl: Label 'Journal de Paie ';
    //     Salaire_BrutCaptionLbl: Label 'Salaire Brut';
    //     Salaire_ImposableCaptionLbl: Label 'Salaire Imposable';
    //     I_R_P_PCaptionLbl: Label 'I.R.P.P';
    //     "PrêtsCaptionLbl": Label 'Prêts';
    //     AvancesCaptionLbl: Label 'Avances';
    //     "Salaire_Net_PerçuCaptionLbl": Label 'Salaire Net Perçu';
    //     CNSSCaptionLbl: Label 'CNSS';
    //     Avt_Nature_CaptionLbl: Label 'Avt Nature ';
    //     C_G_CCaptionLbl: Label 'C.G.C';




}

