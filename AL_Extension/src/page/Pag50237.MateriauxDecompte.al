Page 50237 "Materiaux Decompte"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Detail Rapport DG";
    ApplicationArea = all;
    Caption = 'Materiaux Decompte';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Marché"; REC.Marché)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Rapport"; REC."Date Rapport")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Niveau; REC.Niveau)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Designatiion; REC.Designatiion)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Unité"; REC.Unité)
                {
                    ApplicationArea = all;
                }
                field("Quantité Marché"; REC."Quantité Marché")
                {
                    ApplicationArea = all;
                }
                field("Quantité Exécuté"; REC."Quantité Exécuté")
                {
                    ApplicationArea = all;
                }
                field("Quantité Livré"; REC."Quantité Livré")
                {
                    ApplicationArea = all;
                }
                field(Difference; REC.Difference)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Observation; REC.Observation)
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

