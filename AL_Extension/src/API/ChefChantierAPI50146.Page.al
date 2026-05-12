page 50146 "ChefChantierAPI"
{
    PageType = API;
    Caption = 'chefChantierApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'chefChantier';
    EntitySetName = 'chefsChantier';
    SourceTable = "Chef Chantier";
    DelayedInsert = true;
    // SystemId est la clé OData standard — garantit des URLs stables et cohérentes
    // avec les autres pages API du projet (jobTasks, purchaseRequests, etc.)
    ODataKeyFields = SystemId;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false; 
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
                field(nomEtPrenom; Rec."Nom et Prenom")
                {
                    Caption = 'Nom et Prénom';
                }
                field(email; Rec."Adresse Email")
                {
                    Caption = 'Email';
                }
                field(actif; Rec.Actif)
                {
                    Caption = 'Actif';
                }
                field(numProjet; Rec."Num Projet")
                {
                    Caption = 'N° Projet géré';
                }
                field(idApprobateur; Rec."Id Approbateur")
                {
                    Caption = 'Id Approbateur';
                }
            }
        }
    }

    // Génération automatique du GUID métier si vide lors de l'insertion
    // (champ Id de la table "Chef Chantier", distinct du SystemId BC)
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if IsNullGuid(Rec.Id) then
            Rec.Id := CreateGuid();
        exit(true);
    end;
}
