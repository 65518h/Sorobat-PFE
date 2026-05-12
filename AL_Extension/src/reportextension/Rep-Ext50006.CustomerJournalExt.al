namespace SOROUBATDEV.SOROUBATDEV;

using Microsoft.Sales.Reports;
using Microsoft.Foundation.Period;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Foundation.Company;

reportextension 50006 "Customer Journal Ext" extends "Customer Journal"
{
    // RDLCLayout = './Layouts/Customer JournalCopy.rdlc';
    dataset
    {
        add(Date)
        {
            column(CompanyInfoAddress; CompanyInfo.Address) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.") { }
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
        modify(Date)
        {
            trigger OnAfterAfterGetRecord()
            begin
                CompanyInfo.GET();
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
}