report 8004158 "Liste tombés d'échéances AVAL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ListetombésdéchéancesAVAL.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Liste tombés d''échéances AVAL';

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING(Banque, "Compte Bancaire")
                                WHERE("Mode Paiement" = CONST(Traite),
                                      "Copied To No." = FILTER(''),
                                      "Account Type" = FILTER(Vendor | 3),
                                      "Status No." = FILTER(<> 60000),
                                      "Aval" = CONST(true));
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
            column("Liste_des_tombés_d_échéances_des_LC_AVALISECaption"; Liste_des_tombés_d_échéances_des_LC_AVALISECaptionLbl)
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
            /*GL  column(AmountBanque; AmountBanque)
              {

              }*/
            trigger OnAfterGetRecord()
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


                /*GL  IF "Payment Line".Banque <> BanqueTest then begin
                      AmountBanque := 0;
                      BanqueTest := "Payment Line".Banque;
                  end;


                  AmountBanque := AmountBanque + "Payment Line".Amount;*/

            end;

            trigger OnPreDataItem()
            begin
                AmountBanque := 0;
                LastFieldNo := FIELDNO("Compte Bancaire");
                "Payment Line".SETFILTER("Payment Line"."Due Date", '>=%1&<=%2', DateRec, DateDep);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(DateRec; DateRec)
                {
                    ApplicationArea = all;
                    Caption = 'Période du :';
                }
                field(DateDep; DateDep)
                {
                    ApplicationArea = all;
                    Caption = 'Au :';
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
        AmountBanque: Decimal;
        BanqueTest: Option " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUSID,TSB,"WIFAK BANK","ALBARAKA BANK";
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
        "Liste_des_tombés_d_échéances_des_LC_AVALISECaptionLbl": Label 'Liste des tombés d''échéances des LC AVALISE';
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





}

