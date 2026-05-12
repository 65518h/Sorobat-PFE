report 50077 "Recap Tombees Echeances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RecapTombeesEcheances.rdlc';
    Caption = 'Recap Tombees Echeances';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            DataItemTableView = SORTING("Due Date", Banque)
                                WHERE("Mode Paiement" = FILTER(Traite),
                                      "Account Type" = FILTER(Vendor | "G/L Account"),
                                      "Payment Class" = FILTER('DECAISS-TRAITE' | 'AVANCE-FRS-TRT' | 'RESERVATION' | 'PAIEMENT' | 'DECAISS-TRAITE-AVAL'),
                                      "External Document No." = FILTER(<> '*BAP*'),
                                      "Copied To No." = FILTER(''));
            RequestFilterFields = "Due Date", Banque;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Du____FORMAT_GETRANGEMIN__Due_Date_________Au______FORMAT_GETRANGEMAX__Due_Date___; 'Du ' + FORMAT(GETRANGEMIN("Due Date")) + '  Au : ' + FORMAT(GETRANGEMAX("Due Date")))
            {
            }
            column(Payment_Line__Due_Date_; "Due Date")
            {
            }
            column(MontantTraite; MontantTraite)
            {
            }
            column(Payment_Line_Banque; Banque)
            {
            }
            column(MontantReservation; MontantReservation)
            {
                DecimalPlaces = 3 : 3;
            }
            column(MontantReservation_MontantTraite_MontantNonPay__MontantAval; MontantReservation + MontantTraite + MontantNonPayé + MontantAval)
            {
                DecimalPlaces = 3 : 3;
            }
            column(MontantNonPay; MontantNonPayé)
            {
            }
            column(MontantAval; MontantAval)
            {
            }
            column(MontantEcheancierTraite; MontantEcheancierTraite)
            {
            }
            column(MontantEcheancierReservation; MontantEcheancierReservation)
            {
            }
            column(MontantEcheancierReservation_MontantEcheancierTraite_MontantEcheancierNonPay__MontantEcheancierAval; MontantEcheancierReservation + MontantEcheancierTraite + MontantEcheancierNonPayé + MontantEcheancierAval)
            {
            }
            column(MontantEcheancierNonPay; MontantEcheancierNonPayé)
            {
            }
            column(MontantEcheancierAval; MontantEcheancierAval)
            {
            }
            column(MontantGlobalTraite; MontantGlobalTraite)
            {
            }
            column(MontantGlobalReservation; MontantGlobalReservation)
            {
            }
            column(MontantGlobalTraite_MontantGlobalReservation_MontantGlobalNonPay__MontantGlobalAval; MontantGlobalTraite + MontantGlobalReservation + MontantGlobalNonPayé + MontantGlobalAval)
            {
            }
            column(MontantGlobalNonPay; MontantGlobalNonPayé)
            {
            }
            column(MontantGlobalAval; MontantGlobalAval)
            {
            }
            column(Payment_LineCaption; Payment_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(BanqueCaption; BanqueCaptionLbl)
            {
            }
            column(Montant_PayCaption; Montant_PayCaptionLbl)
            {
            }
            column(EcheanceCaption; EcheanceCaptionLbl)
            {
            }
            column(ReservationCaption; ReservationCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Montant_Non_PayCaption; Montant_Non_PayCaptionLbl)
            {
            }
            column(Montant_AvalCaption; Montant_AvalCaptionLbl)
            {
            }
            column(Payment_Line_No_; "No.")
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(RECAP_TOMBES_ECHEANCES_; "RECAP_TOMBES_ECHEANCES")
            {
            }
            trigger OnAfterGetRecord()
            begin
                //GL2024
                if "Due Date" <> DueDtae then begin
                    MontantTraite := 0;
                    MontantNonPayé := 0;
                    MontantReservation := 0;
                    MontantAval := 0;
                    MontantEcheancierTraite := 0;
                    MontantEcheancierAval := 0;
                    MontantEcheancierNonPayé := 0;
                    MontantEcheancierReservation := 0;
                    DueDtae := "Due Date";
                    Banque1 := Banque;


                end
                else
                    if Banque <> Banque1 then begin
                        MontantTraite := 0;
                        MontantNonPayé := 0;
                        MontantReservation := 0;
                        MontantAval := 0;
                        Banque1 := Banque;
                    end;
                //GL2024



                IF "Payment Class" = 'RESERVATION' THEN BEGIN
                    MontantReservation += ABS(Amount);
                    MontantEcheancierReservation += ABS(Amount);
                    MontantGlobalReservation += ABS(Amount);
                END;

                IF "Payment Class" = 'PAIEMENT' THEN BEGIN
                    MontantNonPayé += ABS(Amount);
                    MontantEcheancierNonPayé += ABS(Amount);
                    MontantGlobalNonPayé += ABS(Amount);
                END;


                IF ("Payment Class" = 'AVANCE-FRS-TRT') AND ("Status No." < 20000) THEN BEGIN
                    MontantNonPayé += ABS(Amount);
                    MontantEcheancierNonPayé += ABS(Amount);
                    MontantGlobalNonPayé += ABS(Amount);
                END;

                IF ("Payment Class" = 'AVANCE-FRS-TRT') AND ("Status No." >= 20000) THEN BEGIN
                    MontantTraite += ABS(Amount);
                    MontantEcheancierTraite += ABS(Amount);
                    MontantGlobalTraite += ABS(Amount);
                END;



                IF ("Payment Class" = 'DECAISS-TRAITE') THEN BEGIN
                    MontantTraite += ABS(Amount);
                    MontantEcheancierTraite += ABS(Amount);
                    MontantGlobalTraite += ABS(Amount);
                END;

                IF ("Payment Class" = 'DECAISS-TRAITE-AVAL') THEN BEGIN
                    MontantAval += ABS(Amount);
                    MontantEcheancierAval += ABS(Amount);
                    MontantGlobalAval += ABS(Amount);
                END;
            end;


            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Banque);




                MontantEcheancierTraite := 0;
                MontantEcheancierReservation := 0;
                MontantEcheancierNonPayé := 0;
                MontantEcheancierAval := 0;

                MontantTraite := 0;
                MontantNonPayé := 0;
                MontantReservation := 0;
                MontantAval := 0;

                MontantGlobalTraite := 0;
                MontantGlobalAval := 0;
                MontantGlobalNonPayé := 0;
                MontantGlobalReservation := 0;


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
        /*GL2024   IF PrintToExcel THEN
             CreateExcelbook;*/
    end;

    trigger OnPreReport()
    begin
        /*GL2024    IF PrintToExcel THEN
            MakeExcelInfo;*/
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total ';
        MontantTraite: Decimal;
        MontantReservation: Decimal;
        MontantEcheancierTraite: Decimal;
        MontantGlobalTraite: Decimal;
        MontantEcheancierReservation: Decimal;
        MontantGlobalReservation: Decimal;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        Text001: Label 'Données';
        Text002: Label 'Recap Tombes Echeances';
        Text003: Label 'Nom de la société';
        Text004: Label 'N° état';
        Text005: Label 'Nom état';
        Text006: Label 'Code utilisateur';
        Text007: Label 'Date';


        MontantAval: Decimal;
        MontantEcheancierAval: Decimal;
        MontantGlobalAval: Decimal;
        Payment_LineCaptionLbl: Label 'Ligne bordereau';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        BanqueCaptionLbl: Label 'Banque';
        Montant_PayCaptionLbl: Label 'Montant Pay';
        EcheanceCaptionLbl: Label 'Echeance';
        ReservationCaptionLbl: Label 'Reservation';
        TotalCaptionLbl: Label 'Total';
        Montant_Non_PayCaptionLbl: Label 'Montant Non Pay';
        Montant_AvalCaptionLbl: Label 'Montant Aval';
        RECAP_TOMBES_ECHEANCES: Label 'RECAP TOMBES ECHEANCES';
        MontantNonPayé: Decimal;
        MontantEcheancierNonPayé: Decimal;
        MontantGlobalNonPayé: Decimal;
        Banque1: Option " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUSID,TSB;
        DueDtae: Date;




    /*GL2024   procedure MakeExcelInfo()
       begin
           ExcelBuf.SetUseInfoSheet;
           ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,'',TRUE,FALSE,FALSE,'',0);
           ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.NewRow;
           ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',0);
           ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.NewRow;
           ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'',0);
           ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert",FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.NewRow;
           ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',0);
           ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.NewRow;
           ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',0);
           ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',0);
           //ExcelBuf.NewRow;
           ExcelBuf.ClearNewRow;
           MakeExcelDataHeader;
       end;

       local procedure MakeExcelDataHeader()
       begin
           ExcelBuf.NewRow;
           ExcelBuf.AddColumn('Echeance',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Banque',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Montant Paye',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Montant Aval',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Montant Non Paye',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Reservation',FALSE,'',TRUE,FALSE,TRUE,'',0);
           ExcelBuf.AddColumn('Total',FALSE,'',TRUE,FALSE,TRUE,'',0);
       end;

       local procedure MakeExcelDataHeader2()
       begin
           //ExcelBuf.NewRow;
           //ExcelBuf.AddColumn('N  Vehicule :'+"Item Ledger Entry"."N  V hicule",FALSE,'',TRUE,FALSE,TRUE,'');
           //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'');
           //ExcelBuf.AddColumn('N  Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'');
       end;

       procedure MakeExcelDataBody()
       begin


           ExcelBuf.NewRow;
           ExcelBuf.AddColumn("Payment Line"."Due Date",FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(FORMAT("Payment Line".Banque),FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(MontantTraite,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(MontantAval,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(MontantNonPay ,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(MontantReservation,FALSE,'',FALSE,FALSE,FALSE,'',0);
           ExcelBuf.AddColumn(MontantReservation+MontantTraite+MontantNonPay +MontantAval,FALSE,'',FALSE,FALSE,FALSE,'',0);
       end;


       procedure CreateExcelbook()
       begin
           ExcelBuf.CreateBook('Recap Tombees Echeances');
           //Gl2024ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
           ExcelBuf.GiveUserControl;
           ERROR('');
       end;*/
}

