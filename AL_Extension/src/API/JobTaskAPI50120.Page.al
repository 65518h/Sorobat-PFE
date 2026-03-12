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
    
    // Configuration des permissions d'écriture
    InsertAllowed = false; // On ne crée pas de nouvelles tâches depuis le Web
    ModifyAllowed = true;  // On autorise la modification de l'avancement
    DeleteAllowed = false; // Sécurité : on ne supprime rien

    layout //séparation de la partie logique (définition de l'api / triggers ) et de la partie présentation (layout)
    {
        area(Content) // Business Central divise les pages en zones spécifiques. La plus importante est area(content). C'est là que vous placez les champs que vous souhaitez exposer via l'API.
        {
            repeater(GroupName) //il "répète" les lignes. Si votre table contient 50 enregistrements, le repeater affichera 50 lignes sous forme de tableau (grille) json pour les pages de type API. 
            // C'est le nom technique que vous donnez à ce groupe de champs.
            {
                //les 3 premiers champs sont issus de la table "Job Task" (SourceTable) et les suivants proviennent de la TableExtension 50877 créée pour SOROUBAT.
                //Le premier paramètre (ex: jobNo) est le nom que l'application Angular verra. Le second (Rec."Job No.") est le nom technique dans BC.

                // --- IDENTIFIANTS (Lecture seule pour protéger l'intégrité) ---
                field(jobNo; Rec."Job No.") { Caption = 'Job No.'; Editable = false; } // editable par défaut à false
                field(taskNo; Rec."Job Task No.") { Caption = 'Task No.'; Editable = false; }
                field(description; Rec.Description) { Caption = 'Description'; Editable = false; }

                // --- SAISIE AVANCEMENT (Modifiables par le chef de chantier) ---
                // Cruciaux pour le suivi temporel sur le site Web
                field(dateDebut; Rec."Date Debut") { Caption = 'Date Debut'; }
                field(dateFin; Rec."Date Fin") { Caption = 'Date Fin'; }
                
                // Pourcentages d'avancement saisis par les chefs de chantier
                field(progressPct; Rec."Progress %") { Caption = 'Progress %'; }
                field(taskProgressPct; Rec."Task Progress %") { Caption = 'Task Progress %'; }
                
                // --- DONNÉES CALCULÉES & RÉALISÉ (Toujours en lecture seule) ---
                // quantityShipped représente ce qui a été réellement consommé/réalisé (FlowField)
                field(quantityShipped; Rec."Quantity Shipped") { Caption = 'Quantity Realized'; Editable = false; } 
                
                // --- DONNÉES DE VENTE (Lecture seule pour consultation uniquement) ---
                // Utile pour comparer le réalisé par rapport à l'objectif de vente
                field(initialQuantity; Rec."Initial Quantity") { Caption = 'Initial Quantity'; Editable = false; }
                field(initialUoM; Rec."Initial Unit Of Measure") { Caption = 'Initial UoM'; Editable = false; }
                field(initialAmount; Rec."Initial Amount") { Caption = 'Initial Amount'; Editable = false; }

                field(isBlocked; Rec.Blocked) { Caption = 'Is Blocked'; Editable = false; }
            }
        }
    }

    trigger OnAfterGetRecord() //s'exécute à chaque fois que l'API récupère une ligne de la table.
    begin
        // Calcul des FlowFields pour Angular (en temps réel)
        // On exécute les formules CalcFormula définies dans la tableext 50877 pour obtenir les totaux
        Rec.CalcFields("Quantity Shipped");
    end;
}