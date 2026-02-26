// Page 50124 "Ligne Suivi Mat Inf"
// {
//     DelayedInsert = true;
//     PageType = ListPart;
//     SourceTable = "Ligne Suivi Mat Inf";
//     ApplicationArea = All;
//     Caption = 'Ligne Suivi Mat Inf';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Operation"; REC."Date Operation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nature Materiel"; REC."Nature Materiel")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Marque; REC.Marque)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Serie"; REC."N° Serie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Statut; REC.Statut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transferer A"; REC."Transferer A")
//                 {
//                     ApplicationArea = all;
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

