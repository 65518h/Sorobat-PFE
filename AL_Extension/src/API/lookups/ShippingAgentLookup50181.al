page 50181 "ShippingAgentAPI"
{
    PageType = API;
    Caption = 'shippingAgentApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'shippingAgent';
    EntitySetName = 'shippingAgents';
    SourceTable = "Shipping Agent";
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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                    Editable = false;
                }
            }
        }
    }
}