
//HS
reportextension 50010 "Customer Trial Balance EXT" extends "Customer Trial Balance FR"
{

    // RDLCLayout = './Layouts/CustomerTrialBalanceFRCopy.rdlc';
    dataset
    {
        add(Customer)
        {
            column(PreviousDebitAmountLCYSolde; (PreviousDebitAmountLCY2 - PreviousCreditAmountLCY2) + (PeriodDebitAmountLCY2 - PeriodCreditAmountLCY2))
            {

            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY_2; ((PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2)) * -1)
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY2; (PreviousDebitAmountLCY2 - PreviousCreditAmountLCY2) * -1)
            {
            }
            column(PeriodCreditAmountLCYSolde; (PreviousCreditAmountLCY2 - PreviousDebitAmountLCY2) + (PeriodCreditAmountLCY2 - PeriodDebitAmountLCY2))
            {

            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {

            }
            column(FiltreCompte; FiltreCompte)
            {

            }
            column(FiltreNomRecherche; FiltreNomRecherche)
            {

            }
            column(FiltreGroupeCompta; FiltreGroupeCompta)
            {

            }
            column(DecTotDebit; DecTotDebit)
            {

            }
            column(DecTotCredit; DecTotCredit)
            {

            }
            column(DecGDebit; DecGDebit)
            {

            }
            column(DecGCredit; DecGCredit)
            {

            }
            column(DecGDebit2; DecGDebit2)
            {

            }
            column(DecGCredit2; DecGCredit2)
            {

            }
            column(Soldegroupedeb; Soldegroupedeb)
            {

            }
            column(Soldegroupecred; Soldegroupecred)
            {

            }
            column(PreviousDebitAmountLCY2; PreviousDebitAmountLCY2)
            {

            }
            column(PreviousCreditAmountLCY2; PreviousCreditAmountLCY2)
            {

            }

            column(CompanyInfoAdresse; CompanyInfo.Address)
            {

            }
            column(CompanyInfoPhone; CompanyInfo."Phone No.")
            {

            }
            column(CompanyInfoFax; CompanyInfo."Fax No.")
            {

            }
            column(CompanyInfoVatRegis; CompanyInfo."VAT Registration No.")
            {

            }
            column(CompanyInfoMatricule; CompanyInfo."Matricule Fiscale")
            {

            }

        }
        modify(customer)
        {


            trigger OnAfterAfterGetRecord()
            begin
                // visibility in layourt
                // IF (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) AND (PreviousDebitAmountLCY = 0) AND (PreviousCreditAmountLCY = 0) THEN
                //     CurrReport.SHOWOUTPUT(FALSE);
                /////////////////////////////////
                PreviousDebitAmountLCY2 := 0;
                PreviousCreditAmountLCY2 := 0;
                PeriodDebitAmountLCY2 := 0;
                PeriodCreditAmountLCY2 := 0;
                CustLedgEntry2.SetCurrentKey(
                                "Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2",
                                "Currency Code");
                CustLedgEntry2.SetRange("Customer No.", "No.");
                if Customer.GetFilter("Global Dimension 1 Filter") <> '' then
                    CustLedgEntry2.SetRange("Initial Entry Global Dim. 1", Customer.GetFilter("Global Dimension 1 Filter"));
                if Customer.GetFilter("Global Dimension 2 Filter") <> '' then
                    CustLedgEntry2.SetRange("Initial Entry Global Dim. 2", Customer.GetFilter("Global Dimension 2 Filter"));
                if Customer.GetFilter("Currency Filter") <> '' then
                    CustLedgEntry2.SetRange("Currency Code", Customer.GetFilter("Currency Filter"));
                CustLedgEntry2.SetRange("Posting Date", 0D, PreviousEndDate2);
                CustLedgEntry2.SetFilter("Entry Type", '<>%1', CustLedgEntry2."Entry Type"::Application);
                if CustLedgEntry2.FindSet() then
                    repeat
                        PreviousDebitAmountLCY2 += CustLedgEntry2."Debit Amount (LCY)";
                        PreviousCreditAmountLCY2 += CustLedgEntry2."Credit Amount (LCY)";
                    until CustLedgEntry2.Next() = 0;

                CustLedgEntry2.SetRange("Posting Date", StartDate2, EndDate2);
                if CustLedgEntry2.FindSet() then
                    repeat
                        PeriodDebitAmountLCY2 += CustLedgEntry2."Debit Amount (LCY)";
                        PeriodCreditAmountLCY2 += CustLedgEntry2."Credit Amount (LCY)";
                    until CustLedgEntry2.Next() = 0;
                /// //////////////////////////////
                // Message('Result %1 ', (PreviousCreditAmountLCY2 - PreviousDebitAmountLCY2) * -1);
                // Message('Result 2 %1 ', (PreviousCreditAmountLCY2 - PreviousDebitAmountLCY2));
                IF (PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2) > 0 THEN
                    DecTotDebit += (PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2)
                ELSE
                    DecTotCredit += -((PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2));
                IF ((PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2)) > 0 THEN
                    Soldegroupedeb := Soldegroupedeb + (PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2);
                IF ((PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2)) < 0 THEN
                    Soldegroupecred := Soldegroupecred + ((PreviousDebitAmountLCY2 + PeriodDebitAmountLCY2) - (PreviousCreditAmountLCY2 + PeriodCreditAmountLCY2))

            end;

            trigger OnAfterPreDataItem()
            begin
                CompanyInfo.get();
                //<<Ajouté MYC 081008
                IF (Customer.GETFILTER(Customer."No.") <> '') THEN
                    FiltreCompte := Customer.GETFILTER(Customer."No.")
                ELSE
                    IF (Customer.GETFILTER(Customer."No.") = '') AND (GETFILTER("Search Name") <> '') THEN BEGIN
                        Customer.SETRANGE(Customer."Search Name", GETFILTER("Search Name"));
                        IF FINDFIRST THEN
                            FiltreCompte := Customer."No."
                        ELSE
                            FiltreCompte := '';
                    END
                    ELSE
                        FiltreCompte := 'Tous';


                IF GETFILTER("Search Name") <> '' THEN
                    FiltreNomRecherche := 'Nom de Recherche : ' + GETFILTER("Search Name")
                ELSE
                    FiltreNomRecherche := '';

                IF GETFILTER("Customer Posting Group") <> '' THEN
                    FiltreGroupeCompta := 'Groupe Compta Client : ' + GETFILTER("Customer Posting Group")
                ELSE
                    FiltreGroupeCompta := '';
                StartDate2 := GetRangeMin("Date Filter");
                PreviousEndDate2 := ClosingDate(StartDate2 - 1);
                if CopyStr(GetFilter("Date Filter"), StrLen(GetFilter("Date Filter")), 1) = '.' then
                    EndDate2 := 0D
                else
                    EndDate2 := GetRangeMax("Date Filter");
                //>>Ajouté MYC 081008
                Clear(PreviousDebitAmountLCY2);
                Clear(PreviousCreditAmountLCY2);
                Clear(PeriodDebitAmountLCY2);
                Clear(PeriodCreditAmountLCY2);

                Soldegroupedeb := 0;
                Soldegroupecred := 0;
            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {

    }
    var
        PreviousEndDate2, StartDate2, EndDate2 : Date;
        DecTotDebit: Decimal;
        DecTotCredit: Decimal;
        DecGDebit: Decimal;
        DecGCredit: Decimal;
        DecGDebit2: Decimal;
        DecGCredit2: Decimal;
        Soldegroupedeb: Decimal;
        Soldegroupecred: Decimal;

        FiltreCompte: Text[30];
        FiltreNomRecherche: Text[30];
        FiltreGroupeCompta: Text[30];
        CompanyInfo: Record "Company Information";
        CustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        PreviousDebitAmountLCY2: Decimal;
        PreviousCreditAmountLCY2: Decimal;
        PeriodDebitAmountLCY2: Decimal;
        PeriodCreditAmountLCY2: Decimal;

}