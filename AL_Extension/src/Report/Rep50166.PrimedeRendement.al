report 50166 "Prime de Rendement"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/PrimedeRendement.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         DataItemTableView = SORTING(Affectation, Month, Year, Employee)
    //                             ORDER(Ascending)
    //                             WHERE(Month = FILTER(<> Rappel),
    //                                   Month = CONST(Décembre));
    //         RequestFilterFields = Affectation, Year;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(COMPANYNAME; COMPANYNAME)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(DesignAffectation; DesignAffectation)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(Note___FORMAT_Year_1_; 'Note ' + FORMAT(Year - 1))
    //         {
    //         }
    //         column(Note___FORMAT_Year_; 'Note ' + FORMAT(Year))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(DesignAffectation_Control1000000021; DesignAffectation)
    //         {
    //         }
    //         column(Designqualification; Designqualification)
    //         {
    //         }
    //         column(daterecrutelment; daterecrutelment)
    //         {
    //         }
    //         column(NotePrecedent; NotePrecedent)
    //         {
    //         }
    //         column("Ancienneté"; Ancienneté)
    //         {
    //         }
    //         column(NbreFiche; NbreFiche)
    //         {
    //         }
    //         column(Nbresalarie; Nbresalarie)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Service_PersonnelsCaption; Service_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(PRIME_DE_RENDEMENTCaption; PRIME_DE_RENDEMENTCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(A_l_attention_de_Mr_Caption; A_l_attention_de_Mr_CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom___PrénomCaption"; Nom___PrénomCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(QualificationCaption; QualificationCaptionLbl)
    //         {
    //         }
    //         column(Date_Recrut_Caption; Date_Recrut_CaptionLbl)
    //         {
    //         }
    //         column("Décision_D_G_Caption"; Décision_D_G_CaptionLbl)
    //         {
    //         }
    //         column("AnciènetéCaption"; AnciènetéCaptionLbl)
    //         {
    //         }
    //         column(Nbre_FicheCaption; Nbre_FicheCaptionLbl)
    //         {
    //         }
    //         column(Nbre__Caption; Nbre__CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             RecAffectation.RESET();
    //             RecAffectation.SETRANGE(RecAffectation.Section, "Rec. Salary Lines".Affectation);
    //             IF RecAffectation.FINDFIRST THEN
    //                 DesignAffectation := RecAffectation.Decription;

    //             /*Salarie.RESET();
    //             Salarie.SETRANGE(Salarie."No.","Rec. Salary Lines".Employee);
    //             IF Salarie.FINDFIRST THEN
    //             BEGIN
    //               //*********************************************
    //               RecQualificat.RESET();
    //               RecQualificat.SETRANGE(RecQualificat.Code,Salarie.Qualification);
    //               IF RecQualificat.FINDFIRST() THEN Designqualification:=RecQualificat.Description;
    //              END;*/
    //             //*************************************************
    //             Salarie.RESET();
    //             Salarie.SETRANGE(Salarie."No.", "Rec. Salary Lines".Employee);
    //             IF Salarie.FINDFIRST THEN BEGIN
    //                 daterecrutelment := Salarie."Employment Date";
    //                 //*********************Nbre Fiche
    //                 RecSalaryLines.RESET();
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Employee, "Rec. Salary Lines".Employee);
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Year, "Rec. Salary Lines".Year);
    //                 NbreFiche := 0;
    //                 IF RecSalaryLines.FINDFIRST() THEN
    //                     REPEAT
    //                         IF RecSalaryLines.Month <> RecSalaryLines.Month::Rappel THEN
    //                             NbreFiche := NbreFiche + 1;
    //                     UNTIL RecSalaryLines.NEXT = 0;




    //                 //************Anciente**************

    //                 IF FORMAT(Salarie."Employment Date") <> '' THEN BEGIN
    //                     //DateRefAnciennete:=DMY2DATE(25,"Rec. Salary Lines".Month+1,"Rec. Salary Lines".Year)+1;
    //                     DateRefAnciennete := DMY2DATE(31, 12, "Rec. Salary Lines".Year);
    //                     IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté("No.", DateRefAnciennete);
    //                     NewDate := CALCDATE(FORMAT(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
    //                     NbrJour := DateRefAnciennete - Salarie."Employment Date";
    //                     IntAnnéeAncienneté := NbrJour DIV 365;
    //                     IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
    //                     IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     Ancienneté := FORMAT(IntAnnéeAncienneté) + ' An(s), ' + FORMAT(IntMoisAncienneté) + ' Mois'
    //                     //+ FORMAT(IntAncienneteJour)+ ' Jours' ;
    //                 END;
    //                 //*********************************
    //                 RecQualificat.RESET();
    //                 RecQualificat.SETRANGE(RecQualificat.Code, Salarie.Qualification);
    //                 IF RecQualificat.FINDFIRST() THEN Designqualification := RecQualificat.Description;
    //             END;

    //             //*****************************************************
    //             // IF PrintToExcel THEN BEGIN
    //             //     MakeExcelDataBody;
    //             // END;

    //             RecAffectation.RESET();
    //             RecAffectation.SETRANGE(RecAffectation.Section, "Rec. Salary Lines".Affectation);
    //             IF RecAffectation.FINDFIRST THEN;
    //             DesignAffectation := RecAffectation.Decription;

    //             Nbresalarie := 0;

    //             NotePrecedent := 0;
    //             Ancienneté := '';
    //             NbreFiche := 0;
    //             RecAffectation.RESET();
    //             RecAffectation.SETRANGE(RecAffectation.Section, "Rec. Salary Lines".Affectation);
    //             IF RecAffectation.FINDFIRST THEN;
    //             DesignAffectation := RecAffectation.Decription;

    //             Salarie.RESET();
    //             Salarie.SETRANGE(Salarie."No.", "Rec. Salary Lines".Employee);
    //             IF Salarie.FINDFIRST THEN BEGIN
    //                 daterecrutelment := Salarie."Employment Date";
    //                 //*********************Nbre Fiche
    //                 RecSalaryLines.RESET();
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Employee, "Rec. Salary Lines".Employee);
    //                 RecSalaryLines.SETRANGE(RecSalaryLines.Year, "Rec. Salary Lines".Year);
    //                 IF RecSalaryLines.FINDFIRST() THEN
    //                     REPEAT
    //                         IF RecSalaryLines.Month <> RecSalaryLines.Month::Rappel THEN
    //                             NbreFiche := NbreFiche + 1;

    //                     UNTIL RecSalaryLines.NEXT = 0;
    //                 IF (DebutPeriode <> 0) AND (FinPeriode <> 0) THEN BEGIN
    //                     IF (NbreFiche < DebutPeriode) OR (NbreFiche > FinPeriode) THEN CurrReport.SHOWOUTPUT(FALSE);
    //                     IF Salarie.Blocked = TRUE THEN CurrReport.SHOWOUTPUT(FALSE);
    //                     IF (Salarie.Blocked = FALSE) AND (NbreFiche IN [DebutPeriode .. FinPeriode]) THEN Nbresalarie := Nbresalarie + 1;

    //                 END
    //                 ELSE BEGIN
    //                     IF NbreFiche < 12 THEN CurrReport.SHOWOUTPUT(FALSE);
    //                     IF Salarie.Blocked = TRUE THEN CurrReport.SHOWOUTPUT(FALSE);
    //                     IF (Salarie.Blocked = FALSE) AND (NbreFiche >= 12) THEN Nbresalarie := Nbresalarie + 1;

    //                 END;

    //                 //************Anciente**************

    //                 IF FORMAT(Salarie."Employment Date") <> '' THEN BEGIN
    //                     //DateRefAnciennete:=DMY2DATE(25,"Rec. Salary Lines".Month+1,"Rec. Salary Lines".Year)+1;
    //                     DateRefAnciennete := DMY2DATE(31, 12, "Rec. Salary Lines".Year);
    //                     IntMoisAncienneté := Managementofsalary.CalculerMoisAncienneté("No.", DateRefAnciennete);
    //                     NewDate := CALCDATE(FORMAT(((IntMoisAncienneté - IntAnnéeAncienneté * 12) - 1)) + 'M', Salarie."Employment Date");
    //                     NbrJour := DateRefAnciennete - Salarie."Employment Date";
    //                     IntAnnéeAncienneté := NbrJour DIV 365;
    //                     IntMoisAncienneté := (NbrJour - IntAnnéeAncienneté * 365) DIV 30;
    //                     IntAncienneteJour := NbrJour - IntAnnéeAncienneté * 365 - IntMoisAncienneté * 30;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     IF IntAncienneteJour < 0 THEN IntAncienneteJour := 0;
    //                     Ancienneté := FORMAT(IntAnnéeAncienneté) + ' An(s), ' + FORMAT(IntMoisAncienneté) + ' Mois'
    //                     //+ FORMAT(IntAncienneteJour)+ ' Jours' ;
    //                 END;
    //                 //*********************************
    //                 RecQualificat.RESET();
    //                 RecQualificat.SETRANGE(RecQualificat.Code, Salarie.Qualification);
    //                 IF RecQualificat.FINDFIRST() THEN Designqualification := RecQualificat.Description;
    //             END;

    //             Notes.RESET;
    //             Notes.SETRANGE(Notes.Matricule, "Rec. Salary Lines".Employee);
    //             Notes.SETRANGE(Notes.Année, "Rec. Salary Lines".Year - 1);
    //             IF Notes.FINDFIRST THEN NotePrecedent := Notes.Note;

    //             IF Ancienneté = '' THEN CurrReport.SHOWOUTPUT(FALSE);

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Affectation);
    //             //"Rec. Salary Lines".SETRANGE("Rec. Salary Lines".Month,11);
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(Content)
    //         {
    //             field(DebutPeriode; DebutPeriode)
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Enter the starting period for the report.';
    //             }
    //             field(FinPeriode; FinPeriode)
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Enter the ending period for the report.';
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
    //     // IF PrintToExcel THEN
    //     //     CreateExcelbook;
    // end;

    // trigger OnPreReport()
    // begin
    //     // IF PrintToExcel THEN
    //     //     MakeExcelInfo;
    // end;

    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Anneeprime: Integer;
    //     Affect: Text[30];
    //     RecAffectation: Record 52048917;
    //     DesignAffectation: Text[30];
    //     RecQualificat: Record 5202;
    //     Designqualification: Text[30];
    //     daterecrutelment: Date;
    //     Salarie: Record 5200;
    //     Datedif: Integer;
    //     Notes: Record 52048938;
    //     NotePrecedent: Decimal;
    //     Managementofsalary: Codeunit 39001402;
    //     "IntMoisAncienneté": Integer;
    //     "IntAnnéeAncienneté": Integer;
    //     "Ancienneté": Text[50];
    //     IntAncienneteJour: Integer;
    //     DateRefAnciennete: Date;
    //     NewDate: Date;
    //     NbrJour: Integer;
    //     Nbresalarie: Integer;
    //     RecSalaryLines: Record 52048901;
    //     NbreFiche: Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     PageConst: Label 'Page';
    //     TotalFor: Label 'Total ';
    //     Text001: Label 'Données';
    //     Text002: Label 'Etat des Prime';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     Item: Record 27;
    //     DebutPeriode: Integer;
    //     FinPeriode: Integer;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Service_PersonnelsCaptionLbl: Label 'Service Personnels';
    //     PRIME_DE_RENDEMENTCaptionLbl: Label 'PRIME DE RENDEMENT';
    //     "Année__CaptionLbl": Label 'Année :';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     A_l_attention_de_Mr_CaptionLbl: Label 'A l''attention de Mr.';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom___PrénomCaptionLbl": Label 'Nom & Prénom';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     QualificationCaptionLbl: Label 'Qualification';
    //     Date_Recrut_CaptionLbl: Label 'Date Recrut.';
    //     "Décision_D_G_CaptionLbl": Label 'Décision D.G.';
    //     "AnciènetéCaptionLbl": Label 'Ancièneté';
    //     Nbre_FicheCaptionLbl: Label 'Nbre Fiche';
    //     Nbre__CaptionLbl: Label 'Nbre :';

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
    //     ExcelBuf.AddColumn('Matricule', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nom et Prenon', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Qualification', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Date Recrut.', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Nbre Fiche', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Ancienté', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Salaire de Base', FALSE, '', TRUE, FALSE, TRUE, '', 0);
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
    //     /*IF Item.GET("Item Ledger Entry"."Item No.") THEN;
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn("Item Ledger Entry"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn("Item Ledger Entry".Quantity,FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn(Montant,FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn("Item Ledger Entry"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn("Item Ledger Entry"."N° Véhicule",FALSE,'',FALSE,FALSE,FALSE,'',0);
    //     ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',0); */
    //     NbreFiche := 0;
    //     //IF Item.GET("Sales Line"."No.") THEN;
    //     Salarie.RESET();
    //     Salarie.SETRANGE(Salarie."No.", "Rec. Salary Lines".Employee);
    //     IF Salarie.FINDFIRST THEN BEGIN

    //         RecSalaryLines.RESET();
    //         RecSalaryLines.SETRANGE(RecSalaryLines.Employee, "Rec. Salary Lines".Employee);
    //         RecSalaryLines.SETRANGE(RecSalaryLines.Year, "Rec. Salary Lines".Year);
    //         IF RecSalaryLines.FINDFIRST() THEN
    //             REPEAT
    //                 NbreFiche := NbreFiche + 1;


    //             UNTIL RecSalaryLines.NEXT = 0;
    //         IF (Salarie.Blocked = FALSE) AND (NbreFiche >= 12) THEN BEGIN
    //             ExcelBuf.NewRow;
    //             ExcelBuf.AddColumn("Rec. Salary Lines".Employee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //             ExcelBuf.AddColumn("Rec. Salary Lines".Name, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //         END;
    //     END;
    //     ExcelBuf.AddColumn(DesignAffectation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Designqualification, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(daterecrutelment, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(NbreFiche, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn(Ancienneté, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines"."Basis salary", FALSE, '', FALSE, FALSE, FALSE, '', 0);

    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('Prime de Rendement');
    //     //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;
}

