report 50242 "Etat Justificatif de Paie"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatJustificatifdePaie.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'Etat Justificatif de Paie';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         RequestFilterFields = Affectation, Month, Year;
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(RecAffectation_Decription; RecAffectation.Decription)
    //         {
    //         }
    //         column(Rec__Salary_Lines__GETFILTER_Affectation_; "Rec. Salary Lines".GETFILTER(Affectation))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(Rec__Salary_Lines__GETFILTER_Month_; "Rec. Salary Lines".GETFILTER(Month))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(UPPERCASE_USERID_; UPPERCASE(USERID))
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Month; Month)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year_Control1000000048; Year)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(CodeVirement; CodeVirement)
    //         {
    //         }
    //         column(BonCaisse; BonCaisse)
    //         {
    //         }
    //         column(BonRetour; BonRetour)
    //         {
    //         }
    //         column(CodeRetourVirement; CodeRetourVirement)
    //         {
    //         }
    //         column(CodeBordereau; CodeBordereau)
    //         {
    //         }
    //         column(TotalPaie; TotalPaie)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TotalVirement; TotalVirement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TotalCaisse; TotalCaisse)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TotalRetour; TotalRetour)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(TotalRetourVirement; TotalRetourVirement)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Net_à_PayerCaption"; Net_à_PayerCaptionLbl)
    //         {
    //         }
    //         column(MoisCaption; MoisCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(Matr_Caption; Matr_CaptionLbl)
    //         {
    //         }
    //         column("AnnéeCaption"; AnnéeCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(Code_VirementCaption; Code_VirementCaptionLbl)
    //         {
    //         }
    //         column(Bon_de_CaisseCaption; Bon_de_CaisseCaptionLbl)
    //         {
    //         }
    //         column(Bon_de_Retour_CaisseCaption; Bon_de_Retour_CaisseCaptionLbl)
    //         {
    //         }
    //         column(Etat_Justificatif_de_PaieCaption; Etat_Justificatif_de_PaieCaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column("Service_ComptabilitéCaption"; Service_ComptabilitéCaptionLbl)
    //         {
    //         }
    //         column(Code_Retour_VirementCaption; Code_Retour_VirementCaptionLbl)
    //         {
    //         }
    //         column(Code_BordereauCaption; Code_BordereauCaptionLbl)
    //         {
    //         }
    //         column(TOTALCaption; TOTALCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             CodeVirement := '';
    //             CodeRetourVirement := '';
    //             BonCaisse := '';
    //             RecLigneLotPaie.RESET;
    //             RecPaymentLine.RESET;
    //             RecRetourCaisse.RESET;
    //             BonRetour := '';
    //             CodeBordereau := '';

    //             RecLigneLotPaie.SETRANGE("Num Paie", "No.");
    //             RecLigneLotPaie.SETRANGE("Matricule Salarié", Employee);
    //             RecLigneLotPaie.SETRANGE(Type, RecLigneLotPaie.Type::"Ordre Virement");
    //             RecLigneLotPaie.SETRANGE(Status, RecLigneLotPaie.Status::Validée);
    //             IF RecLigneLotPaie.FINDFIRST THEN BEGIN
    //                 CodeVirement := RecLigneLotPaie.Code;
    //                 CodeRetourVirement := RecLigneLotPaie."Rejet Salaire";
    //                 TotalVirement += RecLigneLotPaie."Montant Net";
    //                 IF CodeRetourVirement <> '' THEN TotalRetourVirement += RecLigneLotPaie."Montant Net";
    //             END;
    //             //CodeVirement:='';
    //             RecPaymentLine.SETRANGE(Caisse, TRUE);
    //             RecPaymentLine.SETRANGE("Code Opération", 'P1', 'P4');
    //             //RecPaymentLine.SETRANGE("Code Opération",'P1');
    //             RecPaymentLine.SETRANGE(Benificiaire, Employee);
    //             //RecPaymentLine.SETRANGE("N° Paie","No.");
    //             RecPaymentLine.SETRANGE(MoisPaie, Month);
    //             RecPaymentLine.SETRANGE(AnnePaie, Year);
    //             IF RecPaymentLine.FINDFIRST THEN BEGIN
    //                 BonCaisse := RecPaymentLine."Numero Seq";
    //                 TotalCaisse += ABS(RecPaymentLine.Amount);
    //                 RecRetourCaisse.SETRANGE(Caisse, TRUE);
    //                 RecRetourCaisse.SETRANGE("Code Opération", 'PR');
    //                 RecRetourCaisse.SETRANGE("Numero Seq Retour", BonCaisse);
    //                 IF RecRetourCaisse.FINDFIRST THEN BEGIN
    //                     BonRetour := RecRetourCaisse."Numero Seq";
    //                     TotalRetour += ABS(RecRetourCaisse.Amount);
    //                 END;
    //             END;
    //             TotalPaie += "Net salary cashed";
    //             // RB SORO 06/04/2015
    //             /*  IF PrintToExcel THEN BEGIN
    //                   MakeExcelDataBody;
    //               END;*/
    //             // RB SORO 06/04/2015

    //             //MH SORO 13-09-2019
    //             RecEnteteLotPaie.RESET;
    //             RecEnteteLotPaie.SETRANGE(Code, CodeRetourVirement);
    //             IF RecEnteteLotPaie.FINDFIRST THEN CodeBordereau := RecEnteteLotPaie."Code Bordereau";
    //             //MH SORO 13-09-2019
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF CompanyInformation.GET THEN;
    //             IF RecAffectation.GET("Rec. Salary Lines".GETFILTER(Affectation)) THEN;
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
    //     // RB SORO 06/04/2015
    //     /*  IF PrintToExcel THEN
    //           CreateExcelbook;*/
    //     // RB SORO 06/04/2015
    // end;

    // trigger OnPreReport()
    // begin
    //     // RB SORO 06/04/2015
    //     // IF PrintToExcel THEN
    //     // MakeExcelInfo;
    //     // RB SORO 06/04/2015
    // end;

    // var
    //     CompanyInformation: Record 79;
    //     CodeVirement: Code[20];
    //     BonCaisse: Code[20];
    //     BonRetour: Code[20];
    //     CodeRetourVirement: Code[20];
    //     TotalPaie: Decimal;
    //     TotalVirement: Decimal;
    //     TotalCaisse: Decimal;
    //     TotalRetour: Decimal;
    //     TotalRetourVirement: Decimal;
    //     RecLigneLotPaie: Record 52048957;
    //     RecPaymentLine: Record 10866;
    //     PageConst: Label 'Page :';
    //     RecRetourCaisse: Record 10866;
    //     RecAffectation: Record 52048917;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Text001: Label 'Données';
    //     Text002: Label 'Etat Justificatif de Paie';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     RecEnteteLotPaie: Record 52048956;
    //     CodeBordereau: Code[20];
    //     "Net_à_PayerCaptionLbl": Label 'Net à Payer';
    //     MoisCaptionLbl: Label 'Mois';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     Matr_CaptionLbl: Label 'Matr.';
    //     "AnnéeCaptionLbl": Label 'Année';
    //     AffectationCaptionLbl: Label 'Affectation :';
    //     Code_VirementCaptionLbl: Label 'Code Virement';
    //     Bon_de_CaisseCaptionLbl: Label 'Bon de Caisse';
    //     Bon_de_Retour_CaisseCaptionLbl: Label 'Bon de Retour Caisse';
    //     Etat_Justificatif_de_PaieCaptionLbl: Label 'Etat Justificatif de Paie';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     "Service_ComptabilitéCaptionLbl": Label 'Service Comptabilité';
    //     Code_Retour_VirementCaptionLbl: Label 'Code Retour Virement';
    //     Code_BordereauCaptionLbl: Label 'Code Bordereau';
    //     TOTALCaptionLbl: Label 'TOTAL';



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
    //     ExcelBuf.AddInfoColumn(REPORT::"Etat Justificatif de Paie", FALSE, FALSE, FALSE, FALSE, '', 0);
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
    //     ExcelBuf.AddColumn('Matricule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nom et Prenom', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Mois', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Année', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Net à Payer', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Code Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Code Virement', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Bon de Caisse', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Bon de Retour Caisse', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Code Retour Virement', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Code Bordereau', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure MakeExcelDataBody()
    // begin
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Employee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Name, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Month + 1, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Year, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Net salary cashed", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Affectation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(CodeVirement, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(BonCaisse, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(BonRetour, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(CodeRetourVirement, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(CodeBordereau, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('Etat Justificatif de Paie');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;
}

