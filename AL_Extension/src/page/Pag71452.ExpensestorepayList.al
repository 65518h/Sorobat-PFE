//GL3900 
// page 71452 "Expenses to repay (List)"
// {
//     //GL2024  ID dans Nav 2009 : "39001452"
//     Caption = 'Expenses to repay (List)';
//     Editable = false;
//     PageType = List;
//     SourceTable = "Expenses to repay Header";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1180250000)
//             {
//                 ShowCaption = false;
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No."; Rec."Employee No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("""First Name""+' '+""Last Name"""; Rec."First Name" + ' ' + Rec."Last Name")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Employee';
//                 }
//                 field("Document amount"; Rec."Document amount")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Payment month"; Rec."Payment month")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Payment year"; Rec."Payment year")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Repaied; Rec.Repaied)
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

