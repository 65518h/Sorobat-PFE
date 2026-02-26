// Page 50249 "Detail-Consom-Automate"
// {
//     Editable = false;
//     PageType = ListPart;
//     SourceTable = "Details Consommation BL Beton";
//     SourceTableView = sorting(Mat_Code);
//     ApplicationArea = All;
//     Caption = 'Detail-Consom-Automate';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Num_BL; REC.Num_BL)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Mat_Code; REC.Mat_Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Correspondance; REC.Correspondance)
//                 {
//                     ApplicationArea = all;
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

