report 50102 "Grand Livre Compte Genereaux 2"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/GrandLivreCompteGenereaux2.rdl';
    // Caption = 'Grand livre comptes généraux 2';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;


    // dataset
    // {
    //     dataitem("G/L Account"; 15)
    //     {
    //         DataItemTableView = SORTING("No.")
    //         WHERE("Account Type" = CONST(Posting));
    //         RequestFilterFields = "No.", "Date Filter";
    //         column(CompanyInfo_Address; CompanyInfo.Address)
    //         {
    //         }
    //         column("Filter"; Filter)
    //         {
    //         }

    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
    //         {
    //         }
    //         column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
    //         {
    //         }
    //         column(FiltreCompte; FiltreCompte)
    //         {
    //         }
    //         column(G_L_Account__TABLECAPTION_________; "G/L Account".TABLECAPTION + ' : ')
    //         {
    //         }
    //         column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
    //         {
    //         }
    //         column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
    //         {
    //         }
    //         column(CompanyInfo_Name; CompanyInfo.Name)
    //         {
    //         }
    //         column(CompanyInfo__Matricule_Fiscale_; CompanyInfo."Matricule Fiscale")
    //         {
    //         }
    //         column(FORMAT_StartDate__________au________FORMAT__EndDate_; FORMAT(StartDate) + '     au     ' + FORMAT(EndDate))
    //         {
    //         }
    //         column(FiltreTypeEcriture; FiltreTypeEcriture)
    //         {
    //         }
    //         column(FiltreTypeOrigine; FiltreTypeOrigine)
    //         {
    //         }
    //         column(FiltreNumOrigine; FiltreNumOrigine)
    //         {
    //         }
    //         column(FiltreCodeJournal; FiltreCodeJournal)
    //         {
    //         }
    //         column(FiltreLettre; FiltreLettre)
    //         {
    //         }
    //         column(G_L_Account__No__; "No.")
    //         {
    //         }
    //         column(G_L_Account_Name; Name)
    //         {
    //         }
    //         column(G_L_Account___Credit_Amount____GLAccount2__Credit_Amount_; "G/L Account"."Credit Amount" + GLAccount2."Credit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Account___Debit_Amount____GLAccount2__Debit_Amount_; "G/L Account"."Debit Amount" + GLAccount2."Debit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(Solde; Solde)
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
    //         {
    //         }
    //         column(GLAccount2__Credit_Amount_; GLAccount2."Credit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(GLAccount2__Debit_Amount_; GLAccount2."Debit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(Solde_Control1000000023; Solde)
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
    //         {
    //         }
    //         column(G_L_Account__G_L_Account___Credit_Amount_; "G/L Account"."Credit Amount")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Account__G_L_Account___Debit_Amount_; "G/L Account"."Debit Amount")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Solde_Control1000000025; Solde)
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry___Debit_Amount_____G_L_Entry___Credit_Amount_; "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry___Credit_Amount_; "G/L Entry"."Credit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry___Debit_Amount_; "G/L Entry"."Debit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry___Credit_Amount__GLAccount2__Credit_Amount_; "G/L Entry"."Credit Amount" + GLAccount2."Credit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(G_L_Entry___Debit_Amount__GLAccount2__Debit_Amount_; "G/L Entry"."Debit Amount" + GLAccount2."Debit Amount")
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(Solde_Control1000000031; Solde)
    //         {
    //             // DecimalPlaces = 3 : 3;
    //         }
    //         column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
    //         {
    //         }
    //         column(Cust__Ledger_EntryCaption_Control1120146; Cust__Ledger_EntryCaption_Control1120146Lbl)
    //         {
    //         }
    //         column(DescriptionCaption; DescriptionCaptionLbl)
    //         {
    //         }
    //         column(Posting_DateCaption; Posting_DateCaptionLbl)
    //         {
    //         }
    //         column(Document_No_Caption; Document_No_CaptionLbl)
    //         {
    //         }
    //         column(External_Document_No_Caption; External_Document_No_CaptionLbl)
    //         {
    //         }
    //         column(DebitCaption; DebitCaptionLbl)
    //         {
    //         }
    //         column(CreditCaption; CreditCaptionLbl)
    //         {
    //         }
    //         column(Source_CodeCaption; Source_CodeCaptionLbl)
    //         {
    //         }
    //         column(External_Document_No_Caption_Control1120006; External_Document_No_Caption_Control1120006Lbl)
    //         {
    //         }
    //         column(FolioCaption; FolioCaptionLbl)
    //         {
    //         }
    //         column(BalanceCaption; BalanceCaptionLbl)
    //         {
    //         }
    //         column(BalanceCaption_Control1100267000; BalanceCaption_Control1100267000Lbl)
    //         {
    //         }
    //         column(CreditCaption_Control1000000016; CreditCaption_Control1000000016Lbl)
    //         {
    //         }
    //         column(ContinuedCaption; ContinuedCaptionLbl)
    //         {
    //         }
    //         column(To_be_continuedCaption; To_be_continuedCaptionLbl)
    //         {
    //         }
    //         column(To_be_continuedCaption_Control1120271; To_be_continuedCaption_Control1120271Lbl)
    //         {
    //         }
    //         column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
    //         {
    //         }
    //         column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
    //         {
    //         }
    //         // column(STRSUBSTNO_Text004_PreviousStartDate_; StrSubstNo(Text004, PreviousStartDate))
    //         // {
    //         // }
    //         column(PageCaption; StrSubstNo(Text005, ' '))
    //         {
    //         }
    //         column(UserCaption; StrSubstNo(Text003, ''))
    //         {
    //         }
    //         column(GLAccountTABLECAPTIONAndFilter; "G/L Account".TableCaption + ': ' + Filter)
    //         {
    //         }
    //         // column("Filter"; Filter)
    //         // {
    //         // }
    //         column(FiscalYearStatusText; FiscalYearStatusText)
    //         {
    //         }
    //         column(No_GLAccount; "No.")
    //         {
    //         }
    //         column(Name_GLAccount; Name)
    //         {
    //         }
    //         column(DebitAmount_GLAccount; "G/L Account"."Debit Amount")
    //         {
    //         }
    //         column(CreditAmount_GLAccount; "G/L Account"."Credit Amount")
    //         {
    //         }
    //         // column(STRSUBSTNO_Text006_PreviousEndDate_; StrSubstNo(Text006, PreviousEndDate))
    //         // {
    //         // }
    //         column(DebitAmount_GLAccount2; GLAccount2."Debit Amount")
    //         {
    //         }
    //         column(CreditAmount_GLAccount2; GLAccount2."Credit Amount")
    //         {
    //         }
    //         // column(STRSUBSTNO_Text006_EndDate_; StrSubstNo(Text006, EndDate))
    //         // {
    //         // }
    //         // column(ShowBodyGLAccount; ShowBodyGLAccount)
    //         // {
    //         // }
    //         // column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
    //         // {
    //         // }
    //         // column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
    //         // {
    //         // }
    //         column(G_L_Detail_Trial_BalanceCaption; G_L_Detail_Trial_BalanceCaptionLbl)
    //         {
    //         }
    //         // column(Posting_DateCaption; Posting_DateCaptionLbl)
    //         // {
    //         // }
    //         // column(Source_CodeCaption; Source_CodeCaptionLbl)
    //         // {
    //         // }
    //         // column(Document_No_Caption; Document_No_CaptionLbl)
    //         // {
    //         // }
    //         // column(External_Document_No_Caption; External_Document_No_CaptionLbl)
    //         // {
    //         // }
    //         // column(DescriptionCaption; DescriptionCaptionLbl)
    //         // {
    //         // }
    //         // column(DebitCaption; DebitCaptionLbl)
    //         // {
    //         // }
    //         // column(CreditCaption; CreditCaptionLbl)
    //         // {
    //         // }
    //         // column(BalanceCaption; BalanceCaptionLbl)
    //         // {
    //         // }
    //         column(Grand_TotalCaption; Grand_TotalCaptionLbl)
    //         {
    //         }
    //         column(ShowBodyGLAccount; ShowBodyGLAccount)
    //         {
    //         }
    //         column(StartDate; Format(StartDate)) { }
    //         column(EndDate; Format(EndDate)) { }
    //         column(NoFolio; NoFolio)
    //         {
    //         }
    //         column(debit2; debit2)
    //         {

    //         }
    //         column(credit2; credit2)
    //         {

    //         }
    //         dataitem(Date; 2000000007)
    //         {
    //             DataItemTableView = SORTING("Period Type");
    //             PrintOnlyIfDetail = true;
    //             // column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
    //             // {
    //             // }
    //             column(STRSUBSTNO_Text007_EndDate_; StrSubstNo(Text007, EndDate))
    //             {
    //             }
    //             column(Date_PeriodNo; Date."Period No.")
    //             {
    //             }
    //             column(PostingYear; Date2DMY("G/L Entry"."Posting Date", 3))
    //             {
    //             }
    //             column(Date_Period_Type; "Period Type")
    //             {
    //             }
    //             column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
    //             {
    //             }
    //             dataitem("G/L Entry"; 17)
    //             {
    //                 DataItemLink = "G/L Account No." = FIELD("No."),
    //                                "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
    //                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
    //                 DataItemLinkReference = "G/L Account";
    //                 DataItemTableView = SORTING("G/L Account No.");
    //                 RequestFilterFields = "Source Type", "Source No.", "Source Code", Letter;
    //                 column(G_L_Entry__Debit_Amount_; "Debit Amount")
    //                 {
    //                 }
    //                 column(TotalByInt; TotalByInt)
    //                 {
    //                 }
    //                 column(G_L_Entry__Credit_Amount_; "Credit Amount")
    //                 {
    //                 }
    //                 column(G_L_Account__Name; "G/L Account".Name)
    //                 {
    //                 }
    //                 column(G_L_Account___No__; "G/L Account"."No.")
    //                 {
    //                 }
    //                 column(G_L_Entry__Credit_Amount__Control1000000027; "Credit Amount")
    //                 {
    //                 }
    //                 column(G_L_Entry__Posting_Date_; "Posting Date")
    //                 {
    //                 }
    //                 column(G_L_Entry__Source_Code_; "Source Code")
    //                 {
    //                 }
    //                 column(G_L_Entry__Document_No__; "Document No.")
    //                 {
    //                 }
    //                 column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
    //                 {
    //                 }
    //                 column(G_L_Entry__External_Document_No__; "External Document No.")
    //                 {
    //                 }
    //                 column(G_L_Entry__G_L_Entry__Description; "G/L Entry".Description)
    //                 {
    //                 }
    //                 column(G_L_Entry__Debit_Amount__Control1120116; "Debit Amount")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(G_L_Entry__Credit_Amount__Control1120119; "Credit Amount")
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(G_L_Entry_Letter; Letter)
    //                 {
    //                 }

    //                 column(G_L_Entry__Source_No__; "Source No.")
    //                 {
    //                 }
    //                 column(LibelleOrigine; LibelleOrigine)
    //                 {
    //                 }
    //                 column(Solde_Control1000000014; Solde)
    //                 {
    //                     DecimalPlaces = 3 : 3;
    //                 }
    //                 column(Previous_pageCaption; Previous_pageCaptionLbl)
    //                 {
    //                 }
    //                 column(ContinuedCaption_Control1120008; ContinuedCaption_Control1120008Lbl)
    //                 {
    //                 }
    //                 column(G_L_Entry_Entry_No_; "Entry No.")
    //                 {
    //                 }
    //                 column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
    //                 {
    //                 }
    //                 column(G_L_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
    //                 {
    //                 }
    //                 column(G_L_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
    //                 {
    //                 }
    //                 column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
    //                 {
    //                 }
    //                 column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
    //                 {
    //                 }
    //                 column(PostingDate_GLEntry; Format("Posting Date"))
    //                 {
    //                 }
    //                 column(SourceCode_GLEntry; "Source Code")
    //                 {
    //                 }
    //                 column(DocumentNo_GLEntry; "Document No.")
    //                 {
    //                 }
    //                 column(Source_No_GLEntry; "Source No.")
    //                 {
    //                 }
    //                 column(ExternalDocumentNo_GLEntry; "External Document No.")
    //                 {
    //                 }
    //                 column(Description_GLEntry; Description)
    //                 {
    //                 }
    //                 column(Balance; Balance)
    //                 {
    //                 }
    //                 // column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
    //                 // {
    //                 // }
    //                 column(Date_PeriodType_PeriodName; Text008 + ' ' + Format(Date."Period Type") + ' ' + Date."Period Name")
    //                 {
    //                 }
    //                 // column(TotalByInt; TotalByInt)
    //                 // // {
    //                 // // }

    //                 trigger OnAfterGetRecord()
    //                 begin
    //                     IF ("Debit Amount" = 0) AND
    //                        ("Credit Amount" = 0) THEN
    //                         CurrReport.SKIP;
    //                     Solde := Solde + "Debit Amount" - "Credit Amount";
    //                     // >> HJ SORO 09-01-2016
    //                     LibelleOrigine := '';
    //                     IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
    //                         IF Vendor.GET("Source No.") THEN
    //                             LibelleOrigine := Vendor.Name;
    //                     END;
    //                     IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer THEN BEGIN
    //                         IF Customer.GET("Source No.") THEN
    //                             LibelleOrigine := Customer.Name;
    //                     END;
    //                     IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Bank Account" THEN BEGIN
    //                         IF Bank.GET("Source No.") THEN
    //                             LibelleOrigine := Bank.Name;
    //                     END;
    //                     IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::"Fixed Asset" THEN BEGIN
    //                         IF Immo.GET("Source No.") THEN
    //                             LibelleOrigine := Immo.Description;
    //                     END;

    //                     // >> HJ SORO 09-01-2016

    //                     NoFolio := '';
    //                     RecGLEntry.SETCURRENTKEY("Document No.", "Posting Date");
    //                     RecGLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
    //                     RecGLEntry.SETFILTER("Folio N°", '<> %1', '');
    //                     IF RecGLEntry.FINDFIRST THEN
    //                         REPEAT
    //                             IF RecGLEntry."Folio N°" <> '0' THEN
    //                                 NoFolio := RecGLEntry."Folio N°";
    //                         UNTIL RecGLEntry.NEXT = 0;

    //                     // RB SORO 17/04/2015
    //                 end;

    //                 trigger OnPreDataItem()
    //                 begin
    //                     IF DocNumSort THEN
    //                         SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
    //                     SETRANGE("Posting Date", Date."Period Start", Date."Period End");


    //                     if EndDateIsClosing then
    //                         SetRange("Posting Date", Date."Period Start", Date."Period End")
    //                     else
    //                         SetRange("Posting Date", Date."Period Start", NormalDate(Date."Period End"));
    //                     //CurrReport.SHOWOUTPUT := ("G/L Account"."Direct Posting") OR
    //                     //                         (Date."Period Type" = Date."Period Type"::Year)
    //                     // RB SORO 17/04/2015 N° FOLIO



    //                 end;
    //             }

    //             trigger OnPreDataItem()
    //             begin
    //                 SETRANGE("Period Type", TotalBy);
    //                 SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
    //                 CurrReport.CREATETOTALS("G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount");
    //             end;
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             /*   GLAccount2.COPY("G/L Account");
    //                WITH GLAccount2 DO BEGIN
    //                    IF "Income/Balance" = 0 THEN
    //                        SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate)
    //                    ELSE
    //                        SETRANGE("Date Filter", 0D, PreviousEndDate);
    //                    CALCFIELDS("Debit Amount", "Credit Amount");
    //                    Solde := GLAccount2."Debit Amount" - GLAccount2."Credit Amount";
    //                END;
    //                IF "Income/Balance" = 0 THEN
    //                    SETRANGE("Date Filter", StartDate, EndDate)
    //                ELSE
    //                    SETRANGE("Date Filter", 0D, EndDate);
    //                CALCFIELDS("Debit Amount", "Credit Amount");
    //                IF ("Debit Amount" = 0) AND ("Credit Amount" = 0) THEN
    //                    CurrReport.SKIP;*/



    //             GLAccount2.Copy("G/L Account");
    //             if GLAccount2."Income/Balance" = 0 then
    //                 GLAccount2.SetRange("Date Filter", PreviousStartDate, PreviousEndDate)
    //             else
    //                 GLAccount2.SetRange("Date Filter", 0D, PreviousEndDate);
    //             GLAccount2.CalcFields("Debit Amount", "Credit Amount");
    //             GLAccount2.Balance := GLAccount2."Debit Amount" - GLAccount2."Credit Amount";
    //             if "Income/Balance" = 0 then
    //                 SetRange("Date Filter", StartDate, EndDate)
    //             else
    //                 SetRange("Date Filter", 0D, EndDate);
    //             CalcFields("Debit Amount", "Credit Amount");
    //             if ("Debit Amount" = 0) and ("Credit Amount" = 0) then
    //                 CurrReport.Skip();




    //             debit2 += GLAccount2."Debit Amount";
    //             credit2 += GLAccount2."Credit Amount";



    //             ShowBodyGLAccount :=
    //          ((GLAccount2."Debit Amount" = "Debit Amount") and (GLAccount2."Credit Amount" = "Credit Amount")) or ("Account Type" <> "Account Type"::Posting);
    //         end;

    //         trigger OnPreDataItem()
    //         begin



    //             IF "G/L Account".GETFILTER("G/L Account"."No.") <> '' THEN
    //                 FiltreCompte := "G/L Account".GETFILTER("G/L Account"."No.")
    //             ELSE
    //                 FiltreCompte := 'Tous';
    //             //test
    //             FiltreDate := GETFILTER("Date Filter");


    //             CompanyInfo.GET;
    //             IF GETFILTER("Date Filter") = '' THEN
    //                 ERROR(Text001, FIELDCAPTION("Date Filter"));
    //             IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
    //                 ERROR(Text002);
    //             StartDate := GETRANGEMIN("Date Filter");
    //             Period.SETRANGE("Period Start", StartDate);
    //             CASE TotalBy OF
    //                 TotalBy::" ":
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Date);
    //                 TotalBy::Semaine:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Week);
    //                 TotalBy::Mois:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Month);
    //                 TotalBy::Trimestre:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
    //                 TotalBy::"Année":
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Year);
    //             END;
    //             IF NOT Period.FIND('-') THEN
    //                 ERROR(Text010, StartDate, Period.GETFILTER("Period Type"));
    //             PreviousEndDate := CLOSINGDATE(StartDate - 1);
    //             FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
    //             TextDate := CONVERTSTR(TextDate, '.', ',');
    //             // FiltreDateCalc.VerifiyDateFilter(TextDate);
    //             TextDate := COPYSTR(TextDate, 1, 8);
    //             EVALUATE(PreviousStartDate, TextDate);
    //             IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
    //                 EndDate := 0D
    //             ELSE
    //                 EndDate := GETRANGEMAX("Date Filter");
    //             CLEAR(Period);
    //             Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
    //             CASE TotalBy OF
    //                 TotalBy::" ":
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Date);
    //                 TotalBy::Semaine:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Week);
    //                 TotalBy::Mois:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Month);
    //                 TotalBy::Trimestre:
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
    //                 TotalBy::"Année":
    //                     Period.SETRANGE("Period Type", Period."Period Type"::Year);
    //             END;
    //             IF NOT Period.FIND('-') THEN
    //                 ERROR(Text011, EndDate, Period.GETFILTER("Period Type"));
    //             TotalByInt := TotalBy;
    //             EndDateIsClosing := EndDate = ClosingDate(EndDate);




    //         end;
    //     }
    // }

    // requestpage
    // {



    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';
    //                 field("Centralisé par"; TotalBy)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Centralisé par';

    //                 }


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
    //     TotalBy := TotalBy::Mois;
    // end;



    // trigger OnPreReport()
    // begin
    //     ExcelBuf.DELETEALL;
    //     Filter := "G/L Account".GETFILTERS;

    //     //<< Ajouté MYC 101008

    //     // JBS. 28/05/2025

    //     // IF  "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter") <>'' THEN
    //     //   FiltreTypeEcriture:='Type Ecriture : '+  "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter")
    //     // ELSE
    //     //   FiltreTypeEcriture:='';

    //     IF "G/L Entry".GETFILTER("G/L Entry"."Source Type") <> '' THEN
    //         FiltreTypeOrigine := 'Type Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Type")
    //     ELSE
    //         FiltreTypeOrigine := '';

    //     IF "G/L Entry".GETFILTER("G/L Entry"."Source No.") <> '' THEN
    //         FiltreNumOrigine := 'N° Origine: ' + "G/L Entry".GETFILTER("G/L Entry"."Source No.")
    //     ELSE
    //         FiltreNumOrigine := '';

    //     IF "G/L Entry".GETFILTER("G/L Entry"."Source Code") <> '' THEN
    //         FiltreCodeJournal := 'Code Journal: ' + "G/L Entry".GETFILTER("G/L Entry"."Source Code")
    //     ELSE
    //         FiltreCodeJournal := '';

    //     IF "G/L Entry".GETFILTER("G/L Entry".Letter) <> '' THEN
    //         FiltreLettre := 'Lettre: ' + "G/L Entry".GETFILTER("G/L Entry".Letter)
    //     ELSE
    //         FiltreLettre := '';


    //     //>> Ajouté MYC 101008
    // end;

    // var
    //     Text001: Label 'Vous devez renseigner le champ %1.';
    //     Text002: Label 'Vous devez spécifier une date de début.';
    //     Text003: Label 'Imprimé par %1';
    //     Text004: Label 'Début exercice comptable : %1';
    //     Text005: Label 'Page %1';
    //     Text006: Label 'Solde au %1 ';
    //     Text007: Label 'Solde au %1';
    //     Text008: Label 'Total';
    //     GLAccount2: Record 15;
    //     FiltreDateCalc: Codeunit 358;
    //     StartDate: Date;
    //     EndDate: Date;
    //     PreviousStartDate: Date;
    //     PreviousEndDate: Date;
    //     TextDate: Text[30];
    //     Solde: Decimal;
    //     TotalBy: Option " ",Semaine,Mois,Trimestre,Année;
    //     DocNumSort: Boolean;
    //     "Filter": Text[250];
    //     PeriodText: Text[30];
    //     Text009: Label 'Cet état inclut les écritures de simulation.';
    //     Text010: Label 'La date de début choisie (%1) ne correspond pas au début de %2.';
    //     Text011: Label 'La date de fin choisie (%1) ne correspond pas à la fin de %2.';
    //     Period: Record 2000000007;
    //     FYFiscalClose: Codeunit 10862;
    //     FiscalYearStatusText: Text[80];
    //     Text012: Label 'Statut de l''exercice comptable : %1';
    //     CompanyInfo: Record 79;
    //     FiltreCompte: Text[30];
    //     "--": Integer;
    //     ExcelBuf: Record 370;
    //     PrintToExcel: Boolean;
    //     BlankFiller: Text[250];
    //     FiltreDate: Text[30];
    //     FiltreTypeEcriture: Text[100];
    //     FiltreTypeOrigine: Text[30];
    //     FiltreNumOrigine: Text[50];
    //     FiltreCodeJournal: Text[30];
    //     FiltreLettre: Text[100];
    //     FiltreAffichLettrage: Option " ","Non Lettré","Lettré";
    //     "// RB SORO 17/04/2015": Integer;
    //     NoFolio: Code[20];
    //     RecGLEntry: Record 17;
    //     LibelleOrigine: Text[100];
    //     Vendor: Record 23;
    //     ShowBodyGLAccount: Boolean;
    //     TotalByInt: Integer;
    //     Customer: Record 18;
    //     Bank: Record 270;
    //     Immo: Record 5600;
    //     Cust__Ledger_EntryCaptionLbl: Label 'Grand livre comptes généraux';
    //     Cust__Ledger_EntryCaption_Control1120146Lbl: Label 'Grand livre comptes généraux';
    //     DescriptionCaptionLbl: Label 'Libellé écriture';
    //     Posting_DateCaptionLbl: Label 'Date';
    //     Document_No_CaptionLbl: Label 'Document';
    //     External_Document_No_CaptionLbl: Label 'Origine';
    //     DebitCaptionLbl: Label 'Débit';
    //     CreditCaptionLbl: Label 'Crédit';
    //     Source_CodeCaptionLbl: Label 'Journal';
    //     External_Document_No_Caption_Control1120006Lbl: Label 'Origine';
    //     FolioCaptionLbl: Label 'Folio';
    //     BalanceCaptionLbl: Label 'Solde';
    //     BalanceCaption_Control1100267000Lbl: Label 'Solde';
    //     CreditCaption_Control1000000016Lbl: Label 'Crédit';

    //     Total_Date_RangeCaptionLbl: Label 'Total de la periode';
    //     FiscalYearFiscalClose: Codeunit "Fiscal Year-FiscalClose";
    //     DateFilterCalc: Codeunit "DateFilter-Calc";
    //     Balance: Decimal;

    //     Grand_TotalCaptionLbl: Label 'Total Général';

    //     ContinuedCaptionLbl: Label 'Continué';
    //     To_be_continuedCaptionLbl: Label 'À suivre';
    //     To_be_continuedCaption_Control1120271Lbl: Label 'À suivre';
    //     Previous_pageCaptionLbl: Label 'Page précédente';
    //     ContinuedCaption_Control1120008Lbl: Label 'Continué';
    //     G_L_Detail_Trial_BalanceCaptionLbl: Label 'Grand livre comptes généraux';
    //     debit2: Decimal;
    //     credit2: Decimal;
    //     EndDateIsClosing: Boolean;








}

