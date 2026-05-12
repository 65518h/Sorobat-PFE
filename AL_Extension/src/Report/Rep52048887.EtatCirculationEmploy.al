report 52048887 "Etat Annexe IUTS"
//GL2024  ID dans Nav 2009 : "39001414"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatCirculationEmployé.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         DataItemTableView = SORTING(Employee, Year, Month, "Type Prime");
    //         RequestFilterFields = Employee, Year;
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year; Year)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Qualification; Qualification)
    //         {
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Month; Month)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year_Control1000000021; Year)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Basis_hours_; "Basis hours")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Affectation; Affectation)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Paied_days_; "Paied days")
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Paied_days__Control1000000040; "Paied days")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Basis_hours__Control1000000039; "Basis hours")
    //         {
    //         }
    //         column("Etat_de_Circulation_employéCaption"; Etat_de_Circulation_employéCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_MonthCaption; FIELDCAPTION(Month))
    //         {
    //         }
    //         column(Rec__Salary_Lines_Year_Control1000000021Caption; FIELDCAPTION(Year))
    //         {
    //         }
    //         column(Nb__Hrs_Caption; Nb__Hrs_CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_AffectationCaption; FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column("PrésenceCaption"; PrésenceCaptionLbl)
    //         {
    //         }
    //         column("Salarié__Caption"; Salarié__CaptionLbl)
    //         {
    //         }
    //         column(Total__Caption; Total__CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_No_; "No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF RecAffectation.GET(section) THEN;
    //             Affect := RecAffectation.Decription;
    //             //RecQualification.GET(Qualification);
    //             //Qualif := RecQualification.Description;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO(Year);
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
    //     PageConst: Label 'Page';
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     RecQualification: Record 5202;
    //     RecAffectation: Record 52048917;
    //     Affect: Text[30];
    //     Qualif: Text[30];
    //     "Etat_de_Circulation_employéCaptionLbl": Label 'Etat de Circulation employé';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     "Année__CaptionLbl": Label 'Année :';
    //     Nb__Hrs_CaptionLbl: Label 'Nb. Hrs.';
    //     "PrésenceCaptionLbl": Label 'Présence';
    //     "Salarié__CaptionLbl": Label 'Salarié :';
    //     Total__CaptionLbl: Label 'Total =';
}

