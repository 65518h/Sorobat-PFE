//GL3900 
// page 71500 "Rec. Expenses to repay Header1"
// {
//     //GL2024  ID dans Nav 2009 : "39001500"
//     DataCaptionFields = "No.", "Employee No.", "First Name", "Last Name";
//     Editable = true;
//     PageType = Card;
//     SourceTable = "Expenses to repay Header";
//     SourceTableView = SORTING("No.") ORDER(Ascending) WHERE(Repaied = FILTER(false));
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     Caption = 'Rec. Expenses to repay Header1';
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
//                 action("&Valider")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Valider';

//                     trigger OnAction()
//                     begin
//                         MngtRepayableExpenses.EnregDoc(Rec);
//                     end;
//                 }
//                 action("&Unpost")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Unpost';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         MngtRepayableExpenses.DevaliderDoc(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         MngtRepayableExpenses: Codeunit "Mgmt. of repayable expenses";
// }

