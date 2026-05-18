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
                // ── Identifiants techniques ───────────────────────────────────
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'N° Document';
                    // Editable à l'insertion pour lier la ligne à son en-tête.
                    // BC refusera un documentNo qui ne correspond pas à une demande existante.
                    Editable = true;
                }
                // lineNo doit être Editable = true pour que le backend puisse
                // envoyer la valeur calculée (Max + 10 000) lors de la création.
                // Si Editable = false, BC ignore la valeur et génère son propre numéro,
                // ce qui peut créer des doublons ou des incohérences avec le GetLastLineNo.
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

                // jobNo forcé par le backend (JWT) — non modifiable directement
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'N° Projet';
                    Editable = true; // Doit rester Editable pour que le backend puisse le forcer à l'insertion
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'N° Tâche Projet';
                }

            }
        }
    }
}
