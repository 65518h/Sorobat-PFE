report 50258 "Fiche Création Nouv Salarié"
{
    // //   //
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/FicheCréationNouvSalarié.rdlc';


    // dataset
    // {
    //     dataitem(Employee; 5200)
    //     {
    //         RequestFilterFields = "No.";
    //         column(Employee__First_Name_; "First Name")
    //         {
    //         }
    //         column(Employee__No__; "No.")
    //         {
    //         }
    //         column(Employee__Employment_Date_; "Employment Date")
    //         {
    //         }
    //         column(Employee__Deccription_Affectation_; "Deccription Affectation")
    //         {
    //         }
    //         column("Employee_Collège"; Collège)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(USERID; USERID)
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(Employee__Date_Creation_; "Date Creation")
    //         {
    //         }
    //         column("Créateur"; Créateur)
    //         {
    //         }
    //         column(SalaireBase; SalaireBase)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Employee__Salaire_Net_Simulé_"; "Salaire Net Simulé")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(SalaireBrut; SalaireBrut)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column("Fiche_Création_du_Nouveau_Salarié_sur_le_SystèmeCaption"; Fiche_Création_du_Nouveau_Salarié_sur_le_SystèmeCaptionLbl)
    //         {
    //         }
    //         column(Employee__First_Name_Caption; FIELDCAPTION("First Name"))
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(Date_de_RecrutementCaption; Date_de_RecrutementCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column("CatégorieCaption"; CatégorieCaptionLbl)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Date_CreationCaption; Date_CreationCaptionLbl)
    //         {
    //         }
    //         column("Crée_parCaption"; Crée_parCaptionLbl)
    //         {
    //         }
    //         column(SignatureCaption; SignatureCaptionLbl)
    //         {
    //         }
    //         column(Wannes_ZakraouiCaption; Wannes_ZakraouiCaptionLbl)
    //         {
    //         }
    //         column(Salaire_de_BaseCaption; Salaire_de_BaseCaptionLbl)
    //         {
    //         }
    //         column(Salaire_NetCaption; Salaire_NetCaptionLbl)
    //         {
    //         }
    //         column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
    //         {
    //         }
    //         column("Validé_par____Wannes_ZakraouiCaption"; Validé_par____Wannes_ZakraouiCaptionLbl)
    //         {
    //         }
    //         column(Direction_AdministrativeCaption; Direction_AdministrativeCaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             RecContrat.RESET;
    //             IF RecContrat.GET("No.") THEN Créateur := RecContrat."User ID";

    //             IF Employee."Employee's type" = 0 THEN BEGIN
    //                 SalaireBase := Employee."Salaire De Base Horaire";
    //                 Employee.CALCFIELDS("Total Indemnité Par Defaut");
    //                 SalaireBrut := "Total Indemnité Par Defaut" + SalaireBase;
    //             END
    //             ELSE BEGIN
    //                 SalaireBase := Employee."Basis salary";
    //                 Employee.CALCFIELDS("Total Indemnité Par Defaut");
    //                 SalaireBrut := "Total Indemnité Par Defaut" + "Basis salary";
    //             END;
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
    //     RecContrat: Record 5211;
    //     "Créateur": Code[20];
    //     SalaireBrut: Decimal;
    //     SalaireBase: Decimal;
    //     "Fiche_Création_du_Nouveau_Salarié_sur_le_SystèmeCaptionLbl": Label 'Fiche Création du Nouveau Salarié sur le Système';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     Date_de_RecrutementCaptionLbl: Label 'Date de Recrutement';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     "CatégorieCaptionLbl": Label 'Catégorie';
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Date_CreationCaptionLbl: Label 'Date Creation';
    //     "Crée_parCaptionLbl": Label 'Crée par';
    //     SignatureCaptionLbl: Label 'Signature';
    //     Wannes_ZakraouiCaptionLbl: Label 'Wannes Zakraoui';
    //     Salaire_de_BaseCaptionLbl: Label 'Salaire de Base';
    //     Salaire_NetCaptionLbl: Label 'Salaire Net';
    //     Salaire_BrutCaptionLbl: Label 'Salaire Brut';
    //     "Validé_par____Wannes_ZakraouiCaptionLbl": Label 'Validé par :  Wannes Zakraoui';
    //     Direction_AdministrativeCaptionLbl: Label 'Direction Administrative';
}