//HS
reportextension 50009 "G/L Trial Balance EXT" extends "G/L Trial Balance"
{
    // RDLCLayout = './Layouts/GLTrialBalanceCopy.rdlc';

    dataset
    {
        add("G/L Account")
        {
            column(DecGCredit; DecGCredit)
            {

            }
            column(DecGDebit; DecGDebit)
            {

            }
            column(DecGDebit2; DecGDebit2)
            {

            }
            column(ExclureNullSI; ExclureNullSI)
            {

            }
            column(Soldé; Soldé)
            {

            }
            column(DecGCredit2; DecGCredit2)
            {

            }
            column("SoldePeriodeDebitcredit"; "Debit Amount" - "Credit Amount")
            {

            }
            column("DecGDebit2DecGCredit2"; DecGDebit2 - DecGCredit2)
            {

            }
            column("DecGDebitDecGCredit"; DecGDebit - DecGCredit)
            {

            }
            column("DecGDebitDecGCredit_DecGDebit2DecGCredit2"; DecGDebit2 + DecGDebit - DecGCredit2 - DecGCredit)
            {

            }
            column("accountType"; "Account Type")
            {

            }
            column(FiltreCompte; FiltreCompte)
            {

            }
            column(FiltreTypeCpte; FiltreTypeCpte)
            {

            }
            column(FiltreTypeEcriture; FiltreTypeEcriture)
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
            column(Titre; Titre)
            {

            }


        }
        modify("G/L Account")
        {


            trigger OnAfterPreDataItem()
            begin
                CompanyInfo.get();
                IF "G/L Account".GETFILTER("G/L Account"."No.") <> '' THEN
                    FiltreCompte := "G/L Account".GETFILTER("G/L Account"."No.")
                ELSE
                    FiltreCompte := 'Tous';
                //<<Ajouté MYC 081008
                // IF "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter") <> '' THEN
                //     FiltreTypeEcriture := 'Type écriture : ' + "G/L Account".GETFILTER("G/L Account"."G/L Entry Type Filter")
                // ELSE
                //     FiltreTypeEcriture := '';

                IF "G/L Account".GETFILTER("G/L Account"."Account Type") <> '' THEN
                    FiltreTypeCpte := 'Type compte : ' + "G/L Account".GETFILTER("G/L Account"."Account Type")
                ELSE
                    FiltreTypeCpte := '';
                //>>Ajouté MYC 081008
                IF "G/L Account".GETFILTER("G/L Account"."No.") = '' THEN
                    Titre := 'BALANCE GENERALE'
                ELSE
                    Titre := 'BALANCE PARTIELLE';

                IF SousClasse = FALSE THEN
                    "G/L Account".SETFILTER("G/L Account"."Account Type", '<>%1', "G/L Account"."Account Type"::Posting);


                StartDate2 := GetRangeMin("Date Filter");
                PreviousEndDate2 := ClosingDate(StartDate2 - 1);

                DateFilterCalc2.CreateFiscalYearFilter(TextDate2, TextDate2, StartDate2, 0);
                TextDate2 := ConvertStr(TextDate2, '.', ',');
                //    DateFilterCalc.VerifiyDateFilter(TextDate2);
                TextDate2 := CopyStr(TextDate2, 1, 8);
                Evaluate(PreviousStartDate2, TextDate2);
                SETCURRENTKEY("G/L Account"."No.");
            end;

            trigger OnAfterAfterGetRecord()
            begin
                GLAccount3.Copy("G/L Account");
                GLAccount3.SetRange("Date Filter", 0D, PreviousEndDate2);
                GLAccount3.CalcFields("Debit Amount", "Credit Amount");
                //Ajout MEC 280208
                IF "Account Type" = "Account Type"::Posting THEN BEGIN
                    DecGDebit += "Debit Amount";
                    DecGCredit += "Credit Amount";
                    DecGDebit2 += GLAccount3."Debit Amount";
                    DecGCredit2 += GLAccount3."Credit Amount";
                END;

                //Fin AJOUT

                //AJOUT ZAM 160708
                IF ((GLAccount3."Debit Amount" - GLAccount3."Credit Amount") = 0) AND (ExclureNullSI) THEN
                    CurrReport.SKIP;

                IF ((GLAccount3."Debit Amount" + "Debit Amount" - GLAccount3."Credit Amount" - "Credit Amount") = 0) AND (Soldé) THEN
                    CurrReport.SKIP;

                //Fin AJOUT
            end;
        }
        // Add changes to dataitems and columns here
    }

    requestpage
    {

        layout
        {
            addafter(ShowNegAmounts)
            {
                // add field from table extension to request page
                field(ExclureNullSI; ExclureNullSI)
                {
                    ApplicationArea = All;
                    Caption = 'Exculre les comptes SI = 0';
                    Visible = false;

                }
                field(SousClasse; SousClasse)
                {
                    ApplicationArea = All;
                    Caption = 'Sous Classes';


                }
                field(Soldé; Soldé)
                {
                    ApplicationArea = All;
                    Caption = 'Hors Compte Soldés';
                }
            }
        }
    }

    rendering
    {
        // layout(LayoutName)
        // {
        //     Type = RDLC;
        //     LayoutFile = 'mylayout.rdl';
        // }
    }
    var
        PreviousEndDate2: Date;
        StartDate2: Date;
        GLAccount3: Record "G/L Account";
        DecGDebit: Decimal;
        DateFilterCalc2: Codeunit "DateFilter-Calc";
        DecGCredit: Decimal;
        DecGDebit2: Decimal;
        ExclureNullSI: Boolean;
        DecGCredit2: Decimal;
        Soldé, SousClasse : Boolean;
        PreviousStartDate2: Date;
        TextDate2, Titre, FiltreTypeCpte, FiltreTypeEcriture, FiltreCompte : Text[30];
        CompanyInfo: Record "Company Information";
}