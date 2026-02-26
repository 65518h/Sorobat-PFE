//GL3900
// Codeunit 39001407 "EmpEntry-Apply Posted Entries2"
// {
//     //GL2024  ID dans Nav 2009 : "39001407"
//     Permissions = TableData "Employee Ledger Entry2" = rimd;
//     TableNo = "Employee Ledger Entry2";

//     trigger OnRun()
//     begin
//         with Rec do begin
//             //GL2024    PostApplication.SetValues("Document No.", "Posting Date");
//             PostApplication.LookupMode(true);
//             if Action::LookupOK = PostApplication.RunModal then begin
//                 GenJnlLine.Init;
//                 //GL2024      PostApplication.GetValues(GenJnlLine."Document No.", GenJnlLine."Posting Date");
//                 if GenJnlLine."Posting Date" < "Posting Date" then
//                     Error(
//                       Text003,
//                       GenJnlLine.FieldCaption("Posting Date"), FieldCaption("Posting Date"), TableCaption);
//             end else
//                 exit;

//             Window.Open(Text001);

//             SourceCodeSetup.Get;

//             GenJnlLine."Account Type" := GenJnlLine."account type"::"IC Partner";
//             GenJnlLine."Account No." := "Employee No.";
//             CalcFields("Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)");
//             GenJnlLine.Correction :=
//               ("Debit Amount" < 0) or ("Credit Amount" < 0) or
//               ("Debit Amount (LCY)" < 0) or ("Credit Amount (LCY)" < 0);
//             GenJnlLine."Document Type" := "Document Type";
//             GenJnlLine.Description := Description;
//             GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
//             GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
//             GenJnlLine."Posting Group" := "Employee Posting Group";
//             GenJnlLine."Source Type" := GenJnlLine."source type"::"IC Partner";
//             GenJnlLine."Source Type" := GenJnlLine."source type"::"IC Partner";
//             GenJnlLine."Source No." := "Employee No.";
//             GenJnlLine."Source Code" := SourceCodeSetup."Purchase Entry Application";
//             GenJnlLine."System-Created Entry" := true;

//             EntryNoBeforeApplication := FindLastApplDtldEmplLedgEntry;

//             //  GenJnlPostLine.EmplPostApplyEmplLedgEntry(GenJnlLine,Rec);

//             EntryNoAfterApplication := FindLastApplDtldEmplLedgEntry;
//             if EntryNoAfterApplication = EntryNoBeforeApplication then
//                 Error(Text004);

//             Commit;
//             Window.Close;
//             Message(Text002);
//         end;
//     end;

//     var
//         Text001: label 'Posting application...';
//         Text002: label 'The application was successfully posted.';
//         Text003: label 'The %1 entered must not be before the %2 on the %3.';
//         Text004: label 'The application was successfully posted though no entries have been applied.';
//         SourceCodeSetup: Record "Source Code Setup";
//         GenJnlLine: Record "Gen. Journal Line";
//         PostApplication: Page "Post Application";
//         GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
//         Window: Dialog;
//         EntryNoBeforeApplication: Integer;
//         EntryNoAfterApplication: Integer;

//     local procedure FindLastApplDtldEmplLedgEntry(): Integer
//     var
//         DtldEmplLedgEntry: Record "Detailed Employee Ledg. Entry";
//     begin
//         DtldEmplLedgEntry.LockTable;
//         if DtldEmplLedgEntry.Find('+') then
//             exit(DtldEmplLedgEntry."Entry No.")
//         else
//             exit(0);
//     end;
// }

