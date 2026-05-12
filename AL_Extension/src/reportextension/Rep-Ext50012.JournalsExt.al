reportextension 50012 "Journals Ext" extends "Journals"
{
    //GL2024  Report=10801
    //GL2024    RDLCLayout = './Layouts/JournalsCopy.rdlc';
    dataset
    {

        add(date)
        {


            column(CompanyInfo__Matricule_Fiscale_; CompanyInfo."Matricule Fiscale")
            {
            }
            column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
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
            column(téléphone_; Text0077)
            {
            }

            column(télécopie_; Text0088)
            {
            }
            column(Périodelab_; Périodelab)
            {
            }
            column(JournalLabel; JournalLabel)
            {
            }
            column(cumulCredit; cumulCredit)
            {
            }
            column(Cumuldebit; Cumuldebit)
            {
            }
            column(GETFILTER__Period_Start__; GETFILTER("Period Start"))
            {
            }
            column("Date_Period_Type"; Date.GETFILTER(Date."Period Type"))
            {

            }

        }
        add(SourceCode)
        {
            column(FiltreCodeJournal; FiltreCodeJournal)
            {
            }
            column(FiltreSimultaion; FiltreSimultaion)
            {
            }
            column(FiltreTypePeriode; FiltreTypePeriode)
            {
            }
            column(SourceCode_Description_SourceNo2; "G/L Entry"."Source No.")
            {
            }




        }
        add("G/L Entry")
        {
            column(SourceCode_Description_SourceNo; "G/L Entry"."Source No.")
            {
            }
        }
        modify(Date)
        {

            trigger OnBeforePreDataItem()
            begin
                IF CompanyInfo.GET THEN;
            end;

        }
        modify(SourceCode)
        {

            trigger OnAfterAfterGetRecord()
            begin

                Date.FINDFIRST;
                CASE TRUE OF
                    Date."Period Type" = 0:
                        TypeDate := 'Date';
                    Date."Period Type" = 1:
                        TypeDate := 'Semaine';
                    Date."Period Type" = 2:
                        TypeDate := 'Mois';
                    Date."Period Type" = 3:
                        TypeDate := 'Trimestre';
                    Date."Period Type" = 4:
                        TypeDate := 'Année';
                END;

            end;

        }



    }


    requestpage
    {
        layout
        {


        }
    }

    rendering
    {

    }

    trigger OnPreReport()
    begin

        //<< Ajout‚ MYC 091008

        IF SourceCode.GETFILTER(SourceCode.Code) <> '' THEN
            FiltreCodeJournal := 'Code Journal : ' + SourceCode.GETFILTER(SourceCode.Code)
        ELSE
            FiltreCodeJournal := '';

        IF SourceCode.GETFILTER(SourceCode.Simulation2) <> '' THEN
            FiltreSimultaion := 'Simulation: ' + SourceCode.GETFILTER(Simulation2)
        ELSE
            FiltreSimultaion := '';

        IF Date.GETFILTER(Date."Period Type") <> '' THEN
            FiltreTypePeriode := 'Type période :' + Date.GETFILTER(Date."Period Type")
        ELSE
            FiltreTypePeriode := '';
        //>> Ajout‚ MYC 091008



    end;



    var

        Text0077: Label 'N° téléphone :';
        Text0088: Label 'N° télécopie :';
        Périodelab: Label 'Période du : ';
        CompanyInfo: Record 79;
        FiltreCodeJournal: Text[100];
        FiltreSimultaion: Text[30];
        FiltreTypePeriode: Text[30];
        JournalLabel: Label 'Journal';
        Cumuldebit: Label 'Cumul Débit';
        cumulCredit: Label 'Cumul Crédit';
        Title2: Text;
        TypeDate: Text[30];

}