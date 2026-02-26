report 52048889 "Liste Personnels non traités"
{
    // //GL2024  ID dans Nav 2009 : "39001416"
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListePersonnelsnontraités.rdlc';

    // dataset
    // {
    //     dataitem(Employee; 5200)
    //     {
    //         DataItemTableView = SORTING("No.")
    //                             WHERE(Blocked = FILTER('No'));
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(FORMAT_Mois_; FORMAT(Mois))
    //         {
    //         }
    //         column(Annee; Annee)
    //         {
    //         }
    //         column(Employee__No__; "No.")
    //         {
    //         }
    //         column(Employee__First_Name_; "First Name")
    //         {
    //         }
    //         column(Employee_Affectation; Affectation)
    //         {
    //         }
    //         column(Employee_Qualification; Qualification)
    //         {
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column("Liste_Des_Personnels_non_traitésCaption"; Liste_Des_Personnels_non_traitésCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(Mois__Caption; Mois__CaptionLbl)
    //         {
    //         }
    //         column("Année__Caption"; Année__CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(Employee_AffectationCaption; FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column(Employee_QualificationCaption; FIELDCAPTION(Qualification))
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF RecAffectation.GET(Affectation) THEN;
    //             Affect := RecAffectation.Decription;
    //             IF RecQualification.GET(Qualification) THEN;
    //             Qualif := RecQualification.Description;

    //             RecSalaryLines.SETRANGE(Employee, "No.");
    //             RecSalaryLines.SETRANGE(Month, Mois);
    //             RecSalaryLines.SETRANGE(Year, Annee);

    //             SalaryLines.SETRANGE(Employee, "No.");
    //             SalaryLines.SETRANGE(Month, Mois);
    //             SalaryLines.SETRANGE(Year, Annee);

    //             //IF  (RecSalaryLines.FINDFIRST) OR(SalaryLines.FINDFIRST) THEN CurrReport.SHOWOUTPUT(FALSE);
    //             IF (SalaryLines.FINDFIRST) THEN CurrReport.SHOWOUTPUT(FALSE);
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
    //         {
    //             field(Mois; Mois)
    //             {
    //                 Caption = 'Mois :';
    //                 ToolTip = 'Sélectionner le mois';
    //             }
    //             field(Annee; Annee)
    //             {
    //                 Caption = 'Année :';
    //                 ToolTip = 'Sélectionner l année';
    //             }
    //         }
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
    //     // MESSAGE('le mois est %1 et l annee est %2',Mois,Annee);
    // end;

    // var
    //     PageConst: Label 'Page';
    //     Mois: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
    //     Annee: Integer;
    //     RecSalaryLines: Record 52048901;
    //     SalaryLines: Record 52048897;
    //     RecAffectation: Record 52048917;
    //     Affect: Text[30];
    //     RecQualification: Record 5202;
    //     Qualif: Text[30];
    //     date: Date;
    //     Afficher: Boolean;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     "Liste_Des_Personnels_non_traitésCaptionLbl": Label 'Liste Des Personnels non traités';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     Mois__CaptionLbl: Label 'Mois :';
    //     "Année__CaptionLbl": Label 'Année :';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
}

