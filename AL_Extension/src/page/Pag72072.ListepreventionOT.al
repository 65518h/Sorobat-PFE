//GL3900 
// Page 72072 "Liste prevention OT"
// {
//     //GL2024  ID dans Nav 2009 : "39002072"
//     PageType = ListPart;
//     SourceTable = "Prevention OT";
//     Caption = 'Liste prevention OT';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(cd_prevention; Rec.cd_prevention)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé"; Rec.Libellé)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_di; Rec.cd_di)
//                 {
//                     ApplicationArea = Basic;
//                     Enabled = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

