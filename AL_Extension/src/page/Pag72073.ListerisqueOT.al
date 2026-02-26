//GL3900 
// Page 72073 "Liste risque OT"
// {
//     //GL2024  ID dans Nav 2009 : "39002073"

//     PageType = listPart;

//     SourceTable = "Risque OT";
//     Caption = 'Liste risque OT';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;

//                 field(cd_risque; Rec.cd_risque)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé"; Rec.Libellé)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_DI; Rec.cd_DI)
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

