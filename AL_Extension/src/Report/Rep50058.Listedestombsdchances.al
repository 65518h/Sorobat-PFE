report 50058 "Liste des tombés d'échéances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Listedestombésdéchéances.rdlc';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING(Banque, "Compte Bancaire")
                                WHERE("Mode Paiement" = CONST(Traite),
                                      "Copied To No." = FILTER(''),
                                      "Account Type" = FILTER(Vendor | "G/L Account"),
                                      "Status No." = FILTER(<> 60000));
            RequestFilterFields = Banque, "Compte Bancaire", "Type de compte", "Code compte";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(DateDep; DateDep)
            {
            }
            column(DateRec; DateRec)
            {
            }
            column(Payment_Line_Banque; Banque)
            {
            }
            column(RibCompte; RibCompte)
            {
            }
            column(Payment_Line_Amount; Amount)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Payment_Line__Due_Date_; "Due Date")
            {
            }
            column(Payment_Line__Drawee_Reference_; "Drawee Reference")
            {
            }
            column(Payment_Line__External_Document_No__; "External Document No.")
            {
            }
            column(TypeAvance; TypeAvance)
            {
            }
            column(Payment_Line__No__; "No.")
            {
            }
            column(TotalFor___FIELDCAPTION__Compte_Bancaire_______; TotalFor + FIELDCAPTION("Compte Bancaire") + ' :')
            {
            }
            column(Payment_Line_Amount_Control1000000033; Amount)
            {
            }
            column(Nbre1; Nbre1)
            {
            }
            column(TotalFor___FIELDCAPTION_Banque______; TotalFor + FIELDCAPTION(Banque) + ' :')
            {
            }
            column(Payment_Line_Amount_Control1000000035; Amount)
            {
            }
            column(Nbre2; Nbre2)
            {
            }
            column(Payment_Line_Amount_Control1000000020; Amount)
            {
            }
            column(Nbre3; Nbre3)
            {
            }
            column("Liste_des_tombés_d_échéances_des_LCCaption"; Liste_des_tombés_d_échéances_des_LCCaptionLbl)
            {
            }
            column(Au__Caption; Au__CaptionLbl)
            {
            }
            column("Période_du__Caption"; Période_du__CaptionLbl)
            {
            }
            column(Payment_Line_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Payment_Line__Due_Date_Caption; FIELDCAPTION("Due Date"))
            {
            }
            column(FournisseurCaption; FournisseurCaptionLbl)
            {
            }
            column("Numéro_PièceCaption"; Numéro_PièceCaptionLbl)
            {
            }
            column(BanqueCaption; BanqueCaptionLbl)
            {
            }
            column(N__CompteCaption; N__CompteCaptionLbl)
            {
            }
            column(Nbre__Caption; Nbre__CaptionLbl)
            {
            }
            column(Nbre__Caption_Control1000000061; Nbre__Caption_Control1000000061Lbl)
            {
            }
            column("Total_général__Caption"; Total_général__CaptionLbl)
            {
            }
            column(Nbre__Caption_Control1000000062; Nbre__Caption_Control1000000062Lbl)
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Payment_Line_Compte_Bancaire; "Compte Bancaire")
            {
            }
            trigger OnAfterGetRecord()
            var
            begin
                Cmpt2 := 0;

                IF RIBBanque.GET("Payment Line"."Compte Bancaire") THEN;
                RibCompte := RIBBanque.RIB;
                Cmpt1 := 0;

                Cmpt1 := Cmpt1 + 1;
                Cmpt2 := Cmpt2 + 1;
                Nbre3 := Nbre3 + 1;
                TypeAvance := '';
                IF "Payment Class" = 'AVANCE-FRS-TRT' THEN TypeAvance := '*';
                Nbre1 := Cmpt1;
                Nbre2 := Cmpt2;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Compte Bancaire");
                "Payment Line".SETFILTER("Payment Line"."Due Date", '>=%1&<=%2', DateRec, DateDep);
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
        //   CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        // IF PrintToExcel THEN
        //    MakeExcelInfo;
    end;

    var
        PageConst: Label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        DateRec: Date;
        DateDep: Date;
        RIBBanque: Record 270;
        RibCompte: Text[30];
        Nbre1: Integer;
        Nbre2: Integer;
        Nbre3: Integer;
        Cmpt1: Integer;
        Cmpt2: Integer;
        TypeAvance: Text[1];
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Text001: Label 'Données';
        Text002: Label 'Etat des Tombés D''échéances';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';
        "Liste_des_tombés_d_échéances_des_LCCaptionLbl": Label 'Liste des tombés d''échéances des LC';
        Au__CaptionLbl: Label 'Au :';
        "Période_du__CaptionLbl": Label 'Période du :';
        FournisseurCaptionLbl: Label 'Fournisseur';
        "Numéro_PièceCaptionLbl": Label 'Numéro Pièce';
        BanqueCaptionLbl: Label 'Banque';
        N__CompteCaptionLbl: Label 'N° Compte';
        Nbre__CaptionLbl: Label 'Nbre :';
        Nbre__Caption_Control1000000061Lbl: Label 'Nbre :';
        "Total_général__CaptionLbl": Label 'Total général :';
        Nbre__Caption_Control1000000062Lbl: Label 'Nbre :';

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
        ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, FALSE, FALSE, FALSE, '', 0);
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
        ExcelBuf.AddColumn('Banque', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        //ExcelBuf.AddColumn('N° Compte',FALSE,'',TRUE,FALSE,TRUE,'',0);
        ExcelBuf.AddColumn('Numéro Piéce', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Montant', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Date D échéance', FALSE, '', TRUE, FALSE, TRUE, '', 0);
        ExcelBuf.AddColumn('Fournisseur', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    end;

    local procedure MakeExcelDataHeader2()
    begin
        //ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'');
        //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'');
        //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'');
    end;

    // [Scope('Internal')]
    procedure MakeExcelDataBody()
    begin
        IF RIBBanque.GET("Payment Line"."Compte Bancaire") THEN;
        RibCompte := RIBBanque.RIB;


        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT("Payment Line".Banque), FALSE, '', FALSE, FALSE, FALSE, '', 0);
        //ExcelBuf.AddColumn(RIBBanque.RIB,FALSE,'',FALSE,FALSE,FALSE,'',0);
        ExcelBuf.AddColumn("Payment Line"."External Document No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Payment Line".Amount, FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Payment Line"."Due Date", FALSE, '', FALSE, FALSE, FALSE, '', 0);
        ExcelBuf.AddColumn("Payment Line"."Drawee Reference", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    end;

    // [Scope('Internal')]
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBook('Liste des tombÚs');
        //GL2024  ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

