Page 52049042 Taxe
{//GL2024  ID dans Nav 2009 : "39004713"
    PageType = Card;
    SourceTable = Taxe;
    ApplicationArea = All;
    Caption = 'Taxe';

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Date Document"; Rec."Date Document")
                {
                    ApplicationArea = Basic;
                }
                field("Date fin Validité"; Rec."Date fin Validité")
                {
                    ApplicationArea = Basic;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000009; Rec.Valider)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Valider)
            {
                ApplicationArea = Basic;
                Caption = 'Valider';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if not Rec.Valider then begin
                        if Confirm('Souhaitez vous valider la Taxe', true) then begin
                            Rec.Valider := true;
                            Rec.Modify;
                        end;
                    end else
                        Error('Saisie Taxe Déjà Validée');
                end;
            }
        }
    }
}

