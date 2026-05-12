// Page 74785 "Ligne rapport Chantier Transpo"
// {//GL2024  ID dans Nav 2009 : "39004785"
//     PageType = List;
//     SourceTable = "Ligne Rapport Chantier";
//     SourceTableView = where(Ressource = const(Transport));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(Materiel; Rec.Materiel)
//                 {
//                     ApplicationArea = Basic;

//                     trigger OnValidate()
//                     begin
//                         if RecVehicule.Get(Rec.Materiel) then Rec.Volume := RecVehicule.Volume;
//                     end;
//                 }
//                 field("Description Engins"; Rec."Description Engins")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Produit; Rec.Produit)
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//                 field(Voyage; Rec.Voyage)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Distance Parcourus"; Rec."Distance Parcourus")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Volume; Rec.Volume)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Heure Dispo"; Rec."Heure Dispo")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Tot Heure"; Rec."Tot Heure")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Conducteur; Rec.Conducteur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Cout; Rec.Cout)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec.Ressource := Rec.Ressource::Transport;
//     end;

//     var
//         RecVehicule: Record "Véhicule";
// }

