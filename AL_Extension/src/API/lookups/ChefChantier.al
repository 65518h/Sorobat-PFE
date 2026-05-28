page 50155 "ChefChantierLookup"
{
    PageType = API;
    Caption = 'chefChantierApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'chefChantier';
    EntitySetName = 'chefsChantier';
    SourceTable = "Chef Chantier";
    DelayedInsert = true;

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
            }
        }
    }
}