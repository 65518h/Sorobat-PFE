Page 50241 "Regroupement Rapport DG"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Regroupement Rapport DG";
    SourceTableView = sorting(Type, Code);
    ApplicationArea = all;
    Caption = 'Regroupement Rapport DG';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field("Code"; REC.Code)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Designation; REC.Designation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantité Estimer"; REC."Quantité Estimer")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Quantité Livré"; REC."Quantité Livré")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Integer"; REC.Integer)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(not CurrPage.LookupMode);
    end;

    var
        Text001: label 'Seulement Type Nouvelle Entrée Est Permis';

    local procedure IntegerOnActivate()
    begin
        if REC.Type <> REC.Type::"Nouvelle Entrée" then Error(Text001);
    end;
}

