page 52049051 "Detail consommation conge"
{//GL2024  ID dans Nav 2009 : "39001579"
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Detail de congé consommé";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Detail consommation conge';
    layout
    {
        area(content)
        {
            repeater(Control1102752000)
            {
                ShowCaption = false;
                Editable = false;
                field("N°Sequence"; Rec."N°Sequence")
                {
                    ApplicationArea = Basic;
                }
                field("Salarié"; Rec.Salarié)
                {
                    ApplicationArea = Basic;
                }
                field("Annee de Consommation"; Rec."Annee de Consommation")
                {
                    ApplicationArea = Basic;
                }
                field("Nbre consommé"; Rec."Nbre consommé")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if RecUser.Get(UserId) then
            if RecUser."Modif Salarie" then
                CurrPage.Editable := true
            else
                CurrPage.Editable := false;
    end;

    var
        RecUser: Record "User Setup";
}

