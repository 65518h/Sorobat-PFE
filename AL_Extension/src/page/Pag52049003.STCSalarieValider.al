// page 52049003 "STC Salarie Valider"
// {
//     //GL2024  ID dans Nav 2009 : "39001531"
//     Editable = false;
//     PageType = Card;
//     SourceTable = "STC Salaries";
//     SourceTableView = where(Status = filter(Cloturé));

//     Caption = 'STC Salarie Valider';
//     layout
//     {
//         area(content)
//         {
//             field("Code STC"; Rec."Code STC")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Maticule; Rec.Maticule)
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Salarié"; Rec.Salarié)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Date Saisie"; Rec."Date Saisie")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Date Comptabilisation"; Rec."Date Comptabilisation")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Mois; Rec.Mois)
//             {
//                 ApplicationArea = Basic;
//                 Editable = true;
//             }
//             field(Annee; Rec.Annee)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Type salarié"; Rec."Type salarié")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Qualification; Rec.Qualification)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Description Qualification"; Rec."Description Qualification")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Affectation; Rec.Affectation)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Deccription Affectation"; Rec."Deccription Affectation")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Base Calcule"; Rec."Base Calcule")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Montant Base Calcule"; Rec."Montant Base Calcule")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Prime de Rendement"; Rec."Prime de Rendement")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Prime de Rendement 2"; Rec."Prime de Rendement 2")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Prime de Rendement';
//             }
//             field(Motif; Rec.Motif)
//             {
//                 ApplicationArea = Basic;
//                 MultiLine = true;
//             }
//             field(Agence; Rec.Agence)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Observation; Rec.Observation)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field(Notifier; Rec.Notifier)
//             {
//                 ApplicationArea = Basic;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Notifier par"; Rec."Notifier par")
//             {
//                 ApplicationArea = Basic;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Date Notification"; Rec."Date Notification")
//             {
//                 ApplicationArea = Basic;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Nb Jours Mois En Cours"; Rec."Nb Jours Mois En Cours")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Nb Jours/Heures Mois En Cours';
//             }
//             field("Droit Congé"; Rec."Droit Congé")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Nb Jours Déplacement"; Rec."Nb Jours Déplacement")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Nb Heures Supplémentaires"; Rec."Nb Heures Supplémentaires")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Montant Rappel"; Rec."Montant Rappel")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Autre Montant"; Rec."Autre Montant")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Montant Avances En Cours"; Rec."Montant Avances En Cours")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Montant Pret En cours"; Rec."Montant Pret En cours")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Annee Prime de Rendement"; Rec."Annee Prime de Rendement")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Annee Prime de Rendement 2"; Rec."Annee Prime de Rendement 2")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Salaire Mois En Cours"; Rec."Salaire Mois En Cours")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Montant Droit Congé"; Rec."Montant Droit Congé")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Montant Jours Déplacement"; Rec."Montant Jours Déplacement")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("Montant Heures Supp"; Rec."Montant Heures Supp")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//             }
//             field("A Retenir"; Rec."A Retenir")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Net A Payer"; Rec."Net A Payer")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(Fonction1)
//             {
//                 Caption = 'Fonction';
//                 actionref(Imprimer1; Imprimer)
//                 {

//                 }
//                 actionref("Imprimer Lettre d'information1"; "Imprimer Lettre d'information")
//                 {

//                 }

//             }
//         }


//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action(Imprimer)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     begin
//                         RecSTCSalarie.SetRange("Code STC", Rec."Code STC");
//                         Report.RunModal(50144, true, false, RecSTCSalarie);
//                     end;
//                 }
//                 action("Imprimer Lettre d'information")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Imprimer Lettre d''information';

//                     trigger OnAction()
//                     begin
//                         RecSTCSalarie.SetRange("Code STC", Rec."Code STC");
//                         Report.RunModal(50071, true, false, RecSTCSalarie);
//                     end;
//                 }
//                 separator(Action1000000002)
//                 {
//                 }
//             }
//         }
//     }

//     var
//         RecSTCSalarie: Record "STC Salaries";
//         RecEmployee: Record Employee;
// }

