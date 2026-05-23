page 50136 "TransferHeaderAPI"
{
    PageType = API;
    Caption = 'transferHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'transferHeader';
    EntitySetName = 'transferHeaders';
    SourceTable = "Transfer Header";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; Editable = false; }
                field(no; Rec."No.") { Caption = 'No.'; Editable = false; }
                field(status; Rec.Status) { Caption = 'Status'; } 
                field(transferFromCode; Rec."Transfer-from Code") { Caption = 'Transfer-from Code'; Editable = false; }
                field(transferToCode; Rec."Transfer-to Code") { Caption = 'Transfer-to Code'; Editable = false; }
                field(postingDate; Rec."Posting Date") { Caption = 'Posting Date'; }
                
                field(observation; Rec.Observation) { Caption = 'Observation'; } 
                field(chantierOrigine; Rec."Chantier Origine") { Caption = 'Chantier Origine'; Editable = false; } 
                field(chantierDestination; Rec."Chantier Destination") { Caption = 'Chantier Destination'; Editable = false; } 


                field ("receiptDate";Rec."Receipt Date") 
                {
                    caption = 'Date de réception'; 
                }

                part(transferLines; "TransferLineAPI")
                {
                    Caption = 'Lines';
                    EntityName = 'transferLine';
                    EntitySetName = 'transferLines';
                    SubPageLink = "Document No." = FIELD("No.");
                }
            }
        }
    }
}