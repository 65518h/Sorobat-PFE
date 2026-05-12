page 50074 "Alerte Vignette Vehicule 0"
{
    Editable = false;
    PageType = Card;
    SourceTable = Véhicule;

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field("N° Vehicule"; rec."N° Vehicule")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Désignation; rec.Désignation)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Immatriculation; rec.Immatriculation)
                {
                }
                field("Date D'immatriculation"; rec."Date D'immatriculation")
                {
                }
                field("Date Expiration AT"; rec."Date Expiration AT")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Date Expiration Assurance"; rec."Date Expiration Assurance")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Date Expiration Visite Tech"; rec."Date Expiration Visite Tech")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Date Expiration Vignette"; rec."Date Expiration Vignette")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.SETRANGE("Date Expiration Vignette", TODAY, TODAY + 35);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Text19035895: Label '************************** ALERTE VIGNETTE VEHICULE ECHUE *****************************';
}

