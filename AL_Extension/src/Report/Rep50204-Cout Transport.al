report 50204 "Cout Transport"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CoutTransport.rdlc';

    dataset
    {
        dataitem("Ligne Rendement Vehicule"; "Ligne Rendement Vehicule Enr")
        {
            DataItemTableView = SORTING(Journee, Vehicule, Provenance, Destination, Produit);
            RequestFilterFields = Journee, Vehicule;
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
            column(Ligne_Rendement_Vehicule_Journee; Journee)
            {
            }
            column(Ligne_Rendement_Vehicule_Vehicule; Vehicule)
            {
            }
            column(Ligne_Rendement_Vehicule_Volume; Volume)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item2_Description; Item2.Description)
            {
            }
            column(Ligne_Rendement_Vehicule_Destination; Destination)
            {
            }
            column(Ligne_Rendement_Vehicule_Provenance; Provenance)
            {
            }
            column(CoutKm; CoutKm)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Total; Total)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ABS_CPR_; ABS(CPR))
            {
                DecimalPlaces = 0 : 0;
            }
            column(CoutTotGasoil; CoutTotGasoil)
            {
                DecimalPlaces = 0 : 0;
            }
            column(AMMJ_MSJ; AMMJ + MSJ)
            {
                DecimalPlaces = 0 : 0;
            }
            column(CoutTotalM3; CoutTotalM3)
            {
                DecimalPlaces = 0 : 0;
            }
            column(NbrVoyage; NbrVoyage)
            {
            }
            column(CoutVoyage; CoutVoyage)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Ligne_Rendement_Vehicule__Distance_Parcourus_; "Distance Parcourus")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Ligne_Rendement_VehiculeCaption; Ligne_Rendement_VehiculeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cout_TransportCaption; Cout_TransportCaptionLbl)
            {
            }
            column(ProvenanceCaption; ProvenanceCaptionLbl)
            {
            }
            column(DestinationCaption; DestinationCaptionLbl)
            {
            }
            column(ProduitCaption; ProduitCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VolumeCaption; VolumeCaptionLbl)
            {
            }
            column(Cout___KMCaption; Cout___KMCaptionLbl)
            {
            }
            column(AMJ___MSCaption; AMJ___MSCaptionLbl)
            {
            }
            column(GasoilCaption; GasoilCaptionLbl)
            {
            }
            column(PRCaption; PRCaptionLbl)
            {
            }
            column(Cout_M3Caption; Cout_M3CaptionLbl)
            {
            }
            column(Nbr_VoyageCaption; Nbr_VoyageCaptionLbl)
            {
            }
            column(Cout_TotalCaption; Cout_TotalCaptionLbl)
            {
            }
            column(DistanceCaption; DistanceCaptionLbl)
            {
            }
            column(Ligne_Rendement_Vehicule_Heure; Heure)
            {
            }
            column(Ligne_Rendement_Vehicule_Produit; Produit)
            {
            }
            // column(Ligne_Rendement_Vehicule_Code_Affaire; "Code Affaire")
            // {
            // }

            trigger OnPreDataItem()
            begin
                IF FORMAT(GETFILTER(Journee)) = '' THEN ERROR(Text001);
                //SETRANGE(Journee,DateDebut,DateFin);
            end;

            trigger OnAfterGetRecord()
            begin




                //  CurrReport.SHOWOUTPUT :=
                // CurrReport.TOTALSCAUSEDBY = "Ligne Rendement Vehicule".FIELDNO(Vehicule);
                IF CurrReport.TOTALSCAUSEDBY = "Ligne Rendement Vehicule".FIELDNO(Vehicule) THEN BEGIN
                    // Total:=0;
                    CPR := 0;
                    AMMJ := 0;
                    MSJ := 0;
                    Divers := 0;
                    CoutTotGasoil := 0;
                    NbrJourFonctionne := 0;
                    NbrJourDisponible := 0;
                    NbJourPanne := 0;
                    VolumeTotal := 0;
                    DistanceTotal := 0;
                    NbrVoyage := 0;
                    LigneRendementVehiculeEnr.SETRANGE(Journee, Journee, Journee);
                    LigneRendementVehiculeEnr.SETRANGE(Vehicule, Vehicule);
                    IF LigneRendementVehiculeEnr.FINDFIRST THEN
                        REPEAT
                            VolumeTotal += LigneRendementVehiculeEnr.Volume;
                            DistanceTotal += LigneRendementVehiculeEnr."Distance Parcourus";

                        UNTIL LigneRendementVehiculeEnr.NEXT = 0;
                END;
                //CurrReport.SHOWOUTPUT :=
                // CurrReport.TOTALSCAUSEDBY ="Ligne Rendement Vehicule".FIELDNO(Produit);
                IF CurrReport.TOTALSCAUSEDBY = "Ligne Rendement Vehicule".FIELDNO(Produit) THEN BEGIN

                    CLEAR(FADepreciationBook);
                    CLEAR(LignePointageVehicule);
                    CLEAR(ItemLedgerEntry);
                    CLEAR(Resource);
                    AMMJournalier := 0;
                    Total := 0;
                    CPR := 0;
                    AMMJ := 0;
                    MSJ := 0;
                    CMOYH := 0;
                    Divers := 0;
                    CoutTotGasoil := 0;
                    NbrJourFonctionne := 0;
                    NbrJourDisponible := 0;
                    CoutJournalier := 0;
                    NbJourPanne := 0;
                    IF InventorySetup.GET THEN;
                    IF Item.GET(InventorySetup."Article Gasoil") THEN PUGasoil := Item."Last Direct Cost";

                    LignePointageVehicule.SETRANGE(Journee, Journee, Journee);
                    LignePointageVehicule.SETRANGE(Vehicule, Vehicule);
                    IF LignePointageVehicule.FINDFIRST THEN
                        REPEAT
                            IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN NbrJourFonctionne += 1;
                            IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrJourDisponible += 1;
                            IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbJourPanne += 1;
                        UNTIL LignePointageVehicule.NEXT = 0;
                    CLEAR(RecVehicule);
                    IF ParamétreParc.GET THEN;
                    IF RecVehicule.GET(Vehicule) THEN BEGIN
                        IF Resource.GET(RecVehicule.MO) THEN
                            CoutJournalier := Resource."Direct Unit Cost";

                        //  CoutJournalier:=RecVehicule."Cout Journalier";

                        PrixLocation := RecVehicule."Cout Journalier";
                    END;
                    IF Item.GET(ParamétreParc."Article Gasoil") THEN;
                    CPR := 0;
                    QteGasoil := 0;
                    MHT := 0;
                    TauxOccup := 0;
                    MQA := 0;
                    AMMJ := 0;
                    MSJ := 0;
                    // Debut  CAlcul index depart du mois et index fin
                    LigneFicheGasoil.RESET;
                    LigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
                    LigneFicheGasoil.SETRANGE(Journee, Journee, Journee);
                    LigneFicheGasoil.SETRANGE(Materiel, Vehicule);

                    IF LigneFicheGasoil.FINDFIRST THEN BEGIN
                        IndexDepart := LigneFicheGasoil."Valeur Compteur";
                    END;
                    //-------------------------------------------------------
                    LigneFicheGasoil.RESET;
                    LigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
                    LigneFicheGasoil.SETRANGE(Journee, Journee, Journee);
                    LigneFicheGasoil.SETRANGE(Materiel, Vehicule);

                    IF LigneFicheGasoil.FINDLAST THEN BEGIN
                        IndexFinal := LigneFicheGasoil."Valeur Compteur";
                    END;

                    // Fin CAlcul index depart du mois et index fin
                    HeureTravailTheorique := ParamétreParc."Heure Travail";
                    // RB SORO 31/03/2016
                    RecParamétreParc.GET;
                    // RB SORO 31/03/2016
                    HeureUtilisation := IndexFinal - IndexDepart;
                    HNormal := NbrJourFonctionne * ParamétreParc."Heure Travail";
                    MQA := HNormal - HeureUtilisation;

                    IF (NbrJourFonctionne <> 0) AND (HeureTravailTheorique <> 0) THEN BEGIN

                        MHT := HeureUtilisation / NbrJourFonctionne;
                        TauxOccup := ((HeureUtilisation / NbrJourFonctionne) / HeureTravailTheorique) * 100;
                    END;
                    LigneFicheGasoil.RESET;
                    LigneFicheGasoil.SETRANGE(Journee, Journee, Journee);
                    LigneFicheGasoil.SETRANGE(Materiel, Vehicule);

                    IF LigneFicheGasoil.FINDFIRST THEN
                        REPEAT
                            QteGasoil += LigneFicheGasoil."Quantité Gasoil";
                        UNTIL LigneFicheGasoil.NEXT = 0;
                    // CPR
                    ItemLedgerEntry.SETCURRENTKEY("N° Véhicule", "Item No.", "Posting Date");
                    ItemLedgerEntry.SETRANGE("Posting Date", Journee, Journee);
                    // RB SORO 31/03/2016
                    IF RecParamétreParc."Article Gasoil" = '' THEN ERROR(Text010);
                    ItemLedgerEntry.SETFILTER("Item No.", '<>%1', RecParamétreParc."Article Gasoil");
                    // RB SORO 31/03/2016
                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                    ItemLedgerEntry.SETRANGE("N° Véhicule", Vehicule);
                    IF ItemLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF Item.GET(ItemLedgerEntry."Item No.") THEN;
                            ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                            CPR += ABS(ItemLedgerEntry.Quantity) * Item."Last Direct Cost";

                        UNTIL ItemLedgerEntry.NEXT = 0;
                    // CPR
                    IF HeureUtilisation <> 0 THEN CMOYH := ROUND(QteGasoil / HeureUtilisation, 1);
                    CoutTotGasoil := QteGasoil * PUGasoil;
                    CLEAR(FADepreciationBook);
                    IF RecVehicule."Code Immo" <> '' THEN BEGIN
                        FADepreciationBook.SETRANGE("FA No.", RecVehicule."Code Immo");
                        IF FADepreciationBook.FINDFIRST THEN BEGIN
                            FADepreciationBook.CALCFIELDS("Acquisition Cost");
                            DateAcuisition := FADepreciationBook."Acquisition Date";
                            DateFinAmort := CALCDATE(FORMAT(ParamétreParc."Nombre année Calcul AMJ") + 'A', DateAcuisition);

                            IF FADepreciationBook."No. of Depreciation Years" <> 0 THEN
                                JoursAmortiss := 360 * FADepreciationBook."No. of Depreciation Years"
                            ELSE
                                JoursAmortiss := 360 * (NbrAnnee);

                            JoursAmortiss := 360 * (ParamétreParc."Nombre année Calcul AMJ");
                            IF JoursAmortiss <> 0 THEN
                                AMMJournalier := ROUND(FADepreciationBook."Acquisition Cost" / JoursAmortiss, 1);
                        END;
                    END;
                    //    message('%1 %2 %3',JoursAmortiss, FADepreciationBook."Book Value", "AMM Journalier");
                    CoutLocation := (CoutJournalier) * NbrJourFonctionne;

                    // AMMJ:=("AMM Journalier"/HeureTravailTheorique) *(HeureUtilisation+NbrJourDisponible*HeureTravailTheorique+
                    // NbJourPanne);

                    AMMJ := AMMJournalier;
                    IF DateFinAmort < WORKDATE THEN AMMJ := 0;
                    MSJ := CoutJournalier * (NbJourPanne + NbrJourFonctionne + NbrJourDisponible);
                    Divers := ROUND((ABS(CPR) + AMMJ + MSJ) * 5 / 100, 1);
                    Total := ABS(CPR) + AMMJ + MSJ + Divers + CoutTotGasoil;
                    Resultat := CoutLocation - Total;
                    IF Item2.GET(Produit) THEN;
                    // IF Volume<>0 THEN  CoutM3:=Total/VolumeTotal;
                    // message('tota %1',total) ;
                    IF DistanceTotal <> 0 THEN
                        CoutKm := Total / DistanceTotal;
                    CoutVoyage := (NbrVoyage * "Distance Parcourus") * CoutKm;
                    IF Volume <> 0 THEN
                        CoutTotalM3 := CoutVoyage / (Volume);

                    LigneRapportChantier.SETRANGE(Journee, Journee);
                    LigneRapportChantier.SETRANGE(Ressource, LigneRapportChantier.Ressource::Transport);
                    LigneRapportChantier.SETRANGE(Materiel, Vehicule);
                    LigneRapportChantier.SETRANGE(Statut, LigneRapportChantier.Statut::Ouvert);
                    IF LigneRapportChantier.FINDFIRST THEN
                        REPEAT
                            LigneRapportChantier.Cout := LigneRapportChantier."Distance Parcourus" * CoutKm;
                            LigneRapportChantier.MODIFY;
                        UNTIL LigneRapportChantier.NEXT = 0;

                END;
                // RB SORO 29/03/2016

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

    trigger OnInitReport()
    begin
        DateDebut := 20161101D;//011116D;
        DateFin := 20161130D;//301116D;
    end;

    var
        Text001: Label 'Date Manquante';
        Text002: Label 'Preciser Affectation';
        Text008: Label 'Data';
        Text009: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text010: Label 'Veuillez Parametrer le code article gaoil dans parametre parc';
        TotalFor: Label 'Total ';
        LigneRendementVehiculeEnr: Record "Ligne Rendement Vehicule";
        "ParamétreParc": Record "Paramétre Parc";
        RecVehicule: Record "Véhicule";
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        FADepreciationBook: Record "FA Depreciation Book";
        InventorySetup: Record "Inventory Setup";
        Item: Record "item";
        Item2: Record "item";
        ItemLedgerEntry: Record "item Ledger Entry";
        LigneFicheGasoil: Record "Ligne Fiche Gasoil";
        Resource: Record "Resource";
        DateDebut: Date;
        DateFin: Date;
        GAffectation: Code[20];
        NbJourPanne: Decimal;
        NbrJourFonctionne: Decimal;
        NbrJourDisponible: Decimal;
        IndexDepart: Decimal;
        IndexFinal: Decimal;
        HTravaille: Decimal;
        HNormal: Decimal;
        i: Decimal;
        QteGasoil: Decimal;
        MHT: Decimal;
        TauxOccup: Decimal;
        PUGasoil: Decimal;
        CoutGasoil: Decimal;
        MQA: Decimal;
        CMOYH: Decimal;
        PrixLocation: Decimal;
        CoutLocation: Decimal;
        CPR: Decimal;
        AMMJ: Decimal;
        MSJ: Decimal;
        Divers: Decimal;
        Total: Decimal;
        Resultat: Decimal;
        "// RB SORO": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        "RecParamétreParc": Record "Paramétre Parc";
        JoursAmortiss: Decimal;
        NbrAnnee: Integer;
        CoutTotGasoil: Decimal;
        CoutJournalier: Decimal;
        HeureTravailTheorique: Integer;
        HeureUtilisation: Decimal;
        AMMJournalier: Decimal;
        CoutM3: Decimal;
        CoutKm: Decimal;
        VolumeTotal: Decimal;
        DistanceTotal: Decimal;
        NbrVoyage: Integer;
        CoutVoyage: Decimal;
        CoutTotalM3: Decimal;
        DateAcuisition: Date;
        DateFinAmort: Date;
        LigneRapportChantier: Record "Ligne Rapport Chantier";
        Ligne_Rendement_VehiculeCaptionLbl: Label 'Ligne Rendement Vehicule';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Cout_TransportCaptionLbl: Label 'Cout Transport';
        ProvenanceCaptionLbl: Label 'Provenance';
        DestinationCaptionLbl: Label 'Destination';
        ProduitCaptionLbl: Label 'Produit';
        TotalCaptionLbl: Label 'Total';
        VolumeCaptionLbl: Label 'Volume';
        Cout___KMCaptionLbl: Label 'Cout / KM';
        AMJ___MSCaptionLbl: Label 'AMJ + MS';
        GasoilCaptionLbl: Label 'Gasoil';
        PRCaptionLbl: Label 'PR';
        Cout_M3CaptionLbl: Label 'Cout M3';
        Nbr_VoyageCaptionLbl: Label 'Nbr Voyage';
        Cout_TotalCaptionLbl: Label 'Cout Total';
        DistanceCaptionLbl: Label 'Distance';

    [Scope('Internal')]
    procedure CalcCoutJournalier()
    begin
    end;
}

