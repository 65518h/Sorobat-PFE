PageExtension 50316 "Config. Packages_PagEXT" extends "Config. Packages"
{
    layout
    {


    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin

        if UserSetup.Get(UserId) then begin
            if not UserSetup."Autoriser Config Packages" then
                Error(
                  'Accès refusé : vous n''êtes pas autorisé à ouvrir la page Config. Packages.'
                );
        end;
    end;

}