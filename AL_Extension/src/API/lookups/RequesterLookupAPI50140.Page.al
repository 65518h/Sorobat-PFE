page 50140 "RequesterLookupAPI"
{
    PageType = API;
    Caption = 'requesterLookup';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'requester';
    EntitySetName = 'requesters';
    SourceTable = Demandeur;
    DelayedInsert = true;
    ODataKeyFields = "Nom Et Prenom";

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
                field(displayName; Rec."Nom Et Prenom")
                {
                    Caption = 'Nom Et Prenom';
                }
            }
        }
    }
}