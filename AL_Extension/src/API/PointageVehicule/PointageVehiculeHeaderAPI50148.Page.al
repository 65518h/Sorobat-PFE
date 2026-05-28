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
    InsertAllowed = true;  
    ModifyAllowed = true;  
    DeleteAllowed = true;  

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
                field(documentNo; Rec."N° Document")
                {
                    Caption = 'Document No';
                    Editable = false; 
                }

                field(jobNo; Rec.Marche)
                {
                    Caption = 'Job No';
                    Editable = true; 
                }
                field(date; Rec.Journee)
                {
                    Caption = 'Date';

                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';
                }
            }
            part(vehiculePointageLines; "APIVehiculePointageLines")
            {
                Caption = 'Lines';
                EntityName = 'vehiculePointageLine';
                EntitySetName = 'vehiculePointageLines';
                SubPageLink = "Document N°" = field("N° Document");
            }
        }
    }
}
