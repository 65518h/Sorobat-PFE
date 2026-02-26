page 50120 "JobTaskAPI"
{
    PageType = API;
    Caption = 'jobTaskApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'jobTask';
    EntitySetName = 'jobTasks';
    SourceTable = "Job Task";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // --- Champs Identifiants (Standards existants dans ton code) ---
                field(jobNo; Rec."Job No.") { Caption = 'Job No.'; }
                field(taskNo; Rec."Job Task No.") { Caption = 'Task No.'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                
                // --- Gestion des Dates (Provenant de la TableExtension 50877 de SOROUBAT) ---
                field(dateDebut; Rec."Date Debut") { Caption = 'Date Debut'; }
                field(dateFin; Rec."Date Fin") { Caption = 'Date Fin'; }
                
                // --- Avancement & Quantités (Provenant de la TableExtension 50877 de SOROUBAT) ---
                field(progressPct; Rec."Progress %") { Caption = 'Progress %'; }
                field(taskProgressPct; Rec."Task Progress %") { Caption = 'Task Progress %'; }
                field(quantityShipped; Rec."Quantity Shipped") { Caption = 'Quantity Realized'; }
                field(isBlocked; Rec.Blocked) { Caption = 'Is Blocked'; }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Calcul des FlowFields pour Angular
        Rec.CalcFields("Quantity Shipped");
    end;
}