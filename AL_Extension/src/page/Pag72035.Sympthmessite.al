//GL3900 
// Page 72035 "Sympthômes site"
// { //GL2024  ID dans Nav 2009 : "39002035"

//     PageType = listPart;

//     SourceTable = "sympthôme site";

//     Caption = 'Sympthômes site';
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

