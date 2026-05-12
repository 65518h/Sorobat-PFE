report 50267 "Recap Rappel"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/RecapRappel.rdlc';
    // UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = all;
    // Caption = 'Recap Rappel';

    // dataset
    // {
    //     dataitem("Rappel Enregistre"; 52048925)
    //     {
    //         DataItemTableView = SORTING("Affectation", "Annee Rappel", "Employee No.");
    //         RequestFilterFields = Affectation, "Annee Rappel", "Blocké", Paye;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column("RECAP_Rappel_Augmentation_de_Salaire_Année______FORMAT__Annee_Rappel__"; 'RECAP Rappel Augmentation de Salaire Année :  ' + FORMAT("Annee Rappel"))
    //         {
    //         }
    //         column(du___FORMAT__Mois_Debut_______FORMAT__Annee_Debut_____au___FORMAT__Mois_Fin_______FORMAT__Annee_Fin__; 'du ' + FORMAT("Mois Debut") + ' ' + FORMAT("Annee Debut") + ' au ' + FORMAT("Mois Fin") + ' ' + FORMAT("Annee Fin"))
    //         {
    //         }
    //         column(Statut; Statut)
    //         {
    //         }
    //         column(Company_Address; Company.Address)
    //         {
    //         }
    //         column(Company_Name; Company.Name)
    //         {
    //         }
    //         column(Rappel_Enregistre__Montant_Rappel_; "Montant Rappel")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Rappel_Enregistre_Affectation; Affectation)
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(Total; Total)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(NbreTotal; NbreTotal)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(NbreCaption; NbreCaptionLbl)
    //         {
    //         }
    //         column(TOTAL__Caption; TOTAL__CaptionLbl)
    //         {
    //         }
    //         column(Nbre__Caption; Nbre__CaptionLbl)
    //         {
    //         }
    //         column(Rappel_Enregistre_Annee_Rappel; "Annee Rappel")
    //         {
    //         }
    //         column(Rappel_Enregistre_Employee_No_; "Employee No.")
    //         {
    //         }
    //         column(TotalRappel_; TotalRappel)
    //         {
    //         }

    //         trigger OnAfterGetRecord()



    //         begin


    //             IF GETFILTER("Rappel Enregistre".Blocké) = 'Oui' THEN Statut := 'Salarié Inactif';
    //             IF GETFILTER("Rappel Enregistre".Blocké) = 'Non' THEN Statut := 'Salarié Actif';
    //             IF Company.GET THEN;



    //             IF RecQualification.GET("Rappel Enregistre".Qualification) THEN Qualif := RecQualification.Description;
    //             NbreTotal := NbreTotal + 1;
    //             Total := Total + "Rappel Enregistre"."Montant Rappel";

    //             IF RecAffectation.GET("Rappel Enregistre".Affectation) THEN begin
    //                 Affect := RecAffectation.Decription;

    //             end;
    //             //GL2024
    //             if "Rappel Enregistre".Affectation <> LastAffectation then begin
    //                 // Rupture : la valeur a changé
    //                 Nbre := 0;
    //                 TotalRappel := 0;
    //                 LastAffectation := "Rappel Enregistre".Affectation;
    //             end;
    //             //GL2024
    //             Nbre := Nbre + 1;
    //             TotalRappel := TotalRappel + "Rappel Enregistre"."Montant Rappel";

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             Total := 0;
    //             TotalRappel := 0;
    //             Nbre := 0;
    //             NbreTotal := 0;
    //             LastFieldNo := FIELDNO("Annee Rappel");
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
    //     TotalRappel: Decimal;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     RecAffectation: Record 52048917;
    //     Affect: Text[150];
    //     RecQualification: Record 5202;
    //     Qualif: Text[150];
    //     Total: Decimal;
    //     Nbre: Integer;
    //     NbreTotal: Integer;
    //     Statut: Text[30];
    //     Company: Record 79;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     MontantCaptionLbl: Label 'Montant';
    //     NbreCaptionLbl: Label 'Nbre';
    //     TOTAL__CaptionLbl: Label 'TOTAL :';
    //     Nbre__CaptionLbl: Label 'Nbre :';
    //     LastAffectation: code[20];
}

