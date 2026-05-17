page 50123 "JobAPI"
{
    PageType = API;
    Caption = 'jobApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'job';
    EntitySetName = 'jobs';
    SourceTable = Job;
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    // Les projets sont créés et gérés exclusivement dans BC — lecture seule depuis le Web
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field(no; Rec."No.")
                {
                    Caption = 'N° Projet';
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field(status; Rec.Status) // planning , devis , ouvert , terminé 
                {
                    Caption = 'Statut';
                    Editable = false;
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Date de début';
                    Editable = false;
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Date de fin';
                    Editable = false;
                }
                // magasin principal 
                field(affectationMagasin; Rec."Affectation Magasin")
                {
                    Caption = 'Affectation Magasin';
                    Editable = false;
                }
            }
        }
    }
}
