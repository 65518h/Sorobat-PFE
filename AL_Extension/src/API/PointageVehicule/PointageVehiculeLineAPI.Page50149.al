page 50149 "APIVehiculePointageLines"
{
    PageType = API;
    Caption = 'vehiculePointageLines';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'vehiculePointageLine';
    EntitySetName = 'vehiculePointageLines';
    SourceTable = "Ligne Pointage Vehicule";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = false; // Les lignes sont générées automatiquement par BC via le trigger OnValidate de Journee
    ModifyAllowed = true;  // Le chef de chantier peut mettre à jour les données de pointage
    DeleteAllowed = false; // La suppression est interdite — les lignes sont gérées exclusivement par BC

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
                field(documentNo; Rec."Document N°")
                {
                    Caption = 'Document No';
                    Editable = false;
                }
                field(vehiculeNo; Rec.Vehicule)
                {
                    Caption = 'Vehicule No';
                    // Editable = true (défaut) — saisi par le chef de chantier
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    // Editable = true (défaut) — saisi par le chef de chantier
                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';                
                }
                field(hoursWorked; Rec."Heure Travailler")
                {
                    Caption = 'Hours Worked';
                    // Editable = true (défaut) — saisi par le chef de chantier
                }
                field(startIndex; Rec."Index Depart")
                {
                    Caption = 'Start Index';
                    // Editable = true (défaut) — suivi kilométrique ou horaire
                }
                field(endIndex; Rec."Index Final")
                {
                    Caption = 'End Index';
                    // Editable = true (défaut) — suivi kilométrique ou horaire
                }
                field(fuelConsumed; Rec.Gasoil)
                {
                    Caption = 'Fuel Consumed';
                    // Editable = true (défaut) — saisi par le chef de chantier
                }
                // marche (jobNo de la ligne) est forcé par BC depuis l'en-tête parent —
                // non modifiable directement pour empêcher un chef de lier une ligne
                // à un autre chantier
                field(marche; Rec.Marche)
                {
                    Caption = 'Job No';
                    Editable = false;
                }
            }
        }
    }
}