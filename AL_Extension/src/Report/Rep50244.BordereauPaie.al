report 50244 "Bordereau Paie"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/BordereauPaie.rdlc';

    // dataset
    // {
    //     dataitem("Ligne Lot Paie"; 52048957)
    //     {
    //         DataItemTableView = SORTING(Code, "Matricule Salarié");
    //         RequestFilterFields = "Code";
    //         column(Ligne_Lot_Paie__Ligne_Lot_Paie__Mois; "Ligne Lot Paie".Mois)
    //         {
    //         }
    //         column(FORMAT_CurrReport_PAGENO_; FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Ligne_Lot_Paie_Code; Code)
    //         {
    //         }
    //         column(Ligne_Lot_Paie__Code_Affectation_; "Code Affectation")
    //         {
    //         }
    //         column(RecEnteteLotPaie__Description_Affectation_; RecEnteteLotPaie."Description Affectation")
    //         {
    //         }
    //         column(Ligne_Lot_Paie__Ligne_Lot_Paie__Annee; "Ligne Lot Paie".Annee)
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
    //         column("Ligne_Lot_Paie__Ligne_Lot_Paie___Matricule_Salarié_"; "Ligne Lot Paie"."Matricule Salarié")
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(TotalSalire; TotalSalire)
    //         {
    //             DecimalPlaces = 3 : 3;
    //         }
    //         column(BORDEREAU_DE_VIREMENTCaption; BORDEREAU_DE_VIREMENTCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(MoisCaption; MoisCaptionLbl)
    //         {
    //         }
    //         column("AnnéeCaption"; AnnéeCaptionLbl)
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
    //         column(Nb_Caption; Nb_CaptionLbl)
    //         {
    //         }
    //         column("Total_à_Payer__Caption"; Total_à_Payer__CaptionLbl)
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             Nbre += 1;
    //             TotalSalire += "Ligne Lot Paie"."Montant Net";
    //             IF RecEnteteLotPaie.GET(Code) THEN;
    //             IF SalaryHeaders.GET("Num Paie") THEN;
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
    //     RecEnteteLotPaie: Record 52048956;
    //     SalaryHeaders: Record 52048896;
    //     Nbre: Integer;
    //     TotalSalire: Decimal;
    //     BORDEREAU_DE_VIREMENTCaptionLbl: Label 'BORDEREAU DE VIREMENT';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     MoisCaptionLbl: Label 'Mois';
    //     "AnnéeCaptionLbl": Label 'Année';
    //     "Net_à_payerCaptionLbl": Label 'Net à payer';
    //     Nom_et_PrenomCaptionLbl: Label 'Nom et Prenom';
    //     BANQUECaptionLbl: Label 'BANQUE';
    //     RIBCaptionLbl: Label 'RIB';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     Nb_CaptionLbl: Label 'Nb.';
    //     "Total_à_Payer__CaptionLbl": Label 'Total à Payer :';
}

