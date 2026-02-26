Page 50165 "Alerte  Visite Tech Vehicule"
{
    Editable = true;
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    Caption = 'Alerte  Visite Tech Vehicule';
    layout
    {
        area(content)
        {
            label(Control1000000017)
            {
                ApplicationArea = all;
                Caption = '************************** ALERTE VISITE TECHNIQUE VEHICULE ECHUE *****************************';
                Style = Unfavorable;
                StyleExpr = true;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Vehicule"; REC."N° Vehicule")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Immatriculation; REC.Immatriculation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("Date Visite Technique"; REC."Date Visite Technique")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Unfavorable;
                //     StyleExpr = true;
                // }
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
        // REC.SetRange("Date Visite Technique", Today, Today + 30);
        Rec.SETRANGE("Date Expiration Visite Tech", TODAY, TODAY + 30);
        if REC.Count = 0 then CurrPage.Close;
    end;

    var
        Text001: label 'Confirmer Cette Action ?';
        Text19010597: label '************************** ALERTE VISITE TECHNIQUE VEHICULE ECHUE *****************************';
}

