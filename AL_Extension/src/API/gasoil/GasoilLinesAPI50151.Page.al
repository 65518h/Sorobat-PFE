page 50151 "GasoilLinesAPI"
{
    PageType = API;
    Caption = 'gasoilLine';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'gasoilLine';
    EntitySetName = 'gasoilLines';
    SourceTable = "Ligne Fiche Gasoil";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { }
                field(documentNo; Rec."Document No.") { }
                field(lineNo; Rec."Numero Ligne") { }
                field(vehicleNo; Rec.Materiel) { }
                field(vehiclePlate; Rec."Immatricule Vehicule") { }
                field(quantity; Rec."Quantité Gasoil") { }
                field(time; Rec.Heure) { }
                field(indexType; Rec."Type Index") { }
                field(hourIndex; Rec."Index Horaire") { }
                field(kmIndex; Rec."Index Kilometrique") { }
                field(driver; Rec.Chauffeur) { }
                field(projectNo; Rec.Affaire) { }
            }
        }
    }
}