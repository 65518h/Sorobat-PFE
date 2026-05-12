Page 59994 "Entete Gestion Rôles"
{
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Entete Gestion Roles";
    Caption = 'Entete Gestion Rôles';

    layout
    {
        area(content)
        {
            field(Code; REC.Code)
            {
                ApplicationArea = Basic;

            }
            field(Libelle; REC.Libelle)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            // field(NUMnav1; REC.NUMnav)
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;
            // }
            // field(Art; rec.Art)
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;
            // }

            // field(montant; REC.montant)
            // {
            //     ApplicationArea = Basic;
            // }
            part(SubLigne; 59995)
            {
                SubpageLink = Code = FIELD(Code);
            }

            part(SubUser; 59997)
            {
            }
            field(Ordre; REC.Ordre)
            {
                ApplicationArea = Basic;
            }
            field(CdeCodeRoles; CdeCodeRoles)
            {
                ApplicationArea = Basic;
                Caption = 'Code Rôle';
                //GL2024  TableRelation = "User Role";
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Generer)
            {
                ApplicationArea = Basic;
                Caption = 'Generer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if (CdeCodeRoles = '') then Error(Text002);
                    if not Confirm(Text001, false) then exit;
                    //  CurrPage.SubLigne.page.GenererRoles(rec.NUMnav, CdeCodeRoles, TxtNomRoles);
                    CurrPage.SubLigne.page.GenererRoles(rec.Code, CdeCodeRoles, TxtNomRoles);
                    CurrPage.Update;
                    CurrPage.SubUser.page.UpdateForm;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // rec.SetCurrentkey(montant);
        Rec.SETCURRENTKEY(Ordre);
    end;

    var
        RecRoles: Record "Permission Set";
        RecRolesPermissiosn: Record Permission;
        RecLigneGestionRoles: Record 59995;
        CdeCodeRoles: Code[20];
        TxtNomRoles: Text[30];
        Text001: label 'Lancer La Génération Des Rôles ?';
        Text002: label 'Preciser Code Roles';
}

