//report 52048891 "Etat de pointage"

//     //GL2024  ID dans Nav 2009 : "39001431"

//{
// DefaultLayout = RDLC;
// RDLCLayout = './Layouts/Etatdepointage.rdlc';

// dataset
// {
//     dataitem("Company Information"; 79)
//     {
//         DataItemTableView = SORTING("Primary Key");
//     }
//     dataitem("Etat Mensuelle Paie"; 52048909)
//     {
//         DataItemTableView = SORTING(Matricule)
//                             ORDER(Ascending);
//         column(Annee; Annee)
//         {
//         }
//         column(Mois; Mois)
//         {
//         }
//         column(USERID; USERID)
//         {
//         }
//         column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
//         {
//         }
//         column(TIME; TIME)
//         {
//         }
//         column(COMPANYNAME; COMPANYNAME)
//         {
//         }
//         column(Etat_Mensuelle_Paie_Matricule; Matricule)
//         {
//         }
//         column(RecGemploye__Statistics_Group_Code_; RecGemploye."Statistics Group Code")
//         {
//         }
//         column(RecGemploye__First_Name_________RecGemploye__Last_Name_; RecGemploye."First Name" + ' ' + RecGemploye."Last Name")
//         {
//         }
//         column(HM; HM)
//         {
//         }
//         column(RecGemploye__Basis_salary_; RecGemploye."Basis salary")
//         {
//             DecimalPlaces = 3 : 3;
//         }
//         column(Etat_Mensuelle_Paie_Heure; Heure)
//         {
//         }
//         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_25_; "Etat Mensuelle Paie"."Heure 25")
//         {
//         }
//         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_50_; "Etat Mensuelle Paie"."Heure 50")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Sup_Majoré_à_75___"; "Etat Mensuelle Paie"."Heure Sup Majoré à 75 %")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Sup_Majoré_à_100___"; "Etat Mensuelle Paie"."Heure Sup Majoré à 100 %")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Férier"; "Etat Mensuelle Paie".Férier)
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Productivité"; "Etat Mensuelle Paie".Productivité)
//         {
//         }
//         column(Etat_Mensuelle_Paie__Nombre_de_jour_; "Nombre de jour")
//         {
//         }
//         column("Etat_Mensuelle_Paie_Congé"; Congé)
//         {
//         }
//         column(NBJourH; NBJourH)
//         {
//         }
//         column(NBHrure; NBHrure)
//         {
//         }
//         column(HNuit; HNuit)
//         {
//         }
//         column(HSup25; HSup25)
//         {
//         }
//         column(HSup50; HSup50)
//         {
//         }
//         column(HSup75; HSup75)
//         {
//         }
//         column(HSup50M; HSup50M)
//         {
//         }
//         column(HSup25M; HSup25M)
//         {
//         }
//         column(HNuitM; HNuitM)
//         {
//         }
//         column(NBHrureM; NBHrureM)
//         {
//         }
//         column(NBJourM; NBJourM)
//         {
//         }
//         column(HSup75M; HSup75M)
//         {
//         }
//         column(HSup100; HSup100)
//         {
//         }
//         column(HSup100M; HSup100M)
//         {
//         }
//         column(JourFerH; JourFerH)
//         {
//         }
//         column(JourFerM; JourFerM)
//         {
//         }
//         column("productivitéH"; productivitéH)
//         {
//         }
//         column("productivitéM"; productivitéM)
//         {
//         }
//         column(Etat_Mensuelle_Paie_Heure_Control1102752001; Heure)
//         {
//         }
//         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_25__Control1102752003; "Etat Mensuelle Paie"."Heure 25")
//         {
//         }
//         column(Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_50__Control1102752004; "Etat Mensuelle Paie"."Heure 50")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Sup_Majoré_à_75____Control1102752005"; "Etat Mensuelle Paie"."Heure Sup Majoré à 75 %")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie___Heure_Sup_Majoré_à_100____Control1102752006"; "Etat Mensuelle Paie"."Heure Sup Majoré à 100 %")
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Férier_Control1102752007"; "Etat Mensuelle Paie".Férier)
//         {
//         }
//         column("Etat_Mensuelle_Paie__Etat_Mensuelle_Paie__Productivité_Control1102752008"; "Etat Mensuelle Paie".Productivité)
//         {
//         }
//         column(Etat_Mensuelle_Paie__Nombre_de_jour__Control1102752010; "Nombre de jour")
//         {
//         }
//         column(MATCaption; MATCaptionLbl)
//         {
//         }
//         column(DepartementCaption; DepartementCaptionLbl)
//         {
//         }
//         column("Nom_et_PrénomCaption"; Nom_et_PrénomCaptionLbl)
//         {
//         }
//         column("RégimeCaption"; RégimeCaptionLbl)
//         {
//         }
//         column(S__BaseCaption; S__BaseCaptionLbl)
//         {
//         }
//         column(Heure_JourCaption; Heure_JourCaptionLbl)
//         {
//         }
//         column(H__Sup_25Caption; H__Sup_25CaptionLbl)
//         {
//         }
//         column(H__Sup_50Caption; H__Sup_50CaptionLbl)
//         {
//         }
//         column(H__Sup_75Caption; H__Sup_75CaptionLbl)
//         {
//         }
//         column(H__Sup_100Caption; H__Sup_100CaptionLbl)
//         {
//         }
//         column("FérierCaption"; FérierCaptionLbl)
//         {
//         }
//         column("ProductivitéCaption"; ProductivitéCaptionLbl)
//         {
//         }
//         column(ETAT_DE_POINTAGECaption; ETAT_DE_POINTAGECaptionLbl)
//         {
//         }
//         column("AnnéeCaption"; AnnéeCaptionLbl)
//         {
//         }
//         column(MoisCaption; MoisCaptionLbl)
//         {
//         }
//         column(Etat_Mensuelle_Paie__Nombre_de_jour_Caption; FIELDCAPTION("Nombre de jour"))
//         {
//         }
//         column("CongésCaption"; CongésCaptionLbl)
//         {
//         }
//         column(Salarier_HoraireCaption; Salarier_HoraireCaptionLbl)
//         {
//         }
//         column(Salarier_MensuelCaption; Salarier_MensuelCaptionLbl)
//         {
//         }
//         column(Nbr_JoursCaption; Nbr_JoursCaptionLbl)
//         {
//         }
//         column(Nbr_HeuresCaption; Nbr_HeuresCaptionLbl)
//         {
//         }
//         column(Nbr_nuitCaption; Nbr_nuitCaptionLbl)
//         {
//         }
//         column(H_suppl_25Caption; H_suppl_25CaptionLbl)
//         {
//         }
//         column(H_suppl_50Caption; H_suppl_50CaptionLbl)
//         {
//         }
//         column(H_suppl_75Caption; H_suppl_75CaptionLbl)
//         {
//         }
//         column(H_suppl_100Caption; H_suppl_100CaptionLbl)
//         {
//         }
//         column(FerierCaption; FerierCaptionLbl)
//         {
//         }
//         column("ProductivitéCaption_Control1000000040"; ProductivitéCaption_Control1000000040Lbl)
//         {
//         }
//         column(TotalCaption; TotalCaptionLbl)
//         {
//         }
//         trigger OnAfterGetRecord()
//         var
//         begin

