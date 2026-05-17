page 50177 "LocationAPI"
{
    PageType = API;
    Caption = 'locationApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'location';
    EntitySetName = 'locations';
    SourceTable = Location;
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
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                    Editable = false;
                }
                field(name; Rec.Name)
                {
                    Caption = 'Nom';
                    Editable = false;
                }
                field(affaire; Rec.Affaire)
                {
                    Caption = 'N° Projet';
                    Editable = false;
                }

            }
        }
    }
}