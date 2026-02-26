// Page 50055 "Ligne Affectation Employé"
// {
//     PageType = ListPart;
//     SourceTable = "Ligne Affectation Employé";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Ligne Affectation Employé';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Employé"; rec.Employé)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nom et Prenom"; rec."Nom et Prenom")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field(Zone; rec.Zone)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Nouveau Affectation"; rec."Nouveau Affectation")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Chantier; rec.Chantier)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Affectation; rec.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Qualification; rec.Qualification)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Salaire Brut"; rec."Salaire Brut")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Salaire de Base"; rec."Salaire de Base")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Observation; rec.Observation)
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

