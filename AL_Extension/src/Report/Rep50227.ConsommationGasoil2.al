report 50227 "Consommation Gasoil 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ConsommationGasoil2.rdlc';

    dataset
    {
        dataitem("Entete Fiche Gasoil"; 50016)
        {
            DataItemTableView = SORTING(Cuve, Journee);
            PrintOnlyIfDetail = true;
            RequestFilterFields = Journee, Cuve;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("Journée_Du________FORMAT_GETRANGEMIN_Journee________Au________FORMAT_GETRANGEMAX_Journee__"; 'Journée Du :   ' + FORMAT(GETRANGEMIN(Journee)) + '  Au :   ' + FORMAT(GETRANGEMAX(Journee)))
            {
            }
            column(Entete_Fiche_Gasoil_Cuve; Cuve)
            {
            }
            column(TotalGasoil; TotalGasoil)
            {
                DecimalPlaces = 0 : 0;
            }
            column("N__VéhiculeCaption"; N__VéhiculeCaptionLbl)
            {
            }
            column(MatriculeCaption; MatriculeCaptionLbl)
            {
            }
            column(CiterneCaption; CiterneCaptionLbl)
            {
            }
            column(HeureCaption; HeureCaptionLbl)
            {
            }
            column(ChauffeurCaption; ChauffeurCaptionLbl)
            {
            }
            column("DéstinationCaption"; DéstinationCaptionLbl)
            {
            }
            column(CompteurCaption; CompteurCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column(Inventory_MovementCaption; Inventory_MovementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(JourneeCaption; JourneeCaptionLbl)
            {
            }
            column(N__FicheCaption; N__FicheCaptionLbl)
            {
            }
            column(Index_De_La_CiterneCaption; Index_De_La_CiterneCaptionLbl)
            {
            }
            column(Citerne__Caption; Citerne__CaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(Entete_Fiche_Gasoil_No_; "No.")
            {
            }
            dataitem("Ligne Fiche Gasoil"; 50017)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING(Materiel, Journee, Heure);
                RequestFilterFields = Materiel, Affaire;
                column(Ligne_Fiche_Gasoil_Materiel; Materiel)
                {
                }
                column(Ligne_Fiche_Gasoil__Valeur_Compteur_; "Valeur Compteur")
                {
                    DecimalPlaces = 0 : 0;
                }
                column("Ligne_Fiche_Gasoil__Quantité_Gasoil_"; "Quantité Gasoil")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Chauff; Chauff)
                {
                }
                column(Ligne_Fiche_Gasoil_Destination; Destination)
                {
                }
                column(Ligne_Fiche_Gasoil_Heure; Heure)
                {
                }
                column(Ligne_Fiche_Gasoil_Cuve; Cuve)
                {
                }
                column(Ligne_Fiche_Gasoil__Ligne_Fiche_Gasoil__Journee; "Ligne Fiche Gasoil".Journee)
                {
                }
                column(Fiche; Fiche)
                {
                }
                column(Ligne_Fiche_Gasoil__Immatricule_Vehicule_; "Immatricule Vehicule")
                {
                }
                column(Ligne_Fiche_Gasoil__Ligne_Fiche_Gasoil___Index_de_la_Citerne_; "Ligne Fiche Gasoil"."Index de la Citerne")
                {
                }
                column(Ligne_Fiche_Gasoil_Document_No_; "Document No.")
                {
                }
                column(Ligne_Fiche_Gasoil_Numero_Ligne; "Numero Ligne")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RecEnteteFicheGasoil.RESET;
                    RecEnteteFicheGasoil.SETRANGE(RecEnteteFicheGasoil."No.", "Ligne Fiche Gasoil"."Document No.");
                    RecEnteteFicheGasoil.FINDFIRST;
                    Journe := RecEnteteFicheGasoil.Journee;
                    Fiche := RecEnteteFicheGasoil."N° Fiche";


                    Marque := '';
                    Categorie := '';
                    souscategorie := '';

                    Vehicule.RESET;
                    IF Vehicule.GET("Ligne Fiche Gasoil".Materiel) THEN
                        Vehicule.SETRANGE(Vehicule."N° Vehicule", "Ligne Fiche Gasoil".Materiel);
                    Vehicule.FINDFIRST;

                    Marque := Vehicule.Marque;

                    TotalGasoil += "Ligne Fiche Gasoil"."Quantité Gasoil";
                    IF ShippingAgent.GET("Ligne Fiche Gasoil".Chauffeur) THEN Chauff := ShippingAgent.Name;
                    //Categorie:=Vehicule."Code Catégorie";
                    // souscategorie:=Vehicule."Code Sous-Catégorie";

                    // IF PrintToExcel THEN BEGIN
                    //     MakeExcelDataBody;
                    // END;
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Ligne Fiche Gasoil".Cuve);
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Cuve);
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
        LastFieldNo: Integer;
        RecEnteteFicheGasoil: Record 50016;
        Journe: Date;
        Fiche: Text[30];
        "//MH SORO TCHAD 08-03-2016": Integer;
        Numserie: Text[30];
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        PageConst: Label 'Page';
        TotalFor: Label 'Total ';
        Text001: Label 'Données';
        Text002: Label 'Etat Consommation de Gasoil';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        Marque: Text[30];
        Categorie: Text[30];
        souscategorie: Text[30];
        Vehicule: Record 52048972;
        TotalGasoil: Decimal;
        ShippingAgent: Record 291;
        Chauff: Text[100];
        "N__VéhiculeCaptionLbl": Label 'N° Véhicule';
        MatriculeCaptionLbl: Label 'Matricule';
        CiterneCaptionLbl: Label 'Citerne :';
        HeureCaptionLbl: Label 'Heure';
        ChauffeurCaptionLbl: Label 'Chauffeur';
        "DéstinationCaptionLbl": Label 'Déstination';
        CompteurCaptionLbl: Label 'Compteur';
        "QuantitéCaptionLbl": Label 'Quantité';
        Inventory_MovementCaptionLbl: Label 'Inventory Movement';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        JourneeCaptionLbl: Label 'Journee';
        N__FicheCaptionLbl: Label 'N° Fiche';
        Index_De_La_CiterneCaptionLbl: Label 'Index De La Citerne';
        Citerne__CaptionLbl: Label 'Citerne :';
        TOTALCaptionLbl: Label 'TOTAL';

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
        //ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'',0);
        //ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert",FALSE,'',FALSE,FALSE,FALSE,'',0);
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
        ExcelBuf.AddColumn('Journée', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Heure', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Véhicule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Matricule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Marque', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('N° Fiche', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Citerne', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Index de La Citerne', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Chauffeur', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Déstination', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Compteur', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Quantité', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        //ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
        //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    end;

    // [Scope('Internal')]
    procedure MakeExcelDataBody()
    begin
        IF ShippingAgent.GET("Ligne Fiche Gasoil".Chauffeur) THEN Chauff := ShippingAgent.Name;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Journee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Heure, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Materiel, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Immatricule Vehicule", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Marque, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Fiche, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Cuve, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Index de la Citerne", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn(Chauff, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil".Destination, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Valeur Compteur", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Quantité Gasoil", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Ligne Fiche Gasoil"."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Consommation Gasoil 2');
        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

