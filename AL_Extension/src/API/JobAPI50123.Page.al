page 50123 "JobAPI"
{
    PageType = API;
    Caption = 'jobApi';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'job';
    EntitySetName = 'jobs';
    SourceTable = Job;
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; Editable = false; }
                field(no; Rec."No.") { Caption = 'N° Projet'; }
                field(description; Rec.Description) { Caption = 'description'; }
                field(status; Rec.Status) { Caption = 'Statut'; }
                
                // Pour savoir qui gère le chantier sur le Web
                field(personResponsible; Rec."Person Responsible") { caption = 'Person Responsible'; } // indique la personne opérationnelle responsable du chantier
                field(projectManager; Rec."Project Manager") { caption = 'Project Manager'; } // indique la personne administrative responsable du chantier
                
                // Utile pour la logistique et les demandes d'achat futures
                field(affectationMagasin; Rec."Affectation Magasin") {  caption = 'Affectation Magasin'; } // indique le magasin d'approvisionnement principal pour ce chantier, ce qui peut être utilisé pour filtrer les demandes d'achat et les approvisionnements liés à ce projet
            }
        }
    }

   
}