Codeunit 8004176 "Job Reg.-Show Ledger2"
{
    TableNo = "Job Register";

    trigger OnRun()
    begin
        JobLedgEntry.SetRange("Entry No.", rec."From Entry No.", rec."To Entry No.");
        PAGE.Run(page::"Job Ledger Entries", JobLedgEntry);
    end;

    var
        JobLedgEntry: Record "Job Ledger Entry";
}

