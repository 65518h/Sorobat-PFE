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
                field(documentNo; Rec."No.")
                {
                    Caption = 'Document No.';
                    Editable = false; 
                }
                field(jobNo; Rec.Chantier)
                {
                    Caption = 'Job No.';
                    Editable = true;
                }
                field(date; Rec.Journee)
                {
                    Caption = 'Date';
                }
                field(locationCode; Rec.Cuve)
                {
                    Caption = 'Location Code';
                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';
                }
                field(fileNo; Rec."N° Fiche")
                {
                    Caption = 'File No.';
                }

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

    trigger OnModifyRecord(): Boolean
    var
        CannotChangeProjectErr: Label 'Vous ne pouvez pas modifier le numéro de chantier d''une fiche existante.';
    begin
        if Rec.Chantier <> xRec.Chantier then
            Error(CannotChangeProjectErr);

        exit(true);
    end;
}
