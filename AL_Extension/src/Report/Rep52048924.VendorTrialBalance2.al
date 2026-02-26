report 52048924 "Vendor Trial BalanceCopy"
{
    //GL2024   Dans nav 2009 id "10807"
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/VendorTrialBalance2.rdlc';
    Caption = 'Balance fournisseurs 2';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("Vendor Posting Group");
            RequestFilterFields = "No.", "Search Name", "Date Filter", "Vendor Posting Group", Balance;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(Vendor_GETFILTER__Date_Filter__; Vendor.GETFILTER("Date Filter"))
            {
            }
            column(FiltreCompte; FiltreCompte)
            {
            }
            column(Vendor_TABLECAPTION_________; Vendor.TABLECAPTION + ' : ')
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(FiltreNomRecherche; FiltreNomRecherche)
            {
            }
            column(FiltreGroupeCompta; FiltreGroupeCompta)
            {
            }
            column(Vendor__Vendor_Posting_Group_; "Vendor Posting Group")
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY___1; (PreviousDebitAmountLCY - PreviousCreditAmountLCY) * -1)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PeriodDebitAmountLCY; PeriodDebitAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PeriodCreditAmountLCY; PeriodCreditAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY___PeriodDebitAmountLCY_PeriodCreditAmountLCY_; (PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY))
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY___PeriodDebitAmountLCY_PeriodCreditAmountLCY__; -((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY)))
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PeriodDebitAmountLCY_Control1120112; PeriodDebitAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PeriodCreditAmountLCY_Control1120113; PeriodCreditAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(soldegroupeCred__1; soldegroupeCred * -1)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Total_______Vendor_Posting_Group_; 'Total ' + "Vendor Posting Group")
            {
            }
            column(SoldeGroupedeb; SoldeGroupedeb)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(TOTSOLDINITCred; TOTSOLDINITCred)
            {
                AutoFormatType = 1;
                DecimalPlaces = 3 : 3;
            }
            column(TotMVTDEB; TotMVTDEB)
            {
                DecimalPlaces = 3 : 3;
            }
            column(TotMVTCRED; TotMVTCRED)
            {
                DecimalPlaces = 3 : 3;
            }
            column(TOTsoldefinCred; TOTsoldefinCred)
            {
                DecimalPlaces = 3 : 3;
            }
            column(TOTsoldefindeb; TOTsoldefindeb)
            {
                DecimalPlaces = 3 : 3;
            }
            column(TOTSOLDINITDEb; TOTSOLDINITDEb)
            {
                AutoFormatType = 1;
                DecimalPlaces = 3 : 3;
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY___PeriodCreditAmountLCY_PeriodDebitAmountLCY_; (PreviousCreditAmountLCY - PreviousDebitAmountLCY) + (PeriodCreditAmountLCY - PeriodDebitAmountLCY))
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY_Control1000000024; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY___1_Control1000000025; (PreviousDebitAmountLCY - PreviousCreditAmountLCY) * -1)
            {
                DecimalPlaces = 3 : 3;
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY___PeriodDebitAmountLCY_PeriodCreditAmountLCY__Control1000000026; (PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY))
            {
                DecimalPlaces = 3 : 3;
            }
            column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
            {
            }
            column(Fax_No_Caption; Fax_No_CaptionLbl)
            {
            }
            column(Fax_No_Caption_Control1120074; Fax_No_Caption_Control1120074Lbl)
            {
            }
            column(Cust__Ledger_EntryCaption_Control1120079; Cust__Ledger_EntryCaption_Control1120079Lbl)
            {
            }
            column(Balance_at_Ending_dateCaption; Balance_at_Ending_dateCaptionLbl)
            {
            }
            column(Balance_at_Starting_DateCaption; Balance_at_Starting_DateCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(Balance_at_Ending_dateCaption_Control1120109; Balance_at_Ending_dateCaption_Control1120109Lbl)
            {
            }
            column(DebitCaption_Control1000000000; DebitCaption_Control1000000000Lbl)
            {
            }
            column(Balance_at_Ending_dateCaption_Control1000000001; Balance_at_Ending_dateCaption_Control1000000001Lbl)
            {
            }
            column(Balance_at_Starting_DateCaption_Control1000000006; Balance_at_Starting_DateCaption_Control1000000006Lbl)
            {
            }
            column(Vendor__Vendor_Posting_Group_Caption; FIELDCAPTION("Vendor Posting Group"))
            {
            }
            column(Grand_totalCaption; Grand_totalCaptionLbl)
            {
            }
            column(Grand_totalCaption_Control1120133; Grand_totalCaption_Control1120133Lbl)
            {
            }
            column(Vendor_TABLECAPTION__________Filter; Vendor.TableCaption + ': ' + Filter)
            {
            }
            column(PageCaption; PageCaption)
            {
            }






            trigger OnAfterGetRecord()
            var
                FilterValues: Text[1024];
            begin
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                PeriodDebitAmountLCY := 0;
                PeriodCreditAmountLCY := 0;

                SoldeGroupedeb := 0;
                soldegroupeCred := 0;
                TOTSOLDINITDEb := 0;
                TOTSOLDINITCred := 0;
                TotMVTDEB := 0;
                TotMVTCRED := 0;
                TOTsoldefindeb := 0;
                TOTsoldefinCred := 0;

                WITH VendLedgEntry DO BEGIN
                    SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2",
                                  "Currency Code");
                    SETRANGE("Vendor No.", "No.");
                    IF Vendor.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                        SETRANGE("Initial Entry Global Dim. 1", Vendor.GETFILTER("Global Dimension 1 Filter"));
                    IF Vendor.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                        SETRANGE("Initial Entry Global Dim. 2", Vendor.GETFILTER("Global Dimension 2 Filter"));
                    IF Vendor.GETFILTER("Currency Filter") <> '' THEN
                        SETRANGE("Currency Code", Vendor.GETFILTER("Currency Filter"));
                    SETRANGE("Posting Date", 0D, PreviousEndDate);
                    SETFILTER("Entry Type", '<>%1', "Entry Type"::Application);
                    IF FIND('-') THEN
                        REPEAT
                            PreviousDebitAmountLCY += "Debit Amount (LCY)";
                            PreviousCreditAmountLCY += "Credit Amount (LCY)";
                        UNTIL NEXT = 0;
                    SETRANGE("Posting Date", StartDate, EndDate);
                    IF FIND('-') THEN
                        REPEAT
                            PeriodDebitAmountLCY += "Debit Amount (LCY)";
                            PeriodCreditAmountLCY += "Credit Amount (LCY)";
                        UNTIL NEXT = 0;
                END;
                //IF NOT PrintVendWithoutBalance AND (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) THEN
                //  CurrReport.SKIP;




                IF (PreviousDebitAmountLCY - PreviousCreditAmountLCY) > 0 THEN
                    TOTSOLDINITDEb := TOTSOLDINITDEb + PreviousDebitAmountLCY - PreviousCreditAmountLCY;
                IF ((PreviousDebitAmountLCY - PreviousCreditAmountLCY) * -1) > 0 THEN
                    TOTSOLDINITCred := TOTSOLDINITCred + (PreviousDebitAmountLCY - PreviousCreditAmountLCY) * -1;
                TotMVTDEB := TotMVTDEB + PeriodDebitAmountLCY;
                TotMVTCRED := TotMVTCRED + PeriodCreditAmountLCY;
                IF ((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY)) > 0 THEN
                    TOTsoldefindeb := TOTsoldefindeb + (PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY);
                IF (-((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY))) > 0 THEN
                    TOTsoldefinCred := TOTsoldefinCred + -((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY));

                IF ((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY)) > 0 THEN
                    SoldeGroupedeb := SoldeGroupedeb + (PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY);
                IF (((PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY))) < 0 THEN
                    soldegroupeCred := soldegroupeCred + (PreviousDebitAmountLCY - PreviousCreditAmountLCY) + (PeriodDebitAmountLCY - PeriodCreditAmountLCY)
            end;

            trigger OnPreDataItem()
            begin



                //<<Ajouté MYC 081008
                IF (GETFILTER("No.") <> '') THEN
                    FiltreCompte := GETFILTER("No.")
                ELSE
                    IF (GETFILTER("No.") = '') AND (GETFILTER("Search Name") <> '') THEN BEGIN
                        SETRANGE("Search Name", GETFILTER("Search Name"));
                        IF FINDFIRST THEN
                            FiltreCompte := "No."
                        ELSE
                            FiltreCompte := '';
                    END
                    ELSE
                        FiltreCompte := 'Tous';


                IF GETFILTER("Search Name") <> '' THEN
                    FiltreNomRecherche := 'Nom de Recherche : ' + GETFILTER("Search Name")
                ELSE
                    FiltreNomRecherche := '';

                IF GETFILTER("Vendor Posting Group") <> '' THEN
                    FiltreGroupeCompta := 'Groupe Compta Fournisseur : ' + GETFILTER("Vendor Posting Group")
                ELSE
                    FiltreGroupeCompta := '';

                //>>Ajouté MYC 081008











                IF GETFILTER("Date Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                //FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("Date Filter");
                CurrReport.CREATETOTALS(PreviousDebitAmountLCY, PreviousCreditAmountLCY, PeriodDebitAmountLCY, PeriodCreditAmountLCY);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompanyInfo.GET;
    end;

    trigger OnPreReport()
    begin
        Filter := Vendor.GETFILTERS;
    end;

    var

        Text003: Label 'Imprimé par %1';
        Text004: Label 'Début exercice comptable : %1';
        Text005: Label 'Page %1';
        CompanyInfo: Record 79;
        FiltreDateCalc: Codeunit 358;
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        PrintVendWithoutBalance: Boolean;
        "Filter": Text[250];
        PeriodText: Text[30];
        VendLedgEntry: Record 380;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PeriodDebitAmountLCY: Decimal;
        PeriodCreditAmountLCY: Decimal;
        FiltreCompte: Text[30];
        "--": Integer;
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        FiltreNomRecherche: Text[100];
        FiltreGroupeCompta: Text[100];
        TOTSOLDINITDEb: Decimal;
        TOTSOLDINITCred: Decimal;
        TotMVTDEB: Decimal;
        TotMVTCRED: Decimal;
        TOTsoldefindeb: Decimal;
        TOTsoldefinCred: Decimal;
        SoldeGroupedeb: Decimal;
        soldegroupeCred: Decimal;
        Cust__Ledger_EntryCaptionLbl: Label 'Balance fournisseurs';
        Fax_No_CaptionLbl: Label 'N° Téléphone :';
        Fax_No_Caption_Control1120074Lbl: Label 'N° Télécopie :';
        Cust__Ledger_EntryCaption_Control1120079Lbl: Label 'Balance fournisseurs';
        NameCaptionLbl: Label 'Désignation';
        No_CaptionLbl: Label 'N°';
        DebitCaptionLbl: Label 'Débit';
        CreditCaptionLbl: Label 'Crédit';
        DebitCaption_Control1000000000Lbl: Label 'Mouvement Période';
        Grand_totalCaptionLbl: Label 'Total général';
        Grand_totalCaption_Control1120133Lbl: Label 'Solde';


        Text001: Label 'Vous devez renseigner le champ %1.';
        Text002: Label 'Vous devez spécifier une date de début.';
        Balance_at_Ending_dateCaptionLbl: Label 'Solde Initial Débit';
        Balance_at_Starting_DateCaptionLbl: Label 'Solde Initial Crédit';

        Balance_at_Ending_dateCaption_Control1120109Lbl: Label 'Solde Initial Débit';

        Balance_at_Ending_dateCaption_Control1000000001Lbl: Label 'Solde Période';
        Balance_at_Starting_DateCaption_Control1000000006Lbl: Label 'Solde Initial Débit';
        PageCaption: Label 'Page';

}

