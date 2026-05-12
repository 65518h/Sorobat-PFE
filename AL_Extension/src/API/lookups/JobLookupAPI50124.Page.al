page 50124 "ProjectLookupAPI"
{
    PageType = API;
    Caption = 'projectLookupApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'project';
    EntitySetName = 'projects';
    SourceTable = Job;
    DelayedInsert = true;
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
                field(code; Rec."No.") { }
                field(description; Rec.Description) { }
                field(status; Rec.Status) { }
            }
        }
    }
}