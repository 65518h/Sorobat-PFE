Page 52048974 Affectation
{//GL2024  ID dans Nav 2009 : "39004684"
    PageType = List;
    SourceTable = "Affectation Véhicule";
    ApplicationArea = All;
    Caption = 'Affectation';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("N° Véhicule"; Rec."N° Véhicule")
                {
                    ApplicationArea = Basic;
                }
                field("Date Affectation"; Rec."Date Affectation")
                {
                    ApplicationArea = Basic;
                }
                field("Type Affectation"; Rec."Type Affectation")
                {
                    ApplicationArea = Basic;
                }
                field(Affectation; Rec.Affectation)
                {
                    ApplicationArea = Basic;
                }
                field(Observation; Rec.Observation)
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
                    if Confirm('Voulez Vous Valider l''Affectation') then begin
                        HistAff.Reset;
                        HistAff.TransferFields(Rec);
                        HistAff.Insert;
                        Rec.Delete;
                        Message('Validation Terminer');
                    end;
                end;
            }
        }
    }

    var
        HistAff: Record "Historique Affect. Véhicule";
}

