// Page 50282 "Subform Ligne Pointage Employé"
// {
//     PageType = ListPart;
//     SourceTable = "Ligne Pointage Employé";
//     ApplicationArea = all;
//     Caption = 'Subform Ligne Pointage Employé';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N°"; REC."N°")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Employé"; REC.Employé)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nom et Prenom"; REC."Nom et Prenom")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Present; REC.Present)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Heure Debut Service"; REC."Heure Debut Service")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Fin Service"; REC."Heure Fin Service")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre Heure"; REC."Nbre Heure")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Categorie; REC.Categorie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Salaire Brut"; REC."Salaire Brut")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Salaire de Base"; REC."Salaire de Base")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Journée"; REC.Journée)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Chantier; REC.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

