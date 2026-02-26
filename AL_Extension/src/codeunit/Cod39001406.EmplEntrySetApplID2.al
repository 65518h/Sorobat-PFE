Codeunit 39001406 "Empl. Entry-SetAppl.ID2"
{
    //GL2024  ID dans Nav 2009 : "39001406"
    //GL3900  Permissions = TableData "Employee Ledger Entry2" = imd;

    trigger OnRun()
    begin
    end;

    var
        EmplEntryApplID: Code[20];

    /*
    //GL3900
        procedure SetApplId(var EmplLedgEntry: Record "Employee Ledger Entry2"; AppliesToID: Code[20])
        begin
            EmplLedgEntry.LockTable;
            if EmplLedgEntry.Find('-') then begin
                // Make Applies-to ID
                if EmplLedgEntry."Applies-to ID" <> '' then
                    EmplEntryApplID := ''
                else begin
                    EmplEntryApplID := AppliesToID;
                    if EmplEntryApplID = '' then begin
                        EmplEntryApplID := UserId;
                        if EmplEntryApplID = '' then
                            EmplEntryApplID := '***';
                    end;
                end;

                // Set Applies-to ID
                repeat
                    EmplLedgEntry.TestField(Open, true);
                    EmplLedgEntry."Applies-to ID" := EmplEntryApplID;
                    EmplLedgEntry.Modify;
                until EmplLedgEntry.Next = 0;
            end;
        end;*/
    //GL3900
}

