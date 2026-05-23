page 50150 "GasoilHeaderAPI"
{
    PageType = API;
    Caption = 'gasoilHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'gasoilHeader';
    EntitySetName = 'gasoilHeaders';
    SourceTable = "Entete Fiche Gasoil";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    InsertAllowed = true;   // Création par le chef de chantier via le backend
    ModifyAllowed = true;   // PATCH date, locationCode et validation du statut
    DeleteAllowed = true;   // Suppression autorisée uniquement si statut "En Cours"

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
                field(documentNo; Rec."No.")
                {
                    Caption = 'Document No.';
                    Editable = false; // Auto-incrémenté par BC
                }
                // jobNo forcé par le backend (JWT) — non modifiable directement
                // pour empêcher un chef de lier une fiche à un autre chantier
                field(jobNo; Rec.Chantier)
                {
                    Caption = 'Job No.';
                    Editable = true; // Doit rester Editable pour que le backend puisse le forcer à l'insertion
                }
                field(date; Rec.Journee)
                {
                    Caption = 'Date';
                }
                field(locationCode; Rec.Cuve)
                {
                    Caption = 'Location Code';
                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';
                    // Editable = true (défaut) — modifié par le backend pour la validation
                }
                field(fileNo; Rec."N° Fiche")
                {
                    Caption = 'File No.';
                }

                part(gasoilLines; "GasoilLinesAPI")
                {
                    Caption = 'Lines';
                    EntityName = 'gasoilLine';
                    EntitySetName = 'gasoilLines';
                    SubPageLink = "Document No." = field("No.");
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    var
        CannotChangeProjectErr: Label 'Vous ne pouvez pas modifier le numéro de chantier d''une fiche existante.';
    begin
        if Rec.Chantier <> xRec.Chantier then
            Error(CannotChangeProjectErr);

        exit(true);
    end;
}