page 50145 "ItemLedgerEntryAPI"
{
    PageType = API;
    Caption = 'itemLedgerEntryApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'itemLedgerEntry';
    EntitySetName = 'itemLedgerEntries';
    SourceTable = "Item Ledger Entry";
    DelayedInsert = true;
    
    // Sécurité : Empêcher toute modification via cette API
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(entryNo; Rec."Entry No.") { Caption = 'Entry No.'; }
                field(itemNo; Rec."Item No.") { Caption = 'Item No.'; }
                
                // FlowField pour récupérer la désignation article
                field(itemDescription; Rec."Designation Article") { Caption = 'Description'; } 
                
                field(locationCode; Rec."Location Code") { Caption = 'Location Code'; }
                field(quantity; Rec.Quantity) { Caption = 'Quantity'; }
                
                // Champ crucial pour le filtrage par projet
                field(jobNo; Rec."Job No.") { Caption = 'Job No.'; } 
                
                field(postingDate; Rec."Posting Date") { Caption = 'Posting Date'; }
            }
        }
    }
}