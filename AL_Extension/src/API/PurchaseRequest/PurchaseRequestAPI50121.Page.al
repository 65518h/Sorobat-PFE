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
    InsertAllowed = true;  
    ModifyAllowed = true;  
    DeleteAllowed = true;  
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                    Editable = false; 
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
                    Caption = 'Description Engin';
                    Editable = false; 
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Code Magasin';
                }

                field( "DateSaisie";Rec."Date saisie")
                { 
                    caption = 'Date de saisie'; // auto remplis par bc lors de la création, non modifiable
                }


                field(statut; Rec.Statut)
                {
                    Caption = 'Statut';
                    Editable = true;
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