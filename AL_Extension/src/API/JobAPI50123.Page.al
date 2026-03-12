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

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // L'essentiel pour identifier le chantier
                field(no; Rec."No.") { }
                field(description; Rec.Description) { }
                field(status; Rec.Status) { }
                
                // Pour savoir qui gère le chantier sur le Web
                field(personResponsible; Rec."Person Responsible") { }
                field(projectManager; Rec."Project Manager") { } 
                
                // Utile pour la logistique et les demandes d'achat futures
                field(affectationMagasin; Rec."Affectation Magasin") { } 
            }
        }
    }

   
}