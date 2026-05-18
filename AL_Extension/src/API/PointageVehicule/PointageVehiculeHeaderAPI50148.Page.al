page 50148 "APIVehiculePointageHeader"
{
    PageType = API;
    Caption = 'vehiculePointageHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'vehiculePointageHeader';
    EntitySetName = 'vehiculePointageHeaders';
    SourceTable = "Entete Pointage Vehicule";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;  // Création par le chef de chantier via le backend
    ModifyAllowed = true;  // PATCH date (étape 2 création) et validation du statut
    DeleteAllowed = true;  // Suppression autorisée uniquement si statut "Ouvert"

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
                field(documentNo; Rec."N° Document")
                {
                    Caption = 'Document No';
                    Editable = false; // Auto-incrémenté par BC
                }
                // jobNo forcé par le backend (JWT) — non modifiable directement
                // pour empêcher un chef de lier un pointage à un autre chantier
                field(jobNo; Rec.Marche)
                {
                    Caption = 'Job No';
                    Editable = true; // Doit rester Editable pour que le backend puisse le forcer à l'insertion
                }
                field(date; Rec.Journee)
                {
                    Caption = 'Date';
                    // Editable = true (défaut) — envoyé dans le PATCH étape 2 pour déclencher
                    // le trigger OnValidate qui génère les lignes véhicule
                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';
                    // Editable = true (défaut) — modifié par le backend pour la validation
                }
            }
            part(vehiculePointageLines; "APIVehiculePointageLines")
            {
                Caption = 'Lines';
                EntityName = 'vehiculePointageLine';
                EntitySetName = 'vehiculePointageLines';
                SubPageLink = "Document N°" = field("N° Document");
            }
        }
    }
}
