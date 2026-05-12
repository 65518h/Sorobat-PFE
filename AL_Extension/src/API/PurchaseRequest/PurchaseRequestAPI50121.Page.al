page 50121 "PurchaseRequestAPI"
{
    PageType = API;
    Caption = 'purchaseRequestApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'purchaseRequest';
    EntitySetName = 'purchaseRequests';
    SourceTable = "Purchase Request";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;  // Le chef de chantier peut créer une demande
    ModifyAllowed = true;  // Le chef peut modifier les champs autorisés
    DeleteAllowed = true;  // Le chef peut supprimer une demande "Open"

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // ── Identifiants (lecture seule) ──────────────────────────────
                field(id; Rec.SystemId) // rec est la ligne courante, xRec est la valeur avant modification
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(no; Rec."No.")
                {
                    Caption = 'N° Demande';
                    Editable = false; // Auto-incrémenté par BC
                }

                // ── Champs modifiables par le chef de chantier ────────────────
                field(observation; Rec.Observation)
                {
                    Caption = 'Observation';
                }
                // jobNo est forcé par le backend (JWT) — non modifiable directement
                // pour empêcher un chef de lier une demande à un autre projet
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'N° Projet';
                    Editable = true;
                }
                field(jobDescription; Rec."Job Description")
                {
                    Caption = 'Libellé Projet';
                    Editable = false; // Calculé par BC depuis jobNo
                }
                field(requesterId; Rec."Requester ID")
                {
                    Caption = 'Demandeur';
                }
                field(requestType; Rec."Request Type")
                {
                    Caption = 'Type de demande';
                }
                field(engin; Rec.Engin)
                {
                    Caption = 'Code Engin';
                }
                field(descriptionEngin; Rec."Description Engin")
                {
                    Caption = 'Désignation Engin';
                    Editable = false; // Calculé par BC depuis engin
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Code Magasin';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Date Commande';
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Date d''échéance';
                }
                // statut non modifiable directement depuis l'API :
                // seule l'action /submit (PATCH dédié) peut changer Open → To Approve.
                // Cela évite qu'un chef bypasse le workflow d'approbation.
                field(statut; Rec.Statut)
                {
                    Caption = 'Statut';
                    Editable = true;
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Montant';
                    Editable = false; // Calculé par BC depuis les lignes
                }
                field(service; Rec.Service)
                {
                    Caption = 'Service';
                }
            }

            part(purchaseRequestLines; "PurchaseRequestLineAPI")
            {
                Caption = 'Lines';
                EntityName = 'purchaseRequestLine';
                EntitySetName = 'purchaseRequestLines';
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        CannotChangeProjectErr: Label 'Vous ne pouvez pas modifier le numéro de projet d''une demande existante.';
    begin
        // xRec contient la valeur avant modification, Rec contient la nouvelle valeur.
        if Rec."Job No." <> xRec."Job No." then
            Error(CannotChangeProjectErr);
            
        exit(true);
    end;


}
