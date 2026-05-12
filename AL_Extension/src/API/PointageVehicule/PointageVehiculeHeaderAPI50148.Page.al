page 50148 "APIVehiculePointageHeader"
{
    PageType = API;
    Caption = 'vehiculePointageHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'vehiculePointageHeader';
    EntitySetName = 'vehiculePointageHeaders';
    SourceTable = "Entete Pointage Vehicule";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; }
                field(documentNo; Rec."N° Document") { Caption = 'Document No'; }
                field(jobNo; Rec.Marche) { Caption = 'Job No'; } // Lien avec le chantier 
                field(date; Rec.Journee) { Caption = 'Date'; }
                field(status; Rec.Statut) { Caption = 'Status'; }
            }
            part(vehiculePointageLines; "APIVehiculePointageLines")
            {
                Caption = 'Lines';
                EntityName = 'vehiculePointageLine';
                EntitySetName = 'vehiculePointageLines';
                SubPageLink = "Document N°" = field("N° Document"); // Lien entre Header et Lines
            }
        }
    }
}