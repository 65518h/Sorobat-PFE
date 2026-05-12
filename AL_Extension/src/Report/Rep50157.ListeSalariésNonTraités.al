report 50157 "Liste Salariés Non Traités"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListeSalariésNonTraités.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         RequestFilterFields = Month, Year;
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Qualification; Qualification)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_NameCaption; FIELDCAPTION(Name))
    //         {
    //         }
    //         column(Rec__Salary_Lines_AffectationCaption; FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column(Rec__Salary_Lines_QualificationCaption; FIELDCAPTION(Qualification))
    //         {
    //         }
    //         column("Liste_des_Salariés_Non_TraitésCaption"; Liste_des_Salariés_Non_TraitésCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }

    //         trigger OnPreDataItem()
    //         begin

    //             //MESSAGE('vous avez selectionner le mois %1',FilterMois);
    //             FilterMois := "Rec. Salary Lines".GETFILTER("Rec. Salary Lines".Month);
    //             //IF PrintToExcel THEN
    //             //  MakeExcelInfo;
    //         end;

    //         trigger OnAfterGetRecord()
    //         Begin

    //             IF RecEmployee.GET(Employee) THEN
    //                 IF RecEmployee.Blocked THEN CurrReport.Skip();
    //             RecSalaryLines.RESET;
    //             RecSalaryLines.SETFILTER("No.", '<>%1', 'SIMULATION');
    //             RecSalaryLines.SETRANGE(Employee, Employee);
    //             IF RecSalaryLines.FINDFIRST THEN BEGIN
    //                 comp2 += 1;
    //                 CurrReport.Skip();
    //             END
    //             ELSE BEGIN
    //                 IF PrintToExcel THEN BEGIN
    //                     MakeExcelDataBody;
    //                 END;
    //                 Compt += 1;
    //             END;
    //         End;
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
    //     // IF PrintToExcel THEN
    //     // CreateExcelbook;

    //     MESSAGE('Vous avez %1 Salariés Non Traités et %2 salarie traites ', Compt, comp2);
    // end;

    // var
    //     FilterAnnee: Integer;
    //     FilterMois: Text[30];
    //     RecSalaryLines: Record 52048897;
    //     Text001: Label 'Erreur, Vous devez renseigner les champs Année et Mois!!!';
    //     Compt: Integer;
    //     comptttt: Integer;
    //     PageConst: Label 'Page';
    //     CompanyInformation: Record 79;
    //     comp2: Integer;
    //     RecEmployee: Record 5200;
    //     "// RB SORO EXPORT EXCEL": Integer;
    //     PrintToExcel: Boolean;
    //     ExcelBuf: Record 370 temporary;
    //     Text002: Label 'Liste  Salariés  Non Traités';
    //     Text003: Label 'Nom de la société';
    //     Text004: Label 'N° état';
    //     Text005: Label 'Nom état';
    //     Text006: Label 'Code utilisateur';
    //     Text007: Label 'Date';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Liste_des_Salariés_Non_TraitésCaptionLbl": Label 'Liste des Salariés Non Traités';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';

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
    //     ExcelBuf.AddInfoColumn(REPORT::"Mouvement Articles", FALSE, FALSE, FALSE, FALSE, '', 0);
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
    //     ExcelBuf.AddColumn('NOM', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Affectation', FALSE, '', TRUE, FALSE, TRUE, '', 0);
    //     ExcelBuf.AddColumn('Qualification', FALSE, '', TRUE, FALSE, TRUE, '', 0);
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
    //     ExcelBuf.NewRow;
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Employee, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Name, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Affectation, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    //     ExcelBuf.AddColumn("Rec. Salary Lines".Qualification, FALSE, '', FALSE, FALSE, FALSE, '', 0);
    // end;

    // // [Scope('Internal')]
    // procedure CreateExcelbook()
    // begin
    //     // ExcelBuf.CreateBook('Liste SalariÚs Non TraitÚs');
    //     //GL2024 ExcelBuf.CreateSheet(Text002,Text003,COMPANYNAME,USERID);
    //     // ExcelBuf.GiveUserControl;
    //     ERROR('');
    // end;
}

