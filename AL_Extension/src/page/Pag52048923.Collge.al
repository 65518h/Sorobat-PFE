// page 52048923 "Collége"
// {
//     //GL2024  ID dans Nav 2009 : "39001444"
//     Caption = 'Collége';
//     Editable = true;
//     PageType = List;
//     SourceTable = "Collège";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {

//             repeater(Control1180250000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Exonoration Impot"; Rec."Exonoration Impot")
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
// }

