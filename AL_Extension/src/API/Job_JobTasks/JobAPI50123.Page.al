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
                field(status; Rec.Status) 
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
                // c'est le magasin principal 
                field(affectationMagasin; Rec."Affectation Magasin")
                {
                    Caption = 'Affectation Magasin';
                    Editable = false;
                }
            }
        }
    }
}
