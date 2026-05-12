// report 50173 "Solde Congés"
// {
//     // DefaultLayout = RDLC;
//     // RDLCLayout = './Layouts/SoldeCongés.rdlc';

//     // dataset
//     // {
//     //     dataitem(Employee; 5200)
//     //     {
//     //         DataItemTableView = SORTING(Affectation, "No.")
//     //                             WHERE(Blocked = CONST(false),
//     //                                   BR = CONST(false));
//     //         RequestFilterFields = Affectation, "No.", Blocked;
//     //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
//     //         {
//     //         }
//     //         column(COMPANYNAME; COMPANYNAME)
//     //         {
//     //         }
//     //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
//     //         {
//     //         }
//     //         column(Employee_Affectation; Affectation)
//     //         {
//     //         }
//     //         column(Employee_Employee__Deccription_Affectation_; Employee."Deccription Affectation")
//     //         {
//     //         }
//     //         column(MoisSolde; MoisSolde)
//     //         {
//     //         }
//     //         column("Annéecours"; Annéecours)
//     //         {
//     //         }
//     //         column("Annéecours_Control1000000013"; Annéecours)
//     //         {
//     //         }
//     //         column("Annéepreced"; Annéepreced)
//     //         {
//     //         }
//     //         column(SoldeTotal; SoldeTotal)
//     //         {
//     //         }
//     //         column(soldecours; soldecours)
//     //         {
//     //         }
//     //         column(consomescours; -consomescours)
//     //         {
//     //         }
//     //         column(acquiscours; acquiscours)
//     //         {
//     //         }
//     //         column(soldepreced; soldepreced)
//     //         {
//     //         }
//     //         column(consomepreced; -consomepreced)
//     //         {
//     //         }
//     //         column(acquipreced; acquipreced)
//     //         {
//     //         }
//     //         column(Employee__First_Name_; "First Name")
//     //         {
//     //         }
//     //         column(Employee__No__; "No.")
//     //         {
//     //         }
//     //         column("Soldes_CongésCaption"; Soldes_CongésCaptionLbl)
//     //         {
//     //         }
//     //         column(Affectation__Caption; Affectation__CaptionLbl)
//     //         {
//     //         }
//     //         column(MoisCaption; MoisCaptionLbl)
//     //         {
//     //         }
//     //         column(SoldeCaption; SoldeCaptionLbl)
//     //         {
//     //         }
//     //         column(SoldeCaption_Control1000000008; SoldeCaption_Control1000000008Lbl)
//     //         {
//     //         }
//     //         column("ConsommésCaption"; ConsommésCaptionLbl)
//     //         {
//     //         }
//     //         column(AcquisCaption; AcquisCaptionLbl)
//     //         {
//     //         }
//     //         column(SoldeCaption_Control1000000018; SoldeCaption_Control1000000018Lbl)
//     //         {
//     //         }
//     //         column("ConsommésCaption_Control1000000023"; ConsommésCaption_Control1000000023Lbl)
//     //         {
//     //         }
//     //         column(AcquisCaption_Control1000000024; AcquisCaption_Control1000000024Lbl)
//     //         {
//     //         }
//     //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
//     //         {
//     //         }
//     //         column(MatriculeCaption; MatriculeCaptionLbl)
//     //         {
//     //         }

//     //         trigger OnAfterGetRecord()
//     //         begin

//     //             MoisSolde := '';
//     //             MoisCours := DATE2DMY(TODAY, 2);
//     //             IF MoisCours = 1 THEN MoisSolde := 'Janvier';
//     //             IF MoisCours = 2 THEN MoisSolde := 'Février';
//     //             IF MoisCours = 3 THEN MoisSolde := 'Mars';
//     //             IF MoisCours = 4 THEN MoisSolde := 'Avril';
//     //             IF MoisCours = 5 THEN MoisSolde := 'Mai';
//     //             IF MoisCours = 6 THEN MoisSolde := 'Juin';
//     //             IF MoisCours = 7 THEN MoisSolde := 'Juillet';
//     //             IF MoisCours = 8 THEN MoisSolde := 'Aout';
//     //             IF MoisCours = 9 THEN MoisSolde := 'Septanbre';
//     //             IF MoisCours = 10 THEN MoisSolde := 'Octobre';
//     //             IF MoisCours = 11 THEN MoisSolde := 'Novembre';
//     //             IF MoisCours = 12 THEN MoisSolde := 'Décembre';
//     //             Annéecours := DATE2DMY(TODAY, 3);
//     //             DescQuali := '';
//     //             qualifications.RESET;
//     //             qualifications.SETRANGE(Code, Employee.Qualification);
//     //             IF qualifications.FINDFIRST THEN DescQuali := qualifications.Description;

