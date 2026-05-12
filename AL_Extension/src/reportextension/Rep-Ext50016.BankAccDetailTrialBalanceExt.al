namespace SOROUBATDEV.SOROUBATDEV;

using Microsoft.Bank.Reports;
using Microsoft.Bank.Ledger;
using Microsoft.Foundation.Company;
using Microsoft.Finance.Currency;
using Microsoft.Bank.BankAccount;

reportextension 50016 BankAccDetailTrialBalanceExt extends "Bank Acc. Detail Trial Balance"
{
    // RDLCLayout = './Layouts/BankAccDetTrialBalFinalCopy.rdlc';
    dataset
    {
        add("Bank Account")
        {
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyInfoMatFiscale; CompanyInfo."Matricule Fiscale") { }
            column(PeriodTextField; PeriodText) { }
            column(BankLedgEntryEntryNo; BankLedgEntry."Entry No.") { }
            column(GeneralDebitAmountLCYField; GeneralDebitAmountLCY) { }
            column(GeneralCreditAmountLCYField; GeneralCreditAmountLCY) { }
            column(PrintToExcelField; PrintToExcel) { }
            column(BlankFillerField; BlankFiller) { }
            column(FiltreCompteField; FiltreCompte) { }
            column(BalanceDField; BalanceD) { }
            column(PreviousDebitAmountField; PreviousDebitAmount) { }
            column(PreviousCreditAmountField; PreviousCreditAmount) { }
            column(GeneralDebitAmountField; GeneralDebitAmount) { }
            column(GeneralCreditAmountField; GeneralCreditAmount) { }
            column(ReportDebitAmountField; ReportDebitAmount) { }
            column(ReportCreditAmountField; ReportCreditAmount) { }
            column(DebitPeriodAmountDField; DebitPeriodAmountD) { }
            column(CreditPeriodAmountDField; CreditPeriodAmountD) { }
            column(DevField; Dev) { }
            column(CodeDeviseField; CodeDevise) { }
            column(TxtFiltreDevField; TxtFiltreDev) { }
            column(TotalGeneralDebitField; TotalGeneralDebit) { }
            column(TotalGeneralCreditField; TotalGeneralCredit) { }
            column("Debit_Amount"; "Debit Amount") { }
            column("Credit_Amount"; "Credit Amount") { }
            column(BalanceD; BalanceD) { }
        }
        modify("Bank Account")
        {
            trigger OnAfterPreDataItem()
            begin

                CompanyInfo.GET;
                IF "Bank Account".GETFILTER("Bank Account"."No.") <> '' THEN
                    FiltreCompte := "Bank Account".GETFILTER("Bank Account"."No.")
                ELSE
                    FiltreCompte := 'Tous';
                TxtFiltreDev := 'Filtre Devise :  Tous';
                IF CodeDevise <> '' THEN
                    TxtFiltreDev := 'Filtre Devise : ' + CodeDevise
                ELSE
                    TxtFiltreDev := 'Filtre Devise :  Tous';
                IF (Dev) AND (CodeDevise = '') THEN
                    ERROR(Text009);
                StartDate2 := GetRangeMin("Date Filter");
                PreviousEndDate2 := ClosingDate(StartDate2 - 1);
            end;

            trigger OnAfterAfterGetRecord()
            var
                BankAccountBal2: Record "Bank Account";
            begin
                CompanyInfo.GET();

                //>>MHM Devise
                PreviousDebitAmount := 0;
                PreviousCreditAmount := 0;
                //<<MHM Devise
                BankAccountBal2.Copy("Bank Account");
                BankAccountBal2.SetRange("Date Filter", 0D, PreviousEndDate2);
                BankAccountBal2.CalcFields("Debit Amount", "Credit Amount");

                //>>MHM Devise
                PreviousDebitAmount := PreviousDebitAmount + BankAccountBal2."Debit Amount";
                PreviousCreditAmount := PreviousCreditAmount + BankAccountBal2."Credit Amount";
                //<<MHM Devise


                //>>MHM Devise
                GeneralDebitAmount := GeneralDebitAmount + PreviousDebitAmount;
                GeneralCreditAmount := GeneralCreditAmount + PreviousCreditAmount;
                //<<MHM Devise

                //>>MHM Devise
                BalanceD := PreviousDebitAmount - PreviousCreditAmount;
                DebitPeriodAmountD := 0;
                CreditPeriodAmountD := 0;
                //<<MHM Devise


            end;
        }
        add("Bank Account Ledger Entry")
        {
            // column(BankLedgEntryEntryNo; BankLedgEntry."Entry No.") { }
            // column(GeneralDebitAmountLCYField; BankLedgEntry."Debit Amount (LCY)") { }
            // column(GeneralCreditAmountLCYField; BankLedgEntry."Credit Amount (LCY)") { }
        }
        add("Bank Account Ledger Entry")
        {


            column("DebitAmountField"; "Debit Amount") { }
            column("CreditAmountField"; "Credit Amount") { }
        }
        Modify("Bank Account Ledger Entry")
        {
            trigger OnAfterPreDataItem()
            var
            BEGIN

                IF Dev THEN
                    SETRANGE("Currency Code", CodeDevise);
            END;

            trigger OnAfterAfterGetRecord()
            begin
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

            trigger OnAfterPostDataItem()
            var
            begin
                ReportDebitAmount := ReportDebitAmount + "Debit Amount";
                ReportCreditAmount := ReportCreditAmount + "Credit Amount";
            end;
        }
    }

    requestpage
    {
        layout
        {
            addafter(Options)
            {
                // field(TotalBy; TotalBy)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Indicates whether to total by bank account or by currency.';
                // }
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of period for the report.';
                }
                field(Dev; Dev)
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Filtrer par Devise';
                    trigger OnValidate()
                    var
                    // CodeDeviseVisible: Boolean;
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
                // field(TxtFiltreDev; TxtFiltreDev)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the filter for the currency code.';
                // }
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

    }
    var
        CodeDeviseVisible: Boolean;
        CompanyInfo: Record "Company Information";
        PeriodText: Text[30];
        BankLedgEntry: Record "Bank Account Ledger Entry";
        GeneralDebitAmountLCY: Decimal;
        GeneralCreditAmountLCY: Decimal;
        // ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        BlankFiller: Text[250];
        FiltreCompte: Text[30];
        BalanceD: Decimal;
        PreviousEndDate2: Date;
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
        TotalGeneralDebit: Decimal;
        StartDate2: Date;
        TotalGeneralCredit: Decimal;
        PeriodType: Option "Date","Week","Month","Quarter","Year"; // Add this variable
        Text009: Label 'Vous devez renseigner le code devise';
    // DebitAmountField: Decimal;
    // CreditAmountField: Decimal;
}