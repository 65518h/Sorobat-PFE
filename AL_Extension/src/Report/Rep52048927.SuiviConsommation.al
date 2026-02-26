report 52048927 "Suivi Consommation"
// Dys Jasser.B 2025 Nav 39004681
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SuiviConsommation.rdlc';

    dataset
    {
        dataitem("Véhicule"; 52048972)
        {
            DataItemTableView = SORTING(Famille)
                                ORDER(Ascending);
            RequestFilterFields = "N° Vehicule";
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("Mission_Enregistré__GETFILTERS"; "Mission Enregistré".GETFILTERS)
            {
            }
            column(Mois_de____FORMAT__mois_; 'Mois de  ' + FORMAT(mois))
            {
            }
            column("RTECATV_Désignation"; RTECATV.Désignation)
            {
            }
            column(KM_PrcouruCaption; KM_PrcouruCaptionLbl)
            {
            }
            column("Prise_carburant_Enregistré__N__Véhicule_Caption"; "Prise carburant Enregistré".FIELDCAPTION("N° Véhicule"))
            {
            }
            column(ChauffeurCaption; ChauffeurCaptionLbl)
            {
            }
            column("Index_Début_de_moisCaption"; Index_Début_de_moisCaptionLbl)
            {
            }
            column(Index_Fin_de_moisCaption; Index_Fin_de_moisCaptionLbl)
            {
            }
            column(Total_GasoilCaption; Total_GasoilCaptionLbl)
            {
            }
            column(Taux_Consom___KMCaption; Taux_Consom___KMCaptionLbl)
            {
            }
            column(Consom_CibleCaption; Consom_CibleCaptionLbl)
            {
            }
            column(MatriculeCaption; MatriculeCaptionLbl)
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Véhicule_N__Vehicule"; "N° Vehicule")
            {
            }
            column("Véhicule_Famille"; Famille)
            {
            }
            dataitem("Mission Enregistré"; 52048983)
            {
                DataItemLink = "N° Véhicule" = FIELD("N° Vehicule");
                DataItemTableView = SORTING("N° Véhicule")
                                    ORDER(Ascending);
                RequestFilterFields = "Date Mission";

                trigger OnPreDataItem()
                begin
                    DD := DMY2DATE(1, mois, DATE2DMY(WORKDATE, 3));
                    DF := CALCDATE('FM', DD);
                    SETRANGE("Date Mission", DD, DF);
                end;

                trigger OnAfterGetRecord()
                begin

                    IndexDéb := "Index Cpt. Depart";

                    IndexFin := "Mission Enregistré"."Index Cpt. Retour";
                end;
            }
            dataitem("Prise carburant Enregistré"; 52048984)
            {
                DataItemLink = "N° Véhicule" = FIELD("N° Vehicule");
                RequestFilterFields = "Date de Prise";
                column("Prise_carburant_Enregistré__N__Véhicule_"; "N° Véhicule")
                {
                }
                column("IndexDéb"; IndexDéb)
                {
                }
                column(IndexFin; IndexFin)
                {
                }
                column("Véhicule_Immatriculation"; Véhicule.Immatriculation)
                {
                }
                column("IndexFin_IndexDéb"; IndexFin - IndexDéb)
                {
                }
                column("Prise_carburant_Enregistré__Gasoil_Consommé_"; "Gasoil Consommé")
                {
                }
                column("Gasoil_Consommé____IndexFin_IndexDéb__100"; "Gasoil Consommé" / (IndexFin - IndexDéb) * 100)
                {
                }
                column("Véhicule__Consommation_Moyen_"; Véhicule."Consommation Moyen")
                {
                }
                column("Prise_carburant_Enregistré_Sequence"; Sequence)
                {
                }
                column("Prise_carburant_Enregistré_N__Mission"; "N° Mission")
                {
                }

                trigger OnPreDataItem()
                begin
                    DD := DMY2DATE(1, mois, DATE2DMY(WORKDATE, 3));
                    DF := CALCDATE('FM', DD);
                    SETRANGE("Date de Prise", DD, DF);
                end;
            }
            trigger OnAfterGetRecord()
            begin

                Mission := FALSE;
                Véh.RESET;
                Véh.SETRANGE(Famille, Véhicule.Famille);
                IF Véh.FINDFIRST THEN
                    REPEAT
                        IF Mission = FALSE THEN BEGIN
                            MisEnreg.RESET;
                            MisEnreg.SETRANGE("N° Véhicule", Véh."N° Vehicule");
                            IF MisEnreg.FINDFIRST THEN
                                Mission := TRUE;
                        END;
                    UNTIL Véh.NEXT = 0;
                CurrReport.SHOWOUTPUT(Mission);
                IF RTECATV.GET(Famille) THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(mois; mois)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Sélectionnez le mois pour lequel vous souhaitez afficher les données.';
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
        "IndexDéb": Decimal;
        "Véh": Record 52048972;
        IndexFin: Decimal;
        CompInfor: Record 79;
        MisEnreg: Record 52048983;
        Mission: Boolean;
        mois: Option " ",Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Âout",Septembre,Octobre,Novembre,"Décembre";
        DD: Date;
        DF: Date;
        RTECATV: Record 52048974;
        KM_PrcouruCaptionLbl: Label 'KM Prcouru';
        ChauffeurCaptionLbl: Label 'Chauffeur';
        "Index_Début_de_moisCaptionLbl": Label 'Index Début de mois';
        Index_Fin_de_moisCaptionLbl: Label 'Index Fin de mois';
        Total_GasoilCaptionLbl: Label 'Total Gasoil';
        Taux_Consom___KMCaptionLbl: Label 'Taux Consom / KM';
        Consom_CibleCaptionLbl: Label 'Consom Cible';
        MatriculeCaptionLbl: Label 'Matricule';
        Item_Ledger_EntryCaptionLbl: Label 'Suivi Consommation Gasoil Mensuel';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

