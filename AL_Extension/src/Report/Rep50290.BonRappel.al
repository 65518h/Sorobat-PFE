report 50290 "Bon Rappel"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BonRappel.rdlc';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;
    // Caption = 'Bon Rappel';

    // dataset
    // {
    //     dataitem("Rappel Enregistre"; 52048925)
    //     {
    //         DataItemTableView = SORTING("Employee No.", "Annee Rappel");
    //         RequestFilterFields = "Annee Rappel", Affectation, "Employee No.", "Blocké";
    //         column(Rappel_Enregistre__Employee_No__; "Employee No.")
    //         {
    //         }
    //         column(Employee_No_; "Employee No.")
    //         {

    //         }
    //         column(Rappel_Enregistre_Nom; Nom)
    //         {
    //         }
    //         column(Rappel_Enregistre__Montant_Rappel_; "Montant Rappel")
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Company_Name; Company.Name)
    //         {
    //         }
    //         column(Company_Address; Company.Address)
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column(STR; STR)
    //         {
    //         }
    //         column("Rappel_Augmentation_de_Salaire__Année"; Rappel_Augmentation_de_Salaire)
    //         {
    //         }
    //         column(du_; du)
    //         {
    //         }
    //         column(au_; au)
    //         {
    //         }
    //         column("Mois_Debut"; "Mois Debut")
    //         {
    //         }
    //         column("Annee_Debut"; "Annee Debut")
    //         {
    //         }
    //         column("Mois_Fin"; "Mois Fin")
    //         {
    //         }
    //         column("Annee_Fin"; "Annee Fin")
    //         {
    //         }
    //         column("Mégrine__le__Caption"; Mégrine__le__CaptionLbl)
    //         {
    //         }
    //         column("Veuillez_payer_à_M__Caption"; Veuillez_payer_à_M__CaptionLbl)
    //         {
    //         }
    //         column(Matricule__Caption; Matricule__CaptionLbl)
    //         {
    //         }
    //         column(Qualification__Caption; Qualification__CaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(La_somme_de__Caption; La_somme_de__CaptionLbl)
    //         {
    //         }
    //         column(Visa_Sce_PaieCaption; Visa_Sce_PaieCaptionLbl)
    //         {
    //         }
    //         column(Visa_D_A_F_Caption; Visa_D_A_F_CaptionLbl)
    //         {
    //         }
    //         column(Cachet_CaisseCaption; Cachet_CaisseCaptionLbl)
    //         {
    //         }
    //         column("Signature_bénéficiareCaption"; Signature_bénéficiareCaptionLbl)
    //         {
    //         }
    //         column(Rappel_Enregistre_Annee_Rappel; "Annee Rappel")
    //         {
    //         }
    //         trigger OnAfterGetRecord()
    //         begin
    //             test := "Annee Rappel";
    //             test2 := "Mois Debut";
    //             test3 := "Annee Debut";
    //             test4 := "Mois Fin";
    //             test5 := "Annee Fin";

    //             STR := '';
    //             IF Company.GET THEN;
    //             IF RecAffectation.GET("Rappel Enregistre".Affectation) THEN Affect := RecAffectation.Decription;
    //             IF RecQualification.GET("Rappel Enregistre".Qualification) THEN Qualif := RecQualification.Description;
    //             Convert."Montant en texte"(STR, "Montant Rappel");
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             LastFieldNo := FIELDNO("Employee No.");
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
    //     test: Integer;
    //     test2: Integer;
    //     test3: Integer;
    //     test4: Integer;
    //     test5: Integer;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     Company: Record 79;
    //     Convert: Codeunit 50005;
    //     RecAffectation: Record 52048917;
    //     Affect: Text[150];
    //     RecQualification: Record 5202;
    //     Qualif: Text[150];
    //     STR: Text[250];
    //     "Mégrine__le__CaptionLbl": Label 'Mégrine, le :';
    //     "Veuillez_payer_à_M__CaptionLbl": Label 'Veuillez payer à M :';
    //     Matricule__CaptionLbl: Label 'Matricule :';
    //     Qualification__CaptionLbl: Label 'Qualification :';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     La_somme_de__CaptionLbl: Label 'La somme de :';
    //     Visa_Sce_PaieCaptionLbl: Label 'Visa Sce Paie';
    //     Visa_D_A_F_CaptionLbl: Label 'Visa D.A.F.';
    //     Cachet_CaisseCaptionLbl: Label 'Cachet Caisse';
    //     "Signature_bénéficiareCaptionLbl": Label 'Signature bénéficiare';
    //     du: Label 'du ';
    //     au: Label ' au ';
    //     Rappel_Augmentation_de_Salaire: Label 'Rappel Augmentation de Salaire  Année :  ';
}

