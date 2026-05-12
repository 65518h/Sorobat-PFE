PageExtension 50079 "Resource Ledger Entries_PagEXT" extends "Resource Ledger Entries"
{
    var
        wUserMgt: Codeunit "User Setup Management";

    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN
        //MASK
        lMaskMgt.ResLedgEntry(Rec);
        //MASK//

    end;
}

