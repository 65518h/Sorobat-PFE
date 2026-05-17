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
                field(dateFin; Rec."Date Fin")
                {
                    Caption = 'Date Fin';
                }

                // avancement manuel par le chef de chantier
                field(progressPct; Rec."Progress %")
                {
                    Caption = 'Progress %';

                    trigger OnValidate()
                    begin

                        if (Rec."Progress %" < 0) or (Rec."Progress %" > 100) then
                            Error('L''avancement doit être compris entre 0 et 100 %%. Valeur saisie : %1.', Rec."Progress %");
                    end;
                }

            }
        }
    }

}
