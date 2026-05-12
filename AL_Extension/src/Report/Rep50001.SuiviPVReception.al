report 50001 "Suivi PV Reception"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviPVReception.rdlc';

    dataset
    {
        dataitem(DataItem8490; 50004)
        {
            DataItemTableView = SORTING("Code Magasin");
            RequestFilterFields = "Code Magasin", "Date Commande";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(PV_Reception__Code_Magasin_; "Code Magasin")
            {
            }
            column(PV_Reception__N__Camion_; "N° Camion")
            {
            }
            column(PV_Reception__N__Commande_; "N° Commande")
            {
            }
            column(PV_Reception__N__Article_; "N° Article")
            {
            }
            column(PV_Reception__Date_Commande_; "Date Commande")
            {
            }
            column(PV_Reception__Poids_Net_Fournisseur_; "Poids Net Fournisseur")
            {
            }
            column(PV_Reception__Poids_Net_Chantier_; "Poids Net Chantier")
            {
            }
            column(PV_Reception__Ecart_Poids_Net_Chantier_; "Ecart Poids Net Chantier")
            {
            }
            column(PV_Reception__Poids_Apres_SC_; "Poids Apres SC")
            {
            }
            column("PV_Reception__Poids_Aprés_CB_"; "Poids Aprés CB")
            {
            }
            column(PV_Reception__Ecart_Final_; "Ecart Final")
            {
            }
            column(SUIVI_PV_RECEPTIONCaption; SUIVI_PV_RECEPTIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PV_Reception__N__Camion_Caption; FIELDCAPTION("N° Camion"))
            {
            }
            column(PV_Reception__N__Commande_Caption; FIELDCAPTION("N° Commande"))
            {
            }
            column(PV_Reception__N__Article_Caption; FIELDCAPTION("N° Article"))
            {
            }
            column(PV_Reception__Date_Commande_Caption; FIELDCAPTION("Date Commande"))
            {
            }
            column(PV_Reception__Poids_Net_Fournisseur_Caption; FIELDCAPTION("Poids Net Fournisseur"))
            {
            }
            column(PV_Reception__Poids_Net_Chantier_Caption; FIELDCAPTION("Poids Net Chantier"))
            {
            }
            column(PV_Reception__Ecart_Poids_Net_Chantier_Caption; FIELDCAPTION("Ecart Poids Net Chantier"))
            {
            }
            column(PV_Reception__Poids_Apres_SC_Caption; FIELDCAPTION("Poids Apres SC"))
            {
            }
            column("PV_Reception__Poids_Aprés_CB_Caption"; FIELDCAPTION("Poids Aprés CB"))
            {
            }
            column(PV_Reception__Ecart_Final_Caption; FIELDCAPTION("Ecart Final"))
            {
            }
            column(Magasin__Caption; Magasin__CaptionLbl)
            {
            }
            column(PV_Reception_N__Sequence; "N° Sequence")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Code Magasin");
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        SUIVI_PV_RECEPTIONCaptionLbl: Label 'SUIVI PV RECEPTION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Magasin__CaptionLbl: Label 'Magasin :';
}

