report 50138 "Etat des Encaissements"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EtatdesEncaissements.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Etat des Encaissements';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING("Due Date", "Document No.")
                                WHERE("Copied To No." = FILTER(''),
                                      "Payment Class" = FILTER('ENC-CHEQUE' | 'ENC-TRAITE'),
                                      "Status No." = FILTER(15000));
            column(Text01________FORMAT_CurrReport_PAGENO_; Text01 + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Payment_Line__No__; "No.")
            {
            }
            column(Amount; -Amount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Payment_Line__Account_No__; "Account No.")
            {
            }
            column(Payment_Line__Due_Date_; "Due Date")
            {
            }
            column("Payment_Line_Libellé"; Libellé)
            {
            }
            column(Payment_Line__External_Document_No__; "External Document No.")
            {
            }
            column(Amount_Control1000000008; -Amount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Etat_Des_EncaissementsCaption; Etat_Des_EncaissementsCaptionLbl)
            {
            }
            column(MontantCaption; MontantCaptionLbl)
            {
            }
            column(N__Piece_De_PaiementCaption; N__Piece_De_PaiementCaptionLbl)
            {
            }
            column("LibelléCaption"; LibelléCaptionLbl)
            {
            }
            column(N__compteCaption; N__compteCaptionLbl)
            {
            }
            column(N__Caption; N__CaptionLbl)
            {
            }
            column("Date_d_échéanceCaption"; Date_d_échéanceCaptionLbl)
            {
            }
            column("Total_généralCaption"; Total_généralCaptionLbl)
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }

            trigger OnPreDataItem()
            begin
                IF FilterDateEchiance <> 0D THEN
                    "Payment Line".SETFILTER("Due Date", '<= %1', FilterDateEchiance);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Filter Date Echeance"; "FilterDateEchiance")
                    {
                        Caption = 'Filter Date Echeance';
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

    var
        FilterDateEchiance: Date;
        Text01: Label 'Page';
        Etat_Des_EncaissementsCaptionLbl: Label 'Etat Des Encaissements';
        MontantCaptionLbl: Label 'Montant';
        N__Piece_De_PaiementCaptionLbl: Label 'N° Piece De Paiement';
        "LibelléCaptionLbl": Label 'Libellé';
        N__compteCaptionLbl: Label 'N° compte';
        N__CaptionLbl: Label 'N° ';
        "Date_d_échéanceCaptionLbl": Label 'Date d''échéance';
        "Total_généralCaptionLbl": Label 'Total général';
}

