report 50296 "Liste des CESSIONS"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/ListedesCESSIONS.rdlc';

    // dataset
    // {
    //     dataitem("Loan & Advance Header"; 52048889)
    //     {
    //         DataItemTableView = SORTING (Employee)
    //                             WHERE ("Pret CNSS"=CONST(Cession));
    //         column(Annee; Annee)
    //         {
    //         }
    //         column(Mois; Mois)
    //         {
    //         }
    //         column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
    //         {
    //         }
    //         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
    //         {
    //         }
    //         column(Loan___Advance_Header_Employee; Employee)
    //         {
    //         }
    //         column(Loan___Advance_Header_Name; Name)
    //         {
    //         }
    //         column(Loan___Advance_Header__Montant_tranche_; "Montant tranche")
    //         {
    //         }
    //         column(Loan___Advance_Header_section; section)
    //         {
    //         }
    //         column(Loan___Advance_Header__Date_d_effet_; "Date d'effet")
    //         {
    //         }
    //         column(Affect; Affect)
    //         {
    //         }
    //         column(Total; Total)
    //         {
    //         }
    //         column(Nbre; Nbre)
    //         {
    //         }
    //         column(Mois_du__Caption; Mois_du__CaptionLbl)
    //         {
    //         }
    //         column("Liste_des_échéances_Cessions_sur_salaireCaption"; Liste_des_échéances_Cessions_sur_salaireCaptionLbl)
    //         {
    //         }
    //         column(Service_du_PersonnelsCaption; Service_du_PersonnelsCaptionLbl)
    //         {
    //         }
    //         column(SOROUBATCaption; SOROUBATCaptionLbl)
    //         {
    //         }
    //         column(MatriculeCaption; MatriculeCaptionLbl)
    //         {
    //         }
    //         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
    //         {
    //         }
    //         column(MontantCaption; MontantCaptionLbl)
    //         {
    //         }
    //         column(AffectationCaption; AffectationCaptionLbl)
    //         {
    //         }
    //         column(DateCaption; DateCaptionLbl)
    //         {
    //         }
    //         column(Total__Caption; Total__CaptionLbl)
    //         {
    //         }
    //         column(Nb_Caption; Nb_CaptionLbl)
    //         {
    //         }
    //         column(Loan___Advance_Header_No_; "No.")
    //         {
    //         }

    //         trigger OnAfterGetRecord()
    //         begin
    //             IF RecAffectation.GET(section) THEN;
    //             Affect := RecAffectation.Decription;
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
    //     RecAffectation: Record 52048917;
    //     Mois: Option ,Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
    //     Annee: Integer;
    //     Date: Date;
    //     Month: Integer;
    //     Year: Integer;
    //     Total: Decimal;
    //     Affect: Text[30];
    //     Nbre: Integer;
    //     Mois_du__CaptionLbl: Label 'Mois du :';
    //     "Liste_des_échéances_Cessions_sur_salaireCaptionLbl": Label 'Liste des échéances Cessions sur salaire';
    //     Service_du_PersonnelsCaptionLbl: Label 'Service du Personnels';
    //     SOROUBATCaptionLbl: Label 'SOROUBAT';
    //     MatriculeCaptionLbl: Label 'Matricule';
    //     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
    //     MontantCaptionLbl: Label 'Montant';
    //     AffectationCaptionLbl: Label 'Affectation';
    //     DateCaptionLbl: Label 'Date';
    //     Total__CaptionLbl: Label 'Total =';
    //     Nb_CaptionLbl: Label 'Nb.';
}

