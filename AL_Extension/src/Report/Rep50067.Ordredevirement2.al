report 50067 "Ordre de virement2"
{//NEW Etat
    // // DefaultLayout = RDLC;
    // // RDLCLayout = './Layouts/HeureSupBR.rdlc';
    // ProcessingOnly = true;

    // dataset
    // {
    //     dataitem("Etat Mensuelle Paie"; "Etat Mensuelle Paie")
    //     {
    //         DataItemTableView = SORTING(Matricule)
    //                             WHERE("Heure Sup BR" = FILTER(> 0));

    //         trigger OnAfterGetRecord()
    //         begin
    //             MaxHeureSup := 0;
    //             NbreHeureMois := 0;

    //             RecBRHeureSuplémentaire."Code Brouillard" := NoSeries.GetNextNo('BRH', 0D, TRUE);
    //             RecBRHeureSuplémentaire.Maticule := "Etat Mensuelle Paie".Matricule;
    //             RecBRHeureSuplémentaire.Salarié := "Etat Mensuelle Paie".Nom;
    //             RecBRHeureSuplémentaire.Affectation := "Etat Mensuelle Paie".Affectation;
    //             RecBRHeureSuplémentaire.Qualification := "Etat Mensuelle Paie".Qualification;
    //             RecBRHeureSuplémentaire.Mois := DATE2DMY(DatePaie, 2) - 1;
    //             RecBRHeureSuplémentaire.Annee := DATE2DMY(DatePaie, 3);
    //             IF RecContract.GET("Etat Mensuelle Paie".Matricule) THEN BEGIN
    //                 IF RecRégime.GET(RecContract."Regimes of work") THEN BEGIN
    //                     MaxHeureSup := RecRégime."Max. Supp. Hours per month";
    //                     NbreHeureMois := RecRégime."Work Hours per month";
    //                 END;
    //             END;

    //             //IF "Etat Mensuelle Paie"."Heure Sup BR">MaxHeureSup THEN
    //             //        RecBRHeureSuplémentaire."Nombre Heure Suplémentaire":=MaxHeureSup
    //             //ELSE
    //             RecBRHeureSuplémentaire."Nombre Heure Suplémentaire" := "Etat Mensuelle Paie"."Heure Sup BR";

    //             RecEmployee.RESET;
    //             IF RecEmployee.GET("Etat Mensuelle Paie".Matricule) THEN BEGIN
    //                 RecBRHeureSuplémentaire."Type salarié" := RecEmployee."Employee's type";
    //                 IF RecEmployee."Employee's type" = 0 THEN BEGIN
    //                     RecBRHeureSuplémentaire."Base Calcule" := RecEmployee."Salaire De Base Horaire";
    //                 END;
    //                 IF RecEmployee."Employee's type" = 1 THEN BEGIN
    //                     RecBRHeureSuplémentaire."Base Calcule" := RecEmployee."Basis salary";
    //                 END;
    //             END;

    //             RecBRHeureSuplémentaire.Régime := RecContract."Regimes of work";
    //             RecBRHeureSuplémentaire."Heures Par mois" := RecRégime."Work Hours per month";
    //             RecBRHeureSuplémentaire."Max heure sup Mensuel" := RecRégime."Max. Supp. Hours per month";

    //             IF "Etat Mensuelle Paie"."Ne pas appliquer Taux %" = FALSE THEN BEGIN
    //                 RecBRHeureSuplémentaire."Net A Payer" := ((RecBRHeureSuplémentaire."Base Calcule" * 1.2) / NbreHeureMois) *
    //                               RecBRHeureSuplémentaire."Nombre Heure Suplémentaire";
    //                 RecBRHeureSuplémentaire."Appliquer Taux" := TRUE;
    //             END
    //             ELSE IF "Etat Mensuelle Paie"."Ne pas appliquer Taux %" = TRUE THEN BEGIN
    //                 RecBRHeureSuplémentaire."Net A Payer" := (RecBRHeureSuplémentaire."Base Calcule" / NbreHeureMois) *
    //                            RecBRHeureSuplémentaire."Nombre Heure Suplémentaire";
    //                 RecBRHeureSuplémentaire."Appliquer Taux" := FALSE;
    //             END;

    //             IF RecSection.GET("Etat Mensuelle Paie".Affectation) THEN RecBRHeureSuplémentaire."Deccription Affectation" := RecSection.Decription;
    //             IF RecQualification.GET("Etat Mensuelle Paie".Qualification) THEN
    //                 RecBRHeureSuplémentaire."Description Qualification" := RecQualification.Description;

    //             IF NOT RecBRHeureSuplémentaire.INSERT THEN RecBRHeureSuplémentaire.MODIFY;

    //             RecSection.RESET;
    //         end;
    //     }
    // }

    // requestpage
    // {


    //     layout
    //     {
    //         area(content)
    //         {
    //             group(Options)
    //             {
    //                 field("CHOISIR LA DATE DE PAIE"; DatePaie)
    //                 {
    //                     Caption = 'CHOISIR LA DATE DE PAIE';
    //                 }
    //             }
    //         }

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
    //     DatePaie := CALCDATE('-1M', TODAY);
    // end;

    // trigger OnPostReport()
    // begin
    //     MESSAGE('Importation des données de pointage avec succée');
    // end;

    // var
    //     "RecBRHeureSuplémentaire": Record 50035;
    //     NoSeries: Codeunit 396;
    //     DatePaie: Date;
    //     RecEmployee: Record 5200;
    //     RecContract: Record 5211;
    //     "RecRégime": Record 52048882;
    //     MaxHeureSup: Decimal;
    //     NbreHeureMois: Decimal;
    //     RecSection: Record 52048917;
    //     RecQualification: Record 5202;
}

