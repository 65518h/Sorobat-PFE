Page 50300 "Liste Parc Pour Compta"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    Caption = 'Liste Parc Pour Compta';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Grande Famille"; REC."Grande Famille")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date D'immatriculation"; REC."Date D'immatriculation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Code Immo"; REC."Code Immo")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

