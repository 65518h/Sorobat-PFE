//GL3900 
// page 71446 "Salary grid lines List"
// {
//     //GL2024  ID dans Nav 2009 : "39001446"
//     Caption = 'Salary grid lines List';
//     PageType = List;
//     SourceTable = "Salary grid lines";
//     SourceTableView = sorting(Echelle)
//                       order(ascending);
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1180250000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field(Echelle; Rec.Echelle)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Collège"; Rec.Collège)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Grade; Rec.Grade)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis salary"; Rec."Basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInit()
//     begin
//         CurrPage.LookupMode := true;
//     end;

//     var
//         ListCategory: page "Collége";//39001444
//         Cat: Record "Collège";
// }

