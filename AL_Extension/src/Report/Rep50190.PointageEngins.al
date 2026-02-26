report 50190 "Pointage Engins"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/PointageEngins.rdlc';

    // dataset
    // {
    //     dataitem("Véhicule"; 52048972)
    //     {
    //         DataItemTableView = WHERE(Bloquer = CONST(false));
    //         RequestFilterFields = "N° Vehicule", Famille, "Sous Famille", "Type Index", "Designation Sous Affaire", Marche, Chauffeur;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Afficher; Afficher)
    //         {
    //         }
    //         column("Véhicule__N__Vehicule_"; "N° Vehicule")
    //         {
    //         }
    //         column(Val1_1_; Val1[1])
    //         {
    //         }
    //         column(Val1_2_; Val1[2])
    //         {
    //         }
    //         column(Val1_3_; Val1[3])
    //         {
    //         }
    //         column(Val1_6_; Val1[6])
    //         {
    //         }
    //         column(Val1_5_; Val1[5])
    //         {
    //         }
    //         column(Val1_4_; Val1[4])
    //         {
    //         }
    //         column(Val1_9_; Val1[9])
    //         {
    //         }
    //         column(Val1_8_; Val1[8])
    //         {
    //         }
    //         column(Val1_7_; Val1[7])
    //         {
    //         }
    //         column(Val1_12_; Val1[12])
    //         {
    //         }
    //         column(Val1_11_; Val1[11])
    //         {
    //         }
    //         column(Val1_10_; Val1[10])
    //         {
    //         }
    //         column(Val1_15_; Val1[15])
    //         {
    //         }
    //         column(Val1_14_; Val1[14])
    //         {
    //         }
    //         column(Val1_13_; Val1[13])
    //         {
    //         }
    //         column(Val1_31_; Val1[31])
    //         {
    //         }
    //         column(Val1_30_; Val1[30])
    //         {
    //         }
    //         column(Val1_29_; Val1[29])
    //         {
    //         }
    //         column(Val1_28_; Val1[28])
    //         {
    //         }
    //         column(Val1_27_; Val1[27])
    //         {
    //         }
    //         column(Val1_26_; Val1[26])
    //         {
    //         }
    //         column(Val1_25_; Val1[25])
    //         {
    //         }
    //         column(Val1_24_; Val1[24])
    //         {
    //         }
    //         column(Val1_23_; Val1[23])
    //         {
    //         }
    //         column(Val1_22_; Val1[22])
    //         {
    //         }
    //         column(Val1_21_; Val1[21])
    //         {
    //         }
    //         column(Val1_20_; Val1[20])
    //         {
    //         }
    //         column(Val1_19_; Val1[19])
    //         {
    //         }
    //         column(Val1_18_; Val1[18])
    //         {
    //         }
    //         column(Val1_17_; Val1[17])
    //         {
    //         }
    //         column(Val1_16_; Val1[16])
    //         {
    //         }
    //         column(NbrF; NbrF)
    //         {
    //         }
    //         column(NbrD; NbrD)
    //         {
    //         }
    //         column(NbrP; NbrP)
    //         {
    //         }
    //         column("Véhicule_Désignation"; Désignation)
    //         {
    //         }
    //         column(LignePointageVehicule_Chantier; LignePointageVehicule.Chantier)
    //         {
    //         }
    //         column(V31Caption; V31CaptionLbl)
    //         {
    //         }
    //         column(V30Caption; V30CaptionLbl)
    //         {
    //         }
    //         column(V29Caption; V29CaptionLbl)
    //         {
    //         }
    //         column(V28Caption; V28CaptionLbl)
    //         {
    //         }
    //         column(V27Caption; V27CaptionLbl)
    //         {
    //         }
    //         column(V26Caption; V26CaptionLbl)
    //         {
    //         }
    //         column(V25Caption; V25CaptionLbl)
    //         {
    //         }
    //         column(V24Caption; V24CaptionLbl)
    //         {
    //         }
    //         column(V23Caption; V23CaptionLbl)
    //         {
    //         }
    //         column(V22Caption; V22CaptionLbl)
    //         {
    //         }
    //         column(V21Caption; V21CaptionLbl)
    //         {
    //         }
    //         column(V20Caption; V20CaptionLbl)
    //         {
    //         }
    //         column(V19Caption; V19CaptionLbl)
    //         {
    //         }
    //         column(V18Caption; V18CaptionLbl)
    //         {
    //         }
    //         column(V17Caption; V17CaptionLbl)
    //         {
    //         }
    //         column(V16Caption; V16CaptionLbl)
    //         {
    //         }
    //         column(V15Caption; V15CaptionLbl)
    //         {
    //         }
    //         column(V14Caption; V14CaptionLbl)
    //         {
    //         }
    //         column(V13Caption; V13CaptionLbl)
    //         {
    //         }
    //         column(V12Caption; V12CaptionLbl)
    //         {
    //         }
    //         column(V11Caption; V11CaptionLbl)
    //         {
    //         }
    //         column(V10Caption; V10CaptionLbl)
    //         {
    //         }
    //         column(V9Caption; V9CaptionLbl)
    //         {
    //         }
    //         column(V8Caption; V8CaptionLbl)
    //         {
    //         }
    //         column(V7Caption; V7CaptionLbl)
    //         {
    //         }
    //         column(V6Caption; V6CaptionLbl)
    //         {
    //         }
    //         column(V5Caption; V5CaptionLbl)
    //         {
    //         }
    //         column(V4Caption; V4CaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(MaterielCaption; MaterielCaptionLbl)
    //         {
    //         }
    //         column(V1Caption; V1CaptionLbl)
    //         {
    //         }
    //         column(V2Caption; V2CaptionLbl)
    //         {
    //         }
    //         column(V3Caption; V3CaptionLbl)
    //         {
    //         }
    //         column(NBR_FCaption; NBR_FCaptionLbl)
    //         {
    //         }
    //         column(NBR_DCaption; NBR_DCaptionLbl)
    //         {
    //         }
    //         column(NBR_PCaption; NBR_PCaptionLbl)
    //         {
    //         }
    //         column(ChantierCaption; ChantierCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin

    //             // IF PrintToExcel THEN BEGIN
    //             //     MakeExcelDataBody;
    //             // END;

    //             Afficher := 'ATTACHEMENT DU PERIODE DE ' + FORMAT(DateDebut) + ' AU ' + FORMAT(DateFin);//+UPPERCASE(FORMAT("a supprimer 22".Mois))+' '
    //                                                                                                     //  + FORMAT("a supprimer 22".Annee) + ' ' +"a supprimer 22".Affectation;


    //             IF CatégorieVéhicule.GET(Famille) THEN;
    //             NbrF := 0;
    //             NbrD := 0;
    //             NbrP := 0;
    //             Chauffeur01 := '';
    //             Chauffeur02 := '';
    //             Chauffeur03 := '';
    //             TxtChaffeur := '';
    //             FOR i := 1 TO 31 DO BEGIN
    //                 Val1[i] := '';
    //                 Val2[i] := '';
    //                 Val3[i] := '';
    //             END;
    //             LignePointageVehicule.SETCURRENTKEY(Vehicule, Journee);
    //             LignePointageVehicule.SETRANGE(Vehicule, "N° Vehicule");
    //             LignePointageVehicule.SETRANGE("Statut Entete", LignePointageVehicule."Statut Entete"::Validé);
    //             LignePointageVehicule.SETRANGE(Journee, DateDebut, DateFin);
    //             //IF Véhicule.GETFILTER("Designation Sous Affaire")<>'' THEN
    //             //LignePointageVehicule.SETRANGE(Chantier,"Designation Sous Affaire");
    //             IF LignePointageVehicule.FINDFIRST THEN
    //                 REPEAT
    //                     IF Vehicule.GET(LignePointageVehicule.Vehicule) THEN;
    //                     //  IF (LignePointageVehicule."Index Final"<>0) AND (LignePointageVehicule."Index Depart"<>0) THEN // AND
    //                     Val1[DATE2DMY(LignePointageVehicule.Journee, 1)] := COPYSTR(FORMAT(LignePointageVehicule.Statut), 1, 1);
    //                     IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN NbrF += 1;
    //                     IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrD += 1;
    //                     IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbrP += 1;
    //                     IF LignePointageVehicule.Chauffeur <> '' THEN TxtChaffeur := LignePointageVehicule.Chauffeur;
    //                     IF LignePointageVehicule."Chauffeur 2" <> '' THEN TxtChaffeur := TxtChaffeur + '/' + LignePointageVehicule."Chauffeur 2";
    //                     IF LignePointageVehicule."Chauffeur 3" <> '' THEN TxtChaffeur := TxtChaffeur + '/' + LignePointageVehicule."Chauffeur 3";
    //                 UNTIL LignePointageVehicule.NEXT = 0;
    //             //MakeExcelDataBody;
    //         end;

    //         trigger OnPostDataItem()
    //         begin
    //             // IF PrintToExcel THEN BEGIN
    //             //     CreateExcelbook;
    //             // END;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF PrintToExcel THEN BEGIN
    //                 MakeExcelDataHeader;
    //             END;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 Caption = 'Options';
    //                 field("Date Debut"; DateDebut)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Date Debut';
    //                 }
    //                 field("Date Fin"; DateFin)
    //                 {
    //                     ApplicationArea = all;
    //                     Caption = 'Date Fin';
    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //     }
    // }

    // labels
    // {
    // }

    // trigger OnInitReport()
    // begin
    //     DateDebut := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
    //     DateFin := CALCDATE('FM', DateDebut);
    // end;


    // var
    //     RecVehicule: Record "Véhicule";
    //     LignePointageVehicule: Record 52049011;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Val1: array[31] of Text[10];
    //     Val2: array[31] of Text[10];
    //     Val3: array[31] of Text[10];
    //     MoisNbr: Integer;
    //     Compteur: Integer;
    //     CoutGasoil: Decimal;
    //     CoutTotal: Decimal;
    //     NbrJours: Decimal;
    //     TotaGasoil: Decimal;
    //     TotalCout: Decimal;
    //     Afficher: Text[50];
    //     i: Integer;
    //     DateDebut: Date;
    //     DateFin: Date;
    //     NbrF: Integer;
    //     NbrD: Integer;
    //     NbrP: Integer;
    //     "CatégorieVéhicule": Record 52048974;
    //     Salarier: Record 50011;
    //     Chauffeur01: Code[20];
    //     Chauffeur02: Code[20];
    //     Chauffeur03: Code[20];
    //     TxtChaffeur: Code[60];
    //     Vehicule: Record 52048972;
    //     NbrC: Integer;
    //     "// RB SORO EXPORT EXCEL": Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Receptioneur: Integer;
    //     Valeur: Decimal;
    //     TotalFor: Label 'Total ';
    //     Text001: Label 'Data';
    //     Text002: Label 'Customer/Item Sales';
    //     Text003: Label 'Company Name';
    //     Text004: Label 'Report No.';
    //     Text005: Label 'Report Name';
    //     Text006: Label 'User ID';
    //     Text007: Label 'Date';
    //     V31CaptionLbl: Label '31';
    //     V30CaptionLbl: Label '30';
    //     V29CaptionLbl: Label '29';
    //     V28CaptionLbl: Label '28';
    //     V27CaptionLbl: Label '27';
    //     V26CaptionLbl: Label '26';
    //     V25CaptionLbl: Label '25';
    //     V24CaptionLbl: Label '24';
    //     V23CaptionLbl: Label '23';
    //     V22CaptionLbl: Label '22';
    //     V21CaptionLbl: Label '21';
    //     V20CaptionLbl: Label '20';
    //     V19CaptionLbl: Label '19';
    //     V18CaptionLbl: Label '18';
    //     V17CaptionLbl: Label '17';
    //     V16CaptionLbl: Label '16';
    //     V15CaptionLbl: Label '15';
    //     V14CaptionLbl: Label '14';
    //     V13CaptionLbl: Label '13';
    //     V12CaptionLbl: Label '12';
    //     V11CaptionLbl: Label '11';
    //     V10CaptionLbl: Label '10';
    //     V9CaptionLbl: Label '9';
    //     V8CaptionLbl: Label '8';
    //     V7CaptionLbl: Label '7';
    //     V6CaptionLbl: Label '6';
    //     V5CaptionLbl: Label '5';
    //     V4CaptionLbl: Label '4';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     MaterielCaptionLbl: Label 'Materiel';
    //     V1CaptionLbl: Label '1';
    //     V2CaptionLbl: Label '2';
    //     V3CaptionLbl: Label '3';
    //     NBR_FCaptionLbl: Label 'NBR F';
    //     NBR_DCaptionLbl: Label 'NBR D';
    //     NBR_PCaptionLbl: Label 'NBR P';
    //     ChantierCaptionLbl: Label 'Chantier';

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
    //     ExcelBuf.AddInfoColumn(REPORT::"Mouvement Articles", FALSE, FALSE, FALSE, FALSE, '', 0);
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
    //     ExcelBuf.AddColumn('N° Vehicule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('N° Serie', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Affaire', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('1', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('2', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('3', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('4', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('5', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('6', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('7', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('8', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('9', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('10', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('11', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('12', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('13', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('14', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('15', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('16', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('17', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('18', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('19', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('20', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('21', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('22', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('23', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('24', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('25', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('26', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('27', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('28', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('29', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('30', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('31', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nbj F', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nbj D', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nbj P', FALSE, '', TRUE, FALSE, TRUE, '', 0);
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
    //     ExcelBuf.AddColumn(LignePointageVehicule.Vehicule, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(LignePointageVehicule.Description, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(LignePointageVehicule."N° Serie", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(LignePointageVehicule.Chantier, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[1], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[2], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[3], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[4], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[5], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[6], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[7], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[8], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[9], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[10], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[11], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[12], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[13], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[14], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[15], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[16], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[17], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[18], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[19], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[20], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[21], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[22], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[23], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[24], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[25], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[26], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[27], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[28], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[29], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[30], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Val1[31], FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NbrF, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NbrD, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NbrP, FALSE, '', FALSE, FALSE, FALSE, '', 0);



    //     //ExcelBuf.AddColumn(1,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn(Vehiculecode.Désignation,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //     //ExcelBuf.AddColumn(Vehiculecode.Immatriculation,FALSE,'',TRUE,FALSE,TRUE,'',0);

    //     //ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     //ExcelBuf.AddColumn("Item Ledger Entry"."Lieu Livraison",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     //ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'',0);
    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('Pointage Engins');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;
}

