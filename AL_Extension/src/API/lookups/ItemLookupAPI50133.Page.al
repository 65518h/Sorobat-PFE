page 50133 "ItemLookupAPI"
{
    PageType = API;
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'item';
    EntitySetName = 'items';
    SourceTable = Item;
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
                field(number; Rec."No.") { }
                field(displayName; Rec.Description) { }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure") { }
            }
        }
    }
}