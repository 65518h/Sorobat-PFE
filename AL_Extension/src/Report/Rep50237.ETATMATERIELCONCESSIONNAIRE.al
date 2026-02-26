report 50237 "ETAT MATERIEL CONCESSIONNAIRE"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ETATMATERIELCONCESSIONNAIRE.rdlc';

    // dataset
    // {
    //     dataitem("Véhicule"; 52048972)
    //     {
    //         DataItemTableView = SORTING("N° Vehicule")
    //                             WHERE("Chez Concessionnaire" = FILTER(true));
    //         RequestFilterFields = "Marche", "Enrobé", "Bloquer", "Marque", "Grande Famille", "Famille", "Sous Famille", "Statut Vehicule";
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("Véhicule__N__Vehicule_"; "N° Vehicule")
    //         {
    //         }
    //         column("Véhicule__Index_Théorique_Final_"; "Index Théorique Final")
    //         {
    //             DecimalPlaces = 0 : 0;
    //         }
    //         column("Véhicule_Famille"; Famille)
    //         {
    //         }
    //         column("Véhicule_Marque"; Marque)
    //         {
    //         }
    //         column("Véhicule_Type"; Type)
    //         {
    //         }
    //         column("Véhicule_Immatriculation"; Immatriculation)
    //         {
    //         }
    //         column("Véhicule__Statut_Vehicule_"; "Statut Vehicule")
    //         {
    //         }
    //         column(Compteur; Compteur)
    //         {
    //         }
    //         column(ObservationConcessionnaire; ObservationConcessionnaire)
    //         {
    //         }
    //         column(NomConcessionnaire; NomConcessionnaire)
    //         {
    //         }
    //         column(ETAT_DES_MATERIELS_CHEZ_CONCESSIONNAIRECaption; ETAT_DES_MATERIELS_CHEZ_CONCESSIONNAIRECaptionLbl)
    //         {
    //         }
    //         column("Véhicule__N__Vehicule_Caption"; FIELDCAPTION("N° Vehicule"))
    //         {
    //         }
    //         column(INDEXCaption; INDEXCaptionLbl)
    //         {
    //         }
    //         column("Véhicule_FamilleCaption"; FIELDCAPTION(Famille))
    //         {
    //         }
    //         column("Véhicule_MarqueCaption"; FIELDCAPTION(Marque))
    //         {
    //         }
    //         column("Véhicule_TypeCaption"; FIELDCAPTION(Type))
    //         {
    //         }
    //         column("Véhicule_ImmatriculationCaption"; FIELDCAPTION(Immatriculation))
    //         {
    //         }
    //         column("Véhicule__Statut_Vehicule_Caption"; FIELDCAPTION("Statut Vehicule"))
    //         {
    //         }
    //         column(ObservationCaption; ObservationCaptionLbl)
    //         {
    //         }
    //         column(ConcessionnaireCaption; ConcessionnaireCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF PrintToExcel THEN BEGIN
    //                 //   MakeExcelDataBody;
    //             END;
    //             NomConcessionnaire := '';
    //             ObservationConcessionnaire := '';
    //             RecDétailsVéhicules.RESET;
    //             RecDétailsVéhicules.SETCURRENTKEY(Date);
    //             RecDétailsVéhicules.SETRANGE(Type, RecDétailsVéhicules.Type::concessionnaire);
    //             RecDétailsVéhicules.SETRANGE("Code Véhicule", "N° Vehicule");
    //             IF RecDétailsVéhicules.FINDLAST THEN BEGIN
    //                 NomConcessionnaire := RecDétailsVéhicules."Nom Fournisseur";
    //                 ObservationConcessionnaire := RecDétailsVéhicules.Observation;
    //             END;

    //             Compteur += 1;
    //             IF ChauffeurLocation.GET(Véhicule.Chauffeur) THEN NomChauffeur := ChauffeurLocation.Nom;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnPostReport()
    // begin
    //     IF PrintToExcel THEN
    //         CreateExcelbook;
    // end;

    // trigger OnPreReport()
    // begin
    //     IF PrintToExcel THEN
    //         MakeExcelInfo;
    // end;

    // var
    //     ChauffeurLocation: Record 52049006;
    //     NomChauffeur: Text[150];
    //     Compteur: Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     PageConst: Label 'Page';
    //     TotalFor: Label 'Total ';
    //     Text001: Label 'Données';
    //     Text002: Label 'Etat des Materiels';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     "RecDétailsVéhicules": Record 52048952;
    //     NomConcessionnaire: Text[100];
    //     ObservationConcessionnaire: Text[250];
    //     ETAT_DES_MATERIELS_CHEZ_CONCESSIONNAIRECaptionLbl: Label 'ETAT DES MATERIELS CHEZ CONCESSIONNAIRE';
    //     INDEXCaptionLbl: Label 'INDEX';
    //     ObservationCaptionLbl: Label 'Observation';
    //     ConcessionnaireCaptionLbl: Label 'Concessionnaire';

    // // [Scope('Internal')]
    // procedure MakeExcelInfo()
    // begin
    //     ExcelBuf.SetUseInfoSheet;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
    //     //ExcelBuf.NewRow;
    //     ExcelBuf.ClearNewRow;
    //     MakeExcelDataHeader;
    // end;

    // local procedure MakeExcelDataHeader()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn('N° Véhicule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Index', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Famille', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Marque', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Type', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Immatriculation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Concessionnaire', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Statut Vehicule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Observation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    // end;

    // local procedure MakeExcelDataHeader2()
    // begin
    //     //ExcelBuf.NewRow;
    //     //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    // end;

    // // [Scope('Internal')]
    // procedure MakeExcelDataBody()
    // begin

    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn(Véhicule."N° Vehicule", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Véhicule."Index Théorique Final", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Véhicule.Famille, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Véhicule.Marque, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Véhicule.Type, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Véhicule.Immatriculation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NomConcessionnaire, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(FORMAT(Véhicule."Statut Vehicule"), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(ObservationConcessionnaire, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('ETAT MATERIEL CONCESSIONNAIRE');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     // ERROR('');
    // end;
}

