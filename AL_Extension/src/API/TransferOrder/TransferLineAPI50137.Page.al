page 50137 "TransferLineAPI"
{
    PageType = API;
    Caption = 'transferLine';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'transferLine';
    EntitySetName = 'transferLines';
    SourceTable = "Transfer Line";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; Editable = false; }
                field(documentNo; Rec."Document No.") { Caption = 'Document No.'; Editable = false; }
                field(lineNo; Rec."Line No.") { Caption = 'Line No.'; Editable = false; }
                field(itemNo; Rec."Item No.") { Caption = 'Item No.'; Editable = false; }
                field(description; Rec.Description) { Caption = 'Description'; Editable = false; }
                field(quantity; Rec.Quantity) { Caption = 'Quantity'; Editable = false; }
                
                field(quantityShipped; Rec."Quantity Shipped") 
                { 
                    Caption = 'Quantity Shipped'; 
                    Editable = false; 
                }
                field(quantityReceived; Rec."Quantity Received") 
                { 
                    Caption = 'Quantity Received'; 
                    Editable = false; 
                }
                field(qtyToReceive; Rec."Qty. to Receive") 
                { 
                    Caption = 'Qty. to Receive'; 
                    // Seul champ modifiable par le chef de chantier pour la réception
                }
                field(unitOfMeasure; Rec."Unit of Measure Code") { Caption = 'Unit of Measure'; Editable = false; }

                field(stock; Rec.Stock) { Caption = 'Stock'; Editable = false; } 
                field(numVehicule; Rec."N° vehicule") { Caption = 'N° Véhicule'; } 
                field(affaire; Rec.Affaire) { Caption = 'Affaire/Projet'; Editable = false; } 
                field(descriptionSoroubat; Rec."Description Soroubat") { Caption = 'Description Soroubat'; Editable = false; }
            }
        }
    }
}