report 50023 "Consommation PR/MATERIEL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ConsommationPRMATERIEL.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Consommation PR/MATERIEL';

    dataset
    {
        dataitem("Véhicule"; "Véhicule")
        {
            DataItemTableView = SORTING("N° Vehicule");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "N° Vehicule";
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("N__Vehicule___________Désignation"; "N° Vehicule" + ' : ' + Désignation)
            {
            }
            column(DecTotalCout; DecTotalCout)
            {
            }
            column("Total_____Véhicule__N__Vehicule___________Véhicule_Désignation"; 'Total  ' + Véhicule."N° Vehicule" + ' : ' + Véhicule.Désignation)
            {
            }
            column(ABS_DeQte_; ABS(DeQte))
            {
                DecimalPlaces = 0 : 0;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(LISTE_CONSOMMATION_VEHICULESCaption; LISTE_CONSOMMATION_VEHICULESCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column("CoûtCaption"; CoûtCaptionLbl)
            {
            }
            column("Article_ConsomméCaption"; Article_ConsomméCaptionLbl)
            {
            }
            column("CoûtCaption_Control1000000044"; CoûtCaption_Control1000000044Lbl)
            {
            }
            column(Lieu_Liv_Caption; Lieu_Liv_CaptionLbl)
            {
            }
            column("Véhicule_N__Vehicule"; "N° Vehicule")
            {
            }
            column(FicheNoLbl; FicheNoLbl)
            {

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Cost Amount (Actual)";
                DataItemLink = "N° Véhicule" = FIELD("N° Vehicule");
                DataItemTableView = SORTING("Item No.", "Posting Date")
                                    WHERE("N° Véhicule" = FILTER(<> ''),
                                          "Entry Type" = FILTER("Negative Adjmt." | "Positive Adjmt."));
                column(Item_No_____________RecItem_Description; "Item No." + ' : ' + RecItem.Description)
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item_No_; "Item No.")
                {

                }
                column(Quantity; -Quantity)
                {
                }
                column(Cost_Amount__Actual__; RecItem."Last Direct Cost" * Quantity)
                {
                }
                column(Description; "Document No.")
                {
                }
                column(ArticleCaption; ArticleCaptionLbl)
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column("Item_Ledger_Entry_N__Véhicule"; "N° Véhicule")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    IF RecItem.GET("Item No.") THEN;
                    DecTotalCout += ABS("Cost Amount (Actual)");
                    DeQte += Quantity;
                    //IF "Item Ledger Entry"."Entry Type"="Item Ledger Entry"."Entry Type"::tran THEN  CurrReport.SHOWOUTPUT(FALSE);
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("N° Véhicule");
                    IF (DteDateDebut <> 0D) AND (DteDateFin <> 0D) THEN SETRANGE("Posting Date", DteDateDebut, DteDateFin);
                end;
            }
            dataitem("Détail Reparation Enreg."; "Détail Reparation Enreg.")
            {
                DataItemLink = "N° Véhicule" = FIELD("N° Vehicule");
                DataItemTableView = SORTING("N° Reparation", "N° Ligne");
                column("Détail_Reparation_Enreg___Montant_Reparation_"; "Montant Reparation")
                {
                }
                column("Détail_Reparation_Enreg__Désignation"; Désignation)
                {
                }
                column("RecRéparationVéhiculeEnreg____Date_document_"; "RecRéparationVéhiculeEnreg."."Date document")
                {
                }
                column(InterventionCaption; InterventionCaptionLbl)
                {
                }
                column("Détail_Reparation_Enreg__N__Reparation"; "N° Reparation")
                {
                }
                column("Détail_Reparation_Enreg__N__Ligne"; "N° Ligne")
                {
                }
                column("Détail_Reparation_Enreg__N__Véhicule"; "N° Véhicule")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "RecRéparationVéhiculeEnreg.".GET("N° Reparation") THEN;
                    // "DateRecRéparationVéhiculeEnreg" := "RecRéparationVéhiculeEnreg."."Date document";

                    IF (DteDateDebut <> 0D) AND (DteDateFin <> 0D) THEN
                        IF ("RecRéparationVéhiculeEnreg."."Date document" < DteDateDebut) OR
                            ("RecRéparationVéhiculeEnreg."."Date document" > DteDateFin) THEN
                            CurrReport.SKIP;


                    DecTotalCout += "Montant Reparation";
                end;
            }
            dataitem("Reparation Pneu Enreg."; "Reparation Pneu Enreg.")
            {
                DataItemLink = "N°Véhicule" = FIELD("N° Vehicule");
                DataItemTableView = SORTING("N° Reparation", "N° Ligne");
                column("Reparation_Pneu_Enreg___Coût_Opération_"; "Coût Opération")
                {
                }
                column(PNEUMATIQUE_REF___; ' PNEUMATIQUE REF ')
                {
                }
                column("Reparation_Pneu_Enreg___Réf__Pneu_"; "Réf. Pneu")
                {
                }
                column("RecRéparationVéhiculeEnreg____Date_document__Control1000000027"; "RecRéparationVéhiculeEnreg."."Date document")
                {
                }
                column(PneumatiqueCaption; PneumatiqueCaptionLbl)
                {
                }
                column(Reparation_Pneu_Enreg__N__Reparation; "N° Reparation")
                {
                }
                column(Reparation_Pneu_Enreg__N__Ligne; "N° Ligne")
                {
                }
                column("Reparation_Pneu_Enreg__N_Véhicule"; "N°Véhicule")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "RecRéparationVéhiculeEnreg.".GET("N° Reparation") THEN;
                    // "DateRecRéparationVéhiculeEnreg2" := "RecRéparationVéhiculeEnreg."."Date document";
                    IF (DteDateDebut <> 0D) AND (DteDateFin <> 0D) THEN
                        IF ("RecRéparationVéhiculeEnreg."."Date document" < DteDateDebut) OR
                           ("RecRéparationVéhiculeEnreg."."Date document" > DteDateFin) THEN
                            CurrReport.SKIP;


                    DecTotalCout += "Coût Opération";
                end;
            }
            trigger OnPreDataItem()
            begin

                DecTotalCout := 0;
                DeQte := 0;
            end;

            trigger OnAfterGetRecord()
            begin


            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Date Début"; DteDateDebut)
                    {
                        Caption = 'Date Début';
                        ApplicationArea = all;
                    }

                    field("Date Fin"; DteDateFin)
                    {
                        Caption = 'Date Fin';
                        ApplicationArea = all;
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

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        "RecVéhicule": Record "Véhicule";
        RecItem: Record 27;
        "RecRéparationVéhicule": Record "Réparation Véhicule";
        "RecRéparationVéhiculeEnreg.": Record "Réparation Véhicule Enreg.";
        "RecRéparationVéhiculeEnreg.1": Record "Réparation Véhicule Enreg.";
        IntCompteur: Integer;
        DecTotalCout: Decimal;
        DteDateDebut: Date;
        DteDateFin: Date;
        DeQte: Decimal;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Montant: Decimal;
        PageConst: Label 'Page';
        Text001: Label 'Données';
        Text002: Label 'Etat des Bons de Livraison';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        Item: Record 27;
        Numserie: Text[30];
        DesignationVehicule: Text[150];
        ImmatriculeVehicule: Text[150];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Item_Ledger_EntryCaptionLbl: Label 'Écriture comptable article';
        LISTE_CONSOMMATION_VEHICULESCaptionLbl: Label 'LISTE CONSOMMATION VEHICULES';
        DateCaptionLbl: Label 'Date';
        "QuantitéCaptionLbl": Label 'Quantité';
        "CoûtCaptionLbl": Label 'Coût';
        "Article_ConsomméCaptionLbl": Label 'Article Consommé';
        "CoûtCaption_Control1000000044Lbl": Label 'Coût';
        Lieu_Liv_CaptionLbl: Label 'Lieu Liv.';
        ArticleCaptionLbl: Label '** Article';
        InterventionCaptionLbl: Label '** Intervention';
        PneumatiqueCaptionLbl: Label '** Pneumatique';
        DateRecRéparationVéhiculeEnreg: date;
        "DateRecRéparationVéhiculeEnreg2": date;
        FicheNoLbl: Label 'Fiche N°';



}

