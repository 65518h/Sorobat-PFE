report 50016 "Balance générale 8 COL"
{
    //  MntdebitP[1]-MntcreditP[1]
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Balancegénérale8COL.rdlc';


    dataset
    {
        dataitem("G/L Account"; 15)
        {
            CalcFields = "Debit Amount", "Credit Amount";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Account Type" = FILTER(Posting));
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Periodeant; Periodeant)
            {
            }
            column(Periode; Periode)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Txt; Txt)
            {
            }
            column(G_L_Account__No__; "No.")
            {
            }
            column(G_L_Account_Name; Name)
            {
            }
            column(MntdebitP_3_; MntdebitP[3])
            {
                AutoFormatType = 2;
            }
            column(MntcreditP_3_; MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_4__MntcreditP_4_; MntdebitP[4] - MntcreditP[4])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_4__MntcreditP_4__; -(MntdebitP[4] - MntcreditP[4]))
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_2__MntcreditP_2_; MntdebitP[2] - MntcreditP[2])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_2__MntcreditP_2__; -(MntdebitP[2] - MntcreditP[2]))
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_1__MntcreditP_1__; -(MntdebitP[1] - MntcreditP[1]))
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_1__MntcreditP_1_; MntdebitP[1] - MntcreditP[1])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_4__MntcreditP_4___Control1000000030; -(MntdebitP[4] - MntcreditP[4]))
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_4__MntcreditP_4__Control1000000032; MntdebitP[4] - MntcreditP[4])
            {
                AutoFormatType = 2;
            }
            column(MntcreditP_3__Control1000000034; MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_3__Control1000000036; MntdebitP[3])
            {
                AutoFormatType = 2;
            }
            column(MntcreditP_2_; MntcreditP[2])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_2_; MntdebitP[2])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_1__MntcreditP_1___Control1000000042; -(MntdebitP[1] - MntcreditP[1]))
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_1__MntcreditP_1__Control1000000044; MntdebitP[1] - MntcreditP[1])
            {
                AutoFormatType = 2;
            }
            column(G_L_Account_Name_Control1000000045; Name)
            {
            }
            column(G_L_Account__No___Control1000000048; "No.")
            {
            }
            column(Mntdebit_1_; Mntdebit[1])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_1_; Mntcredit[1])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_3__Control181; MntdebitP[3])
            {
                AutoFormatType = 2;
                DecimalPlaces = 3 : 3;
            }
            column(MntcreditP_3__Control183; MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_4_; Mntdebit[4])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_4_; Mntcredit[4])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_2_; Mntcredit[2])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_2_; Mntdebit[2])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_1____MntcreditP_3_; Mntcredit[1] + MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_1____MntdebitP_3_; Mntdebit[1] + MntdebitP[3])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_4__Control1000000050; Mntcredit[4])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_4__Control1000000051; Mntdebit[4])
            {
                AutoFormatType = 2;
            }
            column(MntcreditP_3__Control1000000054; MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_3__Control1000000056; MntdebitP[3])
            {
                AutoFormatType = 2;
                DecimalPlaces = 3 : 3;
            }
            column(Mntcredit_1__Control1000000061; Mntcredit[1])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_1__Control1000000063; Mntdebit[1])
            {
                AutoFormatType = 2;
            }
            column(MntdebitP_2__Control1180250000; MntdebitP[2])
            {
                AutoFormatType = 2;
            }
            column(MntcreditP_2__Control1180250001; MntcreditP[2])
            {
                AutoFormatType = 2;
            }
            column(Mntdebit_1____MntdebitP_3__Control1000000089; Mntdebit[1] + MntdebitP[3])
            {
                AutoFormatType = 2;
            }
            column(Mntcredit_1____MntcreditP_3__Control1000000093; Mntcredit[1] + MntcreditP[3])
            {
                AutoFormatType = 2;
            }
            column(Rep; Rep)
            {
            }
            column(TypeImp; typeimp)
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column("Mntdebit1"; Mntdebit[1])
            {
                AutoFormatType = 2;
            }
            column("Mntcredit1"; Mntcredit[1])
            {
                AutoFormatType = 2;
            }
            column("Mntdebit2"; Mntdebit[2])
            {
                AutoFormatType = 2;
            }
            column("Mntcredit2"; Mntcredit[2])
            {
                AutoFormatType = 2;
            }
            column("Mntdebit3"; Mntdebit[3])
            {
                AutoFormatType = 2;
            }
            column("Mntcredit3"; Mntcredit[3])
            {
                AutoFormatType = 2;
            }
            column("Mntdebit4"; Mntdebit[4])
            {
                AutoFormatType = 2;
            }
            column("Mntcredit4"; Mntcredit[4])
            {
                AutoFormatType = 2;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(GENERAL_BALANCECaption; GENERAL_BALANCECaptionLbl)
            {
            }
            column(Previous_date__Caption; Previous_date__CaptionLbl)
            {
            }
            column(Period_date__Caption; Period_date__CaptionLbl)
            {
            }
            column(New_balancesCaption; New_balancesCaptionLbl)
            {
            }
            column(CREDITCaption; CREDITCaptionLbl)
            {
            }
            column(DEBITCaption; DEBITCaptionLbl)
            {
            }
            column("CréditCaption"; CréditCaptionLbl)
            {
            }
            column(Month_AmountCaption; Month_AmountCaptionLbl)
            {
            }
            column("DébitCaption"; DébitCaptionLbl)
            {
            }
            column("CréditCaption_Control31"; CréditCaption_Control31Lbl)
            {
            }
            column(Previous_balanceCaption; Previous_balanceCaptionLbl)
            {
            }
            column("DébitCaption_Control50"; DébitCaption_Control50Lbl)
            {
            }
            column("CréditCaption_Control54"; CréditCaption_Control54Lbl)
            {
            }
            column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
            {
            }
            column("DébitCaption_Control73"; DébitCaption_Control73Lbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(No_Caption_Control1180250003; No_Caption_Control1180250003Lbl)
            {
            }
            column(DescriptionCaption_Control1180250005; DescriptionCaption_Control1180250005Lbl)
            {
            }
            column("DébitCaption_Control1180250007"; DébitCaption_Control1180250007Lbl)
            {
            }
            column("CréditCaption_Control1180250008"; CréditCaption_Control1180250008Lbl)
            {
            }
            column("DébitCaption_Control1180250010"; DébitCaption_Control1180250010Lbl)
            {
            }
            column("CréditCaption_Control1180250013"; CréditCaption_Control1180250013Lbl)
            {
            }
            column("DébitCaption_Control1180250014"; DébitCaption_Control1180250014Lbl)
            {
            }
            column("CréditCaption_Control1180250017"; CréditCaption_Control1180250017Lbl)
            {
            }
            column(DEBITCaption_Control1180250018; DEBITCaption_Control1180250018Lbl)
            {
            }
            column(CREDITCaption_Control1180250021; CREDITCaption_Control1180250021Lbl)
            {
            }
            column(New_balancesCaption_Control1180250023; New_balancesCaption_Control1180250023Lbl)
            {
            }
            column(Month_AmountCaption_Control1180250025; Month_AmountCaption_Control1180250025Lbl)
            {
            }
            column(Previous_balanceCaption_Control1180250027; Previous_balanceCaption_Control1180250027Lbl)
            {
            }
            column(Opening_BalanceCaption_Control1180250028; Opening_BalanceCaption_Control1180250028Lbl)
            {
            }
            column(No__2Caption; No__2CaptionLbl)
            {
            }
            column(Month_AmountCaption_Control1000000003; Month_AmountCaption_Control1000000003Lbl)
            {
            }
            column(Previous_amountCaption; Previous_amountCaptionLbl)
            {
            }
            column(CREDITCaption_Control1000000010; CREDITCaption_Control1000000010Lbl)
            {
            }
            column(DEBITCaption_Control1000000011; DEBITCaption_Control1000000011Lbl)
            {
            }
            column("CréditCaption_Control1000000013"; CréditCaption_Control1000000013Lbl)
            {
            }
            column("DébitCaption_Control1000000016"; DébitCaption_Control1000000016Lbl)
            {
            }
            column("CréditCaption_Control1000000017"; CréditCaption_Control1000000017Lbl)
            {
            }
            column("DébitCaption_Control1000000020"; DébitCaption_Control1000000020Lbl)
            {
            }
            column("CréditCaption_Control1000000022"; CréditCaption_Control1000000022Lbl)
            {
            }
            column("DébitCaption_Control1000000024"; DébitCaption_Control1000000024Lbl)
            {
            }
            column(Opening_BalanceCaption_Control1000000001; Opening_BalanceCaption_Control1000000001Lbl)
            {
            }
            column(New_balancesCaption_Control1000000007; New_balancesCaption_Control1000000007Lbl)
            {
            }
            column(No_Caption_Control1000000026; No_Caption_Control1000000026Lbl)
            {
            }
            column(DescriptionCaption_Control1000000028; DescriptionCaption_Control1000000028Lbl)
            {
            }
            column(No_Caption_Control1180250034; No_Caption_Control1180250034Lbl)
            {
            }
            column(DescriptionCaption_Control1180250036; DescriptionCaption_Control1180250036Lbl)
            {
            }
            column("DébitCaption_Control1180250037"; DébitCaption_Control1180250037Lbl)
            {
            }
            column("CréditCaption_Control1180250040"; CréditCaption_Control1180250040Lbl)
            {
            }
            column("DébitCaption_Control1180250042"; DébitCaption_Control1180250042Lbl)
            {
            }
            column("CréditCaption_Control1180250044"; CréditCaption_Control1180250044Lbl)
            {
            }
            column("DébitCaption_Control1180250046"; DébitCaption_Control1180250046Lbl)
            {
            }
            column("CréditCaption_Control1180250048"; CréditCaption_Control1180250048Lbl)
            {
            }
            column(Month_AmountCaption_Control1180250050; Month_AmountCaption_Control1180250050Lbl)
            {
            }
            column(Previous_amountCaption_Control1180250052; Previous_amountCaption_Control1180250052Lbl)
            {
            }
            column(Opening_BalanceCaption_Control1180250055; Opening_BalanceCaption_Control1180250055Lbl)
            {
            }
            column(DEBITCaption_Control1180250057; DEBITCaption_Control1180250057Lbl)
            {
            }
            column(New_balancesCaption_Control1180250059; New_balancesCaption_Control1180250059Lbl)
            {
            }
            column(CREDITCaption_Control1180250060; CREDITCaption_Control1180250060Lbl)
            {
            }
            column(No__2Caption_Control1180250063; No__2Caption_Control1180250063Lbl)
            {
            }
            column(Totals__Caption; Totals__CaptionLbl)
            {
            }
            column(Totals__Caption_Control1000000087; Totals__Caption_Control1000000087Lbl)
            {
            }
            column(Totals__Caption_Control1000000058; Totals__Caption_Control1000000058Lbl)
            {
            }
            column(Totals__Caption_Control1000000091; Totals__Caption_Control1000000091Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FOR i := 1 TO 4 DO BEGIN
                    Mntdebit[i] := 0;
                    Mntcredit[i] := 0;
                    MntdebitP[i] := 0;
                    MntcreditP[i] := 0;
                END;
                FOR i := 1 TO 4 DO BEGIN
                    SETFILTER("Date Filter", Txtfilterdate[i]);
                    CALCFIELDS("Debit Amount", "Credit Amount");
                    IF "Account Type" = "G/L Account"."Account Type"::Posting THEN BEGIN
                        IF "Debit Amount" > "Credit Amount" THEN
                            Mntdebit[i] := "Debit Amount" - "Credit Amount"
                        ELSE
                            Mntcredit[i] := -("Debit Amount" - "Credit Amount");
                    END;
                    MntdebitP[i] := "Debit Amount";
                    MntcreditP[i] := "Credit Amount";
                END;

            end;

            trigger OnPreDataItem()
            var
            // AccountTypeInt: Integer;
            begin
                // AccountTypeInt := "G/L Account"."Account Type".AsInteger();
                //   RepTypeInt := Rep.AsInteger();
                typeimp := 1;
                Periode := "G/L Account".GETFILTER("Date Filter");
                Annee := DATE2DMY(CALCDATE('+1J', "G/L Account".GETRANGEMIN("Date Filter")), 3);
                Txtfilterdate[1] := '..C31/12/' + COPYSTR(FORMAT(Annee - 1), 3, 2);
                Txtfilterdate[2] := '01/01' + COPYSTR(FORMAT(Annee), 3, 2) + '..' + FORMAT("G/L Account".GETRANGEMIN("Date Filter") - 1);
                Txtfilterdate[3] := "G/L Account".GETFILTER("Date Filter");
                Txtfilterdate[4] := '..' + FORMAT("G/L Account".GETRANGEMAX("Date Filter"));
                IF Rep = Rep::"&Solde" THEN
                    Txt := 'Solde période antérieurs'
                ELSE
                    Txt := 'Mouvements période antérieurs';
                FOR i := 1 TO 4 DO BEGIN
                    CurrReport.CREATETOTALS(Mntdebit[i], Mntcredit[i], MntdebitP[i], MntcreditP[i]);
                    Mntdebit[i] := 0;
                    Mntcredit[i] := 0;
                    MntdebitP[i] := 0;
                    MntcreditP[i] := 0;
                END;
                IF (Rep = Rep::"&Solde") AND Excel THEN BEGIN
                    Ligne.WRITETEXT(
                           '' + '' + '' + ';' +   //2
                           '' + '' + '' + ';' +   //3
                           '' + '' + 'Solde D''ouverture' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Solde Anterieur' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Mouvements Periode' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Nouveau Solde' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + '');


                    Ligne.WRITETEXT;

                    Ligne.WRITETEXT(
                           '' + 'N° ' + '' + ';' +   //2
                           '' + '' + 'Libelle' + ';' +   //3
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + '');


                    Ligne.WRITETEXT;
                END;
                IF (Rep = Rep::"&Mouvements") AND Excel THEN BEGIN
                    Ligne.WRITETEXT(
                           '' + '' + '' + ';' +   //2
                           '' + '' + '' + ';' +   //3
                           '' + '' + 'Solde D''ouverture' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Mouvements Anterieur' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Mouvements Periode' + ';' +
                           '' + '' + '' + ';' +
                           '' + '' + 'Nouveau Solde' + ';' +
                           '' + '' + '' + ';' + '' + '' + '');


                    Ligne.WRITETEXT;

                    Ligne.WRITETEXT(
                           '' + 'N°' + '' + ';' +   //2
                           '' + '' + 'Libelle' + ';' +   //3
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + 'Débit' + ';' +
                           '' + '' + 'Crédit' + ';' +
                           '' + '' + '');


                    Ligne.WRITETEXT
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(Rep; Rep)
                {
                    ApplicationArea = All;
                    Caption = 'Type de rapport';
                    ToolTip = 'Sélectionnez le type de rapport à imprimer.';
                    OptionCaption = '&Solde, &Mouvements';
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

    trigger OnInitReport()
    begin
        CLEARALL;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            // ExcelBuffer.CreateBook('Balance gÚnÚrale 8 COL');
            // GL2024   ExcelBuffer.CreateSheet('Donnéés','Balance Générale',COMPANYNAME,USERID);
            // ExcelBuffer.GiveUserControl;
        END;
        //   IF Excel THEN
        //     fich.CLOSE;
    end;

    trigger OnPreReport()
    begin
        IF PrintToExcel THEN BEGIN
            IF ExcelBuffer.FIND('-') THEN
                ExcelBuffer.DELETEALL;
        END;
    end;

    var
        ExcelBuffer: Record 370;
        PrintToExcel: Boolean;
        TextePeriode: Text[30];
        Fdate: Record 15;
        Pcompt: Record 50;
        Pcomptc: Record 50;
        Periode: Text[60];
        Periodeant: Text[60];
        "Périodec": Text[30];
        "Périodecf": Text[30];
        Solde1: Decimal;
        Solde2: Decimal;
        X: Decimal;
        TotalS1: Decimal;
        TotalS2: Decimal;
        Rep: Option "&Solde","&Mouvements";
        Annee: Integer;
        SoldeDouv: Decimal;
        SoldeCouv: Decimal;
        Mntdebouv: Decimal;
        Mntcrouv: Decimal;
        Mntdebant: Decimal;
        Mntcrant: Decimal;
        Mntdebmois: Decimal;
        Mntcrmois: Decimal;
        TotalSe1: Decimal;
        TotalSe2: Decimal;
        Txt: Text[30];
        SoldeAntD: Decimal;
        SoldeAntC: Decimal;
        Txtfilterdate: array[4] of Text[30];
        Mntdebit: array[4] of Decimal;
        Mntcredit: array[4] of Decimal;
        MntdebitP: array[4] of Decimal;
        MntcreditP: array[4] of Decimal;
        i: Integer;
        typeimp: Option "Général",Social,"économique";
        IntEntete: Integer;
        nameF: Text[100];
        Excel: Boolean;
        ex: Boolean;
        fich: File;
        Ligne: OutStream;
        Txtcpt: Text[100];
        SdO: Text[30];
        ScO: Text[30];
        SDA: Text[30];
        SCA: Text[30];
        SDP: Text[30];
        SCP: Text[30];
        SDN: Text[30];
        SCN: Text[30];
        Txt2: Text[30];
        InfoSoc: Record 79;
        Npage: Decimal;
        CommonDialogControl: Integer;
        "//SBN-NWDTN 091111": Integer;
        SD00: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        GENERAL_BALANCECaptionLbl: Label 'Balance Générale';
        Previous_date__CaptionLbl: Label 'Date précédente';
        Period_date__CaptionLbl: Label 'Date de période';
        New_balancesCaptionLbl: Label 'Nouveaux soldes';
        CREDITCaptionLbl: Label 'CREDIT';
        DEBITCaptionLbl: Label 'DEBIT';
        "CréditCaptionLbl": Label 'Crédit';
        Month_AmountCaptionLbl: Label 'Montant du mois';
        "DébitCaptionLbl": Label 'Débit';
        "CréditCaption_Control31Lbl": Label 'Crédit';
        Previous_balanceCaptionLbl: Label 'Solde précédent';
        "DébitCaption_Control50Lbl": Label 'Débit';
        "CréditCaption_Control54Lbl": Label 'Crédit';
        Opening_BalanceCaptionLbl: Label 'Solde d’ouverture';
        "DébitCaption_Control73Lbl": Label 'Débit';
        DescriptionCaptionLbl: Label 'Description';
        No_CaptionLbl: Label 'N°';
        No_Caption_Control1180250003Lbl: Label 'N°';
        DescriptionCaption_Control1180250005Lbl: Label 'Description';
        "DébitCaption_Control1180250007Lbl": Label 'Débit';
        "CréditCaption_Control1180250008Lbl": Label 'Crédit';
        "DébitCaption_Control1180250010Lbl": Label 'Débit';
        "CréditCaption_Control1180250013Lbl": Label 'Crédit';
        "DébitCaption_Control1180250014Lbl": Label 'Débit';
        "CréditCaption_Control1180250017Lbl": Label 'Crédit';
        DEBITCaption_Control1180250018Lbl: Label 'DEBIT';
        CREDITCaption_Control1180250021Lbl: Label 'CREDIT';
        New_balancesCaption_Control1180250023Lbl: Label 'Nouveaux soldes';
        Month_AmountCaption_Control1180250025Lbl: Label 'Montant du mois';
        Previous_balanceCaption_Control1180250027Lbl: Label 'Solde précédent';
        Opening_BalanceCaption_Control1180250028Lbl: Label 'Solde d’ouverture';
        No__2CaptionLbl: Label 'N° 2';
        Month_AmountCaption_Control1000000003Lbl: Label 'Montant du mois';
        Previous_amountCaptionLbl: Label 'Montant précédent';
        CREDITCaption_Control1000000010Lbl: Label 'CREDIT';
        DEBITCaption_Control1000000011Lbl: Label 'DEBIT';
        "CréditCaption_Control1000000013Lbl": Label 'Crédit';
        "DébitCaption_Control1000000016Lbl": Label 'Débit';
        "CréditCaption_Control1000000017Lbl": Label 'Crédit';
        "DébitCaption_Control1000000020Lbl": Label 'Débit';
        "CréditCaption_Control1000000022Lbl": Label 'Crédit';
        "DébitCaption_Control1000000024Lbl": Label 'Débit';
        Opening_BalanceCaption_Control1000000001Lbl: Label 'Solde d’ouverture';
        New_balancesCaption_Control1000000007Lbl: Label 'Nouveaux soldes';
        No_Caption_Control1000000026Lbl: Label 'N°';
        DescriptionCaption_Control1000000028Lbl: Label 'Description';
        No_Caption_Control1180250034Lbl: Label 'N°';
        DescriptionCaption_Control1180250036Lbl: Label 'Description';
        "DébitCaption_Control1180250037Lbl": Label 'Débit';
        "CréditCaption_Control1180250040Lbl": Label 'Crédit';
        "DébitCaption_Control1180250042Lbl": Label 'Débit';
        "CréditCaption_Control1180250044Lbl": Label 'Crédit';
        "DébitCaption_Control1180250046Lbl": Label 'Débit';
        "CréditCaption_Control1180250048Lbl": Label 'Crédit';
        Month_AmountCaption_Control1180250050Lbl: Label 'Montant du mois';
        Previous_amountCaption_Control1180250052Lbl: Label 'Montant précédent';
        Opening_BalanceCaption_Control1180250055Lbl: Label 'Solde d’ouverture';
        DEBITCaption_Control1180250057Lbl: Label 'DEBIT';
        New_balancesCaption_Control1180250059Lbl: Label 'Nouveaux soldes';
        CREDITCaption_Control1180250060Lbl: Label 'CREDIT';
        No__2Caption_Control1180250063Lbl: Label 'N° 2';
        Totals__CaptionLbl: Label 'Totals :';
        Totals__Caption_Control1000000087Lbl: Label 'Totals :';
        Totals__Caption_Control1000000058Lbl: Label 'Totals :';
        Totals__Caption_Control1000000091Lbl: Label 'Totals :';

    // [Scope('Internal')]
    // procedure OpenFile()
    // begin
    //     //CommonDialogControl.DialogTitle('Export');
    //     //CommonDialogControl.Filter := Text004;
    //     //CommonDialogControl.FileName := 'Compensation';
    //     //CommonDialogControl.InitDir('c:\');
    //     //CommonDialogControl.ShowSave;
    //     nameF:='c:\BalanceGenarale.csv' ;//CommonDialogControl.FileName;
    //     IF nameF='' THEN
    //     BEGIN
    //      Excel := FALSE;
    //      EXIT;
    //     END;
    //     IF EXISTS(nameF) THEN
    //      BEGIN
    //       ex := FALSE;
    //       REPEAT
    //         IF CONFIRM('Le fichier spécifié existe déja \'+
    //                  'Voulez vous l''écraser',FALSE) THEN
    //          BEGIN
    //         //   fich.CREATE(nameF);
    //           ex := TRUE;
    //          END
    //         ELSE
    //          BEGIN
    //         //  CommonDialogControl.ShowSave;
    //     nameF:='c:\BalanceGenarale.csv' ;//CommonDialogControl.FileName;
    //          // nameF:=CommonDialogControl.FileName;
    //         //   IF EXISTS(nameF) THEN
    //         //    ex := FALSE;
    //           END;
    //        UNTIL ex;
    //      END ELSE
    //     //   fich.CREATE(nameF);

    //     // fich.TEXTMODE(TRUE);
    //     // fich.WRITEMODE(TRUE);
    //     // fich.QUERYREPLACE := TRUE;
    //     // fich.CREATEOUTSTREAM(Ligne);
    //     Ligne.WRITETEXT(''+COMPANYNAME+''+';'+
    //            ''+''+''+';'+   //2
    //            ''+''+''+';'+   //3
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+FORMAT(WORKDATE)+';'+
    //            ''+''+'');
    //     Ligne.WRITETEXT;
    //     Ligne.WRITETEXT(''+''+''+';'+
    //            ''+''+''+';'+   //2
    //            ''+''+''+';'+   //3
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+Txt2+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'');
    //     Ligne.WRITETEXT;
    //     Ligne.WRITETEXT(''+''+''+';'+
    //            ''+''+''+';'+   //2
    //            ''+''+''+';'+   //3
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'Periode'+FORMAT(Periode)+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'');
    //     Ligne.WRITETEXT;
    //     Ligne.WRITETEXT(''+''+''+';'+
    //            ''+''+''+';'+   //2
    //            ''+''+''+';'+   //3
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'Periode anterieur'+FORMAT(Txtfilterdate[2])+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'');
    //     Ligne.WRITETEXT;

    //     Ligne.WRITETEXT(''+''+''+';'+
    //            ''+''+''+';'+   //2
    //            ''+''+''+';'+   //3
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+Txtcpt+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+''+';'+
    //            ''+''+'');


    //     Ligne.WRITETEXT;
    // end;
}

