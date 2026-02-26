Page 52049076 "PR Reparation"
{//GL2024  ID dans Nav 2009 : "39004716"
    PageType = ListPart;
    SourceTable = "PR Réparation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Quantité Stock"; Rec."Quantité Stock")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field(Magasin; Rec.Magasin)
                {
                    ApplicationArea = Basic;
                }
                field("Quantité"; Rec.Quantité)
                {
                    ApplicationArea = Basic;
                }
                field(DA; Rec.DA)
                {
                    ApplicationArea = Basic;
                }
                field("Bon Sortie"; Rec."Bon Sortie")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Valider; Rec.Valider)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

