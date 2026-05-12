report 50105 "Transfert Engin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TransfertEngin.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Transfert Engin';

    dataset
    {
        dataitem("Historique Transfert Engin"; 50056)
        {
            RequestFilterFields = "Code Transfert";
            column(CompanyPicture; RecCompnyInfo.Picture) { }
            column(BON_TRANSFERT_ENGIN_N____________Code_Transfert_; 'BON TRANSFERT ENGIN N° :      ' + "Code Transfert")
            {
            }
            column(Historique_Transfert_Engin__Code_Engin_; "Code Engin")
            {
            }
            column(Historique_Transfert_Engin_Immatriculation; Immatriculation)
            {
            }
            column(Historique_Transfert_Engin__User_Id_; "User Id")
            {
            }
            column(Historique_Transfert_Engin__Description_Engin_; "Description Engin")
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
            column(Historique_Transfert_Engin__Description_Depart_; "Description Depart")
            {
            }
            column(Historique_Transfert_Engin__Description_Destination_; "Description Destination")
            {
            }
            column(Historique_Transfert_Engin_Chauffeur; Chauffeur)
            {
            }
            column(Historique_Transfert_Engin_Observation; Observation)
            {
            }
            column(Historique_Transfert_Engin__Code_Tracteur_Routier_; "Code Tracteur Routier")
            {
            }
            column(Historique_Transfert_Engin__Description_Tracteur_Routier_; "Description Tracteur Routier")
            {
            }
            column(Historique_Transfert_Engin__Code_Port_Chart_; "Code Port-Chart")
            {
            }
            column(Historique_Transfert_Engin__Description_Port_Chart_; "Description Port-Chart")
            {
            }
            column(Historique_Transfert_Engin__Immat_Tracteur_Routier_; "Immat Tracteur Routier")
            {
            }
            column(Historique_Transfert_Engin__Immat_Port_Chart_; "Immat Port-Chart")
            {
            }
            column(SOROUBATCaption; SOROUBATCaptionLbl)
            {
            }
            column(Adresse1; Adresse1)
            {
            }
            column(Adresse2; Adresse2)
            {
            }
            column(Adresse3; Adresse3)
            {
            }
            column(Adresse4; Adresse4)
            {
            }
            column(Historique_Transfert_Engin__Code_Engin_Caption; FIELDCAPTION("Code Engin"))
            {
            }
            column(Historique_Transfert_Engin_ImmatriculationCaption; FIELDCAPTION(Immatriculation))
            {
            }
            column(Historique_Transfert_Engin__User_Id_Caption; FIELDCAPTION("User Id"))
            {
            }
            column(Historique_Transfert_Engin__Date_Transfert_Caption; FIELDCAPTION("Date Transfert"))
            {
            }
            column(Historique_Transfert_Engin_DepartCaption; FIELDCAPTION(Depart))
            {
            }
            column(Historique_Transfert_Engin_DestinationCaption; FIELDCAPTION(Destination))
            {
            }
            column(Historique_Transfert_Engin_ChauffeurCaption; FIELDCAPTION(Chauffeur))
            {
            }
            column(Historique_Transfert_Engin_ObservationCaption; FIELDCAPTION(Observation))
            {
            }
            column(Historique_Transfert_Engin__Code_Tracteur_Routier_Caption; FIELDCAPTION("Code Tracteur Routier"))
            {
            }
            column(Historique_Transfert_Engin__Code_Port_Chart_Caption; FIELDCAPTION("Code Port-Chart"))
            {
            }
            column(Directeur_de_ParcCaption; Directeur_de_ParcCaptionLbl)
            {
            }
            column(ChauffeurCaption; ChauffeurCaptionLbl)
            {
            }
            column(ResponsableCaption; ResponsableCaptionLbl)
            {
            }
            column(ReceptionCaption; ReceptionCaptionLbl)
            {
            }
            column(Historique_Transfert_Engin_Code_Transfert; "Code Transfert")
            {
            }
            trigger OnPreDataItem()
            begin

                RecCompnyInfo.get();
                RecCompnyInfo.CalcFields(Picture);
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
        RecCompnyInfo: Record "Company Information";
        SOROUBATCaptionLbl: Label 'SOROUBAT';
        "Adresse1": Label 'Avenue de la gare Megrine Riadh';
        "Adresse2": Label '2014 BEN AROUS';
        "Adresse3": Label 'Code TVA : 1864 Y/A/M/000 - Site : www.groupesoroubat.com';
        "Adresse4": Label 'Tél.: Siège : 71 433 120 - FAX : 71 433 074';



        Directeur_de_ParcCaptionLbl: Label 'Directeur de Parc';
        ChauffeurCaptionLbl: Label 'Chauffeur';
        ResponsableCaptionLbl: Label 'Responsable';
        ReceptionCaptionLbl: Label 'Reception';
}

