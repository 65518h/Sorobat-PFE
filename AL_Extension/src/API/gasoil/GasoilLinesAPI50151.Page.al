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
    InsertAllowed = true;   // Création manuelle par le chef de chantier
    ModifyAllowed = true;   // Mise à jour partielle autorisée
    DeleteAllowed = true;   // Suppression autorisée

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                // documentNo doit être Editable = true à l'insertion pour lier la ligne à son en-tête.
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = true;
                }
                // lineNo doit être Editable = true pour que le backend puisse envoyer
                // la valeur calculée (Max + 10 000) lors de la création.
                field(lineNo; Rec."Numero Ligne")
                {
                    Caption = 'Line No.';
                    Editable = true;
                }
                field(vehicleNo; Rec.Materiel)
                {
                    Caption = 'Vehicle No.';
                }

                field(quantity; Rec."Quantité Gasoil")
                {
                    Caption = 'Quantity';
                }
                field(maxConsommation; Rec."Consommation Max")
                {
                    Caption = 'Max Consommation';
                }
                field(time; Rec.Heure)
                {
                    Caption = 'Time';
                }
                field(indexType; Rec."Type Index")
                {
                    Caption = 'Index Type';
                }
                field(valeurCompteur; Rec."valeur compteur")
                {
                    Caption = 'Valeur Compteur';
                }
                field(driver; Rec.Chauffeur)
                {
                    Caption = 'Driver';
                }
                field(destination; Rec.Destination)
                {
                    Caption = 'Destination';
                }
                // projectNo forcé par le backend (JWT) — non modifiable directement
                // pour empêcher un chef de lier une ligne à un autre chantier
                field(projectNo; Rec.Affaire)
                {
                    Caption = 'Project No.';
                    Editable = true; // Doit rester Editable pour que le backend puisse le forcer à l'insertion
                }
                field(observation; Rec.Observation)
                {
                    Caption = 'Observation';
                }
            }
        }
    }
}