report 50109 "Déclaration Trim Validation"
{
    // DefaultLayout = RDLC;
    // //  RDLCLayout = './Layouts/DéclarationTrimValidation.rdlc';
    // TransactionType = UpdateNoLocks;

    // dataset
    // {
    //     dataitem(DataItem1397; 52048919)
    //     {
    //         DataItemTableView = SORTING(Matricule, Année, Trimestre);

    //         trigger OnAfterGetRecord()
    //         begin
    //             Cloturer := TRUE;
    //             MODIFY;
    //         end;

    //         trigger OnPreDataItem()
    //         begin
    //             IF NOT CONFIRM(Text001) THEN ERROR(Text002);
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

    // trigger OnInitReport()
    // begin
    //     Année := DATE2DMY(WORKDATE, 3);
    //     xTrimestre := (DATE2DMY(WORKDATE, 2) - 1) DIV 3;
    // end;

    // var
    //     RecEmplyee: Record 5200;
    //     LastFieldNo: Integer;
    //     FooterPrinted: Boolean;
    //     LigneSalaireEnreg: Record 52048901;
    //     LigneSalaireEnreg1: Record 52048901;
    //     LigneSalaireEnreg2: Record 52048901;
    //     LigneSalaireEnreg3: Record 52048901;
    //     LigneSalaireEnreg4: Record 52048901;
    //     CompanyInformation: Record 79;
    //     RecSocialContribution: Record 52048903;
    //     xTrimestre: Option "Premier Trimestre","Deuxiéme Trimestre","Troisième Trimestre","Quatrième Trimestre";
    //     "Année": Integer;
    //     Total1: Decimal;
    //     Total2: Decimal;
    //     Total3: Decimal;
    //     TotalE1: Decimal;
    //     TotalE2: Decimal;
    //     TotalE3: Decimal;
    //     Total: Decimal;
    //     CotisationPersonnel: Decimal;
    //     CotisationPatronal: Decimal;
    //     AccidentTravail: Decimal;
    //     CotisationGlobal: Decimal;
    //     Convert: Codeunit 50001;
    //     Comp: Text[30];
    //     CNSS: Record 52048885;
    //     mois1: Decimal;
    //     mois2: Decimal;
    //     mois3: Decimal;
    //     SommeLigne: Decimal;
    //     i: Integer;
    //     j: Integer;
    //     m: Integer;
    //     Cnt: Record 5211;
    //     LibMois1: Text[30];
    //     LibMois2: Text[30];
    //     LibMois3: Text[30];
    //     DMin: Date;
    //     An: Integer;
    //     GLSetup: Record 98;
    //     TFmois1: Decimal;
    //     TFmois2: Decimal;
    //     TFmois3: Decimal;
    //     K: Integer;
    //     NJ1: Decimal;
    //     NJ2: Decimal;
    //     NJ3: Decimal;
    //     Effectif: Integer;
    //     EffectifEntete: Integer;
    //     TmpEmployee: Code[20];
    //     CodeU: Codeunit 50005;
    //     TextGMnt: Text[600];
    //     "1erMois": Text[30];
    //     "2emeMois": Text[30];
    //     "3emeMois": Text[30];
    //     PageConst: Label 'Page';
    //     Num: Integer;
    //     "// RB SORO": Integer;
    //     LinesPrinted: Integer;
    //     SommePage1: Decimal;
    //     SommePage2: Decimal;
    //     SommePage3: Decimal;
    //     TotalPage: Decimal;
    //     NouvellePage: Boolean;
    //     SommeRep1: Decimal;
    //     SommeRep2: Decimal;
    //     SommeRep3: Decimal;
    //     TotalRep: Decimal;
    //     RecHumanSetup: Record 5218;
    //     RecEmployeeAvg: Record 5200;
    //     NumSecuriteSocial: Code[20];
    //     fk: Integer;
    //     fg: Integer;
    //     TotCnss: Decimal;
    //     Declarationsalaires: Record 52048919;
    //     Text001: Label 'Cloturer Declaration Année %1, Trimestre %2 ?????';
    //     Supprimer: Boolean;
    //     Text002: Label 'Opération Annulée Par l''Utilisateur';
}

