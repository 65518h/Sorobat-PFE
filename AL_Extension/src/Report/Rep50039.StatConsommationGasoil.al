report 50039 "Stat Consommation Gasoil"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StatConsommationGasoil.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Stat Consommation Gasoil';

    dataset
    {
        dataitem("Ligne Fiche Gasoil"; 50017)
        {
            DataItemTableView = SORTING(Materiel, Journee, Heure)
                                ORDER(Descending)
                                WHERE(Statut = CONST(Valider));
            RequestFilterFields = Cuve, Materiel, Journee, Affaire, Chauffeur, Destination, "Document No.";

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
            column(Ligne_Fiche_Gasoil_Materiel; Materiel)
            {
            }
            column(Ligne_Fiche_Gasoil__Nom_Engin_; "Nom Engin")
            {
            }
            column(Ligne_Fiche_Gasoil_Journee; Journee)
            {
            }
            column(Ligne_Fiche_Gasoil_Heure; Heure)
            {
            }
            column(Ligne_Fiche_Gasoil__Valeur_Compteur_; "Valeur Compteur")
            {
            }
            column("Ligne_Fiche_Gasoil__Quantité_Gasoil_"; "Quantité Gasoil")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Ligne_Fiche_Gasoil_Affaire; Affaire)
            {
            }
            column(Ligne_Fiche_Gasoil__Ligne_Fiche_Gasoil__Cuve; "Ligne Fiche Gasoil".Cuve)
            {
            }
            column(Ligne_Fiche_Gasoil_Destination; Destination)
            {
            }
            column(Ligne_Fiche_Gasoil_Trajet; Trajet)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Ligne_Fiche_Gasoil_Consommation; Consommation)
            {
            }
            column(Ligne_Fiche_Gasoil__Document_No__; "Document No.")
            {
            }
            column(OptRepture; OptRepture)
            {
            }
            column(EnteteGAsoil__N__Fiche_; EnteteGAsoil."N° Fiche")
            {
            }
            column("Ligne_Fiche_Gasoil__Quantité_Gasoil__Control1000000033"; "Quantité Gasoil")
            {
                DecimalPlaces = 0 : 0;
            }
            column(FirstValue_LastValue; FirstValue - LastValue)
            {
            }
            column(ConsommationT; ConsommationT)
            {
            }
            column(Ligne_Fiche_Gasoil_Compteur; Compteur)
            {
            }
            column(Ligne_Fiche_Gasoil_Trajet_Control1000000015; Trajet)
            {
                DecimalPlaces = 0 : 0;
            }
            column(SORTIE_GASOIL_PAR_VEHICULECaption; SORTIE_GASOIL_PAR_VEHICULECaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Materiel_Caption; Materiel_CaptionLbl)
            {
            }
            column(IndexCaption; IndexCaptionLbl)
            {
            }
            column(QteCaption; QteCaptionLbl)
            {
            }
            column(CuveCaption; CuveCaptionLbl)
            {
            }
            column(TrajetCaption; TrajetCaptionLbl)
            {
            }
            column(Consom_Caption; Consom_CaptionLbl)
            {
            }
            column(AffaireCaption; AffaireCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(N__BonCaption; N__BonCaptionLbl)
            {
            }
            column(N__FicheCaption; N__FicheCaptionLbl)
            {
            }
            column(Nombre_De_LignesCaption; Nombre_De_LignesCaptionLbl)
            {
            }
            column(Ligne_Fiche_Gasoil_Numero_Ligne; "Numero Ligne")
            {
            }
            column(DestinationCaption; DestinationCaption)
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Materiel);
            end;

            trigger OnAfterGetRecord()
            var
            begin
                if Materiel <> Materiel2 then begin
                    ConsommationT := 0;
                    QuteGasoil := 0;
                    Materiel2 := Materiel;
                    FirstValue := 0;
                    LastValue := 0;
                end;

                QuteGasoil += "Quantité Gasoil";

                IF EnteteGAsoil.GET("Document No.") THEN;
                IF Vehicule.GET(Materiel) THEN;
                Compteur := "Ligne Fiche Gasoil".Count;
                Trajet := 0;
                Consommation := 0;
                RecLigneFicheGasoil.SETRANGE(Materiel, Materiel);
                RecLigneFicheGasoil.SETFILTER(Journee, '<%1', Journee);
                RecLigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
                IF (RecLigneFicheGasoil.FINDLAST) THEN
                    Trajet := "Valeur Compteur" - RecLigneFicheGasoil."Valeur Compteur";
                IF Trajet <> 0 THEN BEGIN
                    IF "Type Index" = 1 THEN
                        Consommation := ("Quantité Gasoil" / Trajet)
                    ELSE IF "Type Index" = 2 THEN Consommation := ("Quantité Gasoil" / Trajet) * 100;
                END;

                IF FirstValue = 0 THEN FirstValue := "Valeur Compteur";
                LastValue := "Valeur Compteur";
                IF "Dernier Index" > Vehicule."Consommation Max" THEN
                    OptRepture := OptRepture::Max ELSE
                    OptRepture := OptRepture::Min;

                IF FirstValue - LastValue <> 0 THEN ConsommationT := ("Quantité Gasoil" / (FirstValue - LastValue)) * 100;
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

    trigger OnPostReport()
    begin
        // IF PrintToExcel THEN
        //     CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        // IF PrintToExcel THEN
        //     MakeExcelInfo;

    end;

    var
        Vehicule: Record 52048972;
        EnteteGAsoil: Record 50016;
        RecLigneFicheGasoil: Record 50017;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Trajet: Decimal;
        Consommation: Decimal;
        ConsommationT: Decimal;
        FirstValue: Decimal;
        LastValue: Decimal;
        Compteur: Decimal;
        Image: Integer;
        OptRepture: Option "Min","Max";
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Etat Mouvement Articles';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        SORTIE_GASOIL_PAR_VEHICULECaptionLbl: Label 'SORTIE GASOIL PAR VEHICULE';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Materiel_CaptionLbl: Label '** Materiel ';
        IndexCaptionLbl: Label 'Index';
        QteCaptionLbl: Label 'Qte';
        CuveCaptionLbl: Label 'Cuve';
        DestinationCaption: Label 'Destination';
        TrajetCaptionLbl: Label 'Trajet';
        Consom_CaptionLbl: Label '% Consom.';
        AffaireCaptionLbl: Label 'Affaire';
        DateCaptionLbl: Label 'Date';
        N__BonCaptionLbl: Label 'N° Bon';
        N__FicheCaptionLbl: Label 'N° Fiche';
        Materiel2: code[20];
        Nombre_De_LignesCaptionLbl: Label 'Nombre De Lignes';
        QuteGasoil: Decimal;

    // [Scope('Internal')]
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(REPORT::"Mouvement Articles", FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
        //ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('N° BON', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° FICHE', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('DATE', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('AFFAIRE', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('CUVE', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('DESTINATION', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('INDEX', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('QUANTITE', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('TRAJET', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('CONSOMMATION', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('N° Vehicule :' + "Ligne Fiche Gasoil".Materiel, FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Description :' + "Ligne Fiche Gasoil"."Nom Engin", FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    // [Scope('Internal')]
    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(EnteteGAsoil."N° Fiche", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(FORMAT("Ligne Fiche Gasoil".Journee) + ' ' + FORMAT("Ligne Fiche Gasoil".Heure), FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Affaire, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Cuve, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Destination, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Valeur Compteur", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Quantité Gasoil", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Trajet, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Dernier Index", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Stat Consommation Gasoil');
        // ExcelBuf.CreateSheet(Text001, Text002, COMPANYNAME, USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

