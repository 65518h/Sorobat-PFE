report 52048921 "Liste Personnels Partant"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListePersonnelsPartant.rdlc';

    // dataset
    // {
    //     dataitem(Employee; 5200)
    //     {
    //         DataItemTableView = SORTING("No.");
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(DateDep; DateDep)
    //         {
    //         }
    //         column(DateRec; DateRec)
    //         {
    //         }
    //         column(Employee__No__; "No.")
    //         {
    //         }
    //         column(Employee__First_Name_; "First Name")
    //         {
    //         }
    //         column(Employee__Birth_Date_; "Birth Date")
    //         {
    //         }
    //         column(Employee__Employment_Date_; "Employment Date")
    //         {
    //         }
    //         column(Employee__Inactive_Date_; "Inactive Date")
    //         {
    //         }
    //         column(Employee__N__CIN_; "N° CIN")
    //         {
    //         }
    //         column(Employee__Nombre_Enfant_; "Nombre Enfant")
    //         {
    //         }
    //         column(Employee_Affectation; Affectation)
    //         {
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column("Employee_Collège"; Collège)
    //         {
    //         }
    //         column(Employee__Social_Security_No__; "Social Security No.")
    //         {
    //         }
    //         column(Liste_du_Personnels_PartantCaption; Liste_du_Personnels_PartantCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column("Période_du__Caption"; Période_du__CaptionLbl)
    //         {
    //         }
    //         column(Au__Caption; Au__CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(NaissanceCaption; NaissanceCaptionLbl)
    //         {
    //         }
    //         column(Date_Recrut_Caption; Date_Recrut_CaptionLbl)
    //         {
    //         }
    //         column(Date_DepartCaption; Date_DepartCaptionLbl)
    //         {
    //         }
    //         column(Employee__N__CIN_Caption; FIELDCAPTION("N° CIN"))
    //         {
    //         }
    //         column(Sit__Fam_Caption; Sit__Fam_CaptionLbl)
    //         {
    //         }
    //         column(Employee_AffectationCaption; FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column(QualifCaption; QualifCaptionLbl)
    //         {
    //         }
    //         column("CatégorieCaption"; CatégorieCaptionLbl)
    //         {
    //         }
    //         column(N__CNSSCaption; N__CNSSCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             Employee.SETFILTER("Inactive Date", '>=%1&<=%2', DateRec, DateDep);
    //             IF RecQualification.GET(Qualification) THEN;
    //             Qualif := RecQualification.Description;
    //         end;
    //     }
    // }

    // requestpage
    // {

    //     layout
    //     {
    //         area(content)
    //         {
    //             group(options)
    //             {
    //                 field(DateRec; DateRec)
    //                 {
    //                     Caption = 'Date Recrut.';
    //                     ApplicationArea = All;
    //                 }
    //                 field(DateDep; DateDep)
    //                 {
    //                     Caption = 'Date Depart';
    //                     ApplicationArea = All;
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
    //     PageConst: Label 'Page';
    //     RecQualification: Record 5202;
    //     Qualif: Text[100];
    //     DateRec: Date;
    //     DateDep: Date;
    //     Liste_du_Personnels_PartantCaptionLbl: Label 'Liste du Personnels Partant';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     "Période_du__CaptionLbl": Label 'Période du :';
    //     Au__CaptionLbl: Label 'Au :';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     NaissanceCaptionLbl: Label 'Naissance';
    //     Date_Recrut_CaptionLbl: Label 'Date Recrut.';
    //     Date_DepartCaptionLbl: Label 'Date Depart';
    //     Sit__Fam_CaptionLbl: Label 'Sit. Fam.';
    //     QualifCaptionLbl: Label 'Label1000000034';
    //     "CatégorieCaptionLbl": Label 'Catégorie';
    //     N__CNSSCaptionLbl: Label 'N° CNSS';
}

