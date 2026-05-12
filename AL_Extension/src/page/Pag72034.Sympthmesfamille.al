//GL3900 
// Page 72034 "Sympthômes famille"
// { //GL2024  ID dans Nav 2009 : "39002034"
//     PageType = ListPart;
//     SourceTable = "sympthôme famille";

//     Caption = 'Sympthômes famille';
//     ApplicationArea = All;
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

