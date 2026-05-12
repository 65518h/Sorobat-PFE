// page 50355 "Liste STC Salarié Valider"
// {
//     //GL2024  New Page
//     PageType = List;
//     SourceTable = "STC Salaries";
//     SourceTableView = where(Status = filter(Cloturé));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste STC Salarié Valider';
//     CardPageId = "STC Salarie Valider";
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("Code STC"; Rec."Code STC")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Maticule; Rec.Maticule)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Description Qualification"; Rec."Description Qualification")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Motif; Rec.Motif)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Chantier; Rec.Chantier)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deccription Affectation"; Rec."Deccription Affectation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Salarié"; Rec.Salarié)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Saisie"; Rec."Date Saisie")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date Comptabilisation"; Rec."Date Comptabilisation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Mois; Rec.Mois)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Annee; Rec.Annee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net A Payer"; Rec."Net A Payer")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Notifier; Rec.Notifier)
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Notifier par"; Rec."Notifier par")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Notification"; Rec."Date Notification")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

