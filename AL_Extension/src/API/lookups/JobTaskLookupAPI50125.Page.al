page 50125 "ProjectTaskLookupAPI"
{
    PageType = API;
    Caption = 'projectTaskLookupApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'projectTask';
    EntitySetName = 'projectTasks';
    SourceTable = "Job Task";
    InsertAllowed = false;

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
                field(projectNo; Rec."Job No.") { }
                field(taskNo; Rec."Job Task No.") { }
                field(description; Rec.Description) { }
                field(type; Rec."Job Task Type") { } // Utile pour filtrer uniquement les lignes de type "Posting" (il existe aussi des lignes de type "Non-Posting" qui sont utilisées pour structurer les tâches dans le projet mais qui ne doivent pas être sélectionnées dans le cadre de la PR)
            }
        }
    }
}