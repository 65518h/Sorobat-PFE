//GL3900 
// Page 72033 "Sympthômes équipement"
// { //GL2024  ID dans Nav 2009 : "39002033"
//     PageType = List;
//     SourceTable = "symptôme equipement";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Sympthômes équipement';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field(cd_sympt; Rec.cd_sympt)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Sympthome';
//                 }
//                 field("libellé"; Rec.libellé)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         symt.Reset;
//         symt.SetRange(symt.cd_sympt, Rec.cd_sympt);
//     end;

//     var
//         symt: Record "symptôme";
// }

