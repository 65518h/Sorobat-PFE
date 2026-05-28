page 50122 "PurchaseRequestLineAPI"
{
    PageType = API;
    Caption = 'purchaseRequestLineApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'purchaseRequestLine';
    EntitySetName = 'purchaseRequestLines';
    SourceTable = "Purchase Request Line";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'N° Document';

                    Editable = true;
                }

                field(lineNo; Rec."Line No.")
                {
                    Caption = 'N° Ligne';
                    Editable = true;
                }


                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'N° Article';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(observation; Rec."Description 2")
                {
                    Caption = 'Observation';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantité';
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Code Unité';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Code Magasin';
                }

                field(jobNo; Rec."Job No.")
                {
                    Caption = 'N° Projet';
                    Editable = true; 
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'N° Tâche Projet';
                }

            }
        }
    }
}
