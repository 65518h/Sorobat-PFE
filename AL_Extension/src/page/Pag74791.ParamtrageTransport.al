//GL3900 
// Page 74791 "Paramétrage Transport"
// {//GL2024  ID dans Nav 2009 : "39004791"
//     DelayedInsert = true;
//     PageType = list;
//     SourceTable = "Paramétrage Transport";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(Produit; Rec.Produit)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Temps de chargement"; Rec."Temps de chargement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Temps de déchargement"; Rec."Temps de déchargement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("VM du camion"; Rec."VM du camion")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taux de résistance"; Rec."Taux de résistance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("VM Exceptionnelle du camion"; Rec."VM Exceptionnelle du camion")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Durée par KM"; Rec."Durée par KM")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable(not CurrPage.LookupMode);
//     end;
// }

