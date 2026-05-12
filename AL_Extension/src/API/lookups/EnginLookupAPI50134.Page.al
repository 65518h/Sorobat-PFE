page 50134 "VehiculeLookupAPI"
{
    PageType = API;
    Caption = 'vehiculeLookupApi';
    APIPublisher = 'soroubat';
    APIGroup = 'lookups';
    APIVersion = 'v1.0';
    EntityName = 'vehicule';
    EntitySetName = 'vehicules';
    SourceTable = "Véhicule"; 
    InsertAllowed = false;
    ModifyAllowed = false;

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
    }                field(code; Rec."N° Vehicule") { } 
                field(designation; Rec."Désignation") { }
                field(statut; Rec.Statut) { }

            }
        }
    }
}