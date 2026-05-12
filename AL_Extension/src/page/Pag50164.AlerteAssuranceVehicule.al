Page 50164 "Alerte  Assurance Vehicule"
{
    Editable = true;
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    Caption = 'Alerte  Assurance Vehicule';
    layout
    {
        area(content)
        {
            label(Control1000000017)
            {
                ApplicationArea = all;
                Caption = '************************** ALERTE ASSURANCE VEHICULE ECHU *****************************';
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
                field("Date Expiration Assurance"; REC."Date Expiration Assurance")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Delai Prochain"; REC."Delai Prochain")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if not Confirm(Text001) then exit;
                        if REC."Delai Prochain" = 1 then REC."date Expiration Assurance" := CalcDate('12M', REC."Date Expiration Assurance");// Annee
                        if REC."Delai Prochain" = 2 then REC."date Expiration Assurance" := CalcDate('6M', REC."Date Expiration Assurance");// 6 Mois
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
        //  REC.SetRange("Date Assurance", Today, Today + 30);
        Rec.SETRANGE("Date Expiration Assurance", TODAY, TODAY + 30);
        if REC.Count = 0 then CurrPage.Close;
    end;

    var
        Text001: label 'Confirmer Cette Action ?';
        Text19029982: label '************************** ALERTE ASSURANCE VEHICULE ECHU *****************************';
}

