Page 59997 "Affectation Utlisateur"
{
    PageType = ListPart;
    SourceTable = "Affectation Utlisateur";
    Caption = 'Affectation Utlisateur';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Affecter; REC.Affecter)
                {
                    ApplicationArea = all;
                }
                field(UserId; UserId)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("User Name"; REC."User Name")
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
        if RecUser.FindFirst then
            repeat
                RecAffectationUtlisateur.UserId := RecUser."User ID";
                //  RecAffectationUtlisateur."User Name" := RecUser.Name;
                if RecAffectationUtlisateur.Insert then;
            until RecUser.Next = 0;
    end;

    var
        RecUser: Record "User Setup";
        RecAffectationUtlisateur: Record "Affectation Utlisateur";


    procedure UpdateForm()
    begin
        CurrPage.Update(true);
    end;
}

