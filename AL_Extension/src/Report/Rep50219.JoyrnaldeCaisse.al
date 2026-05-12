report 50219 "Joyrnal de Caisse"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/JoyrnaldeCaisse.rdlc';
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'Joyrnal de Caisse';
    // ApplicationArea = all;

    // dataset
    // {
    //     dataitem("Payment Line"; 10866)
    //     {
    //         DataItemTableView = SORTING("Code Opération", "Due Date", Benificiaire, Amount)
    //                             WHERE(Caisse = CONST(true),
    //                                   Amount = FILTER(<> 0),
    //                                   "Caisse Chantier" = CONST(false));
    //         RequestFilterFields = "Type Caisse";

    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column("Période_du______FORMAT_Date1_____AU____FORMAT_Date2_"; 'Période du :  ' + FORMAT(Date1) + '  AU  ' + FORMAT(Date2))
    //         {
    //         }
    //         column(GETFILTER__Payment_Line___Type_Caisse__; GETFILTER("Payment Line"."Type Caisse"))
    //         {
    //         }
    //         column(SoldeInitiale; ROUND(SoldeInitiale, 0.01))
    //         {
    //         }
    //         column(Payment_Line__Credit_Amount_; "Credit Amount")
    //         {
    //         }
    //         column(Payment_Line__Debit_Amount_; "Debit Amount")
    //         {
    //         }
    //         column(DesignationCodeOperation; DesignationCodeOperation)
    //         {
    //         }
    //         column(JOURNAL_DE_CAISSECaption; JOURNAL_DE_CAISSECaptionLbl)
    //         {
    //         }
    //         column(DEPENSESCaption; DEPENSESCaptionLbl)
    //         {
    //         }
    //         column(LIBELLESCaption; LIBELLESCaptionLbl)
    //         {
    //         }
    //         column(RECETTESCaption; RECETTESCaptionLbl)
    //         {
    //         }
    //         column(MOUVEMENTSCaption; MOUVEMENTSCaptionLbl)
    //         {
    //         }
    //         column(Solde_Reporte___Caption; Solde_Reporte___CaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_Line_No_; "Line No.")
    //         {
    //         }
    //         column("Payment_Line_Code_Opération"; "Code Opération")
    //         {
    //         }
    //         column(Montant_Debit; "Montant Debit")
    //         {
    //         }

    //         column(Montant_Credit; "Montant Credit")
    //         {
    //         }
    //         column(Totalcredit1; Totalcredit)
    //         {

    //         }
    //         column(Totaldebit1; Totaldebit)
    //         {

    //         }
    //         column(SoldeInitiale__Totaldebit_Totalcredit_1; SoldeInitiale + (Totaldebit - Totalcredit))
    //         {

    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF CodeOpérationCaisse.GET("Payment Line"."Code Opération") THEN DesignationCodeOperation := CodeOpérationCaisse.Description;







    //             //GL2024
    //             if "Payment Line"."Code Opération" <> Operation then begin
    //                 "Montant Credit" := 0;
    //                 "Montant Debit" := 0;
    //                 Operation := "Payment Line"."Code Opération";

    //             end;

    //             "Montant Debit" := "Montant Debit" + "Debit Amount";
    //             "Montant Credit" := "Montant Credit" + "Credit Amount";
    //             //END;

    //             //IF ("Payment Line".Paie<>TRUE) AND  ("Payment Line".Avance<>TRUE) THEN CurrReport.SHOWOUTPUT(FALSE);


    //             //IF ("Payment Line".Paie=TRUE) OR  ("Payment Line".Avance=TRUE) THEN
    //             //BEGIN
    //             Totaldebit := Totaldebit + "Debit Amount";
    //             Totalcredit := Totalcredit + "Credit Amount";

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Code Opération");
    //             "Payment Line".SETRANGE("Payment Line"."Due Date", Date1, Date2);
    //             "Payment Line".SETRANGE("N° Affaire", FORMAT(ChantierAffaire));
    //             Totalcredit := 0;
    //             Totaldebit := 0;
    //             "Montant Credit" := 0;
    //             "Montant Debit" := 0;

    //             SoldeInitiale := 0;
    //             RecPaymentLine.SETRANGE(RecPaymentLine.Caisse, TRUE);
    //             IF "Payment Line".GETFILTER("Type Caisse") <> '' THEN BEGIN
    //                 IF "Payment Line".GETFILTER("Type Caisse") = 'C' THEN Choix := 3;
    //                 IF "Payment Line".GETFILTER("Type Caisse") = 'E' THEN Choix := 2;
    //                 IF "Payment Line".GETFILTER("Type Caisse") = 'A' THEN Choix := 1;


    //                 RecPaymentLine.SETRANGE("Type Caisse", Choix);
    //             END;

    //             RecPaymentLine.SETFILTER("Due Date", '<%1', Date1);
    //             RecPaymentLine.SETRANGE("Caisse Chantier", FALSE);
    //             IF RecPaymentLine.FINDFIRST THEN
    //                 RecPaymentLine.CalcSums(Amount);
    //             SoldeInitiale := RecPaymentLine.Amount;

    //             /*GL2024  REPEAT
    //                   SoldeInitiale := SoldeInitiale + (RecPaymentLine."Debit Amount" - RecPaymentLine."Credit Amount");
    //               UNTIL RecPaymentLine.NEXT = 0;



    //               */

    //         end;
    //     }
    //     dataitem("Payment Line 2"; 10866)
    //     {
    //         DataItemTableView = SORTING("Code Opération", "Due Date", Benificiaire, Amount)
    //                             WHERE(Caisse = CONST(true),
    //                                   Amount = FILTER(<> 0),
    //                                   "Type Caisse" = CONST(C),
    //                                   Paie = CONST(false),
    //                                   Avance = CONST(false),
    //                                   "Caisse Chantier" = CONST(false));
    //         column(Payment_Line_2__Credit_Amount_; "Credit Amount")
    //         {
    //         }
    //         column(Payment_Line_2__Debit_Amount_; "Debit Amount")
    //         {
    //         }
    //         column(DesignationCodeOperation_Control1000000021; DesignationCodeOperation)
    //         {
    //         }
    //         column(Payment_Line_2__Payment_Line_2___Numero_Seq_; "Payment Line 2"."Numero Seq")
    //         {
    //         }
    //         column(Payment_Line_2__Payment_Line_2___Due_Date_; "Payment Line 2"."Due Date")
    //         {
    //         }
    //         column(Totalcredit; Totalcredit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Totaldebit; Totaldebit)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SoldeInitiale__Totaldebit_Totalcredit_; SoldeInitiale + (Totaldebit - Totalcredit))
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(T_O_T_A_L____D_E_S_____M_O_U_V_E_M_E_N_T_S___Caption; T_O_T_A_L____D_E_S_____M_O_U_V_E_M_E_N_T_S___CaptionLbl)
    //         {
    //         }
    //         column(S_O_L_D_E______P_O_U_R_____B_A_L_A_N_C_E___Caption; S_O_L_D_E______P_O_U_R_____B_A_L_A_N_C_E___CaptionLbl)
    //         {
    //         }
    //         column(Payment_Line_2_No_; "No.")
    //         {
    //         }
    //         column(Payment_Line_2_Line_No_; "Line No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF CodeOpérationCaisse.GET("Payment Line 2"."Code Opération") THEN DesignationCodeOperation := CodeOpérationCaisse.Description;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             "Payment Line 2".SETRANGE("Payment Line 2"."Due Date", Date1, Date2);
    //             "Payment Line 2".SETRANGE("N° Affaire", FORMAT(ChantierAffaire));
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
    //                 field("Période du :"; "Date1")
    //                 {
    //                     Caption = 'Période du :';
    //                 }
    //                 field("Au"; "Date2")
    //                 {
    //                     Caption = 'Au';
    //                 }
    //                 field("Chantier :"; ChantierAffaire)
    //                 {
    //                     Caption = 'Chantier :';
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

    // trigger OnPostReport()
    // begin
    //     /*GL2024  IF PrintToExcel THEN
    //       CreateExcelbook;*/
    // end;

    // trigger OnPreReport()
    // begin
    //     /*GL2024    IF PrintToExcel THEN
    //             MakeExcelInfo;*/
    // end;

    // var
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Date1: Date;
    //     Date2: Date;
    //     Totaldebit: Decimal;
    //     Totalcredit: Decimal;
    //     RecPaymentLine: Record 10866;
    //     SoldeInitiale: Decimal;
    //     "CodeOpérationCaisse": Record 50000;
    //     DesignationCodeOperation: Text[200];
    //     Choix: Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     TotalFor: Label 'Total ';
    //     Text001: Label 'Données';
    //     Text002: Label 'Journal de La caisse';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     ChantierAffaire: Option ADMINISTRATION,"AEROP-JERBA-MATMATA",PENETRANTE_LOT2,PENETRANTE_LOT3,BIZERTE_BASE_AERIEN,PONT_BIZERTE_LOT1,"PORT FINA RAOUED RP2","AUTOROUTE SBIKHA LO5",CHANTIER_KEF_RR173;
    //     JOURNAL_DE_CAISSECaptionLbl: Label 'JOURNAL DE CAISSE';
    //     DEPENSESCaptionLbl: Label 'DEPENSES';
    //     LIBELLESCaptionLbl: Label 'LIBELLES';
    //     RECETTESCaptionLbl: Label 'RECETTES';
    //     MOUVEMENTSCaptionLbl: Label 'MOUVEMENTS';
    //     Solde_Reporte___CaptionLbl: Label 'Solde Reporte  :';
    //     T_O_T_A_L____D_E_S_____M_O_U_V_E_M_E_N_T_S___CaptionLbl: Label 'T O T A L    D E S     M O U V E M E N T S  :';
    //     S_O_L_D_E______P_O_U_R_____B_A_L_A_N_C_E___CaptionLbl: Label 'S O L D E      P O U R     B A L A N C E  :';
    //     "Montant Credit": Decimal;
    //     "Montant Debit": Decimal;
    //     Operation: code[20];


    // /*GL2024  procedure MakeExcelInfo()
    //   begin
    //       ExcelBuf.SetUseInfoSheet;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(REPORT::"Suivi Mouvement Transfert", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(USERID, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(TODAY, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       //ExcelBuf.NewRow;
    //       ExcelBuf.ClearNewRow;
    //       MakeExcelDataHeader;

    //   end;*/

    // /*GL2024 local procedure MakeExcelDataHeader()
    //  begin
    //      ExcelBuf.NewRow;
    //      ExcelBuf.AddColumn('Libellée', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //      ExcelBuf.AddColumn('Recettes', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //      ExcelBuf.AddColumn('Déoenses', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //  end;*/

    // /*GL2024  local procedure MakeExcelDataHeader2()
    //  begin
    //      //ExcelBuf.NewRow;
    //      //ExcelBuf.AddColumn('N° Vehicule :'+"Item Ledger Entry"."N° Véhicule",FALSE,'',TRUE,FALSE,TRUE,'',0);
    //      //ExcelBuf.AddColumn('Description :' +"Item Ledger Entry".Description,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //      //ExcelBuf.AddColumn('N° Serie :'+Numserie,FALSE,'',TRUE,FALSE,TRUE,'',0);
    //  end;*/


    // /*GL2024  procedure MakeExcelDataBody()
    //  begin
    //      ExcelBuf.NewRow;
    //      ExcelBuf.AddColumn(DesignationCodeOperation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //      ExcelBuf.AddColumn("Payment Line"."Debit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //      ExcelBuf.AddColumn("Payment Line"."Credit Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //  end;*/


    // /*GL2024   procedure CreateExcelbook()
    //    begin
    //        ExcelBuf.CreateBook('Joyrnal de Caisse');
    //        //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //        ExcelBuf.GiveUserControl;
    //        ERROR('');
    //    end;*/
}

