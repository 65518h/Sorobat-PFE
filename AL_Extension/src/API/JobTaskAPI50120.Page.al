// utilise l'objet de type page pour exposer des données vers l'extérieur. 
//"JobTaskAPi"  est utilisé si vous voulez faire référence à cette page dans d'autres parties de votre code AL.
page 50120 "JobTaskAPI"
{
    PageType = API;
    Caption = 'jobTaskApi';
    //APIPublisher, APIGroup, APIVersion : Ces trois éléments forment l'URL de votre service.
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'jobTask'; // type de l'objet 
    EntitySetName = 'jobTasks'; //C'est le nom qui apparaît réellement dans l'URL
    SourceTable = "Job Task"; //nom de la table telle qu'elle existe physiquement dans la base de données SQL 
    DelayedInsert = true; // BC attend d'avoir reçu tous les champs envoyés par l'API avant de tenter d'insérer et de valider l'enregistrement dans la table SourceTable

    layout //quels champs de la table "Job Task" seront visibles dans l'API et sous quel nom.
    {
        area(Content)
        {
            repeater(GroupName)
            {
                //les 3 premiers champs sont issus de la table "Job Task" (SourceTable) et les 5 suivants sont issus de la TableExtension 50877 créée pour SOROUBAT.
                //Le premier paramètre (jobNo) est le nom que l'application Angular verra. Le second (Rec."Job No.") est le nom technique dans BC
                field(jobNo; Rec."Job No.") { Caption = 'Job No.'; }
                field(taskNo; Rec."Job Task No.") { Caption = 'Task No.'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                field(dateDebut; Rec."Date Debut") { Caption = 'Date Debut'; }
                field(dateFin; Rec."Date Fin") { Caption = 'Date Fin'; }
                field(progressPct; Rec."Progress %") { Caption = 'Progress %'; }
                field(taskProgressPct; Rec."Task Progress %") { Caption = 'Task Progress %'; }
                field(quantityShipped; Rec."Quantity Shipped") { Caption = 'Quantity Realized'; }
                field(isBlocked; Rec.Blocked) { Caption = 'Is Blocked'; }
            }
        }
    }

    trigger OnAfterGetRecord() //s'exécute à chaque fois que l'API récupère une ligne de la table.
    begin
        // Calcul des FlowFields pour Angular (en temps réel)
        Rec.CalcFields("Quantity Shipped"); // exécute la formule CalcFormula définie dans la tableext 50877
    end;
}