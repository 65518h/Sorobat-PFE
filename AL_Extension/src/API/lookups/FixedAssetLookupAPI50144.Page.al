page 50144 "FixedAssetLookupAPI"
{
    PageType = API;
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'fixedAsset';
    EntitySetName = 'fixedAssets';
    SourceTable = "Fixed Asset"; 
    DelayedInsert = true;
    Caption = 'Fixed Asset Lookup API';

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
                field(number; Rec."No.") 
                { 
                    Caption = 'No.';
                }
                field(displayName; Rec.Description) 
                { 
                    Caption = 'Description';
                }

                field(faClassCode; Rec."FA Class Code") 
                { 
                    Caption = 'FA Class Code';
                }
                field(faSubclassCode; Rec."FA Subclass Code") 
                { 
                    Caption = 'FA Subclass Code';
                }
            }
        }
    }
}