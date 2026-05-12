page 52049025 "Ligne rapport Chantier"
{ //  id dans nav"39004764"
    PageType = Card;
    SourceTable = "Ligne Rapport Chantier";
    SourceTableView = WHERE(Ressource = CONST(Transport));

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Materiel; rec.Materiel)
                {

                    trigger OnValidate()
                    begin
                        IF RecVehicule.GET(rec.Materiel) THEN rec.Volume := RecVehicule.Volume;
                    end;
                }
                field("Description Engins"; rec."Description Engins")
                {
                }
                field(Volume; rec.Volume)
                {
                }
                field(Produit; rec.Produit)
                {
                }
                field(Voyage; rec.Voyage)
                {
                }
                field(Heure; rec.Heure)
                {
                }
                field(Conducteur; rec.Conducteur)
                {
                }
                field(Provenance; rec.Provenance)
                {
                }
                field(Destination; rec.Destination)
                {
                }
                field("Distance Parcourus"; rec."Distance Parcourus")
                {
                }
                field(Observation; rec.Observation)
                {
                }
                field(Cout; rec.Cout)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Ressource := rec.Ressource::Transport;
    end;

    var
        RecVehicule: Record Véhicule;
}

