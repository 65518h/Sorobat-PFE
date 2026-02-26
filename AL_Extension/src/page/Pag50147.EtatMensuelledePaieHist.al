// Page 50147 "Etat Mensuelle de Paie Hist"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     SourceTable = "Etat Mensuelle Paie Hist";
//     ApplicationArea = all;
//     Caption = 'Etat Mensuelle de Paie Hist';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field(Annee; REC.Annee)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Mois; REC.Mois)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Nom; REC.Nom)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom 1"; REC."Nom 1")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("D.Hr sup"; REC."D.Hr sup")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Congé Spéciale"; REC."Congé Spéciale")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tot Heurs"; REC."Tot Heurs")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Hr nuit"; REC."Hr nuit")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure 25"; REC."Heure 25")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure 50"; REC."Heure 50")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Présence"; REC.Présence)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Congé"; REC.Congé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Férier"; REC.Férier)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Jour repos"; REC."Jour repos")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Bage; REC.Bage)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Sup Majoré à 75 %"; REC."Heure Sup Majoré à 75 %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Semaine; REC.Semaine)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Heure; REC.Heure)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Heure"; REC."Type Heure")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Absence; REC.Absence)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure ferier"; REC."Heure ferier")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Suivi Modification"; REC."Suivi Modification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Utilisateur; REC.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Sup Majoré à 100 %"; REC."Heure Sup Majoré à 100 %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Salarié"; REC."Type Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heures Normal"; REC."Heures Normal")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Rembourcement frais"; REC."Rembourcement frais")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heures compensation"; REC."Heures compensation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nombre de jour indemnité exep"; REC."Nombre de jour indemnité exep")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Salisure; REC.Salisure)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Douche; REC.Douche)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbr Jours Deplacement"; REC."Nbr Jours Deplacement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Congé maladie"; REC."Heure Congé maladie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure accident de travail"; REC."Heure accident de travail")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Indemnité ration de force"; REC."Indemnité ration de force")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Indemnité Habillement"; REC."Indemnité Habillement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prime semestrielle"; REC."Prime semestrielle")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Indemnité samedi"; REC."Indemnité samedi")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant congé"; REC."Montant congé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Jours Sup Calculé Majoré à 75%"; REC."Jours Sup Calculé Majoré à 75%")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Normal Supp Calculé"; REC."Heure Normal Supp Calculé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Travaillé"; REC."Heure Travaillé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Jours Travaillé"; REC."Jours Travaillé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Rappel; REC.Rappel)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Retenu; REC.Retenu)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Cession; REC.Cession)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heures Retenues"; REC."Heures Retenues")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Travaillé réel"; REC."Heure Travaillé réel")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Jours Dimanche"; REC."Jours Dimanche")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Kmetrage; REC.Kmetrage)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Jours Sup Normal"; REC."Jours Sup Normal")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Droit Congé"; REC."Droit Congé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Rappel Salarié"; REC."Rappel Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("type calcul paie"; REC."type calcul paie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nombre de jour"; REC."Nombre de jour")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Productivité"; REC.Productivité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total nb jours"; REC."Total nb jours")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total nb heures"; REC."Total nb heures")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nombre Salarier"; REC."Nombre Salarier")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

