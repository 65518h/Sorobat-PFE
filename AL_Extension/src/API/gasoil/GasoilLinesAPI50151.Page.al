page 50151 "GasoilLinesAPI"
{
    PageType = API;
    Caption = 'gasoilLine';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'gasoilLine';
    EntitySetName = 'gasoilLines';
    SourceTable = "Ligne Fiche Gasoil";
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
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = true;
                }

                field(lineNo; Rec."Numero Ligne")
                {
                    Caption = 'Line No.';
                    Editable = true;
                }
                field(vehicleNo; Rec.Materiel)
                {
                    Caption = 'Vehicle No.';
                }

                field(quantity; Rec."Quantité Gasoil")
                {
                    Caption = 'Quantity';
                }
                field(maxConsommation; Rec."Consommation Max")
                {
                    Caption = 'Max Consommation';
                }
                field(time; Rec.Heure)
                {
                    Caption = 'Time';
                }
                field(indexType; Rec."Type Index")
                {
                    Caption = 'Index Type';
                }
                field(valeurCompteur; Rec."valeur compteur")
                {
                    Caption = 'Valeur Compteur';
                }
                field(driver; Rec.Chauffeur)
                {
                    Caption = 'Driver';
                }
                field(destination; Rec.Destination)
                {
                    Caption = 'Destination';
                }

                field(projectNo; Rec.Affaire)
                {
                    Caption = 'Project No.';
                    Editable = true; 
                }
                field(observation; Rec.Observation)
                {
                    Caption = 'Observation';
                }
            }
        }
    }
}
