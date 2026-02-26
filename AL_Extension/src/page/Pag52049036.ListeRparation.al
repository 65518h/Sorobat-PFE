page 52049036 "Liste Réparation"
{//GL2024  ID dans Nav 2009 : "39004699"
    Editable = false;
    PageType = List;
    //GL2024
    SourceTableView = WHERE(Valider = CONST(false));
    //GL2024
    SourceTable = "Réparation Véhicule";
    CardPageId = "En-Tête Réparation";
    ApplicationArea = All;
    Caption = 'Liste Réparation';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Reparation"; REC."N° Reparation")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
                field("N° Intervenant"; REC."N° Intervenant")
                {
                    ApplicationArea = all;
                }
                field("Date Acceptation"; REC."Date Acceptation")
                {
                    ApplicationArea = all;
                }
                field("Heure Debut Réparation"; REC."Heure Debut Réparation")
                {
                    ApplicationArea = all;
                }
                field("Heure Fin Réparation"; REC."Heure Fin Réparation")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {


            actionref(Fiche1; Fiche) { }
            actionref("Fiche Véhicule1"; "Fiche Véhicule") { }
            actionref(Imprimer1; Imprimer) { }

        }
        area(navigation)
        {
            group("Réparation")
            {
                Caption = 'Réparation';
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    Image = Card;
                    RunObject = Page "En-Tête Réparation";
                    RunPageLink = "N° Reparation" = FIELD("N° Reparation");
                }

                action("Fiche Véhicule")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche Véhicule';
                    Image = Card;
                    RunObject = Page "Fiche Véhicule";
                }
                //GL3900 action("Fiche Intervenant")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Fiche Intervenant';
                //     //GL3900    RunObject = Page "Vendor List";
                // }
                action(Imprimer)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Reparation.RESET;
                        Reparation.SETRANGE("N° Reparation", REC."N° Reparation");
                        IF Reparation.FIND('-') THEN
                            REPORT.RUN(70003, TRUE, FALSE, Reparation);
                    end;
                }
            }
        }
    }

    var
        Reparation: Record "Réparation Véhicule";
}

