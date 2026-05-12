//GL3900 
// page 71449 "Expenses to repay Header"
// {
//     //GL2024  ID dans Nav 2009 : "39001449"
//     PageType = Card;
//     SourceTable = "Expenses to repay Header";
//     SourceTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Proposed));
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
//                 field("Global dimension 1"; rec."Global dimension 1")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global dimension 2"; rec."Global dimension 2")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part("Expenses to repay Lines"; "Expenses to repay Lines")
//             {
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
//                 action("Test Report")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         Header.SETRANGE("No.", rec."No.");
//                         IF Header.FIND('-') THEN
//                             REPORT.RUN(8099026, TRUE, TRUE, Header);
//                     end;
//                 }
//                 action("P&ost")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         MngtRepayableExpenses.EnregDoc(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         MngtRepayableExpenses: Codeunit "Mgmt. of repayable expenses";
//         Header: Record "Expenses to repay Header";
// }

