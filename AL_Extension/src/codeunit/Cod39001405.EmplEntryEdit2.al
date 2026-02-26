//GL3900
// Codeunit 39001405 "Empl. Entry-Edit2"
// {
//     //GL2024  ID dans Nav 2009 : "39001405"
//     Permissions = TableData "Employee Ledger Entry2" = imd,
//                   TableData "Detailed Employee Ledg. Entry" = m;
//     TableNo = "Employee Ledger Entry2";

//     trigger OnRun()
//     begin
//         EmplLedgEntry := Rec;
//         EmplLedgEntry.LockTable;
//         EmplLedgEntry.Find;
//         EmplLedgEntry.TestField(Open, true);
//         EmplLedgEntry."On Hold" := rec."On Hold";
//         EmplLedgEntry."Due Date" := rec."Due Date";
//         DtldEmplLedgEntry.SetRange("Employee Ledger Entry No.", EmplLedgEntry."Entry No.", EmplLedgEntry."Entry No.");
//         DtldEmplLedgEntry.ModifyAll("Initial Entry Due Date", rec."Due Date");
//         EmplLedgEntry."Pmt. Discount Date" := rec."Pmt. Discount Date";
//         EmplLedgEntry."Applies-to ID" := rec."Applies-to ID";
//         EmplLedgEntry.Validate("Pmt. Disc. Possible", rec."Pmt. Disc. Possible");
//         EmplLedgEntry.Modify;
//         Rec := EmplLedgEntry;
//     end;

//     var
//         EmplLedgEntry: Record "Employee Ledger Entry2";
//         DtldEmplLedgEntry: Record "Detailed Employee Ledg. Entry";

// }

