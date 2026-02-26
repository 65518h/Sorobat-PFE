// Page 50155 "Etat Mensuel De Paie 2"
// {
//     PageType = List;
//     SourceTable = "Etat Mensuelle Paie";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Etat Mensuel De Paie 2';

//     layout
//     {
//         area(content)
//         {
//             group("ETAT MENSUEL DE PAIE")
//             {
//                 Caption = 'ETAT MENSUEL DE PAIE';
//                 field(Affectation; CodeAffectation)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         REC.Reset;
//                         REC.CalcFields("Nombre Salarier");
//                         NombreSalarié := REC."Nombre Salarier";
//                         if CodeAffectation <> '' then begin
//                             REC.SetRange(Affectation, CodeAffectation);
//                             EtatMensuellePaie.SetRange(Affectation, CodeAffectation);
//                             EtatMensuellePaie.CalcFields("Nombre Salarier");
//                             NombreSalarié := EtatMensuellePaie.Count;
//                         end;

//                         CurrPage.Update;
//                     end;
//                 }
//                 field("Nombre Salarié"; NombreSalarié)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             repeater("Group0001")
//             {
//                 ShowCaption = false;
//                 field("<Matricule>"; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Matricule';

//                     trigger OnValidate()
//                     begin
//                         if CodeAffectation = '' then Error(Text005);
//                         if RecGEmp.Get(REC.Matricule) then begin
//                             REC.Affectation := CodeAffectation;
//                             RecGEmp.Affectation := CodeAffectation;
//                             RecGEmp.Modify;
//                         end;

//                         if CodeAffectation = '' then Error(Text005);
//                         if RecGEmp.Get(REC.Matricule) then begin
//                             REC.Affectation := CodeAffectation;
//                             RecGEmp.Affectation := CodeAffectation;
//                             RecGEmp.Modify;
//                         end;
//                     end;
//                 }
//                 field("<Nom>"; REC.Nom)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nom';
//                 }
//                 field("<Jours Travaillé>"; REC."Jours Travaillé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Jours Travaillé';
//                 }
//                 field("<Heure Travaillé>"; REC."Heure Travaillé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heure Travaillé';
//                 }
//                 field("<Férier>"; REC.Férier)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Férier';
//                 }
//                 field("<Droit Congé>"; REC."Droit Congé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Droit Congé';
//                 }
//                 field("<Congé Spéciale>"; REC."Congé Spéciale")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Congé Spéciale';
//                 }
//                 field("<Nbr Jours Deplacement>"; REC."Nbr Jours Deplacement")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nbr Jours Deplacement';
//                 }
//                 field("<Congé>"; REC.Congé)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Congé';

