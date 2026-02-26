Page 50166 "Alerte Vignette Vehicule"
{
    Editable = false;
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    Caption = 'Alerte Vignette Vehicule';
    layout
    {
        area(content)
        {
            label(Control1000000017)
            {
                ApplicationArea = all;
                Caption = '************************** ALERTE VIGNETTE VEHICULE ECHUE *****************************';
                Style = Unfavorable;
                StyleExpr = true;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                }
                field("Date D'immatriculation"; REC."Date D'immatriculation")
                {
                    ApplicationArea = all;
                }
                field("Date Expiration Vignette"; REC."Date Expiration Vignette")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Delai Prochain"; REC."Delai Prochain")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if not Confirm(Text001) then exit;
                        if REC."Delai Prochain" = 1 then REC."Date Expiration Patente" := CalcDate('12M', REC."Date Expiration Patente");// Annee
                        if REC."Delai Prochain" = 2 then REC."Date Expiration Patente" := CalcDate('6M', REC."Date Expiration Patente");// 6 Mois
                        //IF "Delai Prochain"=3 THEN "Date Expiration AT":=CALCDATE('3M',"Date Expiration AT");// 6 Mois
                        //IF "Delai Prochain"=2 THEN "Date Expiration AT":=CALCDATE('6M',"Date Expiration AT");// 6 Mois
                        REC.Modify;
                    end;
                }
            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //  REC.SetRange("Date Vignette", Today + 30, Today + 35);
        Rec.SETRANGE("Date Expiration Vignette", TODAY + 30, TODAY + 35);
        if REC.Count = 0 then CurrPage.Close;
    end;

    var
        Text001: label 'Confirmer Cette Action ?';
        Text19035895: label '************************** ALERTE VIGNETTE VEHICULE ECHUE *****************************';
}

