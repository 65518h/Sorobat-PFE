Page 50268 "BR Heures Sup"
{
    Editable = true;
    PageType = List;
    SourceTable = "BR Heure Suplémentaire";
    SourceTableView = where(Cloturer = const(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'BR Hours sup';
    layout
    {
        area(content)
        {
            field(MoisHS; MoisHS)
            {
                ApplicationArea = all;
                Caption = 'Mois';
            }
            field("AnnéeHS"; AnnéeHS)
            {
                ApplicationArea = all;
                Caption = 'Année';
            }
            repeater(Control1)
            {
                Editable = true;
                ShowCaption = false;
                field(Mois; REC.Mois)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Annee; REC.Annee)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Maticule; REC.Maticule)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Salarié"; REC.Salarié)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type salarié"; REC."Type salarié")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Qualification; REC.Qualification)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description Qualification"; REC."Description Qualification")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Affectation; REC.Affectation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Deccription Affectation"; REC."Deccription Affectation")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Base Calcule"; REC."Base Calcule")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Régime"; REC.Régime)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Heures Par mois"; REC."Heures Par mois")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Max heure sup Mensuel"; REC."Max heure sup Mensuel")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Nombre Heure Suplémentaire"; REC."Nombre Heure Suplémentaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Net A Payer"; REC."Net A Payer")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print';

                trigger OnAction()
                begin

                    RecBRHeureSuplémentaire.Reset;
                    RecBRHeureSuplémentaire.SetRange(Mois, MoisHS);
                    RecBRHeureSuplémentaire.SetRange(Annee, AnnéeHS);
                    Report.RunModal(Report::"Heure Sup BR Impression", true, true, RecBRHeureSuplémentaire)
                end;
            }
            action(Action1000000039)
            {
                ApplicationArea = all;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Print';

                trigger OnAction()
                begin

                    RecBRHeureSuplémentaire.Reset;
                    RecBRHeureSuplémentaire.SetRange(Mois, MoisHS);
                    RecBRHeureSuplémentaire.SetRange(Annee, AnnéeHS);
                    Report.RunModal(Report::"Heure Sup BR Récap", true, true, RecBRHeureSuplémentaire)
                end;
            }
        }
    }

    var
        MoisHS: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
        "AnnéeHS": Integer;
        "RecBRHeureSuplémentaire": Record "BR Heure Suplémentaire";
}

