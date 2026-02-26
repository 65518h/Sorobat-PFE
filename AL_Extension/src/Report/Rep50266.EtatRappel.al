report 50266 "Etat Rappel"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/EtatRappel.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'Etat Rappel';

    // dataset
    // {
    //     dataitem("Rappel Enregistre"; 52048925)
    //     {
    //         DataItemTableView = SORTING(Affectation);
    //         RequestFilterFields = Affectation, "Annee Rappel", "Blocké", Paye;
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CurrReport_PAGENO; CurrReport.PAGENO)
    //         {
    //         }
    //         column(du___FORMAT__Mois_Debut_______FORMAT__Annee_Debut_____au___FORMAT__Mois_Fin_______FORMAT__Annee_Fin__; 'du ' + FORMAT("Mois Debut") + ' ' + FORMAT("Annee Debut") + ' au ' + FORMAT("Mois Fin") + ' ' + FORMAT("Annee Fin"))
    //         {
    //         }
    //         column("Rappel_Augmentation_de_Salaire__Année______FORMAT__Annee_Rappel__"; 'Rappel Augmentation de Salaire  Année :  ' + FORMAT("Annee Rappel"))
    //         {
    //         }
    //         column(Statut; Statut)
    //         {
    //         }
    //         column(Company_Name; Company.Name)
    //         {
    //         }
    //         column(Company_Address; Company.Address)
    //         {
    //         }
    //         column(Rappel_Enregistre_Affectation; Affectation)
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Rappel_Enregistre__Employee_No__; "Employee No.")
    //         {
    //         }
    //         column(Rappel_Enregistre_Nom; Nom)
    //         {
    //         }
    //         column(Rappel_Enregistre__Montant_Rappel_; "Montant Rappel")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column(TotalFor___FIELDCAPTION_Affectation_; TotalFor + FIELDCAPTION(Affectation))
    //         {
    //         }
    //         column(Rappel_Enregistre__Montant_Rappel__Control1000000028; "Montant Rappel")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(Rappel_Enregistre__Montant_Rappel_Caption; FIELDCAPTION("Montant Rappel"))
    //         {
    //         }
    //         column(EmargementCaption; EmargementCaptionLbl)
    //         {
    //         }
    //         column(QualificationCaption; QualificationCaptionLbl)
    //         {
    //         }
    //         column(Nbre__Caption; Nbre__CaptionLbl)
    //         {
    //         }
    //         column(Rappel_Enregistre_Annee_Rappel; "Annee Rappel")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin

    //             IF GETFILTER("Rappel Enregistre".Blocké) = 'Oui' THEN Statut := 'Salarié Inactif';
    //             IF GETFILTER("Rappel Enregistre".Blocké) = 'Non' THEN Statut := 'Salarié Actif';
    //             IF Company.GET THEN;

    //             IF RecQualification.GET("Rappel Enregistre".Qualification) THEN Qualif := RecQualification.Description;



    //             IF RecAffectation.GET("Rappel Enregistre".Affectation) THEN Affect := RecAffectation.Decription;
    //             //GL2024
    //             if "Rappel Enregistre".Affectation <> LastAffectation then begin
    //                 // Rupture : la valeur a changé
    //                 Nbre := 0;
    //                 LastAffectation := "Rappel Enregistre".Affectation;
    //             end;

    //             Nbre := Nbre + 1;

    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Annee Rappel");
    //             Nbre := 0;
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
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     TotalFor: Label 'Total ';
    //     RecAffectation: Record 52048917;
    //     Affect: Text[150];
    //     RecQualification: Record 5202;
    //     Qualif: Text[150];
    //     Nbre: Integer;
    //     Statut: Text[30];
    //     Company: Record 79;
    //     CurrReport_PAGENOCaptionLbl: Label 'Page';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     EmargementCaptionLbl: Label 'Emargement';
    //     QualificationCaptionLbl: Label 'Qualification';
    //     Nbre__CaptionLbl: Label 'Nbre :';
    //     LastAffectation: code[20];
}

