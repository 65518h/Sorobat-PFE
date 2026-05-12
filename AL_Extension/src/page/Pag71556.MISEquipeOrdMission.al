//GL3900 
// page 71556 "MIS-Equipe Ord. Mission"
// {
//     //GL2024  ID dans Nav 2009 : "39001556"
//     PageType = listPart;
//     SourceTable = "Equipe mission";

//     Caption = 'MIS-Equipe Ord. Mission';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 field("Employee No."; Rec."Employee No.")
//                 {
//                     ApplicationArea = Basic;
//                     LookupPageID = "FOR-Liste Aff. Pers. Formation";
//                 }
//                 field(Nom; Rec.Nom)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Nom2; Rec.Nom2)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Fonction; Rec.Fonction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 2"; Rec."Global Dimension 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global Dimension 1"; Rec."Global Dimension 1")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Direction; Rec.Direction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Service; Rec.Service)
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

