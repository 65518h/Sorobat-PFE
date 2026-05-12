codeunit 50039 ResJnlPostLineEvent
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::table, Database::"Res. Ledger Entry", 'OnAfterCopyFromResJnlLine', '', true, true)]
    procedure OnAfterCopyFromResJnlLine(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    var
        Res: Record Resource;
    begin
        Res.GET(ResJournalLine."Resource No.");
        ResLedgerEntry."Resource Group No." := fGetResourceGroupNo(Res, ResLedgerEntry."Resource Group No.");
        //#8927//
    end;

    procedure fGetResourceGroupNo(pResource: Record Resource; pDefaultGrpResNo: Code[20]) GroupResNo: code[20]
    var

        lResGrpRes: Record "Resource / Resource Group";
    begin

        //#8927
        GroupResNo := pDefaultGrpResNo;
        lResGrpRes.SETRANGE("Resource No.", pResource."No.");
        lResGrpRes.SETRANGE("Resource Group No.", pDefaultGrpResNo);
        IF (lResGrpRes.ISEMPTY()) THEN BEGIN
            GroupResNo := pResource."Resource Group No.";
        END;
        //#8927//
    end;

    var
        myInt: Integer;
}