report 52048900 "Fiche Réparation"
{ //GL2024  ID dans Nav 2009 : "39004672"
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FicheRéparation2.rdlc';
    Caption = 'Fiche Réparation';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Réparation Véhicule"; "Réparation Véhicule")
        {
            DataItemTableView = SORTING("N° Reparation");
            RequestFilterFields = "N° Reparation", "N° Véhicule";
            column("Réparation_Véhicule__N__Reparation_"; "N° Reparation")
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("Réparation_Véhicule__N__Véhicule_"; "N° Véhicule")
            {
            }
            column("Réparation_Véhicule__N__Intervenant_"; "N° Intervenant")
            {
            }
            column("Réparation_Véhicule__Date_Début_Réparation_"; "Date Début Réparation")
            {
            }
            column("Réparation_Véhicule__Date_Fin_réparation_"; "Date Fin réparation")
            {
            }
            column("Réparation_Véhicule__Descriptif_Panne_"; "Descriptif Panne")
            {
            }
            column("Réparation_Véhicule_Accidentée"; Accidentée)
            {
            }
            column("Réparation_Véhicule__Nature_Panne_"; "Nature Panne")
            {
            }
            column("Réparation_Véhicule__Degré_d_Urgence_"; "Degré d'Urgence")
            {
            }
            column("Réparation_Véhicule__Sous_Nature_Panne_"; "Sous Nature Panne")
            {
            }
            column("Réparation_Véhicule__Opération_Realisées_"; "Opération Realisées")
            {
            }
            column("Réparation_Véhicule__Date_Acceptation_"; "Date Acceptation")
            {
            }
            column("Réparation_Véhicule__Date_Prevision_Réparation_"; "Date Prevision Réparation")
            {
            }
            column("Réparation_Véhicule__Total_Cout_réparation_"; "Total Cout réparation")
            {
            }
            column("Fiche_de_réparationCaption"; Fiche_de_réparationCaptionLbl)
            {
            }
            column(N_Caption; N_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Réparation_Véhicule__N__Véhicule_Caption"; FIELDCAPTION("N° Véhicule"))
            {
            }
            column("Réparation_Véhicule__N__Intervenant_Caption"; FIELDCAPTION("N° Intervenant"))
            {
            }
            column("Réparation_Véhicule__Date_Début_Réparation_Caption"; FIELDCAPTION("Date Début Réparation"))
            {
            }
            column("Réparation_Véhicule__Date_Fin_réparation_Caption"; FIELDCAPTION("Date Fin réparation"))
            {
            }
            column("Réparation_Véhicule__Descriptif_Panne_Caption"; FIELDCAPTION("Descriptif Panne"))
            {
            }
            column("Réparation_Véhicule_AccidentéeCaption"; FIELDCAPTION(Accidentée))
            {
            }
            column("Réparation_Véhicule__Nature_Panne_Caption"; FIELDCAPTION("Nature Panne"))
            {
            }
            column("Réparation_Véhicule__Degré_d_Urgence_Caption"; FIELDCAPTION("Degré d'Urgence"))
            {
            }
            column("Réparation_Véhicule__Sous_Nature_Panne_Caption"; FIELDCAPTION("Sous Nature Panne"))
            {
            }
            column("Réparation_Véhicule__Opération_Realisées_Caption"; FIELDCAPTION("Opération Realisées"))
            {
            }
            column("Réparation_Véhicule__Date_Acceptation_Caption"; FIELDCAPTION("Date Acceptation"))
            {
            }
            column("Date_Prevision_Réparat_Caption"; Date_Prevision_Réparat_CaptionLbl)
            {
            }
            column("Réparation_Véhicule__Total_Cout_réparation_Caption"; FIELDCAPTION("Total Cout réparation"))
            {
            }
            dataitem("PR Réparation"; "PR Réparation")
            {
                DataItemLink = "N° Reparation" = FIELD("N° Reparation");
                DataItemTableView = SORTING("N° Reparation", "N° Ligne");
                column("PR_Réparation__No__"; "No.")
                {
                }
                column("PR_Réparation_Quantité"; Quantité)
                {
                }
                column("PR_Réparation_Description"; Description)
                {
                }
                column(ReferenceCaption; ReferenceCaptionLbl)
                {
                }
                column("PR_Réparation_QuantitéCaption"; FIELDCAPTION(Quantité))
                {
                }
                column("PR_Réparation_DescriptionCaption"; FIELDCAPTION(Description))
                {
                }
                column(PiecesCaption; PiecesCaptionLbl)
                {
                }
                column("PR_Réparation_N__Reparation"; "N° Reparation")
                {
                }
                column("PR_Réparation_N__Ligne"; "N° Ligne")
                {
                }
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
        "Fiche_de_réparationCaptionLbl": Label 'Fiche de réparation';
        N_CaptionLbl: Label 'N°';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Date_Prevision_Réparat_CaptionLbl": Label 'Date Prevision Réparat.';
        ReferenceCaptionLbl: Label 'Reference';
        PiecesCaptionLbl: Label 'Pieces';
}

