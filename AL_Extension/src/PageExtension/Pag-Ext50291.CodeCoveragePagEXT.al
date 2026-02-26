PageExtension 50291 "Code Coverage_PagEXT" extends "Code Coverage"
{
    layout
    {
    }

    actions
    {
        addafter(Start)
        {
            action("Créer Rôles")
            {
                Caption = 'Créer Rôles';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    // >> HJ DSFT 12-10-2012
                    REPORT.RUN(Report::"Generateur Autorisation", TRUE, TRUE, Rec);
                    // >> HJ DSFT 12-10-2012
                end;
            }

        }
        addafter(Start_Promoted)
        {
            actionref("Créer Rôles1"; "Créer Rôles")
            {

            }
        }

    }
    var

        RecRolesTemporaire: Record "Roles Temporaire";
        RecCodeCoverage: Record "Code Coverage";
}