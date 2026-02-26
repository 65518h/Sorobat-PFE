// Page 50120 "Ligne Puce"
// {
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Détails Véhicules";
//     ApplicationArea = all;
//     Caption = 'Ligne Puce';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Index Véhicule"; REC."Index Véhicule")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Date; REC.Date)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Véhicule"; REC."Code Véhicule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Ligne"; REC."N° Ligne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fournisseur; REC.Fournisseur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date fin contrat"; REC."Date fin contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Observation Contrat"; REC."Observation Contrat")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Fournisseur"; REC."Nom Fournisseur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Hist; Hist)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mouvement';

//                     trigger OnAssistEdit()
//                     begin
//                         HistoriquePuce.SetRange("Entry No.", REC.Type);
//                         PAGE.RunModal(Page::"Ligne Avances Caisse", HistoriquePuce);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         Hist: Code[10];
//         HistoriquePuce: Record "Temp G/L Entry";
// }

