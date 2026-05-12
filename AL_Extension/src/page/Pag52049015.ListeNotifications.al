page 52049015 "Liste Notifications"
{
    //GL2024  ID dans Nav 2009 : "39001543" 
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "FOR-Notifications";
    // SourceTableView = where("Type Notification" = const(DA));

    Caption = 'Liste Notifications';
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                ShowCaption = false;
                Editable = false;
                // field("Date Creation"; Rec."Date Creation")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Document N°"; Rec."Document N°")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Description; Rec.Description)
                // {
                //     ApplicationArea = Basic;
                // }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("N° Notification"; Rec."N° Notification")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Affecte a"; Rec."Affecte a")
                {
                    ApplicationArea = Basic;
                }
                field("Date echeance"; Rec."Date echeance")
                {
                    ApplicationArea = Basic;
                }
                field("Date debut"; Rec."Date debut")
                {
                    ApplicationArea = Basic;
                }
                field("Temps reste (jours)"; Rec."Temps reste (jours)")
                {
                    ApplicationArea = Basic;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Atteindre Fiche")
            {
                Caption = 'Atteindre Fiche';
                ApplicationArea = Basic;
                Image = Open;
                trigger OnAction()
                var
                    RecLFormationEnrg: Record "FOR-Formations Enregistrées";
                    RecLSalarie: Record 5200;
                begin
                    IF rec.Type = 1 THEN BEGIN
                        RecLFormationEnrg.SETFILTER(RecLFormationEnrg."N° Sequence", rec."N° Document");
                        page.RUN(page::"Note Salariée Enreg.", RecLFormationEnrg);
                    END;
                    IF rec.Type = 2 THEN BEGIN
                        RecLSalarie.SETRANGE(RecLSalarie."No.", rec."N° Document");
                        Page.RUN(70122, RecLSalarie);
                    END;
                end;
            }
        }
    }

}