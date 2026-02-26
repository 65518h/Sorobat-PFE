report 50061 "Pointage Journalier2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PointageJournalier2.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Entete Pointage Vehicule"; "Entete Pointage Vehicule")
        {
            DataItemTableView = SORTING("N° Document");
            RequestFilterFields = Journee, Marche;
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
            column(Entete_Pointage_Vehicule_Journee; Journee)
            {
            }
            column(Entete_Pointage_VehiculeCaption; Entete_Pointage_VehiculeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(POINTAGE_JOURNEECaption; POINTAGE_JOURNEECaptionLbl)
            {
            }
            column(Ligne_Pointage_Vehicule_DescriptionCaption; "Ligne Pointage Vehicule".FIELDCAPTION(Description))
            {
            }
            column("VéhiculeCaption"; VéhiculeCaptionLbl)
            {
            }
            column(StatutCaption; StatutCaptionLbl)
            {
            }
            column(Ligne_Pointage_Vehicule__Index_Depart_Caption; Ligne_Pointage_Vehicule__Index_Depart_Caption)
            {
            }
            column(Ligne_Pointage_Vehicule__Index_Final_Caption; Ligne_Pointage_Vehicule__Index_Final_Caption)
            {
            }
            column(ChauffeurCaption; ChauffeurCaptionLbl)
            {
            }
            column(Entete_Pointage_Vehicule_N__Document; "N° Document")
            {
            }
            dataitem("Ligne Pointage Vehicule"; "Ligne Pointage Vehicule")
            {
                DataItemLink = "Document N°" = FIELD("N° Document");
                DataItemTableView = SORTING("Document N°", Vehicule, Journee);
                column(Ligne_Pointage_Vehicule_Vehicule; Vehicule)
                {
                }
                column(Ligne_Pointage_Vehicule_Description; Description)
                {
                }
                column(FORMAT_Statut_; FORMAT(Statut))
                {
                }
                column(Ligne_Pointage_Vehicule__Index_Depart_; "Index Depart")
                {
                }
                column(Ligne_Pointage_Vehicule__Index_Final_; "Index Final")
                {
                }
                column(TxtChaffeur; "Ligne Pointage Vehicule".Chauffeur)
                {
                }
                column(Ligne_Pointage_Vehicule_Document_N_; "Document N°")
                {
                }
                column(Ligne_Pointage_Vehicule_Journee; Journee)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
            begin

                // TxtChaffeur := '';
                // IF salarier.GET("Ligne Pointage Vehicule".Chauffeur) THEN TxtChaffeur := salarier.Salarie;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("N° Document");
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
        Chu: Integer;
        TxtChaffeur: Code[60];
        salarier: Record 50011;
        Entete_Pointage_VehiculeCaptionLbl: Label 'Entete Pointage Vehicule';
        Ligne_Pointage_Vehicule__Index_Depart_Caption: Label 'Index Depart';
        Ligne_Pointage_Vehicule__Index_Final_Caption: Label 'Index Final';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        POINTAGE_JOURNEECaptionLbl: Label 'POINTAGE JOURNEE';
        "VéhiculeCaptionLbl": Label 'Véhicule';
        StatutCaptionLbl: Label 'Statut';
        ChauffeurCaptionLbl: Label 'Chauffeur';
}

