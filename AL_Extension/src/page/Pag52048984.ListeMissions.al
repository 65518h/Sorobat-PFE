page 52048984 "Liste Missions"
{//GL2024  ID dans Nav 2009 : "39004687"
    Editable = false;
    PageType = List;
    SourceTable = Missions;
    ApplicationArea = All;
    CardPageId = "Fiche Mission";
    Caption = 'Liste Missions';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Mission"; REC."N° Mission")
                {
                    ApplicationArea = all;
                }
                field("Date document"; REC."Date document")
                {
                    ApplicationArea = all;
                }
                field("Date Mission"; REC."Date Mission")
                {
                    ApplicationArea = all;
                }
                field("Code Demandeur"; Rec."Code Demandeur")
                {
                    ApplicationArea = all;
                }
                field(Demandeur; REC."Nom Demandeur")
                {
                    ApplicationArea = all;
                }
                field("Date Départ"; REC."Date Départ")
                {
                    ApplicationArea = all;
                }
                field("Date Arrivée"; REC."Date Arrivée")
                {
                    ApplicationArea = all;
                }
                field("Lieu départ"; REC."Lieu départ")
                {
                    ApplicationArea = all;
                }
                field("Lieu Arrivé"; REC."Lieu Arrivé")
                {
                    ApplicationArea = all;
                }
                field("N° Véhicule"; REC."N° Véhicule")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Mission1)
            {
                Caption = 'Mission';
                actionref(Imprimer1; Imprimer) { }
                actionref(Fiche1; Fiche) { }
                actionref("Prise de Carburant1"; "Prise de Carburant") { }
            }

        }
        area(navigation)
        {
            group(Mission)
            {
                Caption = 'Mission';
                action(Imprimer)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';

                    trigger OnAction()
                    begin
                        Miss.RESET;
                        Miss.SETRANGE("N° Mission", REC."N° Mission");
                        IF Miss.FIND('-') THEN
                            REPORT.RUN(52048901, TRUE, FALSE, Miss);
                    end;
                }
                action(Fiche)
                {
                    ApplicationArea = all;
                    Caption = 'Fiche';
                    RunObject = Page "Fiche Mission";
                    RunPageLink = "N° Mission" = FIELD("N° Mission");
                    ShortCutKey = 'Ctrl+F7';
                }

                action("Prise de Carburant")
                {
                    ApplicationArea = all;
                    Caption = 'Prise de Carburant';
                    RunObject = Page "Prise carburant";
                    RunPageLink = "N° Véhicule" = FIELD("N° Véhicule"),
                                  "N° Mission" = FIELD("N° Mission");
                }
            }
        }
    }

    var
        Miss: Record Missions;
        company: Record "Company Information";
}

