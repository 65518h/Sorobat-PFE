report 50060 "Pointage Engins2"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PointageEngins2.rdlc';

    dataset
    {
        dataitem("Véhicule"; "Véhicule")
        {
            DataItemTableView = WHERE(Bloquer = CONST(false));
            RequestFilterFields = "N° Vehicule", Famille, "Sous Famille", "Type Index", "Sous Affaire";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Afficher; Afficher)
            {
            }
            column("Véhicule__No_Vehicule_"; "N° Vehicule")
            {
            }
            column(Val1_1_; Val1[1])
            {
            }
            column(Val1_2_; Val1[2])
            {
            }
            column(Val1_3_; Val1[3])
            {
            }
            column(Val1_6_; Val1[6])
            {
            }
            column(Val1_5_; Val1[5])
            {
            }
            column(Val1_4_; Val1[4])
            {
            }
            column(Val1_9_; Val1[9])
            {
            }
            column(Val1_8_; Val1[8])
            {
            }
            column(Val1_7_; Val1[7])
            {
            }
            column(Val1_12_; Val1[12])
            {
            }
            column(Val1_11_; Val1[11])
            {
            }
            column(Val1_10_; Val1[10])
            {
            }
            column(Val1_15_; Val1[15])
            {
            }
            column(Val1_14_; Val1[14])
            {
            }
            column(Val1_13_; Val1[13])
            {
            }
            column(Val1_31_; Val1[31])
            {
            }
            column(Val1_30_; Val1[30])
            {
            }
            column(Val1_29_; Val1[29])
            {
            }
            column(Val1_28_; Val1[28])
            {
            }
            column(Val1_27_; Val1[27])
            {
            }
            column(Val1_26_; Val1[26])
            {
            }
            column(Val1_25_; Val1[25])
            {
            }
            column(Val1_24_; Val1[24])
            {
            }
            column(Val1_23_; Val1[23])
            {
            }
            column(Val1_22_; Val1[22])
            {
            }
            column(Val1_21_; Val1[21])
            {
            }
            column(Val1_20_; Val1[20])
            {
            }
            column(Val1_19_; Val1[19])
            {
            }
            column(Val1_18_; Val1[18])
            {
            }
            column(Val1_17_; Val1[17])
            {
            }
            column(Val1_16_; Val1[16])
            {
            }
            column(NbrF; NbrF)
            {
            }
            column(NbrD; NbrD)
            {
            }
            column(NbrP; NbrP)
            {
            }
            column("CatégorieVéhicule_Désignation"; CatégorieVéhicule.Désignation)
            {
            }
            column(TxtChaffeur; TxtChaffeur)
            {
            }
            column("Véhicule__No_Vehicule__Control1000000233"; "N° Vehicule")
            {
            }
            column(Val1_1__Control1000000235; Val1[1])
            {
            }
            column(Val1_2__Control1000000236; Val1[2])
            {
            }
            column(Val1_3__Control1000000237; Val1[3])
            {
            }
            column(Val1_6__Control1000000239; Val1[6])
            {
            }
            column(Val1_5__Control1000000240; Val1[5])
            {
            }
            column(Val1_4__Control1000000241; Val1[4])
            {
            }
            column(Val1_9__Control1000000242; Val1[9])
            {
            }
            column(Val1_8__Control1000000243; Val1[8])
            {
            }
            column(Val1_7__Control1000000244; Val1[7])
            {
            }
            column(Val1_12__Control1000000277; Val1[12])
            {
            }
            column(Val1_11__Control1000000279; Val1[11])
            {
            }
            column(Val1_10__Control1000000280; Val1[10])
            {
            }
            column(Val1_15__Control1000000281; Val1[15])
            {
            }
            column(Val1_14__Control1000000282; Val1[14])
            {
            }
            column(Val1_13__Control1000000283; Val1[13])
            {
            }
            column(Val1_31__Control1000000284; Val1[31])
            {
            }
            column(Val1_30__Control1000000285; Val1[30])
            {
            }
            column(Val1_29__Control1000000286; Val1[29])
            {
            }
            column(Val1_28__Control1000000287; Val1[28])
            {
            }
            column(Val1_27__Control1000000288; Val1[27])
            {
            }
            column(Val1_26__Control1000000289; Val1[26])
            {
            }
            column(Val1_25__Control1000000290; Val1[25])
            {
            }
            column(Val1_24__Control1000000291; Val1[24])
            {
            }
            column(Val1_23__Control1000000292; Val1[23])
            {
            }
            column(Val1_22__Control1000000293; Val1[22])
            {
            }
            column(Val1_21__Control1000000295; Val1[21])
            {
            }
            column(Val1_20__Control1000000296; Val1[20])
            {
            }
            column(Val1_19__Control1000000297; Val1[19])
            {
            }
            column(Val1_18__Control1000000298; Val1[18])
            {
            }
            column(Val1_17__Control1000000299; Val1[17])
            {
            }
            column(Val1_16__Control1000000300; Val1[16])
            {
            }
            column(Val3_31_; Val3[31])
            {
            }
            column(Val3_30_; Val3[30])
            {
            }
            column(Val3_29_; Val3[29])
            {
            }
            column(Val3_28_; Val3[28])
            {
            }
            column(Val3_27_; Val3[27])
            {
            }
            column(Val3_26_; Val3[26])
            {
            }
            column(Val3_25_; Val3[25])
            {
            }
            column(Val3_24_; Val3[24])
            {
            }
            column(Val3_23_; Val3[23])
            {
            }
            column(Val3_22_; Val3[22])
            {
            }
            column(Val3_21_; Val3[21])
            {
            }
            column(Val3_20_; Val3[20])
            {
            }
            column(Val3_19_; Val3[19])
            {
            }
            column(Val3_18_; Val3[18])
            {
            }
            column(Val3_17_; Val3[17])
            {
            }
            column(Val3_16_; Val3[16])
            {
            }
            column(Val3_15_; Val3[15])
            {
            }
            column(Val3_14_; Val3[14])
            {
            }
            column(Val3_13_; Val3[13])
            {
            }
            column(Val3_12_; Val3[12])
            {
            }
            column(Val3_11_; Val3[11])
            {
            }
            column(Val3_10_; Val3[10])
            {
            }
            column(Val3_9_; Val3[9])
            {
            }
            column(Val3_8_; Val3[8])
            {
            }
            column(Val3_7_; Val3[7])
            {
            }
            column(Val3_6_; Val3[6])
            {
            }
            column(Val3_5_; Val3[5])
            {
            }
            column(Val3_4_; Val3[4])
            {
            }
            column(Val3_3_; Val3[3])
            {
            }
            column(Val3_2_; Val3[2])
            {
            }
            column(Val3_1_; Val3[1])
            {
            }
            column(Val2_1_; Val2[1])
            {
            }
            column(Val2_2_; Val2[2])
            {
            }
            column(Val2_3_; Val2[3])
            {
            }
            column(Val2_6_; Val2[6])
            {
            }
            column(Val2_5_; Val2[5])
            {
            }
            column(Val2_4_; Val2[4])
            {
            }
            column(Val2_9_; Val2[9])
            {
            }
            column(Val2_8_; Val2[8])
            {
            }
            column(Val2_7_; Val2[7])
            {
            }
            column(Val2_12_; Val2[12])
            {
            }
            column(Val2_11_; Val2[11])
            {
            }
            column(Val2_10_; Val2[10])
            {
            }
            column(Val2_15_; Val2[15])
            {
            }
            column(Val2_14_; Val2[14])
            {
            }
            column(Val2_13_; Val2[13])
            {
            }
            column(Val2_31_; Val2[31])
            {
            }
            column(Val2_30_; Val2[30])
            {
            }
            column(Val2_29_; Val2[29])
            {
            }
            column(Val2_28_; Val2[28])
            {
            }
            column(Val2_27_; Val2[27])
            {
            }
            column(Val2_26_; Val2[26])
            {
            }
            column(Val2_25_; Val2[25])
            {
            }
            column(Val2_24_; Val2[24])
            {
            }
            column(Val2_23_; Val2[23])
            {
            }
            column(Val2_22_; Val2[22])
            {
            }
            column(Val2_21_; Val2[21])
            {
            }
            column(Val2_20_; Val2[20])
            {
            }
            column(Val2_19_; Val2[19])
            {
            }
            column(Val2_18_; Val2[18])
            {
            }
            column(Val2_17_; Val2[17])
            {
            }
            column(Val2_16_; Val2[16])
            {
            }
            column(V31Caption; V31CaptionLbl)
            {
            }
            column(V30Caption; V30CaptionLbl)
            {
            }
            column(V29Caption; V29CaptionLbl)
            {
            }
            column(V28Caption; V28CaptionLbl)
            {
            }
            column(V27Caption; V27CaptionLbl)
            {
            }
            column(V26Caption; V26CaptionLbl)
            {
            }
            column(V25Caption; V25CaptionLbl)
            {
            }
            column(V24Caption; V24CaptionLbl)
            {
            }
            column(V23Caption; V23CaptionLbl)
            {
            }
            column(V22Caption; V22CaptionLbl)
            {
            }
            column(V21Caption; V21CaptionLbl)
            {
            }
            column(V20Caption; V20CaptionLbl)
            {
            }
            column(V19Caption; V19CaptionLbl)
            {
            }
            column(V18Caption; V18CaptionLbl)
            {
            }
            column(V17Caption; V17CaptionLbl)
            {
            }
            column(V16Caption; V16CaptionLbl)
            {
            }
            column(V15Caption; V15CaptionLbl)
            {
            }
            column(V14Caption; V14CaptionLbl)
            {
            }
            column(V13Caption; V13CaptionLbl)
            {
            }
            column(V12Caption; V12CaptionLbl)
            {
            }
            column(V11Caption; V11CaptionLbl)
            {
            }
            column(V10Caption; V10CaptionLbl)
            {
            }
            column(V9Caption; V9CaptionLbl)
            {
            }
            column(V8Caption; V8CaptionLbl)
            {
            }
            column(V7Caption; V7CaptionLbl)
            {
            }
            column(V6Caption; V6CaptionLbl)
            {
            }
            column(V5Caption; V5CaptionLbl)
            {
            }
            column(V4Caption; V4CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MaterielCaption; MaterielCaptionLbl)
            {
            }
            column(V1Caption; V1CaptionLbl)
            {
            }
            column(V2Caption; V2CaptionLbl)
            {
            }
            column(V3Caption; V3CaptionLbl)
            {
            }
            column(NBR_FCaption; NBR_FCaptionLbl)
            {
            }
            column(NBR_DCaption; NBR_DCaptionLbl)
            {
            }
            column(NBR_PCaption; NBR_PCaptionLbl)
            {
            }
            column(CHAUFFEURCaption; CHAUFFEURCaptionLbl)
            {
            }
            trigger OnPreDataItem()
            var
            begin

            end;

            trigger OnAfterGetRecord()
            var
            begin

                Afficher := 'ATTACHEMENT DU PERIODE DE ' + FORMAT(DateDebut) + ' AU ' + FORMAT(DateFin);//+UPPERCASE(FORMAT("a supprimer 22".Mois))+' '
                                                                                                        //  + FORMAT("a supprimer 22".Annee) + ' ' +"a supprimer 22".Affectation;

                IF Salarier.GET(Conducteur) THEN;
                IF CatégorieVéhicule.GET(Famille) THEN;
                NbrF := 0;
                NbrD := 0;
                NbrP := 0;
                Chauffeur01 := '';
                Chauffeur02 := '';
                Chauffeur03 := '';
                TxtChaffeur := '';
                FOR i := 1 TO 31 DO BEGIN
                    Val1[i] := '';
                    Val2[i] := '';
                    Val3[i] := '';
                END;
                LignePointageVehicule.SETCURRENTKEY(Vehicule, Journee);
                LignePointageVehicule.SETRANGE(Vehicule, "N° Vehicule");
                LignePointageVehicule.SETRANGE(Journee, DateDebut, DateFin);
                LignePointageVehicule.SETRANGE("Statut Entete", LignePointageVehicule."Statut Entete"::Validé);
                IF LignePointageVehicule.FINDFIRST THEN
                    REPEAT
                        IF Vehicule.GET(LignePointageVehicule.Vehicule) THEN;
                        // IF (LignePointageVehicule."Index Final"<>0) AND (LignePointageVehicule."Index Depart"<>0)
                        //THEN
                        Val1[DATE2DMY(LignePointageVehicule.Journee, 1)] := COPYSTR(FORMAT(LignePointageVehicule.Statut), 1, 1);
                        IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN NbrF += 1;
                        IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrD += 1;
                        IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbrP += 1;
                        IF LignePointageVehicule.Chauffeur <> '' THEN TxtChaffeur := LignePointageVehicule.Chauffeur;
                        IF LignePointageVehicule."Chauffeur 2" <> '' THEN TxtChaffeur := TxtChaffeur + '/' + LignePointageVehicule."Chauffeur 2";
                        IF LignePointageVehicule."Chauffeur 3" <> '' THEN TxtChaffeur := TxtChaffeur + '/' + LignePointageVehicule."Chauffeur 3";
                    UNTIL LignePointageVehicule.NEXT = 0;
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
        DateDebut := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
        DateFin := CALCDATE('FM', DateDebut);
    end;

    var
        RecVehicule: Record "Véhicule";
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Val1: array[31] of Text[10];
        Val2: array[31] of Text[10];
        Val3: array[31] of Text[10];
        MoisNbr: Integer;
        Compteur: Integer;
        CoutGasoil: Decimal;
        CoutTotal: Decimal;
        NbrJours: Decimal;
        TotaGasoil: Decimal;
        TotalCout: Decimal;
        Afficher: Text[50];
        i: Integer;
        DateDebut: Date;
        DateFin: Date;
        NbrF: Integer;
        NbrD: Integer;
        NbrP: Integer;
        "CatégorieVéhicule": Record "Catégorie Véhicule";
        Salarier: Record 50011;
        Chauffeur01: Code[20];
        Chauffeur02: Code[20];
        Chauffeur03: Code[20];
        TxtChaffeur: Code[60];
        Vehicule: Record "Véhicule";
        V31CaptionLbl: Label '31';
        V30CaptionLbl: Label '30';
        V29CaptionLbl: Label '29';
        V28CaptionLbl: Label '28';
        V27CaptionLbl: Label '27';
        V26CaptionLbl: Label '26';
        V25CaptionLbl: Label '25';
        V24CaptionLbl: Label '24';
        V23CaptionLbl: Label '23';
        V22CaptionLbl: Label '22';
        V21CaptionLbl: Label '21';
        V20CaptionLbl: Label '20';
        V19CaptionLbl: Label '19';
        V18CaptionLbl: Label '18';
        V17CaptionLbl: Label '17';
        V16CaptionLbl: Label '16';
        V15CaptionLbl: Label '15';
        V14CaptionLbl: Label '14';
        V13CaptionLbl: Label '13';
        V12CaptionLbl: Label '12';
        V11CaptionLbl: Label '11';
        V10CaptionLbl: Label '10';
        V9CaptionLbl: Label '9';
        V8CaptionLbl: Label '8';
        V7CaptionLbl: Label '7';
        V6CaptionLbl: Label '6';
        V5CaptionLbl: Label '5';
        V4CaptionLbl: Label '4';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MaterielCaptionLbl: Label 'Materiel';
        V1CaptionLbl: Label '1';
        V2CaptionLbl: Label '2';
        V3CaptionLbl: Label '3';
        NBR_FCaptionLbl: Label 'NBR F';
        NBR_DCaptionLbl: Label 'NBR D';
        NBR_PCaptionLbl: Label 'NBR P';
        CHAUFFEURCaptionLbl: Label 'CHAUFFEUR';
}