//     //             Annéepreced := DATE2DMY(TODAY, 3) - 1;
//     //             Annéecours := DATE2DMY(TODAY, 3);



//     //             acquiscours := 0;
//     //             consomescours := 0;
//     //             soldecours := 0;
//     //             acquipreced := 0;
//     //             consomepreced := 0;
//     //             soldepreced := 0;
//     //             SoldeTotal := 0;

//     //             EmployeesdaysoffEntry.RESET;
//     //             EmployeesdaysoffEntry.SETRANGE(EmployeesdaysoffEntry."Employee No.", Employee."No.");
//     //             EmployeesdaysoffEntry.SETRANGE(EmployeesdaysoffEntry."Posting year", DATE2DMY(TODAY, 3) - 1);
//     //             IF EmployeesdaysoffEntry.FINDFIRST() THEN
//     //                 REPEAT
//     //                     IF EmployeesdaysoffEntry."Line type" = 1 THEN acquipreced := acquipreced + EmployeesdaysoffEntry."Quantity (Days)";
//     //                     IF EmployeesdaysoffEntry."Line type" = 2 THEN consomepreced := consomepreced + EmployeesdaysoffEntry."Quantity (Days)";
//     //                     soldepreced := soldepreced + EmployeesdaysoffEntry."Quantity (Days)";

//     //                 UNTIL EmployeesdaysoffEntry.NEXT = 0;

//     //             //**********************************************

//     //             EmployeesdaysoffEntry.RESET;
//     //             EmployeesdaysoffEntry.SETRANGE(EmployeesdaysoffEntry."Employee No.", Employee."No.");
//     //             EmployeesdaysoffEntry.SETRANGE(EmployeesdaysoffEntry."Posting year", DATE2DMY(TODAY, 3));
//     //             IF EmployeesdaysoffEntry.FINDFIRST() THEN
//     //                 REPEAT
//     //                     IF EmployeesdaysoffEntry."Line type" = 1 THEN acquiscours := acquiscours + EmployeesdaysoffEntry."Quantity (Days)";
//     //                     IF EmployeesdaysoffEntry."Line type" = 2 THEN consomescours := consomescours + EmployeesdaysoffEntry."Quantity (Days)";
//     //                     soldecours := soldecours + EmployeesdaysoffEntry."Quantity (Days)";

//     //                 UNTIL EmployeesdaysoffEntry.NEXT = 0;

//     //             //SoldeTotal:=soldecours+soldepreced;

//     //             //*************************************************

//     //             EmployeesdaysoffEntry.RESET;
//     //             EmployeesdaysoffEntry.SETRANGE(EmployeesdaysoffEntry."Employee No.", Employee."No.");
//     //             IF DateFin > 0 THEN
//     //                 //EmployeesdaysoffEntry.SETFILTER(EmployeesdaysoffEntry."Posting month",'=%1',MoisFin);
//     //                 EmployeesdaysoffEntry.SETFILTER(EmployeesdaysoffEntry."Posting year", '<=%1', DateFin);

//     //             IF EmployeesdaysoffEntry.FINDFIRST() THEN
//     //                 REPEAT
//     //                     SoldeTotal := SoldeTotal + EmployeesdaysoffEntry."Quantity (Days)";
//     //                 UNTIL EmployeesdaysoffEntry.NEXT = 0;

//     //         end;

//     //         trigger OnPostDataItem()
//     //         begin
//     //             IF PrintToExcel THEN BEGIN
//     //                 // CreateExcelbook;
//     //             END;
//     //         end;

//     //         trigger OnPreDataItem()
//     //         begin
//     //             LastFieldNo := FIELDNO(Affectation);
//     //             IF PrintToExcel THEN BEGIN
//     //                 MakeExcelDataHeader;
//     //             END;
//     //             IF PrintToExcel THEN BEGIN
//     //                 // MakeExcelDataBody;
//     //             END;
//     //         end;
//     //     }
//     // }

