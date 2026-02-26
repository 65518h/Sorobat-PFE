reportextension 50011 "G/L Journal Ext" extends "G/L Journal"
{
    //GL2024  Report=10800
    //GL2024    RDLCLayout = './Layouts/GLJournalCopy.rdlc';
    dataset
    {



        add(date)
        {

            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; Text006)
            {
            }
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
            column(téléphone_; Text007)
            {
            }

            column(télécopie_; Text008)
            {
            }
            column(Périodelab_; Périodelab)
            {
            }
            column(GETFILTER__Period_Start__; GETFILTER("Period Start"))
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

                //<< Ajouté MYC 091008

                IF GETFILTER(SourceCode.Code) <> '' THEN
                    FiltreCodeJournal := 'Code Journal : ' + GETFILTER(SourceCode.Code)
                ELSE
                    FiltreCodeJournal := '';

                IF GETFILTER(Simulation2) <> '' THEN
                    FiltreSimultaion := 'Simulation: ' + GETFILTER(Simulation2)
                ELSE
                    FiltreSimultaion := '';

                //>> Ajouté MYC 091008
            end;
        }


    }

    requestpage
    {

    }

    rendering
    {

    }


    var
        Text006: Label 'Statut de l''exercice comptable :';
        Text007: Label 'N° téléphone :';
        Text008: Label 'N° télécopie :';
        Périodelab: Label 'Période du : ';
        CompanyInfo: Record 79;
        FiltreCodeJournal: Text[100];
        FiltreSimultaion: Text[30];

}