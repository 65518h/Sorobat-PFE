report 50118 "Liste Mouvement Engins"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListeMouvementEngins.rdlc';

    dataset
    {
        dataitem("Historique Transfert Engin"; 50056)
        {
            DataItemTableView = SORTING ("Code Transfert");
            RequestFilterFields = "Date Transfert", "Code Engin";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Historique_Transfert_Engin_Immatriculation; Immatriculation)
            {
            }
            column(Historique_Transfert_Engin__Description_Engin_; "Description Engin")
            {
            }
            column(Historique_Transfert_Engin__Code_Engin_; "Code Engin")
            {
            }
            column(Historique_Transfert_Engin__Date_Transfert_; "Date Transfert")
            {
            }
            column(Historique_Transfert_Engin_Depart; Depart)
            {
            }
            column(Historique_Transfert_Engin_Destination; Destination)
            {
            }
            column(Historique_Transfert_Engin_Chauffeur; Chauffeur)
            {
            }
            column(Historique_Transfert_Engin__Immat_Tracteur_Routier_; "Immat Tracteur Routier")
            {
            }
            column(Historique_Transfert_Engin_Observation; Observation)
            {
            }
            column(Historique_Transfert_Engin__Immat_Port_Chart_; "Immat Port-Chart")
            {
            }
            column("Liste_Transfert_MatèrielCaption"; Liste_Transfert_MatèrielCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Liste_Transfert_MatèrielCaption_Control1000000010"; Liste_Transfert_MatèrielCaption_Control1000000010Lbl)
            {
            }
            column(ChauffeurCaption; ChauffeurCaptionLbl)
            {
            }
            column(Description_EnginsCaption; Description_EnginsCaptionLbl)
            {
            }
            column(Code_EnginsCaption; Code_EnginsCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Immat__EnginsCaption; Immat__EnginsCaptionLbl)
            {
            }
            column(DestinationCaption; DestinationCaptionLbl)
            {
            }
            column(DepartCaption; DepartCaptionLbl)
            {
            }
            column(ObservationCaption; ObservationCaptionLbl)
            {
            }
            column(Imm_TractCaption; Imm_TractCaptionLbl)
            {
            }
            column(Imm_Port_ChartCaption; Imm_Port_ChartCaptionLbl)
            {
            }
            column(Historique_Transfert_Engin_Code_Transfert; "Code Transfert")
            {
            }
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
        "Liste_Transfert_MatèrielCaptionLbl": Label 'Liste Transfert Matèriel';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Liste_Transfert_MatèrielCaption_Control1000000010Lbl": Label 'Liste Transfert Matèriel';
        ChauffeurCaptionLbl: Label 'Chauffeur';
        Description_EnginsCaptionLbl: Label 'Description Engins';
        Code_EnginsCaptionLbl: Label 'Code Engins';
        DateCaptionLbl: Label 'Date';
        Immat__EnginsCaptionLbl: Label 'Immat. Engins';
        DestinationCaptionLbl: Label 'Destination';
        DepartCaptionLbl: Label 'Depart';
        ObservationCaptionLbl: Label 'Observation';
        Imm_TractCaptionLbl: Label 'Imm Tract';
        Imm_Port_ChartCaptionLbl: Label 'Imm Port-Chart';
}