//                     trigger OnValidate()
//                     begin
//                         if REC.Congé + REC.Présence + REC."Congé Spéciale" > 26 then Error(Text004);
//                     end;
//                 }
//                 field("<Affectation>"; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Affectation';
//                 }
//                 field("<Kmetrage>"; REC.Kmetrage)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Kmetrage';
//                 }
//                 field("<Présence>"; REC.Présence)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Présence';
//                 }
//                 field("<Heure Travaillé réel>"; REC."Heure Travaillé réel")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heure Travaillé réel';
//                 }
//                 field("<Heures Retenues>"; REC."Heures Retenues")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heures Retenues';
//                 }
//                 field("<Jours Sup Normal>"; REC."Jours Sup Normal")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Jours Sup Normal';
//                 }
//                 field("<Jours Sup Calculé Majoré à 75%>"; REC."Jours Sup Calculé Majoré à 75%")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Jours Sup Calculé Majoré à 75%';
//                 }
//                 field("<Heure Normal>"; REC."Heure Normal")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heure Normal';
//                 }
//                 field("<Heure Sup Majoré à 75 %>"; REC."Heure Sup Majoré à 75 %")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heure Sup Majoré à 75 %';
//                 }
//                 field("<Heure Sup Majoré à 100 %>"; REC."Heure Sup Majoré à 100 %")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heure Sup Majoré à 100 %';
//                 }
//                 field("<Total nb heures>"; REC."Total nb heures")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Total nb heures';
//                 }
//                 field("<Nombre de jour>"; REC."Nombre de jour")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nombre de jour';
//                 }
//                 field("<Heures Normal>"; REC."Heures Normal")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Heures Normal';
//                 }
//                 field("<Rappel Salarié>"; REC."Rappel Salarié")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Rappel Salarié';
//                 }
//                 field("<Rappel>"; REC.Rappel)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Rappel';
//                 }
//                 field("<Retenu>"; REC.Retenu)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Retenu';
//                 }
//                 field("<Cession>"; REC.Cession)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cession';
//                 }
//                 field("<Qualification>"; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Qualification';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action("<Récupérer Employée>")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Récupérer Employée';

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     if not Confirm(Text003) then exit;
//                     RecGEmp.SetRange(RecGEmp.Blocked, false);
//                     if RecGEmp.FindFirst then
//                         repeat
//                             Saut := false;
//                             EtatMensuellePaie.Matricule := RecGEmp."No.";
//                             EtatMensuellePaie.Nom := RecGEmp."First Name";
//                             EtatMensuellePaie."Nombre de jour" := 30;
//                             EtatMensuellePaie."Heures Normal" := 30;
//                             EtatMensuellePaie."Type Salarié" := 1;
//                             EtatMensuellePaie.Qualification := RecGEmp.Qualification;
//                             EtatMensuellePaie.Affectation := RecGEmp.Affectation;
//                             FinDeMois := CalcDate('+FM', WorkDate);
//                             if (RecGEmp."Birth Date" <> 0D) and (((FinDeMois - RecGEmp."Birth Date") / 365) > 60) then
//                                 Saut := true;
//                             if not Saut then
//                                 if not EtatMensuellePaie.Insert then EtatMensuellePaie.Modify;
//                         until RecGEmp.Next = 0;
//                     Message(Text002);
//                 end;
//             }
//             action("Déverouiller")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Déverouiller';

//                 trigger OnAction()
//                 begin
//                     CurrPage.Editable := true
//                 end;
//             }
//             action(Verouiller)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     CurrPage.Editable := false
//                 end;
//             }
//             action(Imprimer)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     Report.RunModal(52048902, true, true, Rec)
//                 end;
//             }
//             action(Importation)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     //DYS dataport obsolet
//                     // DATAPORT.Run(39001405);
//                     CurrPage.Update;
//                 end;
//             }
//             action(Valider)
//             {
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 begin
//                     //IF CodeAffectation<>'' THEN EtatMensuellePaie.SETRANGE(Affectation,CodeAffectation);
//                     EtatMensuellePaie.SetFilter(Présence, '<>%1', 0);
//                     Report.Run(Report::"Defalcatiuon Paie", true, true, EtatMensuellePaie)
//                 end;
//             }
//         }
//     }

//     var
//         EtatMensuellePaie: Record "Etat Mensuelle Paie";
//         RecGEmp: Record Employee;
//         i: Integer;
//         d: Dialog;
//         //GL3900  MgmtSuppHour: Codeunit "Management of Work Hours";
//         ToTNbrjours: Decimal;
//         ToTNbrHeures: Decimal;
//         CodeQualification: Code[20];
//         CodeAffectation: Code[20];
//         "NombreSalarié": Integer;
//         FinDeMois: Date;
//         Saut: Boolean;
//         dialogMess1: label 'Défalcation des Heures Supp.';
//         dialogMess2: label 'Mise à jours des lignes défalcation.';
//         Text001: label 'Integrer Les Employées ?';
//         Text002: label 'Tâche chevée Avec Succée';
//         Text003: label 'Attention Vous Allez Supprimer Toutes Les Informations !!!! Continuer Quand Meme ??????????????????';
//         Text004: label 'Vous Avez Depasser Le Nombre De Jours Autorisés';
//         Text005: label 'Vous Devez Chosir Une Affectation';
// }

