Page 59995 "Ligne Gestion Rôles"
{
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Ligne Gestion Roles";
    Caption = 'Line Management Roles';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field(Affecter; REC.Affecter)
                {
                    ApplicationArea = all;
                }
                field("Id Formulaire"; REC."Id Formulaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Formulaire"; REC."Nom Formulaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REC.SetCurrentkey("Id Formulaire");
    end;

    var
        BlnOK: Boolean;


    procedure GenererRoles(CdeCodeEntete: Code[20]; CdeRoles: Code[20]; TxtNomRoles: Text[30])
    var
        RecRoles: Record "Permission Set";
        RecRolesPermissiosn: Record Permission;
        RecLigneGestionRoles: Record "Ligne Gestion Roles";
        RecAffectationUtlisateur: Record "Affectation Utlisateur";
    //GL2024  RecMemberOf: Record 2000000003;
    begin

        RecAffectationUtlisateur.SetRange(Affecter, true);
        RecLigneGestionRoles.SetRange(Code, CdeCodeEntete);

        //RecRoles.INIT;
        //RecRoles."Role ID":=CdeRoles;
        //RecRoles.Name:=TxtNomRoles;
        if RecRoles.Insert then BlnOK := true else RecRoles.Modify;
        RecLigneGestionRoles.SetRange(Code, CdeCodeEntete);
        RecLigneGestionRoles.SetRange(Affecter, true);
        if RecLigneGestionRoles.FindFirst then
            repeat
                RecRolesPermissiosn."Role ID" := CdeRoles;
                RecRolesPermissiosn."Object Type" := RecRolesPermissiosn."object type"::Page;
                RecRolesPermissiosn."Object ID" := RecLigneGestionRoles."Id Formulaire";
                if RecRolesPermissiosn.Insert then BlnOK := true else RecRolesPermissiosn.Modify;
                RecLigneGestionRoles.Affecter := false;
                RecLigneGestionRoles.Modify;
            until RecLigneGestionRoles.Next = 0;

        /*GL2024  if RecAffectationUtlisateur.FindFirst then
              repeat
                  RecMemberOf."User ID" := RecAffectationUtlisateur.UserId;
                  RecMemberOf."Role ID" := CdeRoles;
                  if RecMemberOf.Insert then BlnOK := true else RecMemberOf.Modify;
                  RecAffectationUtlisateur.Affecter := false;
                  RecAffectationUtlisateur.Modify;
              until RecAffectationUtlisateur.Next = 0;*/
    end;
}

