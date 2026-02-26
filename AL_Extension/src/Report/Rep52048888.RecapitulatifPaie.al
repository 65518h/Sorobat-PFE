report 52048888 "Recapitulatif Paie"
{
    // //GL2024  ID dans Nav 2009 : "39001415"
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapitulatifPaie.rdlc';

    // dataset
    // {
    //     dataitem("Salary Lines"; 52048897)
    //     {
    //         DataItemTableView = SORTING(Affectation);
    //         RequestFilterFields = Month, Year, Affectation;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(FORMAT_Month_; FORMAT(Month))
    //         {
    //         }
    //         column(Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //         {
    //         }
    //         column(Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(Compteur; Compteur)
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(TotalCount; TotalCount)
    //         {
    //         }
    //         column(Salary_Lines__Net_salary_cashed__Control1000000011; "Net salary cashed")
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Recapitulatif_PaieCaption; Recapitulatif_PaieCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(Mois__Caption; Mois__CaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(NombreCaption; NombreCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(Total__Caption; Total__CaptionLbl)
    //         {
    //         }
    //         column(Salary_Lines_No_; "No.")
    //         {
    //         }
    //         column(Salary_Lines_Employee; Employee)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF CompanyInformation.GET THEN;
    //             IF RecAffectation.GET(Affectation) THEN;
    //             Affect := RecAffectation.Decription;

    //             Compteur := Compteur + 1;
    //             TotalCount := TotalCount + 1;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Affectation);
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

    // var
    //     RecAffectation: Record 52048917;
    //     RecSalaryLines: Record 52048897;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     Compteur: Integer;
    //     TotalCount: Integer;
    //     Affect: Text[30];
    //     CompanyInformation: Record 79;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Recapitulatif_PaieCaptionLbl: Label 'Recapitulatif Paie';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     Mois__CaptionLbl: Label 'Mois :';
    //     "Année__CaptionLbl": Label 'Année :';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     NombreCaptionLbl: Label 'Nombre';
    //     MontantCaptionLbl: Label 'Montant';
    //     Total__CaptionLbl: Label 'Total =';
}