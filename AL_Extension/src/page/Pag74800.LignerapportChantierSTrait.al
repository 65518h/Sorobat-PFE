// Page 74800 "Ligne rapport Chantier S Trait"
// {//GL2024  ID dans Nav 2009 : "39004800"
//     PageType = ListPart;
//     SourceTable = "Ligne Rapport Chantier";
//     SourceTableView = where(Ressource = const("Sous-Traitant"));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(Observation; Rec.Observation)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Désignation';
//                 }
//                 field("Quantité Excutée"; Rec."Quantité Excutée")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 // field("Code unité"; Rec."Code unité")
//                 // {
//                 //     ApplicationArea = Basic;
//                 //     Caption = 'Unité';
//                 // }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec.Ressource := Rec.Ressource::Engins;
//     end;
// }

