page 50084 "Alerte CERTIFICAT NON Vehicule"
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
        rec.SETRANGE("Date Expiration Certificat de", TODAY, TODAY + 35);
        IF rec.COUNT = 0 THEN CurrPage.CLOSE;
    end;

    var
        Text19036597: Label '************************** ALERTE CERTIFICAT DE NON IMPOSITION VEHICULE ECHUE *****************************';
}

