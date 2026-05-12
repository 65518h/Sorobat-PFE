TableExtension 50222 "Reversal EntryEXT" extends "Reversal Entry"
{


    procedure fHasMaintenancePermission() retour: Boolean
    begin
        //#6979
        MaintenanceLedgEntry.SETPERMISSIONFILTER;
        retour := MaintenanceLedgEntry.ReadPermission;
        //#6979//
    end;

    var

        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
}

