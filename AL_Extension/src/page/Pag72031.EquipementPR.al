//GL3900 
// page 72031 "Equipement PR"
// {
//     //GL2024  ID dans Nav 2009 : "39002031"
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Equipements PR";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Equipement PR';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(PR; Rec.PR)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Piéce Rechange';
//                 }
//                 field("Designation PR"; Rec."Designation PR")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Quantité"; Rec.Quantité)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         tem: Text[30];
//         t: Record Organe;
//         TXT: label 'All themes';
// }

