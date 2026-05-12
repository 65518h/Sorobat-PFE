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

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { Caption = 'Id'; }
                field(documentNo; Rec."Document N°") { Caption = 'Document No'; }
                field(vehiculeNo; Rec.Vehicule) { Caption = 'Vehicule No'; }
                field(description; Rec.Description) { Caption = 'Description'; }
                field(status; Rec.Statut) { Caption = 'Status'; }
                field(hoursWorked; Rec."Heure Travailler") { Caption = 'Hours Worked'; }
                
                // On utilise les champs Index pour le suivi kilométrique ou horaire
                field(startIndex; Rec."Index Depart") { Caption = 'Start Index'; } 
                field(endIndex; Rec."Index Final") { Caption = 'End Index'; }
                field(fuelConsumed; Rec.Gasoil) { Caption = 'Fuel Consumed'; }
                field(breakdownMotiv; Rec."Motif Panne") { Caption = 'Breakdown Motive'; }
                field(Marche;Rec.Marche) { Caption = 'Job No'; } 
                
            }
        }
    }
}