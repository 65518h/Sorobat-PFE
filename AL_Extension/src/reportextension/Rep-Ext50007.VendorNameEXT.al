namespace SOROUBATDEV.SOROUBATDEV;

using Microsoft.Purchases.Reports;
using Microsoft.Purchases.Payables;
using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Company;

reportextension 50007 "Vendor Name EXT" extends "Vendor Journal"
{ // RDLCLayout = './Layouts/Journal comptes founisseurs Copy.rdlc';
    dataset
    {
        add(Date)
        {
            column(CompanyInfoName; CompanyInfo.Name) { }
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyInfoMatFiscale; CompanyInfo."Matricule Fiscale") { }
            column(PreviousEndDateField; PreviousEndDate) { }
            column(PeriodTextField; PeriodText) { }
            column(FiltreTypePeriodeField; FiltreTypePeriode) { }
            column(FiltreCodeJournalField; FiltreCodeJournal) { }
            column(TitleField; Title) { }
            column(DisplayField; FORMAT(Display)) { }
            column(DisplayEntriesField; DisplayEntries) { }
            column(DisplayCentralField; DisplayCentral) { }
        }
        add("Vendor Ledger Entry")
        {
            column(RecFRSNo; RecFRS."No.") { }
            column(RecFRSName; RecFRS.Name) { }
        }
        modify(Date)
        {
            trigger OnAfterAfterGetRecord()
            begin
                CompanyInfo.GET();
            end;
        }
        modify("Vendor Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            begin
                IF RecFRS.GET("Vendor Ledger Entry"."Vendor No.") THEN;
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        PreviousEndDate: Date;
        PeriodText: Text[30];
        FiltreTypePeriode: Text[30];
        FiltreCodeJournal: Text[150];
        Title: Text[50];
        Display: Option;
        DisplayEntries: Boolean;
        DisplayCentral: Boolean;
        RecFRS: Record "Vendor";
}
