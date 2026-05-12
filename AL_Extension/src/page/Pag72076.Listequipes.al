//GL3900 
// Page 72076 "Liste équipes"
// {
//     //GL2024  ID dans Nav 2009 : "39002076"
//     Caption = 'Teams list';

//     PageType = list;

//     SourceTable = Equipes;

//     ApplicationArea = all;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;

//                 field("code équipe"; Rec."code équipe")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé"; Rec.Libellé)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

