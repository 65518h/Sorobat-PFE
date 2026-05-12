Page 52048996 "Ligne Programmation"
{//GL2024  ID dans Nav 2009 : "39004743"
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Linge Programmation";
    SourceTableView = sorting(Chantier, Vehicule);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1120000)
            {
                field(Journee; Rec.Journee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Vehicule; Rec.Vehicule)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Nom Vehicule"; Rec."Nom Vehicule")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = Basic;
                }
                field(Chauffeur; Rec.Chauffeur)
                {
                    ApplicationArea = Basic;
                }
                field(Chantier; Rec.Chantier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Sous Affectation"; Rec."Sous Affectation")
                {
                    ApplicationArea = Basic;
                }
                field("Point Chargement 1"; Rec."Point Chargement 1")
                {
                    ApplicationArea = Basic;
                }
                field("Point Dechargement 1"; Rec."Point Dechargement 1")
                {
                    ApplicationArea = Basic;
                }
                field("Point Chargement 2"; Rec."Point Chargement 2")
                {
                    ApplicationArea = Basic;
                }
                field("Point Dechargement 2"; Rec."Point Dechargement 2")
                {
                    ApplicationArea = Basic;
                }
                field("Point Chargement 3"; Rec."Point Chargement 3")
                {
                    ApplicationArea = Basic;
                }
                field("Point Dechargement 3"; Rec."Point Dechargement 3")
                {
                    ApplicationArea = Basic;
                }
                field("Point Chargement 4"; Rec."Point Chargement 4")
                {
                    ApplicationArea = Basic;
                }
                field("Point Dechargement 4"; Rec."Point Dechargement 4")
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
    }

    var
        Text001: label 'Confirmer Cette Action ?';
        DteJournee: Date;
        RecVehicule: Record "Véhicule";
        SuiviVehiculeParStatut: Record "Linge Programmation";
        SuiviVehiculeParStatut2: Record "Linge Programmation";
        Text002: label 'Vous Devez Preciser La Journee';
        Text003: label 'Vous Devez D''abords Valider La Journee %1';
        Text004: label 'Journee Deja Saisie';
        Affectation: Code[20];
}

