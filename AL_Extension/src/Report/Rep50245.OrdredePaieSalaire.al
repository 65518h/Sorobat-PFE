report 50245 "Ordre de Paie Salaire"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/OrdredePaieSalaire.rdlc';

    // dataset
    // {
    //     dataitem("Ligne Lot Paie"; 52048957)
    //     {
    //         DataItemTableView = SORTING(Code, "Matricule Salarié");
    //         RequestFilterFields = "Code";
    //         column(Ligne_Lot_Paie_Mois; Mois)
    //         {
    //             OptionCaption = '< ,Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Rappel,Solder jour de congé,Divers>';
    //             OptionMembers = "< ",Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé","Divers>";
    //         }
    //         column(AffEnteteLotPaie_Annee; AffEnteteLotPaie.Annee)
    //         {
    //         }
    //         column(CompanyInformation_Name; CompanyInformation.Name)
    //         {
    //         }
    //         column(RecBankAccountLotPaie_RIB; RecBankAccountLotPaie.RIB)
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(RecBankAccountLotPaie_Name; RecBankAccountLotPaie.Name)
    //         {
    //         }
    //         column(Ligne_Lot_Paie__Ligne_Lot_Paie___Montant_Net_; "Ligne Lot Paie"."Montant Net")
    //         {
    //         }
    //         column(Ligne_Lot_Paie__Ligne_Lot_Paie___Nom_Salarie_; "Ligne Lot Paie"."Nom Salarie")
    //         {
    //         }
    //         column("Ligne_Lot_Paie__Ligne_Lot_Paie___Banque_Salarié_"; "Ligne Lot Paie"."Banque Salarié")
    //         {
    //         }
    //         column(Ligne_Lot_Paie_RIB; RIB)
    //         {
    //         }
    //         column("Ligne_Lot_Paie__Matricule_Salarié_"; "Matricule Salarié")
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Qualif; Qualif)
    //         {
    //         }
    //         column(TotalSalire; TotalSalire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(VIREMENT_SALAIRE_Caption; VIREMENT_SALAIRE_CaptionLbl)
    //         {
    //         }
    //         column(ORDRE_DE_VIREMENTCaption; ORDRE_DE_VIREMENTCaptionLbl)
    //         {
    //         }
    //         column(RIB_DONNEUR_D_ORDRE__Caption; RIB_DONNEUR_D_ORDRE__CaptionLbl)
    //         {
    //         }
    //         column(NOM_PRENOM___RS__Caption; NOM_PRENOM___RS__CaptionLbl)
    //         {
    //         }
    //         column(MOTIF_DU_VIREMENT__Caption; MOTIF_DU_VIREMENT__CaptionLbl)
    //         {
    //         }
    //         column(BANQUE__Caption; BANQUE__CaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(LA_FONCIERE_TUNISIENNECaption; LA_FONCIERE_TUNISIENNECaptionLbl)
    //         {
    //         }
    //         column("Net_à_payerCaption"; Net_à_payerCaptionLbl)
    //         {
    //         }
    //         column(Nom_et_PrenomCaption; Nom_et_PrenomCaptionLbl)
    //         {
    //         }
    //         column(BANQUECaption; BANQUECaptionLbl)
    //         {
    //         }
    //         column(RIBCaption; RIBCaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(QualificationCaption; QualificationCaptionLbl)
    //         {
    //         }
    //         column(DataItem1000000039; V2__Le_donneur_d_ordre_dégage_d_ores)
    //         {
    //         }
    //         column(AgenceCaption; AgenceCaptionLbl)
    //         {
    //         }
    //         column("Total_à_Payer__Caption"; Total_à_Payer__CaptionLbl)
    //         {
    //         }
    //         column("V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_Caption"; V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl)
    //         {
    //         }
    //         column(Signature_du_ClientCaption; Signature_du_ClientCaptionLbl)
    //         {
    //         }
    //         column(Important__Caption; Important__CaptionLbl)
    //         {
    //         }
    //         column(Nb_Caption; Nb_CaptionLbl)
    //         {
    //         }
    //         column(Ligne_Lot_Paie_Code; Code)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             Nbre += 1;
    //             TotalSalire += "Ligne Lot Paie"."Montant Net";
    //             Qualif := '';
    //             Affect := '';

    //             IF RecEmploye.GET("Matricule Salarié") THEN BEGIN
    //                 IF RecQualification.GET(RecEmploye.Qualification) THEN Qualif := RecQualification.Description;
    //             END;

    //             IF Recsection.GET("Code Affectation") THEN Affect := Recsection.Decription;

    //             IF CompanyInformation.GET THEN;
    //             IF AffEnteteLotPaie.GET(Code) THEN;
    //             IF RecBankAccountLotPaie.GET(AffEnteteLotPaie."Code Banque") THEN;
    //             Mois := AffEnteteLotPaie.Mois;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             Nbre := 0;
    //             TotalSalire += 0;
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
    //     AffEnteteLotPaie: Record 52048956;
    //     Nbre: Integer;
    //     TotalSalire: Decimal;
    //     Mois: Option " ",Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé";
    //     Annee: Integer;
    //     CompanyInformation: Record 79;
    //     EnteteLotPaie: Record 52048956;
    //     CodeBanque: Code[10];
    //     BankAccount: Record 270;
    //     RibBank: Text[40];
    //     Banque: Text[30];
    //     NomBq: Text[12];
    //     CodeBanqueRIB: Text[2];
    //     CodeLotVirement: Code[20];
    //     CodeBanqueLotPaie: Code[20];
    //     RecEnteteLotPaie: Record 52048956;
    //     RecBankAccountLotPaie: Record 270;
    //     PageConst: Label 'Page';
    //     TotalFor: Label 'Total ';
    //     Recsection: Record 52048917;
    //     RecQualification: Record 5202;
    //     Affect: Text[150];
    //     Qualif: Text[150];
    //     RecEmploye: Record 5200;
    //     VIREMENT_SALAIRE_CaptionLbl: Label 'VIREMENT SALAIRE ';
    //     ORDRE_DE_VIREMENTCaptionLbl: Label 'ORDRE DE VIREMENT';
    //     RIB_DONNEUR_D_ORDRE__CaptionLbl: Label 'RIB DONNEUR D''ORDRE :';
    //     NOM_PRENOM___RS__CaptionLbl: Label 'NOM PRENOM / RS :';
    //     MOTIF_DU_VIREMENT__CaptionLbl: Label 'MOTIF DU VIREMENT :';
    //     BANQUE__CaptionLbl: Label 'BANQUE :';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     LA_FONCIERE_TUNISIENNECaptionLbl: Label 'LA FONCIERE TUNISIENNE';
    //     "Net_à_payerCaptionLbl": Label 'Net à payer';
    //     Nom_et_PrenomCaptionLbl: Label 'Nom et Prenom';
    //     BANQUECaptionLbl: Label 'BANQUE';
    //     RIBCaptionLbl: Label 'RIB';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     QualificationCaptionLbl: Label 'Qualification';
    //     "V2__Le_donneur_d_ordre_dégage_d_ores": Label '2. Le donneur d''ordre dégage d''ores et déja la responsabilité de la banque pour les conséquences découlant du libellé d''un RIB:RIP erroné.';
    //     AgenceCaptionLbl: Label 'Agence';
    //     "Total_à_Payer__CaptionLbl": Label 'Total à Payer :';
    //     "V1__Cet_Ordre_ne_sera_executé_que_si_la_situation_du_donneur_d_ordre_le_permet_CaptionLbl": Label '1. Cet Ordre ne sera executé que si la situation du donneur d''ordre le permet,';
    //     Signature_du_ClientCaptionLbl: Label 'Signature du Client';
    //     Important__CaptionLbl: Label 'Important :';
    //     Nb_CaptionLbl: Label 'Nb.';
}

