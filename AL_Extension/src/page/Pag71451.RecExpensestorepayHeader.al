//GL3900 
// page 71451 "Rec. Expenses to repay Header"
// {
//     //GL2024  ID dans Nav 2009 : "39001451"
//     DataCaptionFields = "No.", "Employee No.", "First Name", "Last Name";
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Expenses to repay Header";
//     SourceTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Validated));
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Employee No."; rec."Employee No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("First Name"; rec."First Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Last Name"; rec."Last Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total amount"; rec."Total amount")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part("Expenses to repay Lines"; "Expenses to repay Lines")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("No.");
//             }
//             group(Repayment)
//             {
//                 Caption = 'Repayment';
//                 field("Payment month"; rec."Payment month")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment year"; rec."Payment year")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Repaied; rec.Repaied)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment No."; rec."Payment No.")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 action("&Unpost")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Unpost';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     var
//                         MngtRepayableExpenses: Codeunit "Mgmt. of repayable expenses";
//                     begin
//                         MngtRepayableExpenses.DevaliderDoc(Rec);
//                     end;
//                 }
//             }
//         }
//     }
// }

