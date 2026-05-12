Page 50004 "Bureau Ordre Envoyé à"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Bureau Ordre Envoyé a";
    Caption = 'Bureau Ordre Envoyé à';




    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Utilisateur; rec.Utilisateur)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Service; rec.Service)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Envoyé à"; rec."Envoyé à")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        "BlnEnvoyéA": Boolean;


    procedure "EnvoyéA"("ParaEnvoyéA": Boolean)
    begin
    end;
}

