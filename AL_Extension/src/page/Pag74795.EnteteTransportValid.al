//GL3900 
// page 74795 "Entete Transport Validé"
// {//GL2024  ID dans Nav 2009 : "39004795"
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Entete Transport";
//     ApplicationArea = All;
//     //DYS Non compiler dans NAV
//     //SourceTableView = WHERE("Section 6" = CONST(1));

//     layout
//     {
//         area(content)
//         {
//             group(Transport)
//             {
//                 Caption = 'Transport';
//                 Editable = false;
//                 Enabled = true;
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Marché; REC.Marché)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Produit; REC.Produit)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Journée; REC.Journée)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Section 1"; REC."Section 1")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Section 2"; REC."Section 2")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Section 3"; REC."Section 3")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Section 4"; REC."Section 4")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Section 5"; REC."Section 5")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//             part(Ligne; "Ligne Transport")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//                 Enabled = false;
//                 SubPageLink = "N° Document" = FIELD("N° Document");
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         RecLigneTransport: Record "Ligne Transport";
//         RecLigneTransport2: Record "Ligne Transport";
//         Vehicule: Record "Véhicule";
//         Compteur: Integer;
//         Text001: Label 'Valider Cette Journée ?';
// }

