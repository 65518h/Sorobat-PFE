page 50150 "GasoilHeaderAPI"
{
    PageType = API;
    Caption = 'gasoilHeader';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'gasoilHeader';
    EntitySetName = 'gasoilHeaders';
    SourceTable = "Entete Fiche Gasoil";
    ODataKeyFields = SystemId;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; }
                field(documentNo; Rec."No.") { Caption = 'Document No.'; }
                field(jobNo; Rec.Chantier) { Caption = 'Job No'; }
                field(date; Rec.Journee) { Caption = 'Date'; }
                field(locationCode; Rec.Cuve) { Caption = 'Location Code'; }
                field(status; Rec.Statut) { Caption = 'Status'; }
                field(startIndex; Rec."Index Depart") { Caption = 'Start Index'; }
                field(endIndex; Rec."Index Final") { Caption = 'End Index'; }
                field(fileNo; Rec."N° Fiche") { Caption = 'File No.'; }

                part(gasoilLines; "GasoilLinesAPI")
                {
                    Caption = 'Lines';
                    EntityName = 'gasoilLine';
                    EntitySetName = 'gasoilLines';
                    SubPageLink = "Document No." = field("No.");
                }
            }
        }
    }
}