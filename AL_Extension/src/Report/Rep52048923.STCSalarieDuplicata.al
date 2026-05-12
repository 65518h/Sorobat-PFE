report 52048923 "STC Salarie Duplicata"
//jbs nav 39001434
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/STCSalarieDuplicata.rdlc';

    // dataset
    // {
    //     dataitem("Rec. Salary Lines"; 52048901)
    //     {
    //         column(Tunis__le___FORMAT_TODAY_0_4_; 'Tunis, le ' + FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         // column(CompanyInformationImage;CompanyInformation1)
    //         // {
    //         //     AutoFormatType = 0;

    //         // }
    //         column(CompanyInformation_Address; CompanyInformation.Address)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Employee; Employee)
    //         {
    //         }
    //         column(Rec__Salary_Lines_Name; Name)
    //         {
    //         }
    //         column(Desriptionqualification; Desriptionqualification)
    //         {
    //         }
    //         column(DescriptionAffectaion; DescriptionAffectaion)
    //         {
    //         }
    //         column(cin; cin)
    //         {
    //         }
    //         column(NumRIB; NumRIB)
    //         {
    //         }
    //         column(CompanyInformation_Name_____; '"' + CompanyInformation.Name + '",')
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed_; "Net salary cashed")
    //         {
    //         }
    //         column(MontantLettres__________; '     ' + '(' + ' ' + MontantLettres + ' ' + ')')
    //         {
    //         }
    //         column(Rec__Salary_Lines__No__; "No.")
    //         {
    //         }
    //         column(NumCNSS; NumCNSS)
    //         {
    //         }
    //         column("V2__Ma_signature_ci_dessous_dégage_la___CompanyInformation_Name___de_tout_engagement__"; '2- Ma signature ci-dessous dégage la ' + CompanyInformation.Name + ' de tout engagement.')
    //         {
    //         }
    //         column(Rec__Salary_Lines__Motif_STC_; "Motif STC")
    //         {
    //         }
    //         column(Rec__Salary_Lines_CNSS; CNSS)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Taxe__Month__; "Taxe (Month)")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Contribution_Social_; "Contribution Social")
    //         {
    //         }
    //         column(Rec__Salary_Lines_Cession; Cession)
    //         {
    //         }
    //         column(Rec__Salary_Lines__Gross_Salary_; "Gross Salary")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Taxable_salary_; "Taxable salary")
    //         {
    //         }
    //         column(Rec__Salary_Lines__Net_salary_cashed__Control1000000040; "Net salary cashed")
    //         {
    //         }
    //         column(SOLDE_DE_TOUT_COMPTECaption; SOLDE_DE_TOUT_COMPTECaptionLbl)
    //         {
    //         }
    //         column(Maticule__Caption; Maticule__CaptionLbl)
    //         {
    //         }
    //         column("Salarié__Caption"; Salarié__CaptionLbl)
    //         {
    //         }
    //         column(Qualification__Caption; Qualification__CaptionLbl)
    //         {
    //         }
    //         column(Affectation__Caption; Affectation__CaptionLbl)
    //         {
    //         }
    //         column(CIN__Caption; CIN__CaptionLbl)
    //         {
    //         }
    //         column(RIB__Caption; RIB__CaptionLbl)
    //         {
    //         }
    //         column("V1__Je_Soussigné__avoir_reconnu_reçu_de_la_part_de_la_société_Caption"; V1__Je_Soussigné__avoir_reconnu_reçu_de_la_part_de_la_société_CaptionLbl)
    //         {
    //         }
    //         column(l_ordre_deCaption; l_ordre_deCaptionLbl)
    //         {
    //         }
    //         column("Réparti_comme_suit__Caption"; Réparti_comme_suit__CaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines__No__Caption; FIELDCAPTION("No."))
    //         {
    //         }
    //         column(N__CNSS__Caption; N__CNSS__CaptionLbl)
    //         {
    //         }
    //         column(DUPLICATACaption; DUPLICATACaptionLbl)
    //         {
    //         }
    //         column("Ce_qui_représente_le_solde_de_tout_compte_lors_de_mon_départ_de_la_société_su_mentionnéeCaption"; Ce_qui_représente_le_solde_de_tout_compte_lors_de_mon_départ_de_la_société_su_mentionnéeCaptionLbl)
    //         {
    //         }
    //         column(Motif__Caption; Motif__CaptionLbl)
    //         {
    //         }
    //         column("L_interesséCaption"; L_interesséCaptionLbl)
    //         {
    //         }
    //         column(Service_PaieCaption; Service_PaieCaptionLbl)
    //         {
    //         }
    //         column(Direction_AdministrativeCaption; Direction_AdministrativeCaptionLbl)
    //         {
    //         }
    //         column(CaissierCaption; CaissierCaptionLbl)
    //         {
    //         }
    //         column("Service_ComptabilitéCaption"; Service_ComptabilitéCaptionLbl)
    //         {
    //         }
    //         column("Direction_FinancièreCaption"; Direction_FinancièreCaptionLbl)
    //         {
    //         }
    //         column(CNSS__9_18__Caption; CNSS__9_18__CaptionLbl)
    //         {
    //         }
    //         column("ImpôtCaption"; ImpôtCaptionLbl)
    //         {
    //         }
    //         column("Contribution_Sociale_de_SolidaritéCaption"; Contribution_Sociale_de_SolidaritéCaptionLbl)
    //         {
    //         }
    //         column(Rec__Salary_Lines_CessionCaption; FIELDCAPTION(Cession))
    //         {
    //         }
    //         column(BrutCaption; BrutCaptionLbl)
    //         {
    //         }
    //         column(ImposableCaption; ImposableCaptionLbl)
    //         {
    //         }
    //         column("Net_à_payerCaption"; Net_à_payerCaptionLbl)
    //         {
    //         }
    //         dataitem("Rec. Indemnities"; 52048902)
    //         {
    //             DataItemLink = "No." = FIELD("No."),
    //                            "Employee No." = FIELD(Employee);
    //             DataItemTableView = SORTING("No.", "Employee No.", Indemnity)
    //                                 WHERE(STC = CONST(true));
    //             column(LibelleJoursPaiement; LibelleJoursPaiement)
    //             {
    //             }
    //             column(ROUND__Real_Amount__0_001_; ROUND("Real Amount", 0.001))
    //             {
    //                 AutoFormatType = 0;
    //                 DecimalPlaces = 3 : 3;
    //             }
    //             column(Rec__Indemnities_Description; Description)
    //             {
    //             }
    //             column(Rec__Indemnities_No_; "No.")
    //             {
    //             }
    //             column(Rec__Indemnities_Employee_No_; "Employee No.")
    //             {
    //             }
    //             column(Rec__Indemnities_Indemnity; Indemnity)
    //             {
    //             }
    //             trigger OnAfterGetRecord()
    //             var
    //             BEGIN

    //                 LibelleJoursPaiement := '';
    //                 JoursPayement := 0;
    //                 IF Indemnity = '957' THEN JoursPayement := RecEmployee."Days off =";
    //                 IF JoursPayement <> 0 THEN LibelleJoursPaiement := FORMAT(JoursPayement) + ' Jours';
    //             END;
    //         }
    //         trigger OnAfterGetRecord()
    //         var
    //         BEGIN

    //             MontantLettres := '';
    //             IF CompanyInformation.GET() THEN;
    //             IF RecEmployee.GET(Employee) THEN;
    //             cin := RecEmployee."N° CIN";
    //             NumRIB := RecEmployee.RIB;
    //             NumCNSS := RecEmployee."Social Security No.";
    //             RecEmployee.CALCFIELDS("Deccription Affectation", "Days off =");
    //             RecEmployee.CALCFIELDS("Description Qualification");
    //             Desriptionqualification := RecEmployee."Description Qualification";
    //             DescriptionAffectaion := RecEmployee."Deccription Affectation";

    //             CUMontantLettre."Montant en texte sans millimes"(MontantLettres, "Net salary cashed");
    //         END;
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
    //     CompanyInformation: Record 79;
    //     RecEmployee: Record 5200;
    //     NumRIB: Text[30];
    //     cin: Text[30];
    //     CUMontantLettre: Codeunit 50005;
    //     MontantLettres: Text[250];
    //     Desriptionqualification: Text[100];
    //     DescriptionAffectaion: Text[30];
    //     NumCNSS: Text[30];
    //     JoursPayement: Decimal;
    //     LibelleJoursPaiement: Text[30];
    //     SOLDE_DE_TOUT_COMPTECaptionLbl: Label 'SOLDE DE TOUT COMPTE';
    //     Maticule__CaptionLbl: Label 'Maticule :';
    //     "Salarié__CaptionLbl": Label 'Salarié :';
    //     Qualification__CaptionLbl: Label 'Qualification :';
    //     Affectation__CaptionLbl: Label 'Affectation :';
    //     CIN__CaptionLbl: Label 'CIN :';
    //     RIB__CaptionLbl: Label 'RIB :';
    //     "V1__Je_Soussigné__avoir_reconnu_reçu_de_la_part_de_la_société_CaptionLbl": Label '1- Je Soussigné, avoir reconnu reçu de la part de la société ';
    //     l_ordre_deCaptionLbl: Label 'l''ordre de';
    //     "Réparti_comme_suit__CaptionLbl": Label 'Réparti comme suit :';
    //     N__CNSS__CaptionLbl: Label 'N° CNSS :';
    //     DUPLICATACaptionLbl: Label 'DUPLICATA';
    //     "Ce_qui_représente_le_solde_de_tout_compte_lors_de_mon_départ_de_la_société_su_mentionnéeCaptionLbl": Label 'Ce qui représente le solde de tout compte lors de mon départ de la société su-mentionnée';
    //     Motif__CaptionLbl: Label 'Motif :';
    //     "L_interesséCaptionLbl": Label 'L''interessé';
    //     Service_PaieCaptionLbl: Label 'Service Paie';
    //     Direction_AdministrativeCaptionLbl: Label 'Direction Administrative';
    //     CaissierCaptionLbl: Label 'Caissier';
    //     "Service_ComptabilitéCaptionLbl": Label 'Service Comptabilité';
    //     "Direction_FinancièreCaptionLbl": Label 'Direction Financière';
    //     CNSS__9_18__CaptionLbl: Label 'CNSS (9,18%)';
    //     "ImpôtCaptionLbl": Label 'Impôt';
    //     "Contribution_Sociale_de_SolidaritéCaptionLbl": Label 'Contribution Sociale de Solidarité';
    //     BrutCaptionLbl: Label 'Brut';
    //     ImposableCaptionLbl: Label 'Imposable';
    //     "Net_à_payerCaptionLbl": Label 'Net à payer';
}

