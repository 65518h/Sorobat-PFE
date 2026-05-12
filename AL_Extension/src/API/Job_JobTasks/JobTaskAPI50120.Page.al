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
    ODataKeyFields = SystemId;
    InsertAllowed = false; // Les tâches sont créées exclusivement dans BC
    ModifyAllowed = true;  // Le chef de chantier peut mettre à jour l'avancement
    DeleteAllowed = false; // La suppression est interdite depuis le Web

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // ── Identifiants (lecture seule) ──────────────────────────────
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    Editable = false;
                }
                field(taskNo; Rec."Job Task No.")
                {
                    Caption = 'Task No.';
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }

                // ── Dates (saisies par le chef dans BC, lues en Web) ──────────
                field(dateDebut; Rec."Date Debut")
                {
                    Caption = 'Date Debut';
                }
                field(dateFin; Rec."Date Fin")
                {
                    Caption = 'Date Fin';
                }

                // ── Avancement manuel (seul champ modifiable depuis le Web) ───
                // Le chef de chantier saisit un % global qui peut différer
                // du calcul automatique basé sur les quantités.
                field(progressPct; Rec."Progress %")
                {
                    Caption = 'Progress %';

                    trigger OnValidate()
                    begin
                        // Validation de plage côté AL : garantit la cohérence
                        // indépendamment des validations faites côté backend .NET
                        if (Rec."Progress %" < 0) or (Rec."Progress %" > 100) then
                            Error('L''avancement doit être compris entre 0 et 100 %%. Valeur saisie : %1.', Rec."Progress %");
                    end;
                }

                // ── Avancement calculé (lecture seule — basé sur les quantités) ──
                field(taskProgressPct; Rec."Task Progress %")
                {
                    Caption = 'Task Progress %';
                    Editable = false;
                }

                // ── Données réalisées (FlowFields — calculés dans OnAfterGetRecord) ──
                field(quantityShipped; Rec."Quantity Shipped")
                {
                    Caption = 'Quantity Realized';
                    Editable = false;
                }

                // ── Données de référence / budget (lecture seule) ─────────────
                field(initialQuantity; Rec."Initial Quantity")
                {
                    Caption = 'Initial Quantity';
                    Editable = false;
                }
                field(initialUoM; Rec."Initial Unit Of Measure")
                {
                    Caption = 'Initial UoM';
                    Editable = false;
                }
                field(initialAmount; Rec."Initial Amount")
                {
                    Caption = 'Initial Amount';
                    Editable = false;
                }
                field(isBlocked; Rec.Blocked)
                {
                    Caption = 'Is Blocked';
                    Editable = false;
                }
                field(usageTotalCost; Rec."Usage (Total Cost)")
                {
                    Caption = 'Usage Total Cost';
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Calcul groupé des deux FlowFields en un seul appel :
        // BC optimise le calcul quand les champs sont demandés ensemble.
        Rec.CalcFields("Quantity Shipped", "Usage (Total Cost)");
    end;
}
