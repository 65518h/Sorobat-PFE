page 50126 "LocationLookupAPI"
{
    PageType = API;
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'location';
    EntitySetName = 'locations';
    SourceTable = Location;
    DelayedInsert = true;
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
                field(code; Rec.Code) { }
                field(name; Rec.Name) { }
            }
        }
    }
}