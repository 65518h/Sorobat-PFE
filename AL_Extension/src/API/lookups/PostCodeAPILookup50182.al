page 50182 "PostCodeAPI"
{
    PageType = API;
    Caption = 'postCodeApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'postCode';
    EntitySetName = 'postCodes';
    SourceTable = "Post Code";
    ODataKeyFields = SystemId;
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
                field(code; Rec.Code)
                {
                    Caption = 'Code';
                    Editable = false;
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                    Editable = false;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                    Editable = false;
                }
            }
        }
    }
}
