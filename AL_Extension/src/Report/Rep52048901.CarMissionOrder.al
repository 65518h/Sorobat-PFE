report 52048901 "Car Mission Order"
{//GL2024  ID dans Nav 2009 : "39004676"
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CarMissionOrder.rdlc';
    Caption = 'Ordre de Mission Véhicule';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Missions; Missions)
        {
            DataItemTableView = SORTING("N° Mission")
                                ORDER(Descending);
            RequestFilterFields = "N° Mission", "N° Véhicule";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Missions_Missions__Date_Mission_; Missions."Date Mission")
            {
            }
            column(N_______Missions__N__Mission_; 'N° :' + Missions."N° Mission")
            {
            }
            column(Missions__Date_Mission_; "Date Mission")
            {
            }
            column(Missions__Date_document_; "Date document")
            {
            }
            column("Missions__Date_Départ_"; "Date Départ")
            {
            }
            column("Missions__Date_Arrivée_"; "Date Arrivée")
            {
            }
            column("Missions__Lieu_départ_"; "Lieu départ")
            {
            }
            column("Missions__Lieu_Arrivé_"; "Lieu Arrivé")
            {
            }
            column(vehicul_Immatriculation; vehicul.Immatriculation)
            {
            }
            column(Missions__Nom_Demandeur_; "Nom Demandeur")
            {
            }
            column(Missions_Missions__Nom_Convoyeur_; Missions."Nom Convoyeur")
            {
            }
            column(ORDRE_DE_MISSIONCaption; ORDRE_DE_MISSIONCaptionLbl)
            {
            }
            column(Edition_02Caption; Edition_02CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Document_FLO_03Caption; Document_FLO_03CaptionLbl)
            {
            }
            column(Manuel_des_formulairesCaption; Manuel_des_formulairesCaptionLbl)
            {
            }
            column(Missions__Date_Mission_Caption; FIELDCAPTION("Date Mission"))
            {
            }
            column(Missions__Date_document_Caption; FIELDCAPTION("Date document"))
            {
            }
            column("Date_Départ______________________________________Caption"; Date_Départ______________________________________CaptionLbl)
            {
            }
            column("Date_Arrivée_____________________________________Caption"; Date_Arrivée_____________________________________CaptionLbl)
            {
            }
            column("Lieu_Départ____________________________________________________Caption"; Lieu_Départ____________________________________________________CaptionLbl)
            {
            }
            column("Lieu_Arrivée___________________________________________________Caption"; Lieu_Arrivée___________________________________________________CaptionLbl)
            {
            }
            column(Immatriculation__Caption; Immatriculation__CaptionLbl)
            {
            }
            column(Index_Fin________________________________________Caption; Index_Fin________________________________________CaptionLbl)
            {
            }
            column("Index_Départ_________________________________________Caption"; Index_Départ_________________________________________CaptionLbl)
            {
            }
            column("Heure_départ_____________________________________Caption"; Heure_départ_____________________________________CaptionLbl)
            {
            }
            column(Heure_Retour_____________________________Caption; Heure_Retour_____________________________CaptionLbl)
            {
            }
            column(Nom_Chauffeur_________________________________________Caption; Nom_Chauffeur_________________________________________CaptionLbl)
            {
            }
            column(EQUIPAGECaption; EQUIPAGECaptionLbl)
            {
            }
            column(Convoyeur________________________________________________Caption; Convoyeur________________________________________________CaptionLbl)
            {
            }
            column("Quantité_Carburant____________________________________________Caption"; Quantité_Carburant____________________________________________CaptionLbl)
            {
            }
            column(Client_____FournisseurCaption; Client_____FournisseurCaptionLbl)
            {
            }
            column(Nom_articleCaption; Nom_articleCaptionLbl)
            {
            }
            column(N__BLCaption; N__BLCaptionLbl)
            {
            }
            column("Livraison___RéceptionCaption"; Livraison___RéceptionCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column("ArrêtsCaption"; ArrêtsCaptionLbl)
            {
            }
            column(LieuCaption; LieuCaptionLbl)
            {
            }
            column("DuréeCaption"; DuréeCaptionLbl)
            {
            }
            column(CausesCaption; CausesCaptionLbl)
            {
            }
            column("RéclamationsCaption"; RéclamationsCaptionLbl)
            {
            }
            column(PanneCaption; PanneCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Signature_ChauffeurCaption; Signature_ChauffeurCaptionLbl)
            {
            }
            column(Signature_Responsable_ExploitationCaption; Signature_Responsable_ExploitationCaptionLbl)
            {
            }
            column(Missions_N__Mission; "N° Mission")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //vehicul.RESET;
                //IF vehicul.GET(Missions."N° Véhicule") THEN
                // typcarburant := vehicul."Type de Carburant";
                /*
              empl.RESET;
              IF empl.GET(Mission."Code Demandeur") THEN
               nomChauff := empl."Last Name"
              ELSE
               nomChauff := '';
              empl.RESET;
              */
                /*
                IF empl.GET() THEN
                 nomConv := empl."Last Name"
                
                 ELSE
                  nomConv := '';
                 */
                companyinfo.GET();
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
        companyinfo: Record 79;
        vehicul: Record "Véhicule";
        typcarburant: Option Essence,Gasoil,"Ess. Sans Plomb";
        empl: Record 5200;
        nomChauff: Text[100];
        nomConv: Text[100];
        ORDRE_DE_MISSIONCaptionLbl: Label 'ORDRE DE MISSION';
        Edition_02CaptionLbl: Label 'Edition 02';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Document_FLO_03CaptionLbl: Label 'Document FLO 03';
        Manuel_des_formulairesCaptionLbl: Label 'Manuel des formulaires';
        "Date_Départ______________________________________CaptionLbl": Label 'Date Départ';
        "Date_Arrivée_____________________________________CaptionLbl": Label 'Date Arrivée';
        "Lieu_Départ____________________________________________________CaptionLbl": Label 'Lieu Départ';
        "Lieu_Arrivée___________________________________________________CaptionLbl": Label 'Lieu Arrivée';
        Immatriculation__CaptionLbl: Label 'Immatriculation :';
        Index_Fin________________________________________CaptionLbl: Label 'Index Fin :......................................';
        "Index_Départ_________________________________________CaptionLbl": Label 'Index Départ :.......................................';
        "Heure_départ_____________________________________CaptionLbl": Label 'Heure départ.....................................';
        Heure_Retour_____________________________CaptionLbl: Label 'Heure Retour.............................';
        Nom_Chauffeur_________________________________________CaptionLbl: Label 'Nom Chauffeur';
        EQUIPAGECaptionLbl: Label 'EQUIPAGE';
        Convoyeur________________________________________________CaptionLbl: Label 'Convoyeur';
        "Quantité_Carburant____________________________________________CaptionLbl": Label 'Quantité Carburant............................................';
        Client_____FournisseurCaptionLbl: Label ' Client  /  Fournisseur';
        Nom_articleCaptionLbl: Label 'Nom article';
        N__BLCaptionLbl: Label 'N° BL';
        "Livraison___RéceptionCaptionLbl": Label 'Livraison / Réception';
        "QuantitéCaptionLbl": Label 'Quantité';
        "ArrêtsCaptionLbl": Label 'Arrêts';
        LieuCaptionLbl: Label 'Lieu';
        "DuréeCaptionLbl": Label 'Durée';
        CausesCaptionLbl: Label 'Causes';
        "RéclamationsCaptionLbl": Label 'Réclamations';
        PanneCaptionLbl: Label 'Panne';
        DescriptionCaptionLbl: Label 'Description';
        Signature_ChauffeurCaptionLbl: Label 'Signature Chauffeur';
        Signature_Responsable_ExploitationCaptionLbl: Label 'Signature Responsable Exploitation';
}

