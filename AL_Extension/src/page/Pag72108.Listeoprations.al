//GL3900 
// Page 72108 "Liste opérations"
// {
//     //GL2024  ID dans Nav 2009 : "39002108"
//     DelayedInsert = true;
//     Editable = true;
//     PageType = List;
//     SourceTable = "Opération";
//     ApplicationArea = all;
//     UsageCategory = Lists;

//     Caption = 'Liste opérations';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;

//                 field("code operation"; Rec."code operation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé"; Rec.Libellé)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Typ; Rec.Typ)
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

