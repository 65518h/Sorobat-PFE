// page 52048988 "STC Salarie"
// {//GL2024  ID dans Nav 2009 : "39001516"
//     Editable = true;
//     PageType = Card;
//     SourceTable = "STC Salaries";
//     SourceTableView = where(Status = filter("En cours"));

//     Caption = 'STC Salarie';
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
//             field("Mois 2"; Rec."Mois 2")
//             {
//                 ApplicationArea = Basic;
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
//             }
//             field(Observation; Rec.Observation)
//             {
//                 ApplicationArea = Basic;
//             }
//             field(Notifier; Rec.Notifier)
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Notifier par"; Rec."Notifier par")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Date Notification"; Rec."Date Notification")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field("Annee 2"; Rec."Annee 2")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Annee Prime de Rendement"; Rec."Annee Prime de Rendement")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Annee Prime de Rendement 2"; Rec."Annee Prime de Rendement 2")
//             {
//                 ApplicationArea = Basic;
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
//             field("A Retenir"; Rec."A Retenir")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Observation a retenir"; Rec."Observation a retenir")
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
//             field("Net A Payer"; Rec."Net A Payer")
//             {
//                 ApplicationArea = Basic;
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//             field("Nbre Jours Mois 2"; Rec."Nbre Jours Mois 2")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Nb Jours/Heures Mois 2';
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
//             field("Salaire Mois 2"; Rec."Salaire Mois 2")
//             {
//                 ApplicationArea = Basic;
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
//                 actionref("Notifier STC1"; "Notifier STC") { }
//                 actionref(Imprimer1; Imprimer) { }
//                 actionref("Imprimer Lettre D'information1"; "Imprimer Lettre D'information") { }
//                 actionref(Valider1; Valider) { }
//             }
//         }

//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Notifier STC")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Notifier STC';

//                     trigger OnAction()
//                     begin
//                         if Rec.Notifier = true then Error(Text001);

//                         if not Confirm('Voulez-vous Notifier Cette STC', false) then exit;

//                         RecSTCNotificationMail.Code := Rec."Code STC";
//                         RecSTCNotificationMail."Matricule Employé" := Rec.Maticule;
//                         RecSTCNotificationMail.Salarié := Rec.Salarié;
//                         RecSTCNotificationMail.Qualification := Rec."Description Qualification";
//                         RecSTCNotificationMail."Notifier par" := UserId;
//                         RecSTCNotificationMail."Date Notification" := Today;
//                         if not RecSTCNotificationMail.Insert then RecSTCNotificationMail.Modify;

//                         Rec.Notifier := true;
//                         Rec."Notifier par" := UserId;
//                         Rec."Date Notification" := Today;
//                         Rec.Modify;
//                         Message(Text002);
//                     end;
//                 }
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
//                 action("Imprimer Lettre D'information")

//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Imprimer Lettre D''information';

//                     trigger OnAction()
//                     begin
//                         RecSTCSalarie.SetRange("Code STC", Rec."Code STC");
//                         Report.RunModal(50071, true, false, RecSTCSalarie);
//                     end;
//                 }
//                 separator(Action1000000002)
//                 {
//                 }
//                 action(Valider)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Valider';
//                     //
//                     trigger OnAction()
//                     begin
//                         if Rec.Notifier = false then Error(Text003);
//                         if RecEmployee.Get(Rec.Maticule) then;
//                         RecEmployee.Blocked := true;
//                         RecEmployee."Code STC" := Rec."Code STC";
//                         RecEmployee."Motif STC" := Rec.Motif;
//                         RecEmployee.Modify;
//                         // Solder le solde congé
//                         RecEmployeeAbsence.Reset;
//                         RecEmployeeAbsence.Validate("Employee No.", Rec.Maticule);
//                         RecEmployeeAbsence.Validate("Cause of Absence Code", 'EXP');
//                         RecEmployeeAbsence.Validate("Motif D'absence", RecEmployeeAbsence."motif d'absence"::"Congé Spécial");
//                         RecEmployeeAbsence.Validate(Unit, RecEmployeeAbsence.Unit::"Journée de travail");
//                         RecEmployeeAbsence.Validate("From Date", Dmy2date(1, Rec.Mois + 1, Rec.Annee));
//                         RecEmployeeAbsence.Validate(Quantity, Rec."Droit Congé");
//                         RecEmployeeAbsence.Validate("Line type", RecEmployeeAbsence."line type"::"Day off Consumption");
//                         RecEmployeeAbsence.Insert(true);
//                         //IF NOT RecEmployeeAbsence.INSERT THEN RecEmployeeAbsence.MODIFY;
//                         EmployeeAbsence.Reset;
//                         EmployeeAbsence.CopyFilters(RecEmployeeAbsence);
//                         if EmployeeAbsence.Find('-') then begin
//                             HumanRessource.ValidAbsence(EmployeeAbsence);
//                         end;
//                         // Solder le solde congé
//                         Rec.Status := Rec.Status::Cloturé;
//                         Rec."Date Comptabilisation" := Today;
//                         Rec.Modify;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         RecSTCSalarie: Record "STC Salaries";
//         RecEmployee: Record Employee;
//         RecEmployeeAbsence: Record "Employee Absence";
//         EmployeeAbsence: Record "Employee Absence";
//         HumanRessource: Codeunit "Management of absences";
//         RecSTCNotificationMail: Record "STC Notification Mail";
//         Text001: label 'STC Déja Notifier !!';
//         Text002: label 'Notification Achevé avec succée !!';
//         Text003: label 'Vous Devez Notifier STC !!';
// }