//     // requestpage
//     // {

//     //     layout
//     //     {
//     //     }

//     //     actions
//     //     {
//     //     }
//     // }

//     // labels
//     // {
//     // }

//     // var
//     //     PageConst: Label 'Page';
//     //     LastFieldNo: Integer;
//     //     FooterPrinted: Boolean;
//     //     "Annéecours": Integer;
//     //     "Annéepreced": Integer;
//     //     acquiscours: Decimal;
//     //     consomescours: Decimal;
//     //     soldecours: Decimal;
//     //     acquipreced: Decimal;
//     //     consomepreced: Decimal;
//     //     soldepreced: Decimal;
//     //     SoldeTotal: Decimal;
//     //     EmployeesdaysoffEntry: Record 52048895;
//     //     MoisCours: Integer;
//     //     MoisSolde: Text[30];
//     //     DateFin: Integer;
//     //     "// RB SORO EXPORT EXCEL": Integer;
//     //     PrintToExcel: Boolean;
//     //     ExcelBuf: Record 370 temporary;
//     //     Text001: Label 'Données';
//     //     Text002: Label 'Detail Mensuelle De Paie Enreg';
//     //     Text003: Label 'Nom de la société';
//     //     Text004: Label 'N° état';
//     //     Text005: Label 'Nom état';
//     //     Text006: Label 'Code utilisateur';
//     //     Text007: Label 'Date';
//     //     qualifications: Record 5202;
//     //     DescQuali: Text[30];
//     //     MoisFin: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
//     //     "Soldes_CongésCaptionLbl": Label 'Soldes Congés';
//     //     Affectation__CaptionLbl: Label 'Affectation :';
//     //     MoisCaptionLbl: Label 'Mois';
//     //     SoldeCaptionLbl: Label 'Solde';
//     //     SoldeCaption_Control1000000008Lbl: Label 'Solde';
//     //     "ConsommésCaptionLbl": Label 'Consommés';
//     //     AcquisCaptionLbl: Label 'Acquis';
//     //     SoldeCaption_Control1000000018Lbl: Label 'Solde';
//     //     "ConsommésCaption_Control1000000023Lbl": Label 'Consommés';
//     //     AcquisCaption_Control1000000024Lbl: Label 'Acquis';
//     //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
//     //     MatriculeCaptionLbl: Label 'Matricule';

//     // // [Scope('Internal')]
//     // procedure MakeExcelInfo()
//     // begin
//     //     ExcelBuf.SetUseInfoSheet;
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, TRUE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, TRUE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddInfoColumn(REPORT::"Solde Pret", FALSE, FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', 0);
//     //     //ExcelBuf.NewRow;
//     //     ExcelBuf.ClearNewRow;
//     //     MakeExcelDataHeader;
//     // end;

//     // local procedure MakeExcelDataHeader()
//     // begin
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddColumn('N°', FALSE, '', TRUE, FALSE, TRUE, '', 0);
//     //     ExcelBuf.AddColumn('Nom & Prenom', FALSE, '', TRUE, FALSE, TRUE, '', 0);
//     //     ExcelBuf.AddColumn('Qualification', FALSE, '', TRUE, FALSE, TRUE, '', 0);
//     //     ExcelBuf.AddColumn('Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
//     //     ExcelBuf.AddColumn('Solde', FALSE, '', TRUE, FALSE, TRUE, '', 0);
//     // end;

//     // // [Scope('Internal')]
//     // procedure MakeExcelDataBody()
//     // begin
//     //     ExcelBuf.NewRow;
//     //     ExcelBuf.AddColumn(Employee."No.", FALSE, '', FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddColumn(Employee."First Name", FALSE, '', FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddColumn(DescQuali, FALSE, '', FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddColumn(Employee."Deccription Affectation", FALSE, '', FALSE, FALSE, FALSE, '', 0);
//     //     ExcelBuf.AddColumn(SoldeTotal, FALSE, '', FALSE, FALSE, FALSE, '', 0);
//     // end;

//     // // [Scope('Internal')]
//     // procedure CreateExcelbook()
//     // begin
//     //     // ExcelBuf.CreateBook('Solde CongÚs');
//     //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
//     //     // ExcelBuf.GiveUserControl;
//     //     ERROR('');
//     // end;
// }

