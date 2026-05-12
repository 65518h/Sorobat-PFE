// Page 50180 "Mise Ajour Affectation Financi"
// {
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Bank Account Ledger Entry";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Mise Ajour Affectation Financi';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Entry No."; REC."Entry No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bank Account No."; REC."Bank Account No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Posting Date"; REC."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Document No."; REC."Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Affectation Financiere"; REC."Affectation Financiere")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         CuGenJnlPostLine.UpdateAffectationFinancier(REC."Entry No.", REC."Affectation Financiere");
//                     end;
//                 }
//                 field("Amount (LCY)"; REC."Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Source Code"; REC."Source Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Debit Amount (LCY)"; REC."Debit Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Credit Amount (LCY)"; REC."Credit Amount (LCY)")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("External Document No."; REC."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Folio"; REC."N° Folio")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         CuGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line_CDU12";

// }

