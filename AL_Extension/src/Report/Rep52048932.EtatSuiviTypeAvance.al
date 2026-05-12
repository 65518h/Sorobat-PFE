report 52048932 "Etat Suivi Type Avance"
{
    // //Id Nav 39001418
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatSuiviTypeAvance.rdl';

    // dataset
    // {
    //     dataitem("Loan & Advance Header"; "Loan & Advance Header")
    //     {
    //         DataItemTableView = SORTING("Pret CNSS")
    //                             WHERE(Type = CONST(Advance));
    //         PrintOnlyIfDetail = true;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         /*    column(CurrReport_PAGENO; CurrReport.PAGENO)
    //              {
    //              }*/
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(Annee; Annee)
    //         {
    //         }
    //         column(Mois; Mois)
    //         {
    //         }
    //         column(Somme; Somme)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Loan___Advance_HeaderCaption; Loan___Advance_HeaderCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Mois_du__Caption; Mois_du__CaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(Nom_Et_PrenomCaption; Nom_Et_PrenomCaptionLbl)
    //         {
    //         }
    //         column(AffCaption; AffCaptionLbl)
    //         {
    //         }
    //         column(Description_AffCaption; Description_AffCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(Loan___Advance_Header_No_; "No.")
    //         {
    //         }
    //         column(Loan___Advance_Header_Pret_CNSS; "Pret CNSS")
    //         {
    //         }
    //         dataitem("Loan & Advance Lines"; "Loan & Advance Lines")
    //         {
    //             DataItemLink = "No." = FIELD("No.");
    //             DataItemTableView = SORTING(Year, Month);
    //             column(Loan___Advance_Lines_Employee; Employee)
    //             {
    //             }
    //             column(Loan___Advance_Lines__Line_Amount_; "Line Amount")
    //             {
    //             }
    //             column(Loan___Advance_Lines_section; section)
    //             {
    //             }
    //             column(RecEmployee__First_Name_; RecEmployee."First Name")
    //             {
    //             }
    //             column(RecSection_Decription; RecSection.Decription)
    //             {
    //             }
    //             column(Loan___Advance_Lines_No_; "No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Entry_No_; "Entry No.")
    //             {
    //             }
    //             column(Loan___Advance_Lines_Year; Year)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             begin

    //                 IF RecEmployee.GET(Employee) THEN;
    //                 IF RecSection.GET(section) THEN;
    //                 Somme += "Line Amount";
    //                 // RB SORO 06/04/2015
    //                 IF PrintToExcel THEN BEGIN
    //                     //       MakeExcelDataBody;
    //                 END;
    //                 // RB SORO 06/04/2015
    //             end;

    //             trigger OnPreDataItem()
    //             begin
    //                 IF Annee <> 0 THEN SETRANGE(Year, Annee);
    //                 SETRANGE(Month, Mois);
    //                 CurrReport.CREATETOTALS("Line Amount");
    //             end;
    //         }
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Group)
    //             {
    //                 Caption = 'Parameters';
    //                 field(Annee; Annee)
    //                 {
    //                     Caption = 'Année :';
    //                 }
    //                 field(Mois; Mois)
    //                 {
    //                     Caption = 'Mois :';
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





    // var
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     RecEmployee: Record 5200;
    //     RecSection: Record Section;
    //     TypePret: Text[30];
    //     Mois: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
    //     Annee: Integer;
    //     Somme: Decimal;
    //     "// RB SORO EXPORT EXCEL": Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Text001: Label 'Data';
    //     Text002: Label 'Customer/Item Sales';
    //     Text003: Label 'Company Name';
    //     Text004: Label 'Report No.';
    //     Text005: Label 'Report Name';
    //     Text006: Label 'User ID';
    //     Text007: Label 'Date';
    //     "N° Bon Caisse": Text[30];
    //     Loan___Advance_HeaderCaptionLbl: Label 'Loan & Advance Header';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Mois_du__CaptionLbl: Label 'Mois du :';
    //     "Année__CaptionLbl": Label 'Année :';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     Nom_Et_PrenomCaptionLbl: Label 'Nom Et Prenom';
    //     AffCaptionLbl: Label 'Aff';
    //     Description_AffCaptionLbl: Label 'Description Aff';
    //     MontantCaptionLbl: Label 'Montant';

    // //[Scope('Internal')]
    // /*  procedure MakeExcelInfo()
    //   begin
    //       ExcelBuf.SetUseInfoSheet;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text003), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(FORMAT(Text002), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text004), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(REPORT::"Mouvement Articles", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(USERID, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, '', TRUE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddInfoColumn(TODAY, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       //ExcelBuf.NewRow;
    //       ExcelBuf.ClearNewRow;
    //       MakeExcelDataHeader;
    //   end;

    //   local procedure MakeExcelDataHeader()
    //   begin
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddColumn('Mois', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Année', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Code Salarié', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Nom Salarié', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Code Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //       ExcelBuf.AddColumn('Montant', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //   end;

    //   [Scope('Internal')]
    //   procedure MakeExcelDataBody()
    //   begin
    //       ExcelBuf.NewRow;
    //       ExcelBuf.AddColumn(FORMAT(Mois), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn(Annee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn(FORMAT("Loan & Advance Lines".Employee), FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn(RecEmployee."First Name", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn("Loan & Advance Lines".section, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn(RecSection.Decription, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //       ExcelBuf.AddColumn("Loan & Advance Lines"."Line Amount", FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //   end;

    //   [Scope('Internal')]
    //   procedure CreateExcelbook()
    //   begin
    //       ExcelBuf.CreateBook('Etat Suivi Type Avance');
    //       //GL2024 ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
    //       ExcelBuf.GiveUserControl;
    //       ERROR('');
    //   end;*/
}

