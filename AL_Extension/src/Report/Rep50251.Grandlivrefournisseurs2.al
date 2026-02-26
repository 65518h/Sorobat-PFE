// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Purchases.Reports;

using Microsoft.Foundation.Period;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.Vendor;
using System.Utilities;
using Microsoft.Finance.Currency;

report 50251 "Grand livre fournisseurs 2"
{
    //report 50251
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/VendorDetailTrialBalanceFR2.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Grand livre fournisseurs 2';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(Dev; Dev) { }////

            column(GeneralDebitAmount_GeneralCreditAmount; GeneralDebitAmount - GeneralCreditAmount)
            {
            }
            column(Vendor_Posting_Group; "Vendor Posting Group")
            {
            }
            column(Vendor_TABLECAPTION_________; Vendor.TABLECAPTION + ' : ')
            {
            }
            column(GeneralCreditAmount; GeneralCreditAmount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(GeneralDebitAmount; GeneralDebitAmount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Vendor__Vendor_Posting_Group_; "Vendor Posting Group")
            {
            }
            column(ReportDebitAmount; ReportDebitAmount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(ReportCreditAmount; ReportCreditAmount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(ReportDebitAmount_ReportCreditAmount; ReportDebitAmount - ReportCreditAmount)
            {
                AutoFormatType = 1;
                DecimalPlaces = 3 : 3;
            }
            column(Vendor_Vendor__No__; Vendor."No.")
            {
            }

            column(Vendor_Vendor_Name; Vendor.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }

            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo__Registration_No__; CompanyInfo."Registration No.")
            {
            }
            column(Vendor_GETFILTER__Date_Filter__; Vendor.GETFILTER("Date Filter"))
            {
            }
            column(FiltreCompte; FiltreCompte)
            {
            }
            column(TxtFiltreDev; TxtFiltreDev)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; StrSubstNo(Text003, UserId))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; StrSubstNo(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; StrSubstNo(Text005, ' '))
            {
            }
            column(PrintedByCaption; StrSubstNo(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Vendor_TABLECAPTION__________Filter; Vendor.TableCaption + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
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
            column(PreviousDebitAmount_PreviousCreditAmount; PreviousDebitAmount - PreviousCreditAmount)
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
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Vendor_Currency_Filter; "Currency Filter")
            {
            }
            column(Vendor_Detail_Trial_BalanceCaption; Vendor_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_vendors_that_only_have_balances_Caption; This_report_also_includes_vendors_that_only_have_balances_CaptionLbl)
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
                column(CreditPeriodAmountD; CreditPeriodAmountD)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(DebitPeriodAmountD_CreditPeriodAmountD; DebitPeriodAmountD - CreditPeriodAmountD)
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 3 : 3;
                }
                column(DebitPeriodAmountD_PreviousDebitAmount___CreditPeriodAmountD_PreviousCreditAmount__Control1000000160; (DebitPeriodAmountD + PreviousDebitAmount) - (CreditPeriodAmountD + PreviousCreditAmount))
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 3 : 3;
                }
                column(CreditPeriodAmountD_PreviousCreditAmount_Control1000000163; CreditPeriodAmountD + PreviousCreditAmount)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(DebitPeriodAmountD_PreviousDebitAmount_Control1000000166; DebitPeriodAmountD + PreviousDebitAmount)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(DebitPeriodAmountD; DebitPeriodAmountD)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(STRSUBSTNO_Text006_EndDate_; StrSubstNo(Text006, EndDate))
                {
                }
                column(Date__Period_Name_; Date."Period Name")
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
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter"), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"), "Currency Code" = field("Currency Filter");
                    DataItemLinkReference = Vendor;
                    DataItemTableView = sorting("Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code") where("Entry Type" = filter(<> Application));
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(BalanceD; BalanceD) { }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount_; "Debit Amount")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Vendor__No___Control1120212; Vendor."No.")
                    {
                    }
                    column(Vendor_Name_Control1120231; Vendor.Name)
                    {
                    }
                    column(Solde; Solde)
                    {
                        AutoFormatType = 1;
                        DecimalPlaces = 3 : 3;
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Posting_Date_; Format("Posting Date"))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(Det_Vendor_L_E___Entry_No__; "Detailed Vendor Ledg. Entry"."Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + Format(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(FooterEnable; not (Date."Period Type" = Date."Period Type"::Year))
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Vendor_No_; "Vendor No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Currency_Code; "Currency Code")
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
                    column(Detailed_Vendor_Ledg__Entry__Detailed_Vendor_Ledg__Entry___Credit_Amount__LCY__; "Detailed Vendor Ledg. Entry"."Credit Amount (LCY)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Detailed_Vendor_Ledg__Entry__Detailed_Vendor_Ledg__Entry___Debit_Amount__LCY__; "Detailed Vendor Ledg. Entry"."Debit Amount (LCY)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Lettr; Lettr)
                    {
                    }

                    column(RecVendor_Name; RecVendor.Name)
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Vendor_No__; "Vendor No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var

                    begin
                        /////////////////////
                        RecVendor.RESET;
                        IF RecVendor.GET("Vendor No.") THEN;
                        RecVendorLedgerEntry4.RESET;
                        Lettr := '';
                        RecVendorLedgerEntry4.SETRANGE("Document No.", "Document No.");
                        IF RecVendorLedgerEntry4.FINDFIRST THEN BEGIN
                            Lettr := RecVendorLedgerEntry4.Lettre;
                        END;
                        //////////////////////
                        // >> HJ SORO 26-10-2016
                        YouSkip := FALSE;
                        IF DATE2DMY("Posting Date", 3) = DATE2DMY("Detailed Vendor Ledg. Entry".GETRANGEMIN("Posting Date"), 3) THEN BEGIN

                            CLEAR(OriginalLedgerEntry3);
                            OriginalLedgerEntry3.GET("Vendor Ledger Entry No.");

                            IF (OriginalLedgerEntry3.Lettre <> '') AND LettrageCompatable THEN BEGIN
                                YouSkip := TRUE;
                                CLEAR(RecVendorLedgerEntry);
                                RecVendorLedgerEntry.SETCURRENTKEY(Lettre);
                                RecVendorLedgerEntry.SETRANGE(Lettre, OriginalLedgerEntry3.Lettre);
                                IF RecVendorLedgerEntry.FINDFIRST THEN
                                    REPEAT
                                        IF DATE2DMY(RecVendorLedgerEntry."Posting Date", 3) > DATE2DMY("Detailed Vendor Ledg. Entry".GETRANGEMIN("Posting Date"), 3) THEN
                                            YouSkip := FALSE;
                                        RecVendorLedgerEntry.CALCFIELDS(RecVendorLedgerEntry."Remaining Amount");
                                        IF RecVendorLedgerEntry."Remaining Amount" <> 0 THEN YouSkip := FALSE;

                                    UNTIL RecVendorLedgerEntry.NEXT = 0;

                            END;
                            IF YouSkip THEN CurrReport.SKIP;
                        END;
                        // >> HJ SORO 26-10-2016
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.Skip();
                        //   BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        IF NOT YouSkip THEN BalanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        Solde := Solde + "Detailed Vendor Ledg. Entry"."Debit Amount" - "Detailed Vendor Ledg. Entry"."Credit Amount";
                        OriginalLedgerEntry.Get("Vendor Ledger Entry No.");

                        // GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                        // GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";

                        // DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                        // CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                        ///////////////////////////////////////

                        //>>MHM Devise
                        //   CurrReport.SHOWOUTPUT := Dev;
                        //<<MHM Devise
                        IF Dev THEN BEGIN
                            //MakeExcelDataBody1;
                            //<<Ajout‚ MYC 141008
                            RecVendorLedgerEntry.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                            RecVendorLedgerEntry.SETRANGE(RecVendorLedgerEntry."Posting Date", Vendor."Date Filter");
                            RecVendorLedgerEntry.CALCFIELDS(RecVendorLedgerEntry."Remaining Amount");
                            IF RecVendorLedgerEntry."Remaining Amount" <> 0 THEN
                                BollGLettr := FALSE
                            ELSE
                                BollGLettr := TRUE;
                            ////>>Ajout‚ MYC 141008

                            IF (BooGLettrage = BooGLettrage::Lettré) THEN BEGIN
                                IF BollGLettr = FALSE THEN
                                    CurrReport.Skip()
                                //  CurrReport.SHOWOUTPUT := FALSE
                                ELSE BEGIN
                                    //balanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    BalanceD := "Debit Amount" - "Credit Amount";
                                    //<<MHM Devise

                                    OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                    //GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                    //GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                    GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                    //<<MHM Devise

                                    //DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                    //CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                    CreditPeriodAmountD := CreditPeriodAmountD + "Credit Amount";
                                    //<<MHM Devise
                                    // ExcelBuf.NewRow;
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(BalanceD, FALSE, '', FALSE, FALSE, FALSE, '', 0);

                                END;
                            END
                            // RB SORO 03/02/2017

                            ELSE IF (BooGLettrage = BooGLettrage::"Non lettré") THEN
                                IF BollGLettr = TRUE THEN
                                    CurrReport.Skip()
                                //  CurrReport.SHOWOUTPUT := TRUE
                                //hejer 13/12/2011

                                // RB SORO 03/02/2017
                                ELSE BEGIN
                                    //balanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    BalanceD := "Debit Amount" - "Credit Amount";
                                    //<<MHM Devise

                                    OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                    //GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                    //GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                    GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                    //<<MHM Devise

                                    //DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                    //CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                    CreditPeriodAmountD := CreditPeriodAmountD + "Credit Amount";
                                    //<<MHM Devise
                                    // ExcelBuf.NewRow;
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(BalanceD, FALSE, '', FALSE, FALSE, FALSE, '', 0);

                                END ELSE BEGIN
                                //balanceLCY := BalanceLCY + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                                //>>MHM Devise
                                BalanceD := "Debit Amount" - "Credit Amount";
                                //<<MHM Devise

                                OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                //GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                //GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                //>>MHM Devise
                                GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                //<<MHM Devise

                                //DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                //CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                //>>MHM Devise
                                DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                CreditPeriodAmountD := CreditPeriodAmountD + "Credit Amount";
                                //<<MHM Devise
                                // ExcelBuf.NewRow;
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(BalanceD, FALSE, '', FALSE, FALSE, FALSE, '', 0);

                            END;
                        END;


                        /////////////////////////////////////////

                        //    CurrReport.SHOWOUTPUT := NOT Dev;

                        //<<MHM Devise
                        IF NOT Dev THEN BEGIN
                            //MakeExcelDataBody1;

                            // >> HJ SORO 26-10-2016
                            CLEAR(OriginalLedgerEntry2);
                            OriginalLedgerEntry2.GET("Vendor Ledger Entry No.");

                            IF (OriginalLedgerEntry2.Lettre <> '') AND LettrageCompatable THEN BEGIN
                                BollGLettr := TRUE;
                                CLEAR(RecVendorLedgerEntry);
                                RecVendorLedgerEntry.SETCURRENTKEY(Lettre);
                                RecVendorLedgerEntry.SETRANGE(Lettre, OriginalLedgerEntry2.Lettre);
                                IF RecVendorLedgerEntry.FINDFIRST THEN
                                    REPEAT
                                        RecVendorLedgerEntry.CALCFIELDS(RecVendorLedgerEntry."Remaining Amount");
                                        IF RecVendorLedgerEntry."Remaining Amount" <> 0 THEN BollGLettr := FALSE;
                                        IF DATE2DMY(RecVendorLedgerEntry."Posting Date", 3) <> DATE2DMY("Detailed Vendor Ledg. Entry".GETRANGEMAX("Posting Date"), 3) THEN
                                            BollGLettr := FALSE;

                                    UNTIL RecVendorLedgerEntry.NEXT = 0;
                                IF NOT BollGLettr THEN OriginalLedgerEntry2.Lettre := '';
                            END;
                            // >> HJ SORO 26-10-2016


                            //<<Ajouté MYC 141008
                            RecVendorLedgerEntry.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                            RecVendorLedgerEntry.SETRANGE(RecVendorLedgerEntry."Posting Date", Vendor."Date Filter");
                            RecVendorLedgerEntry.CALCFIELDS(RecVendorLedgerEntry."Remaining Amount");
                            IF RecVendorLedgerEntry."Remaining Amount" <> 0 THEN
                                BollGLettr := FALSE
                            ELSE
                                BollGLettr := TRUE;
                            //>>Ajouté MYC 141008



                            IF (BooGLettrage = BooGLettrage::Lettré) THEN BEGIN
                                IF BollGLettr = FALSE THEN
                                    CurrReport.Skip()
                                //CurrReport.SHOWOUTPUT := FALSE
                                //hejer 13/12/2011
                                ELSE BEGIN


                                    //>>MHM Devise

                                    //BalanceD := BalanceD+ "Debit Amount" - "Credit Amount";
                                    //<<MHM Devise
                                    CLEAR(OriginalLedgerEntry);
                                    OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                    // >> HJ SORO 26-10-2016
                                    IF OriginalLedgerEntry.Lettre <> '' THEN BEGIN
                                        BollGLettr := TRUE;
                                        RecVendorLedgerEntry.SETCURRENTKEY(Lettre);
                                        RecVendorLedgerEntry.SETRANGE(Lettre, OriginalLedgerEntry.Lettre);
                                        IF RecVendorLedgerEntry.FINDFIRST THEN
                                            REPEAT
                                                RecVendorLedgerEntry.CALCFIELDS(RecVendorLedgerEntry."Remaining Amount");
                                                IF RecVendorLedgerEntry."Remaining Amount" <> 0 THEN BollGLettr := FALSE;
                                                IF DATE2DMY(RecVendorLedgerEntry."Posting Date", 3) <> DATE2DMY("Detailed Vendor Ledg. Entry".GETRANGEMAX("Posting Date"), 3) THEN
                                                    BollGLettr := FALSE;
                                            UNTIL RecVendorLedgerEntry.NEXT = 0;
                                        IF NOT BollGLettr THEN OriginalLedgerEntry.Lettre := '';
                                    END;
                                    // >> HJ SORO 26-10-2016


                                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    //GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                    //GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                    //<<MHM Devise

                                    DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                    CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    //DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                    //CreditPeriodAmountD := CreditPeriodAmountD +"Credit Amount";
                                    //<<MHM Devise

                                    // ExcelBuf.NewRow;
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(BalanceLCY, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry2.Lettre, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                END;
                                ///hejer 13/12/2011


                            END
                            ELSE IF (BooGLettrage = BooGLettrage::"Non lettré") THEN
                                IF BollGLettr = TRUE THEN
                                    CurrReport.Skip()
                                // CurrReport.SHOWOUTPUT := FALSE
                                ///hejer 13/12/2011
                                ELSE BEGIN

                                    //BalanceLCY :=BalanceLCY+ "Debit Amount (LCY)" - "Credit Amount (LCY)";
                                    //>>MHM Devise

                                    //BalanceD := BalanceD+ "Debit Amount" - "Credit Amount";
                                    //<<MHM Devise

                                    OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    //GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                    //GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                    //<<MHM Devise

                                    DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                    CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                    //>>MHM Devise
                                    //DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                    //CreditPeriodAmountD := CreditPeriodAmountD +"Credit Amount";
                                    //<<MHM Devise

                                    // ExcelBuf.NewRow;
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(BalanceLCY, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                    // ExcelBuf.AddColumn(OriginalLedgerEntry2.Lettre, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                END
                            ///hejer 13/12/2011

                            ELSE BEGIN

                                //BalanceLCY :=BalanceLCY+ "Debit Amount (LCY)" - "Credit Amount (LCY)";
                                //>>MHM Devise

                                //BalanceD := BalanceD+ "Debit Amount" - "Credit Amount";
                                //<<MHM Devise

                                OriginalLedgerEntry.GET("Vendor Ledger Entry No.");

                                GeneralDebitAmountLCY := GeneralDebitAmountLCY + "Debit Amount (LCY)";
                                GeneralCreditAmountLCY := GeneralCreditAmountLCY + "Credit Amount (LCY)";
                                //>>MHM Devise
                                //GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                                //GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                                //<<MHM Devise

                                DebitPeriodAmount := DebitPeriodAmount + "Debit Amount (LCY)";
                                CreditPeriodAmount := CreditPeriodAmount + "Credit Amount (LCY)";
                                //>>MHM Devise
                                //DebitPeriodAmountD := DebitPeriodAmountD + "Debit Amount";
                                //CreditPeriodAmountD := CreditPeriodAmountD +"Credit Amount";
                                //<<MHM Devise

                                // ExcelBuf.NewRow;
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Source Code", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(OriginalLedgerEntry."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(OriginalLedgerEntry.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)", FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(BalanceLCY, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                                // ExcelBuf.AddColumn(OriginalLedgerEntry2.Lettre, FALSE, '', FALSE, FALSE, FALSE, '', 0);
                            END;
                        END;
                        CLEAR(OriginalLedgerEntry3);
                        OriginalLedgerEntry3.GET("Vendor Ledger Entry No.");

                        ///////////////////////////////////////////////
                    end;

                    trigger OnPostDataItem()
                    begin
                        ReportDebitAmountLCY := ReportDebitAmountLCY + "Debit Amount (LCY)";
                        ReportCreditAmountLCY := ReportCreditAmountLCY + "Credit Amount (LCY)";
                        //>>MHM Devise
                        ReportDebitAmount := ReportDebitAmount + "Debit Amount";
                        ReportCreditAmount := ReportCreditAmount + "Credit Amount";
                        //<<MHM Devise
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SetCurrentKey("Vendor No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SetRange("Posting Date", Date."Period Start", Date."Period End");
                        ///////////////////////
                        IF Dev THEN
                            SETRANGE("Currency Code", CodeDevise);
                        ///////////////////////////////
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetRange("Period Type", TotalBy);
                    SetRange("Period Start", CalcDate('<-CM>', StartDate), ClosingDate(EndDate));
                    CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //////////////////////////////

                IF Vendor.GETFILTER(Vendor."No.") <> '' THEN
                    FiltreCompte := Vendor.GETFILTER(Vendor."No.")
                ELSE
                    FiltreCompte := 'Tous';
                TxtFiltreDev := 'Filtre Devise :  Tous';
                IF CodeDevise <> '' THEN
                    TxtFiltreDev := 'Filtre Devise : ' + CodeDevise
                ELSE
                    TxtFiltreDev := 'Filtre Devise :  Tous';
                ////////////////////////////
                //>>MHM Devise
                PreviousDebitAmount := 0;
                PreviousCreditAmount := 0;
                //<<MHM Devise
                BalanceLCY := 0;
                VendLedgEntry.SetCurrentKey(
                  "Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                VendLedgEntry.SetRange("Vendor No.", "No.");
                VendLedgEntry.SetRange("Posting Date", 0D, PreviousEndDate);
                VendLedgEntry.SetFilter(
                  "Entry Type", '<>%1&<>%2',
                  VendLedgEntry."Entry Type"::Application,
                  VendLedgEntry."Entry Type"::"Appln. Rounding");

                VendLedgEntry.CalcSums("Debit Amount (LCY)", "Credit Amount (LCY)", "Debit Amount", "Credit Amount");
                PreviousDebitAmountLCY := VendLedgEntry."Debit Amount (LCY)";
                PreviousCreditAmountLCY := VendLedgEntry."Credit Amount (LCY)";
                //>>MHM Devise
                PreviousDebitAmount := PreviousDebitAmount + VendLedgEntry."Debit Amount";
                PreviousCreditAmount := PreviousCreditAmount + VendLedgEntry."Credit Amount";
                //<<MHM Devise

                VendLedgEntry2.CopyFilters(VendLedgEntry);
                VendLedgEntry2.SetRange("Posting Date", StartDate, EndDate);
                if not (ExcludeBalanceOnly and VendLedgEntry2.IsEmpty) then begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    //>>MHM Devise
                    GeneralDebitAmount := GeneralDebitAmount + PreviousDebitAmount;
                    GeneralCreditAmount := GeneralCreditAmount + PreviousCreditAmount;
                    //<<MHM Devise
                end else begin

                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    //>>MHM Devise
                    GeneralDebitAmount := GeneralDebitAmount + PreviousDebitAmount;
                    GeneralCreditAmount := GeneralCreditAmount + PreviousCreditAmount;
                    //<<MHM Devise
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                //<<MHM Devise
                BalanceD := BalanceD + (PreviousDebitAmount - PreviousCreditAmount);  //hejer 14/02/2012
                DebitPeriodAmountD := 0;
                CreditPeriodAmountD := 0;
                //<<MHM Devise
                CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
            end;

            trigger OnPreDataItem()
            begin
                ///////////
                CompanyInfo.GET;
                //////////
                if GetFilter("Date Filter") = '' then
                    Error(Text001, FieldCaption("Date Filter"));
                if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                    Error(Text002);
                StartDate := GetRangeMin("Date Filter");
                PreviousEndDate := ClosingDate(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := ConvertStr(TextDate, '.', ',');
                //   FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := CopyStr(TextDate, 1, 8);
                Evaluate(PreviousStartDate, TextDate);
                if CopyStr(GetFilter("Date Filter"), StrLen(GetFilter("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GetRangeMax("Date Filter");

                /////
                //>>MHM Devise
                IF (Dev) AND (CodeDevise = '') THEN
                    ERROR(Text009);
                //<<MHM Devise


                /////
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
                        Caption = 'Trié par n° document>';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclure seulement les fournisseurs qui ont un solde ouvert';
                        MultiLine = true;
                    }
                    field(TotalBy; TotalBy)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Centralisé par';
                    }

                    field(BooGLettrage; BooGLettrage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lettrage';

                    }
                    field(LettrageCompatable; LettrageCompatable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lettrage Compatable';
                        ToolTip = 'Lettrage Compatable';
                    }
                    field(Dev; Dev)
                    {

                        ApplicationArea = Basic, Suite;
                        Caption = 'Filtrer par Devise';
                        trigger OnValidate()
                        var
                        begin
                            IF Dev THEN BEGIN
                                CodeDeviseVisible := TRUE;
                                CodeDevise := '';
                            END ELSE BEGIN
                                CodeDeviseVisible := FALSE;
                                CodeDevise := '';
                            end;

                        end;

                    }
                }
                group(General)
                {
                    Caption = 'Devise';
                    Visible = CodeDeviseVisible;

                    field(CodeDevise; CodeDevise)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Code Devise';
                        TableRelation = Currency;
                        //   Visible = CodeDeviseVisible;

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
        TotalBy := TotalBy::Mois;
        ///////////
        CodeDevise := '';
        Dev := FALSE;
        //////////
    end;

    trigger OnPreReport()
    begin
        Filter := Vendor.GetFilters();
    end;

    var
        CodeDeviseVisible: Boolean;
        Text001: Label 'Vous devez renseigner le champ %1.';
        Text002: Label 'Vous devez spécifier une date de début.';
        Text003: Label 'Imprimé par %1';
        Text004: Label 'Début exercice comptable : %1';
        Text005: Label 'Page %1';
        Text006: Label 'Solde au %1';
        Text007: Label 'Solde au %1';
        Text008: Label 'Total';
        VendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        OriginalLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        BalanceLCY: Decimal;
        TotalBy: Option Date,Semaine,Mois,Trimestre,Année;
        DocNumSort: Boolean;
        "Filter": Text;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        GeneralCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;
        ExcludeBalanceOnly: Boolean;
        Vendor_Detail_Trial_BalanceCaptionLbl: Label 'Grand-livre des fournisseurs';
        This_report_also_includes_vendors_that_only_have_balances_CaptionLbl: Label 'Cet état inclut aussi les fournisseurs ayant un solde ouvert.';
        Posting_DateCaptionLbl: Label 'Date';
        Source_CodeCaptionLbl: Label 'Journal';
        Document_No_CaptionLbl: Label 'Document';
        External_Document_No_CaptionLbl: Label 'Doc externe.';
        DescriptionCaptionLbl: Label 'Libellé écriture';
        DebitCaptionLbl: Label 'Débit';
        CreditCaptionLbl: Label 'Crédit';
        BalanceCaptionLbl: Label 'Solde';


        ContinuedCaptionLbl: Label 'Continué';
        To_be_continuedCaptionLbl: Label 'À suivre';
        Grand_TotalCaptionLbl: Label 'Total général';
        Total_Date_RangeCaptionLbl: Label 'Total de la période';
        Previous_pageCaptionLbl: Label 'Page précédente';
        Current_pageCaptionLbl: Label 'Page en cours';
        ///////////////////
        FiltreCompte: Text[30];
        CompanyInfo: Record 79;
        "--": Integer;
        ExcelBuf: Record 370;
        PrintToExcel: Boolean;
        BlankFiller: Text[250];
        BollGLettr: Boolean;
        RecVendorLedgerEntry: Record 25;
        "---": Integer;
        BalanceD: Decimal;
        PreviousDebitAmount: Decimal;
        PreviousCreditAmount: Decimal;
        GeneralDebitAmount: Decimal;
        GeneralCreditAmount: Decimal;
        ReportDebitAmount: Decimal;
        ReportCreditAmount: Decimal;
        DebitPeriodAmountD: Decimal;
        CreditPeriodAmountD: Decimal;
        Dev: Boolean;
        CodeDevise: Code[10];
        TxtFiltreDev: Text[30];
        Text009: TextConst FRA = 'Vous devez renseigner le code devise ';
        BooGLettrage: Option "",Lettré,"Non lettré";
        LettrageCompatable: Boolean;
        OriginalLedgerEntry3: Record 25;
        OriginalLedgerEntry2: Record 25;
        YouSkip: Boolean;
        Mnt2014: Decimal;
        RecVendorLedgerEntry4: Record 25;
        Lettr: Text[4];
        RecVendor: Record 23;
        Solde: Decimal;

    ///////////////////
}

