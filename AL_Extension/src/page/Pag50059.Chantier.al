// Page 50059 Chantier
// {
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Chantier Loyer";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Parametrage Chantier';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affaire; rec.Affaire)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(General)
//             {
//                 action(New)
//                 {
//                     Visible = false;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         CDU50032: Codeunit 50032;
//                     begin
//                         CDU50032.TransfertSTDJobToDysJob();
//                     end;
//                 }
//             }
//         }
//     }
// }

