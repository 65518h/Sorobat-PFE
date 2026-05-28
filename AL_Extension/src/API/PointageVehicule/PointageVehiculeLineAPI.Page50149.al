page 50149 "APIVehiculePointageLines"
{
    PageType = API;
    Caption = 'vehiculePointageLines';
    APIPublisher = 'soroubat';
    APIGroup = 'siteManagement';
    APIVersion = 'v1.0';
    EntityName = 'vehiculePointageLine';
    EntitySetName = 'vehiculePointageLines';
    SourceTable = "Ligne Pointage Vehicule";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    InsertAllowed = false; 
    ModifyAllowed = true;  
    DeleteAllowed = false; 

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
                field(documentNo; Rec."Document N°")
                {
                    Caption = 'Document No';
                    Editable = false;
                }
                field(vehiculeNo; Rec.Vehicule)
                {
                    Caption = 'Vehicule No';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(status; Rec.Statut)
                {
                    Caption = 'Status';                
                }
                field(hoursWorked; Rec."Heure Travailler")
                {
                    Caption = 'Hours Worked';
                }
                field(startIndex; Rec."Index Depart")
                {
                    Caption = 'Start Index';
                }
                field(endIndex; Rec."Index Final")
                {
                    Caption = 'End Index';
                }
                field(fuelConsumed; Rec.Gasoil)
                {
                    Caption = 'Fuel Consumed';
                }

                field(marche; Rec.Marche)
                {
                    Caption = 'Job No';
                    Editable = false;
                }
            }
        }
    }
}
