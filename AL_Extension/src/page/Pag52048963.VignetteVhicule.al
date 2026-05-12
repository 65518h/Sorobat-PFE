Page 52048963 "Vignette Véhicule"
{//GL2024  ID dans Nav 2009 : "39004674"
    PageType = List;
    SourceTable = "Vignette Véhicule";
    ApplicationArea = All;
    Caption = 'Vignette Véhicule';

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("N° Veh"; Rec."N° Veh")
                {
                    ApplicationArea = Basic;
                    Caption = 'N° Véhicule';
                }
                field("Date Document"; Rec."Date Document")
                {
                    ApplicationArea = Basic;
                }
                field("code Vig"; Rec."code Vig")
                {
                    ApplicationArea = Basic;
                    Caption = 'Code Vignette';
                }
                field("Libellé"; Rec.Libellé)
                {
                    ApplicationArea = Basic;
                }
                field(Tarif; Rec.Tarif)
                {
                    ApplicationArea = Basic;
                }
                field("Date Fin de Validité"; Rec."Date Fin de Validité")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000005; Rec.Valider)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                        if Confirm('Souhaitez vous valider la Saisie vignette', true) then begin
                            Rec.Valider := true;
                            Rec.Modify;
                        end;
                    end else
                        Error('Saisie Vignette Déjà Validée');
                end;
            }
        }
    }
}