//             IF RecGemploye.GET(Matricule) THEN
//                 IF RecGemploye."Employee's type" = 0 THEN
//                     HM := 'H'
//                 ELSE
//                     HM := 'M';
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
//     Annee: Integer;
//     Erreur1: Label 'Vous devez préciser l''année';
//     HM: Text[1];
//     Mois: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème";
//     RecCompanyinfo: Record 79;
//     RecGemploye: Record 5200;
//     RecEtatMensuelPaie: Record 52048909;
//     NBJourH: Decimal;
//     NBJourM: Decimal;
//     NBHrure: Decimal;
//     HNuit: Decimal;
//     HSup25: Decimal;
//     HSup50: Decimal;
//     HSup75: Decimal;
//     HSup100: Decimal;
//     NBHrureM: Decimal;
//     HNuitM: Decimal;
//     HSup25M: Decimal;
//     HSup50M: Decimal;
//     HSup75M: Decimal;
//     HSup100M: Decimal;
//     JourFerH: Decimal;
//     JourFerM: Decimal;
//     "productivitéH": Decimal;
//     "productivitéM": Decimal;
//     MATCaptionLbl: Label 'MAT';
//     DepartementCaptionLbl: Label 'Departement';
//     "Nom_et_PrénomCaptionLbl": Label 'Nom et Prénom';
//     "RégimeCaptionLbl": Label 'Régime';
//     S__BaseCaptionLbl: Label 'S. Base';
//     Heure_JourCaptionLbl: Label 'Heure/Jour';
//     H__Sup_25CaptionLbl: Label 'H. Sup 25';
//     H__Sup_50CaptionLbl: Label 'H. Sup 50';
//     H__Sup_75CaptionLbl: Label 'H. Sup 75';
//     H__Sup_100CaptionLbl: Label 'H. Sup 100';
//     "FérierCaptionLbl": Label 'Férier';
//     "ProductivitéCaptionLbl": Label 'Productivité';
//     ETAT_DE_POINTAGECaptionLbl: Label 'ETAT DE POINTAGE';
//     "AnnéeCaptionLbl": Label 'Année';
//     MoisCaptionLbl: Label 'Mois';
//     "CongésCaptionLbl": Label 'Congés';
//     Salarier_HoraireCaptionLbl: Label 'Salarier Horaire';
//     Salarier_MensuelCaptionLbl: Label 'Salarier Mensuel';
//     Nbr_JoursCaptionLbl: Label 'Nbr Jours';
//     Nbr_HeuresCaptionLbl: Label 'Nbr Heures';
//     Nbr_nuitCaptionLbl: Label 'Nbr nuit';
//     H_suppl_25CaptionLbl: Label 'H.suppl.25';
//     H_suppl_50CaptionLbl: Label 'H.suppl.50';
//     H_suppl_75CaptionLbl: Label 'H.suppl.75';
//     H_suppl_100CaptionLbl: Label 'H.suppl.100';
//     FerierCaptionLbl: Label 'Ferier';
//     "ProductivitéCaption_Control1000000040Lbl": Label 'Productivité';
//     TotalCaptionLbl: Label 'Total';
//}