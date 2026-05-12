Codeunit 8001536 "Workflow SingleInstance"
{

    //GL2024  ID dans Nav 2009 : "8004203"
    SingleInstance = true;

    trigger OnRun()
    begin
        //#8774
        fInitSetup();
        //#8774//
    end;

    var
        wNotClientLoaded: Boolean;
        wSelectedClient: Option ,Classic,RoleTailored,NAS;

    local procedure fInitSetup()
    begin
        //#8774
        if (wNotClientLoaded) then begin
            wNotClientLoaded := false;
            wSelectedClient := Wselectedclient::Classic;
            if (not GuiAllowed) then
                wSelectedClient := Wselectedclient::NAS;
            if (ISSERVICETIER) then
                wSelectedClient := Wselectedclient::RoleTailored;
        end;
        //#8774//
    end;


    procedure fGetSelectedClient() retour: Integer
    begin
        //#8774
        retour := wSelectedClient;
        //#8774//
    end;
}

