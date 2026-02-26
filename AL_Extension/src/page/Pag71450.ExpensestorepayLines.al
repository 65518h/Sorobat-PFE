//GL3900 
// page 71450 "Expenses to repay Lines"
// {
//     //GL2024  ID dans Nav 2009 : "39001450"
//     DelayedInsert = true;
//     PageType = CardPart;
//     SourceTable = "Expenses to repay Lines";
//     Caption = 'Expenses to repay Lines';
//     ApplicationArea = All;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1180250000)
//             {
//                 ShowCaption = false;
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Reason Code"; Rec."Reason Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("External Document No."; Rec."External Document No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Line amount"; Rec."Line amount")
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
//         EnTeteFraisMission: Record "Expenses to repay Header";
//         CodeMotif: Record "Reason Code";
//         ExpensesRepayLines: Record "Expenses to repay Lines";
// }

