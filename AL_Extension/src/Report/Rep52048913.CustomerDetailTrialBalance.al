// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Sales.Reports;

using Microsoft.Foundation.Period;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;
using System.Utilities;
using Microsoft.Finance.Currency;

report 52048913 "Grand livre clients 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Grand livre clients 2.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Grand livre clients 2';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Customer Posting Group", "Currency Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(STRSUBSTNO_Text003_USERID_; StrSubstNo(Text003, UserId))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; StrSubstNo(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; StrSubstNo(Text005, ''))
            {
            }
            column(PrintedByCaption; StrSubstNo(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Customer_TABLECAPTION__________Filter; Customer.TableCaption + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(ReportDebitAmountLCY; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; StrSubstNo(Text006, PreviousEndDate))
            {
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY; GeneralDebitAmountLCY)
            {
            }
            column(GeneralCreditAmountLCY; GeneralCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY_GeneralCreditAmountLCY; GeneralDebitAmountLCY - GeneralCreditAmountLCY)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Currency_Filter; "Currency Filter")
            {
            }
            column(Customer_Detail_Trial_BalanceCaption; Customer_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_customers_that_only_have_balances_Caption; This_report_also_includes_customers_that_only_have_balances_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = sorting("Period Type");
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY_; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(STRSUBSTNO_Text006_EndDate_; StrSubstNo(Text006, EndDate))
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; StrSubstNo(Text007, EndDate))
                {
                }
                column(DebitPeriodAmount; DebitPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Control1120082; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(CreditPeriodAmount; CreditPeriodAmount)
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Control1120086; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_CreditPeriodAmount; DebitPeriodAmount - CreditPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Control1120090; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter"), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"), "Currency Code" = field("Currency Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = sorting("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code") where("Entry Type" = filter(<> Application));
                    column(PreviousOriginalLedgerEntryDesc; OriginalLedgerEntry.Description)
                    {
                    }

                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__; "Debit Amount")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__; "Credit Amount")
                    {
                    }
                    column(BalanceD; BalanceD)
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Posting_Date_; Format("Posting Date"))
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + Format(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(DatePeriodTypeInt; DatePeriodTypeInt)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Currency_Code; "Currency Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(PostingYearValue; Format(Date2DMY("Posting Date", 3)))
                    {
                    }
                    column(OriginalLedgerEntryDesc; OriginalLedgerEntry.Description)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var

                    begin

                        // >> HJ SORO 26-10-2016
                        CLEAR(OriginalLedgerEntry2);
                        OriginalLedgerEntry2.GET("Cust. Ledger Entry No.");

                        IF (OriginalLedgerEntry2.Lettre <> '') AND LettrageCompatable THEN BEGIN
                            BollGLettré := TRUE;
                            CLEAR(RecCustLedgerEntry);
                            RecCustLedgerEntry.SETCURRENTKEY(Lettre);
                            RecCustLedgerEntry.SETRANGE(Lettre, OriginalLedgerEntry2.Lettre);
                            IF RecCustLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    RecCustLedgerEntry.CALCFIELDS(RecCustLedgerEntry."Remaining Amount");
                                    IF RecCustLedgerEntry."Remaining Amount" <> 0 THEN BollGLettré := FALSE;
                                    IF DATE2DMY(RecCustLedgerEntry."Posting Date", 3) <> DATE2DMY("Detailed Cust. Ledg. Entry".GETRANGEMAX("Posting Date"), 3) THEN
                                        BollGLettré := FALSE;

                                UNTIL RecCustLedgerEntry.NEXT = 0;
                            IF NOT BollGLettré THEN OriginalLedgerEntry2.Lettre := '';
                        END;
                        // >> HJ SORO 26-10-2016


                        //MakeExcelDataBody1;
                        IF RecCustLedgerEntry.GET("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.") THEN;
                        RecCustLedgerEntry.SETRANGE(RecCustLedgerEntry."Posting Date", Customer."Date Filter");
                        RecCustLedgerEntry.CALCFIELDS(RecCustLedgerEntry."Remaining Amount");
                        IF RecCustLedgerEntry."Remaining Amount" <> 0 THEN
                            BollGLettré := FALSE
                        ELSE
                            BollGLettré := TRUE;
                        RecCustomer.RESET;
                        IF RecCustomer.GET("Customer No.") THEN;
                        // >> HJ SORO 26-10-2016
                        YouSkip := FALSE;
                        IF DATE2DMY("Posting Date", 3) = DATE2DMY("Detailed Cust. Ledg. Entry".GETRANGEMIN("Posting Date"), 3) THEN BEGIN

                            CLEAR(OriginalLedgerEntry3);
                            OriginalLedgerEntry3.GET("Cust. Ledger Entry No.");

                            IF (OriginalLedgerEntry3.Lettre <> '') AND LettrageCompatable THEN BEGIN
                                YouSkip := TRUE;
                                CLEAR(RecCustLedgerEntry);
                                RecCustLedgerEntry.SETCURRENTKEY(Lettre);
                                RecCustLedgerEntry.SETRANGE(Lettre, OriginalLedgerEntry3.Lettre);
                                IF RecCustLedgerEntry.FINDFIRST THEN
                                    REPEAT
                                        IF DATE2DMY(RecCustLedgerEntry."Posting Date", 3) > DATE2DMY("Detailed Cust. Ledg. Entry".GETRANGEMIN("Posting Date"), 3) THEN
                                            YouSkip := FALSE;
                                        RecCustLedgerEntry.CALCFIELDS(RecCustLedgerEntry."Remaining Amount");
                                        IF RecCustLedgerEntry."Remaining Amount" <> 0 THEN YouSkip := FALSE;

                                    UNTIL RecCustLedgerEntry.NEXT = 0;

                            END;
                            IF YouSkip THEN CurrReport.SKIP;
                        END;
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.Skip();
                        //     BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                        IF NOT YouSkip THEN BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                        OriginalLedgerEntry.Get("Cust. Ledger Entry No.");

                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";

                        DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                        CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";


                        //>>MHM Devise
                        BalanceD := BalanceD + "Debit Amount" - "Credit Amount";
                        //<<MHM Devise
                        //>>MHM Devise
                        GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                        GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                        //<<MHM Devise
                        //>>MHM Devise
                        DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                        CreditPeriodAmountD := CreditPeriodAmountD + "Credit Amount";
                        //<<MHM Devise

                    end;

                    trigger OnPostDataItem()
                    begin
                        ReportDebitAmountLCY := ReportDebitAmountLCY + "Debit Amount (LCY)";
                        ReportCreditAmountLCY := ReportCreditAmountLCY + "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SetCurrentKey("Customer No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SetRange("Posting Date", Date."Period Start", Date."Period End");
                        IF CodeDevise <> '' THEN SETRANGE("Currency Code", CodeDevise);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    DatePeriodTypeInt := Date."Period Type";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Period Type", TotalBy);
                    SetRange("Period Start", CalcDate('<-CM>', StartDate), ClosingDate(EndDate));
                    CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustLedgEntry.SetCurrentKey(
                  "Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                CustLedgEntry.SetRange("Customer No.", "No.");
                CustLedgEntry.SetRange("Posting Date", 0D, PreviousEndDate);
                CustLedgEntry.SetFilter(
                  "Entry Type",
                  '<>%1&<>%2',
                  CustLedgEntry."Entry Type"::Application,
                  CustLedgEntry."Entry Type"::"Appln. Rounding");

                CustLedgEntry.CalcSums("Debit Amount (LCY)", "Credit Amount (LCY)");
                PreviousDebitAmountLCY := CustLedgEntry."Debit Amount (LCY)";
                PreviousCreditAmountLCY := CustLedgEntry."Credit Amount (LCY)";

                CustLedgEntry2.CopyFilters(CustLedgEntry);
                CustLedgEntry2.SetRange("Posting Date", StartDate, EndDate);
                if not (ExcludeBalanceOnly and CustLedgEntry2.IsEmpty) then begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") = '' then
                    Error(Text001, FieldCaption("Date Filter"));
                if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                    Error(Text002);
                StartDate := GetRangeMin("Date Filter");
                PreviousEndDate := ClosingDate(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := ConvertStr(TextDate, '.', ',');
                //     FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := CopyStr(TextDate, 1, 8);
                Evaluate(PreviousStartDate, TextDate);
                if CopyStr(GetFilter("Date Filter"), StrLen(GetFilter("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GetRangeMax("Date Filter");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocNumSort; DocNumSort)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trié par n° document';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclure seulement les clients qui ont un solde ouvert';
                        MultiLine = true;
                    }
                    field(TotalBy; TotalBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Centralisé par';
                    }
                    field(CodeDevise; CodeDevise)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Code Devise';
                        TableRelation = Currency;
                        //   Visible = CodeDeviseVisible;

                    }
                    field(LettrageCompatable; LettrageCompatable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lettrage Compatable';
                        ToolTip = 'Lettrage Compatable';
                    }

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month;
    end;

    trigger OnPreReport()
    begin
        Filter := Customer.GetFilters();
    end;

    var
        CodeDevise: Code[20];
        BalanceD: Decimal;
        DebitPeriodAmountD: Decimal;
        CreditPeriodAmountD: Decimal;
        GeneralDebitAmount: Decimal;
        GeneralCreditAmount: Decimal;
        YouSkip: Boolean;
        RecCustomer: Record 18;
        //   OriginalLedgerEntry: Record 21;
        OriginalLedgerEntry2: Record 21;
        OriginalLedgerEntry3: Record 21;
        LettrageCompatable: Boolean;
        RecCustLedgerEntry: Record 21;
        Text001: Label 'Vous devez renseigner le champ %1.';
        Text002: Label 'Vous devez spécifier une date de début.';
        Text003: Label 'Imprimé par %1';
        Text004: Label 'Début exercice comptable : %1';
        Text005: Label 'Page %1';
        Text006: Label 'Solde au %1';
        Text007: Label 'Solde au %1';
        Text008: Label 'Total';
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        OriginalLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        BalanceLCY: Decimal;
        TotalBy: Option Date,Week,Month,Quarter,Year;
        DocNumSort: Boolean;
        "Filter": Text;
        "BollGLettré": Boolean;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        GeneralCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;
        ExcludeBalanceOnly: Boolean;
        DatePeriodTypeInt: Integer;
        Customer_Detail_Trial_BalanceCaptionLbl: Label 'Grand livre clients';
        This_report_also_includes_customers_that_only_have_balances_CaptionLbl: Label 'Cet état inclut aussi les clients ayant un solde ouvert.';
        ContinuedCaptionLbl: Label 'Continué';
        Posting_DateCaptionLbl: Label 'Date comptabilisation';
        Source_CodeCaptionLbl: Label 'Code source';
        Document_No_CaptionLbl: Label 'N° document';
        External_Document_No_CaptionLbl: Label 'N° doc. externe';
        DescriptionCaptionLbl: Label 'Désignation';
        DebitCaptionLbl: Label 'Débit';
        CreditCaptionLbl: Label 'Crédit';
        BalanceCaptionLbl: Label 'Solde';
        To_be_continuedCaptionLbl: Label 'À suivre';

        Grand_TotalCaptionLbl: Label 'Total général';
        Total_Date_RangeCaptionLbl: Label 'Total de la période';
        Previous_pageCaptionLbl: Label 'Page précédente';
        Current_pageCaptionLbl: Label 'Page en cours';
}

